Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE928E7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:22 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.152494.1734703517267147366
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=vMJGf3Uh;
 spf=pass (domain: linaro.org, ip: 209.85.208.173, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3004028c714so21531501fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703515; x=1735308315; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUg4avwj9jV39CWic1dloH7XDOL/zGz9uZUhdgR/kRI=;
        b=vMJGf3Uh51pqSFJs6Cq1DeazM/QPItbhnP4peYl4qvRiBAY3rAKEKk34fc/3BWeUrB
         fvfIFCxSHQ9d29aZ5wTwdsmQXVJpbGrzSLx50CD39KwGtZtSiOjtUvDqejVtkH/WNx/4
         8Uczst2X75H/+epq/YMNaHt8R3wGB38fcPVEvHXkLkGWYs9Nx9V56vsIZ8GGetfqOTop
         f0Jh9/yx97RzeVg9GecYWPVbj+Eyp8gOH5zXhTyUWAIY96O5wneYBwMFKIzJvirQDELX
         I3NDQ7kXhOMatmoeG8dBH8oAjvyrTAx831oyFLMM6gOIJlh+GcVQlHk2azT97sjfKUzr
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703515; x=1735308315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUg4avwj9jV39CWic1dloH7XDOL/zGz9uZUhdgR/kRI=;
        b=CTQNswzsbHxLCHZfEJTzxBxQpvNi9ei20QbK/bTDXGiyfS5+8uOnUBF1br1V86OLMy
         /ZOdw3EqmZvSCC2eEgdOZ13AhZGFRZAvx5dgxTd7U3H37jKpJ2Cy7DIeL911Y0itAxUT
         Fy/C8Yt/n6xAefsuEJecdFeJUyJSTfN3xtY4VuE35JHb+hMzMkI38ABiuSF9vHbfeWZ6
         ikRUxb6eRoXXYRc/cIKKrIWcM1JDzVwCjhRBQ67t/1DavGF9pQ8vEK7DqhK9g0uZtCGe
         p8uBFhXtlWsNoq2fiGeygSx+MQsaWheISHFfpFGuOyjpmmME4ReGsyYdxB9s2MnsbS2Q
         MPnA==
X-Gm-Message-State: AOJu0YzY/KgYirZ3a44O+i8oZnnPO4+fIbi9RKIGVjNthI8Q3Evd/GCv
	yguU+WOmAfL2MXhCvDaaH4UrfNGcoBST9U3i3P2f2Ec2gWyrC3PCvLc3vIgv34x2V0aoyALb4Eu
	EL/o=
X-Gm-Gg: ASbGncusguImgk4CayLgWdS+Bl9X9HgOJuNbuRJSHcRIhFWTERF7UKTJnc2+0Sw5D9V
	2qTg/50bPYVI9EHsTKXzAu1iTy4bT8fzgAjsfU/iDqJCwY7Xrk52YDPnjQGAoD8S4yi1oaGr/9n
	3JFC+n+gPS9cLgRHZI4VgxFBnxtpj19ceYNxWxD/sA5XTTWMpBQVCjq0Y++A7PhANLB0thMc5Ow
	VR8/anT8oF9dn5ui5VBQ9WaCHxZUihm/RrGfvHdH4AhWwojvpptyKlFkqY2L4mZqKRbqvOOFwqs
	mMIyuekIQUhraALBSGMxc0+lwg==
X-Google-Smtp-Source: AGHT+IEg7+Nvd/YwNJH6IFoO1CN6yRQP/gz0GnGHiNe5o6H6wsBUYTuYnCgweO8OTfSzB/3vOk46/Q==
X-Received: by 2002:a2e:b888:0:b0:301:12:1ed6 with SMTP id 38308e7fff4ca-30468545dc2mr11201891fa.11.1734703513793;
        Fri, 20 Dec 2024 06:05:13 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:11 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 04/18] apparmor: update from 3.1.3 to 4.0.3
Date: Fri, 20 Dec 2024 16:04:27 +0200
Message-ID: <20241220140441.271395-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/943

Fixes python 3.13 support though needed one more patch
which is also submitted upstream. oeqa runtime test
passes on qemuarm and qemuarm64. Did not fix ptest compilation.

Changes:

https://apparmor.net/news/release-4.0.2/
https://gitlab.com/apparmor/apparmor/-/releases/v4.0.3

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../{apparmor_3.1.3.bb => apparmor_4.0.3.bb}  |  8 +-
 .../0001-fail.py-handle-missing-cgitb.patch   | 74 +++++++++++++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)
 rename recipes-mac/AppArmor/{apparmor_3.1.3.bb => apparmor_4.0.3.bb} (96%)
 create mode 100644 recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.patch

diff --git a/recipes-mac/AppArmor/apparmor_3.1.3.bb b/recipes-mac/AppArmor/apparmor_4.0.3.bb
similarity index 96%
rename from recipes-mac/AppArmor/apparmor_3.1.3.bb
rename to recipes-mac/AppArmor/apparmor_4.0.3.bb
index 49ab7a7..06a5010 100644
--- a/recipes-mac/AppArmor/apparmor_3.1.3.bb
+++ b/recipes-mac/AppArmor/apparmor_4.0.3.bb
@@ -11,17 +11,18 @@ SECTION = "admin"
 LICENSE = "GPL-2.0-only & GPL-2.0-or-later & BSD-3-Clause & LGPL-2.1-or-later"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fd57a4b0bc782d7b80fd431f10bbf9d0"
 
