Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897FC61DD2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:04 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22628.1787777936469636589
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ik1EII2N;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52fa6005224so403331cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777935; x=1788382735; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VGV7O+F4SRTRkABEgWl0cRqj1h0m1muH60y/rE/OVms=;
        b=Ik1EII2NONEtn7q9BmVbaEXFxfMEnE1mh/pUa2iswMJOTp1sR+qtn9DfujcpNn28F5
         rMzWQVRdZWxZAVuIeOb2ymGv3MetdD+9iL1LPzfK5V6RxkQ+kk62wvIVb3KZOBRADQi9
         t60WQ5DDZ381UdWadh24K7p8s6Y6lrZ9seUUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777935; x=1788382735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VGV7O+F4SRTRkABEgWl0cRqj1h0m1muH60y/rE/OVms=;
        b=ODNPhb+yHvXnvGgs2v0lf2xVwcs/u/led1FjRckCqQM3rmxmB7V0413kmNeGUkgp74
         k5qsDgyFBAzLiA85ODJK5AofC5wgsUpMbrbcUbzLsOxx4++AwYY29nD6lPf+asrmKCaH
         RzrNPWvMN8NDpuVcUBdLXR6t90/YHO8FmScQb/fZmYg5u+ec1DYe3mSP0nvIoH1JFTfz
         uKcddv18IScGTv5IfwhsjwlA/uBb4KmEml7J7dimWl4Z/l7NjEhjRn7Lr+xCuHKYGgsm
         YBIP/xgdqiyMEO3Coy34R8bq+GZI8XsshdXorv4xma7dIYodJqlD2Pc8zYU6X8JbthrV
         JoRQ==
X-Gm-Message-State: AFuF++nyaAkQZUxX+OlbbqT3hSf0TkFWRlHT3NQf995ba7gkgA4Fwhj9
	tFpM9vcX7XMCh/aaaUbaBsp3puDFPjIXuQjw7TdflbYoiBEdXODJ217c2SZQdhkaDGA6XZbPhWs
	P49fJ
X-Gm-Gg: AR+sD11K+CWd0mRIK7g7qyIdhsNd8oBRV0hcKJoNgfZJEtlAMyo3F3cpKRwIkCiOLBJ
	CzM8yLiHhme2wo25/x1PQcQdpLdKeY9mHYbETj+mrYnZSytSsqEfYQ2wzjEvoWNLQv92KKqvYRV
	SNdXKgfIFPIolSWf7H4lwLoO2O3hIQPvWyFx0XxYZ+tErmSH0OsHDaMsi0eo7glptT1lR0s3rbs
	WS92xOeUkEayl5tJb5BO4thGQndo3NV6zt+uBXkMrvqWzWiB5fnWE3WCEjLmCbcywFSn+7sJjdo
	tJn+jOo99Hoc4OkSEBB8Zqr+bm/xOeuB0ypAFeCNXKO4CQVriwCkknNjvuzxTQvm0Uyy1bd84mw
	hqe1ulBvrGBgOugKo0gfOda6RXez7Kd/Qodwr/GPcwHsZu7lSb13x3xxe8/WWh5qXT7SxcZEN2O
	9Xr2tI++zVBuSNS8pT1eiAWIV8wa5XpqfuucF6LHRXKVKoP+6A1jMOVgcEd6pDIquK0OshrNpuz
	dmMpT9KBSg9if4Yu8w8Nr8oHuA0CNrG5YK0HxC+3+/Culug6cJx2TQXk8WDs/lNIPeWeMQ30yJE
	un2BAjEnVZj3dX0nPstSooYokw==
X-Received: by 2002:a05:622a:844c:10b0:52f:a2c0:1451 with SMTP id d75a77b69052e-52fa2c02c03mr13838551cf.7.1787777935134;
        Wed, 26 Aug 2026 13:58:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 12/15] fix LICENSE variable syntax to suppress QA warning
Date: Wed, 26 Aug 2026 16:57:46 -0400
Message-ID: <d4afe523556fb043949ef0c5c3b9f73089d9ad6e.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4704

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/crowdsec/crowdsec-licenses.inc    | 2 +-
 recipes-ids/crowdsec/crowdsec_1.7.7.bb        | 2 +-
 recipes-mac/AppArmor/apparmor_4.0.3.bb        | 2 +-
 recipes-perl/perl/lib-perl_0.63.bb            | 2 +-
 recipes-perl/perl/libwhisker2-perl_2.5.bb     | 2 +-
 recipes-scanners/clamav/clamav_1.4.4.bb       | 4 ++--
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-ids/crowdsec/crowdsec-licenses.inc b/recipes-ids/crowdsec/crowdsec-licenses.inc
index cb45b10..92f5dc6 100644
--- a/recipes-ids/crowdsec/crowdsec-licenses.inc
+++ b/recipes-ids/crowdsec/crowdsec-licenses.inc
@@ -4,7 +4,7 @@
 # Do not modify it by hand, as the contents will be replaced when
 # running the update-modules task.
 
