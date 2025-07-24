Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF1C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:11 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.6915.1753342025240070038
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iZkuxCfw;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a528243636so384317f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342023; x=1753946823; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcAoFnb6z/4tGv1qsTOFzwGnnYZ/0+QpQCkc4kRJ+KU=;
        b=iZkuxCfwVNwxoDyY63bj/TaWyeeVMDpwsZTI//5dUkF5bO+1b8Q0s6i589+iHVy9+z
         SO+xjt0zB3QXrLNYhoKgtdFvRZ2b90pgYNfqnDyt3/5oHbjglZTxRGTFJ4CPw1QO5Pyo
         nPrOJLRywzC8ua7nZCAEsZZvlKfKdFl/2LYlHUg1SF7c2FeUo7sjuaFH0hkXxVu2G3+u
         uC90vKQlHj78hJAFmGPCFjxJRk/ZFFaYFbZ4Ac1urdgZDr7n4iHevZyn6kEgfl8ftpAa
         VTW3jP9Yfm6HlQ4G94A8uItW0srMzFqOhJP+P/AFd8yLUPQ+2WXNbR3wVzBOqe4Qp0bZ
         rG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342023; x=1753946823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcAoFnb6z/4tGv1qsTOFzwGnnYZ/0+QpQCkc4kRJ+KU=;
        b=hkz1x5aKQrwXcvK7Adb/7OnLp3FdpoRrHcUuxIuFwugebbVA+eJJgxhZct+WgIpxXT
         F7wFWIiqBdOdCwgaEN6Txvcp38wFjMfZlFeAVtTCHpXHzwMJN1JQGIFzqfMqC77zuwiN
         BVevpWdd+Eqb1Ju7CSl1IXuj9TR1i4a6X26qpkwxrB4krbKa/Py6xtCcVZ++ZwOjxZMf
         l6P0wIN2SEqAXfA6zuu92orEMXYahqNOpw50uLGZL19SDUHuU4oFZB2zBwHogurHFza3
         dPLHob+/I6TuIio3WApTAT3y3T0E7XoPZLAQdcAy2ZGwqawD/FmGq2KY+VweHakiTRQE
         q3OQ==
X-Gm-Message-State: AOJu0YxOrbx7Fwu1n/KTc2J4iK0qC+p4RBrfoaTEDSXMCZmBKj09HmI8
	ZxP6/iu+PvRnRhVV3NiypmLULTc0nBMKycC6Qqt+BQbFI3rtPLQd8mHVjE86qQ==
X-Gm-Gg: ASbGncsg/xQyb2sDD50fVBFZH/btfDD0J0nf3OCeMVwRNEzxLFJIB1/s+8ZaMaHmbTt
	fugiPA3L5soxevDxLqeWJw1KgHOkT//6nxm1YHBUpdYyzfa5nKKo5813SBy/hrzdm914NsQDv07
	EagjdSdIo4lZ4lnlrk+mlu+aEVo7TbbsSeIW01eFT0yJL0bL/QuXVl60UKC4nySxbCMW2aQSFoz
	LhklVvF1EF6DskIaMcH2PO3Ilg4nRGDGMFIiy7HsDRQoSBkMFEJ+oq3n6+e/5TXlfcJYUeCzCks
	VwuEiLdz8+43WTUtlMD2nMESaRLmvp0GdLNuJlRYXInSrmhBFyE3OsimmI2DSRAUjvKGWrxEWC/
	fZK8PJW0/0mCfhdDw5is3SsH1nRpMw3d2LPw=
X-Google-Smtp-Source: AGHT+IFfAtDwMsVAHXy0vvt6dE384n/qx6TQprKh4LSedsqnaZDSfkciE460cBkh9HJdhZzhefDi0A==
X-Received: by 2002:a5d:5d0c:0:b0:3b6:db7:5c0d with SMTP id ffacd0b85a97d-3b768ecf3d9mr5184758f8f.3.1753342022862;
        Thu, 24 Jul 2025 00:27:02 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:01 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 0/7] master-next updates
Date: Thu, 24 Jul 2025 09:25:42 +0200
Message-ID: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1857

This patchset includes updates to fix the CI on RISCV and with musl,
add improvements in the build speed like the addition of shared
sstate/dldir.

Changes from 06bd60600e8db1b843cf5cc0f074a11eac7e9a80:

Marta Rybczynska (7):
  gitlab-ci.yml: fix file redirection for qemux86 build logs
  packagegroup-core-security: unify conditional adding of packages on
    RISCV
  checksecurity: update the debian package
  bastille: prevent host uids on files
  kas: add common dldir/sstate
  aide: remove for musl
  kas: add whitespaces around assignement

 .gitlab-ci.yml                                    |  2 +-
 .../checksecurity/checksecurity_2.0.16.bb         |  6 +++---
 .../recipes-security/bastille/bastille_3.2.1.bb   |  2 ++
 kas/kas-security-base.yml                         |  8 ++++++--
 .../packagegroup/packagegroup-core-security.bb    | 15 +++++++++++++--
 5 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.47.2


