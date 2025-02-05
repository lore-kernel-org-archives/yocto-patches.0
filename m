Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A575C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:52:27 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.9483.1738752746311667012
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mw+lf61I;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF8D743190;
	Wed,  5 Feb 2025 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXm+SWw7RF/3MfT6zU6VDfs0MOPwpmhNGDtjqhG6nTs=;
	b=mw+lf61IO2GmGMBEk7R3gW7qUNgiuYjkaxD5X+XESqyi6sqHV0aliNF6sG4Qcs9IS0LX8L
	m8lNIt5s5zxLh6PJGU1f6hf9T5CmwU3ILY0rQhDDsGvXKFVWo798ALhJ+bPHHUVKlKnU/0
	1ihHLV4uHEe8xIdxD4MglvmcxZwGOdoTv3OEfV1edAqXOmCPZWzDtt8K1ROhOfTYzLNdwg
	6MJVFB+7R/c+LCrkoFjQIxLMawZLRgS1YSat/W9EdntsHonuRLbTKxCNkFiGN8qYpzY2O9
	BP9bJ7adGYJT5K8dZ93Iw7gO8EzHIHcgQh6UP+Vi4o2cXsxHn7DLA3+MYYct5Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:52:09 +0100
Subject: [PATCH yocto-autobuilder2 2/2] docker: Add docker file to create a
 local instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-local_ab_docker-v1-2-b1543323b7e7@bootlin.com>
References: <20250205-mathieu-local_ab_docker-v1-0-b1543323b7e7@bootlin.com>
In-Reply-To: <20250205-mathieu-local_ab_docker-v1-0-b1543323b7e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752744; l=11062;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=w8hnVG38lLzAZEdJEWs+Tn+yESGhhvSsAq7xOKdzWt4=;
 b=iR8pNYIRjY41iZwT3TQutIdWy1pYhSkbci+Bo7gFuE2rm4IEdWAQ2IzWdjuPTjj0igLsUv2cD
 q48pluBVT5vAkBx3n0Vx7CiXN5Yrf9u3s6flXCF/priLJ+B1yFDPhe/
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheplefgvdfhueetgedtueefvdfgtdeuieeiteffudffveefgfetgeevgfekteduteejnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdpohhpvghnvghmsggvugguvggurdhorhhgpdhlohgtrghlhhhoshhtkedtuddtrdihohhunecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrp
 hgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:52:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1039

Add a docker compose configuration, allowing to easily create a local
autobuilder instance.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile                                  | 114 +++++++++++++++++++++
 docker/README.md                                   |  23 +++++
 docker/compose.yaml                                |  36 +++++++
 docker/entry.sh                                    |  23 +++++
 ...builders-Do-not-create-tags-during-builds.patch |  25 +++++
 ...Modify-free-space-check-to-work-in-docker.patch |  36 +++++++
 6 files changed, 257 insertions(+)

