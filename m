Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04742CD5BD1
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 08:29:01 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3476.1780216132156140912
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 May 2026 01:28:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sakykjH/;
 spf=pass (domain: siemens.com, ip: 52.101.65.54, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ1dNmSBzQSfaoTlpbWZ2ZozukVoOkuw9f4M8+xx+GZygykrXrfXt0VW7jjjkTM0r4CqgEc+KbU+MvJTuXk1mhg2GrAbqg6IsEpafoZOImdniVJzVhYOU7bDUsZYz3wYT6f8Agj7A8JqD9h5VGhtF7d4HeAH1JMD4ObMcWIbATc4grDUaSvNqRGFW/b00JqPbSkfFgcHXfoRWf/WUFyCY3o17WMtqTP3NOPGhE/8jUolzsP9wEUsjEiEe2kcnE76t96+N33C5JbvX5YRgf+mzLS2u4TUVgxNHpg7YrwXrTT49bPAYRFXtmy43fzsOKd1V5YymCe8KLi1JPW0PnOHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5rEgRStkWazdxsJMeykBBm8feaSQUJSPm/kCz6ZKAs=;
 b=qTF+eZ7R/aXRyFqeKPwe5tYvclM5Lm1QdzN6AfpkqAvGsEbet1eaz23XkuNmhQrLgd6L483HMx3CH7DksTT6CpDjl9d/z5nBwvj9ryXpDc/tY7OEEQxOgIaEvVtJx7XLpibwF6WiMiDHtkR5xM3w7mFqOi95ri8zMGihm/9K6r2QV16ty498iYNbACkSfQYpFexmSDp10PUxKd5OKCma49Avu5PBkZDcSj+XUR6UXoHcesnOCUJjkg87tlo+SU+QhW0gzZF+6M8FcG7ePxrruDwFybdtB+aYukwf4C3HcvqP5ld5zhcszKtxFfY0VSaTDRKvdSnonz07H4gyodDLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5rEgRStkWazdxsJMeykBBm8feaSQUJSPm/kCz6ZKAs=;
 b=sakykjH/n8otcmx0Qtz69vRSKVb02FUikWSkhq9RHRD8Sqsb8psl0G+zQHwdMmHbOM5EECmvfulKpOWAR1UWtbnBmjHdZYIyN8ebU67D9rEsRbCUpDOaTNtnCjlH3QZZ2voN9sYZ/6Tt/9eiIcHXixvQAyphp2BhbmgBxfuCJfOPWHVwG93maLV/u4nkNKWBCtp+oi8kqc2QUG8fL1Q96VepaZ+Iv4V30xosRiVXONgx/W4bMHLAxq1VFTziiLt4tDxuRlUKYNAa2HeMftOfvghBQfQERt17Uaz1HQd3Isn1De2IbpZaMyQDihki2W4HqrxvWE0FYuMPFOEShfuUhA==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by GV2PR10MB6672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 08:28:45 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 08:28:45 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-metrics-meta-oe][PATCH] patch-status: add wrynose
Thread-Topic: [yocto-metrics-meta-oe][PATCH] patch-status: add wrynose
Thread-Index: AQHc4xMsfx+1JfVj2EWS9DvG8Tao37Yn6Jgw
Date: Sun, 31 May 2026 08:28:45 +0000
Message-ID: 
 <AS8PR10MB50731565724064698C2819A1FD142@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260513200009.2474228-1-peter.marko@siemens.com>
