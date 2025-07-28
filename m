Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D928CC87FCE
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 08:45:25 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.76637.1753692319109529887
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Jul 2025 01:45:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FAt0/EUF;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47BC941DE2;
	Mon, 28 Jul 2025 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753692316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BkWVT1klPpbh5Nr2i3eqFXJNvCX3PSk/jC76OuhDKz8=;
	b=FAt0/EUFvjEPXyE01eJeRq+HEY4d6w+w7PZXQAlVT1TPF0k8HHajnMpKIxBXJ1Epqv/qHb
	sSld20HdnS5Q9qQ3iQGQaBO03vK/O4UA6ugz1IiwRSFCpIE9/O/fGPr8WvsD1brW9pK+KI
	6OlecrNFD0wuI6WF4ec6zlMv0I64l72as+CmFtQYnUbxFBfweZI9S2RA0/ijhssm1WgJ/s
	vr8O5YessYTfgbWQdChmIKQZ0r4PaKHNqHiA4/UGTBOP5hVwP0Lmhzad9Yfzdv/Nb9HlNi
	3n661IlniZm/CMfE7ggz8ZMtxtNGk3naQBUnvT1KwJ0+snWgoKq2qxOmPrGpQg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 28 Jul 2025 10:45:02 +0200
Subject: [PATCH yocto-autobuilder-helper][walnascar] config.json: Drop
 meta-ti from check-layer-nighlty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-mathieu-walnascar_meta_ti-v1-1-75cbd722761f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAI04h2gC/z3MywqDMBBA0V+RWTegSaW2vyIi02RsBmIiefSB+
 O8NXXR5FvfukCgyJbg1O0R6cuLgK7pTA9qif5BgUw2ylX17kYNYMVumIl7oPCaNcV4p45xZkNH
 L0F3VuVcKar9FWvj9e4/wCToHgSWHe2FnKApLbqM4jf8RTMfxBfDmUJ+QAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Denys Dmytriyenko <denys@konsulko.com>, Ryan Eatmon <reatmon@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753692316; l=2545;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=37HQ9twxsCFIkYqD/4d8agjiF5+msVp+r08TCOfaZhI=;
 b=n2XTMcy09uf+TeFgWqUf7A6XkGoLd8DFwMmllDwQMndsdnmEaR+dWNQUMQsu/c3xcjaRfhq6p
 SE1djCxOXtmA2lNew6yva601YRQkPe0+XO5Rn/FuTnc/fn9fnrR2DVa
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleeltdeiffehleevfeeuffekgfehvedvueeguddtkeefgefhhfffffdtgeduhfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrvggrthhmohhnsehtihdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgso
 hhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepuggvnhihsheskhhonhhsuhhlkhhordgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Jul 2025 08:45:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1875

meta-ti does not support Walnascar branch: do not test it.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/config.json b/config.json
index bc1ecc89581e..84b41157ff38 100644
--- a/config.json
+++ b/config.json
@@ -1224,7 +1224,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
+            "NEEDREPOS" : ["poky", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
             "step1" : {
                 "shortname" : "Test meta-arm YP Compatibility",
                 "MACHINE" : "qemuarm64",
@@ -1239,22 +1239,18 @@
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-intel --no-auto-dependency"]
             },
             "step4" : {
-                "shortname" : "Test meta-ti YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-ti/meta-ti-bsp ../meta-ti/meta-ti-extras --dependency ../meta-arm --no-auto-dependency"]
-            },
-            "step5" : {
                 "shortname" : "Test meta-oe YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-openembedded --no-auto-dependency"]
             },
-            "step6" : {
+            "step5" : {
                 "shortname" : "Test meta-virtualization YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-virtualization --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python ../meta-openembedded/meta-filesystems --no-auto-dependency"]
             },
-            "step7" : {
+            "step6" : {
                 "shortname" : "Test meta-clang YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-clang --no-auto-dependency"]
             },
-            "step8" : {
+            "step7" : {
                 "shortname" : "Test meta-exein YP Compatibility",
                 "extravars" : [
                     "HOSTTOOLS:remove = 'clang llvm-strip'"

---
base-commit: 04c045fd6df75d9e754a419c9f12341171086a23
change-id: 20250728-mathieu-walnascar_meta_ti-edcf81934533

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


