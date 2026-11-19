Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14147.1795094388940231368
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Nov 2026 05:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SgdFg/dv;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7D7FDC4CBF3
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EE0C60237;
	Thu, 19 Nov 2026 13:19:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D45211BC0B70;
	Thu, 19 Nov 2026 14:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795094386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BSUMJQnmjKdxe7kdD+auAsYFcYmOLFkGcsY3cklX6wo=;
	b=SgdFg/dv+ORprv5fCbnaIqpNkYsNcREjCx5aVkiOmdhpLxsUZi+vTKPLBdcO/zWTCoyi4V
	kP2nKR2WfXN5fAcyLmzfuzLFYQXilUHmL2VWaKFZom7ahaADsEmN1yMcaB086V8Wa99gaV
	XqJRS/EauTKfzlDZnW4bTHC4ATb38ey9btEM9bBSAfJzp5p4CE587F21LD7WRyHE0kn1KK
	zjqPTd7gpy/c19O2bLv5vCsGToUYJvZcLjSfa9Xz1j2wl3jpLsI96gi67fmJ/pb7kHuwlo
	eqp91m2pPCPlK4JTJZh85Hu95cSx0v/tb4c4uK9uclQ0diWuO0ljFIDoZeFDHQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Nov 2026 14:19:34 +0100
Subject: [PATCH yocto-autobuilder2 2/3] docker: Fix for buildbot 4.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mathieu-buildbot-4-4-b4-v1-2-76774afaee1d@bootlin.com>
References: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
In-Reply-To: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Halstead <mhalstead@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795094383; l=2712;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=6TXvKJfm0sLqc5X/ZpKfab2Q3XUp1af17hM2N/ljW7E=;
 b=Yhzp6F0ji4b2NF73SNFZRX2GnFb3HWfueanoNNm43fSPW56WsLV5y9u5dxdz/Zt67PmfYhof5
 z8/nIDsE0EkDpeBfgNE48rSF7pt7hn2t8FxEVk2kmoLMBWIrnyZiHAr
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5477

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 0ddd20d52ac6..f657e7f23bd6 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -1,4 +1,4 @@
-FROM ubuntu:24.04
+FROM ubuntu:26.04
 
 ARG AUTOBUILDER2_BRANCH=master
 
@@ -20,11 +20,11 @@ RUN apt update && \
         gcc \
         git \
         iproute2 \
-        iputils-ping \
         iptables \
+        iputils-ping \
         libacl1 \
         libcairo2 \
-        liblz4-tool \
+        lz4 \
         locales \
         npm \
         python3 \
@@ -62,18 +62,15 @@ RUN pip3 install --break-system-packages \
         buildbot_pkg==4.3.0 \
         websockets
 
-
 # Uncomment and update following code to use a custom buildbot branch
-# RUN pip3 install --break-system-packages \
-#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=master \
-#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=worker \
-#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=pkg \
-#         websockets \
-#     && \
-#     git clone https://github.com/mbriand/buildbot.git -b mathieu/workers_limit && \
-#     cd buildbot/ && \
-#     make frontend_deps && \
-#     pip3 install --break-system-packages pkg www/base www/console_view www/grid_view www/waterfall_view www/wsgi_dashboards www/badges
+#RUN pip3 install --break-system-packages \
+#        git+https://github.com/buildbot/buildbot.git@v4.4.0rc1#subdirectory=master \
+#        git+https://github.com/buildbot/buildbot.git@v4.4.0rc1#subdirectory=worker \
+#        websockets
+#RUN git clone https://github.com/buildbot/buildbot.git -b v4.4.0rc1 && \
+#    cd buildbot/ && \
+#    make frontend_build && \
+#    pip3 install --break-system-packages pkg www/base www/console_view www/grid_view www/waterfall_view www/wsgi_dashboards www/badges
 
 RUN ssh-keyscan push.yoctoproject.org push.openembedded.org >> /etc/ssh/ssh_known_hosts
 
@@ -92,6 +89,10 @@ RUN useradd -m --system pokybuild && \
     \
     cd /home/pokybuild && \
     git clone https://git.yoctoproject.org/git/yocto-autobuilder-helper && \
+    cd /home/pokybuild/yocto-controller/yoctoabb/yocto_console_view && \
+    yarn install --pure-lockfile && \
+    yarn build && \
+    cd /home/pokybuild && \
     pip install --break-system-packages \
         yocto-controller/yoctoabb/yocto_console_view/ && \
     mkdir -p /home/pokybuild/git/trash && \

-- 
2.47.3

