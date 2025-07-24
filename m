Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3401C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:31 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.6901.1753342047498097728
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=APHsx7PA;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so4293085e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342045; x=1753946845; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MQBCCw4tMdixUvsriFLJNx/IB/eSKUeFVwA5q56PI4=;
        b=APHsx7PAxCoh8ewjTgJh0+z+tjN8YBhI3Nbd1/0BH94j6qa61tyMfwWYwugCkwqxIN
         FzH7oDEl0a5EBjkB0jc5GAtIvlI1BEXv/QbXxHkNJcPh+zaa/jgpcQA9fbXIDljDREbS
         fWZ4yZKoSLot/Z1oi3EaxRrYWPAhwNmClfCVys3emo1pIwmoXH4nY8IT8ttSGxbzT4bd
         Gz4TTHoLuZ1TarCxom5+oiKgwfrswm6o6mwPIeHCzSfU9PEo2FCQ2lDhKcy8OPTUzSbJ
         1c+iN5Oim30tcEW2DbuJMiQxMa5qpWhTIpZX7CJ17NbL/KfCxwOVVWEKjt//Uk6Fykmq
         bT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342045; x=1753946845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MQBCCw4tMdixUvsriFLJNx/IB/eSKUeFVwA5q56PI4=;
        b=MNDpo5wAMglpC1tXGRfY/m2wOC3rfvfEcLX5koskx+sz+98doF3W7eFE28MysMf3sY
         7q1zHwP5VTBrocFTi+CMmLSMZ/W+nslEaOW5wwSljW45dxVDVXE5lFYdi6/zzCmwfg02
         JnEA+smc6v0eXnksMi1d7tOuuCb9NQl9NzNmFKBc1RuI3bXXzt8kRb6NzgTGgFd3tJBG
         NQI48qslvg6cjLkSOe6uLDFAoGbrjrdmd9v/kqHIdqVldhGobIwisTbPLyRSCeS07LYd
         gVw5jSgO1PYtxDG3IVvmiiN+yhypgeZHChOJT+4PW1IUlGGNSoJrm6+yWwnDeNwQElYH
         VD6g==
X-Gm-Message-State: AOJu0Yw90zpImJftUi47a1sjD1UCj/N+GALpesTGEO76wI67mEJG88BG
	/Dj5NDuE7sM/c+Eds9FnBvMO6nTZGBEfDdr8IVpJbD3QBSF4lOeu5innL1/ndw==
X-Gm-Gg: ASbGncuccXTIVFodYOGFCdE0Vo48ZzZZnWH/TyL8svq2NVn1csdRRHH9OZcUdkZbFlz
	86BMTq6jYiCJ0FRmfGra0gyG6YS4HZDq+5/J5n/8C17cPIunhsMrw6uvVumfg0VPLo6mQyT7SCy
	aJ3pS92+s9utHaK/G3sNOHOWh3e8aHSfVMLgsKHhBV/7BQbUl4M/yeWM2+AsEVQRAW91aMNIgdo
	Co5k9XLqC51jZ8b6/cOqj+9jt0U+ZLK3ZckJ79oVjIssaerJ0YA7Z+pf0gJmFvANTGuPHRZK+8r
	CW2zSaxd8i619F0qMJN4gIQPcW+XLr73Cjs1bEZbJOjfOWUDhABI+12gzpwXkKYayRpniEf6rj7
	LoOmiLZCiZKLwO4CySH5lMZ/z2s566BsEcS0=
X-Google-Smtp-Source: AGHT+IFODYLDOcvn3Mlkv0RfKI+y61PJmeIDrr/ezkY6moB4I2bhvr1ths5igRTM0QwKStPvnliWFg==
X-Received: by 2002:a05:600c:8b10:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45868c9d357mr62699205e9.10.1753342045241;
        Thu, 24 Jul 2025 00:27:25 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:24 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 6/7] aide: remove for musl
Date: Thu, 24 Jul 2025 09:25:48 +0200
Message-ID: <20250724072642.7358-7-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1863

Aide currently doesn't compile with musl because of copied getopt prototypes
and implementation.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 77782c9..bda78ce 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -91,6 +91,7 @@ RDEPENDS:packagegroup-security-ids:remove:powerpc64 = "suricata"
 RDEPENDS:packagegroup-security-ids:remove:riscv32 = "suricata"
 RDEPENDS:packagegroup-security-ids:remove:riscv64 = "suricata"
 RDEPENDS:packagegroup-security-ids:remove:libc-musl = "ossec-hids"
+RDEPENDS:packagegroup-security-ids:remove:libc-musl = "aide"
 
 SUMMARY:packagegroup-security-mac = "Security Mandatory Access Control systems"
 RDEPENDS:packagegroup-security-mac = " \
-- 
2.47.2


