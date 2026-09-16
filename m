Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE55C982D4
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27124.1789597843554848814
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Xb5j0fRr;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa8so14110485a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597842; x=1790202642; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nxim3a4uS7qQY4yadJJq9KxrWWqnylWA5gBiMArwS+A=;
        b=Xb5j0fRrm0eON/+q55TvJpphSEz/1e9KNYpLrZDMW6i07+CcFOCacnp90ZytZYwG5J
         1xCjB9MzWbgfRnSpDfdG67l1D1H/L6vEX1gVZ0rpHQtMBeA87ZgnbgZujmdsSTpxJ4qV
         3h6+n61r/TExCdzrluP6fc4RJGrYitnKbZ2CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597842; x=1790202642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nxim3a4uS7qQY4yadJJq9KxrWWqnylWA5gBiMArwS+A=;
        b=lTuktWb3VJATV08AHZFU+31eAOISs8LUjz0lMP3hTTntDCatqwX3lsAdLwXsApPM6R
         7/qYlmivU3dQPKxsULYGvvkVa6+ac8oaM7xv3MCKh6EEKOXeGwTDSeD8kpoEk+/SU+mc
         eZejmFavxOEXdSPfDqlH/rPRcDthl3qrAbUjBQsSnzky4PNAuG/WblSWu+WAHHC7wby1
         sCkWPF1ujOt15gbrP+h594mSrNLJQr6jp9rHh4CKON5aESFLfPoNrQ9NunrTmPKDe71k
         V9A/JSyp0ivqEzAxPQS067+FCeVahUgj72LCX9uG84Z3ja6IoWyFkci1EOE5kbr4U19I
         v2KQ==
X-Gm-Message-State: AFuF++ki4d9FgdS/RmTdqKQndlh+bOsAboklz8+pv+RwROcUxCOV2NBF
	fFtcbRf02JVavRV3BehKs41W++LobrEEL4fnURTRF1BcoajwhCkVf+t6M18bSnahPAc1jg4pQuI
	ktII2
X-Gm-Gg: AYBFou37lJAdSpo6ylE+2T81j6bGBeMw+0KgLUp/sTLP6WRccJSTLcVMK+yH5d0NNFT
	Be4MCn9dVC3KOqvCg+zDZt5ngvEBBcuuYRYH2Vd1lYBbnfef+y/ZmqYCTajep4ZBJiQmEfO3AM2
	tYyEUTUbFx7w0LHTSuNoODUtwsSZQ1pOTDtc77Rcr9pOh2UnCStTymMA3me6r3hJXwCAZJXsnNM
	xumSWcI0/sw8dg6RVfZp7Et/EsJAQHSArMjoqegnNfkh6/04X5sF0X4C21tseQsvpj2yLLWmELK
	RXq/eSfFVMRgFLCZHsdSjXgcudG5slI8rtUqYeE/BUDhsuqqvyRBZHbW5IOOzHgZaizq5d4a4Zf
	m5IxOv0ewnlQnw7TsB5LSpLoh4F/Na0o4UZEcDc1HP/kxXl0NjF1NsaziUFuPkJaUII/UNnHnES
	L72AClckGrmvPSaqRFAFWqxRUpf5bq7/cDHEAG/QSz9S78mfLFu69nM9UyMspKpoppnXl/MNQKt
	FKnXwWsRAFNnf4s4A7P9ggOE7KUAIlmgxB37OmAwEPOdlmPZ/SZkRMC5dn/WVd/bqCz5ESU1ho2
	C713xn7RChfJph7X77nco/fckVf1UzAP+U1Tf357xMNtaA==
X-Received: by 2002:a05:620a:4410:b0:93a:251c:5337 with SMTP id af79cd13be357-93bb76a8322mr854390485a.4.1789597842372;
        Wed, 16 Sep 2026 15:30:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 12/24] openscap: upgrade 1.4.3 -> 1.4.4
Date: Wed, 16 Sep 2026 18:30:06 -0400
Message-ID: <2596106b0980963b08727600b8d29ceac7028199.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4888

Release notes:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.4

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb}         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-compliance/openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.4.3.bb b/recipes-compliance/openscap/openscap_1.4.4.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.4.3.bb
rename to recipes-compliance/openscap/openscap_1.4.4.bb
index 1b6d9af..34fcf47 100644
--- a/recipes-compliance/openscap/openscap_1.4.3.bb
+++ b/recipes-compliance/openscap/openscap_1.4.4.bb
@@ -11,9 +11,9 @@ DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native
 
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
-          "
+"
 
-SRCREV = "24986066961363e24fcff83294995b3cfe4058ba"
+SRCREV = "4ac56ce0e6dfdea7215b5ad202b3db20855d2507"
 
 COMPATIBLE_HOST:libc-musl = "null"
 
-- 
2.55.0


