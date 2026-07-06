Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07DC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:25 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162833.1783376958168809377
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NiuImQOB;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f23e851626so28910796d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376957; x=1783981757; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xqo5i5Kx31NrZlkwm2FjDc8ob/Cj5Wl06skah07Zkk=;
        b=NiuImQOBnFqll3ZYT/n7LHr4ZkoE6e+YdOlKytu4R6RiA0bKOtCSaipmHRClK6Y3TS
         xpLRjR3vL7hnXytTYqn0I37cecK+gpfsQ0cwdQOgSPy9ArRI9XSDJFGTh1wMVw9MgAMe
         vD93EbKWZpZpYRbSLGcxQc6XvGTRiSMuWtrtOfzYwzmaNF2wx7sdrGtW5xDu8vaTIFiT
         LdvzwG5JI5AERvhZdPCJJFYlyupYm/A9U8pP+IKpTJEOqkBUJjvxeYhZxz/x2xvHHhCH
         yaXo1y2vZO6tsaZ2+QPPwsdT1s7xCYo5hMO4ood1rK8lLg5+T40yr5rEbjb9gegxy5Tx
         DKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376957; x=1783981757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xqo5i5Kx31NrZlkwm2FjDc8ob/Cj5Wl06skah07Zkk=;
        b=PeEUJvln475olqwktRV2hHeX1xytif5mo2LrRfCZx2S5Ckdq4wJIgRhLLpltMxpGLS
         8pcFuVZskqmhh7B7yPwd13om6rgmW4jNLzHZ+Ls4hQh8+kYL+kxieAaCdCdWa50gHSKK
         3EawgVC6ZXdn/QvczD/Qbqcj3oqvJ9gzMCEJV8KUeRT3UoXAe+IaJQ/X7a6hFXxH41iJ
         mi9MNAuQD0si5KQZ7H9pdH8X4sxTL6r09fOv/PwitW+uYg4EqVh3xkWO2AiGwkTU7BjE
         TAHaSClSoaqhi3b7g5/t7koWgvaU00V1mhCiLe4IsSw9Be2+a/DvD/p9hMHMIqRSE61v
         WQtQ==
X-Gm-Message-State: AOJu0YzqVe9/hQ2ui2s4A9T3zghxszmh4326um1jyigqwNQpAY+Mw1j4
	zuBjpfFNaCMGiiVdaT/BWmai1BB3SLxduMMhVgW7LERXOx61HEW7kQONPfB6thRP
X-Gm-Gg: AfdE7cnDJITcIr/iVV4bU7haYSrOeISnAgrR6VFWIYQ1luP9Y+XUV62SLTsDca/WO+3
	8nV1pQaDpMB8iXRlrKB6lm0cgPQ4+Rt9y9Rn8exgYuCnqQAtVGAafGYbMwlmAA/jjHlYuGPQdyh
	LjgEQfv89GqWqXlYVU1vdpfBvBCOJWe39h9BM834Q0EV6uo6xRUBczgwP2QM6pw1RCc5LXPosch
	ECJqJCp68oVSr0gq0SK0xkpwTdxQ6fM1O/jSBoZLvu4fkJOA2fos7eBYG8i+aJ49b1PSrCncXHt
	nNz8oF8H8Wo7nKCqmy8Bj0xF7mCNbyJYzW4fOvKj1Kcythiu5Rq5R7qbnVrlUcTI4sCN3VUls9L
	JJBEmaTNBOgUvrZpDhRqS6qopf8EZKBPiYVdgGZA1HzoWc9koQ0jYJEdv3eD8JfNndT4j7O8Y79
	3hDTQ3ognPni868BuXVUyHhV0rCROqQqBRjLdAaQ1QLbNztx1cAMqELbm45RHRbttC4A==
X-Received: by 2002:ad4:5aa1:0:b0:8f0:1375:93e with SMTP id 6a1803df08f44-8fcb54d2e3cmr34706146d6.44.1783376956854;
        Mon, 06 Jul 2026 15:29:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:15 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 0/6] tests: standalone test-suite framework plus the first unit test
