Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A65C43327
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:51 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39836.1782891646551409558
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UAAIVHwW;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfbe05683so1975581cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891645; x=1783496445; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYpHsxnDd4qnOjxUN2Bdvy/1Rr9Jb8fbNiQPOPWe8ok=;
        b=UAAIVHwWZt9l/tClFqDig7y1HLIi3dJGaUlwsMBVgGnBJKhavDM8TJ10jxeHFz7qyq
         oKmTePI42mCCUg5Ljzws3McBlHT/qpZH3P7touDixUXb4tPEqpMmYtxLqksItR7+Lpz6
         0B+gg6cKiaAQNdDekkmysmGXtSN/GmekH/21VCVWCytw8s9CWdiE/ntMh5+VJ1b1jTfW
         5ybFgVA6jm04jIv4lazRgGGSx9uKrmHtzsiprpZt/g6fm3G2T/UGMPdLsKO9EDXAMrb+
         PxBGElg4gDkecbXmVb7O8jiM7ieUmF9+6R9OlLDWYPM67+Y2HL/NRVotOEX1kdz0d5TV
         RonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891645; x=1783496445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYpHsxnDd4qnOjxUN2Bdvy/1Rr9Jb8fbNiQPOPWe8ok=;
        b=icUFkm0B4tU6QHbGFGQ0AUGT3jupCJuc8xi2jCFbQy4ujRVWT8zV4zXfUi1gpbO1cx
         +xJOkra6hGVOG9tWtHx19gxQPIzDhUOvhBEUGNpEsu3DkbrzlXpO2cATlMHWNBJAxfAv
         GOpBY8Xy7sSps8kGsgt98Y+EjoDI60E1TaMtZhN+gEjMjk8qvU5R8s193cLdGNNC7e9s
         ONQACnMTC87QbNiBRKd1qau1JQl9dg9AIM9GmTxrNPr4e/ewgDSxaFMq6m8XhgxeGuQz
         a6Av5s6RkcBBlCbcA9RjJ9Rn8BRGxc4M1POfpty+GE18RJyzI3raYMKtCxIxDm+rhYfW
         l9LQ==
X-Gm-Message-State: AOJu0Yw05eHm2ouWT+iWhVm9cwYcuuyoG2PmWP+XLXNGSmFV5wfLqsnh
	XQ2DgbC2P7trARhZC98c42JiofonQVGozC9FQMxu9UUE/Zrvyz/xZOpgXBLjSA==
X-Gm-Gg: AfdE7cn6S2ozC7H4MDTV+57nHQcECmVvyr85VbvCB6SEmAk8kd3QV79aSlsrojEjHIG
	W8oLsD1Ad48MuFJ9hI4Eo8FMOfvyT4FlSs6Wu+2eafFkR9rO0jrLlHGSTdlcKrllSanKZQdEMsi
	hclxXu2/PkFg7x+/PcgGixP86zn80LB9zHubVy0JH4FySnVE5LisBtvOguIFv5hx38pApQ3fu+/
	+rBYh1UKf4vJu9ZfbunDpyZWUkbIxu6wa7Hqfm/DLPLY9AbTxHuqswt5UmOTYgdGBELHDxzexGY
	dye3C7uZFqfwOTFKoqV5UO/BpSZDG3Uk9e4yGUDbtPyCRqYfsFHk8YxcjBvuGNsl5yc9GcmhMUO
	VJbB0uwTPgv+6j0e/RD++AU3o4YitLN7MgKurzO/ZdkTmo/gVB0n8Nx0N43VWZ191faEmrwd9zy
	rsImF8voSZ/8bGsxiCVg/F0A3+oC1D6+j8Q4ZW1N1icywpzmJuM7JyDTvYiBEMCJ39yg==
X-Received: by 2002:a05:622a:13c7:b0:51c:20:aea7 with SMTP id d75a77b69052e-51c26a54d4cmr6902621cf.9.1782891645293;
        Wed, 01 Jul 2026 00:40:45 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:44 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 06/10] tests/docs: add the suite overview README
