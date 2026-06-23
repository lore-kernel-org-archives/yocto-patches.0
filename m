Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C96FCD98F0
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:48 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14970.1782195022808058403
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EKJeMmoj;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37c5a6be9c9so849764a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195022; x=1782799822; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmW7TKqCpJw+tz0OpESr64sZlIAeWFAg67eJiQLhCkg=;
        b=EKJeMmojdppCbgtHqj+HGzCJl6crVMS9pQ67DEn8oy9hzRHMZvnaBUbpPpZIC0YqQ2
         GxXeO3zl6bgoCqgV0DT/Dvfu/014FHMx++G3mutuBnTQ+zmY52miRqOwCc9YqSjgXlKO
         oDMBSB4xHZpygLyNSRWaKMw9FXAb/N4EKJf9r05KHOWANGcJqFbjdRCguvdIbQ6wHqdZ
         Jbv3vLQXmmCj36YobxIodeaIxvovZofcjqAJx+moDN1eI6t/NeAUd+aYbOM0YmE3awK5
         KGDRZZSLyyscgUaHsaxigJbNMMKSdCmyQE5f74P9+O4peezVPWp7urlDy6/rfzqBnYlP
         db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195022; x=1782799822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmW7TKqCpJw+tz0OpESr64sZlIAeWFAg67eJiQLhCkg=;
        b=dPMjYv+bJatcXXUZpButZmgZqrthOOfVMEPnYUaLZAT7HQu9hdTLrbDEowCoNcFVSq
         1MTg8h+wpDcxGCAc8UvkwtgeSUagjGWQ800q28bimFO4cRw0G14ihi/CmrJsWEgfks6Y
         9CjVW3XH6lXhVdteAN9EG56FAAXaC/Ji4Ol2om9Bg9dJa+dlewajy2eoHlhKVPutrXe1
         aas7Sno800KI/kGo9tE4G7no2kT6ZhyEnN9KQmx2juYmBS/JputJRQVi8W7eR6m651sr
         pdb1ECzHczgbZx7Tz87NHQZH7Omz7I1+ONNpsfH6O58H65bbAUpVBz0ZOQX+jNUKZCtz
         sySw==
X-Gm-Message-State: AOJu0YwASAqcpyRhMMxX3Sl4t5wKQpZ9if1XGam848A9qu+3ghxNuZm4
	r5XmQJT6VRHyAphuxl+qa+cgvA5rnbLZcoL73UqU6r87XfRrr4pUxXkcB56DCqWp9zE=
X-Gm-Gg: AfdE7cmrp74wxdkzoCOHTZ49fjKPu8PEhGJQcSc4h1yyyW3JogH7Vac3S8cztDvEsox
	ncu/h7PIADjFnwaePPHOggS6W+d1AlxFAbKZMQ2Gu+dtprJuuw2SpqSRjKO6/uGvebYOKFymqvN
	S/bt8UBrHMlYgtYiGp5B5J5IkJy8axOTTa4Il7ChHCuA9dKIUJyvaeko4CEZxNPUMQqbsyJSVUu
	khhc7xGy1hLIwE2+qpZzY8ooDPty/BrHZKPtRTpTjwdVYWFhJNdznEK00Yk71lt5tRR+5/Ae2+q
	+sYFHVO/gaexApETx9A2CotSzgK0Yh7Mu1kaw2g6TcQRi3a4rURimUXcJ819gBU7+/y/F0I09F5
	hwDSATin/ORzmFr74NfNAqi5pwLRMkvyCJeJjEaN4PO8rq702YQ3QFFkZ3h62jlG4Q1XRfKX7Bb
	56wcg1B6txy9U4xPW8A1W5/rw=
X-Received: by 2002:a17:903:1a26:b0:2c1:5664:b747 with SMTP id d9443c01a7336-2c7bf1fc191mr15900015ad.7.1782195022142;
        Mon, 22 Jun 2026 23:10:22 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:21 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 3/7] strongswan: Fix CVE-2026-35330
Date: Tue, 23 Jun 2026 11:39:57 +0530
Message-Id: <20260623061001.644583-3-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4269

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35330.patch     | 55 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35330.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35330.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35330.patch
new file mode 100644
index 0000000..0e6227d
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35330.patch
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
index 0f167db..527e3b3 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
     file://CVE-2026-35328.patch \
     file://CVE-2026-35329.patch \
+    file://CVE-2026-35330.patch \
 "
-- 
2.34.1


