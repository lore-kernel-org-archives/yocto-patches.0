Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF5E67497
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:49:00 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51714.1766278133423886194
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 16:48:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SWYIJkfC;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2d6df99c5so386144985a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Dec 2025 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766278132; x=1766882932; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5MVt/C+mWPHjJddw6hNH1CaaQX2UooK9x4405NruFo=;
        b=SWYIJkfCRPXHejIhG/GRSL02WWT0HqYj8gvDXxSWu/9nfVyqCQNLq/JR8CRpO/DfAZ
         3LYl/UdIvdA59uvn+fAJGNuWYccMTTUbEK8qrvehJ6hbOvdzL+89TO+JUApVgu2aSh1m
         DEDdoGEhV2b9fTjMq6WXcfTQS+OWae1iee1TyeoSM43SWHSOI5T27oxGekv31s02NBl2
         eStt1zW6uAUCVCWV3mTk726MwBEzzbyzlhyhIZvYPwD16nIX9a6xDuTy7HYt3gWnnZBf
         o49sitxIFwX4anym2ewK4H5M3kN4mWSE7BeayGs6NXJu+bgqWxDeYUqzx3Su/os6Qwqp
         EdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278132; x=1766882932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W5MVt/C+mWPHjJddw6hNH1CaaQX2UooK9x4405NruFo=;
        b=FXfEs0wlfhmgPdVJptIBhqXUcAfgXaOoWnYUvRq5ZekqTAqEKAF1pkuNC8BkEElF4X
         SDqyNEHez917usG9CkLrBnZ0NK9t9OQvBpGf9J+i6f+Syrdgz7Sgyq21rCw82RJYamgv
         zVfzCwSPMNqw0KAKwDshzGHw6tOsDBkh/SjufI5acl2gzXTIGUyTkuGlCs7KkPOGPklk
         qqzppxUhkzerOfBN5PwVJ/BeRV8kOlbntrlGjl7r89ufHQ9KUMMXODZTKfZplXD9ZQrg
         Y+k1cMNesVH/PE1GeJNAYbI1N+OHtDQ17nb/YZ96YzLdpEPEWhLGrGgXA+LOQUqdEIGo
         lt5A==
X-Gm-Message-State: AOJu0YwLLcpTLnaQ9w2JNYF6EjKiYw4mCgRKrTjixWezoL8XCLm8iINf
	74dgsXqfP/1vYf1//imVvo1ZjyhLzhh4yFyfY0VRN3dL0B2xx+1o8MpblVhP6A==
X-Gm-Gg: AY/fxX7ZoyGRX0apmilSVkYpvva5+/ZKEPQgVwf+Reymc8WJnueW1v9rQbkAjq7P9/5
	qCNWIEAuyfFay7Zsn5VmWdMDlnwPdg42YRqgTvD4wNlu/En02f2/YYXqCLTsdP2YgQqV7kyqAl/
	3299//0MtKY6f/4j0+Ay1Wf7cuCXlLTX1RGx7ganIPSSNYQ/BJbWKMIa/PeUp7wDT3dcTTU1cWO
	yb/n15bb7BbWuHOO2GPOFYm4kAXMkv3B251AzIqcVzb5et0e08mrCSjD7wVqiYFPzVlsDti4o73
	cAifWTEIqBwwIU6tJqEEc3foDf+t1ytAzinLXV8IqaS4rAAplEg+laoV//FuXm09k0mpqNqJBcL
	whKhks7XbeaJFp3ST3WC9MPUbOt0ur1mhE1/mZXCrLlWYOs376cy8tRKU3DCFfMItzEw13P04wk
	gkoP+MQNP5UKpCjP100XVzdHlnFXPcTBtgSnrYrm8R0H5Oh6Cv
X-Google-Smtp-Source: AGHT+IFRkms4DOwIfSQyOcfPq2GKjUaxv7ghojqsVRkszca2hb0E6eh4Dhm+VjFakKsYisMc9pD+Xg==
X-Received: by 2002:a05:620a:1706:b0:8be:9218:4c62 with SMTP id af79cd13be357-8bee670c35dmr1668094285a.4.1766278131720;
        Sat, 20 Dec 2025 16:48:51 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm511867385a.41.2025.12.20.16.48.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:48:50 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 5/5] fix u-boot for tf-a firmware
Date: Sat, 20 Dec 2025 19:48:43 -0500
Message-ID: <20251221004843.31946-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251221004843.31946-1-twoerner@gmail.com>
References: <20251221004843.31946-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 00:49:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2841

A change was made in the location and name of the bl31 artifact for
device firmware built with trusted-firmware-a. Update the build to match
so these devices continue to build successfully.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- none
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


