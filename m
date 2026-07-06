Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D3C44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:25 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161869.1783376960285847474
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NCjdE4Uc;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f256eaedf8so37555756d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376959; x=1783981759; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AY1AaOePOsDeEuk4oPElxBGhF9J51T/21Aclc0GdCoY=;
        b=NCjdE4UcYNBOB3b0G0LhAb59iBDs6VzNgEYDNPJ7MdJRNRHQ2HjtNdrPy+JqXF5vGI
         tyROPpc1c1o8GyYvgsnihGkoGkBAikmrqdvfNZXskX8FlEP8Qjg+s74dPvxcmvxWERRD
         17XQQL9ZXOhhYw37+R094eMzBcGDSfSEn5yAt3cR3wTOo52Xgmp0wvTFx67n/6l3q1rs
         GOYr8le4H3wk2CV53pxmUiVJ3qsge89ewQFOuWZ9WhK3vwFLhn8CL3m7nwcLRiDdqD3r
         l9hIXfpzr6cDAYXl/AMzwzQsoimn/3ZwJnOpvAu5O8rwP6RN8PB1Q6iKJ2lWMF0FIBsb
         +OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376959; x=1783981759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AY1AaOePOsDeEuk4oPElxBGhF9J51T/21Aclc0GdCoY=;
        b=TFt/zWaic4/YBAy8rLBvMg+98JVuQyqGBdCqy+dikjh1kZHBGX7f+te1kNWP71m56E
         XpWbzzqwg2wPNvwZVfreH2DbSRLCeOFigTuXAusrbflUEtepKuBBYFUAh1MT8IBrrhed
         LXIh28n4KMjm6oWnskBjj/RUnRr+XUNAf4sRX7JdbD0dK4mhJNzy+23DDVkLkU3y1yWd
         Embj+kk4dfebPORG1npH4xea2r7nuODCYMJ1NUqPyvI5jZALTXJJNJwQXHoM+hagHUGv
         I+E7YYsv7fBSO5LJu6fc4WVHfNyeQU8gsL05oOsN/575+74WmhYPIEDQWefk98w3j47L
         fkiA==
X-Gm-Message-State: AOJu0YwflTyG5QQGIVsiEQtS74SNyudjCcRREhJ/BtyL4WK8jXNJLDqL
	Hm92PPbeTmXkFdrNiheEwGREz6UXEcFDOvcN3snWrmw/qhcLiQbmXx2Tng6SH0qM
X-Gm-Gg: AfdE7cmFEuygwJpHbk8n1Zy98lfrRt+eIpUOCuadK8kP3GEmM/0RDgdDVwALZqsak88
	ris21M26oonSzkIsCyzMr0UWXyuR3tGyr7zrH/x2IAsMS/PKweH7oHxLgtzN8tTzJKC61dZMaQJ
	tMqzqISy+uNeB8SRPYUaSAqp4QD9uo0NutdPGuXLywqD9Yc9rrkjO/YGMUI8ckjnoxBtU4XpLSo
	TcRMxZ2p9EvKzDNbdVf3BhnS74GR5T5ORXElYEeN+bbtlC7Py9kwWIgfqI+z63DY56mV3mGoWYk
	9EZ/6jK8+MJFu+NLqLH0Y6xQlzcXzysuZldkRNVWSuIPANfQjH2a9yaJvDeRpShCViTJXNMb5Gc
	1UfL7akQB/UbtDqvXX0S+thNZ49BnNwrkcVP/s5sNH3Qvo1eMzi5rqR7XT/5lvwzbgGWZGwu/SF
	FImqoj677gXrw1YH2NngvY7tz8ZJED6hMfyJ4vXSWs/FZJf0weZWxPX3LdD2BWfHpfzw==
X-Received: by 2002:ad4:5764:0:b0:8f2:940e:2406 with SMTP id 6a1803df08f44-8fcb1aed76fmr35774026d6.2.1783376958909;
        Mon, 06 Jul 2026 15:29:18 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:18 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 1/6] tests: add the standalone unit-test suite skeleton
