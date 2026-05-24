Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15DECD5BCB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:17 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7241.1779625693795382164
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WkzxWwsB;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-913cc4d7c71so953077385a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625693; x=1780230493; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv4UUnR3CEywTtSlxqi3XVTdZHncafDQ4ZcWkOeH6UA=;
        b=WkzxWwsBJowsiGcXxwzXY+A3HY9CZLEeNqH9nUh+/OfCFWsj+4f8GjW82uJUTwuitz
         BVnXvcyZc/nZw/kFx/MsoSIMW8pq4drSWXD2Cnb2xAALESonv2O60yenzSgYc3vf/7ig
         cH0dlH2/1uWV0jlP/SPcFeldCulda2y28xM+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625693; x=1780230493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tv4UUnR3CEywTtSlxqi3XVTdZHncafDQ4ZcWkOeH6UA=;
        b=ZgX1rgtvLtOTBM4os6+CCG68dXrnPIw5sG9wl00h5x9uj2mGlx3Gp14I5kfP3sztvz
         R8X665Gu3ZpS0CmUUSA0Olv3WprjUs+zwMQYoeMrP09MkqGr/VAoSwfLeHefsaTz2M5J
         7aj73vYc4c+dsD9o3ubJ/eIGDQJIi+J8B0FOVh1d3w6AT/vsnoNSvEBONzNfStL1mCmY
         AZdcFLAlfDGycnpVSSuXOns8SqibVTBWDCIjAv7qgSEuyY34YiitOy5x/A94QPJ2AvXS
         mcdDAXDkSgYT0R0qX2f2y5Wqx5i8yTbj20sKPAGAM/PfXrrb7nNl68RPsawEwCwTOjAw
         sppw==
X-Gm-Message-State: AOJu0YxzfGdgDJDRcqWCtNc76cihqbbM313lZMs3hmqzLVlUlZ3rj+tj
	0u7Xcm2LOayaneYCsrfUIp70omv/OBTzPhslo0yIiX0nHNn4RmUXUMtN0cUcvBEUJSX9DA5upsk
	oqeIs
X-Gm-Gg: Acq92OHTZYXk5z/goVMrT9e6VbM4BKykJLA1aidNZbArNLU4PgbIUAXZahEmQLMgL1o
	PpJsiY97VcNFAmDapkvgoVgCcM10lfx1kPF2ziosUP4V4XTEmNR9E00fLduY9p7wm8g5XWtGi2U
	805Mw1cMQejLGNSsYtCURbZB+fBjPe8l2r+F4rc4806Mvnu2j248L5NFf9ESok3sBYmvEBdc1iq
	5OdPi5/PKP0BqFBfGfb5XUS0he09lEKP5COhrbKkyFTB+MfRO2wWAN60K1C07P9+TiYANUVSOvE
	g8um6uV1/LUEw89ML37t4hiBatUjmjuRN8IVZeipu7YjrWKDvK9iOLKvAA9A5TD64tr9z1jzsdl
	R0dlj3zDwPfNGTewf0ttHL96m0v0LNRe9Bb/Mjd3CiZX0qkRN73dNxWwnhmK2xL+76d/JSkI7cl
	4lfjYTIeogIf8x9P+Idbdfvt3MuVfDf4d6n7UlbOZSMG2POcs2bVJa0aSWa6V59CZI7B7IUNu4L
	MF7taMthzlVx4yXC7uoCe3SL7R7bxHEMplI2yeA01OYYJ2VEwUl5agcQMaOHLQ5
X-Received: by 2002:a05:620a:1b9b:b0:912:5d2a:4bb5 with SMTP id af79cd13be357-914b49efcf6mr1587232185a.46.1779625692772;
        Sun, 24 May 2026 05:28:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 05/13] meta-parsec: Do not run Parsec CI jobs on 32bit platforms.
Date: Sun, 24 May 2026 08:27:54 -0400
Message-ID: <7cafc3fe7329d31015848ff70045490780c21ebc.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4024

From: Anton Antonov <anton.antonov@arm.com>

Signed-off-by: Anton Antonov <Anton.Antonov@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml         | 12 ------------
 kas/qemuarm-parsec.yml |  6 ------
 kas/qemux86-parsec.yml |  6 ------
 3 files changed, 24 deletions(-)
 delete mode 100644 kas/qemuarm-parsec.yml
 delete mode 100644 kas/qemux86-parsec.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 701a65a..2156598 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -67,12 +67,6 @@ qemux86-musl:
   script:
   - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_musl_security_image.txt
 
-qemux86-parsec:
-  extends: .parsec
-  needs: ['qemux86']
-  script:
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_parsec_security_image.txt
-
 qemux86-test:
   extends: .test
   needs: ['qemux86']
@@ -99,12 +93,6 @@ qemuarm:
   script:
   - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm_security_image.txt
 
-qemuarm-parsec:
-  extends: .parsec
-  needs: ['qemuarm']
-  script:
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm_parsec_security_image.txt
-
 qemuarm64:
   extends: .base
   script:
diff --git a/kas/qemuarm-parsec.yml b/kas/qemuarm-parsec.yml
deleted file mode 100644
index cef2818..0000000
--- a/kas/qemuarm-parsec.yml
+++ /dev/null
@@ -1,6 +0,0 @@
-header:
-  version: 8
-  includes:
-    - kas-security-parsec.yml
-
-machine: qemuarm
diff --git a/kas/qemux86-parsec.yml b/kas/qemux86-parsec.yml
deleted file mode 100644
index 370947d..0000000
--- a/kas/qemux86-parsec.yml
+++ /dev/null
@@ -1,6 +0,0 @@
-header:
-  version: 8
-  includes:
-    - kas-security-parsec.yml
-
-machine: qemux86
-- 
2.53.0


