Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB46CA600B
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 15:05:11 +0000 (UTC)
Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17525.1791471903207557305
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 08:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=Dq5Ckkly;
 spf=pass (domain: qbee.io, ip: 74.125.225.132, mailfrom: piotr@qbee.io)
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so15323435e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1791471901; x=1792076701; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BgWx3++iUHmf6PV2fOwQNmVQ8PpXc9DxcfSvLKqpaCI=;
        b=Dq5CkklyVhLvGcybcUQESbBDMjyr1TtRt/C2DLVse9QyVXQFDfr6cSKjP+wO9Pp8Ug
         ePT0DdNsKQ0mriP0MAmwyuXuOVPUpE1UP4fF+7PijOL/zGvNeEpyCKge0t/PCyl/oxrN
         qlZH1wjJnN8o/8VQhyLMQUnmlVPJACi6NosaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471901; x=1792076701;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgWx3++iUHmf6PV2fOwQNmVQ8PpXc9DxcfSvLKqpaCI=;
        b=rhnR0cXq36208SLHtXBMraHNPt9xdepmTmqXg3SqBVULd6MTEO255fvYWCo+xZp0DC
         vOZNnWSK7s0p2AqIMMPO7lfUYzLX7zqNNZ3ZoSNlEGudcLopvYPh4tILuJd2Zz0hAroB
         bMkCh+1CoSqJtc/+/M6GAvXlxAp7upTcJrj6sCmW7yO/MJuWEw3HuXC+Kx7maTNV0bdv
         a1cozJ/ZcI9fwVOsP4yIxr43VTUqfr/TeRW1qLC8b3vEzbZF8xIVFhhGVE7713jd/wQr
         FVC1HOH3Icjoo/mofYuUXcVqtv1ckXdL2H0BcmuoSut7xaWTi+rAM3/2f54P2TMIbZYW
         CD8w==
X-Gm-Message-State: AFuF++mtYNHvtH26e2R5Ej103Wr4X0iqKQiVNLnNueExWu7HpHZGleYh
	pyxtOz+mDkinFgV04k7ouWxgruUrD4UP6PRyaSiASd9cUI3iiLvVavL2kCxd6wVy6m869H5qSga
	Ckv5NTZSBVaUNvb4=
X-Gm-Gg: AYBFou2bzKiLgdfctJtyiAF0D2vRFC4aijHhdEQKwpPfAlN//no4vN7SwyoFIsreCc3
	a/VGUztpDlA4G5T9JOsvkZCs/qJC2cxxyfhOeiBhflyKOJ8izATFzsIVnhCR4faMvfazJ0XQE86
	UT22Dop5ySMGyjbMMGo2MhuSDX/pb0owyJgAbzCYZpJ+xhIQ4pemKcYWJO2crv9gPwQfNwnTwM0
	jsCyzv93TScrVGP0ftkCmwBUnPxwwQzLaTS2CSlNx1qQggV83SUK0LJ714kZn5OryXUAJ5cbqBo
	ZBdm0L5cE7BEbp9jOMlowSH2Fg/rKbCSPuSZ0IhcT5jG144M3l/iC47pZtRN5TpVes52AoQVt/A
	wLi3ITAA6v/hY7yQWB9YfD54c6nLp8pOIqtS6fpnsNaUB7KfAvCIub2hJAZM3a5xPAmEsOS2Rqz
	xxBQMFy6kyPyixEkwNzwA6nzKg5SiICWyk1YWKZ5en4U6OdhQOdT08hGTnH8qmz3kDYnMBlHbQ6
	FYeNFcHQGfxInRZtiM/ZrSHWmOEp2k=
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a1806508edmr106582375e9.30.1791471901111;
        Thu, 08 Oct 2026 08:05:01 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a17f486b6fsm115877215e9.1.2026.10.08.08.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:04:56 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [error-report-web][PATCH 2/3] Add link back validator and use it in the parser.
Date: Thu,  8 Oct 2026 17:04:45 +0200
Message-ID: <20261008150446.74259-2-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008150446.74259-1-piotr@qbee.io>
References: <20261008150446.74259-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 15:05:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5000

This will prevent invalid URL (non-http(s)) from being recorded.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 Post/parser.py     |  3 +-
 Post/test.py       | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 Post/validators.py | 42 +++++++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 Post/validators.py

diff --git a/Post/parser.py b/Post/parser.py
index 08f471d..b6740d0 100644
--- a/Post/parser.py
+++ b/Post/parser.py
@@ -11,6 +11,7 @@
 import json, re
 import bleach
 from Post.models import Build, BuildFailure, ErrorType
+from Post.validators import clean_link_back
 from django.conf import settings
 from django.utils import timezone
 from django.urls import reverse
@@ -48,7 +49,7 @@ class Parser:
             b.DISTRO = str(jsondata['distro'])
             b.NAME = str(jsondata['username'])
             b.EMAIL = str(jsondata['email'])
-            b.LINK_BACK = jsondata.get("link_back", None)
+            b.LINK_BACK = clean_link_back(jsondata.get("link_back", None))
             b.ERROR_TYPE = jsondata.get("error_type", ErrorType.RECIPE)
 
             # Extract the branch and commit
