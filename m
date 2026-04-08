Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C1B105D9B9
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 14:13:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.107537.1775657620796007332
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 07:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HDFNliuM;
 spf=pass (domain: siemens.com, ip: 40.107.162.21, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQRKpbWV2YYg8rz3HS83G64/6xqVX10Jb6bP9evtL0IMxGi90spKySfLcaxpj+0sDTe1Usy34XOflOT3BYZDNFmLJhgNhTecWLLS9Hth3XeHSqOHycAkU30aLJojapMk0SIPeHgWXh73MbgB1g3IfSjAFKqSkeitn0qA8/rP93407msTjIMU/aTmOTFSh8Bu8PoYgZBxOlWJbjHySbInsoes6X8oTktOQRu4lcyLhLWVfXlkgsWfCOnf6IYieTB6O9unlCisfjqtVhUxnJOLJo9Ii04ILaqnKn/ueVSeSsGtepS5ooY8pJLbVJ0j8MDeeHpiUZgmbQ/91b1AwS+tbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2QIehtnf8s9sewwHH1GKZErQFJcRCyBenKP96bvehY=;
 b=W/DPnZamTxMVzj9kA0ebUqgAb9Q70cXE/s+t8+g5aXB1wwCsu6AbmZMLvwao1tUzF6iktyqPD7hK1vgTSVZHiFbA2vQ6QdGHKcZ+Cm3iAbFsRZXfB25gUxLOGspd9kqQp2jIVregZIBfzXhizyMgpEpYD/Mn7MdcnyQ7HECkrTRjN0LLIkMkQhWRLBCKi6oZba+9ccCbjb4s7cfbRcGH4Trapd/FVvWypwZ0VWyut71rUGXYdVg1n1OfOX3uODKyE5vf4Doptjm8Yhdx8J12Cbbt9pTxd0G0cQiCyxSZDp1b3gCCCF2/PrKoWSk/v+OU2paLRMNPnJ4K1WxO8PkmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2QIehtnf8s9sewwHH1GKZErQFJcRCyBenKP96bvehY=;
 b=HDFNliuMktq6KI+GZ5c8y7ADMaq01S53ttiK3e4KFP94w6ukwcQxiY6DgWaFtjgnUfUWDMYKi/I6Hb9j2awG8rbsY6WMLVdDz5gii64QrSd7be4ew2in+YsCCOK7451pqdJlq60sKzwm6Iy5cnERZpiYFICJYEEXEOIrY5/cq3Yh/mR818WicnWzzuRtDtf8jXWKd/KkE16di/SmNPvWUNLphB5yEy8/6M1UDnKUMWmbWFZladCX9IvvDIkvDmKDFejh9PIE8eiP1el1PfOJzgENWkf8SB4pauNQYW+Qhy+ku0rCU7Xd3UvwAm12N4euzx9KXxC5J0qZhnMRtaTzTw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DU0PR10MB9198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 14:13:37 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 14:13:37 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Scott Murray
	<scott.murray@konsulko.com>
Subject: RE: [meta-security][PATCH] libtpms: fix build with glibc 2.43
Thread-Topic: [meta-security][PATCH] libtpms: fix build with glibc 2.43
Thread-Index: AQHcs7RudEtUpMuQWkOuVeFbSQBPH7XVXBEA
Date: Wed, 8 Apr 2026 14:13:36 +0000
Message-ID: 
 <AS1PR10MB5697969D53B2F31FEC1BD0A4FD5BA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260314131358.318029-1-peter.marko@siemens.com>
In-Reply-To: <20260314131358.318029-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=e2858827-ba59-4613-b0de-03e0c3cb6a28;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-04-08T14:12:30Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DU0PR10MB9198:EE_
x-ms-office365-filtering-correlation-id: 5cacac5c-59ae-4363-b423-08de957906ca
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 Zcs5WpQYHbKxa0+4ssyGXpEdra75Re29Aqk/SlbHphoZL9FwI5ZOpm/eSbiifbaKR/us2dFxpmWgYhGQsApAr4wbXKbC3Y0ny2QLqC4+0BomDqAJrmN/g71pl1D3HiL6RQ1I5rcDFXfldbXNizrbHdKGcnAuqVVd29bUzegjwQIMShq5dG1fMts42jDvKjlNjHei8B9rVeItFzxKx/qB5dVemJdypMm1+tf12XT9KpziUbPe2Srn1nlFy08ngVJynbCbtrMPv2dMcfyEXjpNQEij4F1ca2wr0UQIx1Kkblbq9rAuwtFsWUOigYQOT8qzcK8qafh4cwdz6EVys72KQpSSZbh40ME2uqLEnn9CDTEH1SP05i43r92Ec0KbA6OkDH15zhKE+vGYGigb7LxDRKjGRfE0s5yWt5PkELow6FCxSeb4mQ8+tIyYvpJx39GmClRIpYLLdTCIfhM9l5afHfUS7VZEHKlF3G5L1yiokqqGM53/8hCEICqqv0bs7VR8TUmwNyAfeIJajhbPddIX2PCPTTe2ClyzT/Lj7lXrj05EQjLzYtmRceeRHkYXsF96RNeBf45NKnd7EWrQuSx4GIdXUy1Cu3zcEkqwmJz0MRtHR0awisppgHqyFMBuzdoH0VHNa6lh9bb7JXRI50oS3DYs81F9Y9uzz1AbZgr+l4wnMBA48MFCt0Fs2ni1ns3BbqeLGvME4i5R/2jYSqxjKQZT4NwyY2SNcjyun6jrKo6DVF1b/wKrQalQCSVRetA/K/2RgUElOtythy47Pt7HWue91SB9fbJ/LoJ8WQL/f4M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wrfl65B6NUgnKl1T8iHwfViw5GgHz6SCTOq2pPghbB84NqAYHVFY2JiaMsvQ?=
 =?us-ascii?Q?Vi4eFrSfaDafTdn30/4bvmewGTEQbwYunO4Rw+1VPbGjK776xKlQN2yLZmMC?=
 =?us-ascii?Q?TPBQaze3ngPe1t2rt4tBRSI7hI7H6vQcthq1OVscT/ajzb8xVREHJYPq7OAt?=
 =?us-ascii?Q?r5ysTKLtXohlYk8f7WSK14GlzI4H9+rvXOW+y1zTJEI//RD7mPk+1Ijxb4bo?=
 =?us-ascii?Q?7j8DXOmwCnTKyMWYdZrTqnsYs6ZV+Gu6N6NukLOKRaW+Tw84r5XJEZiaVjDD?=
 =?us-ascii?Q?+TlXoQhEXJiGsy7aza3JonCiqUUYTz+wqIxX1aHVB73ArhUCuyNGl0FTlf0V?=
 =?us-ascii?Q?DSdoVIxzZRabVlQ2ZxybwNBnD2HKOcZ8wmtrxPLFQOHAgEz7sukABMnV+d9c?=
 =?us-ascii?Q?Foo7ag4VX4rZD30ffcoDTwMQWm5SQaqV+LqI8EFCGVc8VzP87G0i7Grjx2Tu?=
 =?us-ascii?Q?IkHVoMtVE1cq+6eEfDbEC8dwx2poJ0Qzcq7E0doeExZuGA8zJaVqnYyAiKzl?=
 =?us-ascii?Q?N/3cyWIc/HPtYJejzxUSQchjFSKu3XHmmPOwe/mqnilBx5170g6/UX3qwvBp?=
 =?us-ascii?Q?TkeQhxUV/je8COxr9uqQmF3QCu+u4WpqXpdHrsQlCcSTqq/LXm2sA9LbR5hh?=
 =?us-ascii?Q?UhUv7ioSPvngykIUBXPa6gGBty7ey35rVvezpjEpznwtVhzBg/e5F2g5TN+4?=
 =?us-ascii?Q?YI6vB+4qvQrDgh+RGSpg7ffDyFfDJtRfsgu6VvHL4yYHhwZAsZkHgnH7yf4S?=
 =?us-ascii?Q?OHBb8wKo/upAy4YBsXE22u9sLFhh3bTsNxwJInC8uNdaYuw0OpGtKaErYI9f?=
 =?us-ascii?Q?dYd6Yf3a2VxLLDE4Zi9EehSEdgZlhjMklL816VH8IcGp25Rj91f3K6pKe6EC?=
 =?us-ascii?Q?1tcAotM6pyGEcfJQCVjzde9bH2ZqcAi3ikkuaZkfcIBW2iHVX5Nw5rMlm8qE?=
 =?us-ascii?Q?6G2j0fgAxstNpjF35q2uV3OZbDaphDjmWDc3cNQC18fBn1E19VYkGEyfiR+Z?=
 =?us-ascii?Q?DMD8md9IRbHJ1hOBiMBSc6MTjyC1hlaH86MOwvTTjcqnQqTn9Ntugp2qH9z6?=
 =?us-ascii?Q?EgRmTG95IXSMHSVI1ksot7MxofSNCJyVlh5rtO0euXRRWAOLXxJq8vmCSxiv?=
 =?us-ascii?Q?2tddmFNAk9C1haujHFElXtJS01X/Ry4oXumw6/0EJWX8H/SR3YOaej4PagoB?=
 =?us-ascii?Q?OLdA0drxkmASCWuLh/uPcROMglOtvhk3nVCXPNdxQP+462+1pZeVZ9cMOBc6?=
 =?us-ascii?Q?tHIFlJ7rwYXRz2UM6bHmUzsdQNj0Yp+qU18NxBYCauZYS+lp5RTCKIY6H4NP?=
 =?us-ascii?Q?ZSIwkJ0LC1h3pPOEQP0s+DUrwRq2ny6TShNdr7HcuL16IC83SN7QYil7qUwy?=
 =?us-ascii?Q?iMUhKi7oT/cFXFxVI+jycbYbO5A4R96tRg3W7YaLhg1PuQ81uSk59dDUdXut?=
 =?us-ascii?Q?wcjaeolIEBUZjnuZZKKMlrhitQI0HbPso8aVVGldXPh7NO5ZXohbEJ0o7/Bs?=
 =?us-ascii?Q?GgBH6eeseCgqLw4t3Xw3gPlT61b6HPNC983t6bT+NX5Opjak/yJglSHSTZ9+?=
 =?us-ascii?Q?OPhgoXjRYIvuupICu4CsuiUpJFy5GNMPz2YlgRXY7FkF8ps/YcPKN19ywVqP?=
 =?us-ascii?Q?8rw4t5bYCpFmMm6krPAr4poAHas27HeRExwhOXCuIr/WRdMMISd6Jj31YQd2?=
 =?us-ascii?Q?I0YkXwV1MACjzK0UWOR4UonOx2TA1tyaSzMgavyZ7Hx/4cY52iR3MfNYrSJn?=
 =?us-ascii?Q?j93FXikVUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cacac5c-59ae-4363-b423-08de957906ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 14:13:37.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhozBsKV1deWHgPTsiFKtLiiCenZfCTD0Of8WBgPYVkty01+pWIAOX8RTzvltu/bnHnf7Mu0JlcJUTRkCHlVoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9198
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 14:13:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3666

gentle ping

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Saturday, March 14, 2026 2:14 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
Subject: [meta-security][PATCH] libtpms: fix build with glibc 2.43

From: Peter Marko <peter.marko@siemens.com>

Backport patch stable-0.10 branch (not tagged yet).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilat=
ion-error-in-TPMLIB_GetPlaintext.patch

diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-err=
or-in-TPMLIB_GetPlaintext.patch b/meta-tpm/recipes-tpm/libtpm/libtpms/0001-=
Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
new file mode 100644
index 0000000..3a82473
--- /dev/null
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-T=
PMLIB_GetPlaintext.patch
@@ -0,0 +1,34 @@
+From a20f8b6a22f1ae60d96ae7e554f5e13dd431471b Mon Sep 17 00:00:00 2001
+From: Stefan Berger <stefanb@linux.ibm.com>
+Date: Fri, 2 Jan 2026 11:37:31 -0500
+Subject: [PATCH] Fix a compilation error in TPMLIB_GetPlaintext
+
+Fix a compilation error that newer gcc versions may complain about:
+
+tpm_library.c: In function 'TPMLIB_GetPlaintext':
+tpm_library.c:441:11: error: assignment discards 'const' qualifier from po=
inter target type [-Werror=3Ddiscarded-qualifiers]
+  441 |     start =3D strstr(stream, starttag);
+      |           ^
+At top level:
+cc1: note: unrecognized command-line option '-Wno-self-assign' may have be=
en intended to silence earlier diagnostics
+cc1: all warnings being treated as errors
+
+Upstream-Status: Backport [https://github.com/stefanberger/libtpms/commit/=
a20f8b6a22f1ae60d96ae7e554f5e13dd431471b]
+Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
+---
+ src/tpm_library.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/tpm_library.c b/src/tpm_library.c
+index f48f4fd3..7b2ea687 100644
+--- a/src/tpm_library.c
++++ b/src/tpm_library.c
+@@ -435,7 +435,7 @@ static unsigned char *TPMLIB_GetPlaintext(const char *=
stream,
+                                           const char *endtag,
+                                           size_t *length)
+ {
+-    char *start, *end;
++    const char *start, *end;
+     unsigned char *plaintext =3D NULL;
+=20
+     start =3D strstr(stream, starttag);
diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb b/meta-tpm/recip=
es-tpm/libtpm/libtpms_0.10.0.bb
index 3727bb3..7f00216 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
@@ -3,7 +3,9 @@ LICENSE =3D "BSD-3-Clause"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3De73f0786a936da3814896df06ad225a=
9"
=20
 SRCREV =3D "17f253a767f6b5b7813ae33f12bc79c479576cdc"
-SRC_URI =3D "git://github.com/stefanberger/libtpms.git;branch=3Dstable-0.1=
0;protocol=3Dhttps"
+SRC_URI =3D "git://github.com/stefanberger/libtpms.git;branch=3Dstable-0.1=
0;protocol=3Dhttps \
+    file://0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch \
+"
=20
 PE =3D "2"
=20

