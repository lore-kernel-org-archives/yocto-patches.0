Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DCE7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:42 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.152501.1734703537809125319
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FYbOWTi5;
 spf=pass (domain: linaro.org, ip: 209.85.208.182, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-300479ca5c6so21031551fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703536; x=1735308336; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDpYzgIpWFnCb0ga3TmMLAeZRbiig+pTw9O5aBk+SKI=;
        b=FYbOWTi5z2zvXbBaxlNL364DdKT8jqiBAH8Y1lRF1ugepnsXqhXTHaCpAWKkOji+qe
         ksGKYkItlbUPfgeYMrUWjbFgOxmoo/F5lqgO24sL0NW+Vd+EsOaw2ZSwEH/Lw8obJiMN
         2MSFzmyVdfNxb0Byl1I2xAkD3X3OgJT8lj2ApvPmWrxtKiKaq5FDCezV3CF31XCNsqL3
         8VHP5GBTz4ouisnvYlt6HfXldns0OAcYphU3s+osSSeKcmotjRC5EU+wNdvCNSh2Mp10
         O3Sq6+wmNrO2+TBhmd8R8QqRzR2lSNRINGX3xwCMxozAgcRf7zoyzE1YlL+qqYacphIn
         3T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703536; x=1735308336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDpYzgIpWFnCb0ga3TmMLAeZRbiig+pTw9O5aBk+SKI=;
        b=dIM4uDFA3NzEY3LjIcykGbjrhREFq6Tw2GAv5tn/H/+pOPOVWLtqx20Ny5CsGDh714
         6sC4q4/KhMGot7Ini0dRq/rAcu17n9d/2KtSAG7lJqZJrKy8ddifEOlARcJ+FRH0/stA
         s5d1iyYnTHZQD+CA1KzADxesG/QxZPOEw8QhzIUzsi/qE5JHSya2+Yk8OVlfljCbqSsz
         5mEqyFVsMjKKGB/D3eLV4w/OheBkjeG/lOqiSaWPFqheuxzhAErFVM2DjtbXtxg+uVoH
         msTiwLcyiCpqe35xbazX+JVo8Vh0Gd7QdQIsGQ7Od28oHk/PHOWEgJNNS2mq5X8eChSj
         jyUw==
X-Gm-Message-State: AOJu0YwIkohMQ3J3rmoiSjxr4rzTtK+JSVF+XCLv8eevzcFLS0uobM4+
	wY+tiWj+UF6swZG8IUx+jDwAtvvwjW6YMCY7yHZmxpoKIIZCPa9rVZPzJbeADCERcu7hIXFaNK1
	7hL4=
X-Gm-Gg: ASbGncv0bBVTU3d01+08DsZC5UUatS1rzbW8o/ixy1O6HPevqs1A2s1HSC8UgpNY8nM
	YeO4NGjFEzWk4SsNzx1LS90sqxB2n1kyesijprazK4HdJBmUoUBay/rwjojcEkBqDw725UPHAEX
	oc9lU2NQQq02JVM0vklwzbnDy8KxKiXqulYHdDapXTo+sO0L0bBOVPz85RI8QKxyn8WSGjx61lj
	9OTa5dpYyjMqtpkG3JOm2LAVzJowSEbH6SnzhI/aBhkVEakmTD5Og6vDp9/UnM+8Bii1Ks4wFhR
	cP8RGUGuPjL0jywVIqNXcv5KAQ==
X-Google-Smtp-Source: AGHT+IFOm6sqnBq3p4jXBl8x2JUIfHzUFGHunWq6ZcpDrD/7ca6XMiwgV+gVrbBmXomoqNRSm74Sow==
X-Received: by 2002:a2e:b8ca:0:b0:302:1b18:2bfa with SMTP id 38308e7fff4ca-304685b9d5cmr10862001fa.23.1734703535813;
        Fri, 20 Dec 2024 06:05:35 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:34 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 10/18] tpm2-tools: add dependency to efivar
Date: Fri, 20 Dec 2024 16:04:33 +0200
Message-ID: <20241220140441.271395-11-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/949

Without this there is a floating dependency which can fall back
to build host and possibly fail if header file is found but
shared library not. Without this change do_configure log
shows:

checking for efivar... no
checking for efivar/efivar.h... no
../tpm2-tools-5.7/configure: line 15461: efivar: command not found

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index bb422cf..fec5e1c 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -4,7 +4,7 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl"
+DEPENDS = "tpm2-tss openssl curl efivar"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-- 
2.43.0


