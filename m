Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD69C531D0
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:27 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2387.1785202879208383769
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aVnNUYxd;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8486672f03cso3251210b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202878; x=1785807678; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iey3Ghxi2FM/GI7svCR+Mu4x1xYuTD6DsWll+0T6rBM=;
        b=aVnNUYxdfp5i9PWWL+oCpFGTjjdC5ixD+T6jRIa7ytIFIrNzYqrE93fQOdVOwAwolE
         fu3v+LgwmlPTRRmStHqS+c6YfREfhda51nmXlQl0lucBa2+hbeFOmG84zTEFwyrxyNZ5
         cpyjd5eY1DPdOjfQD9S1PKkiUBxlvUlJZqHffD2SHciw1Pj3LuoY9wO5HL8p7gzO6XQ2
         6GmT2fKUJspBSckClRzTrcj1wWomiKzdn/Tjej7MAkP6Ri9rTuMUSxU0p5xkADV73zp9
         jo9frebzeM7XWFFVmEOkfAgwgK7WGKTZLZzV6ng9MbQreodlLhBIlsU1WOEEFvuYiBXF
         gDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202878; x=1785807678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iey3Ghxi2FM/GI7svCR+Mu4x1xYuTD6DsWll+0T6rBM=;
        b=AZaAjEQWUfJGu8zzDdgPv6Ilzc8cF6rsYeSkqqGg19WFXOCFwliGsJw9nM6gceIE7z
         rtxT1gXGvkgzj5E00Jra5cogyUhg1dUE376hf14jarcLhD7AruUIIjJo+T26u+vPs31/
         l51zVq9ECvNTe9VhCd+kD4en71PIvL/Bfe3pRD5neBsbR3srpwJ44aWF0AoFW/YQJbFS
         ZJbiHIyeCyvs//zjQVVpUo+Ggzt3Dne1UInsQkkEkxsdSss8cE2dYjMLNL3P2Q3UEAu7
         IWlwPSJ9aRk5eRx0XN+aC8JLakO8aHXROuvPUJCT0h21UUHCow1fF+pJUZRXYIk0pIcC
         3LXg==
X-Gm-Message-State: AOJu0YykgTQ4mqiMyVIjMVlGjIDz9Yeg9x3mIXv3Dk+9v3QYhcwLUHw2
	TVQf388rDbHqVvhc7J7I/XY8ZuRgBb/4KKUetkqrFVRv3b9zYEOBuHxGreZvMA==
X-Gm-Gg: AR+sD11Du/6UuVrCSJEJAONIQ2vt61whvcVUjhNsUH05WZ6clogzstZEolaQaf8nCf1
	7uZ4qQxAz9HUPSHV6Sk4JyEBoAQzFZE7Z4r1J/fnWnLY/UVk0hJTRN9mOkJE5yyr73h+1Y7vXNC
	71tYY4ljvqOw298zEuMB8r/G9YYYb+lmSYFlu2cgC7Vlnak6ilCNnqzHlN+bVsfeH0i3Lu+ns/A
	r9MxuzIY27iWzlYzR6xa65HBNT2N/rrSzKkfM+YXUkw4EgJHSrv/4OF72btUgK55EmP4O4z8TSs
	jGuTb0BxfPo6E6XWOuil0/TKcGXdgBBGkEgjxNPuW4aj6HKcnImCj73HQgzHAnBSgXpBqISfYJ1
	xnGyrPEmw3JrReNVW3CKBoc1+3/GuZsYXvtDF70rYXcZTR0kFNbViXk1C32S02bK6pXCZw0+K9M
	zXfmwE06RI2uqYA/+sDbVTf6VAlsvgzes9RCSpLWM785qRbq5ERrI/nvAb8lpMbQJapYO2b+m0c
	aUZzaS03JwvzH8hosOyTfzMl8URJ9y9s05ix5qvijmDEuN90+OWlDdiYdaze2kbSLBBrw8=
X-Received: by 2002:a05:6a00:6c93:b0:848:2f7a:2e5a with SMTP id d2e1a72fcca58-84e9340e985mr321809b3a.73.1785202878546;
        Mon, 27 Jul 2026 18:41:18 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:17 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 02/12] config.json: add vcontainer-tarball build target
Date: Mon, 27 Jul 2026 18:40:35 -0700
Message-ID: <8017979c637a4cbcce5e061d2e72c6e02380cfd5.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4541

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
index 4d329e3..8a665cc 100644
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
2.55.0


