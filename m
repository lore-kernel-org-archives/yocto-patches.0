Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE454C87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 16:08:15 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.3300.1754410094185694750
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 Aug 2025 09:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=eRBVFmwn;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3245F1F68F;
	Tue,  5 Aug 2025 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754410092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oB0lzUlHEWD/jWu5ZQnM+C02eewWWkhtVhES22MWW1E=;
	b=eRBVFmwnBhEX5PP/7ncFJ9kY595/b5x/IjDe2HIaLmm5jz5IpKGuSJ9dToegb98I9TWxAs
	1Krzw4OiYVlxzkQZlhYJbXa7iy5Sa07zkw0Rb+LgkvJfNWl+XISQXOJWJpvfSU+L2LBGxT
	MRgARiAgb+eA6n/R+WJHXAx0OVrDiunGiJ6KECpqsEyQRsFh7GK7U1lr1Brkj1qWD/reRb
	4aK3irhWhoATYarIIn6Lu7EiRywiO+IAMjciXpW5zxJuxfZoZE/p1m3fuRIPO/rJtvvCrX
	Qw5C8e4qKH2Nvi/leTq6pOmxsRJWvuktJXZ7a8Zy+IULmfryblVxViijCsc29Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 05 Aug 2025 18:08:03 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros:
 check worker status on AB API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-check-worker-statuses-v1-1-103948a7ccc5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGIskmgC/yXMQQ7CIBBA0as0s5aEklTRqzRdwDAVbFMaBqqm6
 d1FXb7F/zswpUAMt2aHRFvgEJeK9tQAerPcSQRXDUqqTmrZCfSEk3jGNFESnE0uTCzsudWo5EW
 PVwe1XRON4fX79sPfXOyDMH9n/TtijsKUHG0Js6snT/NKaYDj+AD3m1/4kwAAAA==
X-Change-ID: 20250805-check-worker-statuses-b618c2078f9d
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Jyc2GroHKZJzVVG4up23c8787kDtIYdgAFb/ElBfNbs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBokixrwTmlNS8ZN6R1SIdMTy1y8sAypwrfqq96n
 rVmHK78P2iJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJIsawAKCRDRgEFAKaOo
 NtKeD/9vGK+fIBlbmfc3rkU9Ix9vtFS1ha0SoxBJR37ovUvexN/3mqZHSsjkeWpwwnBgHDm7+NJ
 ffMpNB+yxU7h6lbqIRCKSS6JqBzmC23Rk7EAtb40BvC3vT1md6qaODWLbBkGujjXaIkruPjO3ge
 cfYpvAwHcP6j3KY11gFHTYEEQJ956i5YXgfC/PsIhXh41hzw619hox4L2XHAy3ALGCtaMekYfA4
 4ERUphbJCROsWIh5jWIdgH33sWScRhVbae++uRTWQeexwYgJZ7wvT7GDgA/n34ExAKkiGYReyG+
 DS/Bd39cYxXy3EM+3jz9s0tnsVVd6oakwIu/Cc46qrsfYev8e7Kq4zbkY4UJvdLPd2KY0sO5Ed7
 +O+uUb7LaE1eSpMMhF3LN7skP9I1jYN7fmho2o3PWric0BkYbihfdk/L/VcFCEArFRgXzQR/Ybn
 M6+nhZlj6XG0kec/2v1sTyatIS0ybBQyEEkP5HKNC7AApJCufbbbpFW20d4cZTB5uNBsaH1b5aP
 xg8vScmBGE7XujKDqjp5A+51D7fIy2SCaLml0A0uSB2O+lU8H7oVWrc7IVSqe17kurUYKJZgcUQ
 CXg1ppd8WmaDh6dW01j4XQeImNSCK3GEPSXsoQpG4Wc70wJhamTl8rUk8iPPQ/FGaPVlLJ/YhKq
 nNBz88TaR0kCO5A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegkedvleekueeuudfgleevheeggeeggfetgeehtdejtefhteetvdelffeftddvleenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgtohhnfhhighdrphihnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhot
 hhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 Aug 2025 16:08:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1886

