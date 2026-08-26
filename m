Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59999C61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 16:14:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16494.1787760840444870998
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 09:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T5KaYR6I;
 spf=pass (domain: siemens.com, ip: 52.101.83.10, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIUhIgbjlv+yJHDmcMv+2GWI5cEez5VI63yJ3DviJ0PHJ4PlnVZZUKaxC0l7suueIYPuHtO/BtERoSTBvy4TZ6zU4/YU+6flif+XVXU+gzgXaACniFJKiQW6Ou/3S4JO95QWvd01DE0T4vHJuVmSN67YPS7mBauVbGVLlEa/rH7Lvd/6Njxy7gzaXCFdHjlu/ypnmBm6FXknoB+iODjcn2xw5ASS9eJcbDXjRLTBjF2UVjHp0u6qjfILLwDTrjsheMuYPDA0dIiNTZxyG4Z3sqIGi7QD2Nka9qlHZ+hgpRTWWNCkbXIjqST27nSLMs2ifY9BjeE4ZS/aBEPEhAd2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKXF/ajG0JkNwJpXErSVVzcC4O2nZHsooed40xOpV4A=;
 b=vR0sTEW0yvJCobJkWD73ehH7BX/09m2Tac03VtfKIvO9acAKO0oIavV6Fa8tmuTErPbY1NS2bwMEV06uiuClb1R71MTbceCfXg2EqhGqaJGBgi0GKSM3kFLqMPvXcG+zbV4fapHpfnoF0/Zh77IGENn20UWGgYWxPVQvzw64xIDbztj36m8gFtyLPAUkATJL2ecNj2IG3af3kHiArTTijjFz5pgkBcWpt2XrrqatnMfodA8QxeJ6uyojNbYw3ShMB5JZZWZoMDAclI7fAjqgspe+B0llttTrNCdD0xCvb/uMWkIkh/ktjgAVuih4ahFa2i21Nf5cm8U+urvcMsljdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKXF/ajG0JkNwJpXErSVVzcC4O2nZHsooed40xOpV4A=;
 b=T5KaYR6IzBeYP/OM8tQJoMJIgwX5KwAVkfcJXI/AuUOiqbB9RIyboLxbY9NtwkA7Id4b21ghSOvYngYoV6Dlt5vQhXl+r/gVo+KxodPVQgLVzJzgf1mlrkDxjKO8Y7pGpEP1mU756a8po9ayGnwJynlZayO0NiqwMt49zjPcX70HfMLa+lmEZUXg2eA/fSR0BL1RYuD0DoU0Q/HIAhMI688ndSxGT8GVPzcGipDCWhbHQXmPai7IJWt6+1Ct2b8Xmwnb9f9KgCUK1CiBFyrkul81CNUmPJVhaQ6qm07lpQ+hXADXtSzaGRt7IeDMl+JP8UOhi3qAm05bBIHUh1UDkw==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DU0PR10MB6678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 16:13:55 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 16:13:55 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.5 ->
 1.26.6
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.5 ->
 1.26.6
Thread-Index: AQHdLLQylB2M+DAMVEaMrPeyAZmYhrawkkhA
Date: Wed, 26 Aug 2026 16:13:54 +0000
Message-ID: 
 <AS8PR10MB5073F7131951BF35C1B98429FDAE2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260815124658.1003592-1-peter.marko@siemens.com>
In-Reply-To: <20260815124658.1003592-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=10e046e1-40a6-41ef-b3b4-97a3cd48260b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-08-26T16:13:35Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DU0PR10MB6678:EE_
x-ms-office365-filtering-correlation-id: b00e3146-4e18-40e7-f231-08df038d06ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006|12006099003|6133799003;
x-microsoft-antispam-message-info: 
 5OFraEUig6QTaE34NRJVAvaevvbjNdpOyfJq978irXoE9BLccCVO+NJyAweZFZUjBxPsfzylkrajWm1+ohsmMnOohpYxiuPbvvEtShsMI5TE4j/vFzgT+M34mID53jZ4uUkkLWPUUvnR+ETO9M6j0YZPOPt6CnHaiRXamjqjq/fcbg4Eli8uI2R8Fi+h3dQc8+jPtrec5Z9NkuvLCjPyUZf/AWETcth2Z5R9fDFz/OVgbXW0ih8AHqA+2KR9UgQ+ZLEymIjq5jPXRW0FS/RO/tqeDLjFQ3xyhzj083j0evttemMWoc8XVDvN8vnodTfWshrw4fBLqoBfPTS+IDWWn5rEkB8guWgiBoCOzOdRZXnfwi7RfqqYJcreQ3VnhD9QXCe73uRjguoRndP2UvQmyglwLxjThr9wkIU4x02scdASgkRHLeniHCDO/gnM2iJ560qF/GLtYv2HZoyOfqEotAo8nHMljStDZshm3AGp4VwYELoXom2TzMXgm3me+wRhlS3BS5rrwJl9mhIxsFRNXB9m+L2rn8asszVL4lqFkeA0iZHX+35+k09KsW2NvO+qZxldSFJNJxRfbCDWjAWSzEZ1TUktP7NsPf11Jwvbec/C5JA9x0xnqxU5sjj8qtNMh4siJ0ZKKYiwQx9K2MPoEoDvpoowLU+uEv3SwH4n8/I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006)(12006099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?otBHkQIJcuYSfb3vN7Vn+teIbF0hkcmj5uKD5KD9AxxqCaYamOS7ARHy6I3Q?=
 =?us-ascii?Q?77wr85H/Q50vTcTLRgfLBroR9QDNkSq4G5tqEZ4Or+eO7ygVKkuTmjAMHbus?=
 =?us-ascii?Q?aF8JaLJ9JQHYZOb0ea3qSw3H3vcq5DbKMFgKBuQaV0J5tH62/QJHIgHsoRdy?=
 =?us-ascii?Q?aCbBOGjKfoF1C10t17xj9A/xfotWhvdS2o3w9nQoVHVhcQRPxXKcgeYoBkyZ?=
 =?us-ascii?Q?4bLdIMAF1KFfvfM5JPxll7E+nsMwuLr4tZEW2hN0g62Jlcs2DqAzk4i4yNSD?=
 =?us-ascii?Q?R2aG/x8qHBTA8KBy+UUyTWhrTX4/tHzhiCsT20cE/LRHRXnT5+NdbKtJN/2H?=
 =?us-ascii?Q?W4T3Of23IrsohgEMV2azyAHgl5cs87TpbrBUvvjV/Vlt/+4nd65Dd+1lTG5P?=
 =?us-ascii?Q?KVDzGlVz5RnwmePLpXrWP0E8d8yzIsCaJM2qXisn1omn7SXJVSkw9kM6hNRN?=
 =?us-ascii?Q?hoIILQiz0Nm8unozsejHmNEUQnw6Jbn3POZbNW2flQ9qghriumZSRqPE52ct?=
 =?us-ascii?Q?iQCRdvdrZdzFp2Ni5bdlokrEYsgmfRNHVy2Tw6Ga+lni0571dQU2osq8IJQR?=
 =?us-ascii?Q?VC1dUwjRV75bGvryp4Ik7EPuFkT8/ya3slSXeQ+d7TpTFlGNMpva3X1OQY6C?=
 =?us-ascii?Q?Jus+6oSqVGlYCFxPH15X8V072bK5p+IiXFHErlqBIBtvfrXHdb799ykQfUea?=
 =?us-ascii?Q?PKpfXBsUTnBNsbEOeXkB1TGQAnwiKHeo0BQOLQBdAdX6NRq5Qv9A2jGhpkPi?=
 =?us-ascii?Q?1VSUTHhn9GZZoQK4UkLhuJ57xlFzaE86zy/KG4ImtpNHbo1Myh6h65t/YyG4?=
 =?us-ascii?Q?yl6uNBDXcVcUkkhuuxHx8qY4ZGxk8bnVH3wxaT8PPf0O3neoCaUZglvNe78v?=
 =?us-ascii?Q?a2nObbhKAIT3Zyp2hHEVxU4iOuzGvOnCS4ucShO3bD/Ds09ZPjyBHviENagw?=
 =?us-ascii?Q?BZgqkFDlSDwl6QZoVBNMpL+169elcNbKhPNciR1a10xmh9NaSEKSXistN8Dk?=
 =?us-ascii?Q?rypLRBO/ksr+gsZc8JQXc6ceLzqpIUsIYzc4VPP/sION7k3C+JS+wwFItYxZ?=
 =?us-ascii?Q?kVIDrke0yUBPKhNG1807r+PW9ddzH9pB0fMLvg7JBTyEd7+QgHvhdmDfyuT+?=
 =?us-ascii?Q?dbeResrE0Ey67PJAHNCelm6TdwZTCh3rR+P6DsZ5MLHiZcndxMhMbsVPJssX?=
 =?us-ascii?Q?1UBGIjprzz2XxR5uWCQAYmWoaGBDymg7ytey+iKbStbMfGvo4zWMk7hjkktv?=
 =?us-ascii?Q?s2tOiG/PpbpIXa0GEXoMyDYqfb3jvRaMhiHZmF7dFaVtVRA3d7SPnqQS30Ja?=
 =?us-ascii?Q?KByeaLsHaYvT8Jvof2RbyAlJESlPGZdfdBqKA3wXQHulaO6jfuYRA+jkojlu?=
 =?us-ascii?Q?5BVvlUnxd///lmKcaXp4yCpD2v0kVgr/sZuZn/mBUUoHYr6Mo9K6CNhtKCNO?=
 =?us-ascii?Q?5gqvT6wccSsfnys14oGBPaqBcB5If5iqxS7FpnDAUn6rC+hAP2knlNONlPxm?=
 =?us-ascii?Q?n9LfxhsB5as+yVE9p74T+BS8G2OrLU3iFayMNVYzxo3FTGoL8//qK4ljc1YV?=
 =?us-ascii?Q?3RAnSEXPLkGiUJQ9HFYIJfBFdFJMB8Ucbak+DSgQMv8PZvzGSZ2yqAmrFh4I?=
 =?us-ascii?Q?OdM9sowri8xZTge/7ik/hZYS/mHnthA513MqFN3+k72KB2l3ZmrX7HCgZNC6?=
 =?us-ascii?Q?HSywbdjwe4DbvYFQ+MjXbIs4zG1RWVwgFZn/zoEc5SZ5ZKNBfc3vBw1XYmiL?=
 =?us-ascii?Q?L19veqVEWg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e3146-4e18-40e7-f231-08df038d06ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 16:13:55.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VuDEVCKvhvfvB+FLLNECaeYz522kSFcI6Wa/v3UNAEt543ZCuJxy2gjSpA9Kkk16qEYqmyI5GZAYtnlzROfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6678
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 16:14:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4689

This is now merged.

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Saturday, August 15, 2026 2:47 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.5 -> 1.2=
6.6
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.26.x release [1]:
>=20
> $ git --no-pager log --oneline go1.26.5..go1.26.6
> 1ea5a71ad8 (tag: go1.26.6) [release-branch.go1.26] go1.26.6
> 115eb476aa [release-branch.go1.26] cmd/vendor: fix CVE-2026-56865 in x/mo=
d
> 9f6980fd5c [release-branch.go1.26] cmd/vendor: fix CVE-2026-56864 in x/mo=
d
> 6ec908dd24 [release-branch.go1.26] encoding/asn1: enforce maximum recursi=
on
> depth
> 9918f26ab3 [release-branch.go1.26] encoding/xml: fix depth processing in
> (*Decoder).unmarshal
> 33ecb966ca [release-branch.go1.26] html/template: fix JavaScript regexp t=
racking
> 128893dbf9 [release-branch.go1.26] net/url: avoid quadratic complexity in
> resolvePath
> 13c194062c [release-branch.go1.26] cmd/compile: do not elide riscv64 sign
> extension of unsigned values
> 52e5e2f22a [release-branch.go1.26] cmd/compile: fix time traveling proofs=
 in prove
> db38ee7121 [release-branch.go1.26] cmd/compile: fix prove to generate Con=
st64 for
> 64bits slicemasks
> f5bf46f361 [release-branch.go1.26] cmd/compile: fix mips64le bigger than =
32bits
> pointer offsets
> f8d4fa6213 [release-branch.go1.26] runtime: fix frame pointer adjustment =
around
> injected calls
> efc79671b1 [release-branch.go1.26] cmd/compile: do not home mul/div resul=
ts in
> HI/LO
> 605fd48711 [release-branch.go1.26] crypto/tls: add fips140ems GODEBUG set=
ting to
> disable EMS enforcement
> 100fb8f023 [release-branch.go1.26] cmd/link: quote PE .def library name
> 4d522f275f [release-branch.go1.26] cmd/compile: tighten mergelocals addre=
ss use
> analysis
> 0e8a244fe5 [release-branch.go1.26] all: update x/net
> 019fcb0152 [release-branch.go1.26] cmd/compile: don't require Heapaddr fo=
r heap
> vars in dead code
> b6432317a1 [release-branch.go1.26] crypto/tls: do not count handshake mes=
sages
> as state-advancing post-handshake
> ae63e27897 [release-branch.go1.26] runtime: fix uninitialized 7th argumen=
t in
> mach_vm_region_trampoline
> 88bf57924f [release-branch.go1.26] runtime: don't emit write barrier for =
code pointers
> in itabInit
> 4238449188 [release-branch.go1.26] os: strip trailing slashes in RemoveAl=
l on Plan 9
> 28f27d64cf [release-branch.go1.26] os: properly handle trailing / in Root=
.MkdirAll
> cc312256f8 [release-branch.go1.26] runtime: be sure to scan small frame i=
ntroduced
> by (*sigctxt).pushCall
> 07a0bbba1b [release-branch.go1.26] os: don't expect an error from Root.Re=
adFile
> from a directory on NetBSD
> a42fec40ab [release-branch.go1.26] all: update x/net
> 5bbd22ff78 [release-branch.go1.26] net/http: apply header timeout to serv=
er's
> unencrypted HTTP/2 check
>=20
> Fixes CVE-2026-56865, CVE-2026-56864, CVE-2026-56859, CVE-2026-56853,
>       CVE-2026-56860, CVE-2026-46600, CVE-2026-56862, CVE-2026-56858,
>       CVE-2026-39821 and CVE-2026-33818.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.26.5...go1.26.6
> [2] https://groups.google.com/g/golang-announce/c/94pEornpRlI
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (From OE-Core rev: cae8a33abfda172e65166811eeb1bc7ad2d129a3)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.26.5.inc =3D> go-1.26.6.inc}        | 2 +-
>  ...o-binary-native_1.26.5.bb =3D> go-binary-native_1.26.6.bb} | 6 +++---
>  ...cross-canadian_1.26.5.bb =3D> go-cross-canadian_1.26.6.bb} | 0
>  .../go/{go-cross_1.26.5.bb =3D> go-cross_1.26.6.bb}           | 0
>  .../go/{go-crosssdk_1.26.5.bb =3D> go-crosssdk_1.26.6.bb}     | 0
>  .../go/{go-runtime_1.26.5.bb =3D> go-runtime_1.26.6.bb}       | 0
>  recipes-devtools/go/{go_1.26.5.bb =3D> go_1.26.6.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.26.5.inc =3D> go-1.26.6.inc} (90%)
>  rename recipes-devtools/go/{go-binary-native_1.26.5.bb =3D> go-binary-
> native_1.26.6.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.5.bb =3D> go-cross-
> canadian_1.26.6.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.5.bb =3D> go-cross_1.26.6.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.5.bb =3D> go-crosssdk_1.26.=
6.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.5.bb =3D> go-runtime_1.26.6.=
bb} (100%)
>  rename recipes-devtools/go/{go_1.26.5.bb =3D> go_1.26.6.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.5.inc b/recipes-devtools/go/go-1=
.26.6.inc
> similarity index 90%
> rename from recipes-devtools/go/go-1.26.5.inc
> rename to recipes-devtools/go/go-1.26.6.inc
> index a4302b2..fa6b0a5 100644
> --- a/recipes-devtools/go/go-1.26.5.inc
> +++ b/recipes-devtools/go/go-1.26.6.inc
> @@ -16,4 +16,4 @@ SRC_URI +=3D "\
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "495be4bc87176ac567392e5b4116abd98466d33d7b49d41e764ccc6976b2dc42"
> +SRC_URI[main.sha256sum] =3D
> "a0721c54c688901448d77ad9b3ec7ea7c474730755ff891382e92ecb93ff2cb1"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.5.bb b/recipes-dev=
tools/go/go-
> binary-native_1.26.6.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.26.5.bb
> rename to recipes-devtools/go/go-binary-native_1.26.6.bb
> index 8ba9dd4..c3e9eb1 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.5.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.6.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "5c2c3b16caefa1d968a94c1daca04a7ca301a496d9b086e17ad77bb81393f053"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "fe4789e92b1f33358680864bbe8704289e7bb5fc207d80623c308935bd696d49"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "c5d60e2b303bb612f20cd82786594b64874e73b35134025e27d3390bf284ae43"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "708effb774be8237570d0add163225abbdfaf4fca28b2611df167beba4feef89"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "d0507e9e9d7fe012aae570108cbd76c15de879e17130ab8cb90d4d7445cb1f2e"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "232b65543a42eda95df6a63f76235c1795bb535eba5c74e509faec71bc648388"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.5.bb b/recipes-de=
vtools/go/go-
> cross-canadian_1.26.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.5.bb
> rename to recipes-devtools/go/go-cross-canadian_1.26.6.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.5.bb b/recipes-devtools/go=
/go-
> cross_1.26.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.5.bb
> rename to recipes-devtools/go/go-cross_1.26.6.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.5.bb b/recipes-devtools=
/go/go-
> crosssdk_1.26.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.5.bb
> rename to recipes-devtools/go/go-crosssdk_1.26.6.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.5.bb b/recipes-devtools/=
go/go-
> runtime_1.26.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.5.bb
> rename to recipes-devtools/go/go-runtime_1.26.6.bb
> diff --git a/recipes-devtools/go/go_1.26.5.bb b/recipes-devtools/go/go_1.=
26.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.5.bb
> rename to recipes-devtools/go/go_1.26.6.bb

