Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5083C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:41:01 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39838.1782891653478339622
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bS15sLf3;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8e9c9d63815so2175226d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891652; x=1783496452; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3BkQMZhZStIsv6P9kXJlKtdsa8KzwetRzr3UKOFwuQ=;
        b=bS15sLf3bVC8TmNtQD8vQ5kdyKDvkciroF+d2lTSlnqnhskbrc+emZHMr2CNefoImH
         b9n3mcHHSRTEMUvYeVq6oAgn1WuUqnEZPFh4Ppzsv2Ea3zubJu45C7LOZbfTd/2fxiTg
         aFKKsXMJ4fKSFlGtnAJJMWl1KscRIMoEoZHuv/ZxsbaHhAPO8mqWv2bX7x4alVqrGLyb
         /Rq2zdKaMkTFIOI2GxiVlBvv84vyPd/x95Bg+3vNtEudLqqd8O0G15gQkt4slZbeeaKh
         blo5HRXHy9uRgWEF3hDdjCiwgQ0oc51SrB+lYFm8edeIdROlQqx72kNm5Y0Sa+NfqDHn
         2Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891652; x=1783496452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3BkQMZhZStIsv6P9kXJlKtdsa8KzwetRzr3UKOFwuQ=;
        b=NmNalezAbQ5Awd8lL+zpWxboIzbYBOdR3xRFbKixX4SvuZ4wzRfkdwCNzMhhknZjce
         cjL/JpswAE8RUPY6v3kHFecfhMSnjiI38bWrzAZniYGtPUYGfLAcS09DU/blSJX9Djq7
         /099JIR37jvgj7EH5C1VOIjZwSV+Amrt2rUzEhPAPb0yFovrhoQ3nf2gPMDT7TA2+4CS
         a8gvfmtvY7D9YSYpXZh4fM3Vw0LCaPDElYiDLN27B2mwCTPnicR4L9DkAcipyNoRn8Hl
         2t6P1b9FKqOblJTIvdafWnWZFpfxRodyqm/epnZa9cUxjqBME79gacCGeI3pa7TeuNO/
         Udvg==
X-Gm-Message-State: AOJu0Yxe3mEUvn6ADRlnFbGxj9PeCKV0PBeINcVkkrshk7S4A06Jx5To
	TZe369scTuOshv6FfL4+mHU8Y2kb48zV1BixCncZT+uOUZxXklDCn5Od6lmtag==
X-Gm-Gg: AfdE7clUQagpd4gVnKXjlw5bIoN50yD93BNwFeA0rkTABqZb8Jo6Rvs8NZtutkzWR5u
	cP8ECg6KCad7lqg0L5deKNdbqrddyOOpVHnwDAQ5ms6lTCXM/vyjrjSvWZIglTcAqr0rDyLtJRu
	HNnyu5BvKzFvHH6bCUCz1vmOkG/B+DzluonHLCry7qtF2qBN9VMl1LWTSukCEfz6gOpUnWKoHNs
	Jg19PSYbpUeFFfEbaUG1NCasFvM8YlCN5gskb1T5MmYeS3btZojnbL1l18kNLL9cVe+k3kqWRn1
	OPKJg4NUobEQnLkTfU+cWMfq0N4bE9SGO4K/KpEveIqlxSjDZPBAEY2yyB2UECZrup+MN88Hf5y
	lSji9trhumdTHBnkqWF+4sLlm32qmkuN3EEbRPsaetVJuOmuOfegztzNHMy85IkVGix+jeHSB3G
	BVsUwmZVvTu8r57jjxTGWAvwRVAOdW3Ksux3y6M3eGPRCiy8fnxSxOHpI=
X-Received: by 2002:a05:620a:1a26:b0:915:cb40:f76a with SMTP id af79cd13be357-92e782c44c1mr74431285a.39.1782891652131;
        Wed, 01 Jul 2026 00:40:52 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:50 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 10/10] tests/docs: add the review rubric
Date: Wed,  1 Jul 2026 03:40:30 -0400
Message-ID: <20260701074030.1090807-11-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:41:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4342

