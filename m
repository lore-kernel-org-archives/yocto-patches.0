Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2812.1794616247493605500
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:30:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=0BeKrEpc;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so892529a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616247; x=1795221047; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2l4iGhdes7kqz/jiyuIjoTgTBFBkwl6qwEQnrsPqPSE=;
        b=0BeKrEpc04z/50/Fv011O64ONW2RHdnTg2sCL3LnJBJKxu3IvaqjyajioE2mkb6KvL
         pG+KqGfOdIhRqothQreLWvl6ZyOEtW6rYlLfmFAQ5HChLOlRiKmr4pKLZ3nrHKl0Bobo
         wl0jNNOcC07J6v0652JAk7oicY4iQ9HGsb6LbuA2Qp6HAUk5sAmHLEQ4NOCDB7XCMGcf
         Wj+e7HykouHGSfOvWm7o8dIfa9F9/BpzGiatszPi+9kqnA63eCuCwiwgAP0JBK6qP6zM
         dPgK9g8zgi4X8l4ngZNlZqr9XeW5dpVHOJrh6Xudz6i1GWm9n0vZ+YmkAfrO7LZE1cEa
         eBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616247; x=1795221047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2l4iGhdes7kqz/jiyuIjoTgTBFBkwl6qwEQnrsPqPSE=;
        b=kyDWUZc/eXCGSmdTmEHVKlyVwZuwTYtc3cPAPAH7DDEtBSclZeQz0aulYzTRxEe5Y0
         wPnlcYJzJ9NjBcMa7oW6z2Tn3JXb4drY3Mzdz4BY7/K8Lsd4fSpowEseB8tm2hNzSfos
         rtaGapW4DyfQseObq2a4YLSVA06Frf9Hl7lax2mR/uxB5jCy3BtUan8JmblSXnE+hx35
         828/zUmBPnfIRZ3EkUMxTDgZJVJCeptsxTywHyIkTw0XEjFECpG4GMi1DgB7aDu1Z354
         ZSOR5NyftlQLfvWJHZGROOBDe6WONELLBtCG3TSsG+HWUC76kquOz1508kg1B7UJhuMn
         n7rA==
X-Gm-Message-State: APuU4Z8DM0Qs4wp4xhUxxDQqDDCVjum7JCu/tJtEZHu+DzDn45Z3zMei
	4S8kk9ZN4YkJ+RNce8hDPewUdRNBDcrtPLCp+xgOtK6aVAav7BrU9dZdrF9vtM5l
X-Gm-Gg: AYBFou3h6EhBBRBMx+NmUaw06KFN2n0OmxDvPw5uPG4PkJM4iIjj/OhbknoWs7rXtPu
	lGbTkVKudUNCpkEfyaqbVabds1YwSDMaC4k0Uw71rMX9hzIjSvyc211lSO65HY0TQTGbF4yPGmX
	Ai5j08IUu4SDDnQ2ulXPY5vxi9ulkIzTCHm1Qtdt1lIIr05vZ2W0O0DJ2KxYVlcsC3T8Irf07x0
	bQPYc2qMxedHQPHA9/6TKB1UqpBpGupj736g7T2CsRlxU7hBzuCePZiTEmN2na0h3LvCaxbCbw2
	zekxcehCUcMSj7ROZeQsYNJPZuDAnl8q0LSYX7xCSgcAC032U5CGTP0kxF7GqSiURl91EylRgSU
	ZdO2Gk5N6FYpINjpe3hy5UApP/w4fdDHXCdgEVhxcEb5FRLspfa/QLDlprgfc2LIQn9N2bsPseI
	4cr6uMqKf+mjNt/v5FxaZKNFwSqY+TiySS2KzKIjonSB0bkS0dG827joe+vGKDOnGy3DwHgglUJ
	wKRIFHNzUIz0tNfM1M1ExCC4o8exkUaKR+Wgd+0RfUrC16GDhFmO6f32pumBHe8Zys3fqa6jDO5
	CRA0EKvnz8HzCHxhsMs/kZulbcSZofAgFLBz30FpaO/n0eTtzn0Bi0SsT8saWQ==
X-Received: by 2002:a17:90a:e7c1:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b1b0b94eaemr2649371a91.19.1794616246734;
        Fri, 13 Nov 2026 16:30:46 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm6684787a91.12.2026.11.13.16.30.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:30:46 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/3] Fix the Update Layer button
Date: Fri, 13 Nov 2026 16:30:38 -0800
Message-ID: <20261114003041.15197-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5346
Content-Type: text/plain; charset="utf-8"

These fix the problems in bug 15395 with the Update Layer button.

1: The button created two update records: the view's, with the task
   and its log, and an empty one from update.py, which holds the
   per-layer updates.
2: The task page showed the live log as a Python bytes literal (since
   Django 3.0), and only saw the task finish when the poll reached the
   process that started it (rpc:// result backend).
3: The task logs volume belonged to root, so the worker could not write
   the log. An existing volume keeps its owner and needs a one-time
   "chown layers" of the task logs directory.

Tested on a test instance loaded with a copy of the layers.openembedded.org
database, with RabbitMQ and a Celery worker, by pressing the button for
meta-maker and for meta-security (a full parse): before, two records
and a b'...' log; after, one record with the layer update attached, the
log shown as it runs, and success detected. The worker also needs
"layerindex/tasks.py: fix loading the settings in the Celery worker",
sent separately. The test suite passes in the Docker image (80 passed,
1 skipped).

Queuing an update behind one that is already running, also asked for
in the bug, is not part of this series.

Tim Orling (3):
  layerindex: record Update Layer runs in a single update record
  layerindex/views: fix the live log on the task status page
  Dockerfile: create the task logs directory

 Dockerfile                  |  6 ++-
 layerindex/tasks.py         |  6 ++-
 layerindex/update.py        | 30 +++++++++----
 layerindex/views.py         | 26 ++++--------
 tests/test_update_button.py | 84 +++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 28 deletions(-)
 create mode 100644 tests/test_update_button.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

