Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EAFD65550
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web10.53093.1732644735859121869
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UPh1cBgI;
 spf=pass (domain: konsulko.com, ip: 209.85.167.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea48624a2aso1332700b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644735; x=1733249535; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRLxbClEzQ5ow6xj6Ft7X6ncez5YTFXJyTzaKGiBdSs=;
        b=UPh1cBgIYeXW0KP+0vRizPFYymuvzPn/3/1z1On3KhyrkyPuXWqNFiGP/KnxbEmPs6
         4kfvqOKU49oB5Gbw8tPzVZPs2yBZGTvzK6dUrf9ok9EU6Jgpci+xdf120a8XEZFMrk9k
         Z6ySd1avcK06SI5HckSktsJhpj6RHaNZtdsbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644735; x=1733249535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRLxbClEzQ5ow6xj6Ft7X6ncez5YTFXJyTzaKGiBdSs=;
        b=W8f2o2t+PavQa8U5Fs77pQrBmVtYcTjCd7EDMk9b1ASKzcJfL127AP/F5BJ6984h0w
         VVXd26aXrhJai20GY3NFYejr84Z9Pj5m/WB6Z/JXwgtTU+bYdVT8vpiduOlygEjukCRU
         T8WkkkbscMsuwcPjZ7d20Dwg3qiXxt5TK/90RhxpnTUBc+oR5bFbG+75Pzm/UyfFb+Yy
         3BMeUyWYgHgcLT9AM9eXnHXnskdPH4n4eBOw6/ozhmjqEqyzz8G1U7SLN7cRNaYK0ej2
         4D9HWt7mSbaKMjCtaC/LGyzN0oT67/LiMQMo1fpRhSPHRAAuReHeSZJRI0Eln+FViWWy
         4UWA==
X-Gm-Message-State: AOJu0YwcRYqGDLagKclRJlHK+Rq4i+ZsbK7A9e1o7T497p3UeBrHF23R
	A9liwkiSSQO0mmVPL8NewRxyNqYldx8wL2a6HSSCiRc0rye7bYfathV3ZeAqFl6A4CCCX32Ge1P
	x
X-Gm-Gg: ASbGncvusrO1kQ+nHWTx2lze+oMty413W7nb8fCoNLZBprRcjGn4VCoogUTt6Klfhu6
	rhVgMqCAGn1pN0C83W8lI5oxZ4r0aQ8cktk4DslXvzZ7jykdH0sgCfeyrrC451PHvalQ7auaxkN
	uOuZWL+K9AjUaqSShfQ+V6Ae2+6+F9FI8AMaG2pDO9ww46kxoqoq5QNFhToHLJDieQIT8akWPCf
	Q5upMxpPVsN/bsZAIX+YZCBiav0W0Ivqh/YU0G1Qtg3ipDQSQ0O08s815BA07k8P0FWnMGMzwpo
	s43R6yt3SQBY7rA+TRx+ljg8uA==
X-Google-Smtp-Source: AGHT+IGSH28dNiKhqsJi27Oqt2enuwjwjbqzsaYHl9uC3q4wSk1sBjNat5vJIfF06ikqvg/WAVZqEw==
X-Received: by 2002:a05:6808:2018:b0:3e6:3860:596b with SMTP id 5614622812f47-3ea6db6410dmr438587b6e.8.1732644734938;
        Tue, 26 Nov 2024 10:12:14 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:14 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 4/9] rust-target-config: Update the data layout for x86-64 target
Date: Tue, 26 Nov 2024 13:11:35 -0500
Message-ID: <20241126181152.407253-5-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/836

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

The data layout for x86-64 target was different in rust from llvm.
It resulted in the following data layout error:
--------------------------------------------------------------------------------------
error: data-layout for target `x86_64-linux`, `e-m:e-i64:64-f80:128-n8:16:32:64-S128`,
differs from LLVM target's `x86_64-unknown-linux-gnu` default layout,
`e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128`
--------------------------------------------------------------------------------------

The issue was reported in meta-rust layer as:
https://github.com/meta-rust/meta-rust/pull/442

Hence, the data layout for x86-64 is modified as per the llvm sources which fixes the issue.

After running the testsuite with the modified data layout; it was observed that the
"tests/codegen/i128-x86-align.rs" passed. The modified data layout fixed the scalar pair which
resolved the testcase failure. Hence, the testcase has been removed from the exclude list.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 96f11d299b32a32086eb3d890c88eb7ce42057b0)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index e293272..993706c 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -153,7 +153,7 @@ TARGET_C_INT_WIDTH[aarch64] = "32"
 MAX_ATOMIC_WIDTH[aarch64] = "128"
 
 ## x86_64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[x86_64] = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
+DATA_LAYOUT[x86_64] = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
 TARGET_ENDIAN[x86_64] = "little"
 TARGET_POINTER_WIDTH[x86_64] = "64"
 TARGET_C_INT_WIDTH[x86_64] = "32"
-- 
2.47.0


