Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E21ACA600C
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 14:28:01 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16613.1791469676301870593
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 07:27:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DcNPap6L;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: ticotimo@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a01933b584so28489675e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469674; x=1792074474; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyT9PBsxBPxE7rcFzaJHPTHJ6K9wFdNSO7I06oKK2b8=;
        b=DcNPap6L40nchwvxQgKYKogMu8wteowSdLRO07GDJEIPOLARfl+DHXY/rrFIC39Cmr
         xA0+OGT1AUdFMM1UwPHr8WMFxIZ/ORq6jqtL0AOSP6nE794AICXa4G8vik6TZHQOhWZh
         Dsv9wG+VPfmDKPtoOU0URzDBX/y3XBzf/UpxP08vBrKfRpt9gjNX6wQNouFb4Gt41lDL
         QW9g2Ck4G2AY9hDo9qngB/MN4CR1/ThhWzsEiqd+71YlylRHRU+2d4STtiDd23PkHUOI
         hhvrQI7eFda0rKe6J7BjFnJ71SozU2jRD4w4xQbNXEunqqiEWHfkYU5QZ66HUPWyBbL1
         vGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469674; x=1792074474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyT9PBsxBPxE7rcFzaJHPTHJ6K9wFdNSO7I06oKK2b8=;
        b=ihrWP3iUTv6nwG+OtQpKyUnU3IW9h9Z4dpAkQBUtyFPkEChfpJ9AcWGGVbrtU51e6I
         NosFhWzAfUo9pFsPB4n0ySOCpAv6skcQJwRsnevluuWxzpyzs0vxILXfRxNrcSidv/Kw
         kAEGT4jvI5BXJ56ISpTmhzORvmIlGehn8Mvcz9R8nKyXQd0OTEaY7E6pyujdsozsC0d4
         gLL+rORscJ5q1sFuXhJ5BPiIFRt8zCHAnZOZDgQJ92ZDpbGYJgFBu9SE4dEzNUHJ/I93
         RSSsdNM6rymwYgza6Bjd+VjiB5Vit+lNOCdcz4/qPVnFcsK+yHTQsMrRrwMImE+S7bzl
         iA4g==
X-Gm-Message-State: AFuF++mx/q3zFzcn6paQieCY+chvxFrmQjoWzgvVNtBvp/QNXQU2SckA
	x8u4x9tMAuKRAViD4QD1C9za6mPmJKHExYEb/7V3TkyGj+pT+fqTVZfUSoRF1eyC
X-Gm-Gg: AYBFou3zREAVuGSvGLYagYYtevTumgEZBMofnK8+x2uXI6VRwIfdCRsmUyF8bpIxuwo
	udLTTTS7EKixgaupNghjYGfVCiUobQi5ivd9uQAr/0JEH6avJA4m22GvplcMB2AaMVc573fr3vV
	kLfncL2i75bTsuW8FC1Wyj74lzTVHBNvgsK2VPvuqClGUFmJJMI2k0NOAyqsl3sqqV/DFdGZMdV
	FV88FxrLki348pzlWKR1fz4g+yOgfl1w6P/1ed6ogk4tX447aLf2ObMzl2YuoTkCsVa6ku+SFhD
	Ky8I8NsVLGSn/Ijyr9WhmYfV+nK0P2S6PWjKEW2Ue04W6I7aZE4AE1DamDxz1pxhd6RYFNOFLGX
	dltv6rSgr7+Rl8bVC8gVlI22kBly2aoDEpSyOiHZXHfxxSuPp5KF4eLmttPFNXebwfS7/YaK1Ct
	UISuAKFr4vQHAjAJvemebTMG9A7X8/ACovXoOvU78SGtu/bKvYlcqeXVzObaZxMr/a29zXCw2Rg
	EoJuwWKg6oeGRzsJ43aMp9DYNuorv5q5oZbceTOI3jCUbBLjg==
X-Received: by 2002:a05:600c:609a:b0:4a1:7703:e52a with SMTP id 5b1f17b1804b1-4a18031133emr86918025e9.9.1791469674254;
        Thu, 08 Oct 2026 07:27:54 -0700 (PDT)
Received: from localhost.localdomain (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm11491958f8f.38.2026.10.08.07.27.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 07:27:52 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] Add sitemap using django.contrib.sitemaps
Date: Thu,  8 Oct 2026 16:27:38 +0200
Message-ID: <20261008142738.29958-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142738.29958-1-tim.orling@konsulko.com>
References: <20261008142738.29958-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 14:28:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4997

From: Michael Halstead <mhalstead@linuxfoundation.org>

Serve /sitemap.xml listing the main branch views and all published,
non-comparison layers.

