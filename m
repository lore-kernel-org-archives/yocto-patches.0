Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B264CD6E65
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:39 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12713.1780355910656147910
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lKS7b3mc;
 spf=pass (domain: konsulko.com, ip: 209.85.216.42, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2719562a91.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355910; x=1780960710; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wup+ARkC5NxdlM6S9euHh+cIF99+71JfQqhwZqaIX50=;
        b=lKS7b3mcs4l8xgSuILkDliqRDAOq9B5jDh2anB7ZzulJC/f5hCqtXp25rKIYH5OX1y
         9aiPIZ5Do5mftUjFhG2EqO8Mns2UQTqu2LRXeH2/slITAC+4WT3DE90hYCYaEh9nhzJE
         EvssM8lRpFrsYcikUKDhWRX+Wo4UmyufQ40XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355910; x=1780960710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wup+ARkC5NxdlM6S9euHh+cIF99+71JfQqhwZqaIX50=;
        b=ary48PMy4RdnV5q+LE86eQJO5lbFhLp2640t9lLYFu9u+cONfjrADhXr1MUMrARaON
         s/iit1k9ExVL3edRzzsjQukBWG5PjrKmjZO5nukPS5TLTjgeOo7NihRLxUdFxxFoz4/l
         RFF52vyLASMB2FM27x8p3CQCJwsWApcjPerSYZMvruk8NA+6v8cvzMVmowItm71hJEwY
         WVjmVW90f1j1ehlliEt3ndaK2t1lMkMsX2POS6ii1Rcdr1bXUwLggOkFa1oknhKeOVFm
         18bdUTlQDx9XqoPcE3H8qPsVXs21SJ5QZiKBTPJ6fmGsB/waqJyR27m1Axhvh6/U1sLY
         SZJw==
X-Gm-Message-State: AOJu0YxswUs+xeC9bhHp61fpV263a32S6RAiXKds1A9LcdtjFjklsHhw
	7DXbpIhxjE+/trdqdn+nsq2cPM7B3ER2RlK2320rWEZ5FdjMHzNyNhxsTrJ48gOueldAitfsx//
	4iImB
X-Gm-Gg: Acq92OEZ+kOzh5/2wdFFeLi7M5ptqG7dx1wPTVr1s/SPEcTUD0Sb/2AgBaR5h2HJlq8
	qYpDOOOAjO0Zs66QX/JEBvm1Vh4j3UMNBGfw/Dts5E/MxifhQrCtAKVCQKH60kM9S/NxjzcRzfn
	S2XczW/ZqueEQwyCrvT5/R4/sqFRgbTjMZHpiaBQED6sAVcp5ez99JjkvDF2+//oHTOnS+FfNEV
	IQHb4BUlscsUeR1SbbhnMptlAZ2Pih5JuTPxnLyEMKhAirQOnwfWJdUg/hGFKLmRM7ngaozemOV
	gRPyO7hoNR1QRwIDN8mV1vj7GKq0FJYDPXgTd3rVJZfHrMcjGDUmK+BzrOcT54PK+NkP4eIjwPC
	d20z6dtfg7QsXjzZeIjg12iGHBS+DbctBKxhk5LjJp+jyO6mtXJSp1oypQovTRxvwN58TIZ2kqp
	mAkl3HRv0sMFexkuxUjAKgRqmeqmG8rWDhKir0WFVOQILIo9bUYrT12WOKR7cS8XgZVdEQy60T7
	g==
X-Received: by 2002:a17:90b:17ce:b0:36b:71e6:3de3 with SMTP id 98e67ed59e1d1-36c4fef326amr12660452a91.3.1780355910105;
        Mon, 01 Jun 2026 16:18:30 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd9751ea1sm700191a91.12.2026.06.01.16.18.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:29 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 04/10] scripts/utils: add getconfigdict() for dict-type config values
Date: Mon,  1 Jun 2026 16:18:03 -0700
Message-ID: <ddf766402b49961b63364b17ea75adf2cfe12471.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4101

From: Tim Orling <tim.orling@konsulko.com>

Parallel to getconfiglist(), but for JSON object values. The merge
priority is defaults < target-level < step-level so that more-specific
keys win: a step can override individual entries in a target-level dict
without replacing the whole thing, and both levels refine the defaults.

Used by the upcoming CONTAINER_IMAGES support, where each entry maps a
Yocto recipe name (the on-disk OCI path stem) to an image name (the
name pushed to the container registry).

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/utils.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/utils.py b/scripts/utils.py
index ea905d9..112ebc2 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -112,6 +112,21 @@ def getconfiglist(name, config, target, stepnum):
         ret.extend(config['defaults'][name])
     return expandresult(ret, config)
 
+# Get a build configuration dict, merging defaults < target < step so that
+# more-specific entries win (step-level keys override target-level, which
+# override defaults).
+def getconfigdict(name, config, target, stepnum):
+    ret = {}
+    step = "step" + str(stepnum)
+    if name in config['defaults']:
+        ret.update(config['defaults'][name])
+    if target in config['overrides']:
+        if name in config['overrides'][target]:
+            ret.update(config['overrides'][target][name])
+        if step in config['overrides'][target] and name in config['overrides'][target][step]:
+            ret.update(config['overrides'][target][step][name])
+    return expandresult(ret, config)
+
 # Return only unique configuration values (identified with '=' in them)
 def getconfiglistfilter(name, config, target, stepnum):
     def merge(main, newvals):
-- 
2.43.0


