Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80089CD5BC8
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 18:11:48 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2712.1779819101128637741
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 11:11:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=czFGbR1I;
 spf=pass (domain: siemens.com, ip: 40.107.159.34, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPJcmOwlyshdcU0GXgcjXFj29kQospTR5O23DaE5QoU2Na8NzFOETMYmFu4dnFKv81c3hz2fv4bAXYKITAhMUle/xpYlPeBCcXGtO8/2aN16/HAef1+bVTXQr4XxQfHFvAXqR6XdCEoQIXsthMf4ravgRQ4znI0D7Ok2K7PQBBWghYUDELxbsXnBIRvgVm4Eui5pTLPzHuJqfC3AdtWBXi6/DJsEGjLeHkgXTRQDNR/UlBmbNd/CLBCpzrCSIxkIeTWsESEb5d21b8PI42vv5wkboVDVVecvGBS9FhSlKXQ6FuuCOGsJW9iI2YeQWaaQHT4WAEG6+YbTLI5NjaBx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8K+aUsYt+TZyG5XtBUrX4lBMFZjLdPOPT2oWfSVcSk=;
 b=r8seGrYfu2uJiH4OsU1etrgNwxD50Pb2DTDABIBzgmFN3qfiIjV4ap3NWYo2BcfiLOcmgz/TyXuCyEGwC+ACBnigGuSY6M3Qe6kgmJ180X1IpX/2zo9DpBwj8VRdnkBHZRQ/A5KwSZ/TmsJ0p9uD9RQzFxUfFoiSzMdo6/0SMbtAtm69lz9V3IluWpaE6hsp2f2N2cAFOZsCjaTm17HaDb+PWSyI1+L7xZjo9c2A8YphZ0pkNQKyOogvGieDUg62vJaGUsmqfA77oMjQZFwkDsOtZzEj58SX7i9A/3NaxSp3lCSuHaNppkAPqjJb1oc2bX0jXOtvbf0t9D+1Xk1r1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8K+aUsYt+TZyG5XtBUrX4lBMFZjLdPOPT2oWfSVcSk=;
 b=czFGbR1IwLLq0kgxf5v5ZhHOeI7pKirTKnCCAXn72Rt0SWcoXnxQQkxjgrXTJffZQ3ZzAMqs+UF97wur2LIImcegrurlD7LZfl2V8u0U2ZuwZVELk8QyG1W+n8TRfofP5i0IhL8VT3NriiYx0iINz7KbNmh9/Ga4GkTiXJTmYMNzyqLlx7jT6mmAYg6UTKzmEOT4rkzjCS0kMXxfBo18kleG21J4RHEbIQ75HoBioF9/ipNXhbsko5KQj2NF8m1fKauoNU+PgOE6Q1BscggBeMpwgYwKGgsxNh6iNQo6wtCW5KePRfL8bW1wBVVdYyZRLl8a4BV9SGbPkIf5+U2I4g==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by AM7PR10MB3825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 18:11:37 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 18:11:36 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH 1/7] go-helloworld: upgrade
 to latest revision
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH 1/7] go-helloworld:
 upgrade to latest revision
Thread-Index: AQHc4vtf0ArxIwuAUEOZ5mAJgsmBPrYgsA7w
Date: Tue, 26 May 2026 18:11:36 +0000
Message-ID: 
 <AS8PR10MB5073BE5B6275CF3BC2225665FD0B2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260513170902.2468061-1-peter.marko@siemens.com>
