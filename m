Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8BC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 14:48:43 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.675.1739285322097864673
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 06:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=flLbZdZu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42E5A20457;
	Tue, 11 Feb 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739285320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JVPgPbiPl1FJYt6pwGT0lzr+bGaYJRrO8R9Mx+WOxI=;
	b=flLbZdZuTciMJ1l5pLqURXknmWFdjSMPLhjW0vp4kP82Mtf+JA3nwUaZPx2y/LTXTfIrC7
	LRFsAe5PbwBPjMp7lEuK61drdzgEfpf8+kARp4n3DlvxEIU15OQn4BNq5RIzFLw+5Y8Q2B
	DhOpWxIG+qfaEQlLP/BnpRvmxCoLmhDjLNYQWCYjqya69q3vfi25aoiA71WyxLoERNVetp
	/fu3/6gkAEpfnfkosid88s9o5VRI7Npa7zgF0dJ0nwyAoeP0D4030gLVJYls8tD8+4NShO
	XMemFl0glMFVzR3cSQeUmU1Lsvuy13DwLqz8TPbOxlkuutNnqhrgZg7hvBatBw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 11 Feb 2025 15:48:18 +0100
Subject: [PATCH yocto-autobuilder2 1/3] yocto_console_view: Group similar
 builder builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-mathieu-console_view_colspan-v1-1-d94a8c55acf9@bootlin.com>
References: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
In-Reply-To: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739285319; l=2288;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=MK+UzFLpV1mruPBBvwXtaCqnsSadN7/9uQ92O7mjhp4=;
 b=Y1LNo1GNtusav5TNGjkbbwg1xSVLaGXn5Z6NoiYZUueV4t2rL+J3lBvTXPBJimjsps/OmH1O6
 idcDW88g1IoDcLT1IFThrsYbBarkAfKz784fb6J1sIXHM03qxrBTMXv
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgto
 hhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 14:48:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1054

Builds from similar builders have to be in the same <td>, compacting a
bit the whole view.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.scss |  2 +-
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx  | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
index a3421d9742f0..7969b229706c 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
@@ -17,7 +17,7 @@ tr.bb-console-table-first-row {
   font-size: 1em;
   width: 1.5em;
   text-align: center;
-  transform: rotate(-45deg) translate(.5em, 1em);
+  transform: rotate(-45deg) translate(-.2em, .8em);
   transform-origin: bottom left;
   text-decoration: none;
   white-space: nowrap;
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index a44be811caf9..973c26424233 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -412,14 +412,17 @@ export const ConsoleView = observer(() => {
   const changeRows = changesToShow.map(changeInfo => {
     const change = changeInfo.change;
 
-    const builderColumns = buildersToShow.map(builder => {
-      const builds = changeInfo.buildsByBuilderId.get(builder.builderid) ?? [];
+    const builderColumns = builderGroups.map((builderGroup, i) => {
+      const builds: Build[] = [];
+      for (const builder of builderGroup.builders) {
+        const builderBuilds = changeInfo.buildsByBuilderId.get(builder.builderid) ?? []
+        builds.push(...builderBuilds);
+      }
       const buildLinks = builds.map(build => (
         <BuildLinkWithSummaryTooltip key={build.buildid} build={build}/>
       ));
-
       return (
-        <td key={builder.name} title={builder.name} className="column">
+        <td key={i} title={builderGroup.name} colSpan={builderGroup.colspan} className="column">
           {buildLinks}
         </td>
       );

-- 
2.39.5


