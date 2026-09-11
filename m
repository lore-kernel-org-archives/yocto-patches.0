Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA230C88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49576.1789160637095148117
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=V6wbGvlO;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDFD92E96
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:52 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A3263F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160636; bh=6fqGWoBvFXx7JMfu+y5M2rPT8JOH5vRTz5kjO5G0yTk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V6wbGvlOekQjZSykJHIbr39sjHbeXf4PLQd+h0ek3rzChjiEAtWXUOVcnYSjxF29c
	 ICeyiaizbQhcp8mkYxr4GKarv/dXdOdY4TkBR/qPJZ8JHvS9ySWsoMeLhpVOAOYJHH
	 ulr+gw1FTsJkGpmZsXYlrnOnHCHHJJApfk5Ki/M0=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 3/8] dashboard/bugtriage: match whiteboard on words not substrings
Date: Fri, 11 Sep 2026 22:03:46 +0100
Message-ID: <20260911210351.2020798-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4818

This avoids false positives with substring matches.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 7970b5dd..873a3b6f 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -607,7 +607,7 @@
       const params =3D new URLSearchParams({
         resolution: "---",
         status_whiteboard: keyword,
-        status_whiteboard_type: "substring",
+        status_whiteboard_type: "anywords",
       });
       const bugs =3D await searchBugs(table, params);
     }
--=20
2.43.0


