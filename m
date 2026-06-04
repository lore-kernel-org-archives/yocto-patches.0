Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156DCD6E68
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:36 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6279.1780560330926128950
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=L3BF23EE;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8422c327755so220177b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560330; x=1781165130; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh7zmfrJe3I2LFGKZLbkfvwNhLT4eYiXnu9vrW80ZoY=;
        b=L3BF23EEc7N+wD0wvvXSGxnCxTiew6dBOB4pq30PZxvvDbV4Kjo9TjVu2LtzZG0De3
         qqUO5BABp3vozGbGyU9QZ68ZSEwUVZyAUi7k4osIqiANPfCGLzSQ2mi7sbGPHAmevD/t
         2O9sZyXRfbYY6cGUjZFPCyShv6fd8IIycowmkm/2VgFDcleKLOTR3rEzm1hf6AqFZiix
         u9AwNX+VBTmpA/JMk6EeT48hENUBdEkPobOLZ6/2bQSN7CQdbZ1Flle0qkHDfzfxvmnc
         b4iJe5NlwfaMHo1jxeoPAzHxZHEoCFqEOZCXgzzDLgxsuUjDvh31lvMfC+uH962912JP
         NPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560330; x=1781165130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jh7zmfrJe3I2LFGKZLbkfvwNhLT4eYiXnu9vrW80ZoY=;
        b=AiQ782LH+/wD34uhG4Kyz79tdtQwWEtfVNJyR1EXS3NNFi26OyB9q9Md+1DlV+QLWj
         vVJXCDPR1DSX7SuFSs6cHraFvWsFrmpbt7SNsesv9sGZz3yTAHJhokFIq6Ay2kppL3u5
         R/WTkTG8DLJWRQi/NLTGQwluFfwZ4HtJ7yea/Kd+565Pac4Kq2uTQhKWAr2OU/nx7Iaf
         QKkT3SPKeD8XaRDph6JoT+IREBNxjTxldpfo8JhnkJ5U3BFdm0icj4gdkoC+FgXvbJ/R
         v6R6aW8dh4kbH1CoL4nmfN4+XJnT4ehNlBBbA5+01fAtkqTtyx8egtxXxNh3kmBMLmG1
         8JzQ==
X-Gm-Message-State: AOJu0YweXNsZlaP5XKP3BJAgFHQKPCsvnQVRwTJg5985V8jvZCgXrF1S
	fjJW0+QgRTJW4gDB4MfcO32Si5+zygE9eO7NXO9Psk3fNzw7dPRzhnvQCo+jEg==
X-Gm-Gg: Acq92OGpAgZJVpO3KVyvfr5OA3B7RXNYN/u93g/dJlzopjQhlq8hDSp7aBz14rRSIh8
	7eJjDKn3RHE5yBMosXPDbNadoIzQePvLi5cQsjEMjEcy6CyxRUdLkSL5hZJY7BF16sHU2jZ9kar
	gTm97BTYZ3rCfTObmGKgmAzDPrE4rq9a3ttX+8i7Tv5Z2a1VpHe3nkQutoP/RhYRJj0af9h7oPU
	CWXi0Yc4KJe5iGUstUxM9D8yNHsQzLJ2z3UYw2hZRh07zf7QfjYYXiWXEwigEG/uLV4Txm1iUZn
	tDCFhkmsj75Lp/K4WnVFOYJ9FJCZbEsK/Xbn8xdpNMZ4t4mLGEozp1fOF9UYMJEBQdmrv+U07+O
	iKgRirchJAOMCYT1Q/8xNpiAyUD5wkOPjMZzmaa9CicFh8SJtjZbHuo0zkzodTFBLQHO9W3ECBF
	uGxghGnW+J1udSiEZKzzkPORIUjXgD9+KyFr0ftvEikUK4Fw==
X-Received: by 2002:a05:6a00:1ca2:b0:841:de16:8a8f with SMTP id d2e1a72fcca58-84284dc5ac9mr5907814b3a.7.1780560330267;
        Thu, 04 Jun 2026 01:05:30 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:29 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 2/7] strongswan: Fix CVE-2026-35329
Date: Thu,  4 Jun 2026 13:35:01 +0530
Message-Id: <20260604080506.274123-2-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4133

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...d-NULL-pointer-dereference-when-veri.patch | 57 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch

diff --git a/meta-networking/recipes-support/strongswan/files/pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch b/meta-networking/recipes-support/strongswan/files/pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch
new file mode 100644
index 0000000..7c55d43
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch
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
index c47ca7e..9def352 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -1,3 +1,4 @@
 SRC_URI += "\
     file://tls-server-Prevent-infinite-loop-if-supported-versio.patch \
+    file://pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch \
 "
-- 
2.34.1


