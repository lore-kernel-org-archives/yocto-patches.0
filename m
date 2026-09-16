Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF9C982D6
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27094.1789597847757605197
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VPkKo+Tr;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so14203585a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597847; x=1790202647; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y7U3Ykl1YFj5VD4pZsIw6pEtrP659jV/JkmKkpBI81c=;
        b=VPkKo+TrJsHe3ApXP0hC/Q6um6ATWvPXaPgkVdfXwjzIIwM3xKJf8Qojrhuh0NFMAT
         N3F17IiKzC91kTNRHoUdM0ZnR4xFQ76GCDCr0yQ+sfqjenzZz1kzM+h1osc/c65qEEZO
         QYadaKDEe/OB+im+cDgY77DO8BdE0kT8Dn9s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597847; x=1790202647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y7U3Ykl1YFj5VD4pZsIw6pEtrP659jV/JkmKkpBI81c=;
        b=ggI5flADAy1H5dN/f6Uxlm8rMxR2MNqz6LZ2yvDa0sgeVF8Nguel0lz3fgCasihsf4
         +LhbZvnK+EYnAhTaSeB5UIqIRuKGaFwXYGP3KnwhC0bJF16QVyJWQI4GuXWFeGOF/cj+
         50I7T3Jr4cpxZDJBvJoIL5eBSPVmBz2Jg8G/qe9/eo5/czOvQOibYWXa/BXmE2OVHaMg
         qpQ1M09ubmfXsXCWlFZqGMgEtMh6h2BE9OVXBSevDvzcptdY4rFfrxQQOwt6Oq8dxbZV
         OliAoUdpx7Fm8H3uYjNBm2zenAswhMjDhy2+Ocpv2F6Btnx7IuNonMeMy76xaK3SjqwW
         2Bag==
X-Gm-Message-State: AFuF++mGvoPQEvn3MV2JDaNnvmRk1Yo6d5QLS+xm5pdfdj2EqFJsIPye
	Xu8m1fqpD8o4AHZdfJ5gY5XK5lnjA3FAhKJvXMAYpVD3dP+TuWMCcze2rF5LxgujrTW3yTOeeAt
	A9rWh
X-Gm-Gg: AYBFou3x3PxMBucMS1077ubdx3PQTh8yO5r3lbcvDwQehwrdO8wu98IrxAdZ3c9N4Ei
	bnfk42ztJZOrDdeh5OaBMCkELIs/nDYz3naSJyQkRRfCXANoO6pGo4mUjpop9kdl5aL11DS7u3F
	kQ0VC88AsyJ1xtZz66d+Pwr1I8kd8Xk9t3SIuqi5C+YhQqotG4g44do1CQjIOOuiaoGiNjuoZ8R
	E8j7DRQu/wjeZVv8lTqxDRroD+3IruFkmxPUerajpguwgGFs6juTdFTlQFLDdSwQ5qBYL/Eucww
	cx/AvkWRjxRgeJwOBZbmg0j6m/xBe0xAcqR46wq9GHZKeBWeGGtJZlhNN8mvYr3yx1hB3H9TkCE
	FgDMwXSVzukhWiPrOVrdVGENck5OKuKOTKJHE6CAWif3G9ErT/aZPOfPLAT/jbFGcyylUjPrk5M
	u/b5XGigLD/rY9WAGLITP4gH1BQJUJCFjx5YWTZ98JrA1HCtbGEVCu5oAQ4FLvSmkNIIBw4bofb
	RAu87i6X+tphz6rNGjZxJmALULE/Qtd/lafHADIj6kupyZy3sJK6WFRt0UojQXwm1SA8dtgRH2Y
	L06/1jE/SHNLYnIrbNTmlInA90LiIdYghDY=
X-Received: by 2002:a05:620a:2911:b0:939:cb1a:2c5a with SMTP id af79cd13be357-93bb78961d1mr760401985a.31.1789597846583;
        Wed, 16 Sep 2026 15:30:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 16/24] ossec-hids: upgrade 3.7.0 -> 4.3.0
