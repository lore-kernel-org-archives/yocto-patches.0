Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF7D2F7CC
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 09:46:40 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2104.1764927991054353274
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 01:46:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Jd4iG30S;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 32750C1964C
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Dec 2025 09:46:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1AE460731
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Dec 2025 09:46:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50C3310B60661;
	Fri,  5 Dec 2025 10:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764927988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QpwoStgYoDGxHXIkGdOPIrIXkLfMMDHn1/TIEMKQN58=;
	b=Jd4iG30SdoxL7PjQPGrgrF/CYbUkBA2yeBDxPLSuxhVjLrf4gSTWeNvZ2smp3Fxz1A3ynU
	iMdPu3sSPesgshU/d0P1HZpTbG6cnae9S/NOYqYCIlkqaiNObXZyhzmmfWqLnsXYP3gWgf
	+R7wVPosT7UkaxmMJAGvotE2bw7TG7k0FlRJDAKXDa57KrwUvl43Npb8mMyeps3LeQLgvj
	L3WAWoxhuPiKqNTAkT9jpYbiupSu2EpBwey9LPz6TpugWatjBQTyz5x69VHLdFwo2KLGlZ
	GT9DGKLS5KxZXd/zERxaAXM5geKEKbI7N/JBUCZA2GhknUFN1vdfUwSN9klVnw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 05 Dec 2025 10:46:07 +0100
Subject: [PATCH yocto-autobuilder2] yocto_console_view: Show branch names
 instead of build caption
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-mathieu-console-link-names-v1-1-3827363bf8f5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAN+pMmkC/x3MSwrCMBAA0KuUWTvQJgY/V5EuYjq1g+mM5CNK6
 d0NLt/mbZApMWW4dhskenNmlYbh0EFYvDwIeWoG0xs3mN7h6svCVDGoZI2EkeWJ4lfKaMNsj/Z
 CZ3ciaMEr0cyff36Dr4ai6GvRe+U4UTIw7vsPvLev0oAAAAA=
X-Change-ID: 20251205-mathieu-console-link-names-3cf3439e857e
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764927987; l=3963;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=qHw5RvM6Zycf3s1NCRzLiPxIosCaNRtOFvuglgbdbEw=;
 b=4DSlL/59QdgX/vh9hdbiMpFTKef69wnpLql/ZMvgEGeXs2m6WDUP7qhurl7qSjFH9QfuIsMYQ
 e99SelrzbgUDA5xOeeFOISPeHq7dPwxzLbrwll5TBlQ2W9BxQLq0yKU
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 09:46:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2738

Build caption is set to oe-core build branch by yocto-autobuilder-helper
scripts. Today we are using this caption to describe all branches on the
console view, but some repos might use other branches.

Explicitly use oe-core and bitbake branch names instead.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx       | 10 +++++++++-
 .../src/views/ConsoleView/YoctoChangeDetails.tsx               |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 14276ce92da9..28bfca376f54 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -138,6 +138,8 @@ function resolveFakeChange(revision: string, whenTimestamp: number, comment: str
       poky_revision: revision,
       oecore_revision: null,
       bitbake_revision: null,
+      oecore_branch: null,
+      bitbake_branch: null,
       poky_revlink: null,
       oecore_revlink: null,
       bitbake_revlink: null,
@@ -253,6 +255,12 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
         change.change.publishurl = change.change.publishurl.replace("/srv/autobuilder/autobuilder.yocto.io/", "https://autobuilder.yocto.io/");
         change.change.publishurl = change.change.publishurl.replace("/srv/autobuilder/valkyrie.yocto.io/", "https://valkyrie.yocto.io/");
       }
+      if ('branch_oecore' in build.properties) {
+        change.change.oecore_branch = build.properties['branch_oecore'][0];
+      }
+      if ('branch_bitbake' in build.properties) {
+        change.change.bitbake_branch = build.properties['branch_bitbake'][0];
+      }
     }
 
     return change;
@@ -299,7 +307,7 @@ export const ConsoleView = observer(() => {
   const buildsQuery = useDataApiQuery(() => Build.getAll(accessor, {query: {
       limit: buildFetchLimit,
       order: '-started_at',
-      property: ["yp_build_revision", "yp_build_branch", "repo_poky", "repo_oecore", "commit_oecore", "repo_bitbake", "commit_bitbake", "reason", "publish_destination", "use_bitbake_setup"],
+      property: ["yp_build_revision", "yp_build_branch", "repo_poky", "repo_oecore", "commit_oecore", "branch_oecore", "repo_bitbake", "commit_bitbake", "branch_bitbake", "reason", "publish_destination", "use_bitbake_setup"],
     }}));
 
   const windowSize = useWindowSize()
diff --git a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
index 18a74cf17003..f703b44a5530 100644
--- a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
+++ b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
@@ -137,12 +137,12 @@ export const YoctoChangeDetails = observer(({change, compact, showDetails, setSh
               change.poky_revlink
               ? <a href={change.poky_revlink}>{change.caption} (poky)</a>
               : change.oecore_revlink
-                ? <a href={change.oecore_revlink}>{change.caption} (oe-core)</a>
+                ? <a href={change.oecore_revlink}>{change.oecore_branch ? change.oecore_branch : change.caption} (oe-core)</a>
                : <span>{change.caption}</span>
             }
             {
               change.bitbake_revlink
-              ? <a href={change.bitbake_revlink}>{change.caption} (bitbake)</a>
+              ? <a href={change.bitbake_revlink}>{change.bitbake_branch ? change.bitbake_branch : change.caption} (bitbake)</a>
               : <></>
             }
             {

---
base-commit: e8c4db23afb334de278f3c5c7800c33fe32f7438
change-id: 20251205-mathieu-console-link-names-3cf3439e857e

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


