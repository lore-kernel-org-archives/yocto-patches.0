Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EADCD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:04 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4660.1778205661344432292
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:01:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M1t75Uzk;
 spf=pass (domain: konsulko.com, ip: 209.85.214.174, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b788a98557so11127175ad.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205660; x=1778810460; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9NJtCAEJvuu08gLcRGkO7F1iIExljVavKS4xNeQ7io=;
        b=M1t75UzkWbrYQAGS+owFt0V4s+CZJRgi8+ocMhFlaVNFGIyPPPbuHgQKpJeZS33LY8
         C6fh48sYQZkje5ZDgnkeTVOFYYbmjYXnCZAfvk89Nz2qs3v5QmsZqmveXvHtQwolVa78
         O/EDS4KKwMTMmmiaeRtRBkjUVAHR+7UwULD18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205660; x=1778810460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H9NJtCAEJvuu08gLcRGkO7F1iIExljVavKS4xNeQ7io=;
        b=h68I3vvmcs0/nvB8Yl3xPUvPz0g5x9EUMvWFXjtooIyvj8ZQ1knm0UfQUZwElDvuHg
         AzcYtCGw8DGRlJVMMsRjtS8CS4BxibrWvJOa+EC0NfIQjna457Yg5QKH2V4LHibzyrJS
         qnvCN/PUTFvF+zGuo8x5tL5b4y3dTJn3MrGb8jZkH7k8xK63OgskddDwHbbYYGiPee7y
         MLdL5aLzrfUcgEfbLf6WWJHfJMnoCnqh7hzpWAkXelyYpmk7aLguTNA5SBLo6YFBwDhG
         4NnTchbsQyHBce4oz4uYuGJfypZ85riWsYH9iD4b9set1KxASKet2Zl/3P5IwcnIYSnL
         coRA==
X-Gm-Message-State: AOJu0Yy7ilv8Ximl4OJJA3tDI8TudkPAr/eW96dphvorP1m7fuPYPKv5
	9acqEnIRKlsu5Mspn5GpItRrB9UhS40FoWRtlOcRJDyvkrzzIXK2zItkKeSTwCtKBYm9YFuJdcd
	OBPNr
X-Gm-Gg: Acq92OFAdGgHf4YJyIkwHWdKXMYgi98OUCOATuQ3vXMx7YwSma6r7gbs3biaBCpN5d9
	dPWNV2phSG0tXF+WpXTaL9Ee/t8VtpaKsfBM1CavC4GLMAwhUIonDGpgXiFtK45Q7zX7Bvh8enu
	uoEhbHde8Uh2ChdgbaEsm85Ut0NyCE6Bcr1i8GrF7iVOy/An5zMcjfWqfjXVjjzidp6txeFA1n1
	Q2IbzVktuen4h8H/kElfWZ4+RDlK8p7d4e6eYjZr7tMNSjQj+REhVNLExqk86VAwbawbwfMThze
	E622f6T0t8iObcxlJ6xpzVh949k9l22KxYDg+rc/GGt5BvsSN2CkAjgnjyVwnRy4IpMPsIHx1SD
	XRZsRk0vRZI9iehjOR0DyUeNV9i2F+V6RQoflGys112ndfCeszpWaZs6GQFek3ENncejX9DVoPp
	M216ST+L9yS88f+DoQ0rMDjaylQA6TUNxKjVy+BNbSozUsCUd+GfbU8nDgW+PcrIdnoB8f2BYy5
	A==
X-Received: by 2002:a17:902:c946:b0:2ba:7610:3f21 with SMTP id d9443c01a7336-2baf0cf312bmr7313395ad.5.1778205660230;
        Thu, 07 May 2026 19:01:00 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm2141945ad.15.2026.05.07.19.00.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:59 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 07/11] config.json: add 'containers-' build jobs
Date: Thu,  7 May 2026 19:00:30 -0700
Message-ID: <1c444ecb2272a384e77a786f7ca32767f791ce34.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3946

From: Tim Orling <tim.orling@konsulko.com>

Add 'containers-' build jobs that build container images on top
of the vcontainer-tarball SDK:

  * containers-meta-virt: the original app-container-* images that
    ship in meta-virtualization itself (e.g. app-container-curl).
  * containers-library: a layer for additional images modelled
    after docker.io/library/*, sourced from meta-yocto-containers-demo

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/config.json b/config.json
index 9e6898d..86c1ffb 100644
--- a/config.json
+++ b/config.json
@@ -1895,6 +1895,49 @@
                     "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
                 ]
             }
+        },
+        "containers-meta-virt": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-virtualization"
+            ],
+            "step1" : {
+                "shortname" : "Build 'base' container",
+                "BBTARGETS" : "container-base",
+                "extravars" : [
+                    "DISTRO_FEATURES:append = ' virtualization vcontainer'"
+                ]
+            },
+            "step2" : {
+                "shortname" : "Build 'curl' container",
+                "BBTARGETS" : "app-container-curl",
+                "extravars" : [
+                    "DISTRO_FEATURES:append = ' virtualization vcontainer'"
+                ]
+            }
+        },
+        "containers-library": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization", "meta-yocto-containers-demo"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-openembedded/meta-webserver",
+                "${BUILDDIR}/../meta-virtualization",
+                "${BUILDDIR}/../meta-yocto-containers-demo"
+            ],
+            "extravars" : [
+                "DISTRO_FEATURES:append = ' virtualization vcontainer'"
+            ],
+            "step1" : {
+                "shortname" : "Build 'python' container",
+                "BBTARGETS" : "app-container-python"
+            }
         }
     },
     "repo-defaults" : {
@@ -2018,6 +2061,12 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
+        "meta-yocto-containers-demo" : {
+            "url" : "https://github.com/moto-timo/meta-yocto-containers-demo.git",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
+        },
         "auto-upgrade-helper" : {
             "url" : "git://git.yoctoproject.org/auto-upgrade-helper",
             "branch" : "master",
-- 
2.43.0