-DEPENDS = "bison-native apr gettext-native coreutils-native swig-native"
+DEPENDS = "bison-native apr autoconf-archive-native gettext-native coreutils-native swig-native"
 
 SRC_URI = " \
-    git://gitlab.com/apparmor/apparmor.git;protocol=https;branch=apparmor-3.1 \
+    git://gitlab.com/apparmor/apparmor.git;protocol=https;branch=apparmor-4.0 \
     file://run-ptest \
     file://crosscompile_perl_bindings.patch \
     file://0001-Makefile.am-suppress-perllocal.pod.patch \
     file://0001-Makefile-fix-hardcoded-installation-directories.patch \
+    file://0001-fail.py-handle-missing-cgitb.patch \
     "
 
-SRCREV = "e69cb5047946818e6a9df326851483bb075a5cfe"
+SRCREV = "b4dfdf50f50ed1d64161424d036a2453645f0cfe"
 S = "${UNPACKDIR}/git"
 
 PARALLEL_MAKE = ""
@@ -106,7 +107,6 @@ do_install () {
     chown root:root -R ${D}/${datadir}/apparmor
 
     find ${D}${libdir}/perl5/ -type f -name ".packlist" -delete
-    find ${D}${PYTHON_SITEPACKAGES_DIR}/LibAppArmor/ -type f -name "_LibAppArmor*.so" -delete
 }
 
 #Building ptest on arm fails.
diff --git a/recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.patch b/recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.patch
new file mode 100644
index 0000000..28c1d9e
--- /dev/null
+++ b/recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.patch
@@ -0,0 +1,74 @@
+From 434e34bb510b4cab04e64cd5b21d635c6be8c8ea Mon Sep 17 00:00:00 2001
+From: Mikko Rapeli <mikko.rapeli@linaro.org>
+Date: Fri, 29 Nov 2024 13:46:32 +0000
+Subject: [PATCH] fail.py: handle missing cgitb
+
+It's no longer in python standard library starting
+at version 3.13. Fixes:
+
+root@qemuarm64:~# aa-complain /etc/apparmor.d/*
+Traceback (most recent call last):
+  File "/usr/sbin/aa-complain", line 18, in <module>
+    from apparmor.fail import enable_aa_exception_handler
+  File "/usr/lib/python3.13/site-packages/apparmor/fail.py", line 12, in <module>
+    import cgitb
+ModuleNotFoundError: No module named 'cgitb'
+
+Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
+---
+ utils/apparmor/fail.py | 25 +++++++++++++++----------
+ 1 file changed, 15 insertions(+), 10 deletions(-)
+
+Upstream-Status: Backport
+
+diff --git a/utils/apparmor/fail.py b/utils/apparmor/fail.py
+index ece6efc4..a71ceb66 100644
+--- a/utils/apparmor/fail.py
++++ b/utils/apparmor/fail.py
+@@ -8,7 +8,11 @@
+ #
+ # ------------------------------------------------------------------
+ 
+-import cgitb
++try:
++    import cgitb
++except ImportError:
++    cgitb = None
++    pass
+ import sys
+ import traceback
+ from tempfile import NamedTemporaryFile
+@@ -32,20 +36,21 @@ def handle_exception(*exc_info):
+         print('', file=sys.stderr)
+         error(ex.value)
+     else:
+-        with NamedTemporaryFile('w', prefix='apparmor-bugreport-', suffix='.txt', delete=False) as file:
+-            cgitb_hook = cgitb.Hook(display=1, file=file, format='text', context=10)
+-            cgitb_hook.handle(exc_info)
+-
+-            file.write('Please consider reporting a bug at https://gitlab.com/apparmor/apparmor/-/issues\n')
+-            file.write('and attach this file.\n')
++        if cgitb:
++            with NamedTemporaryFile('w', prefix='apparmor-bugreport-', suffix='.txt', delete=False) as file:
++                cgitb_hook = cgitb.Hook(display=1, file=file, format='text', context=10)
++                cgitb_hook.handle(exc_info)
++                file.write('Please consider reporting a bug at https://gitlab.com/apparmor/apparmor/-/issues\n')
++                file.write('and attach this file.\n')
+ 
+         print(''.join(traceback.format_exception(*exc_info)), file=sys.stderr)
+-        print('', file=sys.stderr)
+         print('An unexpected error occurred!', file=sys.stderr)
+         print('', file=sys.stderr)
+-        print('For details, see %s' % file.name, file=sys.stderr)
++        if cgitb:
++            print('For details, see %s' % file.name, file=sys.stderr)
+         print('Please consider reporting a bug at https://gitlab.com/apparmor/apparmor/-/issues', file=sys.stderr)
+-        print('and attach this file.', file=sys.stderr)
++        if cgitb:
++            print('and attach this file.', file=sys.stderr)
+ 
+ 
+ def enable_aa_exception_handler():
+-- 
+2.43.0
+
-- 
2.43.0


