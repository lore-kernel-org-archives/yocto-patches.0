Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E544FCD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 13:31:49 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20052.1780493505738095226
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 06:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PoqmUeMo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec449d0af2so471928466b.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780493504; x=1781098304; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujJNRdVkw/WYwC1Zg8/2AQfennALFaQbzgaMFMYGY4Y=;
        b=PoqmUeMod3194s7N0nKM/q9PYHc7xYPZ88MyEhVcJYEzCSe3Q6Em31zUjg8YAI0OTA
         4wgX1teX1NzGHFMC/2XDSpqEUCrogWfTqdw9QbLXR1OmjM1l0uBITqCXWnjww6Vwv+tk
         51Ls0itdPzEhjgXs+nKQhQjWIZhWARTfCML2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493504; x=1781098304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ujJNRdVkw/WYwC1Zg8/2AQfennALFaQbzgaMFMYGY4Y=;
        b=M7zqOae+WkxzWWq6Lv1ZgJAxgB4atHEzvIN0iKcyg8KAxhvY0qqi2H6BmqoPtiljZi
         TnO3otaSLcrSAPzNHquUPaTgZDOVVtA0JbfLpi0FqLNWydqra93lY1T6VAzNMfb53jYz
         oKAPRyNIJAgp5e+4EWf8npUSQRsiBWUyconxXKJ4/ofFTcTF20+T8fLc02MwApC5mvlq
         1L3rXnyuG1ZllkcOwK+y3OWto6u0/rDIomzAoE6QfIGHfLsPDaka0d7uDy6ZMsFifeZa
         t2SbG/x/imzvx4vVeprgEbayaDczDtBJaNRFyPvqHtkQgiU9Ta82qiXUKXiOnzarE/n+
         DnWw==
X-Gm-Message-State: AOJu0Yy89kQsaXNzMaw5wzfguCvzCsHQ2il8f5BvRLi38+/Wfh9sbRpA
	Fyfsj3GwTF6q8ArOyuRDGwRWkvQc8oysK4Af3bQ/NjJZtYo9u62qhbUqUy+KWzw5djU10/g1ybZ
	/PbAS
X-Gm-Gg: Acq92OEu8ZeA2XGL4P+B80uVlqMBJYgucQcvPHyRn5gwNWGEBgR02c/fRNdaDumTGo2
	r4NRAw6wamIvX1zSbiFpgAI9EP+zYSPF/xddqyxUKZdwsGZierW3rbJURtcHi7eSCNmDJaDVlY5
	q3WB6/ZaYVwv51bAwJ28gt8Sxbzls5XivNb8sJN6AGMV6Mr8HWyj8X3kt1ZsuIogQrNLnYwaXGK
	iftyKMhKJnDokL+UUpEtd9FnwVZprmJp+XzyO24LP8RjHq7+l0ov/i4Q+iLZmnI/xH8AJw7kxi9
	ScdBaL6ZlZXtjit5LK5VSwua4Hl51BMZJuxZWR2VOVOtr6brBYO75WkhCHPLZOXrwQ1f6SgjA91
	me8LdndXKHciM13yhjShKV7fvtT1kpBdB8QmQOfV2iqHAJ0EyLYWnzxHFgyfg2YqMg60a/W2zMx
	NiCy+OuXsIRC8t9TSeANvAiYETw1RP3BLbdYkz8CgbdCKOYWGTpFGrqt+QhFhOpQ==
X-Received: by 2002:a17:907:72c5:b0:bec:c237:4ec1 with SMTP id a640c23a62f3a-bf0acc0ded1mr174145566b.13.1780493503811;
        Wed, 03 Jun 2026 06:31:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm156048366b.52.2026.06.03.06.31.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:31:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 3/3] config.json: Remove unneeded SDKMACHINE settings
Date: Wed,  3 Jun 2026 14:31:39 +0100
Message-ID: <20260603133139.1113999-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603133139.1113999-1-richard.purdie@linuxfoundation.org>
References: <20260603133139.1113999-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 13:31:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4117

x86_64 is the default so we can remove the duplicate setting from a few
places.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.json b/config.json
index e650b1e..6df21d4 100644
--- a/config.json
+++ b/config.json
@@ -60,7 +60,6 @@
             ],
             "extratools" : "${EXTRATOOLS_URL}",
             "step1" : {
-                "SDKMACHINE" : "x86_64",
                 "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-minimal-dev core-image-full-cmdline core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext core-image-sato:do_populate_sdk_ext",
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
             },
@@ -195,7 +194,6 @@
             "MACHINE" : "unset",
             "DISTRO" : "unset",
             "step1" : {
-                "SDKMACHINE" : "x86_64",
                 "extravars" : [
                     "MACHINE = 'qemuarm64'",
                     "DISTRO = 'poky'"
@@ -204,7 +202,6 @@
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
             },
             "step2" : {
-                "SDKMACHINE" : "x86_64",
                 "extravars" : [
                     "MACHINE = 'qemux86-64'",
                     "DISTRO = 'poky'"
@@ -215,7 +212,6 @@
             },
             "step3" : {
                 "BUILDINFO" : false,
-                "SDKMACHINE" : "x86_64",
                 "PACKAGE_CLASSES" : "package_rpm",
                 "extravars" : [
                     "MACHINE = 'qemux86-64'",
@@ -288,7 +284,6 @@
         },
         "reproducible-meta-oe" : {
             "MACHINE" : "qemux86-64",
-            "SDKMACHINE" : "x86_64",
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../layers/openembedded-core/meta-selftest"

