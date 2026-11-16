Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6024.1794870265338664869
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:04:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=piyBb1+Q;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1605197b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794870265; x=1795475065; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSalTJNQ99lPip3G9fhVoi79pdi+vMUsr25YydVxubg=;
        b=piyBb1+QUJdK7wTVGa7owbeiR1rBLuyidxxy41Yeer/Utnz9hlkZlnVrn/nF+kJoST
         OD2qyWiZBhNs3FgagPcofbXtyKki2OueIA3AlvCQiYcGlBsoQoopAb/F9SiQuiCXZ9eI
         0D3/zA9NqgFx+2xh0rErcY0q32PdzvJvDKQqxC4Am2y9aObNmxaBN11nmT+okrFX26qd
         N2xy274keKw+K5lZrh6p14vwdpb/483BZapvhLHSDV3cMl8kI3w57DNf3y7OAx6eVnFi
         ZVuqRSWSmtbhQ4RmJ6NR5qge3aAsNwhEMPPuZiaAdcOPL+ToQVCGcxgVL7eMcRqBPr/D
         ySIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870265; x=1795475065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSalTJNQ99lPip3G9fhVoi79pdi+vMUsr25YydVxubg=;
        b=mN01jiS/CH2s/mrCA5ZQLEG0VwhDHdlU8RglP41MMYISHd1SaIp/cefVg33rT1YOd8
         qOqOUx3yV615H+FE9TvQPdmhDKaoO5yCLvhA11iXvv3dN49LIYe5EBDrgE27BE5CGWMe
         IKqYyDTNWNbkGEFBuJCnIEsPPU0IRkDrLq/QCcz+LNFtldin1IilLUyunCeKCDTdOj8W
         9vQfz0AiOQEeYaJcEWxCtAffMJGpRQaauzN8ZCevtCv9Lxx7/+H9UKGecyjYxBU9pTj9
         SmWMu1KNEJguRDp/bsgsfxgOJl9lIFF7cGV/XsCSNwNl1+uEi468nN28C9aMcA6DvhN4
         8KHA==
X-Gm-Message-State: APuU4Z88Ez2LTdPNL09rcfukNCP+nslmnPQeMKyD0/+anNAncaMiJmlJ
	t/tyj4a0/USyKz8jhbbKIlxZvd2baFXueiSPy9iMRCzG2NRxDCbpQ74gSWlwCA==
X-Gm-Gg: AYBFou1QVTBy2NAcvHESOr6EmoyGbS0Ty5GJ+5m2T9MdSGORfiWo6dQu0+SNRYp/wUB
	xN6GMKgfSGrbWj72OulskQifuZc93PUzRJ2EAX36tU2BjNZP7rnuu+z/SRXDk/6ShMmiZ6mRxtJ
	cygWg0aXkbwrzO4tr+DsDltJshQdlPKeTMRuboNnA4v+tIa/KyU2Z9QeP3d2gKF0VVLsL9XmDLe
	8AUCKUBv1ude7YNBIiQD19CaUuBx0rKS2bXGWKFIj7JUs/cor/5bEux3VrTW3V6PQGdETopyKL/
	p6BrP0/kLLlUBCdIdclr/wPmq867FP4rnUb6MMQ2S6ntqIPQAsqrptFrzXyLwryl1CY/ikH4uho
	56r7H36WU/k0/DRmC/wfG/XYTZKIkSMCA9MVVm841gAo5EfSVPw2/T4Xq69RPhvjkS5weAhs+Ah
	gxz0DUnrn7waqLbQaj4x/je49dtqvVsmOBb+GO9XLrWD8WF/+KgdfiUx0ARq/0SKp86OYZLCeEw
	JYvqWvfFCvNq8/qIb7CpsDW5LqSfyTDNmPGkrnuW1hx7HtRfE5jukHBF/FgBZxQY5eBS/Kyvbje
	8Q6BNlmzHDiE58OmMZzN6hS3XDYph1INkYt3YfpcCc9sl/ejHMDk3o1s9wYNkg==
X-Received: by 2002:a05:6a20:e210:b0:3f5:ef59:3aaa with SMTP id adf61e73a8af0-3f7a70b1d36mr11527541637.16.1794870264571;
        Mon, 16 Nov 2026 15:04:24 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a90f1sm4210535b3a.19.2026.11.16.15.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 15:04:22 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] layerindex/middleware.py: reject NUL characters in the URL with a 400
Date: Mon, 16 Nov 2026 15:03:52 -0800
Message-ID: <20261116230401.42917-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116230401.42917-1-tim.orling@konsulko.com>
References: <20261116230401.42917-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:04:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5438
Content-Type: text/plain; charset="utf-8"

