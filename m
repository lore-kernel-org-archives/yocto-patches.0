Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD27CD8C89
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:48 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1780714307716786038
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j8eZ82wO;
 spf=pass (domain: konsulko.com, ip: 209.85.214.173, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c379e8ffso17834865ad.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714307; x=1781319107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmvatY3D5s7K4rI8c7d7kRG0/CBouTRj/yBcEY6d2+Y=;
        b=j8eZ82wOKmcPJkstn7hi2vlRkAHiWV82PYtH+UMcuAbR7e/Sj4c8/BWprSQQu8oDlt
         taALRpQBA+gErzVVAiq2H3Ftprazgx0/hndfWCQyNzo3J95xLtPBPo15fmQlh3DxksBl
         tZG+pGzsPnTv6JaJBInoza5CQjmWr1hVHrCBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714307; x=1781319107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmvatY3D5s7K4rI8c7d7kRG0/CBouTRj/yBcEY6d2+Y=;
        b=rugClygFCvFfOexs0ZwZ2v0BhzrHLfkC5hnQ62Rfu7WlsJY/qSg1AyMy0X4BpipPS1
         WuacHcoSqU/nzCmyOplWTPnRmBSZWjO0cLg3pf/rPFQ3xLSQ5mG5SGNqWs9bAgdFdtuM
         htAxYOeuwH1XjA/Pv5IUxLXtxwWW0gbxXkT96hlbyO1XtmuunZWqywHdBWgzqf1P9PTb
         RuGk65HQZ8liZXgePwMn3aV0ObNRKTG4V/lzgs1hWYQloVPp5SJUQ28yMiGbXr5ZwigA
         6+Uu6XRo2Ge5c8ZMfqrarybV6Sv0nqdEpK+ENf7n+G5U8pt2v6MGZZ41xEbVuQI6+wVC
         dJeg==
X-Gm-Message-State: AOJu0YyGxt7NmZEdelqpvxK8+We393nczAsfF9+zPNFoarA74e25+JZ6
	fkTnXXgzStevAD8fQD01XYACRbPz472S3Vy43c7/sS8lzdYMr+AgWxPh/wxCrV0Z1hvX/Vsawkx
	mdxbY
X-Gm-Gg: Acq92OH4AmithTz4aEmJRdrHfd2nTlSMwLvrFXoiBNmORRfUOm/F+S2ZNA1vfqHbHdR
	lBhpfCcZ+B+TJ3tkio1bqkkAJ6exDl9y8iU5P7CHn4RdcMRWl+Kfy9J5RiohDb51bcKAcb8pDlj
	BJzctapS8ukrSw3q+p2U0qxB1vM6cQoS/cIYqyhl4u5TBwNIiQL+g8orpFZoeybAt2hd373uBS8
	tqVKQYbrazXHEP6H6eMyzO7QVkv7SFdP+5IOvSbTZTIPjoyinPsUaJrQXoXlE8hC4vttraVH6kx
	EZSGOwUO2jJ2rBeNNc5lVKooP+RHSnrALqTpDjPF3KIE0ImynJveNuKGx/yzOMoiONHpik9d14K
	fJbCFPwy3SSDvzJ0rU6OMP1xcON2QHyIrXFyglCEeSAqp2Gd80gMiFe6il/wCdysF2uxmzYxz3/
	5u1PRIWrpDE+ZlM55WpTKbJ3se8lPu7wYy6L2ClHJi5q7Nl96DhUSzUJydnEeqhIj3Mmg2caYAV
	twJPHLEZsH0
X-Received: by 2002:a17:903:1813:b0:2c0:c262:b919 with SMTP id d9443c01a7336-2c1e78e4e97mr41368345ad.5.1780714307053;
        Fri, 05 Jun 2026 19:51:47 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2d7sm108113515ad.39.2026.06.05.19.51.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:46 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 5/6] config.json: add 'containers-library' build job
Date: Fri,  5 Jun 2026 19:51:19 -0700
Message-ID: <2a6d0e8432b255f5e4fcd2bbe3a219f4a69ab64f.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4160

From: Tim Orling <tim.orling@konsulko.com>

Add 'containers-library' build job that builds container images on top
of the vcontainer-tarball SDK:

  * original container images from the intial "container-cross-install"
    branch of  meta-virtualization
    - container-base
    - app-container-curl
  * additional images modelled after docker.io/library/*
    - app-container-python
    - app-container-mosquitto
    - app-container-valkey
    - app-container-nginx
  * Tag containers with versions based on the recipe to which they are
    mapped, e.g. python:3, python:3.14, python:3.14.5. Also tag with
    DISTRO_CODENAME and DISTRO_VERSION, e.g. wrynose and yocto-6.0.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/config.json b/config.json
index e1ea01a..18a2b6b 100644
--- a/config.json
+++ b/config.json
@@ -1889,6 +1889,62 @@
                     "${SCRIPTSDIR}/run-vcontainer-tests -s vpdmn -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
                 ]
             }
+        },
+        "containers-library": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-openembedded/meta-webserver",
+                "${BUILDDIR}/../meta-virtualization"
+            ],
+            "extravars" : [
+                "DISTRO_FEATURES:append = ' virtualization vcontainer'"
+            ],
+            "vcontainer" : "${VCONTAINER_TARBALL_URL}",
+            "CONTAINER_TAG_CMDS" : [
+                "_PV_MAJOR=$(echo $_PV | cut -d. -f1)",
+                "_PV_MAJOR_MINOR=$(echo $_PV | cut -d. -f1,2)",
+                "_EXTRA_TAGS=\"$_PV_MAJOR $_PV_MAJOR_MINOR\""
+            ],
+            "step1" : {
+                "shortname" : "Build 'base' container",
+                "BBTARGETS" : "container-base",
+                "CONTAINER_IMAGE_MAP" : {"container-base": "base"},
+                "CONTAINER_VERSION_RECIPE" : "base-files"
+            },
+            "step2" : {
+                "shortname" : "Build 'curl' container",
+                "BBTARGETS" : "app-container-curl",
+                "CONTAINER_IMAGE_MAP" : {"app-container-curl": "curl"},
+                "CONTAINER_VERSION_RECIPE" : "curl"
+            },
+            "step3" : {
+                "shortname" : "Build 'python' container",
+                "BBTARGETS" : "app-container-python",
+                "CONTAINER_IMAGE_MAP" : {"app-container-python": "python"},
+                "CONTAINER_VERSION_RECIPE" : "python3"
+            },
+            "step4" : {
+                "shortname" : "Build 'mosquitto' container",
+                "BBTARGETS" : "app-container-mosquitto",
+                "CONTAINER_IMAGE_MAP" : {"app-container-mosquitto": "mosquitto"},
+                "CONTAINER_VERSION_RECIPE" : "mosquitto"
+            },
+            "step5" : {
+                "shortname" : "Build 'valkey' container",
+                "BBTARGETS" : "app-container-valkey",
+                "CONTAINER_IMAGE_MAP" : {"app-container-valkey": "valkey"},
+                "CONTAINER_VERSION_RECIPE" : "valkey"
+            },
+            "step6" : {
+                "shortname" : "Build 'nginx' container",
+                "BBTARGETS" : "app-container-nginx",
+                "CONTAINER_IMAGE_MAP" : {"app-container-nginx": "nginx"},
+                "CONTAINER_VERSION_RECIPE" : "nginx"
+            }
         }
     },
     "repo-defaults" : {
-- 
2.43.0


