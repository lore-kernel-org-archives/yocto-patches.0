Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A11CCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:42:03 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22117.1792359714042921418
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OCPlxoHn;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e5378b281aso6125995ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359713; x=1792964513; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlLrlVlVZ1thgL2Xgu3A53UCQqd0dZurlOyqCp5cT10=;
        b=OCPlxoHnWxuwZvCF5MD89YRAM0JYC3K1fpbnNcMBhHm+q/2JwdiTpL1MEnm6VMawzq
         ZjGPu8Nr70141UiTMeJ9JQuxCpHhhaumaIJ5bYwdjCGUjxdc3mIHPPz/pPOPBDb/g+bO
         k+BILxQV6tL5lrkdZ5RA9Td1FsMP3M3J+MfHfcaXRY8bquMPUS9gXGfbq7SzdB2D843O
         +g4Pgej+yn4d8Rvigy0fsxFghTqiPQFV8AwA+VsK06gtlH8Fr0sxtRD0GglZzxUL1e6j
         5vX/ffDNDVGXXk5BjdNVdQCLb4xaz3WbybPF3Q/fvBB1wIOt14b5ZBZvqJZSCKYgGPBo
         QYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359713; x=1792964513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlLrlVlVZ1thgL2Xgu3A53UCQqd0dZurlOyqCp5cT10=;
        b=DbiIS/CNhcscRbgRzXLB2La3uvxqSeEDIBTZSbIrBbpjyP4bbNqD1zsLTkKnmGoIxO
         kzgce+Sw/H5pdq+oIKoJ7sPQnLGQ8y9Xy8c9vW1DqBzjeMG7ofXiJGXLoRY8NUa6hUWm
         nG7h9fvjei5+baGnSWI+A/1QkAIb0OR8sdD3ATNrUZznz87pryg+QAREmEldOjkFp2rS
         310ImGV8KKKqrUD/3XoRf3WRCJrVkBmNuudYd1FtMbHYjjah4NsCfuQk2ooNLmITiEL+
         uSO9FrzfP8TvReYAIV2eyR/DZUNa+OtLuDZYBZh/WC1LBFOHI3MEJVCatpoD1ca+MAIA
         436A==
X-Gm-Message-State: AFq9FYJrie8ltudVgYfB66nJZM4ER6ydkVSzJJEpTIpi9DDYUVwCypfi
	wV+ML4xNEDpqUmiyp76xisOrsnEgva/EuTWzUyPz7NESCPquEQ5zjzHDI8Bb7w==
X-Gm-Gg: AYBFou3tFnVm2Dksyt04WQ/gCpvFJc16FWa/GxAN93ZyAyPscCQnl8R+ht3H8ME6MsP
	E5E/10/PzeTd4lWZ3qnOIchgf2lkQerJN38IgJeDPnRGDq5V6cop6kMGzWRUMjjVcKoYON4SfMH
	9cBUSndKGUl+gYmHJAt+3bP05i5mv/8t5Xo1/0lq/zXFOR6574fwPcvWmijAnlY3m8xnh95PvL8
	zUEY3GwmOneCaGPZbAdtnIfLYPFoMdcpydylGS+7/JSxMFzFHhNb3WeBjs9k5T3I7aVLL6VT5vz
	V5/PFKasPrGeA+ZtHs+gsMYNUw5wo7deIWzMGzRVMj8Ja+m4cUYtVRQB0Kz1T3s59zuyE27ddTR
	X7/ZrOm8v2maofgKju/yehWGl0CsCpfU0rADQzaf53VhNyMkjbSj1RARLskOLftdPgBfv5o6GZ5
	FNmj+ngJmdWfCgaGIZZscyKIc9d3nyDB9/zZHZ0RL/yLgowccSH/2a7tc3Q5owx0YqtlENuBMe7
	6YRX8BBNdRk3dslGAnn7OfSTucupok=
X-Received: by 2002:a17:90b:5111:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3acee292795mr5641318a91.8.1792359713261;
        Sun, 18 Oct 2026 14:41:53 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e9d3fa9ffdsm9004155ad.58.2026.10.18.14.41.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:41:52 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Docker: environment files for dev, staging and production
Date: Sun, 18 Oct 2026 14:41:42 -0700
Message-ID: <20261018214146.67856-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5072

This series moves the Docker container settings out of
docker-compose.yml into tracked .env.<context>.<service> files and adds
staging and production compose setups, with two fixes found on the way.

Patch 1 stops DEBUG=0 from enabling Django's debug mode: any non-empty
value used to count as true.

Patch 2 makes nginx send X-Forwarded-Proto, which docker/settings.py
already trusts. Without it Django treated HTTPS requests as plain HTTP,
which is also what caused the 403 on login on a non-default HTTPS port
[YOCTO #15329].

Patch 3 lets DATABASE_PORT and STATIC_ROOT be set from the environment
and adds ENABLE_RRS to turn on the Recipe Reporting System.

Patch 4 adds the env files and the staging and production setups. The
secrets in the staging and production files are commented out, so
nothing starts with a known password; the real values belong in a local
commit on the server. dockersetup.py now writes the secrets it generates
to untracked .env.local.* files instead of editing docker-compose.yml.
Installations set up with dockersetup.py before this keep their secrets
in docker-compose.yml and need them carried over once; the README
change in the documentation series that follows describes how.

Tested with docker/run-tests.sh (the full suite, including
tests/test_update.py) and on a test deployment.

Tim Orling (4):
  docker/settings.py: don't enable DEBUG when DEBUG=0
  docker: set X-Forwarded-Proto in the nginx configs
  docker/settings.py: read more settings from the environment
  Add staging and production docker-compose setups with env files

 .dockerignore              |   1 +
 .env.dev.app               |  14 +++++
 .env.dev.celery            |  14 +++++
 .env.dev.db                |   3 +
 .env.dev.rabbit            |   3 +
 .env.prod.app              |  15 +++++
 .env.prod.celery           |  15 +++++
 .env.prod.db               |   4 ++
 .env.prod.rabbit           |   4 ++
 .env.staging.app           |  15 +++++
 .env.staging.celery        |  15 +++++
 .env.staging.db            |   4 ++
 .env.staging.rabbit        |   4 ++
 .gitignore                 |   2 +
 README                     |  23 +++++++-
 docker-compose.prod.yml    |  74 +++++++++++++++++++++++++
 docker-compose.staging.yml |  74 +++++++++++++++++++++++++
 docker-compose.yml         |  42 +++-----------
 docker/nginx-ssl.conf      |   2 +
 docker/nginx.conf          |   1 +
 docker/settings.py         |   9 ++-
 dockersetup.py             | 111 +++++++++++++++++--------------------
 22 files changed, 350 insertions(+), 99 deletions(-)
 create mode 100644 .env.dev.app
 create mode 100644 .env.dev.celery
 create mode 100644 .env.dev.db
 create mode 100644 .env.dev.rabbit
 create mode 100644 .env.prod.app
 create mode 100644 .env.prod.celery
 create mode 100644 .env.prod.db
 create mode 100644 .env.prod.rabbit
 create mode 100644 .env.staging.app
 create mode 100644 .env.staging.celery
 create mode 100644 .env.staging.db
 create mode 100644 .env.staging.rabbit
 create mode 100644 docker-compose.prod.yml
 create mode 100644 docker-compose.staging.yml


base-commit: e6040597ae0f614581de241fe78f20e34dae13ac
-- 
2.56.0


