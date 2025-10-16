Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB95CCD19A
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:33 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.8267.1760620822972489618
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2QE6KVOn;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A791B1A134B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E2386062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB0CB102F22EF;
	Thu, 16 Oct 2025 15:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iDZZ9vm9QSJxGQnw8qeGrGew933+70cGg95+aP9DR1c=;
	b=2QE6KVOn1xoOYm04Qe+US7EYFButKoBDEU+SmxnbkJLpFwA1UaP8E3ET7yIiYD/1bQFBKq
	JZRmp5f/R+1WwC1AM/SFGThtMEiReeZ6nmMP6h9LrnIyklaQy7uv7ywnfalJtXlfaJ+0wA
	KaRG0lbaE3tE2GA6E6xyFdFPjio93/BmqxRup7Nw/LehiPlZPFgNH/8PB0VCsVxCUEhKXj
	s+A9fND1w38cKBb/BQTLT/eqeX2UiyCD79iG1ZgeXKSeKUoiEY6EfTpSXMYnmpggMce/Ho
	xu9MvIvIvbqNmtNTwBTiYb3ASEQygrIti3/crCSfXB82SWzALNAII7z1NbLwpw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:16 +0200
Subject: [PATCH yocto-autobuilder2 v2 5/6] builders: provide builder name
 to getproperties.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-5-095908455e0b@bootlin.com>
References: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=1771;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=vENro3S1F83SiFmzWvG+oSuGgOCJEV0Iif2tJ4OYLhs=;
 b=zlFG728L+3Kw+llBKWxQ5bcI29c8lFsdaeficD7x/HNGMrte7ZHzIfXErT+OTisEhPabJgdQJ
 A/Pgo07aRJNB5WHoWoLSj8QShkAWiTsyzstezfZrrftya4KxBA7zldP
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2318

Provide the builder name to the getproperties.py script, allowing to
extract data about build configuration, such as MACHINE or DISTRO.

The script does validate the number of arguments, so we remain
compatible with older versions of autobuilder helper that do not use
this new one.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builders.py b/builders.py
index 2fb0bf827b0f..18c119aa7617 100644
--- a/builders.py
+++ b/builders.py
@@ -137,7 +137,7 @@ def create_builder_factory():
     f.addStep(steps.JSONPropertiesDownload(workerdest="build-properties.json"))
 
     f.addStep(steps.SetPropertyFromCommand(
-        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
+        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build %(prop:buildername)s"),
         extract_fn=extract_json_props,
         name='Load build revisions',
         haltOnFailure=True))
@@ -342,7 +342,7 @@ def create_parent_builder_factory(buildername, waitname):
     factory.addStep(steps.JSONPropertiesDownload(workerdest="build-properties.json"))
 
     factory.addStep(steps.SetPropertyFromCommand(
-        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
+        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build %(prop:buildername)s"),
         extract_fn=extract_json_props,
         name='Load build revisions',
         haltOnFailure=True))

-- 
2.47.3


