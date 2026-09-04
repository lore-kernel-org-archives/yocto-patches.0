Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E9C61DD6
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:07:47 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13458.1788527261214421021
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 06:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KLkLkk/J;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a668ce86abso1499469a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527259; x=1789132059; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG29WNSeqf1QKp/iqetr53Xl7iDfOEoORGiiYI4rGaA=;
        b=KLkLkk/JQAaRw3Q3y5bV9NteeiFlZNpYeGd50TN11WKmEvLpOQL29NNzbmhQz2QuUr
         Ho27PuBLRin9us1zNmASLnmfJ5fQ0WyoTHjDvHm8HvxVSQ4ycTAtPiOi8mS9851wzgEC
         uQNITkKiTmRWQyb9lCXNSizg7dP2p/0lVuCyOFtHevrtYlUisqYoHJzEqlb1gC3NOGTu
         Z97Loqmd1+R6dUtz8c29A1SRks3aNJVwnsaVh4UBPQDI1sRLj7Zc4jFYpjLMIoM0eMri
         L0nmVHK8roBjfYpdl8lL/QV2m5jihU8hjfrBUyododtLfvrCvKoTmS1994eFXYHkRHqw
         FHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527259; x=1789132059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TG29WNSeqf1QKp/iqetr53Xl7iDfOEoORGiiYI4rGaA=;
        b=qCKO9WGpwBE/EmxOGpcE1BbYaNyh2GVhSy9PUeEZ9+tph2Janl3NTChPbCVSW3NkEn
         frCbeKGBCZu6Q4C6SbBsYf7uo73qs57eDFrU4wWbWgmxJLcWF15k+l21IvZEQ1lO6MwH
         uX5GYsRhPNxy7xQkJJPS+r6Vnp64Xr7SLiA3JUtzGxO6KdiiVlChiQaDYhCtj2MMWBSF
         ai6+gbKRVRTwgQV4jUqwMr1DlK6HeRuiQrNeW2uKA+/Dm8GhDjIHuSCBhuaSCAKGgwSX
         T7df4ZBn5xiHI2MqgNsbRFP6IB1enrZSucUlUPpvytYRWTLYgQGfThDxQA0L4Kex4yHv
         qtHQ==
X-Gm-Message-State: AFuF++mZITlZXKlpY7Vm0g/KVm9a1kz8rhXotfdsJMMuDKKK2tOZYSU9
	TZWCYrZb0BSzkkPM0N5oSMe1T9bOB+yFLZmYpa91m2DK2GI8AjSf9pf+WT7SyNMu
X-Gm-Gg: AYBFou0Hod/3OXNPvq/Fb+UnEe9KX+A2LjEOklBNh3Uh65ruKeHsza+QPTv1QojSH1c
	Pw5CIDSo0kKrKsqp6hmHUNJ9lWU4VTWHstt2vBqeXVpiDsnmcb/QwdoSCzznsEefZQxMMmyjn1z
	elaeevcGwg5xTNqf70icfLZCkso+MBCtwRHx/PCY90fyY/z9wojPyqYz8uU9NBapeU6YF8PE+JJ
	R8FpGyS3/fegChysmDyU6VNu2AlNGol10b5Ola3JyFRgRMekUxRI8Kp/PPOBlc583o5Woofy2yG
	XzFg5SzRtYvmk5hRrrkE/Y/s7P2NAdBfycvCooiy3AY4UGhS8sCetPxzSGhJMp/wXH9yS4f2Sri
	AGEI3xfskjyqVC95tLV1mNrMU0eh4fTF5UM6SNd3MSP0vbzCfKbOwagiKyqhprjfxFmlNX8DiaN
	v2jdXRBiCHP7/0henxZkYN+M4GxLnE/jpMKJouCmqjXagxvKZ60MH4EHM=
X-Received: by 2002:a05:6402:210c:b0:6a0:9776:cb5b with SMTP id 4fb4d7f45d1cf-6a7e8d987ebmr3075607a12.13.1788527259243;
        Fri, 04 Sep 2026 06:07:39 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm1173158a12.15.2026.09.04.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:07:37 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v2 3/4] ports/linux/pseudo_wrappers.c: Add syscall support for open_tree() wrapper
Date: Fri,  4 Sep 2026 16:06:26 +0300
Message-ID: <20260904130627.453678-4-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904130627.453678-1-frezidok1@gmail.com>
References: <20260904130627.453678-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 13:07:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4731

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/pseudo_wrappers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index b920cb2..33cba2d 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -102,6 +102,20 @@ syscall(long number, ...) {
 #error SYS_openat2 not defined
 #endif
 
+#ifdef SYS_open_tree
+	if (number == SYS_open_tree) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking open_tree.\n");
+		va_start(ap, number);
+		int dirfd = va_arg(ap, int);
+		const char *path = va_arg(ap, const char*);
+		unsigned int flags = va_arg(ap, unsigned int);
+
+		return wrap_open_tree(dirfd, path, flags);
+	}
+#else
+#error SYS_open_tree not defined
+#endif
+
 #ifdef SYS_renameat2
         /* Call out wrapper, expanding the variable arguments first */
 	if (number == SYS_renameat2) {

