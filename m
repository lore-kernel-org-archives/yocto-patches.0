Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC17CA0EC2
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.28762.1754495066731117457
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CSNbv1fS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 481A54433F;
	Wed,  6 Aug 2025 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngw6zUY6LMpIdjISUttXwsXvxMxPnulaxkwDc8IkVVw=;
	b=CSNbv1fSpOLh4mPLCPOmrBxfRR18fMcVZgLEzW0W55fyCaSS1QSwPIXAilh/xTs37Ki90g
	MkGFlejvj8ZcBURi+5KINQ/whkI3ccqJpt2ZR8DIkbbZJAhc645kXumPILUSfcN6UOx3Oe
	HCi0jRR0f93ADA/gyLp7zq62U+9HnCaUDi8yPWo+PzY3apbM0iJilpslQzcQImQeqLBenU
	zZ80SVinQuv55imzoFL7l59H/ymssO+911xubGdURpphBooYstUObwoL0OkiEuGze2ZyCS
	5znXitIGbXV7QD+28t/ArgNH70ie1q4yfxG2HJBziTs6mzRLJLG/fZMPF6+uDQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:36 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 6/7]
 scripts/yocto-supported-distros: add --output-format option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-6-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6990;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=IrcJaVse4wWp0nlPmylgi1jJGg5FyelPNZVx6lCgJfk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hXi8D+uxpGS9SdV2L1raMybg4pyzZ8fk78a
 HR6W+GZPsGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VwAKCRDRgEFAKaOo
 NsHoEADIF5ccCjIZSp9YWiZ+kxJ7576ulkxS/fuWa+kjkR6jas0ce7PRflXaRyxdncpFGgcd+yy
 FL4m8InN84eGghu+rnMBQiHcQGutVPBNpzitjiTG9r2ZJ0vzaVelOpiq55hVKbpiU/7mDJ5l0OG
 mcC+pwksyMgQ/9vNM801wA7yG96vyyZHqbsw1AWHH7NIUPujlNSodUJM64klQIbW2a4ynVaNc/t
 b1N17LHA/8Qg80+9g56gtqHgrYMFiaOpoyFePzRlkM3ryB54eEiguZOknkuTm+mirA4bBYY21MW
 nYW/FcSwEOzvcXWIO/n18g0g2OorL3jFcrs3p9eRJWJIfGL7bQ4rvSszB8DytnldBlxa9F+H5D0
 R/p+UXhGctpegTYeMnKilT9x/wjBDa2IeUx7lAd0DTLtcmtMD4a3o2O+cS5TOixX/xGn3og9w+G
 8aVU6YiqeDErLwtonNzoi9Iq2lSxtEODh3Dyd/H6OIXBzpha6J12P8hAGYQ9lM8fm2obwhvgmt7
 l+zm9Gi743Fy5HhSkp/ppHjqqYeQmduJ2z1BMyPUD4TIl42qFHXI4jhkKi3AOIhWEN18lSBhz5N
 dnmwWU05gfPE7dZ8WBNQfHYFXbFPswuBpMadU2WQG38F5GXbOBZV4gj/9CKItLe/SnKMch6rrMy
 1iiwEE3yFUYRNRQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekuefhiefhgfdtheejvdelledvhfegfefhtdetuefhfffhvdeiudeuvddvteetgeenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhoj
 hgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1896

The --output-format option can be used to control how things are printed
on the console. There are two supported types of formats: "lsb" for
printing lsb_release formatted strings, and "docs" to print strings as a
bullet list for yocto-docs.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 149 +++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 48 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index d53cc68..fa5b819 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -56,6 +56,77 @@ CONFIG_REMOTE_URL = "https://git.yoctoproject.org/yocto-autobuilder2/plain/confi
 AUTOBUILDER_WORKERS_ENDPOINT = "https://autobuilder.yoctoproject.org/valkyrie/api/v2/workers"
 
 
+INPUT_REGEXES = {
+    "alma": {
+        "ab": re.compile(r"^alma(\d+)"),
+        "lsb": re.compile(r"^almalinux-(\d+)"),
+    },
+    "debian": {
+        "ab": re.compile(r"^debian(\d+)"),
+        "lsb": re.compile(r"^debian-(\d+)"),
+    },
+    "fedora": {
+        "ab": re.compile(r"^fedora(\d+)"),
+        "lsb": re.compile(r"^fedora-(\d+)"),
+    },
+    "opensuseleap": {
+        "ab": re.compile(r"^opensuse(\d{2})(\d{1})"),
+        "lsb": re.compile(r"^opensuse-(\d{2})\.(\d{1})"),
+    },
+    "centos": {
+        "ab": re.compile(r"^centos(\d+)"),
+        "lsb": re.compile(r"^centos-(\d+)"),
+    },
+    "centosstream": {
+        "ab": re.compile(r"^stream(\d+)"),
+        "lsb": re.compile(r"^stream-(\d+)"),
+    },
+    "rocky": {
+        "ab": re.compile(r"^rocky(\d+)"),
+        "lsb": re.compile(r"^rocky-(\d+)"),
+    },
+    "ubuntu": {
+        "ab": re.compile(r"^ubuntu(\d{2})(\d{2})"),
+        "lsb": re.compile(r"^ubuntu-(\d{2})\.(\d{2})"),
+    },
+}
+
+OUTPUT_FORMATS = {
+    "alma": {
+        "lsb": "almalinux-{}",
+        "docs": "-  AlmaLinux {}",
+    },
+    "debian": {
+        "lsb": "debian-{}",
+        "docs": "-  Debian {}",
+    },
+    "fedora": {
+        "lsb": "fedora-{}",
+        "docs": "-  Fedora {}",
+    },
+    "opensuseleap": {
+        "lsb": "opensuseleap-{}.{}",
+        "docs": "-  OpenSUSE Leap {}.{}",
+    },
+    "centos": {
+        "lsb": "centos-{}",
+        "docs": "-  CentOS {}",
+    },
+    "centosstream": {
+        "lsb": "centosstream-{}",
+        "docs": "-  CentOS Stream {}",
+    },
+    "rocky": {
+        "lsb": "rocky-{}",
+        "docs": "-  Rocky Linux {}",
+    },
+    "ubuntu": {
+        "lsb": "ubuntu-{}.{}",
+        "docs": "-  Ubuntu {}.{}",
+    },
+}
+
+
 def parse_arguments() -> argparse.Namespace:
     parser = argparse.ArgumentParser(description="Print supported distributions")
 
