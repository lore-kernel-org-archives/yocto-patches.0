Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F94CD1297
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:10 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13176.1762633202395126392
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DqIBnPRZ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-880576ebe38so17764176d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633201; x=1763238001; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wh3wuZCwQENttsp7ghRUkZ87sfbBoHLt8A1urbdT3vI=;
        b=DqIBnPRZKoNfU8z1RsGAW3IfeankUgF/XdCYNPqsiWqxVfaAshxBHF7ullg1xB2hc3
         pONbI28oxx/2LQIG6Dso5lA5acfeblV0gaApeomMfG1p6C2xSm/mbTwm7PE9YP+lFNoZ
         d+iKPgCaUEI9AEdFV8lFogeH+GLLe63DJx5h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633201; x=1763238001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wh3wuZCwQENttsp7ghRUkZ87sfbBoHLt8A1urbdT3vI=;
        b=jceQsyjwV0IX1pxlOnxrhKuylQgUUYHk14+JkN2w9zTFXlFuRRcf67rQTPnPgHrJlC
         c5seQcnLQfYVjAwbg5VcRzPwYussf/Nppu3qaY2lNPgjK07CsoBVpru9uLkTmO5WCf4O
         HzyhdiP8Fq8mgDHXkpGX4FPx1AigDszdoUJvvHLp9NOZzUiX2hR7wNR6nbwUfLfS4C7F
         45cLNitfCX/Nolu4NjEEAsnDknS5oFe3PcCOgZL7pEy2M+/FvgBpvW5ndKcJF3BtaJX4
         SCR4o69y+HLq8gXPXg5TIb9tqifMAc9bQ+7IaztfEPzccm/SuIDbFamzFjF4M5Ds3FyC
         aoAA==
X-Gm-Message-State: AOJu0Yxu9PgjigzAlnu3LN9kJK+5i5aPJgFq3mEf643WW9GZQdCcVsIy
	Va736HBIAU8ZbOcPgOJBkBaoleARbLWFHnu08P/UhSleRKmawn5ORyym/SFia8V/+DvaKp2KOux
	wZVGr
X-Gm-Gg: ASbGncvcs2LqLLbGEaD+AuuM9pItcKhkuQltw2T0nA3+UiL497sZvEHQRPUhSA6/8Wz
	e+HAmmh9sLZ8/oyOpJH57blNXPDxTCaVcr51/5JQnC3Sknnp4ZDZBfNVU32ZvDHmnD6Nvug91y6
	g6/EsKHfK1S2iVu28h/K0LnfVbDa+Bf7ADot1sZi8VKdjgC1wpUouILv8lAOtWdoL4JHhtWJcQG
	JfNUzJkghv6GCFSkrfcUqu55V5zuP1i4GurYF24UfnfmG9J83ZKA1/hgW0UoGwN8gfhY+y+kRdW
	m/n2WJK/sV6C1cEeqguNYOeqkY0mjODU8Z/hcLfb4syW2RYJWU2lRESGvnbALH5U5IIXCiW1DtD
	UY+r1qcG1EGz1P9r7VvdyeWLYZWJ31paeCkS+eb6e3/xPE+SssM1UbPANDdJ1S2z5xJFB5ZKT3r
	51yUBLd4EhtIm4Hung4YYcnovK11tLl2HqnKMYAtz/AbTB48fJP+cY
X-Google-Smtp-Source: AGHT+IEd+4VVnt1UP7fXG4o6+XahS7fENLjLNEJgSUWouZp2D3pJosJqKang5SK7bhiyDdzCxdmI5Q==
X-Received: by 2002:a05:6214:5082:b0:880:4eac:8689 with SMTP id 6a1803df08f44-882386ed923mr54250786d6.57.1762633201168;
        Sat, 08 Nov 2025 12:20:01 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.20.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:20:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/11] classes/cargo_common: ensure B is clean
Date: Sat,  8 Nov 2025 15:19:44 -0500
Message-ID: <201f2082b4da39801247a4e44ed5df98265fc257.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2456

From: Ross Burton <ross.burton@arm.com>

The cargo class defaults to out-of-tree builds in WORKDIR/build, but
at no point was that directory cleaned.  This causes problems with the
rust standard library recipe (libstd-rs) which installs manually with cp,
so rebuilds can be contaminated with the contents of previous builds.

I believe that post-release we should switch cargo.bbclass to mandating
out-of-tree builds to reduce the complexity, but for now in out-of-tree
builds we can just delete the ${B}/target directory.

Note that we use ${B}/target because there at least were reasons to use
that name[1], it is unclear if these limitations still hold. We can't
simply clean ${B} because that will break recipes that use cargo and
something else to build, for example librsvg.

[1] https://github.com/rust-lang/cargo/pull/1657

(From OE-Core rev: 1452ac7a44196454a52f3f6d883290ddcccfd3f8)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9d9ce457630ea7403ffe7028e3370647db0b83fa)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index c0f6544..db050ca 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -110,6 +110,10 @@ cargo_common_do_configure () {
 	# Put build output in build directory preferred by bitbake instead of
 	# inside source directory unless they are the same
 	if [ "${B}" != "${S}" ]; then
+		# We should consider mandating out-of-tree builds and just using [cleandirs]
+		rm -rf ${B}/target
+		mkdir -p ${B}
+
 		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		[build]
-- 
2.51.0


