Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9AFC43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:44 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25077.1782835600561329611
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=J0zFn8CS;
 spf=pass (domain: gmail.com, ip: 209.85.222.42, mailfrom: twoerner@gmail.com)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-966d7738c3bso3100700241.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835599; x=1783440399; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=leJUCEtgwp18wtcNtEU3avZfMg5q7SCaj3+thS2daQc=;
        b=J0zFn8CSn098NOcm7q/N4Yy+m7OAM3F3Pj6DC1sIURW62rGo8DZL35D70BGhdCeeB7
         wijsikbKm4XEzcXZP7Nyi69r1yAMKo2cmLwA3bL8u0OmMFQiRHH9EQ9OyHKJAJCM+sKh
         0Qczl3cxX1zIbRnSWtl88IfkKUDhyLv0VqUC80pabaG7+x+sxaOabgz8MvjNXFBeBHZl
         VVrh0kUbx91FVfzQPNOp9Y20On5c3ITVIiSUxN9ZJ0o/XXgS7z1Tw10VnqSvwkwNyXd5
         S2LWCv0d2GbYSok0qKWlIZE5+S4HkzsfryOYQ5+MJG08BSMwm71jK1jzvkpMv3mA+lHT
         qRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835599; x=1783440399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leJUCEtgwp18wtcNtEU3avZfMg5q7SCaj3+thS2daQc=;
        b=e7x3s12Pr5tWj29+JR9NSzTFG83PVSUAi/VsnZKCa6LoX1K5YMaeA48t9HlQYiMMiw
         anR8z8+MwkCpDfM81ZKXJVADDmsB8sf7B+8YlZctrWtLtI1lzxxHlhABwtsjxlPfxSBy
         yKwo7tkseflNOYSi1PqqFWyPiB16bNPaldhFyQBpXSOaXTnBeqhLgef51QaHIQf08flc
         f+TqyLV9Z6iajHmC5ZXAD8zwIaoI40TQaZ9cm050ShuBc3N9BXH3DijQFYbEuIrAH892
         R9pZxpavQgOV4Y+g/NrPJ7Gpy/uPt14oy76GrBJ0Q1oYyDZl+oWI0jKMs60GCYPb3fmP
         mzDg==
X-Gm-Message-State: AOJu0YwvcDEX8F+8PpPfVvbhcYRGYjXcqYdUgxbEVzDdI7eWPZB3EAVL
	HfyyEe2P3EB8xjwOdR4C+d3B4d/zfCCUFjVF355KjL6ShQhIUOsM5JEP0ZQAvA==
X-Gm-Gg: AfdE7cl5UnVmePrRhveeWwCTDXzkW4LmhkUwKD5U/U9sXJypiecoYSWKu6oMk5NkWPm
	Eq8fcOnscRjZ7hl7CpTT/bvhhfEZUudPydVEvmAf9GjEjQZy3BWIDGyqY8fiU1ebepHr2ffDWRY
	jTfMMxjDEFkfa/W20tJ0ycLXbinRmw6S9B3vQ2D8wSkVG4IXsBXUbVNhAdi1LPsUkEHulM0Ng7w
	dX6hlIdNdnmAhz9CMfYF9tlTCcBtydvlqdkhhIHONfAlDQQfKjUXaEUOW8bya1hDw1WmmU66Cgl
	YSx624/6LBkUVuvuM/0de0ITMkQQ0sFoGbPLN0Zau8Bmwk7VoGYf1DQhcK0Qs6Dub+c++8mGvO1
	/PcQe1minhLAkvSHwc25vlasQ1Cz47p6rjcEqIEjSjrvd0nMN4dRJYg3rccNv8j08VIdBw1eHea
	iy7Upcr1kXI3T0htfg6Mp0buANQpxoHaMRc6c70HdXOMF6/mMSS5lzi5g=
X-Received: by 2002:a05:6102:50a9:b0:738:c9e1:c58 with SMTP id ada2fe7eead31-73a38c390ccmr2574803137.28.1782835593353;
        Tue, 30 Jun 2026 09:06:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:32 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 0/9] tests: standalone test-suite framework plus the first unit test
Date: Tue, 30 Jun 2026 12:06:03 -0400
Message-ID: <20260630160612.1005451-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4321

v1 sent the whole test suite as a single 6000-line commit that leaned on
xfail markers to record the bugs it found. Review feedback was that this
is not reviewable: the request was for a series of small commits where
each test lands green next to the source fix that makes it pass, with no
xfails and no failing tests at any commit boundary.

This v2 is that rework. Rather than resend the entire suite at once, it
establishes the test framework and a single representative test so the
structure and conventions can be reviewed first. Later functions will
follow as their own per-function commits once this base is agreed.

The series contains:

  - the suite skeleton (pyproject test config, layout, .gitignore,
    README Testing section);
  - the conftest session banner;
  - the run-tests.sh wrapper, with optional coverage and ruff linting
    added in their own commits;
  - the suite docs (overview README and authoring guide) and the one
    ruff per-file-ignore the sys.path bootstrap needs;
  - the first unit test, tests/unit/test_bb_utils, which tests
    mkdirhier() and carries the one-line errno-import fix the test
    exposes, so the suite is green.

The whole suite is green at every commit (zero failures, zero xfails)
and tests/run-tests.sh --lint-tests is clean throughout.

Trevor Woerner (9):
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

 .gitignore                  |  10 +++
 README.md                   |  15 ++++
 pyproject.toml              |  30 +++++++
 src/wic/bb/utils.py         |   1 +
 tests/conftest.py           |  38 +++++++++
 tests/docs/README.md        |  61 ++++++++++++++
 tests/docs/authoring.md     | 124 ++++++++++++++++++++++++++++
 tests/docs/linting.md       |  59 +++++++++++++
 tests/run-tests.sh          | 159 ++++++++++++++++++++++++++++++++++++
 tests/unit/.gitkeep         |   0
 tests/unit/test_bb_utils.py | 126 ++++++++++++++++++++++++++++
 11 files changed, 623 insertions(+)
 create mode 100644 tests/conftest.py
 create mode 100644 tests/docs/README.md
 create mode 100644 tests/docs/authoring.md
 create mode 100644 tests/docs/linting.md
 create mode 100755 tests/run-tests.sh
 create mode 100644 tests/unit/.gitkeep
 create mode 100644 tests/unit/test_bb_utils.py

-- 
2.50.0.173.g8b6f19ccfc3a

