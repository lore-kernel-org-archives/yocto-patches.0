Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48420CD129C
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13109.1762632966429151348
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BtOPfe7z;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so17666946d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632965; x=1763237765; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcBzFIBoXwPehpuZK2QJ5W6y3JogdeLXA2yabwwxC28=;
        b=BtOPfe7zeZSwnlz62duAg6pfVhzPBKQ4d8VqzcwQ65DcbDVip0nPw869qKT5GlMx5+
         hPVzyteK4gawsM99/ie1Nkh8tkLWT/YgmMyYmgA7y6bD/eBbuZcnjv//kNZrB2rCMTLa
         k5l8U54GgQ2pUCZNI0vgP2KjlknghEgfDq8iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632965; x=1763237765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcBzFIBoXwPehpuZK2QJ5W6y3JogdeLXA2yabwwxC28=;
        b=BXpQLKDGvFtoXP8/GeOorA7qnWYK9dXOHsulX/ANgRsR6ChHl8Z+kd1fSA9MrQqdXX
         yyUkiESGRJcXBr08M4m0sFLlZ25WCG1ns2vts4Js/vy757pvOhihDBYH5EUVwzlXpzKT
         k9kv1+Oer2zFLy98wSRck2Ik9hDA411nPx6Q0B3yDntc9LJM5+axMctjv2+aW44T+Pfd
         pWwKcBmM/G1U/wWWx4ft0OC3gx3xC06gb09IPTJVqk4EEsWWA0daZaLZ63XRlF3Xe2td
         Yhhjhvem9a9yMw2iAamM3XrjzmT85wESYH7TbMdJmpP6Wn1IWg23lVTkAD2li8pdTQhZ
         EFTw==
X-Gm-Message-State: AOJu0YxO8YbkHTxkZF/BF6cPZH4Mfqf1LoTZy4ib8gpZ1xlJYko7atI3
	Zr9a4PdI4t7EX/Eloc/ddZFfXx41uGLo94GzWAIq0GDAWdIl1ubnzZbOKVb8JbwP3TQY7CV270W
	s8AGr
X-Gm-Gg: ASbGncuglmIrpmSzR1ongif7F4HJ0glqOCJEGEdaAtozyZotcPBvJ2Ux+HDJy53OUXi
	c/Rcv3rC/xERvShSqbE5B7f3GJTMjNwjFgmMTaonqloVEFaYGaqXaC57k5kBAbVtobNjIZfy3er
	yju2CZQX2Lalpk/U9QMPVNUuWVv2utqKSN+O04vt22kR9HMfma8orVdTAi3YDNXDbr2IXxaeExe
	MT/3yW048T5gbIpO8OhjlO0wYv0aBgLVpWLQI8TvXbB0GR64SksKKWVyd9jQe5qsePbMwcnuVUO
	YxnbpMbPpKBL3nUhjDr5T68oXM1HPQn9QYGq5Gnz8Ax8qnJ3/LridtgKc83DRpIby9JSpZzZX0g
	W6rH3MnZW4tfwp++TLKFwlND0/oPkwhUOAqkESWZ406s26nSVeCvgrciBzntzx3RyMcKzUZhzL0
	RxalQUGolV//SPiE0Yb9N/ZJtdXasd7FpUxshiB0lDeC+0ZUzVLfFs
X-Google-Smtp-Source: AGHT+IG2GZM/ffKaofixYC2wx2mWpa5e8E+4SvIUtXJKeeUAcFChhc86mrHU+KWhxYgVvTYQhjTAIA==
X-Received: by 2002:ad4:5ca5:0:b0:882:42a7:9a10 with SMTP id 6a1803df08f44-88242a79aeamr22700376d6.19.1762632965051;
        Sat, 08 Nov 2025 12:16:05 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:04 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/11] rust-target-config: Update the data layout for ppc64 targets.
Date: Sat,  8 Nov 2025 15:15:46 -0500
Message-ID: <1f02d0ef0b65644ab7120c19a969a0798ffda6ae.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2438

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Rust commit for updating the data layouts:
https://github.com/rust-lang/rust/commit/0680155a171d47772302fc4da4cbbfa466378d81

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit cf1972b7b96bb38b48e90654a8c840568e4646cf)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index c2d5d3e..63c7e8c 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -223,14 +223,14 @@ TARGET_C_INT_WIDTH[powerpc] = "32"
 MAX_ATOMIC_WIDTH[powerpc] = "32"
 
 ## powerpc64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[powerpc64] = "E-m:e-Fi64-i64:64-n32:64-S128-v256:256:256-v512:512:512"
+DATA_LAYOUT[powerpc64] = "E-m:e-Fi64-i64:64-i128:128-n32:64-S128-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64] = "big"
 TARGET_POINTER_WIDTH[powerpc64] = "64"
 TARGET_C_INT_WIDTH[powerpc64] = "32"
 MAX_ATOMIC_WIDTH[powerpc64] = "64"
 
 ## powerpc64le-unknown-linux-{gnu, musl}
-DATA_LAYOUT[powerpc64le] = "e-m:e-Fn32-i64:64-n32:64-S128-v256:256:256-v512:512:512"
+DATA_LAYOUT[powerpc64le] = "e-m:e-Fn32-i64:64-i128:128-n32:64-S128-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64le] = "little"
 TARGET_POINTER_WIDTH[powerpc64le] = "64"
 TARGET_C_INT_WIDTH[powerpc64le] = "32"
-- 
2.51.0


