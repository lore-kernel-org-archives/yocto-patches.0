Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E905C44507
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83542.1783039584957237845
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ0x069650;
	Thu, 2 Jul 2026 19:46:19 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 00/23] Create new pseudo 1.99.0 version
Date: Thu,  2 Jul 2026 19:45:55 -0500
Message-Id: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4371

The changes from Dmitry and some others that are planned are enough
I want to start planning for a 2.0 version of pseudo.

(I have already created a pseudo-1.9 branch so we can backport stable
changes as needed.)

I have pushed the following changes to 'master-next'.  I'd like feedback
before I push them to master.  (Including if the environment changes
specifically should go back to the stable branch.  At this point I
think they should based on the symptoms.)

Dmitry Sakhonchik (11):
  pseudo_util: Add log severity flags
  pseudo: Add new logging macros
  pseudo_util: Change pseudo_diag() calls to appropriate logging macros
  pseudo_db: Change pseudo_diag() calls to appropriate macros
  pseudo_client: Change pseudo_diag() calls to appropriate macros
  pseudo_server: Change pseudo_diag() calls to appropriate macros
  pseudo.c: Change pseudo_diag() calls to appropriate macros
  pseudolog.c: Change pseudo_diag() calls to appropriate macros
  wrappers: Change pseudo_diag() calls to appropriate macros
  pseudo: Change pseudo_diag() name to pseudo_log()
  pseudo_util: Add default log severity values

Mark Hatle (5):
  Makefile.in: Move version to 1.99.0 to prep for 2.0 development
  pseudo_util.c: strchr now returns const char
  test/test-openat2-func.c: Remove unusuaed saved_errno
  test-bash-exec-env: Add bash env test case
  test: various: Move to makefile compilation

Richard Purdie (7):
  pseudo.h: Avoid accessing unallocated memory
  pseudo_util: Avoid accidental free calls for without_libpseudo()
  pseudo_util: Ensure pseudo_setupenvp handles memory consistently
  pseudo_util: Avoid a memory leak in pseudo_dropenv()
  pseudo_util: Clean up memory handling for setupenvp results
  exec*: Replace bash workaround to avoid memory corruption
  pseudo_util: Correctly free memory allocated by pseudo_setupenvp

 Makefile.in                         |   2 +-
 enums/sev.in                        |   2 +-
 ports/common/guts/execv.c           |  19 +-
 ports/common/guts/execve.c          |   4 +-
 ports/common/guts/execvp.c          |  15 +-
 ports/common/guts/posix_spawn.c     |   4 +-
 ports/common/guts/posix_spawnp.c    |   4 +-
 ports/darwin/pseudo_wrappers.c      |   3 +-
 ports/linux/guts/fcntl.c            |   2 +-
 ports/linux/guts/fcntl64.c          |   2 +-
 ports/linux/guts/getpw.c            |   2 +-
 ports/linux/guts/openat.c           |   3 +-
 ports/linux/openat2/guts/openat2.c  |   3 +-
 ports/linux/xattr/pseudo_wrappers.c |   3 +-
 ports/unix/guts/getcwd.c            |   6 +-
 ports/unix/guts/linkat.c            |   2 +-
 ports/unix/guts/nftw_wrapper_base.c |   6 +-
 ports/unix/guts/popen.c             |  16 +-
 ports/unix/guts/symlinkat.c         |   2 +-
 ports/unix/guts/system.c            |  16 +-
 ports/unix/guts/tempnam.c           |   2 +-
 ports/unix/guts/tmpnam.c            |   2 +-
 ports/unix/guts/unlinkat.c          |   2 +-
 pseudo.c                            | 105 ++---
 pseudo.h                            |  33 +-
 pseudo_client.c                     |  96 ++--
 pseudo_client.h                     |   3 -
 pseudo_db.c                         | 122 ++---
 pseudo_ipc.c                        |   2 +-
 pseudo_server.c                     |  92 ++--
 pseudo_util.c                       | 174 +++++---
 pseudo_wrappers.c                   |   8 +-
 pseudolog.c                         |  76 ++--
 test/test-bash-exec-env.c           | 667 ++++++++++++++++++++++++++++
 test/test-bash-exec-env.sh          |  34 ++
 test/test-chroot.c                  |  10 +
 test/test-chroot.sh                 |  14 +-
 test/test-execl.c                   |   4 +
 test/test-execl.sh                  |  13 +-
 test/test-linkat-chroot.sh          |   4 +-
 test/test-openat2-func.c            |   1 -
 test/test-reexec-chroot.c           |  10 +
 test/test-reexec-chroot.sh          |  14 +-
 43 files changed, 1199 insertions(+), 405 deletions(-)
 create mode 100644 test/test-bash-exec-env.c
 create mode 100755 test/test-bash-exec-env.sh
 create mode 100644 test/test-chroot.c
 create mode 100644 test/test-execl.c
 create mode 100644 test/test-reexec-chroot.c

-- 
2.53.0


