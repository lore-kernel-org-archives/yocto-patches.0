Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F43C369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.4590.1746132052179294457
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ui4zra8U;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07947so15561806d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132051; x=1746736851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GynVCE9keBQk1dKDqQYBl4NeZ8S255moG90twPqKWQY=;
        b=ui4zra8ULZZ4prLGE8H2ADq76ZchogSearT0gQQUB/2h5bnhj3hKcCzpPDnm6Kl8GD
         1e4vSSpPzTLeaQX2C/SP4T6U8vwXc6aoggix1ciJ2UwnJnS0Fnc8A3VXCfbtYdUE52v9
         0428s50iLOW5N+E1tIMQshsEtEoNOHAIb25TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132051; x=1746736851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GynVCE9keBQk1dKDqQYBl4NeZ8S255moG90twPqKWQY=;
        b=bi54ptbnTGC+Nuvi4r8GVHcVm4+5SHHD/EQTNXxETEdClUYAOeq1DoQ+jHlJY6oQpi
         4W9H9fLMdGIC5tYBLcgVaZRphPrsrWS0jrOy71kY7fQ1OL0ZNSc7q72retpGVDxzMoZM
         qv3l+W5JHWRkzflj2Jxpf6JgjHyDGiXUFQFPGV41A3JgsO8lZMwGU+XQnPAsmd6x7wxn
         i4slrFy/Y2tBsfQdcHliNnNaI9bP1+2ocK71A+U5y+kxI9NwiE9n5fgJaH15c6IauCrt
         2CnekHiHOvI/tnyXqE31qOt7+mUfB27h/VWk5rEG3EuJDlOyOh5XFFz76RwWORidlO/x
         2/cQ==
X-Gm-Message-State: AOJu0Yw4U8hbUO9xQZ9Hm0XAP7GCzN4cDNzVrWRmu0ztKUxAE/nTtiyx
	HWyq1LTW5MeNIdVRd3HQNRfyL0NvYCgSj5UDZCQQ51m5uenrbhVpGLuoiA9r7eW/7mQiSuLXQBx
	5
X-Gm-Gg: ASbGncvEBjhe39mlFQ7K95chhRRJ7MqxVFrKakSMmAyQdlBXxYVrFfyb7ZCiBcsoOVO
	piekms1sZgiRroDD3P1GQemHlljnc+x+h11KZuLZNzLvK8srAyBGJO9RDV2qNrGdAGsQzeVRie+
	VPALDNfbJm6gNGanfmQh1IAX7+qjL8ZAEOzEV3rvy9VMVMbtBvzGzTpm9ieHH6T3a/3ImYIbTSY
	Hv5EBN504xAPppQhcg0ZEpYCNQitNCyHgZ0GLxrd8yVHqJCo8ROsLByseFPyNoTvCG29n9Tc62z
	Y19N9LIJs60YA9Mdj9R5JGhYxgxNE0xoaWPROIvAIdPK4bwpL1m58OEAPe3GmLRol1tiJ5oRcdX
	XVo6v4nV0Gin3qFf4prsQRvSE/8w=
X-Google-Smtp-Source: AGHT+IG0EIkGzs6bK4JX71aPR5yMF3/YMXQDp26A57Zj/HncaGpFuYIEJP5DqFlFkH1tioJhZrxTSg==
X-Received: by 2002:ad4:5bae:0:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f50b2d1431mr67267076d6.19.1746132051014;
        Thu, 01 May 2025 13:40:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 16/38] rust: Fix build break because of download-ci-llvm
Date: Thu,  1 May 2025 16:39:52 -0400
Message-ID: <72c4e3fb140df196b3cc73868b475bdb0a7c479a.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1442

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Previously, download-ci-llvm was set to false. However, with the following commit:
https://github.com/rust-lang/rust/commit/7d579046c80d3de3143dcb8b2db5640f95b5383c ,
which has been present from rust_1.83, it was changed to true. As a result, after
updating to rust_1.83, we encountered the following error during the build:

-------------------------------------------------------------------------------
| thread 'main' panicked at src/core/config/config.rs:2047:13:
| setting build-target.llvm-config is incompatible with download-ci-llvm.
| note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
-------------------------------------------------------------------------------

To resolve this issue, we are setting download-ci-llvm back to false.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d43424cba7e93ee30b410d0a024be441e2336dbd)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.83.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust_1.83.0.bb b/recipes-devtools/rust/rust_1.83.0.bb
index 06f48f1..41efcd6 100644
--- a/recipes-devtools/rust/rust_1.83.0.bb
+++ b/recipes-devtools/rust/rust_1.83.0.bb
@@ -129,6 +129,7 @@ python do_configure() {
     # [llvm]
     config.add_section("llvm")
     config.set("llvm", "static-libstdcpp", e(False))
+    config.set("llvm", "download-ci-llvm", e(False))
     if "llvm" in (d.getVar('TC_CXX_RUNTIME') or ""):
         config.set("llvm", "use-libcxx", e(True))
 
-- 
2.49.0


