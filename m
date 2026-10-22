Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.127])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18405.1792659063636369127
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 01:51:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@phytec.de header.s=selector2 header.b=njl2zRtT;
 spf=pass (domain: phytec.de, ip: 52.101.66.127, mailfrom: l.anderweit@phytec.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY2c+A4OOgwahh33iCjFItGZTkWFtZv1kN+Ak+c7QtPy/LAoCGb1ZLR4ODk5e0KD6WnEav38IVCJRuUJe4Wvpsm/VTtL2rbNnRsWFWryWdSDnTv9/HTfv2cOvUFTiFaWQS3d15nYpPh+chRrngsp+nkgflYLRbtvKKYwvu3rRhVT/+LCAAFZJtc4o+X37+VnmYo0GbAxJ2aQ3ORL+SdtWoGPsvEJtJT22iIlsCL+a6/EVuCnRKy9X/mQPEk+RA6SSCv5kFED6SfP/+Fi35knS76FAKr3HfAfdmm71pggl0Sx2JEon5VMYVb/P9hHWKPWALeK9JspjLjiCWHK21fu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEOy22x7lBZwMhcn1BHnuHSFW/BwIcShHGxdi5+dtlY=;
 b=bbt/E9ExXQYG8apJOzfCEvBW4n0GRj5vzV24NgrGRA4Np+Asbpt1zbM4LsG6R6OsGDUlay8Xux55dTZIywUba1FZSHsMUlCSnfNlZRM7t0/fhkCvnjZHjPFeA110U0fLU4aVvd6ezzOykzz8AspKz21pJ04S3A+gRxaVuaa2r9E+xWvF/ntPM+0hf0YVIuNat4TanHFbPIemxsyQjaXgL926OEKvccGjOJVUPP+UVNhDnwi6x9wGdudJQSpsxcETeyBtVwtizfJBhfAhwZg8/rU49lMsHSWh+jWzjDLN6+lney1vggYmwyWp6AbfijeuN29rsAL3KWitxd9mLsswBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=phytec.de; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEOy22x7lBZwMhcn1BHnuHSFW/BwIcShHGxdi5+dtlY=;
 b=njl2zRtTMfq8Capw8dV64L7Ix6vsdprPfg0kdhJeoQZOcfAZh+arDe6P3dHcgUCMX9M9gi/HytkvCxguEyt+kYBAZ47DSgP74CsHh4HZx51YlTdIpG06I4o+TkpJJHLTiJjJbZrsawWt0V/M2LUw2eVFDnI00gPZFMxMrKH0W4AtGoCg+7tSglFS5ywQ1HTf6YRB3zXSiqx4QFLX3lf+84fZFj7mz4bIA60PXt05bzA/aTRIl0FySqU+JiybNEdsf5LabsOFoqdsClvTnagA1D+zcXXl2n1nD59fuHeMtwbOZ3zksMqLmAY9hKJWI13IwY6xaSFseo5RTSiFw3U4nw==
Received: from DU2PR04CA0333.eurprd04.prod.outlook.com (2603:10a6:10:2b4::25)
 by GV1P195MB2053.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:50:55 +0000
Received: from MAD0EPF000008B5.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4:cafe::75) by DU2PR04CA0333.outlook.office365.com
 (2603:10a6:10:2b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 08:50:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 MAD0EPF000008B5.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:50:54 +0000
Received: from augenblix5.phytec.de (172.25.0.69) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 10:50:53 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <yocto-patches@lists.yoctoproject.org>
CC: <upstream@lists.phytec.de>
Subject: [meta-security][PATCH] tpm2-tss: update to 4.2.0
Date: Thu, 22 Oct 2026 10:50:44 +0200
Message-ID: <20261022085044.3244953-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: L.Anderweit@phytec.de
X-Originating-IP: [172.25.0.69]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B5:EE_|GV1P195MB2053:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cb698a-dd33-4684-b0a2-08df30199509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|18002099003|12006099003|13003099007|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 47J0yC4BwDwniskXglMqoiqzI4JNnJ3YwMKOdgOFvFG+Xm2KGDJsEokYJXyeYJUIgTDEvmh2IRCsxOrQQnjJiU7FqKlyUKvM5zWnTQIANnqXUbIhmKch7Ket5DEeqy/Z9Sh22y1GwRh/p4tdysRUIJDnw/J79G3S71OVlsWRH25namCQApcM0TJXZUDgM057Wpwoe2uc51yxgF1qYxZXillvSqRrymy6kJs/C9rQq23mrKZ3IRHiXoHrlNxqs8OtrtyUPJeR4zUDDtBrmGgIrfppXHE5sv05/51tscSkg26N+ss3hBlqK7kse7kujBnPmLxbsXU3dM79KnulPn/0OYPFGyGLc9icnxP27MCg9IXJyF8QGi552RiqVK1mNfEtkycuXpE47QsCKUtdah+Sm2hejW5zxk9qrz/8pqt1Fekd67vbyzVwgsTKFAFGxBr+SnuJAookBcUMrDC1MyAoGg44A+N0etQ7ralWl+CtxdUOTr57dESJ0yvEX1v+2fyu4G4Un0mMeFTdpOA5Nr5GImOiN3iXbtVMru+R4hZxsbFrpIFOzkF6+L5+iLRT7+JjlDcr2AFUXe3JcW4F/3zStFe1GlNPp9sfv9Tup4kJh06DF55/R0mb5NY6mdaryI9u9gi1ot0w2EdHJh6CEBJDuKNHIqX703oCN1KK5F5xo5kSvRN86rz9QvPlg7MylYK2t7+66fIEPd/qohp13mgXrA==
X-Forefront-Antispam-Report: CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(12006099003)(13003099007)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TgZ9+3YHjULK6jhIXdG/Pc8BLix5MEUivMUFIopMkiQskdRwYvSD1C/cZ9Ng4gE/+E/TwM9cCVtux1nIdjdCwjGggJsvFRBwMsLfYM880J6VbVA2Uo51SiN+yjWye5k8dWlcq6ZqV7bIqnwDZ92If7gdECARxGGHVuDGhgk11JcfgfLLmTW8EruL8fZ2R1KOUDhSQoJ6zhAo/nScoCVZ5c5JeOTN6aI8sXuYttuGVpoYE80wXWX86aXZOC08kQyNwgAjYt5K4H5lDRVKdeEdtSnerHnJwEMkq4ZlVo7anuJwkBqkqznp5X228MD4CkawII0Geylp8CRFR6Z6jzFQN5VyeD838wlA/tiEaCNMNWz4upd2dco9mDjEOEqwsSZi1FyxHsuqDyLHN3dU4NfnApDx5hcUiUqmIAEA5iiHfpqfQAjP4+5VOvzn4EbljDXr
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:50:54.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cb698a-dd33-4684-b0a2-08df30199509
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B5.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2053
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 08:51:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5129
Content-Type: text/plain; charset="utf-8"

Update to version 4.2.0 and rebase the patch accordingly.
Also, remove the CVE_STATUS for CVE-2024-29040 because it is now
properly detected as fixed.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 .../tpm2-tss/tpm2-tss/fixup_hosttools.patch         | 13 +++++++------
 .../{tpm2-tss_4.1.3.bb =3D> tpm2-tss_4.2.0.bb}        |  4 +---
 2 files changed, 8 insertions(+), 9 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb =3D> tpm2-tss_4.2=
.0.bb} (94%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch =
b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
index 8822d1b3c4f7..798a0c724924 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
@@ -1,4 +1,4 @@
-From ab120a9642516cdfdae5c5b8a91e42e2c9898172 Mon Sep 17 00:00:00 2001
+From 8913c8c4b207ae6dfd3ae58d886e2074d53cc268 Mon Sep 17 00:00:00 2001
 From: Valentin Kunin <kunin@google.com>
 Date: Mon, 20 May 2024 21:09:27 +0000
 Subject: [PATCH] revert configure: add checks for all tools used by make
@@ -15,10 +15,10 @@ Signed-off-by: Valentin Kunin <kunin@google.com>
  1 file changed, 11 deletions(-)
=20
 diff --git a/configure.ac b/configure.ac
-index eb6051ea..a52c4725 100644
+index 4a1f1b022772..5a745e9c5c22 100644
 --- a/configure.ac
 +++ b/configure.ac
-@@ -663,17 +663,6 @@ AM_CONDITIONAL([SYSD_SYSUSERS], [test "x$systemd_sysu=
sers" =3D "xyes" && test "x$s
+@@ -658,17 +658,6 @@ AM_CONDITIONAL([SYSD_SYSUSERS], [test "x$systemd_sysu=
sers" =3D "xyes" && test "x$s
  AC_CHECK_PROG(systemd_tmpfiles, systemd-tmpfiles, yes)
  AM_CONDITIONAL([SYSD_TMPFILES], [test "x$systemd_tmpfiles" =3D "xyes" && =
test "x$tmpfilesdir" !=3D "xno"])
 =20
@@ -29,12 +29,13 @@ index eb6051ea..a52c4725 100644
 -      AC_CHECK_PROG(adduser, adduser, yes)
 -      AC_CHECK_PROG(addgroup, addgroup, yes)
 -      AS_IF([test "x$addgroup" !=3D "xyes" && test "x$groupadd" !=3D "xye=
s" ],
--         [AC_MSG_ERROR([addgroup or groupadd are needed.])])
+-         [AC_MSG_WARN([addgroup or groupadd are needed for install.])])
 -      AS_IF([test "x$adduser" !=3D "xyes" && test "x$useradd" !=3D "xyes"=
 ],
--         [AC_MSG_ERROR([adduser or useradd are needed.])])])
+-         [AC_MSG_WARN([adduser or useradd are needed for install.])])])
 -
  AC_SUBST([PATH])
 =20
  dnl --------- Doxy Gen -----------------------
 --=20
-2.45.0.rc1.225.g2a3ae87e7f-goog
+2.43.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/re=
cipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
similarity index 94%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
index 30e984ea48f8..0d5b36a832b4 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
@@ -11,7 +11,7 @@ SRC_URI =3D "https://github.com/tpm2-software/${BPN}/rele=
ases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
=20
-SRC_URI[sha256sum] =3D "37f1580200ab78305d1fc872d89241aaee0c93cbe85bc559bf=
332737a60d3be8"
+SRC_URI[sha256sum] =3D "b53f0c5c8c4ce17f05701a410ca9688f725ca380c9bc4640ea=
cd0eadb1fea124"
=20
 UPSTREAM_CHECK_URI =3D "https://github.com/tpm2-software/${BPN}/releases"
=20
@@ -94,5 +94,3 @@ FILES:${PN} =3D "\
     ${sysconfdir}/sysusers.d"
=20
 BBCLASSEXTEND =3D "native nativesdk"
-
-CVE_STATUS[CVE-2024-29040] =3D "fixed-version: Fixed since version 4.1.0"
--=20
2.43.0

