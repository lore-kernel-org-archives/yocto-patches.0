Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F081111224B
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 00:17:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5334.1775089019583474887
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 17:16:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H1a/TQuK;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfd832155so144796f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089018; x=1775693818; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgPn6jAUgKAVEqKS+Y5BJozfo1wllZspfDTpMgR3iPY=;
        b=H1a/TQuKbc38bibMYQ6d30oQWmM733i9ugkxcrWPmQ0lZCzYgBJvOqDySFgQz2EUJF
         XsTxw6PI9QfI6ArYgQcbKQ2WKlMbpBIBAOhxENi675rvjnI2dbUEqXstMijOie8VX8zz
         fUsfyNDV9BdD4Hf5mpRyTMjHotfR3Ui0x4iXSukElc5qlyw2BCSlSx7j73hNGaqVqQyQ
         cOvJ2eNOl8Y2Fgzlgeo4gRvVitA6C08ptWVyRxAvdvGXzu/nCqV2DLzDFh/a7ZtoMZ7l
         K4S+oJ0OsniezWMTvbnf85DmVBkrWIR+05/sub48nQJhtZh7Fj35Y2qc/WxQVWJkMTQN
         IIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089018; x=1775693818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgPn6jAUgKAVEqKS+Y5BJozfo1wllZspfDTpMgR3iPY=;
        b=mA+IKjGUDgNp1OG1pjDTIll7mQSd51bBWipenKaFOtcLY82GwKKEWbjtZ6lt8W8lii
         iElLvprk3SnP/RRsI+fWWiAfIBcrJRld9M/7SvQ0dj2MRsNLYSxNmQlKlnTSc2G5ecmC
         Xbh6QOtyDbAiSkpB3RrLFBM/ikYdfIwQK5hAeSIkN2FpDmpW+Rdkydq2mRC5Ifpzz+yT
         ivH3He+XmZMk6npFdxV8UGQQZx27IJNo9FbJylFEeT9EL5LtHKQvd9RKt72mpH05vAj7
         6hyU2JdM9x66Pa0d7RhS4cCKiwyy2HnfMf0nz2vatnAyQkDAnonCwvD/1gcUkW5FzUo+
         wMjQ==
X-Gm-Message-State: AOJu0YxcjI+UKOdzTrN5QlN1JYMwHBhDlqlUjFbGshk1ztDIowUxj3sK
	dUBCznf1DU0js2Y30vFz4cyHw149k/Ww3oH5fMZ0muYzbaGI8y8JRiskUAWcrw==
X-Gm-Gg: ATEYQzw25bOevCA7V5X33VJcxvOCqbl/A3uorkaYdGN4n7iYlU7iWDod3URGTsE3kvA
	2laYhhOSe2eENULq8kHCIeD56kQoCrSjKxbyylPZPM+wzCMd9RiVREJlF6OEo1mauFQ+CDN24vK
	jseUKXi5FHw3eJpdgcHRY7De8sC1yKIghuWqn8OQFe6D458B4aDYrOLidfbP17oOkz0MRz61QP2
	FFVcr+HYHtLmjvfT2jf1nks4S4iA9FuaaCBsK0fYWFgXXohXo1b7X7aYhq+9VgawYg3HCiu1V3w
	xS2OcnG+uECU39z81LFapPvAOIKPbWXrRK5O/cR+37GP/YcAEbmv4trJJfCkPm6dxtvJKhu9r/b
	d8j1H7kfnm3k9wNsnrfJlAd22slq6VOxdWEdvdoosS4gMSctFF4Kiou7ZPW6WO08Mw54m4QQQ3Z
	M/eLMax5dz2zhqZVX+1+PHAUbGftM+f6ltQNO2
X-Received: by 2002:a5d:5384:0:b0:43d:1c21:efd2 with SMTP id ffacd0b85a97d-43d1c21f015mr4908637f8f.0.1775089017726;
        Wed, 01 Apr 2026 17:16:57 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm3411872f8f.31.2026.04.01.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:16:57 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH 3/3] bazel: update the arguments for local resources
Date: Thu,  2 Apr 2026 02:16:45 +0200
Message-ID: <20260402001645.1717722-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001645.1717722-1-martin.jansa@gmail.com>
References: <20260402001645.1717722-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 00:17:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3601

From: Martin Jansa <martin.jansa@gmail.com>

Fixes:
WARNING: Option 'local_cpu_resources' is deprecated: --local_cpu_resources is deprecated, please use --local_resources=cpu= instead.
WARNING: Option 'local_ram_resources' is deprecated: --local_ram_resources is deprecated, please use --local_resources=memory= instead.

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 classes/bazel.bbclass                        | 4 ++--
 recipes-devtools/bazel/bazel-native_7.7.0.bb | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index 43e2c9c..085eff1 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -85,11 +85,11 @@ def bazel_get_flags(d):
 
     if d.getVar("BAZEL_JOBS"):
         flags += "# From BAZEL_JOBS\n"
-        flags += "build --jobs=%s --local_cpu_resources=%s\n" % (d.getVar("BAZEL_JOBS"), d.getVar("BAZEL_JOBS"))
+        flags += "build --jobs=%s --local_resources=cpu=%s\n" % (d.getVar("BAZEL_JOBS"), d.getVar("BAZEL_JOBS"))
 
     if d.getVar("BAZEL_MEM"):
         flags += "# From BAZEL_MEM\n"
-        flags += "build --local_ram_resources=%s\n" % (d.getVar("BAZEL_MEM"))
+        flags += "build --local_resources=memory=%s\n" % (d.getVar("BAZEL_MEM"))
 
     return flags
 
diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
index 042f456..3b81be5 100644
--- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -35,8 +35,8 @@ EXTRA_BAZEL_ARGS = " \
     --distdir=${TS_DL_DIR} \
     --color=no \
     ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--jobs=${BAZEL_JOBS}", d )} \
-    ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--local_cpu_resources=${BAZEL_JOBS}", d )} \
-    ${@oe.utils.conditional("BAZEL_MEM", "", "", "--local_ram_resources=${BAZEL_MEM}", d )} \
+    ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--local_resources=cpu=${BAZEL_JOBS}", d )} \
+    ${@oe.utils.conditional("BAZEL_MEM", "", "", "--local_resources=memory=${BAZEL_MEM}", d )} \
 "
 
 do_compile[network] = "1"

