Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCDFD6B6A9
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:35:50 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.19512.1730306139705358502
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 09:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y0/hUYuW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso315795e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730306138; x=1730910938; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGxrn/+FoHaGIZy9j0BmZBOy+GafmVctF5DJFiJ3Up8=;
        b=Y0/hUYuWHM/rAUhN+02HCw0iPzAorf0wR/xS+o0OSYILGqvL6zkbv8yk++0z+sKLO3
         6YEBzolbs73gun3k1VXkffcZetRtCPE1Qou6yJUzRfrojVqqPeCnSd7DRJoil0I7MARN
         NcnhHnRkV+lPV9t3SHQJcSnwrcmbLuF6rcqso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306138; x=1730910938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGxrn/+FoHaGIZy9j0BmZBOy+GafmVctF5DJFiJ3Up8=;
        b=rKCseSFm+FtV2yGkw3DJjJip95SHSJfnT3NBIid6wUum/gMSn8D9ZWGfRWxmbUHXln
         gBnsLXmB8stGsL7awN/EgiznOUZQ+ktb5MZQPY2a9qkmR4PXNUVPoJXLRV/r4GJl8hV6
         2WkahcGJg8oqApM/O5Qmybn6eaABNz2aplriQmIy/nN3ByiMThgZpvc4+h2XCCGOCW2J
         zw4mLLo5UcWt+tlT2+rvEUR4DgWjv3JKXB8pPoUwfXmk06bIoLCro2HxbfAPK1QrHtoY
         TN0rOhNmePze3IRlHluDrMvI++DAfNqxl9AVpNTbnDPm75cUXuAUsd/oiPqxfuV13MCq
         6Z6w==
X-Gm-Message-State: AOJu0Yz/eER3VHJmJPfbkCbU+9tZEaFqKTC7Zo9KrsWw42xYbrABCnpA
	CXaaw6J+MWoQKhAuwjvoBluG+w80wf+ezK/GQy2sCfKfGpI119MosLBPMJie73bD3AFd8snhcmZ
	YFWg=
X-Google-Smtp-Source: AGHT+IFSC8/Sw6yg2/GPGI4I05OWjizBZl7h+2s7wtvmj2SQ7VLbyuVpcS9/JaH9BEeIETtvRji01w==
X-Received: by 2002:a05:600c:35c2:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4319ad26eafmr166071165e9.30.1730306137713;
        Wed, 30 Oct 2024 09:35:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:65f1:8463:55dd:142d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b132fbsm15827411f8f.4.2024.10.30.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:35:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: docs@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH v2] scripts/run-docs-build: Add support for installing texlive for pdf generation
Date: Wed, 30 Oct 2024 16:35:36 +0000
Message-ID: <20241030163536.437177-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 16:35:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/777

To build the latexpdf output for the docs, we need Xetex (which can handle
international characters). Rather than require it on all autobuilder workers,
along with dependencies, we install a copy onto NFS which the workers can
use. The full install is 6GB so just install the pieces we've found we
need via tlmgr on top of a small install. This script creates the install
if it isn't present.

For local docs builds, we assume the user has the tools available from
the host OS. It is unlikely most users using this script would have the
NAS path present so this seems like a reasonable compromise.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-docs-build | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 2e7298e..3348378 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -42,6 +42,26 @@ mkdir buildtools
 ${buildtools_localpath} -y -d $builddir/buildtools
 . $builddir/buildtools/environment-setup*
 
+# To build the latexpdf output we need Xetex (which can handle international characters)
+# Rather than require it on all autobuilder workers, along with dependencies, we install
+# a copy onto NFS which the workers can use. The full install is 6GB so just install
+# the pieces we've found we need via tlmgr on top of a small install. This script 
+# creates the install if it isn't present.
+# For local docs builds, we assume the user has the tools available.
+if [ -e /srv/autobuilder/valkyrie.yocto.io/ ]; then
+    textooldir=/srv/autobuilder/valkyrie.yocto.io/docs-build-tex-tools
+    if [ ! -e ${textooldir} ]; then
+        mkdir -p /tmp/textemp
+        pushd /tmp/textemp
+        wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
+        zcat < install-tl-unx.tar.gz | tar xf -
+        cd install-tl-*/
+        ./install-tl --scheme=small --texdir=${textooldir} --no-interaction
+        PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex
+        popd
+    PATH=$PATH:${textooldir}/bin/x86_64-linux
+fi
+
 # Getting the old docbook built docs from an archive. Not rebuilding them.
 docbookarchive_localpath=${sharedir}/cluster-downloads-cache/`basename ${docbookarchive_url}`
 if [ ! -e ${docbookarchive_localpath} ]; then

