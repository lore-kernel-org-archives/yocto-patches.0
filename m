Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041ADCC6B1A
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:58 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3854.1791913728943434049
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Oct 2026 10:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hAEWYjcs;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=tX59qH0p;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB8674E4120F
	for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Oct 2026 17:48:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB27060362
	for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Oct 2026 17:48:46 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 4869111D7159B; Tue, 13 Oct 2026 19:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mAhPXidxEVbUK8eNEX94J9vkifOvqYMEVwSY/fPgCUU=;
	b=hAEWYjcs0ggNb42UC5msjIv7F43OgkDNFxDTYacXDk294yLNeIMPnYbJapsgJOH9hA+cRT
	PrVnVLvagq7uN9YTs3W6UFCq9qvYiEUs3/03tbibIgsc+4XDtRBusYuSytffBPeOQvwTLT
	U33urc99/rUlOz6wD5OpbbP9Qvhw/bt+u5cRo6mXndSoPK8q0xQeNfPuEbxf67j7EYGFkb
	mntQEBQ5RxXDnZRsDZe1+YIv1NVY2jD0GR7pl+6qlDJTI9VldpLv7fLexwUobnHE27CVYt
	VECYnZCvDouFmpekat6zI11zb1vGMp/qvmYywmfsbsbSYpvk6iQq6inZMCn2vg==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id aIORKB7CzGorOQ8AtaWaaQ
	(envelope-from <mathieu.dubois-briand@bootlin.com>)
	for <mathieu.dubois-briand@bootlin.com>; Mon, 12 Oct 2026 13:18:54 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DC7411D70E4E;
	Mon, 12 Oct 2026 13:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791803934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mAhPXidxEVbUK8eNEX94J9vkifOvqYMEVwSY/fPgCUU=;
	b=tX59qH0pq2igpvFy85LB+CU0a6f7wVLiDxxbb4uyaC1Ju+2OWkeSlZoPFbve1dpDTpdBlb
	AmriFZOmLEAeX2tmC3YSjtHBj+LiC27V8RpCre3vpBoLw2O6nXzcKl5j3vFQk1c4Xzi3QN
	gU07ylfVWfNkm3EYcmR2i/xtFEYUDEeWtZ5n8ZtK1SksiCe12+iseRSmPIt0rD04d3A3oO
	n3Es1gk1YlFvE4l7A+tkPQiNcPBGMdJJIv4n95JTLFnX1vrrA3hT2DHJD5/PQ4Gwm7HD1H
	iKuC8n88anHcPJwOaWPpI3PhynCRaCrTI8EZEk3+jixozR72VH8LVSM6lJv/yg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 12 Oct 2026 13:18:50 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: Fix meta-exein branch for
 scarthgap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mathieu-exein-scarthgap-v1-1-154376f31836@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABrCzGoC/x3MTQqDQAxA4atI1g2YUKr0KqWLOEYn0M7I/BSLe
 PcOXX6L9w7Imkwz3LsDkn4sWwwNdOnAeQmros3NwD3fqCfGtxRvWlF3tYDZSSp+lQ2ZSRcaZaD
 pCq3eki62/88P+EZXIkotcar2mjUxPM/zBw2uaop9AAAA
X-Change-ID: 20261012-mathieu-exein-scarthgap-221ef18a71b4
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791803933; l=874;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=L0JWnVeF+66EY7zkzbrbdrUS4AojGzhmrCetnhEci7Y=;
 b=DEwGbqxHxUFBaSIQosMKqHZqP6ciXSbkkPzzKgD28lvGLs0LKHyUo+fd+xHipvBD+gsvPRxMH
 v/IaB3MM9JuCChgji63uzhbaoWz3M36O+QkSvTC/TscD6p03+X+A/o6
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 4869111D7159B
X-Spamd-Result: default: False [-1.24 / 30.00];
	BAYES_HAM(-2.24)[89.38%];
	DATE_IN_PAST(1.00)[30];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	BCC(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORWARDED(0.00)[mathieu.dubois-briand@bootlin.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[mathieu.dubois-briand@bootlin.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[schedulers.py:url,bootlin.com:mid,bootlin.com:email,localhost:rdns,localhost:helo];
	RCPT_COUNT_THREE(0.00)[3]
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Oct 2026 17:48:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5005

Scarthgap builds should use "scarthgap" branch instead of "main".

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schedulers.py b/schedulers.py
index f52b772831c2..5577f5b6fbe2 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -189,6 +189,7 @@ branchdefaults = {
         'branch_meta-arm': 'scarthgap',
         'branch_meta-aws': 'scarthgap',
         'branch_meta-clang': 'scarthgap',
+        'branch_meta-exein': 'scarthgap',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'scarthgap',
         'branch_meta-mingw': 'scarthgap',

---
base-commit: 2f571236971d2e77010e8fd06198b7733123a36f
change-id: 20261012-mathieu-exein-scarthgap-221ef18a71b4

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


