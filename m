Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2810775ED
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 17:20:47 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19897.1773854439466452360
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 10:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zUSCiI/s;
 spf=pass (domain: siemens.com, ip: 52.101.69.32, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgluKknTa6zKRy8hO//rcdq2uj0c8q4wYVIwuabxaPfWoJbCQeSaCpFAkx5VQmKxNzPVwBFFZO3QSUpKnHpjTYZZlrjxWx+EdrAjXcXCoNIbDdHRfFXRsB27DqJ5D8H6gfHcLvU+22Z/4idf+SfqwajXB0vpcBD5tnquvgCuMY0SdeVVFxzqoZjC0wBGt7B3Z9A3AF7fwsMXqduXwYOC7/vp5sdurWKWcKrFFvCSBatC0NRrBzgQa88rZb/6fKPvfFrgcT9A+jmCMpbUzWpbSBI21DBZmuY0zz6B1pDoq0EtReZH8Xwx7BYTSCnajQSJ138uoD/+HiRZN7SfiEpkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYxb8/Ss9LbPTKLLU+DUSIoJlYt/hPGVUJbXE/YVPxM=;
 b=GwVFP3AA6ioDPt6vXIndrpjjvY8pPMQTLxlBaJRiXpjkz6u6QidQLjobzCp/NVt9WYtltv2VhjQw4V4Z2q9IbT3eK392gx37QI5bNKn2fVHBJJ5Fc4e3XKnOIOlHwYuxeHOcp6FO8fK8cAI3NNBgga8ayUdJDCSTRddfN1CtgFYWRqfwYiiTKrBWxxP3uKS9XRo6QTyY+PpNPxhXNen/3bzsn8cehTs4IQUzNTyrfz4wIjEhxF9D78HF1TZeB5W+MWDAIhBKcJKhpt+snCai52Ih1ibHNTKF69U7BMjVdxN/ENYcwY/ys6KYmswUpswchwVjaZ0vo2e8ZUYlB2sJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYxb8/Ss9LbPTKLLU+DUSIoJlYt/hPGVUJbXE/YVPxM=;
 b=zUSCiI/sS+muYBxGtKXOhRjwQr6KI/v0O1xxeQ3xeGw2g17w5L2yRwMqGstDuYGZl0ABo183BuuaNUIwhFkr3SihYRbGgEfrtAgpCnJ08yIDwZqBytcHj8fPkCGQQeSh7/TQKDgYAyUnCMSSdmhoK5hTHxdp9DpmZWsHTrj/l+4L38EJzWyaxYi9vi9f0j8P09qMeCgmT5sgbEsxbXJZs+Ag35oNPQk2of9hBH6JHVJ8D5nNsAA3cNtGhaWB7/LGChTWb/Zg5GD9qJXBqgIEIM625LLAiYqe4/qXNO3FhOz8GDzbl67TAxl/Q3WQyonsLl6YzMWUTZNl9DR2nNiH+g==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS2PR10MB7779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:20:34 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:20:34 +0000
From: "Marko, Peter (FT D EU SK BFS1)" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.0 ->
 1.26.1
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.0 ->
 1.26.1
Thread-Index: AQHcsOUG2yZgaPR1OkaRWe2ZacQJbrW0lTbw
Date: Wed, 18 Mar 2026 17:20:34 +0000
Message-ID: 
 <AS1PR10MB5697FA63D6088090E9D0B273FD4EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260310232405.1471770-1-peter.marko@siemens.com>
In-Reply-To: <20260310232405.1471770-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=3f8a4a6e-2bd9-4043-9b25-a602b530c1bb;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-03-18T17:20:21Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS2PR10MB7779:EE_
x-ms-office365-filtering-correlation-id: 6c418e19-711e-4af8-6469-08de8512aa62
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|55112099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 WMnyTz/RDsKOngFU63OqlsaLbZwT8NEF6vh+BwQEtIxgZk0QBpZao73+J5jendu2rYok03grWHbyOeQa7fW1gZi+bx/JwYNnTc0c5sYT4ws7YSe19xFg7MlN74yf+2R4L3+Wk4YM4FCJ5OR1D6povr6NMUjRrGvjAqoFTkfIWfCBtcxHaYYDGr2j3/uPHUsW/SpNg8GW1x8irRLXbkgCWnZndBpYRUb7mHHLIAA81gM+dyCskfKQqooaUBWI2f15HwR/DrjWlniv1LgVy0G8y2dOUecrIIQ8LtMd7Cx7zffD/7mYLTeEhfsr0ClKiTYrb+VMmi5TmvVX43DessHjtH9piRJJSkIyqK30YYiDStIfjYayj1QQ5QSaLkiVfyLpDLjBkG1jihv9JkRsME545Xy33QU46UJNXdur0jDlmiDtkXI/crjM3oe0DM60qaZwMk7K/LYL22Kkj+MrAZRGGRoeRpin1SdbYE5fyF8cyM+QRgBg7VxwnIKeFZX7wu8AQTPgghs35+J529tSDLR8sxpBdKmIL8WMq0qwmyckwpXseDNJsPXoRI9LCSnsFAsDqIzRhA1raAVwgqOzN4+IBf9cgs+r6MJWTM/r9OxcyrDcYuU2Evd/eb28RuDiKku3saCOGpYX9QZJjQKANHhEQYQf3l7H9P7dMqR3ArsbtUg7IZK+NfPOGXEJnn+WwxBmmGn9aLMyhjqEU4o3qdJ45vQtFnnTrtjDxKUcvYnT8AA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(56012099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nuRsZBXsnACMOByhw/0nNyM4YOosvWrmu3cyammWP23JA5rL2oou2wRbVTX2?=
 =?us-ascii?Q?MHQ8R/ZgnLj9V2cOOB3SlOHytE2PrpVfkyAAiGahIxUZqFvoXYLF6TC/zKN9?=
 =?us-ascii?Q?P6VFYXeYjTWM4L5nsH/EvgYqwUlu5rd0kJT6OmV3f1H+JqRCD7VMYF1z3ySO?=
 =?us-ascii?Q?OZanOkKPhWW449WEcQQjj5Fe1xNy6wDsn939k18BSP/k/Xx7KamGDqv4EtOQ?=
 =?us-ascii?Q?8jiXOCgXbJx1nuhnPgCSJt9CrvwAgjHhaRPp/vUVk19Tt73fl4wS00tHPOLP?=
 =?us-ascii?Q?kbb1AWA6ZrNRKd4IC4arqMUDOKqLM2bsFaFZiQ8iRoEUkCnZa9E1VAGw2swp?=
 =?us-ascii?Q?R9Gc1xozeNOo5IuxYZgTZD/Z9xOA1O4W3SHoSpY3R20bn41WzfBonZD96nFx?=
 =?us-ascii?Q?S+mGhQjUT+9+jARKqeGt4nXt5FIPxr2s7atQg3lhyp76qa3hkl1799IPqIKs?=
 =?us-ascii?Q?vLhiUlgUJ4PJfSGaaAGAEaAengRR2khhuH/J/G6jddRR1SdBZ7jqHBHMmVHC?=
 =?us-ascii?Q?5HK7NVID4PvH5UbYMhR/GSgs85Lz+SbZUgdwfdrAh4Y0163ir+ABzfP8/zCz?=
 =?us-ascii?Q?CYBHXCjrZP2egPZVIrU+anX7eaGgBfvUIe7glEdXwQtHKBeBNkTqcpMutxjK?=
 =?us-ascii?Q?da/7G4rJurp6uagp0U71lMifhXXTmKXo0w+IKh5/J/fCMiGUjfBR/s3ThE1a?=
 =?us-ascii?Q?ojv6Px2Jprx7GvwyCI6b/HgQ7A5Ut0boFMUKjzT1YOaoPS7emYD4wpg7fvJH?=
 =?us-ascii?Q?dG8RCjHB0fc3RetUmgQUIgyimklnT3lxHdxQ8Xl2trjkl6avwaOedx56Vs5B?=
 =?us-ascii?Q?NnAFCBSYDCJXfqINUtkKsW/1eYHw/GFmAj2d1A+Qm9BiXY44L/KiF8G6/CiQ?=
 =?us-ascii?Q?cRSONj+Qvrh+SDwZNpZUL24w/0POO5ZjCFiIzhUAfgVikAiQKpEa7fPwVh43?=
 =?us-ascii?Q?UMQzKBGpzh0WGprZ2Bw8fdNmkV6/7oMr/ZrYcibiq5qvygXktIeeAImDULfC?=
 =?us-ascii?Q?NJdQaH5hUGi99UY85xvz3/PCaNsJfOpvJVao50IIP7nb6jeMuVtjJ9EGTdae?=
 =?us-ascii?Q?xjeXJ+BX1Yp2XIBp+RAvE2Ewsc2KsLDVRX/7x2kpk+Kk0u6Kz9Rw94pJUZkY?=
 =?us-ascii?Q?ppNP+tLxRaSfHuBE5G1AQHWkethOavPBsqQLpBvqTOAucYXNZeqXMHMf5rHh?=
 =?us-ascii?Q?QqrIABloGwXitbXNjzIEiAzwpyR7aeYrDfg8AQFi8jqMWCSq7Y2PLw3VvK3m?=
 =?us-ascii?Q?sB8nNZlYI9azfwEugNpc2w1Ve8G8K8R76okQwPwrHK/ymT5Vuhka+YoHfwi9?=
 =?us-ascii?Q?MWvMxhXDFxEQvFve5Y4LDCC4Y3dAK0gI4X+6xK01iZPq4LIKIVPmrlK0WNOI?=
 =?us-ascii?Q?t+VSxnQ64oqNXbpvqVkwsqH176v044AuepY5kZieyLofWLerIBvrdhwzP4FZ?=
 =?us-ascii?Q?VqWM+0gMhcn4wKHfNmrB3Q3dJufP8IjFpVZ5XGgP46cC54oIjhZ0ovOrHWe9?=
 =?us-ascii?Q?aMKv6RT19cDG+RguEHW2YqCIXlf+u9b28DsJPp5zOHfIdRYe7PMXm9Yel9i/?=
 =?us-ascii?Q?xJa2mmGk2XgQp8J/Wb/aL7NrEy+wT38ov2TR2tCvbIouRv4trHFlAiL+A6Nm?=
 =?us-ascii?Q?BBOvlwTGmkIeCcaklFVAVYOpzEaYJyZPCIx44NDi2aUo0+6KTmJQXuGa+KJ+?=
 =?us-ascii?Q?XAUhggjBUEN3jJ9xZW6/Dp32ZqgcCMVhVdADmbpHTv8c4KXxClk5uVlrBcaD?=
 =?us-ascii?Q?uwV9AhjLFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c418e19-711e-4af8-6469-08de8512aa62
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:20:34.7250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGJMyp0ShisNQsPe5I2kkXkhTiT0dwTrID6yP1kAx2tudRiSP7xxE+QYUtia2F5PphOT5sUpb0S/WTR/0p2SNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7779
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 17:20:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3515

This is merged now

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Wednesday, March 11, 2026 0:24
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.0 -> 1.2=
6.1
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.26.x release [1]:
>=20
> $ git --no-pager log --oneline go1.26.0..go1.26.1
> e87b10ea2a (tag: go1.26.1) [release-branch.go1.26] go1.26.1
> e792d6aa95 [release-branch.go1.26] crypto/x509: fix name constraint check=
ing
> panic
> a761c9ff70 [release-branch.go1.26] crypto/x509: fix full email constraint=
 matching
> 994692847a [release-branch.go1.26] html/template: properly escape URLs in=
 meta
> content attributes
> 65c7d7a9fb [release-branch.go1.26] net/url: reject IPv6 literal not at st=
art of host
> e28ac674af [release-branch.go1.26] cmd/go: revert update default go direc=
tive in
> mod or work init
> 4d1051fdc9 [release-branch.go1.26] cmd: re-vendor x/tools for Go 1.26.1
> 8cce3ab20c [release-branch.go1.26] os: avoid escape from Root via ReadDir=
 or
> Readdir
> ef041913a8 [release-branch.go1.26] cmd/compile: ensure StructMake/ArrayMa=
ke1
> of direct interfaces are unwrapped
> 155c25e249 [release-branch.go1.26] cmd/compile: pointer-shaped types are
> SSAable even if lots of 0-sized fields
> c5723195a6 [release-branch.go1.26] net/smtp: prevent test failures due to=
 expired
> test certificate
> f67a1f4c76 [release-branch.go1.26] cmd/go: fix pkg-config flag sanitizati=
on
> 4659d630da [release-branch.go1.26] cmd/compile: avoid folding 64-bit inte=
gers
> into 32-bit constants
> 6fb3df88d4 [release-branch.go1.26] go/analysis/passes/modernize: add vend=
ored
> code
> 85050c90ee [release-branch.go1.26] cmd/compile: fix mis-compilation for s=
tatic
> array initialization
> 12c0690eeb [release-branch.go1.26] cmd/compile: don't drop same register =
twice
> e8df1a6697 [release-branch.go1.26] reflect: use &zeroVal[0] instead of ni=
l for data
> field for zero-sized payloads
> 167ef716ba [release-branch.go1.26] cmd/compile: rewriteFixedLoad: ensure
> AuxInt is sign-extended
> 495e6c6b09 [release-branch.go1.26] internal/syscall/windows: correct some
> enums and syscall signatures
> 29618c4439 [release-branch.go1.26] cmd/link: don't pass -Wl,-S on illumos
> c283d1f762 [release-branch.go1.26] os: support deleting inaccessible file=
s in
> RemoveAll
>=20
> Fixes CVE-2026-27137, CVE-2026-27138, CVE-2026-27142, CVE-2026-25679 and
>       CVE-2026-27139.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.26.0...go1.26.1
> [2] https://groups.google.com/g/golang-announce/c/EdhZqrQ98hk
>=20
> (From OE-Core rev: 124a43b74b7a8494dd13dac1294a237fb8a02e6c)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.26.0.inc =3D> go-1.26.1.inc}        | 2 +-
>  ...o-binary-native_1.26.0.bb =3D> go-binary-native_1.26.1.bb} | 6 +++---
>  ...cross-canadian_1.26.0.bb =3D> go-cross-canadian_1.26.1.bb} | 0
>  .../go/{go-cross_1.26.0.bb =3D> go-cross_1.26.1.bb}           | 0
>  .../go/{go-crosssdk_1.26.0.bb =3D> go-crosssdk_1.26.1.bb}     | 0
>  .../go/{go-runtime_1.26.0.bb =3D> go-runtime_1.26.1.bb}       | 0
>  recipes-devtools/go/{go_1.26.0.bb =3D> go_1.26.1.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.26.0.inc =3D> go-1.26.1.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.26.0.bb =3D> go-binary-
> native_1.26.1.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.0.bb =3D> go-cross-
> canadian_1.26.1.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.0.bb =3D> go-cross_1.26.1.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.0.bb =3D> go-crosssdk_1.26.=
1.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.0.bb =3D> go-runtime_1.26.1.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.26.0.bb =3D> go_1.26.1.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.0.inc b/recipes-devtools/go/go-1=
.26.1.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.26.0.inc
> rename to recipes-devtools/go/go-1.26.1.inc
> index 7d8a68e..2e3464e 100644
> --- a/recipes-devtools/go/go-1.26.0.inc
> +++ b/recipes-devtools/go/go-1.26.1.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "c9132a8a1f6bd2aa4aad1d74b8231d95274950483a4950657ee6c56e6e817790"
> +SRC_URI[main.sha256sum] =3D
> "3172293d04b209dc1144698e7ba13f0477f6ba8c5ffd0be66c20fdbc9785dfbb"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.0.bb b/recipes-
> devtools/go/go-binary-native_1.26.1.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.26.0.bb
> rename to recipes-devtools/go/go-binary-native_1.26.1.bb
> index 9b06301..d2652ef 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.0.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.1.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "aac1b08a0fb0c4e0a7c1555beb7b59180b05dfc5a3d62e40e9de90cd42f88235"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "bd03b743eb6eb4193ea3c3fd3956546bf0e3ca5b7076c8226334afe6b75704cd"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "3066b2284b554da76cf664d217490792ba6f292ec0fc20bf9615e173cc0d2800"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "a290581cfe4fe28ddd737dde3095f3dbeb7f2e4065cab4eae44dfc53b760c2f7"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f56eed002998f5f51fa07fd4ed0c5de5e02d51cec7a4007f771c7576620d9d45"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.0.bb b/recipes-
> devtools/go/go-cross-canadian_1.26.1.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.0.bb
> rename to recipes-devtools/go/go-cross-canadian_1.26.1.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.0.bb b/recipes-devtools/go=
/go-
> cross_1.26.1.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.0.bb
> rename to recipes-devtools/go/go-cross_1.26.1.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.0.bb b/recipes-devtools=
/go/go-
> crosssdk_1.26.1.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.0.bb
> rename to recipes-devtools/go/go-crosssdk_1.26.1.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.0.bb b/recipes-devtools/=
go/go-
> runtime_1.26.1.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.0.bb
> rename to recipes-devtools/go/go-runtime_1.26.1.bb
> diff --git a/recipes-devtools/go/go_1.26.0.bb b/recipes-devtools/go/go_1.=
26.1.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.0.bb
> rename to recipes-devtools/go/go_1.26.1.bb

