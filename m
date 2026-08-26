Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E01C61DD3
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22433.1787777932577897642
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uP4RCwGL;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f0e5e36912so7432886d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777931; x=1788382731; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suvlxoiVkJqP3aL3PCzZ0h8UjC9cFDalTjK7ybF8dKw=;
        b=uP4RCwGLCzGW2/Rwu5vOPIXPAYcYGsbE3Bl36LKos05oMjZFqgo26lRAZPAP7WH8NU
         8qsvdHZ/DF9wV+iIMup17WjMBSYhUV/inwbmOWCWjxwddCpbjNjWg3MhCo2JazFYz/+Y
         L9uVIOD+nqwoOnbTRhqZqWTtJKedSlqI5TIN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777931; x=1788382731;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suvlxoiVkJqP3aL3PCzZ0h8UjC9cFDalTjK7ybF8dKw=;
        b=Hv9JjOMiUpPktwCJ1eK+ju68mZPIqJUNF+LwNKwHHPJbFOfEH5ySc22o5QAbNr1Qgh
         MJ8LvCvDOaRzk9veOGG4r0ugzktC1fPZvL/1rXLhzHDPHvpHN98J4qBghRADapAcaGrA
         M3f3eGhMDtahYScgWW6ffaAjwsb6cCnnRXynvsXddd4fCwfjmCGBguYv+Yo34S5PzM0Q
         5COsEQh2+2S+N71GsmzJhu/sEcYu+y/1eMiY+LjEtf9C2bOlc0pamm8JzwG9RDxv+l+a
         38q2xW24doxJ1dgaSrDt15THYeUdvrXdM9ByMN1ETHY7nLY8XEb/GBnEu9XOipCQKidR
         vGXA==
X-Gm-Message-State: AFuF++nhJlLSu6YWFVRRKw8dxHHK43bEUh4VWE4AQCxWf6qg3nzpyASL
	rHsjGu8zElh+eXcd8ZPlaE5hmnuM/dM84VV8XQHrVftYBGxH0a6B3vWbLom4xdhIgEqLYPslBHB
	2F3GM
X-Gm-Gg: AR+sD13RBM1tc+YsYiaNywEgH/wevhIHxmzFSA8RrLLDW/fDm/AyrLbpaQctdTnbidP
	FSOoboNT0/s4GoGZ3MZBAPGm3eiuoSjG2wbBV7FUFhXp0Xa/KgkhL4AbXeE1EFS5yeNFZlXHxyu
	0YVVcbdXmqhC0hMHAs05xmAyGLGJ8GxIJvUCcnhgfzczQUt8wxL3JfS6CWu7BGnyP8MgBsYL34E
	fqXhB3JEzGB28rVTgg9C4pjn8YgDcit+HYzFt5S/yzzEUpXpt+NcM72fSmNxTst6y611GzkG0e2
	mgOijI38mEPGbC7Nj9g4ZFJYN0wJU5LT6KWSKsFCt0R9mjxtoiW394U/dnOGh4RVrUW4yF4KYbd
	HU+SPzOCdh4cSBBfKuHMKgLfvqG1JIgo/M1sk01TcgkhSW2K/pUVYcL4EPNx6rouqYdECg9W1O2
	1pyGr1Els3uBjr/hJl3A3ZNIWlGkVNwghPQjTuXYG85n5xEUSqzPQDqwiwu45npI3BUBpNNKSkS
	EjZEDrLZFaPDO9rCFSwCpYtaQloDoK+gycAsA7CDC32E1BZw2vCuWynnnSCupLr04qZb+beytx9
	KpeHlTY3egaladn5StJGMP0ESg==
X-Received: by 2002:a05:6214:2c13:b0:907:5ad6:ed0c with SMTP id 6a1803df08f44-90cc78a848dmr117710286d6.7.1787777931296;
        Wed, 26 Aug 2026 13:58:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 08/15] docs: update path of wic files
Date: Wed, 26 Aug 2026 16:57:42 -0400
Message-ID: <79b0dbd8f7c76c358d87b900082c95a0a26d329e.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4700

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


