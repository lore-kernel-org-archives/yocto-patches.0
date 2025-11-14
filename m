Return-Path: <louis.rannou@semalibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263FDCE7A89
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13404.1763109007343208300
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 00:30:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.semalibre.com on 100.100.100.100:53: no such host" header.i=@semalibre.com header.s=dkim header.b=EqWQK1Wz;
 spf=pass (domain: semalibre.com, ip: 185.246.84.56, mailfrom: louis.rannou@semalibre.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1163A1A1A9E;
	Fri, 14 Nov 2025 08:30:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D26436060E;
	Fri, 14 Nov 2025 08:30:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8978B102F29CE;
	Fri, 14 Nov 2025 09:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semalibre.com;
	s=dkim; t=1763109005;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2DKuLNFd8014DP39UlX8Lh7sgSg6Sc9OgEVRiOu3cv8=;
	b=EqWQK1WzTYodisz7pE5gZWM/rsgnHkbAsE0BqTpQcsT2b+4du0IVnn084r8FSbv33DIF+H
	Alb8aQR7O2Ux9/V+AAaW/Z65ss6/faaw1V5mosKNNtfxjyvdhkflh7RdIpPXUTo+msh7KW
	hauP6M7khVwRs0Nv5cb4xRTQPpbjHRTZaGY0FDG3YSUXoYpn6vChBXSaoe0mUmNjtyHLMY
	zxJsVB3uzadlHiRY1S7uKRblZO0lQJgzKpwOup6iofUaMcGP+4H7r/5XA/8c0dX7X4tT/u
	f2MVUqS+ppVunQrkGRHM7QfoZux4qKRSIERTBMD458IqncXMj978cbOvdC6LwA==
From: Louis Rannou <louis.rannou@semalibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	pascal.eberhard@non.se.com,
	yi.zhao@windriver.com,
	Louis Rannou <louis.rannou@non.se.com>
Subject: [meta-security][PATCH 3/4] oeqa: openscap test
Date: Fri, 14 Nov 2025 09:29:49 +0100
Message-ID: <20251114-openscap_bump-v1-3-1c8169b8e332@non.se.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2556

From: Louis Rannou <louis.rannou@non.se.com>

Add basic openscap test. This looks for an existing profile and run a bas=
ic scan.

Openscap scans return 1 in case of failure, 0 in case of success and 2 wh=
en a
vulnerability has been found. As this does not aim to check openscap repo=
rts, 2 is
considered as a successful test.

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 lib/oeqa/runtime/cases/openscap.py | 48 ++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/oeqa/runtime/cases/openscap.py b/lib/oeqa/runtime/cases/=
openscap.py
new file mode 100644
index 0000000..7012b6b
--- /dev/null
+++ b/lib/oeqa/runtime/cases/openscap.py
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: MIT
+#
+
+from oeqa.runtime.case import OERuntimeTestCase
+from oeqa.core.decorator.depends import OETestDepends
+from oeqa.runtime.decorator.package import OEHasPackage
+
+
+class OpenscapTest(OERuntimeTestCase):
+
+    @OEHasPackage(["openscap"])
+    @OETestDepends(["ssh.SSHTest.test_ssh"])
+    def test_openscap_basic(self):
+        status, output =3D self.target.run("oscap -V")
+        msg =3D (
+            "`oscap -V` command does not work as expected. "
+            "Status and output:%s and %s" % (status, output)
+        )
+        self.assertEqual(status, 0, msg=3Dmsg)
+
+    @OEHasPackage(["openscap"])
+    @OEHasPackage(["scap-security-guide"])
+    @OETestDepends(["ssh.SSHTest.test_ssh"])
+    def test_openscap_scan(self):
+        SCAP_SOURCE =3D "/usr/share/xml/scap/ssg/content/ssg-openembedde=
d-xccdf.xml"
+        CPE_DICT =3D "/usr/share/xml/scap/ssg/content/ssg-openembedded-c=
pe-dictionary.xml"
+
+        cmd =3D "oscap info --profiles %s" % SCAP_SOURCE
+        status, output =3D self.target.run(cmd)
+        msg =3D (
+            "oscap info` command does not work as expected.\n"
+            "Command: %s\n" % cmd + "Status and output:%s and %s" % (sta=
tus, output)
+        )
+        self.assertEqual(status, 0, msg=3Dmsg)
+
+        for p in output.split("\n"):
+            profile =3D p.split(":")[0]
+            cmd =3D "oscap xccdf eval --cpe %s --profile %s %s" % (
+                CPE_DICT,
+                profile,
+                SCAP_SOURCE,
+            )
+            status, output =3D self.target.run(cmd)
+            msg =3D (
+                "`oscap xccdf eval` does not work as expected.\n"
+                "Command: %s\n" % cmd + "Status and output:%s and %s" % =
(status, output)
+            )
+            self.assertNotEqual(status, 1, msg=3Dmsg)

--=20
2.43.0

