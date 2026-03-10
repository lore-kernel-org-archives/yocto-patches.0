Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD07FD4F1A
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 18:34:42 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2465.1773167678296327943
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 11:34:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K8mXDvqU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.42, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1273de95aso7862852e87.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 11:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773167676; cv=none;
        d=google.com; s=arc-20240605;
        b=hgWEkIyFPJ4hyvLznud+H4xwvaalxSN/mzBgqudCcjY10kdiEW4Itq0AasQmy5GV3C
         fFTkDLLIH+expnkEoukBzOVTu4cBuRcbaxFusisQDabdad/eO7BACdj/rHMdbdD/uWmf
         tx5cjc85sRaVFcRF2LStV9yObS37cHqIg3uKYcrdo1AzdFE8sZYa7MRuowoFlkeWreHh
         mW9iGLCRiGq2Kvsya99NoAoAzzjwlZ4KWCrN8Q4O9rZaZgZ5Vl1R9axi+ho5TIYVWpNX
         8A4pWC5PwlY1pYl/g3VUU3R9r0x59FJdvrsLhQLOLnirJjZBmYcY9S8CMmPn76ITVbOF
         Ea9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KmjJLCkXk+4o6uE0CJpCM3MZD5fkSsowQerBmcOC2/U=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=SY8swPwhMJ7Lz+LZuNabGTKBxDTTaClBoTiOZlOMZI8YB2Jm3TevJJnR0ldBpqilzc
         z980E2s4ewjhoZbkVbbWIjAazvLpGQPkLZKNk0kwX9beOxUxxLIGSiSiNxwr2uu0kWts
         hIrT1QA0Dd58pFPiCTbjrnM0TG9WBdR/+pgHkQk7o3xO+Chh4Aoj7HFwjDGNRAHzzoju
         DHYFPl4k0FvIF9dcpD3PO2t2Zj2VR6c8iJfzc0L7cr2nxqzYHCKh7ypQdudJDmD4N5br
         el1OWuiJssVV8F3TiF0PQ6bNv2sAOGRDrE0GEWKc4lat0Iid59JfABOfXsPhQdM5vwKu
         D82A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773167676; x=1773772476; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmjJLCkXk+4o6uE0CJpCM3MZD5fkSsowQerBmcOC2/U=;
        b=K8mXDvqU0BKxdZahr8jy1nmWVW/0lKE/Dx1cUllbq8BiQeZSR+pY4rYixL16j1/tlv
         2X5JqrboG7E66ZE8JmTZ4ULYT1Vrz9SIQERcAn749aSeZTKjxfihJTp6NpGd6bRYPzpc
         O/7DDkMFMayDi4CHDt2DzVOIcRpUNnx37kuZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167676; x=1773772476;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmjJLCkXk+4o6uE0CJpCM3MZD5fkSsowQerBmcOC2/U=;
        b=TKt4xGaDCfvYlTMvLQQJiCBQ7OKOE+0Kuqjzj9VinPEUlgDEJsS3VZpqdeSXcLKfaG
         xSVdp4vGEzEliwUCKi4I2kDRQZaAk/gd5JQK1l5qmY+KdCAUw5MGS//Dqg6fxEY2ikou
         rA5tvwBr1pSwPHJMXLPH8aPY8PVNm1GfzXY5rX6MKGxdtDEexgFhHswlWr10MIvroR6G
         WcuROGHwnMOLHvqDbUSVFPvb/Of8TT/Wi/Kg7VZ4IZcinTPEi98tvezUrqP+s61PcgB6
         hB0lIBNx9FdFaLcPupW1OhFEQV4gC3z1VDMbRpc5XR/3Kb91RAT95/CwZD8YE7MNO52V
         Ss9g==
X-Gm-Message-State: AOJu0YyPshP2bUZ7B5LhIEd1zJKVnOwxbhJ1++K3WOTKMgsrwK+X8yTI
	vLvM7lZ0YJeEs4jKrYqhLMw35LRJBDc2rkDSzH4EZ73DEZyjzxmt7v807DuM27SuIOi+wIUav7L
	41gLgndoa81vmGXycbQFp7vuZC1jDQGYB7Ud1KcQTR2AKM0yZIHaSGJJl0g==
