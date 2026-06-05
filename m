Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE7CD6E7D
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 14:47:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9747.1780670828566712457
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 07:47:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=pPLEFnIy;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03DF7237B
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:47:03 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69DE83F7D8
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670827; bh=Xqlz+b3HLtjSSBklgIt/A1kj2YytlohPqTUJhZws0ME=;
	h=From:To:Subject:Date:From;
	b=pPLEFnIyJGY3MGz3lxEAg5aGHkawNkEaEnIaZOnddo7um1LWXj1cVbUIQJbVewbY/
	 TPZ7QxLLZv0Jzo6eOa+wzrzyEn8JYoR1NcbUP6/Hg3N6tYpecJioyVi3qPlUwFzm6X
	 /O25FqH1G1H48KoPjUj6ZC2xPlQzJVnpSzT9fM+4=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/2] bugtriage: ignore Wic issues, we don't triage those
Date: Fri,  5 Jun 2026 15:47:02 +0100
Message-ID: <20260605144703.3472116-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 14:47:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4149

The wic maintainer handles issues themselves, triage isn't involved.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index c154c9e7..f18c0b34 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -466,7 +466,8 @@
       "opkg",
       "Security Response Tool",
       "Toaster",
-      "Yocto Project Compatible"
+      "Yocto Project Compatible",
+      "Wic",
     ];
=20
     // Fields to display (bugzilla field name -> column header)
--=20
2.43.0


