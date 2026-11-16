Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2509.1794860557618112840
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 12:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=gSHsBZVo;
 spf=pass (domain: snapchat.com, ip: 209.85.128.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so10978125e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794860556; x=1795465356; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWeHsiedABmrOtp+PkDN9DBYw4If0HjEpfhGcQmja2k=;
        b=gSHsBZVo+baOCWKCFPyAnmmE8h/cSL/24PulnG/xzCO1lw7UvWl6JJWEIZle44yMvk
         4Pwph3Ro0ErsTZSgyUnMmKGmuD29GDIZobw6zMyvVbXfGQTYscWNPOZ7TgLigukxiRAe
         1SsjirGitCMOsCTqvACUWwOlFkMNrGZzJ6IEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860556; x=1795465356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWeHsiedABmrOtp+PkDN9DBYw4If0HjEpfhGcQmja2k=;
        b=vaDXtSGc3OW2IfY/cQSS6+ffSnJxxCpcq4Iyo1qQtgvdJGAI0R2inUeAvZO1vnqzbz
         387k3LYOtW6oQY8UTG+00feH05yTSV2hx2Kyqugq2M5ALw5tQZq2CtPp0lFR7hUXPYst
         i+/vFn7zPrqpv7LhCGUv/b63bGS712w/Zo1X2Fq/Eh8nrisBKchlZMVKwneCnWOFPeNU
         YWTUvXlHe62C4Cvp3iPT5pp0KKhQuSjc894kBN3+iPyGDtpNs23JmdpeB2pmlSum3DvX
         GL5nhTnErtuUD4pdVa/xVicuSt4nrsmcGCUCh3rVsziQOL2CN855hydJ62u4Q61QI+RN
         GHSQ==
X-Gm-Message-State: APuU4Z+yh0ZwvcEyZ+EH+ukVQwt73oLq4NFTCm64nSfl6vj1wK4rABVd
	U7Pnwtco1c4Jxrd/ztjALI2ZHExhaKjQvNVF4m6s2cW9vDHWzNIqzgyXRRIpdxpP9DTBNBVwf7A
	dAMefLH8=
X-Gm-Gg: AYBFou3EFnfrhrt18gh99XJrqeNVCxoSYBBhrNyunIsgBi/4UMXIO3i45fcI2U9eFTf
	BAh56FcBMhZL3i1n6NGdv0amd5DWH2bZwMtSKCd1Z9xC8N0Pu3rOHZvgHvzDUpjpO9k2vD1+UOl
	/hKtT6+1RF9u4OSSdc5FMj4u4hMqFq3GJLtyPyGhojKUmIaybFc5X0getEr4PAEoo1PcBtkipzV
	pjpr90A3yr4BYt9210Pm4pjwR3n+NCY3ZSngJoGq07t5+IpuvNwUkO3BP4VCUmEJMFI+AdY5Of4
	eg7phe8HtNUco1eGzwIO4zb3C2hBr8JLHXnGR4vAcrS8GOlC+TJTKdZL2OxmTliBCn2S64YgQYo
	XUMOMbI/qKxN0w+HfeVykygQoCk5s4GYpp7tnT11HLXXPQD1/gE3SMud5DHHKHJlqxA/+FtuRxk
	hv9VV55A0MNu1DFZ5xg5Im5xwj/LeJKi4a1sktpCSGS2oRynOXuQeGHW2wgKqgKrsUQOZiYM2hR
	Z8cMV7A9h8ApdzN3W5ApQWCozYyXf/yenAjfg+6HhYKNc6lvxB/OM0bzHPgF2D17f6P/N2fgSHy
	xTtmDmqozZVjaWWo85hf3tMSOBVk3VJqBfCpWByMQasAQyGCrddS8tCuxFU4INquqdCiGX2PGSA
	kD6TgshSQjK9EVbpGa5240Xv0BVIl4vH3ZyCZfswwnVk6+Z1FS1xqtG0TkjWzbZdZ8FtI25wTG9
	KB
X-Received: by 2002:a05:600c:a46:b0:4bb:694e:496c with SMTP id 5b1f17b1804b1-4bb694e4c2bmr135403215e9.22.1794860555817;
        Mon, 16 Nov 2026 12:22:35 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm10724165e9.13.2026.11.16.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:22:35 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 3/5] libgpg-error: install lock-obj-pub header for the darwin21 triplet
Date: Mon, 16 Nov 2026 21:22:21 +0100
Message-ID: <20261116202223.654-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116202223.654-1-ecordonnier@snap.com>
References: <20261116202223.654-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 20:22:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5422
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

mkheader includes src/syscfg/lock-obj-pub.<host triplet>.h, but upstream only
ships <cpu>-apple-darwin names, so do_compile fails on darwin21. Install the
upstream header under the name mkheader expects.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-support/libgpg-error/libgpg-error_%.bbappend | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 recipes-support/libgpg-error/libgpg-error_%.bbappend

diff --git a/recipes-support/libgpg-error/libgpg-error_%.bbappend b/recipes-support/libgpg-error/libgpg-error_%.bbappend
new file mode 100644
index 0000000..ee3d6ad
--- /dev/null
+++ b/recipes-support/libgpg-error/libgpg-error_%.bbappend
@@ -0,0 +1,8 @@
+# mkheader looks for src/syscfg/lock-obj-pub.<host triplet>.h, but upstream only
+# ships <cpu>-apple-darwin names, which never match <cpu>-<vendor>-darwin21.
+# The header describes Apple's pthread_mutex_t, identical across Darwin versions
+# for a given CPU, so install the upstream one under the name mkheader expects.
+do_configure:prepend:darwin21 () {
+    cp ${S}/src/syscfg/lock-obj-pub.${HOST_ARCH}-apple-darwin.h \
+       ${S}/src/syscfg/lock-obj-pub.${HOST_SYS}.h
+}
-- 
2.43.0

