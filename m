Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27272E677F2
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:28:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83507.1766420920066453723
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:28:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dGh+A7SI;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8857A4E41D34
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60BC0606C1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8ACA10AB03F7;
	Mon, 22 Dec 2025 17:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766420914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ri9YOOFN9emg13ayGPb8o/c3Jm6q66AG3Q8ay1MoMTI=;
	b=dGh+A7SI1Z38r3krWedUlzFAKGgJj0CWD5MTbnUubxWA3ZiNoCZiAD6C2A1ZbbLI2GW4ey
	PHqRRavNKmdNUvODIWT48vDx/EmusxXJqQcIEPW+BDhYbqd8x1CZtygOIjAOZp1KYGz0ev
	2VRJxfwLdbbS8Ycp8mtb4ifMW6xB0U8YmvHyrATB3eUKBKYv/rejiMpUvROOfKUqcANu6s
	tL4GmgIeef/fiuq45lYCHKD0zi7V+ZxhPwTqENR5bkleh+B3keO7uTapa5owmIMdpXqnYS
	JLHP7YAOceZzCNfXERWNQ30mvEeeD2Ee+ffmLfrbQb2VpKoF/2ygw6UFxjMF/A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 22 Dec 2025 17:28:14 +0100
Subject: [PATCH yocto-autobuilder2 2/3] docker: do not change shared and
 publish directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-mathieu-fix-ptest-urls-v1-2-4153fdb174a8@bootlin.com>
References: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
In-Reply-To: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766420910; l=2291;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=PxO9LUbMlMcfj+duf1TEFhpXO45c/xjRzUL/x+vzW70=;
 b=VW/hgJAGkZbc+Y1J3uVHbhvxxJCX5XvM7ENiJcgWIBNnw9zFZxhfEwquH9mC37dgmoNQZz9Jx
 uX3lQw/k58pBkTnF8C3ZuKF9BMaxqunP68rBsagfyJf54IBM8QAlQOt
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2848

We need to use the same public directory name as on the public
instance, so the log observers can match lines about yocto.io folders.
---
 docker/Dockerfile   | 5 +----
 docker/compose.yaml | 2 --
 docker/entry.sh     | 4 ++--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index d291bce9a48c..3d6be54b0e47 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -110,14 +110,11 @@ RUN sed -i \
         -e "/^all_workers *=/s/workers_bringup + //" \
         # Switch from ssh:// URLS to git:// so we do not need any auth \
         -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
-        # Change location of sharedrepodir and publish_dest directories \
-        -e "s@^\(sharedrepodir *= *\).*@\1\"/sharedrepo\"@" \
-        -e "s@^\(publish_dest *= *\).*@\1\"/publish\"@" \
         # Use any worker for any release \
         -e '$ a workers_prev_releases = {}' \
         /home/pokybuild/yocto-controller/yoctoabb/config.py && \
     sed -i \
-        # Change location of sharedrepodir and publish_dest directories \
+        # Use git protocol instead of ssh
         -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
         /home/pokybuild/yocto-autobuilder-helper/config.json && \
     sed -i \
diff --git a/docker/compose.yaml b/docker/compose.yaml
index 23d09f4fe52c..97ea724b968f 100644
--- a/docker/compose.yaml
+++ b/docker/compose.yaml
@@ -8,8 +8,6 @@ x-base-service: &base-service
     context: ..
     dockerfile: docker/Dockerfile
   volumes:
-    - sharedrepo:/sharedrepo
-    - publish:/publish
     - mirror:/home/pokybuild/git/mirror
     - srvautobuilder:/srv/autobuilder
   stdin_open: true
diff --git a/docker/entry.sh b/docker/entry.sh
index fe4c4b5def25..125f447be4f2 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -2,8 +2,8 @@
 
 chmod 666 /dev/kvm
 
-chown pokybuild:nogroup /sharedrepo
-chown pokybuild:nogroup /publish
+chown pokybuild:nogroup /srv/autobuilder/repos
+chown pokybuild:nogroup /srv/autobuilder/autobuilder.yocto.io/pub
 chown pokybuild:nogroup /home/pokybuild/git/mirror
 chown pokybuild:nogroup /srv/autobuilder
 cd /home/pokybuild/ || exit 1

-- 
2.47.3


