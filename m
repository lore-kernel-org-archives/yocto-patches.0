Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB66C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 13:20:22 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.12911.1741267215223914001
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Mar 2025 05:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=hgQpZiAr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 949C420454;
	Thu,  6 Mar 2025 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741267213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ltoAdokyOmne4ddFy0Y5nm06O+RBETjqP4J1Ejd04U=;
	b=hgQpZiAriYv9oYPCxXETDcMsZ5Q1x8aYzwJOF2sFWuLmAwiSNNFRGziWPKBYPI4SYXHvjG
	jtsZ+XYmtvKus6/SFI8ymbuaBGURVzoZpkaKwqZqDkUsgQT5NDZnkSAi6ySGU4sktDZOFP
	dMxjnecpZT4jFlD5f7LRI8wiHW68iDqqMtrVBEn5kgdyl/racj9tlSZhUOMfwV8XwExYgn
	Jfm5Jz8OULIGmdW2trrk3fiu46KKlfU2Ld+y8Z/b5ttlDA6o7oe+gqG0hqlx0VtnzfncrI
	VJu9/uwR2AX8D/f6xOGpsPzbEgOuHZ1Numlc0X7jO6k+OSL7hNL1o0VZJy86WQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 06 Mar 2025 14:19:45 +0100
Subject: [PATCH yocto-autobuilder2 1/2] docker: Use current git version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-contrib-mathieu-docker_multi_workers-v1-1-d208b643cfae@bootlin.com>
References: <20250306-contrib-mathieu-docker_multi_workers-v1-0-d208b643cfae@bootlin.com>
In-Reply-To: <20250306-contrib-mathieu-docker_multi_workers-v1-0-d208b643cfae@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741267213; l=2883;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=89w2mMVIuvintg7vDYncSj7IU3ru3Q0qwaLzMnxF5Qs=;
 b=5h+gHwyevQowGB05MVaeXmb88Pmquzka0DnEF/5MuxLF1aq7uA/1wuOPLWifVxI67OfllTM1z
 nZDwcPw7Sc6DkjKyKsUUvZmPGtPF8zWUkBNZlgHin0fwm65L5un3UYI
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeujeelueduheeujeelheejiefhffdtjeefgfduhfejudeuuddvgfdugeekjefhleenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdhophgvnhgvmhgsvgguuggvugdrohhrghenucfkphepledtrdeifedrvddtvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvddtvddrgedtpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhop
 eihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 13:20:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1161

Use local git version instead of fetching remote master branch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile   |  8 +++++---
 docker/compose.yaml | 30 ++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index e7d6f99827eb..e8aea69083f2 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -58,15 +58,17 @@ ENV LC_ALL en_US.UTF-8
 RUN ssh-keyscan push.yoctoproject.org push.openembedded.org >> /etc/ssh/ssh_known_hosts
 
 # Setup buildbot
-COPY yocto-autobuilder2_patches /yocto-autobuilder2_patches
+COPY docker/yocto-autobuilder2_patches /yocto-autobuilder2_patches
+COPY . /yocto-autobuilder2
 RUN useradd -m --system pokybuild && \
     cd /home/pokybuild && \
     buildbot create-master -r yocto-controller && \
     buildbot-worker create-worker -r --umask=0o22 yocto-worker controller example-worker pass && \
     \
     cd yocto-controller && \
-    git clone https://git.yoctoproject.org/git/yocto-autobuilder2 yoctoabb && \
+    mv /yocto-autobuilder2 yoctoabb && \
     git -C yoctoabb apply /yocto-autobuilder2_patches/*.patch && \
+    rm -rf /yocto-autobuilder2_patches && \
     ln -rs yoctoabb/master.cfg master.cfg && \
     \
     cd /home/pokybuild && \
@@ -108,7 +110,7 @@ RUN sed -i \
     awk '/^schedulers.append\(sched.Nightly\(/{comment=1} /\(/{count+=gsub("\\(", "(")} /\)/{count-=gsub("\\)", ")")} {if (comment) {print "#" $0} else {print} if (count==0) comment=0}' \
         /home/pokybuild/yocto-controller/yoctoabb/schedulers.py
 
-COPY entry.sh /
+COPY docker/entry.sh /
 RUN chmod a+x /entry.sh
 
 ENTRYPOINT ["/entry.sh"]
diff --git a/docker/compose.yaml b/docker/compose.yaml
index 71758e9a6010..22191d5777e1 100644
--- a/docker/compose.yaml
+++ b/docker/compose.yaml
@@ -2,29 +2,27 @@
 
 ---
 
+x-base-service: &base-service
+  build:
+    context: ..
+    dockerfile: docker/Dockerfile
+  volumes:
+    - sharedrepo:/sharedrepo
+    - publish:/publish
+    - mirror:/home/pokybuild/git/mirror
+    - srvautobuilder:/srv/autobuilder
+  stdin_open: true
+  tty: true
+
 services:
   controller:
-    build: .
-    volumes:
-      - sharedrepo:/sharedrepo
-      - publish:/publish
-      - mirror:/home/pokybuild/git/mirror
-      - srvautobuilder:/srv/autobuilder
+    <<: *base-service
     ports:
       - 8010:8010
-    stdin_open: true
-    tty: true
     cpus: 4
     command: controller
   worker:
-    build: .
-    volumes:
-      - sharedrepo:/sharedrepo
-      - publish:/publish
-      - mirror:/home/pokybuild/git/mirror
-      - srvautobuilder:/srv/autobuilder
-    stdin_open: true
-    tty: true
+    <<: *base-service
     cpus: 8
     command: worker yocto-worker
     mem_limit: 16gb

-- 
2.39.5


