Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CECD6E68
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:46 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6280.1780560337238759906
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=br0eu90i;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so216603b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560337; x=1781165137; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPrcMeXaECkX37v1xPains6CfZMr0+iH3pqsm6/vf48=;
        b=br0eu90i6aWvRrQHkhlud6n4V5QzZjVN3XLCbwXKyOEjDeNthjX/iP1XDek0XbTqMW
         BwtUB19wfPBWo6tT13bAjEKrnxw095zjEKxL9GM8bm9aMj5DzjYb93jh3hgFGXPuqHN/
         hOZ3hTaHW32376+ZEdmDxKObeom1CRVZb7a9B389gqjz7YsKpEvd0v3tS7xe4VDpp/zi
         0bdfxQXJGI6fnjOYsWFhQrAIp7EvMTTF8FJqp9uJ+FVkKsUmm2xHLeee3gXWq9KN6IhI
         Qhp9ty7Kemg2c9I+sOHktnbSDnJIdsk0wNnBcHnJpcLSrYsDhfTwmrRY8/U32kEpBmT3
         p6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560337; x=1781165137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPrcMeXaECkX37v1xPains6CfZMr0+iH3pqsm6/vf48=;
        b=j7JkmUCAJyg+tM/WJDANRhy92BI4mreEEZAz8arDr2Ci+VMgxC3Omhqyzzz7ZEOXzA
         0GdTLmInTKMF+wWTv+esQRjhwmA7kM2srDErnu0pLQaBE3MZaodKEaKqbJogFZ6D0m31
         ZprLpaV/A/atqan1nPfJNDYdtUHy2MF7+Y/c8Gy/lj1fGV75l13C3sOsMBhhdddrGlSA
         kuSM1IF8x5JYFfcuQYOSRTcIm6fI/0EluytqhILtjMjGqm6r19SkU/AGRfV7n5gOb1FM
         xS6IDG01t/llxobwSw0GyCX1ngQzwAckNz5fpfLcNu3QcUMW6gLR6zkBr7B9nxA7QPfq
         ZiHQ==
X-Gm-Message-State: AOJu0YwnrnLot4LfyIHR5xRiro3J2fJGV5sT2/q7t6ZLcmJSfkr0s/w/
	4Bq4r003MVnqSAenQ2jxAdy3iSxueyHv2zTHOq9OtoKf0w2O1T3apHdxJmQ30g==
X-Gm-Gg: Acq92OGQj5+HpovaumPcUAfqpTCosAaPnHwA6vhkzx2+j/M8vBI2/yKNzD7I1pc3yu9
	4uAg699ypaOc2o6/64Wda+sQNn4TR4SNgagi4N+HLQaQ5dZxmgHQ4NNY0stNuAHzDkB2rq3ewLk
	ta6vjmz61uby91hnPDB3GZHpJ2ctW/hrBpgSiXvxCnMXu758ovdPtXj90F2tMiDPVxzh48UXjTo
	BzyhF72Ubj4MbhbgFRyX6jNjQiEeJV4c41OLQIvyW9J/hia3zcFjxSTDYUK4V2NK6HiyzvgKddb
	z8DM209OtNzNmgq9434M66seYxnwCoemXJ3GPFRzwkMWk+wYnGvMZlnvF4NPquh+qql8ML+12TM
	B97DipvQPuoeO1Co7+gatAzJGy/6nBzomRn8OG6tTCnlOccCSwE9DHkJBj+xinhx9zzImzHGsvR
	uQaNZAgkumTgzEk6SciN/qv5A5RTp5iwqodf5cTIF3EVTJYA==
X-Received: by 2002:a05:6a00:1996:b0:842:3c77:5996 with SMTP id d2e1a72fcca58-8429b57a34cmr2123194b3a.1.1780560336593;
        Thu, 04 Jun 2026 01:05:36 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:36 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 3/7] strongswan: Fix CVE-2026-35330
Date: Thu,  4 Jun 2026 13:35:02 +0530
Message-Id: <20260604080506.274123-3-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4134

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...t-zero-length-EAP-SIM-AKA-attributes.patch | 55 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch

diff --git a/meta-networking/recipes-support/strongswan/files/libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch b/meta-networking/recipes-support/strongswan/files/libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch
new file mode 100644
index 0000000..0e6227d
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch
@@ -0,0 +1,55 @@
+From: =?utf-8?q?Lukas_Johannes_M=C3=B6ller?= <research@johannes-moeller.dev>
+Date: Wed, 11 Mar 2026 16:07:10 +0000
+Subject: libsimaka: Reject zero-length EAP-SIM/AKA attributes
+MIME-Version: 1.0
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: 8bit
+
+parse_attributes() accepts hdr->length == 0 in the AT_ENCR_DATA,
+AT_RAND, AT_PADDING, default branches. The code then subtracts the
+fixed attribute header size from the encoded length, which underflows
+and exposes a wrapped payload length to later code.  In particular,
+for the cases where add_attribute() is called, this causes a heap-based
+buffer overflow (a buffer of 12 bytes is allocated to which the wrapped
+length is written).  For AT_PADDING, the underflow is irrelevant as
+add_attribute() is not called. Instead, this results in an infinite loop.
+
+Reject zero-length attributes before subtracting the attribute header.
+
+Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
+
+Fixes: f8330d03953b ("Added a libsimaka library with shared message handling code for EAP-SIM/AKA")
+Fixes: CVE-2026-35330
+
+CVE: CVE-2026-35330
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Patch is refreshed as per the source code version 5.9.13
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libsimaka/simaka_message.c b/src/libsimaka/simaka_message.c
+index 6706568..4862048 100644
+--- a/src/libsimaka/simaka_message.c
++++ b/src/libsimaka/simaka_message.c
+@@ -416,7 +416,7 @@ static bool parse_attributes(private_simaka_message_t *this, chunk_t in)
+ 			case AT_ENCR_DATA:
+ 			case AT_RAND:
+ 			{
+-				if (hdr->length * 4 > in.len || in.len < 4)
++				if (hdr->length == 0 || hdr->length * 4 > in.len || in.len < 4)
+ 				{
+ 					return invalid_length(hdr->type);
+ 				}
+@@ -439,7 +439,7 @@ static bool parse_attributes(private_simaka_message_t *this, chunk_t in)
+ 			case AT_PADDING:
+ 			default:
+ 			{
+-				if (hdr->length * 4 > in.len || in.len < 4)
++				if (hdr->length == 0 || hdr->length * 4 > in.len || in.len < 4)
+ 				{
+ 					return invalid_length(hdr->type);
+ 				}
+@@ -932,4 +932,3 @@ simaka_message_t *simaka_message_create(bool request, uint8_t identifier,
+ 	return simaka_message_create_data(chunk_create((char*)&hdr, sizeof(hdr)),
+ 									  crypto);
+ }
+-
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index 9def352..0769de9 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -1,4 +1,5 @@
 SRC_URI += "\
     file://tls-server-Prevent-infinite-loop-if-supported-versio.patch \
     file://pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch \
+    file://libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch \
 "
-- 
2.34.1


