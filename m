Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F2ECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.55087.1725893744496235266
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h7rc2W6k;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582face04dso8830641cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893742; x=1726498542; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHZ6HKG62Wd/Pq6tKqx1ZMINzPu0rWe40KPgtw1tfzI=;
        b=h7rc2W6k5YMftGYKph2PDvCOAhU8AuIHs1pRhQJyFpo/gBd1dspu6syHQPWCPe9Sl3
         yNQv9B2hjhX6lkep3WiayHcU+5ApW2bQ9OuyBv3N5OceAaZnj4KEwESbV9Kt2K6enzLj
         7sG05xcbc3ThelEUSAgM1WgT/Kd6hqVm/k7Vit12WytgW2SitkH9NT8lstYW3zMwb4eW
         JajGsBdJh9kuSnRhgUs4rjVXzGTrax5WRV1ibk9sf3z7w+SHPitTTpF/IHJNgyjOwOqm
         iaHeJSQMFTrBY6PXjLah+Q9/YxpmmoiihKW2RT5HblCgQGvTAzGAt705EpsDUwvvBo3v
         LbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893742; x=1726498542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHZ6HKG62Wd/Pq6tKqx1ZMINzPu0rWe40KPgtw1tfzI=;
        b=neBLYBxOhVQNX5HfdTRl39PnIqHdH2nu/9Qs4YDYVh8qzX7xszGX4NxymimdGxyM+/
         IE6F5GU+gxe6BD4Sb8NJljWbrv+dWoRoZ7geGhhJwG6Ga0x7Td/nAq+1aXSKtBENSaPR
         slfMObUp8qVl+rWfsRT4zwR2jEKvA63hJTUnWUAA/9ZlrRQHeGevqkRf07fNLEZOJmt6
         DPKi1km+KthOuJSFjaU0zEPRVr33bMI8JOz6WlEaaWizXEEIBfduwUWxoU7EyatasVPP
         6hYggpWNcc3idB378WazerPdFySGtU1V6Z5KVrqaA7miWmhRfM92ifYuyFUqE6F+oWq+
         gj3w==
X-Gm-Message-State: AOJu0YzK1CbxkGh3Qo9xon3qE5kAVsxeXiVkrgkaes9GVl9yEbyYrlmR
	ob2NeLiB/aTeET6TIGj8P1Xj2lVQt/4x9I8MSASQrBcsCJ7PyUkoPa04E2Sh
X-Google-Smtp-Source: AGHT+IHwN8sMcUuJzSfzA6nooXSSKWxb+sEBHE6djtIeh5lOGUjZSWPXkc22TL/DQAfUliRZqjxSZA==
X-Received: by 2002:ac8:7fd0:0:b0:44f:e11c:b0d8 with SMTP id d75a77b69052e-457f8b9714cmr324556791cf.7.1725893742166;
        Mon, 09 Sep 2024 07:55:42 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:41 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <trevor.woerner@amd.com>
Subject: [meta-rockchip][scarthgap][PATCH 00/10] scarthgap update
Date: Mon,  9 Sep 2024 10:55:20 -0400
Message-ID: <20240909145530.25301-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/626

From: Trevor Woerner <trevor.woerner@amd.com>

Update the scarthgap branch with all the relevant patches from master.

The scarthgap branch did not get the UNPACKDIR changes that went into
master/styhead, therefore any patches that addressed that change were not 
picked, and any patches that added features with UNPACKDIR were modified to
revert back to WORKDIR.

On master, it took a couple patches to get the radxa-zero-3{e|w} machine
added and working fully (i.e. with the kernel tag). All these patches were
squashed together into one "add radxa zero 3" patch.

The rename of the mesa bbappend patch is not required on scarthgap for 
reasons similar to the UNPACKDIR feature.

Boot tested with:
	- nanopi-r2s
	- radxa-zero-3e
	- rock-3a
	- rock-5a
	- rock-pi-4b
	- rock-pi-s


