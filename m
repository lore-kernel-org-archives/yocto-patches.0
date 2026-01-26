Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A24D19508
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 17:08:08 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25637.1769447282849280796
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 09:08:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G8sdue+8;
 spf=pass (domain: siemens.com, ip: 52.101.83.1, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBaD4M8PEW2nKSSjWTD+t2YVuieJ4VM1Kk31c2YPFyCfns7LdY6Z0xWkkr1N0Q/QM9+w23pIgG8kBQRjThFFqIG82wgUR8eapjDPXwhaFbiwr78hg5/VJXkGoF0YMe7Ilc2lcr+s+LmIZei71D05TBYzhBAL5O0ZeNrGF0vqEE2EUxcvbphRN2X0ZU23eWgf+DutNz6X1xtUjUHVhWk+dPv4FuiXgRk6aowArn2vE/rndEvjC1VzLtuVjwNP+hsCwJKkhDEHKeWmhnhNPXhHDIY+/Lx5mCBjEwoR0TK/tPcFcQTYPdRyH0n19eEFvhhgWBhmQZJdHbHd221SiOKAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rbrSvS9qBbfX80ZgGYu/w09UOtmjo9VB03i2jlfBas=;
 b=oh7kwVl6D4td/X0WXMJYnwQUT6G3TN5BiNQD5JiWeu7vYDuL898Noz4S/lsAvt0fal0D2/GkOxlklhIh47fMI5DLewBHTdX2gkYkjUvRIckUt9MC6o9GtO/pxlKd3kHASstAWtmiMxa07A8Pv6soQsmuMkhugqCT0XeruFbAffJZKX7W0XbF4ox9PogXac90x0CbVLjymzA7LqFHfMcCt4JEq0MHNevDzNQoxkEiOid16BbyPPhvn49w9+TfKUYktMbTpY3BMNtBM9DMxByLOBeTmOnhVagQzLVF6VdZ6Y/tllkvvjTEVRXjM0U0Jt/0ZXMlAExxsfghFKFUfqhNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rbrSvS9qBbfX80ZgGYu/w09UOtmjo9VB03i2jlfBas=;
 b=G8sdue+8+G/0lc9kjXI1jbEPClTULfU1Ap57+lamPcecrki7e3gAJp7NnuQRTluqupxhQMhd9Ux27Ef+RYzJsfBjZ8FJLV/4LAYpIrGuCavqGemsF1hmdbbpxHShdQxFqNPWahlJcaRnFLp6gN2YbpE5KZ5eapwOQeaAbOFlYzgnNf9W60a65Nen0I/oIIysIaqmcO8rwfgMcoLct13+2jkBqEjzdSUQUkq0hnoRU1KUhC9jdLUVM+gmsLpTF591pmKsbC63Uwu1RaKCmi//qYpJCiCTrsugKXh7fAiCAclezxHK/z76yHVjOhuR+pQBL6Ux36E4RvoNc5vIFn4AwA==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:07:46 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:07:46 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.25.5 -> 1.25.6
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.25.5 -> 1.25.6
Thread-Index: AQHcjUE4cm3bU54EIEKza6/k9gjcJ7Vksf9w
Date: Mon, 26 Jan 2026 17:07:46 +0000
Message-ID: 
 <AS1PR10MB5697FDA216DAE0A6B1FEA02FFD93A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <188DB26C195B2E93.3717435@lists.yoctoproject.org>
In-Reply-To: <188DB26C195B2E93.3717435@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=c5511645-78d6-4466-9c5b-7b753192ebc1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-01-26T17:07:29Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DU0PR10MB5560:EE_
x-ms-office365-filtering-correlation-id: 97a61497-67ce-471b-f65c-08de5cfd6d5b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|13003099007|7053199007|38070700021|7142099003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8HmZwcdlSrSlvtwyuvJX8brt3VCc4AvbaW+mmm+BX1tSrbzYYpH/l/G3AHvO?=
 =?us-ascii?Q?zTcXKEXSb2GTEBaavayLwgwgsUGgUUVFyo60lqcSic3ju2BkMMkFknGdZmHU?=
 =?us-ascii?Q?tU0VjyiSeJ46E+pDDhUw9tOmL+vtJXI/yprfO5BM/HQ4GW3E0loCsAu1ed05?=
 =?us-ascii?Q?bwfofqKrqd2NeHpaJw7KkrjaMsS0l2IKsjBZaG6CyNUpf/a09UTreBMwW6ee?=
 =?us-ascii?Q?bSE1SkJMBVwWRaVRcnZbWRWZM/4WfY+NJbbddpBOUWaqEHnLMHPW13buXrIB?=
 =?us-ascii?Q?GKmOz+E6zPh7VQj+PpZIfjJZIGJVnvocy4FzZrvkg4wssq54443avJ0Tjd6g?=
 =?us-ascii?Q?wS5KRPwkV1uxQtycQuDfFzhJmHgB1JL9YIhZS9cY5xh4SWUFIhBD/ltxC3bN?=
 =?us-ascii?Q?Eo4dgVXI30W1vTFrXIN/3fQllmPPydSg8TL2gmKqSJLDeXH/Xg2KhGTychvK?=
 =?us-ascii?Q?tK9gDhYHnBaaKOsCpn7lrJX47o3/zyyVANnkwRVAwk7BvLNuUllqS5e0ZGaY?=
 =?us-ascii?Q?wYd+w0Cf61II5IoTYFmhhCiJCuh44r+6faF//TEd3jJx9WIZmQzStkAGDBCV?=
 =?us-ascii?Q?MHLpNpz3Fg+j9i0RcESxWfuB3ITNYtSL340sZlFFP+X4CDiKfOmXmNrg6iAn?=
 =?us-ascii?Q?In1yXZ2ZteGuwmDM9+kHGHnLKCIeARQIs5uSQydNYqYh4mWM4+OyE3Ddkmkz?=
 =?us-ascii?Q?fzKW3w+r6fsvrWu8CdhKmxxpFVOKXIqRjiituYEwTEEFzgkNyQQXGmDzlNfq?=
 =?us-ascii?Q?ZsqYvwSitQqckmxdV47GNin4AcRxBYQdR6SSMobw3H4Ow4nKvn2CBvj+zxPm?=
 =?us-ascii?Q?8V+lpd/GpokbUAl1UU5lCgPV3oNZUn2rfpxgARoTKBKcrQ5PvhVzu1Yt4pAW?=
 =?us-ascii?Q?eAc6G9Lw/mo1wBbTT2YkLvjezrSeV/xHUHw76Uftpkc/BqpX8CLajWeiwxhl?=
 =?us-ascii?Q?mIacX5mDfSao6TZZANCfRGWLcR1fIUAFmSmHOEcm/JmUiOURF7wH0Wqy78a9?=
 =?us-ascii?Q?ZyLrxv57GdbR89dmV1niIdZhR9qqMaUMl7y6G86zKkPmeOCAe4KoW4D1QP+g?=
 =?us-ascii?Q?Cs7olZTWu2LheK3hrC5G/ags/o2AH3EgLeQd6IfKSyhdmhipAc7m2XbZ3kKA?=
 =?us-ascii?Q?vYcAMo7kHuttS8d+buuhvE9MKPH5vAZSr7YMGpdsGLWXkmYqAN9YK8L1tnEa?=
 =?us-ascii?Q?+++Vd7wxzi7x+Gsb0TzOm9c9QjXLpOThSYxldCZXKZSIUzmNpw/O3X/hza3G?=
 =?us-ascii?Q?4Kw2XQDzhh2I7L7Dpbrubw4dyKZPXXA9zUjQJqz+jQ5CRmcCfcukh0dLJFft?=
 =?us-ascii?Q?yoR2GnSnMcTy9f+5OfusSqksw1Zck6l/jlacpUbTZl5RoOg4kx0iZklejqX2?=
 =?us-ascii?Q?9/9JPO1AvLJr2zpEveriTbaMaSZJywimxcLwcg6fmc0/40dmqR7mOTVN09UK?=
 =?us-ascii?Q?HxAuM834rMM3IFYjHO8dYlFFk4u1g70Rsn08IfpJViHVTDWS9Vey0d4blmyh?=
 =?us-ascii?Q?UcML87Y3hXsMlusn+z6bmrlaoGHppctEBzdDTWA293ys/UqQ3mT4YrtpT/Hp?=
 =?us-ascii?Q?Dbdvno19mAKfV5vKTUKdljfmQGXxmw0HNOhW8fJo?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(13003099007)(7053199007)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8hmzTHMgEhLzpfpZwNzT81gOQf63oJtcFxrvRBO7DHqMCvg+vZ3oxTdWgiEv?=
 =?us-ascii?Q?O+/0n/p3AMI+vxm3MrGKLmOT7SK1GHFc7HQLIL4gzyRBoqiciHy7BoeGtvcS?=
 =?us-ascii?Q?g78TKYsSi+YEBNgXz9wldUi8KbgZSQbxmI0nZOjW7MTXwZZc+8eNTVRKFTd/?=
 =?us-ascii?Q?jxahdJ3KxYRxmTLFPo6kpzTVw0Ko5wrKOfDTrpyFikqUckhyON+8vl524rdS?=
 =?us-ascii?Q?ddtpwQxIYeCd4xXtBLDkg2HU8ooUQbmVkXCH5xRa3nq4ZCUtwOGKcUZnJsg9?=
 =?us-ascii?Q?Xdl3w9BqCg4Hjq8ti5ldCgEJ74hcrr1FYKv567oVZjKBYloI2SDeT2X0+Hy+?=
 =?us-ascii?Q?EvNXxv1lgjw8s9vJHk0GTs0CP2bcsXQZ9w/2+1Xvr+9rSZigxC0XfTvq74TX?=
 =?us-ascii?Q?2wstV3kxIt2w/liUmrQAq2vj0CtHYcfWHSdOXePVtCyv8dJ6WlP01l3p2nai?=
 =?us-ascii?Q?F/ArKTjy3O0V0yjH4bDT/Swwj5DSvRRNmpVH8HXueOc2Ph21AKA2rDwjnZdf?=
 =?us-ascii?Q?83CW+hldIqNY5fDVNYUT8dYwpg5twTdopfUEkYgvjBoPR/ZhFYkpIMMAxILk?=
 =?us-ascii?Q?9xITr/UXzE7Oo55sQ29j4biKmN3w3QwOrVbFFG4xWc0NO6tWRPqrBWc+8/Vu?=
 =?us-ascii?Q?jh26IHjHP0+51xpERdNGVCXE7cqzQt4YDX+9eKe4sOMbU8x+wC9T1jg10MtX?=
 =?us-ascii?Q?oSC4Z5BeP/b2W+mGQ9M4j+jHreYcghtw9/z/z8G8r80O0ZTmlhyWm/tQoHo6?=
 =?us-ascii?Q?zSmY1wJ0rmnQwRnt/ZYfH8QPWGiREp481ZDVN5CHHIWCkpZ68lTJYPaH+aG+?=
 =?us-ascii?Q?Mz+XzbBBgakPDC0++967q+DinPkNiPuBgtgmEu8vPG3bLvgkwKkFJyFoqVw0?=
 =?us-ascii?Q?5Ms7Geyund4DilrfeaO8oXyas0m8lkvkrxvECVm5TQZH8Ncp2MXmlGUMlZhk?=
 =?us-ascii?Q?XiwD4+AFSXkUvPwDm1pAwumlUiBJM2xp11ZXawz6HUUgvhpmjdEmGfdsAUXE?=
 =?us-ascii?Q?wu7aLYRIiDkfqI6uv0XIfveqz6fR/jxke+2FJzevnEsAKPGdaSi2jqLLTFIA?=
 =?us-ascii?Q?yorx3xoZ0AmvdF462kuIjayrQNsz1RpIRvn4tWC6DlHjgrOe2E6hOOX2z0wG?=
 =?us-ascii?Q?uZlwjUinyXqyCcc/TQG/2mMSnlaZrbhrmJXANtFTVhPVIrUNwbTtq1LHeIv3?=
 =?us-ascii?Q?hO0suHOZ8Pzl28JDgHZG3gfKzQX3AahiixeLs/Aa48+uG6jN2pOFm4BGr57u?=
 =?us-ascii?Q?VTnjn9Mjc0zwIt9umaxuv/MjLxNQMVSHBbZptqLVClYcXGYxgecli189P0Kx?=
 =?us-ascii?Q?Bfhv3peq01ppRm2QlKmXJdecyQ99ADlXcq9YlwxUo1Pk8zNiY3DxwhAfTL1t?=
 =?us-ascii?Q?CQJEos3b7ssSJpjk6eSgJAtrHxa1dwniTHMI62BSyLq6lNjerfuy8ooS6qzw?=
 =?us-ascii?Q?VO7yT+2lPepGs2YoaHWRt1lg4QPlHjZTM/LRWAKFOosBYrzBMYWaQYcF4njV?=
 =?us-ascii?Q?J4b87+VwrOm/04pX6rVgTAGSThDl/w0aNyq+uKvkYqM9jgj7UagtEjBvjkgT?=
 =?us-ascii?Q?jdBw0OXKby6pObqH6EfQi6tLPivjgdUj/c35bvcTCleuOAmwW946JZUpGL6R?=
 =?us-ascii?Q?w4Pk8CSkFyb7Jz79xKrp7jSrulguRNUGWcTA/XcMioUIzrp1Nh9AymPCJG3u?=
 =?us-ascii?Q?77YPheznmiNjV3DDQyCoY2rrhbV3r02HCfZkupSq80tuksBZx4/Y+Ulfup4K?=
 =?us-ascii?Q?+C89NU/1GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a61497-67ce-471b-f65c-08de5cfd6d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 17:07:46.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S71BAvv87dj6kKmXVypHkoR8DQXdZCXYnyroT64KoGmnLcUSp211A6Xb68L231cnv2X3aN03uLnHEnBAicY0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 17:08:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3087

This is now merged.

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Peter Marko via
> lists.yoctoproject.org
> Sent: Saturday, January 24, 2026 15:53
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go: upgra=
de
> 1.25.5 -> 1.25.6
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.25.x release [1]:
>=20
> $ git --no-pager log --oneline go1.25.5..go1.25.6
> 69801b25b9 (tag: go1.25.6) [release-branch.go1.25] go1.25.6
> 9d497df196 [release-branch.go1.25] archive/zip: reduce CPU usage in index
> construction
> afa9b66ac0 [release-branch.go1.25] net/url: add urlmaxqueryparams GODEBUG
> to limit the number of query parameters
> 2526187481 [release-branch.go1.25] cmd/go/internal/work: sanitize flags b=
efore
> invoking 'pkg-config'
> 082365aa55 [release-branch.go1.25] cmd/go: update VCS commands to use saf=
er
> flag/argument syntax
> 4be38528a6 [release-branch.go1.25] crypto/tls: don't copy auto-rotated se=
ssion
> ticket keys in Config.Clone
> 525dd85363 [release-branch.go1.25] crypto/tls: reject trailing messages a=
fter
> client/server hello
> ddcf27fc8c [release-branch.go1.25] Revert "errors: optimize errors.Join f=
or single
> unwrappable errors"
> 14f50f6e3e [release-branch.go1.25] cmd/compile: handle propagating an out=
-of-
> range jump table index
> 4e531b2f14 [release-branch.go1.25] runtime: mark getfp as nosplit
> 6f07a57145 [release-branch.go1.25] runtime/race: set missing argument fra=
me for
> ppc64x atomic And/Or wrappers
> ea603eea37 [release-branch.go1.25] os: allow direntries to have zero inod=
es on
> Linux
> 93f5d1c27e [release-branch.go1.25] os,internal/poll: don't call IsNonbloc=
k for
> consoles and Stdin
> d5bfdcbc47 [release-branch.go1.25] crypto/tls: use inner hello for earlyD=
ata when
> using QUIC and ECH
>=20
> Fixes CVE-2025-61728, CVE-2025-61726, CVE-2025-68121, CVE-2025-61731,
>       CVE-2025-68119 and CVE-2025-61730.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.25.5...go1.25.6
> [2] https://groups.google.com/g/golang-announce/c/Vd2tYVM8eUc
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.25.5.inc =3D> go-1.25.6.inc}      | 2 +-
>  ...binary-native_1.25.5.bb =3D> go-binary-native_1.25.6.bb} | 6 +++---
>  ...oss-canadian_1.25.5.bb =3D> go-cross-canadian_1.25.6.bb} | 0
>  .../go/{go-cross_1.25.5.bb =3D> go-cross_1.25.6.bb}         | 0
>  .../go/{go-crosssdk_1.25.5.bb =3D> go-crosssdk_1.25.6.bb}   | 0
>  .../go/{go-runtime_1.25.5.bb =3D> go-runtime_1.25.6.bb}     | 0
>  ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
>  ...ime-when-using-cgo-on-386-call-C-sigaction-funct.patch | 4 ++--
>  .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
>  recipes-devtools/go/{go_1.25.5.bb =3D> go_1.25.6.bb}        | 0
>  10 files changed, 11 insertions(+), 11 deletions(-)
>  rename recipes-devtools/go/{go-1.25.5.inc =3D> go-1.25.6.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.25.5.bb =3D> go-binary-
> native_1.25.6.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.25.5.bb =3D> go-cross-
> canadian_1.25.6.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.25.5.bb =3D> go-cross_1.25.6.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.25.5.bb =3D> go-crosssdk_1.25.=
6.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.25.5.bb =3D> go-runtime_1.25.6.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.25.5.bb =3D> go_1.25.6.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.25.5.inc b/recipes-devtools/go/go-1=
.25.6.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.25.5.inc
> rename to recipes-devtools/go/go-1.25.6.inc
> index 47d5c39..2c31c4a 100644
> --- a/recipes-devtools/go/go-1.25.5.inc
> +++ b/recipes-devtools/go/go-1.25.6.inc
> @@ -18,4 +18,4 @@ SRC_URI +=3D "\
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>      file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "22a5fd0a91efcd28a1b0537106b9959b2804b61f59c3758b51e8e5429c1a954f"
> +SRC_URI[main.sha256sum] =3D
> "58cbf771e44d76de6f56d19e33b77d745a1e489340922875e46585b975c2b059"
> diff --git a/recipes-devtools/go/go-binary-native_1.25.5.bb b/recipes-
> devtools/go/go-binary-native_1.25.6.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.25.5.bb
> rename to recipes-devtools/go/go-binary-native_1.25.6.bb
> index 94de9ce..261f7dc 100644
> --- a/recipes-devtools/go/go-binary-native_1.25.5.bb
> +++ b/recipes-devtools/go/go-binary-native_1.25.6.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "9e9b755d63b36acf30c12a9a3fc379243714c1c6d3dd72861da637f336ebb35b"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "b00b694903d126c588c378e72d3545549935d3982635ba3f7a964c9fa23fe3b9"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f0904b647b5b8561efc5d48bb59a34f2b7996afab83ccd41c93b1aeb2c0067e4"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "f022b6aad78e362bcba9b0b94d09ad58c5a70c6ba3b7582905fababf5fe0181a"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "738ef87d79c34272424ccdf83302b7b0300b8b096ed443896089306117943dd5"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "bee02dbe034b12b839ae7807a85a61c13bee09ee38f2eeba2074bd26c0c0ab73"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.25.5.bb b/recipes-
> devtools/go/go-cross-canadian_1.25.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.25.5.bb
> rename to recipes-devtools/go/go-cross-canadian_1.25.6.bb
> diff --git a/recipes-devtools/go/go-cross_1.25.5.bb b/recipes-devtools/go=
/go-
> cross_1.25.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.25.5.bb
> rename to recipes-devtools/go/go-cross_1.25.6.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.25.5.bb b/recipes-devtools=
/go/go-
> crosssdk_1.25.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.25.5.bb
> rename to recipes-devtools/go/go-crosssdk_1.25.6.bb
> diff --git a/recipes-devtools/go/go-runtime_1.25.5.bb b/recipes-devtools/=
go/go-
> runtime_1.25.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.25.5.bb
> rename to recipes-devtools/go/go-runtime_1.25.6.bb
> diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-
> content-based-hash-generation-less-pedan.patch
> index b55ad1e..6d75266 100644
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
> -@@ -2631,8 +2633,25 @@ func envList(key, def string) []string {
> +@@ -2639,8 +2641,25 @@ func envList(key, def string) []string {
>   	return args
>   }
>=20
> @@ -136,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS,
> checkCompilerFlags); err !=3D nil {
>   		return
>   	}
> -@@ -2648,6 +2667,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> +@@ -2656,6 +2675,13 @@ func (b *Builder) CFlags(p *load.Package)
> (cppflags, cflags, cxxflags, fflags, l
>   	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS,
> checkLinkerFlags); err !=3D nil {
>   		return
>   	}
> @@ -150,7 +150,7 @@ index 7b073165d5..1f618be0bb 100644
>=20
>   	return
>   }
> -@@ -2665,7 +2691,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir st=
ring,
> pcCFLAGS, pcLDFLAGS, cgo
> +@@ -2673,7 +2699,7 @@ func (b *Builder) cgo(a *Action, cgoExe, objdir st=
ring,
> pcCFLAGS, pcLDFLAGS, cgo
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> @@ -159,7 +159,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if err !=3D nil {
>   		return nil, nil, err
>   	}
> -@@ -3229,7 +3255,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
> +@@ -3237,7 +3263,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> diff --git a/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-ca=
ll-C-
> sigaction-funct.patch b/recipes-devtools/go/go/0001-runtime-when-using-cg=
o-on-
> 386-call-C-sigaction-funct.patch
> index 33e3b03..d27809a 100644
> --- a/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-
> sigaction-funct.patch
> +++ b/recipes-devtools/go/go/0001-runtime-when-using-cgo-on-386-call-C-
> sigaction-funct.patch
> @@ -168,7 +168,7 @@ diff --git a/src/runtime/os_linux.go
> b/src/runtime/os_linux.go
>  index c9d25a5be8..f9fe1b5f33 100644
>  --- a/src/runtime/os_linux.go
>  +++ b/src/runtime/os_linux.go
> -@@ -486,7 +486,8 @@ func setsig(i uint32, fn uintptr) {
> +@@ -487,7 +487,8 @@ func setsig(i uint32, fn uintptr) {
>   	sigfillset(&sa.sa_mask)
>   	// Although Linux manpage says "sa_restorer element is obsolete and
>   	// should not be used". x86_64 kernel requires it. Only use it on
> @@ -178,7 +178,7 @@ index c9d25a5be8..f9fe1b5f33 100644
>   	if GOARCH =3D=3D "386" || GOARCH =3D=3D "amd64" {
>   		sa.sa_restorer =3D abi.FuncPCABI0(sigreturn__sigaction)
>   	}
> -@@ -562,6 +563,21 @@ func sysSigaction(sig uint32, new, old *sigactiont)=
 {
> +@@ -563,6 +564,21 @@ func sysSigaction(sig uint32, new, old *sigactiont)=
 {
>   //go:noescape
>   func rt_sigaction(sig uintptr, new, old *sigactiont, size uintptr) int3=
2
>=20
> diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-
> by-default.patch
> index 5117379..15ffdb3 100644
> --- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> +++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> @@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
>   	if err :=3D sh.Mkdir(a.Objdir); err !=3D nil {
>   		return err
>   	}
> -@@ -1731,6 +1748,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
> +@@ -1739,6 +1756,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
>   		return err
>   	}
>=20
> diff --git a/recipes-devtools/go/go_1.25.5.bb b/recipes-devtools/go/go_1.=
25.6.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.25.5.bb
> rename to recipes-devtools/go/go_1.25.6.bb
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3069): https://lists.yoctoproject.org/g/yocto-
> patches/message/3069
> Mute This Topic: https://lists.yoctoproject.org/mt/117435349/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


