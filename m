Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F75C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:26 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162836.1783376964120369947
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hYQuyXtc;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e57a753f9so257674785a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376963; x=1783981763; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJj9x+KFWryKNgy0kpcNQKsjI8ajviFt4P6n+ALge6M=;
        b=hYQuyXtchFkjjw2tyvJnDv1Lno4kXHXVVg++NQLa4gXWjICGAcSLVklu1pGECo3Jfi
         eIbDebDkp0S6qUAK0/H96hYVD7oO0NjZ+xxCVLhnuCQKmCs3s2JHGLj9UvPAGrkjj4sN
         SN9FX7bwem5XwJxpLqoq5hvrkABTCResIj5goG9dpcxE6cQkUx62AdC65niDf44BzVRH
         kG37ocWchJrghGrGl7lUWiQgoJFhtME2GXMKm4xIUjlhMfbCz7qVzbU1dnXe9gM/aYlp
         DpqlD6YtCzPG3rLWWGWMaTghc4JEKO62ico7HcfvYlUKLDo2Qp9TElSCA0kqOscOMf0s
         yZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376963; x=1783981763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJj9x+KFWryKNgy0kpcNQKsjI8ajviFt4P6n+ALge6M=;
        b=Xndax3GUV3FjVIMVYQpakPx6LLSzSrDEWdDQWgoh41y0nE4C2ceAWaRrwJwgX1hN4r
         yPj7QQZd459mSQTvPSmXSlM3Ll6Bdpd16KDtvwDo3i2kMKwBjOxCpRRBIrNr4sW6dymn
         fMUSV58Ie0t1x8LMa51jDR0C9qOYeL/hd6rwO+o51tCAEL6/zTIEeWgQjdo8pGn8Jm/Y
         D9S/IDSDng0jAkC7VPG+KYD9bfsMZlLovMzbN5+E/1VxKKxVoMcTAfJ8r5o7r5kvvrEZ
         CnP1Pdt7l89AEgxLteREtj9P9mLjfidski6OMNgO9HozxBoFnLYJrebBhdr7rALNlCYo
         YCmQ==
X-Gm-Message-State: AOJu0YxRp9LSnMSLYzPuJ6IwNrJjZaWaSk0gwLv/ExFvEB4FVbhHq1WF
	m36WcFGAGAHRGm5DDdkwDf/LDlVvA2kqbzy+s0LyDltUqu976hI0H8M9B09k3kvr
X-Gm-Gg: AfdE7cktROCnftLXwTVVkpB80zD/1Y1rr63yyP66cBUmLHtoCrw5KDoNUMyQ1CvU/sU
	HAOOtmOLgVZthC9UbestY8OVRk4FAX1tUawUnDuE+RdTct+jzD1GnArA4J/zycAYYKha7Uu4rDt
	gbGDaDysd42VDquEi02BBBT9aH6hg1uRMPvgcPEETZzXlFE8TfSyjVN5qNWTvAQ/qwVDJf+hOlv
	LpGjxsMCMNaO4asejOUbwh6Oyo1DY4y/bhKVN5GR8aSjkCdjCX0C56HmRvLTbF48HOgChEM6Ps4
	B1lG+2NtZSMs6yx/EFe56yFZ4r7wEWxaq2j6c2qv9JXsRhd7k93x553tzWh4MuMC78t7WqPUs7r
	RD6lq0E/C1+oYPk+4/x8A25PQl9sAFsLHa0VtsFJgh/mdmtejCNVp3avaX0rRRxKHBPdabk3Hsf
	y71Lwks0E0Sctme+N2yknbMCTCfM8Q4MaWNM28oSIWDQnaxLPg7DktnAmhbn6hi8/vVg==
X-Received: by 2002:a05:620a:6607:b0:92e:70a4:2c5b with SMTP id af79cd13be357-92ebb5c420cmr356630985a.69.1783376962986;
        Mon, 06 Jul 2026 15:29:22 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:21 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 3/6] tests: add optional coverage reporting
Date: Mon,  6 Jul 2026 18:29:01 -0400
Message-ID: <20260706222904.664863-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4445

Add branch coverage of the wic source as opt-in just recipes, so a
plain run stays fast and quiet. coverage and pytest-cov join the tests
extra; the coverage recipe prints a terminal report of the lines that
were missed, and coverage-html additionally writes a browsable report
to htmlcov/. .gitignore ignores the .coverage data file and htmlcov/.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- expose coverage through just recipes (coverage, coverage-html)
  rather than run-tests.sh flags.
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore     | 2 ++
 justfile       | 8 ++++++++
 pyproject.toml | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/.gitignore b/.gitignore
index a0f016bc5823..e30cafa40f7f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,4 @@
 **/__pycache__
 .pytest_cache/
+.coverage
+htmlcov/
diff --git a/justfile b/justfile
index 41a9d3d236f4..1be3e01e7c7d 100644
--- a/justfile
+++ b/justfile
@@ -8,3 +8,11 @@ default:
 # (e.g. `just tests -k <expr>` or `just tests tests/unit`).
 tests *args:
     pytest {{args}}
+
+# Run the suite with a terminal branch-coverage report for wic.
+coverage *args:
+    pytest {{args}} --cov=wic --cov-branch --cov-report=term-missing
+
+# Run the suite with an HTML coverage report (written to htmlcov/).
+coverage-html *args:
+    pytest {{args}} --cov=wic --cov-branch --cov-report=term-missing --cov-report=html
diff --git a/pyproject.toml b/pyproject.toml
index e60c4fcc1595..2ad694b13358 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -24,6 +24,8 @@ Repository = "https://git.yoctoproject.org/wic"
 [project.optional-dependencies]
 tests = [
     "pytest >= 9.1.1",
+    "coverage >= 7.15.0",
+    "pytest-cov >= 7.1.0",
     "rust-just >= 1.55.1",
 ]
 
-- 
2.50.0.173.g8b6f19ccfc3a


