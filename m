Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C4CCD19F
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.8265.1760620821219896917
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dmtJg43D;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E499A1A142F
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B4ED96062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE47C102F2304;
	Thu, 16 Oct 2025 15:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=73TFVuZ7uT3VdzKOB0NpQ4PibBCG8k4qYqJlwVPWmOg=;
	b=dmtJg43Ds1kxHRPSkCijF8BsRyqrtkWHULnzJYZ0hOC5/t37Z7hq8G/YstiJI5FlVsRH9X
	WPaGxb77qaD3xfOf4n3e4nmCX/dLDHYH/vQPbPW3wr5Yo+W+yLD6xANUu9lKFKfZshigWc
	N4pUYySvCc4b3/gdOH/jwF2PE6jXojjZ6vqLOj/Y/u/R3QHDZG8AuEwhXvYuc/z5bv5YFJ
	K7siwX+nJ60UXg8hQFiRiHzgd0M1ElzDLxycKRgy/dWk6PIZFs/Pmx63O3EDgSmdfrBdCy
	z+OEOks9pHMXbjiOEIGEplOcZYomf0U8243LacsE/XQdvMIHIuaLBGmOeRwnRA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:13 +0200
Subject: [PATCH yocto-autobuilder2 v2 2/6] yocto_console_view: fix commit
 links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-2-095908455e0b@bootlin.com>
References: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=6641;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=gH+qaY/WQa0PQVWWYkpRubRroJ+ePxCzA3CeqkyyCLo=;
 b=wefQLCF2FSMVE6fNoHgmu7ukp8PQq4JYlL6zBoFj+nDxVKwdB5YLBmKKuw0EJJpK7QSJXIDa1
 DRLHZEk/DJYBlTCV1eSp72AqHB4vuYquGYT1NIpY8tKpV4CxfACEX2z
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2315

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.tsx          | 37 +++++++++++++++---
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   | 44 +++++++++++++++++-----
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 826ba2aec8bd..dd84c7913cda 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -125,7 +125,7 @@ function resolveFakeChange(revision: string, whenTimestamp: number, comment: str
   }
 
   const newChange = {
-    change: new Change(undefined as unknown as IDataAccessor, "a/1", {
+    change: new Change(undefined as unknown as IDataAccessor, {
       changeid: revision,
       author: "",
       branch: "",
@@ -135,8 +135,12 @@ function resolveFakeChange(revision: string, whenTimestamp: number, comment: str
       project: "",
       properties: {},
       repository: "",
-      revision: revision,
-      revlink: null,
+      poky_revision: revision,
+      oecore_revision: null,
+      bitbake_revision: null,
+      poky_revlink: null,
+      oecore_revlink: null,
+      bitbake_revlink: null,
       when_timestamp: whenTimestamp,
     }),
     buildsByBuilderId: new Map<number, Build[]>
@@ -156,8 +160,19 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
   if ((build.properties !== null && ('yp_build_revision' in build.properties))  || (build.buildid in revMapping)) {
     let revision;
     let change = undefined;
+    let oecore_revision = undefined, bitbake_revision = undefined;
+    let use_bitbake_setup = false;
     if (build.properties !== null && ('yp_build_revision' in build.properties)) {
       revision = build.properties['yp_build_revision'][0];
+      if ('commit_oecore' in build.properties) {
+        oecore_revision = build.properties['commit_oecore'][0];
+      }
+      if ('commit_oecore' in build.properties) {
+        bitbake_revision = build.properties['commit_bitbake'][0];
+      }
+      if ('use_bitbake_setup' in build.properties) {
+        use_bitbake_setup = build.properties['use_bitbake_setup'][0];
+      }
     } else {
       revision = revMapping[build.buildid];
     }
@@ -178,7 +193,19 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
       if (build.buildid in branchMapping) {
         change.change.caption = branchMapping[build.buildid];
       }
-      change.change.revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + revision;
+
+      if (!use_bitbake_setup) {
+        change.change.poky_revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + revision;
+        change.change.poky_revision = revision;
+      } else {
+        // We might retrieve the "use_bitbake_setup" after the first execution, so wrong poky data might have been added: remove them.
+        change.change.poky_revlink = change.change.poky_revision = undefined;
+
+        change.change.oecore_revlink = "https://git.openembedded.org/openembedded-core/commit/?id=" + oecore_revision;
+        change.change.bitbake_revlink = "https://git.openembedded.org/bitbake/commit/?id=" + bitbake_revision;
+        change.change.oecore_revision = oecore_revision;
+        change.change.bitbake_revision = bitbake_revision;
+      }
       change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
 
       let bid = build.buildid;
@@ -239,7 +266,7 @@ export const ConsoleView = observer(() => {
   const buildsQuery = useDataApiQuery(() => Build.getAll(accessor, {query: {
       limit: buildFetchLimit,
       order: '-started_at',
-      property: ["yp_build_revision", "yp_build_branch", "reason", "publish_destination"],
+      property: ["yp_build_revision", "yp_build_branch", "commit_oecore", "commit_bitbake", "reason", "publish_destination", "use_bitbake_setup"],
     }}));
 
   const windowSize = useWindowSize()
diff --git a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
index 37670de255c9..18a74cf17003 100644
--- a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
+++ b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
@@ -70,16 +70,33 @@ export const YoctoChangeDetails = observer(({change, compact, showDetails, setSh
             </tr>
             : <></>
           }
-          <tr>
-            <td>Revision</td>
+          { change.poky_revlink
+          ? <tr>
+            <td>poky revision</td>
             <td>
-            {
-              change.revlink
-              ? <a href={change.revlink}>{change.revision}</a>
-              : <></>
-            }
+              <a href={change.poky_revlink}>{change.poky_revision}</a>
+            </td>
+          </tr>
+          : <></>
+          }
+          { change.oecore_revlink
+          ? <tr>
+            <td>openembedded-core revision</td>
+            <td>
+              <a href={change.oecore_revlink}>{change.oecore_revision}</a>
             </td>
           </tr>
+          : <></>
+          }
+          { change.bitbake_revlink
+          ? <tr>
+            <td>bitbake revision</td>
+            <td>
+              <a href={change.bitbake_revlink}>{change.bitbake_revision}</a>
+            </td>
+          </tr>
+          : <></>
+          }
         </tbody>
       </Table>
       <h5>Comment</h5>
@@ -117,9 +134,16 @@ export const YoctoChangeDetails = observer(({change, compact, showDetails, setSh
                         overlay={popoverWithText("comments-" + change.id, change.caption)}>
           <React.Fragment>
             {
-              change.revlink
-              ? <a href={change.revlink}>{change.caption}</a>
-              : <span>{change.caption}</span>
+              change.poky_revlink
+              ? <a href={change.poky_revlink}>{change.caption} (poky)</a>
+              : change.oecore_revlink
+                ? <a href={change.oecore_revlink}>{change.caption} (oe-core)</a>
+               : <span>{change.caption}</span>
+            }
+            {
+              change.bitbake_revlink
+              ? <a href={change.bitbake_revlink}>{change.caption} (bitbake)</a>
+              : <></>
             }
             {
               change.errorlink

-- 
2.47.3


