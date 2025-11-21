Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF9CFC28B
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12354.1763734899334835404
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jKMwA4I8;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b23b6d9f11so198082485a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734898; x=1764339698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAe1n76s9q0EyS8Z/T7bkn9WuApOznG1EzoExZL/Uac=;
        b=jKMwA4I8PEv9cSew3jqszhhP62grN4n1XPwg7Bky8g5wi08p/uZ1fTWKB9PWXFlpT9
         FTaOplPZXSdU4NNpZv/eDY0pGwOaNOFQ4B7HwDuTNSGY9AOZxC04q7qznLUXOkLW681S
         XqcbpMM8kAyVSvVMwv04d1hWTkY3IIf5b//po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734898; x=1764339698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YAe1n76s9q0EyS8Z/T7bkn9WuApOznG1EzoExZL/Uac=;
        b=LtRSSsqOrdlB8CVcB8N9FIscGFe4finigdxAm7OcB3mCFllaK0UlGeULTHeSevQiHV
         T4uXqkVIKWJb25xZuYkx0qsBLk2Nn3tG9uqWGiMYX9GB9iXueIyriYROESazFj2xnY0/
         FCid5oTzw/ISDwRCwWNirqTLTW3hYnG/JlPOvgHoQhwDhTSRDevyePfVQEHcIpA2dRvo
         Za4xtm8LCvV6EROnDl35Qe9IjQ5C3N4sPQzgmGVc5x3R4/GZPaESS0jjdmpOx15oQh6z
         OcJbbsvmTqrFo0TF4/rglIQML7MslXyMGUAw6IB6FbAFunEy6Abe+cwmD5lattMC3iIZ
         u07g==
X-Gm-Message-State: AOJu0Yy+4HN+M8e0RJTVC+EtSrf2wA14qdd5Cjvi5RkBm4ijl3k1YER6
	jaVpTGU0m+E03TotB6kg5uTYONklTamJ7nwa56hwcv+tCfrFKAJflABOUH4Ejsk9laKYpuv1h6j
	/1ZFM
X-Gm-Gg: ASbGncsMHcLSgwF4VVQi8niKX2m62EsZpLzDkjQ34a6p/qyCkodLmdT/npRP2rIArri
	mnyUPLjmDroG9rjOtLEdUcsiiwkJpq9cyPOpCrRfqyciDC558lgxCwEq9+G+xDzcNrL2Fm6X84w
	uMkmV9PCJTybKGdGan2mssAffUKUjVyHp9RcB21M9kj5Hf1qtLlCLIZvEpf1H4AfA6Id6TTTgft
	vXSjxpdcz1A2tDw+/Y29CPhGFdJHblIe+3avn+hAvhgaTQtUtxghOgqY+wCJnkZiPbBJSnxy5iL
	SN3xPytMCiafgEazFQoRhsAjf2EIp/vC2mjRuDBzqGAQtSjG51APV0u8sbcAwofkLuEtk4GciyU
	6D1d2xXvzY9O0GEY1SjHJ0P8bPNwd0seKdUdDa8EawOJRw+aFS8wNvotVO4QxH+KxZKPAh3Bd5i
	1lHmTNUkZ7MBSSCeSRznvpILde1UIwY8Byv8NxlE0ZJ4b2n44wsTiMfOit/+rUOVNULa9KhEs31
	g==
X-Google-Smtp-Source: AGHT+IHgLhL8UJ621b95RrVe8VFEdD9x8XM8uVnmd3c8ajZXhkY3Qc2PSOrrkelXK851hL+4ktR4gA==
X-Received: by 2002:a05:620a:29c1:b0:89f:5f63:68eb with SMTP id af79cd13be357-8b33d1b2967mr255281885a.13.1763734898045;
        Fri, 21 Nov 2025 06:21:38 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:37 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/6] libgssglue: update HOMEPAGE
Date: Fri, 21 Nov 2025 09:21:17 -0500
Message-ID: <3b67d414b350301088b2c982e6963b867ca93370.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2647

From: Yi Zhao <yi.zhao@windriver.com>

The original homepage is outdated.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 532227a..3bc37cd 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -5,7 +5,7 @@ mechanisms itself; instead it calls gssapi routines in other libraries, \
 depending on the mechanism. \
 "
 
-HOMEPAGE = "http://www.citi.umich.edu/projects/nfsv4/linux/"
+HOMEPAGE = "https://gitlab.com/gsasl/libgssglue"
 SECTION = "libs"
 
 LICENSE = "BSD-3-Clause | HPND"
-- 
2.51.0


