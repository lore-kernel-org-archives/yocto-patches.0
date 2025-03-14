Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6285C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:37:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.10028.1741944214704906372
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Mar 2025 02:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=michael.haener@siemens.com header.s=fm1 header.b=Cue7Vl3X;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-664519-20250314092331768ee1487c6cbbd439-vdfngi@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250314092331768ee1487c6cbbd439
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 14 Mar 2025 10:23:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8n7zgLrMoxRFQicRGvJP/mQv+lvcrEfZKGJdFoCTlcY=;
 b=Cue7Vl3XuWlZUEBSGIDGFeCRTGH7q/uvMjv191rw+XuFQnBx1QARXpr6RpKtRkXjmpF5MR
 kzPxEG86viMOYqbnKLZqTQZrPUP+DB5Ex2ZSwA8BIh6iWEu7reJZaajScve0p8odF0tXGEh8
 k3wx9wzfZm8rg3O1iv3nCIiiuMIHTdK5GcnQTLoL4AkFpgYa0g1vLUNME3TOQ7R+QAA6DX34
 zSxskRtBcjvKJlvQEZYp7G6um/9qTiO4DUF+tGCkLpQisCc6RypWMedZU0H8kvs9OhCddffL
 de6eat2gPMX3mLyhSp+sR//KJTccTvRVDx8fLIKtbNhgc/b0I9tptLZA==;
From: "Michael Haener" <michael.haener@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Haener <michael.haener@siemens.com>
Subject: [meta-security][PATCH] tpm2-openssl: update to 1.3.0
Date: Fri, 14 Mar 2025 10:23:23 +0100
Message-Id: <20250314092323.8659-1-michael.haener@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 09:37:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1206

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 .../{tpm2-openssl_1.1.1.bb => tpm2-openssl_1.3.0.bb}          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-openssl/{tpm2-openssl_1.1.1.bb => tpm2-openssl_1.3.0.bb} (78%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.1.1.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
similarity index 78%
rename from meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.1.1.bb
rename to meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
index b676871..ed756b1 100644
--- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.1.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
@@ -1,12 +1,12 @@
 SUMMARY = "Provider for integration of TPM 2.0 to OpenSSL 3.0"
 LICENSE = "BSD-3-Clause"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=b75785ac083d3c3ca04d99d9e4e1fbab"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=3f4b4cb00f4d0d6807a0dc79759a57ac"
 
 DEPENDS = "autoconf-archive-native tpm2-tss openssl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "5a9bb0c6c61d026272b8843cbc291b5dfa9a55c1661a513b1c980807ad2dad01"
+SRC_URI[sha256sum] = "9a9aca55d4265ec501bcf9c56d21d6ca18dba902553f21c888fe725b42ea9964"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.34.1