The suite already documents how to write a test (authoring.md) and how
it is linted (linting.md), but not how a test change is judged. This
adds tests/docs/reviewing.md, the review-time companion to authoring.md,
so the standard a change is held to is written down where both
reviewers and contributors can see it.

The rubric records the conventions the suite is built on:

  - one function per commit, with the subject keyed to the test file;
  - a test asserts the correct behaviour, and when it exposes a defect
    the source fix lands in the same commit rather than as an xfail or a
    test that bakes in the wrong result;
  - a fix must be proven to matter by backing it out and watching the
    test go red;
  - the suite is green and lint-clean at every commit, not only at the
    tip of a series;
  - assertions are specific, boundaries are probed, and an assertion is
    never weakened to force a pass;
  - coverage is read as a guide to untested branches, not a score;
  - each commit message stands alone and references no other commit.

It closes with a short reviewer checklist that collects those points,
and is linked from the docs table in the suite README.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- new in v3: adds tests/docs/reviewing.md, the review rubric for a
  test change, and links it from the suite README.
---
 tests/docs/README.md    |   1 +
 tests/docs/reviewing.md | 164 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 tests/docs/reviewing.md

diff --git a/tests/docs/README.md b/tests/docs/README.md
index ba7bd5e192a3..d44212a287ab 100644
--- a/tests/docs/README.md
+++ b/tests/docs/README.md
@@ -79,4 +79,5 @@ treated.
 | File | Content |
 |------|---------|
 | [authoring.md](authoring.md) | How to add a unit test to the suite |
+| [reviewing.md](reviewing.md) | How a test change is reviewed |
 | [linting.md](linting.md)     | How ruff is used on the suite |
