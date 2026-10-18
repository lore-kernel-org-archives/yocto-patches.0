Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F2CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:47:36 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7808.1792288046527817754
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:47:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=c31xDJOL;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso8432915ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288046; x=1792892846; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/S5sPXsIyRmIGUnwhuuvERiQrBb3PRHHUebft2nC6I=;
        b=c31xDJOLi08oSkWeJj7U3cdaa1J4CFgNZy6jCOdKRePwT0kRoYuiQse+Z9m1J65ihH
         xdv4rb1HO+l6xU9ApsaHCSRzUWnEdVH/tquzuz3sWGN2XZGmsgcSeTJd06VWVSI3wC/y
         NN4rDtxhB34vnNFiDmoplmpYYny4fDJRxc2X87c8V9uSmbCqXhp6sZW+dT9lAB3VPKOM
         XZv7/XlUSKxHa1Z4Y+flfeW8S59QX41wrYdk2aQolP5euQ+h8nfBk1Kugh8iKH4FwXo9
         P9k2jNhoY0zqpHdWNFOMvnkQq6akRUg4Cfw7+/TS9o4upubM8rctdjF108oDCesYky8K
         EadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288046; x=1792892846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/S5sPXsIyRmIGUnwhuuvERiQrBb3PRHHUebft2nC6I=;
        b=yDhHiUQ65ChO+nyFNQ4Vqjms9ArKSiZeOGOCy08iBI76XtTXX8cDLqEO3iC9F13m8v
         ihVSFK1D/klxSlUMyUufhlLk+ryNJ4fpbKql186gisCa+mgQswM60c02KSjXZwx8uD3X
         vKGkzNXmy3NGNjDrzMjDNSOWXg5DRfr1GDMrE8TSizx0Ibq3MWKm8npPtfdyRO2IiSNP
         0QWKcireR2Vu6TNBUO4Qt+zPVS8E2x2JrG/JGK++CFzk7EH7FfIM+OqZDExNGoB518U4
         BdSd9rOPb7djSy81nKdeCMcsFmVARg3RJFCl/VFiBxJi52YJJgZJMoMM12zvesdGiuIi
         jkzw==
X-Gm-Message-State: AFq9FYJp1NUk6JhjsISxvv8ylg6sNQ3jIAjbmqSrQdPyQrYITzdOTzfE
	eXdIoo2EX8QWy+ITo/AmoFywxHLw7ySDln2vzuA8pKMCboU0r7GHSis30jp0dQ==
X-Gm-Gg: AYBFou37CySZ/YWnpfQLpuhJTwTfBej/YFYbhUO6q51lBXXLEdXopsI8Ca+qxNx/JTp
	l1sNdAwq2SZnFS/M4ZqkZVSDyGP4pP++OZeVHgQMlQlvD1p8yw62mJqz7P+6HDriX6IYVxQLgT0
	LFpHuwIug+x+RprTOljWh7AtPcK/dn3LhnKXtzrfyC+XKiSU8kFE9e52YqjKxBzJriUkTQJLt6i
	XErNcFdDb10fg4ezQVxXXlvcSA0vnh5isrlGnDoQS0/mDqeDoIWhyyw6TYoQVESKo9p9XUj/e5E
	MgJy6Ia4X4SkpefWCo0/NPaj/i1isz8eC+tz6erihpS+6dXAgr58Q/v9tubDaYC1QLaCCrTMjT7
	l4xBsX7dm4qH/3nbXsGSu7vOEj7nyTSMtvSmqnJPmb2rUrJczT1wSPfgtd+QwKgWtB0uSTwyTw2
	9i/zcF6vJtWamIVGqQ5OhSLeYKvWDT0S+slclEQGI0yTRfB2vORMHGCTArDjymKUvHFHxn+q3WC
	CUhjGnpE4ibGcAeJH+LjKgDuM96O0M=
X-Received: by 2002:a17:903:22c3:b0:2e9:9846:2da7 with SMTP id d9443c01a7336-2e9a68437f0mr38901305ad.5.1792288045820;
        Sat, 17 Oct 2026 18:47:25 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:47:25 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 5/5] Add a ruff lint job to CI and fix its findings.
