Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77138C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 18:45:28 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.30246.1752691520851900803
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Jul 2025 11:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HEUAbxoA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.215.170, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b390d09e957so122403a12.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752691519; x=1753296319; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ro6nBxNvqyPgV4ceKQQCUA5/t/l2baqIynddfsE9yg=;
        b=HEUAbxoAlIHNp9K785NDDYsXFwpU7SBMnfsfvZ5RCbOxxNSG+qotUIg4p0GeSZMcfy
         fPDgW5hxm6CQahV1FGwgOjIVEgCc2B4qMCt50/yN1vqSkVvXEMYIKKzPP+u76bJ2EU9S
         LdTbkVAu7gpjBUSyHGjP3Gy/kPF9wKjE7176I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752691519; x=1753296319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ro6nBxNvqyPgV4ceKQQCUA5/t/l2baqIynddfsE9yg=;
        b=GVLK6XvtX7O2sgfaXVSRw6P2gn4xF5n5VieoF4H3pznK/Sq9Nl48TiUpn4rmFdp8ke
         HtF80s35vipEWZsYCem76OWKNXOE1aQe3GBrcZd7QmWrc3jGI9FcI7JJAsQPNe4G9VII
         se/+d7zdVslbGXrNcrOkFO1vjTuGX7QTG4QH3zYo5i+NNbobyou0ri71EYpz6Aui0qx3
         dal/CFUoKhTkw5aVWJnHdhhnBXcVkDz5ttAMbmg8ZfrADKhM2VIl9ZCdfneYI1ykRw0X
         VyglnigqnOtaabeaj3qtUkxehvPFUmZ4WdtAXa8uCQTgQu2sWD4rLZ7aclrK9ap9dLvJ
         VplQ==
X-Gm-Message-State: AOJu0YwiybhaM6AJzdFS1Ri7J5R6cwfHvuI+N2wJpSou05vCAa4rnf8S
	rmYNu7xf7XOGqLO78kwWQUUS0dbm306v4yzyC81KNSvF11LpoTwy58C3ffydajxgrjGhvC09waD
	oSDKx
X-Gm-Gg: ASbGncsb2jAv7n5ybFON3SiFM7+UXl07gRQqCuByz6tbxKyMqxUgT68vXsHtmANHgL7
	DaFOwzM7YkUgzbBm9o53OxlBpOMPd+6jLkTdL9/UauFOrqVraKyL+82eqWTTuUkEA3rSVBH/oKu
	dNXE/GOI0Zep7hIOfKbpAypBF21WMFSf982dBafyXPNcKEPBNU12fcKPVpxk+sd7ueZZ8Oi2fz7
	6vSC/L4JBftGG6SgJZMHHU7ZdLQN6Aghbz/56EwQIrMEEMVmVHuHGxl+BLFQeXVkGSt60hpIH2r
	oS9xAs+jIA006GP18znTbJwgPu7hdFFjLuE592honGhBh5tj5HhNq7CDd1Dsz57qzrvIPlo0KNK
	Si8WGKKMZjWAOTPrd6OjXNOwNxuuWan8=
X-Google-Smtp-Source: AGHT+IH1WhV31O03k1MoVsxVvU3y1l3XVh3cTkfcwdDNcrqjVi2lyTLjTlxKrEQPmmNF4/tnomXPrg==
X-Received: by 2002:a17:90b:2b4c:b0:311:eb85:96ea with SMTP id 98e67ed59e1d1-31c9f3c5719mr5315419a91.9.1752691518971;
        Wed, 16 Jul 2025 11:45:18 -0700 (PDT)
Received: from yoctolap.taild15c8.ts.net ([2001:470:b:487::627])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf825ee4sm7152a91.41.2025.07.16.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:45:18 -0700 (PDT)
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org,
	Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [yocto-autobuilder2] schedulers: remove obsolete ourTriggerable class
Date: Wed, 16 Jul 2025 11:45:03 -0700
Message-ID: <20250716184503.187037-1-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 18:45:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1805

https://github.com/buildbot/buildbot/commit/c8393c1b0df442d7603fb2212c11a50d163bfdc5
eliminates the need for ourTriggerable reconfigure safe class.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 schedulers.py | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 11e42a5..309cb19 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -457,17 +457,11 @@ def builderNamesFromConfigFull(props):
 
     return builders
 
-# Upstream Triggerable class will rasise NotImplementedError() which will mean triggers abort upon reconfig
-# Hack to intercept and ignore this, we'd rather they just survive in our case.
-class ourTriggerable(sched.Triggerable):
-    def reconfigService(self, name=None, *args, **kwargs):
-        return
-
 # nightly builder triggers various other builders
-wait_quick = ourTriggerable(name="wait-quick",
+wait_quick = sched.Triggerable(name="wait-quick",
                          builderNames=builderNamesFromConfigQuick)
 schedulers.append(wait_quick)
-wait_full = ourTriggerable(name="wait-full",
+wait_full = sched.Triggerable(name="wait-full",
                          builderNames=builderNamesFromConfigFull)
 schedulers.append(wait_full)
 
-- 
2.50.1


