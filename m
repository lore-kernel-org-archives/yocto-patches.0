Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1742E7717B
	for <webhook@archiver.kernel.org>; Sat,  7 Dec 2024 15:32:48 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.62051.1733585563972291709
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Dec 2024 07:32:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YkV/I1BN;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53f22fd6832so402959e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733585561; x=1734190361; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOOBna5kueN0iL+XRnlM3rOf7KkVu9PHFs6GpjxCd88=;
        b=YkV/I1BNYgiL+DRoOiqg7JBIxEme4pJ5Rzt9GojUf7GC7ZkX79sIB87X169Q9zAUF0
         NWQdRhOGLjEj9dhhE+Zv0HDOxcaE+FqU5bs181dypyBu65K5C1Cpav+de2ZZC5lPUhNW
         IUrq7eAYDjoFdKx2GZ+UzK2nLHXbptC+ZWh8Pm4DUoLbT/yBLCh3tAbWP98Fd5xSqeEo
         l4+O29mQAPXpq3vKqHSrvnj4Z/S8AvB2bZppNyRUyAPgjFlzlLaYJIon9BRzy/A4KtUL
         PYsM0X2t4/nrBVEdQrESXnDFrHMwz+4gLM/Ye4bJ2yff0hICrQE+h6kQxi1kLDWme9bC
         7s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733585561; x=1734190361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOOBna5kueN0iL+XRnlM3rOf7KkVu9PHFs6GpjxCd88=;
        b=muiD/8micxjhkexzwAD8WDFCyaEibKFuHnAhIKHwCXqhjVcL/MaRLO3Pi/Uz7FH4Is
         NV7UWIYkMi62SpKHIqqeIfKodu9hjyK8nB2aP4hOP3j3/osdWDQkrDfkSxj5F6GA4ShH
         1DibC/jX+iD/VyIzWudTVNVc8Zjos5Vc/vaZKDt9XcKtqWregMU9Pzey2dfpPpvt5IJI
         LuVu6hVRTVd5LquB7nx5l90w3pw97YiqjePYkyYtlZs/zb0AjZZs8u1E60bIPaBgsAIf
         xm1gI9MZkk0E8Hlqld6gkQGpG9OqVJZr7hcgPaO/E9E9/jwNn+xDg+aUG/HUDlS8NOAa
         R2EQ==
X-Gm-Message-State: AOJu0Yy6QkNKygBQSMgaguZCwbRWTx3YgeLk66Zx/7Mh55etLLqutOaU
	1R7bsvCnkObF17ZVfOB4gnrbtPyVteFBec0UTtg772FwVXdg+EuDhJV/cw==
X-Gm-Gg: ASbGncvHC5rTH0yrAvRvT+8dHinpPTywqHu2JVMIShYQfBlKR3CG11vg1eggmCHzUjf
	jsA2Wbw55cri9nzci/mOrrEf/ZPzhA3wScNtMLvR33sRBrD8K07yyFTdQpJaEUy94Mtsf8nJunj
	hiKxhcER2cweJdeHzoAMKIOmDpGnUb+PhLsqcN0LQHY8Bf0OQ5ndTFY4OehQdLvrxpnXp+IpuQ8
	BNH03MVLytFzDevjTykYOXI5JSJm9kg8OgGUp7eSs8ccmaUCmQ=
X-Google-Smtp-Source: AGHT+IFLpHX/k59zssSgJ1T1Z2+pzpmAGBpjQFBrHfFsoohXfUR2aN5VBJncXz6y723kCeMB9nuS6A==
X-Received: by 2002:a05:6512:39d1:b0:53e:27d5:85db with SMTP id 2adb3069b0e04-53e2c2b1ab8mr2229886e87.12.1733585561034;
        Sat, 07 Dec 2024 07:32:41 -0800 (PST)
Received: from fedora.. ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-302192f2c7dsm148371fa.29.2024.12.07.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 07:32:40 -0800 (PST)
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
	Trevor Woerner <twoerner@gmail.com>
Subject: [meta-rockchip][PATCH] linux-torvalds-next: update SRCREV
Date: Sat,  7 Dec 2024 16:31:53 +0100
Message-ID: <20241207153154.9125-1-oleksii.kurochko@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 15:32:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/867

During the fetch process, the following issue occurs:
 Unable to find revision fdadd93817f124fd0ea6ef251d4a1068b7feceba in branch
 even from upstream

This issue arises because the tag next-20240904 and the commit hash
fdadd93817f124fd0ea6ef251d4a1068b7feceba do not exist. This can be verified
by running the following commands in
<yocto>/build/tmp/work-shared/radxa-zero-3e/kernel-source:
  $ git tag | grep next-20240904
  $ git branch --contains fdadd93817f124fd0ea6ef251d4a1068b7feceba
    error: no such commit fdadd93817f124fd0ea6ef251d4a1068b7feceba

The head commit of v6.11-rc6 is:
  $ git rev-list -n 1 v6.11-rc6
    431c1646e1f86b949fa3685efc50b660a364c2b6

Update the SRCREV to the head commit corresponding to the hash of v6.11-rc6.

Fixes: 7f91ebf5c17ce ("linux-torvalds-next: bump to next-20240904")
Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index b961b14..34bb9d7 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -18,7 +18,7 @@ SRC_URI = " \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
 # this is tag 'next-20240904'
-SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
+SRCREV = "431c1646e1f86b949fa3685efc50b660a364c2b6"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.47.1


