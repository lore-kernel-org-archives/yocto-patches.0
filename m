Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569ECFF885D
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:34 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1691.1777071751753121527
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 16:02:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63ON2Dbu287175;
	Fri, 24 Apr 2026 18:02:14 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, dburgener@linux.microsoft.com,
        peter.kjellerstedt@axis.com
Subject: [yocto-patches][pseudo][PATCH 0/3] Add pending patches to master
Date: Fri, 24 Apr 2026 18:02:10 -0500
Message-Id: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 23:02:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3816

This includes the two pending patches to pseduo and a test case for Peter's
issue so hopefully it doesn't happen again in the future.

These changes are currently applied to 'master-next'.  Assuming nobody finds
issues with these, I'll merge to master and bump the version (1.9.6) on
Monday.

(RP if you think the build needs it before Monday, go ahead!  I've tested
everything and it looks safe to me.)


Daniel Burgener (1):
  Only copy xattrs on a rename if it's cross-filesystem

Mark Hatle (1):
  test: Add test for linkat chroot path stripping

Peter Kjellerstedt (1):
  linkat: Avoid a segmentation fault

 ports/unix/guts/linkat.c   |  2 +-
 pseudo_db.c                |  4 ++-
 test/test-linkat-chroot.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 test/test-linkat-chroot.sh | 19 +++++++++++++
 test/test-xattr.sh         | 12 ++++++++
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 test/test-linkat-chroot.c
 create mode 100755 test/test-linkat-chroot.sh

-- 
1.8.3.1


