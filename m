Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E48CFD64E
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 15:06:36 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7899.1767798394694782818
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 07:06:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lGLkOJkV;
 spf=pass (domain: konsulko.com, ip: 209.85.160.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ff4acb6eebso1394425fac.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767798394; x=1768403194; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI0yPXRV/evikperq6Q8CsWur3ENe6yy5LSAnaz+It0=;
        b=lGLkOJkVotAstPsQxuPHA9/MDmWswifqJTsgC25wMjLjh4rvBSz2sbsIRUq/PCQR0i
         dZurT+192HBdOt2azqiBm5Ld4aEcnuz58urqWs1Uqf6+ZroQVBG0oHrXfsx9R0gUBgdi
         s8rA+SacQS0u9mdQN0ldGZNPjYUUeixuVylfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798394; x=1768403194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NI0yPXRV/evikperq6Q8CsWur3ENe6yy5LSAnaz+It0=;
        b=TDN0dOEOeUMYWJcW8WeymOX9m1Yj7GNu/3GrsMmvXubFbhBQ8NeUuNvg7H/cRbqkUE
         p0hCv6TlvXoFZKOvER0o6Y5u8dDLz8v4Wl3BLRtC2DuCTbF4rH6AbnFv9t/46T3TQCZ7
         jrIHqjwbIC9hWq7g/MdYUTYWL3c4NG2id7vO96QzAUQhMhgVHbcS76O4REOGgX2PmN4n
         zZ2O1jHLx3X0XOhrGOqhAa0AP4B6jq9nI3wVZi4Kb1/wJP3xm/qdGxlHqImGatTusPL8
         Ja2CZ1f9LsJyBEIB2E14xtvUaH/fUNK22AoqJlE7sAqsk/x1H8JMWdPzGcvhUOMRH3Kg
         AqEQ==
X-Gm-Message-State: AOJu0Yxg/UXKZAP/ZDUDxASzWr/SnXiqrs/KST900TJo7kin9/RvVvUX
	N+OY7QtVojJxP5Iwlxf2Noqr2emgkrZbYBWemj2DJ4joYs82L/Fh0zXcPMBDSNeaXAeZxchPrCf
	FiYlf
X-Gm-Gg: AY/fxX540YKEaPVjiWXzbtCRabI/+I9Zv/nApnKv7LcQiJOPo7e6KP9D3hibHJULjOI
	hl9cX/NCNf2qiiDWJssGrwTNQRsrV1ROr+J6r9OGo82O+kFEr8hoj1CY1dxErTFUDzOmfLFw7Iw
	RxGZj3iBovZ9nKbxXw6r6HzFaqauobIOzwma9KPEff20Lf4gH6Zwsyd5+GAw5Cwv/GOfUksT6H7
	nkpVMRSl5Cuj7tu73xC4w3/SiNLnoN6PQ9mRPvJgALWbdvGvxOUSyYxXpCIX5L8Stj1RdXy0CX3
	M+KOpwTypd/XekqAPjS4C5KjfyDbu9NaDfMk6aglVA4fDpx8g5WT2+FWg12djob+7/qjGL0BA27
	8baHXkiqwE6aiGONOrj2a55oRJ7aesNmM6/B9l8ZDEGm7j8Nt01/ffFQvvYdPQpVtdlZpOJE3QY
	Idt+IivS8IJ/byLCrM0Z+8Df35nwCpdbMOeM5RwWqIbTWZwXE0O/FD2BPgfFwiCYnS8Px/C794J
	2ZYSm8vtPgPylCLrSIaZpRLePE+91g31BIhHMqzX2Khu3LXZJ96
X-Google-Smtp-Source: AGHT+IEacILGCCmwMk5J5OzYcizllgsn+4ThM88FOT9c7x0TDpDiJYTZKr/XKyHWG8+8IOQJ5kU7GQ==
X-Received: by 2002:a05:622a:283:b0:4ff:b2cb:a44c with SMTP id d75a77b69052e-4ffb4a7006cmr35173281cf.83.1767798027389;
        Wed, 07 Jan 2026 07:00:27 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d568cbsm34113551cf.11.2026.01.07.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:00:27 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH 4/4] Update kas configuration
Date: Wed,  7 Jan 2026 10:00:09 -0500
Message-ID: <b5192f58f4926aa08c338b899221cc2121056bf1.1767797568.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767797568.git.scott.murray@konsulko.com>
References: <cover.1767797568.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 15:06:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2911

Changes to catch up with current kas and future-proof a bit:
* Update the kas configuration file versions to 19 to match kas 4.8.x.
* Change refspec to branch to remove deprecation warnings.
* Add quoting around URLs to match upstream examples.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 kas/kas-security-alt.yml    |  2 +-
 kas/kas-security-base.yml   | 18 +++++++++---------
 kas/kas-security-dm.yml     |  2 +-
 kas/kas-security-parsec.yml |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kas/kas-security-alt.yml b/kas/kas-security-alt.yml
index 8f754ac..2a449c5 100644
--- a/kas/kas-security-alt.yml
+++ b/kas/kas-security-alt.yml
@@ -1,5 +1,5 @@
 header:
-    version: 9
+    version: 19
     includes: 
         - kas-security-base.yml
 
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 8954896..2ab81aa 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -1,5 +1,5 @@
 header:
-  version: 9
+  version: 19
 
 distro: poky
 
@@ -12,27 +12,27 @@ repos:
       meta-hardening:
 
   bitbake:
-    url: https://git.openembedded.org/bitbake
-    refspec: master
+    url: "https://git.openembedded.org/bitbake"
+    branch: master
     layers:
       .: disabled
 
   openembedded-core:
-    url: https://git.openembedded.org/openembedded-core
-    refspec: master
+    url: "https://git.openembedded.org/openembedded-core"
+    branch: master
     layers:
       meta:
 
   poky:
-    url: https://git.yoctoproject.org/git/meta-yocto
-    refspec: master
+    url: "https://git.yoctoproject.org/git/meta-yocto"
+    branch: master
     layers:
       meta-poky:
       meta-yocto-bsp:
 
   meta-openembedded:
-    url: http://git.openembedded.org/meta-openembedded
-    refspec: master
+    url: "http://git.openembedded.org/meta-openembedded"
+    branch: master
     layers:
       meta-oe:
       meta-perl:
diff --git a/kas/kas-security-dm.yml b/kas/kas-security-dm.yml
index c03b336..fe74d25 100644
--- a/kas/kas-security-dm.yml
+++ b/kas/kas-security-dm.yml
@@ -1,5 +1,5 @@
 header:
-    version: 9
+    version: 19
     includes: 
         - kas-security-base.yml
 
diff --git a/kas/kas-security-parsec.yml b/kas/kas-security-parsec.yml
index c44a280..54bf96e 100644
--- a/kas/kas-security-parsec.yml
+++ b/kas/kas-security-parsec.yml
@@ -1,5 +1,5 @@
 header:
-    version: 9
+    version: 19
     includes:
         - kas-security-base.yml
 
-- 
2.51.0


