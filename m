Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B62CD3425
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:22 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14499.1777477215432720136
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BhJax62n;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef0ba61d46so1005371185a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477214; x=1778082014; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0gGZlkVGUTrRQDBSslala2wxHG3EIDzkUOOVrgzeNQ=;
        b=BhJax62nZOvnRh9SumQw86VfJKaVezwXBmE3/pUDaT3ewsHySSSjw+nQfY6JnTHaLn
         bRm3YKx84z6seYFlh9vzjxVtOVipEkIM8KF84yvCxdKKod/rNXlUXLOBTNjON8a50boU
         48rhennWhYkyviTRgpKjYoal5m3kV9J1Nn/IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477214; x=1778082014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0gGZlkVGUTrRQDBSslala2wxHG3EIDzkUOOVrgzeNQ=;
        b=D16Q37tThD7SkDXJvzt8NTONEvZXqoOQIEYtIp/7+WC5XNR4PpGTAXYULmQhr91pUp
         lY95pks8fd1chU3vy5EDZZXDdrUt5s9hplL75IDJNdlbAAfZBips71xrL1tyT+sMTC0U
         lFT82DA9BNvXqx7qu7utePWuDKovrxyTcPZE0sdWArBSVd6OedU7xWnxYSSpscww8S53
         NOZ5WjRHnws/483k+1b2UT1IPsEMFrGIBNy4AnCtBd3L4sZnO1obAt9oTUIEqyUbhJBe
         k61sAOk7HayUH0gyqsOofIZ5WYNThICJzFBYU2I74p1TnZXIGkpslGFiZr0TG5TcYiwe
         IvnQ==
X-Gm-Message-State: AOJu0YzLAo9ouSGbZ6L3CexF8Kw8HbXz2f5GWRnCSvUU9yLNRQxKq3kM
	YP6OLq8BfeW7mQNokjS4Mp+ATWboCjXo6o9dSAVxsi3XEB/p8JscdpPiTYqF+fMHlIx9FiiAX71
	aEz/L
X-Gm-Gg: AeBDiet3XgMv1qxwYWZDtaQvfxYJ7Uts1Ub3yvgFzr90lJysqWgtZxgaEB1hpw88GhD
	p9VHJZVBr7nU2bAwJtkya3sS1ddBPT3nK7KAt8WFOoO4/lEUT8RCo/flDH8R6EH+9tXOPpP1moL
	S7AULyVf51e6YPeT4kMP0QOXwqPUXcp6BQFVpbGABItepqIGYp879oaHBoTsinP+WUo6T+aAEkR
	rQtTfpWXBqpVGh57ozlForeVk8NU0SH+0MWySkaFaDOlgfdBn0/8eNnz4ekpf/ehRy8YidC56Cn
	i7UqKAyS021YmkOt8wZTib4l+jyL/MscYlcju3qQLgsq1QUQgUgbKqB5qxN3kwE5TiS76zkXBZR
	vIkW9niMDEg8Pg0O4tQr3/cdRmDnljmnsYsXqbRFo++WKLRXlr/sFbCSee1sasQMhIerx9/YSbf
	nlS5RlObA/x3ziXo6ZbSVOlTLvcWyvRd/Fdfsm/RvexouiAkkKDFJkIuYSikMIFIiEQZcoT6fQx
	Z0nA1FhlxHGNF2+Eqm4Ux/Mo7QZGjgL5VIBG5z2/Mo2DpgGDyn61PGD/dwuvN0HP+XDRbF6+9E=
X-Received: by 2002:a05:620a:4147:b0:8d3:ccef:b2c6 with SMTP id af79cd13be357-8f8f44e4a25mr665189085a.24.1777477213957;
        Wed, 29 Apr 2026 08:40:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 05/13] opendnssec: Upgrade to 2.1.14
Date: Wed, 29 Apr 2026 11:39:35 -0400
Message-ID: <8e4092ad8d50881bacb70fe8590bf9da4f9edc28.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3878

