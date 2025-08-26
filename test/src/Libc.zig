b: *std.Build,
options: Options,
root_step: *std.Build.Step,

libc_test_src_path: std.Build.LazyPath,

test_cases: std.ArrayList(TestCase) = .empty,

pub const Options = struct {
    optimize_modes: []const std.builtin.OptimizeMode,
    test_filters: []const []const u8,
    test_target_filters: []const []const u8,
};

const TestCase = struct {
    name: []const u8,
    src_file: std.Build.LazyPath,
    secondary_src_file: ?std.Build.LazyPath,
    supports_mingw: bool,
    supports_wasi_libc: bool,
};

pub fn addSimpleCase(
    libc: *Libc,
    path: []const u8,
    supports_mingw: bool,
    supports_wasi_libc: bool,
) void {
    libc.addCase(
        path,
        null,
        supports_mingw,
        supports_wasi_libc,
    );
}

pub fn addCase(
    libc: *Libc,
    path: []const u8,
    secondary_path: ?[]const u8,
    supports_mingw: bool,
    supports_wasi_libc: bool,
) void {
    const name = libc.b.dupe(path[0 .. path.len - std.fs.path.extension(path).len]);
    std.mem.replaceScalar(u8, name, '/', '.');
    libc.test_cases.append(libc.b.allocator, .{
        .name = name,
        .src_file = libc.libc_test_src_path.path(libc.b, path),
        .secondary_src_file = if (secondary_path) |snd_path| libc.libc_test_src_path.path(libc.b, snd_path) else null,
        .supports_mingw = supports_mingw,
        .supports_wasi_libc = supports_wasi_libc,
    }) catch @panic("OOM");
}

pub fn addTarget(libc: *const Libc, target: std.Build.ResolvedTarget) void {
    if (libc.options.test_target_filters.len > 0) {
        const triple_txt = target.query.zigTriple(libc.b.allocator) catch @panic("OOM");
        for (libc.options.test_target_filters) |filter| {
            if (std.mem.indexOf(u8, triple_txt, filter)) |_| break;
        } else return;
    }

    const common = libc.libc_test_src_path.path(libc.b, "common");

    for (libc.options.optimize_modes) |optimize| {
        const libtest_mod = libc.b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        });

        var libtest_c_source_files: []const []const u8 = &.{ "print.c", "rand.c", "setrlim.c", "memfill.c", "vmfill.c", "fdfill.c", "utf8.c" };
        libtest_mod.addCSourceFiles(.{
            .root = common,
            .files = libtest_c_source_files[0..if (target.result.isMuslLibC()) 7 else 2],
            .flags = &.{"-fno-builtin"},
        });

        const libtest = libc.b.addLibrary(.{
            .name = "test",
            .root_module = libtest_mod,
        });

        for (libc.test_cases.items) |*test_case| {
            if (target.result.isMinGW() and !test_case.supports_mingw)
                continue;
            if (target.result.isWasiLibC() and !test_case.supports_wasi_libc)
                continue;

            const annotated_case_name = libc.b.fmt("run libc-test {s} ({t})", .{ test_case.name, optimize });
            for (libc.options.test_filters) |test_filter| {
                if (std.mem.indexOf(u8, annotated_case_name, test_filter)) |_| break;
            } else if (libc.options.test_filters.len > 0) continue;

            const mod = libc.b.createModule(.{
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            });
            mod.addIncludePath(common);
            mod.addCMacro("_WASI_EMULATED_SIGNAL", "");
            mod.addCSourceFile(.{
                .file = test_case.src_file,
                .flags = &.{"-fno-builtin"},
            });
            if (test_case.secondary_src_file) |second_file| {
                mod.addCSourceFile(.{
                    .file = second_file,
                    .flags = &.{"-fno-builtin"},
                });
            }
            mod.linkLibrary(libtest);

            const exe = libc.b.addExecutable(.{
                .name = test_case.name,
                .root_module = mod,
            });

            const run = libc.b.addRunArtifact(exe);
            run.setName(annotated_case_name);
            run.skip_foreign_checks = true;
            run.expectStdErrEqual("");
            run.expectStdOutEqual("");
            run.expectExitCode(0);

            libc.root_step.dependOn(&run.step);
        }
    }
}

const Libc = @This();
const std = @import("std");
