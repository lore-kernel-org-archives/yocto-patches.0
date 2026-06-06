Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A0ECD8C93
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 19:55:10 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21921.1780775701201488359
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Jun 2026 12:55:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HLe806Gc;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1186172a12.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780775700; x=1781380500; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzfMX6Pjy1DT49TWaYR2ywXsvFRdVHg0TcdXy1vSh2k=;
        b=HLe806Gc62ib9MTKvmLkPzgdzSXfIUb7xD6w/rThXIiP/YO9hjX5yjwhQbzEYmgGAQ
         4SzYBH0I9KWt8W2A1PozZhLmVRgGtRQo4E74UouUhn5e6Pz2uc2SlLWnMY2316vrfWGV
         nZ/XdmUStdRvv7a8msx+GVtLBSBDotnqHWta/awYIxv20UX5b1BwTRpII3tXFI8/L6eB
         6JfNu0jMxs2Isdiu8RQD/HttAKVWt1enhNmGfZ6a/Sem6v/u2UJEYYl1Zdl0i/Y3dgog
         mqAK61WHeNaIPldWb5TYPx4lK/rRx79UZmDTn6ANY0vdR5Tc7vkHxildimR1wCfU2UQZ
         3qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780775700; x=1781380500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzfMX6Pjy1DT49TWaYR2ywXsvFRdVHg0TcdXy1vSh2k=;
        b=p4+xS2DOStt+BmqiqxIsIqwd8z66VyVShWUDtV1e9ySwdsKv6jWNp5t7RSb937F1Q0
         QMcsmTPr4Q3f5+Yd2oKkU6HqYiJEwof49yWcDH7mi3xt1ALR6RLL7fhzjogCPhHaIzOQ
         IcyqrsuCAfHvRg7S0Dia3jqcLZJRTUpYzRoeDX8XQjbDSDlwcaQMzEKECnRaIyZKM6wR
         p+fo0IG+r+PF1p2fXT+ZnCFDlFbLJbsXAqiwC/SEvmHBl5FSIwA47l3q5FIC/ya6oNet
         Ovh5i7GbtVLqipNYKJWfQOhnD5+1wYz5fkNdVUQuuEI4FjCr275sn3wSBpaNdI2vCrBS
         6upg==
X-Gm-Message-State: AOJu0YzT0bSn1wk9YTSXbSi/TL3fEvyAxkPHo0G8zklO/ZM4JboQw2fl
	U5TnU1FUtd7VTp1sQk1i/mgiYzkZPhRUW5cF9y6xJEOK+k1E+GmF/5TJchihLQ==
X-Gm-Gg: Acq92OFtzEaE3mVXIapgcsEXP8t3rpthTyw1Q2lZ1s17GpHix4YFFxzbfGqzIfTLTwG
	rV+Y277EF9SodEOjo49a8jSHz9/+LiTOSqOODFibDh0QFYnUtkjU8x07DvQeKEmMW715QJ89k19
	irJ20xZ1dqJUiPnwAxRJb2WaM40exLEvOg7p3wq3bNcYPkbdAOs0kJRpOrCxQ9lsfOVPqiVSyET
	lfnTnfgH5cZ0MXZd4NymlEiSwQuhDgKCy4sx4ltrP7e2qguB5vfKs5wIwG6N0xHwTh5DPBzYF1D
	WAtWSPer2OiIQQowC/TXLZIRYCDepiarDGyUR3H6ZbVJeiUUD1uBIXX/xLOYtMmuGlw4Icbinmz
	fFixzcNaoDEZ6gT3wU3SyO5wGP0+RzSm1SyELNicqmXwANti9LET3DMOgyW380FWVACqu2OHHjL
	nydelR28KDhzDuIhY979dl/K1tM/KHaR6uoL8EM1diMggZOgsAMtIaqorf+7YJfg+OzMu+FTYo2
	3uQZXKce3YaFziCU5zMSBv9sZirXk3OAA==
X-Received: by 2002:a05:6a20:e390:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3b4ccd60984mr11621423637.16.1780775700093;
        Sat, 06 Jun 2026 12:55:00 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04311bsm10943179a12.9.2026.06.06.12.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 12:54:59 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] Update git.openembedded.org URLs
Date: Sat,  6 Jun 2026 12:54:48 -0700
Message-ID: <20260606195450.59191-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 19:55:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4166

The old cgit.openembedded.org URLs redirect to git.openembedded.
Update all references to use the new URLs and switch from http
to https.

While we are here, use https for github, gitlab and bitbucket,
as http:// URLs redirect for all of these providers as well.

