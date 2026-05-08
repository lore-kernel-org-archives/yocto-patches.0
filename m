Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB42CD37AD
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:04 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4657.1778205659515921101
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ky886oWu;
 spf=pass (domain: konsulko.com, ip: 209.85.216.41, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3658ff4d34dso1011737a91.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205658; x=1778810458; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RevNAg63UntrgGhEbeJlSDWjtYKRFpzF9WJml6ixDsc=;
        b=Ky886oWuz5IANirq0j7n/c1SvhHnypTzfNsTYXT6n94o1oTupU70eXa7iOL2SpMeGK
         TDCBwC93ALilVSPxNCD3Npxgj3uKhjR2/zU2js/6lm7e1jJuQ3heKM+ZMtUBfOMozN4e
         IirR8sQRDV9oU96UAJVXpi6i7EbmtxrNKVa38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205658; x=1778810458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RevNAg63UntrgGhEbeJlSDWjtYKRFpzF9WJml6ixDsc=;
        b=i/JWufVFQ1/PzmnkG/LGkcZXze83eeby5bd5f0ya3pGD+lnxbid+ThHaedxK+1lq0B
         RHOSiDcEC1fhdl9ucpnzzPtvs74Ii45Fy2EXGGSVkPJpFWKthR/rkZggUcA48zCBUq5a
         3EX5K00t/CjxCqkNHlDzIfjPfQoVfwKjwUuDLlKcf8OgFCtcGkaQ1vIh5EGsUplBit7e
         A6yM7beFAxiTJaEgSO9kbmE4TH0BVFMH1kFTlKpQ8r0KT8gSP+eGj0Gdea2mdKzEC1D/
         NQSFKIaBHIlZzai46QiPkt1FrCuJOpll2LIyU4RbipZvKF++AsdwbI4ln2YN3R+cog3t
         DKdg==
X-Gm-Message-State: AOJu0Yz3JS7TiYAzx1DRbJV02n1OW+IlRbGMB4il/Apm8/lfyvrWoYUv
	ADDlguPkf7WLzjw/JES73j51fFTzaAyYclP/iAR/eyHvNFWeZbqc6g4l9JZCCnuNXLWvxfQldlJ
	/cbtU
X-Gm-Gg: Acq92OE05/X8gZqgTKoeEINczOCQ6jqI7M7YHn3DLIZBg1tgfpNE4FHEtsi9vJ4LS0P
	DAS0jweUVfUwtjZTqGfngvg6AkyuJbYs70o6mmQKLRbu4YE1GDD/PUFrMZWSaP1HVp4ptBkNM0m
	owaIOHk5cOmF4SX/nTTmRj80lsuwZEn+BwuBJyQgLo0SdZ06hZbxcpAxOliQQnO6Q/UOrhN6Yoi
	CTHb/VMbz/yHRWSJtrmyGNXl0F1SyOxyBF+o5U29n26JKnjJpDzhNVHi6kOCB6tyBG0S7HutyqL
	HelA/I3m9KLM5ebR1Nm494BIXaYUwcfk+Z2HKxfYXCXCZMG/EvjKogflv1k5iDA8kc3meDJaWQC
	P9L5HWZT/0bPTIJJNGluf8+gJCF4es1l3nNBycXljkoAQnmX8fr/Hnylkogo6BhSGEgpE43GvIv
	RsZ06W+KeT918XYBZeqICKPb7YbBxeOYOPXELaCGGG2gWKs0HJo6bJiMXVt1lGEPwyf+s/xQD5y
	w==
X-Received: by 2002:a17:90b:3a0f:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-365ac79e167mr10090501a91.26.1778205658488;
        Thu, 07 May 2026 19:00:58 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da42c37sm233896a91.6.2026.05.07.19.00.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:58 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 06/11] config.json: add vcontainer-tarball build target
Date: Thu,  7 May 2026 19:00:29 -0700
Message-ID: <f76cfa3158594d6abef88eaea589b9e135158e9f.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3945

From: Tim Orling <tim.orling@konsulko.com>

Add the vcontainer-tarball build target which produces the
meta-virtualization SDK used by downstream container build/test
jobs. Modelled after the buildtools-tarball target.

The target uses EXTRACMDS to reset BBMULTICONFIG for the worker
shell, places the extravars in the per-step config, and includes
a publish-artefacts step so the resulting SDK tarball is staged
for reuse by container-tests and other consumers.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/config.json b/config.json
index ab0ad7c..9e6898d 100644
--- a/config.json
+++ b/config.json
@@ -1869,6 +1869,32 @@
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
+                "EXTRAPLAINCMDS" : [
+                    "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
+                ]
+            }
         }
     },
     "repo-defaults" : {
-- 
2.43.0


