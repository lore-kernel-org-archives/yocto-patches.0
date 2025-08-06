Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7DC87FD3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:53 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.28547.1754495066355076414
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XdoJoth5;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5DB14433B;
	Wed,  6 Aug 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbuTYZW0ZAu1DInFjmfB4ng/cLRf9Uv+Tr/kXy1p3Tk=;
	b=XdoJoth5W+wCWPWjJ18wHbLrO3sKMXB+lXlyURzQV7xpuVIZQm+LB0LBnDahgJNuMN0/de
	AfxVaVvlKsrG0TP/6MyaRlkXXaEzJ6OAI9gBH2fzN17f1l2esCSmMb9r8QUYsrKrjb38kd
	P7LAg96/wt/I50mAvy8MLypienKbV1t8fYJ8krRgyATFjYmXSFYk/pzr+3/TtPhpM3Bl4F
	w0Te7KS4ONC/kIoC9cAprRN1Tk9zyYV/jrWlEVTXkmPsIrlIq5PXVy8zG562lL8LrU1IKu
	k5Gk+GyRjgQuK2TBMF6muE06u8Fw0iXy4kcDE19fuv0jHDT36auDH9vMi6bZ5Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:34 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 4/7]
 scripts/yocto-supported-distros: pass one release only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-4-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5797;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=vZC7GdCnfLKpv1c4IqIaWBFoAY07XaE3pEVxKduI3jU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hWdj29OuQ2+1r/+d3brFQg1DwWc8tYefA2D
 B8mQ2FsjjiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VgAKCRDRgEFAKaOo
 NtarD/wKpxydC2QWo4pbkN5HezF/B03cfp1usmLoFqpG21khksrGrKlP/1eYVndFRZCvnPTgvW/
 N0DooofifFcoSenaTsZ4SVqdp6eD/DapdmlS0OhO/PU4vRjhP+4hrvheK5XFiabO1KX0qqYcOin
 BND4i0gSryvubUehXbqSiOtoI5SV7+dkBHqm2Fu4/m46i+t9+N5bMI4wv9CUn7tFmoepQfRt7x6
 h72XQdd4Lt9WekZAP6iciE8UvaNrHaUiyXm62yO44MQrmt2nBN5Csp19Yip+DOEvKvkaWwQWa5g
 lhRKbd85i1Prn1o7cqlKFnFrk3Y9qO7jANBdHofxY2VFnr5sLXrZrtAaUlj1I3071oaehyd3Wqc
 yNQ9+c3y7bOgld4n0PStX0KUBha5PTL0WiBA7a7HLZZgYJuM3dmljBm9+8tTntkC+ZaEX3b191B
 twDLTjx7BcyuaESKULkj8C/98pK8EAIa7ycaX22TqqMXAPZWRpHKIxtm5CF9OT8QMIauP/NZkjI
 0qerqqJf5C3E4lcOkWZIoRgMtY4l5Ll99wGP188xf/3QWnCF/wGcawuGAJuZXVqBNYQ/PzCEp3s
 LwIF0UEbdRqc43WxrqOCvXCUJvV7xrDgYBy0Jq06fpp8gpReuOvRdj3VpSjpel6jXCzZuJIHAgm
 aHDmf8osWZjQUDg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvt
 hgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1894

Instead of supporting multiple releases passed to --releases just
support one, as passing multiple releases makes the more complicated for
little added value. Make it --release instead of --releases.

This also makes the --release more symmetrical to --release-from-env.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 76 ++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index e259e1a..f05788e 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -61,11 +61,9 @@ def parse_arguments() -> argparse.Namespace:
 
     g1 = parser.add_mutually_exclusive_group()
 
