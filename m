Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B705CD98DB
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:13 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2211.1763064847200665022
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DVgFHj48;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8824a756771so12011366d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064846; x=1763669646; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgjDfAxS7/OJDsNVUiv7ijCQ0fd42Q1pORXMFxd63b8=;
        b=DVgFHj48DxVYfWzrktG6Qexjs6LtBOA18ckkShSo9p4ktJLycxilh3HYXd/Z8xZJzU
         /yy20N9PbgZCb7pjvMxdc5k8hwblzr3E2bG1FsnasqO6nowt0E8fKdVdXetelKmj7frg
         t3cjkd6CeqmelBnDQgz3qU/bXv791y91/y5PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064846; x=1763669646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tgjDfAxS7/OJDsNVUiv7ijCQ0fd42Q1pORXMFxd63b8=;
        b=wTrBaRQZA2DPxuob0LJwhLNhk0B/wvQSm4d3xoxVpqCEEqkY8rLnYb2DOK/3sb8jzU
         wMj7fkENQMMvPRLHf8lEAefPUhlo3js/zbMGdPBoBycjMEnywLNykY+NwzObeiYXwrVY
         Z/HC0ATz1JYNJqtVCDzkE9l4Lamy6oUztKYW+JNq98YyRoo4mnoTH5OFZ+HXI+UnXt93
         d437k7unVbTuuZgG9ZlqaHVsaEX2kyYkACk8zTc119gIKcy5i0kJBcuxoSpTKZYWXLAW
         5rxqjFLay4P023dIncNxvytrdX6ULpOrklGAJQHEo8UxPwP1wfYL65wLQ3KB9x2aPhSH
         UCfA==
X-Gm-Message-State: AOJu0YyFQXTDHIw6fuAn+dF3U8aaJDkrc7xZxoJmhONvQoWUWpB/f4z7
	acFfZaLYAOSHvmoUw9fhRkOo9x+Jagjfj+OVrF6cObb5szi76XPMberzvJfXw34TCA3JLgSqLWg
	II/ub
X-Gm-Gg: ASbGncvgBJNuZQdGRlcWLEAAOFV1d4UGIFEESjqOVKrZ+BvGLPPpFBhhNyZumt9WV2u
	5qI+1cMkOX9TJnJ/hMdvsW9iKubzehrBWs0dE3r/73UrHzUFggTuMm9y9b4WpB1xG6V4V6Q24cx
	5jDCBS9SIyz9Dgdc/WfMOhF00qhQJtrPLJZzs+jbOYZ0jgZLpaA78kZWVElHB5qAMBQYZJuUYTH
	uRE3ekqAYOhEC2hdsTDrzEDmz5ZVUDjT45875ZoNAwOMXmzuQ7W9+ervgs1BsDp5LBdvUHyP4jx
	J3EahP0fLVWc0cC4N9/Z41qkyysitehP9LE+h6zdkgzd06OvfcLCJ89uX2loAteegNog2Qa1k80
	VQ6AyybZbEM1IZxLTqT6GXj9MUhECojTgFhtfam5NPNmpREk5dMBWwgC9/gSionkxuMo1gjwIlo
	2R83oXyykzAdCpZLRWAoo9XuJHVVKDWPAA4aeZ1vdS+cITz5fbD7Uf
X-Google-Smtp-Source: AGHT+IGILVot/7Hgiq7PwZ/d+PmU5z711eotTtNqQzuVQzhj25BHL1C8zHRaHv/ZjYOqZliPMxWZXQ==
X-Received: by 2002:a05:6214:27c8:b0:882:6b8e:3143 with SMTP id 6a1803df08f44-88290f40124mr17313856d6.18.1763064845860;
        Thu, 13 Nov 2025 12:14:05 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:03 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/6] Update kas configuration for poky obsolescence
Date: Thu, 13 Nov 2025 15:13:37 -0500
Message-ID: <3045ef984a8cf996ebe2cf246cbb2a354f84ae34.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763064477.git.scott.murray@konsulko.com>
References: <cover.1763064477.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2545

Replace poky repository configuration with separate bitbake,
openembedded-core, and meta-poky repository configurations.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 kas/kas-security-base.yml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 17f4bb3..8954896 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -11,11 +11,22 @@ repos:
       meta-integrity:
       meta-hardening:
 
-  poky:
-    url: https://git.yoctoproject.org/git/poky
+  bitbake:
+    url: https://git.openembedded.org/bitbake
+    refspec: master
+    layers:
+      .: disabled
+
+  openembedded-core:
+    url: https://git.openembedded.org/openembedded-core
     refspec: master
     layers:
       meta:
+
+  poky:
+    url: https://git.yoctoproject.org/git/meta-yocto
+    refspec: master
+    layers:
       meta-poky:
       meta-yocto-bsp:
 
-- 
2.51.0


