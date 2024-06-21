Return-Path: <ricardo@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34CC2BA18
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 00:02:44 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.61850.1718928163881594587
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Jun 2024 17:02:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=Rdfeh6rY;
 spf=pass (domain: foundries.io, ip: 209.85.216.46, mailfrom: ricardo@foundries.io)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7fe2dcdf6so792073a91.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1718928163; x=1719532963; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7f6qYzp0YGN2KUQ/2Fzh8KKFiHCNivukAWHLX+52ak=;
        b=Rdfeh6rYPAHL3quMZB4WsEHDsy4UGsotj1E73sxNlr7XowFZLTOwyh/+QWm505h5Ox
         AgSUUxdiRTlEZ51DNZ+LwNwHQBbINXYT7FEdSH8MZFTfjpyrYvFMJa+AyPDjSeroHver
         FCxzPnkgL8T3Xatu0k+rBlL5EI4743SjXWejdS9a3FodxUFCe2W3nGQyd5rwaAvSL9Jm
         mqJoWyPrPt3Hes0BSAnB8DvMqZ3jg8hicZCAwrqsV/8t+jq1mVRjGRlgwSuG4BrzNpQq
         Zgg77tr82hiDXrARwjdeHWMuD5Iyw6h8/LM53VgSHfThKkf8i3xUD3VMnlT6z7NQy/49
         DSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718928163; x=1719532963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7f6qYzp0YGN2KUQ/2Fzh8KKFiHCNivukAWHLX+52ak=;
        b=NqLi8wpi2hkiEqw6qW3T1qeTRbLGEj8p7tcj6bpKelMsTsnjg2fZHERqtTniHaErXS
         yrjRB7+J0F9vCm3YRVVC8xGIB1sN+TiHwZ40CpnQ2S63gHeq3bBBQYi+k8mWDTUF/YY2
         jRi9GK30pUSSzDsaOxU9Xb2LZamxBHzj9YB+NQgua1Or/0QuqHTqvOufTZnc5SRL3OES
         1N5hGChl5EyK/VUVu15e6nCnek3veyrc93UoXRF0GFu2OMbWvyuOpbqnZRKToRmlLcVZ
         +2WsZN/h5IL7FQcFa3vqadSnHXEqnCSwNP/QIgiQ2vxmpQeN0xjvDIWGAg41ScVSnXh4
         By2w==
X-Gm-Message-State: AOJu0YxfKvfkI/j30bkLSLt9kc/A0QlpZLCFWXt81ZhyBm6h8VpK73qq
	WfxXUHSHTDCVWt6gd+ZKDeCl4aDUfhig8ctFJRW6r75BdxgDFeWcAHHBsolrHEQLb88j+FGAwBM
	=
X-Google-Smtp-Source: AGHT+IGxuW1pkqqF16cx8nH5YrjXdZQnCJUb4CAcxfdhbw2VZjky9iKlATlnfdiWPVcM941R214KvQ==
X-Received: by 2002:a17:90a:d58a:b0:2c7:c6a1:42d9 with SMTP id 98e67ed59e1d1-2c7c6a144d7mr5030654a91.49.1718928162347;
        Thu, 20 Jun 2024 17:02:42 -0700 (PDT)
Received: from evatuf.domocacupe ([179.117.98.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4775ba4sm2337943a91.0.2024.06.20.17.02.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 17:02:41 -0700 (PDT)
From: Ricardo Salveti <ricardo@foundries.io>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security] [PATCH] tpm2-tss: drop libgcrypt
Date: Thu, 20 Jun 2024 21:02:36 -0300
Message-Id: <20240621000236.2872164-1-ricardo@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 00:02:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/361

Upstream removed gcrypt backend as part of the 3.0.0 release
(https://github.com/tpm2-software/tpm2-tss/pull/1781), but it was not
removed from the recipe during the update.

Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
---
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb
index 9a57308..a27acca 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb
@@ -4,7 +4,7 @@ LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
 SECTION = "tpm"
 
-DEPENDS = "autoconf-archive-native libgcrypt openssl"
+DEPENDS = "autoconf-archive-native openssl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
            file://fixup_hosttools.patch \
@@ -92,6 +92,4 @@ FILES:${PN} = "\
     ${sysconfdir}/tpm2-tss \
     ${sysconfdir}/sysusers.d"
 
-RDEPENDS:libtss2 = "libgcrypt"
-
 BBCLASSEXTEND = "native nativesdk"
-- 
2.34.1


