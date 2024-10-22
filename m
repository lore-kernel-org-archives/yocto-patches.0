Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D6D2CE01
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 16:47:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.23466.1729615624107677768
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Oct 2024 09:47:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57276497
	for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Oct 2024 09:47:33 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B3553F73B
	for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Oct 2024 09:47:03 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper v2] scripts/abint: generalise autobuilder URL regex
Date: Tue, 22 Oct 2024 17:46:58 +0100
Message-Id: <20241022164658.235987-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Oct 2024 16:47:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/725

The autobuilder isn't just autobuilder.yoctoproject.org, as the new
cluster is valkyrie.yoctoproject.org.  Generalise the regex to match on
any buildbot URLs with "yocto" in the hostname, as we also have machines
using *.yocto.io.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/abint/abint.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/abint/abint.py b/scripts/abint/abint.py
index 1d358836..5a4a9b81 100755
--- a/scripts/abint/abint.py
+++ b/scripts/abint/abint.py
@@ -54,7 +54,7 @@ class Bug:
=20
=20
 def get_data():
-    url_re =3D r"(?P<server>https?://autobuilder.yoctoproject.org/typhoo=
n/)#/?builders/(?P<builder>\d+)/builds/(?P<build>\d+)"
+    url_re =3D r"(?P<server>https?://.+yocto.+/)#/?builders/(?P<builder>=
\d+)/builds/(?P<build>\d+)"
=20
     logging.debug("Searching bugzilla for AB-INT bugs...")
     bz =3D bugzilla.Bugzilla("https://bugzilla.yoctoproject.org/rest")
--=20
2.34.1


