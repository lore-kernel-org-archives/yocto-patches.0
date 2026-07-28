Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B958C531D0
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:47 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2426.1785202906799628438
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZNn6MYnD;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e507b079dso1943219b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202906; x=1785807706; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4b9t2kE795ANKe1mv5hsNIyxoSO+MCakNXX2BaiSt04=;
        b=ZNn6MYnDDmquUWiEyZirzr3X2DoGwdRhQvgONBkSxtPSdoWJuawPymaMxo3W974T0D
         5jTiDh6nvKIE+xp4T8zwffEjFxwgsP6Dnjp/XdM31BO3udJku0D8+ssIrgv7bj67BMh6
         pdwpA8fKE1BuFTVNdLhWu0UvebPTdnzmBiDrNiGShAtFLlyXDcFKUAIm57UdBP4B0ih7
         RbJuJ7C36BOB1XwhHsuKZktuva409iTkcZB3+0VQFJdgWsZXNjbqgtxQqlrzLjmkhNTI
         +Oi5an7TWxZoicpvCxyWScCV4Qw4dLQOiGgKODij1CQ3yvnE9vrSxdOjQ44R9T+viB2d
         tFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202906; x=1785807706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4b9t2kE795ANKe1mv5hsNIyxoSO+MCakNXX2BaiSt04=;
        b=hAkCiY4xzPePcnWAlzbGgsxu9uP6hlRflbfa/FTdTdiaDLs+XSAVlmyul/7dXnfJvL
         vfl7FZJBARbGqF93bZSWv2T5rM4yVk0E6DXL537Tys+kxVTT5s5l/d9aRPSBFNWpOvWz
         bPURuvE9DxKpvlJ8uYbHey8hX66R5J0E7ARj67HziuJfh5lG7+Af82GiZ26raW16P8ZS
         hS1rt/f9vZaXtGI1eBJfaqmxz78FQz5qiuRSDlKFmbvUMHY616HmXdiLeoV2eHu1F1R0
         7k0Xn8todmRaRFIVn8aHK/CRuWOsd8YOjXufA+PT/AyYSMJkTO15vQro7tkyLVRJz2ec
         Bm1w==
X-Gm-Message-State: AOJu0YwxVw4BcfMr0kVqD0WivqG4AU+OjI32ondug8Gh/NaNDLernfu7
	sdzcJMMyozNyRdDV2XbGmbSyYnOVln2IoMdxbnlxk0DJlshkYETPA0HvOB8i8w==
X-Gm-Gg: AR+sD10t3u6/cn+8hQ9gVR6A9lrPk5XAh338wFGCqN1p2zQDF4s2ZzPHbP2NGd1QvGI
	mXmh7HT0gnbrpBPQzC8VvEHQFE9trctCorfnkVfQHjZlUVSLvogz6Q0ch2N/ufjNT6qZQJLHF0Q
	CpV5JHpC6IDEMHNSKBuIcceOXry88GvsX6CNlvLNlbmJftd3+vlt66x0/vOYAfatW3QxbTnm+QV
	fCJVxK4phKieL/CJ+uCC8RghwTaCflMHbs9rcNwWNXkCO+JkUbj8PIDgPkDD2Px3BpMRXE9K+SS
	x39CSs24zePjRA6gaPIToIsNr7GNUrI2aG45wrrjFANtgtl9PxvB6pxLCiCLkBeZCXNVBhdiHu0
	JVIpwkFugbiBX7NVcQUc3v0N7lBzj/EqBkzYVNR2XQw5TX2a0VhPJfsZ/XNvdXiQ1Wl/TqZmNok
	dUdzuPxC0GVXe/bbxjJwpqkZw7PUI4O9aUra7u/LdzqmMCogC1VDbjPH4GviPvKb2WrNuFGr/bA
	A==
X-Received: by 2002:aa7:8883:0:b0:847:84a1:9782 with SMTP id d2e1a72fcca58-84e93315f3fmr329749b3a.26.1785202906155;
        Mon, 27 Jul 2026 18:41:46 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:45 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 12/12] config.json: set  VCONTAINER_TARBALL_URL
Date: Mon, 27 Jul 2026 18:40:45 -0700
Message-ID: <7ff37632f6b606ce17dabf815a8b30cd7e93a02f.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4551

For now, set VCONTAINER_TARBALL_URL to .../pub/vcontainer-tarball-latest/...
which is where the vcontainer-tarball job stages the under-test most recent
build, until we decide if we want to use a release build.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.json b/config.json
index 8c23c2b..9a14c5b 100644
--- a/config.json
+++ b/config.json
@@ -12,6 +12,8 @@
     "BUILDTOOLS_MAKE_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/x86_64-buildtools-make-nativesdk-standalone-5.0.4.sh;sha256=2eb7a6c013113f4fdb87e800167606dc13af1bd8bbc1c9e2443b7be37fefd124",
     "EXTRATOOLS_URL" : "https://downloads.yoctoproject.org/tools/buildtools/x86_64-buildtools-imagemagick-nativesdk-standalone-4.3+snapshot-5f2ba20f203114db9a3b11264467f8c23a05041d.sh;sha256=9cbff3a7cf524bdfa7779dce8afaf3453114d8017918d2927f723ea38a36ebdc",
 
+    "VCONTAINER_TARBALL_URL" : "${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh",
+
     "REPO_STASH_DIR" : "${BASE_HOMEDIR}/git/mirror",
     "TRASH_DIR" : "${BASE_HOMEDIR}/git/trash",
 
-- 
2.55.0


