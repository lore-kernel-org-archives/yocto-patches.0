Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB0CD3427
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:04 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4656.1778205655459610112
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lAsA5VEW;
 spf=pass (domain: konsulko.com, ip: 209.85.214.175, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba0714574fso8848485ad.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205654; x=1778810454; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wup+ARkC5NxdlM6S9euHh+cIF99+71JfQqhwZqaIX50=;
        b=lAsA5VEWtcfdnUS7ZUdvMltau1ukZ8+kHJgS9hKdHD4vTmGJNucCSFCY5CrII4Zhz6
         vmr1lwHAcyauEePzP4btlEOMvPbuf09QCgbFNGTL/QF4XpD5mHwgVX3SC/Z0LWZr7v8f
         y53/XAWLfAC5lcSycN2faWHFDKBahmP9yX6bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205654; x=1778810454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wup+ARkC5NxdlM6S9euHh+cIF99+71JfQqhwZqaIX50=;
        b=Vq8BwlLJM8sgDljjhuEAVIs4q0elDrN86zYXdMLODhmZfQ2RGmnIhvT188Kh4koTRm
         d3VsSVf9IWT+L+GG2x7ceOfR/9uafISCqwHXpgPcblEbt9f9odyH9FlGUFZBEzkS667D
         csKtWXY5hPJwfY+G75AHs9PKETGvITdJfGz+TSgjkAxb0mQB3SqQ8lfYZZ9yiFN6yz5O
         ZzaFTwN+Szp+cvBpn8AhHStTvtxZdjZGKDKcO3K7YPXKOcolkmg+lAZrHPpOQGr9LoSe
         GVMo0IG43AB6cHembnsa641kQgnxkBz/F9A8rBh/Oqkxjn4ZZqtY2QUMBmzAM/AvPZxS
         AvpQ==
X-Gm-Message-State: AOJu0YzYok3J0uCrmJPRh3yWuvXFRzArOG+1CaCnh8TH5va5VKCS/uy7
	h0QqJmNosM7U85DXolK60z6RokJYNfDpmd+Da2KUcvGXvCJskKKw9V5IJQG3uU3cthQAYYEMx1h
	MeBMX
X-Gm-Gg: Acq92OFdyMQUQzIDdC2FSli9kWdy9+f6RwiN7+jLGsORjgw7kw/txpmdJPYPN1pDQwR
	MolhV8vNSmcenNI9/a1Eu52snMHlPomxrIg4LfxbGUGiOCaydsoM7KLDh/fTEOG4SsQZrx93BlY
	+Vuetajp8BclFtOosmg/ZhSNKweDtziDuByTGSWGuoDT0MSSTGoPsyKqfWiqXa3vbMcMcmE3rav
	wKb/hEncqylnL1eScZKNGN9ezhXwcdo9RMqpqQzFJnVZ7m1wixuH/37LibBFn+TCV6DfUb76kxE
	hQLudD0t9rkhnQLsDq7yC/c10/MmPJULSI9F/cZDkc/vT66TJt8Xp2EnJcXPi2xyUqu+VDFj2aR
	XRmIGwJYrLdefjTp8nuJcFYEwCNZb+2vH8vEG3r6Rh1h7TekRhlTCx831pyBHtrNo+HLLOCVJ+0
	bEleyryyuiVuvcPMi8icJz0hx8dW761Fmce+ADXvecNZ0DdYLSjF4ozFknq67yRxk=
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2ba79c25ad9mr107017305ad.37.1778205654359;
        Thu, 07 May 2026 19:00:54 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4050dsm1888045ad.31.2026.05.07.19.00.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:54 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 04/11] scripts/utils: add getconfigdict() for dict-type config values
Date: Thu,  7 May 2026 19:00:27 -0700
Message-ID: <d85e765060f18251c2072ad3d1cb12219a2b0085.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3943

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


