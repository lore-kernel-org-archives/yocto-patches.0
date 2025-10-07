Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F6CCD187
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20403.1759847848118835825
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=HrHuJ4jx;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CB4801A1167
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4434606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78F1B102F2167;
	Tue,  7 Oct 2025 16:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yB+ANRchbSeFwISRo31WdrNP+sShEiEaGE0sLCEor04=;
	b=HrHuJ4jxd4OLkNvmoyMD96Ji71fJQb1EHBrjDBAf9uv0mWLZCHbkDAF8yDQogW9Ojhc8ol
	ViBBOTCgcUZlYhZXopClx9dPxfPyyjsStshB11EEelXApgUQ88N2Sh6WPvky9Le+XxGGlH
	qIKqXsLnwRXK29fEuFXP/IGxczusZrIP0iwU8ZfuLkRTA/cqnNT/GH5QU1HSOifjrXfPQy
	IE+rCx9Dv4O7Q4yhORLNEAzcVDwPNKUPTo0RT9pvg1mhx1bmButpQPWxHpRsm85LvyCJyT
	lNa67h+w/XGAANv5Vpj8Wh308UQh/jR9wnNJsrNetND7C9XWOX0/TznpgEZHuw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:22 +0200
Subject: [PATCH yocto-autobuilder2 06/10] yocto_console_view: fix commit
 links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-6-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=6753;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=eecZ2wnAAo4+keyYCyd4x561tHopeQnxPBwj4EEBKOc=;
 b=2Os+UDbQ8duoAlcCnvMWtu6/O0X1mke/JTzJRovb/ipkqjA/XZ20uD/HZip0t0dTc5WGKkDrC
 vIue/l7ATGyD6nU9appVp/cABIoReo6Y8+fn89fa7qwurEgUSMZv88x
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2282

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.tsx          | 37 +++++++++++++++---
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   | 44 +++++++++++++++++-----
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 826ba2aec8bdc775e7365c987284a82628c0db1a..dd84c7913cdab3ae3e4537e4b00d0fb077be4b71 100644
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
index 37670de255c96efb7135c9eb2ef8f4847a627222..18a74cf170034b4eda6a30b0bd3f484fa686e7a9 100644
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


