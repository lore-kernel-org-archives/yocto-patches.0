Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24500C02194
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:18 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web10.19467.1738174156840942844
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YG26IGg3;
 spf=pass (domain: konsulko.com, ip: 209.85.166.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce873818a3so62010775ab.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174156; x=1738778956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXgzVBMp+OSyKu0EDvTN0AvQDJmnMtJAc8yoIqvX/tE=;
        b=YG26IGg30K9GZQ2Qcxg+8YQPSf77+qjuwhv/XIpHdKikLy1PA3GYSMDPsRx09wMBcg
         k8cPay8EQVP8u6cbWlLiPPy4PNCyjrLQgiBSV9R+5+vQWYYeULr4vcak2mDHM3l1Z4P/
         zJ6V1qyJD7INoWSLQj3JWK78opmuKFkRFYqko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174156; x=1738778956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXgzVBMp+OSyKu0EDvTN0AvQDJmnMtJAc8yoIqvX/tE=;
        b=lIKXKhuj8+1EafLnB4UexCrVr6ltF6ytfffVsgKDnZ5Ysz4TB3JJnKV9TAyH6x+IYL
         Nb8iFOsuPEVWs7NA49LVIMHlZnkkXf0CEOYJhHbOUvLBwOrD8aApvcdiFOqedEwA498h
         NacKsoJ+bhH9sUKv9nIvg/kFtvtsM/qvLT1GiUBiAByzLET5bWxQogz5iO4h+CqG06vH
         G+DEs5VfHciaHbxgTjcKP2Q3BHPBRhiK+TjAADrbNKM3dMs+4XMjFXyWecPQCv3QYBHg
         O/ocd4elMLooM0hwZ2cd6dGgRlKyhQzHsACJIPzPHi/x3DhZbj/IeYuhF2UkXuyfTsUm
         Ar/A==
X-Gm-Message-State: AOJu0Yz0pZyz0t8jqc5/6siWlVxl3Ky8CcX/LtUq4ekMSqFxoaJNv4Hm
	ETt27/Znp0PZwz+G65oSTNh9KSm8ncq/6mJ8aBY1hdn2YLppv1L0g5GEvVzmFV4LOp8RYhhhXUX
	F
X-Gm-Gg: ASbGnctpw1sqlWlP6xZ86+DmZjs7MCvpQRxVItohqO0RktQCD+lVEVPrNFveR63XW2+
	UlEjKDWkX2aFQxx1sPJgnnhsfGgdvdkRWlDT0UbrEEfQBYVhE0DzzWlc1ZakeOTWKyf0X2QzYhM
	f894rmrtaHlRuhn94r48mV14auvEPByerZwhQfFDzr4zAW7ya5Gi/UPukV6ZH9ZqG5FWS4gU9f/
	bsIgr490FbFKUA06w3MqK+V2059qLgaPz5s+qg4I4ZEF1TEm1b7psMErLAmGLHuwMSsySVQKakp
	NtL5EzhGIl21I/zhaVYHQ60dLQ7K+f3+uhzxRdL4aJPBQQ0XoTY5zpSjBS5cA/zXxFQ=
X-Google-Smtp-Source: AGHT+IFDCEA7Wg7Pe61y1OT65q71uL/e2rFjBl29FxfdQ0n0inr0nt6W50r8VBHGil7ep+A/XMgHUA==
X-Received: by 2002:a05:6e02:3101:b0:3ce:69ca:ef99 with SMTP id e9e14a558f8ab-3cffe3e5e4amr41069165ab.6.1738174155816;
        Wed, 29 Jan 2025 10:09:15 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:15 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 3/9] cargo-c: convert to target recipe
Date: Wed, 29 Jan 2025 13:08:54 -0500
Message-ID: <029a7a82d9e134c39ae47cc154245ce59c06e5d9.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1015

From: Alexander Kanavin <alex@linutronix.de>

This was prompted by sstatetests.SStateHashSameSigs2.test_sstate_allarch_samesigs
where adwaita-icon-theme would fail due to new librsvg introducing
cargo-c-native into dependency path.

Rather than look into why is that, I simply converted the recipe
into the standard 'target + BBCLASSEXTEND' approach.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 80a2673a3081e623f30f25cc773ac9217e717958)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...e_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 rename recipes-devtools/rust/{cargo-c-native_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} (86%)

diff --git a/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb b/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
similarity index 86%
rename from recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
index 728b875..c6e88e6 100644
--- a/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
@@ -9,9 +9,10 @@ SRC_URI = "crate://crates.io/cargo-c/${PV};name=cargo-c"
 SRC_URI[cargo-c.sha256sum] = "5bfa9ba93806384d940e71dafbc185316e0a6a47561b33b7105fcf67f99df70a"
 S = "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
 
-inherit cargo cargo-update-recipe-crates pkgconfig native
+inherit cargo cargo-update-recipe-crates pkgconfig
 
 DEPENDS = "openssl curl"
 
 require ${BPN}-crates.inc
 
+BBCLASSEXTEND = "native"
-- 
2.48.1


