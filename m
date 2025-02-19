Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25DC021B0
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 18:02:55 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.81])
 by mx.groups.io with SMTP id smtpd.web11.29286.1739988173364677795
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Feb 2025 10:02:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TKiV/Iis;
 spf=pass (domain: siemens.com, ip: 40.107.241.81, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECDrZFswP/IYZMA/+SrTCXntfAlSrLn6tca96TD28AxYAV7eSGkisXs91nQDbdDo/FqsX7AR2z7pwfnwgIYbsZwgRv39UaPEwtpQKLPhlla9W3Q1wGdJhsd8GFCwQFrcsJOUt7r92JRngbi7IENarx2ArWcQrWpR5MOIhNBcQmcngWfYJmU9H0Hs9T1UmZS34rfPb6503w4Uj5xI5Ww6MkK1tW2n+fB0S511w6ukcADr2b0nMFDs7K6kKlkP6jEmyBuqdmjM+bzoO5FbRUAwgpxVsZp8WewgyIqba3QITQYOyT8Dh3YVXpKXbwg36ljtl2wCldHYT0vJhAsSdOV8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R684Yw8vE0Kfa51UKwZb2ZBy0T/V8tiJ4VjrK2fxZnY=;
 b=ClQA4dvXZEriw2SJVAC/hy8xY453iQr7mBVRamCmOsNLd7+Kf4o57sVswS1lT5aYQF6WXmjSER9lpDK92FindcoZI1ZT6ikzozIuDONDoQzzxUh9GO8RfHO6QyfqaDFHuJk3gvJNIVqQlekFwhfNA+eoPVRfT/G53rGySABXAFzpE3X3zCzXauRLHNFizmCcOZXsNXm9mnEdMdSUpYlCrP02IGgEL40IKak51b5S5moPa5RbhS+JNhMSiEMAMo9tlr3iK89ehzYiKrLYYSTozipbfqUFOsp57OCyUJriI6B57/fipcX7lE/yHzBbxsUXgW3D9OjQ2UUZbyqt7Oq/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R684Yw8vE0Kfa51UKwZb2ZBy0T/V8tiJ4VjrK2fxZnY=;
 b=TKiV/IisvkaggCBhfy4L74aXpdndBiGlrftbUP4h2zkYRblOPyoSwXHE4aaYwkjw/JdWSTUci31auRjHKnLm8TA/o6Hz6gnekm0pyNz2aXE5H9a958i8XbgWnrubWwX0et9/zaYTHgl46NHlG9veVDqa5IvnlqWiUx4wOKXUoGq6+5GQwMmt8uYp3ao3uRXGWI/+OAEETLSadntTMTFLaumntbN2RKauWDKuY2cZbeM+GvhbXTrTE/AsPpBomqtr6+W2tmIGA6wkC+ceZKHi0/vIS9e206G0yLYJBeOl4T2LZ+i3R6L31eh5UhDvDoiwOpX8Aev6Xi12gWhyZ8B3/Q==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by PA1PR10MB8329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:450::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Wed, 19 Feb
 2025 18:02:49 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%3]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 18:02:49 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Joshua Watt <jpewhacker@gmail.com>
Subject: RE: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2
 dependency
Thread-Topic: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2
 dependency
Thread-Index: AQHbfko6GUNWMq9ROkCR+ibCRuRcH7NO9BeQ
Date: Wed, 19 Feb 2025 18:02:49 +0000
Message-ID: 
 <AS1PR10MB5697639AC70EB51E87E51514FDC52@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250213190424.1873927-1-peter.marko@siemens.com>
