Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED1CFD34F
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 19:12:19 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24990.1764011531866248308
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 11:12:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q4SuqkaA;
 spf=pass (domain: siemens.com, ip: 52.101.66.13, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=marW+4gQ75kHVzRR/3h5dGLmh2QcpZLqTcBk8qBIPPeNyzYF0SPzJeu1/+b7cBZjjnH3JOuuMbFYxbd0R3MnZ2Y+BzkkZVk4+VDB/jaM6TFLrLP2XkaPLHv2FrGIKOuVRTEmsOig5OefyWvWqEUb+cKVY46APQaoGrC4WvPZEOiuAMd+nT3ckOvz64jWGH9BQk+AXFXhJ9wDv59MgmUTo0MLUAUk1IMj4zqDzo+4bK3790KJ97s5ZIpSXGxay4f8bVyUtT1+sOnCXFSDXwPtdIHPGVN1UXXBUmPu3+bqDitgnOlJWh8nEojeYzJ7QaPTNCjquL7JlB4BbV/ZzlWYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uCrOF/5q3pc03zzjTUmOnmRgy3bCcpKQz4paBCJwgY=;
 b=sp3OXL/YG17v7mhxjyk5L9ThPLM5WMcja5nH7g7EdQu07pkjqdRbvV48oKobgv2OSMWemrG8bYINNTvEYUINwQ17l2UI2uuQeRJo4fHsr1CClO5Cma10fDVnO+8pa2S78mx6dQ0GRry/zLVanK5WWXh+VWYPvYgW26faWWmUcnJ3wfIPDFZ7qzO8utCmd6e4C1O6O4Y3as0zIRbjvPaDPhAtz3cN09GQNEiD7101GyRObx4yMV6858FMoPb36weFEAOQHqkoKLaTh3B8wk44feHzeMg1YdCgdNW3zTYjomZ0Fmp+e5XxqlEpDIBDLEy3ps9r3xyl0SOntgpZTOBKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uCrOF/5q3pc03zzjTUmOnmRgy3bCcpKQz4paBCJwgY=;
 b=Q4SuqkaAQ++eEd4lv+S4CGk5NBKbnKgEhQSpzmXVJBm3k3PMj2PgGDeiQ+2aqr+BYrfThR4IeJ4urb8xP8X4iOqIfLzlpch/0ZwNIGjzB2zhWlaRGnAXYnwPalzXxBgpydDPLgkW43pxR5pKU+3+EEaKin6pkQqLoGJyANaTWpAXwQUMQAGlxRwap/UZchYcLNsIGf9XBsbm+FKSsO6SpYM0myXNpmk304eyRvEhLH56vGI9quYnlRx23XSpeCodm9zZ/jGbJ81QLBi+m7j6eac54ce+9J+ZbzakqReLvr05sC0GvuCRutcJS+W8dmkOO0/3IPE+FHCpYxxNZ7WV0g==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by GVXPR10MB8344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 24 Nov
 2025 19:12:05 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 19:12:05 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH v2 00/35] initial
 scarthgap/go version
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH v2 00/35] initial
 scarthgap/go version
Thread-Index: AQHcWWX7S17jVkLGVUmNODcNXyDm5LUCOVcw
Date: Mon, 24 Nov 2025 19:12:05 +0000
Message-ID: 
 <AS1PR10MB5697217340A247E5BA66901CFDD0A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251119150522.15477-1-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d3ab32c5-fa6d-49f7-bdb5-98bbcde1e009;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-24T19:11:00Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|GVXPR10MB8344:EE_