diff --git a/docker/Dockerfile b/docker/Dockerfile
new file mode 100644
index 000000000000..e7d6f99827eb
--- /dev/null
+++ b/docker/Dockerfile
@@ -0,0 +1,114 @@
+FROM ubuntu:24.04
+
+ARG AUTOBUILDER2_BRANCH=master
+
+USER root
+
+# Install needed packages
+ENV DEBIAN_FRONTEND=noninteractive
+RUN apt update && \
+    apt full-upgrade -y && \
+    apt -y install \
+        build-essential \
+        chrpath \
+        cpio \
+        debianutils \
+        diffstat \
+        file \
+        gawk \
+        gcc \
+        git \
+        iproute2 \
+        iputils-ping \
+        libacl1 \
+        liblz4-tool \
+        locales \
+        npm \
+        python3 \
+        python3-git \
+        python3-jinja2 \
+        python3-pexpect \
+        python3-pip \
+        python3-subunit \
+        socat \
+        texinfo \
+        unzip \
+        virtualenv \
+        wget \
+        xz-utils \
+        zstd
+
+RUN pip3 install --break-system-packages \
+        buildbot==4.2.1 \
+        buildbot-www==4.2.1 \
+        buildbot-waterfall-view==4.2.1 \
+        buildbot-console-view==4.2.1 \
+        buildbot-grid-view==4.2.1 \
+        buildbot-worker==4.2.1 \
+        buildbot_pkg==4.2.1 \
+        websockets
+
+RUN npm install -g yarn
+
+RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
+ENV LANG en_US.UTF-8
+ENV LANGUAGE en_US:en
+ENV LC_ALL en_US.UTF-8
+
+RUN ssh-keyscan push.yoctoproject.org push.openembedded.org >> /etc/ssh/ssh_known_hosts
+
+# Setup buildbot
+COPY yocto-autobuilder2_patches /yocto-autobuilder2_patches
+RUN useradd -m --system pokybuild && \
+    cd /home/pokybuild && \
+    buildbot create-master -r yocto-controller && \
+    buildbot-worker create-worker -r --umask=0o22 yocto-worker controller example-worker pass && \
+    \
+    cd yocto-controller && \
+    git clone https://git.yoctoproject.org/git/yocto-autobuilder2 yoctoabb && \
+    git -C yoctoabb apply /yocto-autobuilder2_patches/*.patch && \
+    ln -rs yoctoabb/master.cfg master.cfg && \
+    \
+    cd /home/pokybuild && \
+    git clone https://git.yoctoproject.org/git/yocto-autobuilder-helper && \
+    pip install --break-system-packages \
+        yocto-controller/yoctoabb/yocto_console_view/ && \
+    mkdir -p /home/pokybuild/git/ && \
+    mkdir -p /home/pokybuild/tmp/ && \
+    echo "[user]\nname=pokybuild\nemail=pokybuild@none\n" > \
+        /home/pokybuild/.gitconfig && \
+    chown -R pokybuild:nogroup /home/pokybuild && \
+    mkdir -p /srv/autobuilder/ && \
+    chown -R pokybuild:nogroup /srv/autobuilder/
+
+# Fix config files for local runner
+RUN sed -i \
+        # Add example-worker \
+        -e "s/^\(workers_debian *=.*\).*/\1 + [\"example-worker\"]/" \
+        # Remove workers_bringup from all_workers \
+        -e "/^all_workers *=/s/workers_bringup + //" \
+        # Switch from ssh:// URLS to git:// so we do not need any auth \
+        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
+        # Change location of sharedrepodir and publish_dest directories \
+        -e "s@^\(sharedrepodir *= *\).*@\1\"/sharedrepo\"@" \
+        -e "s@^\(publish_dest *= *\).*@\1\"/publish\"@" \
+        /home/pokybuild/yocto-controller/yoctoabb/config.py && \
+    sed -i \
+        # Change location of sharedrepodir and publish_dest directories \
+        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
+        /home/pokybuild/yocto-autobuilder-helper/config.json && \
+    sed -i \
+        # imp was removed in python 3.12, switch to importlib \
+        -e "s/^import imp$/import importlib as imp/" \
+        # Fix own URL \
+        -e "s@^\(c\['buildbotURL'\] *= *\).*@\1\"http://localhost:8010/\"@" \
+        /home/pokybuild/yocto-controller/master.cfg && \
+    # Comment any sched.Nightly schedulers \
+    # We try to support multilines code blocks by counting parenthesis \
+    awk '/^schedulers.append\(sched.Nightly\(/{comment=1} /\(/{count+=gsub("\\(", "(")} /\)/{count-=gsub("\\)", ")")} {if (comment) {print "#" $0} else {print} if (count==0) comment=0}' \
+        /home/pokybuild/yocto-controller/yoctoabb/schedulers.py
+
+COPY entry.sh /
+RUN chmod a+x /entry.sh
+
+ENTRYPOINT ["/entry.sh"]
diff --git a/docker/README.md b/docker/README.md
new file mode 100644
index 000000000000..c75f48276cca
--- /dev/null
+++ b/docker/README.md
@@ -0,0 +1,23 @@
+# Local autobuilder setup docker
+
+This docker compose configuration aims to provide a working minimal setup,
+allowing to test and debug the buildbot configuration.
+
+It create two docker containers based on the same image, one acting as a
+buildbot controller, one acting as buildbot worker.
+
+The buildbot configuration will be modified in several ways from the
+configuration used in the public autobuilders. Main changes include:
+ - Only one worker will be used.
+ - Git urls will be modified to use git protocol instead of ssh, removing needs
+   for authentication.
+ - All nightly schedulers will be disabled.
+
+## Usage
+
+The local autobuilder can be started by running `docker-compose up` in this
+folder. Once the dockers are started, buildbot web interface will be exposed on
+http://localhost:8010/.
+
+You might want to modify the `compose.yaml` file first to suit your needs, such
+as the cpu count and memory limits.
diff --git a/docker/compose.yaml b/docker/compose.yaml
new file mode 100644
index 000000000000..71758e9a6010
--- /dev/null
+++ b/docker/compose.yaml
@@ -0,0 +1,36 @@
+# Expose buildbot on http://localhost:8010/
+
+---
+
+services:
+  controller:
+    build: .
+    volumes:
+      - sharedrepo:/sharedrepo
+      - publish:/publish
+      - mirror:/home/pokybuild/git/mirror
+      - srvautobuilder:/srv/autobuilder
+    ports:
+      - 8010:8010
+    stdin_open: true
+    tty: true
+    cpus: 4
+    command: controller
+  worker:
+    build: .
+    volumes:
+      - sharedrepo:/sharedrepo
+      - publish:/publish
+      - mirror:/home/pokybuild/git/mirror
+      - srvautobuilder:/srv/autobuilder
+    stdin_open: true
+    tty: true
+    cpus: 8
+    command: worker yocto-worker
+    mem_limit: 16gb
+
+volumes:
+  sharedrepo:
+  publish:
+  mirror:
+  srvautobuilder:
diff --git a/docker/entry.sh b/docker/entry.sh
new file mode 100644
index 000000000000..3518eecb9a32
--- /dev/null
+++ b/docker/entry.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+chown pokybuild:nogroup /sharedrepo
+chown pokybuild:nogroup /publish
+chown pokybuild:nogroup /home/pokybuild/git/mirror
+chown pokybuild:nogroup /srv/autobuilder
+cd /home/pokybuild/ || exit 1
+
+role="$1"
+
+if [ "${role}" = "controller" ]; then
+  su pokybuild -c "yocto-autobuilder-helper/janitor/ab-janitor" &
+  su pokybuild -c "buildbot start yocto-controller"
+  #tail -F yocto-controller/twistd.log &
+elif [ "${role}" = "worker" ]; then
+  workername="$2"
+  su pokybuild -c "buildbot-worker start ${workername}"
+else
+  echo "Unexpected role: ${role}"
+  exit 2
+fi
+
+/bin/bash
diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
new file mode 100644
index 000000000000..567b80f0ae7b
--- /dev/null
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -0,0 +1,25 @@
+From ee671836ad9f0b65fa8b8b11c7f366377521ab20 Mon Sep 17 00:00:00 2001
+From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+Date: Fri, 3 Jan 2025 09:39:06 +0100
+Subject: [PATCH 1/2] builders: Do not create tags during builds
+
+Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+---
+ builders.py | 1 -
+ 1 file changed, 1 deletion(-)
+
+diff --git a/builders.py b/builders.py
+index 14ea1df1192e..ba47241de2cc 100644
+--- a/builders.py
++++ b/builders.py
+@@ -273,7 +273,6 @@ def create_parent_builder_factory(buildername, waitname):
+             util.Interpolate("%(prop:builddir)s/layerinfo.json"),
+             util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
+             "-p", get_publish_dest,
+-            "-t", util.Interpolate("%(prop:buildername)s-%(prop:buildnumber)s"),
+         ],
+         haltOnFailure=True,
+         name="Prepare shared repositories"))
+-- 
+2.39.5
+
diff --git a/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
new file mode 100644
index 000000000000..6d3ec5539b97
--- /dev/null
+++ b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
@@ -0,0 +1,36 @@
+From 9bf9680ab9125138d926c22ca434ad86053bb5c4 Mon Sep 17 00:00:00 2001
+From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+Date: Wed, 20 Nov 2024 14:53:34 +0100
+Subject: [PATCH 2/2] builders: Modify free space check to work in docker
+
+Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+---
+ builders.py | 5 ++---
+ 1 file changed, 2 insertions(+), 3 deletions(-)
+
+diff --git a/builders.py b/builders.py
+index ba47241de2cc..02f6c10c6add 100644
+--- a/builders.py
++++ b/builders.py
+@@ -67,8 +67,7 @@ def canStartBuild(builder, wfb, request):
+ 
+     # threshold is GB of space
+     checks = {
+-        "." : (200, "HOME"),
+-        "/tmp" : (1, "/tmp"),
++        "." : (200, "root"),
+     }
+ 
+     for mountpoint in checks:
+@@ -76,7 +75,7 @@ def canStartBuild(builder, wfb, request):
+ 
+         threshold = threshold * 1024 *1024 * 1024
+ 
+-        cmd = yield shell("findmnt -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
++        cmd = yield shell("findmnt --all -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
+         if int(cmd.stdout) < threshold:
+             log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(cmd.stdout, name, threshold))
+             wfb.worker.quarantine_timeout = 10 * 60
+-- 
+2.39.5
+

-- 
2.39.5