Upgrade to 2.1.14 and add some patches from the github PR queue to
fix compilation.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...1-Fix-implicit-function-declarations.patch | 51 +++++++++++++++++++
 .../files/0001-include-utilities.h.patch      | 33 ++++++++++++
 ...rder-header-files-and-include-time.h.patch | 39 ++++++++++++++
 ...ndnssec_2.1.10.bb => opendnssec_2.1.14.bb} | 15 +++---
 4 files changed, 131 insertions(+), 7 deletions(-)
 create mode 100644 recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch
 create mode 100644 recipes-security/opendnssec/files/0001-include-utilities.h.patch
 create mode 100644 recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch
 rename recipes-security/opendnssec/{opendnssec_2.1.10.bb => opendnssec_2.1.14.bb} (70%)

diff --git a/recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch b/recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch
new file mode 100644
index 0000000..0404ed1
--- /dev/null
+++ b/recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch
@@ -0,0 +1,51 @@
+From 7060607ef359162d5b0aef62a4b8440fd42c9d28 Mon Sep 17 00:00:00 2001
+From: Yaakov Selkowitz <yselkowi@redhat.com>
+Date: Tue, 26 Dec 2023 14:09:12 -0500
+Subject: [PATCH] Fix implicit function declarations
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+utils/kaspcheck.c:101:33: error: implicit declaration of function ‘exit’
+utils/kaspcheck.c:136:17: error: implicit declaration of function ‘free’
+utils/kc_helper.c:47:40: error: implicit declaration of function ‘free’
+utils/kc_helper.c:519:85: error: implicit declaration of function ‘atoi’
+utils/kc_helper.c:569:83: error: implicit declaration of function ‘malloc’
+utils/kc_helper.c:1122:28: error: implicit declaration of function ‘strtol’
+utils/kc_helper.c:1274:25: error: implicit declaration of function ‘exit’
+utils/kc_helper.c:1375:21: error: implicit declaration of function ‘calloc’
+
+Upstream-Status: Submitted [https://github.com/opendnssec/opendnssec/pull/853]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ enforcer/src/utils/kaspcheck.c | 1 +
+ enforcer/src/utils/kc_helper.c | 1 +
+ 2 files changed, 2 insertions(+)
+
+diff --git a/enforcer/src/utils/kaspcheck.c b/enforcer/src/utils/kaspcheck.c
+index 9bac3b796..b3b808598 100644
+--- a/enforcer/src/utils/kaspcheck.c
++++ b/enforcer/src/utils/kaspcheck.c
+@@ -26,6 +26,7 @@
+ #define _GNU_SOURCE
+ #include <stdio.h>
+ #include <getopt.h>
++#include <stdlib.h>
+ #include <string.h>
+ #include <syslog.h>
+ 
+diff --git a/enforcer/src/utils/kc_helper.c b/enforcer/src/utils/kc_helper.c
+index 89e56c61e..e1704f6f9 100644
+--- a/enforcer/src/utils/kc_helper.c
++++ b/enforcer/src/utils/kc_helper.c
+@@ -27,6 +27,7 @@
+ #include <syslog.h>
+ #include <stdarg.h>
+ #include <stdio.h>
++#include <stdlib.h>
+ #include <string.h>
+ #include <sys/stat.h>
+ #include <errno.h>
+-- 
+2.47.3
+
diff --git a/recipes-security/opendnssec/files/0001-include-utilities.h.patch b/recipes-security/opendnssec/files/0001-include-utilities.h.patch
new file mode 100644
index 0000000..f9efbbd
--- /dev/null
+++ b/recipes-security/opendnssec/files/0001-include-utilities.h.patch
@@ -0,0 +1,33 @@
+From 42c01ae83a0c549379b9739a74db8ca3c4924407 Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
+Date: Sun, 31 Dec 2023 22:43:50 +0100
+Subject: [PATCH 1/2] include utilities.h
+
+The utilities.h header file is necessary for clamp function, otherwise
+compilation fails with implicit function declarations error with moder
+compilers. This is baiscally backport of commit f41dd6020f58 ("Compile
+warning. clamp implicitely defined.")
+
+Bug: https://bugs.gentoo.org/871294
+
+Upstream-Status: Submitted [https://github.com/opendnssec/opendnssec/pull/854]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ common/scheduler/task.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/common/scheduler/task.c b/common/scheduler/task.c
+index 4dcf9e90..0dfa496a 100644
+--- a/common/scheduler/task.c
++++ b/common/scheduler/task.c
+@@ -40,6 +40,7 @@
+ #include "duration.h"
+ #include "file.h"
+ #include "log.h"
++#include "utilities.h"
+ 
+ static const char* task_str = "task";
+ static pthread_mutex_t worklock = PTHREAD_MUTEX_INITIALIZER;
+-- 
+2.47.3
+
diff --git a/recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch b/recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch
new file mode 100644
index 0000000..137c117
--- /dev/null
+++ b/recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch
@@ -0,0 +1,39 @@
+From 4e0da6c3716c08a5864fbac3f647427bcc64693e Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
+Date: Sun, 31 Dec 2023 22:51:51 +0100
+Subject: [PATCH 2/2] reorder header files and include time.h
+
+The time.h header file is needed for strptime function, otherwise modern
+compilers fail with implicit function declaration error. Moreover,
+getopt.h needs to be included after config.h otherwise global
+configuration will not be respected. This can affect time.h as they both
+include features.h.
+
+Bug: https://bugs.gentoo.org/879727
+
+Upstream-Status: Submitted [https://github.com/opendnssec/opendnssec/pull/854]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ enforcer/src/daemon/time_leap_cmd.c | 4 +++-
+ 1 file changed, 3 insertions(+), 1 deletion(-)
+
+diff --git a/enforcer/src/daemon/time_leap_cmd.c b/enforcer/src/daemon/time_leap_cmd.c
+index af41c8db..c0acd01d 100644
+--- a/enforcer/src/daemon/time_leap_cmd.c
++++ b/enforcer/src/daemon/time_leap_cmd.c
+@@ -26,9 +26,11 @@
+  *
+  */
+ 
+-#include <getopt.h>
+ #include "config.h"
+ 
++#include <getopt.h>
++#include <time.h>
++
+ #include "file.h"
+ #include "duration.h"
+ #include "log.h"
+-- 
+2.47.3
+
diff --git a/recipes-security/opendnssec/opendnssec_2.1.10.bb b/recipes-security/opendnssec/opendnssec_2.1.14.bb
similarity index 70%
rename from recipes-security/opendnssec/opendnssec_2.1.10.bb
rename to recipes-security/opendnssec/opendnssec_2.1.14.bb
index 64bacf1..5d9bc67 100644
--- a/recipes-security/opendnssec/opendnssec_2.1.10.bb
+++ b/recipes-security/opendnssec/opendnssec_2.1.14.bb
@@ -1,18 +1,21 @@
 SUMMARY = "OpenDNSSEC is a policy-based zone signer that automates the process of keeping track of DNSSEC keys and the signing of zones"
-
+HOMEPAGE = "https://www.opendnssec.org"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=b041dbe2da80d4efd951393fbba90937"
 
 DEPENDS = "libxml2 openssl ldns libmicrohttpd jansson libyaml "
 
-SRC_URI = "https://dist.opendnssec.org/source/opendnssec-${PV}.tar.gz \
+SRC_URI = "${GITHUB_BASE_URI}/download/${PV}/opendnssec-${PV}.tar.gz \
            file://libxml2_conf.patch \
            file://libdns_conf_fix.patch \
-           "
+           file://0001-include-utilities.h.patch \
+           file://0002-reorder-header-files-and-include-time.h.patch \
+           file://0001-Fix-implicit-function-declarations.patch \
+"
 
-SRC_URI[sha256sum] = "c0a8427de241118dccbf7abc508e4dd53fb75b45e9f386addbadae7ecc092756"
+SRC_URI[sha256sum] = "5a68d62ea0ea3a6c61e9f4946f462c7b907fbe6bccc9e8a721b7fe0f906f95d0"
 
-inherit autotools pkgconfig perlnative
+inherit autotools pkgconfig perlnative github-releases
 
 EXTRA_OECONF = " --with-libxml2=${STAGING_DIR_HOST}/usr --with-ldns=${STAGING_DIR_HOST}/usr \
                  --with-ssl=${STAGING_DIR_HOST}/usr  "
@@ -32,5 +35,3 @@ do_install:append () {
 }
 
 RDEPENDS:${PN} = "softhsm"
-
-SKIP_RECIPE[opendnssec] ?= "Needs porting to openssl 3.x"
-- 
2.53.0


