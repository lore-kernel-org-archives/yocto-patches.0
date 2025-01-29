Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD50C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:18 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web11.19370.1738174154776983113
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Mev11pzO;
 spf=pass (domain: konsulko.com, ip: 209.85.166.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso489219739f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174154; x=1738778954; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttSzcfu3gDM3uup7qvtvb5QzVR6c6hMJGDzyoHnSV84=;
        b=Mev11pzO6H3ztBrA6baWYVEgLG7yzyoMW2RpNs7bPCPmesa5fCwhDcBnhldOk//lyR
         nmGFf5L4i7rcRhwIW6B2IxoiD9pOatGSP/VCn8N7GcLOTvU3clP7+MHAyYRA9hHJG14U
         LyU+TT9bKNssWhvBGX3/2ee2t5FLqhWSNclXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174154; x=1738778954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttSzcfu3gDM3uup7qvtvb5QzVR6c6hMJGDzyoHnSV84=;
        b=NsEL8JWy4umBYETHbZ1eT6w8CInEo1pnfzAx2kO1S3BjHYrkS8GlrfHSNLh7IfTfYk
         NcQDPCNpQeMvDpn3Pujk6ePFQS/BIoGIhzNshaUaHzuZIMCmo3ZJlsAWOldo7fykLJrM
         aJwWohSY2zKGELtc+ipCnSBxZTZhANj8g+t6a8wJCU4GtDvRQsr6t+ebzUeUyodFsvTV
         ki7AWsF18jzE1+NFZyD1kX+iF6gnKFSfJNcxsIy8XWdXJ91G0XZoF2ydm4EL3KW5eK05
         VaXuBK37zW+Ug4LK8Dnod+x+tX7zs6dAnSDmx4ZAueLuGGufl2g9uEbnXvRkQx+TjoWj
         HuXw==
X-Gm-Message-State: AOJu0YxQ+LaP4zcVOTgLMOUaFd+IZyB1UGOWQfdecWs0Y5/uC2Vv2pR1
	g5YzSGmsvwFN+iKNoGQXvrBSjTZL/TewfRd9PYS0BhgiecoEpyUqa2DNyWI2NPVUS8NrgM76QOR
	D
X-Gm-Gg: ASbGncuKfn3goRq54AWgeYr3DY3RJsISCiysq3tfh5Nr2AK5XA8BIBhwjCmBBDZYRJX
	aPE+TDWo/AoSq2bNfYd41NChsEPtJiv6ctN/lVSM/q3aalMe26t2Uqp344v8f/UH9TznSpXgRH/
	asPN5uJqxQvUisruwaXDUcKUY9eK5SbuYHHcSlm7hLU1S2IPkLWEpt9uQTYYqpKcMkjn2tMm5Bo
	indMNzodgnmTww0oIoXAM7q3nVfaVB1emXRXUBHO6ougHD4DFwHEQBBpHwqvlh3Q8Ad1RLN2Xgu
	46Ud8CzEhDRHsAb9wttgGdwqMAZukkVMV/g1hh6yC0cQKUynxC80rmTdcLR8vTmo0yA=
X-Google-Smtp-Source: AGHT+IEsIOMNSrk0EZCRMMgvqR4ypw+SgenMrzPcSn6aKatTdR5oWZbML4r8hgHEUidOajoUBur4VQ==
X-Received: by 2002:a05:6602:368e:b0:843:e9c0:8290 with SMTP id ca18e2360f4ac-85427e24a58mr437903439f.6.1738174153739;
        Wed, 29 Jan 2025 10:09:13 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:13 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 1/9] cargo.bbclass: do not install libraries by default
Date: Wed, 29 Jan 2025 13:08:52 -0500
Message-ID: <b0e2fb16ddb20f4d5915d9fa13c41788b8bdd3b5.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1014

From: Alexander Kanavin <alex@linutronix.de>

'cargo install' only installs executables and examples into the system,
and we should follow that. Libraries are vendored into
build trees from the crate registry and then baked directly into executables.

Neverthless, there's now a condition variable, so individual recipes can
opt into installing libraries if there's a use case for it.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 68990af9630da16fc75362ca09046ceab71a1106)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 0829a58..b583f84 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -61,9 +61,11 @@ cargo_do_install () {
 	for tgt in "${B}/target/${CARGO_TARGET_SUBDIR}/"*; do
 		case $tgt in
 		*.so|*.rlib)
-			install -d "${D}${rustlibdir}"
-			install -m755 "$tgt" "${D}${rustlibdir}"
-			have_installed=true
+                        if [ -n "${CARGO_INSTALL_LIBRARIES}" ]; then
+				install -d "${D}${rustlibdir}"
+				install -m755 "$tgt" "${D}${rustlibdir}"
+				have_installed=true
+			fi
 			;;
 		*examples)
 			if [ -d "$tgt" ]; then
-- 
2.48.1


