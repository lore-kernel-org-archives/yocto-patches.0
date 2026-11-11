Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2480.1794370864791628574
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lk2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:03 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 00/34] Various fixes
Date: Tue, 10 Nov 2026 22:20:28 -0600
Message-Id: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5262
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This is a large set.  It fixes pretty much all of the issues
I'm aware of, including many found during recent development.

The first 4 changes are related to the long standing issue of parallel
symlink/renames.  This is effectively fixed by putting in a shared
lock that serializes disk operations across processes.

Much of the additional work was syncronization for newer Linux systems,
removal of non Linux ports, removal of obsolete code, etc.

Update the pseudo.1 man page and other documentation to match the
current state of the implementation.  These files had slowly gone out
of sync over the past about 10 years.

Some simple performance optimizations were also included in this set.
The goal is to eliminate various calls in an attempt to offset the
serialized path lock usage.  The items look like they do improve
performance over large numbers of files, but without a significantly
large build, it's unclear if they will make a measurable difference.

Mark Hatle (34):
  pseudo_client: serialize path changes across clients
  ports: hold the path lock in create and metadata wrappers
  ports: check created files under the path lock before recording them
  test-parallel-ops: Add a parallel create/rename/link/chmod test
  ports: Remove PSEUDO_NO_REAL_AT_FUNCTIONS
  ports/unix: Remove guts overridden by the Linux port
  ports: Let the port define how pseudo stats files
  patches/yocto-older-glibc-symbols.patch: Update to latest YP version
  Remove unused #if 0 debug code
  Replace #if 0 strerror() debug messages with a comment
  pseudo_util: Remove stale with_libpseudo() comment
  ports/common/subports: Show the unknown OS name in the error
  ports/linux: Drop redundant PSEUDO_LINK_SYMLINK_BEHAVIOR override
  pseudo_server: Skip events for clients closed earlier in the batch
  pseudo_server: Drop an idle client when out of file descriptors
  pseudo_server: Always use epoll
  configure: Fix --disable-* options
  pseudo_server: Lower highest_client when the highest client closes
  pseudo_server: Set highest_client to the new client when growing
  pseudo_util: Store PSEUDO_SEVERITY as severity names
  pseudo: Fix the -k severity option
  pseudo_util: Make -v and numeric PSEUDO_DEBUG add debug flags
  AGENTS.md: Add to assist future developers
  pseudo_util: Fix the date format in the event log dump
  pseudo: List -p in the usage message
  pseudo_util: Write the event log to PSEUDO_EVLOG_FILE
  pseudo.1: Update to match the current code
  ports/linux: Don't require <linux/mount.h>
  configure: Require GCC 5 or later
  doc: Update README and doc/ to match the code
  configure: Fix the --enable-profiling default
  pseudo_util: Skip unneeded lstat calls when canonicalizing paths
  wrappers: Don't re-block signals in nested wrapper calls
  Wrap execvpe(), fexecve() and execveat()

 AGENTS.md                               |  85 +++++++++
 Makefile.in                             |   3 +-
 README                                  |  41 +++-
 README.security                         |   4 +-
 configure                               |  47 +++--
 doc/chroot                              |  10 +-
 doc/database                            |  75 +++++---
 doc/overview                            |  21 +--
 doc/passwd                              |   7 +-
 doc/program_flow                        |  16 +-
 doc/pseudo_ipc                          |  37 ++--
 doc/utils                               |   6 +-
 makewrappers                            |  17 ++
 patches/yocto-older-glibc-symbols.patch |   4 +-
 ports/common/guts/execveat.c            |  29 +++
 ports/common/guts/execvpe.c             |  29 +++
 ports/common/guts/fexecve.c             |  21 +++
 ports/common/pseudo_wrappers.c          | 141 ++++++++++++++
 ports/common/subports                   |   2 +-
 ports/common/wrapfuncs.in               |   3 +
 ports/linux/guts/__fxstatat.c           |  12 --
 ports/linux/guts/__fxstatat64.c         |  14 --
 ports/linux/guts/__xmknodat.c           |  23 +--
 ports/linux/guts/fopen64.c              |  11 +-
 ports/linux/guts/freopen64.c            |  11 +-
 ports/linux/guts/mkostemp64.c           |   4 +-
 ports/linux/guts/open_tree.c            |   4 +-
 ports/linux/guts/open_tree_attr.c       |   4 +-
 ports/linux/guts/openat.c               |  51 ++---
 ports/linux/openat2/guts/openat2.c      |  44 ++---
 ports/linux/portdefs.h                  |  26 +--
 ports/linux/statx/wrapfuncs.in          |   2 +-
 ports/linux/wrapfuncs.in                |  40 ++--
 ports/linux/xattr/wrapfuncs.in          |  16 +-
 ports/unix/guts/faccessat2.c            |  12 --
 ports/unix/guts/fchmodat.c              |  18 --
 ports/unix/guts/fchownat.c              |  12 --
 ports/unix/guts/fopen.c                 |   5 +-
 ports/unix/guts/freopen.c               |   5 +-
 ports/unix/guts/lchown.c                |  15 --
 ports/unix/guts/linkat.c                |  11 --
 ports/unix/guts/lutimes.c               |  16 --
 ports/unix/guts/mkdirat.c               |  17 --
 ports/unix/guts/mkfifoat.c              |  22 ---
 ports/unix/guts/mknod.c                 |  15 --
 ports/unix/guts/mknodat.c               |  81 --------
 ports/unix/guts/readlinkat.c            |   8 -
 ports/unix/guts/renameat.c              |  12 --
 ports/unix/guts/symlinkat.c             |  12 --
 ports/unix/guts/tmpnam.c                |  20 --
 ports/unix/guts/unlinkat.c              |  25 ---
 ports/unix/guts/utimes.c                |  15 --
 ports/unix/pseudo_wrappers.c            |   7 +-
 ports/unix/wrapfuncs.in                 |  56 +++---
 pseudo.1                                | 318 ++++++++++++++++++++++++++++----
 pseudo.c                                |   5 +-
 pseudo.h                                |  30 ++-
 pseudo_client.c                         | 128 +++++++++++--
 pseudo_client.h                         |  16 +-
 pseudo_server.c                         | 265 +++++---------------------
 pseudo_util.c                           |  93 ++++++----
 pseudo_wrappers.c                       |   9 +-
 templates/wrapfuncs.c                   |  30 +--
 test/test-debug-flags.sh                |  59 ++++++
 test/test-exec.c                        |  50 +++++
 test/test-exec.sh                       |  31 ++++
 test/test-execl.c                       |   4 -
 test/test-execl.sh                      |  13 --
 test/test-open_tree_attr-syscall.c      |   1 -
 test/test-parallel-ops.sh               |  53 ++++++
 70 files changed, 1364 insertions(+), 985 deletions(-)
 create mode 100644 AGENTS.md
 create mode 100644 ports/common/guts/execveat.c
 create mode 100644 ports/common/guts/execvpe.c
 create mode 100644 ports/common/guts/fexecve.c
 delete mode 100644 ports/unix/guts/lchown.c
 delete mode 100644 ports/unix/guts/lutimes.c
 delete mode 100644 ports/unix/guts/mknod.c
 delete mode 100644 ports/unix/guts/mknodat.c
 delete mode 100644 ports/unix/guts/tmpnam.c
 delete mode 100644 ports/unix/guts/utimes.c
 create mode 100755 test/test-debug-flags.sh
 create mode 100644 test/test-exec.c
 create mode 100755 test/test-exec.sh
 delete mode 100644 test/test-execl.c
 delete mode 100755 test/test-execl.sh
 create mode 100755 test/test-parallel-ops.sh

-- 
1.8.3.1

