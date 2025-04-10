Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7700C369A9
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 17:08:04 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.17])
 by mx.groups.io with SMTP id smtpd.web11.3905.1744304880666611540
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 10:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vooh522Q;
 spf=pass (domain: siemens.com, ip: 52.101.72.17, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbLmKuwxVFAT8z7aSiW7MMGLqPofjlGuC+QOOoIhlziuEUXZhvkPbZyAYPXlgKT3IwydqYFQYUYLgZXooAgRP7johX5l+a4cYY2Bd8jctCKPPxVe0QTe06O916DLcn8+wks/TUZRJ7Enju+/cOWzQBT77uTyEohuvpt8xMt1AelO/CV6abGyAn6YoiQqepTd15nqhnEmJpBtrId0FKcooVTVEk29oNRtUa9507bpkgs0D03T4fA75dl/iF8Up7MpaOlJCBVbB5V1HCOK14pA4mBphc3ArMJVWsx1DsCrWRp0c9hJ/Z4aV+HrgUKBqT0fa/CKcum0MSQ1b2QnAsE35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKzht/0rKEtHzDQkHN0O66lWP+kRoah3x+r/SVwlZEQ=;
 b=b9YibLNDm5yOF3dgUlE/xSKNRBqtHiVib1OI2os41UKR2MflprTda2OprpJMsEatZLkl7dH2pw8u4AZgczzFUqjnsb2fMEeIbnSmNLSGgqV0vvP731dVBmxqFZdsZxnDHrcTEjGEL3RpPeA2aHHSLpJko/YxF3xHF565ZtkE4M7q3X8ZkfRwvvN45IGplv7JAtnM4x/hvJpMrztDwrQT31k5flKFknkC7S6uPtU5wO3YDRYs7b9EvOIfzpruFkirWT+hh9Dy+raDRzZGz/iTPmIyPjUozm/5G2o6YMwyVfz0T7e7kEkg9hjg+vaVTERq8TsyMGoce3cPthoy8Kf0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKzht/0rKEtHzDQkHN0O66lWP+kRoah3x+r/SVwlZEQ=;
 b=vooh522QRfVCI3QFwfGi2gsekngL4CbIG3R0GwJOmq+BYQEAsQJeqngetiWuABECnnDt5Fei1E1TRcvmD7qGZMxBZYRpLcOxJTigFYOJzVWXM+B575/MbFu1KG8hUnO+Np8SfSUjp6+xJTbHqwwM42c3yFaj97qWiy6ckOYb6InCKjGMAJmypaYEX1IY6YwntoCh7e9GKEYPK/QjVTifidiMYpkKYSFDzCVZ1D/IFLx+RpQjK4JJ+cdXOgG4mNbPIwjQxg+hKnb4C3cvZ8SrU/qgsWuZmDr6BnDuUR5/K8yNUl/+4lS8OvO0VP6oyWkdoSk8YJU4WLYb9vt0B/Vmeg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS8PR10MB6433.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 17:07:57 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 17:07:57 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.24.1 ->
 1.24.2
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.24.1 ->
 1.24.2
Thread-Index: AQHbqjkPboMDjMkpg0awt9DToVIFXbOdIWfg
Date: Thu, 10 Apr 2025 17:07:57 +0000
Message-ID: 
 <AS1PR10MB569751BF90E3B789828A992FFDB72@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250410165229.9748-1-peter.marko@siemens.com>
In-Reply-To: <20250410165229.9748-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=8846c66a-f921-402d-969c-62caff5b0467;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-04-10T17:06:39Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS8PR10MB6433:EE_
x-ms-office365-filtering-correlation-id: 1e5b190a-a088-432a-88f2-08dd78523da5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?RNtyihea7tzhPhmoXO8vSGjJgQ2zJqO694Dq1Ph4WcmG2PS3JFrQyUvA4IKF?=
 =?us-ascii?Q?P51xw21mTrmbW6qsokeKocxL3lFJtRLuLmCp4cuKhrtB/L+azgqagtIHwvSj?=
 =?us-ascii?Q?YEP1Y8YK1ECBL1FI3asArQHuxwROtZ3Ule2mkGRJR5NnfzdVqsvmZ4VLhItD?=
 =?us-ascii?Q?2ays9OWmPnZNJyikbbVTeBRnH9WnLyYsh+EtyOk+r5/CFCaGTkKZECf9VC2m?=
 =?us-ascii?Q?63//pn22dac/RLhlWkG4b0LygNn52/DD4DQtDM2BWIp5xIIFroVPFpdOmCCW?=
 =?us-ascii?Q?L6mXLkbujU0xzmui51KvRNbd6WWr3bR74dB72nL2GnFsonbNeo0wYSMwFHAQ?=
 =?us-ascii?Q?WAmRAif+Knm7orUcOQBwENPJT797pxJ4rR2/KBZl96Y3V1TxK7cqmDkdxINv?=
 =?us-ascii?Q?0BptkexFgIqQHxT4Aqzz7Jhnd09COeXe+81/CxlIu6V407YORUUfuRp1lct0?=
 =?us-ascii?Q?t3AY8ygqez2+JN/vKnO/ZS9ukLfyBobnieUfs+OWz5ekVpm6g/bUb+sUdE1A?=
 =?us-ascii?Q?kfuGxh5lqQbW8akmQxvV/z1R5W6eTX+bu0OIdXQXk+KJ7HFpaGxYigtfE0sA?=
 =?us-ascii?Q?ZUUZe2aP9vg0WiUd6pnePukApGnGMtpId4H4c39uPx4lL87geiLsZMcYhYFe?=
 =?us-ascii?Q?1P4DikbmWZB09/BNU6ciMwduToYcsD54ivw5+hlKbgBwioNHrYiD7hEqepMB?=
 =?us-ascii?Q?M1pQYi0dR5v8czcZmxrlIj4XWZlsOADKAul9chtChh/Q0MliSM+OWjFZxOFW?=
 =?us-ascii?Q?S8OybsXV7JD74Jyx6HnuCjuWfuwIOMaEXnfEunurQbd/PcdEsRtL56UUDnOr?=
 =?us-ascii?Q?XrdjYaH6dcl2Mi3ffH4/dwCRcBuBbvjhftQEjWSVLzNXJquCaT3ATrIgwrvE?=
 =?us-ascii?Q?DTcNmYDX9p9OMiMv4ugPliD4pSUDavqNJbWMBdAGdLXJshJBYnOe4TRUp7+m?=
 =?us-ascii?Q?HBKSHus4akBUDjkjZLZ6pJp6lfywPWFcZk+VAslgW0BQXYkqp+2CEwyBrzjp?=
 =?us-ascii?Q?cXc0a0BIAPAyHSO+D3aEtQm7wCxkhrVa6jTCRrNtrdjTtsegiDMYmqt+5tI9?=
 =?us-ascii?Q?i76XH06NJ5oL8T32cvj5SiwHt0vFruiG1YeCVvRFilnq5nnJ54Myuie4NM1n?=
 =?us-ascii?Q?6aPYgMBDk7QuCFONtAZFgB+OpXTTw84Cb6jYx/XwvCazM62Ac1OhyFu53WFX?=
 =?us-ascii?Q?wNaAAyKcrSHI918spNcPGhCjM5pL8S1hYyyY1jxILY2ENTbJ79TmOmsdCZAF?=
 =?us-ascii?Q?oGhE+Gm0t+Qq4904mTHkaIwMqMD74lGAUgP1RXIDC3RgFeO1PHfKrWKfzwsN?=
 =?us-ascii?Q?UF1IXgQgCeFy19XO/b8Jgz3rUtcWk5B4damo5yEVJZds5bNNIRxnSYG4dikF?=
 =?us-ascii?Q?RVvNB3fkkpGWNwQIUxJRacomrYNBYXGEU8yCd0UQxz/37vaS/Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?NrkqpWwHIpf3Nz46EelauwYq64qhhdT4VvECI9apc+kCYhUT+2aw3EC39ERa?=
 =?us-ascii?Q?ygyNf5bq1XzwmUKFNr1tWbga1yHSp45aNaPUZPJ+fFPobB+w4NU0R+PjBv8M?=
 =?us-ascii?Q?lojsg+iMAByuKZhyjYwnNU4LYDPqGoiKc7INHoHiaFxyUYXcdg/rykP4YQsh?=
 =?us-ascii?Q?DEut3YdIdGde0Nze602OlDdhIrNuBn5oDM+WVXC6Y+qM3uafBWbkraII80Nd?=
 =?us-ascii?Q?XKwOfEXle4muJb8+b+Vw3Tv48B7UNcG+SXfzPNz3UQFY+SWoLIfVyzepB/I2?=
 =?us-ascii?Q?iCJE/Nt/ifggcC9f7ZzMZJx/LAq7uLReG0iT0SsvVETv3I1fSkFgGsFwDr10?=
 =?us-ascii?Q?JSn9SjMlXB75q/IC+E34Biidp2BMZtLl6EaLVzukZQxNt+QxvRlUZXdLHb5G?=
 =?us-ascii?Q?24hGvcCjCcnP3jcwPAHiTUQSAs5gm909MDAOosyqn5lwmzaR3ILmCal3hrek?=
 =?us-ascii?Q?5FxiUajwFbHxj3LUCcsar9IC0tm27w6vyhZRjbxJz227R0hpkJ3+LEyM7IeT?=
 =?us-ascii?Q?PYaKJWk0ILF7AaBN/cKslFqvng91xfcYQs2PSIIpl4oZIgQHlhM4GyGdNvOa?=
 =?us-ascii?Q?uNCxLXpfvZNV/ThUOlB5+UtvIWO6k4qaBFbDV24vzRCN2w6y4WJkIvpwlMrH?=
 =?us-ascii?Q?bN8r25PGRoZcMRRkD6G3uWiIecAroSfq3Y7P9yhFSYJJI9fXTKToBKICzk1t?=
 =?us-ascii?Q?a9DWBBgAx7N/UJ4uLOsEDuJ0WC76BGj96lT+uPTmDL5bNrZV6sFp/TLa1jyc?=
 =?us-ascii?Q?FyHCk6XBIK6sX8N331u5EFVJDr/J4eTB5z5B2N76gR3PgBDqwntA0NMhQwnt?=
 =?us-ascii?Q?BMBrlX50l7shIiG0LjbC5KvXuMnTpfz3xhJgt4F/Lew0GNAEm/lBy2a1qz7N?=
 =?us-ascii?Q?lk1v1l6/Q0dDOY7cXf46P2pwgFrpIkb+QplOW/52cwp1b7YJb5y+WZ6LgoKE?=
 =?us-ascii?Q?IrSDaXfSIqxMPmJ+YOdiVKUi3hJ+8jOO+ppuvXQpP00HaTiCk83kr0xAnGAr?=
 =?us-ascii?Q?KofAiGvi2bzz7eliQbebwtzvaUigyB6iWEtBTYRKdg3uhqVtVSviqXikDmoY?=
 =?us-ascii?Q?vBH8ekrvhYuMqCpVT2Cy60F8X83VD2k+I9m3ZX9zLl5Hwt+ABxplfhwd/FoY?=
 =?us-ascii?Q?Ktr15d1a4kYUitVN5wBbC33fs3RaLHNhWkW02CBwytdSGdpcxFK/wvBvx9c5?=
 =?us-ascii?Q?/Uaf0nlHldlji2o7VnJgS0DJ2i4EuuyyYiX2gtBKtRAEOH0IRustH3wWbD0L?=
 =?us-ascii?Q?wizLVpX3r7RDybrZzx0nY6LaIn1fsP+y3nR4qEW9Gwtk4t88iq6Vj9w5VKFx?=
 =?us-ascii?Q?sdkjJhmScgBGCNa/CZ0J5NlUwXEJ0jDqVb5HFSvrRDGoCl4W9mceUlVbTLL7?=
 =?us-ascii?Q?zVU7EgV2A3kZMw5MxMwRmib7RBwC+PjFfJpFTbFPmTHAgTx/9PKIQHUXwqN5?=
 =?us-ascii?Q?EifnfD/9RVKFqVFmmsdkgk2x06EGKZqkOsCwuY8Xt+qHda4U6hujUwUUoR2C?=
 =?us-ascii?Q?q11aqykKuJbfAlUhNmSKBPYzZm4SPnh+H/ZT06S06DMfnPdFwX9b9kFtTL4Y?=
 =?us-ascii?Q?IiQosGW22SpbQ0dtG9RjateYh9NTyil+EZzSK22p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5b190a-a088-432a-88f2-08dd78523da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 17:07:57.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/04ekEdmYJYiVqgp4lH/WBfgRzyJfwboTS8qg0QxZoeNmtWKyo7EMCDf7YwvdWY66wzA4ME3MwCyDSveEu6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6433
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 17:08:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1358

Should have been [kirkstone/go]...
I hope it will be found anyway :-)

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Thursday, April 10, 2025 18:52
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.24.1 -> 1.2=
4.2
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.24.x release [1]:
>=20
> $ git --no-pager log --oneline go1.24.0..go1.24.1
> 339c903a75 (tag: go1.24.1) [release-branch.go1.24] go1.24.1
> 334de7982f [release-branch.go1.24] all: updated vendored x/net with secur=
ity fix
> 5d6920842b [release-branch.go1.24] runtime/cgo: avoid errors from -
> Wdeclaration-after-statement
> 949eae84df [release-branch.go1.24] cmd/compile: don't pull constant offse=
ts out of
> pointer arithmetic
> 0bfde51e0d [release-branch.go1.24] runtime: document that cleanups can ru=
n
> concurrently with each other
> 45a52718e3 [release-branch.go1.24] runtime/cgo: avoid errors from -
> Wdeclaration-after-statement
> 7f375e2c22 [release-branch.go1.24] reflect: let Value.Seq return the iter=
ation
> value correct type
> 4070531920 [release-branch.go1.24] syscall: disable O_DIRECTORY on Window=
s
> for js/wasm
> 5ffdb9c88b [release-branch.go1.24] reflect: correctly handle method value=
s in Seq
> becc17ebcd [release-branch.go1.24] runtime: use WCLONE when waiting on pi=
dfd
> test child
> d418e224ae [release-branch.go1.24] syscall: don't send child signal when =
testing
> pidfd
> 456eaf5c29 [release-branch.go1.24] cmd/compile: don't report newLimit
> discovered when unsat happens multiple times
> e4ef83383e [release-branch.go1.24] debug/buildinfo: base64-encode test bi=
naries
> 4e6d3468cc [release-branch.go1.24] cmd/compile: ensure we don't reuse
> temporary register
> f5c388313f [release-branch.go1.24] internal/godebugs: add fips140 as an o=
paque
> godebug setting
> af236716b2 [release-branch.go1.24] cmd/compile, runtime: use deferreturn =
as
> target PC for recover from deferrangefunc
> 0f7b7600fb [release-branch.go1.24] doc/godebug: mention GODEBUG=3Dfips140
> eb58df7dbf [release-branch.go1.24] cmd/compile: avoid infinite recursion =
when
> inlining closures
> 30f4d9e117 [release-branch.go1.24] syscall: don't truncate newly created =
files on
> Windows
> bb0e5c2045 [release-branch.go1.24] runtime: fix usleep on s390x/linux
> cd0e528d3d [release-branch.go1.24] runtime: add some linknames back for
> `github.com/bytedance/sonic`
> 80e2e474b8 [release-branch.go1.24] cmd/go: initialize req.Header when loa=
ding
> git credential
>=20
> Fixes CVE-2025-22871
>=20
> [1] https://github.com/golang/go/compare/go1.24.1...go1.24.2
>=20
> (From OE-Core rev: c83927d94bc0afe2205324a976e9495d6df00caf)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc}        | 2 +-
>  ...o-binary-native_1.24.1.bb =3D> go-binary-native_1.24.2.bb} | 6 +++---
>  ...cross-canadian_1.24.1.bb =3D> go-cross-canadian_1.24.2.bb} | 0
>  .../go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb}           | 0
>  .../go/{go-crosssdk_1.24.1.bb =3D> go-crosssdk_1.24.2.bb}     | 0
>  .../go/{go-runtime_1.24.1.bb =3D> go-runtime_1.24.2.bb}       | 0
>  recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.24.1.bb =3D> go-binary-
> native_1.24.2.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.24.1.bb =3D> go-cross-
> canadian_1.24.2.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.24.1.bb =3D> go-crosssdk_1.24.=
2.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.24.1.bb =3D> go-runtime_1.24.2.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.24.1.inc b/recipes-devtools/go/go-1=
.24.2.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.24.1.inc
> rename to recipes-devtools/go/go-1.24.2.inc
> index 4cf66e7..cb4ae9e 100644
> --- a/recipes-devtools/go/go-1.24.1.inc
> +++ b/recipes-devtools/go/go-1.24.2.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656"
> +SRC_URI[main.sha256sum] =3D
> "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
> diff --git a/recipes-devtools/go/go-binary-native_1.24.1.bb b/recipes-
> devtools/go/go-binary-native_1.24.2.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.24.1.bb
> rename to recipes-devtools/go/go-binary-native_1.24.2.bb
> index ffe3d50..690b854 100644
> --- a/recipes-devtools/go/go-binary-native_1.24.1.bb
> +++ b/recipes-devtools/go/go-binary-native_1.24.2.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.24.1.bb b/recipes-
> devtools/go/go-cross-canadian_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.24.1.bb
> rename to recipes-devtools/go/go-cross-canadian_1.24.2.bb
> diff --git a/recipes-devtools/go/go-cross_1.24.1.bb b/recipes-devtools/go=
/go-
> cross_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.24.1.bb
> rename to recipes-devtools/go/go-cross_1.24.2.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.24.1.bb b/recipes-devtools=
/go/go-
> crosssdk_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.24.1.bb
> rename to recipes-devtools/go/go-crosssdk_1.24.2.bb
> diff --git a/recipes-devtools/go/go-runtime_1.24.1.bb b/recipes-devtools/=
go/go-
> runtime_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.24.1.bb
> rename to recipes-devtools/go/go-runtime_1.24.2.bb
> diff --git a/recipes-devtools/go/go_1.24.1.bb b/recipes-devtools/go/go_1.=
24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.24.1.bb
> rename to recipes-devtools/go/go_1.24.2.bb

