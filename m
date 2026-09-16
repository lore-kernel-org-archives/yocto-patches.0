Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE21C982D4
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27089.1789597837616718038
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Lz4Vylnu;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c8so13889885a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597836; x=1790202636; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suvlxoiVkJqP3aL3PCzZ0h8UjC9cFDalTjK7ybF8dKw=;
        b=Lz4VylnujJKFioYorYIbhO3TsAPV4Fc1kSlNdsGmRVhz2RcU8b3B14m7PRJtPCvynV
         NO26YbjbnDhRZZdwD+7zRarIHhfYO9h45xF+KqJg6m7dl7AUpzUSsUlg7NS9iyN1pkgg
         v0eyHP1oY6XlBBI1X+ep9wQEHgkihwc67QLok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597836; x=1790202636;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suvlxoiVkJqP3aL3PCzZ0h8UjC9cFDalTjK7ybF8dKw=;
        b=nWi8gr4rcrO7X0Tm72ljNjxGA3BHu96k3hR4a0cXCMFlY2OaHA78DxHh8J9/2lGEpp
         kuz23kl4SkeZAm/gIRjNtGHJeZV/qPNy6YHLTHbUsT14IryC3oL04CKq5TJPUkvZ+8ql
         kiyk44yqWdQaZoyu8qy3Li5tmHIPv5gcHiqDVz/9rfGTf+fKjPcMkyFXUOYjfR3+iUJJ
         eFtmqQpDWexzex5s+HTWCpgOxhP7n8nE7B0EHgM0hGn/v5CdTo1iVI6cIJmy0naYTgt+
         3hOOqWM4sfvKUVFbimh1pOEdz40mY6b3LDI3e7+0pagVmdm0yxgf+pDaD5aOJ0UTLHec
         Ai6w==
X-Gm-Message-State: AFuF++kEE9f89h58UjstNGwnkdt5ZFA1kupkcG+8TQCBksbH5r2GBVb4
	m4xq+MZinuIkKKsMmoTY5wTLEjqjG7LPSuAS2hwQRvpYkHWsblIjZsmtUsnwfFe+bSIBLzEEUcS
	lbx/9
X-Gm-Gg: AYBFou1ijocSx8mI8mPY33hnhhI4PWD/IG07By4sLGk6fFn/kwP2ZJkWTjeyikeE64b
	H3Q+q7/RQamvogUTlYn9Vf+nMUzebrwevMFWi/1sikaojGAiFapb3avGYlqtyRJHhww/DqfNx86
	pGmvPyvY7QqibRC2ZPeWG6+ZeYqKcM59FidjN5nIBl3n8Q81xznD/T1HiHxBUcoKjzMLepOtsm8
	jMg57uv2jvQuFYxGARu7xmcsMOZ1iR+O0Ge7zp45/TaOlPSzwCNUk60MzubSMiFfW4iokfbyStw
	KWESw3Zbi/E8DdpWF1+BwdL+VKb9i0mAioGr0g4qKEowYSSIUZFBCH1IfRvxWfVzs9RMRzw5ey9
	E8OZdGKJ4apT948YE6BxCmhozigVYNpovssYApti2HErH74QXL15AUoq5hNdDcp1noqhjaeJrIR
	gxqd9PoLMt6WGV5DHYqGQmVqHcCS/pjZ0JwSsRYn3Fiaj18/bZXym6Hp/jz7K2JlRQkbbN/2gdU
	dLG4CcXAjKs7iPFxxKoQutE29s47DU9w3n1VxD03dbqgBWooGL2/FPI4UWrNMv+i8VzzB+BCMM4
	VuKRTKTbohfYTk3sYUQlsp208gmx2uODfkw=
X-Received: by 2002:a05:620a:8805:b0:939:6dea:374b with SMTP id af79cd13be357-93bb794d26cmr795526685a.47.1789597836107;
        Wed, 16 Sep 2026 15:30:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:35 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 06/24] docs: update path of wic files
Date: Wed, 16 Sep 2026 18:30:00 -0400
Message-ID: <2491b069c4d9d9076b0dcb9f24a66298b10c3273.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4882

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

The wic files were moved from wic/ to files/wic since commit 596b966a0d
("wic: wic need to be moved to files/wic within the layer to be
found/used").

This updates the path of wic files in the documentation.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 docs/dm-verity-systemd-x86-64.txt | 6 +++---
 docs/dm-verity.txt                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/dm-verity-systemd-x86-64.txt b/docs/dm-verity-systemd-x86-64.txt
index a47b02c..5d759a5 100644
--- a/docs/dm-verity-systemd-x86-64.txt
+++ b/docs/dm-verity-systemd-x86-64.txt
@@ -14,8 +14,8 @@ writing (kernel v6.1) the resulting qemux86-64 build can also be booted
 successfully on physical hardware, but if you don't intend to use qemu,
 you might instead want to choose "genericx86-64"
 
-This will make use of wic/systemd-bootdisk-dmverity.wks.in -- note that it
-contains a dependency on the meta-intel layer for microcode, so you'll need
+This will make use of files/wic/systemd-bootdisk-dmverity.wks.in -- note that
+it contains a dependency on the meta-intel layer for microcode, so you'll need
 to fetch and add that layer in addition to the meta-security related layers.
 
 In addition to the basic dm-verity settings, choose systemd in local.conf:
@@ -56,7 +56,7 @@ The following build artifacts were used to create the image(s):
   NATIVE_SYSROOT:               /home/paul/poky/build-qemu-x86_64/tmp/work/core2-64-poky-linux/wic-tools/1.0-r0/recipe-sysroot-native
 
 INFO: The image(s) were created using OE kickstart file:
-  /home/paul/poky/meta-security/wic/systemd-bootdisk-dmverity.wks.in
+  /home/paul/poky/meta-security/files/wic/systemd-bootdisk-dmverity.wks.in
 build-qemu-x86_64$
            ------------------------------
 
diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
index a538fa2..dca3df6 100644
--- a/docs/dm-verity.txt
+++ b/docs/dm-verity.txt
@@ -115,7 +115,7 @@ The following build artifacts were used to create the image(s):
   NATIVE_SYSROOT:    /home/paul/poky/build-bbb-verity/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/wic-tools/1.0-r0/recipe-sysroot-native
 
 INFO: The image(s) were created using OE kickstart file:
-  /home/paul/poky/meta-security/wic/beaglebone-yocto-verity.wks.in
+  /home/paul/poky/meta-security/files/wic/beaglebone-yocto-verity.wks.in
              ----------------------
 
 The "direct" image contains the partition table, bootloader, and dm-verity
-- 
2.55.0


