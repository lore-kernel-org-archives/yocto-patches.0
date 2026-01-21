Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E0C44508
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:47:13 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17656.1769017630084272226
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Z4UwppqE;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so69549f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769017628; x=1769622428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWzHDG8iqyv+Ucd7/os26juf/34GwFLHM3tWmXv4Mbo=;
        b=Z4UwppqEJLRsmGt/pEFSTmi+m07GgURzTsTYPlHoLM39sgljgpt2Op1fDnE0zkboVD
         k+K4Si8CPteAC03OxqEISlBh77WiUdpx57WaFRSdsx73CPhDQI3UcHtudjn6MFHD8M2Z
         +r+oM1j8OQwldW7ItYmVw3PNc6XG+wUvVeCbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017628; x=1769622428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWzHDG8iqyv+Ucd7/os26juf/34GwFLHM3tWmXv4Mbo=;
        b=nGlA+OEAbIEbJou9LO4HYTjPowg+CXHpHt+UKdh6PrYkNgyqUxIrV8Pf2T/OgvcyvJ
         LOeZrtpQqwuu+7kJHoWS6JwTJwNALz31gY5Hurfj9iY8g5Mo5sLan2bxvNcjZaLvpA9D
         /nx3s2ykARhjrWq8tHpitgs1KaXptKBKKLLCXjPCycAhO9oEWgGSPgAccyhK97oZ8LbY
         OVU1dCqD9dMjRYYCbonn/fKsmJjPmAwwCq0WppFCiObr10I50tTzFeY0Hdotvw7LSH7B
         XHAKUp8EaokX72SeykYBELfzHc/li8bJ/LuWPAEotdeGjgqym5dUZdqLaBCNFiKo9p4s
         GTrg==
X-Gm-Message-State: AOJu0YwHfPCF9DbD22mHFAGDaE1obhWfPFet7l1W1c4pKsWncsgtXtfV
	UYFd+8TS/MxwaM0/qZ6jGeb0t3ZbOnMfV9EJDvi/+iEefLKMG+Xm/7A8dfgENbSzwJ2arINe0kE
	mDt7y
X-Gm-Gg: AZuq6aKLfuwZYins2w6Yl25D75K+bkZBgl9hZDX4IMHSV5/+c9cpJfwlmB8aCIzxurf
	MBXItkkpKSNwPSGu8Gy4naC/VXyASy1ihZC6vYPfkONCRrq/d797dgd0LfnVmurlo4RIe/fwIcu
	iwl2YD77SYiZkD+D18kTJRZPiboP24QuRcQkeQx3SiPQ2vtgTZTMJmVNtg0YpQJlad0NV5R1MJ5
	htu3BFAmNxp0tGIY2iXyJ+/+bqdxMVr0AQB9OWiTOkhxFLpztOCsTcASnKmpNyzVWlYFGnCBBu9
	xwKSndaGX/xT32PNOLkrn1XUQu8hXizUcIsAp8JcHI0RD7KA1x66tsQNGKHADGPVoIvgnAp88sA
	y1vvbWr/MLDYzomm0pt4W+bcHc3kA//2ZexMjHcCAZkEI26i8P9YnaoqatS3YiDS67kJ/QWHI7Z
	z5SC18Q16rmG81sd2QavUq6khezkZwJepIQ0Kzy7AghpPyY6QP5nUWH46eiAspd0wWdvbsQgHu3
	EXRIPaDx/gqMrDHEQE=
X-Received: by 2002:a05:6000:2504:b0:430:f58d:40cf with SMTP id ffacd0b85a97d-4356a02c4c3mr25819817f8f.16.1769017628251;
        Wed, 21 Jan 2026 09:47:08 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-2607-6b4c-4a99-80db-6945-f296.rev.sfr.net. [2a02:8440:2607:6b4c:4a99:80db:6945:f296])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4359f4a7ac7sm5082117f8f.20.2026.01.21.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:47:07 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2 2/2] schedulers: Add missing stable branches for non-core repos
Date: Wed, 21 Jan 2026 18:46:51 +0100
Message-ID: <20260121174651.64212-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121174651.64212-1-yoann.congal@smile.fr>
References: <20260121174651.64212-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:47:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3049

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

---
v1->v2: removed whinlatter for meta-clang
---
 schedulers.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 0018fcb..95d87e0 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -75,7 +75,9 @@ branchdefaults = {
         'branch': 'whinlatter',
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
+        'branch_meta-aws': 'whinlatter',
         'branch_meta-gplv2': 'master',
+        'branch_meta-intel': 'whinlatter',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
         'branch_meta-virtualization': 'whinlatter',
@@ -134,6 +136,7 @@ branchdefaults = {
         'branch_meta-ti': 'scarthgap',
         'branch_meta-virtualization': 'scarthgap',
         'branch_meta-webosose': 'scarthgap-webos',
+        'branch_meta-yocto': 'scarthgap',
         'branch_oecore': 'scarthgap',
         'branch_poky': 'scarthgap',
     },
@@ -199,8 +202,10 @@ branchdefaults = {
         'branch_meta-ti': 'kirkstone',
         'branch_meta-virtualization': 'kirkstone',
         'branch_meta-webosose': 'kirkstone-webos',
+        'branch_meta-yocto': 'kirkstone',
         'branch_oecore': 'kirkstone',
         'branch_poky': 'kirkstone',
+        'branch_yocto-docs': 'kirkstone',
     },
     'honister': {
         'branch': 'honister',

