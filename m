Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7241C43602
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44674.1782911622353582554
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DB6/NX9A;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4759b4f0897so497029f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911620; x=1783516420; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+U3eiOeCr2g65PDVF8GsNmdiKfsmjw8wbsM8L7dweA=;
        b=DB6/NX9AD5gLp9tY2iT8paxGulPYrgBak0qgQeetwTLpsG9qm0mISVgnb4g5YbfGrv
         rA+OgAYSx3VR8gO2NRiCExF13KDuLb7FuenqNCNTni/DKeyPOARD4nFihcdOJJxoMqZb
         CIm5r5vMcdgCKxGydMXv1chSYfLh0F5hyWl24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911620; x=1783516420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+U3eiOeCr2g65PDVF8GsNmdiKfsmjw8wbsM8L7dweA=;
        b=papx9HV1sekvX5h8u5nttlvx8L61tZBVzj0bCsqg/aAEMq02RS/PsLejG0b4Mc5Fwj
         5cnUVDhboC1rbfzgswKdkIGq2qY/sGSo0RBhHY3fx3FtBoQGPRxcLa0yipaxwTQsgtpM
         JXEAKydwtVEFPCosKhIh+w1E6P3OJIbDZge1+m49wfvgNIRCtmWStpJx/IhEWrQR/2tj
         N19rS+/+IbGnHUooUh2a7oP1+ZyD+PMcI9SmWOUkheQ60e/undjNgGGHvGTDoEge3CG9
         rElrpLwzNL0IjzIF8TdXPOM/SSkaENP8GoDkgNRo5jW7qYe2QD1obj7Md79jw8xUusCI
         rlvg==
X-Gm-Message-State: AOJu0YxuoSWdrybXOcmKNow+I4A1zAmCU9y3M82ulRIz9AqRAbteg6fZ
	7ejXAdY9wy5mGR+J386cTm1kQWEOq2Dt5yIBSMZYnVZfXvJVhwPJR6kLQf/GZnzHigBeOSP8ltS
	AuaUW
X-Gm-Gg: AfdE7cmWC60eLVs2jtYeKiFcJuNbucJWMb3GMXSEYUocnLdKOZpI/QQ0iM3mn1235jY
	B6n8m1IY0nRqZmrBO+hxT2osLlqh7LnXQYyWXvMRhpdrreH98eq/xmXbttXdgC//+7QNWfTRYLt
	5aJkmi12v4cIgCFp8Kt2e2Tf72KdzbU7zGR8A2caDLveOkOQgNjlVGLIUYo2Bs2qhpyw2eUw6+4
	Xbh4aD0/Z0hn5T201czrcEFiggIyEZ7jRZCFPAU0utgF4YKTHXwnH6RLChXSr2DZRBiHVwOquB7
	45UghLl7SMIX3wOc7ML+PGajllF/R2K3ML4ctHt5v8YmDdOC8jolmMo+1qEDxj+U9wepfxr/y3w
	bXyfOqRP58FDqvrcHYNdxTCuyMTT2pByRiS2xQQ0fstM/6Hlf78rNQejNQoR9sy66SVeHQpZkPf
	+vd3YX9PHwEAxQKtkesNYAAHT/G8Qysu3+t0GbbcAnPQ==
X-Received: by 2002:a05:6000:18a7:b0:474:d7a5:4b6d with SMTP id ffacd0b85a97d-477b38897b8mr762972f8f.21.1782911620531;
        Wed, 01 Jul 2026 06:13:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 3/7] pseudo_util: Ensure pseudo_setupenvp handles memory consistently
Date: Wed,  1 Jul 2026 14:13:32 +0100
Message-ID: <20260701131336.3578279-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4345

Most of the new environment values added to the new environment array
returned by setupenvp are already freshly allocated memory. Ensure all
the returned values are so the data can be handled consistently and
correctly freed (for a later patch).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 9cafad6..126746f 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1197,7 +1197,7 @@ pseudo_setupenvp(char * const *envp) {
 		}
 	} else {
 		/* keep old value */
-		new_envp[j++] = ld_library_path;
+		new_envp[j++] = strdup(ld_library_path);
 	}
 
 	if (ld_preload) {
@@ -1228,7 +1228,7 @@ pseudo_setupenvp(char * const *envp) {
 	for (i = 0; envp && envp[i]; ++i) {
 		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=")) continue;
 		if (STARTSWITH(envp[i], PRELINK_PATH "=")) continue;
-		new_envp[j++] = envp[i];
+		new_envp[j++] = strdup(envp[i]);
 	}
 
 	for (i = 0; pseudo_env[i].key; i++) {