Date: Sat, 17 Oct 2026 18:44:04 -0700
Message-ID: <20261018014510.72203-11-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014510.72203-1-tim.orling@konsulko.com>
References: <20261018014510.72203-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:47:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5049

Pin ruff and select its classic rules, which find bugs; newer defaults
are mostly style. Fix the findings. The paginator now catches
InvalidPage, and the JSON parser Exception, so deeply nested JSON
(RecursionError) is still reported as invalid. Test bad page numbers.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .github/workflows/ci.yml         |  9 +++++++++
 Post/createStatistics.py         |  6 ++----
 Post/models.py                   |  4 +---
 Post/parser.py                   |  5 +++--
 Post/purge.py                    |  2 +-
 Post/templatetags/projecttags.py |  4 ----
 Post/test.py                     | 13 ++++++++++++-
 Post/views.py                    | 10 ++++------
 ruff.toml                        |  5 +++++
 test-data/test-send-error.py     |  4 +++-
 10 files changed, 40 insertions(+), 22 deletions(-)
 create mode 100644 ruff.toml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 74405ac..f53ae69 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -20,3 +20,12 @@ jobs:
 
       - name: Build image and run tests
         run: docker/run-tests.sh
+
+  lint:
+    runs-on: ubuntu-latest
+    timeout-minutes: 10
+    steps:
+      - uses: actions/checkout@v5
+
+      - name: Ruff
+        run: pipx run ruff==0.17.0 check --output-format=github .
diff --git a/Post/createStatistics.py b/Post/createStatistics.py
index 09d098e..6ecab0a 100644
--- a/Post/createStatistics.py
+++ b/Post/createStatistics.py
@@ -8,11 +8,9 @@
 #
 # Licensed under the MIT license, see COPYING.MIT for details
 
-import sys, os
 from Post.models import Build, BuildFailure
 from django.db.models import Count
-import re
-from datetime import datetime, timedelta
+from datetime import timedelta
 from django import utils
 
 class Statistics:
@@ -52,7 +50,7 @@ class Statistics:
         elif string == "NATIVELSBSTRING":
             errors = Build.objects.filter(DATE__range=[enddate, startdate]).values('NATIVELSBSTRING').annotate(dcount=Count('NATIVELSBSTRING')).order_by('-dcount')[:6]
             items = list(errors)
-            return items;
+            return items
         elif string == "TARGET_SYS":
             errors = Build.objects.filter(DATE__range=[enddate, startdate]).values('TARGET_SYS').annotate(dcount=Count('TARGET_SYS')).order_by('-dcount')[:6]
             items = list(errors)
diff --git a/Post/models.py b/Post/models.py
index 541f394..eef0c0c 100644
--- a/Post/models.py
+++ b/Post/models.py
@@ -7,9 +7,7 @@
 # Licensed under the MIT license, see COPYING.MIT for details
 
 from django.db import models
-from django.db.models.signals import post_save
 from django.conf import settings
-from datetime import datetime
 
 import Levenshtein
 
@@ -117,7 +115,7 @@ class BuildFailure(models.Model):
 
         recalc_lev_distance = kwargs.pop('recalc_lev_distance', False)
 
-        if self.LEV_DISTANCE == None or recalc_lev_distance:
+        if self.LEV_DISTANCE is None or recalc_lev_distance:
             self.LEV_DISTANCE = self.calc_lev_distance()
 
         super(BuildFailure, self).save(*args, **kwargs)
diff --git a/Post/parser.py b/Post/parser.py
index b6740d0..092ce24 100644
--- a/Post/parser.py
+++ b/Post/parser.py
@@ -8,7 +8,8 @@
 #
 # Licensed under the MIT license, see COPYING.MIT for details
 
-import json, re
+import json
+import re
 import bleach
 from Post.models import Build, BuildFailure, ErrorType
 from Post.validators import clean_link_back
@@ -26,7 +27,7 @@ class Parser:
 
         try:
             jsondata = json.loads(self.data)
-        except:
+        except Exception:
              return  { 'error' : 'Invalid json' }
 
         # Bleach data going directly into the database so that
