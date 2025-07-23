Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC1C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.22557.1753296039060636609
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CpkFs9au;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e050bd078cso20896685a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296038; x=1753900838; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAipnkTyhcG3jETkRMDaHMyun/oMhXdcH+DXr+fVkIk=;
        b=CpkFs9au8Xw/WzJy3BRIiy+J/ODV//MChyIj5PLcH3/QxNmHHDmXDN7G5+6HKriNz0
         JsnkpMQMvJrpwEl5dqacFWw4guWNELbaqlbfP0B/epBhsKtrVzYre53u4Jk5kMaWib2e
         Ur4mio+MO7h5bzfiEhTP3cKicjbJIceOe36/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296038; x=1753900838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAipnkTyhcG3jETkRMDaHMyun/oMhXdcH+DXr+fVkIk=;
        b=TNJ7ZkNpAzJ6nxiO95+6fcRFmgSyoTOdNahzRw+gNGv8cKakZrDjcT90o/ohjLZbqA
         zH0mc0RCZ1KTlT0HeV13zVgR+4ZoTxskpl97X2LdMbqSqafNOkeHv01THbch5k3B8GSE
         SMDp6/LE7ScfWchpVc04MVv6WWbSeuPLSpzbeA+xLwIrZmIHLiMVXtGtxr2zxK/juJYS
         hNS4WH+TQpGao090VNubERablo2PHK9eWhtQrax5pDmlu9t1UmDS9wB2p8xsV6fU8XF/
         xvbwPJAdFG+6UISJFumtsxvA/cW5njmzEvWyoDpYwQw6au1t5lA3sMgxwILTJ+ts/FW1
         4TIQ==
X-Gm-Message-State: AOJu0YwmkighWeCF0WHK1K4Uu0bjQVXqHhqCuypvMQL3Mm/yW6KhHfnH
	89POVOZZqiHQgn4bu1LZi6w5w7VL6FwliNbeI3Z5tlZnGwa1U2UkMw6g/JuNEZSeGDp7ydvnJQi
	kR4RG
X-Gm-Gg: ASbGnctC70NWL9HyZnss5/TbHXfbSqNsjlawWab5/RCo69rM89VgdU758ADzfiu4r2c
	xFOmIH7XO+K1wRKqlNSR4d60X8q7umSooXjYyl8GCj8QaKBXuEe9DUVaf+l/w2vp2e9fxlLoVmB
	nhCRR0M+Ulaxyq0ZGumwiOtCDSFUr/jBtqoz/tOmqj32g7N8xasKGcajY8YR2a3f0X5QAlsOmvw
	dZn/sSwhCBw9cieMpFUCpsP++jyWztWFXHIlqaYADxRRhJU4qXiz4X6/El4G8r5WH5lyoheSpTx
	HO1D80lLJ9ESn/WY12oVBJGUS//ESljV8pS+pjdl0djruJQkf8oPPgQ8uC3eo875SOUlC4vbFV+
	6JrbgB6cPYG8puiU988dIeAVOR7F1t2pUEb/tHBc0x77zPXl38GRvoyJbw6SCVgXGJljLTj+5xI
	8TmDT8YhRV
X-Google-Smtp-Source: AGHT+IGuQ3987DC+5fL1EI0O4i4lmO7IMG9W8sCqvjzQYsWFvjbEwAd9yN8d2oYsxqFdoVzcL4klgw==
X-Received: by 2002:a05:620a:996:b0:7e1:9c2d:a862 with SMTP id af79cd13be357-7e62a19332fmr338309685a.39.1753296037566;
        Wed, 23 Jul 2025 11:40:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/13] rust: remove file-native DEPENDS
Date: Wed, 23 Jul 2025 14:40:07 -0400
Message-ID: <ebe330206d589296b35e44160eda465208ed7b5d.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1834

From: Ross Burton <ross.burton@arm.com>

It's unclear what this was for: there's no use of "file" or libmagic in
the recipe, and the guide to building Rust from source doesn't list file
as a dependency[1].

[1] https://github.com/rust-lang/rust/blob/master/INSTALL.md#dependencies

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 79dcbed250cfe8ab05dd6e075905ad37de6d3bc4)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index 085fd3f..d968aff 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "file-native rust-llvm"
+DEPENDS += "rust-llvm"
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
 DEPENDS:append:class-target = " cargo-native rust-native"
-- 
2.50.0


