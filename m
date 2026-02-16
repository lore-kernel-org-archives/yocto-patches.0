Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94691EF48C9
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 08:50:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15930.1771231831881917351
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Feb 2026 00:50:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KQJrj/yt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362507f396so2811805f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Feb 2026 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771231830; x=1771836630; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ThZOD66oZun8/un+PGYvvXMEcbUOCT2xWHXHz3EGMk=;
        b=KQJrj/ytftmah3W3rUQgbQKuovBm8rcXVVbfgb66Q1NFev4puxKmywXC9qgk5LTrAM
         YfCcTH3WAWjRc4s+qV1OsCfzGR2Auf4d9bADfJlHXXiNylKDmmkuCWHu1MHQS7HnxdXv
         84HXDN/CeSa4Mi2/N4I7gpX6xi0MpDhb6QBXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771231830; x=1771836630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ThZOD66oZun8/un+PGYvvXMEcbUOCT2xWHXHz3EGMk=;
        b=e2ffFfgANaUS4spEOOc/uSZ2JWt1cyTeYS1pTOYr15s7O8oPua2RUjpJAu2JvWgsHY
         q4IlZGfriDXlskBMvFCLlAfLu3P8fpXX+Gx1PpXfCo5F95NyOidTIOG+USw09zaJemZ+
         tbEdTxw8OhsGWY2uEKW7ZY09UW0a+A2yYs0y1aoNbKXqNFXcsyZQB4z2AiixrKJRj3Wb
         gLqiP741l2jLAQiS1IAaTvSvJYF6NCpuuO+P4E+W3MulShtZTyPbQ//ezSiUZ/Di8Xm3
         WcLYWfOcxGkv+QjdIPDcDB7mnFcJZhd5gfAvSUjnB6HxD5V2p2Sbhxs7mNNYhmJDbsL7
         V3hg==
X-Gm-Message-State: AOJu0YwPHacltqzTBNxPQICLF2InYUgkzI1K96VEtLycRxUzAIpRceKZ
	43Lf4smYtWqf34XZCtiD0AjcphczVVDpBLDgz0YRHLDjJ70PQoLqK9k0AZX/zFjFYRt6hjvkUj7
	phI4LJ7I=
X-Gm-Gg: AZuq6aJWDHH4EGUwdYBXpNROhGDrGcUjx2N4ajFOxKo68zotJgY+F5+y1cHVmHKjsKb
	FC+0ElmubYETXSyTe2Z6LSiIqAHeDAdMED7TRcgWkRoqUjI6t9wBahiB0y9AtTs+yXLFy939l1a
	xEasLCLTdmhkKixaBkEa3dUYkSWNbi6iEAvIADANH2//wyCfM/LmFriqq4sSdit2QVu9WyudMCy
	gtRRG3WSb0ld1IJOmQsWvVc7U2wVz+eyNzdqhORJmzDSMmSf9FVpyeAwY1R8lnOjCSD9PcFh8JY
	x2MNQOn2ephgq+FO5lOEf3XtZRs3dRHNlOu2CPu1+ne5tb95EG5lpKCFtRPqZ6Ko5oxUjwKG2QI
	P1lZm15JkiqOrnMq/piLvsvExCgrXCxQhuYF8o8D9qLXP3IKIgUc7op6UuxUgOmajJbQmnsWst5
	7DLF9boTPghMTTodMbWTRKrJsDPxiysm1gEYWE0Wu7IMY8bnj5Pb0=
X-Received: by 2002:a05:6000:2405:b0:436:da9:4371 with SMTP id ffacd0b85a97d-437978c1acemr19950748f8f.5.1771231829621;
        Mon, 16 Feb 2026 00:50:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c30e:78c8:ded9:8375])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm26857105f8f.13.2026.02.16.00.50.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:50:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop sysvinit compatibility with systemd tests
Date: Mon, 16 Feb 2026 08:50:25 +0000
Message-ID: <20260216085026.2129388-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Feb 2026 08:50:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3243

systemd is dropping support for sysvinit compatibility so these tests will
no longer be supported, remove them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/config.json b/config.json
index 407d245..dff1d93 100644
--- a/config.json
+++ b/config.json
@@ -1558,26 +1558,6 @@
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-skeleton"]
             },
             "step4" : {
-                "shortname" : "Systemd with sysvinit compat",
-                "BBTARGETS" : "core-image-sato",
-                "SANITYTARGETS" : "core-image-sato:do_testimage",
-                "extravars" : [
-                    "INIT_MANAGER = 'systemd'",
-                    "DISTRO_FEATURES_BACKFILL_CONSIDERED:remove = 'sysvinit'",
-                    "TEST_SUITES:append = ' systemd'"
-                ]
-            },
-            "step5" : {
-                "shortname" : "Sysvinit with systemd",
-                "BBTARGETS" : "core-image-sato",
-                "SANITYTARGETS" : "core-image-sato:do_testimage",
-                "extravars" : [
-                    "DISTRO_FEATURES:append = ' systemd usrmerge'",
-                    "ROOT_HOME = '/root'",
-                    "VIRTUAL-RUNTIME_init_manager = 'sysvinit'"
-                ]
-            },
-            "step6" : {
                 "shortname" : "Systemd",
                 "BBTARGETS" : "core-image-sato",
                 "SANITYTARGETS" : "core-image-sato:do_testimage",
@@ -1586,7 +1566,7 @@
                     "INIT_MANAGER = 'systemd'"
                 ]
             },
-            "step7" : {
+            "step5" : {
                 "shortname" : "Mesa gallium-llvm",
                 "BBTARGETS" : "core-image-sato",
                 "SANITYTARGETS" : "core-image-sato:do_testimage",
@@ -1594,7 +1574,7 @@
                     "PACKAGECONFIG:append:x86-64:pn-mesa = ' gallium-llvm gallium amd'"
                 ]
             },
-            "step8" : {
+            "step6" : {
                 "shortname" : "preempt-rt",
                 "BBTARGETS" : "core-image-full-cmdline",
                 "SANITYTARGETS" : "core-image-full-cmdline:do_testimage",

