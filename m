Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D46CCD6E57
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:49 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12812.1780355925338435754
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WKvx22JF;
 spf=pass (domain: konsulko.com, ip: 209.85.216.43, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36c68964315so1385867a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355925; x=1780960725; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyRTlKvOn47aHDOgL6NxLR76/UbRCfIJZZmSnkj19xo=;
        b=WKvx22JF+sXjt1BDxV1uln2WHOwWDCTXO5rORri1G8/FXoRJPqQz+0s/L9RJmh/Q1p
         OxbbTHB102i/+pFN0H6g2n8aD3+QBGk7hPCs2ZUq9RMlbbBHWeTkNowex2f23cFmsi+9
         o7jFyg1WFQYTvkS18X936E5Fe9de7XfVnxm9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355925; x=1780960725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyRTlKvOn47aHDOgL6NxLR76/UbRCfIJZZmSnkj19xo=;
        b=aJ5BONKck7WaLlbiMxnTRyhsRDbYkyoRcvKu2gK+bas8AeRIPgCUgG7z9rYGd2/7bs
         eTYrPvzRMDO+Zu+xQ/8ZG7oHJXyuX4dO9eJmKSQXzR3Flc/Co4+S6pw51pzwODxw+VNY
         YiYfIiV+gjRJQaC41qKGqcNgyRGB29KEtLrEWhVNGUmH4ac6LgxiaT66M9+m4yTghRz6
         1WUdPFyeP3yZ1kAZn2c/U1/hcrjYpxTXSitxnH94h1xd1fZ7DUzXV7qT9JJH7ErSdsOz
         I8Twn8IkmhQtj8K6HRNw1ajnlMZ9aIIoCCYvs3fLGvpIM8xyO7tXAUflg3xyxfz0M2HM
         w8gw==
X-Gm-Message-State: AOJu0YzywKxmcDcF/ZZuX3uoCWLd6eG4nX14g2lkWK2ras016Lj1nMHZ
	0rcwdAx1UsYzQqd8Qql2j6f+9hSk3ftgUL4LiD29KK9Ic8HNa+6IXhvA1025fsD5dqnu+LTiIXb
	ajEEJ
X-Gm-Gg: Acq92OFXtJaOiEhbz4hY8MDIufZl/190gmDnNHiC2Sk0FVLd2voVBzBlxiPqB1YCn4y
	bBgRNu/6Z4mNJKxYIWHirfcmR/TR7MDMk1MBdr1z5YImR3rs9kAYDFB+JQE4o6GXWWZ9JPY+ECj
	qnGW2W38gpXpkCSKa5DAK9KjsabF1d3SnJa5fXJKyDkPKcnXhMuPJn4sLJZmBdRr+UNBeb1WF2s
	JC1ok1lBiUMC3Uh7C/wrdrWk9/TkNWSKtJWhPjgoBS2mKlaG/yvitreECOUU+ErPPoQJ7PZLmY0
	ceufVCEfGsNcp6GAwI0pbqKkCTvuIC4m01HHNKQ3l+lsiT3W3zwjtuqwxSnEs7hU9B53wo4wPki
	Kwc/BMZTIzWuNLEdeP3CCzUHy4RDuXUfHr1MBbMRf6LSCRdlQinW9MJd3+wVyuII5fVV+QqzhQo
	dOxwREvnd/kM6iNq9a1wDSEE5PM4AG3VBTZvqB42ZvGTv/J67xKn73wCoIAR90Sa1HftVJDQazA
	Q==
X-Received: by 2002:a17:903:2bce:b0:2bf:128d:f7ff with SMTP id d9443c01a7336-2bf367d2311mr143953035ad.16.1780355924718;
        Mon, 01 Jun 2026 16:18:44 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd84fsm117901465ad.23.2026.06.01.16.18.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:44 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 10/10] config.json: add 'containers-library' build job
Date: Mon,  1 Jun 2026 16:18:09 -0700
Message-ID: <aff1838ffcfb3e4c2aa1fe455dc0f74f87effdf6.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4107

From: Tim Orling <tim.orling@konsulko.com>

Add 'containers-library' build job that build container images on top
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
    mapped, e.g. python:3, python:3.14, python:3.14.5.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/config.json b/config.json
index 9f85a7d..dae55d6 100644
--- a/config.json
+++ b/config.json
@@ -1929,6 +1929,61 @@
                     "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vpdmn ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
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


