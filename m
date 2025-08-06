Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C9CA0EC3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.28763.1754495066954068271
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IzBCOG8J;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 802EC44340;
	Wed,  6 Aug 2025 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BY2YU8ejvjDUQT2SSFo765+pSUwSj8PYqzyGDIDUlw=;
	b=IzBCOG8JYgKB6jcYLgP8gge01s1wPrbK1yv0JZLUcqQZssi9xMj/IrEtk57eSrDQwpcUDm
	tSC794l4yb59DfKp58psobvWsrEWaF8+U9ZBUHEUYg89O1ZPFA1Eadn1cTsheOK3NEslt0
	iEzCDk2BJtV/J6KNo/xS58I48e7sHYoI2hmmRJ0+1KWOx9Pj1/KVOn5l6wW1snZPdkLtWP
	a9CaiA/Wwby/Eemg5KI+TSb8jbPyKltJ2Vnxf4B51H/B3kPGwpMuDJUytVZxRq8tdfzNCQ
	MZoQ1HzKD6tdiYpUK2dggWdyO9iZhlN00/dOl4myYdFdEgJM1t8+t1Q7PATn1Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:37 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 7/7]
 scripts/yocto-supported-distros: add --poky-distros option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-7-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FzIFv7HGr75zeCRzzeKLJefXKukGXRdRYP3e3oUD2ew=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hX2jI6Xr+/btrH1J2UCgmePWeCMgcJDleY7
 k9Z5bY1RX6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VwAKCRDRgEFAKaOo
 NhmzEACSUlZ4xfmzBd35c76wC2STgJjwslKmXdH7mLkCJ0M9fgGcfBYx3sckqxTKyp9qF20HzJx
 ZJUs3uDoEK1+GAkrAQVzL6c+nZjHkaGDWL0eyuNQ2FcbCJQgJEACYXx640yUpf4KWoFUKPU9Ped
 mywTE1/R6tWQUdSdce9p072lJaZSLIW5Lb4G6MhxYYlvB9KaT+LNCL/fpIYXoMzC2Os2G7xjaaT
 sXo/e1TS+L8ppgBohez/zv09SwsJprpVAJJssMpjWq7mzDAHD6dxgPaoWy2V2nQEn7hDwD62R7M
 bFkQlwHsTCtHb2F4r9ZBbYcHg5muAXNESp+QS53V5tZTRRbHS1vvyudKNpwk7dsKtoOKn0Fq7ZD
 KD3f3euDHSRXblsabTX+ebI5zSfYYprdkwQifUzGnXyq0vm65vZ9ube8dTyM9DhkBsr3KPqcH1L
 46AMhXtqQ70xkd1DXpfSoWPe9Ksw46Sj5Vc3M2hnEEQeXfk7jP0tdIwERwSj4dLDzu5pg8PC6qT
 LB+LddEtmpWZcwqkTrx6O0+eszP1Y7VdVGCpUieioJEGPjyCwPVEVdrDZGxZaY0QM4oqeHfWEsF
 LDtP6SIMBaAU/FhCut487bTzrpYMozxlgE38JqLb465P7YdMErpNy0JNm/YCLyviGS4Bi9ooVG6
 vTaD9vpa16j213g==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1897

Add a --poky-distros option to list the distributions listed in
SANITY_TESTED_DISTROS in the desired format. This means that the strings
can be converted from lsb to docs, for yocto-docs.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index fa5b819..e70943d 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -157,6 +157,10 @@ def parse_arguments() -> argparse.Namespace:
                     action="store_true",
                     help="Compare to poky.conf releases")
 
+    g3.add_argument("--poky-distros",
+                    action="store_true",
+                    help="Print previously tested distros")
+
     g3.add_argument("--old-distros",
                     action="store_true",
                     help="Print previously tested distros")
@@ -413,6 +417,15 @@ def main():
         else:
             print("All good!")
 
+    elif args.poky_distros:
+        poky_distros = _get_poky_distros()
+        workers = set()
+        for w in poky_distros:
+            mangled_w = _mangle_worker(w, "lsb", args.output_format)
+            if mangled_w:
+                workers.add(mangled_w)
+        _print_workers(release, workers)
+
     elif args.old_distros:
         if release == "master":
             print("The --old-distros argument only makes sense for stable release")

-- 
2.50.1


