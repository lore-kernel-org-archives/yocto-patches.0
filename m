Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5438.1793784748507807221
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PbmTuwxp;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C84F44E413F5
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96B6060770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7B3E1032920A;
	Wed,  4 Nov 2026 10:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hTVDs370tAI1T343yiF6KUu5UpNR+qC8Gyd4dznS5Uc=;
	b=PbmTuwxpSRWkFAxdaU47tKRqv6q7ktqaP2ius3ZH1Z0ZenMpsKIVtmCiTlwHUaS+/Z+TW2
	aVkLrSPXduExXdFnN7/ThaPj+2SvqD6bIj+tSgFZZ/Jim4dK25YiJTVLqd1DoqqKPRah6X
	EWcuO838e6mARGSnOxZesK+o7FN9gaBMl7zcyY0VKiwLeJFn6WcC8VG5VlmJ8aH6avyCmq
	MpibrjqgJSNLt+HXpuhHGm7VSJvPlMXUdPDEKcx4ymUJV79fZIhY7EG0nXoe93Y/0hq+zs
	3wYvyTbW+OICjCfATWKXT/OMfik8JoVLKvNlDQqAhWZ3sj7pAK98Odwv1fduaQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 04 Nov 2026 10:32:16 +0100
Subject: [PATCH yocto-autobuilder2 5/5] releaseselector: Read release
 shortcuts from the force scheduler spec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-mathieu-release-selector-fix-v1-5-a245895c0093@bootlin.com>
References: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
In-Reply-To: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=4808;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=gmCETQ/WrujWY09X2kfT4jscItgav4BmbXISEzix7qw=;
 b=YsfZbqGsekiKgHVYEX4C1QoDvEES0y6M+mnb+/4IrkiaKBuO+DTVuFoXD0BLLkHnGRfivSK/1
 Xf9yiqZyO8LCEWCvPZ68TBFsO8x+Ip8gsoberEBQZECr6wP6LrZ45jR
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5230

The release selector configuration was encoded in the choice strings
and decoded in the browser. Instead, use field spec attribute to
retrieve them.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts    | 52 ++++++++++-------------
 yocto_console_view/yocto_console_view/__init__.py |  9 +---
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index 1c4d289af224..c5c681a51e29 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -1,5 +1,5 @@
 import {buildbotSetupPlugin} from "buildbot-plugin-support";
-buildbotSetupPlugin((reg) => {
+buildbotSetupPlugin((reg, config) => {
 	let selectInputName = null;
 	let selectListName = null;
 	let inputRefs = null;
@@ -12,6 +12,26 @@ buildbotSetupPlugin((reg) => {
 		return label ? label.textContent.split(':')[0] : null;
 	}
 
+	async function loadSelectors() {
+		try {
+			const res = await fetch(config.buildbotURL + 'api/v2/forceschedulers', {
+				headers: {accept: 'application/json'}
+			});
+			const data = await res.json();
+			for (const sched of data.forceschedulers ?? []) {
+				for (const field of sched.all_fields) {
+					if (field.selectors) {
+						selectors = new Map(Object.entries(field.selectors));
+						return;
+					}
+				}
+			}
+		} catch (e) {
+			console.error('releaseselector: failed to load release shortcuts:', e);
+		}
+	}
+	loadSelectors();
+
 	const onTransitionEndEvent = (event) => {
 		/*
 		 * We are looking for the transition showing the "forcebuild" dialog.
@@ -46,19 +66,11 @@ buildbotSetupPlugin((reg) => {
 			prepareInterceptor(input);
 		});
 
-		/*
-		 * Only show the pretty name in the release selector field.
-		 */
-		const releaseSelector = inputRefs.get('force-field-branchselector');
-		const releaseSelectorLabel = releaseSelector.parentNode.previousSibling;
-		const sepIdx = releaseSelectorLabel.textContent.indexOf(':');
-		if (sepIdx >= 0) {
-			releaseSelectorLabel.textContent = releaseSelectorLabel.textContent.substring(0, sepIdx);
-		}
 
 		/*
 		 * Get the name of the ReleaseSelector field div.
 		 */
+		const releaseSelector = inputRefs.get('force-field-branchselector');
 		selectInputName = releaseSelector.attributes.getNamedItem('id').value;
 		const selectName = selectInputName.substring(0, selectInputName.lastIndexOf('-'));
 		selectListName = selectName + '-listbox';
@@ -66,24 +78,6 @@ buildbotSetupPlugin((reg) => {
 	}
 	window.addEventListener('transitionend', onTransitionEndEvent);
 
-	function updateSelectors() {
-		if (selectListName) {
-			const listDiv = document.getElementById(selectListName);
-			if (listDiv) {
-				listDiv.childNodes.forEach(div => {
-					const sepIdx = div.textContent.indexOf(':');
-					if (sepIdx >= 0) {
-						try {
-							selectors.set(div.textContent.substring(0, sepIdx),
-							              JSON.parse(div.textContent.substring(sepIdx + 1)));
-						} catch (e) {}
-						div.textContent = div.textContent.substring(0, sepIdx);
-					}
-				});
-			}
-		}
-	}
-
 	function applySelectorByName(name) {
 		const selector = selectors.get(name);
 		if (selector) {
@@ -92,8 +86,6 @@ buildbotSetupPlugin((reg) => {
 	}
 
 	const onClick = (event) => {
-		updateSelectors();
-
 		if (event.target.parentElement) {
 			const parentId = event.target.parentElement.attributes.getNamedItem('id');
 			if (parentId && parentId.value == selectListName) {
diff --git a/yocto_console_view/yocto_console_view/__init__.py b/yocto_console_view/yocto_console_view/__init__.py
index 6118ac29409b..eedf6958cfe9 100644
--- a/yocto_console_view/yocto_console_view/__init__.py
+++ b/yocto_console_view/yocto_console_view/__init__.py
@@ -16,8 +16,6 @@
 from buildbot.www.plugin import Application
 from buildbot.schedulers.forcesched import ChoiceStringParameter
 
-import json
-
 # create the interface for the setuptools entry point
 ep = Application(__package__, "Yocto Buildbot Console View plugin")
 
@@ -27,10 +25,5 @@ class ReleaseSelector(ChoiceStringParameter):
     selectors = None
 
     def __init__(self, name, selectors, **kw):
-        def format_choice(choice):
-            return choice + ': ' + json.dumps(selectors.get(choice, {}))
-
         super().__init__(name, **kw)
-        self.choices = [format_choice(choice)
-                        for choice in kw.get('choices', {})]
-        self.__dict__['default'] = format_choice(self.__dict__['default'])
+        self.selectors = selectors

-- 
2.47.3

