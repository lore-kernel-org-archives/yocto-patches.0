Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94545C25B79
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.62679.1715612377732109242
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=E8MrIegv;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.167.53, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5206a5854adso4560470e87.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612376; x=1716217176; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8LdnbLtve7OP6v0CvU2Lv95DTIc1IoAqH8ha1jFljTQ=;
        b=E8MrIegvvc2IphEkROFyFObUIxVCoi8+CKqB7CvRF+eRQU4ppAyifEbfJGSmlFle1z
         YKyPaXBuZDn/haerg3LbVvwVBXTQin1yOnSOml7jhfqrZQbMiqyQhgJsU2qs354uuDln
         Nu1LHsJmCP1zR4WXRuhCNVwcj2NEoe9K2JQArX4Ek1iLJmTEyOEdPG0tc+RIf6S0X88Z
         v18mI+8XIfOr2TIkF2dyLU1sSeTedei8/SE8JW4f4YROv/3ZOjrnL9dFmH2X7CkBFQgL
         MbJeulhq5DV9+sgMfNz22tbIP6HSya1DGGdjw8U+gEcZYOoPQZQaGyN8qHUSwE3KCZEh
         m82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612376; x=1716217176;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LdnbLtve7OP6v0CvU2Lv95DTIc1IoAqH8ha1jFljTQ=;
        b=nJEmK3OoA4Wimp7leTtx1oBT3kRYGmsox6lPiBB/+QZbZ2c9Uj6YKVDFNwKtabzAB+
         PULATrE1dJ4IAf5oWK0tb6Mx5JmhmfpwsCkTU/pX9M7uILK7LjFq5TVTN3G1d1/Kq2hW
         AVUL9uiYxi3++wENxAC2zH1Chd25HrKmqEJEg2rEBqEJtr9z2nTnXPXlZP64kkr6hBbj
         7dzk7/ekuZI10xr43iRdY66uZSMg4KvUyFg/6UaWMWQPnaNvvsq+NvaeJRzYwJIy490M
         LlO0pVR6JAjJk8AGFnFjra8+CDyIi2ix41PF7Swg+CUB/pCYHHFCtZ1mhll4h9EI2Yo6
         JRSg==
X-Gm-Message-State: AOJu0Yw0q6bK8xV2oenakTa3z02JkPQ8vq13VvMAwtZgnxv8tBUa4cGd
	9PoO0Hd+C1XqdF9wsEBOjF0UH6j37T0D70t8wdBf5uLb+ExuBiz7+3XuGQoutH4wUnw4ES30KvR
	z
X-Google-Smtp-Source: AGHT+IG940VHds0z0W0jZ7/vEUoQK8C8fnLKV5B+ZunZyKHNrOkRUHhE24daoLu6Q7qQ4OY2/BbQWw==
X-Received: by 2002:a05:6512:324a:b0:520:6fb:41d with SMTP id 2adb3069b0e04-5221016e79bmr5236013e87.55.1715612375782;
        Mon, 13 May 2024 07:59:35 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:35 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 10/12] index.html: add line numbers to CVE link lists
Date: Mon, 13 May 2024 16:58:59 +0200
Message-ID: <20240513145905.4167-11-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/130

From: Alex Feyerke <hello@alexfeyerke.com>

Improves readability.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 31c5bfe5..a847a456 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -412,9 +412,9 @@ SPDX-License-Identifier: MIT
         html += '<details>';
         html += `<summary class="sub">${name} CVEs</summary>`;
         html += "<ul>";
-        for (const cve of cves) {
+        for (const [index, cve] of cves.entries()) {
           html += '<li>'
-          html += `<a href="${cve}" target="_blank">${cve}</a>`
+          html += `${index + 1}: <a href="${cve}" target="_blank">${cve}</a>`
           html += '</li>';
         }
         html += "</ul>";
-- 
2.44.0