diff --git a/tests/docs/reviewing.md b/tests/docs/reviewing.md
new file mode 100644
index 000000000000..a9b002a6dabd
--- /dev/null
+++ b/tests/docs/reviewing.md
@@ -0,0 +1,164 @@
+# Reviewing a test change
+
+This is the rubric a reviewer applies to a change that adds or edits
+tests, and the bar a contributor should meet before sending one. It is
+the review-time companion to [authoring.md](authoring.md): authoring.md
+says how to write a good test, this says how such a change is judged.
+
+## Contents
+
+- [One function per commit](#one-function-per-commit)
+- [Test and fix land together](#test-and-fix-land-together)
+- [Prove the fix matters](#prove-the-fix-matters)
+- [Green at every commit](#green-at-every-commit)
+- [Assertions and boundaries](#assertions-and-boundaries)
+- [Scratch files](#scratch-files)
+- [Coverage](#coverage)
+- [Commit message](#commit-message)
+- [Reviewer checklist](#reviewer-checklist)
+
+## One function per commit
+
+A commit covers one function under test. A module with a single
+function is one commit; a module with five functions is five commits,
+one per function. All the tests for that function (happy path, guards,
+boundaries, error paths) belong in the same commit, because they share
+the function and its setup; do not split a commit per assertion.
+
+The subject line names the test file and the function:
+
+```text
+tests/unit/test_<module>: test <function>()
+tests/unit/test_<module>: test <function>() and fix
+```
+
+The second form is for when a fix to the wic source rides along (see
+below). Keep the subject short: it says only "and fix", and the full
+explanation of what was fixed goes in the commit body. There is no
+leading `wic:`; the subject is keyed to the test file.
+
+## Test and fix land together
+
+A test asserts the behaviour wic is *expected* to provide, never the
+behaviour it currently happens to have. When a test exposes a defect,
+the fix to the wic source lands in the same commit, so the test asserts
+the correct behaviour and passes. A change that adds a test asserting a
+known-wrong result, or that marks a failing case `xfail` to defer the
+fix, does not meet the bar: it either bakes in the bug or leaves a red
+test behind. Reject both.
+
+## Prove the fix matters
+
+When a commit carries a fix, the test must actually exercise the bug.
+The cheap proof is to back the source change out and watch the test go
+red, then restore it and watch it pass:
+
+```bash
+git stash push -- src/wic/<file>
+tests/run-tests.sh tests/unit/test_<module>.py   # the new tests fail
+git stash pop
+tests/run-tests.sh tests/unit/test_<module>.py   # the new tests pass
+```
+
+A test that stays green with the fix removed is not testing the fix.
+Either the assertion is too weak or the wrong code path is exercised;
+in review, treat that as a finding.
+
+## Green at every commit
+
+The suite is green at every commit boundary, not just at the tip of the
+series: zero failures and zero `xfail` markers, with
+`tests/run-tests.sh --lint-tests` passing 100%, reporting nothing. The
+test tree is held to a clean bar; a single lint finding fails the
+commit. A series that only goes green at the end cannot be bisected and
+is not acceptable; check intermediate commits, not just `HEAD`.
+
+`--lint-src` is a preview report over the wic source, not a gate (see
+[linting.md](linting.md)); findings there do not block a test change.
+
+## Assertions and boundaries
+
+Every case asserts a specific outcome, an exact value or a specific
+exception, never merely that nothing was raised. A test that only
+checks for the absence of a crash passes against badly wrong output and
+gives false confidence.
+
+A good test probes the boundary of each parameter and just past it,
+rather than only the comfortable middle of its range. The classes worth
+covering (empty, zero, negative, maximum and one beyond, wrong types,
+path traversal, stale state, and so on) are enumerated in
+authoring.md under "Probe the boundaries"; in review, look for the ones
+that matter for the function at hand and note the ones that are
+missing.
+
+If an assertion was weakened to make a test pass, the change is going
+the wrong way. The answer to a hard-to-pass test is in the code or in
+understanding the correct behaviour, never in loosening the assertion.
+
+## Scratch files
+
+A test that needs scratch space uses pytest's `tmp_path` fixture, which
+gives each test its own directory and removes it automatically when the
+test passes (a failing test's directory is kept for inspection). A
+change that reaches for `tempfile.mkdtemp()`, `/tmp` directly, or any
+other hand-rolled scratch path is going the wrong way: those leak
+directories across runs and are worth a finding.
+
+The scratch tree lands under the system temporary directory by default.
+To send it elsewhere, when `/tmp` is small or a run produces a lot of
+scratch, use the standard pytest controls rather than a custom setting;
+both are passed straight through by `run-tests.sh` and are described in
+the suite [README](README.md#scratch-files):
+
+```bash
+TMPDIR=/path/to/scratch tests/run-tests.sh
+tests/run-tests.sh --basetemp=/path/to/scratch
+```
+
+## Coverage
+
+Coverage is a guide, not a score to maximise. Run it for the module
+under review and read which lines and branches the new tests reach:
+
+```bash
+tests/run-tests.sh --coverage tests/unit/test_<module>.py
+```
+
+Use it to confirm the boundary rule above was actually met: the
+function's own guards and error paths should be reached, not just its
+happy path. A reachable branch of the function under review that no
+test exercises usually means a boundary case is missing, so the fix is
+to add that case, not to chase a coverage number. A branch that cannot
+sensibly be triggered is not a gap.
+
+## Commit message
+
+Each commit stands alone. The body explains the function, the tests,
+and, when a fix rides along, what the bug was, why it was invisible
+before, and why the test and fix must land together; a short failing
+snippet helps. Do not reference other commits by number or hash, since
+the series may be reordered or rebased and such a reference would go
+stale. When a fix rides along, the body is where the fix is explained
+in full, since the subject only says "and fix". Do not weaken the
+explanation to save space: a reviewer reading the commit in isolation
+should understand the whole change.
+
+## Reviewer checklist
+
+- The commit covers exactly one function, with the subject in the form
+  above.
+- All of that function's cases (happy path, guards, boundaries, error
+  paths) are present and each asserts a specific value or exception.
+- If a fix rides along, it is in the same commit and the test fails
+  without it (verified by backing the fix out).
+- No `xfail`, no test asserting a known-wrong result, no weakened
+  assertion.
+- Scratch space uses the `tmp_path` fixture, not `mkdtemp()` or a raw
+  `/tmp` path.
+- The suite is green and `--lint-tests` is clean at this commit, not
+  only at the tip.
+- Coverage confirms the function's own guards and error paths are
+  reached; any reachable but untested branch is treated as a missing
+  boundary case.
+- The commit message stands alone, references no other commit, and
+  fully explains any fix that the short "and fix" subject only names.
-- 
2.50.0.173.g8b6f19ccfc3a


