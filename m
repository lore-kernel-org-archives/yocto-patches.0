Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61FC43602
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:41 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39828.1782891637108077429
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YXjYQc/x;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51a8f5ef23bso2069171cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891636; x=1783496436; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgA1KZBX54HVNPOyagtXsuIOHW3aatFGsduASI2pxTw=;
        b=YXjYQc/xJJSL2G2Y7//vH6T6V0sKRbalV8VU7ZX7ad1tmuxDNl6ZObtNlNQx8i8sWY
         7U7OhhU10qsR5UOM92pb0KnO0eITq+W7GCZm2A8JG7exLu7sPmDOo8W5d4dN9Tunkm2Y
         JKIhmNyXbZW59kB4pz88N9lnghBBkJj+p0S6FP+gDwPFIlzkF7wqoKFy+c/sfZ8PXAVf
         w8IWEvWccngZxWHMIiHx9YMhXGKT+x8L3hIeA58dYa8qoorog8mTq2JW6Y35TjWmFFRF
         NfcLQmE+15YByAb/bNERGgfiHirF+FniEHj04zx0uHUOSqdXfrjDYpRJoO4HM1cBR3/x
         HERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891636; x=1783496436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgA1KZBX54HVNPOyagtXsuIOHW3aatFGsduASI2pxTw=;
        b=Q/5Df43jRvnFFB7pCoA6HeJBXtlJ6gdelspIG006hx9aRv8NwP2bBX2lTir2o7EjJW
         Q02XvEcnTeo9/6nOZpz/77HLF6i4GSfoWwQ0oAknNX1myMowpPZ2vgQ2AWdvls5s+lQk
         RVnN+zORZ+gtHx4MFLEuXmEFWaXc6ysmTYcbJlaom1qUpMc93zGoBnf4mOAFcm8kRDiV
         M9GXtsYruYphJ5ND5SKYAS92563eEBMV2gwbwslKy49Ud4iuEdsHgLGybm6AOcbpKPGS
         PyjkrkfTZbUu69wB8T3vG0pgcMQknC+7QMMVECkEUVMuRuI5vp1HScn6FCAyG+1q4O6Z
         M78g==
X-Gm-Message-State: AOJu0Yx7a1fBEGy5ezM/AHAFc13kM7pB2/K8CZbJ64STv4bxI/yNd9iD
	T8oZbBgLFtB7Y86HqRFMorUbZ7GFNbyvJHryzgGGeri9AOWu8SpMj+6ECtYo4Q==
X-Gm-Gg: AfdE7cm3uzC6FSD5XgBQwbgV0Fz8lyrcVGicxZaFIxVyXLbFGndgYPvhFchMyRA0a1f
	Pjt4hIa+F/Oxz+F9yBHYMiymBZFYzRKzLBETgpl6DiQvBwga32nPVyZ9XB5YdMTMK5zkaYpKwkG
	CwZFUDoFQxHZPubYCgKYXPZk6FwZ3poQuaeGZm1QptpDMvQUcL2AqYzDewMAnDoBy0sPb3FlZV+
	tzSsLCjOLnrc1O9sXPWaHQ8Oftr9CZjsjESKeN65i0U1W/CxdiHE8Olhwjt38hKvE65S+yekWDL
	ZzM93XatUNujl9i0Qwh/BtVSuY66PUxV+7/RTi18QnIi793xUMndbU4P2LZ/Zo+T5NEOUHjO3i4
	K7C7yDLshKaC+2Su6AaW+UbMqSj09wx+NMV/9pJF2Uc4tyHvhGpOaMLvhN0YbwZbrtCLM7+JLa+
	s+xlVirWUA3niCzxuN0q3lWhGupJcIvFEU8DRqBRMl6Vg+YtHN4UWyWaw=
X-Received: by 2002:ac8:5a95:0:b0:51c:ebd:fb42 with SMTP id d75a77b69052e-51c26b20e48mr6086181cf.59.1782891635522;
        Wed, 01 Jul 2026 00:40:35 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:34 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 01/10] tests: add the standalone test-suite skeleton
