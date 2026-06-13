Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B8CD8CA8
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 07:43:03 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87309.1781336576782500694
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Jun 2026 00:42:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AkL/luHK;
 spf=pass (domain: siemens.com, ip: 52.101.72.70, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUm9PAKd1/0wS4+IQlTFPhrMqNvEB8BmBODNGZAWH2r+OU4eOhLbAixS42ExDuRegdDFQ/mfF0zxUYckF1rJaAjw4gt9ZJmOw6nl5PFUYmFvYqX11Azn8W55yKdEyy6g+UunOmijKNFZVff3CfNb9ZkVgZxLTZV0PPEMTeC10M3W8f1vtizPkQi5dTV7tvSY7Rf7999aE6aKl1xfMwguCfDx3C58QE87bTSafdU7NAO3C7RlkBTRQDajR//L/KzBdZvuG9iruiWVlIJS9w4wQK1vrmI+5MP4zuyuvZlPzy9Cs/x+h5IY5aw93QTOjhXgiPkSkNgrRKs6uOLY+5ML9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKWaj0YooyFBOcHlUiDKFUnxh9i8InSCtNEMPfYk7gc=;
 b=e24ldjJqX2H9Ap/gGVt9lvUrVWYscuJ73EzaNqdq57rZr/ulN6z8NBhNwoTyFUEOBDGz8HpOv1Qv9qg8YKa0iWmHwc2PmhqFpZ45CfyW7C2JpF/gAX9FqX7z9qr38pHzTwL2H1e7q9yuIJsnnFIJTZaSUnDF/CATlNHdA+RJGW4uM8ZtDwXmY/Yt/Db+5ZCpYPq9aZsV5GAm/baLvGvqel7OUzc9KxzGz5QF8EgzydX33hN2Tefr+MclM1P85+LHByQ35/xQUw7vbunnaJQvUxIyu6X8ZaTyajc1DzkPGUVJv//VRLQeJuivVwWQlKgHLuStgjZWEkymmVID/GTV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKWaj0YooyFBOcHlUiDKFUnxh9i8InSCtNEMPfYk7gc=;
 b=AkL/luHKjwvU3MJ6TIKUOmiv8FtN2Z1bzarmVkkfsTa7coPudcv8zb6WEdqzvaaU3QZn80J7l2sM1HWvF+9b7b3gVWDojI40qiIhf4dUkMFU++NqTpD0sGg1eTFoH2zYeBLoez8JFndRZ8lkfhu5s1s6sEjYi/UJPYmHOhibKHO8/HCviSbSaWKU/HbUump70qHUg//Y66eFtR83ju86Hiikb7xKvnfrkeAY5d97E/2B9GKlfhH1kxyPR8H2cnZM1zt+fkT7oZ6bnq+QrVyi7QPjEse9lyvlvA9uhuU7sox68Y16nQwS5rFlZ6rPw+JGmJtHNfJrx2/ni9doZDYSKQ==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DU0PR10MB7407.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Sat, 13 Jun
 2026 07:42:52 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%5]) with mapi id 15.21.0113.015; Sat, 13 Jun 2026
 07:42:52 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go-helloworld: use
 bbappend for mixin modifications
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go-helloworld: use
 bbappend for mixin modifications
Thread-Index: AQHc9rQXo2CTkOA1kkC4JcFvLY4DB7Y8IvGg
Date: Sat, 13 Jun 2026 07:42:51 +0000
Message-ID: 
 <AS8PR10MB50737266652867E0FF0E413AFD192@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260607192934.156036-1-peter.marko@siemens.com>