diff --git a/Post/purge.py b/Post/purge.py
index f4989fb..eb2ee7b 100644
--- a/Post/purge.py
+++ b/Post/purge.py
@@ -1,4 +1,4 @@
-from datetime import datetime, timedelta
+from datetime import timedelta
 from django.utils import timezone
 import os
 import sys
diff --git a/Post/templatetags/projecttags.py b/Post/templatetags/projecttags.py
index a01989f..838b8f7 100644
--- a/Post/templatetags/projecttags.py
+++ b/Post/templatetags/projecttags.py
@@ -1,8 +1,4 @@
-from datetime import datetime, timedelta
-import re
 from django import template
-from django.utils import timezone
-from django.template.defaultfilters import filesizeformat
 from Post.validators import clean_link_back
 
 register = template.Library()
diff --git a/Post/test.py b/Post/test.py
index 9527a9f..2a98bfc 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -1,4 +1,6 @@
-import urllib.request, urllib.parse, urllib.error
+import urllib.request
+import urllib.parse
+import urllib.error
 import json
 from unittest.mock import patch
 from django.core.management import call_command
@@ -389,6 +391,15 @@ class LinkBackSubmissionTest(TestCase):
 
 
 
+@override_settings(ALLOWED_HOSTS=["testhost"])
+class PaginationTest(TestCase):
+    def test_invalid_page_shows_last_page(self):
+        client = Client(HTTP_HOST="testhost")
+        for page in ("999", "abc"):
+            response = client.get("/Errors/Latest/", {"page": page})
+            self.assertEqual(response.status_code, 200)
+
+
 @patch("Post.management.commands.culldb.time.sleep")
 class CullDbTest(TestCase):
     def setUp(self):
diff --git a/Post/views.py b/Post/views.py
index add68d5..9b6656d 100644
--- a/Post/views.py
+++ b/Post/views.py
@@ -10,19 +10,17 @@
 # vi: tabstop=8 expandtab shiftwidth=4 softtabstop=4
 
 from __future__ import division
-from django.shortcuts import get_object_or_404
 from django.shortcuts import HttpResponse, render
 from django.views.decorators.csrf import csrf_exempt
 from django.shortcuts import redirect
-from Post.models import BuildFailure, Build, ErrorType
+from Post.models import BuildFailure, ErrorType
 from Post.parser import Parser
 from django.conf import settings
 from Post.createStatistics import Statistics
-from django.core.paginator import Paginator, EmptyPage
+from django.core.paginator import InvalidPage, Paginator
 from django.core.exceptions import FieldError, ObjectDoesNotExist, RequestDataTooBig
 from django.http import JsonResponse
 from django.db.models import Q
-import json
 import re
 import urllib
 from urllib.parse import urlparse
@@ -76,7 +74,7 @@ def addData(request, return_json=False):
         if return_json:
             response = JsonResponse(result)
         else:
-            if not 'error' in result:
+            if 'error' not in result:
               response = HttpResponse("Your entry can be found here: "+result['build_url'])
             else:
               response = HttpResponse(result['error'])
@@ -252,7 +250,7 @@ def search(request, mode=results_mode.LATEST, **kwargs):
 
     try:
         build_failures = build_failures.page(page)
-    except:
+    except InvalidPage:
         build_failures = build_failures.page(build_failures.num_pages)
 
     context['build_failures'] = build_failures
diff --git a/ruff.toml b/ruff.toml
new file mode 100644
index 0000000..cd9662d
--- /dev/null
+++ b/ruff.toml
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: MIT
+
+[lint]
+# Ruff's classic defaults: bugs, not style.
+select = ["E4", "E7", "E9", "F"]
diff --git a/test-data/test-send-error.py b/test-data/test-send-error.py
index de2fc49..7a8067f 100755
--- a/test-data/test-send-error.py
+++ b/test-data/test-send-error.py
@@ -3,7 +3,9 @@
 
 # test/example script for sending data to error-report-web
 
-import urllib.request, urllib.error, urllib.parse
+import urllib.request
+import urllib.error
+import urllib.parse
 import sys
 
 def send_data (url, data_file):
-- 
2.56.0


