Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81576C79F99
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:00 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32737.1788779996524586690
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kMZSZxjl;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso4608163a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779995; x=1789384795; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG29WNSeqf1QKp/iqetr53Xl7iDfOEoORGiiYI4rGaA=;
        b=kMZSZxjldXPESSQT2qUh4CI42LVm8YYCz96xoy0r2NS6/FytPn7hMLPxrLTpSFJqz1
         P+NWQEYCE65Xyir7k6RwmdNgU81LkWCLAD4cH4sr02JU9bY5tY/jyUifXNo44mM8sd4R
         PkJSVb5TO9eAK41bSYH7RhJRd7lcf66KZn0iQGVE5c7OPoVJ3PYcDM6t7fU4/3dhgCvG
         4P/YQ0Hl4qq9P8V4kYRVpYXZERna/yHSmSo/1RwxfWOhd9uitawd+fXartqNytuBQ+yz
         gfRWah5rsi38GQA0pqDjZAQr3L9boBdHX9BKzBviLz6DDBjBayktURz5qobwgEnpgjtt
         k0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779995; x=1789384795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TG29WNSeqf1QKp/iqetr53Xl7iDfOEoORGiiYI4rGaA=;
        b=ATYGVak2bvVYDKbp6yLHFpE0qSnlakRirI/mkVsApieUbLv4JE4aoCdCdxGsfWg3aN
         0QWIK3wNwB/MfNa3/TpqYZTdRyxSltV7pe1CIrawnRbEyy3kDCIlWJ+jcgWLlAxb+ZvN
         uWbqGCxsGiyz6LZrIAtLwO8F906YpDmRKqrLUM5xws8/oANIn4nqtLoryi6lP4M31FmS
         dN2Sj7sRietyEEEozNvIZPnUtGF0/ocjAYZS3a51v4e6ejZ/yljnJZ7sLMaS9YoUIdyM
         WtuP/cSpvqv34NRiFG6CzaJbtx53Wmwt7UuUgyuJEE/UD8fPu3eaUJpiXdDV7waBZ76/
         x23w==
X-Gm-Message-State: AFuF++ndwFXG3Mgu6a5DwLFGQ40909XxX1rqkAiDSQnlsPysVi+OGtfB
	9k/YwmnLbxAQjMtXHic/pejiACdaFajDlLcDgBrlPTQ5cLXuPpCNNJDLAsXfkeLP
X-Gm-Gg: AYBFou1fs75YTw0DQ4otXCu6fhtakncfRVXHGv0IhnAMvvTy1VDQ2skBhVd8nu4VNgJ
	/pMBYaWbDXWQOX9XQm5yoAW71hbg79idE4olOeyLGWH0TOcElMI0oAQkl/4ijAf0Cy1FnZEOFJa
	mz/Aujxlx4ZqRlm9hHmY8m/jtmXjj7ecr2h4g6Bq3FPf/vuvTrmd/OJBxlNG4oJJfTBWqYa9kFz
	9TK762ZFG8M4emXl+Qw6mpmmhOI08RYUhUpILYfB8hoGBGNdNCUYhHTxOfsa5EaaPMWHH+Cq0A0
	6lMUoSg+slOzP2EenBiDzyykenwawXNOpvtJtyFydTv1K/H8Z1hgTKWzAeLEAtPd5a34eTRY8G8
	KNOh/Zgffb64QVv3hycdNI4glcc141BsqgoMHbrkGMMrslZTgcPHQVrTz431asEopTTCUz/CScp
	nMtAh83KCFIckTKQ3ovzKOV6CGpCCoTDc80ikn2PITOBXA22MR6Z690MhF
X-Received: by 2002:a05:6402:2b88:b0:6a6:306c:cceb with SMTP id 4fb4d7f45d1cf-6a7e8d8df90mr7634812a12.12.1788779994546;
        Mon, 07 Sep 2026 04:19:54 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:19:53 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 3/6] ports/linux/pseudo_wrappers.c: Add syscall support for open_tree() wrapper
Date: Mon,  7 Sep 2026 14:18:40 +0300
Message-ID: <20260907111843.26746-4-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4744

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