X-Gm-Gg: ATEYQzzbQXt8r2o0quYRanYRa/khYiHxXyJJBV+Ugg+eG4VV1J1/WZs7CsAD+5KTCi2
	sacuuMreJ1wFoIpkSLWDEVR+lLBpMwV2MsYFxe2yqtJJeLwpg+1r6RNPEROOb8IkKubMNl5dlic
	vrokn0z3/oR6acw1eYiMyKwHDdV+s8TGgJjkxZ2KZ0NUMVADfAnp5B5Wh0zFqHii/w/n/2l2VMm
	PinwggHvEHiPNaI7zCxsK5QSO8EqdXoKhf2/slQ0UnrBCaso0RvGalhBySh1fPqMaJtxLfiL478
	EAoInMufWVAc3IwOniGtE5YRwMBe0Qk=
X-Received: by 2002:a05:6512:39cb:b0:5a1:3d21:7b55 with SMTP id
 2adb3069b0e04-5a13d217d7cmr5424458e87.43.1773167675361; Tue, 10 Mar 2026
 11:34:35 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Tue, 10 Mar 2026 11:34:23 -0700
X-Gm-Features: AaiRm50BYH_mpawUgaKKbF02ufcH3bhV2hVMp2RopykKs6YiXTOTtmdwZ6I2-IE
Message-ID: <CADfgfoawtdjc3=oMd6TBY88MdgNBtBD_qijtK5uT1U2gO0_zwA@mail.gmail.com>
Subject: [PATCH error-report-web] models: Add index to avoid denial of service
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 18:34:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3397

models: Add index to avoid denial of service

Requests for /Errors/SimilarTo/ can cause a denial of service since it
runs unindexed queries.

1000 UTF-8 characters is too long to index properly. In a decade of
production use, our max task length is under 700 characters. Reduce the
field to an indexable size and add the needed index.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 ...dfailure_task_buildfailure_idx_task_lev.py | 20 +++++++++++++++++++
 Post/models.py                                |  7 ++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644
Post/migrations/0008_alter_buildfailure_task_buildfailure_idx_task_lev.py

diff --git a/Post/migrations/0008_alter_buildfailure_task_buildfailure_idx_task_lev.py
b/Post/migrations/0008_alter_buildfailure_task_buildfailure_idx_task_lev.py
new file mode 100644
index 0000000..9bb1f2a
--- /dev/null
+++ b/Post/migrations/0008_alter_buildfailure_task_buildfailure_idx_task_lev.py
@@ -0,0 +1,20 @@
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('Post', '0007_alter_build_date_alter_build_error_type_and_more'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='buildfailure',
+            name='TASK',
+            field=models.CharField(max_length=750),
+        ),
+        migrations.AddIndex(
+            model_name='buildfailure',
+            index=models.Index(fields=['TASK', 'LEV_DISTANCE'],
name='idx_task_lev'),
+        ),
+    ]
diff --git a/Post/models.py b/Post/models.py
index bb05d61..f7c0916 100644
--- a/Post/models.py
+++ b/Post/models.py
@@ -57,7 +57,7 @@ class Build(models.Model):
         super(Build, self).save(*args, **kwargs)

 class BuildFailure(models.Model):
-    TASK = models.CharField(max_length=1024)
+    TASK = models.CharField(max_length=750)
     RECIPE= models.CharField(max_length=250)
     RECIPE_VERSION = models.CharField(max_length=200)
     ERROR_DETAILS = models.TextField(max_length=int(settings.MAX_UPLOAD_SIZE))
@@ -74,6 +74,11 @@ class BuildFailure(models.Model):
             default = 'NOT_VISITED'
     )

+    class Meta:
+        indexes = [
+            models.Index(fields=['TASK', 'LEV_DISTANCE'], name='idx_task_lev'),
+        ]
+
     def get_similar_fails(self):
         if self.LEV_DISTANCE is None:
             return BuildFailure.objects.none()
-- 
2.53.0

-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

