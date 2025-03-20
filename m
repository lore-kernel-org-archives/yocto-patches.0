Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE24C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 20:22:55 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.4944.1742502164052399092
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 13:22:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=D8GRqu3R;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20250320202240ab51753eb7a491c9b2-0u14ty@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250320202240ab51753eb7a491c9b2
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Mar 2025 21:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=oXOQQ0JYXxnpVByfvU884VAmcLyS325vtScQC0qnzJI=;
 b=D8GRqu3RuLiFemc9CJQVReoylbqd8vblMFbRoKrybh0jI6YCIqb8Hw9G/lEyiXVfqWJFuj
 9E8vdybf4wQapfFOc+cIRfTiG1USVccfGbkH1EuNZdq+t8eDvEQrIcJiwGTsxuHuZpfeEGjI
 smEWhXbCCBdtkeTcTaT0ElHislSQrafBBzcDeGfGMMhlprOnLT3c6Eho4g53vOw6r6bLfK9i
 8yM8sS7I+sTEGjlcSlx/uKMq3IPcGTFKK0DfBaC4QsmVQqWf+FzFXZE3QixwnF32yV53lXLW
 P6oRpgyM/aBmQ3J3/C0qaDCohXs3B2rB/qFmk0Fgsq5JnU8er1YZbVOw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [meta-security][PATCH v2] tpm2-tss-engine: add .so symmlink to engines package
Date: Thu, 20 Mar 2025 21:20:32 +0100
Message-ID: <20250320202031.50796-2-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 20:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1237

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Without the symlink, the engine is not found by openssl:

openssl engine -t -c tpm2tss
20F0C5BDFFFF0000:error:12800067:DSO support routines:dlfcn_load:could
    not load the shared library:/usr/src/debug/openssl/3.2.4/crypto/dso/dso_dlfcn.c:118:
    filename(/usr/lib/engines-3/tpm2tss.so): /usr/lib/engines-3/tpm2tss.so:
    cannot open shared object file: No such file or directory
...

With sym-link it works (also without extra configuration for openssl)

cd /usr/lib/engines-3/
ln -s libtpm2tss.so tpm2tss.so
openssl engine -t -c tpm2tss
(tpm2tss) TPM2-TSS engine for OpenSSL
    [RSA, RAND]
        [ available ]

For exmample also the Fedora package has the symlink.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
V1 -> V2:
- Just realized that my first test did not show the sanity check
  failure. I added the INSANE_SKIP line to the patch.

 .../recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index 30865d2..af9dec8 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -29,7 +29,11 @@ do_configure:prepend() {
 
 PACKAGES += "${PN}-engines ${PN}-engines-staticdev ${PN}-bash-completion"
 
-FILES:${PN}-dev = "${libdir}/engines-3/tpm2tss.so ${includedir}/*"
-FILES:${PN}-engines = "${libdir}/engines-3/lib*.so*"
+FILES:${PN}-dev = "${includedir}/*"
+FILES:${PN}-engines = "${libdir}/engines-3/*.so*"
 FILES:${PN}-engines-staticdev = "${libdir}/engines-3/libtpm2tss.a"
 FILES:${PN}-bash-completion += "${datadir}/bash-completion/completions"
+
+# The tpm2tss.so symlink is in the main package because OpenSSL
+# searches for the shared object via the symlink.
+INSANE_SKIP:${PN}-engines += "dev-so"
-- 
2.48.1


