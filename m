Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC6C44500
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62379.1782967538316222746
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sNZc6TfB;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493adc4ff7eso1234385e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967536; x=1783572336; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3XQuGOK5SG27PADpkb/O/W+UjSaGrD+x/ZjtfBK60G4=;
        b=sNZc6TfBsYw09rWCiVcMwMmHTMr6DjXSom+Sv/oJMp3RsLfvyvkRSC7VVQvTMCFAX1
         PPjkpkGd0czet9RAw1VEwW9wjkEQtvjkP9+W68LNKEnZ2vmAulrL9vUEI5uTvi51zQS/
         piJ0RII7XsBozWWNJtfMr+mg76ZHNzxmroKMXTgFZDs3Wz6TDFGa2wc/Qake3/pz5gmE
         cRNkS92E9/Nv5IZ0VWKSfakgdoRB66/w1WhMgIZ63Qbtn6PMFVS6qWAyd1OMDvfcEEqW
         YjGaxGBcJxBUDjJCBTf2eVQlaBVObCcnxlJSD2UPTvkhlU/oJq+Dn5JU9SVVxT4a4wzO
         mwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967536; x=1783572336;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XQuGOK5SG27PADpkb/O/W+UjSaGrD+x/ZjtfBK60G4=;
        b=ou3JlCd9J0cZoRBX0tM3iEg6CX3LI6OePZSPuN0phEeS0ovMIgfBJiiqh7zDbx3EFz
         B+zxF9YEo34aZoDrIbUaH9Ba6+OUznfcb186ZwaeRtr0HWf4ZnBUWGAe+8ALSnbuGKPE
         eLvbdtCC6gtI+4qmvhF6Y7DvPJQNZxPSNH7bV/VvveT5tN3Up7ocagEfIAyFB8E1gWw/
         dgiM4/WaVr9ksj/mjv5Zn9Meob6sum9taYt5lQqpBMGTR+t7fyPWwp2zpEr0K0Fn028j
         yLwQ8/8UKU1qKx+6nmF81rmedLn3ZqPL/v1ffwkDjye1XIdWstpyEQp0QNB/zUUJr2Ei
         sbPg==
X-Gm-Message-State: AOJu0Yxtdg077TXNs0rA5U+lGcxrWnIvVHnhFFkS0vs/juPx98wrTalD
	hRwfTPpJ3bKdS8oBupwF+pAv+qk7G/OJA3x4Psd738exfvZ3f5LSr7mC5VPvrW97
X-Gm-Gg: AfdE7ckHewlUqkm1DEcbKOBw6UCXgKTGFlDCW7K8jJT2AbeEu+oRd6vNI/GJ41A8YAH
	mUHbQDwXwmnjeLfLueNeLDRcIJkDHlxjnxYQsv3DfDNIiLk/7TKoKahN6uWxajlFJPb51uK+B0m
	29FJbThxsa3CqYGsbfYx6+V1O6XzXKy6kZxNxDywh3xXzy8zqMQJxDgce6CWfzuUXoHky6/olMV
	o92ahZ0iVTZVBBWV4y5S/zC8i2M/TWxvUyNY3iojHV1hKIWu6Db/NkQgtor6Hwmh+v86Ee76FKd
	rC68TwsPkepm54jzcz0wxdDU0iWeWYNTCUmcJEhvqb54bgnZMiQ8zahzsNckTE/LoGQwNfhIZef
	mr+esgBU8BGVr7qIYMxnoZ+N0J5UD3aObroS4gy2Jd2Y9ZuXGjLExSfiQxQcP+KVHDjjiJED2Y+
	fuN4zx3E/ziOpeZykaFN3JYv9ltZ/sh4DxZcL6E21HemBRHpbTRV4ITdJtWjrjWWB8HaZw
X-Received: by 2002:a05:600c:4f89:b0:493:b246:4a19 with SMTP id 5b1f17b1804b1-493c2b9e75cmr35353705e9.8.1782967536470;
        Wed, 01 Jul 2026 21:45:36 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:35 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 6/6] wic/help: Add missing option values and rewrap lines
Date: Thu,  2 Jul 2026 06:44:24 +0200
Message-ID: <20260702044425.846351-7-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4359

Some options take values, but those values are missing from the usage
and help strings.

	$ wic create
	usage: wic create [-h] [-o OUTDIR] [-w WORKDIR] [-e IMAGE_NAME] [-r ROOTFS_DIR] [-b BOOTIMG_DIR] [-k KERNEL_DIR] [-n NATIVE_SYSROOT] [-s] [-f] [-c {gzip,bzip2,xz}] [-m] [--no-fstab-update]
	                  [-v VARS_DIR] [-D] [-i IMAGER] [--extra-space EXTRA_SPACE] [--sector-size SECTOR_SIZE]
	                  wks_file

This adds and capitalizes the missing option values, and rewraps lines
to 80-characters.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/wic/help.py b/src/wic/help.py
index 05e838a..837695b 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -116,11 +116,12 @@ wic_create_usage = """
  Create a new OpenEmbedded image
 
  usage: wic create <wks file or image name> [-o, --outdir <DIRNAME>]
-            [-e, --image-name] [-s, --skip-build-check] [-D, --debug]
-            [-r, --rootfs-dir] [-b, --bootimg-dir]
-            [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
-            [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
-            [-w, --workdir]
+            [-e, --image-name <IMGNAME>] [-s, --skip-build-check] [-D, --debug]
+            [-r, --rootfs-dir <DIRNAME>] [-b, --bootimg-dir <DIRNAME>]
+            [-k, --kernel-dir <DIRNAME>] [-n, --native-sysroot <DIRNAME>]
+            [--sector-size <BYTES>] [-f, --build-rootfs]
+            [-c, --compress-with gzip|bzip2|xz] [-m, --bmap]
+            [-w, --workdir <DIRNAME>]
 
  This command creates an OpenEmbedded image based on the 'OE kickstart
  commands' found in the <wks file>.
@@ -138,11 +139,12 @@ NAME
 
 SYNOPSIS
     wic create <wks file or image name> [-o, --outdir <DIRNAME>]
-        [-e, --image-name] [-s, --skip-build-check] [-D, --debug]
-        [-r, --rootfs-dir] [-b, --bootimg-dir]
-        [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
-        [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
-        [-w, --workdir]
+        [-e, --image-name <IMGNAME>] [-s, --skip-build-check] [-D, --debug]
+        [-r, --rootfs-dir <DIRNAME>] [-b, --bootimg-dir <DIRNAME>]
+        [-k, --kernel-dir <DIRNAME>] [-n, --native-sysroot <DIRNAME>]
+        [--sector-size <BYTES>] [-f, --build-rootfs]
+        [-c, --compress-with gzip|bzip2|xz] [-m, --bmap] [--no-fstab-update]
+        [-w, --workdir <DIRNAME>]
 
 DESCRIPTION
     This command creates an OpenEmbedded image based on the 'OE
-- 
2.43.0


