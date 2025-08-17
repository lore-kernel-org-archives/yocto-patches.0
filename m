Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D92CA0EF3
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.61166.1755464894207936427
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qvCZQTlZ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1099192b0so59031741cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464893; x=1756069693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjHubvCzDzIuUVQgrWIwl5abJ1DlCWTCe/y2DBeMAbg=;
        b=qvCZQTlZluZEaaQvL4wsZkJd5R1ZB/U9bedBwlzOpHlKW1VD4sucsc5S6gjWIC2KF7
         BrIcPMP4vKk3xu4piECDWcXOfWn4Q/hZq8kFFZpFql+UyQdXclI5iXB8sRJhSUV+tllY
         JDI7VwUNL3ZjwLCR00WbUT0DXSPfJ2QJRLUj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464893; x=1756069693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjHubvCzDzIuUVQgrWIwl5abJ1DlCWTCe/y2DBeMAbg=;
        b=dxwxDseyLC7N3XD+709xR/H9svU593lSQkUkWYfUz4g0SVhFGLM5mCzoL5TvbpiBiX
         KStTW8RWONnhBJ5GR1/W1opAxXO5XrDcf5PniEIXERt5/J2uPFzKNyNhxdcOEKEmCtLf
         KwE5HB8J8vCZu1+8zVO0gYY7WW6kqLWIfl+er1JyN2udcsASdPuBa3mmUVQU4STUj8Kk
         4Hyrm0RGXmma2whr2sSV9cnTg5qAGMaM3uT51xuezjciNlC9DsZif89x6jRMwV44733x
         BoOeB8r1eB4K0erey8auw8sxuTGlErA1rLKOP2A7DLJISmkGb1XCE+WccvJLTPilzsJI
         hAng==
X-Gm-Message-State: AOJu0YzHsKJMoFvqhdb8CX7E/o6gXegkolDYelbYb7sklECnsY9HN5gv
	pQkfF06vmGlXmnpSkAOlXIlYI0H7fY8UpPWxCdVhDuSJeEc6vjDwBALmtRbzDpffyeexmwtC4mS
	JIgN3
X-Gm-Gg: ASbGncuAVRaQiYsVRKVGT6TbP77dCTI40cBFMYzXm+Hf6gUON+KV8iL08uXmdnG9gA5
	qlEtOU/mdUEPu/3/qg/1yuuMG2dHUbMzgyomGoSrK4rmhg6Y/sXxqJ0VlJsbaQgFHj/eCgbJyFA
	fc+jDvEXdBiDb1KrYvznERwzj+F7Uvz31IXuS6SYID3YfMujVf1ORBVtisoWLV3NP8iYdzqe1Z3
	tvxfcSIg1scmz0XbIOCNik/qFpyWk1WmbsCCAy+BuqbtKOoD86FLaACpmhOPfmuxzUL/IHe94fD
	cdMDf7kuwZv3pife4pDYNGKzqcNMB8b1kL4D7DnmHEIFl15jSfyHYFtoeYFQMJFza5HLSAXS2GH
	CdSYas/ey5Fke7XmN27dte7SLumUAym+cP6q/kWG6sET1Z1PjC7aGdhUyDxI1g/o+VihKPr2W/w
	fvEXikhvW+
X-Google-Smtp-Source: AGHT+IHRq1OfnTHTmI9easF0WDL9sTS/dmrAfditapzVwLNmwZm0zFrArHmH7vIp9JlVyWGIr8vaFQ==
X-Received: by 2002:ac8:5d55:0:b0:4ab:6bd2:e25 with SMTP id d75a77b69052e-4b11e1fe7f5mr129510561cf.25.1755464893069;
        Sun, 17 Aug 2025 14:08:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 3/7] .gitlab-ci.yml: add logging of jobs to files
Date: Sun, 17 Aug 2025 17:07:55 -0400
Message-ID: <b255a22a494f9fb9cdd34ed625528ba62f78cc4f.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2026

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Log kas commands to files and export them as artefacts

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 32ce2b9..628b0e6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,6 +7,7 @@
     - source ~/kas_env/bin/activate
     - python3 -m pip install kas
     - mkdir -p $CI_PROJECT_DIR/build/tmp/log/error-report/
+    - mkdir -p $CI_PROJECT_DIR/log/
 
 .after-my-script: &after-my-script
     - cd $CI_PROJECT_DIR/poky
@@ -28,6 +29,10 @@ stages:
   stage: base 
   after_script:
     - *after-my-script
+  artifacts:
+    paths:
+      - $CI_PROJECT_DIR/log/*
+    when: always
 
 .parsec:
   before_script:
@@ -53,72 +58,72 @@ stages:
 qemux86:
   extends: .base
   script:
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal"
-  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_security_image.txt
+  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee CI_PROJECT_DIR/log/qemux86_harden_image.txt
 
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
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml
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
-  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k core-image-minimal security-build-image security-tpm-image security-tpm2-image integrity-image-minimal"
-  - kas build --target dm-verity-image-initramfs kas/$CI_JOB_NAME-dm-verify.yml
-  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml
+  - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k core-image-minimal security-build-image security-tpm-image security-tpm2-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_security_image.txt
+  - kas build --target dm-verity-image-initramfs kas/$CI_JOB_NAME-dm-verify.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_dm_verify.txt
+  - kas build --target security-build-image kas/$CI_JOB_NAME-alt.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_64_security_build_image.txt
 
 qemux86-64-parsec:
   extends: .parsec
   needs: ['qemux86-64']
   script:
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml
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
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml
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
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuarm64_parsec_security_image.txt
 
 qemuriscv64:
   extends: .base
   script:
-  - kas build --target security-build-image kas/$CI_JOB_NAME.yml
+  - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemuriscv64_security_image.txt
-- 
2.39.5


