Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C510775F4
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 17:20:57 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19818.1773854447480441984
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 10:20:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eHDbySQe;
 spf=pass (domain: siemens.com, ip: 52.101.84.33, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT2oiBKYxubSrKyWXgsbUf4w+vr4va7vJkorBvrmVCVMTd6UpKSt8drEHI7KwMXHvGh1z9r0z278gOv5OwbZ3AFPctpNNmryDkBCt2apCQ1Z+rTw/KqyZ/CACkGSRqG8Mpt4sBlXJy4A7vaRwt9DQwWcw3i/6OSbyo7y1gBYBNMKPov+YMzDv7wfiHxlEgddKnKjs7ESyWNK3EOcqycGIzQH83l9SMqErzSke8t5hN9ZekrAfKUq1mMfaRmKqKFy2svmTnFlk7/4YrVX5B2Ry508somYwfJYxK0EXfTx2YpVktymAx2u3mI0OoIeN+Hx3K6AgFv2JFH9L5hMSl1B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viyd2ME4hKGuIXcyax86yEEgp9QtQEPski49KPabeZo=;
 b=MGF5uxZydwWw7o9bEXFWLoCeh4BcwBZByJg0DhDMChRJgRpAHj/77pE9yrkzDEZBgBF5tTM5ZUo5clwomtf1LfYP54XJZf2MSNAUSPXTcMqBxEUkmhbLK/Wc/UeL+gsPMpo3sYuwuFzCcOYYOvybiJKpoH3qjEiBDciwjmeFZrb3w8KddefVkHzh/rbnr4e3lgJLuUIE8SNZ3hYjViQ3c+YmvySphxZJKs4lYs096rRAS7VXwnidCj5KSVLsEI6/Pub55WPQs50JdM5u5UCoOBhGdzteDawR3yDpCFNeJK29/SpvYBipsmd5tbgdhV7iRWqk3sw3izvpv8k/pYNr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viyd2ME4hKGuIXcyax86yEEgp9QtQEPski49KPabeZo=;
 b=eHDbySQeRw16ER+u5hS/OfU+HWF8tL2vjtsjtcpHZOpA+OY1DpgQP+PneeE+v1l8qgfqwiGZh7oUF27CxToy26jEyGkMZp2dNI8SSPLbibqoqdY3eZYRWnGZ55SORvu007+9Dw0GHqV8awqAGGyYpgY8XfCJHNA9TK3TY2CnAPr771w7QPzwdpBJKLkThXaHRR2c64u6cHZ8ZXLFd6QhCBLdyfVx0hG3ObWv+YPvevx3orXydj41GoyyUFGyRB+GipOPojVT2Zbt7HP0VqoYjmRFHM0MHKZzwTXzTIJFOqyDp74g+ng4mR0J9W6DgC4Cpos3EcxpoUdQEXUDTcNOAw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS2PR10MB7779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:20:43 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:20:43 +0000
From: "Marko, Peter (FT D EU SK BFS1)" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.0 ->
 1.26.1
Thread-Topic: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.0 ->
 1.26.1
Thread-Index: AQHcsOUMerHKVAJHFUuQhZpNCmsW7LW0lUmw
Date: Wed, 18 Mar 2026 17:20:43 +0000
Message-ID: 
 <AS1PR10MB5697891E5EAB9F5980B07DD4FD4EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260310232425.1471790-1-peter.marko@siemens.com>
In-Reply-To: <20260310232425.1471790-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=93afc6a8-9f93-4507-bb23-f448b65da0d3;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-03-18T17:20:38Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS2PR10MB7779:EE_
x-ms-office365-filtering-correlation-id: f27bd5f2-5e37-4418-e17d-08de8512afb4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|55112099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 kI599DRQZxZnMmGzyrQ0VoRcYoS2+j6oYfkfPsJW/iK+IAlVRveaKMIw5EO1yNFpXp/bIt6rNrxgF7GM93AImzyOjuxQfvEqa7/SkJRlUcARYnyaS/mFZN7tDL+OQ+GWEdWAZY7c1e+TZwOpyZkKQA1taGmIzFxzZfItL4TAHL/DdNTUpKR9c7Ae6sbFJoT2c09VJkNAfmEkY4/hDZ/XNYRR6aaKrFuMWoCaknjxnW7Pnh/pzgaQNMswDPqTLLRW6SdoH75SPm0k6zuI8CcHJGFBmlQwqvM5a6yIlmMLA3KUdPTM4tPY3OXnOCPld1vS8m3DHpmH2AoZzkUZvjEuiw1sDroRDPv0RBICgVFVxFizEGy8ZFB1R9P+jIERw8pwTU7azhP2E+Ffy3UWLenuu3P1jhaD8Wa546mHX9HL91ZC6Yc5WCNPykmitKZzdXAPGLisQhbaTVSoTTNTuMS93iI7tAls/56rYbHRPaMw7FWQodrFgOadbG7pZAutWXymlG5quzBbuxVDWI4jcLJ7kIFzgNTgcONV/lkUPdOrWgl57inWG8LUnkvOp4JSjOMchMPNAtkQc1lhgc0WvFipb4QjFKw5XvN48QNROp1eLsjE0ybypfqDJGqd4KqNqBPUHtBQ9TDMkbC7VnaQ2baMidZTD4RhCxBNNF0gdHyaVZrHYs8JUr8f8b6v15jdDzoUPeqkLP2Yt32INQnwm9xk+un7XozsrTXV1l7otCOAUmw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(56012099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IMPdnkHHPTNjp3SSazBBnZgTJTMhkXaT0GwdIUWLh/VxQuGeIHbu4s+6J7LX?=
 =?us-ascii?Q?qerYnj2LCwNuz06rktzyjcS2oHdiV+9fYe+PCx3tPUnzbIPq09RWc8ROZHQu?=
 =?us-ascii?Q?xlSmx8K0xvxvZY1tGufhMPJq3QGe8Lfdpy9wR9CuDvHMxbvi21KgBvH9NeP1?=
 =?us-ascii?Q?M7vQ9cOPPMOouBRTfBKlBgCM8HVCywNT7PjDnVog01Ue1cEgK+7NOZ5sLrsZ?=
 =?us-ascii?Q?CYbYsPg5w0UzD6zkhTAae2Yd2XCDpqUOlBF9pmugMkPMJ0hSDTZRPHrZiGc/?=
 =?us-ascii?Q?gweqU+ubbDsze5PAWw7rfmEwSwugSimdoJY3cBKUQeyNe7ORdJzdGhK+9BW0?=
 =?us-ascii?Q?rgpWJ8E3BtKV0supB/JwBwR2cl+Bd1wbUQHrczQmW7E6lRYSQ8DOqcBKgrZD?=
 =?us-ascii?Q?dzOvOIOSkrVDUI094Edfd2xGPt85GtY5EGxv07cobRfC9gcAVo16Sd0aD3rA?=
 =?us-ascii?Q?xt8MPG88z1ZI6nmBWglRRg45I+JQgn1Y2zRVxCnGcpFAvIztvfjOKIkcgAkc?=
 =?us-ascii?Q?aE8vrBIJ8/QqNjEiLNKK7sZuAyBgzfNNZclvCKYbnTN29Rq1U1GwbKqILpgr?=
 =?us-ascii?Q?26y7j3pYQFk17w0UX4twLBdQG5jRMUxU6NeDnLLoZMR13H2qpK4RroOFnNCn?=
 =?us-ascii?Q?qO1Zom9N7rSbeNbdcF9YU6FxDrqHVw73NTrH6K1QqFR0e3wwfQZpQHLF+6UH?=
 =?us-ascii?Q?9aEMoBVLZXwidbjSDMHtaOEd5VuUJOTfxTNLT2GMeDnLxQbvfRuGdIG0gRI4?=
 =?us-ascii?Q?9lobcKz3ckodqBtQ1cIfUnqTPfRXkqVR74READQLl6OcvAF2gGnYEfIYJi2Y?=
 =?us-ascii?Q?zlBiMPQ1ojuf3f0Gqkyt7o6BNH0eIf9qKwiCaIfTCzSY1ucs67VvPh0QNQPJ?=
 =?us-ascii?Q?nxUJHx8ySs1hcXdr77ZBPSWOQ3ylwHi2WDozk6oe/ka5N5Qv4VQLCe+JtNlW?=
 =?us-ascii?Q?f5THICGFs5pgTu/D0VA7FiewSnwxgrv+yfrhrJL0G0u0gF4VeKxKSDQ1gkSV?=
 =?us-ascii?Q?IpBQekJPrIwWxanCVSbWhU6S+XmKoYJhKcJZrxezzeLm37B7z/erwbf5DnoK?=
 =?us-ascii?Q?rTD3k6F4YAtQajiYB/gibDS3jlI+QcNI19dlbzP1jw8B1nwMv6VaDn5joaSS?=
 =?us-ascii?Q?WzqHIgMnbYddPiHg9WcarcGlcmR/7fNuEEf2yLa68WebPMNFHiVoQmQr0Gk/?=
 =?us-ascii?Q?Cb80thkF0afMuTKeLu5IQCOtx3Ctugb9SE81R0Pw+/b/3dnboB1h/aI/V8tg?=
 =?us-ascii?Q?LzTXQpCvhNEnAZLlo2AdG3tqn2EtmlBDo39e85N1PC7Zbfa4dND5DeFnwU4H?=
 =?us-ascii?Q?rjf70VILcSnqFp83VvFU7YSslcQuDvdq1JrDBt2v+nNgddhJLsLo2LL4YuVA?=
 =?us-ascii?Q?oSTCdFGS1B4YnzJVjZCuo3WMPtiZdMgmSIaqFKmyDZHX+mRz3VFoAj/uacN2?=
 =?us-ascii?Q?g5LZ+u7lN/lPA6qoDz3LgN3JvpXi0QcYE0j9oOQQoaFS8lXhCTrb6w4u6xVT?=
 =?us-ascii?Q?YIBW3DOmaUFkHPjADnjNLqZ0AqWnT492vAFL2c7hR5TTmFXZ/sZy4h2jdtic?=
 =?us-ascii?Q?r18umpereRL19kpTi9u5+whEFq9C3SgDZcq28JPRvu/pQKPiJkMdX5rgEkGx?=
 =?us-ascii?Q?bEZx13zA8bkcoKoKtUhOhIPMjqPQdaYOib9uBYAQ6UMnd1Y8+jUScFZ+Soi8?=
 =?us-ascii?Q?REtl6ChZN5GT0X8WJO1vW9HyhoGlm1InGc6666FnAwHYRtRuIKjpi7s81DtN?=
 =?us-ascii?Q?bsyHEwEg+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f27bd5f2-5e37-4418-e17d-08de8512afb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:20:43.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rasImawoJHCPl3JyaES4cuRXREqtkKNJU94HXiGpPvmCRgP0YQSboL7DbRNfCJf3JLFkM1TeKkTiuKTGtXFhbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7779
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 17:20:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3516

This is merged now

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Wednesday, March 11, 2026 0:24
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.0 -> 1.2=
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
> index 9eb84fa..a21b415 100644
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

