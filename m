Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C592CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:49:03 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22357.1792360135946829350
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:48:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CzilPdH8;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9cf928dc9so3300305ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360135; x=1792964935; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNVmuuzmtA4YtEHDsuU1TR3ZwojIQDzxa1Bdo2qpbvk=;
        b=CzilPdH8lq/zOhjnUyKQicBoKsheqcAYf1hjfF3iUX44hIgb4TgrFSRsROksHzes4E
         /I5gZ4LzKfA5+61pu4KFrxytdoDZYj/0AxKxpCSXp7pCQ8FB6JZIyrfVq88nmSQRlA3k
         51a2zPVLyfHOpUQFkuYH7X7zvkESxnOAk5PB9YHk31I0QPjCm+dBGPpGV6q2TxrcfLVs
         y+dFMLIol+J1osaFM9gVlEHBMn8NItKmkretO8TLVLyE2DqBYosi1PE1V7cpczAjMW1C
         oNxZBSYfS9oVx4DbzoIDLvOH8tHUi9HTqJADZ1k7k4X1YI36ju2m9dHUr7QkCN51Bh/4
         IL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360135; x=1792964935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNVmuuzmtA4YtEHDsuU1TR3ZwojIQDzxa1Bdo2qpbvk=;
        b=a+xV2UapoKXJFmwSaxpBw/YMig2+ynkyc80agEkrdHV+ONbRhVplvAhIXzHerQcwMz
         6oEZWP29am21kSQrc933tD6hjlZw/Oc177gmFhN1TacYf2tMcLtlR4FEUU0AmcLdriFe
         a4dHluSLbH46/5bUJc/DrwEgcyPJj4Bk50GtitQcab3NJxnpB32Vnjsw9TzhLXAwOK6l
         ETYnk/ClpLHGlZ523kUpLsSrgWbd2V9YkULC6e7RTMzc2fblG2cfLXptRJCpMxq2IdRw
         0N+P/veH5kiksVULGMKJ4B77zvVhoW/A266ian4I4LxrW6r2GYWitbsmiJXmWUshmkAH
         Tcgg==
X-Gm-Message-State: AFq9FYKkJo+6zEecGOB0ecKNocGy7FRCNWEiXNWl+s2ywAT6FzijVwml
	yIu4iRF+pEopdPxG7WmbbYCd8v9rPWC4XtEQxA+3hccNv4FzItEsEiBD1J16w5p7
X-Gm-Gg: AYBFou2cMQ3RxNbA8GNjsAocrdi+kD8gjV9T1/ysrSvxjHEkVy+Wxw0N3l81DuJFzMZ
	n/7sFmQJMstVkvst4i4cvLvDtVCt0316/VEqBx249dARAOr1MUUWDKeiz9WchLjwL7EJGTUu+54
	kSLp6jd5VJFp5vTGrFmlRh5+sb7qAN+S7/d3lOIM8Gc8uoTsIgpKmDiJzaFXHsdWBTVAkqMaSHU
	QPwQUw9fgFoMe9v4GLvtvuSsE04AL9jbS86OQLj8nAozcNOeWHzBXZfCLG9h3BNYs2rR1eQEwz/
	s+Hw/+bH2y4rNEYaSm1zCHBorg2nNv3IJ5qUgwhAZqsPPya0Jm3UcSHgh31yYkGG30oDMOaAd6J
	xE+eTbISGwztRMojyibtWxTBc9IstyaRlNHi46/LuLi5zO6NSDIkg0i355Q37WxMsNnOzzi0ywS
	oyv1gdvwB1a8T/38HJZoaC2rDDjojO8BtlXbpZRP6xsc8Nly3Pi873sKAID56iOVCVnwTr7N+Tw
	GBZkVRUkk4awEHJCO+37MTzUEyxNNE=
X-Received: by 2002:a05:6a20:e30b:b0:3de:141e:c712 with SMTP id adf61e73a8af0-3e225f6e8bbmr3541871637.14.1792360135149;
        Sun, 18 Oct 2026 14:48:55 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a04493551csm2010759b3a.44.2026.10.18.14.48.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:48:53 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/3] dockersetup.py: tests and "docker compose" support
Date: Sun, 18 Oct 2026 14:48:44 -0700
Message-ID: <20261018214847.69431-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:49:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5077

This series applies on top of "Docker: environment files for dev,
staging and production".

Patch 1 moves the code dockersetup.py ran at module level into main(),
so its functions can be imported and tested. There is no change in
behaviour.

Patch 2 adds tests for the files dockersetup.py writes: the .env.local.*
files, docker-compose.yml, the proxy settings and the nginx SSL
configuration. The Docker image doesn't contain dockersetup.py, so these
tests are skipped by docker/run-tests.sh and run by a separate CI job on
the host, which needs only pytest and PyYAML.

Patch 3 makes dockersetup.py use the "docker compose" plugin that
current Docker installs provide, falling back to the standalone
docker-compose command.

Tested with tests/test_dockersetup.py and docker/run-tests.sh. I have
not run a complete dockersetup.py installation with these changes.

Tim Orling (3):
  dockersetup.py: move the script body into main()
  tests: add tests for the files dockersetup.py writes
  dockersetup.py: use "docker compose" when it is available

 .github/workflows/ci.yml  |  13 +
 dockersetup.py            | 554 ++++++++++++++++++++------------------
 tests/test_dockersetup.py | 183 +++++++++++++
 3 files changed, 487 insertions(+), 263 deletions(-)
 create mode 100644 tests/test_dockersetup.py


base-commit: e6040597ae0f614581de241fe78f20e34dae13ac
prerequisite-patch-id: 0cfb656e605b0ec4a84298986850c958648f94bf
prerequisite-patch-id: cf25fa25d9d94e47af321358b41c451717173512
prerequisite-patch-id: a3d6bb81b18633b51f922cc20a99b84ac423393b
prerequisite-patch-id: e1c00c40927a7db84488f2ce1b4ed40f3aa14aa0
-- 
2.56.0