-    g1.add_argument("--releases",
+    g1.add_argument("--release",
                     type=str,
-                    nargs='+',
-                    default=[],
-                    help="Yocto releases")
+                    help="Yocto release (master, walnascar, ...)")
 
     g1.add_argument("--release-from-env",
                     action="store_true",
@@ -127,14 +125,12 @@ def _print_worker_list_warning(worker_list: List, warning):
         print("WARNING: " + warning + ": " + w)
 
 
-def _print_workers(possible_workers: Dict[str, List]):
+def _print_workers(release: str, possible_workers: List[str]):
     """
     Helper to print the workers nicely.
     """
-    for release in possible_workers:
-        print(f"{release}:\n")
-        _print_worker_list(sorted(possible_workers[release]))
-        print("")
+    print(f"{release}:\n")
+    _print_worker_list(sorted(possible_workers))
 
 
 def _get_poky_distros() -> Set[str]:
@@ -253,14 +249,14 @@ def _compare(ab_workers: set, poky_workers: set, stable_release: bool):
     return ok
 
 
-def _filter_inactive_workers(possible_workers: Dict) -> Dict:
+def _filter_inactive_workers(possible_workers: List[str]) -> List[str]:
     """
-    From the current dictionary of workers, remove the workers that are inactive
+    From the current list of workers, remove the workers that are inactive
     (disconnected) by checking the Autobuilder REST API.
     """
 
-    _possible_workers = {}
-    workers_ab = None
+    _possible_workers = []
+    workers_ab = []
 
     try:
         with urllib.request.urlopen(AUTOBUILDER_WORKERS_ENDPOINT) as r:
@@ -281,8 +277,7 @@ def _filter_inactive_workers(possible_workers: Dict) -> Dict:
 
         return False
 
-    for release in possible_workers:
-        _possible_workers[release] = [w for w in possible_workers[release] if is_connected(w)]
+    _possible_workers = [w for w in possible_workers if is_connected(w)]
 
     return _possible_workers
 
@@ -312,55 +307,44 @@ def main():
         sys.path.append(os.path.dirname(args.config))
         import config
 
-    releases = None
+    release = None
     if args.release_from_env:
-        releases = [_get_current_core_release()]
+        release = _get_current_core_release()
     else:
-        releases = args.releases
+        release = args.release
 
-    if not releases:
-        print("Must provide one or more release, or --release-from-env")
+    if not release:
+        print("Must provide a release, or --release-from-env")
         exit(1)
 
-    possible_workers = {}
+    possible_workers = []
 
     stable_release = True
 
-    for release in releases:
-
-        if release != "master" and release not in config.workers_prev_releases:
-            print(f"Release {release} does not exist")
-            if args.release_from_env:
-                # Might be a custom branch or something else... safely exiting
-                exit(0)
-            else:
-                exit(1)
-
-        if release == "master":
-            stable_release = False
-            possible_workers.update({release: config.all_workers})
-            continue
-
-        if release not in config.workers_prev_releases:
-            print(f"Release {release} does not exist, available releases: "
-                  f"{config.workers_prev_releases.keys()}")
+    if release != "master" and release not in config.workers_prev_releases:
+        print(f"Release {release} does not exist")
+        if args.release_from_env:
+            # Might be a custom branch or something else... safely exiting
+            exit(0)
+        else:
             exit(1)
 
-        possible_workers.update(
-            {release: _possible_workers(config.workers_prev_releases[release],
-                                        config.all_workers)})
+    if release == "master":
+        stable_release = False
+        possible_workers = config.all_workers
+    else:
+        possible_workers = _possible_workers(config.workers_prev_releases[release],
+                                             config.all_workers)
 
     if args.check_worker_statuses:
         possible_workers = _filter_inactive_workers(possible_workers)
 
     if args.compare:
-        assert len(releases) == 1, "Only one release should be passed for this mode"
-        release = releases[0]
         print(f"Comparing for release {release}...\n")
 
         poky_workers = _get_poky_distros()
         ab_workers = set()
-        for w in possible_workers[release]:
+        for w in possible_workers:
             mangled_w = _mangle_worker(w)
             if mangled_w:
                 ab_workers.add(mangled_w)
@@ -371,7 +355,7 @@ def main():
             print("All good!")
 
     else:
-        _print_workers(possible_workers)
+        _print_workers(release, possible_workers)
 
 
 if __name__ == "__main__":

-- 
2.50.1


