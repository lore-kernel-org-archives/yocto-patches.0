Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22537CFD340
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5032.1763941519401719942
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T8yPjKm/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b22624bcdaso481155485a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941518; x=1764546318; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNWp6XnQrusZG6GVydXZa3cq7t5bu2DMPu61VXEm+eA=;
        b=T8yPjKm/r4bjiniw+zj/x33xXfWYvqzplQaoTFS5nF4uYNhiBvPvipPIZ143XElD5s
         22+8RtDkIDP1kIm5xMJyEKcNj2DUJiZWgv860k0KhK72+u1H+co/+iZAmU3h8wz44TSo
         ngkqNBUxIVlCemkiXqxJlntoHmc8P4XPy1Cc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941518; x=1764546318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNWp6XnQrusZG6GVydXZa3cq7t5bu2DMPu61VXEm+eA=;
        b=JxT0XLCdFZ3NCoBk9IfNX+jVW4kUTcER1iV03wkgse8iO1Ir3oyOLcZXE+487fMYj5
         DtiNkyH5b+4Ru83dWEWpVbl9wK7+GBzAhJYdw4PipJdsIOwKQTfbBicFbsDNCy3SZZqu
         vNEKXbRm/LzZxE6W9+RPysRlBG+jTGTT5e3IInKByCIQ1oLNUciiaa+uVCqhECdUjCnj
         xcSsaKrB9O74p28nXOUEbQd5Iwxv1LHfJX+0+7ovl9BiMRU9Giab90SEV9qNq4hVtt47
         o6U7mVYOotCVtrRPlxn37MTNG4dv7hS2NQKcJQnjLL83VTbEtJiVJi6Qmbh5/xiZa1Br
         gwWg==
X-Gm-Message-State: AOJu0YyEMOChj+i2+qvbgkBKydmu64HWRWnqQyRemuME/ax1CutHkq12
	tCN0jozoVYpE8+acKvwg6nOUKajeLYrjPCa2bsA4wVle2uS4DO1RR/+ohF4Q9Bf1QimUAPd7dud
	dnowo
X-Gm-Gg: ASbGncvaurBN1+CN/BxbRLf4KuLqiSs/wO1Y50OV1NHP4nh3pRyA+w2uirqAcQqHO5h
	l59VGF/MoISuHxXKn3x3dedse5Sz3PumL2FfxEY5h4Tg96rdc+45d3OweXHUOSObsQyoXS8X0YT
	/IP5xO2ZB1bhA+bglYZwYUS9x/k5CIbHkwKz0cf8x0XcsnE3IV7u6A8kEwDEUfG6EJAP+YRwi4k
	oEF3Uyc9+dP7bFp0Z6l0IZPbo2bHKSC8FSnuyXmghr8tXwu3JNK8sxPeqHh8YVqcpQkfmfUDfyE
	m7x9/UJRajQ/s4zOpTfXk2ZHHhKhrnHRe/4ZqYz6ONLsp2a6xRPyJbxPvYFOhcMBaodRJekTrRa
	hGI7CknxblnvXOnDUEW5QVT1IfjoMv5xQsBD2i6QCSG+cRqTmAX+A0lL7aP3ByT07Jj7FhUFwT7
	+9KWG5nQ3NzvjPYfsIo7e/aLewaqqfvJfCWl1yw8zqX1R6JF97/Rf9+1wyciqHx/M=
X-Google-Smtp-Source: AGHT+IEj2ZBBG9sgoR6Dfxevruy14EWAgArE1mLaWMXjVhe9cDP72jb7IHuCmQfMNXnhBE04Z7t47Q==
X-Received: by 2002:a05:620a:4623:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8b33d22542cmr1371955285a.39.1763941518036;
        Sun, 23 Nov 2025 15:45:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 02/32] CI: update build for new CI
Date: Sun, 23 Nov 2025 18:44:42 -0500
Message-ID: <dbd0761fd6f1558fd434c9be223147cd3e71af56.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2660

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update for Ubuntu 24.04 runners:
- use venv for installing kas
- add missing directories
- assume that python3 and pip are installed.

Other changes:
- add logging of jobs to files
- build parsec images where appropriate

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(squashed and updated with missing master version changes)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1e82a87..5e15221 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,10 +1,13 @@
 .before-my-script: &before-my-script
     - echo "$ERR_REPORT_USERNAME" > ~/.oe-send-error
     - echo "$ERR_REPORT_EMAIL" >> ~/.oe-send-error
+    - echo "$CI_PROJECT_DIR" >> ~/.ci_project_dir
     - export PATH=~/.local/bin:$PATH
-    - wget https://bootstrap.pypa.io/get-pip.py
-    - python3 get-pip.py
+    - python3 -m venv ~/kas_env/
+    - source ~/kas_env/bin/activate
     - python3 -m pip install kas
+    - mkdir -p $CI_PROJECT_DIR/build/tmp/log/error-report/
+    - mkdir -p $CI_PROJECT_DIR/log/
 
 .after-my-script: &after-my-script
     - cd $CI_PROJECT_DIR/poky
@@ -26,6 +29,10 @@ stages:
   stage: base 
   after_script:
     - *after-my-script
+  artifacts:
+    paths:
+      - $CI_PROJECT_DIR/log/*
+    when: always
 
 .parsec:
   before_script:
@@ -51,77 +58,77 @@ stages:
 qemux86:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal"
-  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_security_image.txt
+  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_harden_image.txt
 
 qemux86-musl:
   extends: .musl
   needs: ['qemux86']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_musl_security_image.txt
 
 qemux86-parsec:
   extends: .parsec
   needs: ['qemux86']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_parsec_security_image.txt
 
 qemux86-test:
   extends: .test
   needs: ['qemux86']
   allow_failure: true
   script:
-  - kas build --target security-test-image kas/$CI_JOB_NAME.yml
-  - kas build -c testimage --target security-test-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-test-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_test_security_image.txt
+  - kas build -c testimage --target security-test-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_testimage_security_image.txt
 
 qemux86-64:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image security-tpm-image security-tpm2-image integrity-image-minimal"
-  - kas build --target dm-verity-image-initramfs kas/$CI_JOB_NAME-dm-verify.yml
-  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k core-image-minimal security-build-image security-tpm-image security-tpm2-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_security_image.txt
+  - kas build --target dm-verity-image-initramfs kas/$CI_JOB_NAME-dm-verify.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_dm_verify.txt
+  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_security_build_image.txt
 
 qemux86-64-parsec:
   extends: .parsec
   needs: ['qemux86-64']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_parsec_security_image.txt
 
 qemuarm:
   extends: .base
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm_security_image.txt
 
 qemuarm-parsec:
   extends: .parsec
   needs: ['qemuarm']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm_parsec_security_image.txt
 
 qemuarm64:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image security-tpm2-image integrity-image-minimal"
-  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image security-tpm2-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_parsec_security_image.txt
+  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_build_security_image.txt
 
 qemuarm64-musl:
   extends: .musl
   needs: ['qemuarm64']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_musl_security_image.txt
 
 qemuarm64-parsec:
   extends: .parsec
   needs: ['qemuarm64']
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_parsec_security_image.txt
 
 qemumips64:
   extends: .base
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemumips64_security_image.txt
 
 qemuriscv64:
   extends: .base
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuriscv64_security_image.txt
-- 
2.47.3


