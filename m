Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA1C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:11:13 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.22066.1752847872386085068
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 07:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aqlwXtpW;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-704c5464aecso19772606d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752847871; x=1753452671; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HWPtE7Ioi+w+7N0ut6SV8GixOh1gwth+6J1S0suc9I=;
        b=aqlwXtpWGA71v/VakT32Vf+ClA+s5GSILkNwmnwmLvBHdDP6HkeZR7QRU+vumLWNLs
         liA8ruxgEyO93BlgIigATu/aT9xpI4Rh1TIk79RbzF/UlDdTbxLL8xyvsurpMAk/SrT+
         3qAIVJsNIbwuk16s8ihz32QaKK9VghhnjtyrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847871; x=1753452671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HWPtE7Ioi+w+7N0ut6SV8GixOh1gwth+6J1S0suc9I=;
        b=k6Mts4v8P8dXe5SNNlPMouMws3FrXsC2BMnWlBSAPAeT7CvpQGc1yh14ygPe7328Kl
         ltUCYAP/75uN7mma+w5uSSvt7APNhrb/nE6PutFAU0UY4aXsnwhmgWMbiBB7Wf8feYNR
         rHDIt0qJu/CbGpkkrzBh3stdn9eg3t5xiZX4su6lZipMaNdDG+deREQKoBGlLDZvyzZf
         eIW8Zx7O9ZI5Bsg7yv4idBiE/AnymjJepq+RzwD3Eod0hipIaBy2HbzBAwwXYFtXuQwj
         RXVlTKeSt3ZxnDqrDdhI8KIybBh8AmvcTmWRlDO9kImDvqv0E5pE02QLh/JOJbGBh6Tt
         rV+g==
X-Gm-Message-State: AOJu0YxRMmGxft7tcz4nBFyNfX3EudfGZNq8DRp7NynRtaNbo1FYaOXW
	PfA21zlA6ZTmUaM/LG14GkW/9eL4nFeHlGIy+gvu8/6z/07sw8U0WpQKWWYv95zNF59EF2iOv56
	N5ROG
X-Gm-Gg: ASbGnct3C/1GSsO0CoF32DlvRWQ1t6VjV0uLvW5uOifZPPHlhfyNUOrDl0kukTf3Wp1
	kAR4A3QfuXNIpItqfTY9o3ouorqonNxlyJhb9Q3dDqjW75XIFl5FYLfEthLpNXScUwLNW42GotK
	vBLJnYvja8vfMCiDy7sWNRK72mnuVho183UOx7euJ43mePGIoqK34St/fvbTHEvOyiUpfilLyjc
	RcfxGWZetfvyFIz7rHRk6vViNVZ/PQoIdbHx+jGQCJNhQA1hkh4ixh/vbN9Obt9VGXQBBpJWTGP
	EUA4Gz31Lhf/IYDYACnSY0dh2+d2vcSstaE6eEychIXbLNQMlw7CKt1nNlXLtci+URj5AYU668b
	wgu6FyMdajZPwfPsNtU9YHt3k4nQHaAbj+wAfTrswb/USUOtCz4XsGJ0SPQHGtJDEu9lJSJotFg
	==
X-Google-Smtp-Source: AGHT+IH6mNXF3O+UbPzgh4Td2Q6Qdd7VimZdZE7rVZdDQE0hNw+esIi2lSscfodK/tPljZBHvb5H+g==
X-Received: by 2002:a05:6214:468d:b0:6fb:4b73:79f7 with SMTP id 6a1803df08f44-704f6b37ab1mr138653486d6.41.1752847870965;
        Fri, 18 Jul 2025 07:11:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356a0732dsm92368785a.0.2025.07.18.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:11:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][PATCH 2/4] scap-security-guide: disable ptest
Date: Fri, 18 Jul 2025 10:10:57 -0400
Message-ID: <ee5f84c7c5eb1ee97edbe6cdcf25a0336a672be6.1752846514.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752846514.git.scott.murray@konsulko.com>
References: <cover.1752846514.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 14:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1813

