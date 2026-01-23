Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11893D74ECB
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:28:59 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67439.1769174937604384968
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 05:28:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QLGprsQJ;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1414376f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 05:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769174936; x=1769779736; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Fri9l1fwedrUkdWFSuieMdVcR2VFqxrcBl51F24QE=;
        b=QLGprsQJjTt0iTq9msG8H7aKh8MFEBaSJsnARXJXRLtRlfA3XpgRMO1AdhaVQ5Y/3G
         pya/gMcmb3Agh4NaGtVUJ6fAhccciDW+7quZkqFJUBJwRDPMaokavpD+/3WdaoV+qAJ/
         XSurGeo4sHl2nicN8q6j4sylbTiSf/gnXFlDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174936; x=1769779736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+Fri9l1fwedrUkdWFSuieMdVcR2VFqxrcBl51F24QE=;
        b=aAL5j1pd/a9v6LFWz1t7QKjDmAOxbQnszrrJcCvjMqMkqqPM75hKDn/ic7FyqDVCad
         p1vsGhle4cU6d19eOSN877JIQz/+pVRpkWeOUan8kBOAwJsjZb0hxYbKERD4ycBjZBbW
         r/GeNZmCIUKgoKJCvMKyCPUEXwnHO2Y8ZVlmml30bIY0HrMSCyU6jcenJk4rpDO5nWVH
         8/tjCxNajdtIcJriI09c34NrHL5gFjDpn9opImiOOJCDlTp5QafLGpyQhL/8ZVpnlwwd
         xitFu8xga7zsgfDw9lXOo177YeigkbVuDWqCoctf1GHkDUZzklXn1LT6BkAWKjL362ga
         I7Fw==
X-Gm-Message-State: AOJu0Yw4LDjc46zu3Y17cuSCX7RyBd4z7E5y6ettdZShEdT4EA84S+gW
	z8ienSxC2mbnH3CI3rG4B5MreGsj+5Ng+4hRPmbF+t3dim1KES4J6CrpuyH2mn8mYW+9zInkbyp
	9bG6ryj0=
X-Gm-Gg: AZuq6aI4bIRH0VhSMu4NFL0J8GvbtFevNjGS4bbZhj8PFLtCqjz/iKg25vMSvLooC8s
	k5XaJPPY6gkDcseIkuxObgH73Po3zJXU5Djk0017h9qOg30FaAUrDMUBeOxLdXELE0EVzzhKHto
	PxAuruElrlQfuXhFWfD6E0bqfdtBVq1jxfyVW6LyY2/21GcD5OKV06lyWN8ukheEEg99OfbWFsh
	m04ErhtmB5Dz5cOrzuBhiAAevI7CNsnsUDZXejOnKE3OXhXjFPd3DOhPKpZt4w/tid8vL3QDak8
	uACjQ0rqyoWXkY/u3KjnvR9I2/SAfeV6cw7PEO7FBAO58yYmYpg0vd4HhqQZK1Gtc+5oatKJjHp
	pWLpzrfwNsuowkElohlQvl3lPSVRQ3AY6W6y1nO7PSqEP9sy2joTyNuaXiQqv1AUGyLmRuuB1Ji
	BtmAspIVb/dNuCa+k+v/8tAVDMeotOImrhhym5O61pXxO26pgPDiQB8/hC8VmfPGtwe3OM3FUaD
	eGY8npfPJrviaY=
X-Received: by 2002:a05:6000:4013:b0:431:1ae:a3be with SMTP id ffacd0b85a97d-435b158a451mr5061742f8f.3.1769174935737;
        Fri, 23 Jan 2026 05:28:55 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f73855sm6705693f8f.29.2026.01.23.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:28:55 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: Add scarthgap branch for meta-qcom and yocto-docs
Date: Fri, 23 Jan 2026 14:28:36 +0100
Message-ID: <20260123132836.99770-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 13:28:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3066

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index c2087b9..77d1645 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -130,6 +130,7 @@ branchdefaults = {
         'branch_meta-intel': 'scarthgap',
         'branch_meta-mingw': 'scarthgap',
         'branch_meta-openembedded': 'scarthgap',
+        'branch_meta-qcom': 'scarthgap',
         'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'scarthgap',
         'branch_meta-ti': 'scarthgap',
@@ -138,6 +139,7 @@ branchdefaults = {
         'branch_meta-yocto': 'scarthgap',
         'branch_oecore': 'scarthgap',
         'branch_poky': 'scarthgap',
+        'branch_yocto-docs': 'scarthgap',
     },
     'nanbield': {
         'branch': 'nanbield',

