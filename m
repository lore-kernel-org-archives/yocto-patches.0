Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050AD19503
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 17:08:08 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25637.1769447282849280796
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 09:08:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e5k2qR5n;
 spf=pass (domain: siemens.com, ip: 52.101.83.1, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYsGQtWxyvH/Qcd9z7Geny/aFZKjORyBH9DPDuyg7gcKy0tHEUGwQ1ScSjS+BRTWHlef/kaxQTEBLSDKH+RJhMlSHYY05sp5SO5ZklFXzQ2Is88MnUHhVKh/qW/3HZouIGuZg/IAD2gExoeqfdMrpoGlEgDYmr8opAdNGKId8aqLr40lXc9AOz1w7aNG0DHAVrzdWfgtQ3f099i1DLtXrQGPB6L0zIgeV9cEDAlDG4VeZuAvLnXQih7X3cEOBZ7g7It1CfeBwOZuyAYKQ5tmSPP29lp3J143ZFFI4FC9XiC44uVYPfbCLYsK9nmOKgtSlpTLxi8aEQ1wEX1Hsnkvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPAW+SwW3Z8SBxgLEJ87FqAf8u/nXBkPQLLTiYWe1qE=;
 b=ara7e2qP18qSVHEgTwH2go48f3fhv1MLI91BEotRRAjauiy4jQKYu61kMf1hYrGyfsl2HdWp7kmPvJocRr2eLV+VqqdJOZXC8/NTeXaGqXdvKZ+keK5BvUb0P4B7TNJ6HM5rgZxaMK0buTEf0s4cnaddP1Dkd7ZdnX99l/v7Vs0+spdGi1OKQhsFnVu8UpLu8wnIffJ/eZdN34IWJWxW3SA9l1vHVzCU6PMwNa1WJmpAx914c97x5vrLECt9JX9OCYvNCoY1bntzp/dGHN3NuDNnRkFHWhHBe7XrRcwQdH5STGSFw6xhqVFLExNGg/2slonAlf/Gk6DmxU0XefQW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPAW+SwW3Z8SBxgLEJ87FqAf8u/nXBkPQLLTiYWe1qE=;
 b=e5k2qR5n6aWj2KEunhpvKqMbwEY2vEFHcoZ5zjuO1oRCaIJ89Hyp9TO1kLAxKUUafjY8w08kfNdOPipm4i+3IaobHouAXmdoVU4NhwHkcPdKLcvGKrP/JgnUOnobG6p0/KfIR38Jn8HE7/YYeNLTL5u3zzJOsQt/Erl/NjLR9b10r5oQem+cNyAw3qBLYEXvcypEeukbPCnzTLRtw1oJdMoDaInF7GHz4xVlDBVcnqomwe+gtK119RpovG7R8i3YnyPK1zpidxVkP5ZYmA+bUyrBnM6sUJfMsax226waTUB1Jrv3KNjLKOUa7+YsdLeSwR2B0iOEQGzqUDVfCCB2eA==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:07:57 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:07:57 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.5 -> 1.25.6
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.5 -> 1.25.6
Thread-Index: AQHcjUE0ihRXTXH7pUqKFMoJUOXcFbVkshaQ
Date: Mon, 26 Jan 2026 17:07:57 +0000
Message-ID: 
 <AS1PR10MB569766173238882ED1FF350AFD93A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <188DB26BF92854A0.3118880@lists.yoctoproject.org>
In-Reply-To: <188DB26BF92854A0.3118880@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=311d8ba2-3025-4055-b5cb-db157722f8ee;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-01-26T17:07:49Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DU0PR10MB5560:EE_
x-ms-office365-filtering-correlation-id: bd214104-acd5-46ff-9147-08de5cfd73c7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|13003099007|7053199007|38070700021|7142099003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?b54NXbT4yvmm3wI20kvEhWg3b2gxeFGpjJowqZuwCZJPBSN6siinh1FIpaLW?=
 =?us-ascii?Q?nPFGzp2jX5jmyjLXYRfBaWT2Tq7mQTj9rTsJfhgtOVSbNFeJnzslOyl2X6TG?=
 =?us-ascii?Q?ucENSUXSlCoF7Ee1OVlU0fklK0o74kiyHS1C/+aaKqgmeVJJL0nywJEKZJyR?=
 =?us-ascii?Q?UP4ORHPIdB9eP+sUmpMbUzRutMHOK4JCUMiKFKJwAEzizIpUUptQJqwteXIU?=
 =?us-ascii?Q?PQUewidSo2r5aYxgWRjbftc0uv6MJh0E8zMWUjnLx98bCdEmUqlY05DkQfdV?=
 =?us-ascii?Q?sLBmq6M8yxei8kaZcnymighJmZm8X6wCf0YTMbuC8sI7fXrxnyuwLbSpF4Pj?=
 =?us-ascii?Q?Sx59pCtJd+a4hZAYXSCSLxtBSgnvHgU75PO76SMyrSVwHQNsX6M3Sb7fBWdH?=
 =?us-ascii?Q?N5e7e0cBP+uHPbyqzEgEmqqmWmPy8XtwWDwqqE3S8XW7aP4a3eYSPtmuRoTo?=
 =?us-ascii?Q?n8VQFv2QqA8OoaTlwJwz+H/xOigm7nLBOqTeebCJIdCNE5yHT3jfM1AP6nyi?=
 =?us-ascii?Q?hvC4MkybJcTf7a8r3sCmhLyyOsaEVM/9QlI8hx61VHgSAzTevsGGFpLJXNvt?=
 =?us-ascii?Q?yHE/3XcAEtTfW1zytiYLMuDcCECJSq/Gy54AnmBZi7fbnxBeXmYj1CCCCfe/?=
 =?us-ascii?Q?i+7DgH9MRzrSJGTGPqMJGR8pkKm1JhbIb98QFr2uY9JR8nWTGkv8s80M31Zg?=
 =?us-ascii?Q?UYppUGaElvtrefZJhHkvs9R1+fINfTUDIEwqZ+KYrOny6aGnWSBVVF3U1y6V?=
 =?us-ascii?Q?hCKsl6elkZUiAVZXW/8ajJzhrErrBH+AaVEdOb8uzNGSnY1gPzU4NGE22Lev?=
 =?us-ascii?Q?EV2cadxB5FngI5TF4I2U2/Mb5AEpPfVqlKCr2NQ1wQkHhkW3LT0KVusL00fM?=
 =?us-ascii?Q?9nHjqCuJqs74GSixqSfUU4IZ6K2TNtpf3lQgh3/KtB1nc6Jwn1jqoJH9WbKk?=
 =?us-ascii?Q?wkw1+nke5x1Jn+5mtC0t6FnM6xKq1dEu3c7sHLJ/ibehldzDAID9MMsoTxW+?=
 =?us-ascii?Q?vCDLN9tA2OOia0PczgI2BwKA38w6WQJ+eP51FZblWDTL4S0iuOv1gbdUdEkP?=
 =?us-ascii?Q?rVeVZAJLUXH0wJOZjtErDVYDZm8FV52iIO4Tq9uAZEQpgJWY9DYLhjciNc0+?=
 =?us-ascii?Q?U2bU9jkOMIwOS8aLo6V/B60M6okdEayn9UxE8fq1edkyaDILKLIBNQJx1+FH?=
 =?us-ascii?Q?gNSMMtiPDa6I+RQhEXsIDm5vefq7qrXitLgC+wVINm055Yyj7Zqx2vaNrTEf?=
 =?us-ascii?Q?yuisPldWvjElUkKqhFMhB8fY/MoCJVlv+ydmoRStBV/as4bQIJXV8GZ+EnEm?=
 =?us-ascii?Q?bJwu0Fneo4x3ApHjRiHZE+IAGmzAPOFrlYmufIcFFshuOMcFJscwMPU2ff0N?=
 =?us-ascii?Q?MLWFZbaUmnd3i6S3+RXLjUHn//QqBWRfxuNEJJhw1ISqR6qcTiBAQjiLJdew?=
 =?us-ascii?Q?r+kIyh4SCS1+X/7nhUBDK2AZQovz+Puy1y5jLBu9PM7uEp7ESfGOl0+8sbMF?=
 =?us-ascii?Q?abl+4+tfjpM91Kg7Ko/92N6LiUmdfvZHy1JykHBpYtw8HxH/L5Q3DnjW55RD?=
 =?us-ascii?Q?Ihuc9/AvpyvMStOacenZB1AM/ceK5kMB/6W5IdQG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(13003099007)(7053199007)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Mgx4kSOzPJAaTDVDwyXthgWXH3x2Il295PX5ayMb0DAwoYQiV22JoBZf2UVk?=
 =?us-ascii?Q?44xATmMBFf4/nlHHFySOVHkXWGnut/b3L78EqrlZZQakIFU4ZGaviG0Fd5/o?=
 =?us-ascii?Q?pqwSycB3Zf+rSNkc11YJaL2CvMMK2IVgFBik3uurg+tD1GXCl0Qd5NZLsF+1?=
 =?us-ascii?Q?NSmmnU03tTxA38kJBdwNn5TytHDXiOBAMle7zn5nvBDd6aR75mOP0HqfCC3M?=
 =?us-ascii?Q?urNSyFifH7bTvAgddnfxlUMXwJyCWitlbVjrVMQX4gs/LDkenSRG/zc6su8Y?=
 =?us-ascii?Q?G09Adr9vgnNbl4BDxr/UzaD4IMl0ANoKI6qsrw6be4MfB7ot+Ra3VqTWjh8N?=
 =?us-ascii?Q?qOs4oPxJfx27z+aJR8ULJLv9TljlYmumiowVjDY7pInHU/rV8wOD/XkeMcij?=
 =?us-ascii?Q?g4B+pTZ+nXNtfRGwnMJLefkBPQzAnpUQXApYWabeQHzJWUvHT28LoAnnFu0+?=
 =?us-ascii?Q?lbxxUCXfDaWHmNKNmPzDGWUJFFtjbGfVfgA4dk6LoWoYWGmmVEj0E6MHLe/D?=
 =?us-ascii?Q?BZWaq68hDryIG8zHTwDwXmjO03uU32u0iOsgdnfXHClBnjOVUkI3su1oy9sf?=
 =?us-ascii?Q?5D9RtGLN7hMA65TnpXhqkRtA1UVwwHUOcHuRSojOL/aPpJ14ZNnfEHq9SHf0?=
 =?us-ascii?Q?lYo6iZHb80BUl9hactz0zLfqLRxIaFpYr1SiYYgaxrWS45a39+K1bFVmDHVK?=
 =?us-ascii?Q?u8tTleYNKww5IzHPgNYSvf6BnUKkK6UczhMq34adu/HKzzSHkEJ47M8E05zt?=
 =?us-ascii?Q?/zYhWTxb7XbBhEIK2LXAsYfhaxTTQoT7zJi7zP19OBOk3xkvFCiIkBVzZXdD?=
 =?us-ascii?Q?oCk165cTMAIzepwcgzuuxjbE27IMV+LOMDWLUb8OukS3mxK/nL3JopRIINVg?=
 =?us-ascii?Q?uoMy1VxkAa+RMnjjv/rXnUoqAQ79V/NIfoHSqpV1biv5PXavEosbiD1zAjoH?=
 =?us-ascii?Q?2TSWEaPIApBWy+PVi+LOG+bYGj2NltSL3Waib0Nvw81YUTtjDl+X+cgtlnMe?=
 =?us-ascii?Q?dYtMUsh6Ga+lUS8xjEBh+jTUco6IpDzP3yCjI2q6mE6hFuunxdBpGJjrUhq7?=
 =?us-ascii?Q?PGQbJGOzqY9I6HBiHMtWSXRHdljafHOjf5i4OM8sepmtG7FnF8L1ImFc8Cup?=
 =?us-ascii?Q?32CepCwIX5nr9lZsblsSmpeEzhCopZNOdi9wvwRGrQ0ruwwAyd4IrD5YB9M7?=
 =?us-ascii?Q?4Q+FGRMWUDj+jyCY+WOV2xIcnW+d5TLEKR951+pXYEdBgCSDIwIhXxDZg62Z?=
 =?us-ascii?Q?BgL46PXX5UQvbbeQj2yzFAIamsN02GSU/nDn1iNTm0CwFkxe8biQ1oqeh8tb?=
 =?us-ascii?Q?cjYgbxWms2ESAVsOTCXOwLVDC5feDPF6inelFLDLvhHFT+r25BLZMSAk11uu?=
 =?us-ascii?Q?hNueY2BWOy6qhd8gNN/6YaIQPgWeQiLC1Er9AYioHzRmCUmnIlB99/p0d6ZS?=
 =?us-ascii?Q?TfCP+VfE1/0CfwMroA6vQqTuqXy8JQqwo5hcrvxIzTUyRgVaqXeDv0SMWCGL?=
 =?us-ascii?Q?elWQOmWNvXlLCbX0irLRmlBzGyqeaNoP4V79cZdp2HflwhHhOmASONemI+dr?=
 =?us-ascii?Q?4jACKNJzhdpJJnrruUJZ+fC00p5J4ydtuXdJXc/XG5uwvYKOJzrqfliKTk1u?=
 =?us-ascii?Q?NmM4fhP+ESxu7n+uZtGe3qzYWkdcGbxUhjdURypAFCi+cjRVmmmLXQyp/Au1?=
 =?us-ascii?Q?szsx4qpLrXOm6BwF3ZqcHMMJbBIk3+5qTBJ1O8Eq1b87jHDiJ6O06yJ6uJbH?=
 =?us-ascii?Q?vaJ+rNv96A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bd214104-acd5-46ff-9147-08de5cfd73c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 17:07:57.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8FZupRDfintMYhQR57fR1Y67cidzz9hZjDoBG4MSSet3LNonHnw4I8g+sCJl/452L8EzK7t7YDtSHwSxcCWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 17:08:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3088

This is now merged.

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Peter Marko via
> lists.yoctoproject.org
> Sent: Saturday, January 24, 2026 15:53
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go: upgra=
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
> index 868cb20..4326dbe 100644
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
> View/Reply Online (#3068): https://lists.yoctoproject.org/g/yocto-
> patches/message/3068
> Mute This Topic: https://lists.yoctoproject.org/mt/117435348/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


