Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C1CCCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 12:13:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.6542.1760616827809927731
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 05:13:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VfKX36Uo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so3495055e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760616826; x=1761221626; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PQCb5lbUC0eG1M5176tvM1M/UOHIJQwEfKGUYTroxI=;
        b=VfKX36UoXuTQRUP7hUgJum4K52bCFs5sHwL8phC2WzfPE67sB6uutlpVUtNo2naD05
         +CHsqPTUO+tRjZm9aq4NO6FFGnY4KF6vZ4GmwGIIjCVrkGjtApogmLqd+HX3mTLFSFE2
         cDP9e/JHO8t9Kq51ehjNJspAHbM1AfS06d1IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616826; x=1761221626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PQCb5lbUC0eG1M5176tvM1M/UOHIJQwEfKGUYTroxI=;
        b=SqKSKf9PqhfhUfmTQuKDIX6wj324eSnfmBy9DChvlSrt8rTwe6fPsQBKyfZrFeTM8C
         1JwTplmbiEIClxSML2icoSdsd9pzcaosNKZn9bDYZthdNV/jvnqTXvnu1FplQjufDej5
         77K5Mk2Kc0cko206WkRXPc9P7lHkBGHW5QxZhuPBESu6OJN4UArXOgQuKeIVatLQTgLe
         31YA4IIZOTWCuN0e9Hd6JR/rqMI/bDKonDDUeX2p/BpWwOwQClP/4/FEmrXafr0ytY6C
         m1DaeylWcvJiTYvYfLZAgUG9zXDc4POrOV0uav1DuwtpUYIFXb18GB1xh0I6HIJRRv5Q
         HEmA==
X-Gm-Message-State: AOJu0Yw92d5irSfBUJfAdc+n3K+wtQ7lKE/aPCDkJhWpQwVnqJQBLYkF
	C7509UKmuqvo1rc+HMuHq/n0ZfhibMDZKLkMOXR+7GnWAfVAdz9tBIy+emu66N5hN+8ZuwEQUXe
	VHJGS
X-Gm-Gg: ASbGncs8beqHPJSWFVAe2z8nMMVpLtMeNPQuK4MW091ZinXNqZf32xc9FOOPumtKucJ
	Vp/O9+ixpHpZL8r24josxiFwt8swvsoeJKkUTdIeiw+oqxB+jwvqEAUdRd3nhaiNTawPtnB7sHL
	guF8YlHMclogAbe6OQBP8GgtAX04pQaUDZ6EEgdDDJ+MzzLuJXsJ9+IFvTyK1wa9a2iQzewGufj
	MDTvAQLiPDdgIwYGQGjwFlqCiGnoJBgsE4qr87oCHOS8S8P3uBzL/ADh5BVPqHg7qsqyCilDzBm
	JQVv5lR3soasHRxivShsQJCrzHLF1nS3m6p9OKmCmjeFHQWnsQhPkJO+qKFQMyGzcfzps8uN8pS
	AxkNXVRFbWx/l1aj7fF81vaclIVomNLqjzVRVQPWjSIMRE7ZV9so6KLngxYA3PXbCDKi2uBTqTB
	ap1r1SnGckMl7Lp6u622uZwtZ3zmS8Qp+/I5Oz7to=
X-Google-Smtp-Source: AGHT+IEggTUMO+uTeLsqw1h8t8AApIFH4+4WG016N17dJ5vn9HwE/kEF+7drWeDTacyx2m4oGFyV/Q==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr234913285e9.36.1760616825596;
        Thu, 16 Oct 2025 05:13:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5c57:ae18:7f42:815d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm34767266f8f.37.2025.10.16.05.13.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 05:13:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json/scripts: Fix toaster execution with bitbake-setup
Date: Thu, 16 Oct 2025 13:13:43 +0100
Message-ID: <20251016121343.959160-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 12:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2312

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json               |  2 +-
 scripts/run-toaster-tests | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.json b/config.json
index 00da369..ce019ae 100644
--- a/config.json
+++ b/config.json
@@ -1776,7 +1776,7 @@
 	    ]
 	},
         "toaster" : {
-            "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/.."]
+            "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
         }
     },
     "repo-defaults" : {
diff --git a/scripts/run-toaster-tests b/scripts/run-toaster-tests
index 014c714..de056d0 100755
--- a/scripts/run-toaster-tests
+++ b/scripts/run-toaster-tests
@@ -3,7 +3,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Called with $1 as the build directory
-#             $2 as the path to poky
+#             $2 as the path to bitbake
 
 set -e
 set -u
@@ -11,7 +11,7 @@ set -o pipefail
 set -x
 
 builddir=$(realpath "$1")
-pokydir=$(realpath "$2")
+bitbakedir=$(realpath "$2")
 
 cd $builddir
 
@@ -28,12 +28,12 @@ mkdir -p toaster_logs
 
 python3 -m venv venv --without-pip --system-site-packages
 source venv/bin/activate
-python3 -m pip install -r $pokydir/bitbake/toaster-requirements.txt -r $pokydir/bitbake/lib/toaster/tests/toaster-tests-requirements.txt
+python3 -m pip install -r $bitbakedir/toaster-requirements.txt -r $bitbakedir/lib/toaster/tests/toaster-tests-requirements.txt
 
-python3 -m pytest -c $pokydir/bitbake/lib/toaster/pytest.ini $pokydir/bitbake/lib/toaster/tests/
+python3 -m pytest -c $bitbakedir/lib/toaster/pytest.ini $bitbakedir/lib/toaster/tests/
 
-if [ -e $pokydir/bitbake/lib/toaster/orm/fixtures/check_fixtures.py ]; then
+if [ -e $bitbakedir/lib/toaster/orm/fixtures/check_fixtures.py ]; then
     echo "Checking toaster fixtures"
-    cd $pokydir/bitbake/lib/toaster/orm/fixtures/
-    $pokydir/bitbake/lib/toaster/orm/fixtures/check_fixtures.py
+    cd $bitbakedir/lib/toaster/orm/fixtures/
+    $bitbakedir/lib/toaster/orm/fixtures/check_fixtures.py
 fi

