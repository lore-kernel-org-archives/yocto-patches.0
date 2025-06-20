Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC06C77B7C
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 12:08:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.6258.1750421294758028438
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 05:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E6ssU+bV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453643020bdso6757955e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750421293; x=1751026093; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0oJFMQrzSSLeWkb6BaSZ4+j7EMMpXP9po/px193uC0=;
        b=E6ssU+bVTTZ7q9Yj6VqfcuKk/2kB4N++bTZTR0SjKvLYrfnclbz8MVKfefnVWj1X12
         Ld4quLwBfNcdDqE0FsvXTXdE5s9uG0PkQ0aqjleQtHtFpcCFm8oKRgEcqvR/dZgISvQw
         CW9z36R42+TXed6DwTZHvuB6wMHWDx7bjGYak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421293; x=1751026093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0oJFMQrzSSLeWkb6BaSZ4+j7EMMpXP9po/px193uC0=;
        b=qLByK2Xl69uwZDS94S+KHaDAfMWhvp8N7vBYIXbLtKjQxjJK4cO/tj1FfN2aPPUUtR
         BUzfZ6A9a+LdHGai7kMdZGvHR/r+g7x7z66L/O62c+rfzPgw5EKR+eMtA1f31HpUwBWt
         /cI1Tt5LHk+ccMlxxVClla1kCB6zzBMWSaNlPpBkpxuIXw9fpeS3StxuMS6cUBrYq1Xq
         BSEYCeS9PlfuSW38DF0fBg+3Te943Lu8PmAq24aDlRYbtEZ0me4+Vv+XzMN4k33VaQNp
         ufl4ByJuV+WN3YBXFxyZE52pUxjN+yAMEZEfbMB9FF+kD6MS6/DT+7WMgF9j3TPRgxvi
         KQ7A==
X-Gm-Message-State: AOJu0YyTV/GoefdEFG5qehxfpAR+1kIxDzIpnHwVoV2IBY2MDHJT1LnE
	z0h2WKTBgeB5dyup0DJ5Qw4m0xOE1mq2/EUNpb0NdDoEGko+bDLViztd18AV3qpmz4BhJjw5vNa
	8pAXM6kY=
X-Gm-Gg: ASbGncsoRcvT2FIjNMfFSa9MlQ97/hwsno9+e1jK2dx95D0m/01ZiRPOm8sSiToIA1A
	CCOzxK8KDad+B5evApTfraSe9K1ZkkeEBKAweBHPOBK093HPk/dblWcdsjCMm/FxtePZ6pl8lHr
	HaPDns6SIj4o+DXL/aVtav9MB7hMJ9qs6WHjqXb56bwnTvTqepp9NWdoNd2nCpHer298OK86Qiw
	OUM5zKkMzZo/ZkJR+oOHQPYhv7iZjPgviQRk7YUVVV8E394vjE/uMzKYLUHdiDANpYsb7bSME6K
	HGwjy7pmt96BP1ZGuJxSAzW1jUcy3wTFqLfqkKs6MGIxfa26LcDy3iIKxc5VVUlVOgHS8QxdNNf
	VIh93hLjLXNFn4yE=
X-Google-Smtp-Source: AGHT+IEam69D+psSfINK9gIzE62/hju4VdEBwlXB+lshEXWGLeLYua1forv+dJoLb2k5mh4+4VoIxw==
X-Received: by 2002:a05:600c:5025:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-453659c5915mr27891215e9.9.1750421291811;
        Fri, 20 Jun 2025 05:08:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b606:370e:6752:7b3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f104d4sm1939656f8f.11.2025.06.20.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:08:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 1/2] recipes: Update to match S/UNPACKDIR changes
Date: Fri, 20 Jun 2025 13:08:09 +0100
Message-ID: <20250620120810.2480232-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 12:08:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1670

Update to match the recent changes in OE-Core where the unpack
layout changed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb             | 2 +-
 .../mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb             | 2 +-
 .../mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb         | 2 +-
 recipes-support/libiconv/libiconv_1.18.bb                       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb
index 68e77fa..e2cb7ac 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb
@@ -2,7 +2,7 @@ DESCRIPTION = "Header files from the MingGW-w64 project"
 
 require mingw-w64.inc
 
-S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-headers"
+S = "${UNPACKDIR}/mingw-w64-v${PV}/mingw-w64-headers"
 B = "${WORKDIR}/build-${TARGET_SYS}"
 
 inherit autotools nativesdk
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
index 0cdbbd1..b49cada 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
@@ -4,7 +4,7 @@ require mingw-w64.inc
 
 #SRC_URI += "file://0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch;striplevel=2"
 
-S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
+S = "${UNPACKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
 B = "${WORKDIR}/build-${TARGET_SYS}"
 
 inherit autotools nativesdk
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
index 6cae85e..baf0782 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
@@ -2,7 +2,7 @@ DESCRIPTION = "Winpthreads runtime libraries from MinGW-w64 project"
 
 require mingw-w64.inc
 
-S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-libraries/winpthreads"
+S = "${UNPACKDIR}/mingw-w64-v${PV}/mingw-w64-libraries/winpthreads"
 B = "${WORKDIR}/build-${TARGET_SYS}"
 
 inherit autotools nativesdk
diff --git a/recipes-support/libiconv/libiconv_1.18.bb b/recipes-support/libiconv/libiconv_1.18.bb
index c7c6332..e4e6a62 100644
--- a/recipes-support/libiconv/libiconv_1.18.bb
+++ b/recipes-support/libiconv/libiconv_1.18.bb
@@ -15,7 +15,7 @@ SRC_URI = "${GNU_MIRROR}/${BPN}/${BPN}-${PV}.tar.gz"
 
 SRC_URI[sha256sum] = "3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8"
 
-S = "${WORKDIR}/libiconv-${PV}"
+S = "${UNPACKDIR}/libiconv-${PV}"
 
 inherit autotools pkgconfig gettext
 

