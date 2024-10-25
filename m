Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68068D0C5E3
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7397.1729844573042529200
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ciEtk/bl;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so2623825e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844571; x=1730449371; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1AP4gcWy6KMj/mrX6sWpKYQXadpf1z7Mq3kc514bSU=;
        b=ciEtk/blRlVS0Y9BMaq/wrCjrGy1mw6UishYL/GSHX9XYi/lf8YkPVhwyGlY3pJVOJ
         p0aHAPRtKB/ec0mdKhSIFo/XCRzfKY8GIFT6NzojVHs0BuEhrrpH3cbYzzzhkWPL0Mm1
         MvE9Zkgc+ackeQIQWoFLMWvm3YqtWQF6C9+BdIwYDZgUYce4pZ+dqAe64WZH/cGf9wAr
         g+ZNzB0yMq4EgnSQ9N8vkgUg9Ghup5+UbeQci7yemzxcBuCapiAGXPgcbReQei8VxbVX
         jV5vHbwEyx+O3dxBQwmWkDkNJhNwX6qRvAoqIV9CT4aoaaIekzgS4727E8enC7vpyYfc
         JWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844571; x=1730449371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1AP4gcWy6KMj/mrX6sWpKYQXadpf1z7Mq3kc514bSU=;
        b=Q6/4+BHypN1Iff3QDo7nHlhLN8YX1qJAvMvsXO+ssbV0dfnrBVCjKBraNU7J3peDzp
         kxEuEsfurPxprPrD/QGfgHeL+mBi+fatZTB10N3QNvHDsRWfjvor+HL6U2798BZ0SF0Z
         u6XYVfHMLq6yDGTW4YPxlt+k0/8tLPGovP+jGZ6qeN22HzBc4+ZLRlnbk5mxQbIfDvsl
         7J2noe9f7QvYTI369IcPTsmumiKYP8kBUxWm+IVuGAHt3kEGH4X8lY33l9jFlCrmNTVY
         dnlKH0MWUk8GxS0JGyBiEGNU6Bze520CXgDIsFrN6mWQgVnuql9A/maiQ1Sgt9LpUxUg
         dxIQ==
X-Gm-Message-State: AOJu0YwZBFkXCYIhO08govwOhyeAtwWDhNCoTuDNpjkcP5OErXsVa98o
	3GeRjzTrtO0DMGRMVaITar0xZ9YEDjgbt7oNEllQzllEyT/mvT3tIR7XKosM
X-Google-Smtp-Source: AGHT+IH9Lpoyq8MimM1YdDJqyaruw5fxDhBK9/Pc+LOAI/fWbjDrPLpiKh6owKaHn1h7zJY+Z0Ygnw==
X-Received: by 2002:a5d:6da5:0:b0:37d:4517:acd0 with SMTP id ffacd0b85a97d-3805b4ab13bmr273105f8f.9.1729844570901;
        Fri, 25 Oct 2024 01:22:50 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:49 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 06/10] sssd: fix missing python3.X-config script
Date: Fri, 25 Oct 2024 10:22:35 +0200
Message-ID: <20241025082239.3468351-7-gael.portay+rtone@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/754

The configure script checks for the utility python3.X-config to be in
$PATH; that script is shipped by the package python3-native.

The recipe does not depend on the package python3-native which causes
the task do_configure to fail.

The recipe inherits from the bbclass python3-dir that does not install
the required script to the sysroot. The bbclass python3native inherits
from (the already inherited bbclass) python3-dir and it adds the missing
dependency to python3-native.

This fixes the configure error by "upgrading" the inherit bbclass from
python3-dir to python3-native.

Fixes:

	| checking for python3.12-config... no
	| configure: error:
	| The program python3.12-config was not found in search path.
	| Please ensure that it is installed and its directory is included in the search
	| path. If you want to build sssd without python3 bindings then specify
	| --without-python3-bindings when running configure.
	| NOTE: The following config.log files may provide further information.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 2717e4e..16e1c24 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -31,7 +31,7 @@ SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-inherit autotools pkgconfig gettext python3-dir features_check systemd
+inherit autotools pkgconfig gettext python3native features_check systemd
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-- 
2.47.0


