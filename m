Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5BCAC5B9
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 03:50:07 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.17021.1759204197743583047
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 20:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=ByXymXSb;
 spf=pass (domain: mvista.com, ip: 209.85.210.172, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7810289cd4bso5170960b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759204197; x=1759808997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKQs0VXbT9b2yd1wNnULH7lQiMHH2Gqr6NB4bHyie0c=;
        b=ByXymXSbQiU6kLurz29rKLE25uzD9f6CCr4u+3vaV9u3w+WRlPUcjRmAAUFt12ZB3Z
         08s9QR8pR2ksDtMsGNi8vrDsjVp5g1EQrI5KJlOz+EriWykQFyZBWzCQOWeKYOKPsbN4
         DNThTBF7X3/YB6JwDAu1EWEAVxUG0qTXwi4Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204197; x=1759808997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKQs0VXbT9b2yd1wNnULH7lQiMHH2Gqr6NB4bHyie0c=;
        b=dlf9HNT+CNjhciYGGEJsKFdVZJoPzqcuJg5BG3L0++TKFKwJKCgqbjhDsvJgfQ6EFG
         4bdsDu+bHtG2s2Xb2eKZ7vFp/k36o0BT9tbxldblMxjQY/V7ekpgLoo2JrTY3AazCSLa
         MDryMGSoeIO9ZjmwtgnKZbj5JWZrygSGvZBL0TtEGZhkix+W4rWojrxmY3iFbwD4bZyj
         uj1YAdPBoJ92eypOpln+H9HkBPYjLivlg6m34NrUY5SwnUGNPeAGVMSMfYuvSuATb0S8
         SAor+hSBNvww3lGuauAqXEyL40Wr93zN2wD77A8n1fEecbWUBGXVTZ28C/wpw3E0kmMm
         pwmg==
X-Gm-Message-State: AOJu0Yxe9CSQXR0JbSZkg8NGRLAC1Ah9gZwxEz7964n9O3FpcwSs7ehg
	6P+F0Yvclr+2iL4RYOjUqC/PbOaQEdTmVElwnVDRdiadaUNmCBC5BhMYDiciNL+JO6lvV9boBxa
	xJq60xWY=
X-Gm-Gg: ASbGncsbiM+wCoEbA2JEV/mFQsQzoNxWWmNxDiLXevtsxg2MjUvLzrWEi5+OYH1Iqnz
	YnzVvzlI8CtBYUNOgAE9Q82SH1neXHCfIO22ukJ/mDjO2zxsFoW5QQLvMGGG+/oR5vBgwhNGOSw
	86Ze8rGfc8DHywF/MtWtIvMJwVctJXrAhGCbXUOsVym4waw0x3OiSEi1WiWsm51/Ct9M/ZpaVtZ
	jTsq15wFMAHhVtUmk4YDGQKy8EbiCpmLiMiHv7oLiA45/7CbIijc4EQ5jGbELHnj8kzpVDO2Tuw
	zvi5Dw0hDF/LXy75+OC7/TK50nCG95DsgklsODwpw1BG4106SeFYLsdXek2D5iV9a5SPNAaVPGN
	fp7cjEBViNnjIJzufAi7bxu+m6cBadlyRZT5iuWGVjsDOurLUQ7yqeVg9/YT71coQJegncgwuww
	==
X-Google-Smtp-Source: AGHT+IHSUWA5gYKaJ/ouRy3fVozBGI8P1sZjAVTVhOgbWrKhzeQfZnVa+h0EhMzagep/kTIwH1yhpw==
X-Received: by 2002:a05:6a21:99a2:b0:2e5:c9ee:96ee with SMTP id adf61e73a8af0-2e7d53bc5bbmr24747207637.37.1759204196772;
        Mon, 29 Sep 2025 20:49:56 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:62d2:5a18:f11e:c6a0:64bc:a06c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b59671ce93fsm7176996a12.3.2025.09.29.20.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:49:56 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH v2 3/3] ucarp: Fix the permissions
Date: Tue, 30 Sep 2025 09:19:35 +0530
Message-Id: <20250930034935.89622-3-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930034935.89622-1-vanusuri@mvista.com>
References: <20250930034935.89622-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 03:50:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2259

From: Vijay Anusuri <vanusuri@mvista.com>

The Makefile.in.in file inside the po/ directory had read-only permissions (0444), even for the file owner. During the build, the process attempted to copy and overwrite this file but failed due to lack of write permissions.

Updated the permissions to grant write access so that the build process could proceed successfully.

Below is the error snippet

| NOTE: List of Makefile.in.ins to update: /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/Makefile.in.in
| NOTE: Executing: cp /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/recipe-sysroot-native/usr/share/gettext/po/Makefile.in.in /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/
| cp: cannot create regular file '/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/Makefile.in.in': Permission denied

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
index d221814..8a2737b 100644
--- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
+++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
@@ -42,6 +42,10 @@ EXTRA_OECONF += "--sysconfdir=${sysconfdir}/${BPN}"
 # fix the perms for config.rpath
 do_configure:prepend() {
     chmod 755 ${S}/config.rpath
+    # Make sure po directory is writable by current user
+    if [ -d "${S}/po" ]; then
+        chmod -R u+rw ${S}/po
+    fi
 }
 
 do_install:append() {
-- 
2.25.1


