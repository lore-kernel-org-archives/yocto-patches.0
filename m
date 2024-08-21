Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A2BC52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 11:44:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.60])
 by mx.groups.io with SMTP id smtpd.web11.17828.1724240634368910334
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 04:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=j0YNgT2k;
 spf=pass (domain: cherry.de, ip: 40.107.22.60, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/IPXOMXsPvZVaKlGHZZ7nvKNAZxXgSLNunsFDMCr26tbvhFM+j+D/B1Sg3ZWm7ZgpVDQoi8Tdlu855MjuWByR1CmfOxZKFMDudYJ085bqYIBkmZbJiLMNszV8XWwe+kfADKNp7nJbANGGBAqlBe7t335TpEE+jlmn/uzjdhW1gM4iE8Gs5o6NNRk8sBs276qwi59PSR3Mn2mN0A1dEL1ZuDbm/EyjRCGp3zw3jCKnST3P1HEm02fJv6Z9J9azue9ihABmF56E8kkvnFKGunWehdrd2uhk8C1tOBepCsNwUOwccRl8FCbPgiCkVTysXNa4pqwAWqFw+Ef6rqwszEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+wT1ZKAsu+V6N4pWSxpVb0JcKmcGtn6SObNHTOd7+w=;
 b=xnFeFkAp1ebyrMvz3oc1Wi9XvI/39V+KYhz4POfHUCnW2Mb39oprawOb2JzZ+4UoeedfyWI0m8icrLPJ7RW8EupY71jmjAHeyGd6cp28d9PeZ8P5dgSTmjRIMdyDStkMk57psNGUAxa+lzS3UpuXuyxoOHSvAt/zMnlk06kXX5amDz79lFXMtjeHsj3nLOv0uhFE4YE3nQ1ukk933acdyDFCnhNCE/E9hPWNK8Do08wgfHkDYpHbX9nBsfaeIKO6jnpucTkZuwEawclsyDTUWcnCUZlyiZQig4br4GpxzBEYZSwjpKqzeSB3T5BxBW6ICNpHaAp5UhUrf6uG8samwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+wT1ZKAsu+V6N4pWSxpVb0JcKmcGtn6SObNHTOd7+w=;
 b=j0YNgT2kQLm4P8gjzEiEvbDWtCSSgJWbUnmrlkrytakDxP7Tu6JKQJ3rtBHB9/n2d1Spjwjsrl8Ii4EvtJoINkALMbT+H/zBCb5Ig/70bokaJyzpQanblHWYRLXGA0TJh2njUS4DjgFiLnd9m9AFf6d8MO2e9xXJMch0djHbtpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 11:43:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 11:43:49 +0000
Message-ID: <db327d20-3338-4829-a3bc-57d515797ff2@cherry.de>
Date: Wed, 21 Aug 2024 13:43:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing list
 address for patches + add git command
To: yocto-patches@lists.yoctoproject.org, joerg.sommer@navimatix.de
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 870c8ab6-7185-4de3-2c10-08dcc1d685d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yWATFWBx9YIv9Jtkl12oTEQu2m8uneEcZotw56BCjXPDeE8hs91lLIl9uF6q?=
 =?us-ascii?Q?e3BTv5kO/k/P5fVnb5OrRei+AOkKGF2YSUTuqI4Tw2UrwbbJe6RNHmPiTa5U?=
 =?us-ascii?Q?twJhGFbUd9/5ZecaGPODyQVi4ZTAjbounFub4eseBTzwJ3oFpSWXhe++qz66?=
 =?us-ascii?Q?xBcys23I+C20qPa15mO7bP5M13Dwin4t3GOsnmGkQL5qetsEuD+VwINqqHuR?=
 =?us-ascii?Q?l5age9CXa+QQxka+s6cxczBnofo7RV98FsIpgeH4LHV8BjdqB8Tk7GkTHAvF?=
 =?us-ascii?Q?XQ0QktLU6K1/QpiHxE228MeYbEyOccoBdRmRzXI7RXy11g6EXseYXFGTTKgm?=
 =?us-ascii?Q?HDzulI0miLVzZZkOoD1NFWtsfcUTQya4uqEiYp0CadHLNDwOlvCSrzHIbNTT?=
 =?us-ascii?Q?VfUS1Dq9OS7at8v6QgWuacvCrHXWj2YNiimrFlB4ZlfWzVIWndqwXf2zxmLx?=
 =?us-ascii?Q?WKKcFhOoMNVjM0f7L5bmoVfw8zdRne8iK++10AtpkNUIqbVMLgdyrPVgT35i?=
 =?us-ascii?Q?e00EpBCMNsH/JW901g9fcypY+RVZN+48NXe2PTxCLn6WmXKgkyZBb7aVATZF?=
 =?us-ascii?Q?j9k0Z0lD+PUS27ADv7kMoGnROSRlucwteN0hrTRhECNLWISBKuVuedBzaEO5?=
 =?us-ascii?Q?WVHO/a4nb2+1hoB71lQBj6juAYyUANHaQRNeoPQtHmRkyz7Dj4K/rz05lJHF?=
 =?us-ascii?Q?KgOXuOXyVO7yismnGEUvzTaB/i589GdGq1iYfFAlEmZ4c76qJevIv/BuRrCv?=
 =?us-ascii?Q?h7LK5FdmMCzC5I2NUlr39zFv45LnXQWUwjJNDnRr9b7Y5Me1bNkDZ9MkSrDT?=
 =?us-ascii?Q?DbsN6JaEn5wojjmGdj3p7P5keWctYWBzAjRVeWC+S3UUnmu+WpMjyiDDIYQ+?=
 =?us-ascii?Q?CSCoOK1OfT8dIxsf0J3tGLRtsO9z95kWU3QVqU4Y7/tFEgkpJ0dUB7x4qF26?=
 =?us-ascii?Q?oyxx46ecDqO5RpBhrhwNnm4sz6R1lkgn+XYXP3qKlBOJr7uT73x2p+QWWkYI?=
 =?us-ascii?Q?IF61FEDwI4rkCTVClO8on0w1RTCsGKvCQ9MfH65qWegBafzYeMmhQBJS2lHe?=
 =?us-ascii?Q?WtG7CDF28dBAjUjKgiybOtzgcpF1Jb0QbALBTvR3hqLNnm6hC/sA9rGjofcv?=
 =?us-ascii?Q?bD+BUfh3Xztfq0oBUdDnxO+r7lUbnWpkAzkjBZWUwD0xKFMJ5J3Oa7y3rGRV?=
 =?us-ascii?Q?psIKXiI9bXlyGOjpH0sdLF9mTtV6XqXJkvEl8iFcz0VvSuihkucY+365SVZf?=
 =?us-ascii?Q?sFEskOB2lP7YMky8Qs8K3cIhDCoHoWoyPv623W/PC6ioTZfXc7/pudT7kcLK?=
 =?us-ascii?Q?SAcek4e3DnL2xz1w0d/PdEKCfph/T+Zsa0hxUxrwN3pXrw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YIHHqLX+HdB3CRntlGJ9jiqUjvfUJdTnzWdt+2YFwBRNiFexW/VQbCWHAbIP?=
 =?us-ascii?Q?t8z4HUGmSAVf6WMmeMlLie0KIarUWrdyWeJX9XvfLPPnr4dMr94Sl6I/1Dt0?=
 =?us-ascii?Q?xaKW6kgp2VBfiy6wjOIZaw7+CjTa5sUB8q1Kvu0Gn3MLY5Ye10nf54hXgQqL?=
 =?us-ascii?Q?Gvf+cmCB4ohctAK3GDK9hukcc3su1riySRf1RCM1hTE3uVMTqbtDWqkeMGN6?=
 =?us-ascii?Q?RCvsZRtFEeo5pAu3Y+0j64RNC0UDj5y2D1cWnHRcDkQuN6p/5jGIP8nVN7Rs?=
 =?us-ascii?Q?s8TTUb8/zPAn/uCIPuVvbr0bEH/Ph7L4wJ8oljqUUfysnH7Dq6gl3o4XyV//?=
 =?us-ascii?Q?Y4Lu6OYxTrMQ7Mwt6X3bh8adoSse4p/Sg/oYNfWEkqUDwtSJ6kTEOo0VpZUU?=
 =?us-ascii?Q?hCFETsUChUxnqlz+ndzuMTEfPGRvqef10tN9Gi7EJrVBX0N6u3s9AcsuVjcC?=
 =?us-ascii?Q?2XFpoC9uyKe+70ESDaof2Unbzqgf/fM89/QPcOY++wh2Si/ZRI/wtIqIjxP3?=
 =?us-ascii?Q?IXi2V2mJ4V7rDdcGAZDC0Bo+Y0owikReofdePbRNpi3K3KnQb3Jx0iXIkAIg?=
 =?us-ascii?Q?95giRa3WevCRa+DtAnN3g3WpEkauHCmtNfS4j4ScsmJsmn2R9DggLAA2vJ+E?=
 =?us-ascii?Q?JC3uDx8mQw/Pnsu3u4hL0Kh7vjolYKywEFNsxeJqZw9TCyXdTusfv++xxK11?=
 =?us-ascii?Q?LmrijV2aDrawDZX1sfAHAwfN18KIJwDmXEISarqOYOJA74YQHgpUThOZKQto?=
 =?us-ascii?Q?QnQEDQBkVl3zDJKYfHB6loNhhMExF7nWQZUJfqsICEYU3rj1pz9w6OkHiXs+?=
 =?us-ascii?Q?yz+oAiBPWJRvuu1ZrZbb99h4P4cv7tCE+AJC4GmDYdybOvXQmqBHbthWJ5k6?=
 =?us-ascii?Q?vRcJYitgOYwMTFR8wqHQ10w2bChbTzC1eO/3ukC6merdfPihLKNZTyjKZKNy?=
 =?us-ascii?Q?ORpn8ixVFeiVV+fz21oebUpPNF24VUlUuc+OlOA7VK9jT7NFFN4gljOZYr1z?=
 =?us-ascii?Q?VmREU0EAZvguMUkpgwLQVB+dQpH3V83ITBDO+xsivalw5mY3L3AsCqSmdbmu?=
 =?us-ascii?Q?M43z6BqhMTAuvDQ6Sj+qOrgdHV0m5SuWoCJrRpmtGCqtRAAwRzCCKhosRD8F?=
 =?us-ascii?Q?fPFZJrFO/7IhClR/he/X4p7/sGdpr8P9buMzs5bXdxtF3ZABzxovVtK35EHf?=
 =?us-ascii?Q?ZG5MbUnC/d5BK23dYGtzi9+55HQjGTvjR4+jFN4DzWfIKFo7Ptl5Ew0zyDqr?=
 =?us-ascii?Q?3bKghD855pKR/dcrTEIY3Dk3OHugp7qZ8RuZn79QkvPZUHnkuUkXZ9v4IMYk?=
 =?us-ascii?Q?O3aYEXZyKksmnxYUgQGnGJKjnj8WnDmYsytUz58FV+5eoHXZYTWAC1bhENWd?=
 =?us-ascii?Q?9QUFWxXHP9cnB1uJsfRM3vjllndBiusHV16mG+k5SzX4PJrNZ33bsZy0OlE8?=
 =?us-ascii?Q?m8OKLzTg6pj/l+ruU39WNHMF0om9Vb36lJG5PzyJL7+oTPyIGW2zfQfJiw6L?=
 =?us-ascii?Q?YnHQqm+kBtI4Pje/N1x9Vzwj4Je/VNmO5lCO4KpnsyKWjv8kJ4CVcFwp5wJS?=
 =?us-ascii?Q?Ni8LMBoD/C9uCX/ihhLFEeB7hk4LvxlAxuxpsIG5QYnbR0FKToAIyGkvhxAu?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 870c8ab6-7185-4de3-2c10-08dcc1d685d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:43:49.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuWi/yZre9HnO+YplpUVgCfrXAkYn2ZVmmB1U6/KYVSVszFzVPnszb58le1NbYY6a6Y4x2ydoJKUgA+Xv1mR8j07eXLBkWgKx6FpzUSwVAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 11:44:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/541

Hi J=C3=B6rg,

On 8/21/24 1:35 PM, J=C3=B6rg Sommer via lists.yoctoproject.org wrote:
> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>=20
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

