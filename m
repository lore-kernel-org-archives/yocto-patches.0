Return-Path: <alex@colossuscompute.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C86F8D74A
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 13:56:05 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14732.1776347762036880913
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 06:56:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@colossuscompute.com header.s=google header.b=R0MuZ2/I;
 spf=pass (domain: colossuscompute.com, ip: 74.125.82.52, mailfrom: alex@colossuscompute.com)
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12713e56abdso440409c88.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colossuscompute.com; s=google; t=1776347761; x=1776952561; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EAwSRFHK/z7shVAkJt1dmcZFQKGWovlByYoIOiwP9Y=;
        b=R0MuZ2/IwUXic2CrvwDvGzLHpkFBNK9Lin5PpVVDnCrt0ebTUySuN77qOb3XiMrgbT
         h+0i4zjoTSdAT5DmPAmOlTDbjYs8WmMNeGL7CQIeGarni/CgNtl0fcu1NsQBu/k6h/DE
         Zg8yhKL2Bp2mi7gZvoGVDO0ps2dFjPNTel8k4pE5hILRqrrNhpBenNHcJQo+ca21JpOb
         VfGK1iX/I8YXZLk4EKMrpDwZNQ0ldBiUqb5lg4dbXg4CL2AU8swEUJG2I66Hjst7Bc1q
         q/r2MmoNyupgoaZZJ0fq3oDRw+1+8zfN9JIGCZIuO/OroyqpWnDObxQKeoSaNeYYKL8m
         OnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347761; x=1776952561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EAwSRFHK/z7shVAkJt1dmcZFQKGWovlByYoIOiwP9Y=;
        b=p89EiK2mVnY7HIC5UYxVMllcmI9xkK79QQ6YIXIxjq6lEApJIkUVbK+pViBF38z6Nz
         jVB6xkxQUsv0F0EpzAamTr4qEfHFk1Qy21X6ITACK7Hj2k7ZfZLo0+YEN+GoV5Xk3Kz3
         KCqQe6MpCrajt5OE+2pEapCpb5F4Kpy/ISm+HU3KRM8nPRRWUQGMlXvuCzYs5wsuITSP
         lCrvQn19oXVn44n7yh9Yjq03pa58/XY6WvFhlSfJJEEuFJnayz+fecQnZDusJsHNNXHH
         xryNMKHJcFGCAGXUDUDhL5L7WYyxPlAy9/qYrhJnDP3n3l4p72jKVbeV3Zfd0Ao57YFs
         iwEQ==
X-Gm-Message-State: AOJu0YwZ74tpIW28qxQVRCzDS5uKRQjsLfHLLuG4PshJs0qB9tOoOkk5
	OydXIPHdEmpFVkS4RuIMlZvA+ByG15OoicIsc8CjBW/tkG33K9m0kA/xbL+te277sw++lo3ViLB
	furLA
X-Gm-Gg: AeBDietiyMDkZGt5bcdhjzQR/gqcqIzJ2IgL1jMGKqiuZBMzNREuOb/POGOWxkIXczM
	vrBf1RhGYbmzKM14eZsHeteN9vZYvrlc5wq7CBv8m02xpJKTdSRN5/TKM0QHcBtZUhLH3j1yhb+
	jWVTl5NqsAcAUychXCeuTkJmp4NuMgBT8oCezDJYuONoERATus5BgLEPo9Hs8uEItrt2f97QCe1
	8WcvnxKYnHLZEVH8qKrEOpBoud2tG8fqQyloGYVuD0npepsuC2yby224sdrhK1iwY/oddmQyP+s
	2zrwN+Nd/8TTH06OAmFdFXT4Fzjm/pgmHm8tuEk2YqJrYGfR2DEMXu1YqWhx5kOEGK8WRH2+6Qk
	RwhsMnUjiaGY6vqpisHANlT5Edchygdg78Er6DY9DhORcuC8vH6HBc87h0nqR1nikzXKNZxuqqW
	+UNIBksEgBCmsduY3QMIYX3C5SiXivgqRv2mNNbX6n2UwlvJE4yJQUH4Us5VEieBhIRLHBq3MGx
	oO/5b4lgTRXGaKctUFJm/S5DeST/ICg3qJO38BHDAhmpomx
X-Received: by 2002:a05:7022:921:b0:12c:2c8:d490 with SMTP id a92af1059eb24-12c630651a8mr1862296c88.5.1776347760679;
        Thu, 16 Apr 2026 06:56:00 -0700 (PDT)
Received: from localhost ([216.38.147.180])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c5e630143sm8480913c88.6.2026.04.16.06.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:56:00 -0700 (PDT)
From: Alex Swehla <alex@colossuscompute.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Swehla <alex@colossuscompute.com>
Subject: [meta-security][PATCH] update wic kickstart path to fix fatal error in sanity checks
Date: Thu, 16 Apr 2026 06:55:57 -0700
Message-ID: <20260416135557.2009759-1-alex@colossuscompute.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 13:56:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3723

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


