Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A3C3DA4A
	for <webhook@archiver.kernel.org>; Sat, 10 Aug 2024 16:26:50 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
 by mx.groups.io with SMTP id smtpd.web10.8677.1723307206385098593
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 Aug 2024 09:26:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=acuG41w7;
 spf=pass (domain: gmail.com, ip: 209.85.219.178, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0bf97a2b96so2927198276.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723307205; x=1723912005; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMNIMTC9K8dsuSOQkYCb+Ps0+EHDrjiAgKzeBh8g08c=;
        b=acuG41w71G4var8mTlJwuMFaly4VJhGRI/16/D5B8NbeOlSBKhs+EGdZFdBUq7enhy
         kA4pySfOVHJLfidC9id9XTko7kw/8QMoNk0s1JFULjTR3HV2wJomuXK3r14xDsyAGTUB
         SkJn0G4Rq/5BX4bEKAAv3V3xjfheWai87ZiKjhoEphJX0bhQeC2AoF80j1Wl8efgL51i
         2QfHM2aBlRr8FkeY8X0eBhKb24UySLOAaxEwPS/7WFK2TKsaIA4R3ik+IEDueSzFQn6D
         ufXuKxjETWO1cCgPTsVZ1BhMwF0PNfr2UMtOXVRGiBttyytuyaLRHhSHr1wdXhLAks29
         AK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723307205; x=1723912005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMNIMTC9K8dsuSOQkYCb+Ps0+EHDrjiAgKzeBh8g08c=;
        b=i3bpbHFM9YpSPVp2KWfK4dHpCjo6QJ4AKVIKUOIsVv2eDyECwXURwD5iZhlpWLn3zO
         m9FyzChnw4GFgIam8RAVAkkWbTGTAwE0VnzS0DLObnDrnXKOU0aaNKVY0eCxFLEIF1pB
         Aj5TFlJzFgKonnDmYqpho9m8KRIRbllUWKpGCU6nBBDXKLdXuygh1wdKyk4cqtRWP4SC
         ZipldH/UjWe2hAwQDaVcY4R3IiJw8MsuN7WVsRCRkkdcQdPILyLRkhyPUCLhngmdplZc
         TSrm83J/wdcqYvn+56eFwclbg5KLNSlpfGhmeNdKAchluywDV0T82zXcio7G2iqUuLcz
         qrGQ==
X-Gm-Message-State: AOJu0YzhV/W5xfauBKnx4OlMT7Gy2pcEFD/lqnmz3EKie+ni5FXJ8AYe
	2dzozD3oGO+6tCdPjfumhCzTUvGg54orrAXNpSfJvPNkv/LltoOqnPp7rA==
X-Google-Smtp-Source: AGHT+IHvWo2zBJ4pJt2qWDzxjZi31CR+wXJAUYDGLa3AWJh4nstWw5t2xkfUfdkbPMAnr3o3Iu7KyA==
X-Received: by 2002:a25:33c6:0:b0:e0e:ce6c:4972 with SMTP id 3f1490d57ef6-e0ece6c5381mr1517646276.15.1723307205386;
        Sat, 10 Aug 2024 09:26:45 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:ad:eb2b:7538:7504])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8c78bbcsm393393276.52.2024.08.10.09.26.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:26:45 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] python3-privacyidea: switch to PEP-517 build backend
Date: Sat, 10 Aug 2024 12:26:44 -0400
Message-Id: <20240810162644.901927-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 16:26:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/516

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../recipes-security/mfa/python3-privacyidea_3.9.1.bb       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.9.1.bb b/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.9.1.bb
index 8268345..36e50e4 100644
--- a/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.9.1.bb
+++ b/dynamic-layers/meta-python/recipes-security/mfa/python3-privacyidea_3.9.1.bb
@@ -8,7 +8,11 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=c0acfa7a8a03b718abee9135bc1a1c55"
 PYPI_PACKAGE = "privacyIDEA"
 SRC_URI[sha256sum] = "7c70feb44980a3fd7501457777a1ec30e73541e54d3b31f2b9b5ab6cd73cff4f"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
 
 do_install:append () {
     rm -fr ${D}${libdir}/${PYTHON_DIR}/site-packages/tests
-- 
2.34.1


