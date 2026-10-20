Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2013.1792529865606792319
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 13:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Sx5ty3gv;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e831e86ebfso40075ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529865; x=1793134665; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPcE02lrZfWwY+OCoO1LnUwR3P3XVsUx+DNDWxOCV3s=;
        b=Sx5ty3gvGi5mDBoyphinG7HrTRSG8tB2lboI35VvAaqtZJTOCEFyQumjdMVnnLaBWY
         EzC3bt4EddkjKKSAPTBkCepfnlxfx7tap2YuA/1O1WGMRGUUPcwV16RpkzaHgbwVLvGf
         h28vTdq0IgBrm97MZexZdwzKcmyqFxhhH07DL7C0SxdoLlyPaX+UWsbQ2qWHamYPmLNW
         bihoILqNED6UJ0SsZEm3Osu2pfHK9D3e2L87QjKN2c1Lc+qQGp7U/YoIhIujhfDtADB2
         KsW1uPgnRC6IzbLfsDaTmSQKYD287LdYhuD8zQyJ+s3nSQoX47C3Aqa9/JB1BZSFGS/W
         f8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529865; x=1793134665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WPcE02lrZfWwY+OCoO1LnUwR3P3XVsUx+DNDWxOCV3s=;
        b=AP3cIBaoeqyiRJ8iWlFAZ80N4wD3e+YkmufhYJiRuky3/uObS/RIp6h8JZ2/qiZcS9
         uhTZZVZsEdfzG0gQnPIAJa90CMkI62A8Z91AP74tEkwTNCrTTOH0hvSl72qXIbEAOGR0
         fVdYsM09FhUoXeFXj6WAH6fldhgdI3y9Jjb7MAA9zA/h212seoFpHliDNmq/ONQnqWjL
         JbxbspSUam0aZMPSstd26ByIvfa5X1eKNITRrdhkjOrEehk15LpvpyIWa6KmBOhcsa/x
         wlggXpbq+8p/xFaYBU4hJi4Hzx40w7Dtnzl5NpHDqfSpXrbXZIOvO5Q468ImoW92cjM4
         Firg==
X-Gm-Message-State: AFq9FYI+0KNOb6xKmv/MGhi+NiP44K98tQCJfTR7TFlkeo4fYbpKNWhq
	Vmf/Tqt+32QA98AmxtESQaD95x0GmRi2JNdx+sL982mg2+dMIVbk0aaf8QvxF9Sc
X-Gm-Gg: AYBFou2fWCqrWjflmBjTragNIsJMQBldPAuhOiaGn9Bq28W47jFoCd7RZJYxCxm+lFS
	ysrewttDpDV4mmMG79pdiskaVUrWD5dydBNxlPb7i6XnFeIDCTQELXdNxoUE7RBgf6yiFyn2ilH
	+eoy2PAottg0mybcvxQXFYzwxrR7DU5ibV9cF6ufD0m3F6i9sZp+e1bQ4P+drlWA2PrWJVCyPxx
	Q4JKcWVRhl4jxV8k6fxoDwOLwC/6jBZi4NJYOqOe0DjRaOkOiEj7adWvZcbEbmgxvoZd1WIGQnr
	+WOgT1LF8IeedGZN+uUBFkfAQ9uIj4cQcGEhutUFb4BQ9Ofz20kW71SlApAZxP7jgQjRCpbxyv7
	Y842dmG5NWnhhrokbTPj7awjYWUykrKPVMB7bajOkprZGkG4FoKRysnkLIi+m0ae6GRbhJS0ZHR
	Z4wLn/3g41W3ED0BvLOBcg1CJ+ZUBCv4NQd9ASayDiGdUEdE5JExm46bnYijbldT/TshqETRPAF
	yQoRpehr8g7BRe8RFeY8yAPZSzkYJlu
X-Received: by 2002:a17:90b:6cc:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3ad86a402ebmr169502a91.0.1792529864848;
        Tue, 20 Oct 2026 13:57:44 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8029765fsm1039115a91.10.2026.10.20.13.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 13:57:43 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] layerindex/views: don't expose patch generation errors to users
Date: Tue, 20 Oct 2026 13:57:29 -0700
Message-ID: <20261020205730.53370-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020205730.53370-1-tim.orling@konsulko.com>
References: <20261020205730.53370-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 20:57:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5116
Content-Type: text/plain; charset="utf-8"

bulk_change_patch_view returned the output of the failing bulkchange.py
run, or the exception text, in the HTTP response. That can include
tracebacks, server paths and bitbake output. Log the details instead
and return a generic error with status 500. The lock timeout message
is kept, since it tells the user what to do and reveals nothing.

Reported by CodeQL (py/stack-trace-exposure).

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py             | 14 ++++++++------
 tests/test_bulkchange_access.py | 11 +++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 42722bf..592311f 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -6,6 +6,7 @@
 #
 # SPDX-License-Identifier: MIT
 
+import logging
 import os
 import sys
 import re
@@ -63,6 +64,8 @@ from layerindex.models import (BBAppend, BBClass, BBClassGlobal, BBClassRecipe,
 
 from . import tasks, utils
 
+logger = logging.getLogger(__name__)
+
 def edit_layernote_view(request, template_name, slug, pk=None):
     layeritem = get_object_or_404(LayerItem, name=slug)
     if layeritem.comparison:
@@ -347,12 +350,11 @@ def bulk_change_patch_view(request, pk):
         return HttpResponse('No patch data generated', content_type='text/plain')
     except Exception as e:
         output = getattr(e, 'output', None)
-        if output:
-            if 'timeout' in output:
-                return HttpResponse('Failed to generate patches: timed out waiting for lock. Please try again shortly.', content_type='text/plain')
-            else:
-                return HttpResponse('Failed to generate patches: %s' % output, content_type='text/plain')
-        return HttpResponse('Failed to generate patches: %s' % e, content_type='text/plain')
+        if output and 'timeout' in output:
+            return HttpResponse('Failed to generate patches: timed out waiting for lock. Please try again shortly.', content_type='text/plain')
+        # Details can include paths and bitbake output, so keep them in the server log
+        logger.exception('Failed to generate patches for bulk change %s: %s', pk, output)
+        return HttpResponse('Failed to generate patches, please contact the site administrator.', content_type='text/plain', status=500)
     # FIXME better error handling
 
 
diff --git a/tests/test_bulkchange_access.py b/tests/test_bulkchange_access.py
index e85451d..914493c 100644
--- a/tests/test_bulkchange_access.py
+++ b/tests/test_bulkchange_access.py
@@ -51,3 +51,14 @@ class TestBulkChangeAccess(TestCase):
         for name in ('bulk_change_edit', 'bulk_change_review'):
             response = self.client.get(self._url(name))
             self.assertEqual(response.status_code, 200, name)
+
+    def test_patch_error_details_not_exposed(self):
+        import subprocess
+        from unittest import mock
+        self.client.force_login(self.owner)
+        err = subprocess.CalledProcessError(1, 'bulkchange.py', output='Traceback: /opt/secret/path')
+        with mock.patch('layerindex.views.utils.runcmd', side_effect=err), \
+                self.assertLogs('layerindex.views', 'ERROR'):
+            response = self.client.get(self._url('bulk_change_patches'))
+        self.assertEqual(response.status_code, 500)
+        self.assertNotIn(b'/opt/secret/path', response.content)
-- 
2.56.0

