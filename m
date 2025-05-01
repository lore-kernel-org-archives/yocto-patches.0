Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE24C3ABAC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:41 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.4576.1746132041278469083
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oL+2LEbS;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7cad57f88eeso11866485a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132040; x=1746736840; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twZLXnKuX81q5Ags5blIcT/lzoNsHmyu6A+4W5zm53E=;
        b=oL+2LEbSsnIKtVg2chwsen+VCOjaFQCmwigdg2Gk90Kw1ESfPZo4HP0J+UrNwjTVov
         vtxcehxTBrRMGQQTo9eYxgzFV6Wm9M2Rf+kliLfunOLb6yeAx3qaJzhlwUNKJsHUyVT6
         nyA3TENa2nUXC/+6InEx1Pajm6+KdR/Ng5M4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132040; x=1746736840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twZLXnKuX81q5Ags5blIcT/lzoNsHmyu6A+4W5zm53E=;
        b=qC6jm+h3J3zeVJDbn6+4PjuXw7ejRNIr/sBVDCTHLjjiPWYB5qC6nNvdmvzkoTiw7x
         aFbDy+sqJmgXSiGAPb26WdzrXLc6P5HdtfnugXdpmoOd6fDQ0Z171dPdf6d8fT4iYm2Z
         FfpVvNyuAus4IOy+Ru3cCexweUXumXFyZp3LHqNXrBT/JP2goQlmA1Q05i+nh9gaE6F5
         b3l+KuWvXq1a8zI++KlokKPq8poD88S14sV3oW6AH++XP0f8reMWTSyQVGQPrM8iHw0i
         hPYPunfiLSjxs+W+yqJllIqlyF75v04YsiFJTGU9q3J1TpWlCE8ZmPwhuL+iHJp6U4Su
         LnwA==
X-Gm-Message-State: AOJu0YzAVeDOszX+GWfQhpP72AidbS6MSVypF7qRFdbJ5bFY29GM7Jsc
	dUstNtQY42B1aueSAMaLUkTwtvCvgKlhZPYoGUAv5yuH/7vHsvOlSxwaIy7BO0A52A8lesIC5M9
	L
X-Gm-Gg: ASbGncvr6eWTJvD+KTYn+wYIbpBjwTooya5eUuZR8YCunCLP0/l38Q3Bh0qUgqquahI
	EsPpAlIwiJ9xcjggP9iSirs3ls+ccN3G35UPcLhT0QPUM1QwuOr1jM4qHUtYyugr+nGWJqt/x20
	Z0Rgo8lIduFVvC0ZZvHExQqDkN9wHdulZVRsVKCQBTKM0fN3i0uLR1+z05Yqyr4B02X0W5THnvC
	Cf83QrguCJ/SlOPrHMWc54Dfe2NSMztjp31k9ASvE05kHwc+gZgGi1suLnjbpMmZVT7y1aMgJ9R
	SAxeToAOWXXgNzxGN124cOt5qpR7tuorlnS8CUqfZ6A4zUGnV14C9lBnmnQJWdoh9ejKNyMp1Ts
	dGj/mGTwpUhEDbCBUkZ5mO5MkFSc=
X-Google-Smtp-Source: AGHT+IEBpvUpg7kg/VuiWWo0XlyUjBA5266CBwPiGz8INO7Ynx8ot0EbeQQbX+2YYgcdFKWw/7R1cw==
X-Received: by 2002:a05:620a:254c:b0:7c9:29c1:44c6 with SMTP id af79cd13be357-7cad5b35b23mr56548385a.13.1746132039680;
        Thu, 01 May 2025 13:40:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 05/38] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Thu,  1 May 2025 16:39:41 -0400
Message-ID: <c18257d2f7034ff7be3b6cbffd80763eca2b0d92.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1432

From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>

As a user i want to override `RUSTLIB` path on a bbclass, lets
call it `XYZ.bbclass`.

If a certain recipe inherits `cargo.bbclass` and `XYZ.bbclass` the
value of `RUSTLIB` is dependent on the order of the inherit.

If `cargo.bbclass` is inherit before `XYZ.bbclass` this will reflect
the desired value of `RUSTLIB`, on the oposite, if the `XYZ.bbclass`
is inherit before `cargo.bbclass` then the `RUSTLIB` defined on
`rust-common.bbclass` will prevail.

Changed definition of `RUSTLIB` to soft assignment to make it overridable.

Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 6eeb832f73ffb48f5f05dc47191f60e4599e640f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-common.bbclass b/classes/rust-common.bbclass
index 910d6ad..033b7da 100644
--- a/classes/rust-common.bbclass
+++ b/classes/rust-common.bbclass
@@ -13,7 +13,7 @@ FILES:${PN} += "${rustlibdir}/*.so"
 FILES:${PN}-dev += "${rustlibdir}/*.rlib ${rustlibdir}/*.rmeta"
 FILES:${PN}-dbg += "${rustlibdir}/.debug"
 
-RUSTLIB = "-L ${STAGING_DIR_HOST}${rustlibdir}"
+RUSTLIB ?= "-L ${STAGING_DIR_HOST}${rustlibdir}"
 RUST_DEBUG_REMAP = "--remap-path-prefix=${WORKDIR}=${TARGET_DBGSRC_DIR}"
 RUSTFLAGS += "${RUSTLIB} ${RUST_DEBUG_REMAP}"
 RUSTLIB_DEP ??= "libstd-rs"
-- 
2.49.0


