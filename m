Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47767C87FD1
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.23093.1753297553756794860
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fEIPYQVK;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7dfff5327fbso30837485a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297553; x=1753902353; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAipnkTyhcG3jETkRMDaHMyun/oMhXdcH+DXr+fVkIk=;
        b=fEIPYQVKEh2YGgYvtP+o0L3Ox15G7X8oNfj+8wlql3PF1V3KasZgou3pCLOwQQmndo
         GuAHTzEGpgUqdRANeUTvu5DQ6/mN8PdDnvN0dyX7MKPcMxfoLFwM106Gnwjf7cg0u24k
         WdRmrZTyH7WPeqgpAg++yUTHYdqyVWA2j4tRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297553; x=1753902353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAipnkTyhcG3jETkRMDaHMyun/oMhXdcH+DXr+fVkIk=;
        b=Pkn1bVwSiJOBsG8AfYoMMPmo3Tc9tHDqNcXyf2uM0cDbzQl0ajPxYqjT9l0Ul5D8SE
         KjMfBAlq64LRmklaCVxBqGEH2Ubzjg6HofJo18rPeTUqzd+Yut0F6D6izHarvICbGdn5
         43L9Os5SKEYqFWUDQtve7usz67qrXY32xs01R6jsOc5CoZfj4/Z7cqUwgK1aMRIfywOC
         daj9vXrWsfqImbvC8Wx1xCX/FHYDR1lPGUiJ+3chFX+fpLrgeC6vSvoV7RKVWepS11e1
         Zophr3s6E4cMCeDvx3kQOsAdg6klzN5l+/kkSSVRWUGxOt/VLYZn7TP2hIzj4idpKtET
         kA2g==
X-Gm-Message-State: AOJu0YxPTVRSXfYoVfaLdvmE9Rudsjz4yV2tdd7odyQ5QK8+1bSrb1Hk
	b4iGxzy1E9lc4CWAFqBk7wVQCTX/pBJfB89prdEENduqWIOlqpFsczPAnxXkvKkXbLAmdG0Ndsv
	w2qI1
X-Gm-Gg: ASbGncsVkVgmk6x0KvYra87tOHgwgnlFWFVwQqP+P0CgIK3fJzm7hGnscvrxUKQs7C2
	xCL6yazr5PYKWDtGn4JXfh/66mTGPwungl0DQzAIBhq7OEQg6eIw8IN/HYw41sMfPSdTRCKhHkc
	1Yb2KiiL/cjIL6Ft/aNNj0ybwVLVJjhMYAUE+aNTvHyRlKZwzcM0v1Tf+clmCo2rFbp19MsjWh7
	IVayQmH8LPM1tar56fIBfpuLVjcT40OaxYvY5LgqJYVfGS+vk3y1odXU0laebd0GAwu3ETh1Iie
	rxPP6q4yTRDWkWwcdtcGgVYSDqZqyFbxAuFtTjKNyjVzKszR/Ky+1R1SkRFDkLoLdIOJzRAE8Dq
	MXlTNmDL5Hp17fIt+mYd2j65flUw5uCi5rvp+WOREtpRgrwqs2xfo3SbLZavDHEd2HbQSWmdn3H
	/aSg1EjBz1
X-Google-Smtp-Source: AGHT+IGVxruKwQlrNJxRHNm2hWEsI+HBtmLikimblbG4B+H0Gzmrrd9JZpPkrI+QaNYnmcVyLd5xCg==
X-Received: by 2002:a05:620a:3b0c:b0:7e2:c5ff:2078 with SMTP id af79cd13be357-7e62a1caf76mr389066085a.37.1753297552624;
        Wed, 23 Jul 2025 12:05:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/13] rust: remove file-native DEPENDS
Date: Wed, 23 Jul 2025 15:05:26 -0400
Message-ID: <063821688e798892eda9bd1a92d78ba08dbdd2dd.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1848

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


