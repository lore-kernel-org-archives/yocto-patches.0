Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA6FD876E
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 13:40:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76196.1773754803816040609
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 06:40:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DHhhPlTP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so51145235e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773754802; x=1774359602; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=753ZXByJLL9rOwhNqQN/BJRbrkIrYLdXfuXJQci2B+0=;
        b=DHhhPlTPvz+yi8qQfcBpWRZbET30vXi8yW3rj7hvOR5ANS8eMG541QbCp03Pbcj8IL
         Vc/gnQ3DUYr9fatxO2DkfzqUrWHeuZ6nnWP9jVrcVDJU5OszrJeujqgZo00boQn9MLSg
         I9WA79blsBG3Ws8Ic/EQcX+178LDpVAZAVRhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754802; x=1774359602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=753ZXByJLL9rOwhNqQN/BJRbrkIrYLdXfuXJQci2B+0=;
        b=j32AWrPA7CaJJ28FxTgIQKvx2t84x4/BlPZY/nxedTmM+bgBETbP4QlktHMXiz7d4u
         Y3aq89mA70REncUnQN/t5tlCJM7LfbUjfVVcM+LMPvVDlQzLZ2iKlqhzDBi4mD14sZN4
         oqCBJ5RGjJYLYy2pzuUpcsO4xRMsz3NZ4ZGix7DMZV7GSAdPxsntnmbO0cIkYwx3rzm9
         IJWWvyu6sqF03PYcDrTugVbwvbXegjadI1dYHXJbiFoScT8ErCvGq6TMVAvSjepCcabW
         c7Gpgg+XzNRbPs6ixrPa1tktB9xyNfWRaYZWuYoMWx8N719LV7kr54R7AqdGItAQp4uF
         vapg==
X-Gm-Message-State: AOJu0YwjiL9mwmFiQymRmJx2bw4t1ItYiTXwBodu3EGsP6xTqcsw5t1h
	2uR0ELh9EXcnDXc+maIE1ZW48jPAyRsb04Ue2LKa9nxujJRgEmh2USa8D62k7AoUbg3P96Wur3t
	Ipih80XI=
X-Gm-Gg: ATEYQzxDpJCXvWoddYyvOogSusw3xf2XvaQMeUUTMCMCWqOgc+uDA5gicHdGYWFqBJ2
	CIrsdtnILTE+14BBScSiyuih7J2rc8x5wiPB9hZPXFHsN8hTD0FmL5ffxBr3NeGYfuKj97CXIZX
	4z6TAQyxdpa4W8T7O0LrRXsOw7ZjX/ArR1pvb2+lC5MR5JCmsW8257eZkYymm0BVey0a27mLoUy
	+Kc3W5Lc/Rg0Jam7b8U+bhzjbD7qsP/YTc8Je40LiyAyagKxtEM2KJ7p8pfWOUj1FFFHfGtoXdF
	+0mIQAq6SGQvm2yLtEzAK5R3FaV9fES2RQpWdkAZIeDWYqz5Wl226XWTJ40EE9Ocj4oTiVYGuve
	IxmcD9z8B6znCK1cT7R4H3X+XarnycORTLLfp2kfnjlZ7zfbdVa+2KuL0CIFv7trwQSqUoSEsgr
	Ngc8xs0N5YWzWzu1Ln7/cDzOP5p7LuD4zSRxkI2yHh8rPepmXLPw==
X-Received: by 2002:a05:600c:4753:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-485566d709dmr284845735e9.14.1773754801734;
        Tue, 17 Mar 2026 06:40:01 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4129:32d:cefa:7330])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea96cefsm66232495e9.4.2026.03.17.06.40.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:40:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Add musl-ptest for qemuarm64 and qemux86-64
Date: Tue, 17 Mar 2026 13:40:00 +0000
Message-ID: <20260317134000.975734-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 13:40:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3488

A lot of work was done to get ptests running properly on musl. As a result, enable
ptests on qemuarm64 and qemux86-64 with musl. The policy is any intermittent ptests
get disabled as we can't afford to stack up new intermittent ptest failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index 2a8ee082..86a6f5e0 100644
--- a/config.py
+++ b/config.py
@@ -86,6 +86,7 @@ trigger_builders_wait_shared = [
     "build-appliance", "buildtools",
     "wic", "poky-tiny", "no-x11",
     "musl-qemuarm64", "musl-qemux86", "musl-qemux86-64",
+    "qemux86-64-musl-ptest", "qemuarm64-musl-ptest",
     "qa-extras", "qa-extras2",
     "check-layer",
     "reproducible",
@@ -118,11 +119,12 @@ trigger_builders_wait_quick_releases = {
 }
 
 old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc", "meta-mingw"]
-trigger_builders_wait_full_noriscv = [x for x in trigger_builders_wait_full if 'riscv' not in x]
+trigger_builders_wait_full_noriscv = [x for x in trigger_builders_wait_full if 'riscv' not in x and "musl-ptest" not in x]
+trigger_builders_wait_full_nomuslptest = [x for x in trigger_builders_wait_full if "musl-ptest" not in x]
 
 trigger_builders_wait_full_releases = {
     "master" : trigger_builders_wait_full,
-    "whinlatter" : trigger_builders_wait_full + ["meta-mingw"],
+    "whinlatter" : trigger_builders_wait_full_nomuslptest + ["meta-mingw"],
     "walnascar" : trigger_builders_wait_full_noriscv + ["meta-mingw"],
     "styhead" : trigger_builders_wait_full_noriscv + old_arch_full,
     "scarthgap" : trigger_builders_wait_full_noriscv + old_arch_full,
@@ -142,7 +144,7 @@ builders_others = [
     "qemuriscv32", "qemuriscv32-tc",
     "qemuppc64", "qemuppc64-tc",
     "qemux86-ptest", "qemux86-ptest-fast",
-    "qemux86-musl-ptest", "qemux86-64-musl-ptest", "qemuarm64-musl-ptest",
+    "qemux86-musl-ptest",
     "musl-qemuarm64",
     "buildperf-debian11",
     "buildperf-alma8",

