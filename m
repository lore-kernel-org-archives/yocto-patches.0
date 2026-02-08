Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF6EF06F2
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:02 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34784.1770587094738025878
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:44:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gtP74hAL;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927b1620ddso53855357b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587093; x=1771191893; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rgw0WvVtFsX32H1ytGOcAiUJz4PLrpoRVfeHaUuVlg=;
        b=gtP74hAL6z5CNOAqHmJZ8rwaXvY2+NEPZysseQ6bsVgbR4KDlSCVXFjvKvSr8KAgnz
         aILQCc4/PkL3knMHeU9/uqnUQaDjkKX5XlNG76/kgCxbuOdxoaU2+Ont4GYDqbNvIRW5
         rsZ7zeoB0yxGGvNM3rG8o9VNiA71a1bZLC9Zevz9Xjcpeb87wL1CfG24VKSGIMpu1r8I
         hPCCAU3L1KSpEYpLBaVWeFu/Mbbm3Kfc2reDqEN3asiThW8JyIEIXFO4ecFgAbFbleoG
         dnTjM92OMFpGCdxJ8OnOzuq3uwWSN5H7z0hCe3pWYWM9DypYZrSqVUBd6Ji3Fvgl/kqf
         mK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587093; x=1771191893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rgw0WvVtFsX32H1ytGOcAiUJz4PLrpoRVfeHaUuVlg=;
        b=lPoUyf9rCqDJgl/d+FzY92EmQYJYOF5IARFKCQsmifNbpAjFo1DfDKTLvcqVjfKiSW
         Xu0zx5vxLOlm1/n+DGB3M4SGI57RLPkIqghnj10UCHutViS3zjhP2+FkhS9eSz4D9TMo
         ZrBMvKg6H8LqIINqfcs3DjvXgRxxqNBdcQh29LCU5oA2/7Pf/4F2tVcWSXZw1pvL0oux
         CThVhRx616KCxwHJzYMbJGtMKD/kOiQWFc/zg0tPQy0VDEYSlS25b1b9eYlUfNZ39Erh
         hxFDd6Eciy/qguv3Dg7J87Df3Q1LL4xOadQqhWb9NTHxZLdDMut+QY3ZdSw15R9RvDIv
         qBXg==
X-Gm-Message-State: AOJu0Yw6frfMV1HO1SSRz9gmSRpR62wklm92gNxGL77LWe8UIzGI3x6s
	iPhGvL6bM9WF/1nItxgRAZy8C/GhE68ToKZPcc+MfxXSRu3BrYcSXHXt7ZyP3Q==
X-Gm-Gg: AZuq6aJgMuWmBlMDcv0RbiuXtrheQft1976cLnUwwcO6jakvzGglvbtfcXza+C3WSeC
	E2LuB8nD4R2nqjuU/khyRxo07WE9w0o+iDd37nMLwvUzTvwHHoEohpJtywHQlgfR1vAlHQuCGbx
	t19XbTfbrNBgPfD9woLNgZ3aphgVXFGFTK3+PnzOGAPgaXX0nndup4czW7rGu+Txtv3NfpsH1MO
	lSsVU0BOus7jynP8lciRiTnaHFmqXyOG2nQ7+tUNQ3UkCKbNz0/p2TQ5xuhacz0dfQ8o/dY10Ij
	Du6FQzA6E1Ygvrhw8bn/cPGqGnl9M4Lj9IAN+Nmu5y11ROOVgZ8rGV+ARYoj04YpSLidbrvPo/B
	beDXdBH71DSApjNHQmyDa7bRUUaCHO6zeDmta2PMgLJlZhHB2Z8q0dyb2t6tVrerxooySnm07yZ
	tAGTmRNkan7fdxjEbPw+d59A==
X-Received: by 2002:a05:690c:fca:b0:796:3a4f:68fc with SMTP id 00721157ae682-7963a4f794fmr33996177b3.8.1770587093244;
        Sun, 08 Feb 2026 13:44:53 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:44:52 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 0/5] Update QEMU machine configs and README
Date: Sun,  8 Feb 2026 18:44:25 -0300
Message-ID: <20260208214430.1048640-1-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3200

From: Charles Dias <charlesdias.cd@outlook.com>

This series updates QEMU machine configurations and improves the
README documentation.

Patches 1-2 clean up the QEMU machine configs: removing the nios2
machine (dropped in Zephyr 4.2) and dropping -nographic from
QB_GRAPHICS (it should be controlled by runqemu, not the machine
config).

Patch 3 adds missing QEMU and Zephyr board settings for the mps2/mps3
machines (ZEPHYR_BOARD, QB_RNG, QB_MEM).

Patch 4 fixes the qemu-cortex-a9 DEFAULTTUNE to use hard-float with
NEON as expected by Zephyr.

Patch 5 updates the README with consistent runqemu nographic usage
and adds a section on listing supported machines.

Charles Dias (5):
  zephyr-bsp: drop nios2 machine fragments (unsupported in Zephyr 4.2)
  machine: remove -nographic from QB_GRAPHICS
  machine: mps2/mps3: add missing QEMU and Zephyr board settings
  qemu-cortex-a9: fix DEFAULTTUNE to cortexa9hf-neon
  README: improve runqemu examples and add supported machines section

 README.md                                     | 26 ++++++++++++++-----
 meta-zephyr-bsp/conf/machine/mps2-an385.conf  |  5 +++-
 meta-zephyr-bsp/conf/machine/mps2-an521.conf  |  4 ++-
 meta-zephyr-bsp/conf/machine/mps3-an547.conf  |  5 +++-
 .../conf/machine/qemu-cortex-a53.conf         |  2 +-
 .../conf/machine/qemu-cortex-a9.conf          |  4 +--
 .../conf/machine/qemu-cortex-m0.conf          |  2 +-
 .../conf/machine/qemu-cortex-m3.conf          |  2 +-
 .../conf/machine/qemu-cortex-r5.conf          |  2 +-
 meta-zephyr-bsp/conf/machine/qemu-nios2.conf  | 17 ------------
 .../conf/machine/v2m-musca-b1.conf            |  2 +-
 .../conf/machine/v2m-musca-s1.conf            |  2 +-
 12 files changed, 38 insertions(+), 35 deletions(-)
 delete mode 100644 meta-zephyr-bsp/conf/machine/qemu-nios2.conf


