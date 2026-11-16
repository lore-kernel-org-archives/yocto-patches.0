Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2411.1794860560612917274
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 12:22:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bFXT43u7;
 spf=pass (domain: snapchat.com, ip: 209.85.128.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so9505065e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794860559; x=1795465359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rhg5cWhzvV854/xt1u2xdezro618Booo90XjFA3feLU=;
        b=bFXT43u7Zk7EnmbtMiwEs2IgV6pjN2haXx/PSUKcOd8+qMP9txyXI2hsEHeF340id7
         i7gJ7AT9dD0axFs7cZj0Tya6E0Clnm90Bgg06cU5RVhF/PORFlB73sJajuwIg4AUcY8p
         xN1cAFciLqB2W7KUgh3FdGzAKrbc/aNrZOkSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860559; x=1795465359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rhg5cWhzvV854/xt1u2xdezro618Booo90XjFA3feLU=;
        b=esh8b2JWTRLNwl305wBBlrHe6vOy02/a/xuiKowhAX/t7XE/Ms6CHGqgplnppANSr+
         0WT94CP2sLAWLJwUSQ6fK2tqROmOv+U5Ujt6U6p9I2d5L02/DsV6x8rOUPZgRa/N7r4H
         lBLlCUapwY40PxuNtZmzAAx8EelcWMDBRyfzIy7p2acE7BTfZNqmjJWntsIUzbNSmvTr
         16UGTC//JP3OBMs3eDTN5ty8IEQMNJSWW9qOPpPLVlyu1dgbae73JVAuj79T6feYmxZI
         qr0Z0LcfEL+SwfhIlBY1S25SqzBwG7xo/UdapKa1oxoL2hnC482Ef4/Ck/gZoC0KTTXB
         CvPQ==
X-Gm-Message-State: APuU4Z+VRDYk4K9oNdh1ehSZ9NQjQEbj+5Mgjp1ZjjI0oS+Z0XutxT8g
	vSPBJl+kdxYBP0u91cUA+UuQOuKrvfymHsQbp+bqbV93/ja1nIPEMFk0NxCodT3q4PLTI/t6rHs
	rROTnQA8=
X-Gm-Gg: AYBFou0gPWW7h57lM1gCcLBsXzLHIRt1i/m6/B4UuMMTBSe1l/qEX3wwScpsadys5HR
	b6EtyXfev9fPfrxc9V3fVGvjo5/+ujYtbxLGdKyVZUCicCpr1cdBSfnNaKh6L69G2USwtuk0Hun
	3Ne+FNra/sds2FlFjjEGnuwIjxTJG18UeOZKwRbct/4vMQz/HefKtHVpjnX7L2OXTtFMkSGqA0O
	0gTNbTe7XC0AUwwN2yC1RXU0LirLzqUsgZuwJnoM0JNyq5IQWR6GlrT8m7gROVKIdcFdpZ6EBFB
	bsuVZQBgl81kUv7LWgd7aonEQ6I/EbFy0xS/9UrP4onZjq32dC6e558jMqCNa3kdex0MS5dgpb+
	8D4zTJOPQPogEl6M+8obnMih6hRlBLvDM8cHmG3RC+1DXpBJWn0lENuVwzeut5NGUk3s0cJ+JCg
	cGs5XUSIqzlipHAoE1K6tYvrmFDvWxTkfYSETArhZShGKDytmHvo+ME2Y7Xb23NxyInm45atwsY
	MVneUB8EypCZXBvPrXAHIvm4ALrNrhq3Dfnbc1btKKWi/fQyqmD+43gHHa1U4i3pnJDSYRo/Pkw
	G2VeXpOu60NDWzktVdMJa/aBaD1elwvbB4YiTzgdngtTNsWWhIW3WSjSxgPpfZ8dV5N/P8ei85m
	TBNMeMUUeC3hZvSRCVlxPKgMY+BQNPfrPgPrm77W5ng7SMsfy+kQdMLouQztOGd8nFcjYux2DEh
	xj8WrujbUQ0xgZjUsMqRjE
X-Received: by 2002:a05:600c:4e01:b0:4bb:71c1:3ca6 with SMTP id 5b1f17b1804b1-4bb71c13d09mr90000765e9.21.1794860558889;
        Mon, 16 Nov 2026 12:22:38 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm10724165e9.13.2026.11.16.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:22:38 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 5/5] gnutls: pass -F for the Apple frameworks on Darwin nativesdk
Date: Mon, 16 Nov 2026 21:22:23 +0100
Message-ID: <20261116202223.654-5-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116202223.654-1-ecordonnier@snap.com>
References: <20261116202223.654-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 20:22:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5424
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

lib/system/certs.c uses the Security and CoreFoundation frameworks, which are
in the SDK runtime tree but need -F.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-support/gnutls/gnutls_%.bbappend | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 recipes-support/gnutls/gnutls_%.bbappend

diff --git a/recipes-support/gnutls/gnutls_%.bbappend b/recipes-support/gnutls/gnutls_%.bbappend
new file mode 100644
index 0000000..4b1ad1a
--- /dev/null
+++ b/recipes-support/gnutls/gnutls_%.bbappend
@@ -0,0 +1,5 @@
+# gnutls (lib/system/certs.c) uses the Security/CoreFoundation frameworks.
+# They are in the SDK runtime tree but need -F, which nothing adds by default.
+OSXSDK:class-nativesdk:darwin21 = "${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime"
+CPPFLAGS:append:class-nativesdk:darwin21 = " -F${OSXSDK}/System/Library/Frameworks"
+LDFLAGS:append:class-nativesdk:darwin21 = " -F${OSXSDK}/System/Library/Frameworks"
-- 
2.43.0

