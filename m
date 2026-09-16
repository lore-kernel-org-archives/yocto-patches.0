Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D309C982D0
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:40 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26466.1789595918636518106
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TB+qLBCO;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a222edc62so17872985a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595917; x=1790200717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pf4ZeUNlEb7Oyl9PnmtCkqHq0/JSSowSuvVWpGUEv+0=;
        b=TB+qLBCOpKyXXdokWvSqx2D3L1amUPajm9A6qF4xxpUKNWpzJQcw6x+3z6675C+JPt
         DHWvpyKRo+TYAoOLlfeNXAAVJSRik3cUvfwkVErxFfiAaDSFkKJJBv0Og+0tQGhHhXWj
         Uw5pdIIqNcLDvFD7JYFsmKGjuiolQx79zw+Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595917; x=1790200717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pf4ZeUNlEb7Oyl9PnmtCkqHq0/JSSowSuvVWpGUEv+0=;
        b=xBuobiZHvF2hGQY+saNmHQzjoluidPeYxNrfX8lK2ubhSCNorDjGrgzCjAJZtKYprx
         IaFaMFwPvIh5xtc99HDcW9UBFrNGC3CSlPeHUKlj1ZOfm1tFyBFWNh7tihWdcJg9x1fP
         dUli+W6c+QtYWQmEKL6M9KPH2H8PYrPH+dzVFj52bpmwvRtqzXdVFnFnCaQ/g9n+FTx4
         QN//GFifxoF+gk1kd1p9mAGBJ16R5KfdFjCGIowuB4wrj81qXJ8tAUSAf+BsgXTI8YKR
         hlisaYwopYd3PwNtHsu/+rg2Ui5iqZ7XF8iMpNrEUJ4AnTgAA6mvrdEIbHhMIuUNhc1h
         1IkQ==
X-Gm-Message-State: AFuF++mqvs1o2ON+g3Z6fwQPzX9Q2NRzB6JObbwGEOancsNjOwxh7LTE
	8tt4RaRa1ba/WU3aFg6JYP80OPD+/mZCuetS4gItOnXOmowSBfz1rZgxQY2u0AGCJZb+E6nZOwR
	G3YCX
X-Gm-Gg: AYBFou3ZboohIjpnsPblGt6Qd2VEhYkIwfGjl6yHHYEqGKpCmgis0PMUH9LGskyfZFw
	jNewaRzg/YqEwVkUWvYXkvRZjsolvSiwf2Dxo00sw56rY+NALVOFknWLdhylP3pKNuRrFXpL2kh
	ZZnzJFzZyXHP5a2DYJPbWvGNhlmP9DPft1AwaspdPiT2Ed1bqZxCB55y0JxSdXfC/FmItMvJAK2
	TFAFsag4umvuXLS99vbCKORqkxFVLjkcwSCC1h+DXWQyaiphofaEDU/b1IXg8CmIc4yBgIL3fGQ
	LJNBpwV9upHaBR/E9yfvWLUNnATFGXdz2YZ5d9mrfSzjRhiU72OverbEmWaBJjdaZHCSk1fdKGm
	lJhQpoMGjd4ChgW9+0L7LpEucvgZp+ML1cos6qAKUeSUOHNPaDTcWmqoqH2Uk5YEV9dBIiHQkog
	OdtYxfoOmLo+7s+mUDwfbxKwiegMmZXtMjsJj/CuCg1GQ4PW8zDFjS4u4B5FyFoYdasutDXbpaB
	+taJcmh4KGFWRfy8vqnhvHCa9BAKf6/fnLuTxtQgPSpFvpirwJYsSD9xwEJa2nHD0EtNy5zsBC3
	Cj1H787kIiTOqT2T6bHqvs3RX3i525dTpVIDqbaprHKOhA==
X-Received: by 2002:a05:620a:700c:b0:939:c303:c54a with SMTP id af79cd13be357-93bb787b13dmr825167285a.31.1789595917492;
        Wed, 16 Sep 2026 14:58:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 01/19] ncrack: fix OpenSSL 4.0 breakage
