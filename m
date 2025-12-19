Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F2D74962
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 07:01:47 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11974.1766127699589396479
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 23:01:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NmFw4Pf/;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4edb6e678ddso19941461cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766127698; x=1766732498; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou7h1mp8mUL/hBzBha/E/mLk+PIB7USTibhaAYg8yYM=;
        b=NmFw4Pf/qxX5/kIQ3cAdE9FLOP2Gg33I00941WambVfIoj98EqlRaGxYk4xtbup32l
         FCZz0E0A4M/lBkTm3Qw10zapE+VNLXqnDNAh2X1+6OO0+klT7B285hyVM0/tycIH7K7V
         kU4+elDdCI3QeyoIKOUd7D6X+8wd63nEEd4WaYLKKrvSA+doFf02UXPdOiK/O8ikNNwp
         wO/xfXhc1l3ufs7HKOWSm1ZBbUnNETJ6okYe6xj0kCJb77/X/vT2czXdlxz9d5kjeOvN
         QxW74WBllVGD0+e2dz2/Wo/tKVVw5aqAcfNWbQE8ppiPR9WShJj2B/bpQ4oNfJO8cP70
         pPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127698; x=1766732498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ou7h1mp8mUL/hBzBha/E/mLk+PIB7USTibhaAYg8yYM=;
        b=LhwtsyZElROuY7H2Ce0CVIDNvGfYM26GZkTzNmMNDCgp5rjd/f34MIgNT4cxUEIIqI
         Wk5YmtmMfjBItQK2s1p9+Y3Ei+Ntiz3mH2q3rKcgeCY9tCEl6j4l80helACOL4PhA+oS
         P3V4x5o+ScUNCWFGf+yGkhfut8a598LddldRRL2IUta6HFcDJQ5tFtv05KkxHS/iVMCw
         TvySHLJQMbfry3oQTO2d4UPmf0wVVVaTFFVGV6GPGjuj1VLrs6CVc9r4vvEDulrBeYpd
         Exyxnm7e1lRUtt6hw7ceF1BbLGfE+owkXTMrmn7pBq+yv/A6NRlVcvqkTSBOs+f0s5gX
         S0CA==
X-Gm-Message-State: AOJu0YxYtGtvWDMeVETPxXn4S7uQTh3JbRlhx0jRd9EpCHgJyGuNuAcH
	9oct+wZDquj934eqRv8bAftcMIs+/Ignou/kIeZlNRu4VgV9zKf2TX++IinOHw==
X-Gm-Gg: AY/fxX6aHPKaxKn9I4Ndty+QEMsK3tEwmjnE00lTFEU5zbWJbDJdg20ogdpEx+ia+kS
	WhMtyerrW/gh6YbnRLNaHtNQ9M0lto6OQe4weSdv0UbkEg2TKuQEHXhNiQoJv6MFMW5e5Tr6qSN
	FTcTCaLwkQJ12qJZp8Ir0W6XMa94FXKza61V+XH38oEU8jB+VbaNNz/M6RHF6c2ybmFQ31PnIFK
	PVN8EvqdxmFoc2mmL4zwerKdhEzIGnkDLxe4G49kQTtEdat1blP38gJipXoegsKdLt2DkNVCxWc
	5islGMGM/6s4AoXb/FDEY8cxk0lu0TGKFR8HYlHXlC+sfl3RI8AytQ3Ol6rjBbalTbxI4vz+PCF
	r0CgzCIcENbn+V9zsIN8GDNWZ/ZR9JNsdp/kJ1ouvfnQKHBROewfAZw8RnmGGUjaLl6mNE4IlVN
	0Sg8JlM2SujH09GWbhvc5YgwZMayXd19CwHEcQbzaI4uZBN/Qw
X-Google-Smtp-Source: AGHT+IEfM3UAm9gzTV99JUJzir0Sp6wn1HBEugJgJtqCfYieUuFTfTdnLmpBydhYCUjnsmLd3X/pyA==
X-Received: by 2002:ac8:5745:0:b0:4f1:e97a:db01 with SMTP id d75a77b69052e-4f4abdbc47dmr26468321cf.78.1766127698023;
        Thu, 18 Dec 2025 23:01:38 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm13570166d6.40.2025.12.18.23.01.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:01:37 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 5/5] fix u-boot for tf-a firmware
Date: Fri, 19 Dec 2025 02:00:14 -0500
Message-ID: <20251219070014.39432-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251219070014.39432-1-twoerner@gmail.com>
References: <20251219070014.39432-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 07:01:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2827

A change was made in the location and name of the bl31 artifact for
device firmware built with trusted-firmware-a. Update the build to match
so these devices continue to build successfully.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../trusted-firmware-a/trusted-firmware-a_%.bbappend  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index 4c7fc3c4c180..7c94b646c316 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -47,3 +47,14 @@ fixup_baudrate:rk3588s() {
 # If you use upstream U-Boot with SPL_ATF_NO_PLATFORM_PARAM disabled, you can
 # simply override this function to do nothing.
 do_patch[postfuncs] += "fixup_baudrate"
+
+do_deploy() {
+    :
+}
+do_deploy:rk3328() {
+    cp -rf ${D}/firmware/trusted-firmware-a/bl31.elf ${DEPLOYDIR}/bl31-rk3328.elf
+}
+do_deploy:rk3399() {
+    cp -rf ${D}/firmware/trusted-firmware-a/bl31.elf ${DEPLOYDIR}/bl31-rk3399.elf
+}
+addtask deploy after do_install
-- 
2.50.0.173.g8b6f19ccfc3a


