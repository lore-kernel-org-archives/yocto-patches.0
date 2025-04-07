Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E83C369A3
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 19:14:23 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.56756.1744053258303300634
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 12:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P1Dn+/MM;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so6952430a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053256; x=1744658056; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wor00SAvxgFXcef/ss+9aEsIbuhqyrkJMRHk09R/o4=;
        b=P1Dn+/MMj1uF3uhgwsQDHyyCa/ywAM3elLxcJlQoT5Cd1ov8liANv8cu4XHvmodeb2
         5Xj2ue9Xxnx0C1MoJXE5+NlcoXv9IvLq3qHsvroBDJCNm27QdDjf3xUY6U9YKUc/gqFC
         iZ+pQyi4wiwSDF4gHSL4ve2VaPBs6zinQJ8UUiJsNw44FEkkeJzyZzHBP3uZ4jWUqGpm
         +bVQcfuA3wnuQjjRzENY2t5mpSUFBo2YF3JL04M9/r8Q+IWCCJlxUea+09WP+YlsySkE
         FIiNDX67/LwpMrvUiH+KlzUsRdWhPcWmbvxT+2g2oxMJiZe6qxnp3DWcwfyN/Ev7WbiV
         +Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053256; x=1744658056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wor00SAvxgFXcef/ss+9aEsIbuhqyrkJMRHk09R/o4=;
        b=L5JAWfch0acjk5ZJdD94Pn8Sj/iLq34JN0oDx8vpG4XoFtoR1UbOXcbRiAM6YuBUWH
         6X4QorC8j3yJ/XuuULaDbn+7wCYvoBwlOZLdCDl2tD9J1bpWmB3cFwuLxnVQTTumx2Yn
         mu0c25gryVBKNG4qIWM4yb4yJmNAIsvnOEbpy0DimYX5FaejW/lPFFTUV/iWkTTn9qb7
         r2yAv+cgFhKtgj9dgWakV9KbmGLd1oCo6UfdrQ6Cjqw3boHpJvSAz6+2UynE1QsIBrSh
         4+LomT5LvtGqt6EVUEMCaEZ2Dcggt7Jbp2g3T+jBlCZraM0hFoO99cYFeVRH6Q9JXQ8p
         8s6g==
X-Gm-Message-State: AOJu0Yx3E52OEpumkVtQz4v5Z1yyLoHe1JJCnPrVLFR7hvWEstvRRU1/
	uVmk6UDTPtiCQp5pOgyOUBB5TFqVdCLTBkFcO1PJTILoEYXwZ1ewvQye5A==
X-Gm-Gg: ASbGncurUsKTVyHxdxmPXbZipT+trJwYT8b1DYs9dcqglz93xZkEQZ2sO4XPIt2K+jY
	69IMRXXYGBkEKR3PwH5EwUNUS4dHMJ7hiQaMIBjo3FHxLZ6a9ydkwoI15vVhQNMsVzJ9jGE1Ucw
	WHxq6uK4/jNl46psSodWB9aSqCJSqbJw52/mzffnrnfhQbCsJOLp3CKrx/zZ0MByDgtNGKw+07C
	UrB0yi4QOm8U8PcXZs+O70Akm+/7f8gizLJ08SXFwzuCz3b/RZWbiLIXx3YbaG9p00UcYMnF+3B
	ILiCPBfOQnZz2KTrjVo5P9IOmvn/zZH2wy9y5UsFUZ6XNzorwxLBD2r4LlJETBDnGkk3+VI=
X-Google-Smtp-Source: AGHT+IHfDagyKF7rNwBtMIyJMEzihGJB9kDrF0uDL0L0Y2w/NIwBg3Mci841653RMmyb5qQJmBEiMg==
X-Received: by 2002:a05:6402:1cc1:b0:5ed:9982:5484 with SMTP id 4fb4d7f45d1cf-5f0b661ac15mr10038790a12.23.1744053256164;
        Mon, 07 Apr 2025 12:14:16 -0700 (PDT)
Received: from localhost.localdomain ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087eedf61sm6916078a12.32.2025.04.07.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:14:15 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: landervanloock@gmail.com
Subject: [pseudo][PATCH v2 0/2] nftw, ftw: add wrappers
Date: Mon,  7 Apr 2025 21:14:12 +0200
Message-ID: <20250407191414.2992785-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 19:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1297

