Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22761C53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 17:11:15 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16546.1785345065920986263
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 10:11:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NI1TY668;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1109310f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785345064; x=1785949864; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5DljYw9jAcBZVu7j0gLVQJww9iVRL+hfDIFWFrtIl8=;
        b=NI1TY668ZvRvmAKCEI/tEzAhR+AKmnz0SOFbWBEVA7vpwl7G4zd30xIVFkllO9zvWh
         67LsgrIBQuHqSgR2DfKZMBAcyUhVsO2xgaoG388WLp2VyR2pZAli/9lE98OI9URbYrel
         VwzYksyfkFekw63B+5v9CDxl07rBKGOg1+yPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345064; x=1785949864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w5DljYw9jAcBZVu7j0gLVQJww9iVRL+hfDIFWFrtIl8=;
        b=HNXWEUQgSJoV6xNDXT/j3riUJCE7hjLHd7dbkyTMmP5mveCLMK9W9qH5LbW5RpEJb5
         QIXEMcsvvmbqlDqLl1HZfUp/inW+Dj3/yzlz6bIrmJRxoaPDXGtqvErx2bpMzj/Q8rkE
         WL1GMYk0VOZDTcBXf8ygBzI4oboHHMdBsHFa8s4wJO8I2IPcpqAkN3kXPz8YjK4RuLw/
         LFbcq8AW8PhzLfcL2mlz1W3JT+2q4+olJU/HGroFO/r7CmwkQqsK1y9VF7YF/zn5XQ2d
         lWJrnL/Bpgo5o02h1Yfu1zjAfzEIKbJ/WBRBG25mPz1QzSDk9gNuOXXpArud6lKEGQYd
         zRYA==
X-Gm-Message-State: AOJu0YzTjkV0BH2pafOL2/nxyLB7Be9nh19a1McOYuXF/LISik7GLh5H
	W8xNdfjHrvZMs2jVWr7GNRBUHlE1EFc3HHfQpaWQ2jyeIhMckmTW2i3Tk04SzXoqrX2smUipvie
	d2H3Lgvg=
X-Gm-Gg: AR+sD137s+lZwYNFJWoW+5M61TdDYuH8mBk9dhrHRb9ydUDrSb+yiB1rcXbKTd5o86x
	vIUo0fakB1m2D0PlCC9+dUYVI1p0eqrNZQyko+Z8uhxTgHF5K4yXl2vC4fcjQuA7L7+T9EIxnr6
	TR8Qn1L0UrwPduwTIq/8SgRZ5hAakdOy2KAObx5DbRWfnD+b/TeflwRAZbYy7oj6Kpmo+EBUvGO
	jp5EKQlO5NQkDkmk4V6bGuSZ6Xa6mGXhljfaG3s0kXzkBlvrc1P35eHvb8YlhXE+4q2B5CDI2YW
	Vk4ZQN0ySZm0yaqDo8jyyfOV38wU09CJvbqrrxeVYsbsUM+zvTYB6VNoqOXuqZnxBq34NJrElJ6
	UmJeMjwCntu6mBU0ZsTu7BBZtzTNU0oM5wqCBb1UokCMihIP5Ow4nf8hint/04x79Oo0QuOeDse
	/5//TxlnccmRAm72dSK0yxyAy4lLzdLl2Tj55dseE1mqZE+AbUuiymnm3Ldw5pIJ3a7F1rTtMFx
	bXw7PsJvsKlpBbXgg==
X-Received: by 2002:a05:600c:3547:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-496c6556147mr91922795e9.14.1785345063766;
        Wed, 29 Jul 2026 10:11:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-497fecfccc7sm63979985e9.12.2026.07.29.10.11.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:11:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Add improved reproducibility targets
Date: Wed, 29 Jul 2026 18:11:02 +0100
Message-ID: <20260729171102.3034771-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 17:11:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4570

We should have a target to test reproducibility:
* of arm on arm
* of x86 on arm
* of arm on x86

Add builders for each of these configurations and drop the obsolete
distro based ones (which were already removed from the controller).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/config.json b/config.json
index 6d8d576..87059cd 100644
--- a/config.json
+++ b/config.json
@@ -282,7 +282,6 @@
             }
         },
         "reproducible" : {
-            "MACHINE" : "qemux86-64",
             "step1" : {
                 "shortname" : "Reproducible Selftest",
                 "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ oe-selftest -r reproducible"],
@@ -1228,25 +1227,23 @@
             }
         },
         "reproducible" : {
+            "MACHINE" : "qemux86-64",
             "TEMPLATE" : "reproducible"
         },
-        "reproducible-meta-oe" : {
-            "TEMPLATE" : "reproducible-meta-oe"
-        },
-        "reproducible-ubuntu" : {
-            "TEMPLATE" : "reproducible"
-        },
-        "reproducible-debian" : {
+        "reproducible-arm" : {
+            "MACHINE" : "qemuarm64",
             "TEMPLATE" : "reproducible"
         },
-        "reproducible-fedora" : {
+        "reproducible-cross" : {
+            "MACHINE" : "qemuarm64",
             "TEMPLATE" : "reproducible"
         },
-        "reproducible-opensuse" : {
+        "reproducible-arm-cross" : {
+            "MACHINE" : "qemux86-64",
             "TEMPLATE" : "reproducible"
         },
-        "reproducible-centos" : {
-            "TEMPLATE" : "reproducible"
+        "reproducible-meta-oe" : {
+            "TEMPLATE" : "reproducible-meta-oe"
         },
         "check-layer" : {
             "NEEDREPOS" : ["bitbake", "meta-mingw"],

