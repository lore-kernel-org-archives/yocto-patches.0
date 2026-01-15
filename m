Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1597FD4663D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.752.1768520620773868848
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjV2408772;
	Thu, 15 Jan 2026 17:43:38 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 00/20] Consolidated pseudo patches
Date: Thu, 15 Jan 2026 17:43:16 -0600
Message-Id: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2975

This is the full set of pending changes.  Many of which have already
been sent to the mailing list.  This set matches 'fray/master' branch
in the repository.

The new features in this set include:

* Test harness improvements (better display, more robust)
* Realpath POSIX fix from Gauthier HADERER
* Linux path traversal into /proc fixes
* General cleanup

This along with the other changes that have recently gone in should
get us to 1.9.3 or even 2.0.0.


Note: the test suite still shows there are problems with parallel
rename and symlink operations.  These are reported but we don't
have any sort of a fix in mind yet.

renameat2 is not implemented, this will require potentially extensive
changes to pseudo to allow for atomic exchange (rename).  It will
return ENOSYS until then.

openat2 is not implemented, a prototype version of this code was
created, but does not yet pass testing.  This also returns ENOSYS.

Gauthier HADERER (1):
  ports/unix/guts/realpath.c: realpath fails if the resolved path
    doesn't exist

Mark Hatle (19):
  test-syscall: Remove build warning
  test: Cleanup test output
  test/test-statx.sh: It should be a failure if pseudo prints an error
  test-realpath: Verify the realpath behavior matches glibc
  run_tests.sh: In verbose mode, include pseudo.log in output
  test/test-statx: Add uutils test case
  test/test-nftw: Avoid compile warnings
  test-tclsh-fork: Skip test if tclsh is not available
  test/test-proc-pipe.sh: Add test case for proc pipes
  pseudo_util.c: Skip realpath like expansion for /proc on Linux
  ports/unix/guts/realpath.c: Fix indents
  ports/linux/pseudo_wrappers.c: Reorder the syscall operations
  ports/linux/pseudo_wrappers.c: Call the wrappers where possible
  ports/linux: Add additional EFAULTS for Linux functions
  Update COPYRIGHT files
  makewrappers: improve error handling and robustness
  pseudo: code quality scan - resolved various potential issues
  configure: Minor code quality changes
  Makefile.in: Bump version to 1.9.3

 ChangeLog.txt                       |   4 +
 Makefile.in                         |   5 +-
 configure                           |  19 ++--
 guts/COPYRIGHT                      |   2 +
 makewrappers                        |  73 ++++++++-------
 ports/darwin/guts/COPYRIGHT         |   1 +
 ports/linux/guts/COPYRIGHT          |   2 +
 ports/linux/openat2/wrapfuncs.in    |   2 +-
 ports/linux/pseudo_wrappers.c       |  46 ++++++----
 ports/linux/wrapfuncs.in            |  22 ++---
 ports/linux/xattr/wrapfuncs.in      |  16 ++--
 ports/uids_generic/guts/COPYRIGHT   |   1 +
 ports/unix/guts/COPYRIGHT           |   2 +
 ports/unix/guts/fts_open.c          |   5 +-
 ports/unix/guts/nftw_wrapper_base.c |  11 +--
 ports/unix/guts/realpath.c          |  23 +++--
 pseudo.c                            |  61 ++++++++-----
 pseudo_client.c                     |   4 +
 pseudo_db.c                         |  10 +++
 pseudo_server.c                     |  14 +++
 pseudo_util.c                       | 132 +++++++++++++++++++++++-----
 run_tests.sh                        |  28 ++++--
 test/nftw-test-impl.c               |   2 +
 test/test-acl.sh                    |  16 ++++
 test/test-proc-pipe.sh              |  27 ++++++
 test/test-realpath.c                |  17 ++++
 test/test-realpath.sh               |  63 +++++++++++++
 test/test-statx.sh                  |  39 +++++++-
 test/test-syscall.c                 |   2 +-
 test/test-tclsh-fork.sh             |   5 ++
 test/test-xattr.sh                  |  17 ++++
 31 files changed, 525 insertions(+), 146 deletions(-)
 create mode 100755 test/test-proc-pipe.sh
 create mode 100644 test/test-realpath.c
 create mode 100755 test/test-realpath.sh

-- 
2.43.0


