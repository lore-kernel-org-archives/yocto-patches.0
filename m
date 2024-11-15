Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652ED637CE
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:03:32 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.21365.1731679410987930667
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 06:03:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fkxqVXFS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3681160007;
	Fri, 15 Nov 2024 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731679409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cFQbJxzANYTXvU1tdXsUHH31vL8x6HjjQy6YQ73TqXc=;
	b=fkxqVXFSYcm1Ce/HWnIslPenNwQIkjpLHOjzdqVX4brXclQ8bqhCR/EVIlLnCepQFr+cWc
	EoeWcNxnxH/2XXZqc+aZ6WzQZK3vNpJxa7dTlEN2qPLdrT5Lui7gnf4PsS8GMX2rv68iPl
	h0+7IfJG3BeOQrAWIUvq2ihedorzp8XCFGZPAAXk77S2/9Ddgjf9MNtNrCu1We71eX4e8j
	FlvJP4P9mnZ5yFIoih4nWbkti+/6Nje9fZxXuWKMHofYFP5Yb5aNIcyOr24IY+zBD7yI+k
	srwHb2mmDeUQthysZwTItzycHxBSX6Nq2rYoMFdPuoTHTuQSVHX8sg7y5d3gZQ==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] builders: Create poky tags on a-full or a-quick builds
Date: Fri, 15 Nov 2024 15:03:25 +0100
Message-Id: <20241115140325.176133-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 14:03:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/806

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builders.py b/builders.py
index 55c7d07f6a09..88ff328c7ec6 100644
--- a/builders.py
+++ b/builders.py
@@ -272,7 +272,9 @@ def create_parent_builder_factory(buildername, waitname):
             util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/prepare-shared-repos"),
             util.Interpolate("%(prop:builddir)s/layerinfo.json"),
             util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
-            "-p", get_publish_dest],
+            "-p", get_publish_dest,
+            "-t", util.Interpolate("%(prop:buildername)s-%(prop:buildnumber)s"),
+        ],
         haltOnFailure=True,
         name="Prepare shared repositories"))
     factory.addStep(steps.SetProperty(
-- 
2.39.5