Date: Wed, 16 Sep 2026 17:58:01 -0400
Message-ID: <4ca185ea19052e37e76d896c01dcece07cb1f985.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4857

Apply patch from outstanding upstream PR to fix building with
OpenSSL 4.0.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-fix-ftbfs-with-OpenSSL-4.patch       | 53 +++++++++++++++++++
 recipes-security/ncrack/ncrack_0.7.bb         |  4 +-
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch

diff --git a/recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch b/recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch
new file mode 100644
index 0000000..93b2dd1
--- /dev/null
+++ b/recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch
@@ -0,0 +1,53 @@
+From 76a0eabaad402ed935c1294f98663cf58a806a06 Mon Sep 17 00:00:00 2001
+From: Ujjwal Sarswat <ujjwal.sarswat@canonical.com>
+Date: Tue, 28 Jul 2026 07:54:33 +0530
+Subject: [PATCH] fix: ftbfs with OpenSSL 4
+
+Upstream-Status: Pending [https://github.com/nmap/ncrack/pull/147]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ opensshlib/cipher-3des1.c | 4 ++++
+ opensshlib/cipher-bf1.c   | 4 ++--
+ 2 files changed, 6 insertions(+), 2 deletions(-)
+
+diff --git a/opensshlib/cipher-3des1.c b/opensshlib/cipher-3des1.c
+index 790faa2..30bd6bb 100644
+--- a/opensshlib/cipher-3des1.c
++++ b/opensshlib/cipher-3des1.c
+@@ -26,6 +26,8 @@
+ 
+ #include "ssherr.h"
+ 
++#ifdef WITH_SSH1
++
+ /*
+  * This is used by SSH1:
+  *
+@@ -155,3 +157,5 @@ evp_ssh1_3des(void)
+ 	EVP_CIPHER_meth_set_flags(ssh1_3des, EVP_CIPH_CBC_MODE | EVP_CIPH_VARIABLE_LENGTH);
+ 	return ssh1_3des;
+ }
++
++#endif /* WITH_SSH1 */
+diff --git a/opensshlib/cipher-bf1.c b/opensshlib/cipher-bf1.c
+index 8e3aac3..97c7de6 100644
+--- a/opensshlib/cipher-bf1.c
++++ b/opensshlib/cipher-bf1.c
+@@ -20,7 +20,7 @@
+ 
+ #include "includes.h"
+ 
+-#ifdef WITH_OPENSSL
++#if defined(WITH_OPENSSL) && defined(WITH_SSH1)
+ 
+ #include <sys/types.h>
+ 
+@@ -99,4 +99,4 @@ evp_ssh1_bf(void)
+ 	EVP_CIPHER_meth_set_do_cipher(ssh1_bf, bf_ssh1_do_cipher);
+ 	return (ssh1_bf);
+ }
+-#endif /* WITH_OPENSSL */
++#endif /* WITH_OPENSSL && WITH_SSH1 */
+-- 
+2.47.3
+
diff --git a/recipes-security/ncrack/ncrack_0.7.bb b/recipes-security/ncrack/ncrack_0.7.bb
index c0a38ca..149b974 100644
--- a/recipes-security/ncrack/ncrack_0.7.bb
+++ b/recipes-security/ncrack/ncrack_0.7.bb
@@ -8,7 +8,9 @@ LIC_FILES_CHKSUM = "file://COPYING;beginline=7;endline=12;md5=8df67d60bde9d6c7b7
 
 DEPENDS = "openssl zlib"
 
-SRC_URI = "git://github.com/nmap/ncrack.git;branch=master;protocol=https"
+SRC_URI = "git://github.com/nmap/ncrack.git;branch=master;protocol=https \
+           file://0001-fix-ftbfs-with-OpenSSL-4.patch \
+"
 SRCREV = "7fab46addcb99326cbf60f41dbde22a1e87aebad"
 
 PV = "0.7+git"
-- 
2.55.0


