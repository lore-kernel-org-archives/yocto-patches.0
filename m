Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17425.1795526098588562780
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 05:14:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2czRQAvc;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09B53C2C648
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92D75601E1
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAEBB11E685A3;
	Tue, 24 Nov 2026 14:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795526092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l6DFQrRMIPNUl1lLi2BKAxO57bkO7SH8zwhdYAiDkHE=;
	b=2czRQAvcmf40XxYJA+k6EuAiILas7pR/JWgl9ThW1ZA+btC1VGCzkIK8IpFbHXd+2LGvZ9
	H/L3IB8SjiM4FnFCNxGBXKzVTMIEngE+fmDzsQfCkyxJgPwX6SWCe8QW2ppMUWd0AiWzzk
	CooZli6kdzR+j/6kWA07neADDZs5OKYVNaQHJf8r3qV6BPlhyvBonIq8TGYXWzA4EkQAUr
	55Ud3ChrYgvRsbQjAMuzw4D4qc/uMmki5UybmbQZTi5QqBXQQRnvcG+lOC0ut8CccAgE1/
	JOpwpDdz97FgkqFcWjcKeNkFex6lZBNWmmYPpkT1erPEQMG6gbZlyihhkAIAhQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Nov 2026 14:14:36 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/4] scripts/run-docs-build:
 checkout closest known ref for oecore/bitbake
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-docs-build-oecore-functions-v1-2-ce9f3c4fbad4@bootlin.com>
References: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
In-Reply-To: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4218;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=K0er8NPng9GPwM5Em3whZOV8SO2tNdX4BMmyxooPa2I=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBY29TQO7l0cOMNCPgNOkBH1bEOUl7pNJ4l9Rg
 8PVuHq/tlmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawWNvQAKCRDRgEFAKaOo
 NuZRD/9yqSW9ZGHjyVZGs7PwGnAqhUY2gXeziifp1Y1dp5FaiDYwCxDOfX73ZZ0TuBBoG5h5Vi3
 Za3c7DXYAs8BXI8zKhFmfHUHs1w4EZnFQ2YrPYCmREfCQ9Al7VL7vvL4DRIcV8rVNQCW6sQmetE
 f8f2+Hznmf3eVo+96YrCtfR3EWlqyM2NAJ5cGo77AgRvzzJafwBVEHBP/tn3XOpKJs5NWUvTOgH
 rqVZ4JF+QClTbU9GRxvheK0xhjo1rLiycmO+q8rZcvGUzf+Ja1qPyKgafwGTBSfk52u3NQDn/12
 Aivu83q08c4ySjuCS6Hwl/2wi2ELf6SrnlrONiYwBR+RxJn13Et5/rzk2ohA4u9BabS11Zr8uPe
 dQ6v4G4QcVQ1DiK14aYnj23SFtewIKR15pRUfSGUI1uf6kHjwIQ0MmYP2MBfyPyZKl2rY3oj53s
 ETr8PBcRBBalLNcBRAsNu3tE6GzFtRm72Kv3fO1I3/g1cRm7bHXZ6GlSZLxhA8Pu3rFnXssOgUY
 T6XMCaAcWAeHFnKxJ5Ax+XXI3CByNfSLZnApWhGSqnUN1r8+IBEXDq/dOcefpFT0yvsXTWzmHOQ
 I0eLPkQkye8kDhawb8fYKGcQER8UxMbdvIKP3qgdAb39qDbnBXoiBrnkfz4DUwhZjIWJMUuwCuA
 oLMj4DIRfgktYuw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5509

Define a checkout_closest_ref function that checks out a given $repo
(bitbake or openembedded-core) and tries to checkout $ref (existing ref
in yocto-docs). If not found, try to checkout the closest tag to this
ref in yocto-docs in $repo.

For bitbake, we have to get the mapping between a Yocto release and a
bitbake version: define a simple Python script for that leverages the
json Python library to read the already available releases.json file.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/docsutils/get-bbmapping | 24 ++++++++++++++++++++++++
 scripts/run-docs-build          | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/scripts/docsutils/get-bbmapping b/scripts/docsutils/get-bbmapping
new file mode 100755
index 0000000..3b78c0e
--- /dev/null
+++ b/scripts/docsutils/get-bbmapping
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Simple utility script called from run-docs-build, to be able to get the
+# mapping between a Yocto release name and a BitBake branch, by parsing the
+# releases.json file from https://dashboard.yoctoproject.org/releases.json.
+#
+# Takes the releases.json file as first argument and branch name as second.
+# Prints the mapping when found, or empty string in all other cases.
+
+import json
+import sys
+
+releases_json_path = sys.argv[1]
+branch_name = sys.argv[2]
+
+with open(sys.argv[1], "r") as fd:
+    releases = json.load(fd)
+
+for release in releases:
+    if branch_name.capitalize() == release.get("release_codename", ""):
+        print(release.get("bitbake_version", "").strip())
+        exit(0)
diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 57044f2..157a201 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -189,6 +189,38 @@ git clean -ffdx
 
 export LATEXMKOPTS="-silent"
 
+function checkout_closest_ref() {
+  # The purpose of this function is to take a ref from yocto-docs (ref=$1) and
+  # checkout the closes possible ref on given (repo=$2).
+  # The way it works is by:
+  # 1. Trying to checkout the same ref on $repo.
+  # 2. If this fails, look for the tag closest to $ref on yocto-docs (CWD) and
+  #    checkout this tag on $repo.
+  # If neither work, exit.
+  local repo="$1"
+  local ref="$2"
+  local bbmapping="$3"
+
+  # keep a copy of the original ref for later
+  docsref="$ref"
+  if [ -n "$bbmapping" ]; then
+    ref="$bbmapping"
+  fi
+
+  if git -C "$repo" rev-parse --verify --quiet "origin/${ref}" >/dev/null; then
+    echo "Closest ref from $docsref for $repo: origin/$ref"
+    git -C "$repo" checkout "origin/$ref"
+    return
+  fi
+  ydocs_closest_tag=$(git describe --tags --match "yocto-*" --abbrev=0 "$docsref")
+  if ! git -C "$repo" rev-parse --verify --quiet "${ydocs_closest_tag}"; then
+    echo "Tag $ydocs_closest_tag does not exists in $repo, quitting"
+    exit 1
+  fi
+  echo "Closest ref from $docsref for $repo: $ydocs_closest_tag"
+  git -C "$repo" checkout "$ydocs_closest_tag"
+}
+
 for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*'); do
     if [ "$branch" = "HEAD" ]; then
         continue
@@ -215,6 +247,14 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     git reset --hard
     git clean -ffdx
 
+    # Tags/branches before this commit in yocto-docs do not have automatic library
+    # functions documentation for openembedded-core.
+    if git merge-base --is-ancestor 2c5846cc2c2649b29de7e7a6ac07fef5c2e7f302 HEAD; then
+      bbmapping="$("$scriptdir"/docsutils/get-bbmapping "$builddir/releases.json" "$branch")"
+      checkout_closest_ref "$bbdocs" "$branch" "$bbmapping"
+      checkout_closest_ref "$oecore" "$branch" ""
+    fi
+
     if [ -e "${scriptdir}/docs-build-patches/${branch}/" ]; then
         echo "Adding patch for $branch"
         git apply -3 "${scriptdir}/docs-build-patches/${branch}/"000*

-- 
2.56.0

