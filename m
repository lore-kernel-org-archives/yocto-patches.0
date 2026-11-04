Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5541.1793784747200764295
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=neyQk6QU;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 66D0F4E413F8
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3511F60770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7554010329217;
	Wed,  4 Nov 2026 10:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UUKqiOwV4/tl5UiALlC3/4YlQ9fBlZh2UWjGSLNEnCI=;
	b=neyQk6QU6TbDTWAE+u3G9/1VxlnLsU3f+8tRCx8GsI5/ILQJi4epsvyHR4aDwwJC6SCYKU
	bJQZaSOgAT7UPzHwRpvS8+MrO46B7GmdYHFIe/rhsNlswGFROPUOjpbPl9hi57cGhTXKtq
	p/qj2qkTYmj0oQ+OXHqqdcnOoOLrnwcTEkM/HoST4g8yr9YLqzU1BTMHdCmovET4Jbq3Jk
	BqWSEHiEH8mGN83O5BBrE9ioJALE7dN7xvrCd5uFgoTUD4WidYAeMBzp7myrTfAe90x3D3
	BkVQkqeDoA8uYW9Utrxd23SiZBWEuogTUD2cSfz9ojnHjBVQVNbdfaEKxePbDg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 04 Nov 2026 10:32:14 +0100
Subject: [PATCH yocto-autobuilder2 3/5] releaseselector: Fix release
 selector not applied on keyboard use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-mathieu-release-selector-fix-v1-3-a245895c0093@bootlin.com>
References: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
In-Reply-To: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=4412;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Go/K+V96Inaf8AIxcQWmNiUdvMghPyXGul3dDe8RPO4=;
 b=KLjU3XQXGADe4VI4ao0LrhOy1uoXBHml3jl+Byy5YjFPZPEPJaflHO2HTyRo0MIYyG5bd567I
 3301pfuhfyXAcPeA21R3S6nczmKWk7K33QGvxf+bVSb+ov68TT1KqEg
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5228

When a release shortcut was picked with the keyboard, the fields it maps
to were not applied. Additionally, pressing return could raise a JS
exception.

Now the configuration is captured in a selectors map when the menu
opens, and reused later. Also, return key only applies the selected
entry when the focus is in the release selector field.

[YOCTO #16291]

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts | 60 +++++++++++++++-----------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index db707ef09174..1d82310da261 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -3,6 +3,14 @@ buildbotSetupPlugin((reg) => {
 	let selectInputName = null;
 	let selectListName = null;
 	let inputRefs = null;
+	let selectors = new Map();
+	let lastName = null;
+
+	function selectedName() {
+		const input = document.getElementById(selectInputName);
+		const label = input && input.parentElement.previousElementSibling;
+		return label ? label.textContent.split(':')[0] : null;
+	}
 
 	const onTransitionEndEvent = (event) => {
 		/*
@@ -54,6 +62,7 @@ buildbotSetupPlugin((reg) => {
 		selectInputName = releaseSelector.attributes.getNamedItem('id').value;
 		const selectName = selectInputName.substring(0, selectInputName.lastIndexOf('-'));
 		selectListName = selectName + '-listbox';
+		lastName = selectedName();
 	}
 	window.addEventListener('transitionend', onTransitionEndEvent);
 
@@ -61,13 +70,13 @@ buildbotSetupPlugin((reg) => {
 		if (selectListName) {
 			const listDiv = document.getElementById(selectListName);
 			if (listDiv) {
-				/*
-				 * The ReleaseSelector menu is shown: clean menu items.
-				 */
-
 				listDiv.childNodes.forEach(div => {
 					const sepIdx = div.textContent.indexOf(':');
 					if (sepIdx >= 0) {
+						try {
+							selectors.set(div.textContent.substring(0, sepIdx),
+							              JSON.parse(div.textContent.substring(sepIdx + 1)));
+						} catch (e) {}
 						div.textContent = div.textContent.substring(0, sepIdx);
 					}
 				});
@@ -75,21 +84,11 @@ buildbotSetupPlugin((reg) => {
 		}
 	}
 
-	function findApplySelector() {
-		/*
-		 * One entry was clicked in the ReleaseSelector
-		 * menu: update all fields described by the
-		 * selector configuration.
-		 */
-		const branchInput = document.getElementById(selectInputName);
-		const inputText = branchInput.parentElement.previousElementSibling.textContent;
-		const sepIdx = inputText.indexOf(':');
-		const selectorName = inputText.substring(0, sepIdx);
-		const selector = inputText.substring(sepIdx + 1);
-
-		new Promise((resolve, reject) => {
-			return applySelector(JSON.parse(selector), selectorName).then(resolve);
-		});
+	function applySelectorByName(name) {
+		const selector = selectors.get(name);
+		if (selector) {
+			applySelector(selector, name).catch(e => console.error(e));
+		}
 	}
 
 	const onClick = (event) => {
@@ -98,18 +97,29 @@ buildbotSetupPlugin((reg) => {
 		if (event.target.parentElement) {
 			const parentId = event.target.parentElement.attributes.getNamedItem('id');
 			if (parentId && parentId.value == selectListName) {
-				findApplySelector();
+				lastName = event.target.textContent.split(':')[0];
+				applySelectorByName(lastName);
 			}
 		}
 	}
 	window.addEventListener('click', onClick);
 
 	const onKeyDown = (event) => {
-		if (event.key == "Enter") {
-			findApplySelector();
-		} else {
-			updateSelectors();
-		}
+		const branchInput = document.getElementById(selectInputName);
+		if (!branchInput || !branchInput.contains(event.target) || event.key != "Enter")
+			return;
+		/*
+		 * The combobox commits the selection when Enter is pressed. Read the
+		 * displayed label once the new value has been rendered (deferred), and
+		 * apply the shortcut only if it actually changed.
+		 */
+		setTimeout(() => {
+			const name = selectedName();
+			if (name && name != lastName) {
+				lastName = name;
+				applySelectorByName(name);
+			}
+		}, 0);
 	}
 	window.addEventListener('keydown', onKeyDown);
 

-- 
2.47.3

