Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DEC982CC
	for <webhook@archiver.kernel.org>; Sun, 20 Sep 2026 09:08:17 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27009.1789895296146224165
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 02:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zMozl04c;
 spf=pass (domain: siemens.com, ip: 40.107.159.17, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALOvA3AuQSuilGbiSou/FdkJUw6JL5t/fs6UIvecqltoJw9kCUb5L/S6DeVugQENS5hd8IfuJTVSRBWylQU535yQ/sau1fK0ksdtKUt315Kj1dX9u9FQshYr7TPdgU68M5Sk5uHFeDH3RHK3SG1mHdcAtFBL3Cxs1Gk/v9XpZeVwJ1Z0Ru3gEGn9JwjKQvYR3FWd1SlIjKHRBxY8UHryuk6UXGz3IEzZnmvqrwzNKVPNERrt0aCwM8oVKhomGKPeeeJVnXZaWGl3gDo6cfgWs31OYFzMQW8s+4/b46SZiLUSc/7wAcJ/vnvxgv7GRCc+r8V1bZhlqeBQwJ+H7BqakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hj6AS47jHbfkNGUgsaCO5e5FgMhsRkxpPOE/FTB/wc=;
 b=XEBhYowtQGSr5yzI7/8XwQa5SblUM7efyvBX/8c0J113ZLdqODXp1I0/ClM3RQCAF5PlA0JHUTW2ENQfpE4vLPSzbBnedf+/XGAM5G8NLWZoisDsWnr+QEKZljjGG9p68fyWP5mH70PvX2Pn0jmFRcxQM5f7qefc4rC7tZ62BVUjkoIBR0sEwKtJ+lfzvSS9B9nyoqvgKWX8jFsse+ZLyOkmmSy/+Kgl5A60KdtOqgp05ji7Ep0M9IVa8hFZxnWrprvwCe7Fy3gRQXshSsJZnSEfqtQ/MRlNSb58mIRSAzmg+xQraSe839DYoCvkCGwQXegcdVIJIwvy4S1vGCJbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hj6AS47jHbfkNGUgsaCO5e5FgMhsRkxpPOE/FTB/wc=;
 b=zMozl04cm3so1khOb2zpOjmWCqI7CJ7d7OYjNRuq2P8BHUGI6edhfIoLHdoOKYxwfK9dRWbd0QWot6jX4imO3XSCfhKkP/U3LVU0KIdV9yK70CzG9NTXAMvGT3zKt7qQJ+WaATimV+4tbk73JXK81q18chdU/7AgGZ4XKl0JS7wHiqUn5qE1lG1NI+Ae/hRICsFLWZzTci/1HnA0CVOSiH7k0gITuotNbGY9Ae/Rf0BxL79ExShHFumDlLTaVFo7HWGzgN/stZecgKaVddGkw9m/dUcy7ghz6IojaGIbPF5QfNEhOkcCBQ7/Q5rVlfnz0sxAPd/Z+uNVkUASLZgPQg==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 09:08:11 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 09:08:11 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] golang: fix homepage
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] golang: fix homepage
Thread-Index: AQHdQ5exzvb6InHbzEKKL3p+x7aIebbXN9zQ
Date: Sun, 20 Sep 2026 09:08:11 +0000
Message-ID: 
 <AS8PR10MB5073EB48D35EDD5F5ECA5EF7FD852@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260913154916.3207747-1-peter.marko@siemens.com>
