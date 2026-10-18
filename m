Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D53CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:45:46 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7817.1792287939520625106
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:45:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cuBKoJe3;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so510325ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792287939; x=1792892739; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0r5m4fMMokRuOowxLJ+PtuDJMMZd0xIgAOQ/+ls8rw=;
        b=cuBKoJe32senmmEbnLEuCui1Os+87eQfglW+R7tyBL0MiNmpQWmIWGL/a7VJNQ1E3/
         d14/akSq22AwdWBqvJd/xH9sqg4S0K3Jl2U2LHLwhZMKjLzrid4v4faK/lV58XjviGeP
         Ey7P61i8cVueCSsmPB4NoAVx8oATM6RPCYzmFoXvZDBd2YXJAQmkU8xtmoG79mvNWq/3
         N0wV8pDaUf+Ym2bFyabC6ZRvKDyJNr6NdjzqCQdSO7rNxaD9FHdNqpTSniz7V9Bfb+HJ
         POSWeHMdlnlfrnuI8lOMmbjzULbe1xmV+LV0gKIBUIXuicArApjLVBBHzo5PnRVyQ6AL
         X9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792287939; x=1792892739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0r5m4fMMokRuOowxLJ+PtuDJMMZd0xIgAOQ/+ls8rw=;
        b=ZduI+dDa1tr3iS73YwOuKaYS32mo5HmGqT7RoIrodYoUwZKryf7LWmqJ7/jt95UpdK
         jgatIZO1nWQvtPhiasISsVJtAbLyeRM9uFGFLMRw3qb5QlHBCU53/WqXE9YpPUJ/6v3N
         H4HCpcPonf/uQ0bd1MHKqtyVUYiNECQGXJyepZnT/8JdnmE0iI30lKF0BqmlQVBBAwUB
         YdxdpMXRGdn9XaDo13bUr7M1xzZVvBlly6pqVuWv1Sbcx3BS2iOwpACX8wJjRKKpTDlh
         w59YgCqau+eYNCjqZqrnlukim8AS25eZpF+ZUB3/PH9Q4+HO8OoeNyFdB8lYxhHbr7s+
         h/yQ==
X-Gm-Message-State: AFq9FYKBCb+nZlY/wP7vgxE+Imi/uXiDitT7BgPC/4Z5WvUsPTRc4CL9
	XJzvCQiyqzb871NK16gUWP+0Yk9HJd/ru5HCZC32vZj/L0ukBNfZC37tqKvZsw==
X-Gm-Gg: AYBFou2YhWKkPNt6agw0OeRgTS4LRk8FwXJCzFNQKpuXAy4wTjPlJ+YvlxP+4XYROm1
	gV09+PwiHMLCq2cztp9lw6WPdk+mL7BmfaavmA2OhXKSXflqYnfNFqd+xqKH/7mMefuql7sXmYT
	lHBTDTS8in4hTa8quFGOsWjlqbuUHFl42pssoc8c3glb3wFrhNZPdJ8xTeiWNrYQvb2rNl9U0HP
	6qB0e0E32n/ublyjvtbit0StPcpEuYEKWKKG75z6egKgRGM7GwreLe9L+mn/fooLLi/BkLrxOpb
	0X+LYJGcbpes7sqcMlVigOvorbxYdKQ0iv43TjP70NYLzYf7TUYA+whBSXoh4+QjYTzKtDEe9rY
	+MPsYiuEqFbaOiiVR+6eeMUpjlSLNLGTFt8HTa83HaATZW5qKb5NIdap44pnUhVVJZN/KHYAy5e
	QbuYgUZR/mkQZgCCGXOfJbO5JZlcaKB2jR2U852FXId0H1RP5M3a90p/Zqf8V/9yLPDw6zRaHuu
	nadFJT1rwR4C0C3L4OPP8RyxLM38vEKzq9Do3j2+w==
X-Received: by 2002:a17:902:e5cf:b0:2e7:8d:89bd with SMTP id d9443c01a7336-2e9a73557edmr33309325ad.73.1792287938893;
        Sat, 17 Oct 2026 18:45:38 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.45.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:45:38 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/5] Use django.test.TestCase so tests run against a test database.
Date: Sat, 17 Oct 2026 18:43:56 -0700
Message-ID: <20261018014510.72203-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014510.72203-1-tim.orling@konsulko.com>
References: <20261018014510.72203-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:45:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5045

unittest.TestCase gets no test database, so the tests used the
configured one and failed against a fresh database. Also allow CSPTest's
"testhost" in ALLOWED_HOSTS.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/test.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Post/test.py b/Post/test.py
index 6afb0a6..734b99c 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -1,8 +1,7 @@
-import unittest
 import urllib.request, urllib.parse, urllib.error
 import json
 import re
-from django.test import Client, override_settings
+from django.test import Client, TestCase, override_settings
 from Post.models import BuildFailure, Build
 from Post.validators import clean_link_back
 
@@ -64,7 +63,7 @@ def compare_db_obj_with_payload(self, bf_object):
 
     f.close()
 
-class SimpleTest(unittest.TestCase):
+class SimpleTest(TestCase):
     def setUp(self):
         # The test clients submit with HTTP_HOST="testhost", so allow it here
         # instead of hardcoding a test host into the project settings.
@@ -248,7 +247,8 @@ class SimpleTest(unittest.TestCase):
         response = self.client.get("/Errors/Details/9898989898/")
         self.assertEqual(response.status_code, 200)
 
-class CSPTest(unittest.TestCase):
+@override_settings(ALLOWED_HOSTS=["testhost"])
+class CSPTest(TestCase):
     def setUp(self):
         self.client = Client(HTTP_HOST="testhost")
 
@@ -307,7 +307,7 @@ class CSPTest(unittest.TestCase):
 
         Build.objects.all().delete()
 
-class LinkBackValidatorTest(unittest.TestCase):
+class LinkBackValidatorTest(TestCase):
 
     def test_allows_http(self):
         self.assertEqual(clean_link_back("http://example.com/build/1"),
@@ -350,7 +350,7 @@ class LinkBackValidatorTest(unittest.TestCase):
         self.assertIsNone(clean_link_back(123))
 
 
-class LinkBackSubmissionTest(unittest.TestCase):
+class LinkBackSubmissionTest(TestCase):
 
     def setUp(self):
         # The test client submits with HTTP_HOST="testhost"; allow it here.
@@ -358,9 +358,6 @@ class LinkBackSubmissionTest(unittest.TestCase):
         override.enable()
         self.addCleanup(override.disable)
         self.client = Client(HTTP_HOST="testhost")
-        # Start from a clean slate; other unittest.TestCase tests commit rows.
-        Build.objects.all().delete()
-        BuildFailure.objects.all().delete()
         with open("test-data/test-payload.json") as f:
             self.base_payload = json.loads(f.read())
 
-- 
2.56.0


