Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF6CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:50:03 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22237.1792360195225342209
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cHm/RruM;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a706146559so1202313a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360194; x=1792964994; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXXQSMnJANIuAV0nF5mxVJoc9r1nL8MeFNlBH/6Iw6M=;
        b=cHm/RruMqV+Weud1QnWyfq9/K7Bg1n/1kMbigL+D0OilasdmHcN9rEMKxMNjcHXKOX
         wzE1GPyNGa0DUgxn3MYuwcAnNrgvtWAAdiXsq8Mig4EaF16VrJm96Y3GV9usG9NSRMH1
         XFC2/cO8kx+XDP3KyAP7+Nqbt9zXiMENFdzSMCC0mBxLUKkTsJJCrZCWoDjRQQUy8irL
         Jae5V8HR9QoLtVUyrMgs97CgUm8zu1Wm5UkhL79/gl72U07bTSBU5Uwa6hnCDJAMiA4A
         R8x0KUyze/SB2SZC/qdl2Xgv+nz2/4oIC0H384LXFyIzyiDk1eUhaRkgAHzQv2Z/2gWp
         fheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360194; x=1792964994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXXQSMnJANIuAV0nF5mxVJoc9r1nL8MeFNlBH/6Iw6M=;
        b=mbkc/GAb2eDpDqniRI4gGe0hTYaJhyjLk5fXvCnFz4eyjHvubzpsGALBmt7aPx0eIh
         Ombq5xL5mkCLz3Y+3Z5Adfgd6wvvdKwsyxWkXHlKZ8Z7z1uP3m1dfnjFvY1EjC6egZX0
         DEsWb+eU+f9Ngyj72HWEfI/+VDOFekGE2KVGYaN0PUbOFo0i8ZNuZnracFHCeu/xmZLB
         mn2SEbDyT/prvWtP7kUzY0gRKklBIssAyMgYADo0b1o+HMnkhcGb/bpOAufkL8D2GKGw
         hpItuabJS5y6bIor4Uj+iY8kA7UpQHmsLt+AScfejMn5fgrfpZgCGyjruZ/UIRQaWIxG
         4IlA==
X-Gm-Message-State: AFq9FYI/f+pOmuhas2mk6a7EP/ZUtIryJ+TLgkAtIcaVn1Pkta2OT+x3
	q8emfwIfrCgLmIqHlf3LLnV2WbTU0p2K9nKV4BujP6t2YmkTyZQPNozwryKPEPuI
X-Gm-Gg: AYBFou31RrYkAB6/CYX+T6nC0eQu/UjpTs2mniLS8Pe3E9uezO41jq2gRBEx3QoE/9n
	EFD34c47InIyPg+FLxrfKOmEcz19+J8o03es0cyMAQeQJNBNv5QsoEs1Nd3WY4N9/JicDEdpPjg
	eibk9C5F5yhnfpqfr1MV6gmuDWTwh4pJWZJ4fIdrnMyO+rvNLNeknVrlcU+qd9S4x2ywxnIGhfg
	A4fYBd1iHJ9qmcZoRByNIqMpSbga9xaDvnTRvO2MjMm5H3qpbaLEx0jyf5HjuHm38SzmFrntfiO
	mwT5uRCI81GqsR+Peadx4eXKaXhlyVnFc9xPFRcwaN2SdR5T9N82vIP/Szi0bK6TZfu/itPEL2M
	XpeSSjuuvymS3PyET85KK2ZGUSZx/6dX9UU8nGHnQWTq0r4tulw2n3wHSgDycpQ88egxriusFRy
	kEVG6vI58HfLG0WYOa+QtwuRL7EvhM2Qi73ouC90Uanx7x7EQ3aBeGsARtQ11Jq1k1UjOWEoyD2
	4JCrsEgt09EkZhLIv3IVNihBvmwLLzp
X-Received: by 2002:a17:90b:4cd0:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3acef104296mr5081526a91.11.1792360194555;
        Sun, 18 Oct 2026 14:49:54 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm18418500a91.3.2026.10.18.14.49.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:49:52 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] settings: fix the minutes in REST API timestamps
Date: Sun, 18 Oct 2026 14:49:48 -0700
Message-ID: <20261018214948.69706-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:50:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5081

REST_FRAMEWORK['DATETIME_FORMAT'] used %m (the month) where the minutes
belong, so every timestamp the API returned had the month in place of
the minutes: 14:37 in October came out as 14:10. Use %M.

bitbake's layerindexlib keeps these values as opaque strings, so it is
not affected.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py    |  2 +-
 settings.py           |  2 +-
 tests/test_restapi.py | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_restapi.py

diff --git a/docker/settings.py b/docker/settings.py
index 90bc5f4..a4ea2d9 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -195,7 +195,7 @@ REST_FRAMEWORK = {
     'DEFAULT_PERMISSION_CLASSES': (
         'layerindex.restperm.ReadOnlyPermission',
     ),
-    'DATETIME_FORMAT': '%Y-%m-%dT%H:%m:%S+0000',
+    'DATETIME_FORMAT': '%Y-%m-%dT%H:%M:%S+0000',
 }
 
 # A sample logging configuration. The only tangible logging
diff --git a/settings.py b/settings.py
index b318687..324ad50 100644
--- a/settings.py
+++ b/settings.py
@@ -195,7 +195,7 @@ REST_FRAMEWORK = {
     'DEFAULT_PERMISSION_CLASSES': (
         'layerindex.restperm.ReadOnlyPermission',
     ),
-    'DATETIME_FORMAT': '%Y-%m-%dT%H:%m:%S+0000',
+    'DATETIME_FORMAT': '%Y-%m-%dT%H:%M:%S+0000',
 }
 
 # A sample logging configuration. The only tangible logging
diff --git a/tests/test_restapi.py b/tests/test_restapi.py
new file mode 100644
index 0000000..af1f708
--- /dev/null
+++ b/tests/test_restapi.py
@@ -0,0 +1,30 @@
+# layerindex-web - tests for the REST API
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import datetime
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import LayerItem
+
+
+@pytest.mark.django_db
+class TestRestApiDatetimes(TestCase):
+
+    def test_datetime_format(self):
+        layer = LayerItem.objects.create(name='meta-test', status='P', layer_type='A',
+                                         summary='test', description='test',
+                                         vcs_url='git://example.com/meta-test.git')
+        # auto_now would overwrite a value passed to save()
+        LayerItem.objects.filter(pk=layer.pk).update(updated=datetime.datetime(2026, 10, 18, 14, 37, 5))
+
+        response = self.client.get('/layerindex/api/layerItems/', {'format': 'json'})
+        self.assertEqual(response.status_code, 200)
+        data = response.json()
+        items = data['results'] if isinstance(data, dict) else data
+        item = next(i for i in items if i['name'] == 'meta-test')
+        self.assertEqual(item['updated'], '2026-10-18T14:37:05+0000')

base-commit: e6040597ae0f614581de241fe78f20e34dae13ac
-- 
2.56.0