AI-Generated: Claude Sonnet 5.5
Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py     |  1 +
 layerindex/sitemaps.py | 36 ++++++++++++++++++++++++++++++++++++
 settings.py            |  1 +
 tests/test_sitemap.py  | 38 ++++++++++++++++++++++++++++++++++++++
 urls.py                |  9 +++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 layerindex/sitemaps.py
 create mode 100644 tests/test_sitemap.py

diff --git a/docker/settings.py b/docker/settings.py
index e3ae0fd..90bc5f4 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -148,6 +148,7 @@ INSTALLED_APPS = (
     'django.contrib.contenttypes',
     'django.contrib.sessions',
     'django.contrib.sites',
+    'django.contrib.sitemaps',
     'django.contrib.messages',
     'django.contrib.staticfiles',
     'django.contrib.admin',
diff --git a/layerindex/sitemaps.py b/layerindex/sitemaps.py
new file mode 100644
index 0000000..7d6e0ac
--- /dev/null
+++ b/layerindex/sitemaps.py
@@ -0,0 +1,36 @@
+# layerindex-web - sitemap definitions
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from django.contrib.sitemaps import Sitemap
+from django.urls import reverse
+
+from layerindex.models import LayerItem
+
+BRANCH_VIEWS = ('layer_list', 'recipe_search', 'machine_search', 'distro_search', 'class_search')
+
+
+class StaticViewSitemap(Sitemap):
+    changefreq = 'daily'
+    priority = 0.5
+
+    def items(self):
+        return list(BRANCH_VIEWS) + ['about', 'stats']
+
+    def location(self, item):
+        if item in BRANCH_VIEWS:
+            return reverse(item, args=('master',))
+        return reverse(item)
+
+
+class LayerSitemap(Sitemap):
+    changefreq = 'weekly'
+    priority = 0.8
+
+    def items(self):
+        return LayerItem.objects.filter(status='P', comparison=False).order_by('name')
+
+    def lastmod(self, obj):
+        return obj.updated
diff --git a/settings.py b/settings.py
index 94b3dd1..b318687 100644
--- a/settings.py
+++ b/settings.py
@@ -148,6 +148,7 @@ INSTALLED_APPS = (
     'django.contrib.contenttypes',
     'django.contrib.sessions',
     'django.contrib.sites',
+    'django.contrib.sitemaps',
     'django.contrib.messages',
     'django.contrib.staticfiles',
     'django.contrib.admin',
diff --git a/tests/test_sitemap.py b/tests/test_sitemap.py
new file mode 100644
index 0000000..12b4b87
--- /dev/null
+++ b/tests/test_sitemap.py
@@ -0,0 +1,38 @@
+# layerindex-web - tests for sitemap.xml
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import LayerItem
+
+
+@pytest.mark.django_db
+class TestSitemap(TestCase):
+
+    def _layer(self, name, status='P', comparison=False):
+        return LayerItem.objects.create(
+            name=name,
+            status=status,
+            layer_type='A',
+            summary=name,
+            description=name,
+            vcs_url='git://example.com/%s.git' % name,
+            comparison=comparison,
+        )
+
+    def test_sitemap(self):
+        self._layer('meta-published')
+        self._layer('meta-new', status='N')
+        self._layer('meta-compare', comparison=True)
+
+        response = self.client.get('/sitemap.xml')
+        self.assertEqual(response.status_code, 200)
+        content = response.content.decode()
+        self.assertIn('/layerindex/branch/master/layer/meta-published/', content)
+        self.assertIn('/layerindex/about/', content)
+        self.assertNotIn('meta-new', content)
+        self.assertNotIn('meta-compare', content)
diff --git a/urls.py b/urls.py
index 295fc0b..4bd5998 100644
--- a/urls.py
+++ b/urls.py
@@ -12,13 +12,22 @@ from django.views.generic import RedirectView, TemplateView
 from layerindex.auth_views import CaptchaRegistrationView, CaptchaPasswordResetView, delete_account_view, \
     PasswordResetSecurityQuestions
 from django.contrib import admin
+from django.contrib.sitemaps.views import sitemap
+from layerindex.sitemaps import StaticViewSitemap, LayerSitemap
 admin.autodiscover()
 
 from django.conf import settings
 
+sitemaps = {
+    'static': StaticViewSitemap,
+    'layers': LayerSitemap,
+}
+
 urlpatterns = [
     re_path(r'^layerindex/', include('layerindex.urls')),
     re_path(r'^admin/', admin.site.urls),
+    re_path(r'^sitemap\.xml$', sitemap, {'sitemaps': sitemaps},
+        name='django.contrib.sitemaps.views.sitemap'),
     re_path(r'^accounts/password_reset/$',
         CaptchaPasswordResetView.as_view(
             email_template_name='registration/password_reset_email.txt',
-- 
2.56.0


