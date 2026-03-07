Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1234FC9EED
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6854.1772879418237306464
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HhOJ16Ut;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a133cdd4aso56794846d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879417; x=1773484217; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14OPcfiAbDG74HChmLSdgIawGkkN8YDoRBA2KOLwm+s=;
        b=HhOJ16Ut/CYz8zi/S7RbBWD1vh0Nxino1T+sQwv4v4dImOoOiSkRH50B0Ia6th1oMV
         PZ4V8O9a+ZS8PZVSKZB2NvMQh1q/KK/9Mouf90nSwMkvnh5ArSk/4tEHR1k9A7Zsv3br
         33hTdJJSJgrNLC2lSdBncwfosO+Jslh3ICcL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879417; x=1773484217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14OPcfiAbDG74HChmLSdgIawGkkN8YDoRBA2KOLwm+s=;
        b=jclcre9umUMmiohtSYZlb/IguAnX+SgUSaGST23QAuF/8KqzYGTPVyz7AnvUnK8fPh
         20ryV5RalRCgDUPRafz+K4LBq5SKSgnufprmNPUr/YKNMEaNpD85bIr0TweFserr5Rdz
         U+E7G238Tq7L7vEx+KVwnk/A7RHZHi0vQzedeV1LzqUV9A4BKOFKRxliL66wM+rI9VsE
         dBGNOx26sTPXkLketWB9AEcydmG2HoA8uQrfz+J/nDC7ScrUzQip/wp/sO4OIbiOMUgS
         7WeNWxh1wdjhgIBiP2BEMNyI3uGVxvyYs/+R8yrNw87ckLxLBIg0E1Iqo6SBXnTXZ9TE
         YIdg==
X-Gm-Message-State: AOJu0YxuM93Xm/dJGlaDNMJQTCbLqxjSf1remkqM0fcvfFZUVlbBHyDH
	afVN9WZSxPQc8nu8JWbygkqGWeY396OuboXTkXJuC01bnpBWbM7IlqOHjMoRYoUToa9u+QVKJEy
	NKkMEXs8=
X-Gm-Gg: ATEYQzwjOepdFdoTgcV2+hR/HLsUp3b54pJ8eGfiAP2J+1pKRU4FChBFL6yR2DzmR3y
	PfUbtUoehaP8e2Smhc5d5F0gYXKLag6eSvJ/Qbfifpb+l13E8I9nTVVPYETdD3BFWM2L9ocETO6
	yOFcYI+QbdIG2U4nDfYfLWr5MNSuXFDewf4PS3Lv15pAVO0QCy40VzZF1nl0QA/g83oAKhKmv2D
	7GOFzZksZalh0wa6jk6QTShNlT+LtMyMVJwAY4nFXEE0INZzidElQa0a0RYB7AMTaHMTWTMoUca
	aCLSIklBhOWDoqa0UNHuYgGy1p5uC2umKyfAFkMfnqxbJ/BKmbFH0hGjOT6qgAQPvnsfeyoZzKy
	MgMUL96GCf4VDEFPV+em2O2hizPg5EV/s/YkfTFNFG8VZgjujxYr1bk7Tz6Rjj9NVhR3I0vHc3r
	ksxdMJ/5F9ODAcTsOxLqJQX2fQWjvf4CgAL6w+ZOrTmh99K+h7FU5HngyLqOZAoJnxI5DD+xn/X
	vtN8OeC1m8KzxrWQs65nwBl+n+oL3+5baM14ldVhr1BPLAfCPBd9U4Ro9MkkFO2
X-Received: by 2002:ad4:5de3:0:b0:89a:110f:894d with SMTP id 6a1803df08f44-89a30a80aa7mr77120546d6.30.1772879416985;
        Sat, 07 Mar 2026 02:30:16 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 5/7] fscryptctl: Correct the spelling of DESCRIPTION
Date: Sat,  7 Mar 2026 05:29:59 -0500
Message-ID: <f79853e907d5f11ca78529cebb47b6eb38234b8f.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3370

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
index 81cc1ea..4c9b99a 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -1,5 +1,5 @@
 SUMMARY = "low-level tool handling Linux filesystem encryption"
-DESCIPTION = "fscryptctl is a low-level tool written in C that handles raw keys and manages \
+DESCRIPTION = "fscryptctl is a low-level tool written in C that handles raw keys and manages \
 policies for Linux filesystem encryption (https://lwn.net/Articles/639427). \
 For a tool that presents a higher level interface and manages metadata, key \
 generation, key wrapping, PAM integration, and passphrase hashing, see \
-- 
2.51.0


