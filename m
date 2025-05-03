Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB0C3ABB7
	for <webhook@archiver.kernel.org>; Sat,  3 May 2025 20:02:03 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.17577.1746302520595804407
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 May 2025 13:02:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 543JxuJu008895;
	Sat, 3 May 2025 14:59:57 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: skandigraun@gmail.com, landervanloock@gmail.com,
        richard.purdie@linuxfoundation.org, fntoth@gmail.com
Subject: [pseudo][PATCH v3 0/3] nftw, ftw: add wrappers
Date: Sat,  3 May 2025 14:59:52 -0500
Message-Id: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 03 May 2025 20:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1482

From: Mark Hatle <mark.hatle@amd.com>

Note in this set patch 3/3 does not work yet.  The test cases need more work.


v3:
Rework from Mark Hatle

Split the ftw/ftw64 -> nftw/nftw64 change from the rest
Rework the integration around the nftw* wrappers
Respond to comments from Gyorgy

v2:
Rework from Gyorgy Sarvari

Gyorgy Sarvari via lists.yoctoproject.org (2):
  nftw, nftw64: add wrapper
  ftw, nftw, ftw64 and nftw64: add tests

Mark Hatle (1):
  Move ftw and ftw64 to calling ntfw and nftw64

 Makefile.in                         |   4 +-
 guts/README                         |   8 +-
 ports/linux/guts/ftw64.c            |   9 +-
 ports/linux/guts/nftw64.c           |   2 +-
 ports/linux/pseudo_wrappers.c       |  10 ++
 ports/unix/guts/ftw.c               |  10 +-
 ports/unix/guts/nftw.c              |   2 +-
 ports/unix/guts/nftw_wrapper_base.c | 195 +++++++++++++++++++++++
 ports/unix/pseudo_wrappers.c        |  10 ++
 test/ftw-test-impl.c                | 226 ++++++++++++++++++++++++++
 test/nftw-test-impl.c               | 236 ++++++++++++++++++++++++++++
 test/test-ftw.c                     |   4 +
 test/test-ftw64.c                   |   4 +
 test/test-nftw.c                    |   4 +
 test/test-nftw.sh                   |  90 +++++++++++
 test/test-nftw64.c                  |   4 +
 16 files changed, 808 insertions(+), 10 deletions(-)
 create mode 100644 ports/unix/guts/nftw_wrapper_base.c
 create mode 100644 test/ftw-test-impl.c
 create mode 100644 test/nftw-test-impl.c
 create mode 100644 test/test-ftw.c
 create mode 100644 test/test-ftw64.c
 create mode 100644 test/test-nftw.c
 create mode 100755 test/test-nftw.sh
 create mode 100644 test/test-nftw64.c

-- 
2.34.1