Marcin Bober (1):
  mesa: build panfrost for RK3566 boards

Quentin Schulz (3):
  mesa: enable lima on all rk3328 boards
  mesa: build panfrost for RK3568 boards
  enable HW VPU decoding for SoCs that have stateless VPUs

Trevor Woerner (6):
  user-selectable wic compression
  rockchip-rkbin: bump SRCREV
  radxa-zero-3{e|w}: add
  README: sort MACHINE names
  rauc demo: add
  linux-torvalds-next: bump to next-20240904

 README                                        | 108 ++++++++++++++----
 .../rk-rauc-demo-features-check.bbclass       |   4 +
 conf/layer.conf                               |   4 +
 conf/machine/include/px30.inc                 |   2 +
 conf/machine/include/radxa-zero-3.inc         |   8 ++
 conf/machine/include/rk3066.inc               |   2 +
 conf/machine/include/rk3188.inc               |   2 +
 conf/machine/include/rk3288.inc               |   2 +
 conf/machine/include/rk3328.inc               |   2 +
 conf/machine/include/rk3399.inc               |   2 +
 conf/machine/include/rk3566.inc               |  23 ++++
 conf/machine/include/rk3568.inc               |   2 +
 conf/machine/include/rk3588s.inc              |   2 +
 conf/machine/include/rockchip-rauc.inc        |   4 +
 conf/machine/include/rockchip-wic.inc         |   7 +-
 conf/machine/radxa-zero-3e.conf               |   7 ++
 conf/machine/radxa-zero-3w.conf               |   7 ++
 .../recipes-bsp/u-boot/files/boot.cmd.in      |  51 +++++++++
 .../recipes-bsp/u-boot/files/uboot-rauc.cfg   |   8 ++
 .../recipes-bsp/u-boot/u-boot_%.bbappend      |  26 +++++
 .../base-files/base-files_%.bbappend          |   2 +
 .../recipes-core/base-files/files/fstab       |   5 +
 .../rauc-bundles/files/development-1.cert.pem |  80 +++++++++++++
 .../rauc-bundles/files/development-1.key.pem  |  28 +++++
 .../rauc-bundles/rockchip-rauc-bundle.bb      |  14 +++
 .../recipes-core/rauc/files/ca.cert.pem       |  80 +++++++++++++
 .../recipes-core/rauc/files/system.conf       |  17 +++
 .../recipes-core/rauc/rauc-conf.bbappend      |   7 ++
 .../recipes-core/systemd/abd-partition.bb     |  26 +++++
 .../systemd/files/25-rootfsA.conf             |   4 +
 .../systemd/files/35-rootfsB.conf             |   7 ++
 .../recipes-core/systemd/files/45-data.conf   |   6 +
 .../recipes-core/systemd/files/data.mount     |  10 ++
 .../recipes-core/systemd/systemd_%.bbappend   |   3 +
 .../linux/linux-torvalds-next_%.bbappend      |   1 +
 recipes-bsp/rkbin/rockchip-rkbin_git.bb       |  18 ++-
 recipes-bsp/u-boot/u-boot_%.bbappend          |   4 +
 recipes-graphics/mesa/mesa_%.bbappend         |   4 +-
 .../linux/linux-torvalds-next_git.bb          |  25 ++++
 .../gstreamer1.0-plugins-bad_%.bbappend       |   1 +
 40 files changed, 585 insertions(+), 30 deletions(-)
 create mode 100644 classes-recipe/rk-rauc-demo-features-check.bbclass
 create mode 100644 conf/machine/include/radxa-zero-3.inc
 create mode 100644 conf/machine/include/rk3566.inc
 create mode 100644 conf/machine/include/rockchip-rauc.inc
 create mode 100644 conf/machine/radxa-zero-3e.conf
 create mode 100644 conf/machine/radxa-zero-3w.conf
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/data.mount
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
 create mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
 create mode 100644 recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend

-- 
2.44.0.478.g7774cfed6261


