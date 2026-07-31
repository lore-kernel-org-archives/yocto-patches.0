Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70F9C54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:55 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4604.1785497628064362923
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g8y/hFMs;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c9211d2so67735585a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497627; x=1786102427; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+ZhW/tXGwxiAgjjzfFc7q9QYTo3A0Xo1wVsfoXAkxDY=;
        b=g8y/hFMs9jNA/XvXsIW6vjdp27RN/XXl9NC85u3qTN7DM3s5irAIBuXs0+wUvT2hjO
         myRqtAMCvByiyGNjzIQ0X4vXgBPg+refFIQ8Q5dZaVJGSst0kTo0rve0dpCtatvRyBll
         L7uoOpGHgbQR8aW6TM9LHGHN3PJchPFWxuORE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497627; x=1786102427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+ZhW/tXGwxiAgjjzfFc7q9QYTo3A0Xo1wVsfoXAkxDY=;
        b=gwUa2spGIOBmOUudkBMCN2wraUe+ZoW7iaAA/CCVwdb7pTqkpENUU9mowvZdgB+ZBg
         YxKIN1jinn+ySOAlPnqX8/3T1hZq7IZlCBMa4uBGGHemN4rx+CAK8dSBX3QWWK/iiqGx
         p/6H+5Os+xKKI3Plkyo1vmsO835whgldqJ38rIV1urssD5P0Iuu/Ph5X53UeRYPmnYzQ
         q9G5L4JG0uQsun0Kl3AXVpBiDohqOM3GuKjiI4aNgltSy4erptv9JkotOFyxJSXxiNmO
         lHTpgpoSxHXh6u/10PvSwCKQ/NJVT7R236ZoDJx00RpFcmIp4SnDcAO+YkjsSI73Nswn
         1qbw==
X-Gm-Message-State: AOJu0Yx3lUdRm9RauE4QYvU5fzKvAZAMC5vTge0VQ9+U+WrI7pBHkiek
	kXfIzM+Umcj7ovGEz3wELb9acA+kcgOIoC6JoDGBSa8RBSYzN4vXy50Q1B49M8oRvz9jJae5UGv
	gNO4N
X-Gm-Gg: AR+sD11/5vZG8LhsIVmiJa+0pmmxyXAmoFvRmM4y0SAlHez4meKbFJCBZlQW6k/cham
	W7YzEoremxa2xxnc7f2U7aWcWUHEeSzef+lugUxY+KVMUq44cGj/Po1ELSnzR9kIdEREuf4ZNZe
	+xikmEAE6XylrmQOUjQVmmm2LuA+ARVQn4UQ+Te0in/3Kmaafb88EBh8K8z23NgJ12wwSnRj2cp
	8kYe7rKqTYBK4wpD5s8KxSUl6moDHhWRasF0CNJtpWhILBAPYEoyPbmWymAzIHQR2AR4Kynrr+z
	lhpjXgVjcC8TP+SIMHR2+WvplBMeEfEwl665hkWFAQFXOfh3Ga8cvfXsYQVUjWhjR+F6JQ6MFLK
	cJl5YGZeMPdVhJPiMuKDuiGwmzwMCD2Qo2n3LW2TdPhmtolnFQAvWiWER9lN+zLhfoaHI66zI41
	UTzTN17+kTxEivp1y+zwK7+3pyvDlJ+KZtEYd3GSO15dsD/8MngQ/IEgxvxWmlvG7zFjWsqhzar
	BIUZY4y76JFMVWKCcmm5mZSIv+EgCw3pOPho8NIVfX/bKSew1DfiljNvssOAd3MZ2UCm/T5BG2Z
	2Pwx0TXssACL4MEhY/wsduBy4Q==
X-Received: by 2002:a05:620a:4392:b0:930:ae2b:10c1 with SMTP id af79cd13be357-934967e505amr228753885a.42.1785497626732;
        Fri, 31 Jul 2026 04:33:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 34/35] classes/cargo: fix indentation
Date: Fri, 31 Jul 2026 07:33:04 -0400
Message-ID: <f879150cf01b8593e2eb2fe26b00361f18edb29b.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4610

From: Ross Burton <ross.burton@arm.com>

Fix mismatching indentation.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 0ffe43b82eeeb1c490e04f983c941b71cf11e5ab)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 2dd28e9..8e05a82 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -61,7 +61,7 @@ cargo_do_install () {
 	for tgt in "${B}/target/${CARGO_TARGET_SUBDIR}/"*; do
 		case $tgt in
 		*.so|*.rlib)
-                        if [ -n "${CARGO_INSTALL_LIBRARIES}" ]; then
+			if [ -n "${CARGO_INSTALL_LIBRARIES}" ]; then
 				install -d "${D}${rustlibdir}"
 				install -m755 "$tgt" "${D}${rustlibdir}"
 				have_installed=true
-- 
2.55.0


