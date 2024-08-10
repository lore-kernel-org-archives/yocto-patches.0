Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF0C52D7C
	for <webhook@archiver.kernel.org>; Sat, 10 Aug 2024 16:44:40 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.9220.1723308272957428744
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 Aug 2024 09:44:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AdxvEmvX;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690e9001e01so30428547b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723308272; x=1723913072; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xm4612Cu2YBXZTZGnrsYFOBlZYCuCraVT4sGVVX6YeI=;
        b=AdxvEmvXEryjsyLNcs0NpraoJrIAEXbAl2T9NajgGWVk9KV9VMreYgRiYoQ/Qxrjjz
         NUjbPzJyCjOuQnkweuKCaOtFyFvRAgo3R3v8wjGlvwYyST/Aj3TG54c/Dnw7t6NMF+OV
         UV3RAIFJaPAZvY2F5ON44WLDnUZCN7wjFuAZ3gJd6+IXRUth5xNI59dtEDDYeJIV4K6F
         +tG8ecZLQuVhkD2x5CFTAutOtQkiVaHfamKYxgnNSipzMejl25hGmcXKApKLDGRfw8Q6
         Ppruwinu7bwZFvfUgV5kNY41Po3f3Ymf8N5xbG908GMzGzXObepYIDrsBGxR/NUraeeS
         LumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723308272; x=1723913072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm4612Cu2YBXZTZGnrsYFOBlZYCuCraVT4sGVVX6YeI=;
        b=LqhRzoN08TnFulsStN7F4pAi/diRxtGdhMv4CUa9UQLmcZnUA0hlL8WKHDbLR9qIsk
         +jzrin47HiJxGkWnF4qoAUkV51o/SSV/i18JJ68bz0QTbLyVfKMQYnXFZyxD8pN170r7
         tkn0SqC5LNtZLTX+NCLYPZd8bjuB0T83EUCedj6pjlUzA10hhsAaZ7fyVhQyeE2SOm7l
         ZhKzsul3jEARrSCODpsi2N1Ek/CJ2bMze865RXgK14DyYsVUgoktjl0TVLkk24j3YNQv
         4n3HTuIfufeKAACC7bLSwoUrUAx1K4DljILxMgVPfcyDNMGyMf4IQ82nXI+W3nPR51pK
         1f+Q==
X-Gm-Message-State: AOJu0Yzss+/TskbBT8+syCaO7dr7OosqV4YWi476DSfeMaYzT4MYYIv2
	MvR7BWie+OGCDqEAcAQHQQPZpeGE19nFIq4Z4fsU4cbgwM9KPzvdCndcfg==
X-Google-Smtp-Source: AGHT+IG14TGLdGEpsHfvGF1ERokf+pl+sMojZP/joO1Z5iQ32VXJJv1J8JrcrcDoeRTJ6WOBW8oR7w==
X-Received: by 2002:a05:690c:3303:b0:65f:cd49:44a1 with SMTP id 00721157ae682-69ec5e4993emr50762477b3.22.1723308271855;
        Sat, 10 Aug 2024 09:44:31 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:ad:eb2b:7538:7504])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a09f905c40sm3015517b3.20.2024.08.10.09.44.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:44:31 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] switch to PEP-517 build backend
Date: Sat, 10 Aug 2024 12:44:30 -0400
Message-Id: <20240810164431.902604-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 16:44:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/517

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../python/python3-flask-script_2.0.6.bb      |  6 ++++-
 .../python/python3-json2html_1.3.0.bb         |  6 ++++-
 .../python/python3-pyinotify_0.9.6.bb         | 22 +++++++++++--------
 .../python/python3-segno_1.5.2.bb             |  6 +++--
 .../python/python3-xmldiff_2.6.3.bb           |  6 ++++-
 .../python/python3-yamlpath_3.8.0.bb          |  6 ++++-
 .../python/python3-oauth2client_4.1.3.bb      |  6 ++++-
 7 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-flask-script_2.0.6.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-flask-script_2.0.6.bb
