Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E0CFD350
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 19:12:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24996.1764011554545517331
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 11:12:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H7TBtGDy;
 spf=pass (domain: siemens.com, ip: 52.101.83.23, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzaBHnyOp5TBS2Xv9eYmrYi1h9d0+/ZAzDKR/6/pR1AscnP0yyny5Yy3FhHO/z92vQZ3BSegTkVBzJGzim0XaMTA7MBMq49+/yTeOvfoXgke+TayEQa9dKXz5BVqiyCUa+xeIjRslNta+Mk4/qyiCZXlwEpRaTL1a55mvPfqVvyfEsc/n3h7inb8DyIYPawMlPF6EHQb6vlr+gnYZ8pwb6kpvNvrr6wi5nZasTe0ceg+1eFWVnFh7Lu5cpitrWzwq/at8qvmpEq/QCueyeyez+4WE7SdhGu7ap4V9/zG7+ehou/Vur5DBYWZSNm6vqJxxgJJF6oANurrTsFqi20PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECHJ5CcdD5XDWYMmdU0CDtHvOFo6qpP/5nvHRmpORxM=;
 b=g1S2y0TojSbPPYZ9UNpz4eQ7TpFHSo1PfC9gFpb4RlUX/sRLseRPwCCeZ0Kh0IVgyET8qW65p8Yy2HScnc6Ol5Ttq4bFxNJRBrP4ZIi8AkX+Fa13pg3Q22eOtnrJjasEn7269vrycvJKvyO0JpMaCdwZ1uFumHIHK4zZcxa9/TKaRCVgjQFRiHZwY2i1qBmmAm0Bn4pFOCOUQFxs84LA2Cg3jvd8nGSU5wr1pNKZjqKtDHhfIEXuLm44Z1UUKH+GWhm1h6FUwijveVou993Y97O60Nqs00fKKkKeFo0FMqSs22A8lD7OajWASnw9W0dMaZ5m1pwJF0EJMmOv+o2XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECHJ5CcdD5XDWYMmdU0CDtHvOFo6qpP/5nvHRmpORxM=;
 b=H7TBtGDyeJ3w/QI1Zl1sSiamWLDbRjZez8/YEys9qgWyY1ncjAkBSF0EOa7+N5T7gAA8MEldP3HGnR3TFv2SQIQ1RL0MCmdnC0ZbYa6OeVw7O1tYTyfgAi+5f68LSGTOdcynBfOUHrqP27PoeEjYuTARslfwi//ilplfl/s6Ll3l7EAp0LjeF9ZTx0TJMRzL+8QxRJ1cjUp9Bt60Dvz2VQ4WfFuwI27jOY2ttHTlRzo9iko8pncnmQKjztZLdCpYlFwXwRtquOz+g4BrIIp7xV4/e3M0hYfmN3OBjGj7pZxLS6Zk0o7RZXgdsKunXlvqXZsoBbaqAjHiyRlPABrXLw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by GVXPR10MB8344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 24 Nov
 2025 19:12:30 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 19:12:30 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.3 ->
 1.25.4
Thread-Topic: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.3 ->
 1.25.4
Thread-Index: AQHcWsHQdCRsZEc8UEuImHEN15yF4rUCNv5g
Date: Mon, 24 Nov 2025 19:12:29 +0000
Message-ID: 
 <AS1PR10MB569744526A2B8BE0D87661D4FDD0A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251121083531.864699-1-peter.marko@siemens.com>
In-Reply-To: <20251121083531.864699-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=db88ceca-c8d3-40b9-8c5e-6203ea716075;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-24T19:12:19Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|GVXPR10MB8344:EE_
x-ms-office365-filtering-correlation-id: 3a528e7c-1073-4cc3-ac2e-08de2b8d6a12
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?02Rii73tgIIs6qf+TXdPhWZiD3WjZzoUb01i4FRdci0hnJrEOCi27FoKHk8c?=
 =?us-ascii?Q?ZIXOFs+aMwnXB04gy9BkDXJKSlJY/pA9Rl7OMahcSP9CuENhhiDxLHUXhqdD?=
 =?us-ascii?Q?L+CtDlRi4a3ZGyNmlw1HYIiEC+xc6640VQZeyVgxMUYpWyqeDhs2x/kB3FUV?=
 =?us-ascii?Q?K4LbikEebz/wQ8wNZ3Hb+hRoiFUShXseaF7XVjTQtevC0+DFtSakxd0AAAF4?=
 =?us-ascii?Q?2qlfWU2aHEMh5KE9wuMGwKDP/2jeHoNFpJctZ2L+NAwUxzH0iXhiWMqs06fC?=
 =?us-ascii?Q?9DtA026nk/AUDsjnruf8TTKAle8v81U3+J1L1yiVzdDTttqqQ033qI71awIo?=
 =?us-ascii?Q?Z7I7lzBGqhaadOxBcXYWioW3sYmGHoYqmlgmblHmYtARYx5w+NsxpuuT1Sen?=
 =?us-ascii?Q?ZwYnOBSXDABbAnY8tjqor+3Fs0qDmtOlgMGNOx9OFHUjD8rYu4tjKn/bba5Z?=
 =?us-ascii?Q?tMQefx6ygap+wn0ANnz3OSWP23S1KumhAtJ9rhlnYxhmh1NCOclLo6wsR5fd?=
 =?us-ascii?Q?XhjTvOQLylE66KBjdq6UpdmNGf+6LfnATuRRh786fqfI/5liTtfFDWBT8pqr?=
 =?us-ascii?Q?DmCyQQDrrmI9wal/OAsEPMgwJ/+7rkceBt84aZPG0QRoFH/SQxjyHhrQu/Zo?=
 =?us-ascii?Q?T9R87/+npmF03d9AKucVr3o/UbPpnZHZyZwRmIxRRbFndT/cRTNNuq3/Z7Gv?=
 =?us-ascii?Q?4iO4x06AI6Zraezmm7Pm1Di8ZKEfoWNXuoOthm2R4rVKelhlNzhE3DocTPWR?=
 =?us-ascii?Q?APM1IvAHrOC+XZ0r76licJ0xHHs8Is1grEjGiLqtMjUZvDfHID4YSXcjHIVo?=
 =?us-ascii?Q?GosrAo17xv2iXJ2mEDiVCSyv7RxDyaz3GExafm6gJoG9RMGxCmTW7DWj8G1P?=
 =?us-ascii?Q?nA34HZPJA/bRJe3sD9VFKuR6W7AYYXfY6TjxSaIhBlA7T12adzffDtgbI3nL?=
 =?us-ascii?Q?d7r737T7NF7cuwNhmF0FqHL2P6ubeBBwVXY3ZeD7HiGuxADedjAlRAYOU9fO?=
 =?us-ascii?Q?Dcdjts2Bpo1hcUNfydMHr8rulfLEVuSOKmpQ0Vneb2rlQQpI3fRqdF6HDDTj?=
 =?us-ascii?Q?d63VX6Yvg6wk2bfr31Fv4albSVWSiee5Tn8firXDds/WKQW5Y5S4Au+tyE/s?=
 =?us-ascii?Q?Wv1yYYDgBCQrNWnanSe4Te7WJ1K06ftFF0zW6EP3lkqZdO7aLMTm3qI7ts7+?=
 =?us-ascii?Q?Nu+Rvs8VPGu+eG0bEjkXq/cooI11q8Y92Aj1R7H1Z+19VjS4mkAmKN47W7tt?=
 =?us-ascii?Q?legQPSTTMx+V7Jj+66BR/6ufEHrkvyFUChLJxRll59gNhY+kq0i6XK09SQxE?=
 =?us-ascii?Q?vK0+YdePqe+MDCo7Ij8j4xL+iSD2gl+7pP6WPnlxCl0kmaP45ssUPZpHaNrA?=
 =?us-ascii?Q?GZNuVA9EHZZ49tEfBGAT979JPOdDBS8tUN9NfBhmMR9IMfjI/T5Ww8viJ/aC?=
 =?us-ascii?Q?KJe+O0eNley/lxcArhB3D1SYU/PpiMALOFoIF3EgymklWK6IFYm4mQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/5vOWiJdzHTJ0fn54F3Rq8rCbJetX22y5ILED/BBFGuapOeOBaMNbxSiovyQ?=
 =?us-ascii?Q?mgNeMVwiXVhfpLTTI6lkY+Gn70LJZmK0kd8mqL5mu0+fWKE58GC4Na/kk2oI?=
 =?us-ascii?Q?WwHzJyHMgNOb9UWdZEMcqei78LeQ21fX77UBQaSvtSP/5aHmT696eOvxy/3A?=
 =?us-ascii?Q?mzVLPKy2KMw3LyizKhjCuO2+zMLD429UqkXpZdmlt6bCTBey1FsbiGeGqTf0?=
 =?us-ascii?Q?DUbs1VL7QGON1ZWoOfvmGSPuQUXIde1ZUkDiDFxkyY7DKOc19Chz8vKnaIFu?=
 =?us-ascii?Q?42BYXrZf8hSMKdnPwtckVyTsulkxle8V1eEMMaEadzBU5gJKlHJlSBRuhqHx?=
 =?us-ascii?Q?dKLHmto2Jr/RX+U33pJQ9f5VrnePK0soNeNK+a2mor/7mjyCn68x0EZiqIT/?=
 =?us-ascii?Q?/fJHBwmB1ZTSv5y7uVLoEUXwp5geHtUmCtfkiJHg6NJLAFm6X6HeUJe2WnzY?=
 =?us-ascii?Q?MNOL2pIW/PmwXDB52SoEHBiGUmiU5n+O4xwhuyWemwGvw/YwlDSDNwISYMpW?=
 =?us-ascii?Q?sRXVfE/qG+vJzvBeRRwnJMNaJZw08PeNySs7qNfRlsM2KTfrA18qHDK6Uzde?=
 =?us-ascii?Q?8HVeCR6ewZLyW9xHHjIO4L2kKvKKnHzEBe2K4toARpt2NvErVcTMNcZDmS1q?=
 =?us-ascii?Q?IblhyxI1Bnk6TCSjPkojbGB2N3vactDSILdYiug8WUhURAkiZ2Hp0vqAWbKm?=
 =?us-ascii?Q?lI3TGBaLHKRdAhUP3PAn+h0UjAQWYYtB5HLSWcL/ox79HSf91ZCAJXZ5O+Oc?=
 =?us-ascii?Q?V/Q5Km13CQOPVnO8mghtIqpkEB5aRICKmB2+lmxR8qM+dqWXwJ74Oo1gBAjz?=
 =?us-ascii?Q?iQUgekUZb4Nk4npsTDMT3reZtWKG+AWE0rGcDfC/1n1633+6GXpeouzQrJ61?=
 =?us-ascii?Q?+XvwDx1xixtsZLDcDbT5mtjjdBy4hLL7tgVBVE8XSHjCTkOBhzKfdgX10BQY?=
 =?us-ascii?Q?oSWDfsntoeHPvNyvNRDq/9MuRpOpI1XgDNkKCSUnwv+FXjewzvi8dgF/oBy7?=
 =?us-ascii?Q?vXjsRgcUCHofRXOK3USYgwYQBxH9u7kPIpeWKwdruWuBgzpnyiz46UGr/kKL?=
 =?us-ascii?Q?N6jpWOwDO23ZM6lw2UpzQwej6Fgls7PgKeZhi515vRNJljlce8tzfiO0dxwu?=
 =?us-ascii?Q?NK49VtInz/LBWiFMa6aykQxhUqwl/cpgbCHwI9zwqHVu/vpHSm5LpWGZsHd7?=
 =?us-ascii?Q?oQclNrdv3IFw8CdYd7xa9CcAZtf+gsXsHt8Dth5rKX+NMEWP7aEDhLLajIYS?=
 =?us-ascii?Q?o7hCaz4pgEmPmpF4nLD+Un18Ap1z4bQPoO943UAoqRU5s5Iqk2nAcW1Eaedg?=
 =?us-ascii?Q?b5yIS4FByWaph4uA9atMyn8MZgOd57XLTmb/E2O3MSc2Wo6qmwwqjs/Q8hns?=
 =?us-ascii?Q?RJbspb0MtUKl7B7eoGtDjHtI5gGSoaxWLtPN1RDaQgqMJS/CBzgb7XeIGQqc?=
 =?us-ascii?Q?ROIjbxe9+jbZPpyFmokS8mK7w1RVtr/p2vxRMsuTGjy8RVDp+TZU8F3Jg5FF?=
 =?us-ascii?Q?5qPgdO4x34jTxxCHOq63U4z7gpaTupMt9M821tZNHR0lV3ZdAnFkUAz5EKcK?=
 =?us-ascii?Q?ojfHlUx/BqkQxa553GO0pYnK/tz1LvgScIUqnPL9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a528e7c-1073-4cc3-ac2e-08de2b8d6a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 19:12:30.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+HDpm8l0v+FeAYwb0AhdxtZWZf1zsITF24CBaNOXuTQzzxISB2WG9y+skAtMjBWsu9W6KHmvSzVQwEaDhvHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8344
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 19:12:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2703

Merged now.
Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Friday, November 21, 2025 9:36
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.3 -> 1.2=
5.4
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.25.x release [1]:
>=20
> $ git --no-pager log --oneline go1.25.3..go1.25.4
> f2cd93aa05 (tag: go1.25.4) [release-branch.go1.25] go1.25.4
> 83885f3c22 [release-branch.go1.25] encoding/pem: properly calculate end i=
ndexes
> 5ba37a3677 [release-branch.go1.25] cmd/compile: don't optimize away a pan=
icing
> interface comparison
> 8097b1915f [release-branch.go1.25] os: support deleting read-only files i=
n
> RemoveAll on older Windows versions
> 4942c74d04 [release-branch.go1.25] Revert "crypto/internal/fips140/subtle=
: add
> assembly implementation of xorBytes for mips64x"
> cd21a7b31b [release-branch.go1.25] Revert "crypto/internal/fips140/subtle=
: add
> assembly implementation of xorBytes for mipsx"
> bf95b76739 [release-branch.go1.25] runtime: use one more address bit for =
tagged
> pointers
> bbb7627123 [release-branch.go1.25] cmd/compile: prevent shapifying of poi=
nter
> shape type
> 7e049e5c31 [release-branch.go1.25] encoding/pem: properly decode strange =
PEM
> data
> f6db7350e1 [release-branch.go1.25] net/url: allow IP-literals with IPv4-m=
apped
> IPv6 addresses
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.25.3...go1.25.4
> [2] https://groups.google.com/g/golang-announce/c/tVVHm9gnwl8
>=20
> (From OE-Core rev: 116d7fc8dd940c781d5ee0801d3ddfb79a82d357)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.25.3.inc =3D> go-1.25.4.inc}        | 2 +-
>  ...o-binary-native_1.25.3.bb =3D> go-binary-native_1.25.4.bb} | 6 +++---
>  ...cross-canadian_1.25.3.bb =3D> go-cross-canadian_1.25.4.bb} | 0
>  .../go/{go-cross_1.25.3.bb =3D> go-cross_1.25.4.bb}           | 0
>  .../go/{go-crosssdk_1.25.3.bb =3D> go-crosssdk_1.25.4.bb}     | 0
>  .../go/{go-runtime_1.25.3.bb =3D> go-runtime_1.25.4.bb}       | 0
>  recipes-devtools/go/{go_1.25.3.bb =3D> go_1.25.4.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.25.3.inc =3D> go-1.25.4.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.25.3.bb =3D> go-binary-
> native_1.25.4.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.25.3.bb =3D> go-cross-
> canadian_1.25.4.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.25.3.bb =3D> go-cross_1.25.4.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.25.3.bb =3D> go-crosssdk_1.25.=
4.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.25.3.bb =3D> go-runtime_1.25.4.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.25.3.bb =3D> go_1.25.4.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.25.3.inc b/recipes-devtools/go/go-1=
.25.4.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.25.3.inc
> rename to recipes-devtools/go/go-1.25.4.inc
> index c29f4d6..f88d7fe 100644
> --- a/recipes-devtools/go/go-1.25.3.inc
> +++ b/recipes-devtools/go/go-1.25.4.inc
> @@ -18,4 +18,4 @@ SRC_URI +=3D "\
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>      file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "a81a4ba593d0015e10c51e267de3ff07c7ac914dfca037d9517d029517097795"
> +SRC_URI[main.sha256sum] =3D
> "160043b7f17b6d60b50369436917fda8d5034640ba39ae2431c6b95a889cc98c"
> diff --git a/recipes-devtools/go/go-binary-native_1.25.3.bb b/recipes-
> devtools/go/go-binary-native_1.25.4.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.25.3.bb
> rename to recipes-devtools/go/go-binary-native_1.25.4.bb
> index 79a0f5c..997c4bd 100644
> --- a/recipes-devtools/go/go-binary-native_1.25.3.bb
> +++ b/recipes-devtools/go/go-binary-native_1.25.4.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "1d42ebc84999b5e2069f5e31b67d6fc5d67308adad3e178d5a2ee2c9ff2001f5"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "68d1a08bf3567f330717d821b266a0be1c5080bd05dc238b5a43a24ca0c47d7c"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "9fa5ffeda4170de60f67f3aa0f824e426421ba724c21e133c1e35d6159ca1bec"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "a68e86d4b72c2c2fecf7dfed667680b6c2a071221bbdb6913cf83ce3f80d9ff0"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "38c8ac8463537c99fbc1ef368f243b626144446c09db71b1d20634a4237c966d"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.25.3.bb b/recipes-
> devtools/go/go-cross-canadian_1.25.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.25.3.bb
> rename to recipes-devtools/go/go-cross-canadian_1.25.4.bb
> diff --git a/recipes-devtools/go/go-cross_1.25.3.bb b/recipes-devtools/go=
/go-
> cross_1.25.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.25.3.bb
> rename to recipes-devtools/go/go-cross_1.25.4.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.25.3.bb b/recipes-devtools=
/go/go-
> crosssdk_1.25.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.25.3.bb
> rename to recipes-devtools/go/go-crosssdk_1.25.4.bb
> diff --git a/recipes-devtools/go/go-runtime_1.25.3.bb b/recipes-devtools/=
go/go-
> runtime_1.25.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.25.3.bb
> rename to recipes-devtools/go/go-runtime_1.25.4.bb
> diff --git a/recipes-devtools/go/go_1.25.3.bb b/recipes-devtools/go/go_1.=
25.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.25.3.bb
> rename to recipes-devtools/go/go_1.25.4.bb

