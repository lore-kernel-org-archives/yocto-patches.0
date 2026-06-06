Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91685CD8C8E
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:48 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9456.1780714301691120959
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qwO4tXnO;
 spf=pass (domain: konsulko.com, ip: 209.85.214.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2a68d01so18060315ad.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714301; x=1781319101; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He9gZJRQPmPuaoZ3sbniehphQp6s5kpR6HtWcinvqFk=;
        b=qwO4tXnOMpMEwp6SF9Os46DvvPcnqGF66FrMFBCkFVQqadA0FHdXZALEzqYZzTthdO
         81RxM5RAoXdVAQXSJDM+IffarXAcOiYUk8izBi5HrGW/1apEcmH/+n26KYlStG09SjH8
         zMoRuqvef/bDra2AGdju+SBOJhJQF/E673Veo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714301; x=1781319101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=He9gZJRQPmPuaoZ3sbniehphQp6s5kpR6HtWcinvqFk=;
        b=muwwlTjh5B2K1bxxxwZjr0IWlbyxZPImbVbnuy0+SvjYPkL8fuPee4bCCshblrPuNv
         HTXhPiegrhkUL/7ZC49W7K1smF8QRYHTHGIQnuH8Vs0Om2Fr4RVPk0JFZ5Ku3vRvPYCI
         qL5s1h3UXBKQ7YTyhcEkO+wFXfrFGvZphECzSpFcA0qwMCeyDi8S/T9B9ZfwW56QksVP
         ojN+wJFSrsiQLmcNCXB0vBnhYDaRYpll7BiAyyAcXmuIQyzcuav/6eKj49A5r24Gg87W
         l7/yPMZUnURJSLPlgtSEfoLX6/7AgUswy2aKV7EZfszuIUTWV6E39Z8ft2FKwtMcr/oJ
         L0Fw==
X-Gm-Message-State: AOJu0YyDgh5vXoslIHjSIvc/t+yp4QXa6PNIfnW7pC+XiaYKaoLcbwYy
	0LhxS7n6BhlKu1XMkJHHUMAmVWn4RXIeO96unaYyBir+Tnx1NqZTA0laut/LkQ5+XSYnjc0CQyV
	9lwcv
X-Gm-Gg: Acq92OEkUt9E+ZiZUoSfmHSx8Gf5ojQDQ2HOVokYMB9NVpkLxQhQYoyxLqydN7ssLS6
	FiQ6qRjvaBoW8ihkdT8cn+Q7i7RgwJW6kHrnm3TdC+zg+NblED2fM/ZwAUDzm5tGBIsOWQOiiIl
	zujkbzgmQrK1Krc+NEl4sx6B05M2/4A1zEFy2iiyff00QuqeQ7S5CPpqhx1Gj6+QLQQGmscI0UK
	vTIZxw10kSXIT2x7cgz+rYm5+owI02Ov82HXP5R3eDnpWzfNI877P/i2cPgpKP80HMQp+CXrkQ0
	cSnCeANU5tx2cFi/QLHNg1pHeQrjt2yEYajIsOXTp9BjT+KvNUgkWC1QAnyxxOPk9IoCcXZYISh
	0bXFIVDOz+OgfGMANLcnmq5NNnGido6TDU/XBIcLY+2eQ4upet3RceauwTi0SvoAdarmSF2jnuo
	puXS4YlkM+MC+yooCzVsNjboC7nz7CFzJjrdtvboOThyVk0Yahvun7j0VBXnVdocFBL/FtVq09Q
	g==
X-Received: by 2002:a17:902:da86:b0:2c0:ab82:6b99 with SMTP id d9443c01a7336-2c1e822587dmr65253745ad.33.1780714301014;
        Fri, 05 Jun 2026 19:51:41 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e86dsm108116535ad.8.2026.06.05.19.51.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:40 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 2/6] config.json: add vcontainer-tarball build target
Date: Fri,  5 Jun 2026 19:51:16 -0700
Message-ID: <f85b2e1317a1c05bae2dcae56cf4951f0aa46b58.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4157

From: Tim Orling <tim.orling@konsulko.com>

Add the vcontainer-tarball build target which produces the
meta-virtualization SDK used by downstream container build
jobs. Modelled after the buildtools-tarball target.

The target uses EXTRACMDS to reset BBMULTICONFIG for the worker
shell, places the extravars in the per-step config, and includes
a publish-artefacts step so the resulting SDK tarball is staged
for reuse by container-tests and other consumers.

Since meta-virtualization is the first layer removed by
'remove-layers', our BBMULTICONFIGs become invalid immediately
after layer removal and throw an error.

In scripts/run-config, EXTRACMDS runs after BBTARGETS, but
before 'remove-layers'. Use 'sed' to reset BBMULTICONFIG to ''.

The error in the 'remove-layers' step can be summarized as:

bb.parse.ParseError: ParseError at /home/pokybuild/yocto-worker/vcontainer-tarball/build/layers/openembedded-core/meta/conf/bitbake.conf:824: Could not include required file conf/multiconfig/vruntime-aarch64.conf

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/config.json b/config.json
index 4904439..2971fe9 100644
--- a/config.json
+++ b/config.json
@@ -1827,6 +1827,32 @@
         },
         "toaster" : {
             "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
+        },
+        "vcontainer-tarball": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-virtualization"
+            ],
+            "step1" : {
+                "shortname" : "Build vcontainer-tarballs",
+                "BBTARGETS" : "vcontainer-tarball",
+                "extravars" : [
+                    "DISTRO_FEATURES:append = ' virtualization vcontainer'",
+                    "BBMULTICONFIG = 'vruntime-aarch64 vruntime-x86-64'",
+                    "INIT_MANAGER = 'systemd'"
+                ],
+                "EXTRACMDS" : ["sed -i '/vruntime-aarch64 vruntime-x86-64/d' ${HELPERBUILDDIR}/conf/auto.conf"]
+            },
+            "step2" : {
+                "shortname" : "Publish vcontainer SDK for test reuse",
+                "EXTRACMDS" : [
+                    "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
+                ]
+            }
         }
     },
     "repo-defaults" : {
-- 
2.43.0