This is an (attempt at the) implementation of the nftw and ftw[1] calls in pseudo.

The main motivation is a change in btrfs-tools[2], in which
they have changed from walking the filetree and calling stat
on each entries separately to using the nftw call. As a result,
btrfs filesystem generation currently happens with incorrect
ownership details, as the nftw calls go around pseudo.

See also the relevant report[3] on the Yocto mailing list.

The main idea: with a custom wrapper capture the nftw call, and switch the callback
to our own callback. When our own callback is called, fix the received
stat struct, and call the original callback, this time with the correct
stat struct.

Big thanks to Lander Van Loock, who not only reported the
original issue, but also helped testing and reviewing the first version
of the code.

Please let me know what you think.

[1]: https://linux.die.net/man/3/nftw
[2]: https://github.com/kdave/btrfs-progs/commit/c6464d3f99ed1dabceff1168eabb207492c37624
[3]: https://lists.yoctoproject.org/g/yocto/message/64889


---
v1: https://lore.kernel.org/yocto-patches/20250317113445.3855518-1-skandigraun@gmail.com/T/

changes in v2:
- Add wrapper for ftw, ftw64, nftw and nftw64 (instead of only nftw in v1). All of them
  use the same wrapper file, using macros to account for the naming differences.
- ftw64 and nftw64 depend on large file support of the system. To account for this, move
  these implementations into their own subport folder, and compile them conditionally.
- Move tests into separate commit (and add some tests for the new calls too)
- The original implementation didn't consider multiple concurrent requests
  when it was saving the original call's details (callback function pointer,
  flags), and subsequent calls could overwrite data. This version stores
  these details in an array that behaves similar to a LIFO proto-stack.
- Fix one bug in FTW_CHDIR flag behavior in conjuction with FTW_DEPTH flag (it switched
  to a folder, which didn't match glibc implementation's behavior)
- Minor change in Makefile: since the tests between ftw/ftw64 and nftw/nftw64 are exactly
  the same, they are also implemented in the same file, which however is expected to be
  included in other files, and is not a compile-unit on its own. For this, the Makefile
  looks for files with "test-" prefix in the test folder.

---

Gyorgy Sarvari (2):
  nftw, ftw: add wrapper
  nftw, ftw: add tests

 Makefile.in                            |   4 +-
 guts/README                            |   6 +-
 ports/linux/guts/ftw64.c               |  16 --
 ports/linux/nftw64/guts/ftw64.c        |  29 +++
 ports/linux/{ => nftw64}/guts/nftw64.c |   7 +-
 ports/linux/nftw64/pseudo_wrappers.c   |  45 +++++
 ports/linux/nftw64/wrapfuncs.in        |   2 +
 ports/linux/subports                   |  14 ++
 ports/linux/wrapfuncs.in               |   2 -
 ports/unix/guts/ftw.c                  |  13 +-
 ports/unix/guts/nftw.c                 |   7 +-
 ports/unix/guts/nftw_wrapper_base.c    | 211 ++++++++++++++++++++++
 ports/unix/pseudo_wrappers.c           |  45 +++++
 ports/unix/wrapfuncs.in                |   2 +-
 test/ftw-test-impl.c                   | 226 +++++++++++++++++++++++
 test/nftw-test-impl.c                  | 236 +++++++++++++++++++++++++
 test/test-ftw.c                        |   4 +
 test/test-ftw64.c                      |   4 +
 test/test-nftw.c                       |   4 +
 test/test-nftw.sh                      |  84 +++++++++
 test/test-nftw64.c                     |   4 +
 21 files changed, 937 insertions(+), 28 deletions(-)
 delete mode 100644 ports/linux/guts/ftw64.c
 create mode 100644 ports/linux/nftw64/guts/ftw64.c
 rename ports/linux/{ => nftw64}/guts/nftw64.c (57%)
 create mode 100644 ports/linux/nftw64/pseudo_wrappers.c
 create mode 100644 ports/linux/nftw64/wrapfuncs.in
 create mode 100644 ports/unix/guts/nftw_wrapper_base.c
 create mode 100644 test/ftw-test-impl.c
 create mode 100644 test/nftw-test-impl.c
 create mode 100644 test/test-ftw.c
 create mode 100644 test/test-ftw64.c
 create mode 100644 test/test-nftw.c
 create mode 100755 test/test-nftw.sh
 create mode 100644 test/test-nftw64.c


