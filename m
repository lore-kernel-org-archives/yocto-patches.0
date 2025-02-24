Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8995C021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 09:17:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.85598.1740388643945403038
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 01:17:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ndBkMAiS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 316B5432E9;
	Mon, 24 Feb 2025 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740388642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8s75kOckOephZuY65d56mhZ+VKU8inPHFb67y3Kezec=;
	b=ndBkMAiSMLS08MM0dYFXBSzJ0IXbq3PpSdeKkiKVrsxNBF/wsP36jMxQIFXX4ljl6iaESU
	1pzx28y3iJdAnkADMX/kgJzkc9tMA8NLPLW5LvvU1Ng3JQx3qheK1f9DAEkGQ4zyML5CNz
	1k1xwdvGk93TgydMe8w/D2HxkP5FlEJfYDEZOrBflv2E6KnPwuA95CkPO8Po6XpuT0DUFv
	2Pxt7U1FV3K750Cm163z4/yZCMdJEAUTK21MlQ4isWcWHPdfWfJKOF0rXi1sn97eo7jUuJ
	JL0+ZtrDSwXMPV72DSXYkTZfItIaiDr9Q9t+i5/L22edTzMRd6+KjK4RmOJ4CA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 24 Feb 2025 10:16:46 +0100
Subject: [PATCH yocto-autobuilder2] releaseselector: Fix page scroll on
 selector use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mathieu-release_selector_scroll-v1-1-b0deb510d91f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAP04vGcC/x2N0QrCMAxFf2Xk2cKMVsFfERlZG12grpK0wzH27
 xafDgcO925grMIGt24D5UVM8tzkeOggTDS/2ElsDtij7xHP7k1lEq5OOTEZD9YYStbBguaUHF5
 9DBdCCv4EbeWj/JTv/+EOa26po1ryWCVFVoTHvv8A+NTHUIUAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740388641; l=1950;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Kuxxn5xotsX/zrRV+Bbeg1nCmLIWJEt89GlMD9svCVA=;
 b=X31I9u1MQypUuDd+g7j+YHkLqLzh8fnJr9AVSbLOS6KZmi+q2V5YPHlQSdk/7sE+CcpwCnaO/
 6uJ/eVFS737C1uzKYpOKTatrwCMR7qyqgxujIBkqTbJiLqVhxrG5Klc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleeltdeiffehleevfeeuffekgfehvedvueeguddtkeefgefhhfffffdtgeduhfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrt
 ghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 09:17:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1120

When using selectors, all fields modified by the selector will be
successively focused, inducing a potential page scroll. Save current
scroll before applying the release selector and set back this scroll
once the selector has been applied, setting back the page at the same
position.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index 93ce46382f95..db707ef09174 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -117,6 +117,13 @@ buildbotSetupPlugin((reg) => {
 	 * Apply values from the selected field selector
 	 */
 	async function applySelector(selector, selectorName) {
+		const modalBody = document.getElementsByClassName("modal-body")[0];
+		let scrolltop = 0, scrollleft = 0;
+		if (modalBody) {
+			scrolltop = modalBody.scrollTop;
+			scrollleft = modalBody.scrollLeft;
+		}
+
 		for (let [field, value] of Object.entries(selector)) {
 			const input = inputRefs.get('force-field-' + field);
 			if (input && input.value != value) {
@@ -132,6 +139,16 @@ buildbotSetupPlugin((reg) => {
 		const releaseSelector = inputRefs.get('force-field-branchselector');
 		releaseSelector.parentNode.previousSibling.textContent = selectorName;
 		releaseSelector.focus();
+
+		/* Scroll back to the initial position. */
+		if (modalBody) {
+			modalBody.scroll(scrollleft, scrolltop)
+
+			setTimeout(() => {
+				modalBody.scroll(scrollleft, scrolltop);
+			}, 1);
+
+		}
 	}
 
 	/*

---
base-commit: 62d5d77167a427d87516a6503137a3b2f264cfd5
change-id: 20250224-mathieu-release_selector_scroll-275dc6a2ac53

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


