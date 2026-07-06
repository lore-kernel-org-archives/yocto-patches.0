Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D17C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:35 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161871.1783376965541335556
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sIQPPNl8;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e7632b193so223408785a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376964; x=1783981764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g8XYBvdHt4KI6c7j0GOgzFRHyu6nVjuGW5Ayik6PBuI=;
        b=sIQPPNl8akzQDf627G+e3083dJiHdCV+WnAHUiGOBfiZSdLmyYyoQ7lIFvzogFl4dg
         TYd0fuzEmAjm3ZcmdIIs0c59bDdjvfbXFjNidEZGW9pFAsHuLxIZkYw8iaUXchl/xLcD
         cuaACb0DsfC5yUCuDZoWxS0eALleW1PEqR+TOieSan5bvmXRkdCQR549B5Xtwva/sbc6
         VHSdIIvdfqE4Bh4zCqXL/Iu5CMUMWdGi0pUUwM/hJqfNW9x4Uo3GqhXvLoaQB91vQb2N
         fW/y1+gW81vz4AvdE5fBHmLyx3JK8SsUJWmUh3eEluplc1RvX/+eFfN7Ve2ZgNSuWTeo
         SbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376964; x=1783981764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g8XYBvdHt4KI6c7j0GOgzFRHyu6nVjuGW5Ayik6PBuI=;
        b=GhW5iC9NuNd2S+EqtS7TeXucNwH97sC2v2BBktTKzYf9yfZsKDukLFNbUwCT7N5bmg
         iDRGfmicx6zuMKWTp4FWddE+38XfV5QSo1xxOta6dcCQdn/tImzuG1MYrD3rLv0cHOY/
         o3tyUnQNkiR5rMs8a5dEFKcNgRDDouzzpwpv7K9n73pjyRNrk/pGKkfVFQSyZ5sticgo
         PNCLZfbALIxZpv3CGzZ/xzN8YwaxESoGuCZTJid8G+0/ZvAAIk3D/mBgVodg6L20+alj
         HVrxK3V0qcIrVVX+p1LfA7HMBH4zvrE32vaVSQYX3/di5avQzQ6WwYHFYnOkrAbP6T7u
         07hg==
X-Gm-Message-State: AOJu0Yzxx+QtumkG1/sShYaH2lzskfoP0zk7GFgr/aaBguA3VS25h1w6
	dwTedswYNTFkI1lIEX6WlwF0RDzSVqeCzOXOx51BavMewGhEUeYrU5SzsoEnEGng
X-Gm-Gg: AfdE7cm5Ik3wpKJaT0LjEwPksk/cUbCmcCdosfEeMvjCVsWJ22iTNtwMie2ZLWJOrBD
	nk266U8eHbm/bkufiaSxNKu2IZC06bHDHijnoJMfJ5JCFiqpTIKTHBmBnmrFiT9GqREZyZgio+W
	6qSluau9ewF1FPwdKcmdgNQDwpqbaxokGTQcjWa/mnD3h5zOSR4tzFxISn1QHEpNp8tGd7WZzKy
	y2H8pqvHHcFqc5JmijLQLLVFJA+nzZBI9aRR7DWo1F2YqlhGLp9ijuazrvykIXkh7vXzTVnKpqv
	V+wE2kDq8C0dXVWU7i6Sy6dF+UuwCM5hSaKsAPI1FTjoyha6W+wvZKYf5bbq1buVCCP7b9eB6Y1
	fqu0X/9fI2wYwVHxVGBlpi4RII3FnvkzmmVHd3d3M3t7npRdDygcqXBGWjB0D0Ce1228DrqKiMV
	ZUoi1Y3uyb/gIvb93EhHUs2P1iCyBQc0X+KRFG1PrDYc+PpdtGNmMhQbA=
X-Received: by 2002:a05:6214:e6b:b0:8ef:60f2:5b52 with SMTP id 6a1803df08f44-8fcb3f3377fmr31262486d6.37.1783376964193;
        Mon, 06 Jul 2026 15:29:24 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:23 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 4/6] add ruff linting
Date: Mon,  6 Jul 2026 18:29:02 -0400
Message-ID: <20260706222904.664863-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4446

Lint with ruff via just recipes. lint-tests runs ruff over tests/ and
is held to a clean bar; lint also runs it over src/, whose findings are
a preview since the wic source is not yet ruff-clean. ruff joins the
tests extra and .gitignore ignores its .ruff_cache/.

ruff is pinned exactly so the gate is reproducible: a ruff minor release
can add rules that turn a previously clean tree red, so every machine
must lint with the same version.

Test modules relax E402 via per-file-ignores: they prepend src/ to
sys.path before importing wic, which trips the rule, and that ordering
is deliberate.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- expose linting through just recipes (lint-tests, lint) rather than
  run-tests.sh flags.
- pin ruff exactly (was a stale >= floor) so the clean-bar gate is
  reproducible across machines.
- fold in the tests/** E402 ignore (its own patch in v2 and v3) and
  drop the linting.md doc; the pyproject.toml comment explains it.
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore     | 1 +
 justfile       | 9 +++++++++
 pyproject.toml | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/.gitignore b/.gitignore
index e30cafa40f7f..f2fd2f56b6d7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,4 @@
 .pytest_cache/
 .coverage
 htmlcov/
+.ruff_cache/
diff --git a/justfile b/justfile
index 1be3e01e7c7d..5ccd8144181d 100644
--- a/justfile
+++ b/justfile
@@ -16,3 +16,12 @@ coverage *args:
 # Run the suite with an HTML coverage report (written to htmlcov/).
 coverage-html *args:
     pytest {{args}} --cov=wic --cov-branch --cov-report=term-missing --cov-report=html
+
+# Lint the test suite; it is held to a clean bar, so this must be clean.
+lint-tests:
+    ruff check tests
+
+# Lint the test suite and then the wic source. src/ is not yet
+# ruff-clean, so its findings are a preview, not a gate.
+lint: lint-tests
+    ruff check src
diff --git a/pyproject.toml b/pyproject.toml
index 2ad694b13358..569944ff468c 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -26,6 +26,7 @@ tests = [
     "pytest >= 9.1.1",
     "coverage >= 7.15.0",
     "pytest-cov >= 7.1.0",
+    "ruff == 0.15.20",
     "rust-just >= 1.55.1",
 ]
 
@@ -52,3 +53,10 @@ testpaths = ["tests"]
 # leftover directories under the pytest base temp directory.
 tmp_path_retention_policy = "failed"
 tmp_path_retention_count  = 1
+
+[tool.ruff.lint.per-file-ignores]
+# Test modules prepend the in-tree src/ directory to sys.path before
+# importing wic, so the suite runs against a checkout that has not been
+# installed. That bootstrap runs before the wic imports, which trips
+# E402; the ordering is deliberate, so ignore E402 for the test tree.
+"tests/**" = ["E402"]
-- 
2.50.0.173.g8b6f19ccfc3a


