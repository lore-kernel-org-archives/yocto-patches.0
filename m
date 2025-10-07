Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C587CCA470
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20537.1759847850592881055
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=X+XcqI8q;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4E2DD1A1169
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2554E606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A88F102F216C;
	Tue,  7 Oct 2025 16:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YGm0E++8pFamb5mmqDR2WDQThC+SyjyNYuyBwA13qUM=;
	b=X+XcqI8qI1NCnTaswR7tbZGZoi8257MNoeWoznql87/sO+Do7VAk5BqIzQ/HzlSZaN7Ogb
	N8HArWD21D341RzaWQ/MLkljU/CeiLOEmaLn5dMQw159IcKKejQIcVx5D1RI1XAT+vTENo
	/QaIHVb64pVbHDS7944ceBip5Pr2BiZ7dE1m+BwCnWR0ZNctmT3xSSUlfJoqYpQ5rTT29R
	0hACZ1ZoUAMMpUZag/XjkMkhgCzQdqprJ/ZRpB7rxJEcOSVh/BPiVTMQGCWFKqtgxQzMHp
	1Pb+KZmAaRqFE4AS6+OyeoTNCIx0bIWez/+k9FB1HJ7qZcmtk6PqyWY43bhI/w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:26 +0200
Subject: [PATCH yocto-autobuilder2 10/10] builders: provide builder name to
 getproperties.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-10-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=1827;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=EGvpIB8+E7eDYtjJSBQUKCLKFX3Bd8iCIqxVFg4geZE=;
 b=kpKwMJiBqv9ej/K6OLfGVuorqojG5FPujIe5goolNogcVvq6D+PMdZBcxg/08nyAgqBxIEdao
 K1cxyMqxs5fD+BTErkfO7VwvA9jzIg8CBjzNHBbqnON9WbIZ8PXTmoa
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2286

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
index 2fb0bf827b0f08fb822320ad9fc858592e606cc7..18c119aa76173cbd1f394d3c995a4f88b977291f 100644
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