In-Reply-To: <20260913154916.3207747-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=99b20a5c-80b9-4128-9741-e8d81c6ae179;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-09-20T09:07:55Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DB8PR10MB3657:EE_
x-ms-office365-filtering-correlation-id: 7037c70a-1395-48a4-6091-08df16f6b1f6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|13003099007|38070700021|56012099006|6133799003|3023799007|10067099003|11063799006|18002099003|55112099003|22082099003;
x-microsoft-antispam-message-info: 
 89e7jJfp+a2d/GqreJEWnpmSDQSsTjPCQwQTCr1WRq/R5C2NPqeSbpMhNSYjnpfVVJRcjn+Y5D9yn3lc3YA7XsICX33S2kklRigvV/elCGvVSI5u5meLV7H+1vI095zza6IISLGnU276gzSfvUHWyv1gKgt2L/cpElV9+sxumjCXun39Wirs+j4iU7sPDY9cbANTJ8VC0f2xrZXCIS0HV5lfCa4lRkGrl72XCOvz3kEd9+uo08x1X5OXxUXImj74cCtGNZtc4vCsWFvX1bY1cCoN6cL5bpFvwoCXuQNV+xaGUAbaPQ71LrIRmkTDzU+En4Tm9rWwNV4DT2G79N7ZH1Jq/WjKx3BUquTn85XNMrta84DNsBhykkiqTg8671mePHe+jcoDuRG+fuL1WQGn1LUrrLKjE4a8FafH9wfeoHtpKJHA1ytDtfrs3IkHTTr3cktBA317DUDVyC9KZdSeB/R7Oo3a5P1L7LCzJkN+0+osNltrIuBkAcyAHqxuY8cXmfMm3Vn9woggevkOxY3Bth6fAp6Q2n7sVKaKuAKOkkWH2ffrKuYVNCjQQthEg/RdskhsXInjvj25nHPTR542WfRAXlubX3fPsV4wt8uj0y8OUcJKPck0VL7lJG+2ogJzsI6GZAazaA8+tUP8qtSsvcDUMucZNJ+z6fE4E5rza7U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(13003099007)(38070700021)(56012099006)(6133799003)(3023799007)(10067099003)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SZ9sjcsMLGmkWQS+fWTX494DTVZ9rEJAnwixZlSI1Ewm2L0mIvRintKUWtPW?=
 =?us-ascii?Q?enMcDL9iPiiarfrZYufQj4wEB33l9BRdnSbbtsdRXdAFjb2jeWjWC0wshlAg?=
 =?us-ascii?Q?8iHV2b0TADG9bJ3DBuI3RdkA7mqGK3UU9kQ2UJq2uvXuQClSHrfpcHvYnDCU?=
 =?us-ascii?Q?9or3ul+Sqjl7i1UC7QpwKQjhbseeEA//n+VikHLQtBYXIiPcNw/2l869EF6R?=
 =?us-ascii?Q?miRtRgTKYI3nZn0naaHP19i9WXbgw5624k/PVFV8rabwb5K2EjIl0f84ROmL?=
 =?us-ascii?Q?c9jppVeDyTPdksh7f1vNqxHWMSNm4hGnNOobzU4dfEYaauwarEMZ7PjAEiH8?=
 =?us-ascii?Q?cwQJTVKbTBbbA4hnqpIjvjaJXguPGHP564HnjPJVybT8qpMqKQIDJZPpTt7Q?=
 =?us-ascii?Q?CPr98cuZY5OnxEFQzL0ks+lJvmM8UlBxULdnVJODCV4mXiyFLiyPdr6QIt7N?=
 =?us-ascii?Q?O4esTmd90NlnN36LUKu/w2a6IBpBQEiraJjTB9y7KZDgW3RZkK7D03UI5uk8?=
 =?us-ascii?Q?XiBtQK1n5jHflbsBOxjqJAYXTasgctE5yR7djjLYDlepvZlF4uRDWu4f3QTv?=
 =?us-ascii?Q?xmvl1M20UDPeAfRnIccombFWRWodZzisKmllpzQeK+wc4kz35a6TbGT7qOnn?=
 =?us-ascii?Q?156HXcKj3qmXCFgRQHzNhN574xk5wrK9Xa+H7ZvLsIWKT3ekH+YBDQ+RzhQD?=
 =?us-ascii?Q?7HpKNzpiN62yCAUzbis7DUuv5EtqfAi3PY3EMLqnoKQLJJOjMHuA5/cbiNrt?=
 =?us-ascii?Q?xhS6W1u+RK0Ex7YJ/eAq1ae0iGe54UAA/mfUih1y/cshwhdEnxSbq7Ba8mbO?=
 =?us-ascii?Q?6NkmLgt5o2VJoOgqRGFtr8fYK0lcUZKl4FKN5Kf53hVwjutZgNP3rgChV8M6?=
 =?us-ascii?Q?syyApdODT2+i9uDD+kieektb0I3DiHaDcsx4iLBEXCwj1qX7iuNQ90E1UgoZ?=
 =?us-ascii?Q?NyCOkMjXN2EXWHhrzXfPD7GYnFtXtnA0bgRsbdbYPFF7tLMnuACOY6dIjT6J?=
 =?us-ascii?Q?zMGvMEx5qJXCA58KxkGHV6DC4I+z5e0Ypy5STgjcZATwmDt2ft5K8b1ZL7x9?=
 =?us-ascii?Q?e8m/EE0/7NUOqXH54QacKxF5Zt9CrbQ+MFgoulMwdpLTtCPgqiLeCRrt1shD?=
 =?us-ascii?Q?6KIs5DRijBBgAMwZ2xn81ajYrf7U88lqVmUj4T6zqUBXMiAyP7KNx6CgzFoa?=
 =?us-ascii?Q?dYsle8sVn/zD0ERY1SuYOrAoKRQVSjGci7rFYpB11AXD0113OhbwZymkOtMg?=
 =?us-ascii?Q?W+lC+u+YqB7DbZAUUxNLoIhD7SIm6iv5cD1hc7m2W+r1DRoMylkarusJycIG?=
 =?us-ascii?Q?q47w7lZ3/S3iQH84UgbHEFiI7a6VC1NJBctMJaO7E/Ml8n9FRkTBz3lLR0+2?=
 =?us-ascii?Q?exQqLEeoDef9bV3iAezEZTe0CJOW7KC+Lg5VDKtfxtN7Gg4p20R3XfSRpEa1?=
 =?us-ascii?Q?hoZfYFazWD80lfZd4zQ/OIaKfZlXKiqZkyjwoktodHObAfkdzN9jcpNSMJV8?=
 =?us-ascii?Q?FL+vpdPxJRcoIOj+vIuFBCjiLhx3dKsJ2SMVBbG+390aBESfZ0IzGW1yWcEN?=
 =?us-ascii?Q?RuN1d3qd+7CTublPXPTVCuF1MK9XGyVOYRyvgp0Aonnl4db2NUlUPfF/TQVy?=
 =?us-ascii?Q?oFl1u3NFmpd1qkGb65RgkcQy3oNedxC7uqzKDUby3o/1FmUrlxgtmLYtojBO?=
 =?us-ascii?Q?UBM+xI3IbnyB+Lj6qtHecmke86HS8c112mmKxVPlW1ALJCDP4XPRRLDyjhZO?=
 =?us-ascii?Q?n56Hb6vNEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7037c70a-1395-48a4-6091-08df16f6b1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 09:08:11.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKmTbY0a8saDTnnUssRpxJGAClyFxf8UmwXIcLd/nAKgpDYo7wcLOo2KNnHWfjEaihUXP2er5OGx8O/0D6nPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3657
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 09:08:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4910

