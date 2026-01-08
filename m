Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF83D1D475
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:18:02 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8701.1767885473420378742
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Jan 2026 07:17:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=gCim2haH;
 spf=pass (domain: cherry.de, ip: 52.101.65.18, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6fbloQwVHT4XTn05V81Ac1l3yu34foBLOrppep40Nml5RPPnuLok/i9gU0NplVXujR6JYrRiUqDOdzz/kg3hJMw66nJbq33+QEagIkShlCqOUc7OFkL2syGVG2MHpMxLYNXgFZ9D6UTIa+yhExxd6uGEHo6ulhaNMrogvGiw0jNk6mTQnGY8UHlX/aQYzqxvTXVTG85VtLE9PTU1mZ+nswyt7cg4MFvexYuccdBZfT6omjnntMa8pmzjTnMrqQZ90bMWLT5t8c6XYkZcHg6jEtrH3XkUiTW6K2xXN2M4vkIo6EHGDJ2d+1XQndnLYkOZ/mQYJK4l0lXgSZ5XlVVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKazXbzZxJ/GRjjnE3jsNhwYAMQM7jZ5utl91kYe0to=;
 b=djmWf6IrjhmjXOGJ1yHf9fYZy3PUZCNVtP+ojQ7l1E1C8ld3zoe6tLOCM5w2slS8CHT9RoSjykRRntA9g4ckx2l7RW5iPjrWBn1fjw4pNGrwAeBcbQJjnaOIte6bnmmZsvs5iZpYo9f0MWlOFa+58ZLupb1o2xtScoenr0d/3vJTPHhLMXGQkoQ7Gl7Rc/l8qveO2m+/8p6dZU8WXUEsSVzOf9XlEgYOqtBfey2MngfqMTAu6Ya7LlphHg6BqUz4OQDh5LZE6rkT4NwM3LClfC7vOkO7PazfekS564yq8/+h1QB8Asvc2z4YBqNQH7jAcMEj6Gp82m+nutudgahGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKazXbzZxJ/GRjjnE3jsNhwYAMQM7jZ5utl91kYe0to=;
 b=gCim2haHeBF+Pyt89HzhpxzPx5qKG+kI0aERwgfbVg+FLsKiNPdYj3lgvMhvoR9eo97IPTQegwe7aVQPpkIvJOTn2odsuYGqyHreBrLKtKcMKZBO+hq5lqagertnlSl583AFjyxJ4Fyejx53pzPJ0+efBegpFrNfHcFEUqnyA8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB12019.eurprd04.prod.outlook.com (2603:10a6:150:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 15:17:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 15:17:48 +0000
Message-ID: <11b46c75-8fe7-41af-928e-a9fdb1012321@cherry.de>
Date: Thu, 8 Jan 2026 16:17:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 3/3]
 scripts/release-parser.py: define globals for stable/active versions
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
 <20251219-releases-parser-updates-v1-3-6830e6a67db0@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251219-releases-parser-updates-v1-3-6830e6a67db0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB12019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4345fd17-88b1-46ab-0914-08de4ec91506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTNkRm9MMm90ZWtMUDlvUlZXWnpJaitmQUxJSTZsTjczVWtRYiszVFI0UUdr?=
 =?utf-8?B?a2tkYjMwb25BeTREOXZJOHZUdVpwNFFrS1JNL2t0N2V6RWZBeUZoQlhid0xu?=
 =?utf-8?B?VUY0NmZrb1EzYmNMNnlMbTYxblBPUWlnRSsxQ1FHcHlrWmtaS3o0S2txZGxK?=
 =?utf-8?B?eE1rZmJndmtsWUh5SDl1WjYvayt4UUJxN0FHNDlrYTkxQm1oYjB3eXlJRkVn?=
 =?utf-8?B?QWFXSGlJZ2ZHUjRkVDYyRkFXS3VYWkZka2pVQlRWQlJ3cVBTQytNWGNtSmc5?=
 =?utf-8?B?WUFUUG1BMkZKeVI3Qkd3ampoL2ZIMGw3UFo0cGhXdXJuWEpBeUhCTFByZkIw?=
 =?utf-8?B?OXQzVG9ORmVJYkZWMW1Lb3U5Ujh5M0hiY0VXUUIyTGM2eEhaRnFUczErNUcv?=
 =?utf-8?B?c2h4aDBrdlJVd1doU2VzT3NkY3AyNjdscFF0NzBJc2dRYnZvYTN5QVJLMVRy?=
 =?utf-8?B?TklIc212TjE2VCs5TkFUQWViSjZHTE5ndU45QWpkaEhXdC91dVRmSlEwdGU5?=
 =?utf-8?B?R2dxelZYZ3poQ0toT1BDbTlCWTRtQ2pOVlZRYzBWbklGQ0JTNUhmZkRrM2p2?=
 =?utf-8?B?QzdwcitVWEYxZzEzSzZqVDVwUG5mbXZadXErbkMxd0FSZ2lqdFZ5aEhkK0RT?=
 =?utf-8?B?b3NVbWVqZ0d4aExITEF3NnNDdFEvdGlWam5rbFJQbFJZMnh2V1FadG15OFlP?=
 =?utf-8?B?Vy93SGVoeWJwTC9QK3VWUGdueXllQ053V2d3MVRJaktlUks5bDRxWVcyZ2Qr?=
 =?utf-8?B?dUJoY29pa0ZTMmJVWmJHU0xiVVZ3S0g3MFJuVzJ0eDlMYUVhd010WUp0SDdU?=
 =?utf-8?B?TkVGWXBTOTZaMkhaT2VVSFduYllISENKVWxrc1U2QlU4ZkhXRzRpZEhseExh?=
 =?utf-8?B?ckVoWmRlTkxpNWVBL0Fkd3J1OGhqUitYS2ovZkNhV1MxeUZWZVNHUU8wVWVC?=
 =?utf-8?B?TTNhbTh3MFF3dnNqbXh0LzRKVldmcmN2UHFHQTB4K0dhVXFFa3YycEZpMGRl?=
 =?utf-8?B?a2dQUWM3UGhkWDRWa3hmaXZGamdDcjY0WnU1NnhoVkpQd3lwTXoyL1ZiOEwz?=
 =?utf-8?B?MWd1cTEvaXEybXhaalFwTFVkQkx0R0JZaVlXSVZzcGhyZW5LbnpmQXQ3UDBt?=
 =?utf-8?B?T3hUdEJaVVBIRE5rUFV1MDgzQVJncEpuejV0TGFSd1lIeGpHRWpuSG4zRk1M?=
 =?utf-8?B?bW9aNFJkckJTb0lNZEVFZ3gxVWIyK0d3MlRvWkZpQ0JFdTZ0dWg3TXRlZnNx?=
 =?utf-8?B?bFVnNUdJcmQvVUx5T2VmNUdmb2pjZHl3ZU8yeVJDZytXc3BIMVJIMDVEaDhY?=
 =?utf-8?B?UDRVZHFPY0VWK2h3NjB1NE43UktqV2pNRjZIODVVOC9HcGdMZTgvVWIxRVQr?=
 =?utf-8?B?NFFzSEVOUDQvcVZOZzZsZC9aQlNsUWo5bDlKdlRjUGtYZ1gvMjR4YjZlbjdh?=
 =?utf-8?B?cWRvMnVEVFFZRGRJV3l0YlJ5VFBUa0FoQ1BDRUE4TmlGVzlZL3ExR2xtQnJW?=
 =?utf-8?B?bnFUcUtFUEUxSzdtUHJQbVI2UGVyVm1FamROa1RXeHVYZy81TFlqWmdob2k1?=
 =?utf-8?B?NFZtZ0JPWjZEdlY2Tis4SGdEZHF2SWZ1SHB3ZjhmVnlnYjlOM0tReVFDWlZs?=
 =?utf-8?B?YmhRQWhLWVlmVU9GL2xCajJqcTRURGxxS2QrancwNVc0c1hNQ3EvNklKSTdw?=
 =?utf-8?B?bi9iMlk5cFpXOGFOdEpWbVVrQmF2ZzJ1SUZGcWhWMVBUeEVKTWFOcVFOckpG?=
 =?utf-8?B?bFdFb0hJZERmM2pCazR4TXVQZzBFeGZDK3cyKzRsY2xkZDNKZWY1UFp3WTV3?=
 =?utf-8?B?TzFJQUN6a3FJNXQ2bWhpY0RXWEorL2duYTA0aStNR2JKL3BXVUNnNnMxZXhC?=
 =?utf-8?B?Vkt1VHo2QkxXSndNaFVjRjY4aEpuNklvM2RZbExtZ1lKTkduUmJ1OHY4aWFX?=
 =?utf-8?Q?4yLJstwGQP4QiDW06Xhb7iJfZt5HSHas?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?andnNmRIUHNEWmdlNUFkdlJOejdpb3NqRVpTblVZaldhTWtodUMzelZxVXdZ?=
 =?utf-8?B?RVc3S3MxbnBqWnlGekdkUjBvdk05c25kZWVJMUlUdEFldUxaZGV0akE3UXNG?=
 =?utf-8?B?L0pvU0ZmU3hVNHJaNHg3SHdpMUNYdlNrN2hEQ1JqcU5nTytDbUo0ZUZFQS9U?=
 =?utf-8?B?VVIrZ2VtOUkrc2w5bFp1Q2hhcFdXQVF4dzNkSWs1eCtiWWZkV2xJME1mdkhn?=
 =?utf-8?B?b2VVR1lkMTZsS0VGZ3ptQm45ZnEzNWhQSEkzeWwxQitPdEZDR1o5ZVJOT2NV?=
 =?utf-8?B?bGNEcGRlVjU1U0dBYU5JZDR3OFdURU43SENiN3c3RjhmdDQ5NmNaellxUVZk?=
 =?utf-8?B?aUxOTzNsSjJIUlFzZ0JmblFyQUpxaXJVakZmdFZGNkpiSnRsMWhuVCtIcVFW?=
 =?utf-8?B?TUhOcmU0a1J5SjRsYmxBVkdOTU42S2VDeDgvVnF3d0ZtbmwyejE1ZWdMcXNT?=
 =?utf-8?B?aFNHbWtrVC9qR3hQWlRtS0lRZURYNE92T3I2TzJpMHRYVGp2TkZFOHBGSlN1?=
 =?utf-8?B?blh6MjVnM2xGaWg2UlBEM0tUZ1ZCTUY3V2Evd3ZEbldFRnA2RkE0OFhjbmlL?=
 =?utf-8?B?d3Z0SWpYZ2dBZk9iYk1oRFRqRXVkN3QzKytJV0I1WE96RnJLcURXRGVGVFdI?=
 =?utf-8?B?d1VydEdUa3NmYXhQWFlrRjhEOTRZbkdRMlhmemkvOEl1Q05wWlFycGVEd0V2?=
 =?utf-8?B?MmxEYm1yVjJqSE1reHNIWE9zY2Zldy9xQ0YrMHNNNWFlVDdoSklhUnFOTXo5?=
 =?utf-8?B?Q0YvenR5MEQwN2YyeXEyQkw4OExSZndsTlVtcW5HSjFQZTBkdHJaSVZkOHlU?=
 =?utf-8?B?RThqWXFEVTNZMVE4Q2R2TW9pcDRvb1ZqZ1cxYnRHZFFHNWRTRWIzc05Fd28x?=
 =?utf-8?B?M1R1Q05sSFFpUW9XdTY2cjFxOWhRc3ZKT215V0dKaGRhakRscWVpZFJnMkY5?=
 =?utf-8?B?SktSWjlFL3FsVFgxcS9QT09kWFVKQTBkN2NldEhuSEJzZ2tpL0RUdk1zSW5Q?=
 =?utf-8?B?K1FaZXVqTnkxZE1uN2JmdkVsSUkwcTBISU5tRnY4aEg5WUZLdzlpemNqT1kv?=
 =?utf-8?B?ZnpQRkhzRzdOOWJTbnEwbUdMcXRBYk9OMkpJTU9zVkZZRU9xK1hJelE3bVo5?=
 =?utf-8?B?R3hSMlBFaElWSGdoa3hFV0NNQjV3OElJamFxKzMxK2J6elhuT1hJN1g1and2?=
 =?utf-8?B?S2NKMkNVMHpzS0ljUWNsT0VwdXVOYzVRb2p4RzFoRllFbHgrYnFOd0ttMUF0?=
 =?utf-8?B?bjMwdDU5MG9YRlQ1dWU4MTRlaGwxR01kZzhzdTcvSnRPeU1oNmMxK2M1U3F3?=
 =?utf-8?B?TENSK1BuNHJKUkZwZDdsNS8zOEkyNlJ4WmZRd1VoZG9WMVp6UVNVakZBcHdH?=
 =?utf-8?B?WVJLT3RDS3RRRElkdG9uSlRuRGtKOXZqM1NoWG1KVkZ0UUpCWGVZVldKRVE4?=
 =?utf-8?B?S0QreEIxNi9yTlNUYzhFbFFDaFhZV3pqQmt0SFBtVUxCZnV0OW1zSW4xSVFW?=
 =?utf-8?B?YzgzMGQyenBtcEQ5Zzh3STlISDZDTGxqLzFhbXJuakEybHNhV2hOekUrbjMr?=
 =?utf-8?B?amFxaGpkenQwUHo4bXRFdHAvYUFaNE1LVTRyNUp1cmhiK0VoZTFyOG50dEdV?=
 =?utf-8?B?RzNjMW9pNFlpSE5CMzV4U0hsWHRXMy84T2w0NFdZR1JXMTJqSVlJaXZYRks3?=
 =?utf-8?B?eVl1N0pOTVNFRnh1ZzlIM09oQXpBd0dnMnFjbXFoZkJsZEtoRSszd043NHhG?=
 =?utf-8?B?YzY1NUQyYlpKc25WeXM4L202WE5KWVZtNkRVdy9xOTZIL0NGandlRDdpUmU0?=
 =?utf-8?B?U3dwTlVkOHlkT3k1SVJEaFQyTGxidXVMaExORlFXUXZLaVd2YW8zUkh6THQv?=
 =?utf-8?B?UWc5TkhBTEUxU1loNTNqMjhiRitQQTJyT2NRemlnYUVWMWplbkNpM3F3SXAr?=
 =?utf-8?B?MWhMcG5BYk1PdzBvanpha2dqN0JBTC95T3pRUVhBS1BjQ012QW5xWFV0NHgr?=
 =?utf-8?B?ZGVMU1FRc1FJdlVpY3lVZzA4ZGdUbzlMQ1QyTkMwOTRDdlY1Z1ZicGphb3BN?=
 =?utf-8?B?ZUdjdVFVODRkdDN6VGNIMkQ3RjgySldPU0ZKL3M0VS9EVnVmRXRyQ1pURk0v?=
 =?utf-8?B?MlZvU29CMk04TkE5V0xXcHNMR0kzcW1GZjVJODFUTitmNlF3d2Zxb29mbmpS?=
 =?utf-8?B?UVQzelVSTy9JM283cFJQTkVtRXZqcWFYVW1vUVlsSmYyT2c3eUpwRkl6OVN6?=
 =?utf-8?B?N3RKMHFibkdlYzVwekF3RkVMRWxwZTN1aVlvMlA1eEcxTnFzSlpxOU9uanpP?=
 =?utf-8?B?b3BvSTdiZ0xEdXZOaXlHR3R3OHEwN1pQOU5EVkJIb1NOTmtyMkdVdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345fd17-88b1-46ab-0914-08de4ec91506
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:17:48.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVRXeVoiq8iB8uu0TneZm/SU4Pd3JnKj0ia99rrVXcUS2V1IKPIpn5Jchv9W/0kQqk9mL1jHL93dodUGtiDWBgl9T0rv3kwpAKaO0YG5uC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12019
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 15:18:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2915

Hi Antonin,

On 12/19/25 11:35 AM, Antonin Godard via lists.yoctoproject.org wrote:
> To avoid forgetting a spot where the we need to update this information,
> define it at the top of the file and use it in the code below.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   scripts/release-parser.py | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/release-parser.py b/scripts/release-parser.py
> index 61ff935..5993b30 100755
> --- a/scripts/release-parser.py
> +++ b/scripts/release-parser.py
> @@ -10,6 +10,9 @@ from collections import defaultdict
>   import datetime
>   import semver
>   
> +CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
> +CURRENT_ACTIVE_DEV_VERSION = "6.0"
> +CURRENT_STABLE_BRANCH = "5.3"
>   GIT_REPO = "~/git/mirror/yocto-docs"
>   
>   repo = Repo(GIT_REPO)
> @@ -83,7 +86,7 @@ def get_git_tags():
>               status = "LTS until Apr. 2026"
>           if branch == "yocto-5.0":
>               status = "LTS until Apr. 2028"
> -        if branch == "yocto-5.3":
> +        if branch == f"yocto-{CURRENT_STABLE_BRANCH}":
>               status = "Stable Release until April 2026"

Factor out April 2026 as well so it isn't forgotten?

Also, what's going to happen once we have Wrynose out? It's an LTS (it 
IS technically a stable release, but I'm assuming we don't want to be 
saying that?).

How about something like:

"""
# Dict with key=<yocto-branch>, value="LTS until <date>" or 
value="Stable Release until <date>"
SUPPORTED_RELEASES = {
     "yocto-4.0": "LTS until Apr. 2026",
     "yocto-5.0": "LTS until Apr. 2028",
     "yocto-5.3": "Stable Release until Apr. 2026",
}

[...]

status = SUPPORTED_RELEASES.get(branch, "EOL")
"""

Cheers,
Quentin

