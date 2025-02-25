Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88607C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 09:49:10 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.4629.1740476944179303569
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Feb 2025 01:49:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FG4Yq0OS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E45B5433EA;
	Tue, 25 Feb 2025 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740476942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UpKefRtbIP72KhYUuV9o+JAcupLQQT+dOinu6zJ+1+M=;
	b=FG4Yq0OSaez4XPrl0ViSwC3pa7pWAnIIX0q9SE72FFT2aVs+mVsMBXCUBozdPG06BQBeOZ
	+oU87UknKkjzA+/p4A6utwCP3jTkB6WG1xoTsxZ6mmjOGzY4mZJIPGagZ20z1xMt5wRRBk
	FigY6syOTKsLk1XJ7+9j0moL9xFlvBrORQtgFvAYsrmoWQZePSxJG2a2L9M76jujK040lH
	RoYKAneYWepY19JwbVCqx7NBKsZKZd3UHYWA5efm5vpfNXAZr6SeT6BCEwsQI1romDYIIG
	h8gwthHrrPRTHuj3KF7/HraQPxEXqr6oghIB1CxeYH+8MPBnWlCKf+ldELSn6w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 25 Feb 2025 10:48:13 +0100
Subject: [yocto-autobuilder-helper PATCH] scripts: add
 yocto-supported-distros to list or compare supported distros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-yocto-supported-distros-v1-1-bbe52aeda456@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANyRvWcC/x3MMQ6DMAxA0asgz1hKLIWBq6AOKDGtFxzZKQIh7
 t6o4xv+v8HZhB3m4QbjQ1x074jjAPmz7m9GKd1AgVIgSnhpbor+rVWtccEi3kwdc94oxWmdQiz
 Q62q8yfk/L6/n+QF+OA0BaQAAAA==
X-Change-ID: 20250225-yocto-supported-distros-ccf2516a601d
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11172;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8ddKpgDt/3Yo4FuN8nX1ABTz4p0HSNXAm7q4e/Knuzo=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnvZINhdxL30XRLiXsNzroAVfIPLEHi+eIWt/rU
 VxLXkXctbiJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ72SDQAKCRDRgEFAKaOo
 NrLpD/0dXSF7UdJMsGjgx5Ftzkdjhfn+L2pDA3rNEgLCmbgMe05DtI436Ctrbl82gmopN6bPIJj
 tpZu73Ufyh2v3DWi4GOtWfs0viCua1Qq2GRuLTtPybHMK9k7LftktJZ81cIzsx4cOuHoHCqvJYo
 tsqJUwFNu37GRlGdyQYubaLzEomAFSPyh45/0clfLW0NXlBcF2xi+uhVEsfPnlsGIRKZph4XHqV
 Bha+hfJxBAH2h4paAjDTTaFs/H4QAozN4LPj5FStu4AFkDaz/nMe2aroTSmv9g/MPMY/jmEOGPu
 G8YZMgdel7MtEgOTwuOQhhToowK8owo79uvTknnVGXNqs/GJmux2ukhImLBipgqzYi1VlXoRaei
 zaQKk1D87njZYIGRb1KAEEt0QfzfaqKASIBkcUz+sphgavkMhVvYaMwJaagn5P0VTlEGYgPZz0i
 ZeIAzFc7YFgeFlyqnbJW769DkKHM2zAmMHNG+2XTG+ydCu1sr3sM64L/Z2bL47J3V74895eRgtX
 gkH7XAg4S0txug0UnF9bp9Jaz76h7fPHL4Yc83vV01kmY+eCfa/T/y7vGRKckjL6L7v2ipJS5Ai
 rbNrzrowZHNkf6eAyHhCFsk+q4WNU0BY0L940CX5fg3FpsYR1egRXM8tGLhbvbk1vPn7vWhWcHj
 fy82/KZ0d6nFHPg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeefieelfeeujeejueeiiedugfethfduudfgtdegfeeiieeufeegveeiveekjeevnecuffhomhgrihhnpedtgidtrdhsthdphihotghtohhprhhojhgvtghtrdhorhhgpdgtohhnfhhighdrphihnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihon
 hhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 09:49:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1128

Add scripts/yocto-supported-distros to either:

- List the supported distros on the autobuilder (prints the workers for
  one or more release).

- With --compare, get the supported distro from poky.conf
  (SANITY_TESTED_DISTROS), mangle the worker names to make them match the
  lsb_release distro strings, and return 1 in case of difference (and
  print the differences). Return 0 in case of 1 to 1 match.

The aim of this script is to make maintaining the poky.conf file and the
workers easier.

The release-from-env flag can be used to get the current release from
METADATA_BRANCH.

