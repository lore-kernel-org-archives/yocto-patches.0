Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD8CD3440
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:44:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.151.1777995874071490347
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 08:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=PRf1yo2e;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 036362681
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:28 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 006153F836
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777995873; bh=2n9E36Kt1lyg0V481K3Gz0vdylQQVb8ENLSxe2UAK3Q=;
	h=From:To:Subject:Date:From;
	b=PRf1yo2eg58Dn2EAJ4nMtD9ITg/ZYVRzseCUGvQuCKzj0U+CiHHdbuvOFhuPfBo4A
	 /KM6rNLcun1N7nIKIpkLW0jCvT/3DE7+zwEcuKHtqDcVKo0+GZy/9pVh3Dlochic/z
	 V1rv5ej1kBRAfIGPydS18lvXD6QRFfNzfB5dL+f4=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-security][meta-parsec 1/3] parsec-service: assign PACKAGECONFIG in one line
Date: Tue,  5 May 2026 16:44:21 +0100
Message-ID: <20260505154423.535572-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 15:44:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3916

By :appending the TPM option we make it impossible for distros to simply
assign to PACKAGECONFIG.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../recipes-parsec/parsec-service/parsec-service_1.5.0.bb      | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5=
.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index d88f1b2..c5f9978 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -16,9 +16,8 @@ SRC_URI[parsec-service-1.5.0.sha256sum] =3D "819f1f658a=
1c62fee1b4986fe33232d5dc539
=20
 B =3D "${CARGO_VENDORING_DIRECTORY}/${BP}"
=20
-PACKAGECONFIG ??=3D "PKCS11 MBED-CRYPTO"
 have_TPM =3D "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'TPM', '',=
 d)}"
-PACKAGECONFIG:append =3D " ${@bb.utils.contains('BBFILE_COLLECTIONS', 't=
pm-layer', '${have_TPM}', '', d)}"
+PACKAGECONFIG ??=3D "PKCS11 MBED-CRYPTO ${@bb.utils.contains('BBFILE_COL=
LECTIONS', 'tpm-layer', '${have_TPM}', '', d)}"
=20
 PACKAGECONFIG[TPM] =3D "-F tpm-provider -F tss-esapi/generate-bindings,,=
tpm2-tss,tpm2-tss libtss2-tcti-device"
 PACKAGECONFIG[PKCS11] =3D "-F pkcs11-provider -F cryptoki/generate-bindi=
ngs,"
--=20
2.43.0


