Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C70FC0218F
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:28 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.19375.1738174162568278386
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lKmSD680;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-84a1ce51187so193289239f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174161; x=1738778961; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QElZKMwfqyqw9kgeOafKEf3rn9vyW8TGMNMY65R+vQM=;
        b=lKmSD680Ko2vcpU20Okl3b1INbqbXmo47XIvGhokfGQD51+XDTfKzphtREcJuNc9Mb
         GCs3EeDrBDwtWRmqXYPtEG+vERMRhA78Avof5iDTfkvpw33QooriCCSXKSetu/6VRjer
         upCs3Zpi6QSm3rmli6g2VcAco92mpJC5Fout0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174161; x=1738778961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QElZKMwfqyqw9kgeOafKEf3rn9vyW8TGMNMY65R+vQM=;
        b=FNuOQ7cSQdkOIxgQZYPepi43ZQ5NhoZNWikKHQzlgtxPW9uW9ntfRri13HXmi9CViE
         UXwD64OMzc3Y82nWg0LHIAjxPNuVNIIBsIpiCK91uVChmHWwWTC4Jxua9z/THRGXfMmS
         Lj+UGPVOZc8VWNv2itZWbtxD6z/OCABiooH5+ojK9j1NQxfklYwyolKGeTyE8877109l
         15a7X9WsUddgI0yvgPm6kVeFVKNdnFzrO4AiejOa8mu4vhWzjvO8uReV/NGIqHNj1YFH
         T8O5nZaJzzCUa1x2uLNuu5wQtvWiZnyDgvzpa8TV1OtkipzcBpE72Rc7enbvUgYsUeNv
         MSxw==
X-Gm-Message-State: AOJu0Yxkhom68XYsPPX1Bt+8ff4XI2EK/OsMdW4wM2zegZv2EsYB/+pw
	w2pAzqfvyFFhyQrzjqZ7rmqZJuDWBy/9NDWDwQkwAGb7wAvjp3++iJ8Uc99ukktaGd2aAxdN6j1
	3
X-Gm-Gg: ASbGncvQt87GuPCLFoafcSP1h64Xb7SkM0vbs07Ud9t9XYZQXl8S4TjJP/QC0jVLZIj
	ySwaiFvd9udC8xjme38ypXB64skcZwakN6Nogi90pdnww36OmTG/NqKVusDja/F0SgeT07P2DFR
	1lSU6SgoGTkDBW2PxAFHIVdyPWfce2/H+pYPRsZjVuIJeth3Pj78GSi3SIH+AQETjeZc2yijojC
	6nDq9eaUF9EhEkXLJhXwUgire2x52Kop8utxzg3EYt1DUvqEmMJtCFO1m+az+9ko5+GZsiyajxQ
	ZX6EiNEQ2xg1JANpioSPlmXEMo0YEsOEuyNOgsXzHecUFtrqgwAd8zPwscFJRnk1feM=
X-Google-Smtp-Source: AGHT+IF7ot7m8hMfTyJ3VQLFUQLFHwwepgZ48ICjzv031ePAaAspbJX1uygbTSG0He5bE3EJoxh4PA==
X-Received: by 2002:a05:6602:3d6:b0:843:f261:60e0 with SMTP id ca18e2360f4ac-85427e05892mr468708339f.5.1738174161505;
        Wed, 29 Jan 2025 10:09:21 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:20 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 8/9] rust: increase test timeout again
Date: Wed, 29 Jan 2025 13:08:59 -0500
Message-ID: <cc6dd2e91467fc9bb7dd919a42de69e6b8a256ba.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1019

From: Adrian Freihofer <adrian.freihofer@gmail.com>

Fixes [YOCTO #15625]

The first attempt to get around the timeout was to double it from 5000
to 10000, which doesn't seem to be enough. Let's try to fix this by
extending the timeout by a factor of 10.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit fb19e038582a2bfc414465ef396c30197f67128f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
index b42dda8..bb27ca3 100644
--- a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
+++ b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
@@ -25,7 +25,7 @@ index 11f363d62..c12d66016 100644
      // Just in case `yes` doesn't check for EPIPE...
      thread::spawn(|| {
 -        thread::sleep_ms(5000);
-+        thread::sleep_ms(10000);
++        thread::sleep_ms(50000);
          process::exit(1);
      });
      let output = process::Command::new("sh")
-- 
2.48.1