x-ms-office365-filtering-correlation-id: a29e5b1d-27ca-4438-fa20-08de2b8d5b1b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?hBt4kMIR+YSusdjTg1NOKSc741AE8iONs0f/UO0UiWnqw1V31xXok7PrWE1P?=
 =?us-ascii?Q?P2HqtLPrMzs7d47KTxtWoRhapDvGqobmmuggu3OcGUBsv6k/KXDafTkZxP6r?=
 =?us-ascii?Q?TxCBX4GLCrsH6pA/IHwWNLxSk43bCuFgSUMg0UFrcsL9WuzKz3NEs2B6dCYS?=
 =?us-ascii?Q?Beo+85Sb7vqegLj5WPHg7oXRWGDR8vNHhR2/n/SNvLm0A2G8hXb9QR3rCKIo?=
 =?us-ascii?Q?1/AxzuQc2K/jcetFzyMjvs7fzzbkVN3q+uMh4ikQFGRllIEhWUPeV5qNRG3A?=
 =?us-ascii?Q?ELHgIZlnuVTA9Y4NdPfUQTuE5MrW8lPDOJB8Xcxilk8R74qTj88HcYQWL9/G?=
 =?us-ascii?Q?HB+2UHSGoQ2ShP8KtnKTLj26OY1cWeDUA4aaMG01YlX8R+QCxqBS8cbab4s9?=
 =?us-ascii?Q?MDa29sPVhtH0fx4Hgupbwa+PkmwgUQZ88CzOz0il0kqP1A73nBUZRrCynlmw?=
 =?us-ascii?Q?D1m1j8IjEkvFqRciUELFcsYvLb2F5zyrmLs4oUJCCE0CrrGq+ddYK9R9KLYW?=
 =?us-ascii?Q?poT9zEntCpQ8uDcOqDiHPMdHm82DRHuccfarE6GTrRCQEgbDEndrjPLoQ5D9?=
 =?us-ascii?Q?YrVM3mzATkf2Dz2ewdptq3UeH1nEfR47wBtG7VCwhoj4PACk8n+lZgc0VxUR?=
 =?us-ascii?Q?iWnGlbdAwaVo2RDxvx7E6q+I5TkqiqyoNnf4+iS0nC6oXi+Gm6AEj4+8TMbq?=
 =?us-ascii?Q?AJ32A2R2FOr3L8CZzOk/Y6S1OFNF5TSWi1ckay36nMUf6FWQi8Ip917Tjo8T?=
 =?us-ascii?Q?xBL67wyXoITzwxy8VWjeIOFZSCoN3gtMt2BtesUyVrO3wLg13S7hzIiYv7S7?=
 =?us-ascii?Q?OONrIaXJUHOMLLaIJrFKKwosh3nYtK0phvB/YQ4LWEvK84RYplZlR9iqR2JB?=
 =?us-ascii?Q?KlCTcoZC140ztWklJVnqUIdauFO5yOjN3vov7HlH6BZuBi/7JbkA/qbz3oqA?=
 =?us-ascii?Q?QjLW4Jzu9KgWwdTfWkAQvE0Qpq3glDfq4ktdHDo3paiWWaq6jkJSYMjVyzKB?=
 =?us-ascii?Q?8ikPO/GKs2ik52MLu5C8ey+V8mssgBhS35w3wfdc0b0cjPCgDrXkYne0b9DF?=
 =?us-ascii?Q?10SSQCbnsyQ9AHAhCIMtd9k4iib8frijGN+qBmvAbRH3cKufrXLcU1+YXLB7?=
 =?us-ascii?Q?sZd2LQanSuwoiIwczc1lj6JccmcEN4jsK0s+t+SYhzBqpNxsui6/g4onh/Us?=
 =?us-ascii?Q?mwKsSdBupOXKOJ3rCUZQVd7IfREEELMAHfGiee+e1IGhcHFBwwkq70SYgj8n?=
 =?us-ascii?Q?/XBLk/oFuRr9nckae3Ixpx8ENxyi7VGFBejZXAWamA7Eh/V/NyCWsMMER32i?=
 =?us-ascii?Q?dsPiplLTUoaUL8PkUzd5mWAJyoUIiUJxAXDVbSVyoZiEui+GEap2g+YjBIHZ?=
 =?us-ascii?Q?qm6TbLJm0KJrb5HYYdXIw2Ke/DZXXAq500e14RzSp/W3tdTW1zV5v4o/3d+C?=
 =?us-ascii?Q?btNBvJ923ecJ3JpcsYKRq/C7yI1tnqgXTHtoEZXMMTH5C30BaO400lEm1V9E?=
 =?us-ascii?Q?dcisMQNmSuSMGSZ+AwUCiVu+Cnv1KxPypaAW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OFGxEc5pjIQ0gZnvmBpxqq1dp3aRNaidy/XmX0mT38DGqptduw8O9p83oA3p?=
 =?us-ascii?Q?safcTf2TrOZ3+WUOzHxcpEMVlA7OIs1S3pYGB14/vB41HkQt6JS7aI3vgDIP?=
 =?us-ascii?Q?b9yrwChIqB06hgDSkEjVl7N9QD1YRIaohfL1oXMk80oPtGPAEl2cgoi2F9i9?=
 =?us-ascii?Q?I3kL/sX3uVh4tcNwOEtI9L4m3qQ6Tf0MDL9Yr9NPWcCjmKV/7lhIxSwcwcod?=
 =?us-ascii?Q?yk1KLbIsGlopnYkyoEJHtiQA/Uz7RjGHNIgxKDOKCynNq+mhzQyQKgnByrGp?=
 =?us-ascii?Q?3G++ha5dE38Z0hG/OxzA0nrWkKCMstU/v2eL8rbi0+sTRMu29b/uUiv86qVL?=
 =?us-ascii?Q?dSAUdcrv4Wd7uKq3EKjduheUjsy36ZezAp25JA8A+ZrVBVN8IHGxJg1WKN3i?=
 =?us-ascii?Q?olHySVrbi7FRz2Jy58SfP60QvOUqd7LtLttenKN2S5uupGXmDAt3H4CN0P+k?=
 =?us-ascii?Q?YmVTWu9Ymi3sKf3ZS82cxhP1EbUtQvT0JHKnfEn8z/Fer7jsNLOVyuI9EQ6l?=
 =?us-ascii?Q?QdXh8P93sWfpIfGMans77IMSz/5pAHqW0qxEiZdBhx8Uce9lXst79ojW6RdJ?=
 =?us-ascii?Q?CKCot8zLWPPGg3tBIkPG/EEyvTyAPLx0FeBfUak36sykQ4ySS983w3cXF4La?=
 =?us-ascii?Q?j2RbyJJ1OXG1WpNnIY92B2IGGY6B52wTX0ZrllZnTpyzgPcVYCsSC0qMJqAT?=
 =?us-ascii?Q?7rVOkr/2CSqcfM1SmejprdeLEuxfdUHc3KV8prz8HKL22XI7z9HuPaIUBTmX?=
 =?us-ascii?Q?Gc7Ok4JdpvMQaEzA+RAlbAAoJyJjgXfyN2D5fZsCGF44I5lx5WKSyzvb+t7c?=
 =?us-ascii?Q?jUY+4f9tqfFwj8RAF08SODI6xSsedVZn/BD48v19jPcX6RjvwHzaHAwXfbb6?=
 =?us-ascii?Q?guR/BtgOW1eXnVPkACvFakOmbvkFx2ZK6l9nJTLa1vy8P+AIgS0El08s15vb?=
 =?us-ascii?Q?bBetswn3g4knKfhXN/5i4j98mY3bmAOBGbcBCoSDCpK+yuKFYQwoMT/6Hv5P?=
 =?us-ascii?Q?Fi9R32VW2FS1LwqS/OttrGj9HHyZCuSeyMcomRJjIzX8O/o621ZypFuUVUyz?=
 =?us-ascii?Q?v9MhhFoRl+R9Tk+Oi4fZXq8ZzV2+RPmn+D/g7yw0Ykr9dJaWd4/gGL7oY74S?=
 =?us-ascii?Q?qcomSGeLA21pzOiqsd8cdcCQSeLUQsdXE4Q/rCOyam6C0F9ZxblTYpBAnPkX?=
 =?us-ascii?Q?vszmfTAFnW6hn/3/3Bw/kq24kDvnLUN6+myyJxcWOKu1UXFq5CM4rmEgq1RO?=
 =?us-ascii?Q?wJVoyjqPlljSjavBsoPSKhiEmNWC86Hqa3rbn03g9lx3X023jsdZRV6ZZtvl?=
 =?us-ascii?Q?VdE6ROqcWTV5WsYbZlYQ63fmrpX6PemSsqZx/hwMB8a8CWa2sa8z+ntVUUj7?=
 =?us-ascii?Q?nj/rK4C/24PRbEkuUgJEsXO+mE1QrhLE45CQbLKKdSIEE/V99rHNbIrD21B2?=
 =?us-ascii?Q?e4H9sbV9pB3lgM2edNNDA+nsaPYSwe/IJi/fI4HXX0UAfs5bftMNmijWfjPJ?=
 =?us-ascii?Q?qvEuGRkvUbhAKqtD4PCtibKDr37FW14GtGUhDlmB3V6dp2US7EXntPRYSNVl?=
 =?us-ascii?Q?8aQaITGOAz+17aM3DlZ9JfMLflvueyZx1w+FSGW8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e5b1d-27ca-4438-fa20-08de2b8d5b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 19:12:05.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez4ZuhaOZVD4/bVIc6XosZHffDRZrnJ0TDqq1rn8E1c8MhcZ7p2ShP0IJpH+AXlPWgfh5eDbpBjknbsuP3cbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8344
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 19:12:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2702

