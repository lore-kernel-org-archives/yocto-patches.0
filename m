Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB20CD8C8C
	for <webhook@archiver.kernel.org>; Sun,  7 Jun 2026 19:30:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39315.1780860627639732540
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Jun 2026 12:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Q7ddqi+N;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202606071930230ee868433f00020784-p__t6o@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202606071930230ee868433f00020784
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 07 Jun 2026 21:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pYcqpXj3DpyZr3aoBnT4BuE123HixxPCiDnrOmRfG2Q=;
 b=Q7ddqi+N2OpGNrJvl0byqARSmpx+HKJMaq2gupIMUhgcoHt/CUQ2D4KJwjnFiLEWlyFVvq
 TWuaNpcYG1ZDKvTLtWpe2GWnw3ce2lkqB9Ft+JjoKbPW4NvZieRfMra9PXjxpbHi3ej57k9h
 VBHDcFFk+2rUzlvRGsM1mEyA+MlV46PI324E+lwVIwOvZG0NwVmS9N/qvrcBDAcQl/cDNG/S
 jshxMr9Vutd0cAefujQSvHbUxKAs6q3EgxWua1cfUfrLWMxKztCIoXjqwlqV1r0rQJuf2Qil
 nM5vCJsRWlC+eylkR8gQfNtlkEMR5HgV+WfuAUfxXTHKCKMK8rcx/hWg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go-helloworld: use bbappend for mixin modifications
Date: Sun,  7 Jun 2026 21:29:31 +0200
Message-ID: <20260607192934.156036-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 07 Jun 2026 19:30:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4170

From: Peter Marko <peter.marko@siemens.com>

This makes cherry-pick possible without conflicts.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb       | 3 ---
 recipes-extended/go-examples/go-helloworld_0.1.bbappend | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)
 create mode 100644 recipes-extended/go-examples/go-helloworld_0.1.bbappend

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index c8401c9..77a13b3 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -9,9 +9,6 @@ SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsu
 SRCREV = "7f05d217867b2af52b0a28c6d1c91df97e1b5b39"
 UPSTREAM_CHECK_COMMITS = "1"
 
-# drop the 'destsuffix' so we make the oe-core backports easier without conflits
-SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
-
 GO_IMPORT = "golang.org/x/example"
 GO_INSTALL = "${GO_IMPORT}/hello"
 
diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bbappend b/recipes-extended/go-examples/go-helloworld_0.1.bbappend
new file mode 100644
index 0000000..b2c0661
--- /dev/null
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bbappend
@@ -0,0 +1,2 @@
+# drop the 'destsuffix' so we make the oe-core backports easier without conflits
+SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"