In-Reply-To: <20260607192934.156036-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2e656e20-8d6b-4cf0-ad42-d292eb64f7e2;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-06-13T07:42:24Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DU0PR10MB7407:EE_
x-ms-office365-filtering-correlation-id: 4cf3a515-511f-455e-4355-08dec91f5fbe
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|11063799006|3023799007|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 m0JasbGYZG0qhieSZOW3Sjj35w4tfJFQdgB4bG8mfQub7jigfV1G3UgcZX2NP7pwToJSbem+DEeHiuQXzuQGIo1c1mVmPKduKchjLLUOAWbQCn8yP89s/7Wn/lZFoyQyit24DIYPSOZNjauxPXfTqvZNR5zklc9XLKHmWjvBphQt2L3JHTKChr/hCdkpSgB1AepRTcvS8wVcdhzAqBzwcXEe9cUMq9DCE6U/4l73fcSOcpAAoM5VI/mTrh9tcg1R0ORMeHgpJfMWq4FUx9gAA7seS8qZEKZpQ0Kjp3St3x4rw6PLTrEzz4Ih/xute3PyGZ2vvuPRPtL+G7ONFaDLdtr8lLRJoTUqfbQmUW6r/SrUSjXtS/tHUgDb4YY5xAdpT45s3IiYCmOK+uZRdw/LIWsR1Kn800PpiYjcp3U0T5R0MueizXRNk4/w2vQ2OP6zRnMY6GMF5jyS6T8H6TEduJN1S4Q7pIPa8twEHg5Euxn8G2hRxgu1pmvCC5Kmt3vXCio1MWfkoPq1TeOzWzraViuL1I2yhyH5LIRdvSxoa21IOORzJIIHL/6ZoZf9JNxsIjbrn6cqdPN0bMbwGif3x0VbfUrhTRphJh3K3JUiaI6FOORvBJCz+peQguyztXflqNZwFd+ry6tsjZ90E/AgkKwGUy1ZY4Ug9TZV2JcmAxjHIHc37JVeJiDiOLGntatDRy04R90fN7ivlE0KTEvtXsiPL2HmHUTRPcAI202qMetK7ib5WAAho3h5RJqeeZx5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ub3ejnjlsdsBn+JfBTWj2UNN7S2VFyaEYfFUQTM04L4g77lixNxEOJTDJFy1?=
 =?us-ascii?Q?5g8Y56FUi/Lvw4wIxfBK2XzMPgocae1D4vt5Bfd/voDYmc+xoA6x0LEuCbEn?=
 =?us-ascii?Q?Y1XyZdRIRnLQrMw2vXYvAz1Mb1UmThb5As3PVsBvpOiw4QAJ+ruOXyzaYDXh?=
 =?us-ascii?Q?TO/cLQoPnj0EU1J+cf3qeEA6nMam0SxiTBU2IPDocFLn/bw5fW9hUpePFZh7?=
 =?us-ascii?Q?DuurDc3tWvRd8RxLQ43AuxtVz4+761DpDXMMBNsPWalstBnr1YAJ7DPK/hlf?=
 =?us-ascii?Q?GyzkAEXmedLQWfutfqFJqCgR/3ZnZWAhb7OZNMR4p1XsViTXjV1yCYPvqVeA?=
 =?us-ascii?Q?m2fDcWL+yNRj6F54K4hk6mk3eM7mEIOT5gcBen6URbd+fZRXKmeIJAkNw5wr?=
 =?us-ascii?Q?o3Qpx6mYYR+1lAe6pqDXP4GGQkBR+tIhi9yEhd6WekVS4a+4B9xB6vOXzFjN?=
 =?us-ascii?Q?Sctj/vZv0ZcbzaLOINjRcfKYnWQ677ME2tLTWbcnkbn5+tR3Vmh8vEcQB+Wr?=
 =?us-ascii?Q?aOdsyEbfBaE/DcZiHDMUEETt+/ol3InOz4t3Z4H22mNyjHoiFS7EPmMjAuyx?=
 =?us-ascii?Q?RhIYJkfvgmbab2re+cWU02MeiNVS5/rtpflowIRQ9gXmh35fINcw5cQ8/kt1?=
 =?us-ascii?Q?iwZ5+QUs/+VLGXs1d8/ODXdTdyYiuJsuqAqxEXUlh6CHKqe3Y5pk7CJop/XR?=
 =?us-ascii?Q?tDl39tsaRbaEgW7BPIgz9XnGm1TGDkotmz6IJ+MRWz5mKBPRIHyElvLQnZCO?=
 =?us-ascii?Q?IhTjmCNxI+4XnTDFNu2Z2qO6EVo2HfZv6KE+inYfgLxKCvSKpzaxra08owYv?=
 =?us-ascii?Q?patYGtgUjFk+/uEWbYDUIwrb84Am6B0GZNt2qrkXlyjqWWDeTAVRpZzAAYrq?=
 =?us-ascii?Q?6mvuUqSJb4yAS4xOzY3IzObMQZLqr8R6iFsy8gJrZ5bdX29vx5dRkQOtlEI1?=
 =?us-ascii?Q?vi6BTwRMFDooyCfbCsaM0ojWFcBySFSjlu9ELc2kz+g4F7/3uAxg8MW93Qnv?=
 =?us-ascii?Q?G8YLorFWVats2w7md2uFWyO3Zx6HR7RHazrZQ5i5JCYaTupTS9b0h9UvavTP?=
 =?us-ascii?Q?rRmQmjCBpclNlanM+0AiVhdHF85pBF266280Ld1B3RZgbo0E/mWm1N7qY5Pt?=
 =?us-ascii?Q?DxyAi655nS9cDtcmxaj5PBGomEX7SOKm5MTlLCOaOlKTVhv7Q889yp9+YT5H?=
 =?us-ascii?Q?bzrN5oxVZOYZx6wo19UZIsq3XWb2Bjv5GNF6pg+V4XC3OUSHO+449AKcb+M9?=
 =?us-ascii?Q?U9WiqqRIhTAvZE22P66MaXkOsOVL+28oOjKS0cY6Q/mZe9HFuXawyb6ahDRE?=
 =?us-ascii?Q?1BgAIVDeeLHrPXU3gqx+6qfP1Gr+KCD14wF1nu28Dn4l32hFCtnJQJm14HGl?=
 =?us-ascii?Q?aHE1BtOSX6mFzqdHA7SBiWep9eqdtmBb0sZ2O24RNPb8fNr6WQ8Q+7CQuz7F?=
 =?us-ascii?Q?lwXpIcsucEXqD3ohsdVYubd2L0iZy11JfeCuZY0vZ3RbC2F6IlWg38+0O/X+?=
 =?us-ascii?Q?idmPeK1Rou3i50MeYymcT8I/BCwLKoOIJfXbIOFxHjVKvujKl+Wtmxqh0cFy?=
 =?us-ascii?Q?qqAuhgKv2BPLIYzIoTFBoXaMKp6wKvmqiUYBJc8iXa881ck2k4OpeCdhj/+i?=
 =?us-ascii?Q?ALOQ8lwTiy24BWqL4YR0GcGbkCkvSGjt7rAA58NuRtkKWh+8/deFfrRsc/rZ?=
 =?us-ascii?Q?xrAu+nvY1igS8br2F1lhh/L91B66FNc2XOkrxrMTr7BB+J8QzOl5AeesujnM?=
 =?us-ascii?Q?Y59xSP9tpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf3a515-511f-455e-4355-08dec91f5fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 07:42:51.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXVZUG2uPPzt3oUObO2wMnQfg/1Isea++TK7/aSaN+1bN68w/6uPow9xqMS1PrBk2BAzci+TUVMQH80PC3lwXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7407
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 07:43:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4220

