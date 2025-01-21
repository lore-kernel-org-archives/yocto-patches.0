Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA742C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 09:23:11 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.12189.1737451387801553910
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jan 2025 01:23:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=qLPQ4NYU;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 50L9N4IJ1865267
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 10:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1737451384;
	bh=9ZzIJ8qNrPEyRXPdyJCdMmH+33pzUmB6bkHzdEcNu4Q=; l=1063;
	h=From:To:Cc:Subject:Date;
	b=qLPQ4NYU/wQ4kH/AkTNRwe8BKxdz2zdzzlBnY9X0MPcNSdgBQFZ/8/c2hw6H7PMYc
	 gy1Peha6GjMUUe8CMmQTTB+vRopSjdkzwtujg+3r1AYf6m5OqcDtiuYSpCeju2zfUu
	 mb55fmySKE2ESs2RVOFCqcJ3SmOmTRTSshlUC0Ga3MWLWfac7ZLfaYN4VnnKOFeu00
	 B5CL2kebFO61cHuFUrWdL4wWbA/cIbRTimieU/Ke1zQv4ak+TbdbMOfFJtNktouXiQ
	 4vqsczBaxrpfEneuvGQUtGNbdXTKIrIbYzZBEO4YH451Pa4KS5daZTddwhJBgk/6CD
	 WFe+oc0Jaxjrw==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTP id 50L9N23V193830
	for <yocto-patches@lists.yoctoproject.org> from enrico.scholz@sigma-chemnitz.de; Tue, 21 Jan 2025 10:23:03 +0100
Received: from mail-msa-3.intern.sigma-chemnitz.de ([192.168.12.73])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id 2UBTX5FQJS; Tue, 21 Jan 2025 10:23:00 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 50L9MxIo1832559
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 21 Jan 2025 10:22:59 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1taATL-00000004iKz-0ODZ;
	Tue, 21 Jan 2025 10:22:59 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] rust-cross-canadian: use correct ${S}
Date: Tue, 21 Jan 2025 10:22:52 +0100
Message-ID: <20250121092252.1123704-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 678f67748c284250d7b37fa5
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 09:23:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/998

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

Porting back the UNPACKDIR changes broke do_install()

| + x86_64-oesdk-linux-gcc .../rust-cross-canadian-arm/1.80.1/rust-cross-canadian-arm-1.80.1/target-rust-ccld.c: No such file or directory
| compilation terminated.

Set $S to the expected value.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index ea21e8a..af9f2d6 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -13,6 +13,7 @@ DEPENDS += "virtual/${SDK_PREFIX}gcc virtual/nativesdk-libc virtual/nativesdk-${
 
 SRC_URI += "file://target-rust-ccld.c"
 LIC_FILES_CHKSUM = "file://target-rust-ccld.c;md5=af4e0e29f81a34cffe05aa07c89e93e9;endline=7"
+S = "${WORKDIR}"
 
 # Need to use our SDK's sh here, see #14878
 create_sdk_wrapper () {
-- 
2.48.1


