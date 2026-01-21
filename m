Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E7D46950
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 16:34:43 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15799.1769013274190743582
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 08:34:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MqddVXYl;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so413305e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769013272; x=1769618072; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIubklmVhvLhKrlmQ0ovcd0l+pqTcIjKi/TJARpmJKU=;
        b=MqddVXYlzcNaMGx6gfBkkEvzBiMvg+JBrSKMfXN9FFubjZfR+q0132Bgn4xJ5P7kW/
         SBf4clldtSxVZyNJYo6p+Ulpofl0NVJ1/7CU6qSNwCYyHEDv5g2gXsIhIbsvlb9IfhgH
         P2KE0IayZ/oYyqXIT2kaKhDyh02AjM4Vfshug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769013272; x=1769618072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIubklmVhvLhKrlmQ0ovcd0l+pqTcIjKi/TJARpmJKU=;
        b=S2d0ZdgGQnLIKMvHjAqqKd+8FL/BQ0K7O5GwU93+7ewotShgAYxdA/Q9aldlAYX6kJ
         TaDZ6OX6EMm864fGWzdIT9hoLtv6T/SjUuRVqKe4YNEii7AkuakK/sygq554e6d2L0oL
         +0Fhs7+yfI6ZXgC1K7niDT8rMlsq3WiYnU3aZBKLzXIU17SQp2U6KPyk0xzWMe9bttF2
         BpF/pfnDH+pjjO3/E0DoA+vJr1W/F596McYs/jBF042cnPXsBumFDXFU/gWfpIC9YWQk
         sznE1BOcI4C+upC/7QbNl/OpxzHxbpG3DBsdCdsaYTREn/VCa4ujbC0rJ8rigagQ7fBl
         u4Aw==
X-Gm-Message-State: AOJu0YyqIo5+n4C1ZOBxWhAGQYTcUc42DrZIOPpGi64sKwYTQWH9kkOA
	mD8P9nB0Z3Agkcl5UK5vOHSmkNJUR/Obnp5Co14ateakMb7zL4gJipftyurAwECHJDMktUsXAcN
	cejS4
X-Gm-Gg: AZuq6aJ7bCe3P7kNs5jP4k6ESi6WG+YVo5eNs6CicAH+hv9QK8vb1WuNOiby8WpVx1e
	2/hHAaJpQG1yH6vi1Pj66kc1JyKdK4Xm4Rx9G56nUcbYdHayNK9mkXF9OZrUp6kuNVmjjrbQhkQ
	Xz/giRLTPFq+vKkTTgLujzl/wv1E5k+dWwmf0X17Zi7vh0swSxexKGZIYzce/6zZPAItGZvbLLz
	clB0Th8WCE+uzmGH+QIyU2MRG3eT2qXIAnXzjxeSqdyiI2jk2hPAs9CMjWGJSJ8u09yC3+JyPp3
	2ktbgfo7/wdi9x3+OW1/wg6TMppDyTTWRU93V0L1+IaooqhUYxHOmTpOyZojDFw6CwaelEOkniT
	zbJlaODV3o/lZLHe9+BRHJ3QeuYrMeHTBk4Nra61pa1Nn9xMmTZv90QlgVuJezT5XOygKXI9Mam
	yxRa10nVoXmR0e9A4Jeag/tZHjPr/ExOLE6ZJ+5EiYv49Oayj53f4DmGwN+bN82v30mH+ceX15I
	jpszPlx571dxKjoekpH9Q==
X-Received: by 2002:a05:600c:620d:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-480288773f6mr202226675e9.6.1769013272367;
        Wed, 21 Jan 2026 08:34:32 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042b6a3e2sm26955775e9.1.2026.01.21.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:34:31 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 2/2] schedulers: Add missing stable branches for non-core repos
Date: Wed, 21 Jan 2026 17:34:09 +0100
Message-ID: <20260121163409.59824-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121163409.59824-1-yoann.congal@smile.fr>
References: <20260121163409.59824-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 16:34:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3043

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 0018fcb..036d66c 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -75,7 +75,10 @@ branchdefaults = {
         'branch': 'whinlatter',
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
+        'branch_meta-aws': 'whinlatter',
+        'branch_meta-clang': 'whinlatter',
         'branch_meta-gplv2': 'master',
+        'branch_meta-intel': 'whinlatter',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
         'branch_meta-virtualization': 'whinlatter',
@@ -134,6 +137,7 @@ branchdefaults = {
         'branch_meta-ti': 'scarthgap',
         'branch_meta-virtualization': 'scarthgap',
         'branch_meta-webosose': 'scarthgap-webos',
+        'branch_meta-yocto': 'scarthgap',
         'branch_oecore': 'scarthgap',
         'branch_poky': 'scarthgap',
     },
@@ -199,8 +203,10 @@ branchdefaults = {
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

