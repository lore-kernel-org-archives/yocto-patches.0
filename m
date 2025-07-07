Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DFC83F0F
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.219.1751897146068876430
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WmEEbhmk;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CDA344278;
	Mon,  7 Jul 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHmJYZX/s7F3iPKa+WziWUuE+E8qZBgVZuz+TBJcNow=;
	b=WmEEbhmk8FyqkphS6D7uE1znSM+EA3gEQK7i66B720643NhyqlBvyGyDPMtoejj/EOUG/m
	paPpBdRM8RmCdKNmrR7caxwcWaIMfiS/ciS/ZgvNe8Dh9R3KPo4Wcd2e0lrPPAfAsQDjgF
	jZeCOVSe5YQ2+k69r7LWni01sxutvkXlirfuagqL7ct1293kRTaw807CA16b53Yq/wagDo
	s7Ky+LlxYMXESR9UrBwNxbEoUybEYLFYDIqRWgyZJS5obGnutq2GDgfkuax3ctPOHkVxb6
	3WPHf03kETSHJXnKC4nWhgqyOSyqNd1A9Ui8Vp+spJxpTz2QUT+022J9sxm2/A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 07 Jul 2025 16:05:26 +0200
Subject: [PATCH yocto-autobuilder2 4/5] yocto_console_view: Fix build
 bullets title
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-contrib-mathieu-popup_title-v1-4-d683ba953b96@bootlin.com>
References: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
In-Reply-To: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=1736;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=9sMDYqxffaj8aTUkEdjL5/tFdmM+g6GzsFUDMGxdPyU=;
 b=aP8KW0QZpQJb5WghATi3osS245H9AAltf5S68/sAn2jWPmwfHzBc0noxjGiCIJURAdyrLNkUJ
 ZQ2zoiStW/qAezN1K7ZCBsyNZxyvDdJ8+mNeBsNSiSYh6TE+qvTkfaT
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1774

Fix an issue where the browser pop-up label was the same for all build
of a builders group.

Fixes [YOCTO #15911]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index a1a338684fd6..1ee8b55b06fc 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -395,16 +395,19 @@ export const ConsoleView = observer(() => {
     const change = changeInfo.change;
 
     const builderColumns = builderGroups.map((builderGroup, i) => {
-      const builds: Build[] = [];
+      const buildLinks: NodeListOf<Element>[] = [];
       for (const builder of builderGroup.builders) {
         const builderBuilds = changeInfo.buildsByBuilderId.get(builder.builderid) ?? []
-        builds.push(...builderBuilds);
+        for (const build of builderBuilds) {
+          buildLinks.push(
+            <span title={builder.name}>
+              <BuildLinkWithSummaryTooltip key={build.buildid} build={build}/>
+            </span>
+          );
+        }
       }
-      const buildLinks = builds.map(build => (
-        <BuildLinkWithSummaryTooltip key={build.buildid} build={build}/>
-      ));
       return (
-        <td key={i} title={builderGroup.name} colSpan={builderGroup.colspan} className="column">
+        <td key={i} colSpan={builderGroup.colspan} className="column">
           {buildLinks}
         </td>
       );

-- 
2.39.5


