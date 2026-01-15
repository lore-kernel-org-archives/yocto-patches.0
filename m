Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12FFD4663D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.688.1768517214106491196
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AXAPTppJ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a3b9ddd40so8120066d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517213; x=1769122013; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUUZzt6Y2g2VvCEas/5BVqY8LI+A1XW6Il+dWwSN6iw=;
        b=AXAPTppJyIhrflISmEd5Kx0Tvbl4OKiLE42DwTjK9QWC9VhiPndvvv1f+wJ22qBiWc
         pVunqQCXW+5DJABkapAFR3CiV0R6Ix5eOf8syR2qaQKhKX74y2ERSazs63utnHZZBehO
         fYaAIWmB+bs32T0GehjQJyWMJrm0xvAUrymMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517213; x=1769122013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUUZzt6Y2g2VvCEas/5BVqY8LI+A1XW6Il+dWwSN6iw=;
        b=puVALmhmGbNOGl3DYS/CdRPCbw5g3BQ9xFbKbvt+8vvu3lpAoT0BavY2wpDsAGSOyl
         0wktRnqawbWlsQrwNxmox/DxrGKorZmQ78peTe5D5+W0pgyFDj/GtFZBd1FmZsvn28m9
         skCmNJ/ETeTIGEEsikHDipJ+gRhXyA2vfm71/jO0FQn1LgjsS7gSUR+Mhg5bSm1DDR+T
         QmxkglbzEQ6zIHGf458F6ZicwSRn026YdQ5NMX/5g+wDRy6kEPiXcAEWZGCQFZ6lqmsn
         LriXd5BjunpkXAnFLl+ZYhomP7LG7BsJBDhMxLnYwj1wMcNnQnywLYhBmqgjCGP7wN8h
         mesw==
X-Gm-Message-State: AOJu0YwBFw42f38+/5pnaHDkhDOvtPgRe0H7DiRC9JtbOSnNtbLCMM4w
	X4ObW45HlcbWHOm6u5YDlQXg31Ofdm2CBLl43prw+VMeleysI5C7pri0lfjyAvCyDTTtneX12AM
	blo+M
X-Gm-Gg: AY/fxX5Wf22r/Vo1cp4Ax0JHAkMDfyqCgWgbgOX6FNFCCIL82bZ9+EjhfAE4W4qk6DE
	wuM+Cjm/gFkDIyArFSJxGIbOyhX2xEefcXfKTpbIl5EdRd57W/vVL9OB1GY+1hqEdfv95VpFeX9
	m5AOnY9hFrGc2hHBFN6qEXucPwUNHXLVxYJV3vjEcD6OXajtjUeT1oTC0RtireJLhOe8E33myhj
	2+bLi5qy9HzTHGCPMrSyrnvQT+/lO9RNt+zLfOmOreVpOXbfH47C8WlVokieO75JttO34Z/eQG3
	u32ftuH46HKl6HivoueuQkSgDvyViT1IS24dvcOyfxH5ZWK6GrJqXbtrN80SzBnTVoZ5i8BJ07g
	WmXvzPNSuIa6JsbRCr7xcguwPvrqD8j+s0ZydD7BIqQVwsEUCowNa1YuQGFMZddEDy5duMRbMFt
	6fa79GpFEu+Hwez7gk4PVpArA4nc8Sp2qb60oELqaaM1FSW6GuItusHDbWZu9A5qsENEozsiYDL
	cMjTTBess3yC8Gh2j2dYOAw87YwpdN8jd6s9gBeiuK1aq56/MjQ
X-Received: by 2002:ad4:5cef:0:b0:890:e2d:a9d6 with SMTP id 6a1803df08f44-8942ddb3c6amr17442346d6.68.1768517212640;
        Thu, 15 Jan 2026 14:46:52 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:52 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 2/9] CI: update build for new CI
Date: Thu, 15 Jan 2026 17:46:23 -0500
Message-ID: <cbbb804f5dd2fb26ec391255694e4e0ec32b3ed4.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2967

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update for Ubuntu 24.04 runners:
- use venv for installing kas
- add missing directories
- assume that python3 and pip are installed.

Other changes:
- add logging of jobs to files

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(reworked for kirkstone branch)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a4137cb..e37a161 100644
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
@@ -51,78 +58,78 @@ stages:
 qemux86:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal"
-  - kas build --target security-build-image kas/$CI_JOB_NAME-comp.yml
-  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_security_image.txt
+  - kas build --target security-build-image kas/$CI_JOB_NAME-comp.yml  2>&1 | tee $CI_PROJECT_DIR/log/qemux86_compliance_image.txt
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
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_parsec_security_image.txt
 
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
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_parsec_security_image.txt
 
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
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm_parsec_security_image.txt
 
 qemuarm64:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image security-tpm2-image integrity-image-minimal"
-  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image security-tpm2-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_security_image.txt
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
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_parsec_security_image.txt
 
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
2.51.0