PostgreSQL text can't hold a NUL character, so a search term, API filter
or URL path containing one, e.g. ?q=%00, raised DataError and gave a 500.
MariaDB just found nothing. Forms already reject NUL in what they clean,
but many views read the URL directly, so reject it once in a middleware.

[YOCTO #16520]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py            |  1 +
 layerindex/middleware.py      | 21 +++++++++++++++-
 settings.py                   |  1 +
 tests/test_null_characters.py | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_null_characters.py

diff --git a/docker/settings.py b/docker/settings.py
index cd8bacb..0cfcd83 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -96,6 +96,7 @@ SECRET_KEY = os.getenv('SECRET_KEY', '')
 
 MIDDLEWARE = (
     'corsheaders.middleware.CorsMiddleware',
+    'layerindex.middleware.RejectNullCharactersMiddleware',
     'django.middleware.common.CommonMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
     'django.middleware.csrf.CsrfViewMiddleware',
diff --git a/layerindex/middleware.py b/layerindex/middleware.py
index 6766b1d..1112448 100644
--- a/layerindex/middleware.py
+++ b/layerindex/middleware.py
@@ -7,9 +7,28 @@
 # SPDX-License-Identifier: MIT
 
 from django.utils.deprecation import MiddlewareMixin
-from django.http import HttpResponseRedirect
+from django.http import HttpResponseBadRequest, HttpResponseRedirect
 from django.urls import reverse
 from reversion.middleware import RevisionMiddleware
 
 class NonAtomicRevisionMiddleware(RevisionMiddleware):
     atomic = False
+
+
+class RejectNullCharactersMiddleware:
+    """
+    Return a 400 for a request with a NUL character in its path or query
+    string. PostgreSQL text can't hold NUL, so any lookup with such a value
+    raised DataError and gave a 500. Forms already reject NUL in what they
+    clean; this covers the views that read the URL directly.
+    (AI-generated, Claude Opus 5.5)
+    """
+    def __init__(self, get_response):
+        self.get_response = get_response
+
+    def __call__(self, request):
+        if '\x00' in request.path or any(
+                '\x00' in key or any('\x00' in value for value in values)
+                for key, values in request.GET.lists()):
+            return HttpResponseBadRequest('NUL characters are not allowed')
+        return self.get_response(request)
diff --git a/settings.py b/settings.py
index 495af1e..573311a 100644
--- a/settings.py
+++ b/settings.py
@@ -96,6 +96,7 @@ SECRET_KEY = ''
 
 MIDDLEWARE = (
     'corsheaders.middleware.CorsMiddleware',
+    'layerindex.middleware.RejectNullCharactersMiddleware',
     'django.middleware.common.CommonMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
     'django.middleware.csrf.CsrfViewMiddleware',
diff --git a/tests/test_null_characters.py b/tests/test_null_characters.py
new file mode 100644
index 0000000..e4c685d
--- /dev/null
+++ b/tests/test_null_characters.py
@@ -0,0 +1,45 @@
+# layerindex-web - tests for NUL characters in requests
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# [YOCTO #16520]: PostgreSQL text can't hold NUL, so a search or URL with
+# one raised DataError (a 500). MariaDB returned no results, so these tests
+# check for the 400 rather than for the DataError.
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import Branch
+
+
+@pytest.mark.django_db
+class TestNullCharacters(TestCase):
+
+    def setUp(self):
+        # The migrations may have created it already
+        Branch.objects.get_or_create(name='master', defaults=dict(
+            bitbake_branch='master', short_description='Master', sort_priority=1))
+
+    def assert_bad_request(self, url, params=None):
+        response = self.client.get(url, params or {})
+        self.assertEqual(response.status_code, 400, (url, params))
+
+    def test_search(self):
+        self.assert_bad_request('/layerindex/branch/master/recipes/', {'q': 'a\x00b'})
+
+    def test_api_filter(self):
+        self.assert_bad_request('/layerindex/api/recipes/', {'filter': 'pn:\x00'})
+
+    def test_parameter_name(self):
+        self.assert_bad_request('/layerindex/branch/master/recipes/', {'q\x00': 'a'})
+
+    def test_path(self):
+        self.assert_bad_request('/layerindex/branch/master/layer/a%00b/')
+
+    def test_search_without_nul(self):
+        response = self.client.get('/layerindex/branch/master/recipes/', {'q': 'ab'})
+        self.assertEqual(response.status_code, 200)
-- 
2.56.1