@@ -95,6 +166,12 @@ def parse_arguments() -> argparse.Namespace:
                         default=False,
                         help="Also check the worker statuses using the Autobuilder API")
 
+    parser.add_argument("--output-format",
+                        type=str,
+                        default="lsb",
+                        choices=['lsb', 'docs'],
+                        help="Output format of the workers ('lsb' or 'docs')")
+
     return parser.parse_args()
 
 
@@ -115,17 +192,17 @@ def _possible_workers(all_workers: List[str],
     return possible_workers
 
 
-def _print_worker_list(worker_list: List, indent=2):
+def _print_worker_list(worker_list: List):
     """
     Helper to print a set nicely.
     """
     for w in worker_list:
-        print(" " * indent + w)
+        print(w)
 
 
 def _print_worker_list_warning(worker_list: List, warning):
     """
-    Helper to print a set nicely.
+    Helper to print a warning nicely.
     """
     for w in worker_list:
         print("WARNING: " + warning + ": " + w)
@@ -135,7 +212,6 @@ def _print_workers(release: str, possible_workers: List[str]):
     """
     Helper to print the workers nicely.
     """
-    print(f"{release}:\n")
     _print_worker_list(sorted(possible_workers))
 
 
@@ -182,50 +258,22 @@ def _get_current_core_release() -> str:
     return release.strip().split()[-1]
 
 
-def _mangle_worker(worker: str) -> str:
+def _mangle_worker(worker: str, format_in: str, format_out: str) -> str:
     """
-    Mangle the worker name to convert it to an lsb_release type of string.
+    Mangle the worker name to convert it to a different format.
+    Input -> output formats can be:
+    - ab -> lsb
+    - ab -> docs
+    - lsb -> docs
     """
 
-    r = re.compile(r"^alma(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"almalinux-{m.group(1)}"
-
-    r = re.compile(r"^debian(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"debian-{m.group(1)}"
-
-    r = re.compile(r"^fedora(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"fedora-{m.group(1)}"
-
-    r = re.compile(r"^opensuse(\d{2})(\d{1})")
-    m = re.match(r, worker)
-    if m:
-        return f"opensuseleap-{m.group(1)}.{m.group(2)}"
-
-    r = re.compile(r"^rocky(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"rocky-{m.group(1)}"
-
-    r = re.compile(r"^stream(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"centosstream-{m.group(1)}"
-
-    r = re.compile(r"^centos(\d+)")
-    m = re.match(r, worker)
-    if m:
-        return f"centos-{m.group(1)}"
-
-    r = re.compile(r"^ubuntu(\d{2})(\d{2})")
-    m = re.match(r, worker)
-    if m:
-        return f"ubuntu-{m.group(1)}.{m.group(2)}"
+    if format_in == format_out:
+        return worker
+
+    for distro in INPUT_REGEXES:
+        m = re.match(INPUT_REGEXES[distro][format_in], worker)
+        if m:
+            return OUTPUT_FORMATS[distro][format_out].format(*list(m.groups()))
 
     return ""
 
@@ -356,7 +404,7 @@ def main():
         poky_workers = _get_poky_distros()
         ab_workers = set()
         for w in possible_workers:
-            mangled_w = _mangle_worker(w)
+            mangled_w = _mangle_worker(w, "ab", "lsb")
             if mangled_w:
                 ab_workers.add(mangled_w)
 
@@ -374,12 +422,17 @@ def main():
 
         for distro in config.workers_prev_releases[release]:
             if not any(distro in w for w in config.all_workers):
-                old_distros.append(_mangle_worker(distro))
+                old_distros.append(_mangle_worker(distro, "ab", args.output_format))
 
         _print_workers(release, old_distros)
 
     else:
-        _print_workers(release, possible_workers)
+        workers = set()
+        for w in possible_workers:
+            mangled_w = _mangle_worker(w, "ab", args.output_format)
+            if mangled_w:
+                workers.add(mangled_w)
+        _print_workers(release, workers)
 
 
 if __name__ == "__main__":

-- 
2.50.1