Add a --check-worker-statuses flag to also check the workers statuses on
the Autobuilder, and filter out any worker that is currently
disconnected.

This should help maintaining the config.py file in the Autobuilder. This
is relevant for the master branch here as we do not need to maintain
poky.conf as strictly on stable branches.

This should warn the following on master, at the time of writing:

  WARNING: Missing on the autobuilder but listed in poky.conf: ubuntu-20.04

Meaning ubuntu-20.04 should be removed from poky.conf on meta-poky's
master.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json                     |  2 +-
 scripts/yocto-supported-distros | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 171e885..16ff72f 100644
--- a/config.json
+++ b/config.json
@@ -470,7 +470,7 @@
             "step2" : {
                 "removevars" : ["SANITY_TESTED_DISTROS"],
                 "shortname" : "Compare AB workers and SANITY_TESTED_DISTROS",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare"]
+                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare --check-worker-statuses"]
             }
         },
         "trigger-build-posttrigger" : {
diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 172a186..3664cf3 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -39,6 +39,7 @@
 # from a custom branch.
 
 import argparse
+import json
 import os
 import re
 import urllib.request
@@ -52,6 +53,7 @@ from urllib.error import HTTPError
 
 
 CONFIG_REMOTE_URL = "https://git.yoctoproject.org/yocto-autobuilder2/plain/config.py"
+AUTOBUILDER_WORKERS_ENDPOINT = "https://autobuilder.yoctoproject.org/valkyrie/api/v2/workers"
 
 
 def parse_arguments() -> argparse.Namespace:
@@ -80,6 +82,11 @@ def parse_arguments() -> argparse.Namespace:
                         action="store_true",
                         help="Get config.py from yoctoproject's git web interface")
 
+    parser.add_argument("--check-worker-statuses",
+                        action="store_true",
+                        default=False,
+                        help="Also check the worker statuses using the Autobuilder API")
+
     return parser.parse_args()
 
 
@@ -242,6 +249,40 @@ def _compare(ab_workers: set, poky_workers: set, stable_release: bool):
     return ok
 
 
+def _filter_workers(possible_workers: Dict) -> Dict:
+    """
+    From the current dictionary of workers, remove the workers that are inactive
+    (disconnected) by checking the Autobuilder REST API.
+    """
+
+    _possible_workers = {}
+    workers_ab = None
+
+    try:
+        with urllib.request.urlopen(AUTOBUILDER_WORKERS_ENDPOINT) as r:
+            workers_ab = json.load(r).get("workers")
+    except (HTTPError, AttributeError) as e:
+        print(f"WARNING: Error when trying to fetch the worker statuses from {AUTOBUILDER_WORKERS_ENDPOINT}:")
+        print(e)
+        print("Safely exiting...")
+        exit(0)
+
+    if not workers_ab:
+        return possible_workers
+
+    def is_connected(worker):
+        for w_info in workers_ab:
+            if w_info.get("name") == worker and w_info.get("connected_to"):
+                return True
+
+        return False
+
+    for release in possible_workers:
+        _possible_workers[release] = [w for w in possible_workers[release] if is_connected(w)]
+
+    return _possible_workers
+
+
 def main():
 
     args = parse_arguments()
@@ -305,6 +346,9 @@ def main():
             {release: _possible_workers(config.workers_prev_releases[release],
                                         config.all_workers)})
 
+    if args.check_worker_statuses:
+        possible_workers = _filter_workers(possible_workers)
+
     if args.compare:
         assert len(releases) == 1, "Only one release should be passed for this mode"
         release = releases[0]

---
base-commit: baa4a9a06acf544e91f4816fd0cca484a6f7dab7
change-id: 20250805-check-worker-statuses-b618c2078f9d

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


