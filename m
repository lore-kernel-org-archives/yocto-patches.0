Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC0EF5842
	for <webhook@archiver.kernel.org>; Sat, 14 Feb 2026 15:44:24 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8068.1771083860544546786
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Feb 2026 07:44:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=arrkw4gt;
 spf=pass (domain: siemens.com, ip: 52.101.70.5, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIRhvLzQEk7qgF/jyK/vv/L+qj+yXoBJXv3cw7kIyp0FjQHkVGjl8iQzlP1Ays/O/EesqcwCxGyAmzMmRNsMOgxX+fFXr4rsnvqXXd21+FE9gdUD486nOTIVZ5a4qxenOPtIiWac+yxYZjdS+Mq9MUSCCr4RX8PDDhSe1PSbmIH86WOSi3Qkemq9J3nL+/I25TL2hxC7zxWR1Nj6irzEw8RCEKs8O4TOyB9HOeZKYsBcMzfNFPEc2n03RYd6Su4i3uw7sAjYbBSDId6cSIxLKdrxdZcoi/kJWN2HixENvynaV3b7BHaNfJ61/2E+t1qmTRoM+RUQd/Ah8qWAr2cklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqD7jsOl9yQuEnZrstFvVzP3pug6jSUqHnrD9egDhrE=;
 b=Owse59DeJ1lVrtD7JvGNeFnfAdK0SZZ9m4ZiEBAKsdvZ2Hg26Kw0OZqb9BaF4N9pEZD4Sqz1PVS+yOBgvfGDjcffNyu5qvTsSkgF7oLrs3U3xiRNTDDO4IqG+V3vDyVTgXkmh3RcjNll6SGnrZ2o1BuwurwhczuNgcL3jdBv7chJ9Se14sIcBJxYk5WtjnyBAkrxHUzfxD0RFU9PP5C9nApzMgggWiopDPNvGPVQpQdc0r6FJdXqh6N8eYBcbEVvykACwOqs23lkQyEL3aKZtTeRhdWnEI9d6eq1A5paArlpi2vC8lezv90csqCTeuOAUNJN20FWTP45VAT5Yiv51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqD7jsOl9yQuEnZrstFvVzP3pug6jSUqHnrD9egDhrE=;
 b=arrkw4gtaM7SbW3jxvEx2+RkSs5DrAYM6Gda0t/55Y/rzN2Dlu3wwo6JsE0Z6QjG4a29xxHzF1UpZbQ13Nk6GLE4FqMG7NEfkjJCksZPEHsi4EL7IlAvMCWtWJ/L4vg4w9EWwz1lgOYuUsQHd9ZsVHQVrthrysy997t7gA//C4kg+pmIjAkAtNkgmz+xG5o2AnjV5vYeCAkH8X2ZmSXWA3RZ1DAn4LEZJmZKbqbgguuErYzmS5Bb3beYNMDQ5RnBUYC96kjazHm2X+17vr3LlV0wjESM3rsGsM03f5CbG7FIPVSqfxheaLt+r4g4myOG8GuBrWt0pCJoebkW1L5ckw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by VI1PR10MB3728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 15:44:17 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 15:44:17 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Index: AQHcnFVuI7xjwUGxvEa9gEOPnQXAkLWCWNww
Date: Sat, 14 Feb 2026 15:44:17 +0000
Message-ID: 
 <AS1PR10MB56973CE9C11BF5E92226116DFD6EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <1893965242986680.653184@lists.yoctoproject.org>
In-Reply-To: <1893965242986680.653184@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=ecce272a-da76-45a4-ac79-e218d53f9113;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-14T15:44:11Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|VI1PR10MB3728:EE_
x-ms-office365-filtering-correlation-id: 5b6bb1b0-45d9-4df5-ea83-08de6bdfe9b5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|38070700021|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0JtzkCfNrdVlfdcZBuMh7OAd6Nmpk4dHttMOzgHcoxFJBRXI5ouPkzfrE/TU?=
 =?us-ascii?Q?5557cJWQWXI7vvR2Adiy8mTmgdIQ568Lmv2moke8kJfc3h/sM9Gfp3MArphC?=
 =?us-ascii?Q?u/BP6Aw5Ok8WjM3qUvcwQ1EehoN6dO4XXlU3wGSZnSk8Mzp2ilQ2kTcKSulJ?=
 =?us-ascii?Q?NPWiqrMkLA3WdPkn1o+BI/8qMBS0VvcnLTjkhL1DA0OmKYUxQK+QeHCPHtwP?=
 =?us-ascii?Q?6kgCWC9QUqpBJ4MoXFITSebUCt2NIZrAZJsjGqTVrsu5CiTHBR8hLuMUOs/G?=
 =?us-ascii?Q?szam7yuqpCOymChhL1NOgpdgnjZGgcnFNX7EW/aTVbJk6LutmQQdU1qUezm3?=
 =?us-ascii?Q?MF9THY5Ri/5oeZnhF11CNam0WWevzcsWWxqvQudcgzqvsJHBUDbbZWt4qLS+?=
 =?us-ascii?Q?e8LlCkaWV2k7QsJqoBrlrAF3wihyaSGIMld5pnZl/2Ewr+LnGsYz/933EwRx?=
 =?us-ascii?Q?U9xyK4Kf3OuymR5TKqHiSAuRxEDTiI/PFDIrps046Qc6FqkigMbk13v4rjEk?=
 =?us-ascii?Q?pRmD6FuC7/AF0lMdUWeuOvB31xxHTar+r3u67cbhhiZYGEN1NRjfCCwSEvIQ?=
 =?us-ascii?Q?GcdjH60kTaVRcYDOOF/kx8bxLE1rGN5N04DczD0O309xKH9Fwl/m6B0SMzmT?=
 =?us-ascii?Q?ZkPsMSaooEcsY+E184fTGa1SpEOW19DfcX47cnBObXYSkN/SonRh2kaiyNRz?=
 =?us-ascii?Q?5GA8r1H7+hAV8WfZRlVg/Bi3kNp92LfBZxQDdFCRNvUCVQEhwR56xZZ0a/4R?=
 =?us-ascii?Q?Lmo/K88P7sV/2g4HJ3xlf5o2i5Ey9auOxuKQGRJgTQFSvpCukuOwtILlfqnt?=
 =?us-ascii?Q?XJXv0TsFaUPthWxt/j4GybNWBYA4NADXmyBYXrLH02m5dGhxsOeNZeUXe+NK?=
 =?us-ascii?Q?0TDFFWBwgYNW8SD4oeq33qf04T3+KwWwYTjiFaqr0ACNk3pAvyt2ZzzZuHsq?=
 =?us-ascii?Q?eolpq4Dkc6pe2+6R/bFRRcolzMYLhpJ4YWcTX81sOlf9BmszNM+rfdGFOYLW?=
 =?us-ascii?Q?GV7oko2EddKMF90cIJFImFTutFe+Ej1zssr6Xji7/6wAK+VcGjPe53vKoeQ6?=
 =?us-ascii?Q?MLJmRPiSxK7amDUJ7N9L5QI3GYXvymI+qe1eTfbv35IwIBbt3tvGmGTTwxUF?=
 =?us-ascii?Q?SB6f/cJMCi8f+gOCJeAXNO18pvS1p/659Nm7LOXyiIEkHhdZVhiVuey2TT0R?=
 =?us-ascii?Q?JVaOADeMwnHozRV8MQKj1dNMu6u4mOBwi3WZmEe/F9G5JDidO8dCAzrsURjX?=
 =?us-ascii?Q?00654jx3KFcofpPijEgSCZnbdnxedhrCeJriRTOhLuyStVe9PVx6w9Zlzn2y?=
 =?us-ascii?Q?MzxBFP2BeRUbgWzvekrytIqovFpporHBCEJSWhfXQ2neLRUfPteOB1MgVD24?=
 =?us-ascii?Q?ZXrsmMP4n4WsqHYNHO/bbFVtfwkpvGl++Or+fuVdm3fqlr4zlLlejHNTletS?=
 =?us-ascii?Q?PJi9p8GK9fae/3dcorhjEwwxSLPkDqyliFHjWJvZwdsrJQBbFDpxJjET+tRb?=
 =?us-ascii?Q?Q90zwudaEmE0/UTl4uTPZzbcId+xYJYkQE+8zgjTsK9t3SjJ8CQF8mVURO7N?=
 =?us-ascii?Q?o5kGXStaR0X3dpwXiDnjISav+PT3yqw7A9xPyvr6?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700021)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jJVqqc6hGOUCp45vhvY+6BlkeOOzy7SFq5AuRpotWmiRSdFjc3hy3SFgsGZ7?=
 =?us-ascii?Q?6Mwrm0/Pa6RtHYjmrKsrvoq5Egzqg60DQKviPQGFLIrtAdMVUlf4EMjribjj?=
 =?us-ascii?Q?M34HruIANTTh344Og6NFOsP1QZ3Mcb5zodwenhVEoUoPGZUAeptw/rs4F50R?=
 =?us-ascii?Q?vGaZU5vDNlQWCHyEpj4PvH/VEh9G9MGjk60+4HXxGndLJKWLSABgfSuRJSV9?=
 =?us-ascii?Q?z4NnxwrHYYnJFOBPnLNDDVS9J0evjGwZPum8FdyaGTc6oJIY9s8KDAYiIEkU?=
 =?us-ascii?Q?CbOTmb1bQ7IsZHZyxEcglbBRX5N3klfHbrinGR/WHj0onzELFpffL91WT0VQ?=
 =?us-ascii?Q?Bv1QbXXx220F2OcF0xKy+A6hyw/CiYIh/oKaHf6JXlJ3mojkVAOxocsp8bKh?=
 =?us-ascii?Q?T5uE0q47oU5Fa+at38LhrszbvETGnJiNuO28Jg9Tx1gBAUqTKWYZMDCJXmgE?=
 =?us-ascii?Q?4ZpXsvBuSyEfxCSaaavkgmIDQ5TIYC70s5i83EozpK/jnzD1mvYrBkbSHMWj?=
 =?us-ascii?Q?NGCesUt410KathZVrqwIeGWocnN9b6KPwTmiEpvEXLejBQDIZe/B0P5rWZVj?=
 =?us-ascii?Q?BwG6uAVO99Jwc/ZC2u330yX/uRiC3PmOIrz9YwWrSXo12Wgo7FYqxvTyn9vh?=
 =?us-ascii?Q?jBTUannoKqUYd1PrjAO3J1PA6SnPExEiqtdmySA8q7ObbHcVhNOZWzbrfDjP?=
 =?us-ascii?Q?JxG/K1wV89LFamTkc0mhXA834TnYS1WPCppE3f/KNa3vsEY4Xo0wCFER1P/F?=
 =?us-ascii?Q?kwUKtdSmAkGIN8PdpOrj1sNWvk6uNp+Ktev8sCFMbUbTr+wET5Og53kOuW09?=
 =?us-ascii?Q?3uOiE6clSFuFIlei2QZdRUVvJo3N+HPbSGStL2tEQNX0EHKIKw78vj06rxgT?=
 =?us-ascii?Q?mi8HaVfZmGO+WRF0CyX34ksDZva0SL5WQ9WSmFMG/nfJTb/NVwxMBK0WmCa2?=
 =?us-ascii?Q?5g3l1uLxwOA+YCtRyPBiiiQSyWuflpaYdb5OCNNg19/mqA+1/cDJeoqb01Qh?=
 =?us-ascii?Q?tflawZ5ihWWnbq9QsGrNZFvhehlaP4Ok6HRM4RpFk/s+wMeG11D5MLs0imIW?=
 =?us-ascii?Q?ySZgjGUM8D3gYOR+Df3eC/9/gOzqnKkBm5LmhB4dHq3WSvAPi+Bx5KHJe9H1?=
 =?us-ascii?Q?UUTYp/BzTOUD+Gtk1GJchxgqC+8AMmSKTlGGVLDhCtQRtiqT52adGwoUzpqy?=
 =?us-ascii?Q?vh1esAlZ9hDti8zU59N9WL4ZcYNZG78ZEAc+f2s4ys1LpTFWSqGi9R9mSaer?=
 =?us-ascii?Q?+Q7UGNjQcQvgbqKlHwykpj/BHYAtv4fi/rdDb8c2uRhXTM9GRVez0bas0oXl?=
 =?us-ascii?Q?p6EVe8UW99LoEraGfEfB1HXhJlyoipH5DVmZcCUK37qfqt3HhqLe74UM4dTD?=
 =?us-ascii?Q?Ouj8L+ASX8lvBoz4MyB0ppaQjH3PNVahNd8DrrVJeERYVMk5mZRI548r0RKP?=
 =?us-ascii?Q?AwuI1XAcgpSHvjYCWhuOKTYs0RifJY5e3qegTwn8KlJNKRNLy+6OnZEd/2NF?=
 =?us-ascii?Q?qps3RwKMnO20OLauk0+A+AiYiK9EO6vMk78tsDrmaQMqVr2k0oMtOT7Xfkw0?=
 =?us-ascii?Q?qk5efF4DR3Hb3fqIQ2PT92s70A55gDL2bXIDoGVu5SR62/c8zAxQw+wwUuT0?=
 =?us-ascii?Q?Z91gGMk0cl4h6UEgQ0YR8UIzja9zzFRgcfumxB8dv9iIjNXw90VsCIBM26g/?=
 =?us-ascii?Q?tPNXtFHprgHPukDK6r/WS245NjYHOhrwj0EmJRZ7mOZ5ATO0ISFH1WsuY4s7?=
 =?us-ascii?Q?Rr/mau1lJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6bb1b0-45d9-4df5-ea83-08de6bdfe9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 15:44:17.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjTkBot+OCYaaUBmTzWxHSuiQ9KPvS9f6ZQD9xtWfEa9c/UI9NBgEq/eksUj7i2Ae8Z6qSzgI153k7mCRGCkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3728
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 15:44:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3239

This is now merged.

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Peter Marko via
> lists.yoctoproject.org
> Sent: Thursday, February 12, 2026 20:26
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go: upgra=
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
> index 4326dbe..74f8e3b 100644
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
> View/Reply Online (#3230): https://lists.yoctoproject.org/g/yocto-
> patches/message/3230
> Mute This Topic: https://lists.yoctoproject.org/mt/117780646/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


