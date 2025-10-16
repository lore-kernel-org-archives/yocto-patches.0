Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42587CCD19F
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:21:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.8328.1760620856718786574
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NBhGkkP6;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5FC144E41104
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35E076062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C818102F2309;
	Thu, 16 Oct 2025 15:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ce73aghzi0FZFOZtyXRpQzSIwp2pbLOTbSd7lXybJ60=;
	b=NBhGkkP6iH3T/2wGoxuc9WhdvgaBJ3IyNTdEBAbHxIGZMJ5ezyhhFKV2GKmhMYeKF7NfyN
	fV62ywyeM8xP4rMns37dKUQwqtex/DkkhUCwmbHQEP92ZlbpdXJgkEwHpQXyeRkTGW9uFv
	WHlnE5FbezzhrN6aobEMepbJeJJSfAwXnpb7i+pEygoR4gE8Jf+9+XfOwbYNXFUaGHZ6bL
	BOWCz0s0gHqhiYsg/SbHpajhVBSz94dmno+h29yrGzYHKbIGzYVSrmhZLNvMJESPZBTONP
	DngWsP7/026WRBW4PLjwIQmOBiKErABC8Keleo7AYfbYgoHOEYoDp6oPyau8HQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:51 +0200
Subject: [PATCH yocto-autobuilder-helper master-next v4 2/2] getproperties:
 Add property to indicate we use bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-build_props-v4-2-1f2f6700e06b@bootlin.com>
References: <20251016-contrib-mathieu-build_props-v4-0-1f2f6700e06b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-build_props-v4-0-1f2f6700e06b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620853; l=661;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=TcfZMPoPQt+8xSUV/l5ZbS8bUlv64POJukpAJxBWaSQ=;
 b=dyTZeuWtLevVgtCVVE/ZQsyVHqUqGC4BKjH5Ps8oa8ZdJGD3cssdwv0ty7avapW8MAQnNrMO0
 CU4tDV/n6AaBNvna/NXKQT3HBTJdkbSlBlpnEQPKFt78sdlLW2HDzjc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:21:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2322

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 2119424b2dd4..5c342c748ba9 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -72,6 +72,8 @@ buildid = hashlib.sha1(buildid.encode("utf-8")).hexdigest()
 
 jsonprops['yp_build_revision'] = buildid
 
+jsonprops['use_bitbake_setup'] = True
+
 ourconfig = utils.loadconfig()
 exported_properties = ['DISTRO', 'MACHINE', 'SDKMACHINE', 'PACKAGE_CLASSES']
 if targetname in ourconfig['overrides']:

-- 
2.47.3


