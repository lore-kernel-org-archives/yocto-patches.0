Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD5CCA476
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 18:44:42 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.1415.1760121881041920506
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Oct 2025 11:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=R5UEDK6s;
 spf=pass (domain: qbee.io, ip: 209.85.167.50, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-586883eb9fbso3210696e87.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Oct 2025 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1760121879; x=1760726679; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMD9glwYNsJekLbCr05I5OXa5hoVzjBSzab4TnJk8J4=;
        b=R5UEDK6syhynnECYe/OXoLGJx6xswWI89w1980/y8WydiO6pLyuymundM3L3bM+2hV
         CnNJm2b2YJWbPYdgOw8WwzpRMrv37On+LBZO8OHTaVwgF2/HxgfPwU7az+HgDVXING9D
         QbZd0PKSRBck/5B8VRhjPWMX2C78Rq2sRJBw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121879; x=1760726679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMD9glwYNsJekLbCr05I5OXa5hoVzjBSzab4TnJk8J4=;
        b=QdBvKyegQfYfkDB+oOUtcDMHImm3fOqXRLDtontVNcbdWm+YOfAV+EproJqMUQPa1o
         HIWXfJAe1wZ3ZbyZsVdMKqhXynMy9P/o6sVchDbBy3KEFm06lFH37qTKmd89lkCekwu3
         WvPzxjt6Fjk3kEzHCMWfaRLUWGmhZSwp8WcSCqxwWuW7EyByDH184VhZ7zFECxuy9myW
         OcjQ4Am9dHE3j6l6mKbc1fHWI++1m7jRUBqyKa8j8ha19wT+KO+ATBsLIL7HdX0o1GRM
         9MIkLfCIn4rAnB1bLlEHAOLeCR7hN6qMyeNwAV11m7CRQ63jrBe0PE8VmLSuSqL37UoF
         cmbA==
X-Gm-Message-State: AOJu0YwZOArfvtQoQxFm0Fh0hh067QVwVD6D1p7fMqE3WujpFd1G96+H
	jjegs0onZkFOmgEOYdhfHv04/i7/TgHWZZQbWwdyGCzA3S2Oe5SkUeZPclOdd/Md3q3y3uZNrOb
	fUy2cq9k=
X-Gm-Gg: ASbGncvlWUHDvTY9YSyzGixbbhjn9YWp0VFu+gRAri63DMueOTZ1vLz9fq0Cuyqi5np
	RYiz63SfvIuYMkMargfy2UsoUHOfJjWEC6Qvx1S6UNs5rFgPDLt15br190SK7mY+v4UNjbya0EE
	1nI8Uwdf7dNOVSa22Ls/F072Qsx/Bqfi1yn0yPD8bxY9O7BpwDvTIJ0SkcVicUUna+jkynF9tWm
	p/fwVtpZXwqJy+Nj6dYJg4ShPSv5n38kVMBURPBDd4uDtVWDZ6OsQSIcN60Bd2jeE4ORhSZZ4+h
	MKOxQbPes3O8uiM1SpTK7lRsQepaZ7s6OtakQBHJgCwaiBbu3O2cNgKZ+mCpfb5Fp/LwT0YPQsU
	8Q81oorDDsa29zPXWtG1GDQsw12uXRU6PVZ+70zXlAApf7nLZx+aojdrKO2Ca22aqYIU/OXo=
X-Google-Smtp-Source: AGHT+IFU+9J40+DPlpR3Q6G0gn4xwp1jDwJ6r6ZLcwqGw15EKY/JTJ4ClPWg6T5VKMEeHI1oo4UOQw==
X-Received: by 2002:a05:6512:398c:b0:57e:4998:95ce with SMTP id 2adb3069b0e04-5906d8ed6famr3150661e87.35.1760121878419;
        Fri, 10 Oct 2025 11:44:38 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59088579de8sm1105114e87.115.2025.10.10.11.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:44:38 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Set default settings module and import from django.conf
Date: Fri, 10 Oct 2025 20:44:35 +0200
Message-ID: <20251010184435.68264-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Oct 2025 18:44:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2287

- Replace `os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'` with
  `os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")`
  to avoid overwriting an existing settings module if already defined.
- Change `import settings` to `from django.conf import settings`
  for proper use of Django’s settings registry

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/recipedesc.py          | 2 +-
 layerindex/tools/import_layers.py | 2 +-
 layerindex/utils.py               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/layerindex/recipedesc.py b/layerindex/recipedesc.py
index 33aef31..8cbdcf0 100644
--- a/layerindex/recipedesc.py
+++ b/layerindex/recipedesc.py
@@ -31,7 +31,7 @@ def main():
     # Get access to our Django model
     newpath = os.path.abspath(os.path.dirname(os.path.abspath(sys.argv[0])) + '/..')
     sys.path.append(newpath)
-    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
+    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
 
     from django.core.management import setup_environ
     from django.conf import settings
diff --git a/layerindex/tools/import_layers.py b/layerindex/tools/import_layers.py
index 57b0f86..9696362 100755
--- a/layerindex/tools/import_layers.py
+++ b/layerindex/tools/import_layers.py
@@ -61,7 +61,7 @@ def main():
         loglevel = logging.INFO
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import Branch, LayerItem, LayerBranch, LayerDependency, LayerMaintainer, LayerNote, Recipe, Source, Patch, PackageConfig, StaticBuildDep, DynamicBuildDep, RecipeFileDependency, Machine, Distro, BBClass, BBAppend, IncFile
     from django.db import transaction
 
diff --git a/layerindex/utils.py b/layerindex/utils.py
index 8bbd621..66e4994 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -400,7 +400,7 @@ def setup_django():
     # Get access to our Django model
     newpath = os.path.abspath(os.path.dirname(__file__) + '/..')
     sys.path.append(newpath)
-    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
+    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
     django.setup()
 
 def logger_create(name):

