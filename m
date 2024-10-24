Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68154D0BB7B
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 09:14:26 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.10380.1729761265147482022
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 02:14:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MPIPaxOA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26E0960004;
	Thu, 24 Oct 2024 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729761263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XjORDPwKz3XJfht4FmYhrHaqa7mXzS50M1na2gPa610=;
	b=MPIPaxOAh+OcWQUZ4gE+CYwtchVqcORFvneT3z7ZE+vjdLfnmqTTFfVOcizdm6X/ZH8rDv
	Kfk+bOI6CJIy2Kc58YzIXrv7o0aivyyLeJLZMOWoMoyhaz7iMMs5aFxaxHPb7HgxnYVQel
	Sn4LPArf6yqmkPeEV4q9qB1Ly3G+o92G1yWidFBb99QjRIrK/QIaSYmIEAlWPAi7hQKxr8
	YI9o3B76KCgIW3baQIP8BX3DGYBbjNpt3beDYDkyUDAhnpbGX0WyWhZI6IFwd8z6QTkGbX
	MG5X/NN2WMiBdd+pwV1PvRtgHPyLmly+G62s47f3Hh1DDIEcJrHKo+8iUxfCpw==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: Add codebase on all forced builds
Date: Thu, 24 Oct 2024 11:13:55 +0200
Message-Id: <20241024091355.146213-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 09:14:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/739

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Adding the code base with no name and a label on sub-builders, so it
adds the missing "yocto-autobuilder-helper" header on the build start
pop-up. This mimic the behaviour we already have for the a-full/a-quick
builds.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schedulers.py b/schedulers.py
index e4266a53d1b8..c678c1d17675 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -386,6 +386,7 @@ for builder in config.subbuilders:
     schedulers.append(sched.ForceScheduler(
         name=builder,
         builderNames=[builder],
+        codebases=[util.CodebaseParameter(codebase='', label="yocto-autobuilder-helper:", project=None)],
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the
-- 
2.39.5