This series is now merged.

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Sunday, June 7, 2026 9:30 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>; jose.quaresma=
@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/4] go-helloworld: use bbap=
pend for mixin modifications

From: Peter Marko <peter.marko@siemens.com>

This makes cherry-pick possible without conflicts.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb       | 3 ---
 recipes-extended/go-examples/go-helloworld_0.1.bbappend | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)
 create mode 100644 recipes-extended/go-examples/go-helloworld_0.1.bbappend

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-ex=
tended/go-examples/go-helloworld_0.1.bb
index c8401c9..77a13b3 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -9,9 +9,6 @@ SRC_URI =3D "git://go.googlesource.com/example;branch=3Dmas=
ter;protocol=3Dhttps;destsu
 SRCREV =3D "7f05d217867b2af52b0a28c6d1c91df97e1b5b39"
 UPSTREAM_CHECK_COMMITS =3D "1"
=20
-# drop the 'destsuffix' so we make the oe-core backports easier without co=
nflits
-SRC_URI =3D "git://go.googlesource.com/example;branch=3Dmaster;protocol=3D=
https"
-
 GO_IMPORT =3D "golang.org/x/example"
 GO_INSTALL =3D "${GO_IMPORT}/hello"
=20
diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bbappend b/reci=
pes-extended/go-examples/go-helloworld_0.1.bbappend
new file mode 100644
index 0000000..b2c0661
--- /dev/null
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bbappend
@@ -0,0 +1,2 @@
+# drop the 'destsuffix' so we make the oe-core backports easier without co=
nflits
+SRC_URI =3D "git://go.googlesource.com/example;branch=3Dmaster;protocol=3D=
https"

