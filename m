Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F71C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 11:09:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.20792.1740136145337150188
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 03:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=n1BVAPqu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB52E43221;
	Fri, 21 Feb 2025 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740136143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grf+FmYS8i9OpncE+DsyaJ0vpSMvLWU9HI/6tpxOnhM=;
	b=n1BVAPqurrHvoYl3t1jKMOUFpgA3+vtm7Q3BFyz3vZ7qldmq4nFz6da6NAa2t2M+Bq6MR4
	fkwA1cv8wN4Zfj1OfOXe9Wr0xYsWcZ7eTpk5dL0QaK06rNR0W6mcrDPSbhhGEvyIdbwf3K
	Fpgig1RsxmSIAXN3nQLPCXngVHYr8JYAFfZwKzqKo7JLgQ5ULNthRLmdALthKbHDrkkfbm
	QYlhnrQyHH3CGqT8WuPX+5QypxOcGbR68SLBp7wNLXNph41AlafXoV98uiWuJ2rxTHW46e
	ZEY/sURu4eFYqH+U+p7kYrX+RQEF7ICCt4+5+7zWHrwPoWS/jJKfxtFkbuUeIQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 21 Feb 2025 12:08:34 +0100
Subject: [PATCH yocto-autobuilder2 1/3] yocto_console_view: Fix release
 selector use with keyboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mbria-release_selector_bugs-v1-1-13d166ff0ca1@bootlin.com>
References: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
In-Reply-To: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740136143; l=4780;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=YYOVES4hr53V2I83fm4+qrH/3wEA2gKl42ymsfvMyY4=;
 b=ao20jb2H5E9yRdn8S1YkGxZ/aDvMRL2RvAX6DlrHpra6ABcXdhaPmIxxV9dBWHKnT4IsuISRk
 CZ7PQjplUT/AcZaLUthIbzcEJnic4SUPeKvSOMB1iErEf0r1gn1GkH5
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtt
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 11:09:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1114

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts | 70 +++++++++++++++++---------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index a11816b21829..b330c4cb2ad7 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -1,8 +1,8 @@
 import {buildbotSetupPlugin} from "buildbot-plugin-support";
 buildbotSetupPlugin((reg) => {
+	let selectInputName = null;
 	let selectListName = null;
 	let inputRefs = null;
-	let selectors = null;
 
 	const onTransitionEndEvent = (event) => {
 		/*
@@ -44,59 +44,79 @@ buildbotSetupPlugin((reg) => {
 		const releaseSelector = inputRefs.get('force-field-branchselector');
 		const releaseSelectorLabel = releaseSelector.parentNode.previousSibling;
 		const sepIdx = releaseSelectorLabel.textContent.indexOf(':');
-		releaseSelectorLabel.textContent = releaseSelectorLabel.textContent.substring(0, sepIdx);
+		if (sepIdx >= 0) {
+			releaseSelectorLabel.textContent = releaseSelectorLabel.textContent.substring(0, sepIdx);
+		}
 
 		/*
 		 * Get the name of the ReleaseSelector field div.
 		 */
-		const branchInputId = releaseSelector.attributes.getNamedItem('id').value;
-		const selectName = branchInputId.substring(0, branchInputId.lastIndexOf('-'));
+		selectInputName = releaseSelector.attributes.getNamedItem('id').value;
+		const selectName = selectInputName.substring(0, selectInputName.lastIndexOf('-'));
 		selectListName = selectName + '-listbox';
 	}
 	window.addEventListener('transitionend', onTransitionEndEvent);
 
-	const onClick = (event) => {
+	function updateSelectors() {
 		if (selectListName) {
 			const listDiv = document.getElementById(selectListName);
 			if (listDiv) {
 				/*
-				 * The ReleaseSelector menu is shown: save
-				 * associated selectors for later and clean menu items.
+				 * The ReleaseSelector menu is shown: clean menu items.
 				 */
-				selectors = new Map();
+
 				listDiv.childNodes.forEach(div => {
 					const sepIdx = div.textContent.indexOf(':');
-					const propName = div.textContent.substring(0, sepIdx);
-					const content = div.textContent.substring(sepIdx + 1);
-					div.textContent = propName
-					selectors.set(propName, JSON.parse(content));
+					if (sepIdx >= 0) {
+						div.textContent = div.textContent.substring(0, sepIdx);
+					}
 				});
 			}
 		}
+	}
+
+	function findApplySelector() {
+		/*
+		 * One entry was clicked in the ReleaseSelector
+		 * menu: update all fields described by the
+		 * selector configuration.
+		 */
+		const branchInput = document.getElementById(selectInputName);
+		const inputText = branchInput.parentElement.previousElementSibling.textContent;
+		const sepIdx = inputText.indexOf(':');
+		const selectorName = inputText.substring(0, sepIdx);
+		const selector = inputText.substring(sepIdx + 1);
+
+		new Promise((resolve, reject) => {
+			return applySelector(JSON.parse(selector), selectorName).then(resolve);
+		});
+	}
+
+	const onClick = (event) => {
+		updateSelectors();
 
 		if (event.target.parentElement) {
 			const parentId = event.target.parentElement.attributes.getNamedItem('id');
 			if (parentId && parentId.value == selectListName) {
-				/*
-				 * One entry was clicked in the ReleaseSelector
-				 * menu: update all fields described by the
-				 * selector configuration.
-				 */
-				const selector = selectors.get(event.target.textContent);
-				if (selector) {
-					new Promise((resolve, reject) => {
-						return applySelector(selector, event.target).then(resolve);
-					});
-				}
+				findApplySelector();
 			}
 		}
 	}
 	window.addEventListener('click', onClick);
 
+	const onKeyDown = (event) => {
+		if (event.key == "Enter") {
+			findApplySelector();
+		} else {
+			updateSelectors();
+		}
+	}
+	window.addEventListener('keydown', onKeyDown);
+
 	/*
 	 * Apply values from the selected field selector
 	 */
-	async function applySelector(selector, selectList) {
+	async function applySelector(selector, selectorName) {
 		for (let [field, value] of Object.entries(selector)) {
 			const input = inputRefs.get('force-field-' + field);
 			if (input && input.value != value) {
@@ -110,7 +130,7 @@ buildbotSetupPlugin((reg) => {
 		}
 
 		const releaseSelector = inputRefs.get('force-field-branchselector');
-		releaseSelector.parentNode.previousSibling.textContent = selectList.textContent;
+		releaseSelector.parentNode.previousSibling.textContent = selectorName;
 		releaseSelector.focus();
 	}
 

-- 
2.39.5


