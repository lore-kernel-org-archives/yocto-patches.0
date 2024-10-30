Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85321D5CCB3
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 15:01:29 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.17192.1730300482943939120
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 08:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PGxl6BFg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c452180so6743525e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730300481; x=1730905281; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBogyL24XsA48m4DKRHJHjRD3rIzMHABvCnBlmmACBQ=;
        b=PGxl6BFgm4h6y2FGZfAP8WH0K52rjF44EWiDbb7lnkikPkVS8lEmanlDamkViau3Xn
         +LeW/7vmzCETQwK47qtYnoeM4ZW00Swx0OYvVQpEfdiAHYEgowV3gNDK/qlQTqrQwhn3
         dB5JwGeyXoZmG3XLIB1BvqobI5crOf59RT86M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300481; x=1730905281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBogyL24XsA48m4DKRHJHjRD3rIzMHABvCnBlmmACBQ=;
        b=ErlVNvqcwPFChJ46t230C1d3wGtHyoXxriKrxsk9YzgeNR51CpIAI3G6p8vbkijd6g
         aU9kxWxmBqHSPEmSe7fSuzBs0J+427+O7Z0ALgqIc2tMdFk0XorD1cKFJitlzBygB30u
         wXFUY+8RKuW+0B03EIux3GUwy7UQW9ob/nfo3cUUndtyDNZwcokxnwzTThFbIuWqlkxC
         //g2lwwYxDL9KkqozT22hcQt+TqQPxWu5pN2uNJXdOQvtHrcTERQqEL75c104FmZ6T1V
         VgLDMAT7qh+az+76+GSHXHPnSHyjW8aPts/p374hjo6JdyycDpGDiZRwwzKq3nr0EfLe
         tklQ==
X-Gm-Message-State: AOJu0Yw2XhnT3XQzS/6PUuCdp7k1JBcLWt+MkQmG0aDydMO9aQ8VUUzV
	QUfl2HKuAPLAcey3tc6iSUWIcndD34xviRSNSFhclyDkRJfWSwASaBwm1+SzKcp72vz5Jz7rQu+
	YGCQ=
X-Google-Smtp-Source: AGHT+IHsxkYVJZGlVcuPUwxmUNSGyPlOiYhto7GSjGpiykvlQ8mzITATjBs06bRXRa28gCBGEBFgfA==
X-Received: by 2002:a05:600c:3c9f:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-431bd6d5a9bmr24372845e9.1.1730300480970;
        Wed, 30 Oct 2024 08:01:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:65f1:8463:55dd:142d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c52sm15540693f8f.74.2024.10.30.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: docs@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/run-docs-build: Add support for installing texlive for pdf generation
Date: Wed, 30 Oct 2024 15:01:18 +0000
Message-ID: <20241030150118.421857-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 15:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/773

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
 scripts/run-docs-build | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 2e7298e..ad8fece 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -42,6 +42,20 @@ mkdir buildtools
 ${buildtools_localpath} -y -d $builddir/buildtools
 . $builddir/buildtools/environment-setup*
 
+textooldir=/srv/autobuilder/valkyrie.yocto.io/docs-build-tex-tools
+if [ -e /srv/autobuilder/valkyrie.yocto.io/ -a ! -e ${textooldir} ]; then
+    mkdir -p /tmp/textemp
+    pushd /tmp/textemp
+    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
+    zcat < install-tl-unx.tar.gz | tar xf -
+    cd install-tl-*/
+    ./install-tl --scheme=small --texdir=${textooldir} --no-interaction
+    PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex
+    popd
+fi
+
+PATH=$PATH:${textooldir}/bin/x86_64-linux
+
 # Getting the old docbook built docs from an archive. Not rebuilding them.
 docbookarchive_localpath=${sharedir}/cluster-downloads-cache/`basename ${docbookarchive_url}`
 if [ ! -e ${docbookarchive_localpath} ]; then

