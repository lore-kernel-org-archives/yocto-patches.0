Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45674CD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:39 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12715.1780355914917257488
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=U1XNlBWp;
 spf=pass (domain: konsulko.com, ip: 209.85.216.41, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b8d414666so2896179a91.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355914; x=1780960714; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR/tiEwkmI9AuzyCs9P34K1Bt3u8bKLCLuR4F330iHQ=;
        b=U1XNlBWpyvZTI5h4/tOp+YDviGwwPcito9imGLyszcRZLnDaB1ngB/5GGW5tvpaIHH
         6CJd2EHhz8ulBsRAGCkINMybE+pXKmgtfyzLs31le2mlm/kydA1Zh2MPe0JRYSRtNT+P
         vWxMFvrJzUhM/+RJJT9aMr9GDLgoELDlaT+p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355914; x=1780960714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fR/tiEwkmI9AuzyCs9P34K1Bt3u8bKLCLuR4F330iHQ=;
        b=WXyeojJ2B80BEwoDOoUYBHE2//BmOh+q8CW4FStshHmkz9OP+wxJxhDBK+ghPT9B//
         RltDOTpml5hKrd1+yUdvqnmfzokR8ExaW/kYx/ANbrSMZVsVgYt9zLxBB92PkISUVKlu
         aNeHig8mss1lNLvxVz7g7dStsEq1Hn2QoMB+Z66YAKxM948Ye1iODJLWGA0b3SBOPEV+
         iSMeJgtCjofQ0JizS5xYssosd4kCFzyUAilmrVmNj5YOUOz9EtNe++aRsYQz/w6Vz32X
         L+Jj6CXw4M2+IzeAHNzPoTso6U/dxfMNKWijxZh1ZmDPWCqSLgTxUHNUflTSUO+XA4CX
         y21Q==
X-Gm-Message-State: AOJu0YzMbp/lFdoBIYLeys5T5+L5Mqm4QW/AljXqWrm7rXkOq3HxGgTC
	7lkCfrI3JQFHR6xqjLMW+9AgN6wKRsqRh2YtNFE97qfFYwsNFJ4zc0aF2omHRFkFqEXandqFti9
	GsrHW
X-Gm-Gg: Acq92OHFXQ3L1PFu1ZGj8cNALCbuxd52Mgsc/SQBSRj/uvdoZaFtYEsURWjeNX2Gb7S
	ifu53UYAVLZEEhvyEdYnE2Fmz0UuLgEdtIGnsdc5Wiu9MCUNQhoNsXXXWtj52wOsV5CwyCqe513
	YRT4VGZJ941WjpBgfQ1UQ3lvOg5tFJK5JWpaZkmUOJRlq/5Wdor6wegU2GwpeY6uw/OMNADrHxR
	deTYwdmyRCT3VtXfMAWoOpsum2WCrUi3dj01o2j0IOiGT/og84Dg6Pco+0lZaYPfpACno7f+Q1u
	yCGwmfs9q0Y5kju+rrFN5/gitm/LQfbUCD5tPQ/Ccp65TgNFcte2ohmjS4OFeNj9y3SZ0hYwK8w
	E8znWWRua4pgNV9em002SHIDcYsGCixOTFFN2yw+BpaRtEoNaLWH9AVNn7Nx53ybKAM4i682M+o
	qFzaPoISC3XgUAz2JopE/RfnUheyZiGWSOj2Wva4NcR6iDX3m6CSE7/578pkbUKHXaDduOhVbwA
	w==
X-Received: by 2002:a17:90b:4a91:b0:36c:689c:a4c9 with SMTP id 98e67ed59e1d1-36c689cb2efmr12331985a91.21.1780355914334;
        Mon, 01 Jun 2026 16:18:34 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe19dc07sm6848325a91.5.2026.06.01.16.18.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:33 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 06/10] config.json: add vcontainer-tarball build target
Date: Mon,  1 Jun 2026 16:18:05 -0700
Message-ID: <aca1e3d5668e685b879c599890ce83abd922b005.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4103

From: Tim Orling <tim.orling@konsulko.com>

Add the vcontainer-tarball build target which produces the
meta-virtualization SDK used by downstream container build/test
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
index 16d8a04..7206c41 100644
--- a/config.json
+++ b/config.json
@@ -1864,6 +1864,32 @@
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


