Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD6D0C5E5
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.7394.1729844570653067891
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HRYmszUW;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso2595955e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844569; x=1730449369; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6VdBHnb5CKD1AfTY2gxXaX1I1R3P3rf4TrdTQZy+4E=;
        b=HRYmszUWEmm3iikKUDHMcn7gCGbrxewwK94CFwRGpDhks8NL5cpS9/uDM0WO9ZtY5a
         sncecFOHC/WAjPhE9y7ypkfu8643OM3ioEaa8nVwIuuhSbHbYGb/sQIsB/y9aGK2x7TS
         9uAVdX9QpED0bi4LLpn9Yf95Oi2o2TrffmVN6ZulyQr5xWski5B2nhY0bTdt44c2cnz4
         U1uPgdHc5nWg26krvvOVlk79L4THTu/56TKXayvbbJnmSOzzQYfGmsB47tpYBo4vpubj
         Ki1HKC5Zq+K71whmCWwdaQL95U7i8y8l+Izz+H/N499E7kHhLzxl1tMEVCQwMArIVbMB
         hFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844569; x=1730449369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j6VdBHnb5CKD1AfTY2gxXaX1I1R3P3rf4TrdTQZy+4E=;
        b=MvifPpJJ3xO2nzfb+Qd35J+cHaw4aN0NXXZvtW6H+6SAuQO2wqUyzM1HBBFHGDpkxz
         xckD6TYxHsbUTHKKCeTj9Q882zgx7XW5T8x3qhAMhTcMiY+7RnL8nN9KRh8uRYqZPgFR
         w+x26hAyLDqrDaJnAD3reLZUkUdZYZ9wxhPOSKWJZx2aShUyVYFVxMwNibU8tjCQCI+v
         kF+4yUlu+AjH6C/RlksYUUvS30Ve/+WnB7bLB4vNM84Rp9EIoFBgtayHacKwwISp5V/Y
         ubKTUPPr5TFdciHXmHg16eMvi8IamBdFBTE4Wlzjji3/NPeaZ3SVy1BkN8k0afTyyaRD
         v5Vw==
X-Gm-Message-State: AOJu0YypsbTiCeYBiMV8e+LC4jMgob8N9wTB5qDhGtlk8E1sl1ZUCGvm
	+4bJ7BuoBpKd2dCSMg2pt2lSFBjBywuL0aH2obRJ6VfraR5PQozT67RPTJeX
X-Google-Smtp-Source: AGHT+IH3rehyyeUe3LbBY1LtaPfmPOfSi/VXDeMu88ExheS4lpAIqK4KDEimD66mmr3BRLLDeOBavA==
X-Received: by 2002:a05:6000:1f8f:b0:37d:4548:2d70 with SMTP id ffacd0b85a97d-3805b4ab1d9mr259558f8f.11.1729844568450;
        Fri, 25 Oct 2024 01:22:48 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:46 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 04/10] sssd: fix installation sss_analyze python3 files
Date: Fri, 25 Oct 2024 10:22:33 +0200
Message-ID: <20241025082239.3468351-5-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/752

SSSD has introduced the internal tool sss_analyze since 2.6.0[1].

	Add log parsing tool which can be used to track requests across
	responder and backend logs.

sss_analyze is a python3 script[2] with modules[3] that is run by the
sssctl command analyze[4][5][6].

The autotools installs the files to ${libexec} and ${python3dir}[7]. The
latter is set if the configure option --with-python3-bindings is set
only.

As a consequence, the Makefile installs the python3 files to /sssd
instead of /usr/lib/python3.12/site-packages/sssd if the option
--with-python3-bindings is unset:

	gportay@archlinux ~/src $ find build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/modules
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/modules/__init__.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/modules/request.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/modules/error.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/__init__.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/source_files.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/source_journald.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/source_reader.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/parser.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/sss_analyze.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/sssd/util.py

The sss_analyze tool is unrelated to the python3 bindings; the sssctl
does not condition its code if the python3 bindings are unset.

Therefore, sss_analyze has to be installed even if the python3 bindings
are unset.

This ensures the variable python3dir is set to the expected location by
adding it to --without-python3-bindings if the python3 feature is
disabled.

	gportay@archlinux ~/src $ find build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/modules
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/modules/__init__.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/modules/request.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/modules/error.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/__init__.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/source_files.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/source_journald.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/source_reader.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/parser.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/sss_analyze.py
	build/tmp/work/core2-64-poky-linux/sssd/2.9.2/image/usr/lib/python3.12/site-packages/sssd/util.py

[1]: https://github.com/SSSD/sssd/commit/82e051e1f15060554ecacc07107c82675369e0bb
[2]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/analyzer/sss_analyze#L1
[3]: https://github.com/SSSD/sssd/tree/2.9.2/src/tools/analyzer
[4]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/sssctl/sssctl_logs.c#L47
[5]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/sssctl/sssctl_logs.c#L605
[6]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/sssctl/sssctl.c#L337
[7]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/analyzer/Makefile.am#L7
[8]: https://github.com/SSSD/sssd/blob/2.9.2/configure.ac#L394

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb    | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index e8f3031..2035cd0 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -54,7 +54,7 @@ PACKAGECONFIG[manpages] = "--with-manpages, --with-manpages=no, libxslt-native d
 PACKAGECONFIG[nl] = "--with-libnl, --with-libnl=no, libnl"
 PACKAGECONFIG[nss] = ", ,nss,"
 PACKAGECONFIG[oidc_child] = "--with-oidc-child, --without-oidc-child"
-PACKAGECONFIG[python3] = "--with-python3-bindings, --without-python3-bindings"
+PACKAGECONFIG[python3] = "--with-python3-bindings, --without-python3-bindings python3dir=${PYTHON_SITEPACKAGES_DIR}"
 PACKAGECONFIG[samba] = "--with-samba, --with-samba=no, samba"
 PACKAGECONFIG[selinux] = "--with-selinux, --with-selinux=no --with-semanage=no, libselinux"
 PACKAGECONFIG[ssh] = "--with-ssh, --with-ssh=no, "
@@ -88,9 +88,6 @@ do_install () {
     rmdir --ignore-fail-on-non-empty "${D}/${bindir}"
 
     install -d ${D}/${sysconfdir}/${BPN}
-    install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
-    mv ${D}/${BPN}  ${D}/${PYTHON_SITEPACKAGES_DIR}
-
     install -m 600 ${UNPACKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
 
     # /var/log/sssd needs to be created in runtime. Use rmdir to catch if
@@ -112,7 +109,6 @@ do_install () {
     # Remove /run as it is created on startup
     rm -rf ${D}/run
 
-#    rm -fr ${D}/sssd
     rm -f ${D}${systemd_system_unitdir}/sssd-secrets.*
 }
 
-- 
2.47.0


