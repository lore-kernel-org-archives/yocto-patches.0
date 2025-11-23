Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2242BCFD31D
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4855.1763941518758196806
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=S02BF/zG;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2d32b9777so508967085a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941517; x=1764546317; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBPQlmkBpXKTXHb5vXmxwi4XpQdZ1MmJ0RQhTipRiI4=;
        b=S02BF/zGhRNctiwLukB5Vgg14qj/bUtqXVaZeU4WOQFoJTnRmEzy/bK5bxYf3sAIkL
         A9tw4Qaw6F5nFT/M04/+Nn9kwR9MJcUrKzrdSrk/Z28s/L+KKqxH2NiLuR0NZwJdXNVR
         ryMVN9VqHXn/N1fCtTE6IokdnfHzG9qsX3rCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941517; x=1764546317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBPQlmkBpXKTXHb5vXmxwi4XpQdZ1MmJ0RQhTipRiI4=;
        b=t1oJ9/LFBhxFLkjqFkIChC3sQeZ5dQBxM/pNFWeOFD70JRLDVfFkhnu4mH/fIihmN+
         r+mYJxMjQQaydM97LYMRCnfpdP2AeKIea2FS2JMQH6FfaHjmS1JOiT82e7CtIZJgh9Zj
         OF2I7xRak3KQsejKhlddFudC8NwtQMxc7Eid3SmFPAam11a5qbbQ3F0PFLmA9VYOs0oX
         mWQN1x0xAcXMzkMZXmX+rc88glaR/7s09eoXXTUVEgN/T0gNxj55ySzSaBUl2WnlR4XE
         YIMlTCjA/iriZpU1uzT9PbMwtUzf580RolvzC20vRnRmhN3k/1GQQSwWYuE70nqwOIaC
         DQmw==
X-Gm-Message-State: AOJu0Yz1h4S011ErGDXNHPnr+nm3B3gY+ypiJX/4JnBmAE/ViENp9Upq
	sZ/S7syMeeCkM3oRiSZvNwi50VR9HSjD6h+lBUOU1kkz2QlC/qLdpyBdeopeLL/vU27K6/PfAmW
	19z76
X-Gm-Gg: ASbGncsxwoEjyOpuIALBEpeeCGCTH8OkZvebfYhPZFu3xDr/Fw+42wBNopimMo4+uW7
	dQpnHi+Bu/+gbKHEb9BfdSsJv/qslHT6fdP6o//xt/6Bwzl6qMu+YAvAuD3ZASyzZCpaSwMFaxy
	mDB0qcZAoEm3N63xq888VmHAh38jd1c5nHAJH4N1SgpoDA5UxpbIyBK+4xxhnXxzRRBoBBQez6c
	hFM/+feU4733MetYYODCFZs1Vlt2hlfRdYmSxrzpkqQndsiMkFtqzT+cniu1cKPrUbKtw/Wd3/P
	usUHX+Ujz7hJMWm6HczSr7jlKj9ZYNrQFDYOIIAw1JYVNJhtlim9XOZi8W4j7E2qnF/fBhBnbMW
	3pd55/wKyZz/ntGW1SHzDCZGGXy9WqTZbuloKxcKaGJWGGnNguXQQ53wfWKz/d0KSfbE9Udc07w
	ZKG8StHYxaXjq6VBw2czuL4deP+1AU2nmOuK6gSpHwBCLluekMQ13Npm9LORRhNtc=
X-Google-Smtp-Source: AGHT+IGfgk3iALZ5hAiTC7wiS8yCkLsiSze41E4PE8bW+LhNN+JCmfDAJBTtKT5g9kWSsix1C/r/Ow==
X-Received: by 2002:a05:620a:460d:b0:8b0:f8c4:a5fe with SMTP id af79cd13be357-8b33d5f2646mr1231197585a.89.1763941517272;
        Sun, 23 Nov 2025 15:45:17 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 01/32] Update maintainers
Date: Sun, 23 Nov 2025 18:44:41 -0500
Message-ID: <c8400db9147934ed3c557b4ecd41d54f6e6c321a.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2659

Add Marta and myself as maintainers for meta-security and the other
embedded layers that Armin had been maintaining.  To avoid Armin
getting bugged about individual recipes, set the RECIPE_MAINTAINER
variables to myself.

(backport from master)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README.md                                     |  4 +-
 .../include/maintainers-meta-security.inc     | 72 +++++++++----------
 meta-hardening/README.md                      |  4 +-
 meta-integrity/README.md                      |  4 +-
 meta-parsec/README.md                         |  1 -
 meta-tpm/README.md                            |  4 +-
 .../distro/include/maintainers-meta-tpm.inc   | 33 +++++----
 7 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/README.md b/README.md
index 3e092a9..c657d15 100644
--- a/README.md
+++ b/README.md
@@ -83,7 +83,9 @@ Now you can just do 'git send-email origin/master' to send all local patches.
 
 For pull requests, please use create-pull-request and send-pull-request. 
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
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
index cc39ca4..36f269a 100644
--- a/meta-hardening/README.md
+++ b/meta-hardening/README.md
@@ -76,7 +76,9 @@ $ git config format.subjectPrefix meta-hardening][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:  Armin Kuster <akuster808@gmail.com>
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 License
 =======
diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index c333a9f..191b8e4 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -45,7 +45,9 @@ yocto-patches@yoctoproject.org mailing list. When submitting patches that way,
 make sure to copy the maintainer and add a "[meta-integrity]"
 prefix to the subject of the mails.
 
-Maintainer: Armin Kuster <akuster808@gmail.com>
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 Table of Contents
diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 785c932..9dea718 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -257,7 +257,6 @@ $ git config format.subjectPrefix meta-parsec][PATCH
 Now you can just do 'git send-email origin/master' to send all local patches.
 
 Maintainers:    Anton Antonov <Anton.Antonov@arm.com>
-                Armin Kuster <akuster808@gmail.com>
 
 
 License
diff --git a/meta-tpm/README.md b/meta-tpm/README.md
index 983c753..523b284 100644
--- a/meta-tpm/README.md
+++ b/meta-tpm/README.md
@@ -69,7 +69,9 @@ $ git config format.subjectPrefix meta-security][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
+Maintainers:    
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index e7b216d..829f198 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -19,20 +19,19 @@
 #	RECIPE_MAINTAINER:pn-<recipe name> = "Full Name <address@domain>"
 #
 # Please keep this list in alphabetical order.
-RECIPE_MAINTAINER:pn-aircrack-ng = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-pcr-extend = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-tpm-quote-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libtpm = "Armin Kuster <akuster808@gmail.com>"
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
-
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
2.47.3