index ba0f974..46cdc8e 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-flask-script_2.0.6.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-flask-script_2.0.6.bb
@@ -7,7 +7,11 @@ SRC_URI[sha256sum] = "6425963d91054cfcc185807141c7314a9c5ad46325911bd24dcb489bd0
 
 PYPI_PACKAGE = "Flask-Script"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
 
 RDEPENDS:${PN} += "\
     python3-flask \
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
index 638c56f..3d7e897 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
@@ -6,4 +6,8 @@ SRC_URI[sha256sum] = "8951a53662ae9cfd812685facdba693fc950ffc1c1fd1a8a2d3cf4c346
 
 PYPI_PACKAGE = "json2html"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-pyinotify_0.9.6.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-pyinotify_0.9.6.bb
index ff1b611..9aaa7c9 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-pyinotify_0.9.6.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-pyinotify_0.9.6.bb
@@ -2,6 +2,19 @@ DESCRIPTION = "Python pyinotify: Linux filesystem events monitoring"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://COPYING;md5=ab173cade7965b411528464589a08382"
 
+SRC_URI[md5sum] = "8e580fa1ff3971f94a6f81672b76c406"
+SRC_URI[sha256sum] = "9c998a5d7606ca835065cdabc013ae6c66eb9ea76a00a1e3bc6e0cfe2b4f71f4"
+
+SRC_URI += " \
+           file://0001-Make-asyncore-support-optional-for-Python-3.patch \
+"
+
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
+
 RDEPENDS:${PN} += "\
     python3-ctypes \
     python3-fcntl \
@@ -11,12 +24,3 @@ RDEPENDS:${PN} += "\
     python3-shell \
     python3-threading \
 "
-
-SRC_URI[md5sum] = "8e580fa1ff3971f94a6f81672b76c406"
-SRC_URI[sha256sum] = "9c998a5d7606ca835065cdabc013ae6c66eb9ea76a00a1e3bc6e0cfe2b4f71f4"
-
-SRC_URI += " \
-           file://0001-Make-asyncore-support-optional-for-Python-3.patch \
-"
-
-inherit pypi setuptools3
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-segno_1.5.2.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-segno_1.5.2.bb
index f8a6552..e24f322 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-segno_1.5.2.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-segno_1.5.2.bb
@@ -4,6 +4,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=8e8db3765a57bcb968140e0a353c1a35"
 
 SRC_URI[sha256sum] = "983424b296e62189d70fc73460cd946cf56dcbe82b9bda18c066fc1b24371cdc"
 
-#PYPI_PACKAGE = "Flask-Script"
+inherit pypi python_setuptools_build_meta
 
-inherit pypi setuptools3
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.6.3.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.6.3.bb
index 517ed87..811cf36 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.6.3.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.6.3.bb
@@ -6,4 +6,8 @@ SRC_URI[sha256sum] = "19b030b3fa37d1f0b5c5ad9ada9059884c3bf2c751c5dd8f1eb4ed49cf
 
 PYPI_PACKAGE = "xmldiff"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb
index 5d88951..8d5f33e 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb
@@ -6,4 +6,8 @@ SRC_URI[sha256sum] = "81d5b8baba60c255b519ccd31a691f9bc064223ff196709d41119bde81
 
 PYPI_PACKAGE = "yamlpath"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
diff --git a/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb b/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
index 3a07461..62157e0 100644
--- a/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
+++ b/dynamic-layers/meta-python/recipes-security/python/python3-oauth2client_4.1.3.bb
@@ -6,6 +6,10 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=038e1390e94fe637991fa5569daa62bc"
 PYPI_PACKAGE = "oauth2client"
 SRC_URI[sha256sum] = "d486741e451287f69568a4d26d70d9acd73a2bbfa275746c535b4209891cccc6"
 
-inherit pypi setuptools3
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-setuptools-scm-native \
+"
 
 RDEPENDS:${PN} = "python3-six python3-rsa python3-httplib2 python3-pyasn1 python3-pyasn1-modules"
-- 
2.34.1


