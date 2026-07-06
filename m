Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7FC44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:06:44 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162430.1783375600958320813
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ERB5kb0c;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8478fe07f65so3584019b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375600; x=1783980400; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+gFaOja+ZxdtARCjaXQkdq5mL9J6nnmick6B/WZ7hE=;
        b=ERB5kb0c99a8A3iwPE5gEop1gMzRiCHA0wP7+qN648OG66SD07cIJ45G7Tg/G4KeBi
         DGTR/V2s4XBhVKGPsLTZuJayzwP1Z+ibAspA4XY8DbSzWlpN1w2fr4A5jO7p1AHQfnzs
         a9PgMJweHFU3Mf9DWPoDwHB09Y+aOjBx4+90cvdJORNhU4vgskhZqkqwa5Fe/P+Idzwc
         bzbE85ys7gfMZ9xKlw7/v97RhLZIBIHrfWjZMcI8NdP09MSXIKel3Mc6ucaQHtAyWrip
         CRpb8sMRBkS0dnPE43FwW5cSvXgNIUB9s5T7gG5u0K2fEMdN0OqLFLWAaOK1oe0VkxO1
         UGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375600; x=1783980400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+gFaOja+ZxdtARCjaXQkdq5mL9J6nnmick6B/WZ7hE=;
        b=Zmnx75YU91ZFOj+xOd1LNa7ZpHmIvlp8gfXHNAPYDTdUj1/4NapU3foymxzeGoxgQN
         jt9TAr8oDvC5kpPw8xcjep5o2amOlQVSI/gMqXBD8an0x+XxqFz6cxBsz3p6XvLgV+v1
         6HAvCdECncK9eW2kUX5RCIyYZRtOq8AFCk2lOuqO5YuT+BZsOo00gYnpSSsL6aV0YqTW
         dyN4RAwX2G4xvI2p2ePMbQgNFmZUosdayMFkeahKFhz4ur7f/UILIQrwd16vw6aBSTbY
         zeLLhJWTCbVNsPFC4mCld/HgtliHeQ1YuU6/vD+rRUKUmHXZoJ+/wpj/jNIFZR7/2Nqh
         FM4Q==
X-Gm-Message-State: AOJu0YxehNvWkWPb6YGDFYaR9HsFzIqK7sQR4KdtQr2326lbGCk++HVr
	6T6tUXoUrWdfOXxRkHCD9ZMV6MhUnp6HHklx82E3DvZkdfpR107HhM0P6vtVDQ==
X-Gm-Gg: AfdE7cm6HEIItDkCAvkfWp70yA1LAv+a3sgyAUZC+ivg30Th5hIvB9/1V7EXiGV+slk
	IsU/YDDIRCjp5qOT6kwMhmUkCxzcFyOhW7GiWZDxh0B2eErh0EifOHJx2+RLa0nzmiSbAP03f34
	VmytpL0QjARKhTRty83BYMnnJM0d+TG1xY5B/quebvbos8xhqkqG+6RmicL8U67hs8nn+UR+pr/
	sCkDjcexL/mADilIZYKOk6t6jlt6NmajZGgBIAKrstiQXI2hy793RNFlo4WAmJCQf+ubnUoP+hD
	h4kCldd363HGIBJesp7Rrig0OqVn8qKp+FvEk8BiJaEpdVDdlRMHgilgvNdPblHkd1t9ob2uamt
	vACI4bdTpoyMfHwjEl/37fg27LIshnO0QQT1Rl96ijVPCO7jcwhey1gvdlAxJ9F80kO7ZS64W48
	QGS+0LD0EbxquvQAheoSkn7xv80xjp1wMJkQXtLyAMQlUrAakSdtZDfOu/+NbZKUgQocxdcxP7T
	BCCHdSNbOt3
X-Received: by 2002:a05:6a00:995:b0:847:949e:ea6f with SMTP id d2e1a72fcca58-84826bfc073mr2420336b3a.4.1783375600212;
        Mon, 06 Jul 2026 15:06:40 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.06.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:06:38 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 02/11] config.json: add vcontainer-tarball build target
Date: Mon,  6 Jul 2026 15:05:34 -0700
Message-ID: <21daf90c9799e7049ebb34f24925e26d311852af.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:06:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4432

Add the vcontainer-tarball build target which produces the
meta-virtualization SDK used by downstream container build/test
jobs. Modelled after the buildtools-tarball target.

Following meta-virtualization/docs/build-profiles.md add
"require conf/distro/include/meta-virt-host.conf" to extravars,
which appends required DISTRO_FEATURES and sets appropriate
BBMULTICONFIG.

The target places the extravars in the per-step config, and includes
a publish-artefacts step so the resulting SDK tarball is staged
for reuse by container-tests and other consumers.

Since meta-virtualization is the first layer removed by
'remove-layers', our BBMULTICONFIGs become invalid immediately
after layer removal and throw an error.

In scripts/run-config, EXTRACMDS runs after BBTARGETS, but
before 'remove-layers'. Use 'sed' to remove the "require
...meta-virt-host.conf" line.

The error in the 'remove-layers' step can be summarized as:

bb.parse.ParseError: ParseError at /home/pokybuild/yocto-worker/vcontainer-tarball/build/layers/openembedded-core/meta/conf/bitbake.conf:824: Could not include required file conf/multiconfig/vruntime-aarch64.conf

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/config.json b/config.json
index f4ead18..972682d 100644
--- a/config.json
+++ b/config.json
@@ -1830,6 +1830,31 @@
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
+                    "require conf/distro/include/meta-virt-host.conf",
+                    "INIT_MANAGER = 'systemd'"
+                ],
+                "EXTRACMDS" : ["sed -i '/meta-virt-host.conf/d' ${HELPERBUILDDIR}/conf/auto.conf"]
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
2.54.0


