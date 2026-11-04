Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5542.1793784747892811936
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sdY5J2Uu;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36F614E413F9
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 063CF60770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16EBF103291FC;
	Wed,  4 Nov 2026 10:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IpZqNhtBALnNGTjI/c1EKaHLXSiFxKsryIlcYl/UPmk=;
	b=sdY5J2Uun7po4vrmKTXXiGX7x/7lJS7SyfueBZqh5mB/Xhz5c8t5cY6NbQhWF+ltRQX/8L
	TTMWHCbsvPtGg098VHAg5PWCUpFmvMMqYkqyDxSpKIbS+ugi4Hdq/xasLDoYhgznb4WmN9
	HVloB1io6F/E25wEFRlj419UT+O7uBzE35mxSCLQCVMTYofVwp8+ShuWwW2QFUAEQqk0c1
	iFvm/fNOydTi5ag6WT0qPcBgHsckeHJt9Xvr4x3bQtuZegMkAtvEIYd65LP4/HoxihudLL
	770BiFssMrKJX9N/p6XHt/gUZe3FtXgeWrN4L+ojiWsovoRUu+Y/GnWxzkiUpg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 04 Nov 2026 10:32:15 +0100
Subject: [PATCH yocto-autobuilder2 4/5] releaseselector: Fix checkbox
 filling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-mathieu-release-selector-fix-v1-4-a245895c0093@bootlin.com>
References: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
In-Reply-To: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=1052;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=mRCVCNPjFed7FTebkmysvlRyyWZDLfcuuiJTtDabI4o=;
 b=qCFqr1ctiwebLrieYz21NnbzimCiDJ3dgc0KP5wEjBPmLhB2Z9XOzDmQxT24dYrj98PlfpbwH
 duBLsPivz8yBKIE37VX8M6IxBbDX6skVBhVrybo0Iu7Y8ZzPNYEeHI6
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5229

Set element.checked for checkboxes and dispatch a change event so the
form picks the new value.

[YOCTO #16291]

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index 1d82310da261..1c4d289af224 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -182,6 +182,11 @@ buildbotSetupPlugin((reg) => {
 	const UIValue = Symbol('Displayed value in UI');
 	async function setFieldValue(element, value) {
 		element.focus();
+		if (element.type == 'checkbox') {
+			element.checked = !!value;
+			element.dispatchEvent(new Event('change', {bubbles: true}));
+			return;
+		}
 		element[UIValue] = value;
 		element.value = Object.assign(new String(value), {
 			[UIValue]: true

-- 
2.47.3

