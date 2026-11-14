Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6852.1794639680813944452
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 23:01:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ECTixZRv;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso834937a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794639680; x=1795244480; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l9KHDyL3kdv+0p1Xqt50ILG5jb2It7irdU8YMdn7tTk=;
        b=ECTixZRv4DB34YkIKSpeu5iyV+VvoRhvH61lKlMhLQGEvJv7QCRZQbvG13tX6sOjVP
         uxFfgOB85++CXgSJiFpPmoVRjctAlWsze3DTKG+7D1l2Aei8tjtaGm+kBec/JvX9BMt8
         DE+cGRYZo6eBKJXQrh+ljOhZie7F/xgKUgEkBx2gRAoM6gKIrV5afpYZpXaNyZHVpU0+
         NbuBJz/uG6CCZldgJvpzmTJLmoiRXF32/Egv4yzu62Kztog9JoLskcnc6hDsWgegIHZ6
         Mwk1pp3+LmHJgwY+bK/jmuWFo/E0ZXhNLWKX3CkmNbrTvwP6/SJKTI/QDhM1RXtLArT5
         qBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794639680; x=1795244480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l9KHDyL3kdv+0p1Xqt50ILG5jb2It7irdU8YMdn7tTk=;
        b=x7bLquV+v0tFLCc5ntoP689ri/FWPWDwQoOEGtOn81L+PMQIVPENJIZDNDBkseGvzk
         lT1peH6mbIPOmF95S9I96zN4H5H6RheHShfNgll9zthJSAm5rSY8JTa6VjH/I/UUxiOg
         jHu/EjBbGme29DXEwVu9JQAJ1mJf/qAEYnkFhWQwX04APZD1Hm5nibbmcnL7iEIwYwoJ
         mvLJKSdLdTcKVXC+yeeTCzvWjGSq4ZVQO/OdfvobFw4jE7AxcTPntlkkBpUlj9mVtm5A
         sN/r/qGrGstm2dsftDgaQWmIKDBNeohIfpArB7+WTBG8Kk7qtPPb+9j5f69Y8LmGjm0H
         jdLQ==
X-Gm-Message-State: APuU4Z8qWshERUSc4ZfsLEUIhJYW4CaRtWhYMUHKGwbQ8vVo/7Omo2SK
	ORAEktYac0fAfC5bHmTcaYX1yzL9y804dmYYK+eRgCISfK0NpSahg8M/tfy0/8wu
X-Gm-Gg: AYBFou1v+VY6gJZRxxLSwh1MOYpFjzXL0fIr72Q7eFCbEh5IV3XdRtaZAqpfmifhqw9
	jH0IlMkb9BGcoEPUG36I7wOP8lfR7IQAm1f4pQpg8pS+ezakyNVYWGYV8X6dJePna8Wd7yP87Dr
	IGxjI/JlQci/VW2SLdfaKYBCQaMvGPuPxrVh33u0b9lli7D97T7Mlyj4h1s9S8zfTNqmDDCOrmP
	GOrz+itwbJJQXfPQ45Wor9Cy2B/H34m3cVy9UnVIWvaMXCy0zlpkg2t4fwpOgTqAt7UCbZaTBOY
	1v7bnRNEI3UbxYIX2nKYVL5e6Z2c8UU+15YuA5RQ2eDzF7QxxBV1HmGYirRd+GA2wj92Y/b7LrB
	OZWLkxQyChjbVvpGpftVs97Decv8aiaQrByr2MvsfE7PWCz5fjPuargjMdIG9StHqZdFxQoAl/g
	eXz5lBUo3oelnkY4ag5xsX+p0oLnA9G2uxHTsI8HeraXsBFi+Ji3vSukEAyKEAdHEODExFuE7Ir
	aOjQjIoZ0FY1pTJXPe4q2Fv8AychHP6TfI2fewRlBdV7njnD8Uvdv2cf8BTgQMWrPhUHseq/3KK
	sjo4Dy4tTZvUhxubMeeCBKZGSNGN0b5fn8gYbOTDqAuzWTxDoay8Id3C5oSeSw==
X-Received: by 2002:a17:90b:1807:b0:3aa:fdad:7d6c with SMTP id 98e67ed59e1d1-3b1b0ca59a4mr4717362a91.58.1794639680015;
        Fri, 13 Nov 2026 23:01:20 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc188ff97sm2226841a12.16.2026.11.13.23.01.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 23:01:19 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: use https for URLs entered without a scheme
Date: Fri, 13 Nov 2026 23:01:15 -0800
Message-ID: <20261114070115.28388-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 07:01:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5375
Content-Type: text/plain; charset="utf-8"

