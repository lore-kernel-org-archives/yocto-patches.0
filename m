Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29694C36000
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 08:21:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.2714.1742458900134154147
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 01:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=jv4Dd4g6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-2025032008213617246cb06d9f281285-kfyi6u@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025032008213617246cb06d9f281285
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Mar 2025 09:21:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zRj9UR7oDZdl/xNl9slNFoj+bVR6KpMKjyCgnKP6gxc=;
 b=jv4Dd4g6yZeFV9THNBowIQAkI62hFDBWPZEVvDO3UFGSpwAvG419mXqNejT7rL06tYfdRO
 QasWAkB3hSAGBL+bCqqekJffTfocvS5QSyXZXR7lqZ9B8gSildpqGIac3ZPynhcBIGircVdf
 px1vy3ky+qg1GDrnyxBC0Hf9bR8OvrHf5Au5st7Qq6v/j+JPf1QsPGJ1fnv3RAb0cy22YuRp
 yYqguqGuEOka6r8+lqXyjyICJ6AfI0Raw4kFp/AqYcZPtuqyQUtS4xyoDeE2PBx+BNrEunsd
 nAWVqZft556qLfmqUDfYbe7Ik5Veq8aS4HkX/jsZpK0x3SdhpwnLGUfg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [meta-security][PATCH] tpm2-tss-engine: add .so symmlink to engines package
Date: Thu, 20 Mar 2025 09:21:33 +0100
Message-ID: <20250320082133.683734-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 08:21:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1229

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
 .../recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index 30865d2..413b8a8 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -29,7 +29,8 @@ do_configure:prepend() {
 
 PACKAGES += "${PN}-engines ${PN}-engines-staticdev ${PN}-bash-completion"
 
-FILES:${PN}-dev = "${libdir}/engines-3/tpm2tss.so ${includedir}/*"
-FILES:${PN}-engines = "${libdir}/engines-3/lib*.so*"
+FILES:${PN}-dev = "${includedir}/*"
+# Install also the tpm2tss.so symlink since this is what openssl searches by default
+FILES:${PN}-engines = "${libdir}/engines-3/*.so*"
 FILES:${PN}-engines-staticdev = "${libdir}/engines-3/libtpm2tss.a"
 FILES:${PN}-bash-completion += "${datadir}/bash-completion/completions"
-- 
2.48.1


