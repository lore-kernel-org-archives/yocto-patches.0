Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE48D12D49
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 11:39:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13175.1764761939118562841
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Dec 2025 03:38:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cvD+qltf;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso76419755e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Dec 2025 03:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764761937; x=1765366737; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWCdvGnYoKSoijXdiE97i3XhBvzXBBvA+mTZhswMQvI=;
        b=cvD+qltflHH4jlnhqOpkpLdtw5loLkKAXAF1TewCInN5OY/tzz6V7hlflpGBmMnPmx
         411uAp3eITTlFWRsaxzSnfs52W6XuYlNxcQ4uUOeOYIDnXJ5bhih/ebUFvE0bBXTiSgU
         lns9vbLovGNQLmQCREEqy53wFJD8jGPZLaLii8ZlulNla33U17NIO78cY9TUImeVpdCb
         FfbIwryQApeXzxuUZIspoXM8DHQ5qW0asVXcy00SLBVmKzJAT45EuWIgPi+VYpifPl1f
         ZSRLy5dGTgt9FKoOEjRe6ElllOv0UHxlt/Nw1fFPjjRaRppvDlKUxCCIUqXhyutz6nnw
         XEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761937; x=1765366737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWCdvGnYoKSoijXdiE97i3XhBvzXBBvA+mTZhswMQvI=;
        b=IlBAEiBRQDvN1AGS/jH5K4sm6PxFqkkxd3UjfCrtRsacbBkPcuAm1SJCE1xzGAzXzf
         Kh4pOGYTmtN5g0M+gbLTLBSPerdoYfTZhtoyb0Bo//qHFnecBNu5cnVl166cBBv36i9P
         whE/Am4RQrCx6u/5ZmBqc1iF+pA1/wCdcc5kuw0Gz9/2xQfjMGx0GzTHAE+QpN9tqNHf
         wId0f+/eLJ0YBjwu1AGchUpX3OtoQW+gkQCjBgAjGi6GkbeYE/C8SMXgOxhRfCsec3yQ
         Gbc1NJ74jqhfSHi2JvnX2L04RCsot2e2nmWDElZaTntjKq7wfJU+Wei8yTGcGrO4b8RQ
         oZRg==
X-Gm-Message-State: AOJu0YyzOGFpVnjGVY0Vissm4o4Me6ssNWTGedkOsj3Z4tS3rtR9R5PB
	9WwOQgNE83Nb5F9HIgutOOXYrdxRswuCDxsU+0p/5YhW9FHudPP8x/2f5NiPJA==
X-Gm-Gg: ASbGncv2C84mp+jVIPNoSNMgjfcXvtwmkpJGPZERU1OEZ0fGYWFH9QnDGr/gkImvGJf
	JNxef0nWSxdeXFzJuHtcOHiuftORzzOYj5NoKlkIgvDXaRm9BNxeG6219ru3Xxn/PP0ByeVl1L/
	KMRs5LF/7I2td3FrRKijB77llxSGWIUkNlIK6c4UbKVzeTcZK0CA3RkdsjuPPYf/8ACJeBcyaLZ
	GyNGZDACgotM6fzTU138EfjVKqjxkUbNd8NTBdVn+RuAQOmqHwjg636+JoX2cJfmU2j1RvouRgF
	k9YnV8FqsciS3JutIIsjUvvyO+hB1v5T7ZOtqvB8Hq90O4IAiHlQk/RYaF7SRAeIF3pBCK4wzqz
	7Be9vD+5s9GRa+SgXmPqdajC2pNeekxBIKX+n3sSHo7ICCPpB7nA/9x4YS6rHOGMoVT90X2Z2HO
	09CZHKilyeMfvBY57FZFIbMuGohzFQLCjZCU0lebb/i/RUyHw=
X-Google-Smtp-Source: AGHT+IHRKczCIz2j89NsjgmW6H4eSb5dQpF8Q8ucqrwp1PwmhQAp2yzF9zTMG20HeuZg8mglK99J1w==
X-Received: by 2002:a05:600c:4e89:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-4792af48329mr19383135e9.32.1764761937205;
        Wed, 03 Dec 2025 03:38:57 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a79760esm43909905e9.3.2025.12.03.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:56 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][patch] modules/bitbake: use fragments to set machine
Date: Wed,  3 Dec 2025 12:38:50 +0100
Message-ID: <20251203113850.3989164-1-alex@linutronix.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Dec 2025 11:39:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2735

As the autobuilder is also setting machines via fragments, prefixing bitbake
invocations with environment assignments no longer works.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 modules/utils/bitbake.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index a5fc6fa..32c234c 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -124,9 +124,10 @@ class Bitbake(object):
     def complete(self, recipe, machine):
         if "_" in machine:
             machine, libc = machine.split("_")
-            env = "MACHINE={} TCLIBC={}".format(machine, libc)
+            env = "TCLIBC={}".format(libc)
         else:
-            env = "MACHINE={}".format(machine)
+            env = ""
+        bb.process.run("bitbake-config-build enable-fragment machine/{}".format(machine))
         return self._cmd(recipe, env_var=env)
 
     def dependency_graph(self, package_list):
-- 
2.47.3


