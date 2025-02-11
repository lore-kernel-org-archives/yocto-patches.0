Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5109DC021A0
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 14:48:43 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.736.1739285322041340536
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 06:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DGORN9z6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 722E6204A1;
	Tue, 11 Feb 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739285320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htg2eqHjeeEZxD8j3JTkB5YHtrJSCKpp0XoySjd+WSg=;
	b=DGORN9z64ob2H0VliqEyMKSIfXp/hZqdkHl7anWpSd2v/envIsme4pKGQEohOMxgA7ar8N
	3UMLxfvJdHTwg8m3IvxmdmXoyAxBWLjn1p/QXlcN6JNtHyicpgentWN1vmgd4Qd1lpDSPA
	h9ep8U7gQkDyCobR4+4HWcpKkSyzAXxngJ7yOmxgFM1nuk8exQVElEtQWEjqSTqPsC+Oej
	1280PTNAab4bRQ6Rp35ZOde1w3fMp+wDcriJxN1beYGARFTwmwH119zYwL20hKr3VZ4g7T
	E2o8UtH9LBRJDq+Z/SsTSC03WVhk/LQcHj+hJmXOqkOJC740AtYQgRjHdklSsQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 11 Feb 2025 15:48:19 +0100
Subject: [PATCH yocto-autobuilder2 2/3] yocto_console_view: Keep known
 revision mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-mathieu-console_view_colspan-v1-2-d94a8c55acf9@bootlin.com>
References: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
In-Reply-To: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739285319; l=2370;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=OuXNoxCPWgbj9abT0tsVS6QDbJnwi3uBq69tBSG12vI=;
 b=ovLhYMv31qyY125ccWwzSy79IzvnC2vITi1BKTb/JxNVHn0MbVgjxxkerh4+GjlUQumTnDzQ/
 kgNKazKN1dRBFP9B2n5qhoLXH8rs/WGjJlJfwlOuuSPu8TtCgjEk/ik
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1053

The yp_build_revision property disappears from the build instance once
the build is done. There is no reason for its value to change, so keep
the last seen value in revision mapping. This will prevent finished
builds to jump back to "Unresolved Revision".

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.tsx          | 25 +++-------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 973c26424233..93c51b340b17 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -208,6 +208,9 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
   return fakeChange
 }
 
+const revMapping = new Map<int, string>();
+const branchMapping = new Map<int, string>();
+
 export const ConsoleView = observer(() => {
   const accessor = useDataAccessor([]);
 
@@ -263,8 +266,6 @@ export const ConsoleView = observer(() => {
     builderIdsWithBuilds.add(build.builderid);
   }
 
-  const revMapping = new Map<int, string>();
-  const branchMapping = new Map<int, string>();
   for (const build of buildsQuery.array) {
     let change = false;
     let {
@@ -278,26 +279,6 @@ export const ConsoleView = observer(() => {
       branchMapping[build.buildid] = build.properties.yp_build_branch[0];
       change = true;
     }
-    if ((!revMapping[buildid] || !branchMapping[buildid]) && !build.complete_at) {
-      build.getProperties().onChange = properties => {
-        change = false;
-        buildid = properties.endpoint.split('/')[1];
-        if (!revMapping[buildid]) {
-          const rev = getBuildProperty(properties[0], 'yp_build_revision');
-          if (rev != null) {
-            revMapping[buildid] = rev;
-            change = true;
-          }
-        }
-        if (!branchMapping[buildid]) {
-          const branch = getBuildProperty(properties[0], 'yp_build_branch');
-          if (branch != null) {
-            branchMapping[buildid] = branch;
-            change = true;
-          }
-        }
-      };
-    }
   }
 
   function getBuildProperty(properties, property) {

-- 
2.39.5