Date: Wed,  1 Jul 2026 03:40:26 -0400
Message-ID: <20260701074030.1090807-7-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4338

The test suite needs a front door: a short document that says what the
suite is, how it is laid out, and how to run it. This commit adds
tests/docs/README.md to be that overview.

The README covers:

  - the layout of tests/, file by file;
  - that the suite is unit-only and needs no host tools or build
    environment, so it runs from a plain checkout;
  - how to install the test extras and invoke run-tests.sh, pointing at
    run-tests.sh --help as the authoritative, always-current list of
    options rather than duplicating them here where they would drift;
  - that anything run-tests.sh does not recognise is passed through to
    pytest;
  - a pointer to linting.md for how ruff is applied;
  - a small table of the other documents under tests/docs/.

It deliberately does not enumerate every run-tests.sh option, since the
runner is expected to grow more of them; the table and the --help
output stay the source of truth.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- document the standard pytest scratch-directory mechanisms
  (TMPDIR and --basetemp) in the suite README, so there is no need
  for a custom temporary-directory variable.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 tests/docs/README.md | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 tests/docs/README.md

diff --git a/tests/docs/README.md b/tests/docs/README.md
new file mode 100644
index 000000000000..ba7bd5e192a3
--- /dev/null
+++ b/tests/docs/README.md
@@ -0,0 +1,82 @@
+# wic test suite
+
+A standalone test suite for the wic source tree. It runs from a plain
+checkout with nothing but `pytest` -- no bitbake, no OpenEmbedded
+build, and no target image -- so wic's logic can be exercised and kept
+stable as the code changes.
+
+## Contents
+
+- [Layout](#layout)
+- [Running](#running)
+- [Linting](#linting)
+- [Documentation](#documentation)
+
+## Layout
+
+```
+tests/
+  conftest.py        session banner describing the run
+  run-tests.sh       wrapper for running the suite
+  unit/              unit tests that import wic modules directly
+  docs/              this documentation
+```
+
+The suite is unit-only: every test under `tests/unit/` imports a wic
+module in-process and asserts on its behaviour, so none of it needs
+host tools or a build environment.
+
+## Running
+
+Install wic with its test extras, then run the suite:
+
+```bash
+pip install -e ".[tests]"
+tests/run-tests.sh
+```
+
+`run-tests.sh` works from anywhere in the checkout. It can also report
+branch coverage of the wic source; run `tests/run-tests.sh --help` for
+the current list of options.
+
+Anything `run-tests.sh` does not recognise is handed straight to
+pytest, so the whole pytest command line is available:
+
+```bash
+tests/run-tests.sh -k filemap -v          # one area, verbose
+tests/run-tests.sh tests/unit             # a single tier or file
+```
+
+## Scratch files
+
+Tests that need scratch space use pytest's `tmp_path` fixture, so there
+is no wic-specific temporary-directory setting. Scratch directories are
+created under pytest's base temporary directory and cleaned up according
+to the retention policy in `pyproject.toml` (a passing test's directory
+is removed, a failing one is kept).
+
+By default pytest roots that base directory at the system temporary
+directory (usually `/tmp`). If that fills up, or you want the scratch
+files somewhere else, use the standard pytest mechanisms rather than a
+custom variable. Both are passed straight through by `run-tests.sh`:
+
+```bash
+TMPDIR=/path/to/scratch tests/run-tests.sh   # honoured by pytest
+tests/run-tests.sh --basetemp=/path/to/scratch
+```
+
+`--basetemp` puts everything under the given directory and clears it at
+the start of each run; `TMPDIR` keeps the last few sessions there.
+
+## Linting
+
+The test suite is linted with ruff and is held to a clean bar. See
+[linting.md](linting.md) for the lint modes and how the source tree is
+treated.
+
+## Documentation
+
+| File | Content |
+|------|---------|
+| [authoring.md](authoring.md) | How to add a unit test to the suite |
+| [linting.md](linting.md)     | How ruff is used on the suite |
-- 
2.50.0.173.g8b6f19ccfc3a


