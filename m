Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129CC35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 10:54:11 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.62549.1742900048880924440
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Mar 2025 03:54:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DnftL0+d;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF87C43315;
	Tue, 25 Mar 2025 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742900047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mF09Ha9p9fY2alIZdRGd5deUYiqe2xP0DVt0b/Wcv0I=;
	b=DnftL0+dLkke2dVMUFMgtUG1dZHrqR1ZzxXtVSZMKDx7tH3Vq5Nml5a85Uwa/1ag+QbN7g
	O28ZBbIzGZ+wYwQJUKFsLGz49zkgQoq0remNNFHmrRSnykVubADB9MJf7Gtgj9mcZ8Fdnt
	bLumRFs5luy45oXUlQX3uvDXj0LyezDgapaqsS4BACZAW/RvYQLzwuGx0sMYhvP9PF8rrB
	2vA2q/rO0wxe9XRb5q/SeyFKmXldLalHMf2Do4zYFrjR46iGgpfmK3MkHxSG3llxeOv1bd
	OQCicBbvMNx4DEcICt1uvNWp118lSb6m27o4uk4m79QCtpPJyivcMlRV4tXmzQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 25 Mar 2025 11:53:57 +0100
Subject: [yocto-autobuilder-helper PATCH] scripts/yocto-supported-distros:
 consider any *master* branch to be master
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-yocto-supported-distros-fix-v1-1-1a3abd4dc32b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAESL4mcC/x3MQQqDQAxA0atI1gbGKSr0KuLCmozNxgzJtLSId
 3dw+f7iH+Bswg7P5gDjr7joXtG1DazvZd8YhaohhtiHR+zxr2tR9E/OaoUJSbyYOib5Ib1SoGF
 MibsR6iEb13zfp/k8L8CHaGVtAAAA
X-Change-ID: 20250325-yocto-supported-distros-fix-dbf0d67ffe17
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8r5lfrjeFXT39qtWLgb6s4PycGJ7xKVzqU4dv9ukgyg=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn4otOAC427+wbql9ULK4ZZ3wdUEx2Ct1v4cewF
 ZMJQgTn93GJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ+KLTgAKCRDRgEFAKaOo
 Ni5tD/90uiN4X0xbYxQiCRkWi3YHhvCWfHwuhNgO22R+IK2EGweTYvZx29nq3rBAiQK7al5N7Q8
 ibpHLRwnfSxv00WoxdqAEPjIvbiPtbC+NAQJCrjZ1dcSYLqoJKZ0QinEnsOZIqwuGVUPIh3cl9q
 45D1iLHl1ZoPGMFPMfIbUGPOf6uvrmaKykvza9KJiSlalFKFiZfApCSKEcdh5tkCoUGHpPUW69a
 w8B95mhbw9h+8PtOj0LVPJx3/80k8Kh4oc2f4uIwC/2X4N6q05SjyhlDnIgWdFAF2yFMYg79quu
 3/eKWzHer4r+HQ8+4L52QihVGjMSEJxK3ONZ1NV6TnOv1oK2iOBRVKdLKvyC6dfVPvjhitaV3IS
 sTnsWqHvG34h+HYwkQ6/hYp2ythdKTWZ41X8XGbjmfFKYmIHjp4LKFnxsEiZ8ruGlH6j6FwdCJT
 l+5hrLUqIbFYadWv0kIEZ7mylACWPM3yZb5rMFFidsujUv9Lfagj5Kdvc9OKNmIi9/hms8UgThg
 9hAi1qMdkkA2ZVlU97JW3qYxR9yXqRzK5eX5NEsuX7oa1osbnqMMcMg4uUUHdGkVF7Thpn9rcW9
 PBA3R9mbOOlKa0e7fyxMNGmatqgmvYzw5JQxl/7BbWvfkg/DKBXdiix71jiVf9OmJjWPjUZa5bY
 GtxE+klFfa5cTeA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduieejledtieeuteffveetleeuffeivdffjefgteehgfehleeiteehieeuieekueenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsr
 dihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 10:54:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1248

Testing builds often run on branches <someone>/master[-next]. In these
cases we are really testing "master", so return that. Instead of
exiting with: "Release <future release> does not exist".

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 0cc314b..172a186 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -160,8 +160,8 @@ def _get_current_core_release() -> str:
         ["bitbake-getvar", "--quiet", "--value", "METADATA_BRANCH"],
         encoding="utf-8")
     release = release.strip()
-    if release == "master":
-        return release
+    if "master" in release:
+        return "master"
 
     release = subprocess.check_output(
         ["bitbake-getvar", "--quiet", "--value", "LAYERSERIES_COMPAT_core"],

---
base-commit: 40e3ac177d58484795b14cd1b9a18193bbdd4d2b
change-id: 20250325-yocto-supported-distros-fix-dbf0d67ffe17

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