Django 5.2 warns that the URL form fields will assume https instead of
http for a URL entered without a scheme from Django 6.0. Say which one
the layer, bulk change and layer admin forms mean, choosing https as
Django 6.0 will, so that the behaviour doesn't change silently when
upgrading and the warning goes away.

[YOCTO #16498]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
With this, the test suite runs without any warnings. The
FORMS_URLFIELD_ASSUME_HTTPS setting is not used because it is itself
deprecated and removed in Django 6.0. Applies to master and to
master-next.

 layerindex/admin.py      |  2 +-
 layerindex/forms.py      | 11 +++++++++++
 tests/test_url_fields.py | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_url_fields.py

diff --git a/layerindex/admin.py b/layerindex/admin.py
index f8b2f6e..61ac3e7 100644
--- a/layerindex/admin.py
+++ b/layerindex/admin.py
@@ -55,7 +55,7 @@ class LayerItemAdmin(CompareVersionAdmin):
     save_as = True
     search_fields = ['name', 'summary', 'vcs_url']
     formfield_overrides = {
-        models.URLField: {'widget': TextInput(attrs={'size':'100'})},
+        models.URLField: {'widget': TextInput(attrs={'size':'100'}), 'assume_scheme': 'https'},
         models.CharField: {'widget': TextInput(attrs={'size':'100'})},
     }
 
diff --git a/layerindex/forms.py b/layerindex/forms.py
index 733adc2..bd857ff 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -11,6 +11,7 @@ from collections import OrderedDict
 
 from captcha.fields import CaptchaField
 from django import forms
+from django.db import models
 from django.contrib.auth.models import User
 from django.core.cache import cache
 from django.core.validators import EmailValidator, RegexValidator, URLValidator
@@ -35,6 +36,14 @@ class StyledForm(forms.Form):
         for visible in self.visible_fields():
             visible.field.widget.attrs['class'] = 'form-control'
 
+def https_url_formfield(field, **kwargs):
+    """Model form field callback: treat a URL entered without a scheme as
+    https, as Django 6.0 will by default, rather than http"""
+    if isinstance(field, models.URLField):
+        kwargs.setdefault('assume_scheme', 'https')
+    return field.formfield(**kwargs)
+
+
 class StyledModelForm(forms.ModelForm):
     # Ensure form-control class for Bootstrap 3 is applied to Django-generated widgets
     def __init__(self, *args, **kwargs):
@@ -85,6 +94,7 @@ class EditLayerForm(StyledModelForm):
     class Meta:
         model = LayerItem
         fields = ('name', 'layer_type', 'summary', 'description', 'vcs_url', 'vcs_web_url', 'vcs_web_tree_base_url', 'vcs_web_file_base_url', 'vcs_web_commit_url', 'usage_url', 'mailing_list_url')
+        formfield_callback = https_url_formfield
 
     def __init__(self, user, layerbranch, allow_base_type, *args, **kwargs):
         super(self.__class__, self).__init__(*args, **kwargs)
@@ -332,6 +342,7 @@ class BulkChangeEditForm(StyledModelForm):
     class Meta:
         model = RecipeChange
         fields = ('summary', 'description', 'homepage', 'bugtracker', 'section', 'license')
+        formfield_callback = https_url_formfield
 
 BulkChangeEditFormSet = modelformset_factory(RecipeChange, form=BulkChangeEditForm, extra=0)
 
diff --git a/tests/test_url_fields.py b/tests/test_url_fields.py
new file mode 100644
index 0000000..443cb6c
--- /dev/null
+++ b/tests/test_url_fields.py
@@ -0,0 +1,36 @@
+# layerindex-web - URL form fields use https for a URL entered without a scheme
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import importlib
+import warnings
+
+from django import forms
+from django.contrib import admin
+from django.utils.deprecation import RemovedInDjango60Warning
+
+import layerindex.forms
+from layerindex.models import LayerItem
+
+
+def test_url_form_fields_assume_https(rf, admin_user):
+    # [YOCTO #16498] create the form classes again, to see any warning
+    with warnings.catch_warnings():
+        warnings.simplefilter('error', RemovedInDjango60Warning)
+        mod = importlib.reload(layerindex.forms)
+        request = rf.get('/')
+        request.user = admin_user
+        admin_form = admin.site._registry[LayerItem].get_form(request)
+
+    url_fields = [
+        mod.EditLayerForm.base_fields['vcs_web_url'],
+        mod.EditLayerForm.base_fields['mailing_list_url'],
+        mod.BulkChangeEditForm.base_fields['homepage'],
+        mod.BulkChangeEditForm.base_fields['bugtracker'],
+        admin_form.base_fields['vcs_web_url'],
+    ]
+    for field in url_fields:
+        assert isinstance(field, forms.URLField)
+        assert field.clean('github.com/example/meta-example') == 'https://github.com/example/meta-example'

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

