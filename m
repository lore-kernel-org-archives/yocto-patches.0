Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A7F459F3
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 15:18:47 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.159023.1775834316998004617
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Apr 2026 08:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qrRmmcKo;
 spf=pass (domain: siemens.com, ip: 52.101.66.26, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKIXdkg+qkPC9fT7CuntIGD3YxaZdCXs8kfrQYETSRAsOpf/ct1ASGX6JLJ7+PiZmGXMofEGkC/xGpWkDunqi9KErVAh0FgrmcypAUZ76UTGMZojauFPCbQz72inPB2jYEn4XTdCMzrwQbaFIRnvoy3SkkKrXUNQ5LE6YCmlVYkGGW+Wa13WBX++sGWdHHwasI3f5Gfjm0mZlrLCkE9HyXBHi3V/QlwQMiW9WKIQCOt+5qpo6Zg76uu5Upm8DNdYtAvbJKQD0UN16hf4Kq0+1vHomrSnvpkSt/JIzBY7vq7uCjvpmn/ucY1bvXgo4LjumuHiEjODT67ZgRkfI0suzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOVKmR6p8LK5fc/hXy37IAMf7cWzeGKGtZ6PbLdluVQ=;
 b=a+gGPZiqqCD8a5GQ7fDS5SyHtnsifZNgg3f8V1g0qAjD+XubwtxtkKwcTYykjIHijHQQOEJxcDL54AYreyzhLEpprfPM6o81YEI/5aiOXJgInFZl0xxm7Gz7dCJ0/vs8aVNMSVIAJ7EEGJ3DAuNbydbBrJVaDFZQIVQPPdX/QBT7DIDiNneP2jWTXXQkdHLVXeJ3Jla+l27jHiCl5WiAwrbTQg//M3TidNWUR5KzhY/94RyHHlyw2UQ2XEs2uDJ8sWTni9WDLcryVgnE7EgLBtgxsFUaFKMIlns2lqiJ8FitNtNbmLsbVCO5zwZsTEvqd6gj5Ra5G/JdKTEP4CSH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOVKmR6p8LK5fc/hXy37IAMf7cWzeGKGtZ6PbLdluVQ=;
 b=qrRmmcKodywICm+97wnugQc8cOvsEYT4IeiwE8cRrLqYUQde15LSbYseAJVCz5QGlxIDnc328ulA+XXfMbH2/tMFLOL8ve1xvWxix2iH9JhxWdbstIcwvgyHHP5f/Cp2mbl8AWpFpe02DyAOQG1VMlxGzE61eVuuJ+1B1Gse/+N80dNB6y+M3ZaLdW9nShYgmlXbzDGsYD7SCg3SggmF7z5uN9RNHT+VnXMBPR60k1HpArE/pGKBtxcbLEJfXXNaZg0suHaH+Wdrjo9EmWwogu9j1dbl6wGrOhF9nhg4NHPor0vfPilQzrevDypMaSc3FoAUPLveO17/N9/rS5VZuQ==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS4PR10MB5443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 15:18:33 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 15:18:33 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.1 ->
 1.26.2
Thread-Topic: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.1 ->
 1.26.2
Thread-Index: AQHcyEGlug/TrbV5XEKl/ZcXqLKOgLXYaWrg
Date: Fri, 10 Apr 2026 15:18:33 +0000
Message-ID: 
 <AS1PR10MB56975195CA6275CF51F01AACFD592@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260409165428.2968042-1-peter.marko@siemens.com>
In-Reply-To: <20260409165428.2968042-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=da5ffa46-be5a-4cac-8d4c-ee586ea439ba;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-04-10T15:16:11Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS4PR10MB5443:EE_
x-ms-office365-filtering-correlation-id: 268ad36a-2bc5-45a3-678c-08de97146ded
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: 
 8zyMxUjXXQJQePw0WVPo8d0dveXMAqC5BoOs5a5paGIB7BstAenE/th4mlvqAjVxk0TOXXsnCFH5HsU6E3Vrpe3IKUtfO6F9wEvYVbMxLDba2QCGpkVWSWKhm4JyfOiAu6JQnBvP+JPkOK46PrjqnYk3nBYrtavMpEJuRW2cenrGhNyezt5cRgYFiH944AWyReC78zPQxEx8XcXj13q1ZPUXDAMXv+UrR65mMN2bFjR7xucLXEOh4uPdLubt2GBK2EWAKQTPPEkpJQl0htmtS89gKvSWE7tYolSQerbg5ba3Y9kZtVxJoIBJjp6wi4GCQAR3O4k/Hp6A6DDEBMAJyfurS+x4wQZp920/HEvAwwQfg/+tBBd31vSU5fzoiiFF7YhEIsKBzV5QLqWWJQn17GomEsDX29nkwnK2av5yhvYE7rwRFzAQG4F8BSUOlpsWgs0sh0osDF6CyJ3i6UT4B2uwfyf9NXVPXah5J4dAghiwZJOLSmhA4NHoHnVZPX9KGjGBIPrarShNb60qwHfRq0MBblmsLrJJs+f7WammcGE8SHqrZxnqaKOZn3nuH5yXCzmR7rNLrxbhfMeK7mwTFcLQnD1yjv1eXUGu5l+GSYfGHiNcbTZEQyJBF9gv3zzl/KjpYFNiPC36NDjZveUlSq1yxznS+yhk+33PtyaMwYdyoWdZeu7qiveBur8aRmbFPI8x4fR8OZbaZpbsah0U3tV/W0u0NRSx1hP045v8wy8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DDhMP2fXorvBLqq18XsXB9GKmOvYoIwq7K2wFl7Q9h0HuhaRv/f7Es26cGI6?=
 =?us-ascii?Q?lN2b0Yl+utwoKVYPT+5TNPe6bKtZcIE7AzLRxRLc8366yAV3VRX2eAs3AsfY?=
 =?us-ascii?Q?v1rpiJkxlSj2/ccfGGqryhby+onB0ch6G3auR4QlqXFYskCLYwUJ0Qfno6ba?=
 =?us-ascii?Q?RnXb9Zpg6GsLVVqoG1gF+8CgWnl+JG6CpzoEiSAIcoGziQtng8B/cRRNgEYy?=
 =?us-ascii?Q?t8Cz68faZYCTR/vhaBS+H9lEArvNjzkcGmIwblNskUJD+2hiFaDP2nW0YjUe?=
 =?us-ascii?Q?fie+odTMyIUxKz33ApfWcf7XmRXF2eTND6bzqLTTl/wNB3+pepEXAUb3BgFY?=
 =?us-ascii?Q?kSOjvHE/frBkW0XiNq6IVHYdNm9PqJu60T4tL5vYe53ikKFZI9RG8p2pAJMv?=
 =?us-ascii?Q?Xyg9Hdten1tbWpb9Uy5JhwuTfZ5Rcb/kjLfjBa4rGcCfpNGTJ/XOzy+Moiw2?=
 =?us-ascii?Q?S3zjkJsCqJe878JpTehiTTxbDLD0YpT8Cy3qCGOVhF6Ni/5wBS2PGIpr09j7?=
 =?us-ascii?Q?9O8kDsz4ThtuB1Uc8jkyA3Sn2KAhea5k3vCLox9QB4a8uaHKIU8toeFY7/ZZ?=
 =?us-ascii?Q?fUrgJmSQuilSEf/nRbyugRPtZ07w6x6a8xS+xIsqxtH2ooPRpIf+6Q8hWqmF?=
 =?us-ascii?Q?mbSddxWYX5EOGTrdJIAiJlwlhpwQnApUeHnzmxVkAc/S3223RKJITFDvofUa?=
 =?us-ascii?Q?ZIcneA7X3AFYtRKuhpyTXWg+UyfC4nB73xzy3nHUjsX9QNraZ5yR0pkmSw7J?=
 =?us-ascii?Q?B/4kLULHOkvrAZrWCD4+I6srl0PblfTEbckKm2IwUnc7taMzjeoNAF49hJmT?=
 =?us-ascii?Q?0ThyoWp/XV1CxH/DMKCw3/OKsz91bxAacaFrW+jMCUh+dwRdrVpfCzuW1EUX?=
 =?us-ascii?Q?qkI6SDI2XDuI5SMXg1en0+YFtn214GodrHrz93yZ51fn0aOroF1hSGsHApId?=
 =?us-ascii?Q?AXvseqzKOK0KZ840pmZsT2Acv1RdOAEeb8F+WzduhOq+5+jxlMfqQoopyoOy?=
 =?us-ascii?Q?PLFs8/HUbgFnSN4r2uaoi0TXh1HJALs6fXI7Y2Z8UXZSk96T7+5J3OCSsdMO?=
 =?us-ascii?Q?K2y4bEzkXNAS5hLUm0NA/bJpGcA1d64xbUHBf2YcL80522lpYCuDFta1n92x?=
 =?us-ascii?Q?UOVfm5062YPWo85OCqMO0pb5d//Jpumd/17cNN4GjkIRH9RuVm72WhMbzpp7?=
 =?us-ascii?Q?nlJ2thef/TNXS0UpPFPA6c+9yZ5KzhOPJ8lPp0t20EuNZbdcb68LyLprl21H?=
 =?us-ascii?Q?W167hTZTE7nKSzihAy1x8oLLM7tupt6nunGitfpS5RXDBu5qs3QEj5D8o40Q?=
 =?us-ascii?Q?LvojvVzvDrIYlAttq2aAmrEzzulcNl6zEzQU7bxTstmwbnZcIhq/mx4nMf2b?=
 =?us-ascii?Q?nGT/v4PdDJ6xhk/q48mbbOHoWHqO4+EvCVYNY++VKze7jzZzjgsJD6UEhVR0?=
 =?us-ascii?Q?WrEEo2hRLLBDMDkvlje401TvxmDD9PSxmHYe1e5gGEK7FWh8K95xBdfYRRpS?=
 =?us-ascii?Q?fUAG+tw12tM+pvAtE4mvOn6DiMSCj86ZT7GHpp19VpJoozcS/0mbsBTAljNw?=
 =?us-ascii?Q?28VDRZNI8L9/XvxkZhMUZO8+F+28NVSaA2INbnl4x0rTltZM6/hva4hYZdud?=
 =?us-ascii?Q?zR88tzRvNZXLVhPj/JOXgFny9lEvyM7709BDHV49EKcHDO/wuQ80DGx0Nigx?=
 =?us-ascii?Q?+Uoky+ZiqeOS1pxxNvm05ocd76X5lBORlUPjOWkm73d5C2VjIYZhoisPEMVt?=
 =?us-ascii?Q?Y60QRQxuTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ad36a-2bc5-45a3-678c-08de97146ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 15:18:33.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3+GANGWaR8FR1oUJ9U3WC/R86unbTC2quN0WhT0oPXhLH6lkCQeSWbnPamxY4wfRGMNCQN4VczZKQa31Ivl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5443
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Apr 2026 15:18:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3687

This is now merged.

Note that this is the last update of kirkstone/go branch from me.
Last kirkstone release in openembedded-core/poky was built and kirkstone wi=
ll be EOL now.

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Thursday, April 9, 2026 6:54 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.1 -> 1.2=
6.2
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.26.x release [1]:
>=20
> $ git --no-pager log --oneline go1.26.1..go1.26.2
> 9c8bf0e72a (tag: go1.26.2) [release-branch.go1.26] go1.26.2
> 096f21b1c5 [release-branch.go1.26] cmd/go: disallow cgo trust boundary by=
pass
> 7cafb4140d [release-branch.go1.26] crypto/tls: prevent deadlock when clie=
nt
> sends multiple key update messages
> a34b5e4d55 [release-branch.go1.26] archive/tar: limit the number of old G=
NU
> sparse format entries
> c4b4bd7b3a [release-branch.go1.26] cmd/compile: fix loopbce overflow chec=
k
> logic
> 3a4577a268 [release-branch.go1.26] cmd/compile: fix mem access overlap
> detection
> ceb4da6626 [release-branch.go1.26] crypto/x509: fix wildcard constraint m=
ap case
> sensitivity
> babb1c32c2 [release-branch.go1.26] html/template: properly track JS templ=
ate
> literal brace depth across contexts
> b6176f459a [release-branch.go1.26] internal/syscall/unix: properly suppor=
t
> AT_SYMLINK_NOFOLLOW on Linux
> 917949cc1d [release-branch.go1.26] net/url: permit colons in the host
> subcomponent of non-http/https URLs
> 7b4ed1d7d9 [release-branch.go1.26] crypto/x509: fix signature checking li=
mit
> 8028a51430 [release-branch.go1.26] crypto/x509: hoist policy pruning out =
of loop
> 4ef278779f [release-branch.go1.26] runtime/race: apply LLVM zero-initiali=
zation fix
> 608303dd6e [release-branch.go1.26] cmd/link: skip special symbols for lab=
el
> symbol generation
> e27183eff8 [release-branch.go1.26] cmd/compile: fix internal compiler err=
or: bad
> write barrier type
> 98d4c11d8f [release-branch.go1.26] cmd/compile: treat all zero-sized valu=
es as
> SSA-able
> cce667a91e [release-branch.go1.26] cmd/compile: handle zero-sized values =
more
> generally
> 3206e141fb [release-branch.go1.26] net/url: reattach package doc comment
> 82b95c14ec [release-branch.go1.26] cmd/compile: ternary rewrite of rewrit=
e
> should skip, not panic
> f14d3a8e91 [release-branch.go1.26] cmd/compile: skip race detector test f=
ailure
> for unsupported VMA
> 68f42c591d [release-branch.go1.26] cmd/compile: gate instrumentEnterExit =
on
> NoRaceFunc check
> 9fe1db7e7e [release-branch.go1.26] runtime: fix value of ENOSYS on mips f=
rom
> 38 to 89
> 08edcb8d3f [release-branch.go1.26] test/fixedbugs: remove issue46234 test
> timeout
> 895fbaecf5 [release-branch.go1.26] doc: remove template use in godebug.md
> 26548d4981 [release-branch.go1.26] cmd/fix: pull in CL 755980
> 12bf7d8cd2 [release-branch.go1.26] builtin: incorporate all feedback into=
 doc string
> for new
> 943235a5e5 [release-branch.go1.26] builtin: update new function comment
> 1a44be4cec [release-branch.go1.26] internal/poll: move rsan to heap on wi=
ndows
> 3bf3014fe7 [release-branch.go1.26] test/convert5: skip mipsle
> e29f35511d [release-branch.go1.26] cmd/go/internal/cache: update trim tim=
estamp
> before trimming
> 2b01132c9f [release-branch.go1.26] runtime/poll: fix race condition in Wi=
ndow's
> SendFile
> ba8c3d07a7 [release-branch.go1.26] net/http: restore accidentally removed
> package doc
> 99df9bdb2a [release-branch.go1.26] net: correctly handle non-nil empty cm=
sg
> buffer on windows
> ace2cf6652 [release-branch.go1.26] cmd/compile/internal/typecheck: simpli=
fy
> tcSliceHeader
> 1368bc269e [release-branch.go1.26] cmd/compile: fix bloop test
> 840d86c060 [release-branch.go1.26] runtime: fix printfloat, printcomplex =
buffer
> sizes
>=20
> Fixes CVE-2026-32282, CVE-2026-32289, CVE-2026-33810, CVE-2026-27144,
>       CVE-2026-27143, CVE-2026-32288, CVE-2026-32283, CVE-2026-27140,
>       CVE-2026-32280 and CVE-2026-32281.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.26.1...go1.26.2
> [2] https://groups.google.com/g/golang-announce/c/0uYbvbPZRWU
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.26.1.inc =3D> go-1.26.2.inc}      | 2 +-
>  ...binary-native_1.26.1.bb =3D> go-binary-native_1.26.2.bb} | 6 +++---
>  ...oss-canadian_1.26.1.bb =3D> go-cross-canadian_1.26.2.bb} | 0
>  .../go/{go-cross_1.26.1.bb =3D> go-cross_1.26.2.bb}         | 0
>  .../go/{go-crosssdk_1.26.1.bb =3D> go-crosssdk_1.26.2.bb}   | 0
>  .../go/{go-runtime_1.26.1.bb =3D> go-runtime_1.26.2.bb}     | 0
>  ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
>  .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
>  recipes-devtools/go/{go_1.26.1.bb =3D> go_1.26.2.bb}        | 0
>  9 files changed, 9 insertions(+), 9 deletions(-)
>  rename recipes-devtools/go/{go-1.26.1.inc =3D> go-1.26.2.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.26.1.bb =3D> go-binary-
> native_1.26.2.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.1.bb =3D> go-cross-
> canadian_1.26.2.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.1.bb =3D> go-cross_1.26.2.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.1.bb =3D> go-crosssdk_1.26.=
2.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.1.bb =3D> go-runtime_1.26.2.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.26.1.bb =3D> go_1.26.2.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.1.inc b/recipes-devtools/go/go-1=
.26.2.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.26.1.inc
> rename to recipes-devtools/go/go-1.26.2.inc
> index 2e3464e..8bb10bc 100644
> --- a/recipes-devtools/go/go-1.26.1.inc
> +++ b/recipes-devtools/go/go-1.26.2.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "3172293d04b209dc1144698e7ba13f0477f6ba8c5ffd0be66c20fdbc9785dfbb"
> +SRC_URI[main.sha256sum] =3D
> "2e91ebb6947a96e9436fb2b3926a8802efe63a6d375dffec4f82aa9dbd6fd43b"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.1.bb b/recipes-
> devtools/go/go-binary-native_1.26.2.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.26.1.bb
> rename to recipes-devtools/go/go-binary-native_1.26.2.bb
> index a21b415..67196d9 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.1.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.2.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "a290581cfe4fe28ddd737dde3095f3dbeb7f2e4065cab4eae44dfc53b760c2f7"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f56eed002998f5f51fa07fd4ed0c5de5e02d51cec7a4007f771c7576620d9d45"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "c958a1fe1b361391db163a485e21f5f228142d6f8b584f6bef89b26f66dc5b23"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "62b7645dd2404052535617c59e91cf03c7aa28e332dbaddbe4c0d7de7bcc6736"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.1.bb b/recipes-
> devtools/go/go-cross-canadian_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.1.bb
> rename to recipes-devtools/go/go-cross-canadian_1.26.2.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.1.bb b/recipes-devtools/go=
/go-
> cross_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.1.bb
> rename to recipes-devtools/go/go-cross_1.26.2.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.1.bb b/recipes-devtools=
/go/go-
> crosssdk_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.1.bb
> rename to recipes-devtools/go/go-crosssdk_1.26.2.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.1.bb b/recipes-devtools/=
go/go-
> runtime_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.1.bb
> rename to recipes-devtools/go/go-runtime_1.26.2.bb
> diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-
> content-based-hash-generation-less-pedan.patch
> index af4243e..077bebe 100644
> --- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> +++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> @@ -109,7 +109,7 @@ index 7b073165d5..1f618be0bb 100644
>   	}
>=20
>   	// Configuration specific to compiler toolchain.
> -@@ -2807,8 +2809,25 @@ func envList(key, def string) []string {
> +@@ -2804,8 +2806,25 @@ func envList(key, def string) []string {
>   	return args
>   }
>=20
> @@ -136,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS,
> checkCompilerFlags); err !=3D nil {
>   		return
>   	}
> -@@ -2824,6 +2843,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> +@@ -2821,6 +2840,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
>   	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS,
> checkLinkerFlags); err !=3D nil {
>   		return
>   	}
> @@ -150,7 +150,7 @@ index 7b073165d5..1f618be0bb 100644
>=20
>   	return
>   }
> -@@ -2912,7 +2938,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
> +@@ -2909,7 +2935,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
>   	cgoExe :=3D base.Tool("cgo")
>   	cgofiles =3D mkAbsFiles(p.Dir, cgofiles)
>=20
> @@ -159,7 +159,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if err !=3D nil {
>   		return err
>   	}
> -@@ -3461,7 +3487,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
> +@@ -3462,7 +3488,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-b=
y-
> default.patch
> index e2a0cd6..9aebc2f 100644
> --- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> +++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> @@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
>   	if err :=3D sh.Mkdir(buildAction.Objdir); err !=3D nil {
>   		return nil, err
>   	}
> -@@ -1891,6 +1908,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
> +@@ -1888,6 +1905,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
>   		return err
>   	}
>=20
> diff --git a/recipes-devtools/go/go_1.26.1.bb b/recipes-devtools/go/go_1.=
26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.1.bb
> rename to recipes-devtools/go/go_1.26.2.bb

