Return-Path: <lennart@koschick.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E60C61DC2
	for <webhook@archiver.kernel.org>; Sat, 21 Feb 2026 06:51:24 +0000 (UTC)
Received: from outbound.ci.icloud.com (outbound.ci.icloud.com [57.103.89.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15748.1771656674051561964
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Feb 2026 22:51:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@koschick.eu header.s=sig1 header.b=asIpebwj;
 spf=pass (domain: koschick.eu, ip: 57.103.89.13, mailfrom: lennart@koschick.eu)
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPS id 6E5A81800100;
	Sat, 21 Feb 2026 06:51:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koschick.eu; s=sig1; t=1771656673; x=1774248673; bh=eP5JXSL+qxqVYNLd7aavvUJRFK7x/0IZKzJJrEi7zZY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=asIpebwjTYXwdLuOMu+MnKfFR8flbdZq4K+Sgx6gwhgjknRlABzXULBKw9cJP4uLL/X55fBc80UwRaBt+5A+gyzVJpsxpfxQUhvpdUxL5DMBhk4mSNByF9LNsp5zj1MyJ6M8qj78Ud2gIlCSnMzqjQhcEbjGVPJruRdW+It+9FdZxgFBLdB0jrBB8xOXVWoOasl43hdagTuihU0heE9u4JAHZtisxTL0cnXDtaD5nIeLYWFBpNZvPLZeZbPN1WnTibOoQLCOnGVGkcLX1RHVtzqWpVc/vJgnC1bFxK7i5+/cpD+IrPZZc9QsBXbgYz/PlxbU/4qb+SJ8Ix2pY+ImRQ==
mail-alias-created-date: 1713722900379
Received: from Base.home.arpa (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPSA id 9D34418000BD;
	Sat, 21 Feb 2026 06:51:11 +0000 (UTC)
From: Lennart Koschick <lennart@koschick.eu>
To: yocto-patches@lists.yoctoproject.org
Cc: Lennart Koschick <lennart@koschick.eu>
Subject: [meta-security][scarthgap][PATCH] sssd: Upgrade to 2.9.8
Date: Sat, 21 Feb 2026 07:50:51 +0100
Message-ID: <20260221065052.5407-1-lennart@koschick.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Authority-Info-Out: v=2.4 cv=HYMZjyE8 c=1 sm=1 tr=0 ts=699955e0
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=ArOQHuw0AAAA:8 a=NEAV23lmAAAA:8 a=28AqRZ-4AAAA:20 a=W4FpkI3MAAAA:8
 a=20KFwNOVAAAA:8 a=fk1lIlRQAAAA:8 a=nWRqFRhqyQ5Abb88jkAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sD7ozVhDsUP0bFIHhcxq:22 a=f57ejr8KuCzZjB4NY26B:22
 a=U75ogvRika4pmaD_UPO0:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MCBTYWx0ZWRfX8GK0N6OBZSn2
 8nUTcl42/8jz5Wo5PW23JOLT/5pyDSwM5HRla1Gu1vjWUCJOFPM01TA/HuxJBhEF7/M4oZkQmqG
 a+KG33/ivogVo0P9priFAm3WnnkME6O+oONJl/dTxd9WAP1CxMQzYlTTbQmPdp00JIbwiymDh98
 D1ZnWIVc3vDJPZDyGltYMMlT4cX8BPFDf89UIXz42o6ez/Uv6/hPlMWPMzihaqNP04H5KoSNet/
 Ls+G9z2JFkz6cAmEUYOmHTr+4nV4CsEwkDS6Q6PoT6oEqGTWV5+n/T0MERvO6mT+zuLuPofSNbP
 gQTu52ULHNcc9BRQObcQu2A8xGptUMDah4P8pTpgsbmyN4LI1+ZVZ5lN5DghJY=
X-Proofpoint-ORIG-GUID: McEaEmtf5ZKSpAz0ouPi42FsKC9VPMkM
X-Proofpoint-GUID: McEaEmtf5ZKSpAz0ouPi42FsKC9VPMkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1030 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602210070
X-JNJ: AAAAAAAB1Bl0UWCD0l3T0rRoLNrZlU0vA2/BdOSPwKCzYyl3c25AJViS8odecIIaB4RaxyeogCg/8Nz3YLJbAo5dWggKUrqVXOFqyRu7zTj0hbpqqM9QzZKEczSmEmmgj5Z7GXN1AiEO6m1FazwU9SMLEQcvDYhOcmPvxnpGAudi2ssP8klpusg66gg9q8KuiJ3AXYcXqSdYgwifcV4wUhDmJUnVNGg08iNr550pF7NzXPJGTTZqst5sSb69nUY27wXRxCHIMdVbtY4CMviZSoPjfBaIpOr3l/akWOM2HIYnzr6ua+EqYFGclNawZmlFZ5WrKaSl6NXP5BROvcJTeLPwOFn/kuoe0qzdo58OXpHNTNKbLxQjsvJzRrfkM4LnyDpqHcwPf/tveZhQCFiEelW+kvO+zN2LU3+vyCxaN/WNO9inhXVfrhGyZRSRss0XVamPxqVOjOeLjxqM9/RJVZsr+9dFfNd0SeRxylp2WpPU9K3ZIe8pUt2DNrQKLfRAUH2MuNBW7Wkfh6zGGY2txIwoNHh+RUIB2JeIwH8GkcK4k43ebFdPxTOuEu0XkSMnr6ail3cXT3+ul3Zwf2CyasS3jTbjD2TyFEzlbhulp9c78+INM5iXcC7XrA4=
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 21 Feb 2026 06:51:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3261

Release notes:
https://sssd.io/release-notes/sssd-2.9.8.html

Signed-off-by: Lennart Koschick <lennart@koschick.eu>
---
 .../sssd/files/CVE-2025-11561.patch           | 50 -------------------
 .../sssd/{sssd_2.9.7.bb =3D> sssd_2.9.8.bb}     |  3 +-
 2 files changed, 1 insertion(+), 52 deletions(-)
 delete mode 100644 dynamic-layers/networking-layer/recipes-security/sssd=
/files/CVE-2025-11561.patch
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.7=
.bb =3D> sssd_2.9.8.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
CVE-2025-11561.patch b/dynamic-layers/networking-layer/recipes-security/s=
ssd/files/CVE-2025-11561.patch
deleted file mode 100644
index 110444a..0000000
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-202=
5-11561.patch
+++ /dev/null
@@ -1,50 +0,0 @@
-From 9fdc7f2b4ed50a5ce788a86f2a5be448668381f5 Mon Sep 17 00:00:00 2001
-From: Sumit Bose <sbose@redhat.com>
-Date: Fri, 10 Oct 2025 12:57:40 +0200
-Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IP=
A
-MIME-Version: 1.0
-Content-Type: text/plain; charset=3DUTF-8
-Content-Transfer-Encoding: 8bit
-
-If a client is joined to AD or IPA SSSD's localauth plugin can handle
-the mapping of Kerberos principals to local accounts. In case it cannot
-map the Kerberos principals libkrb5 is currently configured to fall back
-to the default localauth plugins 'default', 'rule', 'names',
-'auth_to_local', 'k5login' and 'an2ln' (see man krb5.conf for details).
-All plugins except 'an2ln' require some explicit configuration by either
-the administrator or the local user. To avoid some unexpected mapping is
-done by the 'an2ln' plugin this patch disables it in the configuration
-snippets for SSSD's localauth plugin.
-
-Resolves: https://github.com/SSSD/sssd/issues/8021
-
-:relnote: After startup SSSD already creates a Kerberos configuration
- snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plug=
in
- if the AD or IPA providers are used. This enables SSSD's localauth plug=
in.
- Starting with this release the an2ln plugin is disabled in the
- configuration snippet as well. If this file or its content are included=
 in
- the Kerberos configuration it will fix CVE-2025-11561.
-
-Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
-Reviewed-by: Pavel B=C5=99ezina <pbrezina@redhat.com>
-(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)
-
-Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e5224f0cb=
684e61203d2cd8045266f7248696204]
-CVE: CVE-2025-11561
-Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
----
- src/util/domain_info_utils.c | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
-index edaf967..5c1f050 100644
---- a/src/util/domain_info_utils.c
-+++ b/src/util/domain_info_utils.c
-@@ -751,6 +751,7 @@ done:
- #define LOCALAUTH_PLUGIN_CONFIG \
- "[plugins]\n" \
- " localauth =3D {\n" \
-+"  disable =3D an2ln\n" \
- "  module =3D sssd:"APP_MODULES_PATH"/sssd_krb5_localauth_plugin.so\n" =
\
- " }\n"
-=20
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2=
.9.7.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.=
8.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.=
9.7.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.=
8.bb
index f92fe65..9e75e83 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.8.bb
@@ -25,9 +25,8 @@ SRC_URI =3D "https://github.com/SSSD/sssd/releases/down=
load/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
-           file://CVE-2025-11561.patch \
            "
-SRC_URI[sha256sum] =3D "6b5284a4d72b67c0897699794360d79e0f67461957e20273=
c2649f025e76c248"
+SRC_URI[sha256sum] =3D "a786fef1c1929984f991747f160f4dbc3f2827d0efa413b6=
a621aff400337ace"
=20
 UPSTREAM_CHECK_URI =3D "https://github.com/SSSD/${BPN}/releases"
=20

