Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F40C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:41 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39827.1782891635578378598
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ID9g7/p+;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so3001766d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891634; x=1783496434; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4hmg5VvGCKYkaikFV2t211sipeRXy9CxO7eX6Us2nI=;
        b=ID9g7/p+pHq8R7gcDeQoUo1RGKm3/rZU/SDsjoWTwvvkDTxZNFDgkrkL3XUyL5Igiz
         j+oXg5oenigxVF/r2zW5rgzRCb5heW00XkFXP+6j9BuuseggOdlsfu0sXWh50kZhhdpE
         83eeWAWNWlCSRusYaXd3PaN3RuR1rk8W5EUYCKIVhunvCa06+C03RcWEXZNWCNHuR8a9
         6xligYe8WT4AtSngrqvDHVGsi3g8hUciMo0Ot4AeELdL7TrF1pQGdzUXmQNnGmVyvntO
         c5IwxrD/wTsjTbUUPnzAooWs/9emyXwgdCpJKk+D76EGFhnfrlTVV+/+RPwyZENm6ScM
         VE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891634; x=1783496434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4hmg5VvGCKYkaikFV2t211sipeRXy9CxO7eX6Us2nI=;
        b=BTW9SdkxF8JtGN6wVSuStmXO+Y0WpJY390848KbhlApbifjg60c4NQZO9ij5sxmdnF
         HfWyvf6qcbcza6BoNC6FlAJux7ZtPvcc15ufWomqissxdzfMsRCgrTQwgr4ophxd4h56
         k/YzVBoVJg1O9vIVElgPKFzyI+P6fiJml7PDuLFpVoFG3jXw5kThSCswDMCRxS7EG0FR
         jsJl3aiF7lcCX3GCd6pHoNTeSryFyMA4w7Q5digSvpomPMdghPoIr8ZenKEoonP+VRj5
         R/5WjNbwkE5ekFrAdQlNJObnLn8AmY+qYyBJHyjVoWV7LkqaOtWQ9tPWT0PYrSHaqRsL
         IW9w==
X-Gm-Message-State: AOJu0YwL+XVT5fEB9WEyBalFqz2vewnedXBawVS8wdnv+ZanoCvm95iV
	Tx28qvifW6XlMU4fzvhgscyyWJ9ThaG7+Bl/lXYDF/ohvhS8myYVSkvudmxXlg==
X-Gm-Gg: AfdE7cmGualfb0/uJP4+OZNz1jApR3mPTJtAPR1C/jKPanbpiZ+VKLjZnhvbbzGbA34
	IMbj7r+GGWfeL6efPRY0ybL2du84z1CquMrZwafYUlQ2ux846iXxCJnj4Ut7qZQmItnwp1zkQoz
	izXowV4Nm7o1sGzW6g6o6NQnwU9QHS1CXxUtTG7JraItRLuwuHrCRQuiTBhYIOJakB1lmIqrFl4
	+AWnGlvPev0NtMySQCawhYQKyoJnaFHrwAUe/c8wXjaFJeId0McllZgseAVYAxPMFI29RW0DEuf
	0QwAcEwO3nyZ4r5iL/GqbNJWYkaa9+morXH1QJD+WcRY5+ejZTUfw6CwygQALyOWNHqZtOGtyhr
	b8YhqMQZ75bO5er2zD8cqRhkHeB9RkG9l+oOA/VKy64oryRmgsaWpmM/zjwascPDhxm9Wupb3hW
	8aVTzumBWExy9ez9QfZuxz7a4KyQTzrGB+kSjt4/Wn/kdxk1iuH4KWPqs=
X-Received: by 2002:a05:6214:5685:b0:8f1:74b0:a4ec with SMTP id 6a1803df08f44-8f3bc91c5a7mr6662256d6.4.1782891634374;
        Wed, 01 Jul 2026 00:40:34 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:33 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 00/10] tests: standalone test-suite framework plus the first unit test
Date: Wed,  1 Jul 2026 03:40:20 -0400
Message-ID: <20260701074030.1090807-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4332

v1 sent the whole test suite as a single 6000-line commit that leaned on
xfail markers to record the bugs it found. Review feedback was that this
is not reviewable: the request was for a series of small commits where
each test lands green next to the source fix that makes it pass, with no
xfails and no failing tests at any commit boundary.

This series is that rework. Rather than resend the entire suite at once,
it establishes the test framework and a single representative test so the
structure and conventions can be reviewed first. Later functions will
follow as their own per-function commits once this base is agreed.

The series contains:

  - the suite skeleton (pyproject test config, layout, .gitignore,
    README Testing section);
  - the conftest session banner;
  - the run-tests.sh wrapper, with optional coverage and ruff linting
    added in their own commits;
  - the suite docs (overview README, authoring guide, and review rubric)
    and the one ruff per-file-ignore the sys.path bootstrap needs;
  - the first unit test, tests/unit/test_bb_utils, which tests
    mkdirhier() and carries the one-line errno-import fix the test
    exposes, so the suite is green.

The whole suite is green at every commit (zero failures, zero xfails)
and tests/run-tests.sh --lint-tests is clean throughout.

Changes in v3:

  - tests/unit/test_bb_utils now uses pytest's tmp_path fixture instead
    of tempfile.mkdtemp(), so the tests no longer leak scratch
    directories under /tmp.
  - the suite README documents the standard pytest scratch-directory
    controls (TMPDIR and --basetemp), so no custom temporary-directory
    variable is needed.
  - a new commit adds tests/docs/reviewing.md, the rubric a test change
    is reviewed against, linked from the suite README.

Trevor Woerner (10):
  tests: add the standalone test-suite skeleton
  tests: add a session banner via conftest.py
  tests: add the run-tests.sh wrapper
  tests: add optional coverage reporting to run-tests.sh
  tests: add ruff linting to run-tests.sh
  tests/docs: add the suite overview README
  tests/docs: add the test-authoring guide
  tests: ignore E402 in the test tree for the sys.path bootstrap
  tests/unit/test_bb_utils: test mkdirhier() and fix its missing errno
    import
  tests/docs: add the review rubric

 .gitignore                  |  10 +++
 README.md                   |  15 ++++
 pyproject.toml              |  30 +++++++
 src/wic/bb/utils.py         |   1 +
 tests/conftest.py           |  38 +++++++++
 tests/docs/README.md        |  83 ++++++++++++++++++
 tests/docs/authoring.md     | 124 +++++++++++++++++++++++++++
 tests/docs/linting.md       |  59 +++++++++++++
 tests/docs/reviewing.md     | 164 ++++++++++++++++++++++++++++++++++++
 tests/run-tests.sh          | 159 ++++++++++++++++++++++++++++++++++
 tests/unit/.gitkeep         |   0
 tests/unit/test_bb_utils.py | 116 +++++++++++++++++++++++++
 12 files changed, 799 insertions(+)
 create mode 100644 tests/conftest.py
 create mode 100644 tests/docs/README.md
 create mode 100644 tests/docs/authoring.md
 create mode 100644 tests/docs/linting.md
 create mode 100644 tests/docs/reviewing.md
 create mode 100755 tests/run-tests.sh
 create mode 100644 tests/unit/.gitkeep
 create mode 100644 tests/unit/test_bb_utils.py

-- 
2.50.0.173.g8b6f19ccfc3a

