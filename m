Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3459DC87FCD
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.23091.1753297552077883790
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=N2p/u2c3;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d45f5fde50so21373685a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297551; x=1753902351; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvHZXpQLEdorX0xqqORIFGXVSgaZOrhurpYjlYBVWFY=;
        b=N2p/u2c3fkmLUwvyXP/jTGjhPlUzAN3n6sOpOv99xM5e9tSTooOyuY2FJ5j75QRa88
         j1nqsEYwAWKcP9aygDNrCzhNZ8HhKnAyrp5+kupi4K/xLBg94672H0w1jhpJloW/IpVD
         G/TdWUwXOOnxglv81IcpRzwWsjh63ejJQ8fzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297551; x=1753902351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvHZXpQLEdorX0xqqORIFGXVSgaZOrhurpYjlYBVWFY=;
        b=hxTklvzSNO7kkDTdCwa1j0brPYmCodL3CKVvgyK8sACjrr5nbf+ipfUyWoFGsdf8OH
         IkkgQqJGWc3Eu2aqZm+zFFI7UlP3bM+DdLyd7sLbkpQR7H0Lpb9w+pD7eSLgWI2uF1gs
         Z91E/TRKPInQYgJKQ0NMVb8Rw+2HkoIBzD/KD8FncYP5LexwXLR45NqTePXsbHuU7qfN
         zEm3pQAqkU9XGyBPuDVsYS93lqhOBVxBNxpiUCIkz9WWrYdh3Hm56onQuM/jM1efyZnb
         OjePBFhiWSfnQz2smAk7lO+5P6T5dsp8Ny+u7DUOqXVA4FNDHosslsyDx+c2ubllLrhI
         q0Ug==
X-Gm-Message-State: AOJu0YwAh2eggCYuUR5H4hh0DHL6Vrj4wXydcDgt6dZi6QH4QD+up0Im
	V9f1do3RfzXvQdU6M4Km6EWTa9PcILS1OVY49SWKitkGHZF6vXz/jMzokwsgaSACFZLfCVG20ev
	0pqW3
X-Gm-Gg: ASbGnct/Cc7QQvT8yMUYpgXn0lF2ZaWbBM3QkrN0oJyJJDAtjEeHyFuShBI0ukMYI7t
	4/h0d+caGpkWwPw/xGtCmlPmVGpR35jTr6p0JmHRz6CtCXSf+49/8uFmxLYy7BiVKH++bDw0cnh
	BQaHA3RKsETEMn6hrlYNJPKh4TMKMZTBJpzCRMjtKwsjX126ACVzTVT2pbqknspzAGqmVYnmqkj
	jbTWfm2pdQTzMfDVIeQHJxXPx4AMXjdaxsbcmoEdBPsmIh1ZhhEUmmkFLddr/YhK10WhdGCANJO
	QD+jjsCl7Dt+dUVr4en7Xfk6yRQeT3TSw5i49D+RAITV0pcHkYMStvVWlzUOrbuO10IFq7DZQN+
	sjFohIE+7yW+uYz+Bim2wrTivj6TgZzTI0MmXOUiZxqt5XhqC2mMZMsOATFbGZYHASMq/VezDQw
	==
X-Google-Smtp-Source: AGHT+IEOGSDHaIQNynMm5kN1OY+gnfiC5DBEPx3hfyvvX7ATDx39yZtFjRXuuDkEi+/CBivndTEOfw==
X-Received: by 2002:a05:620a:4156:b0:7e3:4725:3a06 with SMTP id af79cd13be357-7e62a15547cmr510177485a.31.1753297550914;
        Wed, 23 Jul 2025 12:05:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 05/13] rust: remove python3-native DEPENDS
Date: Wed, 23 Jul 2025 15:05:24 -0400
Message-ID: <2a83a8bf8c9b9db5c14fcabaf5315c9e21dd4d90.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1846

From: Ross Burton <ross.burton@arm.com>

This dependency has always existed in the oe-core recipes but isn't
explicitly needed here: the host Python is sufficient.

Note that rust-common still inherits on python3native[1] so this doesn't
yet actually have a meaningful change to the dependency tree.

[1] oe-core 4abd6ee9d48 ("rust-common.bbclass: rewrite toolchain wrappers in (native) python")

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit aee45fc067b2ccf3e365deb94584089b60cc7d4e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index fddd9a6..90c6d5f 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "file-native python3-native"
+DEPENDS += "file-native"
 DEPENDS:append:class-native = " rust-llvm-native"
 DEPENDS:append:class-nativesdk = " nativesdk-rust-llvm"
 
-- 
2.50.0