Date: Wed,  1 Jul 2026 03:40:21 -0400
Message-ID: <20260701074030.1090807-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4333

wic currently has no test mechanism of its own; it relies on the
oe-selftest from oe-core for all its testing, which means a full
bitbake build is needed to exercise even pure-Python logic. This
commit lays the groundwork for a small standalone suite that runs
from a plain checkout with nothing but pytest, so that logic can be
pinned down and kept stable as the code evolves.

This commit adds the skeleton only; it does not add any tests.

What this adds:

  - pyproject.toml: a "tests" optional-dependency group (pytest only)
    so that "pip install -e .[tests]" pulls in what the suite needs,
    plus a [tool.pytest.ini_options] section. The pytest options keep
    a test's scratch directory only when that test fails, so repeated
    runs do not accumulate leftover files.

  - tests/unit/ and tests/docs/: the directories that hold the
    in-process unit suites and the suite documentation. Git cannot
    track an empty directory, so a placeholder .gitkeep is committed
    in each to create it. The .gitkeep files have no content and are
    removed once real files land in those directories.

  - .gitignore: ignore the .pytest_cache/ directory that pytest
    writes at the top of the checkout.

  - README.md: a Testing section pointing at the suite and at
    tests/docs/, and a tests/* entry in the project layout list.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore          |  3 +++
 README.md           | 14 ++++++++++++++
 pyproject.toml      | 12 ++++++++++++
 tests/docs/.gitkeep |  0
 tests/unit/.gitkeep |  0
 5 files changed, 29 insertions(+)
 create mode 100644 tests/docs/.gitkeep
 create mode 100644 tests/unit/.gitkeep

diff --git a/.gitignore b/.gitignore
index eeb8a6ec4087..07992096c0fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,4 @@
 **/__pycache__
+
+# pytest cache
+/.pytest_cache/
diff --git a/README.md b/README.md
index 75229421763c..497ebb1de0f0 100644
--- a/README.md
+++ b/README.md
@@ -46,6 +46,20 @@ environment file or folder (generated via `bitbake -c rootfs_wicenv
 - `src/wic/*`: core engine, plugins, and helpers.
 - `src/bb/*`: various bitbake helpers that were brought along and used in other parts of wic.
 - `src/oe/*`: various oe-core helpers that were brought along and used in other parts of wic.
+- `tests/*`: the standalone test suite and its documentation (see Testing below).
+
+## Testing
+
+wic ships a standalone test suite under `tests/` that runs from a plain
+checkout, with no bitbake and no OpenEmbedded build required. The test
+extras pull in everything the suite needs:
+
+```
+pip install -e ".[tests]"
+```
+
+See [tests/docs/](tests/docs/) for how to run the suite and the
+conventions it follows.
 
 ## Contributing
 
diff --git a/pyproject.toml b/pyproject.toml
index fdc1ce0f5ece..d660e39007c4 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -21,6 +21,11 @@ classifiers = [
 Homepage = "https://git.yoctoproject.org/wic"
 Repository = "https://git.yoctoproject.org/wic"
 
+[project.optional-dependencies]
+tests = [
+    "pytest >= 7.0",
+]
+
 [project.scripts]
 wic = "wic.cli:main"
 
@@ -36,3 +41,10 @@ build-backend = "hatchling.build"
 
 [tool.hatch.version]
 path = "src/wic/cli.py"
+
+[tool.pytest.ini_options]
+# Keep a test's scratch directory only when it fails; a passing test's
+# tmp_path is removed automatically so repeated runs do not accumulate
+# leftover files under the pytest base temp directory.
+tmp_path_retention_policy = "failed"
+tmp_path_retention_count  = 1
diff --git a/tests/docs/.gitkeep b/tests/docs/.gitkeep
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/unit/.gitkeep b/tests/unit/.gitkeep
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.50.0.173.g8b6f19ccfc3a


