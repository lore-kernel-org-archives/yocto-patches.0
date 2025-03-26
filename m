Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC648C3600E
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 17:08:20 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.28102.1743008896737233486
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 10:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bJR6w1PR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so7308915e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743008894; x=1743613694; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k41iQpmLSEzUHdhxLEO9KRPVpfsiNNM8m9xDo+3AoGw=;
        b=bJR6w1PRUFMR9kopDL8OgRUXL2QnoIh+KKsjNikOTh2vX7AR0wwlP+sREGZBN69D8n
         wrLGID8395g9tZ0HFw9zTqSuef4PZlxGaDAK2YTMn9enXgI2GskF9Ao0bpw9PHrAQKkR
         cpSa5iS5tRAu43aNM3lvWvs6hkchkgosCXOkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008894; x=1743613694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k41iQpmLSEzUHdhxLEO9KRPVpfsiNNM8m9xDo+3AoGw=;
        b=irL4qp0lUY4bCwVNXiF9+x7aUDHThR9uqG6d0MVHc0y8kIsyu1pIz9FA3UwnCghRWw
         HbE4nycaHJJjABiuhsYiyTkgnNMAKwfDKMmhs33Z4jVEkdgor36ex5ghFBG1GxePYMGK
         n53NoJSErw3QWOty7Lou/IoF111xy6Z8Tolow9EYltQ4CsoOsJXYQethqLHcf9ATF0DT
         rcVWn01yyyPXMoji8o0gRcmhjUBZSiP6w6XApickRp7YdBYEn3mrxmnkK9NuWuGEmbJN
         QRvkShQiz4T1W+9yUpi7FJGTd+KP0gEy0QO3LnqmNBHpfvuPJJobwApcfVQrBkK0sLm9
         UrKQ==
X-Gm-Message-State: AOJu0Yyqym4KVPowdBmzcN7kmMNKKUwSLD+mMAz33H3Ok8ZtuDK1NIgk
	bobd3cCsvjEILjuMfZ6KIxi7wd2zDYZGXuQ1YxcjjiK6nNUEiK9cjUhNJoTFEj9BND2/65P+9uK
	f
X-Gm-Gg: ASbGncvJYZ7QnGyUbzoN6l9JWm2SC4/lMEcMkytMC04RTSA8UBycTBlxOjy3RsNRF2R
	/T28M36eLioKAdOltPigQAH+y5UdKWv1GrGcQvEOOWEQ8SQ8nSgu0YGTtuF8Lt8xhlQw3jFuU1G
	dHs6zuB6+mHKyh7lpvVxNJxjti3pznTks4PJP6veERm1gzyJpLfO2xl0lsJjX4EP7arbDGSC4pN
	yrr+2G9Tt0Rx+SAAaexEC2Npi5uoSBf9aM8lKKOdxUz/WnlTxhMP21ntV3K7craOlExjvi/jEDf
	qXpw3BXS6p93Q+UDTu+sNmfdEuDAa+VbYSF9npO6Uq79WJ3FEDdgeJqbNMi7I9i/euOlO+YnuA=
	=
X-Google-Smtp-Source: AGHT+IH8+wQX/RGtlDr7vea2v5fVTQyAzzIa6B5uWZS5YVfNR3ZImjF/0ahEd3WHCk+pGTbUeTRsMw==
X-Received: by 2002:a5d:5f91:0:b0:390:f116:d220 with SMTP id ffacd0b85a97d-39ad14f8057mr560108f8f.17.1743008894325;
        Wed, 26 Mar 2025 10:08:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc90sm17620570f8f.98.2025.03.26.10.08.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:08:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/3] config: Move non-gpl3/ederouter to kirkstone only in triggers
Date: Wed, 26 Mar 2025 17:08:10 +0000
Message-ID: <20250326170812.840424-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 17:08:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1259

We only run these targets in kirkstone now. Update the targets so they don't
trigger at all on more recent releases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/config.py b/config.py
index be3829f9..47d51323 100644
--- a/config.py
+++ b/config.py
@@ -85,14 +85,13 @@ trigger_builders_wait_shared = [
     "qemuarm-oecore",
     "qemux86-64-x32", "qemux86-world",
     "multilib",
-    "edgerouter",
     "genericarm64", "genericarm64-alt",
     "genericx86", "genericx86-alt",
     "genericx86-64", "genericx86-64-alt",
     "beaglebone", "beaglebone-alt",
     "pkgman-non-rpm",
     "build-appliance", "buildtools",
-    "non-gpl3", "wic",
+    "wic",
     "poky-tiny", "musl-qemux86", "musl-qemux86-64", "no-x11",
     "qa-extras", "qa-extras2",
     "check-layer", "meta-mingw",
@@ -107,7 +106,7 @@ trigger_builders_wait_quick = trigger_builders_wait_shared + [
 ]
 
 trigger_builders_wait_full = trigger_builders_wait_shared + [
-    "qemumips-alt", "edgerouter-alt", "qemuppc-alt", "qemux86-world-alt",
+    "qemumips-alt", "qemuppc-alt", "qemux86-world-alt",
     "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-fedora", "oe-selftest-centos",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
     "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "qemuarmv5",
@@ -117,16 +116,18 @@ trigger_builders_wait_full = trigger_builders_wait_shared + [
 trigger_builders_wait_quick_releases = {
     "master" : trigger_builders_wait_quick,
     "scarthgap" : trigger_builders_wait_quick,
-    "zeus" : trigger_builders_wait_quick + ["mpc8315e-rdb"],
-    "thud" : trigger_builders_wait_quick + ["mpc8315e-rdb"],
-    "sumo" : trigger_builders_wait_quick + ["mpc8315e-rdb"]
+    "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl"],
+    "zeus" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
+    "thud" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
+    "sumo" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"]
 }
 
 trigger_builders_wait_full_releases = {
     "master" : trigger_builders_wait_full + ["meta-clang"],
     "scarthgap" : trigger_builders_wait_full,
-    "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb-alt"],
-    "thud" : trigger_builders_wait_full + ["mpc8315e-rdb-alt"],
+    "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"],
+    "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"],
+    "thud" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"],
     "sumo" : trigger_builders_wait_shared + ["qemumips-alt", "edgerouter-alt", "mpc8315e-rdb-alt", "qemuppc-alt", "qemux86-world-alt",
                                              "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-centos"]
 }
@@ -155,6 +156,8 @@ builders_others = [
     "yocto-mirror",
     "meta-oe-mirror",
     "auh", "auh-meta-oe",
+    "edgerouter", "edgerouter-alt",
+    "non-gpl3",
     "meta-webosose"
 ]
 

