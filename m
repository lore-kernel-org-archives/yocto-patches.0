Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C46CAC5B0
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 04:50:32 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.46641.1759121422286795612
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Sep 2025 21:50:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=cwt2zAyo;
 spf=pass (domain: mvista.com, ip: 209.85.214.169, mailfrom: vanusuri@mvista.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2570bf605b1so44221355ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 21:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759121421; x=1759726221; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXK/kAgRvuttv8n6eoE9uUz743wIUr/8mSpKgiRbvOI=;
        b=cwt2zAyofDS7Wm6mShcUlXEYPINv88Hh45sD2LR/7BuinybJnM4iv2E0URj8JkAiD4
         JVVff/LUxgjAyezFxR+WlcW7kE5pP+ZNuIOQIBtCpmv+P/SDftluZmDFgB+Kx99BVFxG
         Q+XTmPDH8OaYnm/SBsF0EnbD7KwOwojCPJt5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759121421; x=1759726221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXK/kAgRvuttv8n6eoE9uUz743wIUr/8mSpKgiRbvOI=;
        b=Jm4G4FDedak0YAaLJD/08++pv54jjoTFrAzV4A5Zb4PV3cOtx+llSSk9eKXQ2C6LiC
         lIq7eUw4vauNODEeoHyVPS6qqKJ6KNK3oTINp+tWiUtAQV/ley0zhDnwlcwPp/vWjNlB
         vf4eN72n0taC227k0lKhncKoKwLeFfAXv0eQpDj5wf6tx54rk6V3Udfh1f3M4gFMUSNN
         cB8+d7tkM6eQgVFVig4k0M0DcLjLB0JH5KBx69ejYFHakz8VLSvl3xg9miIvECZaaXpA
         OtoYdhJYeggxQxKrbjbpkuYBkbfsJVxrClKMC9pr6wLtzXUy9ucDcFuBQrEgQ8Tw5HWQ
         kCHQ==
X-Gm-Message-State: AOJu0Yx75JOb+vC00C9nbMd5U4bXkbWDv7IfvQpFd+ie3U4yqQYltAlF
	SZIGYgAX8V22XEvNPPGquBUSi8Q4fdxJREx75RFwjGko9cyMfCgMGA9wNPknPHIufXaobICPBdP
	MRH5l3Uo=
X-Gm-Gg: ASbGncsfTLBRuRFSqd4oM6zLZPPBfWRZUyDQ6tY10/mKfXgIT0OvrnMiYcCNANVstIk
	S8JhhYnDZUQ10K6hxBCidrI7Xy73I0Gk9zhtxbze49fCXlKizJcbyA+PRX0CuYEkAlphqni3Ohz
	F+wiQff20IQE4pDMx9BM8v6VWKr5v+c4P8WZIblcAETYwrK/5B/rVzlcX5FAydph5HUPXatjZsf
	twPLbsgxvU5GMg6T/JTJQKrFwOMlfwFqx0hoLiLS1J8n8abnpKaWuuMrsb8gMTdZPVsswtu+Cb5
	J/YrsBP4tbYfflvQG9Z9NiR+4pYRE5DSoGwkcVVoqGCCET/Czhgp4PYZUfl0SrUsa23KfVnVoqP
	amECjNU5uVtcgk0+KnpG2V4Fr6FtqiUBhhEnXUtwIQlF58evL
X-Google-Smtp-Source: AGHT+IHFJAto/22RADU2FI+czC9+xPSQ1LiJKVre22aJa0dR7b/uUHMC/QWZx/denbM1cyB6msoCBw==
X-Received: by 2002:a17:902:f611:b0:271:fead:9930 with SMTP id d9443c01a7336-27ed4a78d72mr167400815ad.59.1759121421309;
        Sun, 28 Sep 2025 21:50:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8fcc:87df:9a55:2ec0:d047:5e02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm114277635ad.112.2025.09.28.21.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:50:20 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH 2/3] racoon2: Fix contains reference to TMPDIR [buildpaths] warning
Date: Mon, 29 Sep 2025 10:20:06 +0530
Message-Id: <20250929045007.12623-2-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929045007.12623-1-vanusuri@mvista.com>
References: <20250929045007.12623-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 04:50:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2247

From: Vijay Anusuri <vanusuri@mvista.com>

Pass OE cflags to makefile

ERROR: racoon2-202003018-r0 do_package_qa: QA Issue: File /usr/sbin/.debug/spmd in package racoon2-dbg contains reference to TMPDIR [buildpaths]
ERROR: racoon2-202003018-r0 do_package_qa: QA Issue: File /usr/sbin/.debug/spmdctl in package racoon2-dbg contains reference to TMPDIR [buildpaths]
ERROR: racoon2-202003018-r0 do_package_qa: Fatal QA errors were found, failing task.

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index 211b911..c3ebd5d 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -33,8 +33,6 @@ SRC_URI = "git://github.com/zoulasc/racoon2;branch=master;protocol=https \
           "
 
 SRCREV = "7b68950328454b0e91ba24698c10c4a790705cc1"
-SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
-SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"
 
 inherit autotools-brokensep update-rc.d systemd
 
@@ -52,6 +50,8 @@ do_configure:prepend () {
     mkdir -p lib/m4 spmd/m4 iked/m4 kinkd/m4
 }
 
+EXTRA_OEMAKE += "CPPFLAGS='${CFLAGS}'"
+
 do_install:append() {
     install -d -m 0755 ${D}${sysconfdir}/init.d/
     cp -rfa ${D}${sysconfdir}/${BPN}/init.d/* ${D}${sysconfdir}/init.d/
-- 
2.25.1


