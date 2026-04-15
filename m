Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF0AF428F6
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:53 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4576.1776284388649375151
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LA72ucRf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a093c784b0so87326086d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284387; x=1776889187; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGuN/p2AdVvShBfqA4gnAgz6efLOkw7nTrAWz7BrR/4=;
        b=LA72ucRfANVIMQDVflRpN2ylBpX0pScnf4V7uViqBA/ucKvZjWDgZZMO6io9jGZ43M
         AQedGFdRc3BjPHTBhVB3r1shz0Epoc64dK2PiI0ac5kpwjXCa7G6vDLZVBafaYrsriF5
         nqqC7MNV56iReSzyXVLTL1kV7ggaPIbAINCNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284387; x=1776889187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UGuN/p2AdVvShBfqA4gnAgz6efLOkw7nTrAWz7BrR/4=;
        b=j1Rr+sN7RftUsTfohs2cForue764zSBzE4EXU9o2C3ZDZV07m32hGv+TFSgObZnK/T
         znMo0XtFV0nsQKCNutgQy3gAVRMpNZFVA1ZJhp64sKNnADWAzO8YsqKV3/mjQWgu8dEC
         ynIP32SC1UiIkI+eItSpXPLMHdePf5imxbnM4ZrBK/BprzHdQBjwGnOU42ychlPWXh6Y
         lvJXu3lIQd85s6gM3iOKsXBWRaYwcuzD9Dyy/seDdscIRd6ByHbHWQQI5zA9lwEt7C+R
         8l/6qr8eIrL+51t6HvKbXQJuhnCyhquQmRLnsSFpVTF/Li24kPajlF3VYVDQW6+L1mfz
         qCGQ==
X-Gm-Message-State: AOJu0YyyZUVn2Fb8F3YhYs+FVngnocuvj7jzHR3Ag80KSEUNWpfsWNjU
	Vplbf4Pphnx32mHCbIiYT0CcHZUTP2szMTIXbAxwSGi6Xq8jhQ/j/4GzQwTwGoYixcBJadRAUA0
	k0nqm
X-Gm-Gg: AeBDievE60jyfUT2TpK8q7RuKr/vXDtkcdIgLxvI2/ny9U/4ZKOzdkE+5tsKBnA38gB
	Zr/j8HMoPA+cDwv9WZWuTOumSs7z+rW1cIcmzqO5gGVwsDNtxK8fCBe/eLISLx0dSFNiG1UVj4U
	9/mynP1yKrOuPQDDC/TgjUAvlg8Kz3xzPXKMl2CGw+XZ00B3dKIge6qHtj0B4tm66X6D4S5fIZg
	6hlGzGc+6kSPD/RoojIYDjNgesGQ7felZSceI2gCrizKcNWzhTcqjTJcEiuzam+8YnViOLJ2Nfm
	hr+430wCnN2Biqir8gMd0ovGhZFdknl5v84mvixSRBYiwLwCYIyXt5jXzSfztoJLd4BKQu1fwIa
	J/Ai9XTPsNrO+Ahke4+j7ZX/ZX0XB9Fq3PSTvBdTdELATxURmXrPpJzbbRd+Ns0cBIfh9Ga7Bgm
	p7+fzHGFu6FHhGAhVy+geQNj8Z/DPvpA9QfT790nYzLhCERCYD1AYFQfPR8OPDgKwC/wCBijxkQ
	OoDOS1EQpGQKtFQ22I4/6QPQbuNm3OUuINZalXPDmGbxxloy9XNZ6VF55Zohohz
X-Received: by 2002:a05:6214:258f:b0:899:fd8c:55c3 with SMTP id 6a1803df08f44-8ac861b7754mr349530606d6.22.1776284387390;
        Wed, 15 Apr 2026 13:19:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/7] wic: wic need to be moved to files/wic within the layer to be found/used
Date: Wed, 15 Apr 2026 16:19:24 -0400
Message-ID: <596b966a0d047c2f48cb768821558e918ae0c477.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3712

From: Khem Raj <raj.khem@gmail.com>

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
-- 
2.53.0


