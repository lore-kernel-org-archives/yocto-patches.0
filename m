Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FD9C88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49578.1789160638631498913
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=IHgJNkNN;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D752E99
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:54 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC10E3F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160638; bh=UZiwOJKX8WEo/NSiS3A3JAsaj7Dsem5V6w8WbWKvPGc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IHgJNkNNmXMn/BoHeHr3nOlG2zBV4rOJsRrRI3/uUuX3BjIogS/rHCZVikxBCzbrb
	 DPzoWo8PsT4g2mVe8/8gUWZhKXBppXR+l2MRzlXeWW9zvuU+MfzewBQbfiESEX2i0V
	 ga87ljSsuFw+2bPW2s44VSI302/FkLee9w12hv4w=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 6/8] dashboard/bugtriage: move common query setup to BZSearch's constructor
Date: Fri, 11 Sep 2026 22:03:49 +0100
Message-ID: <20260911210351.2020798-6-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4821

Use .appendQuery() for neater code.

This consolidates the query construction into a single location.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index a9ccf2e7..939dd8fb 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -486,6 +486,17 @@
   <script>
     // URLSearchParams subclass to make it easier to construct Bugzilla =
queries
     class BZSearch extends URLSearchParams {
+      constructor(...args) {
+        super(...args);
+
+        // Filter to just the fields we want
+        this.append("include_fields", Array.from(fields.keys()).join());
+
+        // Ignore specific products and components.
+        this.appendQuery("product", "notregexp", `^(${ignoreProducts.map=
((s) =3D> escapeRegExp(s)).join("|")})$`);
+        this.appendQuery("component", "notregexp", `^(${ignoreComponents=
.map((s) =3D> escapeRegExp(s)).join("|")})$`);
+      }
+
       appendNotResolved() {
         this.append("resolution", "---");
       }
@@ -604,18 +615,6 @@
       const reloadButton =3D container.querySelector('.reload-button')
       reloadButton.classList.toggle('spin')
=20
-      params.append("include_fields", Array.from(fields.keys()).join());
-
-      // Ignore specific products and components. The field numbers are =
high so
-      // that caller's queries can use fields without conflicts.
-      params.append("f100", "product",)
-      params.append("o100", "notregexp",)
-      params.append("v100", `^(${ignoreProducts.map((s) =3D> escapeRegEx=
p(s)).join("|")})$`)
-
-      params.append("f101", "component",)
-      params.append("o101", "notregexp",)
-      params.append("v101", `^(${ignoreComponents.map((s) =3D> escapeReg=
Exp(s)).join("|")})$`)
-
       var bzlink =3D document.createElement("a");
       var buglistURL =3D `${serverUrl}/buglist.cgi?${params}`;
       bzlink.setAttribute("href", buglistURL);
--=20
2.43.0


