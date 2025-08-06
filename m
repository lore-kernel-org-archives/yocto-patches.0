Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F6ECA0EC0
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.28548.1754495066571982194
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=C3ksitg7;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 174324433E;
	Wed,  6 Aug 2025 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2zWG9DsHS5aJZr5eS5vlnLhHGBW8wwpVdqixS8knl4=;
	b=C3ksitg7JZSwPWo6VNHISHi4M2AccNtRMfGDEejizCs3zkdtNRGAcZSxUfxYBWiguCOUFp
	BQI8DA2+Y57tAI1NkXUiDLmQ1FCFYE+tkchWMF7ldGfCPdBKudBipXa9TcJsW/WgcHy8xH
	YKlNJaPLc6fnh2AJDybW7gBp3VnFq0BVEmccWxZQecmhaACbqf+Cw0yjLIm8LRMC2ILiEC
	PVgndqaXGsd12/lPkfZanQ8ADzejhDTJ/FkKhwBjEgMZTnMzL/szC7xbgVN6CsSzAJqc2j
	6aPvK2kzBUXl0dHYjYvRovJUwnXuGuYzL8zoNUWeqhJCO5tkPKO9EjXudPKM2Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:35 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 5/7]
 scripts/yocto-supported-distros: add option to print old distros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-5-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=TyqHVOaBHrEn6ezB6hBjmgWZqkwDm8vudcHHusFKrDE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hXWW4WIEny7lYeFYl1hLYB3Fw15H9zyz4LP
 eVtNw4pXguJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VwAKCRDRgEFAKaOo
 NuNhEADBYDr0kOdNqhEm9NLsPOYBjcYiMzd5cRDJQvaIpiY5co3dchyl9yhrnPx7snoj8SIVTj7
 Eg4M0DBXOpqQd1CaOBqpFSrVkMmVUhsLXKq+gv4yV8Psdco9w+eJgPv+7WfKtruyeGVB0+Q9tJu
 LTtSPOLutrBjDS/FbvsmLxDOeBJOloDkqPgo74fhLo4s1gQqbv9Opr3hxnAoJAHSvnjjTMDwAZd
 RF1GF0Dfo75+0omA3sQA7R41YFSmFi/jDBUSefDH3G70XCONW8SPr/8WJvQGAng8Pt/g31Iebpb
 pWVH8zdM1Cth7oCL2aNoKTgOBg1Plx20tKWdPBbqQXgOB96eod75B6yXQ3/n6dVeY4gzHrGOyif
 on4HLEUegEmzE94zpIMO+rqzvF7t5VVUxxTcQfbVDd4TVYKZ3n+VY4vacBpppjnCUfc9JPGaLUq
 J7NkK6VyvtZNo05+ySr55caXjQpdXomlM6pCPTIfz7rGXw6K6dNppFTOTKNGvph8WNDii5DbAPB
 PX9bsGBi4UL+6wo/1GmQxLclYAqSSn3+ef534QDpOgR1yWuByhXTTBQQSwM6Kc5x+wXM2IevdOW
 Jy/wcGRbs62+mf9gcsPgK9Jcf6MM47T10RDQJaqTqXGMwWnAORxvk3I8ncOQjK2k+DlIGYZiF4X
 lhwKsXp3GntsD/Q==
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1895

We can use config.py to list distributions that used to be tested for a
given release, by comparing the values in workers_prev_releases (all
workers for a release) and all_workers (all active workers for any
release).

Add the --old-distros to do that. Make it mutually exclusive to
--compare, we don't want to do multiple things at the same time.

Add a pattern to match centos, as it was defined for kirkstone in the
past (we use stream now).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index f05788e..d53cc68 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -80,9 +80,15 @@ def parse_arguments() -> argparse.Namespace:
                     action="store_true",
                     help="Get config.py from yoctoproject's git web interface")
 
-    parser.add_argument("--compare",
-                        action="store_true",
-                        help="Compare to poky.conf releases")
+    g3 = parser.add_mutually_exclusive_group()
+
+    g3.add_argument("--compare",
+                    action="store_true",
+                    help="Compare to poky.conf releases")
+
+    g3.add_argument("--old-distros",
+                    action="store_true",
+                    help="Print previously tested distros")
 
     parser.add_argument("--check-worker-statuses",
                         action="store_true",
@@ -211,6 +217,11 @@ def _mangle_worker(worker: str) -> str:
     if m:
         return f"centosstream-{m.group(1)}"
 
+    r = re.compile(r"^centos(\d+)")
+    m = re.match(r, worker)
+    if m:
+        return f"centos-{m.group(1)}"
+
     r = re.compile(r"^ubuntu(\d{2})(\d{2})")
     m = re.match(r, worker)
     if m:
@@ -354,6 +365,19 @@ def main():
         else:
             print("All good!")
 
+    elif args.old_distros:
+        if release == "master":
+            print("The --old-distros argument only makes sense for stable release")
+            exit(1)
+
+        old_distros = []
+
+        for distro in config.workers_prev_releases[release]:
+            if not any(distro in w for w in config.all_workers):
+                old_distros.append(_mangle_worker(distro))
+
+        _print_workers(release, old_distros)
+
     else:
         _print_workers(release, possible_workers)
 

-- 
2.50.1


