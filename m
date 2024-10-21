Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75088D15DBC
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 16:40:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.51376.1729528839714678628
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Oct 2024 09:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4D8DA7
	for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Oct 2024 09:41:08 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B30DA3F528
	for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Oct 2024 09:40:38 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] scripts/abint: generalise autobuilder URL regex
Date: Mon, 21 Oct 2024 17:40:33 +0100
Message-Id: <20241021164033.4076535-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Oct 2024 16:40:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/724

The autobuilder isn't just autobuilder.yoctoproject.org, as the new
cluster is valkyrie.yoctoproject.org.  Generalise the regex to match on
any buildbot URLs and hope that people don't link to buildbot logs on
other servers that often.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/abint/abint.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/abint/abint.py b/scripts/abint/abint.py
index 1d358836..18c2ce53 100755
--- a/scripts/abint/abint.py
+++ b/scripts/abint/abint.py
@@ -54,7 +54,7 @@ class Bug:
=20
=20
 def get_data():
-    url_re =3D r"(?P<server>https?://autobuilder.yoctoproject.org/typhoo=
n/)#/?builders/(?P<builder>\d+)/builds/(?P<build>\d+)"
+    url_re =3D r"(?P<server>https?://.+/)#/?builders/(?P<builder>\d+)/bu=
ilds/(?P<build>\d+)"
=20
     logging.debug("Searching bugzilla for AB-INT bugs...")
     bz =3D bugzilla.Bugzilla("https://bugzilla.yoctoproject.org/rest")
--=20
2.34.1