From: Yi Zhao <yi.zhao@eng.windriver.com>

Enabling ptest will significantly increase build time. Additionally,
since the ptest distro_feature is enabled by default in poky distro,
build time can be very long, which is annoying.

On my build host:
Enable ptest:
$ time build scap-security-guide
real    219m54.529s
user    0m49.040s
sys     0m1.304s

Disable ptest:
$ time build scap-security-guide
real    1m25.222s
user    0m3.306s
sys     0m0.166s

Since no one cares about this ptest and no one fixes the test failures.
Let's disable it.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../scap-security-guide/files/run-ptest       |  7 ---
 .../scap-security-guide_0.1.77.bb             | 52 +------------------
 2 files changed, 1 insertion(+), 58 deletions(-)
 delete mode 100644 recipes-compliance/scap-security-guide/files/run-ptest

diff --git a/recipes-compliance/scap-security-guide/files/run-ptest b/recipes-compliance/scap-security-guide/files/run-ptest
deleted file mode 100644
index e8d270f..0000000
--- a/recipes-compliance/scap-security-guide/files/run-ptest
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-export PYTHONPATH="/usr/lib/scap-security-guide/ptest/git:$PYTHONPATH"
-
-cd git/build
-
-ctest --output-on-failure -E unique-stigids
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
index a082a70..cdd22a5 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
@@ -9,7 +9,6 @@ LICENSE = "BSD-3-Clause"
 SRCREV = "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
-           file://run-ptest \
            "
 
 
@@ -17,7 +16,7 @@ DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-n
 
 B = "${S}/build"
 
-inherit cmake pkgconfig python3native python3targetconfig ptest
+inherit cmake pkgconfig python3native python3targetconfig
 
 STAGING_OSCAP_BUILDDIR = "${TMPDIR}/work-shared/openscap/oscap-build-artifacts"
 export OSCAP_CPE_PATH = "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
@@ -40,57 +39,8 @@ do_install:append() {
     install  ${UNPACKDIR}/run_eval.sh ${D}${datadir}/openscap/.
 }
 
-do_compile_ptest() {
-    cd ${S}/build
-    cmake ../
-    make 
-}
-
-do_install_ptest() {
-
-    # remove host & work dir from tests
-    for x in $(find ${S}/build -type f) ;
-    do
-       sed -e 's#${HOSTTOOLS_DIR}/##g' \
-           -e 's#${RECIPE_SYSROOT_NATIVE}##g' \
-           -e 's#${UNPACKDIR}#${PTEST_PATH}#g' \
-           -e 's#/.*/xmllint#/usr/bin/xmllint#g' \
-           -e 's#/.*/oscap#/usr/bin/oscap#g' \
-           -e 's#/python3-native##g' \
-           -i ${x}
-    done
-
-    for x in $(find ${S}/build-scripts -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    for x in $(find ${S}/tests -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    for x in $(find ${S}/utils -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    PDIRS="apple_os build controls products shared components applications linux_os ocp-resources tests utils ssg build-scripts"
-    t=${D}/${PTEST_PATH}/git
-    for d in ${PDIRS}; do
-        install -d ${t}/$d
-        cp -fr ${S}/$d/* ${t}/$d/.
-    done
-
-    # Remove __pycache__ directories as they contain references to TMPDIR
-    for pycachedir in $(find ${D}/${PTEST_PATH} -name __pycache__); do
-        rm -rf $pycachedir
-    done
-}
-
 FILES:${PN} += "${datadir}/xml ${datadir}/openscap"
 
 RDEPENDS:${PN} = "openscap"
-RDEPENDS:${PN}-ptest = "cmake grep sed bash git python3 python3-modules python3-pyyaml python3-pytest libxml2-utils libxslt-bin"
 
 COMPATIBLE_HOST:libc-musl = "null"
-- 
2.50.0


