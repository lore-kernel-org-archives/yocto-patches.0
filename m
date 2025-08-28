Return-Path: <patrick.wicki@subset.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C16C8303F
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 13:38:05 +0000 (UTC)
Received: from outbound.qs.icloud.com (outbound.qs.icloud.com [57.103.84.156])
 by mx.groups.io with SMTP id smtpd.web10.21214.1756388279187349235
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Aug 2025 06:37:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@subset.ch header.s=sig1 header.b=KylkDlQv;
 spf=pass (domain: subset.ch, ip: 57.103.84.156, mailfrom: patrick@subset.ch)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id 7D60B1800595;
	Thu, 28 Aug 2025 13:37:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subset.ch; s=sig1; bh=FEqllfybuybNiQFwCTSJhTsSktPZctbuZ7o3srFxpzk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=KylkDlQvbMZhEzlms/ncEOVzIvGwzxONDDGhMFXNoc6NBIyUhD9hll3GRwgVH3/9TDB4RB2iO6EUIfA2Ex/VOu5Acv+RKf+M8QKXtwnfxGIZEyZ8I5zJejRLlFP9VXuue23Ya0+xa57eySzlqnAJ48M32/wm8A+oSIxg+T9wu2AedsGq9IeIBxJ+WaCG0oTOYYxPZJvZXLJZCm61QrJPp8qZNX5e/1AyKafNLzV+tJ5E84RIFV3iEz7qgwoKhF8yP7MDAEyogt7at4a2DhHLWIpnAZ2CQzoNHglQVTtocktGhVNwz+1anfALCNYpydb5uKKupHYx51QRpSJNHyyV/g==
X-Client-IP: 77.60.166.98
Received: from thinkpad.c.hoisthospitality.com (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id 4F39E18001D2;
	Thu, 28 Aug 2025 13:34:50 +0000 (UTC)
From: patrick@subset.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Patrick Wicki <patrick.wicki@siemens.com>
Subject: [meta-security][PATCH] tpm2-tss-engine: remove libgcrypt dependency
Date: Thu, 28 Aug 2025 15:34:42 +0200
Message-ID: <20250828133442.133009-1-patrick@subset.ch>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDExNCBTYWx0ZWRfX54jFvZEPAmlg
 imRJqJw2I3wrg4vziYCWROlLwXV8wVzy3zovILIcoYlu49Kgx1ynIZ/vAAvErOuZrKjUOH3dBD6
 V9teB0stfaQeYWyC8pWuGNGCZIH1OPZScrzAQ2sUFoBJOuaIMWP1LCCPOjvwebLz9mq6WvZ9Goh
 rj5F0ggNmW1CRXBdvQ7nk7bymYIUzsvPWybZKVE0p85ejSD/ptbVuwA5uEiRQs/S1r8U/gX95AZ
 QbTjnImKujBvqg9fuE7MjBRYEtmlhhHEZNhyZAwv4oT4XhuCNcNbH3sbRXbjDV+pNDm6B904k=
X-Proofpoint-GUID: ry-z9kMxUSj9hW48WjdMYWNr0sx73Ofr
X-Proofpoint-ORIG-GUID: ry-z9kMxUSj9hW48WjdMYWNr0sx73Ofr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=922 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1030 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508280114
X-JNJ: AAAAAAABoBCmcrCUQuC4q0fsKECvzj940k6ShV/P/p71TGJYn5LaN5mCME5pDYPGIcJ5wVDeUcLX/7e+1zW6F/bNiisoLUU3dsT/i6Fs7oBRPVfVztPEvaEeDllAK52sUK+Xx2Xb9R9Wy0EoVCdkqTOGTwdsdwnAoJRiQJDa7wG3ur8vG2Jkpm86SDi3m0EzfONlnNfpQeF+jrK9X7c3Wgzeky105b3MJKLlUvmRaRcyOnGvo4o3EH8EEonUDw+MH/c+F1D/JqiaQXQ4vOcKQk9HB8vi8U+4uxRtmXOFpn9Tgbtku5nAcdQ61dJmY2kxrc30Eja16WthhcxCY9DECy1ps6os1/x97MDcZn7qzsM4Ti5aWi/+17WiReKJezpyGC85/bxTloGP0VGDlKozUQD8wKjVfyRDBArgxweYB7CR/Dt3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Aug 2025 13:38:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2087

From: Patrick Wicki <patrick.wicki@siemens.com>

There is no hint of libgcrypt in the upstream code and distro packages
like Debian and Fedora do not have this dependency either.

Signed-off-by: Patrick Wicki <patrick.wicki@siemens.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.=
bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index af9dec8..6bc44ef 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -6,7 +6,7 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D7b3ab643b9ce04=
1de515d1ed092a36d4"
=20
 SECTION =3D "security/tpm"
=20
-DEPENDS =3D "autoconf-archive-native bash-completion libtss2 libgcrypt o=
penssl"
+DEPENDS =3D "autoconf-archive-native bash-completion libtss2 openssl"
=20
 SRC_URI =3D "https://github.com/tpm2-software/${BPN}/releases/download/$=
{PV}/${BPN}-${PV}.tar.gz \
            file://0001-Configure-Allow-disabling-of-digest-sign-operatio=
ns.patch \
--=20
2.51.0


