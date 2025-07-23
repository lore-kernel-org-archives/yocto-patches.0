Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A63FC87FCF
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.23584.1753297553002696181
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dUzVOhes;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e344e0212eso27436585a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297552; x=1753902352; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5FCzfo20k9vwR4BRIgNILtghJf2+lKEtKiWlGJxzmc=;
        b=dUzVOhesejiFdQ7s9eCVE8xW/1fyFoXbuTqUBgT/GkW/RFKsb6RuZowSdN20J/emNy
         jBTzDxmgY9tzu2VBZKIrBs3AHxZrJzBSpMKNyvDoRLnw1G5QiMBEB5mVCpkl0dexqnV6
         aTOfrJ+mgx0nUo3WOzMXeW7NBoMWdf4JAv9Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297552; x=1753902352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5FCzfo20k9vwR4BRIgNILtghJf2+lKEtKiWlGJxzmc=;
        b=n7L7QR1QxVRdlHbzCgmvqr3lQaK8+YNEYgFqAwd2lrFDapMDy/yTyA9qbXCUocb0HH
         3qFL3SYlyPILCOdNHF5J2T5HCRayk79jXf1pz6w4aaIQ0tjvxa/6NIVPTEKUGDW8++5J
         mFtaB+Gh6bmMQT1up+U+v5TJ5a968Awl95WhVqpfofi9w0vbMPdqsSv7gcBfOHegjhc/
         Ufo2oHjRRayzRk4O3hBHPmQaCPwu7JE2tv73k1hmUOVgjgA/+Vqs79s4OmM83yQFfe03
         FOm1lBZT2Y2QUHziuaO0sqCPz9kNt2GMWcD2pT08uT+iFJz+4oFKyOyXjeCpv3DLhm7o
         l6CA==
X-Gm-Message-State: AOJu0YzaYnb04rd2lJd4kF0oES3STN7UapGiJ5WTKH8GWY/jGKBJX3Gm
	ZAF5B3aopu1bEdGqCgM7DKI8AfeJLuAkvZzohnB1nWr7jR/AgdESFDqrmNM+SpEPxFFHdWY8A+Y
	jGYmA
X-Gm-Gg: ASbGncvtuiG1UX/tuQvfzJGe3qYT+akoa8mD/yt2oLvlOmgfRpOzfz2dIITDnK1+6bt
	rcryOw57/VNzNGejPO/OIL4/N4I568QoNOK5j1ROPuAUlejV6FJ/6M3MX6wNRE0JUto+GKTlJ9f
	ZnOP8ntL1iiP034teJPw6unfndsuA57vmSyqGGw/FP6pLasIlCvsBdCsy7nOIv50u7Qnr9Ib+iW
	UaCkzkZkk4KOExy0/8/rfToaOJrizB+alcjAVM/s8h4lTK43VAkMiHhat41b1hKzdxdp2P7vYT/
	j8ho7XRjuYZPk+QpfxVXfnNGCKGlH1l6MnjnV8gAVFHhRNzRP/2xrpb1SE3kAG8am0Cn4lBvNQf
	xWoNrdirNKPZEDqdh9eET65HNZN8XNg5k7VBY9C5vSIPS1Ogmmn7ascZ41Nraqch6gqQKo0BI2Q
	==
X-Google-Smtp-Source: AGHT+IF6mcl9pQoZcdjk5gft7EyC8iAM49vhe5Dq8Mk+Gl9GhXd5dO8QNT9g0fzREJAZNhgt1Lt9og==
X-Received: by 2002:a05:620a:7111:b0:7e6:23e9:3a61 with SMTP id af79cd13be357-7e62a915a66mr491855985a.27.1753297551791;
        Wed, 23 Jul 2025 12:05:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 06/13] rust: consolidate rust-llvm dependencies
Date: Wed, 23 Jul 2025 15:05:25 -0400
Message-ID: <e81eb134371705f4c74f05f9ecad6f3dd4c09409.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1847

From: Ross Burton <ross.burton@arm.com>

There's no need to have multiple overrides for this, as BBCLASSEXTEND
will automatically map the dependencies as needed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ffa699332551fbbb95a0e388385667dc2706da6a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index 90c6d5f..085fd3f 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -7,17 +7,12 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "file-native"
-DEPENDS:append:class-native = " rust-llvm-native"
-DEPENDS:append:class-nativesdk = " nativesdk-rust-llvm"
-
+DEPENDS += "file-native rust-llvm"
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
 DEPENDS:append:class-target = " cargo-native rust-native"
 DEPENDS:append:class-nativesdk = " cargo-native rust-native"
 
-DEPENDS += "rust-llvm (=${PV})"
-
 RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
 
 # Otherwise we'll depend on what we provide
-- 
2.50.0


