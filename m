Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B2C43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:44 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24713.1782835602157344881
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fd+v5LDC;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e52c9fddfso136689185a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835601; x=1783440401; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEnH1o5WZikDExsG+MafdSzmrumcvJBCuOI3ycqhk54=;
        b=fd+v5LDCoXnp3sMUiLqhUgVOwYZQimZHccnviurH2xDhjmkwdz4QtHwm6CXwGQQ542
         va8hXfb74cYoHDPy913bHeuOFU23uBwnEMSke2QKavP4guHI+EIiPV7cnMYkSU8L67mO
         xdPu/KDmuz6ycLXmjE22N+X0GJUTBy3ZxR2iCCWLuXdWKF96qz8J43MQn06rlxOzPD9F
         WJjSwRrB+KgLuCrr4X2mjvAiWXtXajYzFatUkMtgtyvLIfpWCcRD69tw8YUBmKasA2kx
         91iS/de2IgmyUoO4//ygvQ0bOD1HchU0xfhGudjPXGM9ldAUTXmk/2DvkzPTXZRVa7xr
         i6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835601; x=1783440401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XEnH1o5WZikDExsG+MafdSzmrumcvJBCuOI3ycqhk54=;
        b=I0A8WeyyejFOhipsTyCEXNxbTuIZgMhg/0XRogp88yR+2nPnO+6TS+y06FwJXf8VXs
         +RtyWJvw9ZnJVxrxxh/B1jZoFMbRV/B4fXFC0t6+LlwbrGmURVjAR9tu6Y0ujAWbYGmk
         ij1dPvX7wG9M6l2bPVXWHpyRVrd4UjV7GO0dNJktEFUuf9eozCndAY1KLnFL0DzDhvZS
         lQ6FUbH7k+M5ajLRhqK2EJSWyPh1LOz9wh1IOytlbG40I6Wapz902eo27cnZ+x4DAUSj
         ej8YCdT4l3+39viBoodLd6GxoEPsG4Z/QHQENo7PkfRGE2zo5NwxDDXjO23GjtutfwVK
         gHjw==
X-Gm-Message-State: AOJu0YwchrqZL8HDc8FMKd1c4z0/ghx1AoXjShJK/nN4nz0SaQWWJUXn
	YDhjxzHtA7m81eyBsoLi77j7ukWDO1kjBQ6fuetKFKpaE8HcMBAT9ciy0YYVTQ==
X-Gm-Gg: AfdE7cn4G9bZ7bv8AQwvt+usVZkF1VEaUFGB4tbdPHBCdG1eri16SU1nUK5emAhx4fy
	uwavrPLE9ObcbTwdj01Mxfdr5qmsB5gJJNqCzV/JuxRo+FI8cAXxoqTFfY8/VuWgQhPvw4Hr3uW
	MWNaZk6z2sUx9t3VKSOkuos77ZANqwOStgaeunC2SIZ/rh0FRJC7dXLY6UGVj2ida6P0tUNSR+d
	yEM5XjDwwRgHIw69yQ4rd+lIQYpqu4SGG3vpMHvUjvRVdvxG0ORq7q9SM8ynVRudcEAL2cXF4eM
	lBAe5HjmhBAyWRAqvjdSrTpDI5Ah4Zl+Gwn8jvjlTBRGl0Xxl4+om21PIZ1CgfIhMuA1SPpz5S3
	PgaPWpMPkOU0kcENxpkuKqyXpzZ+YNhhdH8GDvftoxCu7Xwkrf3hxu2ZTbWFqW7oERHP+S5DT4t
	BoNkkc003PMit7nwc2qxFIEaj6brgD+/6ZbK9aakReYw6oiUylRX48oB8=
X-Received: by 2002:a05:622a:1b93:b0:519:8998:661b with SMTP id d75a77b69052e-51c107593c4mr59896081cf.20.1782835600754;
        Tue, 30 Jun 2026 09:06:40 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:39 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 1/9] tests: add the standalone test-suite skeleton
Date: Tue, 30 Jun 2026 12:06:04 -0400
Message-ID: <20260630160612.1005451-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4322

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