Date: Wed, 16 Sep 2026 18:30:10 -0400
Message-ID: <0e9a9bcb8c3ce17a933fc9c5dce334b9b5b8ec4b.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4891

Release notes:
https://github.com/ossec/ossec-hids/releases/tag/3.8.0
https://github.com/ossec/ossec-hids/releases/tag/4.0.0
https://github.com/ossec/ossec-hids/releases/tag/4.1.0
https://github.com/ossec/ossec-hids/releases/tag/4.2.0
https://github.com/ossec/ossec-hids/releases/tag/4.3.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../files/0001-Makefile-drop-running-scrips-install.patch  | 7 ++-----
 .../ossec/files/0002-Makefile-don-t-set-uid-gid.patch      | 7 ++-----
 .../ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb}     | 4 ++--
 3 files changed, 6 insertions(+), 12 deletions(-)
 rename recipes-ids/ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} (99%)

diff --git a/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch b/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
index 08e018f..7b1600c 100644
--- a/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
+++ b/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
@@ -1,7 +1,7 @@
-From b948d36a8ca8e04794381f0f6eba29daf7e3fd01 Mon Sep 17 00:00:00 2001
+From 1035c4363148a831d2659bd88ac9d299cd6bd38e Mon Sep 17 00:00:00 2001
 From: Armin Kuster <akuster808@gmail.com>
 Date: Wed, 21 Apr 2021 00:56:53 +0000
-Subject: [PATCH 1/2] Makefile: drop running scrips @ install
+Subject: [PATCH] Makefile: drop running scrips @ install
 
 Upstream-Status: Inappropriate [embedded specific]
 
@@ -32,6 +32,3 @@ index 06a7094c..dfb8cb58 100644
  
  install-server-generic: install-common
  	$(call INSTALL_CMD,0660,${OSSEC_USER},${OSSEC_GROUP}) /dev/null ${PREFIX}/logs/active-responses.log
--- 
-2.25.1
-
diff --git a/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch b/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
index d5e3403..fdbe49f 100644
--- a/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
+++ b/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
@@ -1,7 +1,7 @@
-From d9ec907881b72d42b4918f7cfb46516ce8e77772 Mon Sep 17 00:00:00 2001
+From 9572062689514907fb613e0bad2cab2489141f92 Mon Sep 17 00:00:00 2001
 From: Armin Kuster <akuster808@gmail.com>
 Date: Sat, 24 Apr 2021 23:07:29 +0000
-Subject: [PATCH 2/2] Makefile: don't set uid/gid
+Subject: [PATCH] Makefile: don't set uid/gid
 
 Upstream-Status: Inappropriate [embedded specific]
 
@@ -246,6 +246,3 @@ index dfb8cb58..a4d69ef6 100644
  
  	rm -f ${PREFIX}/etc/shared/merged.mg
  
--- 
-2.25.1
-
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/ossec-hids_4.3.0.bb
similarity index 99%
rename from recipes-ids/ossec/ossec-hids_3.7.0.bb
rename to recipes-ids/ossec/ossec-hids_4.3.0.bb
index f8ee993..0bff94a 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_4.3.0.bb
@@ -5,9 +5,9 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=d625d1520b5e38faefb81cf9772badc9"
 
 DEPENDS = "openssl libpcre2 zlib libevent"
 SRC_URI = "git://github.com/ossec/ossec-hids;branch=master;protocol=https \
-           file://0001-Makefile-drop-running-scrips-install.patch  \
+           file://0001-Makefile-drop-running-scrips-install.patch \
            file://0002-Makefile-don-t-set-uid-gid.patch \
-           "
+"
 
 SRCREV = "bf797c759994015274f3bc31fe2bed278cce67ee"
 
-- 
2.55.0


