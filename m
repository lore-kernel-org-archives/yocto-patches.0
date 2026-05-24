Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B696CD5BB1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:04 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7159.1779624964022663280
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RQGNxQNh;
 spf=pass (domain: konsulko.com, ip: 209.85.222.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-95fa8111713so1627976241.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624963; x=1780229763; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXgKG9kHYaF7F/qtoSM3l0FSDA2aR7vBLkknzTj5q0Q=;
        b=RQGNxQNheUf9dlPRULkYqEES6AWoSZYw0Qhzcs/Kb+AkJSBBoNImhxi70Wfh7pxwlM
         t49iMdDK4s39lA8k51b3iHbWlXh5fRqVfqmQ0NBqNpqxaURtAreRpoJ8veoeT3avukjO
         qFGCVaszyGpm2pnbwFJJaThOYhqKjMVT/3pN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624963; x=1780229763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXgKG9kHYaF7F/qtoSM3l0FSDA2aR7vBLkknzTj5q0Q=;
        b=hS+cA1iUVqoNdOMD7lvegVTbLAPdtTB6JO5m24mUZz+X9/CeHoyyYIiLAmUYQE8n4W
         c++rXoqpU/Yod9U6H1jfg6TaDDMB5yG3E+r5kB77qI3d9Fj9IwWISjBcnZxe7N6UQD/+
         kEUxz1CvwAzn9IJBbey9kyuTkhZX7MVkdWQrEGoqCnyFesLBLqif4jwwX+bLk4aMDxVx
         nPhLBgh/a0o+HLIoohNM3UQVg08in7FV79FrUCT9A1uuootlYmE7Gmz2OYX/nllCttzN
         r5YgyxHnA18PEAOS/VHFdgluf5+fH2y/kjWTLhHglHnm9FUJFKH6z7tYb+Y+q/6878rl
         pL4g==
X-Gm-Message-State: AOJu0Yw3++wfQVEM1sg5KdRelpy4VnvehuJinNzg6mtvrUFi9SQGTYM9
	FbsozF8G4ONXpkLqkQix8a+DYDRe8fN4sBw5LE+ybdhYdTA6a+p3DUwf43PYxAjZ6exRCp/q8FD
	0u2XF
X-Gm-Gg: Acq92OHPzg0T/YwCrJldcPv3C1QA/Kjs+xQgfB4VngkyNvwJcU4rCSscn12Feh1cavt
	TYcTdRx0IDWp98XqGXz60u7VnT1KtRpvUmgBcgotFGKfe6NQALqk7VsR1+rGrL6FY0XbIlmmDOT
	hfSDXEPS/pF2XrXtHcQOLzKCh42AIQ+CQsLC+F1E3lFBw+k0ivsU1PIQx2OMIkX37VP+cwgaPxn
	9apYYcLlmlLUBGOZZ1yTT03ilxee756d1Et9c3vmIuaIh2Y0OZo9lsGpDNP+buLznu4zZz5kqJs
	jHE/sb7RMMGJyvsMqmHFQqV+mMvcaHvThMpjTh2r/x00sfs5gLaOTHI8aF/8kFqLqf9LXL7qhg8
	EGdtrCk88zNdIwbkcSaVFnAjUTLhyC+y26d6iMSBiaCalczZe3EM39k94FT1XAn0HapV4VZA5+B
	8OvqcDFbFkIip6In1Qokrms6ZLQ5guJcWskZt8SLUHgd1mfYBO7ALNJmBRK10hMdfsVo/XgIWB0
	a2qE9Z55vdQzkpWvnJbwXsMTTBq8BLnKh+mU08JBC7ocSOKrB1Kvv/IJn6BlNhr
X-Received: by 2002:a05:6102:2b97:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-67c7ffec83emr4482319137.19.1779624962708;
        Sun, 24 May 2026 05:16:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 09/13] tpm2-tools: make efivar optional
Date: Sun, 24 May 2026 08:15:36 -0400
Message-ID: <cdb4e444acbb2b9df467d716241a206c9ea6d3b0.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4015

From: Peter Marko <peter.marko@siemens.com>

Previous commit made this a hard dependency because it's autodetected.
Instead of that, make it configurable so it can be disabled (roughtly
equivalent to behavior before that commit).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index fec5e1c..e1a0c5d 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -4,7 +4,7 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl efivar"
+DEPENDS = "tpm2-tss openssl curl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
@@ -14,4 +14,7 @@ UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
 
+PACKAGECONGIG ??= "efivar"
+PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
+
 BBCLASSEXTEND = "native nativesdk"
-- 
2.53.0


