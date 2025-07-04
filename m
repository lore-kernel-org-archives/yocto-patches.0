Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46787C8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:12:08 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.1077.1751649122318532540
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=L89m5ROD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58ba6c945so16307291cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649121; x=1752253921; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE/CFFoS6DeYN05U6of3e7KDk13m2RwYIL/xiqcBvI4=;
        b=L89m5RODm+XcZGUyN3WQ3nW8U4gXWkF+HrL36rvtO3kicfhMfXJgtkRzpKXqop19Sk
         b/uQoTkZN2QtQ1Y+BjpWTwczYE7Hd+H+jhz5WW9XCKA1l6ZIO+BogeT9zdO1zz8fWyjT
         E0hwRSUQQNgPqk0ztOA963EbBU7GGcLEiv3/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649121; x=1752253921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE/CFFoS6DeYN05U6of3e7KDk13m2RwYIL/xiqcBvI4=;
        b=nfta6D6bWlURbDeRxjui8QVBzLwORwb9jGKjhMU8g6jwqIrCTm0qcaOmKWqtbOeB9t
         ZcsfmZX9rV6l32Vb7EAc+zkb4pvRpj58Ia2qtSVfqQRNPhPAqYuGoVmlaHgqhNGqiAwO
         JnKV2BijXtJxHLwPk4yj2WH9XL97QGob3GLhXr24dOo3fkmDCETUSPsaSxrkinInLNsx
         oas0AxZF6nmGqLkrGbDQkK27Kl984GcKd3ZWUrWWEAzMvtZwmusDONfhGai/E2JA2nCU
         pfbGBAxCUoMqjhTSUU5bMdo6hfMqtrPrV6R+cuUjyjiuKkwx0QEeWG+6U9Wg5gBdLzIC
         hGIQ==
X-Gm-Message-State: AOJu0YyEyBROs1Nv+aVFsCOwK3oYA0VGtZFiNN65j50/2WLYdsTViQz1
	v4UumG1n0HVxl6splbhCGWu5qNf8wcBZm1rCO00dvzwLir8BrvXlKqefkaXIbdsgCGTIhDk5gLw
	QQU9+
X-Gm-Gg: ASbGncuyEsJ1MD8XjpxYWwY73gbEDd2920jNTWrh+ckCIF1VwFgaecT+6z9frDVa/Ln
	SnTbhA+RAHzF9YdB94bsGwoLtf2QvPSjtGtW7w4QSnos05zGM02QE0I3tzFINFUJfRZM/ztfAu7
	1MuWBVNd9pevw71OXiz8Tv0Xi+Jcdcd7yz4K6RqOOBO+3HLprzZSXwQGYQIoD4K+oRh5Zhm3B/Q
	oWvKdUIDEbsPTVOhaMGqLYFUAkGK1B3Een5Cep2CRgHHg2ou6PdKilAh/i3bCH1X6EXPzzenSAC
	hNSXhV+Q94vx8vevmtEb56s1aRiEq+rVSA7O7i6ut6IKNhWfQDEoxrZjFqOaIf+yOuSGUPNfNfz
	3wFYePCih5wwXlNtajQXZuv/dO9gdO1YAomMfrg==
X-Google-Smtp-Source: AGHT+IE/mLPQ+0ASedDYwAFJXBKdy/68DkFgg+i/we1LGLjdnf24oh5aONmJSkhxZt6HZ2mkJePbMw==
X-Received: by 2002:a05:622a:58cd:b0:4a7:7032:d229 with SMTP id d75a77b69052e-4a99688adfdmr55743271cf.39.1751649121083;
        Fri, 04 Jul 2025 10:12:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:12:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 12/12] .gitlab-ci.yml: add logging of jobs to files
Date: Fri,  4 Jul 2025 13:11:16 -0400
Message-ID: <d750c6cf48c48fa5deeaae937a3d764f73c4b53b.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1764

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
2.50.0


