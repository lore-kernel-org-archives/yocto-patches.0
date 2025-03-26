Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E68C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 10:12:48 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.18730.1742983967170554721
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 03:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WkDRu8Nt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39143200ddaso3803474f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742983965; x=1743588765; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBd70F6qSeaHtnUxI4SPp1AyLzOxxiq/wVKqW07asdw=;
        b=WkDRu8NtrWw3nlpoBQSDMdyUtd0y6b5hin0iBC58/6L0MvDQU+SIx61wdlHGg2ktdM
         aUXRQYsVK0iivV/w+2D2IGgp+qn1DjLC5coHubX9CIpX0pI2iysqbOA6cosZ7kYPMPVT
         cZib0Ld4fOOoMjlMxXTl5nukxNwczNq3Yr42M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742983965; x=1743588765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBd70F6qSeaHtnUxI4SPp1AyLzOxxiq/wVKqW07asdw=;
        b=UdmWjJhUVH0WQjg8xTH+Yi0GaW6obAFU/2TPBH9CqmBSoBK3aydFik2oY5kJcogmhh
         ZfBSslNTo2wR87+B3kvVyuvhQUtDHHZGrmId6Z8R6pmtVdehhSE/RFZiBOyP9aNH90Ip
         e2YaUIS99lpVhjdV4ue/+oIZlcfvGgKODoI1g/zLXKvJQj1T/ais9FBPnPnnWKdrstu0
         owgDMdQ7AllQ0yXyrcV2e/Vuxyp8d8pK7D4N9oa6CsCgK9m6EYpCq06L5W/WCNZKc75n
         zAFdzCtDLLksd4YY6W3kPrcBbgmWUorU5gxiN3TGi3Orrqc05mTrWNxtjR8NrX2s422A
         vecQ==
X-Gm-Message-State: AOJu0YxkG5wY0u9j52ROCWZ3GgAypDCDbWPM+rkXpSwKvNMrkrG1ur2n
	ZCKekrqSwU+w9InMGy1kTlA/pqF+rZSqHNHiv4oxJPNObSaE1TISgT4DrMmP9FjgLthMCw1x734
	F
X-Gm-Gg: ASbGncsyJhpGqzNDFOwxkOeqJnHbH5Js2mQd/LyLFC0PvYw/+Tb2SsfHcdhmzd5j49N
	W+GWZJ1yOC26pUxx2jKxrQVERszWxOx3PlzmOj+NqVPMbdyEXPcS1M2L0h7aqEdUvFnTt6+k7RC
	lVLz0f1EDBinWkc+N4gwJEQ6BDi0LUDz+1V3IAkNEXs6OmtbftBF3Z3Bwj31gmkqbQ411dPTEUA
	McD9Z2RnRKb/objDAUeaoKLxy8Rxn8XXExB/usF3ShadKfvYZvyqffh9HCYmyrsiC8oIVbRU9gL
	Q55cC4xhrjU5VR3pUUm3Xnf1F3V2MNVTZOLhqZONv1GyQ6ey7FrOLYc7jL5FKAOhdm5XjVNfvA=
	=
X-Google-Smtp-Source: AGHT+IEYMWY0NU72YZsgGC7BqoDJ/9CKm5l+u9Zuxh5yNwjUJiCy4OALFAaVRmGA/xeOkE79ELMoAg==
X-Received: by 2002:a5d:47c6:0:b0:391:2e31:c7e8 with SMTP id ffacd0b85a97d-3997f8f607emr19350317f8f.2.1742983965018;
        Wed, 26 Mar 2025 03:12:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef098sm16051010f8f.84.2025.03.26.03.12.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:12:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Add musl ptest target
Date: Wed, 26 Mar 2025 10:12:43 +0000
Message-ID: <20250326101243.712575-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 10:12:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1253

Add these for testing, unscheduled for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.py b/config.py
index 74c7c0a4..aa5db9e2 100644
--- a/config.py
+++ b/config.py
@@ -144,6 +144,7 @@ builders_others = [
     "qemuriscv64", "qemuriscv64-ptest", "qemuriscv64-tc",
     "qemuppc64", "qemuppc64-tc",
     "qemux86-ptest", "qemux86-ptest-fast",
+    "qemux86-musl-ptest", "qemux86-64-musl-ptest", "qemuarm64-musl-ptest",
     "buildperf-debian11",
     "buildperf-alma8",
     "reproducible-meta-oe",
@@ -296,10 +297,13 @@ builder_tags = {
 
     "qemuarm64-ptest": ["ptest"],
     "qemuarm64-ptest-fast": ["ptest"],
+    "qemuarm64-musl-ptest": ["ptest"],
     "qemux86-64-ptest": ["ptest"],
     "qemux86-64-ptest-fast": ["ptest"],
+    "qemux86-64-musl-ptest": ["ptest"],
     "qemux86-ptest": ["ptest"],
     "qemux86-ptest-fast": ["ptest"],
+    "qemux86-musl-ptest": ["ptest"],
     "qemuriscv64-ptest": ["ptest"],
 
     "qemuarm64-ltp": ["ltp"],