-LICENSE += "& Apache-2.0 & BSD-2-Clause & BSD-3-Clause & ISC & MIT & MPL-2.0 & WTFPL"
+LICENSE += "AND Apache-2.0 AND BSD-2-Clause AND BSD-3-Clause AND ISC AND MIT AND MPL-2.0 AND WTFPL"
 
 LIC_FILES_CHKSUM += "\
     file://pkg/mod/ariga.io/atlas@v0.31.1-0.20250212144724-069be8033e83/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
diff --git a/recipes-ids/crowdsec/crowdsec_1.7.7.bb b/recipes-ids/crowdsec/crowdsec_1.7.7.bb
index 0697022..356c227 100644
--- a/recipes-ids/crowdsec/crowdsec_1.7.7.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.7.7.bb
@@ -1,7 +1,7 @@
 SUMMARY = "CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network."
 DESCRIPTION = "Open-source and participative security solution offering crowdsourced protection against malicious IPs and access to the most advanced real-world CTI."
 HOMEPAGE = "https://www.crowdsec.net"
-LICENSE = "MIT & CC0-1.0"
+LICENSE = "MIT AND CC0-1.0"
 LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=1e58fe4126ce0b50677f3aa6ba8e13c2 \
                     file://src/${GO_IMPORT}/build/windows/Chocolatey/crowdsec/tools/LICENSE.txt;md5=4d249f04094c9fb4d2b6fd2b1127e219 \
                     file://src/${GO_IMPORT}/test/lib/bats-assert/LICENSE;md5=7bae63a234e80ee7c6427dce9fdba6cc \
diff --git a/recipes-mac/AppArmor/apparmor_4.0.3.bb b/recipes-mac/AppArmor/apparmor_4.0.3.bb
index 9983157..76025bd 100644
--- a/recipes-mac/AppArmor/apparmor_4.0.3.bb
+++ b/recipes-mac/AppArmor/apparmor_4.0.3.bb
@@ -8,7 +8,7 @@ DESCRIPTION = "user-space parser utility for AppArmor \
 HOMEPAGE = "http://apparmor.net/"
 SECTION = "admin"
 
-LICENSE = "GPL-2.0-only & GPL-2.0-or-later & BSD-3-Clause & LGPL-2.1-or-later"
+LICENSE = "GPL-2.0-only AND GPL-2.0-or-later AND BSD-3-Clause AND LGPL-2.1-or-later"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fd57a4b0bc782d7b80fd431f10bbf9d0"
 
 DEPENDS = "bison-native apr autoconf-archive-native gettext-native coreutils-native swig-native"
diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/recipes-perl/perl/lib-perl_0.63.bb
index f0d6832..c0fb43a 100644
--- a/recipes-perl/perl/lib-perl_0.63.bb
+++ b/recipes-perl/perl/lib-perl_0.63.bb
@@ -5,7 +5,7 @@ will find modules which are not located in the default search path."
 
 SECTION = "libs"
 HOMEPAGE = "https://metacpan.org/dist/lib"
-LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
+LICENSE = "Artistic-1.0 OR GPL-1.0-or-later"
 PR = "r0"
 
 LIC_FILES_CHKSUM = "file://README;beginline=26;endline=30;md5=94b119f1a7b8d611efc89b5d562a1a50"
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/perl/libwhisker2-perl_2.5.bb
index e16e5f2..94b2384 100644
--- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
+++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
@@ -1,7 +1,7 @@
 DESCRIPTION = "Libwhisker is a Perl module geared specificly for HTTP testing."
 
 SECTION = "libs"
-LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
+LICENSE = "Artistic-1.0 OR GPL-1.0-or-later"
 
 LIC_FILES_CHKSUM = "file://LICENSE;md5=254b8e29606fce6d1c1a4c9e32354573"
 
diff --git a/recipes-scanners/clamav/clamav_1.4.4.bb b/recipes-scanners/clamav/clamav_1.4.4.bb
index e9c2aca..b3f14cd 100644
--- a/recipes-scanners/clamav/clamav_1.4.4.bb
+++ b/recipes-scanners/clamav/clamav_1.4.4.bb
@@ -1,8 +1,8 @@
 SUMMARY = "ClamAV anti-virus utilities and scanner tools"
-DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
+DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware AND other malicious threats."
 HOMEPAGE = "http://www.clamav.net/index.html"
 SECTION = "security"
-LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
+LICENSE = "GPL-2.0-only AND LGPL-2.1-only AND BSD-2-Clause AND Zlib AND Apache-2.0-with-LLVM-exception"
 LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
                     file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
                     file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 0952ed1..9b33ce9 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -8,7 +8,7 @@ depending on the mechanism. \
 HOMEPAGE = "https://gitlab.com/gsasl/libgssglue"
 SECTION = "libs"
 
-LICENSE = "BSD-3-Clause | HPND"
+LICENSE = "BSD-3-Clause OR HPND"
 
 #Copyright (c) 1996, by Sun Microsystems, Inc.                   HPND
 #Copyright (c) 2007 The Regents of the University of Michigan. BSD-3-Clause
-- 
2.55.0


