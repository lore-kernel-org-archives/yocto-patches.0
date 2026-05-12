Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FACD4F3E
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:53 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.614.1778624449003698467
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiEv1619785;
	Tue, 12 May 2026 17:20:44 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 0/5] Fix rename/renameat w/ hardlinks
Date: Tue, 12 May 2026 17:20:38 -0500
Message-Id: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3978

Changqing Li found the issue related to the renaming followed by a
hardlink causing failures.  Created test case(s) based on Paul
Barker's suggestion.

The test cases check both 'mv / ln', as well as specific calls to
both rename and renameat2.

Due to these tests it was observed that rename had the same bug as
renameat2, and the fix was applied there as well.

Changqing Li (1):
  renameat2/renameat: only ignore when both old and new path are not in
    PSEUDO_INCLUDE_PATHS

Mark Hatle (4):
  run_tests.sh: Allow the user to specify specific tests to run
  tests: Add mv then hardlink testing
  rename: only ignore when both old and new path are not in
    PSEUDO_INCLUDE_PATHS
  Makefile.in: Bump version to 1.9.7

 Makefile.in                    |   2 +-
 makewrappers                   |   4 +-
 ports/unix/guts/rename.c       |  26 +++++++++--
 ports/unix/guts/renameat.c     |  32 ++++++++++---
 run_tests.sh                   |  32 +++++++++++--
 test/test-mv-hardlink.sh       |  52 +++++++++++++++++++++
 test/test-rename-hardlink.c    |  87 +++++++++++++++++++++++++++++++++++
 test/test-rename-hardlink.sh   |  14 ++++++
 test/test-renameat-hardlink.c  | 101 +++++++++++++++++++++++++++++++++++++++++
 test/test-renameat-hardlink.sh |  14 ++++++
 10 files changed, 348 insertions(+), 16 deletions(-)
 create mode 100755 test/test-mv-hardlink.sh
 create mode 100644 test/test-rename-hardlink.c
 create mode 100755 test/test-rename-hardlink.sh
 create mode 100644 test/test-renameat-hardlink.c
 create mode 100755 test/test-renameat-hardlink.sh

-- 
1.8.3.1


