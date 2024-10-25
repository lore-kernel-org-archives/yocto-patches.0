Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757AD0C5E3
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:23:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.7400.1729844576536733764
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Rpgm6T3E;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so2296085e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844574; x=1730449374; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADahBH2a9jmL6wWgGmLVa2bh23t+gUfsvyzgcPdkuUM=;
        b=Rpgm6T3ExenXhbFLrpU9tm687tI7X87qWFDr+A0VvOvVktaBj7rP6hfJhLvkROVPyS
         N+uxFaNBUFgzn/Qn0wnE4XBR4u4YrUzmTAgO7lDApF918R2N03/3cubVoSfpN4fmtuvd
         7SPpFNHUbv5nvqbS35MyWUAHbb+O4adInthjMmzxCzzdm2NO/+WBykG6Ei3i/z4V3UXp
         ma4YWi7LlqXZUTbH6CeGIQeq6XTl6OBIYSiL2DylVVl5H71T36M/Cl7PPD5HVicWFmeW
         V9co11m4A6bFBtA4keJniPt/cG9k+4OZm8f5NS+/AqcY+WaL7Dq7/O3sIsDPP/Ax9uyY
         zA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844574; x=1730449374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADahBH2a9jmL6wWgGmLVa2bh23t+gUfsvyzgcPdkuUM=;
        b=dU/nfpT+Qfd9CfhNPSBhyqjn9e8seDKsI88JvXZMqti2ZXqXECBl4FhhxeUyYMy+oL
         07GESfy5trXViUmuY8LjjNVi85DAhIRuKhYkmKkX62wvq1Ki/wr2S9XS9N11MdD2z92x
         H036XG3zbSigiN47X52jUe8SuJL2amCpqWkNBvDLPBohJ9V61pfMKXeE5KJZPoM/rmcB
         T0VPGNzD55SyF+zaX2WkwWmuWl+83qUsZI9Ml355CVpV0xG1/zQlmvlDUR953T81FLQo
         vPHkSpjeyCOQWm7cj7jsx+oXAs6vdgf2yDSPAqZw2CrE6C/Ds7bOCD6igQy49tpjPSCF
         nC0A==
X-Gm-Message-State: AOJu0YzxZUqxsdMHsn1roA1AhByyEaJes8UV6xlu2Onl+dbFGK0jjbNW
	1PT06a/O+zYgQagCDZToFjqZYtewNY/pynCogYbWfFZdb2A5nDuyV+kOB3A2
X-Google-Smtp-Source: AGHT+IFy5DDgX5eVRvIoFO+RYYt5r3yg3BW1VEMz901Stt/4WYiHwRMZRNpW0J1u77dBJaShMZ8AEQ==
X-Received: by 2002:a5d:64e5:0:b0:37d:4864:39a2 with SMTP id ffacd0b85a97d-3805b3fd077mr244415f8f.7.1729844574448;
        Fri, 25 Oct 2024 01:22:54 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:53 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 09/10] sssd: fix shipping python script and modules
Date: Fri, 25 Oct 2024 10:22:38 +0200
Message-ID: <20241025082239.3468351-10-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:23:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/757

The project installs the python script sss_obfuscate to the /usr/sbin
directory and the modules to the /usr/lib/python3.X directory.

The recipe does not ship the python modules to the package sssd, and
thus, it raises the QA issue attached below.

This adds the python artifacts (sss_obfuscate script and module files)
to the dedicated package sssd-python.

Fixes:

	NOTE: Executing Tasks
	ERROR: sssd-2.9.2-r0 do_package: QA Issue: sssd: Files/directories were installed but not shipped in any package:
	  /usr/lib/python3.12/site-packages/pysss.so
	  /usr/lib/python3.12/site-packages/pyhbac.so
	  /usr/lib/python3.12/site-packages/pysss_murmur.so
	  /usr/lib/python3.12/site-packages/pysss_nss_idmap.so
	  /usr/lib/python3.12/site-packages/SSSDConfig
	  /usr/lib/python3.12/site-packages/SSSDConfig-2.9.2-py3.12.egg-info
	  /usr/lib/python3.12/site-packages/SSSDConfig/__init__.py
	  /usr/lib/python3.12/site-packages/SSSDConfig/ipachangeconf.py
	  /usr/lib/python3.12/site-packages/SSSDConfig/sssdoptions.py
	  /usr/lib/python3.12/site-packages/SSSDConfig/__pycache__
	  /usr/lib/python3.12/site-packages/SSSDConfig/__pycache__/__init__.cpython-312.pyc
	  /usr/lib/python3.12/site-packages/SSSDConfig/__pycache__/ipachangeconf.cpython-312.pyc
	  /usr/lib/python3.12/site-packages/SSSDConfig/__pycache__/sssdoptions.cpython-312.pyc
	  /usr/lib/python3.12/site-packages/SSSDConfig-2.9.2-py3.12.egg-info/dependency_links.txt
	  /usr/lib/python3.12/site-packages/SSSDConfig-2.9.2-py3.12.egg-info/top_level.txt
	  /usr/lib/python3.12/site-packages/SSSDConfig-2.9.2-py3.12.egg-info/SOURCES.txt
	  /usr/lib/python3.12/site-packages/SSSDConfig-2.9.2-py3.12.egg-info/PKG-INFO
	Please set FILES such that these items are packaged. Alternatively if they are unneeded, avoid installing them or delete them within do_install.
	sssd: 17 installed and not shipped files. [installed-vs-shipped]
	ERROR: sssd-2.9.2-r0 do_package: Fatal QA errors were found, failing task.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index a3b1659..e5cd4d8 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -139,7 +139,7 @@ SYSTEMD_SERVICE:${PN} = " \
 "
 SYSTEMD_AUTO_ENABLE = "disable"
 
-PACKAGES =+ "libsss-sudo"
+PACKAGES =+ "sssd-python libsss-sudo"
 ALLOW_EMPTY:libsss-sudo = "1"
 
 FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
@@ -151,6 +151,9 @@ FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
                 ${PYTHON_SITEPACKAGES_DIR}/sssd \
                 "
 
+FILES:${PN}-python = "${sbindir}/sss_obfuscate \
+                      ${PYTHON_SITEPACKAGES_DIR} \
+                      "
 FILES:libsss-sudo = "${libdir}/libsss_sudo.so"
 
 RDEPENDS:${PN} = "bind \
@@ -162,3 +165,4 @@ RDEPENDS:${PN} = "bind \
                   python3-core \
                   python3-logging \
                   "
+RDEPENDS:${PN}-python = "python3-core"
-- 
2.47.0