In-Reply-To: <20260513170902.2468061-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1c98f4e9-1305-4b81-88c3-d655ea526688;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-26T18:11:01Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|AM7PR10MB3825:EE_
x-ms-office365-filtering-correlation-id: e0c96e17-db8a-4e8c-0ddf-08debb523a14
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|38070700021|56012099006|3023799007|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 PwctjZwk7OEmOVnOmnn1ZD6C4EMGrzjv3vKuWbtLEcVmnlq+AI3AtF05EIRe8HFHbNfT0ykGYePSIvs/jl3r/FO80Tbpu3MRKpUIZ1hhkneVM/aPkOv+1elmvB4qf8u2VrUvFeHMr0mwyAj8UtzMc331xGl+y7JLb/vOHKrVARvdicoaivVpmZlrWqFckZV1z9+Cr7Lm5726QI/LNYmICLkg5FkNiDpzp+A/uYg8d09Kv9O2AYLdhywBru14G7B9on7F1A/GRt+KIrP7Jhfir+P76q6gf5Ri2s1hXAIfNtN1Xp7ve0R/qZzLpi3im/ue6RvT/GYj9mjnItszzHiauOYLN6q2RgHBfdIJucCy7MdBUYCXNbdWTw+EFV3JUbW97Lc5yJ143AAX1wbYNrxqolV+E525/odfrgHDrRfZBCo21awJg+1OIk0SAFVFQQokX3yv4UkVYZZLepeH2NX/j3CJrU1fBJ3Ear5w7OVl2zr/PLeRGXWwS6GwXSE5NfOYZRZujm0VDwP15/JMqNISVGJ1SR4TU05rb33cAfI+T3mRlIUesTpicwMGSoXoPILg48QbNTqe3SHQfpVAG0CR+lGDbo2n76Cr4CZUMqexTispjVoGELJbTprv8oEjy5j80ltQSY9RJPS7kn6hNb2OnT1FoYj1jAU+pfk2TrM+bMfZCmJgQcLdtZZjwC7+n7m3kjj3q6yNUXzznAHhS3/3ABX7cuRulaJWLaYRu/pt1vAW9OxDxfZ35MaWMsOay53S
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1aFfkNxPxW9ewoojIXvCSFPw3/C4u1fN2v+lZ+m5uF2ToJ/yukEVtxvFny4W?=
 =?us-ascii?Q?w8cXGIrqpgjmeUdTv8YqSf3UNUJkjmC7hB5J6QfTkoDb+YxqQtWGLlRT+qPX?=
 =?us-ascii?Q?UKOvC8PgapjA4elnsJxyL1W4L/iQZonurvTZeXN6NC0kIB4LRFfb+ru+hr4I?=
 =?us-ascii?Q?EvOhzJSI2f8tQoKtFO/jpzuqCH84NWXxHkYGcl0Y18Z4hzIp58GYhy1DoYvk?=
 =?us-ascii?Q?QrLp4XG7Rs2Y3uyXH1kUwqztAhdieqw3EnhSnHQp1lqPQ2Tgplg5cnDXG73o?=
 =?us-ascii?Q?MpSOEBk4TEQgCkq//TJrSd79AoTXWBo6aNHYvAquU/CHsNWnuuw30AGGdDdN?=
 =?us-ascii?Q?gwVVvLxJ0cHqXpiX9a/nar5hDZ28gWeTNzaivjywoRYBQXKmX9egz7FZcFO2?=
 =?us-ascii?Q?jZpqTfB3o/i4GasviiWVWUZZf/zETI2OtHvRmxzLKJpDZJ/5fI8MIxOrVgs7?=
 =?us-ascii?Q?tgo2jKgcHEV9o1XVG9Rvq/fjjXAhkobTdU2t2SDd9DooCJNOf2Np247wq+tR?=
 =?us-ascii?Q?5IOqLN7tGhBCbvfQNKVU7rvD0v3ot7aM1/hHwtmtwLlZ8hqTcRwx83Gxr5tG?=
 =?us-ascii?Q?jGSnqVDDYdDa1ofj09+zkDEcFn2xYa8SfQfFrgNlUobFUse9CNte5vP8JdLC?=
 =?us-ascii?Q?7563Ew6nwBGK2wnCHbYcxXUIP990JC9B9yHL5LU+VG13VzThAb5E0acO/oIi?=
 =?us-ascii?Q?WAZvs+rNZtd46zPfTFbgoGb16nypt1T+RsmKBJiK2iAjyoY80fTn3bKyo1/+?=
 =?us-ascii?Q?CTEGy+1RaGOcNkbooUHwf8PepaE6DtDDkAQnqQn956NgGcZKB8+76d9F5Ua3?=
 =?us-ascii?Q?T7n2MXJ3OAm5onA6uzExQYuW2wrl6WsCU7JEfWzVSEvReSZTlHbvsVhrBd+I?=
 =?us-ascii?Q?ISthl5SDmT8JTXhrqd1pMY37mfPu8WUDezHtt7ouXuTvWuxzq5to5GGWXKJ0?=
 =?us-ascii?Q?6HGGm3UCmtYohOCM3yz+s8maeIM0UM+e217KhkmSBaFi0ilAHF8zg/LXvNlq?=
 =?us-ascii?Q?BK2sfwxaQtEbWMB4a78gqzWg3SjfqCzNsFAJtx9eAqmKot0pRTeqN4IfYy+h?=
 =?us-ascii?Q?PkbPy1o+OSAgTqWYeaaq/EnQyWOd1zUyBa2zCMih2nw24NdyytnSJ1uXsIBo?=
 =?us-ascii?Q?MPkFjs5HzCUbtENn2c/famavvMnZeIGZtWvCVcGo8Lvy2ZEcDXnTZDIlBvWu?=
 =?us-ascii?Q?JW2+uwVdqjOf/HxQBGgQp4zeF75asTD6CnhI1Fmu9cG93vwWnNhQ7nCSMwQK?=
 =?us-ascii?Q?AZTmQIN9F5yvg8m8bJOSZqSu7j0ewRrp2ytT6ThgB7wbfPiD8pJoTbp678PO?=
 =?us-ascii?Q?+EyUTlR4318hgIBBvNPaEs2TnzU1RC0/frVwT6lh4ZqjrVEfU4Xde/jyBz+L?=
 =?us-ascii?Q?mcHP/zheP1qn0IoONERMkjgA3hK5ZJdHKkjIO/xOn8LSQj0eHZdyNFWy2wOt?=
 =?us-ascii?Q?gRFAICWKxBDH49ZaSiM94d47pRl/yAmX6/ppnBos/8jL8+eF069Ww9AtSkW0?=
 =?us-ascii?Q?8RdlZZspEz03fRQf3vGi1JAIYH6CX8tHufeaWfvplg80jQYLXaN4m1s6phsh?=
 =?us-ascii?Q?hNxm+wMBOG+cwgOlawzID6Wq/X16LRP8BwCrukkUC3Ei+G8AfD6TrAnlBb4u?=
 =?us-ascii?Q?iEbqlMccay2/fDveaxELaJ9NcZ2HL2RkgNRnx2ZUxjlG7YSyn4UOZMZBcygA?=
 =?us-ascii?Q?fmlFst5XdCYATGnUqUONTBHKz6mujJcc+2NXaSDiLBNFb8g2O8NSX6MXN5M7?=
 =?us-ascii?Q?ICNb8VQ9PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c96e17-db8a-4e8c-0ddf-08debb523a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 18:11:36.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIPc7tATDyDBYh1RIWNBYj9n6WcIQZJdyEztfDwMsN5MBgZS4yBtlwNg+scJ3O672UJpRK9XTgF6jYicLHu0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3825
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 18:11:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4057

This series is now applied.
Peter

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Wednesday, May 13, 2026 7:09 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>; jose.quaresma=
@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/7] go-helloworld: upgrade =
to latest revision

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 7f05d217867b2af52b0a28c6d1c91df97e1b5b39)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-ex=
tended/go-examples/go-helloworld_0.1.bb
index 3ffe64b..c8401c9 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE =3D "BSD-3-Clause"
 LIC_FILES_CHKSUM =3D "file://src/${GO_IMPORT}/LICENSE;md5=3D7998cb338f82d1=
5c0eff93b7004d272a"
=20
 SRC_URI =3D "git://go.googlesource.com/example;branch=3Dmaster;protocol=3D=
https;destsuffix=3D${GO_SRCURI_DESTSUFFIX}"
-SRCREV =3D "8b405629c4a5215871be932097e099c05ec5cb2e"
+SRCREV =3D "7f05d217867b2af52b0a28c6d1c91df97e1b5b39"
 UPSTREAM_CHECK_COMMITS =3D "1"
=20
 # drop the 'destsuffix' so we make the oe-core backports easier without co=
nflits

