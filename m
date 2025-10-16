Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE97CCD19F
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:33 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.8314.1760620823525078914
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=KozXUlEm;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3B86E1A142E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12D056062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60A24102F22FC;
	Thu, 16 Oct 2025 15:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ciJYUnNVBnwQYblvfgZdfAmVbE5g2VTu+UeliIGysqA=;
	b=KozXUlEmZ8RGPgJ8LAZGs5OK8tdZlo6mZhCRgk1MS1eRXy4+kyo/fm/8Q372agjaP22bhS
	6FzwktoaumDXRvH5GUB4E07kOHJF885oHx/HWJb1GkbmQ8508yRd9x5aEiJdMBSeYUyGQ1
	52C7c6/UtMDbjDV7H8Nif92WfYGMX3hMXAf7ZN9h3HAKVdQXoW8Ap4tjIXxrufcG/kwZH2
	M17JjNopKQNrb5GWfgXsx51dpQSUix8rMvJPzV4FmKoXOAmGAjyvDx2mvl2sv+3+ULWV+8
	LfECBVCOTd/JebEKyzLCjrFP6nETeJ+mADnLzCaJk0VOSmR0Jagstuz/y9HyXw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:17 +0200
Subject: [PATCH yocto-autobuilder2 v2 6/6] yocto_console_view: Allow to
 link commits in alternate repos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-6-095908455e0b@bootlin.com>
References: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=4891;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=3GcO1u4WyYPH1k5Z2LhhphyddsKwJuQxsHhtK5AO4IQ=;
 b=kqMOKv/KT+rEPsj09OjYfk6anQtCt8U3+llmbL46DvcN5z1dxgFcPBGBWJMJJTI7ktkc3Us+4
 SHbQmwC1U9kAAvNilI1y+wLALkJ12NIP+T8uu5EiXU7wnLnMvBfU0rZ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2319

Instead of always looking for commits in main repos, use values provided
int the "repo_*" build properties. Make sure to use https protocol.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.tsx          | 38 +++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 19b24d1a0427..16569ea9eac8 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -149,6 +149,22 @@ function resolveFakeChange(revision: string, whenTimestamp: number, comment: str
   return newChange;
 }
 
+const gitHostAliases = new Map([
+       ["push.yoctoproject.org", "git.yoctoproject.org"],
+       ["push.openembedded.org", "git.openembedded.org"],
+]);
+
+function getHttpURL(url)
+{
+       let u = new URL(url.replace(RegExp("^[a-z]*://"), "https://"));
+       u.username = "";
+       if (gitHostAliases.has(u.host)) {
+               u.host = gitHostAliases.get(u.host)
+       }
+
+       return u.toString();
+}
+
 // Adjusts changesByFakeId for any new fake changes that are created
 function selectChangeForBuild(build: Build, buildset: Buildset,
                               changesBySsid: Map<number, ChangeInfo>,
@@ -161,15 +177,25 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
     let revision;
     let change = undefined;
     let oecore_revision = undefined, bitbake_revision = undefined;
+    let oecore_repo = undefined, bitbake_repo = undefined, poky_repo = undefined;
     let use_bitbake_setup = false;
     if (build.properties !== null && ('yp_build_revision' in build.properties)) {
       revision = build.properties['yp_build_revision'][0];
       if ('commit_oecore' in build.properties) {
         oecore_revision = build.properties['commit_oecore'][0];
       }
+      if ('repo_oecore' in build.properties) {
+        oecore_repo = build.properties['repo_oecore'][0];
+      }
       if ('commit_oecore' in build.properties) {
         bitbake_revision = build.properties['commit_bitbake'][0];
       }
+      if ('repo_bitbake' in build.properties) {
+        bitbake_repo = build.properties['repo_bitbake'][0];
+      }
+      if ('repo_poky' in build.properties) {
+        poky_repo = build.properties['repo_poky'][0];
+      }
       if ('use_bitbake_setup' in build.properties) {
         use_bitbake_setup = build.properties['use_bitbake_setup'][0];
       }
@@ -194,16 +220,20 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
         change.change.caption = branchMapping[build.buildid];
       }
 
+      oecore_repo = getHttpURL(oecore_repo);
+      bitbake_repo = getHttpURL(bitbake_repo);
+      poky_repo = getHttpURL(poky_repo);
+
       if (!use_bitbake_setup) {
-        change.change.poky_revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + revision;
+        change.change.poky_revlink = poky_repo + "/commit/?id=" + revision;
         change.change.poky_revision = revision;
         change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
       } else {
         // We might retrieve the "use_bitbake_setup" after the first execution, so wrong poky data might have been added: remove them.
         change.change.poky_revlink = change.change.poky_revision = undefined;
 
-        change.change.oecore_revlink = "https://git.openembedded.org/openembedded-core/commit/?id=" + oecore_revision;
-        change.change.bitbake_revlink = "https://git.openembedded.org/bitbake/commit/?id=" + bitbake_revision;
+        change.change.oecore_revlink = oecore_repo + "/commit/?id=" + oecore_revision;
+        change.change.bitbake_revlink = bitbake_repo + "/commit/?id=" + bitbake_revision;
         change.change.oecore_revision = oecore_revision;
         change.change.bitbake_revision = bitbake_revision;
         change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + oecore_revision + "&type=commit&limit=150";
@@ -267,7 +297,7 @@ export const ConsoleView = observer(() => {
   const buildsQuery = useDataApiQuery(() => Build.getAll(accessor, {query: {
       limit: buildFetchLimit,
       order: '-started_at',
-      property: ["yp_build_revision", "yp_build_branch", "commit_oecore", "commit_bitbake", "reason", "publish_destination", "use_bitbake_setup"],
+      property: ["yp_build_revision", "yp_build_branch", "repo_poky", "repo_oecore", "commit_oecore", "repo_bitbake", "commit_bitbake", "reason", "publish_destination", "use_bitbake_setup"],
     }}));
 
   const windowSize = useWindowSize()

-- 
2.47.3


