Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65592C0219A
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.9392.1738752390509409849
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XFAkpKsl;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2B6A43433;
	Wed,  5 Feb 2025 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppPxwCA8nzmI5k+LG40d5F9f9fkhhNryUcSugd+76t8=;
	b=XFAkpKslv0oPbi+gVNFxdMuruJMSa8CwrWGwWd9Fikn0OhS3oVWmdN8aFGX/hEjHv+qhho
	ngQOcjTNFv/1uqNiwGoLUN2Ba5j5KQlL6OMCTt3+Slt1RXfbvc2rgOijWloxL0hCyHP+zx
	BWqif2vseB1JPZY+LcPKMOn1nIp3S8+CJc8WXLWdRB9yQGvxxB9Vz6/A7T6+XD11KIZMna
	SuXX58D3HD/IzArp5fdYSJq4YTxkdw3lM3wtxJLiw7GB+QRM13vIDiievmTUVQwteN2JeM
	r+coCevmc9er0OIK9xaKOyKQDHZPuzxxW7AjkpSTfC/IMefE+76DO/2GbQrufQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:45:53 +0100
Subject: [PATCH yocto-autobuilder2 3/4] yocto_console_view: create our own
 console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-console_view_upgrade-v1-3-fc1194355870@bootlin.com>
References: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
In-Reply-To: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752387; l=30382;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=lT9b3ys8fJEw4EjIwyUbrXb5L9spZHk/ByKvbZ2zUe4=;
 b=IPWsxRNivOHXvrazc/mZkjTMvENmiWTuFnFJnqqYGbdpDI7ed9NhgzcHEZs0StJnC+slTpls1
 9bC/tWUFlvxAlUnZT1mLaaTsZUdzUma/Gg3CgM0FnSA6tAWTvBFx8ZA
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptddtvdelffehgfeiveejgfetvdeutefhvdekjeeigffgueethfehvdefuedtgeegnecuffhomhgrihhnpegsuhhilhgusghothdrnhgvthdphihotghtohhprhhojhgvtghtrdhorhhgpdgssgdqtghonhhsohhlvgdqthgrsghlvgdqfhhirhhsthdqrhhofidrsggspdgthhhilhguihhtvghmshdrmhgrphdphihotghtohdrihhopdgthhgrnhhgvgdrrghuthhhohhrpdhfihhlvghsrdhmrghpnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhi
 hgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:46:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1034

Modify existing console view plugin to recreate our own console view.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../buildbot_console_view/__init__.py              |  19 --
 yocto_console_view/package.json                    |   6 +-
 yocto_console_view/setup.py                        |  14 +-
 .../src/views/ConsoleView/ConsoleView.scss         |  17 +-
 .../src/views/ConsoleView/ConsoleView.tsx          | 363 +++++++++------------
 .../src/views/ConsoleView/YoctoChangeDetails.scss  |  18 +
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   | 149 +++++++++
 yocto_console_view/vite.config.ts                  |   2 +-
 8 files changed, 352 insertions(+), 236 deletions(-)

