Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD95C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 07:34:45 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.8083.1751009677190567831
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 00:34:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=wkHcD36z;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453643020bdso15921045e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1751009675; x=1751614475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDRrw8EJsCxTL+rg4gqd4PJWkBkM9yjreeb1jHFhOs0=;
        b=wkHcD36z3JwyZuOb1jQGDgnMnpMgNLAIg5PVu99dKlkmrzFkM92Lg7wYswmqjzr+dr
         HYu+HDIITCCYdoFE3pA1iu0BgYqJ7IZgM7VhuerHkwIW5h63g9Yqr/zA3U5c/FstQ6/O
         vtXR5h3kR7nByCY6a6dBCf7dxovoY+Pt7RwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009675; x=1751614475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDRrw8EJsCxTL+rg4gqd4PJWkBkM9yjreeb1jHFhOs0=;
        b=e3U7K08Ehq5l2qRWrSaxq9A8XHQIkoZwPKhuF6CiYHUoL2cOesVdeS90CIsQOIK+uY
         QlsWd4Yax335Be69JXiVSTZQxl0m64+egiGKEssrO37ZFyvd77X4EUOycp0Jxpu6F2Vj
         BzAQ7FC2lz38zOYu6TeMbAteJNFr6VZfT+D5MAWahMuRBI5cwhPHComW0a60GMVwjKoF
         25tTkDQWs+hcuhcGtyWvsN313xBSzef8NSTltH1OVmoS2pNoGDFmD9NWy6FlPOF+Y5vj
         Iu209oti55BniANmixeUo/cFr/v/W1aosmIGYif238K3UOeD3kZUD3aEuc63/vP6UiWN
         X7Ag==
X-Gm-Message-State: AOJu0YyI+70/OKxFp+9dwM7pGQ/Er2aj3oE6PlXoV0o1BuJtoTIrfA8W
	6BuAtkkFjucpPYsGEl4Fg4tpHJnU4qNZWfcRhkCi8Fmlroc1/0TovecFaFRHG8EkN+4/26fxhoj
	E4JBH
X-Gm-Gg: ASbGncuzYaPhhyVO/FEYZzXUz4E4+mJ9k1HO/FznIvGH0WgpCNR2EXW9M+Oghm4i0g+
	0qVq22gQbR+l0U8YB64AAYP4ZqNdRmfRRhH1Sl4NAm/sp8mcpxUm/KRpoOUCpG09gsiitknEh5c
	FNNflHm1ocfKYGU8Qv88GOjQlN5y/h3U/EzmWbtXhmbBJSN8sq93Ou2j2K6q5B/XgcVQVcJj5+g
	Tha3NS+t4XTbLKr0qutBVWXs8igq+7yW2/ym3UY5XFrSrpF9RW0qQ9EPjyo5EsVVi7/istZl1ZL
	xFCB6yTZr59W3QoT9ymlNoxme0MjyeE0NE5rd7W5l2xALa1CO8rAapz65OfLj0ZlmTyl/qz+ZuH
	sRO/v8AwRmfsvsWzBhsmeBWZat0JS7OlWQDGR1t6ii69jBMjgMXohK9h7XrxcpCK4JLG57w==
X-Google-Smtp-Source: AGHT+IGiLPIUxANUbWzKyhFD1FenF/rWt1C0e3KaA7OPdang0PTF4Ak03yTfQ5SJ2WAIE3P/C0xSvw==
X-Received: by 2002:a05:600c:a00c:b0:450:cabd:160 with SMTP id 5b1f17b1804b1-4538ee50443mr24441545e9.3.1751009675284;
        Fri, 27 Jun 2025 00:34:35 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c523sm71790035e9.6.2025.06.27.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:34:34 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] reproducible-meta-oe: Remove redundant OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES
Date: Fri, 27 Jun 2025 09:34:31 +0200
Message-Id: <20250627073431.2349674-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 07:34:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1704

From: Yoann Congal <yoann.congal@smile.fr>

Since meta-openembdedded commit bf400cd73fad ("reproducibility: move
known non-repro list to layer.conf")[0],
OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES is directly defined in each
layer.conf. Remove the redundant definition and simplify the code a
little.

[0]: https://git.openembedded.org/meta-openembedded/commit/?h=master&id=bf400cd73fad89aff85017dfc4c169e7a39fdc4a

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/config.json b/config.json
index 383b18d..3e01da3 100644
--- a/config.json
+++ b/config.json
@@ -312,9 +312,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-networking'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-filesystems.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_FILESYSTEMS}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step2" : {
@@ -334,9 +332,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-networking'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-gnome.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_GNOME}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step3" : {
@@ -344,10 +340,6 @@
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
-                ],
-                "extravars" : [
-                    "include conf/include/non-repro-meta-initramfs.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_INITRAMFS}'"
                 ]
             },
             "step4" : {
@@ -364,9 +356,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-multimedia'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-multimedia'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-multimedia.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_MULTIMEDIA}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step5" : {
@@ -383,9 +373,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-networking'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-networking.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_NETWORKING}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step6" : {
@@ -396,9 +384,7 @@
                 ],
                 "extravars" : [
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "include conf/include/non-repro-meta-oe.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_OE}'"
+                    "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'"
                 ]
             },
             "step7" : {
@@ -413,9 +399,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-perl'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-perl'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-perl.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_PERL}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step8" : {
@@ -428,9 +412,7 @@
                 "extravars" : [
                     "EXCLUDE_FROM_WORLD:layer-openembedded-layer = '1'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-python.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_PYTHON}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step9" : {
@@ -445,9 +427,7 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-webserver'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-webserver'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "include conf/include/non-repro-meta-webserver.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_WEBSERVER}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'"
                 ]
             },
             "step10" : {
@@ -473,9 +453,7 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-multimedia'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-multimedia'",
-                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-gnome'",
-                    "include conf/include/non-repro-meta-xfce.inc",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_XFCE}'"
+                    "USERADD_UID_TABLES:append = ' files/static-passwd-meta-gnome'"
                 ]
             }
         },

