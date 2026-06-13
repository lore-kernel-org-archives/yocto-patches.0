Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F413ACD8CA8
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 06:52:32 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86711.1781333552294676709
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Jun 2026 23:52:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dsSFBGKY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ac357c55so15159825e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Jun 2026 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781333550; x=1781938350; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIz3tAdD6ULqhny5HkqHXJxSLGa1utKz4oLpSQ72+Bk=;
        b=dsSFBGKYVCaUnZn07KC9ssmyPi6m7hvU6XMvfTtqbp7yzN7DAnRisawT+p4eN7cURX
         mVlJAqCX6cUw9R+JwocqB9aiAPHURLJBB+6sGWGRE/zu67tQBFIDGKPuDYWF95RFNB6A
         N2vhwtSlDvgsMTEDmNW5ZIjpnQQqI87D2dkOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333550; x=1781938350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIz3tAdD6ULqhny5HkqHXJxSLGa1utKz4oLpSQ72+Bk=;
        b=QYJjUA88XiLBqNISsaZBH5oJeklSlJLsLIfWj47cBx0Bb91b1c37wLIN5yFOlQjTXh
         N9zIsoTa97zyp903A0HQr83ATn69znBZLSvrdutdQl0zIw+og3kSuBNsasgNrkv0G5se
         D7p+hUbTcWcdE3XxOTYbyIWjCn88t0H1TZdH9UN1aOXdPFkfHuKw7fSNg0k2uimgwwwm
         OMKpA3q/iInuhCY5VlGXrVrfHnSBIrdiLjqrX0VrqfhVlunPwg8LGSWXnfXO3llLuI6r
         siUW8D+iC/68kDkJ8pdFACv90ARqiUDx2SRU0+bbt0X0oPyuTuHUosVJqFtTFW21od+D
         NFMw==
X-Gm-Message-State: AOJu0Ywlj/rPUPeCJjNTuvnv0Gmv63WSAUv7ZoK8G0+9bempoLYAberq
	Og+x6w9D7yMMRdG6Tk6/AJ4Cy92Oco9WDkdS03HZW4l+0L3NK+03IVryFmUg01N/HeLY4J6ZdCB
	3eYCS
X-Gm-Gg: Acq92OFg+E6DokuZg3HCDcv2rULXQ25e5EeEdUNu4coxVR85NTbS4C05txyZcJc74CW
	5Z63adrhF1lu4pfNgzQEiHTshJXg7f2HyXlgOYpO9upjkZwH5bEoVVOCEauNBlFIQEXKV11z/OO
	F/uxPScvGUKOrKdS4riJ1OXNDbijjwAPsRJk/zNnOEtilUJ82jiAzMWObvQ5ik1vwJiuacdK0+q
	1ZKX/0uXZiWPmGYNIIeiF/bMPVVbg6Q9gbKPY/Iv9cvIQuvUhh4CEktOqNP26vRR+fpFFhfbbNt
	9F5oQovafYjeBYHQpici/wh+uJh/JdyBp8GaDsusHkUJHhyG+o7W/vlhVT1AxzguOHkfGItycgj
	KQQRQlYKj7ByjuaKErn9g0OgVXZTMr5jmqVvawZilvkb4ra7Kw5VDfMCxCJdp/+Kr6hzrlYcZmB
	kkWnWbcqwcvnsewFo6B+CB4N2eDgG64qemYqyDRmIsBx7Iw0t6oXc7
X-Received: by 2002:a05:600c:820c:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490ec4d3407mr74582815e9.15.1781333550132;
        Fri, 12 Jun 2026 23:52:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4437:5798:e78b:2888])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220304180sm48744975e9.4.2026.06.12.23.52.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:52:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Restore auh state
Date: Sat, 13 Jun 2026 07:52:28 +0100
Message-ID: <20260613065228.2838524-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 06:52:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4217

We were saving the state file (accidentally!) but not restoring it. Also
save a date based backup for now which may aid debugging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index fe9d416..7e6b34f 100644
--- a/config.json
+++ b/config.json
@@ -1585,7 +1585,8 @@
                     "git -C ../layers/openembedded-core config user.name 'Auto Upgrade Helper'",
                     "git -C ../layers/openembedded-core switch -C tmp-auh-upgrades HEAD",
                     "rm -f ../layers/openembedded-core/.git/hooks/pre-commit",
-                    "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./upgrade-helper/upgrade-helper.conf"
+                    "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./upgrade-helper/upgrade-helper.conf",
+                    "cp ${WEBPUBLISH_DIR}/pub/auh/auh-state.json ./upgrade-helper"
                 ]
             },
             "step2" : {
@@ -1593,7 +1594,8 @@
                 "EXTRACMDS" : [
                     "../auto-upgrade-helper/upgrade-helper.py -e all --incremental",
                     "mkdir -p ${WEBPUBLISH_DIR}/pub/auh/",
-                    "cp -rf ./upgrade-helper/* ${WEBPUBLISH_DIR}/pub/auh/"
+                    "cp -rf ./upgrade-helper/* ${WEBPUBLISH_DIR}/pub/auh/",
+                    "cp ${WEBPUBLISH_DIR}/pub/auh/auh-state.json ${WEBPUBLISH_DIR}/pub/auh/auh-state.json.`date +%Y%M%d%H%M`"
                 ]
             }
         },

