Return-Path: <anton.antonov@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FFC3DA6D
	for <webhook@archiver.kernel.org>; Mon, 19 May 2025 08:46:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.46666.1747644374104563341
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 01:46:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: anton.antonov@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA361655;
	Mon, 19 May 2025 01:46:00 -0700 (PDT)
Received: from atg-devlab-kelpie.cambridge.arm.com (atg-devlab-kelpie.cambridge.arm.com [10.2.80.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47B4A3F5A1;
	Mon, 19 May 2025 01:46:13 -0700 (PDT)
From: Anton Antonov <Anton.Antonov@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-parsec][master,walnascar][PATCH] parsec-service: update PACKAGECONFIG options as lists of cargo build features
Date: Mon, 19 May 2025 09:45:53 +0100
Message-Id: <20250519084553.2027324-1-Anton.Antonov@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 08:46:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1561

After commit 7a2b9acef2 "cargo: pass PACKAGECONFIG_CONFARGS to cargo buil=
d"
we don't need to include Parsec cargo build features into CARGO_BUILD_FLA=
GS.
Let's update PACKAGECONFIG options as lists of features.

A small fix in readme.md as well.

Signed-off-by: Anton Antonov <Anton.Antonov@arm.com>
---
 meta-parsec/README.md                             |  4 ++--
 .../parsec-service/parsec-service_1.4.1.bb        | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 785c932..90decaf 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -112,7 +112,7 @@ You might need to change permissions or add the accou=
nt into `kvm` unix group.
=20
 - Add into your `local.conf`:
 ```
-INHERIT +=3D "testimage"
+IMAGE_CLASSES +=3D "testimage"
 TEST_SUITES =3D "ping ssh parsec"
 ```
 - Build your image
@@ -129,7 +129,7 @@ bitbake <your-image> -c testimage
 - Add into your `local.conf`:
 ```
 DISTRO_FEATURES +=3D " tpm2"
-INHERIT +=3D "testimage"
+IMAGE_CLASSES +=3D "testimage"
 TEST_SUITES =3D "ping ssh parsec"
 ```
 - Build security-parsec-image image
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4=
.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
index 49467cd..baa02fb 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -21,15 +21,12 @@ PACKAGECONFIG ??=3D "PKCS11 MBED-CRYPTO"
 have_TPM =3D "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'TPM', '',=
 d)}"
 PACKAGECONFIG:append =3D " ${@bb.utils.contains('BBFILE_COLLECTIONS', 't=
pm-layer', '${have_TPM}', '', d)}"
=20
-PACKAGECONFIG[ALL] =3D "all-providers cryptoki/generate-bindings tss-esa=
pi/generate-bindings,,tpm2-tss libts,tpm2-tss libtss2-tcti-device libts"
-PACKAGECONFIG[TPM] =3D "tpm-provider tss-esapi/generate-bindings,,tpm2-t=
ss,tpm2-tss libtss2-tcti-device"
-PACKAGECONFIG[PKCS11] =3D "pkcs11-provider cryptoki/generate-bindings,"
-PACKAGECONFIG[MBED-CRYPTO] =3D "mbed-crypto-provider,"
-PACKAGECONFIG[CRYPTOAUTHLIB] =3D "cryptoauthlib-provider,"
-PACKAGECONFIG[TS] =3D "trusted-service-provider,,libts,libts"
-
-PARSEC_FEATURES =3D "${@d.getVar('PACKAGECONFIG_CONFARGS').strip().repla=
ce(' ', ',')}"
-CARGO_BUILD_FLAGS +=3D " --features ${PARSEC_FEATURES}"
+PACKAGECONFIG[ALL] =3D "-F all-providers -F cryptoki/generate-bindings -=
F tss-esapi/generate-bindings,,tpm2-tss libts,tpm2-tss libtss2-tcti-devic=
e libts"
+PACKAGECONFIG[TPM] =3D "-F tpm-provider -F tss-esapi/generate-bindings,,=
tpm2-tss,tpm2-tss libtss2-tcti-device"
+PACKAGECONFIG[PKCS11] =3D "-F pkcs11-provider -F cryptoki/generate-bindi=
ngs,"
+PACKAGECONFIG[MBED-CRYPTO] =3D "-F mbed-crypto-provider,"
+PACKAGECONFIG[CRYPTOAUTHLIB] =3D "-F cryptoauthlib-provider,"
+PACKAGECONFIG[TS] =3D "-F trusted-service-provider,,libts,libts"
=20
 export BINDGEN_EXTRA_CLANG_ARGS
 target =3D "${@d.getVar('TARGET_SYS').replace('-', ' ')}"
--=20
2.34.1


