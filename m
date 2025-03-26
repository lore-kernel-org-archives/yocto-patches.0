Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6E9C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 17:08:20 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.28151.1743008898442391210
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 10:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gt4y9DEj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-394780e98easo3950f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743008896; x=1743613696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRtyC+Lb6TeAC8UJI2McEk34nLmeqrOm1KFYQ9wsvww=;
        b=gt4y9DEjvUYOv6qNevlA8N725NxQzYU6/rjeZJjs67QvAZePVW5SIfOAcW9l5cTd1q
         i69E2drlqsvSVMHGNMkfuIYcgmROTotUtjZPFLn3F1g/LKyChL+fYFtsKd1cSuArqjET
         hQyePqNhY4QRNbKTRFM7cEZMydnDWQtW5u+1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008896; x=1743613696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRtyC+Lb6TeAC8UJI2McEk34nLmeqrOm1KFYQ9wsvww=;
        b=kiuToHHxYG8UshLWiiY9XGj9nJniuG0JxGVsD1X0N7xC6gy+H9/GUM/piUC8k+d0mB
         FlNPXIaoernBcCTctP5DgdYENigZfaUbXbzFzFKdG/VZHtEE7lAkd6+hxP8htn6DrDAZ
         6wGb/b1Zi3odiqjKnmLlYTTZds6j0xRL60EyWtqbT0ftY+37QHiI6zoJ7fTdHflfVcit
         +Pb0TkpQahiE4mIN2okCMhwL0J5FsW8hJ0kurGbBxr5ouapDZWl2pw2zbQZIE4ReMkqc
         qy+QlUcCbq4JWLCpUYXlgBhPFb0T7Ws4rGoKbRHR2i5liCN3NepSa7FzenT8x2DfE73D
         rRhg==
X-Gm-Message-State: AOJu0YwghvnvobSu9g9CR+FoUPtZAN9/iCjVXIUXn5u+okmtq7xKPJKu
	A0mslTuBXpklizzUti/5lGzqcF9cyAyouHU7yhU3Y1vCq0IDROzz6DwtaEvjm7Fq6veShMsFPil
	1
X-Gm-Gg: ASbGncs1j5h+eMEtbQB7egyAWmKzrV1L8bCUioSRRY3XAce4Ro3QT49LXx72bmbwm6z
	eS78elMsw1LPnFfaSJwqEMr6pAETY7P7MP2qxPvzTfF+46lvCfX9i53tEj79h3d0XXTakFl5oMM
	rOG5WQPIS8hXIoOt1L9v39ZeboNPdIbQmhbjq8oujV+B8m7LaSbLryiqVeBg1ZomGvG55RDIZ72
	paD4CsWIND0Zq9T9T2qKlF/oyFT3xfkQmHk8QR8PAoDffTKdHFZMuXIL6brp3furzdo18iRczRt
	MwBiqbVMmIs3RLGY/2FZ14iWkBWhzxPzVERUHJ0H9HY5xDp8oqMGt5MvdxjNuA6x5Rrs5qpuYA=
	=
X-Google-Smtp-Source: AGHT+IGNGBAwvq6e5b8EvPvpVoQO2UDn5JmpKPQHVoZq6JRBwI8EQzSDLbjuxfscJ4TOtLisE62R8Q==
X-Received: by 2002:a05:6000:2913:b0:391:481a:5e75 with SMTP id ffacd0b85a97d-39ad174be73mr222255f8f.22.1743008896364;
        Wed, 26 Mar 2025 10:08:16 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc90sm17620570f8f.98.2025.03.26.10.08.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:08:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 3/3] config: Drop mips, mip64 and ppc from default testing
Date: Wed, 26 Mar 2025 17:08:12 +0000
Message-ID: <20250326170812.840424-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326170812.840424-1-richard.purdie@linuxfoundation.org>
References: <20250326170812.840424-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 17:08:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1261

Going forward drop mips, mips64 and ppc from default testing on the
autobuilder outside of older LTS releases.

These are now old and don't see much new development. People aren't
interested in fixing issues on them and it feels like we're wasting
our bandwitdh on them now. Drop the automated testing as a result. If
someone wants to step forward and support these let us know but unless
that happens, they're too much work now (and upstreams like the kernel
would also need work).

This aligns our test matrix with the Yocto Project membership/supporting
members more fairly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/config.py b/config.py
index a8aa4e31..b2485988 100644
--- a/config.py
+++ b/config.py
@@ -77,9 +77,6 @@ repos = {
 trigger_builders_wait_shared = [
     "qemuarm", "qemuarm-alt",
     "qemuarm64", "qemuarm64-alt",
-    "qemumips",
-    "qemumips64",
-    "qemuppc",
     "qemux86", "qemux86-alt",
     "qemux86-64", "qemux86-64-alt",
     "qemuarm-oecore",
@@ -106,29 +103,33 @@ trigger_builders_wait_quick = trigger_builders_wait_shared + [
 ]
 
 trigger_builders_wait_full = trigger_builders_wait_shared + [
-    "qemumips-alt", "qemuppc-alt", "qemux86-world-alt",
+    "qemux86-world-alt",
     "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-fedora", "oe-selftest-centos",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
     "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "qemuarmv5",
-    "qemuarm-tc", "qemuarm64-tc", "qemumips-tc", "qemumips64-tc", "qemuppc-tc", "qemux86-tc", "qemux86-64-tc"
+    "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
 ]
 
 trigger_builders_wait_quick_releases = {
     "master" : trigger_builders_wait_quick,
-    "scarthgap" : trigger_builders_wait_quick,
-    "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl"],
+    "styhead" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
+    "scarthgap" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
+    "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl", "qemumips", "qemumips64", "qemuppc"],
     "zeus" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
     "thud" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
     "sumo" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"]
 }
 
+old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc"]
+
 trigger_builders_wait_full_releases = {
     "master" : trigger_builders_wait_full + ["meta-clang"],
     "walnascar" : trigger_builders_wait_full + ["meta-clang"],
-    "scarthgap" : trigger_builders_wait_full,
-    "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"],
-    "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"],
-    "thud" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"],
+    "styhead" : trigger_builders_wait_full + old_arch_full,
+    "scarthgap" : trigger_builders_wait_full + old_arch_full,
+    "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
+    "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
+    "thud" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
     "sumo" : trigger_builders_wait_shared + ["qemumips-alt", "edgerouter-alt", "mpc8315e-rdb-alt", "qemuppc-alt", "qemux86-world-alt",
                                              "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-centos"]
 }
@@ -160,7 +161,7 @@ builders_others = [
     "edgerouter", "edgerouter-alt",
     "non-gpl3",
     "meta-webosose"
-]
+] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
 builders = ["a-quick", "a-full", "docs"] + subbuilders