The --config-from-web flag can be used to get the current autobuilder
config.py by fetching it from the web repo.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Example output: https://0x0.st/8AO2.txt

I tried to add a step to a local autobuilder instance but I'm having
trouble configuring it properly, so here's how I would suggest running
the script from the helper repo's config.json:

  "step1" : {
      "NEEDREPOS" : ["poky"],
      "shortname" : "Compare AB workers and SANITY_TESTED_DISTROS",
      "EXTRACMDS" : [
          "${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare"
      ]
  }

Probably on the a-quick and a-full builds.
---
 scripts/yocto-supported-distros | 299 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
new file mode 100755
index 0000000000000000000000000000000000000000..da5399d3dffe4958ccea56fa3584d6d92353f7f4
--- /dev/null
+++ b/scripts/yocto-supported-distros
@@ -0,0 +1,299 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Read config.py from yocto-autobuilder2 and print the list of supported releases
+# for each release.
+#
+# Usage:
+#
+#   ./tools/supported-distros --config /path/to/config.py --releases release1 [release2 ...]
+#
+# Example:
+#
+#   ./tools/supported-distros --config yocto-autobuilder2/config.py --releases master styhead scarthgap kirkstone
+#
+# If run with --compare the script with try to run `bitbake-getvar` to obtain the
+# value of SANITY_TESTED_DISTROS, and compare that (with some mangling) to the
+# configured workers and return 1 in case of difference. Only one release must be
+# passed in this mode.
+#
+# Usage:
+#
+#    ./tools/supported-distros --config /path/to/config.py --releases master --compare
+#
+# The opts --release-from-env and --config-from-web can also be used to get
+# these info using respectively the METADATA_BRANCH variable and the config.py
+# from the git web interface.
+#
+# Example:
+#
+#    ./tools/supported-distros --config-from-web --release-from-env --compare
+#
+# Will get the current branch from METADATA_BRANCH, fetch config.py from
+# git.yoctoproject.org/yocto-autobuilder2, compare and output the differences.
+#
+# The script will return 1 in case of difference, 0 if the distros match.
+# With one exception: if the branch returned by --release-from-env is not
+# present in the autobuilder config, just return 0, because this might by run
+# from a custom branch.
+
+import argparse
+import os
+import re
+import requests
+import sys
+import subprocess
+import tempfile
+
+from pathlib import Path
+from typing import List, Dict, Set
+
+
+CONFIG_REMOTE_URL = "https://git.yoctoproject.org/yocto-autobuilder2/plain/config.py"
+
+
+def parse_arguments() -> argparse.Namespace:
+    parser = argparse.ArgumentParser(description="Print supported distributions")
+
+    parser.add_argument("--releases",
+                        type=str,
+                        nargs='+',
+                        default=[],
+                        help="Yocto releases")
+
+    parser.add_argument("--config",
+                        type=Path,
+                        default=None,
+                        help="Autobuilder config.py input file")
+
+    parser.add_argument("--release-from-env",
+                        action="store_true",
+                        help="Get release from METADATA_BRANCH bitbake var")
+
+    parser.add_argument("--compare",
+                        action="store_true",
+                        help="Compare to poky.conf releases")
+
+    parser.add_argument("--config-from-web",
+                        action="store_true",
+                        help="Get config.py from yoctoproject's git web interface")
+
+    return parser.parse_args()
+
+
+def _possible_workers(all_workers: List[str],
+                      match_workers: List[str]) -> List[str]:
+    """
+    Return workers in match_workers that match the workers in all_workers.
+    A match is a worker in all_workers that starts with a worker in
+    match_workers.
+    This is because workers_prev_releases is defined like so in config.py.
+    """
+
+    possible_workers = []
+    for distro_name in all_workers:
+        for worker in match_workers:
+            if worker.startswith(distro_name):
+                possible_workers.append(worker)
+    return possible_workers
+
+
+def _print_worker_list(worker_list: List, indent=2):
+    """
+    Helper to print a set nicely.
+    """
+    for w in worker_list:
+        print(" " * indent + w)
+
+
+def _print_workers(possible_workers: Dict[str, List]):
+    """
+    Helper to print the workers nicely.
+    """
+    for release in possible_workers:
+        print(f"{release}:\n")
+        _print_worker_list(sorted(possible_workers[release]))
+        print("")
+
+
+def _get_poky_distros() -> Set[str]:
+    poky_distros = set()
+
+    tested_distros = subprocess.check_output(
+        ["bitbake-getvar", "--value", "SANITY_TESTED_DISTROS"],
+        encoding="utf-8")
+    tested_distros = tested_distros.replace("\\n", "")
+
+    for distro in tested_distros.split():
+        if "poky" in distro:
+            continue
+
+        if "almalinux" in distro:
+            # remove the minor version string
+            r = re.compile(r"^(almalinux-\d+)\.\d+")
+            m = re.match(r, distro)
+            if m:
+                distro = m.group(1)
+
+        poky_distros.add(distro.strip())
+
+    return poky_distros
+
+
+def _get_metadata_branch() -> str:
+    branch = subprocess.check_output(
+        ["bitbake-getvar", "--value", "METADATA_BRANCH"],
+        encoding="utf-8")
+    return branch.strip()
+
+
+def _mangle_worker(worker: str) -> str:
+    """
+    Mangle the worker name to convert it to an lsb_release type of string.
+    """
+
+    r = re.compile(r"^alma(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"almalinux-{m.group(1)}"
+
+    r = re.compile(r"^debian(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"debian-{m.group(1)}"
+
+    r = re.compile(r"^fedora(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"fedora-{m.group(1)}"
+
+    r = re.compile(r"^opensuse(\d{2})(\d{1})")
+    m = re.match(r, worker)
+    if m:
+        return f"opensuseleap-{m.group(1)}.{m.group(2)}"
+
+    r = re.compile(r"^rocky(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"rocky-{m.group(1)}"
+
+    r = re.compile(r"^stream(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"centosstream-{m.group(1)}"
+
+    r = re.compile(r"^ubuntu(\d{2})(\d{2})")
+    m = re.match(r, worker)
+    if m:
+        return f"ubuntu-{m.group(1)}.{m.group(2)}"
+
+    return ""
+
+
+def _compare(ab_workers: set, poky_workers: set):
+    ok = True
+
+    print("Configured on the autobuilder:")
+    _print_worker_list(sorted(list(ab_workers)))
+    print()
+
+    print("Listed in poky.conf:")
+    _print_worker_list(sorted(list(poky_workers)))
+    print()
+
+    poky_missing = ab_workers.difference(sorted(list(poky_workers)))
+    if poky_missing:
+        print("Missing in poky.conf but configured on the autobuilder:")
+        _print_worker_list(poky_missing)
+        print()
+        ok = False
+
+    ab_missing = poky_workers.difference(sorted(list(ab_workers)))
+    if ab_missing:
+        print("Missing on the autobuilder but listed in poky.conf:")
+        _print_worker_list(sorted(list(ab_missing)))
+        print()
+        ok = False
+
+    return ok
+
+
+def main():
+
+    args = parse_arguments()
+
+    if not args.config and not args.config_from_web:
+        print("Must provide path to config or --config-from-web")
+        exit(1)
+
+    if args.config_from_web:
+        r = requests.get(CONFIG_REMOTE_URL)
+        with tempfile.TemporaryDirectory() as tempdir:
+            with open(Path(tempdir) / "config.py", "wb") as conf:
+                conf.write(r.content)
+            sys.path.append(tempdir)
+            import config
+    else:
+        sys.path.append(os.path.dirname(args.config))
+        import config
+
+    releases = None
+    if args.release_from_env:
+        releases = [_get_metadata_branch()]
+    else:
+        releases = args.releases
+
+    if not releases:
+        print("Must provide one or more release, or --release-from-env")
+        exit(1)
+
+    possible_workers = {}
+
+    for release in releases:
+
+        if release != "master" and release not in config.workers_prev_releases:
+            print(f"Release {release} does not exist")
+            if args.release_from_env:
+                # Might be a custom branch or something else... safely exiting
+                exit(0)
+            else:
+                exit(1)
+
+        if release == "master":
+            possible_workers.update({release: config.all_workers})
+            continue
+
+        if release not in config.workers_prev_releases:
+            print(f"Release {release} does not exist, available releases: "
+                  f"{config.workers_prev_releases.keys()}")
+            exit(1)
+
+        possible_workers.update(
+            {release: _possible_workers(config.workers_prev_releases[release],
+                                        config.all_workers)})
+
+    if args.compare:
+        assert len(releases) == 1, "Only one release should be passed for this mode"
+        release = releases[0]
+        print(f"Comparing for release {release}...\n")
+
+        poky_workers = _get_poky_distros()
+        ab_workers = set()
+        for w in possible_workers[release]:
+            mangled_w = _mangle_worker(w)
+            if mangled_w:
+                ab_workers.add(mangled_w)
+
+        if not _compare(ab_workers, poky_workers):
+            print("Errors were found")
+            exit(1)
+        else:
+            print("All good!")
+
+    else:
+        _print_workers(possible_workers)
+
+
+if __name__ == "__main__":
+    main()

---
base-commit: a1a282417e5691bf3fd09e8e969c831a43e59ee9
change-id: 20250225-yocto-supported-distros-ccf2516a601d

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


