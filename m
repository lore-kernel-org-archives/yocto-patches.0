Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE9DCD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 14:38:30 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21956.1780497509390049850
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 07:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E0k27dvI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso119785435e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780497508; x=1781102308; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOEss+xZrIxou8+/XGs/y1kXw8c8bw+JUwNlCFA/aiA=;
        b=E0k27dvIqDStXI2G0O9PM2y4bZqLbKlHZBhJD232dFui+eTuEeAj6LlydGNc7E+9dQ
         qLrX1+KF0GMWmETAxhtAe3PHFyxTI8yyP0J0s38LDXJ7/dy1NZSOjXw7yiGb7DIwi7gm
         fs11OYeAlX2b+CerALvMycotNiyduziyy5ghY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497508; x=1781102308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOEss+xZrIxou8+/XGs/y1kXw8c8bw+JUwNlCFA/aiA=;
        b=XhITAxv/3kUrVv63UhMzsc0KDQj6YrmhJGzUTkKX+YjHgtNxtw0YUYmdlQvfX9JK0/
         5HVvU8K3wkcsfbIvBA/i01K4tPNAWC2dH/kQgKT0hEM3aP7Gk/jKvvED6OoeQ/E6JfWe
         Kp2KnGr7JY72wr6wplEeawtY9PPcKHvbxUPAIu2jkR0xrOA2osrTnAssRFHRcrd/3cYt
         dMvMK14PEyT/R295NZgkkAAzolAhSJRb8kOZ9jck24yNCogwapu6j6l16BO/H/HbcnId
         on8ov1SWlZcp/SJVsut71grQDzhRhZeHzDEC5nwWB5s8S539SB84Hvr6bVgRcGr/VH/Y
         N4rw==
X-Gm-Message-State: AOJu0Yydebu2ModLd7kfYX/n7Sm2BsyOUm7nK2LmAkp1J2vKe/eOmuDd
	r1w82KdElpkgvpc6cCTgZgXAx8ASLavfd6NMtki0QEaLDL7tqP5g+YkbLEF0OhK4KKM112rVeqV
	vFX/R
X-Gm-Gg: Acq92OH3CAuXEf4kk9Fk/auknfyIeZBVA6OAgRyh4hkzoE/+EoaPbSnTt9Q/PKtKxOX
	biL2ITBddciBIMlZjyHl+LcLwbCIiKDhBCrc5rgbHwpTpOVvgB5zK4NNjNvmdTW+NrRVa4hMOSS
	/L6H8X+YoUDcm8r9JEbrhzdPCO/0z6SqHhlwFBJfZRKw6CMyWeHheaRVi1/2Ytskl69YUHx3P+o
	W/MDI/2Z3dD3PL9mgnNvo1ncP3NbjoqnmAv18mBB94LUJoEgXP+h1EbRm0y2SYS/LBXaHwP7Pwp
	Qyv1TatKHGie13qi8pTWq12QYeMhdX+fjKF29cbRhz8PPbFmM864hO0LysM21Ps4uKE8pqSlGL/
	6MVuw33eWiNqaqDyKmWMfa3TJlTcUScPFtff7K/qw/RYdS519icVfR3zC/9yIqd40uNqlCJacnI
	pyAK5g9UbwWs92ieQbH9vEZp/18hxBkebXR4bhi/66wQ6lDL3rSK5XC7T0u7wJAuPZnseNsAXV
X-Received: by 2002:a05:600c:5288:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490b5ed01damr61859155e9.28.1780497507597;
        Wed, 03 Jun 2026 07:38:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13f91sm183916845e9.3.2026.06.03.07.38.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:38:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop i686 mingw support
Date: Wed,  3 Jun 2026 15:38:26 +0100
Message-ID: <20260603143826.1280990-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 14:38:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4119

Most users would use the 64 bit mingw version now, drop the i686 version.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/config.json b/config.json
index 6df21d4..ac2e933 100644
--- a/config.json
+++ b/config.json
@@ -1409,9 +1409,6 @@
             "BBTARGETS" : "core-image-mingw-sdktest:do_populate_sdk",
             "ADDLAYER" : ["${BUILDDIR}/../meta-mingw"],
             "step1" : {
-                "SDKMACHINE" : "i686-mingw32"
-            },
-            "step2" : {
                 "SDKMACHINE" : "x86_64-mingw32",
                 "SANITYTARGETS" : "core-image-mingw-sdktest:do_testsdk"
             }

