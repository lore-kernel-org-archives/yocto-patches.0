Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C8CA0EF1
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.61167.1755464896085564934
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gD1BGxcD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b274838c01so3171461cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464895; x=1756069695; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYuh9666F2g4zL/6vjCO7tcYSpSKhtpBAcs6JPJTzK8=;
        b=gD1BGxcDfWDlXYIewEzMgAEpqLvu5wE7yeHSwmF3VLWe4T0FBVQxSd0O4/a6Utu+Iv
         0h+MiXp3foP0zxmPPWIHcxZZv8vCXS4xqdQRXAEg8+9MyzfPejTxx++cESDU3T+kDVt6
         LvyOExxUq+vtV7coY/jnuwahGUs6Vdpl6t6Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464895; x=1756069695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYuh9666F2g4zL/6vjCO7tcYSpSKhtpBAcs6JPJTzK8=;
        b=ZcdyMQ2IALlzs/EziHcDp0U+ckjt+ooy2FzHkGCfPAPN262Ilblra2SXzBgVuveLjS
         KKwYCo0Ze+5Z+SAGK1KiYPDEFHZesoQiaD+qN0Aafbo8NuPosxXGfdds80cbXOxHakQM
         DfgoSimVFuDudITXsINL/nkSy+TrgSfAxdhSvH8r/qmHmKwVep/5ZpCmz115r+BwjNt/
         roOFVxsyuw8aieTKH8s6U2H33Wu/2VjHae6xqUUFAaIl1XTIVmXIWbVgiMB2QU2eZnT9
         v6/Cs6ajVxL33ul168iF/PZFKeTCPHTv7RXcqecRzi9uSgi1ouAX6UduhAlyf9lr8SH+
         LpTQ==
X-Gm-Message-State: AOJu0YwI3m3+rBmyo+zIXcrMgdh0toXW+JH5VyyDwFWIu8wrsn5p7kH+
	i8EIzIShE7ZSTGid4cRBHTcqrA3oddpJFuPhjpJIP3l83wXSeDTBvu2EWa3rIxpnyqIdkkUMjd9
	avR1r
X-Gm-Gg: ASbGncuJbnIQx6IQ+zyyhcXJjDi6ckgUH2PwgbaDGtmIwqXpkTRWVYSQm8ovwkjNQKK
	fOQtCQrDRTZENYITIUuHjA72G2TZOqjU4+ceg78MRHKRXreZHtDsU/j28Xef200wHZxB382ALr7
	U0lx+SwYDVIJ3wg+7qJNiVH5QtfbSXCgSoDU7nWZi2FtmcKQqmbzC1xfFD9HNHcwFylm98VaLO+
	5Dfq14MeZpkAY6cvojYdYHjbsgWkksgUDSSLZv5na3Ab4PmQQ96ICYf1VbiXk5JKgo8/EbN7l9F
	7ZfnatM+OddTGbqBnd/1TsmpA7QERYLmDX4MCkXdaYWeyVlAlPmvyZ75A3aV2xzGm8fXX9ZIv9U
	dMHHKx4FqkVMeZsgVdDLrcHbReZgYtb3QlZGUo2/3P7PE7uR1BaT1HHB9NX2d1FdCDvc62v6YPg
	==
X-Google-Smtp-Source: AGHT+IG66mt8GcchwfR6goSHvl1W2pFoiVyIRnaWnXUTFjroTw7l5Ui0nTat+oWMZP4uT/QCn0MtSA==
X-Received: by 2002:ac8:598e:0:b0:4ab:644b:885c with SMTP id d75a77b69052e-4b11e0fd96fmr142714831cf.12.1755464894843;
        Sun, 17 Aug 2025 14:08:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:14 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 5/7] checksecurity: update the debian package
Date: Sun, 17 Aug 2025 17:07:57 -0400
Message-ID: <5ac5c42ea34eaf75c6ac5b78535f7b913789f31d.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2028

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The previously used package (nmu1) is not longer available, use the latest current
one (nmu3). The changelog between the two:

checksecurity (2.0.16+nmu3) unstable; urgency=medium

  * Non-maintainer upload.
  * Fix "missing required debian/rules targets build-arch and/or build-
    indep": Add targets to debian/rules.
    (Closes: #999082)
  * Fix "Removal of obsolete debhelper compat 5 and 6 in bookworm":
    Bump to 7 in debian/{compat,control}.
    (Closes: #965448)
  * Fix some grave packaging errors:
    - move debhelper from Build-Depends-Indep to Build-Depends
    - remove temporary files debian/postrm.debhelper and debian/substvars from
      source package

 -- gregor herrmann <gregoa@debian.org>  Sun, 26 Dec 2021 01:56:10 +0100

checksecurity (2.0.16+nmu2) unstable; urgency=medium

  * Non maintainer upload by the Reproducible Builds team.
  * No source change upload to rebuild on buildd with .buildinfo files.

 -- Holger Levsen <holger@debian.org>  Fri, 01 Jan 2021 19:17:53 +0100

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8006c9f..6a223f8 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -4,14 +4,13 @@ SECTION = "security"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
-SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu1.tar.gz \
+SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu3.tar.gz \
            file://check-setuid-use-more-portable-find-args.patch \
           "
 
-SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
-
-S = "${WORKDIR}/checksecurity-${PV}+nmu1"
+SRC_URI[sha256sum] = "12b043dc7b38512cdf0735c7c147a4f9e60d83a397b5b8ec130c65ceddbe1a0c"
 
+S = "${WORKDIR}/checksecurity-${PV}+nmu3"
 
 # allow for anylocal, no need to patch
 LOGDIR="/etc/checksecurity"
-- 
2.39.5


