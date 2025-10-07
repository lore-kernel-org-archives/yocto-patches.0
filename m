Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6DCCD18A
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20531.1759847844636431193
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=XpUj+ue/;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 58CE71A1169
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31EB8606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9ACB5102F2156;
	Tue,  7 Oct 2025 16:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KDMxH4YMh6rAggWi2TJT8vvzHPSCi++RKT+AOExDTrI=;
	b=XpUj+ue/+wl06aFLf+5rKAoVZkrdylvxwdB5KxCfb+qixILqUCaumiUWnqPRFVV6bHUS18
	ZwAydHjCFDQavQ4O2QsYeT4TCsqLGGG/6TQHiqcJFUtKYiSiI4z1CC108gdPVMo7bDSY7T
	UZxu6E6jZ8NKAtzeEFabpf6s95x4EslxytHZcjOdfqIGTLlGG2GdKyqxSCigo90H9SklUu
	mRj8XUxvPSgn7VAttw9VI8OR8CukwU4wTIuKVkCp4ZW5nf2GWp3chVzone6xU5NSmToyKB
	ZQ0ZLzmlI8tXAwUaCpZ4KUdFvsW4ipAVKbKEU6DsV6fuOgWCHqh2rhTLOQ8luw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:17 +0200
Subject: [PATCH yocto-autobuilder2 01/10] docker: Update buildbot version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-1-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=1028;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=QUxIUoMM4uvmLpt9aC7VBLO+SNWhuHizelFlQ4Z7dgY=;
 b=EuNUnZVBBkCpU5bCIulr6Jh6UrQmacpb1ke7ySol6qLVuJSXVvNrdCJaKwYwLQq7ZDzCrilon
 Mukwn/CXhZ3AGrKkg3fmRIR8vgJ5x12mjagvYFz5qw5jZVE2zH8184c
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2277

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 6948a1155548d753778886b0203c78ea0f85ae43..5de05c40853ad5aad478cd8521384249477f153e 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -48,13 +48,13 @@ ENV LC_ALL en_US.UTF-8
 RUN npm install -g yarn
 
 RUN pip3 install --break-system-packages \
-        buildbot==4.2.1 \
-        buildbot-www==4.2.1 \
-        buildbot-waterfall-view==4.2.1 \
-        buildbot-console-view==4.2.1 \
-        buildbot-grid-view==4.2.1 \
-        buildbot-worker==4.2.1 \
-        buildbot_pkg==4.2.1 \
+        buildbot==4.3.0 \
+        buildbot-www==4.3.0 \
+        buildbot-waterfall-view==4.3.0 \
+        buildbot-console-view==4.3.0 \
+        buildbot-grid-view==4.3.0 \
+        buildbot-worker==4.3.0 \
+        buildbot_pkg==4.3.0 \
         websockets
 
 

-- 
2.47.3


