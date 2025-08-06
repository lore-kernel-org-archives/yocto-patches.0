Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653EFC87FDA
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.28544.1754495066111874014
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=QbRhMMdz;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B10C44333;
	Wed,  6 Aug 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrUquybbHA24k6TmaT0MjyneIYRyXFFztkcOKf4kRdE=;
	b=QbRhMMdzH7mOF5cTl7G6rYCc0oq/EnAuhEgTbIbjbTsTURwj5A95XtFB15M02seRIepoEl
	QjnJLnKrul9+l+0EjY6+kgXgsqxRJOm1rF8gLSby7b4ubvOur8UZnfcmGFlP4noAmxaq7B
	8eaxs4sdFYTxAdCpxobY4Ci575BXmWj3lQKVa0Mfjn1cjVzn8c2HRbSoM2ZF7SN2GOufTM
	YdXyj+ToDJEC2BptyE2mB+4kaLlgmWsUmaIwE9IJ/V90gFmC7Cfu2+edTskHHZy24oJ+KM
	01uw+lcHMZv3qkcQHnxewr3nQsO7KTsjWFN5/m6ARmoRuxMl5oGeaL7WlkG8tg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:31 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 1/7]
 scripts/yocto-supported-distros: check worker status on AB API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-1-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=HvGZ41AqMr/tc/rfTDCs2GjNtW0KkPLQ41/Z/XFgDt0=;
 b=kA0DAAoB0YBBQCmjqDYByyZiAGiTeFaigmUWl9By2/2q0IsBPWfGwwvioqqkfRLvjLvJ50Y9u
 IkCMwQAAQoAHRYhBIZIclGI3UAbuaDT/9GAQUApo6g2BQJok3hWAAoJENGAQUApo6g2MxcP/3mW
 BmdpgISc0rwVdaK/Soic9j50cxAy0hk89OY26qZJPVXd6Is2DUWUT1HqmQ5k/KifTaOc+LQAcTN
 BcSQex59Q/lbuDQs/qIufK9MBiEffMX5WlMBsMloScSJQuDeBuoPWJ6oZNtqYqeEOVvuI9xpu6y
 KG3BpH8Miie7y3GRQRJwjK1QoQJpq+zCgVa6XJPRqHISyZlfMGxBMoSlKex/2T865ExNERFOnmd
 C0jEfnfDjF4vArF9RDsDwh9yF4LaZYnT4/f/GkHgMmb3eBPE0MjtpTZgLo6KhyJBlAJdrrc9Q0G
 WdeokIoMf4hOmY/ZuUP8Ryce8DYtflQ7OGJuQd7d2g57/Kb/B2pa+cSO3JYLoxpbRMZvKs6IAX9
 mZKTdeCDkTKkTV9ejKcHQWhK0uAEF9+xg4XYIzBsqcEyZ+x4TM/A/Xwv6OjqF59uEkU5j0+IH2x
 2FZ3zvKcAASz8kf6fWefttxh96uvORJkduKoSaAr1t7CFiAdnWZjTRydv+lvHTqsKNbaWCFngM8
 EIARKdmZmDorecnFiscx8yb0ENIKzmO306D/poeuLO/G2HwRqphG+N0he6lBWYSzwTUUvB1AkB6
 7XVd9AfOctFDBwb9Mi7ue2VwcJ1C5dGyuIRpIxASF+h3sHNdFDNV7QyDJnRJagJoTNYZOgr2Fj4
 o3Dhp
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekgffhkeejudffvedvleeuudeuheefffelgffgvdegjeekieehhfelfedtgfffgfenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgtohhnfhhighdrphihnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhts
 hdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1890

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
 scripts/yocto-supported-distros | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 172a186..81f881f 100755
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
 
 
+def _filter_inactive_workers(possible_workers: Dict) -> Dict:
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
+        possible_workers = _filter_inactive_workers(possible_workers)
+
     if args.compare:
         assert len(releases) == 1, "Only one release should be passed for this mode"
         release = releases[0]

-- 
2.50.1


