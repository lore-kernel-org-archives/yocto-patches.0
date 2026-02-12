Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF139EB490E
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:40:03 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43484.1770896293210040249
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 03:38:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vg2FOWgn;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: frederikbraendstrup@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so1198711466b.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770896291; x=1771501091; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hpn8LbugVfXrX8fq5NL+Mqt3mdbs9t7/APyNKNujxo=;
        b=Vg2FOWgnvrP+vxaAoeWWQXHRwFvm1x2u0PR10uuvBfUgGGkXVDxs+lCxI0NLs14pn4
         LLDOZSHoSFwGCJiqub3dyrLGZCZ7f3GJ6JbQMyN9J2rrTDQX0G2wUQ/jV5moMuXjt+Ev
         LFYFsgBxU1BmHcw5fQgy4ihxamyLL09zBhglqxETTAsYhtARPe1hrJBPId+gqr0/y34B
         3tWhT2WIsYyVoJFrH520ExU0QrTuvMCt+vhAX4ufYDZSMa/k5ARYEW7CbLQcBGmg5F7+
         Lkl1fOV1dyYGIIMzOW2V9g6f/ydTP+iE+6YNctFXFIpUd509jyhM3B0czYFMtN7Oidfb
         lRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770896291; x=1771501091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hpn8LbugVfXrX8fq5NL+Mqt3mdbs9t7/APyNKNujxo=;
        b=dZ6+pEAsoYOMFOzutrDIf8Hutwr6d/GxVaS1x+PE1Dpy3F+klMtir0XAOKz3bytEkC
         +x1uhnPrB5viPHx3x8i7BHJsBTAK6BxwmzovkTjDEh6AJRQrUoe9QLDIRCLdoYSbbAJT
         qQH7r2dFH2ZbAOPdwKh8EmEMpW+aqGypTvyj/drNqqkiS2SXWRPUGRP/AU3jSHujAaKs
         WpHAthlDklGMGxFneOcDb3ELyvgbhAJrzuVHmennTcxr0BrUOFQO51bH2T/EiRN2/1vP
         5ZiQGhPwcefp5IVbauu9tFeFp/KLzKpvFY/7P1LYT3r1QET1UzWJ0fSMtoXuTpQ887u0
         rv5w==
X-Gm-Message-State: AOJu0YwAjpMGV38Evpimt/6NpxXsBHmiY+8o+5EhHAl3K4fdC5FA2Jk+
	rwPq4MVuiYAYb0HwIgwgvPpwhNWYHlmDlcKRoF8pbjN33RUiTsSySueO5KxGdg==
X-Gm-Gg: AZuq6aKsQ2PsqJnDUJMWWxiutS5jcEvwma9eMPw6eGsbcfZBiXkF7O1Gi/MN+U8WoBJ
	7z7s57S5OGfo5Qv9w09ZZsUeeIgtzzuGm++IPv8VftU6Svzj9LRNSi1G0QaiByMjkGRPbUgdYZz
	6yy5FCKsfoRO5mKcuymthf5qxcXsYrzuPHxpIZNN1o+RGawIVWPlAijS/EKdeGSZIVUX09hoiN0
	7wGPReggIZYdAOFKfL6mZHNf9YtJoPy1d1zQh0rSx2ilPgN2BwCoiIDOmsJuUVzuZi+Pn7Vto6G
	kG0ONbWuC6d4velRdoWG2wUEP+8u+YlV/SIQK2fdfpmNQN8ImngY6OYqA8Oreik078BRu+ME6w4
	AwE859l2e6SsYjV/SV20/09nSz1E9SAALNy6kiVWr0f1jrhr2vpOA9f/gM959KOVo04fgGDNU66
	/PWtdU5ds6jsgaIwg1qUQymg0av4P8AvlC35GAegyNTNP0yDj4PuOz5XhpIqTwPM4gN7ojZe4=
X-Received: by 2002:a17:907:2686:b0:b73:8d2e:2d38 with SMTP id a640c23a62f3a-b8f8f81708dmr122139166b.50.1770896291358;
        Thu, 12 Feb 2026 03:38:11 -0800 (PST)
Received: from ws.taila4487.ts.net (77.241.128.38.mobile.3.dk. [77.241.128.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f7a48890esm129198066b.65.2026.02.12.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:38:10 -0800 (PST)
From: =?UTF-8?B?RnJlZGVyaWsgQnLDpm5kc3RydXA=?= <frederikbraendstrup@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Frede Hoey Braendstrup <frederikbraendstrup@gmail.com>
Subject: [meta-security][PATCH] dm-verity-img: Fix warning when included but unused
Date: Thu, 12 Feb 2026 12:37:25 +0100
Message-ID: <20260212113724.2940142-2-frederikbraendstrup@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:40:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3226

The `get_verity_fstypes` function is used in the expansion of
`IMAGE_FSTYPES` right below this function, so if verity_image or
verity_type is unset, we should warn here. The original warning
in the __anonymous block below, is never reached, because the expansion
of IMAGE_FSTYPES results in a parsing error

Signed-off-by: Frede Hoey Braendstrup <frederikbraendstrup@gmail.com>
---
 classes/dm-verity-img.bbclass | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 48557e9..73297ca 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -187,6 +187,10 @@ def get_verity_fstypes(d):
     verity_hash = d.getVar('DM_VERITY_SEPARATE_HASH')
     pn = d.getVar('PN')
 
+    if not verity_image or not verity_type:
+        bb.warnonce('dm-verity-img class inherited in %s but not used' % pn)
+        return ""
+
     fstypes = ""
     if not pn.endswith(verity_image):
         return fstypes # This doesn't concern this image
@@ -207,7 +211,6 @@ python __anonymous() {
     pn = d.getVar('PN')
 
     if not verity_image or not verity_type:
-        bb.warn('dm-verity-img class inherited but not used')
         return
 
     if not pn.endswith(verity_image):
-- 