In-Reply-To: <20250213190424.1873927-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2eea045a-b18c-4267-9166-d5367726677c;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-19T18:01:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|PA1PR10MB8329:EE_
x-ms-office365-filtering-correlation-id: 43b7baae-e04f-4684-95d9-08dd510f9f75
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IBanqOdWYPFQaYCgJOJpDF87uHk4ej2qgKqDr7lETcmsu+ez/5o6TBTx6Ot1?=
 =?us-ascii?Q?aAkC2Nd3uPTIYF+xecgRLoCrZOYgu9qr6ZfuH4YTxjW9KmXAtquHjVmq9I7H?=
 =?us-ascii?Q?l2kvCaHJ1jdPOOQFZoQOc1KetLeqFZb779BBgrodLGu/E+HeAXZWJr/HkLwH?=
 =?us-ascii?Q?jMcFrZAstn6tl0ZwkFQE+J2QBArRfRoNIIVUFS+V3SUKH7Cx0iuyhACXqwWl?=
 =?us-ascii?Q?VbTFb8NSvsR657FBUUcjoc5cFQokm6NrMA5oMGosxY9tjcDfLTN3AC6u3Cod?=
 =?us-ascii?Q?DQYb/1LOVItrnWhAsQ5cOyBtWazHdfQWYonJpTAnZ8nmX+GQT0Vs1vUS3vS0?=
 =?us-ascii?Q?N64baJzdOUIoqfVFnUFiFyBOyqkN71lmKvxV1xR3LCxcQzpLvoFpxXNX/LHw?=
 =?us-ascii?Q?QhgqDccmnxMtevO+WanGr5gaCzvIdVh2irEn0ISakCeQBbLc+i6RwYjLaHEd?=
 =?us-ascii?Q?ypCPG9y8uLIrqDfM5ey2CATeq+XQjJ+l207vf02myoBuTmWUJeHF5u+uT4Z0?=
 =?us-ascii?Q?XtwG0Fz6Eb6Df5KDFhehMfAbNsSSGdhXdCFfbN+ifzEiceM4KQSfMYdtPgMQ?=
 =?us-ascii?Q?/kTdOcYipbzjzP6MHA/lxAaNJk56zPW6g3ilK7QMhUVGKinTuQ1602zmD6iL?=
 =?us-ascii?Q?fo/L6xAYpoi7NpHcZajxH8t3EMhM8PvBontY3ensLw9LQfDR42i8GUs5wVab?=
 =?us-ascii?Q?b6tMbvJZ+Uywc21VvkvM2UTlx+hrSZfHb9kbgVg1QxSlulAWC2QWoL/rOn/s?=
 =?us-ascii?Q?fpUF2F40elcJ5dJKVZdoVUTRVYgOIlqsDVUPmyUcr5nCGd2jNpwbWnRwjEwk?=
 =?us-ascii?Q?18M1KWmNFi+4SybyPqp/jjK4UAHelS+QRKHFZOuhleOdA2mXQ5ZosCO4kaQW?=
 =?us-ascii?Q?XpKTiBelof0fA/zaNCV+VUgwXYLOdfMZHwEe+MzSvv1spHkUHx9yPRLYgPHh?=
 =?us-ascii?Q?J4Dlse+CyHMHrFFvjSABsjuxJMwWLtoHt54wyhRREdiRhkXq8NhecwGAmIAU?=
 =?us-ascii?Q?3xpMkBsMbSldAhpYFTdx/Ex3JBKTddwfMmQXBo2wAHMVqqH83Y/TabEJVwqR?=
 =?us-ascii?Q?0pvgxGhmWFHzvABmjj0eVjIBn7OYPbzfMJ3N4wVUxCLmXSzAYMijnOOPhK0N?=
 =?us-ascii?Q?IFwL6jfViY8mJyk1Tql4sfZcjhj1NvEGLHWeoOcSYK2qSamRpqA0reG4J+WS?=
 =?us-ascii?Q?p+a/RL6S3+H8KegrCnkfywKLEfLfbSRFNOqOUTXjcmdiEAe8z3FXow3N4kdX?=
 =?us-ascii?Q?N6VFjniJ6iA/rsCYJreTUr9/VWry0Jn2E5USgLCSbaVZ2K9GJnT1ReSZ0xA1?=
 =?us-ascii?Q?N6YaHnJEIQ2xl2XYEYEU0Pk0zm1UYvoC7Sjdj+QFfbWaX/nbcwTNiVVi/F10?=
 =?us-ascii?Q?/VbAOLODJgSh7oKRJeQjkkc9lclpC9+HRjIphFtMnCifetbNHA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?H+wMpfKOqcNA1AKHYgF1m+InIpDfiuEgbEqriiBC8plbASLZIKY0hzYu1QJM?=
 =?us-ascii?Q?f+13eB4AEm7AX/rusXgOpIvm2jvRgFHBtmvU+mkB3D8DB1ZL1/fRJZGFPtbG?=
 =?us-ascii?Q?EH0ipniE2dHMoj2IWYNVzbeh8YZY4itViwFO1mr6V1nLfHMOdLpyyyokwuq4?=
 =?us-ascii?Q?c57HRe3vtNzFWbqg9weW5zupF9NrpxgfryVqBfMCnhD6pM/fNEqcHly/qakz?=
 =?us-ascii?Q?pt7vSgIGKv9Frcf0Dt9PWsgSF9kQq8SAraWwCl2wCgjyR4h1p+O5blvkVVjw?=
 =?us-ascii?Q?we0dwpRhG1rfW2v97XCSJk1b7HT7OlLIvORKJuy9kUtcllb1udKimZjtY8Y4?=
 =?us-ascii?Q?rojwXtQIqTCZNcpHh0rTFGey7xoXfDPVrIarlqxykgDkKCGj5fdFo7Mu4DuM?=
 =?us-ascii?Q?lIS8VJbJnAVByKLUoxwhyYVvFH+3hqnzLInFf+c5bHJrCMUU3hhhR/yXWG7J?=
 =?us-ascii?Q?4RfE+80SDJ7sh1bv6lzIVoWoaEEcZMvRZVezOXsuQYKnu56jP0ljIzv29l/H?=
 =?us-ascii?Q?SAeyzCfB9yVUCCraECVCdDURhG4l+x95rhU6HnJLI4cePn9XtFsCD4j8iWK3?=
 =?us-ascii?Q?NUZxHLn+uD0oS2SEijuTsVNoOugh4AJBI1Nx8jXdKj1L7cRmg/LVtKevM9gn?=
 =?us-ascii?Q?ge7ddIMp4FqnhY33nnwi9nDDI5CgdbnG6+T/+aZK6hlMFOvyIbXlyg2JRWYZ?=
 =?us-ascii?Q?yzTpfptyjHNu4mGVuiQJCRLXefYqIopMsl9WtwrmEeuvnx8LGUV4E+0pDyRU?=
 =?us-ascii?Q?BPS8nAsJI/qd0Fs3EtOaBA9Jd4E3GSDIfzIOKSaQor7g4QPIE/j6E5V8pQ05?=
 =?us-ascii?Q?PDrZl1DghMAcivjXivR2tnudcmH8lQzwjJz5LAhuBAjNSH6b0EozW+P2Ff7d?=
 =?us-ascii?Q?tYOf4wzRgYTjtM/0eSCEoGEOececGk5YxQFfFXukwv34jJc9AcUA9cjrpXQT?=
 =?us-ascii?Q?OBp5AEDVYO2BgeKTioF3u+dkGnTAOVQRVKLOyDVAHYcWGgf4PR70OvrnV1Tb?=
 =?us-ascii?Q?eM+3zETQGOvtY3gXt0mepjXNrFPRH4+P0WvKQEpqlhO0oHrFEvhQqF7FOFrD?=
 =?us-ascii?Q?jP3dOt05V8y5/+TwQLZfuIkb7/pRhuq0HPYQQwJhEDEz9xdAOJqgQdLcBguQ?=
 =?us-ascii?Q?QvvLiZ7QxB1ycwfSMr7xrPAuR7NemYh8TWV/mtlxNDpwkoWPOkY+fYHxizQT?=
 =?us-ascii?Q?UNjqM3d62I8PuzPwspdnCs1ylKUHWlUUUN0eHfds+G8fES7i3QRNLxJVlXBj?=
 =?us-ascii?Q?kGuUcmylTZ8gYOwCEwPG43Xk5utV+1CHAGomsjWTdJ+UxI4RVZ16Q9JPtJ2q?=
 =?us-ascii?Q?5CsOfdhBcvv+N84ICJPIKjG5z4epet9zcZgR4CAgTEg+4cuUe2b2kKw9OsUr?=
 =?us-ascii?Q?qAdmscu9od6RNbt0xsQxjmjizNnCmMmN8pEfucha/X4ZEHA7rIjxat8iFVcx?=
 =?us-ascii?Q?XGrggu5UIufAo6OvUkDIcQWC4RjkcQEETonSablGC/n3YXLgBTevU18fn8cq?=
 =?us-ascii?Q?h2jRHknfbbWkq0sQIhtrLwH7my+6/JJA6NgDszvlEdhnsoNOdjum2ydn4ral?=
 =?us-ascii?Q?mAl8u4YCtnriqtE+JxfAtnjOlbNsrtiKlloatjjg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b7baae-e04f-4684-95d9-08dd510f9f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 18:02:49.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngF/I4bycI14D5a24SujSk4rB7IKW/3Jvf7jFDeogbVknelLztV9i3Wo9k2O8MQ8tS6apny7oHxO//8Fn20BWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8329
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 18:02:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1093

I guess I forgot to cc Joshua as described in layer README.
So adding a ping here.

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Thursday, February 13, 2025 20:04
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2
> dependency
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> This was removed in
> https://git.openembedded.org/meta-
> openembedded/commit/?id=3D83c6dfcce6c334d9e699858614e902f2a5a41e20
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  .../openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend  | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/dynamic-layers/openembedded-layers/recipes-
> devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layers/recipe=
s-
> devtools/grpc/grpc_%.bbappend
> index dc0ea42..a72496d 100644
> --- a/dynamic-layers/openembedded-layers/recipes-
> devtools/grpc/grpc_%.bbappend
> +++ b/dynamic-layers/openembedded-layers/recipes-
> devtools/grpc/grpc_%.bbappend
> @@ -1,5 +1,2 @@
> -# doesn't build and not required
> -DEPENDS:remove:mingw32 =3D "libnsl2"
> -
>  EXTRA_OECMAKE:remove:mingw32 =3D "-DBUILD_SHARED_LIBS=3DON"
>  EXTRA_OECMAKE:append:mingw32 =3D " -DBUILD_SHARED_LIBS=3DOFF"

