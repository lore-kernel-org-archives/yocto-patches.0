Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF46C3065B
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:01 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.27019.1719409194721140707
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CqyGj+kb;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: gael.portay@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f090093d8so4386068f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409192; x=1720013992; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc5D7bOsvUuGZPpCKj60c9MPLqRCK0Q4SvpwoQxkCko=;
        b=CqyGj+kbq8GE5mb6j7gsRNn3LHhfmKONMbzVltlREooASygBGXtaCQJvOdCSAeYKB/
         ob3BuH6AmW0FldrbzdvX6E2Fn1oauwTS+A5Kh4Nx8G9nK9qe3cH59IwuI+QCB5hZ5voz
         ip9uMOI5OtW7TA1D3ODW9sWm8cFtzIikRNSfqY3WWQjtF45l9q7khnZl9Z6kw2y9TtYw
         j3QYExgJVrK0KSR+4s+9eDqWjtCNFFLv4rm89dXV/jH0lmxa4O5NPF+k9Z11IjoVuhwb
         e3T+D7IzRiOdpwas9GcAdYH4lSUoWlDCJRutT4pW1Qplr8Ijrc3NCIu/woWgFCak9P1h
         F7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409192; x=1720013992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qc5D7bOsvUuGZPpCKj60c9MPLqRCK0Q4SvpwoQxkCko=;
        b=JSm37VSVGJEInFDLQ83os7GSIRf1s44y7m01FZe8pDFCYRwTGvSn3I7SGjdCYtxGG2
         h2IIkPSablf4vweBBwEhRBOKb9hq86v1DzYTc75NmVRhWZZGaMP8TlhkjBJnAn8tRcUK
         RLqlnVy5ga4JTlIW3ynZLFOMe9whqOxCTW4JnU5jh62U3CreW5Bg62r7ApZU0CeRKiM5
         1qmyhp9GdW4PB32ETjQut3IzrwXMCy7Iq1mlTF0ae2wE2nCoBfVUG1utADjJ8I7S1Uxb
         MR1PnAFUtBcMCmvPIK4dSIE9y+B36mKh8anDaCeUfBJ5pH8A27TYaq/TAhqcnxGYb0Rh
         hBvg==
X-Gm-Message-State: AOJu0Yzwub84c+oI6Uj7+GzXZdPseoLxcbo0lGKhHj0qU3PrxjqVkDeK
	o6fdZfcExs0yeeSIJvIgYvK+NPndaQHqjROY36j+3v9Q6Y6YAgqD7lFfQexI
X-Google-Smtp-Source: AGHT+IG4z7URqu4ck9pnh7WDIvRm+duNAIeGgN/cC0AwlhbVu9ov25bJFgOGw7ZWwEcEj5jzDjNBLA==
X-Received: by 2002:a5d:4985:0:b0:354:fc65:39d6 with SMTP id ffacd0b85a97d-366e7a1bfbdmr7405586f8f.26.1719409192293;
        Wed, 26 Jun 2024 06:39:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:51 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 4/5] sssd: fix shipping python script and modules
Date: Wed, 26 Jun 2024 15:39:12 +0200
Message-ID: <20240626133913.790145-5-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/378

The project installs the python script sss_obfuscate to the /usr/sbin
directory and the modules to the /usr/lib/python3.X directory.

The recipe does not ship the python modules to the package sssd, and
thus, it raises the QA issue attached below.

This adds the python artifacts (sss_obfuscate script and module files)
to the dedicated package sssd-python.

Fixes:

	NOTE: Executing Tasks
	ERROR: sssd-2.5.2-r0 do_package: QA Issue: sssd: Files/directories were installed but not shipped in any package:
	  /usr/lib/python3.10
	  /usr/lib/python3.10/site-packages
	  /usr/lib/python3.10/site-packages/SSSDConfig-2.5.2-py3.10.egg-info
	  /usr/lib/python3.10/site-packages/pysss_nss_idmap.so
	  /usr/lib/python3.10/site-packages/pyhbac.so
	  /usr/lib/python3.10/site-packages/pysss.so
	  /usr/lib/python3.10/site-packages/pysss_murmur.so
	  /usr/lib/python3.10/site-packages/SSSDConfig
	  /usr/lib/python3.10/site-packages/SSSDConfig/sssdoptions.py
	  /usr/lib/python3.10/site-packages/SSSDConfig/ipachangeconf.py
	  /usr/lib/python3.10/site-packages/SSSDConfig/__init__.py
	  /usr/lib/python3.10/site-packages/SSSDConfig/__pycache__
	  /usr/lib/python3.10/site-packages/SSSDConfig/__pycache__/ipachangeconf.cpython-310.pyc
	  /usr/lib/python3.10/site-packages/SSSDConfig/__pycache__/__init__.cpython-310.pyc
	  /usr/lib/python3.10/site-packages/SSSDConfig/__pycache__/sssdoptions.cpython-310.pyc
	Please set FILES such that these items are packaged. Alternatively if they are unneeded, avoid installing them or delete them within do_install.
	sssd: 15 installed and not shipped files. [installed-vs-shipped]
	ERROR: sssd-2.5.2-r0 do_package: Fatal QA errors were found, failing task.

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 recipes-security/sssd/sssd_2.5.2.bb | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index 9991667..4084d07 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -143,6 +143,7 @@ SYSTEMD_SERVICE:${PN} = " \
 "
 SYSTEMD_AUTO_ENABLE = "disable"
 
+PACKAGE_BEFORE_PN =+ "${PN}-python"
 PACKAGES =+ "libsss-sudo"
 ALLOW_EMPTY:libsss-sudo = "1"
 
@@ -151,6 +152,10 @@ FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
                 ${libdir}/krb5/* \
                 ${libdir}/ldb/* \
                 "
+FILES:${PN}-python = "${sbindir}/sss_obfuscate \
+                      ${PYTHON_SITEPACKAGES_DIR} \
+                      "
 FILES:libsss-sudo = "${libdir}/libsss_sudo.so"
 
 RDEPENDS:${PN} = "bind bind-utils dbus libldb libpam libsss-sudo"
+RDEPENDS:${PN}-python = "python3-core"
-- 
2.45.2


