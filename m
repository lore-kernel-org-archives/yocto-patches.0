Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4538BC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.9393.1738752390691946602
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gX0a/ty9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3828843447;
	Wed,  5 Feb 2025 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=616HWrAEXdAPREp296CiG0V6gx31Vlte90wdcyoATz0=;
	b=gX0a/ty9HqvpbOhUzkIVaSIFdqKtW3g1axAzNBm9JcZjEv93iURJZtJo7ycI4r4kq/EBej
	+80yRKBwJ2KKBofv+cruU6LXm1QSK6rWSWgSCuvHYVfjQtDU2z8Maku+7E+zvAyIirdtsr
	qD0wDu/kslDq+XEUuF7tTvhTIeX2xLRamdQ7cQftl25GLRuibKqTGYxG5l6GodSG72Et1y
	y1tPMFbVelaPgQe8MGu2eSXCJFuZcb7gq3EhPV272T8tkNQDnCXWMUD5XYVs5+J3RaPtOe
	m56Ad/oDd4I469NV4edsW1d354CESXdH0z0aQF702+uyO7YEQtdYy/v8INjIXA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:45:54 +0100
Subject: [PATCH yocto-autobuilder2 4/4] yocto_console_view: Add release
 selector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-console_view_upgrade-v1-4-fc1194355870@bootlin.com>
References: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
In-Reply-To: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752387; l=7847;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=UggBic3iaBms2TQbGXE+x2cKPvJM0HbccEyGIaOoVtg=;
 b=lOOEyiBkkL71NJpLincAUFNvy/hD49oj6RVcy64AIxpkrcfIVgei7rdKidHYJxDo32wlq28Ph
 dr55TRlSS3xBk9pdzKyhcg+oUaWyFOHKFBwISAy/CS0Tnit194bA9Ik
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleeijeefudehtdekhfehgedvhfetkeeuheevteeivdehueevheetueehheevleeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrthhhi
 hgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:46:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1035

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/index.ts                   |   1 +
 yocto_console_view/src/releaseselectorfield.ts    | 152 ++++++++++++++++++++++
 yocto_console_view/yocto_console_view/__init__.py |  36 +++++
 3 files changed, 189 insertions(+)

diff --git a/yocto_console_view/src/index.ts b/yocto_console_view/src/index.ts
index fa0781c88e9a..de773540f6d7 100644
--- a/yocto_console_view/src/index.ts
+++ b/yocto_console_view/src/index.ts
@@ -16,3 +16,4 @@
 */
 
 import './views/ConsoleView/ConsoleView';