Date: Mon,  6 Jul 2026 18:28:59 -0400
Message-ID: <20260706222904.664863-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4443

wic has no test mechanism of its own; it relies on the oe-selftest from
oe-core, which needs a full bitbake build to exercise even pure-Python
logic. This starts a small standalone suite that runs from a plain
checkout, with no BitBake and no OpenEmbedded build.

This is the skeleton only and adds no tests. It gives pyproject.toml a
"tests" extra (pytest and the just command runner) and a pytest config
section, adds a justfile with default and tests recipes, creates
tests/unit/ with a placeholder .gitkeep, ignores .pytest_cache/, and
adds a README Testing section covering install and how to run the suite.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- drop the tests/docs/ documentation tree; the suite now ships with
  a short README Testing section only.
- add a justfile as the command runner and drop the run-tests.sh
  wrapper; just joins the tests extra.
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore          |  1 +
 README.md           | 15 +++++++++++++++
 justfile            | 10 ++++++++++
 pyproject.toml      | 14 ++++++++++++++
 tests/unit/.gitkeep |  0
 5 files changed, 40 insertions(+)
 create mode 100644 justfile
 create mode 100644 tests/unit/.gitkeep

diff --git a/.gitignore b/.gitignore
index eeb8a6ec4087..a0f016bc5823 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,2 @@
 **/__pycache__
+.pytest_cache/
diff --git a/README.md b/README.md
index 75229421763c..c9c38eb5e98a 100644
--- a/README.md
+++ b/README.md
@@ -47,6 +47,21 @@ environment file or folder (generated via `bitbake -c rootfs_wicenv
 - `src/bb/*`: various bitbake helpers that were brought along and used in other parts of wic.
 - `src/oe/*`: various oe-core helpers that were brought along and used in other parts of wic.
 
+## Testing
+
+wic's test suite lives under `tests/` and runs from a plain checkout
+with nothing but `pytest`; it needs no BitBake and no OpenEmbedded
+build. Install the test extras and run it:
+
+```
+pip install -e ".[tests]"
+just tests
+```
+
+The test extras include [just](https://just.systems/), the command
+runner used to drive the suite; run `just` on its own to list the
+available recipes.
+
 ## Contributing
 
 Please send all patches, comments, or questions to the yocto-patches
diff --git a/justfile b/justfile
new file mode 100644
index 000000000000..41a9d3d236f4
--- /dev/null
+++ b/justfile
@@ -0,0 +1,10 @@
+# wic test-suite command runner. Run `just` to list recipes.
+
+# List the available recipes.
+default:
+    @just --list
+
+# Run the test suite. Extra args pass through to pytest
+# (e.g. `just tests -k <expr>` or `just tests tests/unit`).
+tests *args:
+    pytest {{args}}
diff --git a/pyproject.toml b/pyproject.toml
index fdc1ce0f5ece..e60c4fcc1595 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -21,6 +21,12 @@ classifiers = [
 Homepage = "https://git.yoctoproject.org/wic"
 Repository = "https://git.yoctoproject.org/wic"
 
+[project.optional-dependencies]
+tests = [
+    "pytest >= 9.1.1",
+    "rust-just >= 1.55.1",
+]
+
 [project.scripts]
 wic = "wic.cli:main"
 
@@ -36,3 +42,11 @@ build-backend = "hatchling.build"
 
 [tool.hatch.version]
 path = "src/wic/cli.py"
+
+[tool.pytest.ini_options]
+testpaths = ["tests"]
+# Keep a test's scratch directory only when that test fails, and keep
+# just the most recent failing session, so repeated runs do not pile up
+# leftover directories under the pytest base temp directory.
+tmp_path_retention_policy = "failed"
+tmp_path_retention_count  = 1
diff --git a/tests/unit/.gitkeep b/tests/unit/.gitkeep
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.50.0.173.g8b6f19ccfc3a


