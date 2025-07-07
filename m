Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EDFC83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web11.217.1751897146320520122
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=K5wpQXPW;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF7ED4423E;
	Mon,  7 Jul 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+rh5TBkf0Axx3MtvjQyiG3XLx58REuQCscOUSEOd7o=;
	b=K5wpQXPWzA/NQUUa8jKrymY1DbywBjKYygS4bjppYGJ5++zmfDvqxPoR+p5y/KREeKd7kQ
	8lllE/QvupbVTru+CQBMfvimuNjg4xJOyiqaBStd6cvs0TdUqtlU6iI1EtShngFEj2N3aq
	zWykEWWW7ZsRzu/QvDyh9Py5vssdoqb2W0tk5byb5+afD+6W2B6EmMxrZZqlpJtm0b4e0C
	QSsU1MNt+cC9eepB5qjBWD9yqD4sQLPRCo6VVlgzS8TYMWLu4VnTC2go5hyAW9GGnXwYWa
	sFX7BXpgRovII8Gq7MwHcFcZ7EBU+juZ/lR8q7qjhnOBXPAq9SMgpGEJDGqqPg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 07 Jul 2025 16:05:27 +0200
Subject: [PATCH yocto-autobuilder2 5/5] yocto_console_view: Sort build
 bullets by build id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-contrib-mathieu-popup_title-v1-5-d683ba953b96@bootlin.com>
References: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
In-Reply-To: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=1122;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=vmSPDLscvgGjMS8uhyWR2asSxp8U7xI4AeQreAzI2Rk=;
 b=2KJ3Bc7WkhIzjTD4+hMRUqlvtXauQTF+XIAdBcRGpWTn1VAwuJ7vTZS+8iVZpIzzGBQkI7Cf/
 fEtdgqUI1kcCQGW2UjUwKfwrJ9WDNnDyCB7liPepDDR0gOiR5fBbeud
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtt
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 14:05:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1775

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 1ee8b55b06fc..826ba2aec8bd 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -398,7 +398,8 @@ export const ConsoleView = observer(() => {
       const buildLinks: NodeListOf<Element>[] = [];
       for (const builder of builderGroup.builders) {
         const builderBuilds = changeInfo.buildsByBuilderId.get(builder.builderid) ?? []
-        for (const build of builderBuilds) {
+        const sortedBuilderBuilds = builderBuilds.sort((b1, b2) => b1.buildid - b2.buildid);
+        for (const build of sortedBuilderBuilds) {
           buildLinks.push(
             <span title={builder.name}>
               <BuildLinkWithSummaryTooltip key={build.buildid} build={build}/>

-- 
2.39.5


