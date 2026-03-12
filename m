Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F67FED2E7
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 08:02:46 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16627.1773302555270898100
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Mar 2026 01:02:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=o/n8x/8W;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a159c1e65aso718598e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773302553; x=1773907353; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jHSsySGrwWmc4KWJ1Y/Z7PzPGSIpyrTWsoltylkjnU=;
        b=o/n8x/8WomaDsFe2r21lHRrI/BK2hOoScQPyDVOYS0v1fmmrxt4AtNJahffboVIdoF
         aqvjhJHpBEl0Fh5uTKMaaB716ra9inmW2wdykeurMDOYRtcbAbQGawHlQmHgnuOY7p4/
         gkD0yYw5z0MvBQVFOPOpLckwwg+aI71CguhFgYxvVA1fUUULHDTGfH1M8KhOy66DlGrs
         lDtjC/RWSPiPeCVq/vCW5HE8pkpAb8Non1pwzHDJP3h9cQl8IjXEuv6kqi/ggi6AwiPc
         20TwEQZU3zJEtBL2TS9qg9RaO4xpK5vxEKXutpS9dlMiSdYzdNdt6W0/ZFPD+sYEAn2i
         U1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302553; x=1773907353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jHSsySGrwWmc4KWJ1Y/Z7PzPGSIpyrTWsoltylkjnU=;
        b=OJmK5s3FsBHXAKGp2Q9xgTY6zL28QtI8sH03nvc0ProzincRV+mPkLtFYjLTbFOd0G
         kyHCoUQK5lgXNDpTHxKXf7CjXiW1lh9U6tlysDwjiYtj0kNdp5QwD1n+kjBA2YY05aa1
         RjJiKHHuXylI/PixcQj7neBEY6+BqrA5ypF9ZvxNadudtAGErsP+iTNG9/zZwYQKGTcb
         RIJQ1cmjc8+YMKGMWaQc4yKQoBJhgImisOVQwTP0oE1RIvTxEt0Eg1pOwld8XVmBbVtm
         rM/EPaqxfaIEM6HxEDLhcFJv8wRwbOooluV30kmGvodyf1kIIDfhkGWfSwjSBA3jOX+Z
         CWWA==
X-Gm-Message-State: AOJu0YyxmbpEkf/JgPggRqyBfjPFxmARcFHjRExFC6W7vK3nrl+mkGM8
	Lep3kzzpxy7ragN8FliBLcf7RkBtSrFJ04Z9gCrmO5w93cBunZSTJqYpVnDdIfYNQl0j+CxWbSH
	5taDB
X-Gm-Gg: ATEYQzzRAuEK2AZ+XeKpv8i1ToPJZ8Es5ey6AOOtLtCNFGgga6NI5ZPz6+HtQoubJbB
	ra/Lpxl9QTimhdRBWkwPuZshttbgyPOIRYJzpsvV9WPpIW4qxf8hlBsOhyWFPTkr2kNMacVjPUR
	ct3pq2/rLMjwLuU6vks7BniLMJyK7EgGvovuWDACrqsdaUd1J8FEb1O+4EeCU04mf9c6YScM+C4
	GgmmNCkG+Er0MuH4pvsJY4dnxnSVM48jZt6sD+pgDA+0o38KBWA3yGunAc6+3DwNdvukcOU74Wv
	/HhCk0dfq/5mGdTrDvXMrMdtdvTczdMUJ/yYi3/lLfsp3iUYOM+pc0E4eiFltaQKcxs/0iWzRS/
	BcapjDJLaElyqIX5GQEbPv6lB4BAcMJPrwv7rOHmSdZw8FTT6geloGla8EjLIT22ex9ogspadfX
	YCPZTf8JEMgQdxmsmg59c8FyyQoToh6Syu1wRG50Bwf1oGcyBikPSyZLuFPymo8aRf+QrCTEu/
X-Received: by 2002:ac2:4bc1:0:b0:5a1:3447:ac38 with SMTP id 2adb3069b0e04-5a156ba89a2mr1732920e87.2.1773302553069;
        Thu, 12 Mar 2026 01:02:33 -0700 (PDT)
Received: from nuoska.taservs.net (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15635786bsm789120e87.61.2026.03.12.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:02:32 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [yocto-autobuilder-helper][RFC][PATCH] config.json: enable qemu based testimage testing of genericarm64 core-image-sato
Date: Thu, 12 Mar 2026 10:02:00 +0200
Message-ID: <20260312080200.2132060-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 08:02:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3449

RFC: not sure how stable the tests are with tap networking and full
graphics stack on AB infra. Depends on genericarm64 testimage.bbclass
fixes from https://lists.yoctoproject.org/g/poky/message/13862

qemu is one of the devices supported by genericarm64 machine. For qemu,
u-boot is used as the UEFI firmware. All of the oeqa runtime tests run by
testimage.bbclass have been passing in my testing for a long time so
they should be stable and working on AB infrastructure as well. Testing
only core-image-sato to avoid adding too much load to test infra and
since it has good enough coverage for now.

Real target HW testing on AMD KV260 is run by us on weekly basis
and reports are posted to automated-testing list:

https://lists.yoctoproject.org/g/automated-testing/message/1547

These flash and boot the same core-image-sato image and run the same oeqa runtime
tests but via testexport.bbclass since test lab workers are not full
yocto build machines. Additionally I run the same tests on AMD zcu102,
Rockchip rockpi4b, Raspberry Pi 4, TI BeaglePlay, NXP i.MX8MP Verdin and
Renesas SMARC EVK boards.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 config.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 1a8284cdcb70..2a2d5b62f948 100644
--- a/config.json
+++ b/config.json
@@ -783,7 +783,14 @@
         },
         "genericarm64-alt" : {
             "MACHINE" : "genericarm64",
-            "TEMPLATE" : "altcfg-hw"
+            "TEMPLATE" : "altcfg-hw",
+            "step1" : {
+                "BBTARGETS" : "core-image-full-cmdline core-image-sato core-image-sato-sdk"
+            },
+            "step2" : {
+                "BBTARGETS" : "core-image-sato",
+                "SANITYTARGETS" : "core-image-sato:do_testimage"
+            }
         },
         "genericx86" : {
             "MACHINE" : "genericx86",
-- 
2.34.1


