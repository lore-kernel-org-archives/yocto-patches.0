Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24424C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 18:46:39 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.666.1751049993507410120
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 11:46:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PfZg9Vht;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faf66905baso1877876d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751049992; x=1751654792; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoHrh0xoHiqES4oCGAAW2YsIn3CrVDLDuBzq646yyLE=;
        b=PfZg9VhtzgEUitB3dXR+NGnsUS7++uf1JediF3VwjY8+s71mGR/peGWlxDRd2FFWu6
         SH69x5wwHp2FC8V2QMyRKmOd6HOf2aC0FHQjxhGTH8IDKUXZ8R7wL4wvwd85DLt+qZfa
         GL58JjCa9FzcJsGaUim0DLtRP7/NJ4uvbaJ6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049992; x=1751654792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoHrh0xoHiqES4oCGAAW2YsIn3CrVDLDuBzq646yyLE=;
        b=sb+PswB4W4c4jLuhZnLFjXl++Caf8rbHKiaXjQ6areoGJnWIgc3TkG2erXlsoVAQPd
         17nxMU8FR0phjTqCYgHkrplmd+U9jwSvl6hLi49pOYVhe/sdI+1ASkOVINb3Ubuh442a
         BDCQrqM31e/NfWEBOcT1bxgBuDQsPS7UfYj8S9woOqG/Ou2keN4+46OO4qFJCwvEk2Jr
         i3KhbLpAKVeN8/G0qU4wTO359USpCSyHS59t/vmqVRzlNQuuBcf5XTjRiRFts19IQn47
         ZzYurUMIwpxHIo6TQRmNq2iPa7mcJbGHjCy5QLylpbuWPKN95fshfYS9s8My9Jy8hfzR
         Bfew==
X-Gm-Message-State: AOJu0YwQMAP1aI58JYCxH4g6ZIc8PzBfvwgYYLWraYR+Mv33u+rSdZMh
	FBXdVXXilW+3ECY9hBTy57LuoqvT7dtvjwU6b+8Ku3aS3FvygcN4gG2xWHAMXsq4cun0han/qc1
	KGV0X
X-Gm-Gg: ASbGncuvOCHX98mZk/mQEmh3nVdeNc5BEzRcKOx/HUTLU3L/rVhx6aHtqaC2RgyZPpW
	G/ZTCwX/y2F0SopbkGPQSe2mt2NLpBoMIG6UOuzetvoI/nuHfryyaYIYiwyZ7zkDj6zc4847Rb3
	EKrByKQXviP/CU1x7uT9oUqSeMWXnuvNVi/MUeu9jt4BOxDt3OmOh4ypdATeVtO97ofFaVklTHS
	FSC75oHNPA02NxiS27x8Qy9dSrwFNYm5aKbPh/fM3WPnYouXIor7CRQ13BsCgPqMPpaglxBCtXI
	/p8k5qzPDyBsQaZXEHrHUPow4OjkILOh5JEva9KkrC2lvXe6DR6NtndhtUeAKZhg//+XzWyJWMy
	p9vFFMn8oVNeVW7bLxXGtVKayvMbr8MCsWY7Y6w==
X-Google-Smtp-Source: AGHT+IGLa2Shx8kGLi/nz9BjWM0uuNXZ3jKNBAjxb6UUyy2w0hJIVZiONalTU33AciWOWkAK2gbUhQ==
X-Received: by 2002:a05:6214:2b0c:b0:6fa:bb74:8d72 with SMTP id 6a1803df08f44-6ffed759587mr75327496d6.0.1751049992176;
        Fri, 27 Jun 2025 11:46:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730ada5sm24979316d6.110.2025.06.27.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:46:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [meta-security][PATCH 1/1] Update maintainers
Date: Fri, 27 Jun 2025 14:46:17 -0400
Message-ID: <d362cdc5e05123ac1907f64d94ea604fdaab884f.1751049467.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751049467.git.scott.murray@konsulko.com>
References: <cover.1751049467.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 18:46:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1724

Add Marta and myself as maintainers for meta-security and the other
embedded layers that Armin had been maintaining.  To avoid Armin
getting bugged about individual recipes, set the RECIPE_MAINTAINER
variables to myself for now as a starting point that can be adjusted
as things get more settled.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md                                     |  4 +-
 .../include/maintainers-meta-security.inc     | 72 +++++++++----------
 meta-hardening/README.md                      |  4 +-
 meta-integrity/README.md                      |  4 +-
 meta-tpm/README.md                            |  2 +
 .../distro/include/maintainers-meta-tpm.inc   | 32 ++++-----
 6 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/README.md b/README.md
