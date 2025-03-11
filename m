Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7FC28B2E
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 08:23:38 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.3883.1741681411127980814
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 01:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UenaXpHp;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32A17443B9;
	Tue, 11 Mar 2025 08:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741681408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iyuUOjgIqCA3OmpEZnG0noPYaG55eU67FNU72J0en2g=;
	b=UenaXpHpAliaJzAqYkNpbmbN25Y5xYaVjnFIuXNaSz2GUmwom+0oXsNRKjF9p0vRsVES7/
	er3URM0ooOKX3ZTh9wY+N+uSIJbNP3NS99p8p+a8WKXxx8FIsnNAldYSk7p53fg6soPzpI
	RWxf4TlF2HvAR6ReSRnAI5Vk8xj0DD/hryYhEtJd6RwNHD4txKS4A6SqbiJe11P4BQod1o
	1WlPeHFVLflo35Ss+V8l8sahAuFLWL2GJ2xhPVtVbQOEfOZtuofsRVEojUZ+fMCqIBlNt5
	+3FDOVpj4cYIVkw0nXQceCQHxzFxjmSnZs29+0/SQKUUxpXjZOMnGIhiHaAqYw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 11 Mar 2025 09:22:33 +0100
Subject: [yocto-autobuilder-helper PATCH] scripts/yocto-supported-distros:
 catch intermittent HTTPError
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-yocto-supported-distros-fixes-v1-1-eb6d143daab3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMjyz2cC/x3MwQqDMAyA4VeRnA20ysb0VcRDa+OWiylJlQ3x3
 S07fvzwn2CkTAZjc4LSwcayVfi2geUTtjchp2roXPdwvff4k6UI2p6zaKGEia2oGK78JcM4RHr
 GtIaX81AfWekf6mKar+sG3XTn+W8AAAA=
X-Change-ID: 20250311-yocto-supported-distros-fixes-b9be6bdfa801
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steve Sakoman <steve@sakoman.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=7QTdOnZu50sFTuPYV3/97BzrE1uOjlPwUGvbvEEhXSc=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnz/MAWI00iCPSbfo4q70xDEVX7uHqUcv9DXpKy
 ISAlnF2hgyJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ8/zAAAKCRDRgEFAKaOo
 NpENEAC5PDWOY92WE3qJnz9K1SUIIznEV2LseIrOPGK5f44kacVwOy/As1Atm7DLeCqb0EU/YoX
 6BlyOSJN9x9zEYkLf5Snaxj6VmXgy10XqXCZlr5AWVl5qtajQBt73etlnbAluivKhfCyXJq0LHu
 m/4/6suMf7y8OLxqODXuXqlur3myXJEbNW4ddTZZhiVB0DdEvIhRJ3yfHb22KmuakJoBAHFbWRB
 +x1J5l5DzdS7CpcGc4dBkfLg6bFFxuSs8fbk3y5cd6P9UXpyt/Jvoxnxj0DBZnPZouIjdQpM0b3
 n8jynvR2QoAxpO0Us3zDScrfLc3LBhNtfunDrJHQQfgZKs1b5uYcddwuh3j3V1wf7HO0lmBpe6r
 M5z9RH3s6KPT771aHEPHlzPYt9q4PPyg8f7M5QlZYCRJfJoI9VTllI53V5MXAI/2poQfEp1qP9w
 6Mtx68xPzHAvhbK3rtmdke3XKcuryEO7xyEkKoOsOUMSZDkz/LbgnEqorp/dLYp+Rtn6dZgH8i9
 8TZE/7VFjo01Q/BWaksYj5XLQRw+qP6QAW36y5gnpL7UVLXxzea1TIH6qJotszYqA5x4EfG9n7a
 uNV+VF7vAj9pqCVa2NnQPV0RaXLFYO0jKUwUd+bBrUN6ItL2++LL36t9U5sP7FvzGBiDGISf293
 BlW//Pngu43nWuQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddujeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeegudfhheegheeifeegveejfffhvddtudfhhefhhfetleefuefhueeljedtfeenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgtohhnfhhighdrphihpdhhthhtphgvrhhrohhrfihhvghnthhrhihinhhgthhofhgvthgthhhthhgvtghonhhfihhgrdhphienucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehsthgvvhgvsehsrghkohhmrghnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 08:23:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1176

From: Antonin Godard <antonin.godard@bootlin.com>

Print a warning when we get an HTTPError and exit with 0. This can
happen intermittently and there isn't much we can do about it. For
example:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1158/steps/16/logs/stdio

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index db9928f..0cc314b 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -48,6 +48,7 @@ import tempfile
 
 from pathlib import Path
 from typing import List, Dict, Set
+from urllib.error import HTTPError
 
 
 CONFIG_REMOTE_URL = "https://git.yoctoproject.org/yocto-autobuilder2/plain/config.py"
@@ -250,12 +251,18 @@ def main():
         exit(1)
 
     if args.config_from_web:
-        with urllib.request.urlopen(CONFIG_REMOTE_URL) as r:
-            with tempfile.TemporaryDirectory() as tempdir:
-                with open(Path(tempdir) / "config.py", "wb") as conf:
-                    conf.write(r.read())
-                sys.path.append(tempdir)
-                import config
+        try:
+            with urllib.request.urlopen(CONFIG_REMOTE_URL) as r:
+                with tempfile.TemporaryDirectory() as tempdir:
+                    with open(Path(tempdir) / "config.py", "wb") as conf:
+                        conf.write(r.read())
+                    sys.path.append(tempdir)
+                    import config
+        except HTTPError as e:
+            print(f"WARNING: HTTPError when trying to fetch the config.py file from {CONFIG_REMOTE_URL}:")
+            print(e)
+            print("Safely exiting...")
+            exit(0)
     else:
         sys.path.append(os.path.dirname(args.config))
         import config

---
base-commit: 38784f58056d8d0b5000463a611bce5e31aa076f
change-id: 20250311-yocto-supported-distros-fixes-b9be6bdfa801

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


