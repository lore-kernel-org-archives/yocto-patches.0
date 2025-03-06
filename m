Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8EDC28B25
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 13:20:22 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.12980.1741267215254267426
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Mar 2025 05:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mpamIden;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C997C204D3;
	Thu,  6 Mar 2025 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741267213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ3tFbrOOY2poHqrW93wKx7+kwtL9GHsRZHJ5IEZmAw=;
	b=mpamIdenSiXNaPlGZRUdiVPetczjv8YMcXrewF70OL8un7BvuyxRAr2XhfIUj03bPbGTZr
	eSqbNuXnNak47qX9JdeqTI5VyQwqzljZ5bf1ePmITsaO3Wr1UcSpxXLRv94+PevRSRZjbw
	C8re9A++gzeD5ZVt44t0UaZ5TW1N6Cm/F4m7pPHO9a1ktAQ6yTwUhRsp7UmH7R3eeyrIxM
	vCZu5jnxvRixSzDigyZIo2EIIV73pWgfT+tzrx3jFDzT44Dcl+iDhl8uWwdR31KukE6g0+
	saHcGtBYNgTfzGcV4VN3IbPtAGzvOcFqoJLcVH4L0SxoOM/YPDqlbFYT9EWpIQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 06 Mar 2025 14:19:46 +0100
Subject: [PATCH yocto-autobuilder2 2/2] docker: Allow to add several local
 workers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-contrib-mathieu-docker_multi_workers-v1-2-d208b643cfae@bootlin.com>
References: <20250306-contrib-mathieu-docker_multi_workers-v1-0-d208b643cfae@bootlin.com>
In-Reply-To: <20250306-contrib-mathieu-docker_multi_workers-v1-0-d208b643cfae@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741267213; l=4896;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=zLKZfe4wZSDDvIPZnWTBBddfzCzPgYIff975ffDqYeI=;
 b=xpqsY+SYQm3ONZFmIsn8v45q6hcMTzElh/ZnYFmp+GoK4o7YtLMM8Ht3XyVyzQ4b80k88VDol
 aTG95kjtAWKChJv3UCMxLSf+o6aooEe/Mc9ifEO2RBJCJYR9WZwI5AQ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepledtrdeifedrvddtvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvddtvddrgedtpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 13:20:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1162

Add more more workers to test more realistic setups.

The first one is still added as a Debian builder, additional ones are
used as generic ones, allowing to test worker selection.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile   |  7 ++++---
 docker/README.md    |  8 +++++---
 docker/compose.yaml | 12 +++++++++---
 docker/entry.sh     | 16 ++++++++++++----
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index e8aea69083f2..fc6e6635a873 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -9,6 +9,7 @@ ENV DEBIAN_FRONTEND=noninteractive
 RUN apt update && \
     apt full-upgrade -y && \
     apt -y install \
+        bind9-host \
         build-essential \
         chrpath \
         cpio \
@@ -63,7 +64,6 @@ COPY . /yocto-autobuilder2
 RUN useradd -m --system pokybuild && \
     cd /home/pokybuild && \
     buildbot create-master -r yocto-controller && \
-    buildbot-worker create-worker -r --umask=0o22 yocto-worker controller example-worker pass && \
     \
     cd yocto-controller && \
     mv /yocto-autobuilder2 yoctoabb && \
@@ -85,8 +85,9 @@ RUN useradd -m --system pokybuild && \
 
 # Fix config files for local runner
 RUN sed -i \
-        # Add example-worker \
-        -e "s/^\(workers_debian *=.*\).*/\1 + [\"example-worker\"]/" \
+        # Add local workers \
+        -e "s/^\(workers_debian *=.*\).*/\1 + [f\"local-worker-debian\"]/" \
+        -e "s/^\(workers *=.*\).*/\1 + [f\"local-worker-extra-{i}\" for i in range(1, 9)]/" \
         # Remove workers_bringup from all_workers \
         -e "/^all_workers *=/s/workers_bringup + //" \
         # Switch from ssh:// URLS to git:// so we do not need any auth \
diff --git a/docker/README.md b/docker/README.md
index c75f48276cca..3b00ef4261be 100644
--- a/docker/README.md
+++ b/docker/README.md
@@ -8,7 +8,7 @@ buildbot controller, one acting as buildbot worker.
 
 The buildbot configuration will be modified in several ways from the
 configuration used in the public autobuilders. Main changes include:
- - Only one worker will be used.
+ - Only a few workers will be used.
  - Git urls will be modified to use git protocol instead of ssh, removing needs
    for authentication.
  - All nightly schedulers will be disabled.
@@ -17,7 +17,9 @@ configuration used in the public autobuilders. Main changes include:
 
 The local autobuilder can be started by running `docker-compose up` in this
 folder. Once the dockers are started, buildbot web interface will be exposed on
-http://localhost:8010/.
+http://localhost:8010/. Note that with the default profile, only one worker will
+be started. You can start extra workers with `docker-compose --profile
+manyworkers`.
 
 You might want to modify the `compose.yaml` file first to suit your needs, such
-as the cpu count and memory limits.
+as the cpu count, memory limits and number of extra workers.
diff --git a/docker/compose.yaml b/docker/compose.yaml
index 22191d5777e1..50034d90d52b 100644
--- a/docker/compose.yaml
+++ b/docker/compose.yaml
@@ -20,12 +20,18 @@ services:
     ports:
       - 8010:8010
     cpus: 4
-    command: controller
-  worker:
+  worker: &base-worker
     <<: *base-service
     cpus: 8
-    command: worker yocto-worker
     mem_limit: 16gb
+  extraworker:
+    <<: *base-worker
+    cpus: 1
+    mem_limit: 2gb
+    deploy:
+      replicas: 8
+    profiles:
+      - manyworkers
 
 volumes:
   sharedrepo:
diff --git a/docker/entry.sh b/docker/entry.sh
index 3518eecb9a32..1aef2ba4025f 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -6,15 +6,23 @@ chown pokybuild:nogroup /home/pokybuild/git/mirror
 chown pokybuild:nogroup /srv/autobuilder
 cd /home/pokybuild/ || exit 1
 
-role="$1"
+docker_name=$(host "$(host "$(hostname)" | awk '{print $NF}')" | awk '{print $NF}' | awk -F . '{print $1}')
+role=$(echo "${docker_name}" | cut -d_ -f 2)
+instance=$(echo "${docker_name}" | cut -d_ -f 3)
 
 if [ "${role}" = "controller" ]; then
   su pokybuild -c "yocto-autobuilder-helper/janitor/ab-janitor" &
   su pokybuild -c "buildbot start yocto-controller"
   #tail -F yocto-controller/twistd.log &
-elif [ "${role}" = "worker" ]; then
-  workername="$2"
-  su pokybuild -c "buildbot-worker start ${workername}"
+elif [ "${role}" = "worker" ] || [ "${role}" = "extraworker" ]; then
+  if [ "${role}" = "extraworker" ]; then
+      worker_name="local-worker-extra-${instance}"
+  else
+      worker_name=local-worker-debian
+  fi
+  buildbot-worker create-worker -r --umask=0o22 yocto-worker controller "${worker_name}" pass
+  chown -R pokybuild:nogroup yocto-worker
+  su pokybuild -c "buildbot-worker start yocto-worker"
 else
   echo "Unexpected role: ${role}"
   exit 2

-- 
2.39.5


