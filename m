Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB33CCD18D
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20398.1759847845173485306
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=HomEsVvt;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DED371A116B
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7C39606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BAF2102F2165;
	Tue,  7 Oct 2025 16:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z3bfdtzEXLmxLUDHuDAVyxJh3MBQFTDRqZQNpaXLI40=;
	b=HomEsVvtXseKJTKySFTTVQhVJmxxMrPA2h57rQjpcX1MCagh7Gb1p6tFVEkWp2sRGWMgRK
	gySCqKXfc7s5gUWPwVLVEToL2Sla+hQljthuiljw0oD8KlZB8TVQZPca5Bq4/V0SW2N26M
	jFApzODMFYakrcPtjSIqE4s8iTHXaNHw3z+UyGTI+XTJ2T/10TRhDg2ACl5Cd1sutSk65H
	NPfUeODSxVNu2iv3tGeyLlxAFdCBO/Ozz2OTdYq1EgD0qpB4KRIEDfBUCnNhj92Y6GtrXN
	O82Lvslg+RwSee8tsQkZmQtpT2/6wIkqNufdebayMRXwXbb93c0vt3Z+IQSylQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:18 +0200
Subject: [PATCH yocto-autobuilder2 02/10] docker: compose: Fix docker role
 detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-2-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=1941;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Pnzr8L0tp10zJ9Fd2Wlw8qsVJi8t6vgA5Vyhbaq6G1g=;
 b=752ND0admrkg4U0JTm+6FB5qcC0ky8A33OJUS5+8tdYjr20DYrQ2KCjPBKzxJ+t9ZEtJe1Hgs
 3who+vhAlqhADPFwQcwgDXhEk8S5z6j23S0n2QQ6YXa/2jDZnby+0bn
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2278

It looks like the name of docker containers created with docker-compose
is not always the same: is is generated from various values, sometimes
separated by underscores, sometimes by dashes, breaking role detection.
Try to use another method that should be a bit more reliable.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/compose.yaml | 4 ++++
 docker/entry.sh     | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/docker/compose.yaml b/docker/compose.yaml
index 50034d90d52b34f5d09c01a48b8f3e256fe8339a..334e13720b3b4b89128300fa623628d7ea219b5f 100644
--- a/docker/compose.yaml
+++ b/docker/compose.yaml
@@ -2,6 +2,7 @@
 
 ---
 
+name: ab2
 x-base-service: &base-service
   build:
     context: ..
@@ -17,15 +18,18 @@ x-base-service: &base-service
 services:
   controller:
     <<: *base-service
+    command: controller
     ports:
       - 8010:8010
     cpus: 4
   worker: &base-worker
     <<: *base-service
+    command: worker
     cpus: 8
     mem_limit: 16gb
   extraworker:
     <<: *base-worker
+    command: extraworker
     cpus: 1
     mem_limit: 2gb
     deploy:
diff --git a/docker/entry.sh b/docker/entry.sh
index 1aef2ba4025f9871e84189283fd791fab109862d..900e4b9b229ffab31fcd345b8eaec57bd2fef90a 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -6,9 +6,9 @@ chown pokybuild:nogroup /home/pokybuild/git/mirror
 chown pokybuild:nogroup /srv/autobuilder
 cd /home/pokybuild/ || exit 1
 
+role=${1}
 docker_name=$(host "$(host "$(hostname)" | awk '{print $NF}')" | awk '{print $NF}' | awk -F . '{print $1}')
-role=$(echo "${docker_name}" | cut -d_ -f 2)
-instance=$(echo "${docker_name}" | cut -d_ -f 3)
+instance=$(echo "${docker_name}" | sed -e 's/.*[^0-9]\([0-9]*\)$/\1/')
 
 if [ "${role}" = "controller" ]; then
   su pokybuild -c "yocto-autobuilder-helper/janitor/ab-janitor" &

-- 
2.47.3


