Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A9CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:45:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7776.1792287921307144727
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QyRz3HjZ;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5378b281aso4241125ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792287921; x=1792892721; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+6O7AZdPS3QI+YXEmu8Jyy+HRmoNEb9Tf6QVjZW9lF8=;
        b=QyRz3HjZX0fUYv1f0o34T/xU/iozEOgG9eWwF6lR5UpEdRaPfwryMZM9+Cw5jPcL3n
         6SYs5myPYuvCzLaDqV01KlGrhqE5hsMdD/JwrS9dVqkAJBxJjd/0nSNU7kHMCZWIKC6+
         3kWg5Zb0tJXeWiblWG5bRYK13A3Hb2XnoFWFIKTfNekvoRpuTycvTtB7ZdPeYhCT+82r
         C/Lby6TeQDPdzKoX5GCImjns6IERyQOcQJkk4nTB/hCKCa5caazrPYDCaA9MwP3jJ+5O
         ZhfWDviRHP2hnTyWpaB3LNg9aZwsYTkMGMGBTgd3ZY+T0kISRFCdKGkGvFHKpHNKNB+T
         jTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792287921; x=1792892721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+6O7AZdPS3QI+YXEmu8Jyy+HRmoNEb9Tf6QVjZW9lF8=;
        b=zTOkexL+ZbBhhEndlQ9SpXhdZBldNs5YJtiazqh87GMu81khy8MR7uS9L7syYYDfsH
         fY3kakOod9akBk+jFB2w5Pr+4oD8MoYWTZkYifNkCxO1SqjDZknPmoqCv4oUGYUrvDJz
         lwAmldqXbbCymlpqXPk8o57TsIS6knxN3vK/V3zv7HOQtX2fyRgaaeUN0Q77IKQMAgdr
         PHyKj/oCIA1CMxQ6eUE5Cn7Ks5ipy8qD53JMHoH47SpTK48K+RXLsd4AoAz/+c3ufd0j
         A3knjQV15ZIUevA1PjARmuCi4P64QwGEtrzWqdtDH/+DoFhaejK1cuwzQs8Y3NwKBfdn
         bbnw==
X-Gm-Message-State: AFq9FYLkdJ20EgDrMjBI8xify+2akMHfBx8Q0nhu9xv5Jpoa6D76Ieib
	CTDn1a/wtFYZpZP4SBtpgH7mQnzMy7YTg+7roa7O07eHm5T4Pp7Gj3KPPHslsQ==
X-Gm-Gg: AYBFou2MF0a10FBo7b3QBfmhpGEzWrqEXf1ubBoXjaI8QiHkDPdUjdG+qk6zXhism0X
	wHE16S3kSdT+4VEclpou8h5+eyQScRlxC6oXN5EZTsio8WWMfXBvoU/X51FPsai4l8At5B5P5Kv
	PBzs6xDO6gFsy1CM51hVv8qIPWGFpo/3R/JvmX6sy0CsHhMNgsFFUxKeWtvwFMuwR38jSmOsTYq
	9Pvs7CG3cReq549uPds6509Id+V3MQRo66DJSpedX903yDBs7VZh+0O1iI73ZqvZdc5wlLwcBdQ
	b3Alizv4nTtyzV5o7Q/JlBYjX+jdbpHDhqEPh9dTgoBUI9eBMg3Y5cspaKIrvZC/4yV4sNMNf4e
	tLuI+wYe57hHi4aBmBFJwaudLiT1B2vtbG6t56cQRnzvSxEDoh2rLvJ+QqZj6sH0gyRXaCc40Xb
	Xagz4g+3BS+QnVXxS3dNPSPsGpk4qTE8p3p23wS+mGbkdrnvFiRQci4pjCaq9OWluvvwTNo5ruA
	5hs4zDvYCIGb4kOPOI1g+8wd3Ttu8o8+Sx6RfEnkQ==
X-Received: by 2002:a17:903:11c7:b0:2e9:4175:3065 with SMTP id d9443c01a7336-2e9a6833915mr38887075ad.4.1792287920497;
        Sat, 17 Oct 2026 18:45:20 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:45:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/5] Add GitHub Actions CI and run tests with Docker
Date: Sat, 17 Oct 2026 18:43:54 -0700
Message-ID: <20261018014510.72203-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:45:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5044

Add .github/workflows/ci.yml and run tests with docker/run-tests.sh script.
This has been run on https://github.com/moto-timo/error-report-web master-next branch.

Tim Orling (5):
  Use django.test.TestCase so tests run against a test database.
  Add docker/run-tests.sh to run the tests in a container.
  Add a GitHub Actions workflow to run the tests.
  Port culldb and purge.py to Python 3.
  Add a ruff lint job to CI and fix its findings.

 .dockerignore                      | 10 ++++++
 .github/workflows/ci.yml           | 31 +++++++++++++++++++
 .gitignore                         |  1 +
 Post/createStatistics.py           |  6 ++--
 Post/management/commands/culldb.py | 36 +++++++++-------------
 Post/models.py                     |  4 +--
 Post/parser.py                     |  5 +--
 Post/purge.py                      |  4 +--
 Post/templatetags/projecttags.py   |  4 ---
 Post/test.py                       | 49 ++++++++++++++++++++++++------
 Post/views.py                      | 10 +++---
 docker/run-tests.sh                | 32 +++++++++++++++++++
 project/settings.py.docker         |  2 +-
 ruff.toml                          |  5 +++
 test-data/test-send-error.py       |  4 ++-
 15 files changed, 149 insertions(+), 54 deletions(-)
 create mode 100644 .dockerignore
 create mode 100644 .github/workflows/ci.yml
 create mode 100755 docker/run-tests.sh
 create mode 100644 ruff.toml


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
-- 
2.56.0


