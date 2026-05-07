Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AB7CD3442
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 08:39:44 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7467.1778143162802478620
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 01:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=T8aFy5C+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20260507083917050f4fed18000207cc-bspriw@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260507083917050f4fed18000207cc
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 07 May 2026 10:39:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Ic6vKClPhpdV1JurtfCcCnXdDM1dDhYra8J1M49VtW0=;
 b=T8aFy5C+22Bo8ycr6GwsGzQI8Ez2pJVZZKoMG6prRfuz6spi8WJEN7e0uRvpIDwWkv1hhl
 ijEy0eY9EwI/SlZRvg6utS5eB3SMPeMNWrBkXKn7jxpfEcLkFCkewRUOz3YvRdOm4+dtJc/1
 o2xWOrWZ2Jg4SlSQV+v06P7YAynQjEZCkFVd5YzesBHYBOTSwou0E889VBjKrImO0GY/OkWQ
 IIBg8aI1VtuRWQa21BAD+eSKzvwsPlyqkVO6FqIC7cGuNDlNHwOgvWJK61Ys8+RlpO6naqa+
 HKpQzh6dCczjsH2X3tPuiPffRTteCYljE8RY3lFehSwDBtk1Q6BeCgzA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH] tpm2-tools: make efivar optional
Date: Thu,  7 May 2026 10:39:01 +0200
Message-ID: <20260507083901.39472-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 08:39:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3931

From: Peter Marko <peter.marko@siemens.com>

Previous commit made this a hard dependency because it's autodetected.
Instead of that, make it configurable so it can be disabled (roughtly
equivalent to behavior before that commit).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
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

