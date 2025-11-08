Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BACCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:20 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13115.1762632972326222925
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IL3LtPqP;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eda057f3c0so13994901cf.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632971; x=1763237771; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTmLnfvuM9KshJejiS5QYH8OAsqqkT/0xU8xzM2wwv8=;
        b=IL3LtPqPAGc3lgrmMNceKyNj2IBugDKCLRzqE4+HyAboKcYGZfl/Kyp9h/pHZTFong
         WzZ1Vz9K8hvkXsdVsBxCqBByOCmfndqNuWLKrsEcfznU4xrrITdtwzfmvsefdNbCa9Pd
         6i0aLOz85gtIK/SYURugFgGjsC+dbFzigT1tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632971; x=1763237771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTmLnfvuM9KshJejiS5QYH8OAsqqkT/0xU8xzM2wwv8=;
        b=weLsqfs/grzswc2bueu6Yj/RcYeVDYAMHMlkf4ezzUf+YGYkFM9zug47iVAC5GyNWf
         TwU7hMxFr6vaIWrWAtyhYxKtRtlVXOgM5V2LaPKj57YD8x492O9Eh9hBjqWIVXqfJ+n4
         nBDfH0x4xZ7qSNSx5PWNWFKKywkTgAv4jeF/vEgDz+P9rnlJRR2mVxKtns8USUTSVF31
         KAPyEYSR5Px8PqXXwbQPJO3Iu64HgND2FaQGAAwT48n6N5p5v9RG4AcIVHPfTnEtdaOU
         GRgDgjlaLSL61EU9bLroGaSYPHCxfjj4skQLN6KApCbZyfAt4vKns9cOkI0xxNb5kQcs
         34LA==
X-Gm-Message-State: AOJu0YzuedxV62LHweMYhYLIfet1qGDoqrrKcfZpLtJIxHoo2/KJm9RL
	mSJLa9ZRR0hrQwlUE1tj6FwT7TTEedlVlsO/yBstPRwKpcMGUXsr1UHD8xALtXwCs5n62vH/4Qg
	M/k3z
X-Gm-Gg: ASbGnct9tKS2enElPDQNHGk+C0oIBOC20xc+baw5AZF+PDti0E/HnMqbU0qqn9XPBs6
	4u1dmqIz5TwFJwCo1JXaKsdsS6ZM8XhQk4ey7iEs9qgV7MvqVkrZmSyDin575e7jxehuZY1tEA2
	FaL7aPAyX+fNxE/MR6+P2qljqLrv6Hz5IuErPrlVSPtM6Am39rmwhByU6CZbiZfI43HWDKGIeXq
	Nsj3u5iEaSz6pjazn9Eg9VGqXbucuR5lI3hVUF4nzCCQLxd1SNHFCe+gFdqJ5ctIplPem9NkY5f
	0sX1IJ1cB2y3QnRT4V8sqpQ9T1vlZAUkCOPP8lAzlH25LJFwYlo56gx6yEq6AajZhZbJtfpylMC
	s/Azg5/5bLcj5c+B4KqnC1pYDIV7OHHKVg+8C5yZGcZmpbsVxImNnXkHCMAicyCvl+641FcEQ7e
	DqNwybx61jHBXB5UTMlmkuwVtoNxquTrZ5jHv0k6G5gJrPPl1ZYEKXmgvMJpvQKYQ=
X-Google-Smtp-Source: AGHT+IHPVcJmpsZufv46cRLxMC10psx5v8qlb5Y/Lu6NfGBva3pCE+EJoaMNcgbWu5dUjvTjnWYyyg==
X-Received: by 2002:a05:622a:d2:b0:4ed:6803:6189 with SMTP id d75a77b69052e-4eda4f90165mr44924951cf.53.1762632971001;
        Sat, 08 Nov 2025 12:16:11 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:10 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 11/11] rust-target-config: Fix ABI override for powerpc64le target
Date: Sat,  8 Nov 2025 15:15:53 -0500
Message-ID: <88ee10acb0de3da6b3107fb7a8617c8cd56420bf.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2446

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Ensure the powerpc64le check is exclusive by using `elif`, preventing the
powerpc64 condition from overriding it. This keeps the ABI as elfv2 for
PPC64LE and fixes related build failures.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1d4067329d0b84f94aaf2f63d282bb9c99ba5557)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index a81532e..b351638 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -388,7 +388,7 @@ def rust_gen_target(d, thing, wd, arch):
         tspec['llvm-abiname'] = "lp64d"
     if "powerpc64le" in tspec['llvm-target']:
         tspec['llvm-abiname'] = "elfv2"
-    if "powerpc64" in tspec['llvm-target']:
+    elif "powerpc64" in tspec['llvm-target']:
         tspec['llvm-abiname'] = "elfv1"
     tspec['vendor'] = "unknown"
     tspec['target-family'] = "unix"
-- 
2.51.0


