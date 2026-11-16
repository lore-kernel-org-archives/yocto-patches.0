Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6309.1794870784051083560
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iBh9Xu0u;
 spf=pass (domain: konsulko.com, ip: 209.85.221.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ecda93627eso1117702e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870783; x=1795475583; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JmNxjMsMhV4MBQKEEq30xsCupAtSFr/rZLPOjdJn9kM=;
        b=iBh9Xu0uwXQ8jpZdZH+JLHRDjCEC8TeC6F6Qzjy/Pm4qjAPON6caseXzGarwrtE43I
         CNmxVoFXWhrumZS0OFTk5lzeuTcG1lUMgT0i0Ka1BTkI6davqEyxurEiQpSAaq+HEyNF
         ixE1LDIX02XosG24GTNM6Fp/nzJEG6Q8AKVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870783; x=1795475583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JmNxjMsMhV4MBQKEEq30xsCupAtSFr/rZLPOjdJn9kM=;
        b=wyKXt5YpKDnXrzv3ekvKO7vfKQD50onJ2Y79xyecBoYO3EqaM0YbaBrLNU0C52O0Pp
         lAy+gL0KNvt7jUmqLRNnDiujtE5Yv88HjeA8MKLy0EzM952ga9jtb/2ksEI0LT+myO6K
         2ykdMEG11SubegAw/UI/oHkp3S1289ef2R1my86rjTKhQVaxR5+Cbz078+AQqow4r76Z
         dYJ+VvKX9VVqbZQdulNOJprZwhDHNyxyQyz9DJYDRRZPVrvZWSmqRqVGOJSvhchEwlhr
         CImazXZp6dd17aGtX1rl7WIxMoXKZGjYR1cutQyijEwcMXUR1x4cEGAiJshzQexeA6VV
         MPSw==
X-Gm-Message-State: APuU4Z9Ia2Bu+XQjYEDb705VJYZFDnu/Y60v5RRvPO5jXVMh7K3T+Nl/
	sjUaRBJHSp5FH2fXyLLAXjougugqR5dre/WY20rz4bxdbvYWTrcrglu89hRPHVDy0CH8jvDgib5
	Ow70iI0c=
X-Gm-Gg: AYBFou3DmTHOVSYJ2rOd6ftCI9PSX7o54OieC/8QQhe76ZoVkkrDn6S7tBdMtFF3mel
	bTv0RSgTBb692BnS0+YqGrGP5pbkQtI7E1ldEepb7rcJ3aYOzyYXDtx0MW23facz/nXymmRxlww
	N7fenUxwH10/oEDhk+9LR38KbFK6eCyn3eLISA4qXSFsnUPO8QgsbAYe7YMO1KZEXH58o52BsX+
	s9nPJEPhccCgC6JxUamG2o6IIeZWT2Zc5iPwKCDzSwlVDIZQsLeCzNT8AfXaGDud/XmLqh7Dxmn
	jNWHpPWG/mBRQJ+zVUWr+UprH/QjYk1AQBqLGhZcD19eazXf2zcWJPNlvdRPt9QOoPsPdgT7v1W
	2V0OOgRWckw3xYwrJNkWE/ydqmiCOupfITvzqnHVlzKoJginmvtgqIx6neBFPQwOlswvi9JuFEg
	JDFVY42Qs9xyIgnhZfv1Sr2Wj+/LH6qerQAfEG17hrSqxIlaZsYNT/mAppIa/ZkZ53MMugI1lnG
	5cto04a4n6/LXu8Ehl7vnxPV4DyCUCBJOfwtN3gzsgAbnkbeaWV1Ij37U8KP+gR8KnB4YnZi1T8
	hfG6Lfjd1640NP4Xk4EPnKDzcKD3B+Yl088O9Rl7xjIiYMojx+mTzYvkNa1UT+zzukCg73PqFMu
	KIGwbde/umGiRSpRDrj7gW4Aqc6HHjafPFbobt9IF3wpOt6s+W/7u9zb5KVoMJvW/pw==
X-Received: by 2002:a05:6122:3118:b0:5d0:e3b7:334f with SMTP id 71dfb90a1353d-5ee34acd93amr4453102e0c.18.1794870782776;
        Mon, 16 Nov 2026 15:13:02 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:02 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 13/19] rust-target-config: fix invalid +v5 LLVM feature for armv5
Date: Mon, 16 Nov 2026 18:12:34 -0500
Message-ID: <27cb92a178c059244574872d9074790c74a1bb0b.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5451
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
index 1cba275..fee19a1 100644
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
2.56.0

