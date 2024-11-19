Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2288FD4417F
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 16:18:21 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.25301.1732033096908071893
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Nov 2024 08:18:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XZa2cf7v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97FB0FF802;
	Tue, 19 Nov 2024 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732033094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iLvxFG8Gr6kj2zfwhuSIH/2k0AWIoe/pCjt/Lxx03+4=;
	b=XZa2cf7vFUK/EFpuQ7mCbmEK/eqQwGSw/KdUB+fnzfdEwH0hxrPvf6CE7Go1Zjb4Wi2Ygr
	3R8a706c0csCM8s5fRyUpJVdQ3yi3KXbzSREn7+Pa6xo37c+OA3XtvvXk9YJrgp6Sq26Xm
	XF19rT3Xe2tIfkHk77CXNXCXO+48LkakVltS2IyVTXjJmgS49fsnz2+Vb+y0A/xujA2Iaz
	YvFOs1P5k8/FcxBL1k0+qSj+VBBCBfa/HC43nWvrazzh8fCMwug4jWGMldGrrP4BuUuZDD
	br+/1QuWS6pXbLJnL0snFZWZh232XgFFBM+tfqutDMnI0Mx/eyUeAMNuGSogAg==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH] config: Add systemd distro feature to meta-virt builders
Date: Tue, 19 Nov 2024 17:17:36 +0100
Message-Id: <20241119161736.2827354-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Nov 2024 16:18:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/825

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Starting from a recent update to meta-virt, systemd is required to build
xen-image-minimal. Add this to the autobuilder configuration.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index a62a4c975188..a6a4332bbd77 100644
--- a/config.json
+++ b/config.json
@@ -1413,7 +1413,8 @@
                 "${BUILDDIR}/../meta-virtualization"
             ],
             "extravars" : [
-                "DISTRO_FEATURES:append = ' virtualization xen'"
+                "DISTRO_FEATURES:append = ' virtualization xen'",
+                "INIT_MANAGER = 'systemd'"
             ],
             "step1" : {
                 "shortname": "Xen for qemux86-64",
-- 
2.39.5


