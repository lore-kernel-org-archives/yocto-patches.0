Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E398BCD343F
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 05:43:25 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28871.1778823796393385369
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 May 2026 22:43:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EX0beiBu;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83ef1d17904so3576669b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 14 May 2026 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823796; x=1779428596; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vsC4oQ3fczLEvTuK3u5hq0xUH01LvK7QLkpe84LC8k=;
        b=EX0beiBuRoVfJIDND9pXuqXC6gFyf503ccbusEW9u7kCodcEFBrZMSybGOcATO9QSY
         YEH5O5pD0y2+KZvPy9fgTAVtFtytFnAYZlyQ2RRmFMWI9Ay8ZO+PexDU34Nc+uiSu3G0
         xEb5JKySh++0wzMCN/kUM491kacDEXBbG5f26Rh6Vke54gWHwiKx8aD8UunfvMWqG4tY
         xGLr2vrAhZastCZ1s4tZh5je7sCEuFFh95isEgPJPa+6t22kihW8XBTL+8XghoanM3vs
         Jvl+2yKiG3eHMlsuq2fLKS7kC4UtVfXgJr1RdPDWj9tC/XrKQiajB8sHub4VJ6nlrb7J
         Sm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823796; x=1779428596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vsC4oQ3fczLEvTuK3u5hq0xUH01LvK7QLkpe84LC8k=;
        b=fZWbLdxOsYW9cAveElGHvclYjdCurhw7Berv8hyqvIUVgwgdk6yW6ifJHSAKyFvMR1
         89GfErIITJ5x7wbJSPlOw5nynH0+PNVP3QDdls7KoGSzorKLUodsh2fv1T/4YlYsw3gs
         t6ykycM2KGSnviDhPtnd/LZsVRXQxediRrZu7LImu7rZRcT0txz0IS15tQQFKvT5a80q
         4uPLA9Es78L9WHFWmZQS4XDo3yMsNuq5mcmuzUPJi+TpB1qrEn4fCWjAjdKwe+zfo84B
         h9wJIVhXCJkNFT0hlsc8F3KZxyD0sSWYcsxAS7PpMuWYKJGYVfubVWbBSgfuEMA2aGuE
         kkKA==
X-Gm-Message-State: AOJu0Yx9NZCvnDmMsXIvhPSGHpHshEAJsoi9a/wmcQa6VpfbwJuikjez
	VLTmTpVn0sifQn5EI2zeS06fy68OkhulPmng6HfZsWEnxQlLStSix4wq4UGWh7Nm
X-Gm-Gg: Acq92OGEYx8Vj/lK9XfBBqpZ9LRJy7bkVLxMKrn9S8oDSHDuiBJhV2dHIVWPj9ksdZq
	1whxoK7bPidR+foucLJfywPtTlPIkDMj4urchbB6NOpzaQ2Z2L9nDgHMe8DTZfVGlaCq8j+hZKC
	/NC82/RreNz9dUC+k+cq/v2HJznlTrS0BYTxsci7efN3zXqUBnynKiGUqSuQ97gGWRYk97r0NKU
	3uo7gAPnwvP/Uq3SxG5aS0vHAEKTAbf4NjjFuPc+UbO2UHfeym5PUT05AKjVuM9CemqRmUbJL89
	W96ve1GYqnFz/7nkB2sr3gsPGL634Cv9sQAa6Z5LOSSnAtEYC9eN8fDc/yiXniHhdj8HIJ+2swI
	E7BTkUsgq74Fu1PyaOl6K2qBMrpFje/lt+gUVqnXk48Dmlafry8vJ3C4GUFCigpXUQCnp4aRInk
	HNSVWMybdvUndqgtqhQiEAte4QU2PHhGQHpoHJ
X-Received: by 2002:a05:6a00:244c:b0:838:a46:ce99 with SMTP id d2e1a72fcca58-83f33f3ab3cmr2761622b3a.48.1778823795708;
        Thu, 14 May 2026 22:43:15 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.134.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ce1fsm4560175b3a.35.2026.05.14.22.43.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:43:15 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] cargo: set CVE_PRODUCT
Date: Fri, 15 May 2026 11:12:41 +0530
Message-Id: <20260515054241.495473-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 05:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3993

This removes mediawiki:cargo CVEs from CVE metrics.
* CVE-2026-39837, CVE-2026-39839, CVE-2026-39840, CVE-2026-39841

Reference: [https://git.openembedded.org/openembedded-core/commit/?id=a5cb71e7df95925a5c342c341e699e244b1b84f6]

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 recipes-devtools/rust/cargo_1.92.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo_1.92.0.bb b/recipes-devtools/rust/cargo_1.92.0.bb
index a6d3f17..573430e 100644
--- a/recipes-devtools/rust/cargo_1.92.0.bb
+++ b/recipes-devtools/rust/cargo_1.92.0.bb
@@ -17,6 +17,8 @@ require rust-snapshot.inc
 S = "${RUSTSRC}/src/tools/cargo"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
+CVE_PRODUCT = "rust-lang:cargo"
+
 inherit cargo pkgconfig
 
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
-- 
2.34.1


