Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97990CD6E57
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:20 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29657.1780519153051773403
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 13:39:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Kd9Uw2263173;
	Wed, 3 Jun 2026 15:39:09 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 0/6] Permission/setuid/setgid handling
Date: Wed,  3 Jun 2026 15:39:02 -0500
Message-Id: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 20:39:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4130

Victor Kamensky noticed and submitted a change where a file could have +s
defined and this would be set in the real filesystem.  This potentially
opens up a condition where a script or executable could be run as a specific
user's uid or gid which could lead to unintended consequences.

Victor's change filters out setuid/setgid from the on-disk permissions.

I the course of working on this issue (including writing test cases), it
was observed that there was an existing bug where if the user did a
mkdir followed by a +s on the directory the Linux kernel would prevent
the +s mode.  This had the side effect of the +s not being present
when the directory was later scanned.  (+s is only allowed on root owned
directories.)  This bug has never been reported but is now fixed as well.

This lead to the case where we also updated the documentation in the code
to make it more clear what PSEUDO_DB_MODE and PSEUDO_FS_MODE do and how
they need to be kept in sync.

These changes have been pushed to pseudo master branch.


Mark Hatle (5):
  Makefile.in: Add pseudo_client.h as a dependency
  pseudo_client.h: Make it clear both macros must be updated together
  tests: Add test that returned stat is correct
  pseudo_client.h: Add +s to PSEUDO_DB_MODE for mkdir
  tests: Add setuid permission check

Victor Kamensky (1):
  client: permissions drop setuid and setgid

 Makefile.in                     |   2 +-
 pseudo_client.h                 |  13 ++++-
 test/test-db-mode.c             | 117 ++++++++++++++++++++++++++++++++++++++++
 test/test-db-mode.sh            |  10 ++++
 test/test-setuid-permissions.sh |  58 ++++++++++++++++++++
 5 files changed, 197 insertions(+), 3 deletions(-)
 create mode 100644 test/test-db-mode.c
 create mode 100755 test/test-db-mode.sh
 create mode 100755 test/test-setuid-permissions.sh

-- 
1.8.3.1


