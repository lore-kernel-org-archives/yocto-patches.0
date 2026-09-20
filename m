Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8312AC982CC
	for <webhook@archiver.kernel.org>; Sun, 20 Sep 2026 09:08:37 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26667.1789895315500423832
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 02:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zu8cfGg4;
 spf=pass (domain: siemens.com, ip: 52.101.70.61, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJlA0aSSUgdh5xaV21AG13VIvJov/p6wKVb0UiCGMnGJ+DSuTI2U1e/8GfyQJeOPOiG/WnEnAW2f2/fTwfwYkEUHm1SjmaP+k6mLS2WdQDy5VWXrGb2ZEIsVrkUvYMDwKKusvHIDADmMFISt6pwhEX0wmduqoALinpR85jVPOy6rnqOdglmEtcre0qWyqgVlYrN41MrINIheDOcFi4dL5+YBKc6RYGqELiX8VlBXu0J3A+nm69K1MpTy5SgP3OEVTHPMjsMKy1u7H2Bj2Sby2Kzy8ut7WsY7Yp85bDFN0y/qjY5ISMj4CQaLZaD1WUsAgDby7/CugDeFN+qGeAO4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1K/+9O4rpshorSjzSRhZw0X/NFzhACoTYGRIUPkBd8=;
 b=F2D1qG5f8WAeG6lJrEORwiLpGfqupWw3tDnj/JHiRwXKh22kr0Aca8B43hfLUb+O+qkGxixEZuFZ2loArUxWJ1t5mdAT93cgVbU5oDjS9pGbio4ES89eDJ40ptPfEfCHYpAptGWJeKB/OOX2DImaffRGwkSCytXXI/A0sCoK5Nrpc17H7z8NY5IlCvraYKJXD81EKFydPpGKgO2dCTz5aPnsI9uJE+tp3/fagv2e5fjsm3D1zGPe6/MtWNS3XS4Ix2qXB3qXGKxARriYoncGZ/pxYxtgyO+SO59H1xK+R5zKTwxDONL6vJxEj44D5i83UbPiqxbfTGX6i0krk9ujPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1K/+9O4rpshorSjzSRhZw0X/NFzhACoTYGRIUPkBd8=;
 b=zu8cfGg4C7JpExOt1PrkId0PNigRum0yBRYt1TWQOExcs1+8HUeAPT76a2icEIV/+ijzd+ZvWovCZw6PnuvppVv578uiySyyffhwL1kjWtgr7bgR3JlNozYfSjmp/OQcpaXCJcv+ArdZij58s8uH7BAiGcRK9UUBpMEuY9F73CMHkIMTszI4ErwiIaQ5KtFSFEUov/E3v1FsKb2pOMWj1cTRoJjfcTr1DTSjChDNYa3n/UIWyv5iJrqg02iuPhKkcEJHwOrKiGtWGonTKkyUHywi4Xm8YbqAde8I+ts2M7psO7WK14ItyBbbWw169D8jS+IIMbO/nhZTs+qM4ML//Q==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 09:08:31 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 09:08:31 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go: upgrade 1.26.7 ->
 1.27.0
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go: upgrade 1.26.7 ->
 1.27.0
Thread-Index: AQHdRH6UHDV5/+cOykCl1Dr0qJ8Tu7bXNitA
Date: Sun, 20 Sep 2026 09:08:31 +0000
Message-ID: 
 <AS8PR10MB5073A3B048E58B204A119A04FD852@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260914192315.1067308-1-peter.marko@siemens.com>
In-Reply-To: <20260914192315.1067308-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=803b898e-e64a-489e-8179-1ed5d660598c;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-09-20T09:08:19Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DB8PR10MB3657:EE_
x-ms-office365-filtering-correlation-id: 66c3596b-2410-457b-240e-08df16f6bde9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|6133799003|10067099003|11063799006|12006099003|18002099003|55112099003|22082099003;
x-microsoft-antispam-message-info: 
 sqW39BmFWwGbGiTE0fQ7xb5PvVP9CcdwCdTy6l/3oByWExd/w0iXMkEbgFWE8unQJN9eOfF+ckdIDP94HlMnd9Mwajbp6Q3kDEuAwkQwi1m+bpG2Xh4xhBkb719isk3KKcHAUyhPH5QBK4SjeOCpcRBGvAQUty4wH+C97wkBYXcpVNS6OkB3PZ/kCpZzSUZO/mp+ok6RuoT+tlVqRWkKIFeQtVtOHShaCZljhllXF0DKOur8At1QN1vQC4E2VIlDgfvo5Biki12BQRhObstVtxxvTfVo0y9jS4Vtn1wIGLmul3jjUCBXBHipEpmsgFe0Llne6NdNw1++gss7Mo2rKvoUawoW8X7PhjASNxD1DkzepM9nB/4Xu5dRmG8C6RNmHQ97mUTE9kgIRXahX9HJb5kwnXJgBne4FQMVWWnRZv0/cXCsIlpgYNjmxS53XCJZV66+zrusomt4U6nmpqKr+9wvRD+ImBJIGqupioyi7bAgqI1PXgLY02FinKNw5ONaXaB2PXCI2FEDTF/nglgr4lhCM0WR4mD/gQyDjJjqhvia2bAYtuTwzTSVLmX4Sr5tZN/lwS8hJy776ucRA/q0li+Sg4wOZ6+AVA+2IvsjhY0jbPbmE/7nZ/XzFW3jmEliojSMJvXpzSAHPbkCjiCgBsTpz7f8kY/RP+kyrXB+J7k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(6133799003)(10067099003)(11063799006)(12006099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cCzOq5fn0vYV8WoJvKgS0Ilc6+PUKMJcvoK14O1kBZFzCoVm2RPrXS4roPgo?=
 =?us-ascii?Q?daiUsforbVm8YlrAJog5o1At1LS3ytt/jyrqU4rekxh6ekzxvD5uREY2TVKY?=
 =?us-ascii?Q?ZmW00Ifh7qlCf8e6rLChXEhNutDWwhmvoqo+tVFYeIQICpoZARrr/F4UwAO7?=
 =?us-ascii?Q?iUKCO2ApHi6rYR5KOGjSYR5NcJA7+8/waCcouMoQy4LyaSGjPnP6l4NkJ1wj?=
 =?us-ascii?Q?SqfGaB9sV5hjilVAs1cVWQLMNJZcwYv21NPM3kUjspOzLuEZbKbCEyov9PwZ?=
 =?us-ascii?Q?6a4z3gMY/ToROW9DmuByt7qJ7P1kv+j/wdlGy7O/bAbzjGN4x2SNwqsDWz/Q?=
 =?us-ascii?Q?hZZyF6N2U3dbyOiLXBvR4qgnSBSoqpf+0Jd0mIE1y1JgBntEP7tVepHL6dWX?=
 =?us-ascii?Q?Sdmp9DPf/7p+m9KoXOQ4l/ySSjpsFKOxsZn+iKD012KNTQY91L0t6dKfGCSU?=
 =?us-ascii?Q?0LUGWN1v6j2N299ZWoLvD3zkCcI+yWsqHFd6hsFvs4pBxumcJz4lVghf2xue?=
 =?us-ascii?Q?BsHWdpmi9g8Q0n1hy/8qWrYMuDaq629e0TZiEwtoPvXPka7Q2BfOOZXsNyLs?=
 =?us-ascii?Q?q2FbKxivd90M0SDj7bw9gP+6j2ni6GzBCOAwOYYyawYOoHUj9Joe3YPJjbx5?=
 =?us-ascii?Q?3IuPufXaq7KyV2pUOM/10cIkDFTnG+fpMyGwTZinF/7XREYINWIL7pGZ6XUg?=
 =?us-ascii?Q?7ixcpZFCM/IYQHuRONwcXdrI/S6RAJa0CuBObF2XWTvA/DtgtIXihyfQt+Sw?=
 =?us-ascii?Q?lR4nZFKoWQPZJvHB8/pna/jiafTBSrSHL4Zg/01uKNBse1YoZIWMJbT3e41V?=
 =?us-ascii?Q?LzuKMZqQ795Cn9is7rbJBg8p8lu9vyxw/MBbTKd+L33ODTuhiQma8XDhlgwQ?=
 =?us-ascii?Q?2lhz6hhAaIWukddym+VT3JXXjELODLLT1P2Z69dN1ZZXEWmq8b5ZQZdJdjWb?=
 =?us-ascii?Q?rUrar+YmS8F5LqEDzX/iLRk8LRW46oZw4rsLr8WZQ1HCPJJIDIgf90geE4y3?=
 =?us-ascii?Q?PC+vp/Xbq5GnLsHATFcqawjLB3/AACSGBsXOGGNkd+iwUkNK8JFjdo7SekAJ?=
 =?us-ascii?Q?4LDvAV0V1uslPZssRu/cZGjMEnprV9+A0MwovXSqP4LKt6sOny8Qc9EuXzHg?=
 =?us-ascii?Q?NKYRvVWJnYwDtamhITNf/8tPQLYDmBdPrXzxbhQUzos6kHy0BsfYrODIOMUo?=
 =?us-ascii?Q?/sSdc9tycRdIuIupCsofo5fuyJwnLh0eia63z63ZdKqy9oKTMxuY11vS7hlJ?=
 =?us-ascii?Q?Vg2yJCmBwamRgt4iF4QSRMHc9sm033HqDh/XXR14Qs1FZYi0bIhgNOL/9C48?=
 =?us-ascii?Q?Ngff3eh3Pe+mOwDZaHQKqMRUunnDcSZb6Ksn2AyUuDYONFd+ZZN5sYjTpsAd?=
 =?us-ascii?Q?RnwWLzBogZSHmE+077ImoWkLpJ/zKhgX2M0XlHBdYM7nmHL9XEJCOvUJ9tPw?=
 =?us-ascii?Q?F6lZEQMqJ7SwuPo27kKJL/BPn68P42Vscd4xSN+5jwdZSVRVp0qrKLNq4c2/?=
 =?us-ascii?Q?uwxjiRREuips1EDIDGU3eS7VEcC/6IIJd+/zZdsefEpVJvo0zKWYekm0xp9v?=
 =?us-ascii?Q?iu83RjuXUY1YBRr6sU2mfGrbfNNAJWNwJIHbixAlbFU0XupVxJ1fRvWTTjvB?=
 =?us-ascii?Q?XgMgClNbgfPGhXamew0Bv2AqmycLatMHSf90glfc9EdKsjmjISwDXe+C8Vs8?=
 =?us-ascii?Q?NvymVFQsKSikMiiJ3vBAW90Xt9PNiAicOMJbY7OsrCS1Cl1AHuDNZXMhv3Kd?=
 =?us-ascii?Q?3AiTcwGG6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3596b-2410-457b-240e-08df16f6bde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 09:08:31.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHA7W78DMJPSgXPrsyPfTPa7uEEbK4lKf6s/wQFyLyW7FNL5mSdlDeNs9daGzY+VAKKH3IaHjZgywFCxP4oBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3657
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 09:08:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4911

This series is now merged.

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Monday, September 14, 2026 9:23 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> jose.quaresma@foundries.io
> Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go: upgrade 1.26.7 ->=
 1.27.0
>=20
> From: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>
>=20
> Release information:
>=20
> https://groups.google.com/g/golang-announce/c/8gcPInd8SQE
> https://go.dev/doc/go1.27
>=20
> Signed-off-by: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> (From OE-Core rev: a0723b756582036eb0ce9a52ef0edc002c864cc9)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.26.7.inc =3D> go-1.27.0.inc}        | 2 +-
>  ...o-binary-native_1.26.7.bb =3D> go-binary-native_1.27.0.bb} | 6 +++---
>  ...cross-canadian_1.26.7.bb =3D> go-cross-canadian_1.27.0.bb} | 0
>  .../go/{go-cross_1.26.7.bb =3D> go-cross_1.27.0.bb}           | 0
>  .../go/{go-crosssdk_1.26.7.bb =3D> go-crosssdk_1.27.0.bb}     | 0
>  .../go/{go-runtime_1.26.7.bb =3D> go-runtime_1.27.0.bb}       | 0
>  recipes-devtools/go/{go_1.26.7.bb =3D> go_1.27.0.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.26.7.inc =3D> go-1.27.0.inc} (90%)
>  rename recipes-devtools/go/{go-binary-native_1.26.7.bb =3D> go-binary-
> native_1.27.0.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.7.bb =3D> go-cross-
> canadian_1.27.0.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.7.bb =3D> go-cross_1.27.0.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.7.bb =3D> go-crosssdk_1.27.=
0.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.7.bb =3D> go-runtime_1.27.0.=
bb} (100%)
>  rename recipes-devtools/go/{go_1.26.7.bb =3D> go_1.27.0.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.7.inc b/recipes-devtools/go/go-1=
.27.0.inc
> similarity index 90%
> rename from recipes-devtools/go/go-1.26.7.inc
> rename to recipes-devtools/go/go-1.27.0.inc
> index fed8701..4162a2b 100644
> --- a/recipes-devtools/go/go-1.26.7.inc
> +++ b/recipes-devtools/go/go-1.27.0.inc
> @@ -16,4 +16,4 @@ SRC_URI +=3D "\
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
> +SRC_URI[main.sha256sum] =3D
> "7002403d7cc44529ef6d26f69a44818263395ead7c16c05a5808ae047ebeb0e5"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.7.bb b/recipes-dev=
tools/go/go-
> binary-native_1.27.0.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.26.7.bb
> rename to recipes-devtools/go/go-binary-native_1.27.0.bb
> index b2c4927..246fba4 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.7.bb
> +++ b/recipes-devtools/go/go-binary-native_1.27.0.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "ffb5f8de10c62550dfddab66b36b57030721e0a44a3218e9e1181d7b59f121ca"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "5a4ec883379d51ee9ce1040d5e87f8d35e20387574dd8c947feb01eabc3c1b37"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "22d3b362d557175fd16b79651cab0cad64f8aaaedca745f66d16f44d56bc5de1"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "675c26c449cbb18fc24b74650de1eabbae6e16f64326fd85a283fb3b58280685"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "51798d2c42d0e1c6ed7fd9f48728b4193abac9e8aad6dbac2fe96a81f5909bda"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "068085e257a6014c036c723ca62943edbf48fd168b8d00a6d39527d10b656255"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.7.bb b/recipes-de=
vtools/go/go-
> cross-canadian_1.27.0.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.7.bb
> rename to recipes-devtools/go/go-cross-canadian_1.27.0.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.7.bb b/recipes-devtools/go=
/go-
> cross_1.27.0.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.7.bb
> rename to recipes-devtools/go/go-cross_1.27.0.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.7.bb b/recipes-devtools=
/go/go-
> crosssdk_1.27.0.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.7.bb
> rename to recipes-devtools/go/go-crosssdk_1.27.0.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.7.bb b/recipes-devtools/=
go/go-
> runtime_1.27.0.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.7.bb
> rename to recipes-devtools/go/go-runtime_1.27.0.bb
> diff --git a/recipes-devtools/go/go_1.26.7.bb b/recipes-devtools/go/go_1.=
27.0.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.7.bb
> rename to recipes-devtools/go/go_1.27.0.bb

