Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CF107BCE1
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 19:31:31 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24309.1773430286469156127
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 12:31:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DQ8Ru4qh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.54, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59de8155501so2551656e87.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 12:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773430284; cv=none;
        d=google.com; s=arc-20240605;
        b=c+CIhaHGjnDTqSuN3IX3lcJ+mwULhEWc1cIAX+12fliTEuWHSn8A37NGnmquowUUXi
         5Y/05hS5QCGyC3A8l89LtBrOf7ELJBitMG+mexXss8V3sp+QxUx+GywrkRFUOi46NyaL
         loHLW5uccbH1vaO2Yd6A3aVUOl9uhZb0cWrqdyc6ipCqj8pkzkL1nl13uRxslByIvKhx
         08RB7/vCJjpRZ43o6OcZttuO5Noqdpg1bm75BuyJGahH373VvfMdYUYXKf1+Qwdo23yO
         goJ3kkm/EhXAXKpkeyZI6FCFmZOV59RZZ3bhsbUEd0tVXoj4l8RVuIO/seWOzAjn3TLx
         VcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZN9yCTypWqkGsl+ajZ6EtzXlHhWde4y3jU3etkFNN/o=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=TK+1FYjLRxtRLgEyiuf+xelA4Vy4NQ2WlgtJnupek0XoyRE07QAQbZxPbQ89ZWY2PZ
         gfLBZ4DLtKPCsJHetVg8bfiKa27Jl+bRg1g0JEaZBKo4WkMZom4x1LvYObFfsVDktpK0
         D+Ws/EzgttKpghZ7IR6zQNzeHJSq2zK9YTbRNhZtU+AntP6qdYVoiKlqR2iEGCgtG1hM
         l8LwsVpsQhp4EHbfAJhieGBWSlQ5a0Vdjkt6Bly0xFeIK+Gmdjak5J03gpcJ+kJNMUXY
         M6yBobFdiq6VbEs40nEvFDyp/gE67AnQbvYEHlUkHs7HbjHx9GMFUTBfYFraIXXKlsE0
         zLgA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773430284; x=1774035084; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZN9yCTypWqkGsl+ajZ6EtzXlHhWde4y3jU3etkFNN/o=;
        b=DQ8Ru4qhxY1f+LiBiEEZG3V3jS7ZCPSicK++ZLWTMX1mxYZPqvDU55moM+h6EpWTum
         T9pKkRACniUyqphbkEWvyMUM9HbTuj6b6gLQEU7MxUzB/Sowas5q8/ksJx+imRYhkf3A
         UvFZyQrIrct4FID8I4Foperhk67MeIhaLb0U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430284; x=1774035084;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN9yCTypWqkGsl+ajZ6EtzXlHhWde4y3jU3etkFNN/o=;
        b=TvkdELownEoo/Pbxu8GcYrQkRp0UsBNChuaUwDGyQ6IvmfuZCdQW98yDoZhxKSn0bC
         9HZFDG4hrpCjRjNvcnNvJkYAEYPYNV3CeoPW4LqOmsx8Z0iQthqxXlVCno7eABwzXaIL
         vvD73gZJM7yo3fKy/NJg9N3B/tahfUPeU9OCDkQ2fQ4Y2g7qNX7lKBg32reJIE9m0lkf
         L+XcBYZ0olxAhpSJg/OWNFHTlC74s08c47I2f2p/mQX+LfX8i9zIuagNq8ob2s8DwE59
         sx7UWhyPSMuoxtG3CXS6oeA06BeTBhyzyOTq5Y+JdA+TRIZVTeRD2Engqgv9BdYtq8h+
         6FlQ==
X-Gm-Message-State: AOJu0YyRl6PlWt5tV3/8TVF5GdKZavM1jNp6Sl5aWegR96bE1n1Rjz7w
	hnp/zzvzmEVrmsyrzxujNjMnA6IlyHZ7LcXgUiXLcH0kIauGvqI1zttE0vMTDQerysZGe5jEQqX
	JUkuwgDQJkf2caDpDFTdhFetRnK5K10ZBJq+2EauIV0jPv57okZYNN4qnAQ==
X-Gm-Gg: ATEYQzyT3xML2xoeU6Scwki1O+kAIeTEdS582xzfpXQRDvARBSKyWp9FQwOlJ/wtGan
	tBHMHX+mewlzJVasvtOA5kEgWrmK5UdB5rIDMgoaXQVXWEVOW6xqDlmPH8MV7HW8g34+a2tqFn+
	KNPZxKsNZCxaqhX7jKhG+JF6IF0LrFGHjxqRZb7m5/AmgMjTZ55P1drYlnyUoqepek2+unf3hXM
	mxyRok1m0+LYRUoM9LCRdvpabbAvtm+e6l5yPU83Bf4YpN86ZfBNqbxb3y/eJqTJtUhHLgpfsuR
	hbIX/w==
X-Received: by 2002:a05:6512:1451:20b0:5a1:18bf:6b2 with SMTP id
 2adb3069b0e04-5a1626f89aamr1225022e87.1.1773430283543; Fri, 13 Mar 2026
 12:31:23 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 13 Mar 2026 12:31:12 -0700
X-Gm-Features: AaiRm50Va1LAXFL8JeG4ddEg_lsuz24IF6DK66po62ogF-_hzk3v44DCysFY8p4
Message-ID: <CADfgfoYUnOP8ganW97W=D52GuSLuU7APMLY6RTxPO9Am=S03yw@mail.gmail.com>
Subject: [PATCH error-report-web] models: index date to speed up pagination
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 19:31:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3459

models: index date to speed up pagination

With large datasets running full table scans when pagenating or
generating charts are unacceptably long. This index helps a great deal.
Ideally the pagenation code would be changed to avoid needing table
scans entirely but the index solves the issue for now.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 Post/migrations/0009_build_idx_date.py | 17 +++++++++++++++++
 Post/models.py                         |  5 +++++
 2 files changed, 22 insertions(+)
 create mode 100644 Post/migrations/0009_build_idx_date.py

diff --git a/Post/migrations/0009_build_idx_date.py
b/Post/migrations/0009_build_idx_date.py
new file mode 100644
index 0000000..26de512
--- /dev/null
+++ b/Post/migrations/0009_build_idx_date.py
@@ -0,0 +1,17 @@
+# Generated by Django 4.2.29 on 2026-03-13 19:16
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('Post', '0008_alter_buildfailure_task_buildfailure_idx_task_lev'),
+    ]
+
+    operations = [
+        migrations.AddIndex(
+            model_name='build',
+            index=models.Index(fields=['DATE'], name='idx_date'),
+        ),
+    ]
diff --git a/Post/models.py b/Post/models.py
index f7c0916..541f394 100644
--- a/Post/models.py
+++ b/Post/models.py
@@ -48,6 +48,11 @@ class Build(models.Model):
     ERROR_TYPE = models.CharField(max_length=20, choices=ERROR_TYPE_CHOICES,
                                   default=ErrorType.RECIPE)

+    class Meta:
+        indexes = [
+            models.Index(fields=['DATE'], name='idx_date'),
+        ]
+
     def save(self, *args, **kwargs):
         if self.ERROR_TYPE not in [e_type[0] for e_type in
                                    self.ERROR_TYPE_CHOICES]:
-- 
2.53.0

-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

