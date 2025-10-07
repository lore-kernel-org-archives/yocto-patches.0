Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E5DCCD185
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20527.1759847834782293635
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=d+5Bw0J4;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79BFC1A11CC
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 541B6606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A466F102F2166;
	Tue,  7 Oct 2025 16:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LnNnMD+SuDJWCtEhgzYlXKKkFC/CNXfe8ukZOKG4vhY=;
	b=d+5Bw0J44B1xKW9QNGr4UeGeJflRsxqGAaFwD7kRvuQMoAV16Awrpb1+qoqoEe9bG1GCEI
	ghNc6XOmnMCMD5qmBF73JUWyu+99d2swC3xsTFei1JJVFC4aB/GtTtxQh9iwfyAng6ttY4
	aE3b+xBGfseloKnu+exlKnurKbFfT/eUoxW+SM/LTzfuszSq8DR0yUFHSV1HhYfQURxKxG
	1VrCbavC9xMrMlYF/tJXXs5TvfL3j2sw1nsgQm6w2rsSXkIcfWfBOliFQj5XLT9gkmedtB
	ONCEAtlwH8lqsj4jh49LLbrsv6nuydxUbAXdP/9LA9E2p0Z9HFet9+dKVAlErA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:04 +0200
Subject: [PATCH yocto-autobuilder-helper master-next v3 3/3] getproperties:
 Add property to indicate we use bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-build_props-v3-3-0263f52bd682@bootlin.com>
References: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847830; l=717;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=iVHUr5BkOrLmOojbCJxCaQtmGR+arA+TY2Ye4bd3DUg=;
 b=Ypgxn0Lm/OWpKnOYkHCynJ+weHGI3xf2N00R9wjoqh+s3PTruYRga93vrdFqwYi1dho3igeRq
 IQN8YcQu233AIPYrrnmuu2s4AzKz27BYOnHPtds+xsZqhW0SS0GT0AQ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2275

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index ce1bc2fb45a8fce463fd2e19249833075b9d975b..4cd00684a48c23abb5e6602c485f93cbeb4bd30a 100755
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


