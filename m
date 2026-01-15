Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9761D4663C
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.705.1768517213114374208
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aAQlZ1Z2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a26e8711so1240101cf.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517212; x=1769122012; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uGXR84RZlEODxfMaF1hsT3XZzZHeWk3xuW83Y7hXhU=;
        b=aAQlZ1Z2FTUuhcXE6cfn8ZZBgVCrwqKdt+ob45NQEe7+FpD8j0oovQzeyEatrIbtah
         hOj3qTUU6aDtGv5q1guigmqOZZY2ffiWAMQo5qyUAvdJDoCs9+b2Pc2Va3tUtxxzYc3C
         xH84gkelnuQM1b4Ow4RJRuL3YRt3vIy6hxs/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517212; x=1769122012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uGXR84RZlEODxfMaF1hsT3XZzZHeWk3xuW83Y7hXhU=;
        b=Vc/pi3rL8iXxVLvw2nFB9EJBo0lqqWywdiSxwpgmAc1Y/tjrs4n9OvKr3SY2txKcZR
         jvB8LZyqrR4jwtbjPg6x5w7Etj1ysjTLRhxaL7jseIe7LjRZRBFxqswulJNHf4wJKnGZ
         s8uVGiglJiWawpD4NZMY+LGpan4vTLr0KpS7rfuIT7X4Dkt7AocBKKwH1wQCB7DMzSqb
         PeMLnUdUEABMFi60QnLD5NN7pS/rzIeWi5Pf5LetYP8XE457jW9u8tAiRZkgKHbj8MqJ
         fCMORjsbDgNotBJLtgfkTTW0FcmQLIVuEJ4BuKOIxHhvQsI/nMTDEa81+cvAj8a+SYrj
         OCJw==
X-Gm-Message-State: AOJu0YzRDObgxOaGQ/vS9RXYiLaTkXfAyOUteNenYCkXjuNcgQf13bcA
	QT+nYKezO6QW9+z3DltEbYJ5/w8ePx/Vu7ZruI9SreU2skKTMpJNLSk9TtYC6CgTqpeSC1hCfIb
	1mezZ
X-Gm-Gg: AY/fxX4dzFy6WGM4g2p+pxyXijM+YVE8/ZqQnfXdYEF3SSf5UTpysYIOhU5L43ULPbR
	WMFM5Ex3qtPYQ7Wa0CF8GcsMYYdOto74ZaiDRX58QU6B9cYtTdnrVvAKAVJxagEBEqcUhzh6sks
	fNm4rqjh+BGna76AOGuUH/2ptbg8bfUf/0QUT9pud2nEEKfjqGI8f0XeBon4KoePU8RR/MbCrgy
	ygttYN1cYmsWjcTkK7qj2tw40qWoRKW4lZjM5xN7yzqjbvez7/w9GBd9PJyWHtflOAub8hVKRGR
	UsY6xg358pjkYYwdBqROLkcXIfzh+L7s/soXWbLSQikbI4KLHbS/mVWxaWB1CMZ3ZNhzXV1ro2r
	yCRfjtwCCRYMofm5wfj4Vr8CQ398sc5iTr9ccoVPO/T7teDKtRxCXPEGvAY/70TjdDvifMLk7YA
	EsiDsDWdqX9tdVx0hpKV72tknoBQW+PgVCYTT0GzcVnwCgxP3kswTO0Wg0e0QksZBV34FqmDr6l
	f3UFxXf5hpIdreP6mKWd56hQ9SklQqh/ys+ZCbmgUeONHKIe2bI
X-Received: by 2002:ac8:5d8e:0:b0:501:51cb:1371 with SMTP id d75a77b69052e-502a16520d5mr14832121cf.17.1768517211738;
        Thu, 15 Jan 2026 14:46:51 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:51 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 1/9] Update maintainers
Date: Thu, 15 Jan 2026 17:46:22 -0500
Message-ID: <eca72301e0e78cc5d53777552503380e82d96d84.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2966

Add Marta and myself as maintainers for meta-security and the other
embedded layers that Armin had been maintaining.  To avoid Armin
getting bugged about individual recipes, set the RECIPE_MAINTAINER
variables to myself.

(backport from master)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README                                       |  4 +-
 conf/distro/include/maintainers.inc          | 72 ++++++++++----------
 meta-hardening/README                        |  4 +-
 meta-integrity/README.md                     |  4 +-
 meta-parsec/README.md                        |  1 -
 meta-tpm/README                              |  4 +-
 meta-tpm/conf/distro/include/maintainers.inc | 33 +++++----
 7 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/README b/README
index 081669f..7bd7f7c 100644
--- a/README
+++ b/README
@@ -92,7 +92,9 @@ Now you can just do 'git send-email origin/master' to send all local patches.
 
 For pull requests, please use create-pull-request and send-pull-request. 
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/conf/distro/include/maintainers.inc b/conf/distro/include/maintainers.inc
index f623d70..c052695 100644
--- a/conf/distro/include/maintainers.inc
+++ b/conf/distro/include/maintainers.inc
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
diff --git a/meta-hardening/README b/meta-hardening/README
index 191253c..e804bcb 100644
--- a/meta-hardening/README
+++ b/meta-hardening/README
@@ -76,7 +76,9 @@ $ git config format.subjectPrefix meta-hardening][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:  Armin Kuster <akuster808@gmail.com>
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 License
 =======
diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index eae1c57..b0196dc 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -45,7 +45,9 @@ yocto@yoctoproject.org mailing list. When submitting patches that way,
 make sure to copy the maintainer and add a "[meta-integrity]"
 prefix to the subject of the mails.
 
-Maintainer: Armin Kuster <akuster808@gmail.com>
+Maintainers:
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 Table of Contents
diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 97026ea..292d99d 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -190,7 +190,6 @@ $ git config format.subjectPrefix meta-parsec][PATCH
 Now you can just do 'git send-email origin/master' to send all local patches.
 
 Maintainers:    Anton Antonov <Anton.Antonov@arm.com>
-                Armin Kuster <akuster808@gmail.com>
 
 
 License
diff --git a/meta-tpm/README b/meta-tpm/README
index 5722a92..e3667da 100644
--- a/meta-tpm/README
+++ b/meta-tpm/README
@@ -69,7 +69,9 @@ $ git config format.subjectPrefix meta-security][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
+Maintainers:    
+Scott Murray <scott.murray@konsulko.com>
+Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/meta-tpm/conf/distro/include/maintainers.inc b/meta-tpm/conf/distro/include/maintainers.inc
index e7b216d..829f198 100644
--- a/meta-tpm/conf/distro/include/maintainers.inc
+++ b/meta-tpm/conf/distro/include/maintainers.inc
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
2.51.0


