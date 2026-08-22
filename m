Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E90C5DF9A
	for <webhook@archiver.kernel.org>; Sat, 22 Aug 2026 21:14:05 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4313.1787433236903063378
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 22 Aug 2026 14:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rELSjos/;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2080563a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 22 Aug 2026 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787433236; x=1788038036; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ia4xrjjdcethegBODemXvZoH01cDyd/Q6xmNow13OXE=;
        b=rELSjos/s0YGEwpQHZX1GyOgFiftav+6sh+quyH20NqX+vc1IwV0Y3MK1GOF9I04KR
         cFG+uJC2Pa6XyR65jY4mfZbFJdMeeUpXkTp8eP4Oj/PPDXF0cNYxvobNx0Mq8cMAsBjy
         ws3ARqHUnBrTDXlSdULzCjMAp6z/1Ulo51z/Jbp8ECCWHTx7BRtOurL6ZAB2cQUJRZPT
         SYu+NudpMb2OQZ6wJw4xD/0fDY23k+syLCN3OUrRSclPAP2QAG/SNvRUI0dm0SqMTIen
         p9mbjUSeUAnygCWwe9lLJoMpeGYj4da5GOi5/zmo5CUI1N1umI9cBbd+QQf/zqc8+e8T
         nSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787433236; x=1788038036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ia4xrjjdcethegBODemXvZoH01cDyd/Q6xmNow13OXE=;
        b=aLAKRwGY7ZVxTlxSfsROAME634fhRUDxc1HnNwMGbWfnA/mVWjkRki2E3rkQF+a+aL
         A0Nc0DEgmIJGjl94T1f7Ohbxcosn1M10JZ8Uxf/heydFhO73Tz3kFcQG/2iw9gU5qyFI
         R7qEoMlStdPWHCnYTe2dFlqXVYm+zrp1FfPE357YuKA9ZCBHSYJvxe2gsqxbB+MRhxXj
         LMbFkdRCZsIbujEwVTMAfBRYGQQGkaMbKvVUJYaUHYBCIB+zTdHKbI/m1Y7XNSozC0oz
         MV9b+DMtbkxjifO4se/F5u/GNu7QglzB3aPse651FoiL4jJUzI3o1v7OddFw2Kqy16XX
         jn7w==
X-Gm-Message-State: AFuF++lF+AIsK6wMnCHX3QrGnq7fKC0e79VpBBaLQl/X78Lvb/QqBlDE
	dsNJJzaPLEn35YbMpt6cJ1cilZSWdtpUL0YolsiShJdmVi+wxFVp5rmvSqa7gw==
X-Gm-Gg: AR+sD128b8QN3CmBG2ei1MWnSaZXonixxFyiFNER1VmB6t9IqFaVFxwk36irGabHqX1
	6S+Tp7Tia9+mdAEvv3tRMltRLsrgmjKd4xyNyjqQ+YjKiWXu9kz128Kr/JG6j74GlNavrNxKhJp
	l1sos7VWaL/zL2euEjcwOH3oOWfrW3qGBC4VKxfgZTcb4Uc24WIHv92kS0ZP3VrO70kDh5kSraX
	jUy3f6G1rWcV319r3JJ9k7CNzxX/8itdbVGkYYiB/r1ZE9zhzyjv4MkiaWuM6x7YfdCnF6ly+qQ
	kyUifAX/lkNmn5pgNA9KO5I32A8VL97lqykZIrJcbStqIPRX/eQvC1W5RheFSEQ4gbVUmdj6TRR
	JOQaiyt8P9AxT1nJWztU4kEnjImOnOxkhIKrNRes6dVXFMTIb4Jaj9Y8MUpxHl7+zIQcdkThg+i
	ukVIBmte08cNCaK0pNP0Wb6PEe6q9Z05OtzHOzSkE1XJXd25JPkhuYUVYprIU44mhvH0Js7N4PR
	Gji1hTFTkT+yMIB+2/AcEMZEugDh56FmSxhlcJy54p78uTRhGTZ/Q8S4q0g
X-Received: by 2002:a17:90b:1809:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-395df3c2566mr12070148a91.14.1787433236174;
        Sat, 22 Aug 2026 14:13:56 -0700 (PDT)
Received: from localhost.localdomain (c-24-20-171-118.hsd1.or.comcast.net. [24.20.171.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4968618sm4301382a91.3.2026.08.22.14.13.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 14:13:55 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] requirements.txt: upgrades
Date: Sat, 22 Aug 2026 14:13:50 -0700
Message-ID: <20260822211350.9317-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 22 Aug 2026 21:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4683

Updates suggested by 'dependabot update pip'

NOTE: django-reversion-compare 0.20.0 requires Python >= 3.12
      which we do not have in Ubuntu 22.04 Jammy (Python 3.10)

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 54 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index b4b57b5..e0be38a 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,41 +1,41 @@
 -i https://pkgs.safetycli.com/repository/self-d8782/project/layerindex-web/pypi/simple/
-amqp==5.2.0
-asgiref==3.8.1
-beautifulsoup4==4.12.3
-billiard==4.2.0
-celery==5.4.0
-click==8.1.7
+amqp==5.3.1
+asgiref==3.12.1
+beautifulsoup4==4.15.0
+billiard==4.2.4
+celery==5.6.3
+click==8.4.2
 click-didyoumean==0.3.1
-click-plugins==1.1.1
+click-plugins==1.1.1.2
 click-repl==0.3.0
 confusable-homoglyphs==3.3.1
-diff-match-patch==20230430
-Django>=5.2.14,<5.3
-django-appconf==1.0.6
-django-axes==7.1.0
-django-cors-headers==4.4.0
+diff-match-patch==20241021
+Django>=5.2.17,<5.3
+django-appconf==1.2.0
+django-axes==8.3.1
+django-cors-headers==4.9.0
 django-ipware==7.0.1
 django-ranged-response==0.2.0
 django-registration==5.2.1
-django-reversion==5.1.0
+django-reversion==6.3.0
 django-reversion-compare==0.17.0
-django-simple-captcha==0.6.3
-djangorestframework==3.16.1
-gitdb==4.0.11
-GitPython==3.1.58
-kombu==5.4.0
-mysqlclient==2.2.4
+django-simple-captcha==0.7.0
+djangorestframework==3.18.0
+gitdb==4.0.12
+GitPython==3.1.59
+kombu==5.6.2
+mysqlclient==2.2.8
 packaging_legacy==23.0.post0
 Pillow==12.3.0
-prompt-toolkit==3.0.47
+prompt-toolkit==3.0.53
 python-dateutil==2.9.0.post0
-pytz==2024.1
-six==1.16.0
-smmap==5.0.1
-soupsieve==2.8.4
+pytz==2026.3.post1
+six==1.17.0
+smmap==5.0.3
+soupsieve==2.9.2
 sqlparse==0.6.0
-typing_extensions==4.12.2
-tzdata==2024.1
+typing_extensions==4.16.0
+tzdata==2026.3
 vine==5.1.0
-wcwidth==0.2.13
+wcwidth==0.8.2
 PyYAML==6.0.3
-- 
2.55.0


