Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64255C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.28761.1754495066251137814
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WVz8MU2Y;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A007E4433A;
	Wed,  6 Aug 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG3IftwyUQWy1rBMu7Djwx3wSmqQC4mOCbC6syZjT6E=;
	b=WVz8MU2YMa/y4nceuYvGjyejxNMCaRMml1pdxpkBdaJ/gjNGNEt/NGMk/QSLe14Lo7i8ib
	VD/ajYMeNlDZnOydLhNguQMyrDy44Y+t7+XQCPmyUnewNDCzEgCEtXRdaxfdngF3KHLfKx
	UEzD0kECk/GSCmEbfVHeTcAKMXPSpa7B0p4p+ggv5YCW+QKkOtjbZHA+Hn0xwRDwoP+5ir
	JrrpI+YYvPCwuiAYzfa9W6LGbdlVvkkAExP8e182mZUKjly8P9jnNaRTFh4FcOGq9Ck9dw
	k0YqrQR80WWEXPkX8nNACk3cyuAQlb8MbUBRikON6bixgSQU7NyNkCMBL2OcZQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:33 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 3/7]
 scripts/yocto-supported-distros: configure mutually exclusive argparse
 groups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-3-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aqFIZ95HxqIktTXT/MAZkVRMHdDly2AMQarmSdC1BXY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hWtQVLiOz46OJbw75iW1LpIDZYMWlW9EQB5
 8F0Go7jzoKJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VgAKCRDRgEFAKaOo
 NtjOD/9aLJZr0eNlOIuQx5ZAXOLlHkyGIf35ot5aHsjJJHI7VKRMr4Ibrp9CFLO6J24eiJCJ8zR
 eSKP4VPlhyoH6R7AYFnfcjlOTs/enhz/sFwjG5OZRKNs5yj1FAaD+kop8COs9r1dQbVDcA1RcvF
 anxuMKeEXuxisyp4Ga7s1rmwwLScpF3u+CAfQRQA2GcYT+lf8z7wEEFvFc07+npHGSHITvJJSti
 azGNshfuKBB26YMp3KqaNclT0fviYWMxvG6UPT2npytIhkNQL5FfRcTtRvdnUkre2+fDRxtjXjy
 RV3J9P1Av/3w65KZr+YHOWwe4WDp73UZOStOliaR8HW/MKtCyDTf6DS7D+bZJUxsZQflSOPjs/R
 Zi0s2Ju6oWM9dc4MOBPdDM0mFK/YvpdcKMDOzBXPkgbxQDQ36rA+5RMRmu5elp2TzwpHWoCbob/
 n+oF7Yme1TUhvMGp3qXhH4yD4R8WZUsJUhtnclsp9d05RyAIp9wek8hNK1OaujRxZ7qay1iDo1j
 EoHoafaUWU+JBSyZo1jGAbO1iQkKDQsFGqdfqcyKJ2rnwrw+Wz4SqkU2RAMCJ8vZmLzy9aE4trB
 yTfcmunoCF90akpfikO7Tp5Ft1qSEAqvg8xbweDFtbz1QER8Oowqd2SBSBiY/A7B6kMEKvsvtYr
 51Tlfkjocy5WlVw==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1891

Some options cannot be used with others. Make them mutually exclusive.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 81f881f..e259e1a 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -59,29 +59,33 @@ AUTOBUILDER_WORKERS_ENDPOINT = "https://autobuilder.yoctoproject.org/valkyrie/ap
 def parse_arguments() -> argparse.Namespace:
     parser = argparse.ArgumentParser(description="Print supported distributions")
 
-    parser.add_argument("--releases",
-                        type=str,
-                        nargs='+',
-                        default=[],
-                        help="Yocto releases")
-
-    parser.add_argument("--config",
-                        type=Path,
-                        default=None,
-                        help="Autobuilder config.py input file")
-
-    parser.add_argument("--release-from-env",
-                        action="store_true",
-                        help="Get the release codename from the bitbake environment")
+    g1 = parser.add_mutually_exclusive_group()
+
+    g1.add_argument("--releases",
+                    type=str,
+                    nargs='+',
+                    default=[],
+                    help="Yocto releases")
+
+    g1.add_argument("--release-from-env",
+                    action="store_true",
+                    help="Get the release codename from the bitbake environment")
+
+    g2 = parser.add_mutually_exclusive_group()
+
+    g2.add_argument("--config",
+                    type=Path,
+                    default=None,
+                    help="Autobuilder config.py input file")
+
+    g2.add_argument("--config-from-web",
+                    action="store_true",
+                    help="Get config.py from yoctoproject's git web interface")
 
     parser.add_argument("--compare",
                         action="store_true",
                         help="Compare to poky.conf releases")
 
-    parser.add_argument("--config-from-web",
-                        action="store_true",
-                        help="Get config.py from yoctoproject's git web interface")
-
     parser.add_argument("--check-worker-statuses",
                         action="store_true",
                         default=False,

-- 
2.50.1