This is pushed now under https://git.yoctoproject.org/meta-lts-mixins/log/?=
h=3Dscarthgap/go.
Enjoy the new mixins layer.

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Wednesday, November 19, 2025 16:05
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> jose.quaresma@foundries.io
> Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 00/35] initial scarthga=
p/go
> version
>=20
> first version (RFC) coverletter: https://lists.yoctoproject.org/g/yocto-
> patches/message/2515
>=20
> Changes in v2:
> * updated commit message in QA readme update (showing single PASSED
> instead of 3 lines to search for)
> * fixed release information in README (kirkstone -> scarthgap)
> * update commit message of previously only submitted to now really backpo=
rted
> commit (go-helloworld: fix license)
> * fixed branch name in README (scarthgap/rust -> scarthgap/go)
> * added 1.25.4 go recipe upgrade commit
>=20
> Alexander Kanavin (4):
>   go-helloworld: update to latest revision
>   go-helloworld: update to latest revision
>   go-helloworld: update to latest revision
>   meta: remove consecutive blank lines
>=20
> Gyorgy Sarvari (1):
>   go-helloworld: update to latest revision
>=20
> Hongxu Jia (4):
>   go: upgrade 1.22.12 -> 1.24.0
>   go: fix buildpath issue for go-runtime
>   go: remove support for GOROOT_FINAL
>   tcmode-default: bump GOVERSION to 1.24.0
>=20
> Jose Quaresma (1):
>   Revert "go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX"
>=20
> Khem Raj (1):
>   go-cross: Disable build with ccache
>=20
> Osama Abdelkader (1):
>   go-cross-canadian: fix binaries install and GOARCH
>=20
> Peter Marko (19):
>   Initial commit: add license, readme and layer config
>   go-helloworld: add from openembedded-core scarthgap
>   go: add from openembedded-core scarthgap
>   go-helloworld: fix license
>   go: upgrade 1.24.0 -> 1.24.1
>   go: upgrade 1.24.1 -> 1.24.2
>   go: upgrade 1.24.2 -> 1.24.3
>   go: upgrade 1.24.3 -> 1.24.4
>   go: set status of CVE-2024-3566
>   go: upgrade 1.24.4 -> 1.24.5
>   go: upgrade 1.24.5 -> 1.24.6
>   go: upgrade 1.24.6 -> 1.25.0
>   conf/layer: switch to golang 1.25
>   go: upgrade 1.25.0 -> 1.25.1
>   go: upgrade 1.25.1 -> 1.25.2
>   go: upgrade 1.25.2 -> 1.25.3
>   go: upgrade 1.25.3 -> 1.25.4
>   readme: update to markdown format
>   readme: add QA chapter
>=20
> Randolph Sapp (1):
>   go: fix sigaction usage on i386 platforms
>=20
> Richard Purdie (3):
>   go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
>   meta/meta-selftest: Fix variable assignment whitespace
>   go: Fix to work without gold on aarch64


