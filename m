Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E5C71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:53:25 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.1974.1750402404286432017
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Jun 2025 23:53:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=enZraUUe;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0532A4428A;
	Fri, 20 Jun 2025 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750402401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4bRTuXNeqbtzaRmEJiJ+v45HfVKNsFtH/yK2u8D+cyM=;
	b=enZraUUeQuLGWjphU64C7umaKjxTGYqTEubZvgNxZkPJfhROBpYQDC20NnypSM0DBJ4HQ3
	0csOw3gdz9dSc2pak6CriSEzI4c0H7Q/v2X9O1Z9EExQc3crWjYA/XIaYjlqT5Ij4zKCPW
	OvKJDX8xoEiRXB+od5/3oW06ngQq5Kd65LHAI6Wh3mfAzQ26gzg81GNvfELhQj3HJFAig9
	0WImq1o7qaZs4vku3mYRO/O1ZQWGC8H+s25B9QUjQH1EeJVLN0CHy/UAnn1jBOVf7e0A82
	3Glu4EJM8WHZKRTbpzEVJ8hEQNx3XxaY52MBVuMyNhtG++LTICPX8qtCqHYmFg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Jun 2025 08:52:48 +0200
Subject: [swat-tools][PATCH] review: add a confirmation menu before exiting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-confirmation-menu-v1-1-dec1ab0b9626@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD8FVWgC/yXMQQrCMBCF4auUWXdgGjRQr1K6iMnUjtikZFIVS
 u9u1OUH7/07KGdhhUuzQ+anqKRY0bUN+NnFG6OEajBkzmQNoU9xkry4Uoe4cNzQBepPgTpryUD
 9rZknef+aw/i3btc7+/INDfpyBUtKDx3hOD52ixrqgQAAAA==
X-Change-ID: 20250620-confirmation-menu-ad094d016602
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3584;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8bwvPjYjfUm85wELqTSideSL6pRxgPz/TVPO32nNc6g=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoVQVfW/MVDcIScdpUjfYVYuLSxy1uIjsmXVd0C
 LAxHQLJrJ6JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFUFXwAKCRDRgEFAKaOo
 NjcMEADIFVgezGxXDcrPD5qpn1zwvGuz1YB11531fA4DBl96hsK26knjXtaZrVV0LA65onBwLYg
 JP7sxZPgXA4TH6kPBQSeOHsfpSIDrHtQOsW68H2C03IjyKj1ul8NG4JFIfIlKIV5R77NbpZEpyY
 WzAPlo3o2AlWpRjQzUbs9scwZxpocrBbgxwDrG6BCwNpkDMRqYiA9JgKqir6OufN5jTQq5xhMhv
 FHWjIHfk8xnzCnROGG3cSWRC8JbCS9ioozuGlUJSxaYiKG7XeNG4Pr37D4cf7AENgeuB6Rn7GOb
 M7xgFlw60Aj6Sr2WcpTaAfI0PlYaVeR3zaUB1P5eaE3jX0parhF59fBp+yUHFd2v+8eZyhFf92y
 8SS/BUNhZH7uDRWkPFaHzDjYVbyfELEIt9zjIs9Oyp4fM4sVTZ+oXthCbTn+EF8ezAW5av6i2P2
 IFdVxORdFd15IeV8hRa22CQCJhGmPsbx+U4hJzv+m77qaeAYbchfuhetAGBUdrRI8j1iwmJLoB7
 lUk/fZEpNlIVZ43cPwYa+gREFMLnEE0DjQNdqqRse5htuPpCinSKfsAcILpKUUZF5rSrw21d9Pu
 MmA1RN1ewzAybN+CqF+rWsK1HwpesrhbjUWgooMP8i/mtCqAmsSTqtfW3yxYO6zii2GFuOVee0t
 eQzbp8Lbm/LzwtA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdejjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduieejledtieeuteffveetleeuffeivdffjefgteehgfehleeiteehieeuieekueenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhis
 hdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 06:53:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1667

Add a confirmation menu before exiting swatool. This way you can go back
to the main menu quickly by spamming "q", without fearing to exit
swattool entirely and having to relaunch it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/review.py | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/swattool/review.py b/swattool/review.py
index 8a28446..e05ac50 100644
--- a/swattool/review.py
+++ b/swattool/review.py
@@ -63,6 +63,7 @@ class ReviewMenu:
         show_infos = True
         self.entry = 0
         self.done = False
+        self.almost_done = False
         while not self.done:
             try:
                 build = self.builds[self.entry]
@@ -75,6 +76,8 @@ class ReviewMenu:
 
                 prev_entry = self.entry
                 self.review_menu()
+                if self.almost_done:
+                    self.exit_menu()
                 if self.need_refresh:
                     self.need_refresh = False
                     utils.clear()
@@ -128,6 +131,14 @@ class ReviewMenu:
 
         return [c for c in commands if c != ""]
 
+    def _get_exit_commands(self):
+        commands = [
+            "[y] yes",
+            "[q] no",
+        ]
+
+        return [c for c in commands if c != ""]
+
     def _get_triage_commands(self):
         build = self.builds[self.entry]
         simcount = len(_get_similar_builds(build, self.builds)) - 1
@@ -148,9 +159,10 @@ class ReviewMenu:
 
         return [c for c in commands if c != ""]
 
-    def _show_menu(self, commands: list[str], cursor_index: Optional[int]
-                   ) -> Optional[str]:
-        status_bar = f"Progress: {self.entry + 1}/{len(self.builds)}"
+    def _show_menu(self, commands: list[str], cursor_index: Optional[int],
+                   status_bar: str = "") -> Optional[str]:
+        if not status_bar:
+            status_bar = f"Progress: {self.entry + 1}/{len(self.builds)}"
         action_menu = TerminalMenu(commands, title="Action",
                                    status_bar=status_bar,
                                    cursor_index=cursor_index,
@@ -251,6 +263,22 @@ class ReviewMenu:
                 self.triage_menu()
                 break
 
+    def exit_menu(self):
+        """
+        Exit menu before really leaving.
+        """
+
+        commands = self._get_exit_commands()
+        default_index = commands.index("[q] no")
+
+        while True:
+            command = self._show_menu(commands, default_index,
+                                      status_bar="Sure you want to exit?")
+
+            handled = self._handle_navigation_command(command)
+            if handled:
+                break
+
     def _get_abint_num(self) -> Optional[int]:
 
         def preview_bug(fstr):
@@ -434,6 +462,16 @@ class ReviewMenu:
 
     def _handle_navigation_command(self, command: str) -> bool:
         if command == "q":  # Quit
+
+            if self.almost_done:
+                # Go back to the review menu
+                self.almost_done = False
+                return True
+
+            self.almost_done = True
+            return True
+
+        if command == "y":  # "yes", acting as Quit on exit menu
             self.done = True
             return True
 

---
base-commit: 8930d3e3f71dc3d2a33e8df5ade430deeeb7019b
change-id: 20250620-confirmation-menu-ad094d016602

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