diff --git a/Post/test.py b/Post/test.py
index 15aa4be..0705f3c 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -4,6 +4,7 @@ import json
 import re
 from django.test import Client, override_settings
 from Post.models import BuildFailure, Build
+from Post.validators import clean_link_back
 
 #Delete the data between tests
 def data_runner (func):
@@ -246,3 +247,86 @@ class SimpleTest(unittest.TestCase):
 
         response = self.client.get("/Errors/Details/9898989898/")
         self.assertEqual(response.status_code, 200)
+
+
+class LinkBackValidatorTest(unittest.TestCase):
+
+    def test_allows_http(self):
+        self.assertEqual(clean_link_back("http://example.com/build/1"),
+                         "http://example.com/build/1")
+
+    def test_allows_https(self):
+        self.assertEqual(clean_link_back("https://example.com/build/1"),
+                         "https://example.com/build/1")
+
+    def test_rejects_javascript(self):
+        self.assertIsNone(
+            clean_link_back("javascript:alert(document.domain)//PROBE"))
+
+    def test_rejects_data(self):
+        self.assertIsNone(
+            clean_link_back("data:text/html,<script>alert(1)</script>"))
+
+    def test_rejects_vbscript(self):
+        self.assertIsNone(clean_link_back("vbscript:msgbox(1)"))
+
+    def test_rejects_scheme_relative(self):
+        self.assertIsNone(clean_link_back("//evil.example.com/x"))
+
+    def test_rejects_schemeless(self):
+        self.assertIsNone(clean_link_back("example.com/build/1"))
+
+    def test_rejects_control_char_obfuscation(self):
+        self.assertIsNone(clean_link_back("java\tscript:alert(1)"))
+
+    def test_rejects_leading_whitespace(self):
+        self.assertIsNone(clean_link_back("  javascript:alert(1)"))
+
+    def test_rejects_missing_host(self):
+        self.assertIsNone(clean_link_back("http:///path"))
+
+    def test_rejects_none_empty_and_non_string(self):
+        self.assertIsNone(clean_link_back(None))
+        self.assertIsNone(clean_link_back(""))
+        self.assertIsNone(clean_link_back("   "))
+        self.assertIsNone(clean_link_back(123))
+
+
+class LinkBackSubmissionTest(unittest.TestCase):
+
+    def setUp(self):
+        # The test client submits with HTTP_HOST="testhost"; allow it here.
+        override = override_settings(ALLOWED_HOSTS=["testhost"])
+        override.enable()
+        self.addCleanup(override.disable)
+        self.client = Client(HTTP_HOST="testhost")
+        # Start from a clean slate; other unittest.TestCase tests commit rows.
+        Build.objects.all().delete()
+        BuildFailure.objects.all().delete()
+        with open("test-data/test-payload.json") as f:
+            self.base_payload = json.loads(f.read())
+
+    def tearDown(self):
+        Build.objects.all().delete()
+        BuildFailure.objects.all().delete()
+
+    def _submit(self, link_back):
+        payload = dict(self.base_payload)
+        payload['link_back'] = link_back
+        data = urllib.parse.urlencode({'data': json.dumps(payload)})
+        response = self.client.post("/ClientPost/", data, "application/json")
+        self.assertEqual(response.status_code, 200, response.content)
+        return BuildFailure.objects.get()
+
+    def test_javascript_link_back_is_blanked(self):
+        bf = self._submit("javascript:alert(document.domain)//PROBE")
+        self.assertIsNone(bf.BUILD.LINK_BACK)
+
+        response = self.client.get("/Errors/Details/%d/" % bf.id)
+        self.assertEqual(response.status_code, 200)
+        self.assertNotIn(b'href="javascript:', response.content)
+
+    def test_http_link_back_is_preserved(self):
+        bf = self._submit("http://example.com/build/42")
+        self.assertEqual(bf.BUILD.LINK_BACK, "http://example.com/build/42")
+
diff --git a/Post/validators.py b/Post/validators.py
new file mode 100644
index 0000000..c549664
--- /dev/null
+++ b/Post/validators.py
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: MIT
+#
+# error-reporting-tool - link-back URL validation
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+
+import re
+from urllib.parse import urlparse
+
+# Only absolute http(s) URLs are allowed as a "link back". Everything else
+# (javascript:, data:, vbscript:, scheme-relative "//host" or schemeless
+# values) is rejected so it can never be rendered verbatim into an href.
+ALLOWED_LINK_BACK_SCHEMES = ("http", "https")
+
+# Control characters are used to obfuscate schemes, e.g. "java\tscript:".
+_CONTROL_CHARS = re.compile(r"[\x00-\x1f\x7f]")
+
+
+def clean_link_back(value):
+    """Return a safe link-back URL, or None if the value is not acceptable."""
+    if not isinstance(value, str):
+        return None
+
+    value = value.strip()
+    if not value:
+        return None
+
+    if _CONTROL_CHARS.search(value):
+        return None
+
+    try:
+        parsed = urlparse(value)
+    except ValueError:
+        return None
+
+    if parsed.scheme.lower() not in ALLOWED_LINK_BACK_SCHEMES:
+        return None
+
+    if not parsed.netloc:
+        return None
+
+    return value

