Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530AAC54F51
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:37 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2392.1785202887386744254
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Vrh53jBz;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486ac3f347so454882b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202887; x=1785807687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HBMGTEVe/H1D+RkXoZgE7mcyNuCkXgjcjz+SKGcN2N4=;
        b=Vrh53jBzisYDw9twzfa+EsdCnWUp3sPs7iVzg7fRjBmZabQff+0vpnO5ObfwEObaA9
         fnOcTNk2gn7ZTmS+89lDrXju7EZ1oqQrS5QiX3qh12VMrlojTLyQB6lBrPjfPjLzSWXg
         nDoU5g6o5/I0pwdHBBz9GPXzo/Vs4Bm3zpNJNS3hYvbLMFR8+8Btt3FcsI0OcaPDxrJc
         5zq6AuZ0hYQcSointBjBoXN89etBNQg8KzV1nD1YEI+xrvbyOCkOoy72FIfdg/Amg6Me
         U2MSvZm3yg+Cz1I362lXm/T3Mn3hH8go/dk5P279vzVQWqkwAhUMEPbPSJgAJdQwXwCO
         OzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202887; x=1785807687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HBMGTEVe/H1D+RkXoZgE7mcyNuCkXgjcjz+SKGcN2N4=;
        b=oMcg6ZxTS+KKcMbTu5R5IEsAirC7TVYftSD6e/Qcsu0kV7owsdS93TigaiBwwCywFx
         cP/pXsOwrhflWdu7wcyI9V4w1TVFyjnDs/tFZH3cyRea5okHrX7UzqqPz1wh5hi286Hj
         TtTR/hgCHi/yiap0XY8Nor9VC54JsZjpLyO6f9gTJv1ryJJGrXzt5maHFyRhW32X3fhj
         npSQp8GguiFsG9NWvGv3tQwb6g9LOmVvpC/sGjS/re8AtqCi3B1fecN3W1KiODYGAD/4
         vBWLk/t1KxxI4br3sFO+qlTGruFaf7s2/V9N0zXuyjMiL0UvDLS6vDejoNrs1SPzWY7n
         h40Q==
X-Gm-Message-State: AOJu0YyC/gF8uIOF69icd1yUDJZzJKywskDehFI6JESnAiY2MmUSs/rb
	UELY6iIR+3dzbfLnSBUfeCLnXQ44UdQTMYNZMUy7v0tLs9oAi8lB9t30kxI1GQ==
X-Gm-Gg: AR+sD13vbOXxi3nx8HJdiIvvTei9IjYfXXecijCUPLbVIdwCZzGi2GIiMb+9crRhNsi
	JeuOV/P0dt8cKZSovLQbntfAMT7OUqwCWQkjfq2fTSQV3DxnvRhhH074mi9XGA+HHPTiVA0GvoD
	ejaRrc2VvUuCHsdHFDXJEmYC6odjMBpKAm4P4QuQ+XBmqUWqmIBmoeqoJmqAW8sokiNv8DF5Wqg
	+bIegvcATIT+3y/9+HIjvohMD1/0jFwOlgLAj4q9BUTF4nVb3ZwZ0HkET8P5s4IrzZvWy9PmTb8
	xxuBo8gBVWsDsZX/QeOOjVE+0Y22SYNzhDyyk/i2D3x9O1MOZtRzkpJjIygXCUIOQ6xDR5vlbim
	wvI1GVob5QC8Cl0nKViOZgiwNsVxkHsgvjesseLEWtLaRYuBbCQhx3/qazIYYLvuRByUZtPz1SC
	A/7fdHUxMajh/WiEKlZgkEIBQNUSoZz/Q7dP3g1pGKX/pi4J9OqMPtRLCjrxMmuPAS0qwHDK+NX
	w==
X-Received: by 2002:a05:6a00:3a14:b0:848:40f5:ff5e with SMTP id d2e1a72fcca58-84e9329ceaamr295762b3a.37.1785202886745;
        Mon, 27 Jul 2026 18:41:26 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:25 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 05/12] config.json: add 'containers-library' build job
Date: Mon, 27 Jul 2026 18:40:38 -0700
Message-ID: <306a85f2070349bd3e21a0ec4c90bf70a6fe0bf3.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4544

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
index d9d0fdc..8c7a91a 100644
--- a/config.json
+++ b/config.json
@@ -1888,6 +1888,65 @@
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
2.55.0


