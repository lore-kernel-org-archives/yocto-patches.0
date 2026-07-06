Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9705C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:04 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162435.1783375615856913724
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TbYEFmuw;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847e6f03df8so4311650b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375615; x=1783980415; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=apFaqJcux5yubEOSjwEytbZacgvToIJohWLkaO52AJ4=;
        b=TbYEFmuwt/goTjn2L94BWcOTWWwGjoJc8z0NPZDgTnHJimfFfYPTZQD7dWEJptTb2l
         dYjMtQrFxW2ZNzRHtxh34WD0FOBxO+0u1ZzkyPnjg1LVLiqBNQ9fwxFkV+OYRiqN029f
         TqzTR1Ig4WE/N/owZFo2MdCKf0VE4eV7AFA/GxvQBwCehDgnS0lB1wPt2N0EI7NOXkUo
         yBS+CSMWh8/lSIT+l/YlJBmVPMKbLHVaRUgtzLiWxCq8I5/M4saK806Qe0IXSfGfUjIU
         40qjm2iSNj26LdhtP2wu8PZ4NdWISwfg6NSK/GjAvB5T3DaJmkhSKp9yOUgRvex5syo5
         hBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375615; x=1783980415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=apFaqJcux5yubEOSjwEytbZacgvToIJohWLkaO52AJ4=;
        b=iprQquVxw8DbkqGy/SyKIVa+23BZQVlTyX1k3GaCysnErxU62NZ7Lpwm5yKQj9y9TW
         cdzBi+HCPhHBEToIJuwp+1YdCukcVhxNetBf4W3GZerYEcqAx9wsFP3THn90AVxkjWt2
         T2iSFANgKgiekVJEDugoppKYuhH5Loj+zRv9I13P9GooUkKqfXyT7UxOZ1gq4Dpozsha
         vClQ0SOmeIXI1T4WrOmVKKcS9XK+JXfPdJ0FadsjGdJfewRjH6Y5BSK1xaR9Co7cWx5j
         sKmKdTMZgkkW7SMxWsMNCcZYxQcWr9HH+T1yP2HsJ4cRtf8zpBoSk+32gI2YNXQBt7xf
         Nu/Q==
X-Gm-Message-State: AOJu0YzekDKKskLr9tfBDawjrT07AT3Yp5aSUGnGsXeTH0URSeCA8zcM
	O7evVOaFr4dvK9HvXMgyG2MsmQPYZG0ubClRe7uB0ghFW8ML+kFR/7GXI8LyBA==
X-Gm-Gg: AfdE7clDPXmMIGKJrfNhSbj5k0GAH08Co6+9HLwqolVuCPgXLGUR0K05qn5tl4TVaLo
	robpQRc/nevOPNd1oxKabD2VXeCYozQPunvxrSk+EecyerHOO+9IIVZZ8tGuiZM4HYJDPxD5hLj
	LNcZwmSDZrlI3ZKIoJMkLrQErZTNGKl5HAMRLy+NFA6gAUHwq9/MO96iPAjv5/nI9ORqDAL/iSR
	6ImvCX3kFTAf9GQCCjKHUg+cWSVHfRHLWT8QV701J06pXl1XSwZ13zknCrOr94p7uSp03JCZ5Hi
	HTXV33HcO63dZPC0Xnv7XGTHPb8X5sOrFJqB0R75mD9J51uH45rxsQFkbu9GB1dJ7W0tcZFfcZz
	kFIqbIeXbjrT0Mx66j7gR3hRC2L+tJFzbGz6yMVOkGYJJZscFfx22H7QW07nZ06x3I3UmuJYKe3
	RFOIMfoEgtVX55ErWKo179g+B9ETEi0OToTSH6p/+6Fqt194z0ephc6xxWGdKJlqNbjfGL/tmce
	J6A2D96x7Gb
X-Received: by 2002:a05:6a00:2e29:b0:847:9200:21f8 with SMTP id d2e1a72fcca58-84826a83449mr2593962b3a.0.1783375615129;
        Mon, 06 Jul 2026 15:06:55 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.06.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:06:49 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 05/11] config.json: add 'containers-library' build job
Date: Mon,  6 Jul 2026 15:05:37 -0700
Message-ID: <f8d58d0dcb49d1828386f63c0f68d713b187f6d8.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:07:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4435

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
    mapped, e.g. python:3, python:3.14, python:3.14.5. Also tag with
    DISTRO_CODENAME and DISTRO_VERSION, e.g. wrynose and yocto-6.0.
  * Similar to vcontainer-tarball job, follow the guidance in
    meta-virtualization/docs/build-profiles.md and add
    "require conf/distro/include/meta-virt-host.conf" to
    extravars. This adds the required DISTRO_FEATURES and BBMULTICONFIG
    (vruntime-*, container-*). It also fixes warnings due to BBMASKing,
    by setting the appropriate BBFILE_PATTERN_IGNORE_EMPTY on layers
    which are intentionally masked. Use 'sed' in EXTRACMDS to remove the
    added 'require' line from conf/auto.conf or else remove-layers step
    throws a file not found error.
  * Append 'usrmerge' to DISTRO_FEATURES and set INIT_MANAGER to systemd

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/config.json b/config.json
index c6ee372..adabd57 100644
--- a/config.json
+++ b/config.json
@@ -1891,6 +1891,65 @@
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
+                "require conf/distro/include/meta-virt-host.conf",
+                "DISTRO_FEATURES:append = ' usrmerge'",
+                "INIT_MANAGER = 'systemd'"
+            ],
+            "EXTRACMDS" : ["sed -i '/meta-virt-host.conf/d' ${HELPERBUILDDIR}/conf/auto.conf"],
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
2.54.0


