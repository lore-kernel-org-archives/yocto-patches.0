Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B55C88E64
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:07 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48535.1789157646277124871
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=stxuCuDD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5303932c4f3so7985201cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157645; x=1789762445; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sgl6JPzjQcOAGoHISnhSuJ63ZqNjMyOqzm7x8j7NYBU=;
        b=stxuCuDDtqh9Z5rfefKLnhHAAjF6PbRmQur5TgGchOr4/gaY2iTbcnMfDYtfRFS1am
         28BN2n7BUYCxr/RRqq0xjWg072Yfh6zsvnNVXdsFVMeyPm25Xpk5jBLphC5y+1o+bBpk
         RN1bVfQ2t+3rTeBKU20xFI6gdSgTLAAtZwuro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157645; x=1789762445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Sgl6JPzjQcOAGoHISnhSuJ63ZqNjMyOqzm7x8j7NYBU=;
        b=qUJw2w95Uaun2+YsjztTqB/d+eGlqZ/hIsOEXxEPBRzCTJTLcGWrapkE0+IT7ixENe
         X3AmE4BBqsBjL+tfNJk7IDvlF5O1BeSlgne4diyZysN1EopSlRT7N4VkDY698RNortIE
         /LoVi/Rqfp9Bx5/FtBBecBM+x/e5wvS5h21Gycj5bQZbr3jgDyUZIeacenj6tumBRrAx
         vx3BuS+JKylz4CNjZ8OcvnPMuqct1Rw8WZfGq9L8zefxrJK8yp9TXN0YyveW9cUa4v58
         GDKPrrt8AeX8lNAN22LL4hX0ZvMCD5nyOmTy60rzEhe4IDL3g01waucfEPVG1DixUSpV
         0s0Q==
X-Gm-Message-State: AFuF++k82ApUwZ7rGNzgVB8L+o01FT540W9koRM2DY0Jth7SpuziVL10
	0kmPdR2g0IjOcHDDE6CjbrFegDNuwW59KnASPZI4uioiZpr7TX90qFrm8GpvtLUArNgGPndET+y
	3yVFJ
X-Gm-Gg: AYBFou0DqgmFCu12ACya+2V6pPCGas3oK1gLWO/4i77+ybk96u7jV8a33D301ZO98Xa
	0sSXHMBNOGOMe94HozdoCHjF0TZ3BC6pIsG0iQI9EJ4ZezOSPZLlucu2Zc+JiyeV6W7haNF4b+p
	PWtRPUV/XAhldrHLB+Iutst1jB855XyAmIrkNRAf3KF9ApOwAq8mevuDswBEn++ubeD3n5zUXj7
	m41gzF3SdupgpxXD8d/r5FQQP7ChHenuCpjBS17FzqtAIpUMXIh8jPvU0RguMEqa1K7Fd6kh+wE
	tcio4VAObJgmp8rdjcmWHLSt8xor1i03fucj4TM+iyifgUxPRPztGdtYpo5ycuQPbh4HdrkmLmT
	tk7qAQuFzZFjtdwYbDLsmLiVpM7W5jABwSvp8iaoLYA8Srrt4kpVMROrXxZdG54A1cG+1PK5cJM
	VyrmkjWeySR/r7wek8rP7wAT972tXqUjpehHTeosnV4iID6RDuGe1rb2GLNP+Kv4M9vb4OyOx0f
	7wjUngSn3r9UDgFn+qb6iZsjeqpFHWlGPycNHeBFqljN5EO3zQnUG2zzf5Zc+bsisRH6qa4QLYl
	qiWT74DhPYH7XAxPPfP/XKSurOCJbplpYmI=
X-Received: by 2002:a05:622a:487:b0:530:98dc:f5b0 with SMTP id d75a77b69052e-530c8649727mr88588751cf.40.1789157644942;
        Fri, 11 Sep 2026 13:14:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 28/37] classes/ptest-cargo: use oe.path.join instead of os.path.join
Date: Fri, 11 Sep 2026 16:13:14 -0400
Message-ID: <f263f2ea8e05f83169d84c95e5bfc21bce9d6433.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4794

From: Ross Burton <ross.burton@arm.com>

Use oe.path.join() to avoid having to strip leading slashes.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 147ec3334896dab9f2a341752528f80fe78d28b8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 30463e1..f4c881c 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -85,7 +85,7 @@ python do_install_ptest_cargo() {
     cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES')
     rust_test_args = d.getVar('RUST_TEST_ARGS') or ""
 
-    ptest_dir = os.path.join(dest_dir, ptest_path.lstrip('/'))
+    ptest_dir = oe.path.join(dest_dir, ptest_path)
     os.makedirs(ptest_dir, exist_ok=True)
 
     test_bins = []
-- 
2.55.0


