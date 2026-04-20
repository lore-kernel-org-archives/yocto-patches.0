Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2215CF5A8B3
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 18:30:41 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.206.1776709833031664256
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 11:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63KIUUPt3563308;
	Mon, 20 Apr 2026 13:30:30 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: [PATCH 0/5] Add openat2 support, update to version 1.9.4
Date: Mon, 20 Apr 2026 13:30:24 -0500
Message-Id: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 18:30:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3740

Thanks to Richard, it looks like we have a working openat2 implementation.

There is a know issue where it appears to be able to escape the chroot,
I don't know if this is expected behavior for the call or not.  But for
our Yocto Project workflow this should be ok.  (Since we're only
emulating chroot semantics, escaping from the chroot is not a security
issue!  There a multiple ways to escape or by-pass the emulation and
pseudo should not be used for this type of security.)

I've also attempted to add test cases for the functionality, both
the function call and syscall versions of openat2.

Finally we're bumping the release version to 1.9.4 (assuming no issues
in the review of these changes.)


Mark Hatle (4):
  openat2: Implement openat2 wrapper
  test: Add openat2 test cases
  test: Add renameat2 test cases
  Makefile.in: Bump version to 1.9.4

Richard Purdie (1):
  makewrappers/openat2: Add preserve_path option

 Makefile.in                         |   2 +-
 makewrappers                        |  18 ++-
 ports/linux/openat2/guts/openat2.c  | 198 ++++++++++++++++++++++--
 ports/linux/openat2/wrapfuncs.in    |   2 +-
 ports/linux/pseudo_wrappers.c       |   3 +
 templates/wrapfuncs.c               |   1 +
 test/test-openat2-func-chroot.sh    |  18 +++
 test/test-openat2-func.c            | 274 +++++++++++++++++++++++++++++++++
 test/test-openat2-func.sh           |  18 +++
 test/test-openat2-syscall-chroot.sh |  18 +++
 test/test-openat2-syscall.c         | 299 ++++++++++++++++++++++++++++++++++++
 test/test-openat2-syscall.sh        |  18 +++
 test/test-renameat2-chroot.sh       |  11 ++
 test/test-renameat2.c               | 263 +++++++++++++++++++++++++++++++
 test/test-renameat2.sh              |  11 ++
 test/test-syscall.c                 |   9 +-
 16 files changed, 1146 insertions(+), 17 deletions(-)
 create mode 100755 test/test-openat2-func-chroot.sh
 create mode 100644 test/test-openat2-func.c
 create mode 100755 test/test-openat2-func.sh
 create mode 100755 test/test-openat2-syscall-chroot.sh
 create mode 100644 test/test-openat2-syscall.c
 create mode 100755 test/test-openat2-syscall.sh
 create mode 100755 test/test-renameat2-chroot.sh
 create mode 100644 test/test-renameat2.c
 create mode 100755 test/test-renameat2.sh

-- 
1.8.3.1


