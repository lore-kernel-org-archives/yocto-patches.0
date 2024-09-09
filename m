Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15418ECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 12:59:14 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.52225.1725886749177708040
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 05:59:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=D0VBpUg2;
 spf=pass (domain: mvista.com, ip: 209.85.210.169, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798661a52so2543014b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1725886748; x=1726491548; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AzMyaRtsH5E85aJS8OX/aqZIxEG+zemakEU4ahy2ts=;
        b=D0VBpUg28Wb6KQGO68TGFWdPAe7oIdQ4CYeEAi5/oGXeDKaG1ddY3H85+g9V6KWaYy
         SaQwWxN/ZbKk4T3f2Tco9uOAoE48UZpYsDlOPFIfLSVaRGW8psyqp559rU+mtRozXYwk
         lcXba5MnDZTy5CpC+nX0OgclxUKfI/LF7D1Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886748; x=1726491548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AzMyaRtsH5E85aJS8OX/aqZIxEG+zemakEU4ahy2ts=;
        b=suzxAngt2tUucVDjrtfGOlFjCGNG8eTboYhN58Y8GyQ7EKghUt1+SYurDEzU3zQYL7
         c47JCgwRBhXaBSjhKZxWFHSe9AIQr5gQ1VMUEravHMeR4KYhe54x7kw0VrLsn5zFNUkT
         HLuvrEKH0nXxZU/IbXHFOWP8XG9222t9YH/qkM6OrttuLhyTjuTU1Ko/F4cNiJKXeGje
         YqZXF9PUhIWH301Q+D1Ex1AWV0t1F7Tg1zr5AiCm5kDSL5UIr/E5iQz3+imgq3jF72XD
         uSoMrFSdMPxQlziw9QNxRo865y5TUiF4aD4uRwURpOR1NUZvDzzV/1iynh/DEeX/pBBT
         OKwA==
X-Gm-Message-State: AOJu0Yyf7D0uYzaEC4qOC/IL2Duc3yJv+8FCMFYSAia2yXVzFHGzRcyG
	/lzUtCye3RgvQmFoLwrZdQ1PJ6JCVIsPTknjyiTqW8GmzTF+Zwz67LgPRVAlYqNU09r3XdTmhTL
	+azI=
X-Google-Smtp-Source: AGHT+IEb2F2nKb/vYLq4EBHIGUQArQ8mNXShjlY/qWDvq8gSBQl/CkOxedi0pvR+WxtzpgMoJvUIzA==
X-Received: by 2002:a05:6a00:816:b0:70e:aa7f:2cb3 with SMTP id d2e1a72fcca58-718d52dc4d1mr20831661b3a.2.1725886747891;
        Mon, 09 Sep 2024 05:59:07 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882d:7454:9674:8169:5358:32b5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c167csm3467380b3a.51.2024.09.09.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:59:07 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][kirkstone][PATCH] tpm2-tools: Upgrade 5.2 -> 5.7
Date: Mon,  9 Sep 2024 18:28:57 +0530
Message-Id: <20240909125857.6639-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 12:59:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/624

From: Vijay Anusuri <vanusuri@mvista.com>

Include Security fixes:
Fixed CVE-2024-29038
Fixed CVE-2024-29039

Changelog:
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.5
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.4
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.3

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../tpm2-tools/{tpm2-tools_5.2.bb => tpm2-tools_5.7.bb}  | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.2.bb => tpm2-tools_5.7.bb} (51%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
similarity index 51%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index c20af7e..bd3d34b 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -1,21 +1,16 @@
 SUMMARY = "Tools for TPM2."
 DESCRIPTION = "tpm2-tools"
 LICENSE = "BSD-3-Clause"
-LIC_FILES_CHKSUM = "file://doc/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
+LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
 DEPENDS = "tpm2-abrmd tpm2-tss openssl curl autoconf-archive"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "c0b402f6a7b3456e8eb2445211e2d41c46c7e769e05fe4d8909ff64119f7a630"
+SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
 
 inherit autotools pkgconfig bash-completion
 
-do_configure:prepend() {
-    # do not extract the version number from git
-    sed -i -e 's/m4_esyscmd_s(\[git describe --tags --always --dirty\])/${PV}/' ${S}/configure.ac
-}
-
 # need tss-esys
 RDEPENDS:${PN} = "libtss2 tpm2-abrmd"
-- 
2.25.1