diff --git a/yocto_console_view/buildbot_console_view/__init__.py b/yocto_console_view/buildbot_console_view/__init__.py
deleted file mode 100644
index b776b9b2ae02..000000000000
--- a/yocto_console_view/buildbot_console_view/__init__.py
+++ /dev/null
@@ -1,19 +0,0 @@
-# This file is part of Buildbot.  Buildbot is free software: you can
-# redistribute it and/or modify it under the terms of the GNU General Public
-# License as published by the Free Software Foundation, version 2.
-#
-# This program is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-# details.
-#
-# You should have received a copy of the GNU General Public License along with
-# this program; if not, write to the Free Software Foundation, Inc., 51
-# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Copyright Buildbot Team Members
-
-from buildbot.www.plugin import Application
-
-# create the interface for the setuptools entry point
-ep = Application(__package__, "Buildbot Console View plugin")
diff --git a/yocto_console_view/package.json b/yocto_console_view/package.json
index 5e05343c809e..7db4c6b76eb7 100644
--- a/yocto_console_view/package.json
+++ b/yocto_console_view/package.json
@@ -1,9 +1,9 @@
 {
-  "name": "buildbot-console-view",
+  "name": "yocto-console-view",
   "private": true,
   "type": "module",
-  "module": "buildbot_console_view/static/scripts.js",
-  "style": "buildbot_console_view/static/styles.css",
+  "module": "yocto_console_view/static/scripts.js",
+  "style": "yocto_console_view/static/styles.css",
   "scripts": {
     "start": "vite",
     "build": "vite build",
diff --git a/yocto_console_view/setup.py b/yocto_console_view/setup.py
index 02e44dc41216..604f4a50da30 100644
--- a/yocto_console_view/setup.py
+++ b/yocto_console_view/setup.py
@@ -28,12 +28,12 @@ except ImportError:
     sys.exit(1)
 
 setup_www_plugin(
-    name='buildbot-console-view',
-    description='Buildbot Console View plugin',
-    author='Pierre Tardy',
-    author_email='tardyp@gmail.com',
-    url='http://buildbot.net/',
-    packages=['buildbot_console_view'],
+    name='yocto-console-view',
+    description='Yocto Project Console View plugin.',
+    author=u'Richard Purdie',
+    author_email=u'richard.purdie@linuxfoundation.org',
+    url='http://autobuilder.yoctoproject.org/',
+    packages=['yocto_console_view'],
     package_data={
         '': [
             'VERSION',
@@ -43,7 +43,7 @@ setup_www_plugin(
     },
     entry_points="""
         [buildbot.www]
-        console_view = yocto_console_view:ep
+        yocto_console_view = yocto_console_view:ep
     """,
     classifiers=['License :: OSI Approved :: GNU General Public License v2 (GPLv2)'],
 )
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
index dabd8a48b608..a3421d9742f0 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
@@ -1,6 +1,11 @@
+$headcol-width: 20px;
 
 tr.bb-console-table-first-row {
-  background-color: #fff !important;
+  .column {
+    width: $headcol-width;
+    min-width: $headcol-width;
+    max-width: $headcol-width;
+  }
   th {
     border: none;
   }
@@ -12,8 +17,8 @@ tr.bb-console-table-first-row {
   font-size: 1em;
   width: 1.5em;
   text-align: center;
-  transform: rotate(-25deg) ;
-  transform-origin: 0% 100%;
+  transform: rotate(-45deg) translate(.5em, 1em);
+  transform-origin: bottom left;
   text-decoration: none;
   white-space: nowrap;
 }
@@ -36,3 +41,9 @@ tr.bb-console-table-first-row {
 .bb-console-changes-expand-icon {
   float: left;
 }
+
+.bb-console {
+  td.column {
+    padding: .2em;
+  }
+}
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index b747f6a41de3..a44be811caf9 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -41,6 +41,7 @@ import {
   pushIntoMapOfArrays,
   useWindowSize
 } from "buildbot-ui";
+import {YoctoChangeDetails} from './YoctoChangeDetails.tsx';
 
 type ChangeInfo = {
   change: Change;
@@ -53,152 +54,71 @@ export type TagTreeItem = {
   childItems: TagTreeItem[];
 }
 
-export type TagItemConfig = {
-  tag: string,
-  colSpan: number
+export type BuilderGroup = {
+  name: string;
+  tag: string;
+  builders: Builder[];
+  colspan: int;
 };
 
-export type TagLineConfig = TagItemConfig[];
-
-export function buildTagTree(builders: Builder[])
+// Sorts and groups builders together by their tags.
+export function getBuildersGroups(builders: Builder[]) : [Builder[], BuilderGroup[]]
 {
   const buildersByTags = new Map<string, Builder[]>();
   for (const builder of builders) {
-    if (builder.tags === null) {
+    if (builder.name === "indexing") {
       continue;
     }
-    for (const tag of builder.tags) {
-      pushIntoMapOfArrays(buildersByTags, tag, builder);
-    }
-  }
-
-  type TagInfo = {
-    tag: string;
-    builders: Builder[];
-  };
-
-  const undecidedTags: TagInfo[] = [];
-  for (const [tag, tagBuilders] of buildersByTags) {
-    if (tagBuilders.length < builders.length) {
-      undecidedTags.push({tag: tag, builders: tagBuilders});
-    }
-  }
-
-  // sort the tags to first look at tags with the larger number of builders
-  // @FIXME maybe this is not the best method to find the best groups
-  undecidedTags.sort((a, b) => b.builders.length - a.builders.length);
-
-  const tagItems: TagTreeItem[] = [];
-  const builderIdToTag = new Map<number, string>();
-
-  // pick the tags one by one, by making sure we make non-overalaping groups
-  for (const tagInfo of undecidedTags) {
-    let excluded = false;
-    for (const builder of tagInfo.builders) {
-      if (builderIdToTag.has(builder.builderid)) {
-        excluded = true;
-        break;
-      }
-    }
-    if (!excluded) {
-      for (const builder of tagInfo.builders) {
-        builderIdToTag.set(builder.builderid, tagInfo.tag);
+    if ((builder.tags !== null) && (builder.tags.length != 0)) {
+      for (const tag of builder.tags) {
+        pushIntoMapOfArrays(buildersByTags, tag, builder);
       }
-      tagItems.push({tag: tagInfo.tag, builders: tagInfo.builders, childItems: []});
+    } else {
+      pushIntoMapOfArrays(buildersByTags, '', builder);
     }
   }
 
-  // some builders do not have tags, we put them in another group
-  const remainingBuilders = [];
-  for (const builder of builders) {
-    if (!builderIdToTag.has(builder.builderid)) {
-      remainingBuilders.push(builder);
+  const buildersGroups: BuilderGroup[] = [];
+  for (const [tag, builders] of buildersByTags) {
+    builders.sort((a, b) => a.name.localeCompare(b.name));
+    if (tag !== '') {
+      buildersGroups.push({
+        name: builders[0].name,
+        tag: tag,
+        builders: builders,
+        colspan: builders.length
+      });
     }
   }
-
-  if (remainingBuilders.length) {
-    tagItems.push({tag: "", builders: remainingBuilders, childItems: []});
-  }
-
-  // if there is more than one tag in this line, we need to recurse
-  if (tagItems.length > 1) {
-    for (const tagItem of tagItems) {
-      tagItem.childItems = buildTagTree(tagItem.builders);
+  if (buildersByTags.has('')) {
+    const builders = buildersByTags.get('');
+    builders.sort((a, b) => a.name.localeCompare(b.name));
+    for (const builder of builders) {
+      buildersGroups.push({
+        name: builder.name,
+        tag: '',
+        builders: [builder],
+        colspan: 1
+      });
     }
   }
-  return tagItems;
-}
 
-// Sorts and groups builders together by their tags.
-export function sortBuildersByTags(builders: Builder[]) : [Builder[], TagLineConfig[]]
-{
-  // we call recursive function, which finds non-overlapping groups
-  const tagLineItems = buildTagTree(builders);
-
-  // we get a tree of builders grouped by tags
-  // we now need to flatten the tree, in order to build several lines of tags
-  // (each line is representing a depth in the tag tree)
-  // we walk the tree left to right and build the list of builders in the tree order, and the tag_lines
-  // in the tree, there are groups of remaining builders, which could not be grouped together,
-  // those have the empty tag ''
-  const tagLineConfigAtDepth = new Map<number, TagLineConfig>();
-
-  const resultBuilders: Builder[] = [];
-
-  const setTagLine = (depth: number, tag: string, colSpan: number) => {
-    const lineConfig = tagLineConfigAtDepth.get(depth);
-    if (lineConfig === undefined) {
-      tagLineConfigAtDepth.set(depth, [{tag: tag, colSpan: colSpan}]);
-      return;
-    }
+  buildersGroups.sort((a, b) => a.name.localeCompare(b.name));
 
-    // Attempt to merge identical tags
-    const lastItem = lineConfig[lineConfig.length - 1];
-    if (lastItem.tag === tag) {
-      lastItem.colSpan += colSpan;
-      return;
+  const sortedBuilders: Builder[] = [];
+  for (const buildersGroup of buildersGroups) {
+    for (const builder of buildersGroup.builders) {
+      sortedBuilders.push(builder);
     }
-    lineConfig.push({tag: tag, colSpan: colSpan});
-  };
-
-  const walkItemTree = (tagItem: TagTreeItem, depth: number) => {
-    setTagLine(depth, tagItem.tag, tagItem.builders.length);
-    if (tagItem.childItems.length === 0) {
-      // this is the leaf of the tree, sort by buildername, and add them to the
-      // list of sorted builders
-      tagItem.builders.sort((a, b) => a.name.localeCompare(b.name));
-
-      resultBuilders.push(...tagItem.builders);
-
-      for (let i = 1; i <= 100; i++) {
-        // set the remaining depth of the tree to the same colspan
-        // (we hardcode the maximum depth for now :/ )
-        setTagLine(depth + i, '', tagItem.builders.length);
-      }
-      return;
-    }
-    tagItem.childItems.map(item => walkItemTree(item, depth + 1));
-  };
-
-  for (const tagItem of tagLineItems) {
-    walkItemTree(tagItem, 0);
   }
 
-  const resultTagLineConfigs: TagLineConfig[] = [];
-
-  for (const tagLineItems of tagLineConfigAtDepth.values()) {
-    if (tagLineItems.length === 1 && tagLineItems[0].tag === "") {
-      continue;
-    }
-    resultTagLineConfigs.push(tagLineItems);
-  }
-  return [resultBuilders, resultTagLineConfigs];
+  return [sortedBuilders, buildersGroups];
 }
 
-function resolveFakeChange(codebase: string, revision: string, whenTimestamp: number,
+function resolveFakeChange(revision: string, whenTimestamp: number, comment: string,
                            changesByFakeId: Map<string, ChangeInfo>): ChangeInfo
 {
-  const fakeId = `${codebase}-${revision}`;
+  const fakeId = `${revision}-${comment}`;
   const existingChange = changesByFakeId.get(fakeId);
   if (existingChange !== undefined) {
     return existingChange;
@@ -206,11 +126,10 @@ function resolveFakeChange(codebase: string, revision: string, whenTimestamp: nu
 
   const newChange = {
     change: new Change(undefined as unknown as IDataAccessor, "a/1", {
-      changeid: 0,
+      changeid: revision,
       author: "",
       branch: "",
-      codebase: codebase,
-      comments: `Unknown revision ${revision}`,
+      comments: comment,
       files: [],
       parent_changeids: [],
       project: "",
@@ -230,47 +149,63 @@ function resolveFakeChange(codebase: string, revision: string, whenTimestamp: nu
 function selectChangeForBuild(build: Build, buildset: Buildset,
                               changesBySsid: Map<number, ChangeInfo>,
                               changesByRevision: Map<string, ChangeInfo>,
-                              changesByFakeId: Map<string, ChangeInfo>) {
-  if (buildset.sourcestamps !== null) {
-    for (const sourcestamp of buildset.sourcestamps) {
-      const change = changesBySsid.get(sourcestamp.ssid);
-      if (change !== undefined) {
-        return change;
-      }
+                              changesByFakeId: Map<string, ChangeInfo>,
+                              revMapping: Map<int, string>,
+                              branchMapping: Map<int, string>)
+                              {
+  if ((build.properties !== null && ('yp_build_revision' in build.properties))  || (build.buildid in revMapping)) {
+    let revision;
+    let change = undefined;
+    if (build.properties !== null && ('yp_build_revision' in build.properties)) {
+      revision = build.properties['yp_build_revision'][0];
+    } else {
+      revision = revMapping[build.buildid];
     }
-  }
-
-  if (build.properties !== null && ('got_revision' in build.properties)) {
-    const revision = build.properties['got_revision'][0];
     // got_revision can be per codebase or just the revision string
     if (typeof(revision) === "string") {
-      const change = changesByRevision.get(revision);
-      if (change !== undefined) {
-        return change;
+      change = changesByRevision.get(revision);
+      if (change === undefined) {
+        change = changesBySsid.get(revision);
+      }
+      if (change === undefined) {
+        change = resolveFakeChange(revision, build.started_at, revision, changesByFakeId);
       }
 
-      return resolveFakeChange("", revision, build.started_at, changesByFakeId);
-    }
+      change.change.caption = "Commit";
+      if (build.properties !== null && ('yp_build_revision' in build.properties)) {
+        change.change.caption = build.properties['yp_build_branch'][0];
+      }
+      if (build.buildid in branchMapping) {
+        change.change.caption = branchMapping[build.buildid];
+      }
+      change.change.revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + revision;
+      change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
 
-    const revisionMap = revision as {[codebase: string]: string};
-    for (const codebase in revisionMap) {
-      const codebaseRevision = revisionMap[codebase];
-      const change = changesByRevision.get(codebaseRevision);
-      if (change !== undefined) {
-        return change;
+      let bid = build.buildid;
+      if ((buildset !== null) && (buildset.parent_buildid != null)) {
+        bid = buildset.parent_buildid;
+      }
+      if (build.properties !== null && ('reason' in build.properties)) {
+        change.change.reason = build.properties['reason'][0];
+      }
+      if (build.properties !== null && ('publish_destination' in build.properties)) {
+        change.change.publishurl = build.properties['publish_destination'][0].replace("/srv/autobuilder/autobuilder.yoctoproject.org/", "https://autobuilder.yocto.io/");
+        change.change.publishurl = change.change.publishurl.replace("/srv/autobuilder/autobuilder.yocto.io/", "https://autobuilder.yocto.io/");
       }
     }
 
-    const codebases = Object.keys(revisionMap);
-    if (codebases.length === 0) {
-      return resolveFakeChange("unknown codebase", "", build.started_at, changesByFakeId);
-    }
-    return resolveFakeChange(codebases[0], revisionMap[codebases[0]], build.started_at,
-      changesByFakeId);
+    return change;
   }
 
-  const revision = `unknown revision ${build.builderid}-${build.buildid}`;
-  return resolveFakeChange("unknown codebase", revision, build.started_at, changesByFakeId);
+  const revision = `Unresolved Revision`
+  const change = changesBySsid.get(revision);
+  if (change !== undefined) {
+    return change
+  }
+
+  const fakeChange = resolveFakeChange(revision, build.started_at, revision, changesByFakeId);
+  fakeChange.change.caption = revision;
+  return fakeChange
 }
 
 export const ConsoleView = observer(() => {
@@ -300,7 +235,7 @@ export const ConsoleView = observer(() => {
   const buildsQuery = useDataApiQuery(() => Build.getAll(accessor, {query: {
       limit: buildFetchLimit,
       order: '-started_at',
-      property: ["got_revision"],
+      property: ["yp_build_revision", "yp_build_branch", "reason", "publish_destination"],
     }}));
 
   const windowSize = useWindowSize()
@@ -313,13 +248,65 @@ export const ConsoleView = observer(() => {
     buildrequestsQuery.resolved &&
     buildsQuery.resolved;
 
+  // FIXME: fa-spin
+  if (!queriesResolved) {
+    return (
+      <div className="bb-console-container">
+        <LoadingIndicator/>
+      </div>
+    );
+  }
+
+
   const builderIdsWithBuilds = new Set<number>();
   for (const build of buildsQuery.array) {
     builderIdsWithBuilds.add(build.builderid);
   }
 
+  const revMapping = new Map<int, string>();
+  const branchMapping = new Map<int, string>();
+  for (const build of buildsQuery.array) {
+    let change = false;
+    let {
+      buildid
+    } = build;
+    if (build.properties !== null && ('yp_build_revision' in build.properties)) {
+      revMapping[build.buildid] = build.properties['yp_build_revision'][0];
+      change = true;
+    }
+    if (build.properties !== null && ('yp_build_branch' in build.properties)) {
+      branchMapping[build.buildid] = build.properties.yp_build_branch[0];
+      change = true;
+    }
+    if ((!revMapping[buildid] || !branchMapping[buildid]) && !build.complete_at) {
+      build.getProperties().onChange = properties => {
+        change = false;
+        buildid = properties.endpoint.split('/')[1];
+        if (!revMapping[buildid]) {
+          const rev = getBuildProperty(properties[0], 'yp_build_revision');
+          if (rev != null) {
+            revMapping[buildid] = rev;
+            change = true;
+          }
+        }
+        if (!branchMapping[buildid]) {
+          const branch = getBuildProperty(properties[0], 'yp_build_branch');
+          if (branch != null) {
+            branchMapping[buildid] = branch;
+            change = true;
+          }
+        }
+      };
+    }
+  }
+
+  function getBuildProperty(properties, property) {
+    const hasProperty = properties && properties.hasOwnProperty(property);
+    if (hasProperty) { return properties[property][0]; } else { return null; }
+  }
+
   const buildersWithBuilds = buildersQuery.array.filter(b => builderIdsWithBuilds.has(b.builderid));
-  const [buildersToShow, tagLineConfigs] = sortBuildersByTags(buildersWithBuilds);
+  const [buildersToShow, builderGroups] = getBuildersGroups(buildersWithBuilds);
 
   const changesByRevision = new Map<string, ChangeInfo>();
   const changesBySsid = new Map<number, ChangeInfo>();
@@ -347,7 +334,7 @@ export const ConsoleView = observer(() => {
     }
 
     const change = selectChangeForBuild(build, buildset, changesBySsid, changesByRevision,
-      changesByFakeId);
+      changesByFakeId, revMapping, branchMapping);
 
     pushIntoMapOfArrays(change.buildsByBuilderId, build.builderid, build);
   }
@@ -393,21 +380,11 @@ export const ConsoleView = observer(() => {
     }
   };
 
-  // FIXME: fa-spin
-  if (!queriesResolved) {
-    return (
-      <div className="bb-console-container">
-        <LoadingIndicator/>
-      </div>
-    );
-  }
-
-  if (changesQuery.array.length === 0) {
+  if (buildsQuery.array.length === 0) {
     return (
       <div className="bb-console-container">
         <p>
-          No changes. Console View needs a changesource to be setup,
-          and <Link to="/changes">changes</Link> to be in the system.
+          No builds. Console View needs run builds to be setup.
         </p>
       </div>
     );
@@ -423,23 +400,15 @@ export const ConsoleView = observer(() => {
     )
   });
 
-  const tagLineRows = tagLineConfigs.map((tagLineConfig, i) => {
-    const columns = tagLineConfig.map((item, i) => {
-      return (
-        <td key={i} colSpan={item.colSpan}>
-          <span style={{width: item.colSpan * 50}}>{item.tag}</span>
-        </td>
-      );
-    });
-
+  const tagLineColumns = builderGroups.map((builderGroup, i) => {
     return (
-      <tr className="bb-console-tag-row" key={`tag-${i}`}>
-        <td className="row-header"></td>
-        {columns}
-      </tr>
-    )
+      <td key={i} colSpan={builderGroup.colspan} style={{textAlign: 'center'}}>
+      {builderGroup.tag}
+      </td>
+    );
   });
 
+
   const changeRows = changesToShow.map(changeInfo => {
     const change = changeInfo.change;
 
@@ -460,7 +429,7 @@ export const ConsoleView = observer(() => {
     return (
       <tr key={`change-${change.changeid}-${change.codebase}-${change.revision ?? ''}`}>
         <td>
-          <ChangeDetails change={change} compact={true}
+          <YoctoChangeDetails change={change} compact={true}
                          showDetails={changeIsExpandedByChangeId.get(change.changeid) ?? false}
                          setShowDetails={(show: boolean) => changeIsExpandedByChangeId.set(change.changeid, show)}/>
         </td>
@@ -474,28 +443,16 @@ export const ConsoleView = observer(() => {
       <Table striped bordered className={(isBigTable() ? 'table-fixedwidth' : '')}>
         <thead>
           <tr className="bb-console-table-first-row first-row">
-            <th className="row-header" style={{width: rowHeaderWidth}}>
-              <OverlayTrigger trigger="click" placement="top" overlay={
-                <Tooltip id="bb-console-view-open-all-changes">
-                  Open information for all changes
-                </Tooltip>
-              } rootClose={true}>
-                <FaPlusCircle onClick={e => openAllChanges()} className="bb-console-changes-expand-icon clickable"/>
-              </OverlayTrigger>
-
-              <OverlayTrigger trigger="click" placement="top" overlay={
-                <Tooltip id="bb-console-view-close-all-changes">
-                  Close information for all changes
-                </Tooltip>
-              } rootClose={true}>
-                <FaMinusCircle onClick={e => closeAllChanges()} className="bb-console-changes-expand-icon clickable"/>
-              </OverlayTrigger>
+            <th className="row-header">
             </th>
             {builderColumns}
           </tr>
         </thead>
         <tbody>
-          {tagLineRows}
+          <tr className="bb-console-tag-row" key="tag">
+            <td className="row-header"></td>
+            {tagLineColumns}
+          </tr>
           {changeRows}
         </tbody>
       </Table>
@@ -506,7 +463,7 @@ export const ConsoleView = observer(() => {
 buildbotSetupPlugin(reg => {
   reg.registerMenuGroup({
     name: 'console',
-    caption: 'Console View',
+    caption: 'Yocto Console View',
     icon: <FaExclamationCircle/>,
     order: 5,
     route: '/console',
diff --git a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.scss b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.scss
new file mode 100644
index 000000000000..1496dffb00bb
--- /dev/null
+++ b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.scss
@@ -0,0 +1,18 @@
+.yoctochangedetails {
+  width: 100%;
+}
+
+.yoctochangedetails-heading {
+  width: 100%;
+}
+
+.yoctochangedetails-heading > * {
+  margin-right: 0.5em;
+}
+
+.changedetails-properties {
+  padding: unset;
+  margin: unset;
+  border: unset;
+  background-color: unset
+}
diff --git a/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
new file mode 100644
index 000000000000..37670de255c9
--- /dev/null
+++ b/yocto_console_view/src/views/ConsoleView/YoctoChangeDetails.tsx
@@ -0,0 +1,149 @@
+/*
+  This file is part of Buildbot.  Buildbot is free software: you can
+  redistribute it and/or modify it under the terms of the GNU General Public
+  License as published by the Free Software Foundation, version 2.
+
+  This program is distributed in the hope that it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+  details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 51
+  Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+  Copyright Buildbot Team Members
+*/
+
+import './YoctoChangeDetails.scss';
+import {useState} from "react";
+import {observer} from "mobx-react";
+import {OverlayTrigger, Popover, Table} from "react-bootstrap";
+import {Change, parseChangeAuthorNameAndEmail} from "buildbot-data-js";
+import {dateFormat, durationFromNowFormat, useCurrentTime} from "buildbot-ui";
+import {ArrowExpander} from "buildbot-ui";
+
+type ChangeDetailsProps = {
+  change: Change;
+  compact: boolean;
+  showDetails: boolean;
+  setShowDetails: ((show: boolean) => void) | null;
+}
+
+export const YoctoChangeDetails = observer(({change, compact, showDetails, setShowDetails}: ChangeDetailsProps) => {
+  const now = useCurrentTime();
+  const [showProps, setShowProps] = useState(false);
+
+  const renderChangeDetails = () => (
+    <div className="anim-yoctochangedetails">
+      <Table striped size="sm">
+        <tbody>
+          { change.reason !== null
+            ? <tr>
+              <td>Reason</td>
+              <td>{change.reason}</td>
+            </tr>
+            : <></>
+          }
+          { change.author != null
+            ? <tr>
+              <td>Author</td>
+              <td>{change.author}</td>
+            </tr>
+            : <></>
+          }
+          <tr>
+            <td>Date</td>
+            <td>{dateFormat(change.when_timestamp)} ({durationFromNowFormat(change.when_timestamp, now)})</td>
+          </tr>
+          { change.repository !== null
+            ? <tr>
+              <td>Repository</td>
+              <td>{change.repository}</td>
+            </tr>
+            : <></>
+          }
+          { change.branch !== null
+            ? <tr>
+              <td>Branch</td>
+              <td>{change.branch}</td>
+            </tr>
+            : <></>
+          }
+          <tr>
+            <td>Revision</td>
+            <td>
+            {
+              change.revlink
+              ? <a href={change.revlink}>{change.revision}</a>
+              : <></>
+            }
+            </td>
+          </tr>
+        </tbody>
+      </Table>
+      <h5>Comment</h5>
+      <pre>{change.comments}</pre>
+      <h5>Changed files</h5>
+      {change.files.length === 0
+        ? <p>No files</p>
+        : <ul>{change.files.map(file => (<li key={file}>{file}</li>))}</ul>
+      }
+    </div>
+  );
+
+  const [changeAuthorName, changeEmail] = parseChangeAuthorNameAndEmail(change.author);
+
+  const popoverWithText = (id: string, text: string) => {
+    return (
+      <Popover id={"bb-popover-change-details-" + id}>
+        <Popover.Content>
+          {text}
+        </Popover.Content>
+      </Popover>
+    );
+  }
+
+  const onHeadingClicked = () => {
+    if (setShowDetails === null)
+      return;
+    setShowDetails(!showDetails);
+  }
+
+  return (
+    <div className="yoctochangedetails">
+      <div className="yoctochangedetails-heading" onClick={onHeadingClicked}>
+        <OverlayTrigger placement="top"
+                        overlay={popoverWithText("comments-" + change.id, change.caption)}>
+          <React.Fragment>
+            {
+              change.revlink
+              ? <a href={change.revlink}>{change.caption}</a>
+              : <span>{change.caption}</span>
+            }
+            {
+              change.errorlink
+              ? <a href={change.errorlink}>Error</a>
+              : <></>
+            }
+            {
+              change.publishurl
+              ? <a href={change.publishurl}>Output</a>
+              : <></>
+            }
+          </React.Fragment>
+        </OverlayTrigger>
+        { !compact
+          ? <OverlayTrigger placement="top"
+                            overlay={popoverWithText("date-" + change.id,
+                              dateFormat(change.when_timestamp))}>
+              <span>({durationFromNowFormat(change.when_timestamp, now)})</span>
+            </OverlayTrigger>
+          : <></>
+        }
+        {setShowDetails !== null ? <ArrowExpander isExpanded={showDetails}/> : <></>}
+      </div>
+      {showDetails ? renderChangeDetails() : <></>}
+    </div>
+  );
+});
diff --git a/yocto_console_view/vite.config.ts b/yocto_console_view/vite.config.ts
index 168b120f19db..f30b4dab2a37 100644
--- a/yocto_console_view/vite.config.ts
+++ b/yocto_console_view/vite.config.ts
@@ -2,7 +2,7 @@ import {resolve} from "path";
 import {defineConfig} from "vite";
 import react from "@vitejs/plugin-react";
 
-const outDir = 'buildbot_console_view/static';
+const outDir = 'yocto_console_view/static';
 
 export default defineConfig({
   plugins: [

-- 
2.39.5


