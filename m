Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB022CFC28D
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12417.1763734901848096696
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QR5iHAqw;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b28f983333so200567885a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734900; x=1764339700; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzfI47SUGQHv3ZpELw+NUMMpo9Vc/aWTPLyEO3xbYZk=;
        b=QR5iHAqwzogholgmkXwp/v4d9Za5wexlieAaMJaqcLrmF37/lblzmmBw4oRDt22pjB
         ZG0FLw3jnKTyPMQ+80Vl2syH6lvxTU7WNU/Q5NRrTnjmCtm/Yz3mYKASIVUIfFccrCf+
         EqL3ipAhwyhCQSCJYT1VhxGeiWNEVjIO2gpoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734900; x=1764339700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DzfI47SUGQHv3ZpELw+NUMMpo9Vc/aWTPLyEO3xbYZk=;
        b=A9LDOC3l//b+p6uU0r0bTZ7bipjzX4TJidUgU59Yoxk5BUK5Utrho0tMM1lhS4TlwA
         iC7mHBoKa7xWqmEfBjAdLvRPsao4SUHwz36XXLZYhD/JO5nKbbSfOAA1J0nsGcCgJbcK
         qCW8+AuRDY8JZxbUkA27ccMlFTbNV5a+eeXu2pDku1pmeWDW+wVZa7T43u87xgyXAFCL
         NreYa5oSEWUR64c4Q3G1dAXmghzHf3WS90U9uzQs9NrlGvOKMMix8CdZx6LTfrP1Oy5f
         yAA/eimOAD3OjtzYPVPaGwJM8V9jmAY66DlIPLkc2IfBQBGIbhsoce6MKafTDIgRq0dw
         Ujyg==
X-Gm-Message-State: AOJu0Yy/+J7SiC1Sgv6BnGCmnlKGTKJmDJ63Pip6HHdfpbWAn301gPtW
	nvNjHB8CyUxmTjmWqDt8+GBx9hPFpU61CgI0arZJfgYCbcLlwXJ+tfGLimmN5906AI6WQMmybig
	2Bjjs
X-Gm-Gg: ASbGncu3TXZRIi/a1HvomtADXlgz8vBWpol1fQJd9+PavS5KTpmtGq/URWRYQudf3ff
	xBxMtabGnejrMIZvUZyln/GsjeemdriO/69jzL/FRBP6FrUHhl+f57fm4/SIir1255UcyJeaAvu
	VmVH2Z58h+obP8cxHn6M0X4Q3hRlUAQKprurDOxO9LGZDTsgK6d4Q+3Vwiy7qGqtC6nuJda4knz
	KnLxOUm6/k97+Vlh5vDhdfBpCnV8uDEbVnZHHaiVHL5LJpL4T9GeHT4cAcMV0W5EDYJebf7B1IC
	BPPisO6AXO7bPJ48EXjtzxSoHtLlmqDf2ZumHmugjpfwJuQlJ8ScsUWorDmmTU7E24FxG2dCe94
	8JVuag+FNZJ4irfrTuNxpTYc8kEC48pjnhff9L4AYdTuKkWoluWBOVOTWZxGkluPi2LA2ltB9BU
	F4L3AORnU+1S6XsvXKPLbVep/P1v/fgNQ/Sy0nblobGnHxeQ+fhDKFZSMsWhNrW/8=
X-Google-Smtp-Source: AGHT+IGdLELo45lAMw9ZlY5DLMQBSlL5jQaBbCyUKnVoWfk+KuxBZ3ECdu7+HRBKKfWqwDWc0bs5tA==
X-Received: by 2002:a05:620a:2a10:b0:80e:3af7:7a0c with SMTP id af79cd13be357-8b33d274bf9mr234685285a.43.1763734900202;
        Fri, 21 Nov 2025 06:21:40 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:39 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 5/6] oeqa: openscap test
Date: Fri, 21 Nov 2025 09:21:19 -0500
Message-ID: <a043f0b8eded3444d6ac520a5fab02b191d43cf0.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2649

From: Louis Rannou <louis.rannou@non.se.com>

Add basic openscap test. This looks for an existing profile and run a basic scan.

Openscap scans return 1 in case of failure, 0 in case of success and 2 when a
vulnerability has been found. As this does not aim to check openscap reports, 2 is
considered as a successful test.

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
(added to test image)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/runtime/cases/openscap.py         | 48 ++++++++++++++++++++++
 recipes-core/images/security-test-image.bb |  2 +-
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 lib/oeqa/runtime/cases/openscap.py

diff --git a/lib/oeqa/runtime/cases/openscap.py b/lib/oeqa/runtime/cases/openscap.py
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
+        status, output = self.target.run("oscap -V")
+        msg = (
+            "`oscap -V` command does not work as expected. "
+            "Status and output:%s and %s" % (status, output)
+        )
+        self.assertEqual(status, 0, msg=msg)
+
+    @OEHasPackage(["openscap"])
+    @OEHasPackage(["scap-security-guide"])
+    @OETestDepends(["ssh.SSHTest.test_ssh"])
+    def test_openscap_scan(self):
+        SCAP_SOURCE = "/usr/share/xml/scap/ssg/content/ssg-openembedded-xccdf.xml"
+        CPE_DICT = "/usr/share/xml/scap/ssg/content/ssg-openembedded-cpe-dictionary.xml"
+
+        cmd = "oscap info --profiles %s" % SCAP_SOURCE
+        status, output = self.target.run(cmd)
+        msg = (
+            "oscap info` command does not work as expected.\n"
+            "Command: %s\n" % cmd + "Status and output:%s and %s" % (status, output)
+        )
+        self.assertEqual(status, 0, msg=msg)
+
+        for p in output.split("\n"):
+            profile = p.split(":")[0]
+            cmd = "oscap xccdf eval --cpe %s --profile %s %s" % (
+                CPE_DICT,
+                profile,
+                SCAP_SOURCE,
+            )
+            status, output = self.target.run(cmd)
+            msg = (
+                "`oscap xccdf eval` does not work as expected.\n"
+                "Command: %s\n" % cmd + "Status and output:%s and %s" % (status, output)
+            )
+            self.assertNotEqual(status, 1, msg=msg)
diff --git a/recipes-core/images/security-test-image.bb b/recipes-core/images/security-test-image.bb
index 81f69dd..e7e354e 100644
--- a/recipes-core/images/security-test-image.bb
+++ b/recipes-core/images/security-test-image.bb
@@ -12,7 +12,7 @@ IMAGE_INSTALL:append = "\
     ${@bb.utils.contains("BBFILE_COLLECTIONS", "integrity", "packagegroup-ima-evm-utils","", d)} \
 "
 
-TEST_SUITES = "ssh ping apparmor clamav samhain sssd checksec smack suricata aide firejail"
+TEST_SUITES = "ssh ping apparmor clamav openscap samhain sssd checksec smack suricata aide firejail"
 TEST_SUITES:append = " parsec tpm2 swtpm ima"
 
 INSTALL_CLAMAV_CVD = "1"
-- 
2.51.0


