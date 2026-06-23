Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE6CD98F0
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:27 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14969.1782195018298051819
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jj9R9zTb;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8aff9185edso13264a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195017; x=1782799817; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c15kgTN1Dgeji6pZdIZ0MXeCKZXelqTHfX3W284DAcI=;
        b=jj9R9zTbuaj6aVNF4NJ3VjmE/W1YdR+qzvJUC/YlxiCHqKkgxjevvNznN6KK+sq0FZ
         1aPMOQMRCG8ER81lpCJFqNgGvC4Dx4A+VJV47Z9gOt4cwmVMaEky6RLH2giuIH0iHjT8
         5GY7QgALwOi+N7kwLTfzuTzOeQRJxgX0dF3SuSbOeKpC0e0OHv8ExJtf3rmKikfGjvAC
         MNVtPTZOirEuThaMjHsAEDokQAGTUnxXZquo8bFh7KxDr+KqYiK+M95Gqzid+x+Br801
         X0LKe0LinLichaw9diu7QBJCK7UeIn+kZf1IxLULssFWngp5X9KMBaUuUkUjD0FQTC1J
         +pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195017; x=1782799817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c15kgTN1Dgeji6pZdIZ0MXeCKZXelqTHfX3W284DAcI=;
        b=NTiTjYTB9WStEXKEQmQP3VdKuSAwKVnLG9DjacAHrtHj3XFJJeDskO6LpkFOSnNIT5
         Hky03z66di2Lqn7FLc2EF6SI4BIZZ6zkONFrh1qtqw/wxP6vcQRns462Bd4nWd7Kwq6K
         SQucw431Ax/ckgGYENPqJsphjmGEH18Adk0eYzMeWfgbxrOsuhtxEQBIL3HkbBrKK4/d
         IRjYVVOj/pXtKnKy+6yAlK8/DSDgLiMvu8RQLzju3alWZOo0E0aC5beA8nvO3jiH7YJT
         KYD7x98Y4ld6Set7uaL+OE1AbM8qQlE6G2Sh0YItIg8SZTe7liyRc4GrryTI/WMZLwzy
         fSkA==
X-Gm-Message-State: AOJu0YwezzCItJEOVlw1EEjyCTPfD9n+JUCh+lVzeUZRzwvukTqGIeBO
	asKSJHfHehNwR5MTyD27mDv9eD4wQDUa2CY2vULMKbkZYHv78Qu0kb4m4x4QUi2Pmyc=
X-Gm-Gg: AfdE7cllKs41t7jxYA7Eio5klrpoDkhQKRnTbMcHlinqtQ6Orh2n7EAtfWd898PczMd
	Enmlc0JlcaHB8NvgzJlDMKwojLkt+MmOBnM5NHHFDSA1ByDTQhEkArH5E54sfkjeFgvPSOKAXG2
	oI45faGDvL3w/q2ZvNbKKP7ogEnKco3IlNFGK2ZL5kb9IcTS2nGFhbLpDYulMCyIG8FaAQrqMfy
	QmtIz4gSCAP+SCPwdvwXnYL++8K7XiPN7BYwFRbsWGtT6jyMDgmiOtfotz9khc6TroW2mM2aEHU
	q0Iez8/nFosmIT1Hwlot4JQtEhtUOExD+MJn1JGHEg2Vpk6vi4PSVgrpNhhdBXvGGZyWMdnJ3fz
	GNiF3A8C+r7bG2z9Ft8CslSY8OPGfBvERKCOkknkora7jK5u1YDI92qAfD+KSnXAvzuziE3q4Ma
	N9JeEkxNdyXdsxiSe7m/I+owk=
X-Received: by 2002:a17:903:13cf:b0:2ba:1e94:d03b with SMTP id d9443c01a7336-2c737ad3f04mr73795945ad.6.1782195017481;
        Mon, 22 Jun 2026 23:10:17 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:17 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 2/7] strongswan: Fix CVE-2026-35329
Date: Tue, 23 Jun 2026 11:39:56 +0530
Message-Id: <20260623061001.644583-2-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4268

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35329.patch     | 57 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35329.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35329.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35329.patch
new file mode 100644
index 0000000..7c55d43
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35329.patch
@@ -0,0 +1,57 @@
+From: Tobias Brunner <tobias@strongswan.org>
+Date: Wed, 25 Mar 2026 10:28:45 +0100
+Subject: pkcs5/pkcs7: Avoid NULL pointer dereference when verifying padding
+
+Can be triggered via empty PKCS#7 encrypted- or enveloped-data content
+in IKEv1 CERT payload.
+
+Fixes: 4076e3ee9121 ("Extract PKCS#5 handling from pkcs8 plugin to separate helper class")
+Fixes: d7aa09104f08 ("Implement PKCS#7 enveloped-data parsing and decryption")
+Fixes: CVE-2026-35329
+
+CVE: CVE-2026-35329
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Patch is refreshed as per the source code version 5.9.13
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libstrongswan/crypto/pkcs5.c b/src/libstrongswan/crypto/pkcs5.c
+index e48a9ad..134ccd3 100644
+--- a/src/libstrongswan/crypto/pkcs5.c
++++ b/src/libstrongswan/crypto/pkcs5.c
+@@ -113,6 +113,11 @@ static bool verify_padding(crypter_t *crypter, chunk_t *blob)
+ {
+ 	uint8_t padding, count;
+ 
++	if (!blob->len)
++	{
++                return FALSE;
++       }
++
+ 	padding = count = blob->ptr[blob->len - 1];
+ 
+ 	if (padding > crypter->get_block_size(crypter))
+diff --git a/src/libstrongswan/plugins/pkcs7/pkcs7_enveloped_data.c b/src/libstrongswan/plugins/pkcs7/pkcs7_enveloped_data.c
+index 8b26bad..3d601d6 100644
+--- a/src/libstrongswan/plugins/pkcs7/pkcs7_enveloped_data.c
++++ b/src/libstrongswan/plugins/pkcs7/pkcs7_enveloped_data.c
+@@ -182,10 +182,17 @@ static bool decrypt(private_key_t *private, chunk_t key, chunk_t iv, int oid,
+  */
+ static bool remove_padding(private_pkcs7_enveloped_data_t *this)
+ {
+-	u_char *pos = this->content.ptr + this->content.len - 1;
+-	u_char pattern = *pos;
+-	size_t padding = pattern;
++	u_char *pos, pattern;
++	size_t padding;
+ 
++	if (!this->content.len)
++       {
++		return FALSE;
++	}
++
++	pos = this->content.ptr + this->content.len - 1;
++	pattern = *pos;
++	padding = pattern;
+ 	if (padding > this->content.len)
+ 	{
+ 		DBG1(DBG_LIB, "padding greater than data length");
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index 9d48481..0f167db 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -1,4 +1,5 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
     file://CVE-2026-35328.patch \
+    file://CVE-2026-35329.patch \
 "
-- 
2.34.1


