Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E74C43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:54 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24723.1782835614020880711
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oPXHG7Gu;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5cb052edso165794885a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835613; x=1783440413; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GynnNe/oliScUbaXjPQLVBOJFXzLoT7k1lO6apXO8Us=;
        b=oPXHG7GuMeoWKEySLrwRFSieVps61BFlzggV+HUM2JR1E+BGyJZS62rplr++1hb+ti
         hPAY0q61gXMt10gncVIkvQKMb0fpl9cowtcfcPoOLjZWW5NKBCsVo7vv1fCdSSsSZNzs
         sZ7OeYspI6nJY/GlK7ndfCTiCW0j1FTGBkrvxtzmzfnUv6v7gH0tlvzpywOhtNim534H
         A1FfZbrEOC21abSyMtyONVkaTSgsvxUWEz/hlvhptbm01KlNYNcMpkMOn2x5qZNmkBcQ
         7KqWRYx8oW+g+8BHANchXKPY2Lw9b2ibNzD1jPcS5Ip+AagNMnQLjpoAmrQAdaZxKlH5
         cePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835613; x=1783440413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GynnNe/oliScUbaXjPQLVBOJFXzLoT7k1lO6apXO8Us=;
        b=jtuhSv4mdRVk20atzeZJdmm7/sa/O+4O4/J0HDQyN/UwnXIRI+JwgccpeUG31l9KEo
         xMuQ+5oa1I6qtLoLr4aeTN89csWfwlfdHAOt8A9V4djUFA3QlCgO8yblFmaR+WkjLk9g
         vgUPftbg3C9fQxjCRGB4oSI1P0KBX6XuI9vff4Q4BXUPHtvLSbhKN4Mz1c+ydApXRpCH
         hZWU38lZTyrC0di8vWLL2GCrKKG1p+RlVuh63CflMxFvp7Iw4s47q71tWsmG0hZuu4Fh
         oq3Lmq0R44zC3eLtv5GwVk28cLGOb20F3zn3XL2CzTXdxdLQU9G6DkfjlC1V5NxMjAzX
         xHXA==
X-Gm-Message-State: AOJu0YxnBowcDZw5W491Pg0vaw3wUXxC7wnboQeJrScYtrVwQhFSbRu6
	RfJHER0PL3CJOg2bh+PEkyzryCd0G0/efi/pGX3DzdfDbQlCm3iygd33LqscaA==
X-Gm-Gg: AfdE7cnF6eOlqgETkTdGkHwzhYXBSSqlSHTx55Vx7W922g5It7vve6uWKyP4Onjbahu
	sE3yfKUHkvB09SpZ0z0EC/sESKqS4mhFL3eYlEmQidwK0IUyu6eTnOr59l6pq9bLUHPIt7sC0UX
	aG17VR19oUEGVYA0cBJF5KXIUUvqygm4F4zuEEGcllTr/LoWLkyxU6l9B9VoWvMo1Krs+ecuryM
	yQTMlrTOy3cHdqPmGJJb0DIlYd0+gWY+DU+PyIkwBOIRe8b2lcE7z3cuVTUtj2EvYBxLqXZXNvr
	6JrI2cpTd3GYRu/5Hx0BRYVbHXbM3lgy8LwYKWwuWZuls3UvcLKoOeqh7st7bK9uVeTvI8WmpAp
	V1mEHHdG9MnnaRnRt4mobRQ86rt6J/0bdT7JtU2q4DEIGc77+W77YUUULeJAGNMuTj7utN565rs
	tD6zoYP+nJp9aFuaetP0qrGoV57h2gZfvnXm90r/CILgyRaC2LmRG0gJQ=
X-Received: by 2002:a05:620a:1a11:b0:92e:56f7:c5fb with SMTP id af79cd13be357-92e624a9cd8mr692951285a.12.1782835612603;
        Tue, 30 Jun 2026 09:06:52 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:51 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 6/9] tests/docs: add the suite overview README
Date: Tue, 30 Jun 2026 12:06:09 -0400
Message-ID: <20260630160612.1005451-7-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4327

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
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 tests/docs/README.md | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tests/docs/README.md

diff --git a/tests/docs/README.md b/tests/docs/README.md
new file mode 100644
index 000000000000..7f59c9efb84d
--- /dev/null
+++ b/tests/docs/README.md
@@ -0,0 +1,61 @@
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


