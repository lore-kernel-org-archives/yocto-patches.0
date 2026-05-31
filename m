Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBD0CD6E52
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 17:19:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11095.1780247938743578251
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 May 2026 10:18:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hU3EcFyg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso84084745e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 31 May 2026 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780247937; x=1780852737; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vFMmJucMzqD+AbIhVKqWB83Ug+MD+EKA+C2qpwNbYc=;
        b=hU3EcFygWrjKCA5ME5yyyzwCb8+SzuxXiot51EEk6QpnQVmG98lmtz+FxxIbjdmzku
         ogv0kUt0glxr4bGmwr3hLt+KHN7WZfOBXkmONBE807zp3coVZ95Hxg16S95DHpdeZYX6
         lajMuBqDajd6jmbsOY3S6V8ypFbn6g2JzXBFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247937; x=1780852737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vFMmJucMzqD+AbIhVKqWB83Ug+MD+EKA+C2qpwNbYc=;
        b=dWvQwOOPQw+TpUssP4UTNBTnvyQS9L8BQckEKMwdch4XpHmZ8kvn8uvq7V6unWpVq2
         W82GXqjjbjwe2l0bszt4oBUC33yDJ7iDkRWM+g7bRqTOI5sQ2Fj0EYGaY+dYtAQw3wga
         jc0kxBAfAo7CkPuMSel8QpwjH9DJNatEw45Gkkn/vxxiD/wg/+ThfKYYU76xcidKJgGa
         Bu64YZ4SwgENnHHhkKXb9L0B/12FPjqpXm/0/oxWlCAo0z6ashmaTtPxByB50oyyDbNd
         oVlSkuO0mOGwZtEcou/86VG+0SE7AT9yxcrDFu7jHVc/Utkgfsvor4nlB9/JEfaAAu9t
         /u4A==
X-Gm-Message-State: AOJu0YxAGe9JlpRTijem+wXHeZC3eniAN3lKpNjsaCt0XOWMlXG4dwZu
	pm+QK6mguwmydV/drUgAbvQTbHHJbHrt7HxpShq38Y4zXj5zw4ZhwFUz6SXvVImjIVdUgCKfqgl
	e+Tyh
X-Gm-Gg: Acq92OE26+30G59HqF42JUXh7GldEoW5jYULi+IpsBetVmS7jIPwJM8Xq126xof7b4h
	zuRn+a5dF9L8RPfIc33Y4ucuSNgYg2Te9lK4Q8NTh09D5uc1v9hwkcPA5U1SHo/+j2mO+r+uhWm
	BIH2RPJsCdW3Xn1ufdmTpnfHb4LcFeoW5+0kOKCvH3bYwsipSCOqeHQWazLbpOWNGt2CFDo+8+/
	yASF6KnY6gmJi/zIlgYrYmbGHq1rF5L3O5kSu/S2x7PC4LVHqyoq9pz5G2PMBTwOccCYutSiSDu
	WIIu6V9rs1st2LmHIKzkhhYguzXK5+cKORtv0kdRSp2zhrzFeY9MZhmMsdRpN7+ErwAHtTnx1ui
	pgKOyWf3wJiENd/lGWVxtpGNkC+PzF/IGV+E4R3oyDWftn5K2/xN/9KPxVJP5vc/POASt4xG2vU
	f2O4j82e9gkxmtaU9sHsqyIB7Us2bWKHTPSG1b//1OOEGPCgo6uYrl7EouY55mo3E=
X-Received: by 2002:a05:600d:8654:20b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-490a292111bmr107572815e9.14.1780247936698;
        Sun, 31 May 2026 10:18:56 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3612sm193977195e9.12.2026.05.31.10.18.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:18:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop qemuarm testing from meta-virtualization
Date: Sun, 31 May 2026 18:18:55 +0100
Message-ID: <20260531171855.2299550-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 May 2026 17:19:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4089

qemu upstream has dropped support for running on 32 bit hosts (but
can still run 32 bit targets). This means qemuarm is no longer supported
by xen or by meta-virtualization, so remove it from testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.json b/config.json
index f0e220e..b27fee9 100644
--- a/config.json
+++ b/config.json
@@ -1491,11 +1491,6 @@
                 "shortname": "Xen for qemuarm64",
                 "MACHINE": "qemuarm64",
                 "BBTARGETS" : "xen-image-minimal"
-            },
-            "step3" : {
-                "shortname": "Xen for qemuarm",
-                "MACHINE": "qemuarm",
-                "BBTARGETS" : "xen-image-minimal"
             }
         },
         "qa-extras" : {

