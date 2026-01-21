Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82669C44506
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:52:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17986.1769017963786241929
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:52:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=Y8VMgEaw;
 spf=pass (domain: axis.com, ip: 40.107.159.31, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv9Bi9YDWEWG8a3K0lg3W22bNz19yko8c6AWLY2D9C4+52eXEOzcuYDxDEJ0PdRFxkfb6JP9PZu+Z8/mhoUH9jEG5FfKZG+ckhVqNmHUxYgaQpLM0MXIO7Y57v5lQ3S78YSxF8Q93IYu4rSaYz90V57d1+/txsGbEz5x9IBKRCghvMB680gBdhssjV4i4mnsSHvPj1Ern/w4zIlNyEU28+NTt1qZi5zBD3o9qChEFpWyWTksphQHizbvziLMDzB80eWoDSCqfOYqGI8orqHBRpKiQBCEGgA1fczd91k9M09CQa9qWUGSqYWx8b9HDeW2duQgOhB1u4Z8aiqVIjUm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5fSSrmXdhzQzkUzYAu5bU2KafSzVsO46aZ0eBfzNaU=;
 b=nlcf5X35t9/ig4JKn4atkvzFGTv63wohNCG4jqZzyrM47BRSUK61a9Vfyu2vwPkB5CqugoXkgj3nni1VMnrxDntW5qzhsqVWt2U8UWohyHc2K7n5o4ciHMlpmOKXQ6pHYsx22Jm27dILKkPKCngrCwTITHxoFhC56pHbKKZY/29JvS8fiz8sXus+XKb9XfFY21e9knJLR9TTt9Ez3uTM5JGoXUJhV/ONBU3KSEq4UY8uso5C+mBq8aO8eyFZaRX0Qtg0wiXqjKoVVxhSYB0hYGdmm00Z7QScM8K+PdCwIwLUhkD8p6WslQQWJs7HymEaiUzISs4mVTZ4jdmFcN1SjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5fSSrmXdhzQzkUzYAu5bU2KafSzVsO46aZ0eBfzNaU=;
 b=Y8VMgEawxyc9SxJRm6mrKLZziRim6G4FulvgeIHRlBtWgZxThATTSk5eJ0AZU0qppvDujYg+qPs5SsIlKnO1bVjZyYnkqnN8OPJovfq5vysMZLpDIIwvtoGqObOrpY+B3rZe5WJtUOXg9LkH1JfbfF8Hdim0bIw6+S7wbKeOP4U=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PA6PR02MB10709.eurprd02.prod.outlook.com (2603:10a6:102:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 17:52:38 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:52:38 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Yoann Congal <yoann.congal@smile.fr>
Subject: RE: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:
 sort repo branches in maintained stable branches
Thread-Topic: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:
 sort repo branches in maintained stable branches
Thread-Index: AQHciv362uq0WKBGdkGkiegOJk5/JbVc5mNw
Date: Wed, 21 Jan 2026 17:52:38 +0000
Message-ID: 
 <DB5PR02MB10213B6D7B2ED24E5B7C1BC72EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260121174651.64212-1-yoann.congal@smile.fr>
In-Reply-To: <20260121174651.64212-1-yoann.congal@smile.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PA6PR02MB10709:EE_
x-ms-office365-filtering-correlation-id: 791d928c-0618-4444-5d27-08de5915dde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?WtQbeQivCEnNcCazW+3Yo4nThKz+FYprqRYjlgngWqBcBamu7bmDH6OUapVQ?=
 =?us-ascii?Q?swZKGxLkSphg5V8IAbuIQmk1xm+sejBPACoSC70Omh4qbmlUMf643YmXE76t?=
 =?us-ascii?Q?mRzmzio3jUtkuQfLh689a5kw3N9mvIObylvhGpuR30BP4j5HAQAJEEliPwKh?=
 =?us-ascii?Q?DM0epu4RqP88EoAqdY4rRX7C+fZ6imozMg99s09A+kRpLBJTYp4Bx8ywUiCL?=
 =?us-ascii?Q?Tku5YMT/Bq6hROMYIYHjriswaT4/qB4bo5dRDnvDHDi8Gv18y+LQRChCwQTd?=
 =?us-ascii?Q?3FztU4Ox5mb36z+VCPAs3QzCpul4p5UNARow9/y1zO65xnnWivJhDe2CdS+g?=
 =?us-ascii?Q?Ovos4MfCiinVunYLGtDYJ0va1HZteSSgK/ZZ+DvjgpQti/5AXjAAGCy7mCBz?=
 =?us-ascii?Q?NLixacFbwghdRBQ9FHgAuxcUcWbWtnsSUs82eBMUJKsHEyDsMCj2GDC3bVuQ?=
 =?us-ascii?Q?htDwH4j8v/AosxURpVh/zQfP8XCO/+PKAcW7Ieh9WAGS4/I1net2t5CMNBx+?=
 =?us-ascii?Q?ntKhwkZzTYT/iLWdg1eTSlpW+ZMhm3bQgrjFpUJngkhOX7JEWqM6j8t1zn0w?=
 =?us-ascii?Q?xnOVQSiU+SpdaiqFreLQUtTrjhX5uiMWn10XvE/PFdBxTM4oEZXRp/aQtxlZ?=
 =?us-ascii?Q?ZSMKUAVN4TeOScpHufchP8qhRm5rIeG2/xGUvLdzYQ3Xna11DAwmsaipKcMi?=
 =?us-ascii?Q?5lreCpzKlGaW399d4olK2z23h6Tqx1jNRv+rEFVSHlUPwEaIosF+gJBa/wgb?=
 =?us-ascii?Q?UEGyBSDTa+/OSbiiq1VeP6NIU/8cgX63WtluUguB6Vl+UZw/nyNx5uoAQWvW?=
 =?us-ascii?Q?5ZwdmzH8HnPJNxeSBaGcVXR9EBxW/LJfzwkOpKyCJprHmDuXsO97On8pt9iZ?=
 =?us-ascii?Q?3ug7lPg6FDBv8nSgJTXMXjDuQM0LNFaF3Ftu1+gfCMlWizPCBrCjaK6BFWCN?=
 =?us-ascii?Q?POPpX1wle3/2YjcP/hHJYy9/9WsljSU4CN9HoOOdOaOiU1kVudFNnwzUS9eu?=
 =?us-ascii?Q?UHSRveDIXDqiigXC8AAGQSZNcyhaq2kbb0J5CbCaMGqcsoK0WzvtXvaLEdsT?=
 =?us-ascii?Q?ekI0b1lWb8fUhqhyRK+e799DLv2bj4Qnm6HaNo0jzBDsbX70KtsNRqbglWZD?=
 =?us-ascii?Q?bYdEGwSFPM69EDgl2gVnVkTItKKi8R5jvpVnRA3d/8wl7LpssktdcvJ6v5G3?=
 =?us-ascii?Q?hkMAB6/UeGE3y25cL6W8MLk0Ev+rRezNaJZd9PdEoc417co+F3aFRjsT2cbP?=
 =?us-ascii?Q?EiVnq1XZpGcsQwfc0r1BnLAO2vncvj2zCb2wqG6FBAbmkVVLjrhTWBRe2jVC?=
 =?us-ascii?Q?g2v0Yc6r0hZxlc4ACa7NgpSMx5+yD96fe7NezM4iS08Tg+oTcq4OJxcibfUm?=
 =?us-ascii?Q?rBtPube0D6pQ0k6BYspwvT/pCPhv5lPAGgZRL/51T5ztsSV6s7O97yDBDa1M?=
 =?us-ascii?Q?uOE6kSZV/XFaDg9R0DAn1Sd5CEGxYnZDt4z/waMwRa0cQ0UlilaFv3YfP0r4?=
 =?us-ascii?Q?TcatH8cz8ivIiXhw1a9dLAMs2M9+1BkqNK/PxUb9BYtXm+Pcx4DU0fRRPMTs?=
 =?us-ascii?Q?S7wWNVTJPl2XSE/hvjB9NPkWig3UaK0ffRSvPYNchk44EfY6dM7oSMPebPak?=
 =?us-ascii?Q?M7z1PkpykYUzuN8Cyqg54uQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iEBM/xDw1zru9h8E2C/zDbTdl56CQuIazFhULZoMZFDRNXIr8ywlmd81pWZV?=
 =?us-ascii?Q?8QXO4njE6BUoi0G8FSryp6hXq8cNGoNIwmc8EB0NyA/RmiuWmuFzP+kyJzKy?=
 =?us-ascii?Q?dEvazXB26VqqtdBdEIZMAtgVyc2AkAyIM51X9uxj4eTL2zISX7emZQi7VAfC?=
 =?us-ascii?Q?j5wclHxgd+op9RlTSq4vRspKGqPJ4nIoD6BFETqL6B9PhVf9za5pj9ZveRXT?=
 =?us-ascii?Q?s7CA2YBMriM5OuHtu4IgI0JUlAQkadGk1/QJ3n51pVE8TCD730O0ONpHug4R?=
 =?us-ascii?Q?kBkc5w5ijQXXpYEoPXvC+aOP3fTVCSmtnLviz1hN7Xpd67m9DkA9lrf8iCCd?=
 =?us-ascii?Q?YdWN7STIi2XG8TvO4Ni19Slv3qcNfGsd3O3eAjP4TghryiAFwKeDy5YfkZlL?=
 =?us-ascii?Q?WbjZaAY3JhB8OE9gr6mrQJa+q8xLTt6YBH5/8GblxpFoJqHeOdntao3xJCvk?=
 =?us-ascii?Q?3TJi2001j1leOF8VQLUygdXHBsWwKLm/kzs2Nrt5MpUiD22RQpLs5z4isD6h?=
 =?us-ascii?Q?z81Vi3DC2PGAWJ4v6rSVShwYnB0k6PMvz5c9UkoZUmammgebbgT2+q2dke+v?=
 =?us-ascii?Q?l2NNy0MSuFajC6HzI0+ej0rYl5sJ3fWr9yP67vm6vteFKCYUrUnVzmn5SxmG?=
 =?us-ascii?Q?OVNmL4tbdL91C5MYuuXJSNCprdr3tlJ2FzP5irTvlNsfipsK3iNbVCVcGR8S?=
 =?us-ascii?Q?dvScUnWWvbZjJ7GNUoKGeBBboTgxXk9EXx7c1IhWZpTP3Flc42/o1EtEqRmr?=
 =?us-ascii?Q?eWPtFMYbrDoPq3Y1KmRuoI6GqHJbwcX/U4VdNE7iN9hUND3VnFRaQlafAfD5?=
 =?us-ascii?Q?Tft+TgKao0iDmplfAsBDQtVFuHAZbK/uQN6xn7XMn7Xg3GtEjskv91mdxf6q?=
 =?us-ascii?Q?bFkyTu3q7htLBxcCJYnAs7qdZlgOScRuQYimc1LWBlQGY43UD9iCT5oC6CDz?=
 =?us-ascii?Q?aK8PLO4F36OZZKPuViU8X2FyDt5sRZp0qGdaeuTi1gUQuKgXptaBetOIhLYC?=
 =?us-ascii?Q?40INzyIWTbCLp0ycV4i9R8adW0CTaHLtul0QHPCtmK0rpCk7br+2NVENtAuC?=
 =?us-ascii?Q?1CFZqg30DJJ0KRk+agvJ0asIgWI1Wa8IVv/bIFaIiXSmGwdwP/8iw9eeMqTR?=
 =?us-ascii?Q?J/p1Qv4kkuOIdzlUGXClx7snMe+S+ni9bBv5/ghpVjbH7qcEvCanf/ijKJ2n?=
 =?us-ascii?Q?k+kkQsSHRS51tI0v99OMbyvmkoQkqamvazLX5DOZc+SOobBJLXB3A41xadHA?=
 =?us-ascii?Q?UN7QQVddM8LBcT6YH5O+lM/1ysgrMN1CC3Yg1Zu/cceGQ6YP3dJ5OnW5pgTl?=
 =?us-ascii?Q?kzdLz2Ds3hF3EnEC1Ft1njp3peJwbis/cXXLYXnvRoWHPR1b0vvMGj5DQS/r?=
 =?us-ascii?Q?cWjLpcNh6rjCRnYy3xPtB3TeE92/zFdWErp11GwBrW2nv4lroFeI2QDySF6h?=
 =?us-ascii?Q?W0QbYeNxMM6t2qEz+mCklYYmSVi3vffdno5P6S5lDUHyyefko8JuW9Nui/gT?=
 =?us-ascii?Q?L47ZNrcfrP0TpOl3VUGqV0UkSBf2PJum1QgQ4nT86ppfshrFyk5WKQGs5h67?=
 =?us-ascii?Q?aD34MzxIR/HGYLo1Xy4k2hDfFiAYgx1db3ovj2mky7zTWXMxL0lQpmcrAiuz?=
 =?us-ascii?Q?o1SZ1vlEWMc7Pi1q4qyXbyue6g5o3hWRgEXeBbYGk4th1AMPZt6cTFVpqoEW?=
 =?us-ascii?Q?IF9GJCBD0yA5BZlg/e98+EJhCq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791d928c-0618-4444-5d27-08de5915dde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 17:52:38.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjxcWdoaB3hc2H/BQTSyhr6MEZ7WAuuiYUUJvROe/UETwL81rbpo+bfBZGNBk5mT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10709
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:52:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3050

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org> On Behalf Of Yoann Congal via lists.yoctoproject.org
> Sent: den 21 januari 2026 18:47
> To: yocto-patches@lists.yoctoproject.org
> Cc: Yoann Congal <yoann.congal@smile.fr>
> Subject: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers: s=
ort repo branches in maintained stable branches
>=20
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> This should help seeing if any branch is missing by comparing with the
> "Build Properties" page of a build.
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  schedulers.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/schedulers.py b/schedulers.py
> index 42983a8..0018fcb 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -73,16 +73,16 @@ branchdefaults =3D {
>      },
>      'whinlatter': {
>          'branch': 'whinlatter',
> -        'branch_poky': 'master',
>          'branch_bitbake': '2.16',
>          'branch_meta-arm': 'whinlatter',
>          'branch_meta-gplv2': 'master',
>          'branch_meta-mingw': 'whinlatter',
>          'branch_meta-openembedded': 'whinlatter',
> +        'branch_meta-virtualization': 'whinlatter',
>          'branch_meta-yocto': 'whinlatter',
> -        'branch_yocto-docs': 'whinlatter',
>          'branch_oecore': 'whinlatter',
> -        'branch_meta-virtualization': 'whinlatter',
> +        'branch_poky': 'master',

I don't know how these are actually used, but is a branch for poky=20
really meaningful with Whinlatter? Though I notice that meta-gplv2=20
is also mentioned above, and it has been dead and buried for years...

> +        'branch_yocto-docs': 'whinlatter',
>      },
>      'walnascar': {
>          'branch': 'walnascar',
> @@ -120,22 +120,22 @@ branchdefaults =3D {
>      },
>      'scarthgap': {
>          'branch': 'scarthgap',
> -        'branch_poky': 'scarthgap',
>          'branch_bitbake': '2.8',
> -        'branch_meta-arm': 'scarthgap',
>          'branch_meta-agl': 'master',
> +        'branch_meta-arm': 'scarthgap',
>          'branch_meta-aws': 'scarthgap',
>          'branch_meta-clang': 'scarthgap',
>          'branch_meta-gplv2': 'master',
>          'branch_meta-intel': 'scarthgap',
>          'branch_meta-mingw': 'scarthgap',
>          'branch_meta-openembedded': 'scarthgap',
> +        'branch_meta-qt6': '6.8.1',
>          'branch_meta-security': 'scarthgap',
>          'branch_meta-ti': 'scarthgap',
>          'branch_meta-virtualization': 'scarthgap',
> -        'branch_oecore': 'scarthgap',
>          'branch_meta-webosose': 'scarthgap-webos',
> -        'branch_meta-qt6': '6.8.1',
> +        'branch_oecore': 'scarthgap',
> +        'branch_poky': 'scarthgap',
>      },
>      'nanbield': {
>          'branch': 'nanbield',
> @@ -185,22 +185,22 @@ branchdefaults =3D {
>      },
>      'kirkstone': {
>          'branch': 'kirkstone',
> -        'branch_poky': 'kirkstone',
>          'branch_bitbake': '2.0',
> -        'branch_meta-arm': 'kirkstone',
>          'branch_meta-agl': 'quillback',
> +        'branch_meta-arm': 'kirkstone',
>          'branch_meta-aws': 'kirkstone',
>          'branch_meta-clang': 'kirkstone',
>          'branch_meta-gplv2': 'kirkstone',
>          'branch_meta-intel': 'kirkstone',
>          'branch_meta-mingw': 'kirkstone',
>          'branch_meta-openembedded': 'kirkstone',
> +        'branch_meta-qt6': '6.8.1',
>          'branch_meta-security': 'kirkstone',
>          'branch_meta-ti': 'kirkstone',
>          'branch_meta-virtualization': 'kirkstone',
> -        'branch_oecore': 'kirkstone',
>          'branch_meta-webosose': 'kirkstone-webos',
> -        'branch_meta-qt6': '6.8.1',
> +        'branch_oecore': 'kirkstone',
> +        'branch_poky': 'kirkstone',
>      },
>      'honister': {
>          'branch': 'honister',
>=20

//Peter


