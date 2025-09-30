Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F6CCA470
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 11:09:50 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.22873.1759230583400522724
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Sep 2025 04:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U9LumDpA;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 885234E40E5A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 11:09:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E564606E4
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 11:09:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBE0C102F17D5;
	Tue, 30 Sep 2025 13:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759230580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=t2OpqYhiedpfbudOmGScswvywT73meq6V/0rheUQhTo=;
	b=U9LumDpAemitX8FVOtXOjh1uVXN08cct+Qglqdmdlc71Fiqv+XNlyw0VRk4b3tneHHy8h+
	KEF/fex03UqzNF1dZulWiD0cS+Nilt+Edqa1XqYOGqiUFLFeJlWWb0c964RO5V1QjknR39
	tX1Dv5oFzYOViztfpieuM5ydy+MvkEie6JglKA+pUXfuD0oqVDHRFfGEoSJceeQkE9pega
	2KlbjRjiMgbPQET+KwF62/XdzVV8o4x9hLK+dmdKxzf4hbaAvZFZOwPw8yUtKb7rcXu7l6
	qdIT779lZASLi7sXajPRFJwagxiS3iDe4pZArrsKW/NjrfCYMMf6KlgOvPO/lw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 30 Sep 2025 13:09:22 +0200
Subject: [PATCH yocto-autobuilder2] config: Update ubuntu workers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-mathieu-ubuntu-2504-v1-1-466f1a881c07@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGG622gC/x2M0QrCMAwAf2Xk2UCNm2P+iviQdtEFtJW2EcfYv
 1t8vIO7DYpklQKXboMsHy2aYoPjoYOwcHwI6twYyNHgppPDF9dFxdC8xWrYbI90HikM4nnkCVr
 5znLX7/96hTWFmpCtJm/6nCUT3Pb9B73uzWJ5AAAA
X-Change-ID: 20250930-mathieu-ubuntu-2504-2672c5eba7a9
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759230578; l=9853;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=oRJN2a0axxrT4NT+DF3cuJ8xjYxeZFVnz5uinxw9QCQ=;
 b=O6QHratH4xAefNHD5kQ1EROi5eCW9rYX622zr8vs7VN6U6KCLimCOJYs0zEueDZ+Rqd/WxU7m
 nEWn/Hxn9KDBkF0qhGxwUAHpflYUamuy+5l2GU4pGsZ9alsEaSTkwg2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 11:09:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2262

Ubuntu 24.10 workers have been replaced by Ubuntu 25.04.
Ubuntu 20.04 workers have been put offline.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/config.py b/config.py
index 16a25cfbe764aa52fd42263e3cfa75b2eb2122da..dd85dd816ea233d07c709221cf66a527e031754a 100644
--- a/config.py
+++ b/config.py
@@ -162,7 +162,7 @@ publish_dest = "/srv/autobuilder/autobuilder.yocto.io/pub"
 web_port = 8010
 
 # List of workers in the cluster
-workers_ubuntu = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
+workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1"]
 workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9"]
@@ -172,29 +172,29 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
-workers_wine = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
-workers_arm = ["ubuntu2004-vk-arm1", "ubuntu2004-vk-arm2", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2410-vk-arm1"]
+workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_arm = ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-2"]
 #workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2"]
-workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
+workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 
 all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
 # Worker filtering for older releases
 workers_prev_releases = {
-    "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
-    "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
-    "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
-    "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
-    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
-    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
-    "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu2004", "perf-"),
-    "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "perf-"),
-    "dunfell" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2204", "perf-"),
+    "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2504", "perf-"),
+    "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2204", "ubuntu2304", "perf-"),
+    "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2204", "perf-"),
+    "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2204", "perf-"),
+    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
+    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2110", "ubuntu2204", "perf-"),
+    "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "perf-"),
+    "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "perf-"),
+    "dunfell" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2204", "perf-"),
 }
 
 # Worker configuration, all workers configured the same...
@@ -212,7 +212,7 @@ builder_to_workers = {
     "oe-selftest-ubuntu": workers_ubuntu,
     "oe-selftest-opensuse": workers_opensuse,
     "oe-selftest-centos": workers_centos,
-    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2410-vk-arm1"],
+    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"],
     "meta-mingw": workers_wine,
     "buildperf-debian11": ["perf-debian12-vk"],
     "buildperf-alma8": ["perf-alma8-vk"],
@@ -226,7 +226,7 @@ builder_to_workers = {
     "auh-meta-oe" : workers_auh,
     "metrics": workers_centos + workers_debian + workers_opensuse,
      # Have gitstats and gnuplot
-    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"],
+    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"],
     "toaster": workers_toaster,
     "default": workers
 }

---
base-commit: bd6fe5e7bb5291e8d8a5e9dfa3c2bb196d8f05df
change-id: 20250930-mathieu-ubuntu-2504-2672c5eba7a9

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


