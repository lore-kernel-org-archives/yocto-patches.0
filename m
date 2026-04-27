Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF75FF8870
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2117.1777312614013987872
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAd876837;
	Mon, 27 Apr 2026 12:56:43 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 00/11] Various fixes, release 1.9.6
Date: Mon, 27 Apr 2026 12:56:30 -0500
Message-Id: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3852

Richard found a few more things he thought should be in the 1.9.6 release.
Add these, and associated test cases and then bump the release.

Daniel Burgener (1):
  Only copy xattrs on a rename if it's cross-filesystem

Mark Hatle (9):
  test: Add test for linkat chroot path stripping
  test: Add fts test case
  ports/unix: fts_*: Certain functions were incorrectly returning stat
    data
  ports/unix: fts_open: Fix chroot behavior
  test: Add test cases for canonicalize functions
  ports/unix: realpath: Fix chroot processing
  test: Add test symlinkat and related
  pseudo_util.c: Fix symlink processing for symlinkat and related
  Makefile.in: Bump version to 1.9.6

Peter Kjellerstedt (1):
  linkat: Avoid a segmentation fault

 Makefile.in                    |   2 +-
 ports/unix/guts/fts_children.c |  64 +++++++++++++++
 ports/unix/guts/fts_open.c     |   3 +-
 ports/unix/guts/fts_read.c     |  68 ++++++++++++++++
 ports/unix/guts/linkat.c       |   2 +-
 ports/unix/guts/realpath.c     |  15 ++++
 ports/unix/wrapfuncs.in        |   2 +
 pseudo_db.c                    |   4 +-
 pseudo_util.c                  |  14 ++++
 test/test-canonicalize.c       | 171 ++++++++++++++++++++++++++++++++++++++++
 test/test-canonicalize.sh      |  11 +++
 test/test-fts.c                |  87 ++++++++++++++++++++
 test/test-fts.sh               |   8 ++
 test/test-link-symlink.c       | 175 +++++++++++++++++++++++++++++++++++++++++
 test/test-link-symlink.sh      |  11 +++
 test/test-linkat-chroot.c      |  69 ++++++++++++++++
 test/test-linkat-chroot.sh     |  19 +++++
 test/test-xattr.sh             |  12 +++
 18 files changed, 733 insertions(+), 4 deletions(-)
 create mode 100644 ports/unix/guts/fts_children.c
 create mode 100644 ports/unix/guts/fts_read.c
 create mode 100644 test/test-canonicalize.c
 create mode 100755 test/test-canonicalize.sh
 create mode 100644 test/test-fts.c
 create mode 100755 test/test-fts.sh
 create mode 100644 test/test-link-symlink.c
 create mode 100755 test/test-link-symlink.sh
 create mode 100644 test/test-linkat-chroot.c
 create mode 100755 test/test-linkat-chroot.sh

-- 
1.8.3.1


