Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FBAE677F3
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:28:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83505.1766420915741243211
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Em+d4QEz;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 33F654E41D35
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0ADE5606C1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 538A410AB045B;
	Mon, 22 Dec 2025 17:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766420913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FuBOATK1GXWUQ4uUZGvu8NtAZfO09S3v323fEN/GZK0=;
	b=Em+d4QEzB+7v/AoaTTGS3vSLkRJm7gzkdB5I+bAS3k5gJXI+58gPd3Bj0XQj0TgcEcFlz1
	3Rdw7I63KIq6azkjP1mpAhtmYvnNE33IsQRXdRf2PsItv2wJjgKn/YwWUdL2ujQ0GKAZhN
	F6WIXkNig30lTPjIwIJsvWAoxxUmjBt2/7Ac1XX3NW9vZ93rG0QY9nfItRONNBMCmSIsMi
	GpgMGnGYZeFM4LJM7DSk9ljF5Na5mW5RN32TaP09ZEImLvZDI9OBaIdX3KEivaGExF/xD+
	D6Vu02fJwxV6kyCjrNo50PTUwnr+5HDrAnnZ+aq/VICCxRDZl0aD/KpldwbV5w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 22 Dec 2025 17:28:13 +0100
Subject: [PATCH yocto-autobuilder2 1/3] docker: Fix QEMU on yocto-worker
 docker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-mathieu-fix-ptest-urls-v1-1-4153fdb174a8@bootlin.com>
References: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
In-Reply-To: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766420910; l=1841;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=/8aZauBAbT8OKwHaQjBWnb7d/R08i0KPMpCIcX6KhmA=;
 b=ug4P05Q5uhbuHryS+JR0WzxxqlbDf5mD7mj0LRLdxwgLJS9cUnxGGYWsNQKCetWePmzwmtSex
 jelOXhqKFKFC1dnUBLvNGlSaNnkgdH+iqOBFwfIRR+FvhHh3cx08uUq
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2846

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile   | 4 ++++
 docker/compose.yaml | 9 +++++++++
 docker/entry.sh     | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index b1df86022520..d291bce9a48c 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -21,6 +21,7 @@ RUN apt update && \
         git \
         iproute2 \
         iputils-ping \
+        iptables \
         libacl1 \
         libcairo2 \
         liblz4-tool \
@@ -33,6 +34,7 @@ RUN apt update && \
         python3-pip \
         python3-subunit \
         socat \
+        sudo \
         texinfo \
         unzip \
         virtualenv \
@@ -45,6 +47,8 @@ ENV LANG en_US.UTF-8
 ENV LANGUAGE en_US:en
 ENV LC_ALL en_US.UTF-8
 
+RUN echo "pokybuild	ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/pokybuild
+
 RUN npm install -g yarn
 
 RUN pip3 install --break-system-packages \
diff --git a/docker/compose.yaml b/docker/compose.yaml
index 334e13720b3b..23d09f4fe52c 100644
--- a/docker/compose.yaml
+++ b/docker/compose.yaml
@@ -27,6 +27,15 @@ services:
     command: worker
     cpus: 8
     mem_limit: 16gb
+    devices:
+      - /dev/net/tun:/dev/net/tun:rwm
+      - /dev/kvm:/dev/kvm:rwm
+    cap_add:
+      - NET_ADMIN
+      - SYS_ADMIN
+    security_opt:
+      - systempaths=unconfined
+      - apparmor=unconfined
   extraworker:
     <<: *base-worker
     command: extraworker
diff --git a/docker/entry.sh b/docker/entry.sh
index 900e4b9b229f..fe4c4b5def25 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+chmod 666 /dev/kvm
+
 chown pokybuild:nogroup /sharedrepo
 chown pokybuild:nogroup /publish
 chown pokybuild:nogroup /home/pokybuild/git/mirror

-- 
2.47.3


