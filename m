Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76102CCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:00 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13175.1762633200118063720
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uCsYg/A+;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-882475d8851so904886d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633199; x=1763237999; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh2yWwI37xWPRRfCqGGr4PDK4uwySdkavEbzmC9TWKA=;
        b=uCsYg/A+emdsaBDDMZeORFyyKRO1aBp0wRz08x7epblBnwsAGo00RoeWgE2JXHRN9n
         Y2+l8eI+spUgsiPMzh21SnPbkb1oRMrPnqCU5ld1Y3I/EZCFTv5LwPzz0MiWD+hGMe0E
         vrEgeXk5dvKslEIpwq3s/uuLIeU2Qd+D1XGRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633199; x=1763237999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zh2yWwI37xWPRRfCqGGr4PDK4uwySdkavEbzmC9TWKA=;
        b=nBf7yhsaKorYWW1LI08YGAQ/QcrnV55WPIcFRt1wjtikERV3EiLwG90KJrwNsALFxn
         4dFA/jCqVdyBVjmH/7H2Tfn4laCpJmYIsqI2DWskYN4nx4e+hJTfczB7FoL4F5BMZWxC
         01cq3fNihRMkfsHfjlCq4NuQzIRQmd85rwv6kKtJ3yoELy2bXlbhy3iB2bSzdIQIrXqd
         OStgHN7AmrqobEfK6WjOmw6osGNALP1VBBEXnJ7i8K3Xe+YWsFIO6dqqLnEXd/SR2ii2
         tiryt9QLf0tcFPx3iBII+PYgYJivLk/e81ULucYkwpZoyfeSXza1qW1ED8fc/+D6cOIT
         IbCA==
X-Gm-Message-State: AOJu0Yw7V/o5ATz9bWeBFVkVTBVO0HH0xsx4myvxoDqF6gC+/mA4zM8t
	mpR8OreeVrUc35RtLsBw2w6zKmxcv0mQA1I83wT8tqPM6Rp0RycjZCLXHDT9EZagy4R8KvIOO/A
	PTdBV
X-Gm-Gg: ASbGnctre/njYOzud0kPLWMpgsRF2KXhqo9U5gqksgaamPUkEfkOgzmeSGFBIWEJA9d
	pTTwa7dC3+BfY1dt34AD2XOfpyFV8Nw2/HFhG0ELjkfangGngYSrpRTiW8cdEmAllTCNreGydGR
	JB5uN25sDNzAGqe1/phKmoz2Wodt9E2eSrI72acweAt3dGu7n6QFLCA9sjF5j6pRMZsIjHgRPkN
	ewDYKozzy7XNKg4QNBqp9YuuBLe4h1+A0cp2s42eKgEpd7tlJf9yhy1q7q09ToYQ+d1dUAPYr/f
	IxsgM90/00Qa3ni5Bv4SYCvBiQm07UcjfWkQZTaJKY655f2Sq9xcsjRsmQidxgah9MA0MIPNPuT
	FpBeeV6hZOTLfT6n2yIufNy+ONAuf65+TqF5YBYF86Ec+NEMQ4lA+8gFaqDt6TW8pns8LSApPEJ
	Acxpj3WmeDXzExUJJ4OTv5MwQGonlIGKtTd0xQ+PJOcjumJ6g99oq8uChBnJMF830=
X-Google-Smtp-Source: AGHT+IHRsEsY+zbjMnLelW+nAntw9Netr7IXdv3hWHH4GDGplBwqIm6wanEN9AJkB+z4cBTmTYzsUg==
X-Received: by 2002:a05:6214:ccd:b0:882:36bc:da5c with SMTP id 6a1803df08f44-882385f8151mr47872756d6.26.1762633198852;
        Sat, 08 Nov 2025 12:19:58 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/11] cargo-c: fix debug symbols containing TMPDIR references
Date: Sat,  8 Nov 2025 15:19:41 -0500
Message-ID: <7cab7c379a06cfa313d9f7b6282732e95b2bb113.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2452

From: Yash Shinde <Yash.Shinde@windriver.com>

When building cargo-c with DEBUG mode, QA checks fail due to
absolute paths from the build environment (TMPDIR) being embedded into
the debug symbols/binaries. This causes issues such as:

  ERROR: do_package_qa: File /usr/bin/.debug/cargo-capi contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-cinstall contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-cbuild contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-ctest contains reference to TMPDIR [buildpaths]

To fix this, pass an additional -ffile-prefix-map option to DEBUG_PREFIX_MAP to
ensure that paths under `${CARGO_HOME}` are remapped to `${TARGET_DBGSRC_DIR}`.
This ensures debug info is reproducible and does not leak host-specific paths.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3239961e35434592c06ec2cae2885ab464d35744)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb b/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
index fd15f02..5ef68e1 100644
--- a/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
@@ -12,6 +12,8 @@ SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c \
 SRC_URI[cargo-c.sha256sum] = "17d431789b050b0fcf678455dfd5ceb7e5b45cd806140f8fe03b16b995d6cbff"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
+DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
+
 inherit cargo cargo-update-recipe-crates pkgconfig
 
 DEPENDS = "openssl curl"
-- 
2.51.0


