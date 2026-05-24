Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ACACD5BCC
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:05 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7157.1779624960864050716
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QTRymoQe;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8c92737a8d3so56137436d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624960; x=1780229760; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv4UUnR3CEywTtSlxqi3XVTdZHncafDQ4ZcWkOeH6UA=;
        b=QTRymoQegxnArnAGP2wW8tQUU6xaWfbXANR6fy3+wlb/8scQiSJ7S1o8jBJzLlgeI7
         3N1t+tzW9syuk3LY3JdneNbfck654pOVJ6wmV1nC4k4fI+EJ+XBwtFMBus/SZt6aifch
         6ne1mzQAtOu+1pWpwwZk5m2p5wHMDeNbQZrt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624960; x=1780229760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tv4UUnR3CEywTtSlxqi3XVTdZHncafDQ4ZcWkOeH6UA=;
        b=Drzo9miavHS2PvH1J+CJq/LgPoWactQDzBFWwXWT38hYmh6wcOMQxE7M9zRZrKakk7
         /OvO4mkC+9ST90Vgq2dneClDR/e324hZK87s8lrMV87XAPcGLuAj+gWSmiYiNVSx5RnA
         JyWj5aNVrrgHnaP6dfcWTYH8BvGWXYMU7M1zajCdSPNT9BqypYQ5EofkJkcROex/GVa5
         0A5AEMnErmiIl00/2+xqiogqG+C46lAdijyvXQ5yKLackOh7CHFJXvk87SZkjddD84Bo
         Dw4oYScdPH0uo7o8OJ1YyYvvo4Sku+eufJ5HsbF2A9LL8f6cSqQCCIWJTvulywUMVi4m
         cl+A==
X-Gm-Message-State: AOJu0YzkVOc32CaBOVVE/gdTZRZ9geBZgD/dGSpVIbGXK5QhcLQLxyDb
	Sq8Rzvcsz1ySuX3xlrZh81TZuDDNf+JtI13bUc+WKrIIbuNiZHv1qNBEcs2U560yXyrzg3ODJ7j
	cWR+K
X-Gm-Gg: Acq92OE9HMTHgnzxgg8ZzHMqhXxqEZGgoOOkXGNAgkv+Pdne24yIc5I+StPEGCXC5Ja
	lDhc2HNuETdUNnjGbImyc87cjkGn/6lqdCrWYbwJag9cA5Xj8hQSsnDPWpw+a9TZH3yKhqpLbUu
	WpiGuQO/reDkdBRDU0m3SyQareJJ0JQdYj5wFTS6I3NUrdEbid6yL41b2lT1/lL5uwsaFPsTWOH
	oJK3Sh5mn34s9UvzO15vuRUJnzWuasEWxpwfxZ0YSDgHVdqfUq6mdMpSJ9GA3LjxtCFdzhrNTB8
	fKHsK1SiXRoseGa5pn8EC95N4cQFFJhbmzKUFl+xX2oFFarhgr09X9dGxUN074ACYtrfTkx3qfD
	xf846pOjCI6UWs2dfR7UjqsamRz1zxSbfGy5jmHz9+sQ6nfnLISQDyZua6v1TCbSBSWGyD7gtWq
	C4gydPVS8farrDYgbV/cHDS5KdfEnnEk807/iZ1RT5vX1whLsDm6co8SiRK5+pFooXGqGhZjIUV
	OXjw1vHy9SrNB4V3XjzVDL6s2R19Pl2uPOWzfwyuqGFJUSo3l17j/jr6e2t31bp
X-Received: by 2002:a05:6214:29c8:b0:8ca:25db:d3bd with SMTP id 6a1803df08f44-8cc7b6004bamr145271106d6.48.1779624959700;
        Sun, 24 May 2026 05:15:59 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:15:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 05/13] meta-parsec: Do not run Parsec CI jobs on 32bit platforms.
Date: Sun, 24 May 2026 08:15:32 -0400
Message-ID: <677294c158242331d844650b9e6c4a8fd4eef4d4.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4010

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


