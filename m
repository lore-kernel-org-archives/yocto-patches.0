Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD795CA5FFC
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:22 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15219.1791187940441920138
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g/tiskKD;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: frezidok1@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1471640f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187938; x=1791792738; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+md5jNnfBEJeZWuNm4WQPGV7HdtWxtQMntjRBhtAlM=;
        b=g/tiskKD6Bqe76v5gnLQ5Wnk+FQ6cAvlvy8h7lv/Ck+toEaWUJdqbvl3m31Mw1zKKO
         zl/KpEbWoDYIt/F8UhBW0fc1M4c97uxtZjjNhNQx5npNwlULcXct3WfI4uGFlqXO7l+Z
         lEcAjnDci9Vcmo8dlzNYG9S6Ng9TXDbEJw3BQiO9mxlqZb9WpW41Lf36ycFVgV4eggii
         OE9H/wzb6ONSzJiuxbw6V+9iZjTMnXVRi7xwFwAweQEY+oQovEGHE8UELoRCZfemdk3v
         g3LsHiyBwQOpH/yhwKz0MY3L8A7oJqyKDRQdtbgiRAZ4JcSAUHMI7cu/82hIEsmgtnCI
         KxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187938; x=1791792738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+md5jNnfBEJeZWuNm4WQPGV7HdtWxtQMntjRBhtAlM=;
        b=LNVYct1vxIlQUW9AqZuzadSqy44n9wR8tLo6518kAQkgG/ALNguTDkZs4UM6kxQ85m
         4/ODWmGTkMMeM+dZ+uXYSxnHyzaObJKay3Y46coPIhE31e9nQV8ADckxm7wjxI5Rs+XC
         EqhlYSPEgqS/D5PkbcV9kxumDZBCdEEvKti2AQo0SQ33uQ971ZJTTE4IlKrp0tgcIlXV
         V3ykxwT6aU/1gqdEkULXPSPWlI9HbDV7R2Tya3jUKZj89GaNHIVKJagaxKMpTH8WGSG+
         GrAjmuezay9Mw39knuWXotzbLW1rxg0/BEmGNKFyeIn10VH7jdG35ngfLvTQszfYyKEy
         vMTg==
X-Gm-Message-State: AFuF++lAlWKhfWauyp76gl2zfMDHUTBomjFdv0oTGbZVGJWZl7ugsSbf
	XQa6jy+09Z4ittX9He0Jzoi/zqdJRtgG81UxHEEwJRc+/YyfE0xZvJNUsbEcc5Fr
X-Gm-Gg: AYBFou3D1gVbtdFQ/kEETPx/5gO14LQAeEF2kLCgcB+XCrb2l3RLrd4T3H51V5ghRxo
	PjMRvYCxlY9HgnbWMv9ZBq9hTQ/aSE+WT9tKy7nKnW0qXgLz5uytVwfuBCN3/hAZ0cojzSGmSSp
	qiLD+YKPzAsn/HWpaE37PWu3kDTYeDYlOKc6B8bz+sHT/chYFwQj6h75pnLstlztxSRR6ardGoi
	HSTdp1f6a9nQKBrb7zQ/R246kdwn84zy/jhpoFv+9mtO0DX/XX938o3ZV29UEt3jj9SboHv9UmH
	DM9zRCCYwB+CAATXPTNf4ojd8UYWCMMEw0kNzinEcifKjrzynj+FrdqEap/VyIZLQ8UE042zV0s
	d8487zbU2oHkaVQ2mENZKE+4fREiSCHpU+d5iK9lfnDSv3g1GIqwNDbmm8ILy08TDIVK22MuJdu
	qPEGY03NgG57DZ1/YyWJg+WewIV06vXQsiM1EN9emlXqVlC9dIGN4kWjHci+NNFiiILKzDlCU4r
	P5Ae6emHqk6/g2Z1UrUKpHOyzquUw==
X-Received: by 2002:a05:600c:a49:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4a168100e0dmr95800045e9.28.1791187938208;
        Mon, 05 Oct 2026 01:12:18 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:17 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 3/6] ports/linux/pseudo_wrappers.c: Add syscall support for open_tree() wrapper
Date: Mon,  5 Oct 2026 11:11:24 +0300
Message-ID: <20261005081127.107126-4-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4986

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

open_tree() was added in Linux 5.2, while the glibc wrapper was only
introduced in glibc 2.36. Before that, applications using glibc had to invoke
it through syscall.

As a result, applications supporting older glibc versions may still invoke open_tree() via syscall()

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

