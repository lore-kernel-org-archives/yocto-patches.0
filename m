Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83508CD1297
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:00 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13173.1762633198345984769
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:19:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AIcugn8V;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-880576ebe38so17763926d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633197; x=1763237997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUcYdDT89aaj0m2FFnuQF3tg++xTtnIImmaD6wlHMe8=;
        b=AIcugn8V+PwWAa4l92Tp4LisES7anX4GSLZTLTR+PcupRlpBv/m5OO907RupleqI/O
         2lCQpQKd4v9pmFkFer610tJ4D2nAiHhvZAK4RIgOgkryN0cbSy/LuApsx5zbqzQIRuPd
         o7jPuNJ8eRV3AIMrYzk5fghpFmIwVF0mWGXFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633197; x=1763237997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUcYdDT89aaj0m2FFnuQF3tg++xTtnIImmaD6wlHMe8=;
        b=c62m+04m5n1ZK2i+Bj8EzmtJE5FNTxS+iAJO3PF2OOtNW2YdjnRwYprompdSe6Z1qX
         elYRiEcT0XxFB0W2JgCVZElQYX2Px2fGKS2i83phWJqh30R1qBRi+ScUBK+bzPCoZoEe
         G7O1YIt9x1X/zpc2cdy75rA0geU5WNdFpj3gi1ACen4xRv84qlnYYpCp3tumUHw1kfIx
         POCFczqevYFsxtwH9r3WVkC2EYXEye/JM6Qewh3fQHYzVp0Ik8qBKrkmShKTjbbkPtE1
         A0KNeD8Sp79AkaX96oNRwL5Xg3Zaty5XZrxSOMP97AQ9X6ElBQDP+l/OSgvUVb5N0ru/
         JdHw==
X-Gm-Message-State: AOJu0YzIYrv9/8SXKtdfdG3dgXh7TYqIAI1fRYAXPpIr6tB4C76CgUmv
	dlVFewmkiyRYyv1j/Wa9AkBPsqUjhd/tdYEjrmHnTxawYeXB+AwsDyFyyIZZzqsFs9v6crclKO5
	HqCpB
X-Gm-Gg: ASbGncuuYDeMrzjmuIytu1Ld6QBZY7BwiQxtTKvwpDkxE2o/16raFr7e4zltMErjPqS
	YSkZ9hGJ/Qxd0Lhyin+cZbXhVl9WfVWZuf4OK2U34zQKlLu+CIFdcmHYUvFFLdWLv+qQe2O0SzZ
	FWTweL0gCOzw6Dj+M6XAKsko9krJCjQlj5Dbf0yfDx3vjZsJH84QjmZ+c5T1rdiKYhqgNcZUyki
	VdC5MRy6ibHgWepeWn9aTOa4Kk6OUb8qI2SvB2yNSQk3Z59leP3XX4zdOouZ+kFUFkPUINNq9H9
	ltFgHvtftf2MwqqSWZ3p1mvOhOL2xRMD64V8hMwGcIwa1mwpAZ3/tH1ZajeyPEcl0oyB5E2hWBr
	L57HY0Xmx/8Wkohl8dePFFsC+6Ofr0reTJYsbZWUsrpdDsnIY5FOgoy4LJpZGWmO4xA4nO+IgDW
	NRQ3UNlFA26dxVNnS1aK2XbbrleKILuq0afiPJ/VRu8UGdCAQV7gCL
X-Google-Smtp-Source: AGHT+IFDKca0z75369QTZs17XDgBu2Zq887uPkTHtiNu/FtWiSwf7hLxDmg+anekfGIyk7HV/xc3zQ==
X-Received: by 2002:a05:6214:2682:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-8823868f7e2mr53026676d6.41.1762633197035;
        Sat, 08 Nov 2025 12:19:57 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:56 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 04/11] rust-target-config: Update the data layout for ppc64 targets.
Date: Sat,  8 Nov 2025 15:19:39 -0500
Message-ID: <abb6136682271ff9ce9f2def73d6058f936c596d.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2450

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Rust commit for updating the data layouts:
https://github.com/rust-lang/rust/commit/0680155a171d47772302fc4da4cbbfa466378d81

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit cf1972b7b96bb38b48e90654a8c840568e4646cf)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 6da4c26..0377fcd 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
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


