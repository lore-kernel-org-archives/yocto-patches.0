Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8012CEF5845
	for <webhook@archiver.kernel.org>; Sat, 14 Feb 2026 15:44:54 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8078.1771083884134697351
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Feb 2026 07:44:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UI/aurfs;
 spf=pass (domain: siemens.com, ip: 52.101.70.41, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRCnXiV3QQHC0IiTktoDV6nKrZ3Nfj3ZyMTvnGxyMxr5XatNgV+NW70b/NZH2ZNK8og/r4GbU6UPlZmjgO4M8Ox34+04odOCp4NewaHQvzZg5oBKFIIQXp2cAcAE+K4LpfrKNue5s3sWCOwjkh5OH03WKmcTcXxjKM+BkBqfzwebjav1p/AysM/TMhfNU1QaSxHGHwbeYUlyte2FpndLaYhVqd8FbgEARABaTgsg7zvoQWn4kU03Z6Ofp/A9q0nyxipwgc2gTu96pvOjwLjBPRQVIvBiqqfi4jWJiHZKqlmA/0RgH13/iSn31m9iIMnnykb2gqTLf5toWquntXZvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwR2BSch4GchfwM0H9ZbfdQILRVG4fhifLDnsqnxNCY=;
 b=i8w6pzJynyBMxuTOq8W3c/OKpI6BM4DdKMI557VnDnrr2ShOcy/qlJxzRoZgpTKscp9S/4EkC7zgTS4ymWVN11NM93jmpDIemMctqXr59KVrUR6vAwhnXAc0gQ+BoKClNOfNyMNV9f5/tLy+8ODsJeyAnA4hdPWlx6b7h5BZdmrbdJcftGK2OJ/D2XlpGWIbVBDLOrMXuHK0WQM0qI7z0qbb+4S3/cSQOFcwRfQkLOICQIXD9yC7SU9ec+Cd+BFvR7hb6aTBGnZGOO3VeIzAd8axLqfrncd0ZWIWhsPZ66CjkLLHUsmahVqDqCz7HXuoFu0skj70LwZqByW+Fvq9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwR2BSch4GchfwM0H9ZbfdQILRVG4fhifLDnsqnxNCY=;
 b=UI/aurfsoel/7B4CDWHBE/hSsPTM+sbTQP/WBlcnstl7EI/dlwf/W7FmlSzqt3g3mi6zGtroFW4z2ZaZTzgM2SXP/LQeJdJ89G165d2kRNAerA1oz7hXbxwvdkgAAvi9eShLjc8fNoT9dyzcFXe1HGljMc1iDaEIO0XbJVT4k60zh57JvdCnDESjRT2ypOwOqgYbdHVLjDx8QfmBbHhr/YkEGwZDm5k6DSWydTrNo0piaENgTpnIqkoRvoO6gE+ktpxkWUMp6zAHsGMvh6DggXSUPnecLvR4OTtVg3OVBf+rBmUbVX6EkXlIDKq637Qj04LCZnzfZ3iV2YkkOLLu7Q==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by VI1PR10MB3728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 15:44:41 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 15:44:41 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Index: AQHcnFVyhXoddl593UqN8SeRGKH3UbWCWPwA
Date: Sat, 14 Feb 2026 15:44:40 +0000
Message-ID: 
 <AS1PR10MB5697F0D0732F502474E84B9EFD6EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <189396539B11C41B.4089548@lists.yoctoproject.org>
In-Reply-To: <189396539B11C41B.4089548@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=16d95f32-7124-4bbe-a292-053094119d18;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-14T15:44:38Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|VI1PR10MB3728:EE_
x-ms-office365-filtering-correlation-id: 96c37b7c-d162-49a5-854c-08de6bdff7b8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|38070700021|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?escCqBdJYEcMAXkCDMGK13HKAbJj1yT6MjOKhiw5YdErVLvJLG+jMqJ1AdLj?=
 =?us-ascii?Q?Z7rpQiPkYw6T4YAOtOtXZdbZ4AdkrHPzEWiqeJZ5MscIoZ9KxFZ30rNo3CzE?=
 =?us-ascii?Q?uT0DsdXBIyC9kn81BcGwSfd/DWPpYshXtSIGRqjCIcqO3xhV77W8kyOlgGo0?=
 =?us-ascii?Q?b6XopO8+mPWQ83D5ZCyWW+cpMlJ/Uac6rTo/LhiKWf99vhQh5qt0A9td9Fd6?=
 =?us-ascii?Q?P4MwmBnXbdK9dzhTMXyOiDwvHZ07BOUTGRQWLzXL0vq06eK5i4A7mzKtBWks?=
 =?us-ascii?Q?w/9RlYHG7+Y0YpbJd/klaPHnxmKvoIRZta1iRm1xHv99JA8CNNWd/Pkwe4tI?=
 =?us-ascii?Q?dfV/9Z/Ki/ayhRPzD4WiVhKhJa6Vl0ee9lZuP8R9HmzzZ1VytVsDB1lK8D3l?=
 =?us-ascii?Q?5mB6xomJAyAuuXV4HKsrxOPho/DzgKcDwaVHKKj5DHpXH084pTOq9C0yJ17p?=
 =?us-ascii?Q?6wXy0M+R43ShoEuE3vg6THc2IxWmzxqB25vYziLU3nF+wYwihAABUajB5bta?=
 =?us-ascii?Q?iQ5H7XJlAGbeULRlO6Jj1D1mzkCii2KlfKsyrT+T55c56sZ3aTQVD40aDIXT?=
 =?us-ascii?Q?fHkZyOcTdfOLa/WMUNfBlMSHuN50GB1ma1LY9LdrtBo+HX8dGwK/OmM+y7ej?=
 =?us-ascii?Q?igpp01oUpYiW8stK77rb6iJP9twPR7YvtqfXIf9kmS74uOvCiL7NbzDViqVx?=
 =?us-ascii?Q?Cq9pwJxvPGWx4XmFlMMijO4jooQkGY1kBEwot8LqkKRENectyAY69CdDEIil?=
 =?us-ascii?Q?RIKZ61wzl1iRYMt75O4n6FOSzde4lLxWFOkh4tpsW8wfs0btk27rw2hSIMJB?=
 =?us-ascii?Q?WtXpoJb8ZxHAhQy1LpB/Wh4q74MTIMAchz0T3FtMXN9LXmWtqWanxHwy4qSi?=
 =?us-ascii?Q?s3bUJV5lOGtNQNX8l7gAIlL/rQMc/8GcUmlPSBbh5OkS6/EWQQwyBEWqDQcp?=
 =?us-ascii?Q?2oGYOITIWtgPm0HrF9B4UkQoOycekdbui659swWfDGeDr8VXGrlduxAqDVWe?=
 =?us-ascii?Q?PVrn9WiBP159wuF8Lr4KUmyQxLGypR9VcT7g79tWTiUoQPA0F+TgUay/LGWf?=
 =?us-ascii?Q?NaDjrH/adPVXcpYAHgZcMwps/Al4r8sRDDul0GhFwLN8HRdYAw7YGbYKgx3W?=
 =?us-ascii?Q?g2DrKdo8F4A9tdusmuyYTe3J7Qhzt/WPgH5Zq7YGeDrxoTAUdDgNWWlnZu6K?=
 =?us-ascii?Q?3X/hNW3LliPN8VLJfjViRDkWnlfMxr4ouFMFYN8ABFwNzVKWDAkGiV+1mLGE?=
 =?us-ascii?Q?DY99DtQkjW7tAGO+bk0kZeFAim1wxAvdcj54/HygbZ7FKRNlW7qxb8bFn1MW?=
 =?us-ascii?Q?CmnGCDbwsilfxL7bc8fkCKPNgvkkxiXSuDDZboAyja/pgovWo1pQovNBOKIU?=
 =?us-ascii?Q?NVtCoRoat2OiYqIKQbkY5eiiHQ+JQN0a0JLekZ7cov8TslJXKhK4Q8zERX9k?=
 =?us-ascii?Q?mfctgkINKidlVxCUbK2gUTofPX24oLB8Ao35OGpkukiFFl2fXdz9JepTmqhg?=
 =?us-ascii?Q?NVSrhFgjP2rrPcDnwAIwAtEEWJqmYcnpdiv9/kejmMUyjH1eoDMVcrH9iA9H?=
 =?us-ascii?Q?Uw8YXY7xlq6w7CvxVhfUSZcRMGaUxS4kUJIjtDEV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700021)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lVaSX5X+EvJmF0xbsp2K6JrczM4/UKVWSy7HTwg4ti6x/nz+iIsdwNMrJQtK?=
 =?us-ascii?Q?LLdSGC9YNslJDXcswELdqSyPcK0fDI/34oDPDMqe3YnC8/0xL2gk9ousVKbb?=
 =?us-ascii?Q?qEV6OSY9uWAYhoYwiJqlgYsLWdsVkhVtmMl6G+yAx0KX2ZaLBTCiYHVSNGy6?=
 =?us-ascii?Q?gvoxPwRZTk07vqA1QJDnmL3/9xrf11W9FfxOGQ05KL62p6ty/Xz266bbwX+G?=
 =?us-ascii?Q?94k+Y7joyh6xA+3VyDebG6TT600Axq62y7BLKpBpP9AiXqP+baicc0gwtS3S?=
 =?us-ascii?Q?MeSsoIx3nIBBeYJR8q7tDf1CDDyLA6io6XHjDlvqeVz4QenH++YZf4KjGpDf?=
 =?us-ascii?Q?Yd4IDDP5DewwzC7vtk1mzPoON49ut3vHeiyQ/DypY6MRD4MUQ1lohSBsfMNq?=
 =?us-ascii?Q?8YdgNcAB2hIXVsJnYzjOGYN+ywpQPtEuUlDGJ6iUlnxXjWfCmMFioHr3BnnC?=
 =?us-ascii?Q?UXbX806HVOS5lpfMhhPVRahHBJx9qTfIsFPbUed3LrYOStOJK1ff0oxybhAS?=
 =?us-ascii?Q?a9SaKI8f5qeET3ZF4kFfm9R0bDfBz/bMhcAtGZAx0y8Fs+PqJNeA8fIbgjL1?=
 =?us-ascii?Q?fsNR19vHUPElV7tm5lzMdY/OkdjdZ88ZSzFlUJ3+pdRimG8R6eVsDHcOJvzh?=
 =?us-ascii?Q?V9PBCBgZLg2AEPsbBFnjQkzFiy8bknV+5OIvikI0lEktcN/lEyAoXBoqaQDG?=
 =?us-ascii?Q?hyXWnJTAsftZJJGdQIZXuZ0xXPQtpHcXrGTHEdF5u3xXbjblb7CMY69iz5u9?=
 =?us-ascii?Q?kT+ywtXK6kz3oE31sLgsBl4C7EpDXMtKEQvXpxZaclrBQrkE5b6PiBkIlXJi?=
 =?us-ascii?Q?B982RvBefrE1oQzY6BPxBPt6VJJsjWWgTeIiRvWrS8OBUEENVeNWaCt6jseU?=
 =?us-ascii?Q?nNV6XhN/+QD/E2qQMF1NSgI2qJH+2KxpNzvucO+vi7608CRiLNpOBv+mzZtM?=
 =?us-ascii?Q?0eVnMTpuvUxmM2We78IXfLguuvmqeA2mcdP/LEKz6YsDblmHT7oEqxEV5epS?=
 =?us-ascii?Q?qonb1GGuf2+M1VyFvo0cveBDimlmtYrQB0N/XzK6d6l23NFZM5OYeLF1pXwg?=
 =?us-ascii?Q?8TsIWCt3FufEt9wmKa6c/4yIcgVZkbCUK2I4gRRWvLHQzCqqoTKV945PIJR8?=
 =?us-ascii?Q?yBQ6/0XLE0FApbPPWbBe3Dpin7/YlYRU60RzfNQzkyaSFMv3GydXDv+PyXWh?=
 =?us-ascii?Q?lQHdJGG71h6Klq24e6H8Yiu/AZ8P95wmRAR7+pUolrFm8CtXuN7GY7lalwEx?=
 =?us-ascii?Q?a/MZZLCE2VdJhojPMpWt5tEL6ejmsOmcR/ofN/InlvouplkfFPA58oFQsHR5?=
 =?us-ascii?Q?YGGF7dmvgL5o7gnyBqWD8YjZEXwYl/sXM8fcNlm8hVWyGc+Uzdkqt+6W9jMY?=
 =?us-ascii?Q?VlMDBkeM9Q05pFHyrwSv8yCGnnN3WYgN365/XWcYXnWxq/4aez0ufZnmbAoM?=
 =?us-ascii?Q?F0B0fGGkKWuUBNXiK+NXIuhn+OeAUouaRS4KyKi+amwxgsrpUWzlbe/2HrbL?=
 =?us-ascii?Q?FOAHNlNMahuk37fRbpBvAhqWM2BahwuKt27LinnujGOMA7Cs48+/81IUXKFs?=
 =?us-ascii?Q?G8LB5DQLtZP2oMN+QJedJaOjZYX14dW8xhqoJVLp2cEvOpgJw/mn8vyCwby+?=
 =?us-ascii?Q?+dhgXr012LENQyqgiDqDVPECNZqE77clv8NjWHbsGwogju3I0Gmwpgus9fwf?=
 =?us-ascii?Q?KMAmOu87Pltc4pTvFiWyKksmc2vhmv3Ds4qlTmFwXAoy2d2jtMDBu7I7vRvf?=
 =?us-ascii?Q?O2J68N54KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c37b7c-d162-49a5-854c-08de6bdff7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 15:44:41.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxoNFXSTWQgJEZ53Zlg3KFzZHhgbWeJX/TeTsvWS75Xy9Domaqo7GvayPDhE7lOJqh8DvgLa6GkYp5pBqTh7lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3728
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 15:44:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3240

