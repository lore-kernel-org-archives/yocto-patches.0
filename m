Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51661C83F0C
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:12:08 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.1073.1751649120293107248
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:12:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bEhm1ny9;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b3526e6so17486421cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649119; x=1752253919; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20l6qZ/CJmk9etXQtooTDc6ED7V5rBkUosbbQEjAvtw=;
        b=bEhm1ny9KuHfOva6Ir6y36Hm5Yck5LLGDSxg7jtlInKKcBzIH8eXgeCWUZOkXFX18H
         +d8453IZBFfe1xHlSbAa6F5u02YYI2vupkPtm32UXFYiykdWzaLXvVnVAHx0mqYZw1eF
         Jv8MHN9kJLn6yRcg/yQQRwz7JqrOrBcd5fkGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649119; x=1752253919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20l6qZ/CJmk9etXQtooTDc6ED7V5rBkUosbbQEjAvtw=;
        b=Qqnr7TgS0gEj5EOqTmqhBTATjNcoImApW9Y2pT81TzsTe/XD0qyezpOh52WEn6PgQm
         a/oxe+0btzuKbx3j3ZDHE3VfNZkD6mIGB03n6RZs+SNOnG36A/AX+LD9JuW8k3VOtDns
         Jp7ibIL44O9gW4g7mFdE4fFkbsO97sKxTDsJhnm+1u926EFH4OJx/5x657Apw5iVcDEt
         ihR9sUdGc/Dq3GM8KxhMX2Q8q8QuGCjvvHD9mujhN+ur+VaHY9rAV3pY356cSMkdsnNp
         l7RFYiwL11WXKak5nzNjgdPCPHgCITnXc0o/GibOnAYOyUyezmK4ereu305HentucmL8
         TQ1A==
X-Gm-Message-State: AOJu0Yw0sIwIYP53CipsRmhrJXPhCgN+2kBn720++B0FSZBlV/TLhAAm
	irAgY1N4hqmV7x1sXfYiWZ2OkOel4xhFJcAJgJ90Q22nqUUXSzc767RlA07Z3PF1jKJvNJjZGKZ
	Tu3BG
X-Gm-Gg: ASbGnctT5IsXr0riD857R/AO3DacVBOnXhN//HfeCwhh8Vhw4SG2dOsz+hnoQxCVKvF
	LdTatHyxi16k402NtFW56FHH7Nkc8rfge/GfYWFRRIYseZDCzOgfrQYX1XJA+e0/VkSWoDctTBk
	ZVzWytge2DF0+SziEYH3mcc+/eraEHJekp/Rn/TDjsSLEJBuotn+EjGM7bslTXDGDgPOMVnwuPR
	8M/FR/sLwaeHQP/vZcuRfMCVzjEckcazPu4q2tJlOuT/uBBFrAuI37xWaVy3VQNW0kvyYCobxi+
	wclAAztCI5Bs7qRxv1AI7dDRwYX+U3f6/poXerUC/xqqRYTqwx6XbDaMBI4baMuNlLVsgUFOm7y
	U42Hkskv3Oc9LqITsNSy0Ngac2rMiE0/AOQdJJBDQTX/4DKul
X-Google-Smtp-Source: AGHT+IEed1ZHo5ntgvsjg3pI6oGEfPyG0RKQNZxIcL78yFl2QJ4UgPFWfdPTbD6fkJdTYvAwygdFqg==
X-Received: by 2002:ac8:59c5:0:b0:494:ad3f:cb7e with SMTP id d75a77b69052e-4a99682f5f2mr48596551cf.50.1751649118953;
        Fri, 04 Jul 2025 10:11:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:58 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 10/12] chkrootkit: fix building with gcc 15
Date: Fri,  4 Jul 2025 13:11:14 -0400
Message-ID: <8a266d6df5118fc3be230931d2aa4534bfc9f8b2.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1762

Add a patch to fix building chkrootkit with gcc 15.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/rootkits/chkrootkit_0.58b.bb |  5 ++-
 .../files/0001-Fix-building-with-gcc-15.patch | 39 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch

diff --git a/recipes-scanners/rootkits/chkrootkit_0.58b.bb b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
index 0fcc55d..e5912fe 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.58b.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
@@ -6,8 +6,9 @@ LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=6db4d77fb8f0cc84d175e7a1211e4c13"
 
 SRC_URI = "${DEBIAN_MIRROR}/main/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
-           file://musl_fix.patch"
-
+           file://musl_fix.patch \
+           file://0001-Fix-building-with-gcc-15.patch \
+"
 SRC_URI[sha256sum] = "75ed2ace81f0fa3e9c3fb64dab0e8857ed59247ea755f5898416feb2c66807b9"
 
 inherit autotools-brokensep
diff --git a/recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch b/recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch
new file mode 100644
index 0000000..8c2a111
--- /dev/null
+++ b/recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch
@@ -0,0 +1,39 @@
+From 9834ad9f0b8a10de22512772222a9c51014c750d Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Thu, 3 Jul 2025 18:11:24 -0400
+Subject: [PATCH] Fix building with gcc 15
+
+Fix read_status signature to avoid incompatible function pointer
+error with gcc 15.
+
+Upstream-Status: Inactive-Upstream [lastrelease: July 5, 2024]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ chklastlog.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/chklastlog.c b/chklastlog.c
+index 2fffd9e..1566c76 100644
+--- a/chklastlog.c
++++ b/chklastlog.c
+@@ -78,7 +78,7 @@ int main () { return 0; }
+ long total_wtmp_bytes_read=0;
+ size_t wtmp_file_size;
+ uid_t *uid;
+-void read_status();
++void read_status(int signum);
+ 
+ struct s_localpwd {
+      int numentries;
+@@ -214,7 +214,7 @@ int nonuser(struct utmp utmp_ent)
+ }
+ #endif
+ 
+-void read_status() {
++void read_status(int signum) {
+    double remaining_time;
+    static long last_total_bytes_read=0;
+    int diff;
+-- 
+2.50.0
+
-- 
2.50.0