index a8b9f33..dae5aad 100644
--- a/README.md
+++ b/README.md
@@ -88,7 +88,9 @@ Now you can just do 'git send-email origin/master' to send all local patches.
 
 For pull requests, please use create-pull-request and send-pull-request. 
 
-Maintainers:    Open
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/conf/distro/include/maintainers-meta-security.inc b/conf/distro/include/maintainers-meta-security.inc
index f623d70..c052695 100644
--- a/conf/distro/include/maintainers-meta-security.inc
+++ b/conf/distro/include/maintainers-meta-security.inc
@@ -19,39 +19,39 @@
 #	RECIPE_MAINTAINER:pn-<recipe name> = "Full Name <address@domain>"
 #
 # Please keep this list in alphabetical order.
-RECIPE_MAINTAINER:pn-aircrack-ng = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-apparmor = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-bastille = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-buck-security = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-ccs-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-checksec = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-checksecurity = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-clamav = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-ding-libs = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-ecryptfs-utils = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-fscryptctl = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-google-authenticator-libpam = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-hash-perl = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-isic = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-keyutils = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libaes-siv = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libgssglue = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libhtp = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libmhash = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libmspack = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-lib-perl = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libseccomp = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libwhisker2-perl = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-ncrack = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-nikto = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-paxctl = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-python3-fail2ban = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-python3-scapy = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-python-fail2ban = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-python-scapy = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-redhat-security = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-samhain = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-smack = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-sssd = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-suricata = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tripwire = "Armin Kuster <akuster808@gmail.com>"
+RECIPE_MAINTAINER:pn-aircrack-ng = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-apparmor = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-bastille = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-buck-security = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-ccs-tools = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-checksec = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-checksecurity = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-clamav = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-ding-libs = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-ecryptfs-utils = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-fscryptctl = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-google-authenticator-libpam = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-hash-perl = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-isic = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-keyutils = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libaes-siv = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libgssglue = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libhtp = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libmhash = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libmspack = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-lib-perl = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libseccomp = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libwhisker2-perl = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-ncrack = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-nikto = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-paxctl = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-python3-fail2ban = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-python3-scapy = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-python-fail2ban = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-python-scapy = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-redhat-security = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-samhain = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-smack = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-sssd = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-suricata = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tripwire = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/meta-hardening/README.md b/meta-hardening/README.md
index a62782c..36f269a 100644
--- a/meta-hardening/README.md
+++ b/meta-hardening/README.md
@@ -76,7 +76,9 @@ $ git config format.subjectPrefix meta-hardening][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:  Open
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 License
 =======
diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 293ea56..92d24f8 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -45,7 +45,9 @@ yocto-patches@yoctoproject.org mailing list. When submitting patches that way,
 make sure to copy the maintainer and add a "[meta-integrity]"
 prefix to the subject of the mails.
 
-Maintainer: Open
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 Table of Contents
diff --git a/meta-tpm/README.md b/meta-tpm/README.md
index 1d34f05..523b284 100644
--- a/meta-tpm/README.md
+++ b/meta-tpm/README.md
@@ -70,6 +70,8 @@ $ git config format.subjectPrefix meta-security][PATCH
 Now you can just do 'git send-email origin/master' to send all local patches.
 
 Maintainers:    
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index 77f843d..cbc1fcf 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -19,20 +19,20 @@
 #	RECIPE_MAINTAINER:pn-<recipe name> = "Full Name <address@domain>"
 #
 # Please keep this list in alphabetical order.
-RECIPE_MAINTAINER:pn-aircrack-ng = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-pcr-extend = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm-quote-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libtpms = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-trousers = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-swtpm = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-openssl-tpm-engine = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-abrmd = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-totp = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-tcti-uefi = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-tss-engine = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-pkcs11 = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-tss = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm2-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-ibmswtpm2 = "Armin Kuster <akuster808@gmail.com>"
+RECIPE_MAINTAINER:pn-aircrack-ng = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-pcr-extend = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm-quote-tools = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-libtpms = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-trousers = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-swtpm = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-openssl-tpm-engine = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm-tools = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-abrmd = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-totp = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-tcti-uefi = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-tss-engine = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-pkcs11 = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-tss = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-tpm2-tools = "Scott Murray <scott.murray@konsulko.com>"
+RECIPE_MAINTAINER:pn-ibmswtpm2 = "Scott Murray <scott.murray@konsulko.com>"
 
-- 
2.49.0