In-Reply-To: <20260513200009.2474228-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=dceea9c2-0a3a-444b-9e02-fbf5f426a497;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-31T08:27:52Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|GV2PR10MB6672:EE_
x-ms-office365-filtering-correlation-id: b683aa3d-2e85-4431-c836-08debeeea155
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|55112099003|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 B7oMioRuMDW0Og5rdP9P45UiO6p4NBs7IqRijiPowi8vYN/5NXhmdGeKxHwb/+a5B41+fjz/LjoxMih7uUJ4sdqY/3u0B0CxdfeKCr2ZpFC94OUWQKvJwAL1lkyqNnFm2MJwg+KFQMwWY7QH5KC3Onotb6+J0EdkJh9bxwy9OPm9q2SnC4bBRX/n2aygaW47cfqD51Q5xoyAS8Y82PW05Aw1i79d9BD/d+7YkU/6wtBbH/e8s1VDs8fP4yFXaY0ga6Z4K6/+x9q3iH9Pq01QkPtlpDEmD3dB2aRDUoi4sQyesSQCuwX9GcWs4cj03Akt6YJu5nf4moh4UpgHUrIvr3RlP6G4EEvXv5gCh07MmSWFMyDWwWoiBk7pdpo0iE8P/SpBs1QcpjYb2gvWIu2GYNSQ24d13tL4MGNTH6k89WX9OgTX6vIrist7NnwUCdtobHelCsm/SwaHr7MxsrTeAETF4vZ/urDGWlMxYWMDq4XOIZfOVL+7j62U2i5V/pHN6Gq60ry1zy1BmrmoNtz4mNCFziTvARyjXFLqFTRYTp9gpEE1h+jIkVFXVzhDkW/yoaqFa2OhKMOBQS6LnZW1DZQhw382J7H7QpaJ2z5TmNFSU/oUpMKfjYSK7Rz5Gi86PIlcNq4qt+WRt03ANWUv98vjwOazKc40WpsV2sMNV1bwU6eUBNpVjM4AgUcs98ojYwuDhx+DevfrRPVAUORaUI7bx/mLKz/6TMB+CENDA0v/zdLjmBSPVJGriG6VEfec
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2hb3N14IqmTS4N68qWS/gL1J+ZI6k8lRvkt/zaEiuMBdQT6dcCRpT+vZ+hCI?=
 =?us-ascii?Q?4WuSBmLkXG41jo45X8mrWW3f9e11gBTK+XPyXux8UeWBsDfLBKFiOcMWPqUU?=
 =?us-ascii?Q?uF2/8lueG/x6APsVwp7SVBWzGeBXztDXy2hSB8MVwHdvzM382KdYSumGMS0d?=
 =?us-ascii?Q?8kXlipM0fUQmAS/9PYkrN1YOSiqzD+E6gOSn61JlsylLalZmtgpX1jo4goSE?=
 =?us-ascii?Q?6bDxfXjM8FGESLVnIbJlyruOMG01S79T+Xt0+kJhohb+Y6ytYnMeOXftToPE?=
 =?us-ascii?Q?vQDhhzsiExeZKvFytnFTRSxz5w7mLfJYqqNHm8YxvAYqeHlETFziNC+HL+m6?=
 =?us-ascii?Q?2UaxWMPseKNlUN3TTFa1Uxq5zXaOoLuRmkB7MoaGHU1VEIQT/mnhBCKR5Agv?=
 =?us-ascii?Q?G4qhY6joWgPwRhDEcgFj1UA7WsAVujRXS2SHi+f77kNEHuSnQ9ohrtPhs2U8?=
 =?us-ascii?Q?1A2q51KzAeX8y7PtSGN/S+wTeG2hpxDYFxBPqKeT9RhtaH/buDSyKoIOjbLS?=
 =?us-ascii?Q?Ax4xzuG/npThSCxm3gdehORzHZ8wZE+HDgIBejlDGKTux9xPP/OWG4FL63kx?=
 =?us-ascii?Q?y7z1Ec9s4bf3fHuvaszXLyku8RRyWt9eUxbuFzp4DAaoQzT/zya3TRZ7Cyig?=
 =?us-ascii?Q?i99Dm/3vTKFA0K+F85RKOtq0Z/l2RRSnBu71wrdf0B8xd0eqjgnirv5UAjrO?=
 =?us-ascii?Q?AsWsr3f5UKDyXXIojA8Nkjl0+4y3ri2+d6r3nFh5/ZSIxR6hQD93Jg2Fer5f?=
 =?us-ascii?Q?9idoJMe7N6s5Lt0HpxqinjT6oPepzTcELG61xbwSqrowV3xFUndx3bCO/NGp?=
 =?us-ascii?Q?qyh0ooQmjpjQqwRLzmsnXWVeaV8rx7Bedzp8485GVdO+hBJRjw0D9XBZyk8W?=
 =?us-ascii?Q?VnK4H+D8k1FuS4808OejWMXPQ6ppusbCGSoekRFpQbg7Y/U0U2fDwC5VRKJP?=
 =?us-ascii?Q?dIuEP8IgZ4uTV73EB3ar/eSpli1x5oD8Vz2e9xvjhg44+ukpVsAwG8jLp0pJ?=
 =?us-ascii?Q?/mJFxoFTT4mtT2hkdhmCPzFr2UAcIOh4ol+X71C++aFEobc6+M7Ndf9QexKE?=
 =?us-ascii?Q?8zvsEz9GEp0U9KqrwampVeIkucK0n4mRNYE3lpUy3oXBIGeeMUpRCqvWa7Jp?=
 =?us-ascii?Q?XAdCWkOassDrhUny9Rbaapr68rLvYppgxUfq5sNJb5uy1yXLt82tvkML/odp?=
 =?us-ascii?Q?5w8/ZPETX6UV7NhQkb6Sg/5ivbGFResSwSnrFvJGes9w2XzhVA9u9gDN+W72?=
 =?us-ascii?Q?b11aMoE4jzmwzBX4YboPu04yKt4tcnot7nmpELMuBClksPdSvZBZUSbeZt2/?=
 =?us-ascii?Q?KdID/r8wKLL4bmbAtiREXRcpfbxTs7nH4HqsyfDK5/RfsXzFGYSzdSH2g6iZ?=
 =?us-ascii?Q?76Jmy1jvU4w2QSkr5iefJ4ZzuNDJCSWrEtnY2n2OER+G6h7y9zEVDzOOycbU?=
 =?us-ascii?Q?YSvcEft6JQvm8gJZA8EbG8btMGmaJwp69lsCoF69JV2u/ibbWl1kB5Xd6tpl?=
 =?us-ascii?Q?azFrgOjmK/ibSR5Q+baMR5Q+DrQToGLTdynWDRs1QKU5gUZLMz64SLWZZa0y?=
 =?us-ascii?Q?qtkj0Qem9f0RXEeWmABSCGXgjW9z77BzmG25mxyyYlmMnz8r0AaNzQ/7vZuI?=
 =?us-ascii?Q?UX4IQwwYi7FvID5mt2G1f3hwdkNLuzSHHso3OZ+0GYq+BYtvrPrMtrWmGD4k?=
 =?us-ascii?Q?W5B4SNqxVRZWSjyXjgVU5MZx5L3ucAkx7b3e3u6Pn8Wzr1OQmyRxyqXT8D5W?=
 =?us-ascii?Q?G3nVvUtggw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b683aa3d-2e85-4431-c836-08debeeea155
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 08:28:45.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIYy9pEG57ETnvq4osq5U7ChJdYK4anwQaACOdp+v2y76koVS1XyjMod//+NY/mYX1BbLoHcApoxYbABIxLZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6672
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 May 2026 08:29:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4088

