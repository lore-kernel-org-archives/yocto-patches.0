Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D632103D925
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 09:58:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10549.1773827889824380805
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 02:58:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ioUoiQ90;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 975331A2EA5
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 09:58:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E1DD6004F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 09:58:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2466C10450766;
	Wed, 18 Mar 2026 10:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773827887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=NiJV1I1oQRxbgzYC3ZBiNBH/t8xdp2CjJyumYeq6ofI=;
	b=ioUoiQ900dLdNSqydgd5pKSEnDMtIAPwrjvCoibd2asDNmoxVwFHHJvBMvrOhzn6HvWWcU
	zt83LTU0gjducuUuPV/Pd4Ttrg5GWjhQ2gCbq81ZkYwLlhL2seW+G3ZGsyT4250A1uEStJ
	yvj0jC9hU0mEDxy6dB2gfgn4XfjoZPAv9ZW6sQUc5kW54o1qpvR7EDRQ9h4rmsQy8+K45g
	ZsNsEUwmx6A51ht8m2zCqIz4l1a7zjWgLKjozlWaFrdutb5/OUF13EIwmqjTaS9RdfJf7P
	nwySYNMhK8ARCND+bxJlhHxzBfa2FjFUqIWBKnOnuOpq+k3aim/K8h96Ygdbhg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 18 Mar 2026 10:57:52 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: update
 buildtools tarball to 6.0_M2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-update-buildtools-tarball-docs-v1-1-c25b8626c445@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ6CMBBA4auQWTsJYFLQqxAW/RmkpmGaTms0h
 Ltbcfk239tBKHkSuDc7JHp58bzV6C4N2FVvD0LvakPf9qq9diOW6HQmNMUHl5mDYNbJ6BDQsRU
 c1TDYXi3aqhtUJCZa/PscTPO/pZgn2fxTpw/bzKhL5hOkhCuFSGmG4/gCEjPdR5wAAAA=
X-Change-ID: 20260318-update-buildtools-tarball-docs-8677c26fac69
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=14d1Z2UU7bYhXkl9TuX0eR5cN3aIVNLYkbaV2RZMoOk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpunctNpCT6B/jMnxSFiZNaUO+94lPJoTF34LFc
 3WO+GpGsn2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabp3LQAKCRDRgEFAKaOo
 No+gD/9sJYnYT1+NVbUAWn3Ye30GHZ5CNppx7EGtLlZO6hffYtfh+67oF4/J7QdsjwKMFsjVfyD
 7REg/CsAjJ658nOAPavYpflDX/JoQhCIhIM7TLVKlxVRCMxSyeSmh1SiEVIahXcoHEWNDFFLsUn
 kQhmMkUKkYvJuwQNk+9352Uw9PpTu9YjBxOT2SBDSvjisLP6OX2BnhdU8WCZ0aT58mZxqPOLvHg
 9KjSdwtqNeoERKt1xCEVw3g5TnDI/iMvWoLzJ27+2fLWDmLduyAP9aNsSvyM32qFU85+qdrg1u5
 klrCrdqAXG+KZQsr5CbYE2lFHK3w3U5sJvAWGHmKg6J429weHXfatp5Qdhe484BWRF4+0op+ytP
 uIkOnAAza7uzFGjagcIus/7iQqm0d2QA98i/OfVEDt55j6QQS1UFyxo35uOirNp9BdSIIEotmpF
 hG4K6S0jrF1Gl8B7UsRVhsvEXVNqFzHpZDmIccUQZeDc6l96pjuaatim3LqeqeauIINZTzQKnJU
 WRMHlFfyVcxieAcZvDqdXwWs8djwls3iXCZ7dzXYvH+0I0dEfa8iayyGhmUIFXyQXc4myJ2T6FP
 wJuxOHGUNkf/UYzIDrWbn2xPvkVFYKe1QN+pzbmUt2fPsZIfTqia1PniB+JtxNEwJORUTkqOtRY
 IJKX6d95P/fcjqw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 09:58:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3508

This will fix broken links with the singlehtml document[1].

[1]: https://git.openembedded.org/openembedded-core/commit/?id=1fdcc2fae5a8748fd0eef7d1c60fd844b9ad07da

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index cc902c6..3271328 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -26,7 +26,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
 sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
 # Modified 5.1 tools image to include rsvg, switch to next released version
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-6.0_M1/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.3.99%2Bsnapshot-6c31c2a731858108e790acaf38679a01b0d1a035.sh}
+buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-6.0_M2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.3.99%2Bsnapshot-be8cdcf13a658e9e81ff2f7b71d1c8c37a920ce7.sh}
 buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 

---
base-commit: 4f720a0d94c1281018e60b6b19102cdba98d9bea
change-id: 20260318-update-buildtools-tarball-docs-8677c26fac69


