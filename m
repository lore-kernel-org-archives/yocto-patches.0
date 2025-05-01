Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD4C3ABB7
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.4671.1746132070451775492
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uhJsW61P;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so28958526d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132069; x=1746736869; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnGOXR6noMjOO+PYxqABh5bK+OszWgRs+sFklmHt1g4=;
        b=uhJsW61P5xVSHjzHVwDcYNZxFRyiyg/C9Ntq2Dr+oyqLe4XTIfdkpKPEYWjbXaBwBh
         kLN49bHSxLzsx8dRz1JHBjYJ0pnD/AhfarWHq5ITGc6DuWVf/22P9Jpf0NCBYt32Bp8N
         Gat6nCSugZ+KqPV9pRFGabHwi3VobcUjkXXNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132069; x=1746736869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnGOXR6noMjOO+PYxqABh5bK+OszWgRs+sFklmHt1g4=;
        b=ZS5FquFOEmlJtF1sL7yi9+sfjAwomgFILkHb/gQfjFeKoXc/GI5wZae1AirqRPBRE/
         7LtrJX5CpQMrtzWcBcXUVRaIzkFjlBTFr0BjZz714FkIntLyeiO0i4JbfSl74BUtF5kG
         m14QENcT12K7qmx5MHPptUA74JTO2pkCH596Gde79OdeBKc3AGAwU4bkaV/pLr70T1gT
         8eHwLuuhUhh+3/Xg/Y25GKZtSaO+QNO4CMyY9bTi7wBW0zPMf98XkK0i0PKtykMNSO22
         k5uNcuNltC94UXcI8i5b0NRv/et9AmFeg8vO+69Dwc5vdzIthaZxvR0xp0Du07AROtEl
         e5pQ==
X-Gm-Message-State: AOJu0YyzRFbA0j4PHlf0Qh+zoOZ0vO9ZVoFGoXxm7WC+khAyUypb/Ma5
	h3B1ik0Fk9DpZcuArr0X0V8/TAxETWmZuRcJGSbgdqIVrrCUIoNydh3u2w3NtDlSVrB7PUayEWH
	Y
X-Gm-Gg: ASbGncsr8f9mcccffR/gDqbgKN47wnWuarBuM4pvLuN8yJtluoy9/wWhG0H0IRyZabh
	u5r6p5f9AN3bvg0AS5jBKr0Tv9YkNPTrDIIpH4CSTyHKDEdICuyHwcOtHCXgmH89Yu16zc/lOK1
	nBB5yF3JarTDwt6OCZJX9mIgHkq8/GsBg5Vr4MCkWm9J7OWNePisg24E7ySdk0L5FMltDQPaLmu
	Zu+oLSe7/DEnvX5tCgGp1JblPaW+u/8N5T4I1xC/2W6zQYyIVfkg2tqNzW7rUcCHFU62rkYSnMm
	BhrgTyf7RQY+jj+nN31nAoY8f3RkIcthFbOfxeu3a6dwT7KRw1QH0uyJ+rpryaBZmEonreGTW8V
	F8sFfOMTbPUiTG3fx
X-Google-Smtp-Source: AGHT+IFKC+SnYg5ZZ2Nt+r4jqQB6slMeN5ujeL0t20qVXW8NStq5gOB6gVa1D/zHTA8JMXpKgBnmIw==
X-Received: by 2002:a05:6214:252d:b0:6e4:4676:85c3 with SMTP id 6a1803df08f44-6f50b238344mr54121046d6.11.1746132069231;
        Thu, 01 May 2025 13:41:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:08 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 34/38] libstd-rs: Correct the license to use Unicode-3.0
Date: Thu,  1 May 2025 16:40:10 -0400
Message-ID: <1c2220b5b76568175494054c2576f124295f219d.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1460

From: Peter Kjellerstedt <pkj@axis.com>

This was missed in commit 3130069fdebb92f20b962fa8074564a27c3fb6b9.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 1378a4b39e7a0c38c74e0133f31df7f70ed7d6ea)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.85.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/libstd-rs_1.85.1.bb b/recipes-devtools/rust/libstd-rs_1.85.1.bb
index 1994368..00802f0 100644
--- a/recipes-devtools/rust/libstd-rs_1.85.1.bb
+++ b/recipes-devtools/rust/libstd-rs_1.85.1.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Rust standard libaries"
 HOMEPAGE = "http://www.rust-lang.org"
 SECTION = "devel"
-LICENSE = "(MIT | Apache-2.0) & Unicode-TOU"
+LICENSE = "(MIT | Apache-2.0) & Unicode-3.0"
 LIC_FILES_CHKSUM = "file://../../COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 
 require rust-source.inc
-- 
2.49.0


