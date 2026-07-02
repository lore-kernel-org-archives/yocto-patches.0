Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A868C44502
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:41 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62844.1782967533417442471
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KYymwkb5;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so2610605e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967532; x=1783572332; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9RJqGF/GCM6ywpIpHrxuzgpzEnauBZQ5Qd1YazeaFM=;
        b=KYymwkb5yf8+2Xde4g0L2Vesq6aexGwRCkUE1nevljBgJqYH2G2gb4/B/cD10KP4zV
         DbIyJ9+j4RfKYA0dl/QrnjlES+SaS1sDLM3ciDWgEbEkUoKxt5p9cv88PG4nJL2djecc
         NkUO5+1QserDcmbugsePG2gEY1JlA1fUONop8dCgOk9enY4mI+hBl+UBQF9Wjy8WlIzP
         CJeuoPpsEOh4qphj83fm0xY9ibOEVa8fgziZ3g1Voy/D+1E47jOM5KXqDP/1KBIR+VXA
         +e3IHwAmOZN3amSWBOhOeEPTNOkNeAdgZlzDlXEF0gy27g/Clo5eRpmbhmRk4Y4z8Npt
         MuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967532; x=1783572332;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9RJqGF/GCM6ywpIpHrxuzgpzEnauBZQ5Qd1YazeaFM=;
        b=BHYOz+//iFA10AHsRyh6PM7PUu9rhJYU+NyGmh46Q2bsUU0p0tblDiDGEwt1eDZvUi
         79l5EVtpJ3qkog1mr2Zd2iOX5sdW6cxLWGD8aacyww4nA7kBDGzZWH2JqbiQHx6GQBEK
         qn3wgcPg7m0df1TjtxYtbtVLR9wWgdV6biyuAvUj4kRD2DB45BkWq3Uiogq3Vdv4f8CZ
         5beR6JstuzLCilPQ5a+fwr42WxtdD5QK5PmPA6f4git86sENHCPk594jknmi6v9F849U
         dq/IAn4ydMQHGz1XgqzGcd/9yDWU3G41qN1YtkXbay29eR7cxmqHO7/OYuFp1VLWENtU
         8HSQ==
X-Gm-Message-State: AOJu0Yzx/Z3Ugm9MdWqikrZPS+OE1vtQIJS3iDm3fsVnUIsyUeyEyVsu
	F/O7Jg5JNWOwOlUmjtCAIcrTaurIvFCNFu4LVP3TDznL1UKN/L+gp9ske+zpz4Qb
X-Gm-Gg: AfdE7cmaMIpUW9c6K93QeJddvXtz14vYbTPho3vkCgEAgTQvmogPF4ccerPe5Fj515o
	g+uRk/q5neCzQk5TgZV7nSAQHjPyR3ohaRjDpN/6T098JCbmGwX39K0ybj0klKvHTQn5NtpRFF3
	1bCbdaloKUYkpcagO5c5eZg/pw77qRjLCl5yfeDTtfqeSqD5dsb+aG6c3ki/k5CKVXi0FMYzAqj
	bBaoOSjiCm81f5Dr1xe/GBkAChnizoXiGVks4cgen2h7VMQCYX/zrz0bj0D/sbJsGtRqYN+TdLi
	DTbLevdFcorbA1qfg5aGKmUxwqoL3Zum+VYhEeZg4/xpMXsRQR2RSFAzmqRf6KcobfdEswFIPR0
	AsEQ99L3SHFs+5MMtdBZnPKhxF2jv3d5mRsiP3+vqX4wdBL8Bp3iv+Fefv/JwgF2xDJpuLpdcR8
	iTp0ExbhbIa5zcPA0vrBubYOO2vco9xs1SqeZupyuwRasGQgMAI8/iLj1LAg==
X-Received: by 2002:a05:600c:810b:b0:493:bc2d:7e19 with SMTP id 5b1f17b1804b1-493c2b94327mr33417895e9.6.1782967531678;
        Wed, 01 Jul 2026 21:45:31 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:31 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 2/6] wic/help: List missing option --no-fstab-update to usage string
Date: Thu,  2 Jul 2026 06:44:20 +0200
Message-ID: <20260702044425.846351-3-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4355

This lists missing option --no-fstab-update to usage string for 'wic
create'.

As reported by CLI:

	$ wic create
	usage: wic create [-h] [-o OUTDIR] [-w WORKDIR] [-e IMAGE_NAME] [-r ROOTFS_DIR] [-b BOOTIMG_DIR] [-k KERNEL_DIR] [-n NATIVE_SYSROOT] [-s] [-f] [-c {gzip,bzip2,xz}] [-m] [--no-fstab-update] [-v VARS_DIR] [-D] [-i IMAGER] [--extra-space EXTRA_SPACE] [--sector-size SECTOR_SIZE]
	                  wks_file
	wic create: error: the following arguments are required: wks_file

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/help.py b/src/wic/help.py
index 1d0284f..ee5697f 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -119,7 +119,7 @@ wic_create_usage = """
             [-e | --image-name] [-s, --skip-build-check] [-D, --debug]
             [-r, --rootfs-dir] [-b, --bootimg-dir]
             [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
-            [-c, --compress-with] [-m, --bmap]
+            [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
 
  This command creates an OpenEmbedded image based on the 'OE kickstart
  commands' found in the <wks file>.
-- 
2.43.0


