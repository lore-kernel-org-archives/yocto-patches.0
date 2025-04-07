Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5CC369A1
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.59593.1744061442368396029
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CAeC5dE1;
 spf=pass (domain: konsulko.com, ip: 209.85.166.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso48032785ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061441; x=1744666241; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJ0ycxXa8ZtzrlkVuKAN09IZZEgtY+jN+4VdpcGeSaA=;
        b=CAeC5dE1Shod6txXhhq1340OspimaXBQZHGqUQjyI6Y4DAOsHStfypHrE04j0ZyaHW
         NENGD8Sj6+qoIUHMoByRXAAqxEdSU6AAj0nRr0wMDdPYJLxdnFymbgOKsOccfKBPyu9f
         1mELC5AVzLF/YkYQmk2hRKa9ggjgS5ztznwCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061441; x=1744666241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ0ycxXa8ZtzrlkVuKAN09IZZEgtY+jN+4VdpcGeSaA=;
        b=VI1gbecI7n1EoujdloH4ICXPGUwLCi2yngxlBzt7yh4Bejk34UzHBXuYdH21rSTDeA
         yBF/jCn9XbTCzytn37Om+cE6PR0dTjb5NgjczPHZwlIhq/DxnfdaaIqtqu7DenaopWQc
         CM1rYtGMzmiHDS0blenjsTN4LHWF6UPlpJNJWSHw+7i975JwchC4vnvfWdGKRAk3rZxW
         zTiVeXQhoWahIp4JvRd0+suvBDq2Q/5Edwy7LRsJGqAgnzoX0aDcnlnSWXztd9wRVF2a
         pnc4UtPNHg+pXuIMnYa/q8gygN3DsrP/zs1iHySjHSlE1Ibm33OCWxZP1GXACjkBUmIO
         J3VA==
X-Gm-Message-State: AOJu0YzMwmQhKVzB1o4xNF0bBE/Cc2AMF8jVIwbk/tyIFU+FbdnrF2YS
	pX95JXcH1ZHZORo9+ckd4FjA54enduyKCU0yRDM+eJEHo71Qma6AXGToybNus6vDrierNRqjFsr
	izqE=
X-Gm-Gg: ASbGncs9BZvKdVLBosOJ7kX/pLcEVnqJQWXGt1Z4MznXrddSIQk75mSZFuHkCoocCBV
	2TVpHImShBTDFawzcCjqkhvmUXqQR2Icn4z553N4Ei3AcZ4b1qqRNsmWcFCm91wYYmnhCrk4bWb
	LdckewPURycpMPVbeeTrBG8XibTU6sAnk0LJNXXsJ7GMrkLsVCRSOYVVat637dqAiTpAheYRbEe
	UmQHHCdf+QDNmdTqQO/+LYXOanvQAr+ghqPv999CW9Gat3/ZHtHpjIs6U0meGKq2KOUD9J4jXb5
	5+96HRXAzIe2RpCqyo7OpyOnD6V3E8c2SCpvUD0+aVAsTBspQkOA/iwKskNNjggAariA4UE+s/z
	3IlfGg/LneFiA5z6pL16D8gbcwtkBhf4=
X-Google-Smtp-Source: AGHT+IElkKHwDoaT53jLx3cC75ngOj/qytQ9B7SqcCM7uYVsS3kgyzurfB+EkHCD/yfbsUY06QCJ/w==
X-Received: by 2002:a05:6e02:156e:b0:3d2:b509:af44 with SMTP id e9e14a558f8ab-3d6e53181c8mr172759305ab.8.1744061441427;
        Mon, 07 Apr 2025 14:30:41 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 04/29] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Mon,  7 Apr 2025 17:29:53 -0400
Message-ID: <ba0b64c09c8b5de2faac2b5c84ccc3864bc57ef0.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1304

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
 classes-recipe/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index baa3869..31331c7 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
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


