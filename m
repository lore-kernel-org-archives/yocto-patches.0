Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DEFCD8C81
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 14:47:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9886.1780670829257836723
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 07:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=JGyVxpVC;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C00CA244C
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:47:03 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DD7F3F7D8
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670828; bh=ht3HLL3zsuhLjsTTAt+FRCV3gzd4B8Wx8zPcNqNavPk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JGyVxpVCtfKI+LA4lmYOGRL/lNlXeAgxP9ZGSQG+b0YDznNZC2lgNJ9w7DtU9vkL8
	 Z2SSSOHEz+IYIxWlXk1aTlXABFfVjmczUmFCf0raUJlUPUPmXvVQ2RKZBE6yM47adn
	 sjrA2JI/xnLDG+rKofoWqRdI75YWVa46k3/mOpC8=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/2] bugtriage: ignore meta-security issues
Date: Fri,  5 Jun 2026 15:47:03 +0100
Message-ID: <20260605144703.3472116-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605144703.3472116-1-ross.burton@arm.com>
References: <20260605144703.3472116-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 14:47:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4150

These issues are not triaged by the Yocto triage team.

This means adding support for ignoring components. To avoid field
conflicts with the caller's arbitrary field queries, change the
numbering to 100 onwards. This means there is still a theoretical chance
of conflicts but it's unlikely, and luckily bugzilla doesn't care that
the queries are not numbered sequentially.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index f18c0b34..ee4f4019 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -470,6 +470,10 @@
       "Wic",
     ];
=20
+    const ignoreComponents =3D [
+      "meta-security",
+    ];
+
     // Fields to display (bugzilla field name -> column header)
     const fields =3D new Map([
       ["id", "ID"],
@@ -544,9 +548,16 @@
       reloadButton.classList.toggle('spin')
=20
       params.append("include_fields", Array.from(fields.keys()).join());
-      params.append("f0", "product",)
-      params.append("o0", "notregexp",)
-      params.append("v0", `^(${ignoreProducts.map((s) =3D> escapeRegExp(=
s)).join("|")})$`)
+
+      // Ignore specific products and components. The field numbers are =
high so
+      // that caller's queries can use fields without conflicts.
+      params.append("f100", "product",)
+      params.append("o100", "notregexp",)
+      params.append("v100", `^(${ignoreProducts.map((s) =3D> escapeRegEx=
p(s)).join("|")})$`)
+
+      params.append("f101", "component",)
+      params.append("o101", "notregexp",)
+      params.append("v101", `^(${ignoreComponents.map((s) =3D> escapeReg=
Exp(s)).join("|")})$`)
=20
       var bzlink =3D document.createElement("a");
       var buglistURL =3D `${serverUrl}/buglist.cgi?${params}`;
--=20
2.43.0


