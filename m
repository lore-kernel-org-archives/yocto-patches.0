Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB40BCD8C8C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23161.1763038637499248427
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=js5fJ69a;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202511131257145aff3a23130002079a-dja1ff@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511131257145aff3a23130002079a
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jfirrN/TavmEII76NWdWUzLgM7kcUwpYqho9Pp+gThk=;
 b=js5fJ69algHwcXsLIOPVjEDlPHJCFM6qHPCOFwhMpT/wrTFMOQ+4wITZ1rj/Y+iBal+LIQ
 eEnSiC0qzHmV4kqyiG9h/t0J8HKQuh0Sj4T7m4c3X9D/eVulM73CWoOlD4vShqw37U7LGAPX
 Q4Qw4xXhaWsxSE/Tp3lAcKoFwskTjQkvaAlDZUIsIDpPAaU4oy0De0sQ9gDnzplLjTCAGCyV
 4JfSsxLxFjzFx+ExHtZpDyRchkybP0qZyIQFdFjyUKK6gx3I1UvPmk7MS3PtpM/s0ecTCEvL
 cypCY+kZZVI5QlMOmcoPCVoHhlyzLLD9KjK7+EEX8mJmVCboDJyyfZfw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 06/34] Revert "go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX"
Date: Thu, 13 Nov 2025 13:56:44 +0100
Message-Id: <20251113125712.18914-7-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2507

From: Jose Quaresma <jose.quaresma@foundries.io>

This reverts commit f3bb48cea8c9794ff9e4d9eb13309c4651a7a226.

This drop the 'destsuffix' overriding the SRC_URI
so we make the oe-core backports easier without conflits.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 575ee81..4f9e60d 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -9,6 +9,9 @@ SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsu
 SRCREV = "32022caedd6a177a7717aa8680cbe179e1045935"
 UPSTREAM_CHECK_COMMITS = "1"
 
+# drop the 'destsuffix' so we make the oe-core backports easier without conflits
+SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
+
 GO_IMPORT = "golang.org/x/example"
 GO_INSTALL = "${GO_IMPORT}/hello"
 