+import './releaseselectorfield';
diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
new file mode 100644
index 000000000000..a11816b21829
--- /dev/null
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -0,0 +1,152 @@
+import {buildbotSetupPlugin} from "buildbot-plugin-support";
+buildbotSetupPlugin((reg) => {
+	let selectListName = null;
+	let inputRefs = null;
+	let selectors = null;
+
+	const onTransitionEndEvent = (event) => {
+		/*
+		 * We are looking for the transition showing the "forcebuild" dialog.
+		 */
+		if (!event.target.classList.contains("bb-forcebuild-modal"))
+			return
+
+		/*
+		 * Find modal-body div.
+		 */
+		const modalDialog = Array.from(event.target.children).find(e => e.classList.contains("modal-dialog"));
+		const modalContent = modalDialog ? Array.from(modalDialog.children).find(e => e.classList.contains("modal-content")) : null;
+		const modalBody = modalContent ? Array.from(modalContent.children).find(e => e.classList.contains("modal-body")) : null;
+		if (!modalBody)
+			return;
+
+		/*
+		 * Generate a map of all inputs, identifed by the field name.
+		 */
+		inputRefs = new Map();
+		document.querySelectorAll('input').forEach(input => {
+			let idparent = input;
+			while (!idparent.attributes.getNamedItem('data-bb-test-id')
+			       && idparent.parentElement != modalBody) {
+				       idparent = idparent.parentElement;
+			}
+
+			const id = idparent.attributes.getNamedItem('data-bb-test-id')
+			if (id)
+				inputRefs.set(id.value, input);
+
+			prepareInterceptor(input);
+		});
+
+		/*
+		 * Only show the pretty name in the release selector field.
+		 */
+		const releaseSelector = inputRefs.get('force-field-branchselector');
+		const releaseSelectorLabel = releaseSelector.parentNode.previousSibling;
+		const sepIdx = releaseSelectorLabel.textContent.indexOf(':');
+		releaseSelectorLabel.textContent = releaseSelectorLabel.textContent.substring(0, sepIdx);
+
+		/*
+		 * Get the name of the ReleaseSelector field div.
+		 */
+		const branchInputId = releaseSelector.attributes.getNamedItem('id').value;
+		const selectName = branchInputId.substring(0, branchInputId.lastIndexOf('-'));
+		selectListName = selectName + '-listbox';
+	}
+	window.addEventListener('transitionend', onTransitionEndEvent);
+
+	const onClick = (event) => {
+		if (selectListName) {
+			const listDiv = document.getElementById(selectListName);
+			if (listDiv) {
+				/*
+				 * The ReleaseSelector menu is shown: save
+				 * associated selectors for later and clean menu items.
+				 */
+				selectors = new Map();
+				listDiv.childNodes.forEach(div => {
+					const sepIdx = div.textContent.indexOf(':');
+					const propName = div.textContent.substring(0, sepIdx);
+					const content = div.textContent.substring(sepIdx + 1);
+					div.textContent = propName
+					selectors.set(propName, JSON.parse(content));
+				});
+			}
+		}
+
+		if (event.target.parentElement) {
+			const parentId = event.target.parentElement.attributes.getNamedItem('id');
+			if (parentId && parentId.value == selectListName) {
+				/*
+				 * One entry was clicked in the ReleaseSelector
+				 * menu: update all fields described by the
+				 * selector configuration.
+				 */
+				const selector = selectors.get(event.target.textContent);
+				if (selector) {
+					new Promise((resolve, reject) => {
+						return applySelector(selector, event.target).then(resolve);
+					});
+				}
+			}
+		}
+	}
+	window.addEventListener('click', onClick);
+
+	/*
+	 * Apply values from the selected field selector
+	 */
+	async function applySelector(selector, selectList) {
+		for (let [field, value] of Object.entries(selector)) {
+			const input = inputRefs.get('force-field-' + field);
+			if (input && input.value != value) {
+				/*
+				 * Setting value using input.value is not enough here: field
+				 * would appear modified but this value would not be used on
+				 * form submission.
+				 */
+				await setFieldValue(input, value);
+			}
+		}
+
+		const releaseSelector = inputRefs.get('force-field-branchselector');
+		releaseSelector.parentNode.previousSibling.textContent = selectList.textContent;
+		releaseSelector.focus();
+	}
+
+	/*
+	 * All code below is highly based on work from testing-library/user-event:
+	 * https://github.com/testing-library/user-event
+	 * The MIT License (MIT)
+	 * Copyright (c) 2020 Giorgio Polvara
+	 */
+	function prepareInterceptor(element) {
+		const prototypeDescriptor = Object.getOwnPropertyDescriptor(element.constructor.prototype, 'value');
+		const objectDescriptor = Object.getOwnPropertyDescriptor(element, 'value');
+		Object.defineProperty(element, 'value', {
+			objectDescriptor,
+			['set']: function(v) {
+				const realFunc = prototypeDescriptor['set'];
+				realFunc.call(this, v);
+			}
+		});
+	}
+
+	const UIValue = Symbol('Displayed value in UI');
+	async function setFieldValue(element, value) {
+		element.focus();
+		element[UIValue] = value;
+		element.value = Object.assign(new String(value), {
+			[UIValue]: true
+		});
+	}
+
+	document.addEventListener('blur', (e)=>{
+		const event = new Event('change', {bubbles: true, target: e.target, cancelable: false});
+		e.target.dispatchEvent(event);
+	}, {
+		capture: true,
+		passive: true
+	});
+
+});
diff --git a/yocto_console_view/yocto_console_view/__init__.py b/yocto_console_view/yocto_console_view/__init__.py
new file mode 100644
index 000000000000..6118ac29409b
--- /dev/null
+++ b/yocto_console_view/yocto_console_view/__init__.py
@@ -0,0 +1,36 @@
+# This file is part of Buildbot.  Buildbot is free software: you can
+# redistribute it and/or modify it under the terms of the GNU General Public
+# License as published by the Free Software Foundation, version 2.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+# details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Copyright Buildbot Team Members
+
+from buildbot.www.plugin import Application
+from buildbot.schedulers.forcesched import ChoiceStringParameter
+
+import json
+
+# create the interface for the setuptools entry point
+ep = Application(__package__, "Yocto Buildbot Console View plugin")
+
+class ReleaseSelector(ChoiceStringParameter):
+
+    spec_attributes = ["selectors"]
+    selectors = None
+
+    def __init__(self, name, selectors, **kw):
+        def format_choice(choice):
+            return choice + ': ' + json.dumps(selectors.get(choice, {}))
+
+        super().__init__(name, **kw)
+        self.choices = [format_choice(choice)
+                        for choice in kw.get('choices', {})]
+        self.__dict__['default'] = format_choice(self.__dict__['default'])

-- 
2.39.5


