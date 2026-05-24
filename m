Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ACCD5BCC
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:17 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7299.1779625692523075764
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OoOhH/EN;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914b5f85129so213536885a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625691; x=1780230491; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtJ2P9Q2AMfClIgt8f+P4Vs19Sb9QdV+0GYmVPc+b44=;
        b=OoOhH/ENSHciucHD2+wjTAGK5/jrP6kSRW3IZk50ji1RcLBPwHRoDVQCImHFtPRJJC
         QBYUVvYuo+zMOIQVOlUf6CNjQ+B9FUUzLdZ3K1ReLOuHkDMwg97FgYXFnFjrQwSwEwdb
         f/5mwlRXfURS5HCzI0iS+SNROoJiYDDBci9gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625691; x=1780230491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FtJ2P9Q2AMfClIgt8f+P4Vs19Sb9QdV+0GYmVPc+b44=;
        b=oe7l0KJKiz/RsoZ+BskKoZnPGPbavba0qa8Hc1i0zvJyDOAKP8S/7n2bfMXi/45U2y
         4SBYSq/tUCleHTdZByc8U2d96lgRl8GnHdGpdVR1O1/8QmmMoYYjQ/9WdE08k+GrzC3u
         vWDIuHeI5T6E57TOPwHOVddyPQ6jca4sueR8mGMw4rVE8ayXVTZ2eu8F/Y0WujihLur9
         kVe8NRJuIfnQAg33ojIN+RkxGgWZ79+bRJ0PfJtxKk1v8TTL6nlbuwwtZ4kFp2++t7c2
         WsTpIDJGmKE/o2o3NEe4/FYa4xjTJuhR5Zj41v4Z8dCvhz8vnuWp9RFlbL59zIYjeqUk
         Bmiw==
X-Gm-Message-State: AOJu0YwT0YRoEpi8+5QNcAIXYimjPwKWkd2IXoryp4Eg3ocwcC3y3lIM
	PxI+egFIHjvpTPgnu3ro351GBJPGKuGO+gWRT/8gFGbnDAGknpcm71FhLiH6zemsb1nKildelz2
	09Er6
X-Gm-Gg: Acq92OFg0HmmjpSRT2UUN9ly9krWnFz/cYsnnd8xDKK68E0/fe8yduY+4172pWBC/av
	2NgS8biGRR9JPiw/ycY8uzENeyQDhrW37g1ytmKYHNcmvn8Fd9LsGOW9KoLx6OYDtAQCaGvXPlc
	RCgaqeYdK6lksTo+GpurKry8to9S4IxRf70ApD7hT8uXGN475DNbHBpK84pg7DfhfAV3Ff6KtI6
	MP5ZLWDYNVlYTBHCgeWY8L8T3XpkgKzg0qzAWHFNzgyudyxhxPjL5U4R6OpjsmgfJBj/5D0H8t0
	VxZAWQWv2c92n6PfSS8hyGTQgSS+BfHDlCDeuhiY8q7HaRufVSmwuWNkdnWmn/G7TJZJctjmcJq
	sIeXb45RWiPmrSCDG2ZtPYReL483Oy2YYSWrO8NIginKVgftAlH5ypEAibAzo4sxAsKtHzs+OTZ
	SU6Scq61ZHqPpe+Y+bMVfArJdsaE46KTSBjC8pf/rAwUs3kR0qJTaPVLIMBmVfasN/OKME63a2m
	aIPwsY1eXwgSM5IbC+ry+XO+uG4tor7X7EacXem1LbwSW5SrovqiZSZfDib2m/E
X-Received: by 2002:a05:620a:4143:b0:914:be64:9dd1 with SMTP id af79cd13be357-914be64a2eamr1269007185a.61.1779625691391;
        Sun, 24 May 2026 05:28:11 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:11 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 03/13] google-authenticator-libpam: update 1.0.9 -> 1.11
Date: Sun, 24 May 2026 08:27:52 -0400
Message-ID: <e376bba755f1f40ab0586d8d4a216a9b11ba56a0.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4023

From: "jason.lau" <Haitao.Liu@windriver.com>

  Changes from 1.09 to 1.10:
  - Shorten syslog name to work with rsyslog (#172)
  - Update config file with grace period in all cases (#193)
  - Remove printing QR code using Google Charts URL (service shut down)

  Changes from 1.10 to 1.11:
  - Change secret key bits from 128 to 160 bits (#266, #271)
  - Add support for black & white terminals (#268, #270)
  - Fix grace_period for IPv6 link-local addresses (#265)

  Also fix the .bb recipe:
  - Fix typo: RDEPNEDS -> RDEPENDS
  - Use new override syntax: RDEPENDS:pam-google-authenticator
    (replaces old underscore style RDEPENDS_pam-google-authenticator)

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...tor-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)

diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
similarity index 85%
rename from recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
rename to recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
index 333caab..713f60f 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 LICENSE = "Apache-2.0"
 
 SRC_URI = "git://github.com/google/google-authenticator-libpam.git;branch=master;protocol=https"
-SRCREV = "962f353aac6cfc7b804547319db40f8b804f0b6c"
+SRCREV = "016774b0b75ee8f5e80028998d386de762ba1697"
 
 DEPENDS = "libpam"
 
@@ -18,4 +18,4 @@ EXTRA_OECONF = "--libdir=${base_libdir}"
 PACKAGES += "pam-google-authenticator"
 FILES:pam-google-authenticator = "${base_libdir}/security/pam_google_authenticator.so"
 
-RDEPNEDS_pam-google-authenticator  = "libpam"
+RDEPENDS:pam-google-authenticator = "libpam"
-- 
2.53.0