This is now merged.

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Sunday, September 13, 2026 5:49 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> jose.quaresma@foundries.io
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] golang: fix homepage
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Leading space leads to SPDX document validation errors in some tools.
>=20
> Example:
> SchemaError: \" http://golang.org/\" is not valid under any of the
> schemas listed in the 'anyOf' keyword
> (components -> ... -> externalReferences -> 0 -> url)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (From OE-Core rev: cbf36f436b477d81b58ff605846a2482308aefa4)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/go-binary-native_1.26.7.bb | 2 +-
>  recipes-devtools/go/go-common.inc              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/recipes-devtools/go/go-binary-native_1.26.7.bb b/recipes-dev=
tools/go/go-
> binary-native_1.26.7.bb
> index 380b446..b2c4927 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.7.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.7.bb
> @@ -1,7 +1,7 @@
>  # This recipe is for bootstrapping our go-cross from a prebuilt binary o=
f Go from
> golang.org.
>=20
>  SUMMARY =3D "Go programming language compiler (upstream binary for boots=
trap)"
> -HOMEPAGE =3D " http://golang.org/"
> +HOMEPAGE =3D "http://golang.org/"
>  LICENSE =3D "BSD-3-Clause"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D7998cb338f82d15c0eff93b7004d2=
72a"
>=20
> diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-c=
ommon.inc
> index 2d617bd..df98f15 100644
> --- a/recipes-devtools/go/go-common.inc
> +++ b/recipes-devtools/go/go-common.inc
> @@ -9,7 +9,7 @@ DESCRIPTION =3D " The Go programming language is an open
> source project to make \
>   fast, statically typed, compiled language that feels like a\
>   dynamically typed, interpreted language."
>=20
> -HOMEPAGE =3D " http://golang.org/"
> +HOMEPAGE =3D "http://golang.org/"
>  LICENSE =3D "BSD-3-Clause"
>=20
>  inherit goarch

