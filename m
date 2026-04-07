Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E973105D98C
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 23:01:54 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.94409.1775602910053244885
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 16:01:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sCbRqImH;
 spf=pass (domain: gmail.com, ip: 74.125.82.171, mailfrom: raj.khem@gmail.com)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6290185eec.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775602909; x=1776207709; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sowhijnmIlplEQX6z+nC917wWQ1Se9IxEt/R931mNak=;
        b=sCbRqImH4PBlDd+PTlkIzeRIklBc4GFm/ZgGm3IuOVtlxN7/9SSxgrStptJEmBx83h
         nq3plDW27K8cAS8Ao2dwNNTziizO6ygZQ/bxdfRBdcNKhfBfszqM3NC+Pofij3tIEVeD
         0hDUmYNvF+M0RZz9w1+rF9ZPs8vnlxN1XAaUQWANT4Ha/3f0t/xdcevpkg1DisQ4yqrJ
         kDSf8coxZCL3bIwiA26msLriffCT30njGR6BIK1oVgBopCtofUnWroQuzy2cW87XWSYp
         pREu45RLsKOpA1l9Bou6BXfpkOYPLR9Rpzq+GVD2LpxC5EGf8pOHC2ZsvtzpnN6D3qrj
         oxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775602909; x=1776207709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sowhijnmIlplEQX6z+nC917wWQ1Se9IxEt/R931mNak=;
        b=pLg4UZEqUgvtNo0YcknX1ohAKIhfqFbwLxQTGmj6eS3jEBcq7Opaeto4JqACAyq4vJ
         wHXKSn8WXOLqPXw/YsCIxK5rcpa4zFnP7enUUz984fE7Ct8Y9XwoOZNcm1+Qd0FgArQX
         nt7GIeunUe2i8IEoL63eE+vWWlDG6etHVldR6uBpKyZeQEemoijrEQaT4dfRxfPFsEWa
         ahBEN1oxXVMBUqoPeNdnqFJOZEecuLpBJnkpkYcEAdJhrthJbmcF351tQVgee9fipR20
         lpJOcRMIJIOkzic0gbWflkzhlLGdyH8x73IKWtUhEovWwE90ABD7tZ99oZLe/+RYucGm
         Tb1Q==
X-Gm-Message-State: AOJu0YyjLSTkHyFTU94PhkOu/Z4OKWCrCtwaFYhC4yeCgm3kNco6WPNc
	Wl8/vd06ff1QV1OkAsBPdPswVEPk8UBBfTePcEy9NZzJBiPtC2l+0utT2Gmm9A==
X-Gm-Gg: AeBDieu5ZSIEdSjubb/oXe58dbbFvMzhpaymhHDAX5F01E71jAWmESbPR2CZeV3hgOr
	NxSE1mVckpwfgmhxS3y4QL0TMMXhtG3Nl8dEuLe4DPBdJe2+Mja7zu/INVUAvclYDMIr2329mc/
	fMMGgQGAWDGaDGJl7BVXD/K8s4RJ7dWoMYrrcWv4euLQ1G/g962heqHUkDTqy+ZmRP1cXwxRGAe
	0ZBwROKft++3IUCSaPot3nXvL7qbGZktepQFPEqab9Og8aj35CPx8a4iOvjeaFjkkMJw8WCJU13
	KfDmsjgIYWJCXw/uU3PQ9WZfpJKL/luRvunn0TevE4tiVyHAeq/iKtibu/9zc5IghoBRUfkhdV4
	JVwXa7DE7q9c/fapNX7+SL7Ablctb0F13cUyQovg2OR3glJmc/Y9Xd3q2mOcpbOQku8oE8kTjI2
	xZPMSNv30J5skf4oIaU+xGxNHdzRZXAc00qPOYhbj9NwumzlQBTiHmWmVLd3uJCMCQNOTS5J3PR
	y4wGaaLqJToUmesJfchWp4Nz5UqIOUY86hCn6x8iKC3gmP6Adg+0gp6liMS
X-Received: by 2002:a05:7301:4090:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2cbf99ef032mr9086914eec.1.1775602909082;
        Tue, 07 Apr 2026 16:01:49 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cae7e3ec57sm20923864eec.1.2026.04.07.16.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:01:48 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] wic: wic need to be moved to files/wic within the layer to be found/used
Date: Tue,  7 Apr 2026 16:01:39 -0700
Message-ID: <20260407230139.3490478-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 23:01:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3658

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 {wic => files/wic}/beaglebone-yocto-verity.wks.in        | 0
 {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in | 0
 {wic => files/wic}/systemd-bootdisk-dmverity.wks.in      | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)

diff --git a/wic/beaglebone-yocto-verity.wks.in b/files/wic/beaglebone-yocto-verity.wks.in
similarity index 100%
rename from wic/beaglebone-yocto-verity.wks.in
rename to files/wic/beaglebone-yocto-verity.wks.in
diff --git a/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity-hash.wks.in
rename to files/wic/systemd-bootdisk-dmverity-hash.wks.in
diff --git a/wic/systemd-bootdisk-dmverity.wks.in b/files/wic/systemd-bootdisk-dmverity.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity.wks.in
rename to files/wic/systemd-bootdisk-dmverity.wks.in

