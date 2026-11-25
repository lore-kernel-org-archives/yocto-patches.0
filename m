Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3059.1795645894468861111
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VW0o2li3;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d6deecef6so63091791cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645893; x=1796250693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OZY5AJB5zfrsf1ibLz9AdfDIDfEmxerHaim1z82n0rY=;
        b=VW0o2li3EBFehNMBd6Kofy7q0233mMBzVTPbG/Ae63/i+hnFmUWPZwOj+ZWSH3zMRo
         um4ppwiy4Fgr8a7IGM4b6k2nFrmRVvi9sT+UmPuKfQKp8PytYeykGEfBzvgy/rIEUS5h
         gO+0KlnA7G4X4T8ssFl/L1yXB14OVK8CLrmGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645893; x=1796250693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OZY5AJB5zfrsf1ibLz9AdfDIDfEmxerHaim1z82n0rY=;
        b=u86NreIuLuUXCDgW2IbGhFNyPMEMGCcX5zKmvMECVYRU/ti6W3tJNabzFN/zWe1BK9
         7+2m3xoBnZn0rb254VJAfhVHsgY9u9AoOP0pAuYDsLLdzlPPnObTLwCuacbTSutIda4c
         W10/21jircn4kZSKnzpA8rUusnMwjX5hwGAQA3ROVpB1eJ8j329VwvPJ61oIXXL9g8gf
         IH/2Djha213kOHhGrucGJUVjs18CSGnTQP2ncUxbpqAKif66PSPxpo4hZ9DaqmVXowVG
         AUBH+8gNryCP67Ibmqy0Zis9afo1i0HLCAnt2Z54CfKNF9ySirCp3wJHmM3dzJAzRh9P
         SFTw==
X-Gm-Message-State: APuU4Z/3CmyocyQ61/887XrRCORKTkALGiDX07YRgGaq7WCBGDiOI9YO
	ljDXgX2Qq8dxpGxJi6xTBG3kP4y3cWykzxaYNHP78zrYcaCTUkl9cQUzi0iiRr3eVNXRKb4KCod
	aDDI/
X-Gm-Gg: AZFdTZf5L1EudKhFdY02vAAvRyYSpHDfOen0H+gKf+EkLiLhO/oTS6VgeJr4cUvwZ2D
	3CEka4A3Z1Muj+UosWHbVqGv2psIw02kNaIE2b3Gaf7Ddu89z6AUpcklozsYycLxYAbvPa5gs0n
	OTaXT065zRnLSWkjD0xwLMysXN6tVuvjnUENP8OXInx9JEEaJdP/tqqLDwZL6zAF+1c8oVLkOKA
	vPkFKeuw+Je/y39mKDVSqp6GjQf4V9G+ReTMiy1Bu/Bf0zFLZ6s7GzIkGRr2luDAsC/qulhqial
	dwe2o3fHJKou11cyWqK2NgN5zlip5x7cjz03INPKXBOu7mbQQlFRG2zdON+I9Wy5PxpuWxougK+
	dKMxZewGMpKpSS9Kp+8ZEKVvCe4OuqMhF202YgwVREc9wA1SLWgNaFzW5AalZ29eDVF5AIMUAtD
	Qp3NrvGaNvIe4VGrLmXmQ32p3h+rKUJRpe2QNezog5Jr407cNI34S/0z2TmPhj5p2uweAa4pAXL
	qnzC1ZJa3FesYXw80DJXPd/7FykEqKU9QdU1MGIgjJP7hu8qWaM8UCBAZHruUphYObWOSf0/Juq
	spYgg0Hnu84SuL/P1dMl9KGOPBilyiD2DhMmt34+nZQXKUHV9Y9JfsBncT07b/g7nEwY06IgLYR
	HtVRLI87XSso/9uy+p39oNX/Jf57esQUfc4T5WC6CcS60pAsbUDlw7sRNtJD/yc2bsw==
X-Received: by 2002:a05:622a:a0a:b0:533:a4a:8826 with SMTP id d75a77b69052e-55d76a17061mr339336721cf.19.1795645893142;
        Wed, 25 Nov 2026 14:31:33 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:32 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 13/19] rust-target-config: fix invalid +v5 LLVM feature for armv5
Date: Wed, 25 Nov 2026 17:31:04 -0500
Message-ID: <ed05d85c1d4c3f5bb3c651dee110a648974cd296.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5531
Content-Type: text/plain; charset="utf-8"

From: Hemanth Kumar M D <Hemanth.KumarMD@windriver.com>

llvm_features_from_tune() emitted "+v5" for ARMv5 tunes. LLVM does not
recognise "+v5" and silently ignores it:

  '+v5' is not a recognized feature for this target (ignoring feature)

This caused the Rust 1.99 compiler-builtins build to fail:

  error: invalid instruction, any one of the following would fix this:
  note: instruction requires: armv4t
  error: could not compile `compiler_builtins`

Emit the valid +v5te feature instead.

Signed-off-by: Hemanth Kumar M D <Hemanth.KumarMD@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4318e4ab481fce959e0d40ad03446d24917b196c)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 8398ae5..b62bd43 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -53,12 +53,9 @@ def llvm_features_from_tune(d):
 
     if ('armv6' in mach_overrides) or ('armv6' in feat):
         f.append("+v6")
-    if 'armv5te' in feat:
+    if 'armv5' in feat:
         f.append("+strict-align")
         f.append("+v5te")
-    elif 'armv5' in feat:
-        f.append("+strict-align")
-        f.append("+v5")
 
     if ('armv4' in mach_overrides) or ('armv4' in feat):
         f.append("+strict-align")
-- 
2.56.1