Thank you for merging the patch for oe-core.
Could you also take this one for meta-openembedded?

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Wednesday, May 13, 2026 10:00 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [yocto-metrics-meta-oe][PATCH] patch-status: add wrynose
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> See https://lists.yoctoproject.org/g/yocto-announce/message/386
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  patch-status/index.html   | 12 +++++++++++-
>  patch-status/releases.csv |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/patch-status/index.html b/patch-status/index.html
> index cdd89e6e..c784151a 100644
> --- a/patch-status/index.html
> +++ b/patch-status/index.html
> @@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
>          <summary>master</summary>
>          <div id=3D"cve_status_master"></div>
>        </details>
> +      <details>
> +        <summary>wrynose</summary>
> +        <div id=3D"cve_status_wrynose"></div>
> +      </details>
>        <details>
>          <summary>whinlatter</summary>
>          <div id=3D"cve_status_whinlatter"></div>
> @@ -125,6 +129,12 @@ SPDX-License-Identifier: MIT
>        createCVEList('cve_status_master', data);
>     })
>=20
> +   fetch('cve-status-wrynose.txt')
> +   .then(response =3D> response.text())
> +   .then(data =3D> {
> +       createCVEList('cve_status_wrynose', data);
> +   })
> +
>     fetch('cve-status-whinlatter.txt')
>     .then(response =3D> response.text())
>     .then(data =3D> {
> @@ -212,7 +222,7 @@ SPDX-License-Identifier: MIT
>        upstream_status: 'Malformed Upstream-Status',
>        inactive_upstream: 'Inactive-Upstream'
>      };
> -    const branches =3D ['master', 'whinlatter', 'walnascar', 'styhead', =
'scarthgap',
> 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott=
', 'gatesgarth',
> 'dunfell']
> +    const branches =3D ['master', 'wrynose', 'whinlatter', 'walnascar', =
'styhead',
> 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister=
', 'hardknott',
> 'gatesgarth', 'dunfell']
>=20
>      const general_options =3D {
>        tooltip: {
> diff --git a/patch-status/releases.csv b/patch-status/releases.csv
> index 1e8d95f3..48368ed5 100644
> --- a/patch-status/releases.csv
> +++ b/patch-status/releases.csv
> @@ -1,4 +1,5 @@
>  Name,Date
> +6.0 (Wrynose),2026-05-13
>  5.3 (Whinlatter),2025-12-16
>  5.2 (Walnascar),2025-05-08
>  5.1 (Styhead),2024-10-17

