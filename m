Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C0CAC59A
	for <webhook@archiver.kernel.org>; Fri, 19 Sep 2025 09:23:36 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.12340.1758273807298191850
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Sep 2025 02:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0WVQc3k0;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79B1E1A0F11
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E9C8606A8
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70AEA102F1C3C;
	Fri, 19 Sep 2025 11:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758273804; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Cl89KxgYeM9uWPZzpdUU2REG65oRWEjumrqGCWzNE1M=;
	b=0WVQc3k0R4vQ3Le9X26kQKdTbMhiHIvCGwyeyQRTcjiDrzeLqwm+wQmdbCP1BolJKwGuPv
	KaMlrq58z00EyOckygr9cuLsjkh4yKhJ0RzF04r8GTHkqKyFUZGsomYl7SDuFrB34cc3DK
	kt33WMg1zlFzMruRSZjniJF/oZArxeSVtx1pAZFHQl9WH6VUGmWSVKgBqNbzeVicAA6Ur9
	cbm8uyZZOyg4wgC0hSPAqQN2PSQOknCOkgXrvtAM4uE8CesadRuDZBqfaromzrb1dyDehU
	mvW1N9+HCsFXApGdMMKbWeHq8lUNS012qu+oFm6CemJdY21PP6fs4btEobsH5w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Sep 2025 11:22:48 +0200
Subject: [yocto-autobuilder2][PATCH] config.py: remove debian11 for master
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-master-exclude-debian11-v1-1-bc0e7c7998ea@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOcgzWgC/yXMywrCMBBA0V8ps3YgUxUaf6V0kceoIzWRPEql9
 N+NujyLezfInIQzXLoNEi+SJYYGOnTg7ibcGMU3Q6/6s9Kk8Wly4YS8url6Rs9WTCBCIjXQ4JU
 +niy0+pX4KuvvPE5/52of7Mp3N76jKxFNLdFWmT2nfoJ9/wAKMGUFjwAAAA==
X-Change-ID: 20250919-master-exclude-debian11-110818d0934b
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=v7HNU5R5b1xiW9SN7Ls0VhI+7m9BEnpMM7cBOOSyqY8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBozSEHmjK5W2f/h3LUkmuZwMX2rF3Bq+7xrsCEo
 J7DLM0W1uGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaM0hBwAKCRDRgEFAKaOo
 NsmjD/95Go0Y+rMCIS/lBoVTiZ43XnEEZP15yvKzKg6gY5IXXjdd/W6QNe2zpPc6x1r96HLB8Uj
 dAFRKVdIyDFkNrDJB/TRfNpiwF/2XD4srKcB8mlat4LXq9SGYEizz2MEup+4FUmKHRSjRMoC/HA
 Zab9HoawmF/jNj/x+rON+VRzKE/1YWEfMjEKdCbTef/AaCuMrUX5hpjhzj99dYyaMjLzZNMoOUL
 tx4uCt3K+pGn8DQVd+L2CVPEp8coe9kShbaboFqekA7oMWnhUHrm9wesQPFwDNm7jMf1uHQzC/7
 9LM1fpwnXgmMej9vNALhxsW7k/14f4iCtMgk7P61aXy4tTtWmyRVIv+RIvjlurRMoxrJDyH5SgV
 duJ47tgKoYQ7KpxMeIdfFwFbDAndIdTeU7+reizZHtT8eb8YjEHBkkkbs3gPULsv50zJTlcUE4m
 fPkghwg0bwa8oWcPo3rxF/2MgXYZyxvYhZ9/PjD/ioFO0WREZ9KjoXxQx+TDYPPs20ZU2bFVyTT
 cw2Zv6zUV304h9hNNQRcLq+xo7O8A7jj61JVkkOOQmFwnYlrNJlT6wwEKJatEDH3whJ9EZ9gHi/
 zF9mVt1c2PQGlDr5y3ILkj729K3cLZAaGaHc/q+V/d/Gi5QQAJmbCjOkA+dGEKMfx/mAWiATrQP
 gvX/QaE3k+KUfnQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2219

We want to keep the debian11 worker, but we want it only for the stable
releases. The current code in config.py does not allow master to run on
its own filtered list of workers, it just takes all workers in
all_workers.

Rename workers_prev_releases to worker_filters, and include master in
the list. By default, the list of workers for master is the same as
all_workers, but we remove the workers listed in master_exclude_list.

We have to do some mangling to remove the -vk. If something wrong
happens an exception is raised.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
For context see:
https://lore.kernel.org/r/DCW1DRNGJELA.1WL7VLD0XA7T2@bootlin.com
---
 builders.py       |  4 ++--
 config.py         | 20 ++++++++++++++++++--
 docker/Dockerfile |  2 +-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builders.py b/builders.py
index d26b7e9..03af055 100644
--- a/builders.py
+++ b/builders.py
@@ -163,11 +163,11 @@ def nextWorker(bldr, workers, buildrequest):
         # Has to be a better way to do this
         branch = buildrequest.sources[''].branch
     if branch and "bringup" not in bldr.name:
-        for branchname in config.workers_prev_releases:
+        for branchname in config.worker_filters:
             if branchname in branch:
                 possible_workers = []
                 for w in workers:
-                    if w.worker.workername.startswith(config.workers_prev_releases[branchname]):
+                    if w.worker.workername.startswith(config.worker_filters[branchname]):
                         possible_workers.append(w)
                 log.msg("nextWorker: Limiting %s to workers %s for %s" % (str(bldr), str(possible_workers), branchname))
                 break
diff --git a/config.py b/config.py
index 559ca99..ae8e4af 100644
--- a/config.py
+++ b/config.py
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import re
+
 # ## Build configuration, tied to config.json in yocto-autobuilder-helpers
 # Repositories used by each builder
 buildertorepos = {
@@ -197,8 +199,22 @@ workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubu
 
 all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
-# Worker filtering for older releases
-workers_prev_releases = {
+_remove_vk_re = re.compile(r"^(.+)-vk(-.+)?$")
+def mangle_worker(w: str):
+    m = re.match(_remove_vk_re, w)
+    if m:
+        return m.group(1)
+
+    raise Exception(f"Not able to mangle the following worker: {w}")
+
+# Workers we want to exclude for testing on master* branches
+master_exclude_list = ("debian11",)
+
+master_workers = list({mangle_worker(w) for w in all_workers if mangle_worker(w) not in master_exclude_list})
+
+# Worker filtering for branches
+worker_filters = {
+    "master" : master_workers,
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
diff --git a/docker/Dockerfile b/docker/Dockerfile
index 6948a11..5d8997f 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -110,7 +110,7 @@ RUN sed -i \
         -e "s@^\(sharedrepodir *= *\).*@\1\"/sharedrepo\"@" \
         -e "s@^\(publish_dest *= *\).*@\1\"/publish\"@" \
         # Use any worker for any release \
-        -e '$ a workers_prev_releases = {}' \
+        -e '$ a worker_filters = {}' \
         /home/pokybuild/yocto-controller/yoctoabb/config.py && \
     sed -i \
         # Change location of sharedrepodir and publish_dest directories \

---
base-commit: 5dab41d319bc8a5fece467485d11fbf05cee5688
change-id: 20250919-master-exclude-debian11-110818d0934b

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


