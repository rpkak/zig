pub fn addCases(cases: *tests.LibcContext) void {
    cases.addSimpleCase("api/main.c", true, true);

    cases.addSimpleCase("functional/wcstol.c", false, true);
    cases.addSimpleCase("functional/wcsstr.c", false, true);
    cases.addSimpleCase("functional/vfork.c", false, false);
    cases.addSimpleCase("functional/utime.c", false, false);
    cases.addSimpleCase("functional/ungetc.c", false, false);
    cases.addSimpleCase("functional/udiv.c", false, true);
    cases.addSimpleCase("functional/tls_local_exec.c", false, false);
    cases.addSimpleCase("functional/tls_init.c", false, false);
    cases.addCase("functional/tls_align.c", "functional/tls_align_dso.c", false, false);
    cases.addSimpleCase("functional/time.c", false, false);
    cases.addSimpleCase("functional/tgmath.c", false, true);
    cases.addSimpleCase("functional/swprintf.c", false, true);
    cases.addSimpleCase("functional/strtold.c", false, true);
    cases.addSimpleCase("functional/strtol.c", false, true);
    cases.addSimpleCase("functional/strtof.c", false, true);
    cases.addSimpleCase("functional/strtod_simple.c", false, true);
    cases.addSimpleCase("functional/strtod_long.c", false, true);
    cases.addSimpleCase("functional/strtod.c", false, true);
    cases.addSimpleCase("functional/string_strstr.c", false, true);
    cases.addSimpleCase("functional/string_strcspn.c", false, true);
    cases.addSimpleCase("functional/string_strchr.c", false, true);
    cases.addSimpleCase("functional/string_memset.c", false, true);
    cases.addSimpleCase("functional/string_memmem.c", false, true);
    cases.addSimpleCase("functional/string_memcpy.c", false, true);
    cases.addSimpleCase("functional/string.c", false, true);
    cases.addSimpleCase("functional/strftime.c", false, true);
    cases.addSimpleCase("functional/stat.c", false, false);
    cases.addSimpleCase("functional/sscanf_long.c", false, false);
    cases.addSimpleCase("functional/sscanf.c", false, true);
    cases.addSimpleCase("functional/spawn.c", false, false);
    cases.addSimpleCase("functional/socket.c", false, false);
    cases.addSimpleCase("functional/snprintf.c", false, true);
    cases.addSimpleCase("functional/setjmp.c", false, false);
    cases.addSimpleCase("functional/sem_open.c", false, false);
    cases.addSimpleCase("functional/sem_init.c", false, false);
    cases.addSimpleCase("functional/search_tsearch.c", false, true);
    cases.addSimpleCase("functional/search_lsearch.c", false, true);
    cases.addSimpleCase("functional/search_insque.c", false, true);
    cases.addSimpleCase("functional/search_hsearch.c", false, false); // TODO: wasi-libc
    cases.addSimpleCase("functional/random.c", false, true);
    cases.addSimpleCase("functional/qsort.c", false, true);
    cases.addSimpleCase("functional/pthread_tsd.c", false, false);
    // "functional/pthread_robust.c": https://gitlab.com/qemu-project/qemu/-/issues/2424
    // "functional/pthread_mutex_pi.c": Probably a bug in qemu (big/little endian FUTEX_LOCK_PI)
    cases.addSimpleCase("functional/pthread_mutex.c", false, false);
    cases.addSimpleCase("functional/pthread_cond.c", false, false);
    cases.addSimpleCase("functional/pthread_cancel.c", false, false);
    cases.addSimpleCase("functional/pthread_cancel-points.c", false, false);
    cases.addSimpleCase("functional/popen.c", false, false);
    // "functional/mntent.c": https://www.openwall.com/lists/musl/2024/10/22/1
    cases.addSimpleCase("functional/memstream.c", false, true);
    cases.addSimpleCase("functional/mbc.c", false, true);
    // "functional/ipc_shm.c": Probably a bug in qemu
    // "functional/ipc_sem.c": Probably a bug in qemu
    // "functional/ipc_msg.c": Probably a bug in qemu
    cases.addSimpleCase("functional/inet_pton.c", false, false);
    cases.addSimpleCase("functional/iconv_open.c", false, true);
    cases.addSimpleCase("functional/fwscanf.c", false, false);
    cases.addSimpleCase("functional/fscanf.c", false, false);
    cases.addSimpleCase("functional/fnmatch.c", false, true);
    cases.addSimpleCase("functional/fdopen.c", false, false);
    cases.addSimpleCase("functional/fcntl.c", false, false);
    cases.addSimpleCase("functional/env.c", false, true);
    cases.addSimpleCase("functional/dirname.c", false, true);
    cases.addSimpleCase("functional/crypt.c", false, true);
    cases.addSimpleCase("functional/clock_gettime.c", false, true);
    cases.addSimpleCase("functional/clocale_mbfuncs.c", false, true);
    cases.addSimpleCase("functional/basename.c", false, true);
    cases.addSimpleCase("functional/argv.c", false, true);

    cases.addSimpleCase("regression/wcsstr-false-negative.c", false, true);
    cases.addSimpleCase("regression/wcsncpy-read-overflow.c", false, true);
    cases.addSimpleCase("regression/uselocale-0.c", false, true);
    cases.addSimpleCase("regression/syscall-sign-extend.c", false, false);
    cases.addSimpleCase("regression/strverscmp.c", false, true);
    cases.addSimpleCase("regression/sscanf-eof.c", false, true);
    cases.addSimpleCase("regression/sigreturn.c", false, true);
    cases.addSimpleCase("regression/sigprocmask-internal.c", false, false);
    cases.addSimpleCase("regression/sigaltstack.c", false, false);
    cases.addSimpleCase("regression/setvbuf-unget.c", false, true);
    // "regression/setenv-oom.c": QEMU OOM
    cases.addSimpleCase("regression/sem_close-unmap.c", false, false);
    cases.addSimpleCase("regression/scanf-nullbyte-char.c", false, true);
    cases.addSimpleCase("regression/scanf-match-literal-eof.c", false, true);
    cases.addSimpleCase("regression/scanf-bytes-consumed.c", false, true);
    cases.addSimpleCase("regression/rlimit-open-files.c", false, false);
    cases.addSimpleCase("regression/rewind-clear-error.c", false, false);
    cases.addSimpleCase("regression/regexec-nosub.c", false, true);
    cases.addSimpleCase("regression/regex-negated-range.c", false, true);
    cases.addSimpleCase("regression/regex-escaped-high-byte.c", false, true);
    cases.addSimpleCase("regression/regex-ere-backref.c", false, true);
    cases.addSimpleCase("regression/regex-bracket-icase.c", false, true);
    cases.addSimpleCase("regression/regex-backref-0.c", false, true);
    cases.addSimpleCase("regression/raise-race.c", false, false);
    cases.addSimpleCase("regression/putenv-doublefree.c", false, true);
    cases.addSimpleCase("regression/pthread_rwlock-ebusy.c", false, false);
    cases.addSimpleCase("regression/pthread_once-deadlock.c", false, false);
    cases.addSimpleCase("regression/pthread_exit-dtor.c", false, false);
    cases.addSimpleCase("regression/pthread_exit-cancel.c", false, false);
    // "regression/pthread_create-oom.c": QEMU OOM
    cases.addSimpleCase("regression/pthread_condattr_setclock.c", false, false);
    cases.addSimpleCase("regression/pthread_cond_wait-cancel_ignored.c", false, false);
    cases.addSimpleCase("regression/pthread_cond-smasher.c", false, false);
    cases.addSimpleCase("regression/pthread_cancel-sem_wait.c", false, false);
    cases.addSimpleCase("regression/pthread_atfork-errno-clobber.c", false, false);
    // "regression/pthread-robust-detach.c": https://gitlab.com/qemu-project/qemu/-/issues/2424
    cases.addSimpleCase("regression/printf-fmt-n.c", false, true);
    cases.addSimpleCase("regression/printf-fmt-g-zeros.c", false, true);
    cases.addSimpleCase("regression/printf-fmt-g-round.c", false, true);
    cases.addSimpleCase("regression/printf-1e9-oob.c", false, true);
    cases.addSimpleCase("regression/mkstemp-failure.c", false, false);
    cases.addSimpleCase("regression/mkdtemp-failure.c", false, false);
    cases.addSimpleCase("regression/memmem-oob.c", false, true);
    cases.addSimpleCase("regression/memmem-oob-read.c", false, true);
    cases.addSimpleCase("regression/mbsrtowcs-overflow.c", false, true);
    cases.addSimpleCase("regression/malloc-oom.c", false, false); // wasi-libc: requires t_memfill
    // "regression/malloc-brk-fail.c": QEMU OOM
    cases.addSimpleCase("regression/malloc-0.c", false, true);
    cases.addSimpleCase("regression/lseek-large.c", false, false);
    cases.addSimpleCase("regression/lrand48-signextend.c", false, true);
    cases.addSimpleCase("regression/iswspace-null.c", false, true);
    cases.addSimpleCase("regression/inet_pton-empty-last-field.c", false, true);
    cases.addSimpleCase("regression/inet_ntop-v4mapped.c", false, true);
    cases.addSimpleCase("regression/iconv-roundtrips.c", false, true);
    cases.addSimpleCase("regression/getpwnam_r-errno.c", false, false);
    cases.addSimpleCase("regression/getpwnam_r-crash.c", false, false);
    cases.addSimpleCase("regression/ftello-unflushed-append.c", false, false);
    cases.addSimpleCase("regression/fpclassify-invalid-ld80.c", false, true);
    cases.addSimpleCase("regression/flockfile-list.c", false, false);
    cases.addSimpleCase("regression/fgetwc-buffering.c", false, false);
    cases.addSimpleCase("regression/fgets-eof.c", false, true);
    cases.addSimpleCase("regression/fflush-exit.c", false, false);
    cases.addSimpleCase("regression/execle-env.c", false, false);
    cases.addSimpleCase("regression/dn_expand-ptr-0.c", false, false);
    cases.addSimpleCase("regression/dn_expand-empty.c", false, false);
    cases.addSimpleCase("regression/daemon-failure.c", false, false);
}

const std = @import("std");
const tests = @import("tests.zig");
