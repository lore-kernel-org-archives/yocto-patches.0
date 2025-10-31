Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00744CCF9F8
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 13:02:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.14868.1761915750507923925
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Oct 2025 06:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28DF21595
	for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Oct 2025 06:02:22 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F1F23F66E
	for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Oct 2025 06:02:29 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] dashboard/bugtriage: don't ignore bugs in "Other YP Layers"
Date: Fri, 31 Oct 2025 13:02:25 +0000
Message-ID: <20251031130225.2925947-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Oct 2025 13:02:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2406

Some autobuilder-sensitive issues are being filed in this component, as
the AB builds these layers. So whilst the triage call doesn't have
direct responsibility for these layers, it's good to know that any bugs
exist.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 54065576..45273ef8 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -176,7 +176,6 @@
=20
     const ignoreProducts =3D [
       "opkg",
-      "Other YP Layers",
       "Security Response Tool",
       "Toaster",
       "Yocto Project Compatible"
--=20
2.43.0


