Return-Path: <louis.rannou@non.se.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A9D0E6DF
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 13:05:29 +0000 (UTC)
Received: from de-smtp-delivery-123.mimecast.com (de-smtp-delivery-123.mimecast.com [194.104.111.123])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16595.1764075921734457536
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Nov 2025 05:05:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@non.se.com header.s=mimecast20240503 header.b=cPzINcCz;
 spf=pass (domain: non.se.com, ip: 194.104.111.123, mailfrom: louis.rannou@non.se.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=non.se.com;
	s=mimecast20240503; t=1764075920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqjJCVaeNoENZkBrLLFIxM8IXXPls3d/MJGzg/MSOTk=;
	b=cPzINcCz6VH3Hldw7boKt+JvuFNlbzI7kx3+p+777Djt/0GJ9EmlQo/e6s0CZ6Upp0JFWX
	6GWRBlq5W8eZDOF+k6gVfW67N9p/EvSlVHqzPO2ljMVKNelyhUpHi5h3yAtK/W9z5Qbsfk
	hgs8B6y+Cj3+bBJSRgwntLcnAJR3KqBDhsZN9Y9/VSugYGoWdJhb+eBbIyNKtfdorFPaGR
	CWjAiyxwSnqGN71qTGM9BiLLWWddIYwRhNZn/nbz/Sxz1nGQRLVEIyYKAP4TTU6B7X3Ee/
	B2B+sMDuf4/XPthoA15UZlXJsHAhx5oPfNZQ6G0bvw7ylke8d+I+Hcygr24PiQ==
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011066.outbound.protection.outlook.com
 [52.101.70.66]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-42-LaFT9_5TNAuogBFfz6RPqg-1; Tue, 25 Nov 2025 14:05:17 +0100
X-MC-Unique: LaFT9_5TNAuogBFfz6RPqg-1
X-Mimecast-MFC-AGG-ID: LaFT9_5TNAuogBFfz6RPqg_1764075916
Received: from DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 13:05:13 +0000
Received: from DU2PR04MB9194.eurprd04.prod.outlook.com
 ([fe80::14dd:bb3f:4e1c:d410]) by DU2PR04MB9194.eurprd04.prod.outlook.com
 ([fe80::14dd:bb3f:4e1c:d410%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 13:05:13 +0000
From: Louis Rannou <louis.rannou@non.se.com>
To: Scott Murray <scott.murray@konsulko.com>, Louis Rannou
	<louis.rannou@semalibre.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "rybczynska@gmail.com"
	<rybczynska@gmail.com>, "pascal.eberhard@non.se.com"
	<pascal.eberhard@non.se.com>, "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: RE: [meta-security][PATCH 0/4] openscap: upgrade 1.4.1 to 1.4.2 with
 fixes
Thread-Topic: [meta-security][PATCH 0/4] openscap: upgrade 1.4.1 to 1.4.2 with
 fixes
Thread-Index: AQHcVT9fQXOdeu8nokCuovSQmZKidbT9QkOAgAYqsCw=
Date: Tue, 25 Nov 2025 13:05:13 +0000
Message-ID: <DU2PR04MB9194DC15D54E28F0FECBF662A9D1A@DU2PR04MB9194.eurprd04.prod.outlook.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
 <7f3fa589-dabf-388f-6430-38065904b683@konsulko.com>
In-Reply-To: <7f3fa589-dabf-388f-6430-38065904b683@konsulko.com>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Enabled=True;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SiteId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SetDate=2025-11-25T13:05:12.774Z;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Name=General;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_ContentBits=1;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB9194:EE_|VI1PR04MB9812:EE_
x-ms-office365-filtering-correlation-id: b767ba96-ab38-48fc-59eb-08de2c23454d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b4rCKNcv6ufDlueKcQ/9sUyEdZTGEGh8AvlSwrrkVv/EmIRJnVHafTk0ZF?=
 =?iso-8859-1?Q?E8Jwd00YYnSf1U0WS+eZuBEyAkRmbIwRZ+93eZ3TefVoOkRBTBUZiwUQ/3?=
 =?iso-8859-1?Q?lpc7GUw7LLBSCBo/Il6oGyXC3sELteryVc4oF8NqdF13WucFzmtwv/96W3?=
 =?iso-8859-1?Q?8tq/Fwav1wrtKwWgSGF6SLvswupCLL0VbjC4/t4b03Y09b3RRUF2v6b2d3?=
 =?iso-8859-1?Q?cFxB88iBpn7Uzrb/OSKMiqo3IgryTuwpiCYIQ3nftfyheQ3HLZ5X+btS17?=
 =?iso-8859-1?Q?5/H2VKMyZYkXUr3zP36WGndxltg5rlph8Qa7+fRgrHUHRbhjeYTGbexTae?=
 =?iso-8859-1?Q?WyJkWiM5d8AT8tgJwA68VWmdb1DXaau4IccVNsfcGjP//HL/danPnbXjOS?=
 =?iso-8859-1?Q?F96rbVK8Z4sT6gKsm8Y24hU/FJWPb6+mGJ0JDbuZ53e3hu3s1ilrOr8j8y?=
 =?iso-8859-1?Q?ZDHK4rbFb+8EFCY2wgOHVD+vV5iCG5jTqsP63ABiIaxOqWtKfP2g4sbwxC?=
 =?iso-8859-1?Q?aLgp5KJOSdaIfWULn2igs2qUnySnl3uTXW6YXnxJmk4slwu8DBAi5MS21F?=
 =?iso-8859-1?Q?300CbC1IROf59j5Ad3UD6nYxwdEnmuJRs85bZERrzSlXC6c5dtDPWAIC+x?=
 =?iso-8859-1?Q?wiyY5QRogL+AB7TL9kbvplYX2FVYQ2UnoGvAE9sTw6hpPx9pfZlaSkED7F?=
 =?iso-8859-1?Q?5USXhwhkT/yYX0zOz2yTwBYDb71OZLpk7ZcKcZp7YTKsRRZw0kgWrfqQ1j?=
 =?iso-8859-1?Q?ZfcAdnaoPX6iLY+gnQzyO/Os/yDQUFFrDIeNHttRtmD2xvLm5iMKlWNwHC?=
 =?iso-8859-1?Q?7StvKVY6uWURSaHb0vtZhVGlH/lfeJ68AWgN22CSktk/PxWBETZlv+xp31?=
 =?iso-8859-1?Q?+2g6DltQJx1X5YHFUctHhTVfA3bfk6Eu8Stn9gwKsN6oHq4vfxu720bJA5?=
 =?iso-8859-1?Q?/7Ij+Lz1pWV8aCfiBWTZL5NHqPGVS47FtSmjLcOTCr+04zjBoeOjRbDMG5?=
 =?iso-8859-1?Q?kxHk/sxBKRp+LCMDpYd1iU51ahyBw1V482Xm84+J2JpT4LAIb8q0CHQpKv?=
 =?iso-8859-1?Q?VXhwlFhPGvgywzkbNEfIjPymqTZNwWrhp2DXzfii4oMlMBVseKEihOzK+G?=
 =?iso-8859-1?Q?IoIdG4u/nfvEmV3UpXb8D1f5cdqvOt6LKeEWqpfMK+qKdqKCvdN8amBrVh?=
 =?iso-8859-1?Q?nP8nj/FHwCIvqPZCtRUgKnJtfJTn1Q5P8cao+2+KxD5rCl+0lklpjFZvEg?=
 =?iso-8859-1?Q?zAtWWcn9GO6NTk9G+GeCCVooc9eeLhMmtVt9smL+i6PcbFDqY1u5/oqoGI?=
 =?iso-8859-1?Q?ttgyAe6+q7ePcMkNuxI3vGQUC+2WUzGsU4xzI4K8Otl72MrsfNUPYTIO0D?=
 =?iso-8859-1?Q?F8bgK+YmMhHH1evygNAJvJvvTbKHYFL2zIGkOyv20BIEiQdbcV34x9bDie?=
 =?iso-8859-1?Q?PsiQ293zQO15Ur1ltbnggftKERWJ59wPQR2BJcfR3xOZ1xzKTxxNr408CI?=
 =?iso-8859-1?Q?RM3fTq8WCmzBBDB4Jqkel4biVS1nCHbIWKh+Y36Zwpf+6AumgUBITzBRU6?=
 =?iso-8859-1?Q?OX7CnHYfq1MbhMj0fW5lAzpjy4L+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9194.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MS+FXrpuQm2mrQE/wevTNCXyPsmCaSqnJV5SwLsbDaKwp5UoFVKC6tNQPH?=
 =?iso-8859-1?Q?miYQpA2h/dQYzgWFk2dF+Q2llx4R0mw6+c4nu27Z/2LUo5geJqoE+RC1+b?=
 =?iso-8859-1?Q?vBsRDawTlMa4ghubmKYrmuM+j1CWYaTltysCN5ryg0e2OcyqvM1R5mxOj6?=
 =?iso-8859-1?Q?OwZ0F6wK9DUbFAQmIphCFwPRY+fRzPSPKu8KFkKhPgAVO04VALYlPSTOh8?=
 =?iso-8859-1?Q?Nbssoi//jMB4BF619XEx7I25KoyBjYsCaVvAz0njQ4MrSj2DDo0Mi+jKVc?=
 =?iso-8859-1?Q?ZYwtMZyZHf385MwN4/zpFJVKroXaJ9tC6vE2NKGiBG3L8DbtUB5eixkQJj?=
 =?iso-8859-1?Q?IIMw/5icehfkoVWHYwiZXGborn2XfF+/0kDabfBK+HY/OH15jWFHBMGc6Q?=
 =?iso-8859-1?Q?zsklINkzGeiCJOnp7kvutMQfMSGs07/JO0y0uAR2Kdkv+WVcAZqtzeuyAl?=
 =?iso-8859-1?Q?Y7Baw4tIS21fPSeMQJtmeROTVRKJNrPZhxTnFpUmWFJtY91C9qoqGumLbL?=
 =?iso-8859-1?Q?zr06jOpQNzgaC5HDV9DbTNjnt1gKHCLcXOOmo//EzfBfuX1jXlwk2S1q3F?=
 =?iso-8859-1?Q?9N5gr2cLzdyInasNTvQbSPfWXoRIcwdr59fANMytgzs8nIUWfs6PgPGAK1?=
 =?iso-8859-1?Q?XQhRTTwVqc3Q6m4/CZiLHBuF+L2wZ7xZBzIXCCAo6GPQbyHpbGCxpdrUBc?=
 =?iso-8859-1?Q?OPBZu9bZb/bDbhMB/dQ4DckL6sFXXs6K2ce357MVGROJUuHxrYHwNbB4Xx?=
 =?iso-8859-1?Q?csv9YAImkCu9sgiA+rIm8nv92oj/NLR74QCETU2QUVtT2mpCzJFicub17s?=
 =?iso-8859-1?Q?rlpdvlRT6RNCpiojclJNomJ/E6WRuh6QI4Pzl6+qGyYco4a2i29e0GCA5O?=
 =?iso-8859-1?Q?FUY6/p1pb1o4NEuqRBsuqxBk92IEgDaDgMZKKV72z8GxB4v7JLI2xRmowu?=
 =?iso-8859-1?Q?xfS9MxRx4BGrR0FL0dPlCJ5fGylmlFgmruGTUs56QZlf7V1XG+8npsTKi/?=
 =?iso-8859-1?Q?QMaeT+dS53byyyjrmDU2DyPX1Sl2H42HEzX/+JG9/1rjw1oDHZ8RupIDUi?=
 =?iso-8859-1?Q?+wd8opgJIu9O3Ib44zrhhB5/HpVSWv4MpCCJN3VGTltk6W/Z5J9RGkJkzD?=
 =?iso-8859-1?Q?N1b0weYUiIMuCh++wAfnd88O5tTkIVQHUQsGt2w4q7UREV/Yqvu8dceLeH?=
 =?iso-8859-1?Q?jEovWoGfKSRhPQJgdhlCN3f/Ltb1bQRXAONM5srLoW6iiBc+wpD/PjZVON?=
 =?iso-8859-1?Q?F3kHof96FABebzQo05NF3XcY5sTJIv7kPMYKDBVpTNs/n4As7uKexnga7Z?=
 =?iso-8859-1?Q?MA+SWQJQ2dy7hdxtosgh1TSmP/JrH2L5BKCrRbMCcFqZaorvi4sMpxxHBw?=
 =?iso-8859-1?Q?7ezN2DUtxVLed9EJvNgXUOp5iW84j6tVfWddQmOYXPSQzetlQytOsodD/O?=
 =?iso-8859-1?Q?3iKM3nIbnqRVGu9EFgegM5GtorS77tkMYFtP9f6s65MGo8uUIAmDNlnF5k?=
 =?iso-8859-1?Q?ZzI3ZzSrjADTmAB3Fn5Aakg4HmKbY8mQEukS2JxAvNX0f5q8LHiKA8eD/Y?=
 =?iso-8859-1?Q?MZaPvc9p3XIJB0RyyEKOn9s/ufXCJn9W6fkezmM9tXTT1Dfq5NpIZC43wJ?=
 =?iso-8859-1?Q?yLq8vj2Gdj888=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nUkaefz07uJZWjj0e7tyLzU9ZnFy8OkO/ENnHsd8BxlcNc/XsE7wVhngOUEERtwWTl7ExR/gxus0CKvJkYgD+C4gZYF7kARO1oxm/+LCjUxe1mrcPtfkssC/DdPRRYUMeC8aklzbdb/YfGWMF0nutW8igc4aZMybWvf5VuyxuwIh3/faa2LdqsV+MsoF6X4inOJRk9aPWxzNKXXnFPWFBRCdI91yWOxrYvAMfqqBm/7x6cKPpEeswD1BgF581Owt7hOvTrrWTMpvk9XOMdrSOOv5ekWSSoD3kLJQ0L2JE1xQNoGHFz7ft4AlTNvh7UJvrjaNAnd8WhBwuhb2EacYQIrR91F0HwNFjNlUS62NyW5dbyQo6hcmMA2nmttu7evBmNgFPSJO5gS6a3dPuYyZoL/iRWjvcUL1s/RyAmNDEJIsi383q1B6+jvx2A+2D0XCRefvBeA6iqRVcZ6b2LUBkB+KKOoMnysAerzFjPvXY5ZkH5p7uLK4USJPI6zQKZNI//xp4T+CCq6FdFMqfbvzDU3dSgNg8fC0J+K9UbWIJI9yQdHsnsIy49UuJ7aSM+tSp16gE3UgVCW8Z/BozWj3CU8nQh6keAvwrn/aT/t6emNDbxkq78+JCw8IKhaWAk4q1M4LHD2qaLE34PNqmoXmYmEUAuJ6nDCQ+eAeTatvo5m8yiZaC8SRgzFUgEtyCoaZ
X-OriginatorOrg: non.se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b767ba96-ab38-48fc-59eb-08de2c23454d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 13:05:13.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnktMlan+LUF71P3zLidEWVjd7A7oSu4aRjvNWvn1PE7ssSFCQ4W3Of0EKwYLs0kupub4CVqApwmtBIe8n4OYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ZkbTeMf9zUF7zKw6m3G5f3zZZfleXb3ixjla-qO01I_1764075916
X-Mimecast-Originator: non.se.com
Content-Language: fr-FR
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Nov 2025 13:05:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2708

Hello, I thought those errors were fixed, I'll try to give a second check. =
Thanks for the cherry picked merge.

Louis Rannou
Schneider Electric

________________________________________
De : Scott Murray <scott.murray@konsulko.com>
Envoy=E9 : vendredi 21 novembre 2025 15:51
=C0 : Louis Rannou
Cc : yocto-patches@lists.yoctoproject.org; rybczynska@gmail.com; pascal.ebe=
rhard@non.se.com; yi.zhao@windriver.com; Louis Rannou
Objet : Re: [meta-security][PATCH 0/4] openscap: upgrade 1.4.1 to 1.4.2 wit=
h fixes

[External email: Use caution with links and attachments]

________________________________



On Fri, 14 Nov 2025, Louis Rannou wrote:

> From: Louis Rannou <louis.rannou@non.se.com>
>
> This series of patches makes an upgrade of openscap and scap-security wit=
h a repends fix
> and other minor corrections.
>
> I have based the source on the well formatted github release instead of t=
he commit
> sha. So let me know if that's incorrect.
>
> It also includes a runtime test and musl fix.

Just a heads up on these, I took Yi's prior upgrade patches since they
didn't change SRC_URI for openscap, and then applied your other recipe
fixes on top as a separate change, please take a look to see if I've
missed something.  I dropped the musl enabling changes, as both openscap
and scap-security-guide were still failing to build with musl for me
with a couple of different errors:

.../openscap-1.4.2/src/OVAL/probes/unix/process58_probe.c:161:18:
error: 'PATH_MAX' undeclared (first use in this function)

and:

.../openscap-1.4.2/src/OVAL/probes/unix/linux/systemdshared.h:188:50:
error: implicit declaration of function 'basename'; did you mean 'rename'?

(I saw this one in scap-security-guide as well).  Please test locally
with latest oe-core master to see if you can reproduce.  If you cannot,
we'll have to compare notes further, though my test build setup is pretty
plain.

Thanks,

Scott


> Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
> ---
> Louis Rannou (4):
>       openscap: update to 1.4.2
>       scap-security-guide: update to 0.1.78
>       oeqa: openscap test
>       openscap: fix musl compatibility
>
>  lib/oeqa/runtime/cases/openscap.py                 | 48 ++++++++++++++++=
++++++
>  .../{openscap_1.4.1.bb =3D> openscap_1.4.2.bb}       | 16 +++++---
>  ...ide_0.1.77.bb =3D> scap-security-guide_0.1.78.bb} |  4 +-
>  3 files changed, 59 insertions(+), 9 deletions(-)
> ---
> base-commit: 9f1d763bb17bf105cc313a95eb3b07496b34bacc
> change-id: 20251113-openscap_bump-5c33d1ab2ceb
>
> Best regards,
> --
> Louis Rannou <louis.rannou@non.se.com>
>


