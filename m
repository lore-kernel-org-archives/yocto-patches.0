Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38128D3CC9B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 01:10:19 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26075.1768439409031268285
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Jan 2026 17:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60F1A4H72303376;
	Wed, 14 Jan 2026 19:10:04 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 0/4] Implement openat2 wrapper
Date: Wed, 14 Jan 2026 19:09:59 -0600
Message-Id: <1768439403-23665-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 01:10:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2957

Since openat2 isn't a regular function on most systems, the implementation
is a bit strange.  We implement the openat2 function based on the existing
openat (in the future, we may be able to get rid of openat redirecting it
to this new openat2.)  Then instead of calling real_openat2, we call
real_syscall instead.

This appears to work where I've run it, but I don't have a very extensive
test case at this time.  Any review of this serious would be appreciated.

Mark Hatle (1):
  openat2: Implement openat2 wrapper

mark.hatle (3):
  test-syscall: Remove build warning
  ports/linux/pseudo_wrappers.c: Reorder the syscall operations
  ports/linux/pseudo_wrappers.c: Call the wrappers where possible

 ports/linux/openat2/guts/openat2.c | 186 +++++++++++++++++++++++++++++++++++--
 ports/linux/pseudo_wrappers.c      |  51 ++++++----
 test/test-syscall.c                |  12 ++-
 3 files changed, 215 insertions(+), 34 deletions(-)

-- 
1.8.3.1


