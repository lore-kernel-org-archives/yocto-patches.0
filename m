Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD4CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.139.1757000960544805750
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=RqIiGSH1;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3AD7E4E40C32
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:49:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13CBB606C4;
	Thu,  4 Sep 2025 15:49:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D725E1C22C8BB;
	Thu,  4 Sep 2025 17:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=irn94zBPOG8565Lf9ScFd259W8TmSJo5ujlVWJ7omWo=;
	b=RqIiGSH1IoTV0D7cpo0KmhDvNsjyFg2HAqDclztFnuhVvXCHl6CHDP1gH9nUCjUz9WqTHa
	KG48lIfPvo1lO16orWmLGQmBd6Hx/K+VVyap1scktYKdhz1nCWyru60rm4RmJgHzE85dtY
	SeNFFVMF1ymDvyhYLU57zbdXJD/QHQI3uUGlfD5k1HZowHWuJh+peFOAZ1iQ1MDAr4q1wS
	kMRx9bPTQkogqxTmzyi7NyjaLj1Pzm0GkQgmZup5n0/MOFcJUYOcYq9gtX3OUi8Aj04jE/
	X90d20Cy0cTm1EgglDYIjvsM9LyRhL6JcdXZtlycPW+QBLl+qme4FdDrqYopoQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 04 Sep 2025 17:48:50 +0200
Subject: [PATCH yocto-autobuilder2 2/3] builders: Add poky-ci-archive tag
 in build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-contrib-mathieu-build_props-v1-2-0ffaafcd01cb@bootlin.com>
References: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000954; l=1639;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=RZIJ5tzOEY1GBSZQcqGX6hUbLhPEIka/ch4l2V9ytCk=;
 b=ZQuKjJhhUtSCRDDFZlAGgqPoWnLoYb2IAKB3MzT8jobYD2XOJbCYuvyZH7ifvu41Xk4cDWTvr
 +EF1/JWE4biAqEHea7wZqvsD1D7Rp2//FKogTpWKpOwmml6UYfSP0XG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:49:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2133

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builders.py b/builders.py
index e4763d5325aa..0fa6e0035385 100644
--- a/builders.py
+++ b/builders.py
@@ -307,6 +307,12 @@ def create_parent_builder_factory(buildername, waitname):
         ],
         haltOnFailure=True,
         name="Prepare shared repositories"))
+    factory.addStep(steps.SetProperty(
+        property="poky-ci-archive_tag", value=createBuildTag))
+    tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:tag)s',
+                              tag=createBuildTag)
+    factory.addStep(steps.SetProperty(
+        property="poky-ci-archive_url", value=tagurl))
     factory.addStep(steps.SetProperty(
         property="sharedrepolocation",
         value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
@@ -358,7 +364,9 @@ def create_parent_builder_factory(buildername, waitname):
             "milestone_number": util.Property("milestone_number"),
             "rc_number": util.Property("rc_number"),
             "yp_build_revision": util.Property("yp_build_revision"),
-            "yp_build_branch": util.Property("yp_build_branch")
+            "yp_build_branch": util.Property("yp_build_branch"),
+            "poky-ci-archive_tag": util.Property("poky-ci-archive_tag"),
+            "poky-ci-archive_url": util.Property("poky-ci-archive_url")
         }
 
         for repo in config.buildertorepos[buildername]:

-- 
2.39.5


