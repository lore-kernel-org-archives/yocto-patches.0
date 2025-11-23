Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392ECFD31D
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5038.1763941529976839157
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VMbidtpD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2dcdde65bso560151385a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941529; x=1764546329; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLxBfJueovbo3gTdK8FYBULNuYYFWxvoDIshRGYv65s=;
        b=VMbidtpDdXnS24MhfemoYHTVr9VJQRLlAOyLtzB4PTjcb9H+M0q37wxMRZMfdSVDK+
         Q+iKMF9B/kDlYHTstJztVJLqUvoGqEazRGOa7nY+lkBzsyPCEIHH2WC8h6cQkGomkAwJ
         uqQIe8wU93iV9SnQXnOFsTBBZC1v4iABB2nY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941529; x=1764546329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KLxBfJueovbo3gTdK8FYBULNuYYFWxvoDIshRGYv65s=;
        b=W2OZ/2yWV8xOXELkqUE79ZPEt3t9dDJbwDVtOJF1BhkOjrilDZ2LHHSTuPfq8oYibB
         +SwLApzLLI1gv4QypZQoU+/BbnvtaD6ZGdhcKTRMML5l+kLs38ncjpE3BKRQEaJMGuSC
         ZS7CPS/nzLoQu3u8F5XIRqwXgcr5VUalWT3TY9jY1vG/mMPSr+MLwi9RZlldHQIDLw3J
         uUcl7VPaQ7h04liihwiPFA+jtCawRFqGxYRE9uXjVs6tyNXiZ1BJ4VcVq+54uQZzqUds
         nMsbl/b78vvdvXxMdlHJW5kuMmGQnaQpr+9s22J6chpKbgO0gHXgCiLCluCF7LsZznnp
         +xiQ==
X-Gm-Message-State: AOJu0Yx0xJNgsJ8vADYTrP1m7LlaRt2NlpptjvER+FgH/6672Q+3ytTX
	9cM8kBYMODCx07pr1scZr+GyYAAma7vw61pJ5eAGuy0cN6ANZKP6JYK69N8lis7mJGYtdNODBC9
	HbtPE
X-Gm-Gg: ASbGncukHYWIs+CcLtxhOq5u2r7Bk4pXFwomlBbMQQS4GheMdP4n+nxfX3ncSE2mA80
	GQxn5v07ebSk9hrnsWTTE/8xvgcjWAAQiFUwcLEsEV2v4NEq1jNcKtYF9BqHKYMHaKwdOm1flUI
	YUScfftEqySzZ2/bUvKdQ8IvNigaITJNLGv7Ohl1ozYg+KC3yJ+pvluMiBVEsgNT3cIABmk/SX6
	3wx9cKSp7JKdlxHXJXwcJk8LYUNbFoh3b89C5A72Qh8QvLd1NxCIzQqShCUY1f9Hw9aCdDCXXvc
	zOuH+yeXXxPVFsEvXDS9oSPbbvL/p5QDyhuU66UCT3NOBbPXbJ8j34kKcidzNcZw+RDUvRhpA3O
	rjS3qdxlOk1HC6jfNsRnyaO5SjBcFXv5Vp/YCsS6JQLNxc0YUYoIIdY7mqJAzDypgotx4Vaygap
	cmzoZ/8bBYxxBo7lPDqTAvFWGmd9K+rCH29HN+C/cWvnXSjDdvsdHR4vDbAY10ypHkQw7DWi68x
	w==
X-Google-Smtp-Source: AGHT+IHFP9GOuGe6EokZ8W0GnD0xDg0WQ3f0tpKMpOu7MhzubW/JIjf4ai8Fx6KyyztUxmD9AN41WQ==
X-Received: by 2002:a05:620a:4712:b0:8b2:6bdf:3d15 with SMTP id af79cd13be357-8b33d21330bmr1300067485a.8.1763941528494;
        Sun, 23 Nov 2025 15:45:28 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:28 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 12/32] ima-evm-utils: remove unnecessary FILESEXTRAPATHS tweak
Date: Sun, 23 Nov 2025 18:44:52 -0500
Message-ID: <6be5c4ef33389075dbaf87d207ddabd6aeb11531.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2670

It was pointed out that the recipe was wrongly doing
FILESEXTRAPATHS:append, but on inspection the recipe does
not need it at all, so just remove.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
(cherry picked from commit 5770a76fc0d78a645ab254979986f572fd18b3ec)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb         | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
index 8ac080c..ac0a383 100644
--- a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
+++ b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
@@ -6,8 +6,6 @@ DEPENDS += "openssl attr keyutils"
 
 DEPENDS:class-native += "openssl-native keyutils-native"
 
-FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"
-
 SRC_URI = " \
     https://github.com/mimizohar/ima-evm-utils/releases/download/v${PV}/${BP}.tar.gz \
     file://0001-Do-not-get-generation-using-ioctl-when-evm_portable-.patch \
-- 
2.47.3


