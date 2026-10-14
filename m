Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E3ECC6B1D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:33 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14764.1791987151273144159
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=dVFuMOQN;
 spf=pass (domain: snapchat.com, ip: 209.85.128.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso30030995e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987149; x=1792591949; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8dRK9O/nqxRypKTiO//AuAnbPFMDe/00xj5Y0MmGkE=;
        b=dVFuMOQNy9v9oVSuklw/12+hMfNrOoOgxHIAeBlaKyWag3zgSqvCFjzTxJ2FqmCSwr
         zXMh6wCj7UCXd/qf3I6qama1cHO5xdoIWIgjm5DHkgGSoPSoRv49ZzqkMURMRAAWyZvl
         a7ljvpmsWKtcb+OtKRPlaICRnLv3hdOr1RYyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987149; x=1792591949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8dRK9O/nqxRypKTiO//AuAnbPFMDe/00xj5Y0MmGkE=;
        b=PnRmxiZFze2Iw4U1p45gWQbCzzNHPKCjVu9xeF7RrDoIdo+DmCPn3cZGMH+kTyRHeE
         MZgGbvcibGlmE8bwAC+VLsdr5E02za0VOaGJUPiPvy48FsWjR9l0kr9wpiqdkJPS/CmD
         Av1UYwywsJUtVZUqjTao0UhQUTHPcn2t0xoVAkpgR2Vz9MuzmNPR7M1+L/xbYDttYxmk
         aMOPvFFT6ELBhNK+bxHwOy1zWyKu+BL71lHFunvgZP9Li6HTPKv9YFNnV0l/OsvEEjsP
         xmb7qCXyDsaXMWXrqN+dgpZdMFrjwnEcku2Z0Ptmj3EEsU0/UKKDwBzP63lKRk4/979A
         /1AQ==
X-Gm-Message-State: AFq9FYL3AXVHCGY3SpASY/KKRDPHg+HCLnj3SBufxL+ACVojzGKujO5H
	t8thaNCCi0QD+AoSan6lQfEyf8pG1VG5gX3lmA7XeripyJg9oml9qMMDtk4xutvp0zAcItDu5zv
	hbIUWdZY=
X-Gm-Gg: AYBFou1XC8qxdv8DWQfLMzY4yGUw072FP+daa3OIFkWh1aOm7O3B9LJo1jpK6jgQUzi
	tpMxg2MVpNQy7+wX9AwGAicKXMR4DS0m5MzbO17KsKVKEg8qNhV6c3cXaUkzZ5DxPLN7Z/oAbY/
	wF3Ku3gQE4pQQ8/bQ2LwBg34a19UXvsdEwO9CfNRUWE93h66dfZl6iCQQESQyqGn1bekR+Y1kHB
	xK5bm/G/gQ9cUeE0R18m6e8RIYthLkft5MjRSjFS7MrjJJ/aLVHfmZEKfDm4VFLwFvGtAoydWMr
	sJKxs4v3hBf0CUU1J9hwCz37awOYwCwyGzFOPNtTWtub5DWtjOkveM2WbYfmvHRWuJ9YloZtRCS
	mLq98GtmwoI9+76Bg3bE38xoIHEXm/3XlxUQJYC8MaB4xIauNxCFFELFF+SarDS5Z+K2hKVhey7
	IwXxQzsAvcbheP0dGlaUQSZht8W0s43adzniJEmQtG/hats7kXhwbJsWANoKOD8JtVwZficsNRe
	VbiPWK7VzR1/wcwfgLIxQN3msawKU+/kCWGHDTY/Q==
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a18e4d8bbamr279532175e9.27.1791987149483;
        Wed, 14 Oct 2026 07:12:29 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:28 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 05/21] zstd: rebase LC_RPATH patch for upstream's new zstdmt guard, scope to darwin21
Date: Wed, 14 Oct 2026 16:10:26 +0200
Message-ID: <20261014141209.488034-5-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5009

From: Etienne Cordonnier <ecordonnier@snap.com>

Upstream zstd 1.5.7 inserted a new "if ... zstdmt ... exit 1; fi"
safety check into the libzstd-nomt target, shifting hunk #2's context
enough that it no longer applies (hunk #1 already applied with a
6-line offset, a symptom of the same drift). The underlying duplicate
-LDFLAGS bug this patch fixes is unchanged in 1.5.7 (the same
"$(CC) $(FLAGS) $^ $(LDFLAGS) $(SONAME_FLAGS)" line is still there
verbatim), so rebase rather than drop it.

Also scope SRC_URI:append from class-nativesdk to darwin21: LC_RPATH
is a Mach-O/macOS linker concept, and class-nativesdk also covers
other SDK hosts (e.g. mingw32) where this patch has no business being
applied at all.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch | 8 ++++----
 recipes-extended/zstd/zstd_%.bbappend                     | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch b/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch
index b765082..5b6d675 100644
--- a/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch
+++ b/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch
@@ -34,10 +34,10 @@ index a4cf61ab..e1ffba91 100644
  	@echo creating versioned links
  	ln -sf $@ libzstd.$(SHARED_EXT_MAJOR)
  	ln -sf $@ libzstd.$(SHARED_EXT)
-@@ -236,7 +236,7 @@ libzstd-nomt: LDFLAGS += -shared
- libzstd-nomt: $(ZSTD_NOMT_FILES)
- 	@echo compiling single-thread dynamic library $(LIBVER)
- 	@echo files : $(ZSTD_NOMT_FILES)
+@@ -255,7 +255,7 @@ libzstd-nomt: $(ZSTD_NOMT_FILES)
+         echo "Error: Found zstdmt in list."; \
+         exit 1; \
+     fi
 -	$(CC) $(FLAGS) $^ $(LDFLAGS) $(SONAME_FLAGS) -o $@
 +	$(CC) $(FLAGS) $^ $(SONAME_FLAGS) -o $@
  
diff --git a/recipes-extended/zstd/zstd_%.bbappend b/recipes-extended/zstd/zstd_%.bbappend
index 8572d37..2d6b5d5 100644
--- a/recipes-extended/zstd/zstd_%.bbappend
+++ b/recipes-extended/zstd/zstd_%.bbappend
@@ -2,4 +2,7 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 EXTRA_OEMAKE:append:darwin21 = " UNAME='Darwin'"
 
-SRC_URI:append:class-nativesdk = " file://0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch"
+# LC_RPATH is a Mach-O/macOS linker concept; class-nativesdk also covers
+# other SDK hosts (e.g. mingw32), where this patch doesn't apply. Scope to
+# darwin21 like EXTRA_OEMAKE above.
+SRC_URI:append:darwin21 = " file://0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch"
-- 
2.43.0