Fixes [Yocto #16272]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/models.py                   |  2 ++
 layerindex/tools/import_layer.py       | 32 +++++++++++++-------------
 layerindex/tools/import_wiki_layers.py | 32 +++++++++++++-------------
 templates/layerindex/editlayer.html    | 32 +++++++++++++-------------
 4 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/layerindex/models.py b/layerindex/models.py
index 6e96342..864264b 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -541,6 +541,8 @@ class Source(models.Model):
             return self.url
         elif self.url.startswith('git://github.com'):
             return drop_dotgit('https' + self.url[3:])
+        elif self.url.startswith('git://git.openembedded.org'):
+            return drop_dotgit('https://git.openembedded.org' + self.url[26:])
         elif self.url.startswith('git://git.yoctoproject.org'):
             return drop_dotgit('https://git.yoctoproject.org' + self.url[26:])
         elif self.url.startswith('git://git.kernel.org'):
diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_layer.py
index 4af062e..79c679e 100755
--- a/layerindex/tools/import_layer.py
+++ b/layerindex/tools/import_layer.py
@@ -34,10 +34,10 @@ def set_vcs_fields(layer, repoval):
     layer.vcs_url = repoval
     if repoval.startswith('git://git.openembedded.org/'):
         reponame = re.sub('^.*/', '', repoval)
-        layer.vcs_web_url = 'http://cgit.openembedded.org/' + reponame
-        layer.vcs_web_tree_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-        layer.vcs_web_file_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-        layer.vcs_web_commit_url = 'http://cgit.openembedded.org/' + reponame + '/commit/?id=%hash%'
+        layer.vcs_web_url = 'https://git.openembedded.org/' + reponame
+        layer.vcs_web_tree_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+        layer.vcs_web_file_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+        layer.vcs_web_commit_url = 'https://git.openembedded.org/' + reponame + '/commit/?id=%hash%'
     elif repoval.startswith('git://git.yoctoproject.org/'):
         reponame = re.sub('^.*/', '', repoval)
         layer.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
@@ -47,24 +47,24 @@ def set_vcs_fields(layer, repoval):
     elif repoval.startswith('git://github.com/') or repoval.startswith('http://github.com/') or repoval.startswith('https://github.com/'):
         reponame = re.sub('^.*github.com/', '', repoval)
         reponame = re.sub('.git$', '', reponame)
-        layer.vcs_web_url = 'http://github.com/' + reponame
-        layer.vcs_web_tree_base_url = 'http://github.com/' + reponame + '/tree/%branch%/'
-        layer.vcs_web_file_base_url = 'http://github.com/' + reponame + '/blob/%branch%/'
-        layer.vcs_web_commit_url = 'http://github.com/' + reponame + '/commit/%hash%'
+        layer.vcs_web_url = 'https://github.com/' + reponame
+        layer.vcs_web_tree_base_url = 'https://github.com/' + reponame + '/tree/%branch%/'
+        layer.vcs_web_file_base_url = 'https://github.com/' + reponame + '/blob/%branch%/'
+        layer.vcs_web_commit_url = 'https://github.com/' + reponame + '/commit/%hash%'
     elif repoval.startswith('git://gitlab.com/') or repoval.startswith('http://gitlab.com/') or repoval.startswith('https://gitlab.com/'):
         reponame = re.sub('^.*gitlab.com/', '', repoval)
         reponame = re.sub('.git$', '', reponame)
-        layer.vcs_web_url = 'http://gitlab.com/' + reponame
-        layer.vcs_web_tree_base_url = 'http://gitlab.com/' + reponame + '/tree/%branch%/'
-        layer.vcs_web_file_base_url = 'http://gitlab.com/' + reponame + '/blob/%branch%/'
-        layer.vcs_web_commit_url = 'http://gitlab.com/' + reponame + '/commit/%hash%'
+        layer.vcs_web_url = 'https://gitlab.com/' + reponame
+        layer.vcs_web_tree_base_url = 'https://gitlab.com/' + reponame + '/tree/%branch%/'
+        layer.vcs_web_file_base_url = 'https://gitlab.com/' + reponame + '/blob/%branch%/'
+        layer.vcs_web_commit_url = 'https://gitlab.com/' + reponame + '/commit/%hash%'
     elif repoval.startswith('git://bitbucket.org/') or repoval.startswith('http://bitbucket.org/') or repoval.startswith('https://bitbucket.org/'):
         reponame = re.sub('^.*bitbucket.org/', '', repoval)
         reponame = re.sub('.git$', '', reponame)
-        layer.vcs_web_url = 'http://bitbucket.org/' + reponame
-        layer.vcs_web_tree_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-        layer.vcs_web_file_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-        layer.vcs_web_commit_url = 'http://bitbucket.org/' + reponame + '/commits/%hash%'
+        layer.vcs_web_url = 'https://bitbucket.org/' + reponame
+        layer.vcs_web_tree_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+        layer.vcs_web_file_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+        layer.vcs_web_commit_url = 'https://bitbucket.org/' + reponame + '/commits/%hash%'
 
 
 def readme_extract(readmefn):
diff --git a/layerindex/tools/import_wiki_layers.py b/layerindex/tools/import_wiki_layers.py
index a9508de..061f6df 100755
--- a/layerindex/tools/import_wiki_layers.py
+++ b/layerindex/tools/import_wiki_layers.py
@@ -98,10 +98,10 @@ def main():
                         layer.vcs_url = repoval
                         if repoval.startswith('git://git.openembedded.org/'):
                             reponame = re.sub('^.*/', '', repoval)
-                            layer.vcs_web_url = 'http://cgit.openembedded.org/' + reponame
-                            layer.vcs_web_tree_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-                            layer.vcs_web_file_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-                            layer.vcs_web_commit_url = 'http://cgit.openembedded.org/' + reponame + '/commit/?id=%hash%'
+                            layer.vcs_web_url = 'https://git.openembedded.org/' + reponame
+                            layer.vcs_web_tree_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+                            layer.vcs_web_file_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+                            layer.vcs_web_commit_url = 'https://git.openembedded.org/' + reponame + '/commit/?id=%hash%'
                         elif repoval.startswith('git://git.yoctoproject.org/'):
                             reponame = re.sub('^.*/', '', repoval)
                             layer.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
@@ -111,24 +111,24 @@ def main():
                         elif repoval.startswith('git://github.com/') or repoval.startswith('http://github.com/') or repoval.startswith('https://github.com/'):
                             reponame = re.sub('^.*github.com/', '', repoval)
                             reponame = re.sub('.git$', '', reponame)
-                            layer.vcs_web_url = 'http://github.com/' + reponame
-                            layer.vcs_web_tree_base_url = 'http://github.com/' + reponame + '/tree/%branch%/'
-                            layer.vcs_web_file_base_url = 'http://github.com/' + reponame + '/blob/%branch%/'
-                            layer.vcs_web_commit_url = 'http://github.com/' + reponame + '/commit/%hash%'
+                            layer.vcs_web_url = 'https://github.com/' + reponame
+                            layer.vcs_web_tree_base_url = 'https://github.com/' + reponame + '/tree/%branch%/'
+                            layer.vcs_web_file_base_url = 'https://github.com/' + reponame + '/blob/%branch%/'
+                            layer.vcs_web_commit_url = 'https://github.com/' + reponame + '/commit/%hash%'
                         elif repoval.startswith('git://gitlab.com/') or repoval.startswith('http://gitlab.com/') or repoval.startswith('https://gitlab.com/'):
                             reponame = re.sub('^.*gitlab.com/', '', repoval)
                             reponame = re.sub('.git$', '', reponame)
-                            layer.vcs_web_url = 'http://gitlab.com/' + reponame
-                            layer.vcs_web_tree_base_url = 'http://gitlab.com/' + reponame + '/tree/%branch%/'
-                            layer.vcs_web_file_base_url = 'http://gitlab.com/' + reponame + '/blob/%branch%/'
-                            layer.vcs_web_commit_url = 'http://gitlab.com/' + reponame + '/commit/%hash%'
+                            layer.vcs_web_url = 'https://gitlab.com/' + reponame
+                            layer.vcs_web_tree_base_url = 'https://gitlab.com/' + reponame + '/tree/%branch%/'
+                            layer.vcs_web_file_base_url = 'https://gitlab.com/' + reponame + '/blob/%branch%/'
+                            layer.vcs_web_commit_url = 'https://gitlab.com/' + reponame + '/commit/%hash%'
                         elif repoval.startswith('git://bitbucket.org/') or repoval.startswith('http://bitbucket.org/') or repoval.startswith('https://bitbucket.org/'):
                             reponame = re.sub('^.*bitbucket.org/', '', repoval)
                             reponame = re.sub('.git$', '', reponame)
-                            layer.vcs_web_url = 'http://bitbucket.org/' + reponame
-                            layer.vcs_web_tree_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-                            layer.vcs_web_file_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-                            layer.vcs_web_commit_url = 'http://bitbucket.org/' + reponame + '/commits/%hash%'
+                            layer.vcs_web_url = 'https://bitbucket.org/' + reponame
+                            layer.vcs_web_tree_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+                            layer.vcs_web_file_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+                            layer.vcs_web_commit_url = 'https://bitbucket.org/' + reponame + '/commits/%hash%'
                         elif '.git' in repoval:
                             res = link_re.match(fields[5].strip())
                             layer.vcs_web_url = res.groups(1)[0]
diff --git a/templates/layerindex/editlayer.html b/templates/layerindex/editlayer.html
index f6d4967..a95dab3 100644
--- a/templates/layerindex/editlayer.html
+++ b/templates/layerindex/editlayer.html
@@ -198,10 +198,10 @@
 
         if( repoval.startsWith('git://git.openembedded.org/') ) {
             reponame = repoval.replace(/^.*\//, '')
-            this.vcs_web_url = 'http://cgit.openembedded.org/' + reponame
-            this.vcs_web_tree_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-            this.vcs_web_file_base_url = 'http://cgit.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
-            this.vcs_web_commit_url = 'http://cgit.openembedded.org/' + reponame + '/commit/?id=%hash%'
+            this.vcs_web_url = 'https://git.openembedded.org/' + reponame
+            this.vcs_web_tree_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+            this.vcs_web_file_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
+            this.vcs_web_commit_url = 'https://git.openembedded.org/' + reponame + '/commit/?id=%hash%'
             this.vcs_web_type = 'cgit'
         }
         else if( repoval.startsWith('git://git.yoctoproject.org/') ) {
@@ -215,28 +215,28 @@
         else if( repoval.startsWith('git://github.com/') ) {
             reponame = repoval.replace(/^.*github.com\//, '')
             reponame = reponame.replace(/.git$/, '')
-            this.vcs_web_url = 'http://github.com/' + reponame
-            this.vcs_web_tree_base_url = 'http://github.com/' + reponame + '/tree/%branch%/'
-            this.vcs_web_file_base_url = 'http://github.com/' + reponame + '/blob/%branch%/'
-            this.vcs_web_commit_url = 'http://github.com/' + reponame + '/commit/%hash%/'
+            this.vcs_web_url = 'https://github.com/' + reponame
+            this.vcs_web_tree_base_url = 'https://github.com/' + reponame + '/tree/%branch%/'
+            this.vcs_web_file_base_url = 'https://github.com/' + reponame + '/blob/%branch%/'
+            this.vcs_web_commit_url = 'https://github.com/' + reponame + '/commit/%hash%/'
             this.vcs_web_type = '(custom)'
         }
         else if( repoval.startsWith('git://gitlab.com/') ) {
             reponame = repoval.replace(/^.*gitlab.com\//, '')
             reponame = reponame.replace(/.git$/, '')
-            this.vcs_web_url = 'http://gitlab.com/' + reponame
-            this.vcs_web_tree_base_url = 'http://gitlab.com/' + reponame + '/tree/%branch%/'
-            this.vcs_web_file_base_url = 'http://gitlab.com/' + reponame + '/blob/%branch%/'
-            this.vcs_web_commit_url = 'http://gitlab.com/' + reponame + '/commit/%hash%/'
+            this.vcs_web_url = 'https://gitlab.com/' + reponame
+            this.vcs_web_tree_base_url = 'https://gitlab.com/' + reponame + '/tree/%branch%/'
+            this.vcs_web_file_base_url = 'https://gitlab.com/' + reponame + '/blob/%branch%/'
+            this.vcs_web_commit_url = 'https://gitlab.com/' + reponame + '/commit/%hash%/'
             this.vcs_web_type = '(custom)'
         }
         else if( repoval.startsWith('git://bitbucket.org/') ) {
             reponame = repoval.replace(/^.*bitbucket.org\//, '')
             reponame = reponame.replace(/.git$/, '')
-            this.vcs_web_url = 'http://bitbucket.org/' + reponame
-            this.vcs_web_tree_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-            this.vcs_web_file_base_url = 'http://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
-            this.vcs_web_commit_url = 'http://bitbucket.org/' + reponame + '/commits/%hash%'
+            this.vcs_web_url = 'https://bitbucket.org/' + reponame
+            this.vcs_web_tree_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+            this.vcs_web_file_base_url = 'https://bitbucket.org/' + reponame + '/src/%branch%/%path%?at=%branch%'
+            this.vcs_web_commit_url = 'https://bitbucket.org/' + reponame + '/commits/%hash%'
             this.vcs_web_type = '(custom)'
         }
         else {
-- 
2.54.0