Date: Mon,  6 Jul 2026 18:28:58 -0400
Message-ID: <20260706222904.664863-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4442

wic has no test mechanism of its own; it relies on the oe-selftest from
oe-core, which needs a full bitbake build to exercise even pure-Python
logic. This series starts a small standalone suite that runs from a
plain checkout, framework first, then the first fix, and its test.

  - the suite skeleton (pyproject test extra, pytest config, layout,
    a justfile command runner, and a README Testing section);
  - a conftest that imports wic once up front (stopping the session with
    a clear message if that fails) and prints a session banner;
  - optional coverage and ruff linting, each exposed as just recipes;
  - a one-line fix to wic.bb.utils (import errno) so mkdirhier's OSError
    handler works, as its own commit;
  - unit tests for mkdirhier() that pin its behaviour and catch that
    bug.

The suite is green at every commit and the test tree is ruff-clean.

Changes in v4 (in response to review feedback, thanks to Paul Barker):

v4 restructures the v3 10-patch series into 6 patches. How the old
patches map to the new ones:

  - v3 1/10 (skeleton) -> v4 1/6, which also gains a justfile command
    runner in place of the run-tests.sh wrapper and no longer creates a
    tests/docs/ tree;
  - v3 2/10 (conftest banner) -> v4 2/6, which also absorbs the
    wic-import check (see next line);
  - v3 3/10 (run-tests.sh wrapper) -> dropped; the justfile replaces it
    and its wic-import check moves into conftest, so the check runs on
    every invocation rather than only through the wrapper;
  - v3 4/10 (coverage) -> v4 3/6, exposed as just recipes;
  - v3 5/10 (ruff linting) -> v4 4/6, exposed as just recipes, with
    ruff now pinned exactly so the clean-bar gate is reproducible;
  - v3 8/10 (tests/** E402 ignore) -> folded into v4 4/6;
  - v3 6/10, 7/10, 10/10 (docs README, authoring guide, review rubric)
    -> dropped; the suite ships a short README Testing section instead
    of a tests/docs/ tree;
  - v3 9/10 (test plus folded-in errno fix) -> split into v4 5/6 (the
    errno fix, on its own, first) and v4 6/6 (the tests), and the tests
    are reframed to target mkdirhier's own behaviour rather than
    re-testing os.makedirs.

Dependency versions were also refreshed to current releases.

Changes in v3:

  - test_bb_utils used the tmp_path fixture instead of
    tempfile.mkdtemp(), so the tests no longer leaked scratch
    directories under /tmp;
  - documented the standard pytest scratch-directory controls (TMPDIR
    and --basetemp) rather than a custom variable;
  - added a review-rubric doc.

Changes in v2:

  - v1 was a single ~6000-line commit that used xfail markers to record
    the bugs it found; v2 broke the work into a reviewable series where
    each test lands green next to the fix that makes it pass, with no
    xfails.

Trevor Woerner (6):
  tests: add the standalone unit-test suite skeleton
  tests: add conftest with a wic-import preflight and session banner
  tests: add optional coverage reporting
  add ruff linting
  bb/utils: import errno so mkdirhier's OSError handler works
  tests/unit/test_bb_utils: cover mkdirhier()

 .gitignore                  |  4 ++
 README.md                   | 15 +++++++
 justfile                    | 27 +++++++++++++
 pyproject.toml              | 24 +++++++++++
 src/wic/bb/utils.py         |  1 +
 tests/conftest.py           | 28 +++++++++++++
 tests/unit/test_bb_utils.py | 81 +++++++++++++++++++++++++++++++++++++
 7 files changed, 180 insertions(+)
 create mode 100644 justfile
 create mode 100644 tests/conftest.py
 create mode 100644 tests/unit/test_bb_utils.py

-- 
2.50.0.173.g8b6f19ccfc3a

