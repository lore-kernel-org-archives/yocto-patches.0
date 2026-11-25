Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3053.1795645884515051645
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tY5IM/Ry;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-55b8cd4e2abso65321751cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645883; x=1796250683; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TLrG1k+rsP53uyd77nJVMVu2iAlnBJLXoG+HBz83YK4=;
        b=tY5IM/RyH0ux9Y2EAxbJAcJF+bo0o4jej9Hp7g4Qt311Ce+7PDoI60L/CaWNK8TT1e
         JLg4SCX4E5CAWauvAnjiSSLPpcpl2zvrY6m2dir6lQxECOcUQxUWVwi58EUZ+H7zViGP
         cnCikXXA2R+d6o/ZwxGJKLDVddF4NfPGA3J3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645883; x=1796250683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TLrG1k+rsP53uyd77nJVMVu2iAlnBJLXoG+HBz83YK4=;
        b=t7W0DtIgf+lo13dSt+a/uu5BZeCXwey2UTquPJPzOrA8KZCx6RbHmUzaeMFN+YJpsb
         pJqKnL36UxBfVrH54Sbg95Fpvnf4ZnnBVL/ErLPfDGdiguPIjILc3Rbz00fonao+IuAE
         Fbc8bqABZDm56GTK1aWuxt6jdzOtmVvx30JogmSiqAy1zu/0GM0u5tqgV5uaZsFZsW70
         ZZ4ack5aGG1FECYCiqEFa6IvwnywJQAkdGFYNROn4tRTGna3+lN+Qha/TGa8ZouFpxFF
         +EQxH53d0C12gyi/8o4G62FCmPDBfDWV2bo9hUzGF1iNepSMJR1mhWXx1gCnpCYQ385U
         l9zA==
X-Gm-Message-State: APuU4Z96ASAe4m62jPU/eMuqYQKx70pyBkwK8TDNkZ1kwi+DCYJI6XiE
	ruUE2jdbknjtVaFX5TSAEvp3Lc6VRw/1ptVmvGfxS+u57c9BHf4xbvzCAPzucJRH2YW+vId8d2B
	u/K7y
X-Gm-Gg: AZFdTZdgNedv5tEEJ2rczClvv08D8wAg3H23CvfCgGVuBRnylpr5YhU1n5TCy9H8gO8
	WEXZIcscPjkcmzwkltuM8UszMokdo75DgSq5PZtncHpRMd764OPCLc7km4HJUgMPo2ebfzwVyJe
	XWfdycjiy3c6gxrMI+6j7vYF6niyDtY1SSo8A1glH0WHtBoCnLRqkhy2hW+X9y0BZbZ1fW2ga5O
	ZtSEg8GA+/GSamo9D2XvyoOabrqvQn1BIxd6EETkRY9pFmcO4LOmIMPA1X+NV3rqxEj8r6budxL
	zXutgW8hvOaECJ34GfDtDnneSBKMiizYSkjgST7adRH8sxyo0MUijVu062kMb6YkzBpDFc/0EWe
	rOUoptDhZjuaY29PvJ0j6O5zMmO9JbDMjFI6HgTJWf6Fi4DZv2EcTRSTbLKUr+V+H+idYaNDY8s
	heO89FruHg1AaZexOXLk3MXydDhHvy2pan0QMsywiIrSIGxyp+ka6bHLqPkHrKEHmwSPnfvVh8K
	ZMOPtaM470oXUH8mbGottLvXk5JIguln4tE/OLwvvwbY76xz9OZASIQD+zGlzRJt1x9xFvX00rs
	UWaAccBr7EQQXb1/YS7agSjRZqpZL03AXYtM6Of0Iu5CF8po5T8ZHNt1K6SixEB8VZifsdsABec
	Krnnuid0UNwV+q3pPf+eQPW3Gmxp8AuaJJ4XJwpRzYCqYFnrU3Z0lPq8sSDF+gSbPTQ==
X-Received: by 2002:ac8:5cc3:0:b0:535:23ee:eb7f with SMTP id d75a77b69052e-55d769940d3mr355342951cf.1.1795645883334;
        Wed, 25 Nov 2026 14:31:23 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:23 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 01/19] rust: add secure-plt to generated powerpc targets
Date: Wed, 25 Nov 2026 17:30:52 -0500
Message-ID: <e33b8e6092b9814472ce060241e7cffa6402e444.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5520
Content-Type: text/plain; charset="utf-8"

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

Rust's built-in powerpc-unknown-linux-gnu target has used the
+secure-plt feature since rust-lang/rust#136154. OpenEmbedded generates
its own powerpc-poky-linux-gnu target specification, however, and the
feature was missing there. Consequently LLVM emitted objects that were
incompatible with the secure-plt toolchain default, making ld fall back
to bss-plt and print a diagnostic that rustc 1.97+ exposes through the
linker_messages lint.

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 88c0d94bc177bd8e3edc016316c92528c6d38586)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 619a225..8398ae5 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -229,6 +229,7 @@ TARGET_ENDIAN[powerpc] = "big"
 TARGET_POINTER_WIDTH[powerpc] = "32"
 TARGET_C_INT_WIDTH[powerpc] = "32"
 MAX_ATOMIC_WIDTH[powerpc] = "32"
+FEATURES[powerpc] = "+secure-plt"
 
 ## powerpc64-unknown-linux-{gnu, musl}
 DATA_LAYOUT[powerpc64] = "E-m:e-Fi64-i64:64-i128:128-n32:64-S128-v256:256:256-v512:512:512"
-- 
2.56.1