This is now merged.

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Peter Marko via
> lists.yoctoproject.org
> Sent: Thursday, February 12, 2026 20:26
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go: upgra=
de
> 1.25.6 -> 1.25.7
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.25.x release [1]:
>=20
> $ git --no-pager log --oneline go1.25.6..go1.25.7
> eaf3bc799a (tag: go1.25.7) [release-branch.go1.25] go1.25.7
> c7d189e65c [release-branch.go1.25] crypto/tls: document resumption behavi=
or
> across Configs
> 4512014530 [release-branch.go1.25] crypto/tls: revalidate whole chain on
> resumption on Windows and macOS
> d5987bff8a [release-branch.go1.25] crypto/tls: check verifiedChains roots=
 when
> resuming sessions
> c2d04c0994 [release-branch.go1.25] crypto/tls: add verifiedChains expirat=
ion
> checking during resumption
> 6b1110a40f [release-branch.go1.25] Revert "crypto/tls: don't copy auto-ro=
tated
> session ticket keys in Config.Clone"
> 0765a9d624 [release-branch.go1.25] crypto/x509: fix single label excluded=
 name
> constraints handling
> b19100991a [release-branch.go1.25] cmd/go: remove user-content from doc
> strings in cgo ASTs.
> 738bc3a33c [release-branch.go1.25] cmd/compile: during regalloc, fixedreg
> values are always available
>=20
> Fixes CVE-2025-61732 and CVE-2025-68121.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.25.6...go1.25.7
> [2] https://groups.google.com/g/golang-announce/c/K09ubi9FQFk
>=20
> (From OE-Core rev: 7a5237b7ae557136eee9ff3f98e2b0a74f39ebb7)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.25.6.inc =3D> go-1.25.7.inc}        | 2 +-
>  ...o-binary-native_1.25.6.bb =3D> go-binary-native_1.25.7.bb} | 6 +++---
>  ...cross-canadian_1.25.6.bb =3D> go-cross-canadian_1.25.7.bb} | 0
>  .../go/{go-cross_1.25.6.bb =3D> go-cross_1.25.7.bb}           | 0
>  .../go/{go-crosssdk_1.25.6.bb =3D> go-crosssdk_1.25.7.bb}     | 0
>  .../go/{go-runtime_1.25.6.bb =3D> go-runtime_1.25.7.bb}       | 0
>  recipes-devtools/go/{go_1.25.6.bb =3D> go_1.25.7.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.25.6.inc =3D> go-1.25.7.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.25.6.bb =3D> go-binary-
> native_1.25.7.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.25.6.bb =3D> go-cross-
> canadian_1.25.7.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.25.6.bb =3D> go-cross_1.25.7.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.25.6.bb =3D> go-crosssdk_1.25.=
7.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.25.6.bb =3D> go-runtime_1.25.7.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.25.6.bb =3D> go_1.25.7.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.25.6.inc b/recipes-devtools/go/go-1=
.25.7.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.25.6.inc
> rename to recipes-devtools/go/go-1.25.7.inc
> index 2c31c4a..ab58f71 100644
> --- a/recipes-devtools/go/go-1.25.6.inc
> +++ b/recipes-devtools/go/go-1.25.7.inc
> @@ -18,4 +18,4 @@ SRC_URI +=3D "\
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>      file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "58cbf771e44d76de6f56d19e33b77d745a1e489340922875e46585b975c2b059"
> +SRC_URI[main.sha256sum] =3D
> "178f2832820274b43e177d32f06a3ebb0129e427dd20a5e4c88df2c1763cf10a"
> diff --git a/recipes-devtools/go/go-binary-native_1.25.6.bb b/recipes-
> devtools/go/go-binary-native_1.25.7.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.25.6.bb
> rename to recipes-devtools/go/go-binary-native_1.25.7.bb
> index 261f7dc..ec6fa10 100644
> --- a/recipes-devtools/go/go-binary-native_1.25.6.bb
> +++ b/recipes-devtools/go/go-binary-native_1.25.7.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "f022b6aad78e362bcba9b0b94d09ad58c5a70c6ba3b7582905fababf5fe0181a"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "738ef87d79c34272424ccdf83302b7b0300b8b096ed443896089306117943dd5"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "bee02dbe034b12b839ae7807a85a61c13bee09ee38f2eeba2074bd26c0c0ab73"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "12e6d6a191091ae27dc31f6efc630e3a3b8ba409baf3573d955b196fdf086005"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "ba611a53534135a81067240eff9508cd7e256c560edd5d8c2fef54f083c07129"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "42124c0edc92464e2b37b2d7fcd3658f0c47ebd6a098732415a522be8cb88e3f"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.25.6.bb b/recipes-
> devtools/go/go-cross-canadian_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.25.6.bb
> rename to recipes-devtools/go/go-cross-canadian_1.25.7.bb
> diff --git a/recipes-devtools/go/go-cross_1.25.6.bb b/recipes-devtools/go=
/go-
> cross_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.25.6.bb
> rename to recipes-devtools/go/go-cross_1.25.7.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.25.6.bb b/recipes-devtools=
/go/go-
> crosssdk_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.25.6.bb
> rename to recipes-devtools/go/go-crosssdk_1.25.7.bb
> diff --git a/recipes-devtools/go/go-runtime_1.25.6.bb b/recipes-devtools/=
go/go-
> runtime_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.25.6.bb
> rename to recipes-devtools/go/go-runtime_1.25.7.bb
> diff --git a/recipes-devtools/go/go_1.25.6.bb b/recipes-devtools/go/go_1.=
25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.25.6.bb
> rename to recipes-devtools/go/go_1.25.7.bb
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3231): https://lists.yoctoproject.org/g/yocto-
> patches/message/3231
> Mute This Topic: https://lists.yoctoproject.org/mt/117780647/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


