Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAACCFA07
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 17:57:03 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2239.1762279017801858187
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 09:56:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=NrWUlPPx;
 spf=pass (domain: cherry.de, ip: 40.107.162.40, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ6R94PVW0mz/Q695IDpL/3Iq2usy8VZGrnlZ+0WglvP2nP/8MlsfpYgjWmMdNFm/170grvrvcqQLAnq3rEOGrYcdhWYD4PKxTV1Im2EbmKQVjxLmuNbABVxmREg2gQpom2Cf0T0sp4FwnAEXKvO7Y6Iw3KT0lRQc8wm3OFwmRZDyxNJoGBwM/h1U2BmMLpWqsnAtydVnXshxfPcK2jn8yW5ohRQbREDIdDFqfcbGk61KqJxL/n9fGW9CoS4/KYwJzZ6Ls76tQw3uXM1ficGclvkyk/DdZ6jDsy1tOvfaMjv08DCHqkihRrsAJOBA7MkKbpZYkdeCzv9mOU2gH6VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc/d0a0jNi/inrK/e4SjMrZj0EO3bBVoht/is9OdpRA=;
 b=GmMz+7gobot5Qy9NUUoHcVE5PkB657VT/ETavZU+bH3+7doVx4dcG6WsHrtgImAIasvApj8uw72R4WfJKaHVVpV7FinEuteAxgy+WQ58P9WKTjv8ZQcGZOQ8A5+PGqU9go7ZZLPZYpPUnb5w5OPsNgaSryrD5FLCi1Llb+9MGu/oEnnvZPZW9OjWJm8djP2ssyj0i1NN/WOozQQBFTuvO5OjCsiXV2gC6Xsnh20f9GY/DOubWreZnXSIsjWTSWuZKQy7gniuoNO9hhjCH3CeqC5+RP3KkKOY8s2srUI2xsT0/Q1LYTGFhubUsw3Hx6Hg5PjOeobnD1t0+qQZt1u9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc/d0a0jNi/inrK/e4SjMrZj0EO3bBVoht/is9OdpRA=;
 b=NrWUlPPxfpIEtRNLrMMJ1EEMAjkpqVrch56Vgzb+fikes25jjrmA24yIEmDGj5oX3+yhXw4B+B+d8fz1ey9DLzwxvfQrJj/v+Ad3CLvMabcJWx1eBCj3G65iyydpKX9TMkP8eGeT+Ld53S6iaZALOouFRQeJnYoNkQLqaZgmwho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11862.eurprd04.prod.outlook.com (2603:10a6:150:2f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:56:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:56:52 +0000
Message-ID: <34333957-05c1-4c8b-8e5a-1f319ca0c85d@cherry.de>
Date: Tue, 4 Nov 2025 18:56:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] fix sed invocation
To: yocto-patches@lists.yoctoproject.org
References: <20251104174516.31259-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251104174516.31259-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11862:EE_
X-MS-Office365-Filtering-Correlation-Id: 628903bf-5d03-4fb3-d9a0-08de1bcb88c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UHdIMFBjMmoxYnVsZjgvSXgyS0JxVEFyZ25oUkxTaDBkRDZRRGpRUWdIdlNW?=
 =?utf-8?B?dUlTR1hjbm5zaC9nRk5RZ2lhR0ZSNHhtbXhHaWdIUmZMaStKblRHT1BlYUJw?=
 =?utf-8?B?a0JTbkNMTUJDVWljWmJVZklwWWlyQ3p3WmhTSzUzS3FDRXM0ZmNwQklSMUdk?=
 =?utf-8?B?cjI4a1Q0NW9pY0dIRCtUdENkdXJNWmdTV3BENjRXRitRTVdubGRSbGJUUS8v?=
 =?utf-8?B?QW5uTlZnYU1Jb0pKUCtpREREQlFIMlkvNlJpbThYNW9RKzhtaS8rckJNZUN5?=
 =?utf-8?B?dW9BSURXS2hiWTdGVStJKys2MGtWM29UOFlGYTZuTnpKVm9HdHFCNEtmK1J6?=
 =?utf-8?B?c05BM1Q0UmNpVjh2Q0ZsdjJjUDd5M21KNzVIbkdoYnQxRTU2d0gxdlpLNnZ4?=
 =?utf-8?B?R1hkbWFXRXRSMDdSV0pwMk5rSmJJbTJiMlFTcWVhMlNYUGcwcER6aFRMODNj?=
 =?utf-8?B?RS9xWnd6RUNyeDdwNnlkN3B3VGFZczU2RklCZmtTVHZRd0poSmRHVDhnRjE1?=
 =?utf-8?B?Nzd6Yjl3LzZwNG5zbUtHMks2T0hqZFkwdkJhRzVRV3BWRE1nL2RnMVdXRGYw?=
 =?utf-8?B?WjgvZTQrdWpFeW55VmZscVpyRGlaSzhhUVZxcUJ5ZFAxN1FZYUZnTngyME9o?=
 =?utf-8?B?MVhmUHRXZUdQQmpmSTJvQnJibDlSaHkxWG94eHdpbDZtRnZnR3k0MHNBa2s2?=
 =?utf-8?B?bG1Ya1g0NlhiSEx2cWNIdG43dE4yRmZYelR1TDFhR1UyUjd6VU1KQnBKdm1t?=
 =?utf-8?B?NkwwTi9OU2dCL3FQMnJ3cSt0RDNmeG01Zy9YRXd1eVBqSnlSamE5RjRWSlFa?=
 =?utf-8?B?TjNkOEQzc1dFUnN4MmNVVkdxb1VhdEJSVzVRbmxqdEVXWkIyR0dnUnl5S3Zv?=
 =?utf-8?B?QzFFeHZaUjQwWUg4K0c4NXBERWhKZitiR25iTGJFekhlOVFvaXZiS2FZUnZO?=
 =?utf-8?B?Q3czY013UnFrSUp0YWpTNmszcXFnWTRsRTlpamtxVjFSRWZjQ0Rra1piMlVi?=
 =?utf-8?B?TENkekpHd0NXU3lRTlRXaVlVWGpHU3R1K0JWODBvTEhpbzFNTG51Ky9saWl0?=
 =?utf-8?B?RGE0WDZLRi9zRXVPdm1MR2ZXcDgrMkNzS1ZCdVNWV1hmL2dLSWNuQjE0MUJG?=
 =?utf-8?B?L0tpWE81WTlvbWlsVksrTndJWnZEaEU0eWZ5QkN3Z1VaNFd5bmViN2ZKZWdj?=
 =?utf-8?B?b0J4d0hodWVtaWJHOWZSSmIwSEMxQ1JuQm0xQ21DWW9wWUl0ZkIwdWsxUE1v?=
 =?utf-8?B?L0lZT1V3YkNLWjh0K2pJV2RkZGNLSEIvNWs0dlpnNVE5bUZDNFRXNmRWQkhK?=
 =?utf-8?B?elp4S1ZXa2FRWFBJNlJpSndFb25JT0JZKy9JSjc4dXE4YkNJVGpHQW9WbFZC?=
 =?utf-8?B?V1lCZ21HTEsxKzJxcXdBQWpJNkU4MnJlUXhNR1lWK2g3dnFkME56cUZ5M3NE?=
 =?utf-8?B?OGhkTGhZY2lZZFN4NGJHUkR1OThCMEwrYk14TVFjRkhIR3hQd2lBMG90VGpT?=
 =?utf-8?B?U3lkQzg0RDc5SldMSVN6eEhER3RqM3l0MFcyMkIwRHRYdS91eGtIVUxFK2hE?=
 =?utf-8?B?WFh4N1FTeUJYWXA2OUF6b0tUZmlnTlpFZHM5blRQc2pzMGxtZm1ldmo4Z1N2?=
 =?utf-8?B?VW85OG9GQnJZZTE1S2hHbUFCLzB4RjhnOHU0dlZ6NDBSUG5saTV6V0YwMlVs?=
 =?utf-8?B?eC9EaE5zMDBvNHpzbjZxUFJEb0JJSzJTL3E5SzhZWWNhSTNiVWNQUDQrL2RO?=
 =?utf-8?B?T1dLRFN2ZTd1Wk1rd2o2RHN6ZncxOXVYakhmcnNUbzVQb0FvOFlvUjBVcjJt?=
 =?utf-8?B?YTNhOE1iM1VyUWFFT1BDZktyd3BmYmR0cGlRN0Z2Z3hhTk5EL2laNmNhNklk?=
 =?utf-8?B?NGdiMmZ5UDZnelhpV0pLMFNOK3Bzbm9FZ0tydjhDdzBEdFFROUQ0cTE2aWhZ?=
 =?utf-8?Q?VBgBy2W6VhsY5DG01w0My+3d8gi+dAgU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0V1dE9BTkQ0aXhKdzNJY3NmeFdaQXg4WHZCVjM0YnlRQU5IZUZBRFdIWTll?=
 =?utf-8?B?SUoweVQwbkgvcHVWYmNYZXlMYjVYUW01VXgySEM4ZEsvZ3BuOWNUMFNuUWl0?=
 =?utf-8?B?Tzl1RldYeVdOWHZQcUgzK0twOHVXOUtLSTlyT1Bmb3MwT3NOTE8wREw5Snc1?=
 =?utf-8?B?WklKZWRER2FQRWtnWWtSNDlyR2cxUllRdzBZNlpIN0NqSXBvbXZ0TVl5S2N2?=
 =?utf-8?B?TWVUcUo4MmhRbVdUTTAyV1R2WTMxSHBOWVNpMXRrd0RPSTc0Z1FLL01ydEdH?=
 =?utf-8?B?MERRWWhJbTNCeld5T3NyOFk5Z3QvOEUwQ2NNRUJBSU1FYzNld05xblNYeVJW?=
 =?utf-8?B?dmExNUxGcGpkanI0TGxGM3p4TEgweDJoNFh0TGlhdmI3Q3BKa2hVTU9KNkZ4?=
 =?utf-8?B?UjdnaGduaGV2VEptOTNCNW42WElwSGtrRjY1WTM3Mkc5ZUVuc01RcjUyZmp1?=
 =?utf-8?B?RG0rUEV6eGJWMEkxbEFISDU0WjNYenRla205S25BZkgrYkgxdDFHSUZZVlZM?=
 =?utf-8?B?SnlCQTN2d25qK2NUY0dnSkZlb1lrS3FZa1lRTXFIZ0IxdDZHWS9zTVhtOWkw?=
 =?utf-8?B?MWlEdUNHOWNjcDVSOCtlTzN1VlFCdVVIamNuSlIzbEdaU0EyL2cya050WS9y?=
 =?utf-8?B?VW80OEdaU2FBWWgvV05rUEFwc0szMW94VEFadjhQVjJGbi8vYkhFZkVMUFQ3?=
 =?utf-8?B?cU14bWRmRHZ2ZXJsSmVXNjFtRFYrN1dxNWc3ZEF6cUFCZ0ZJNDIxQnFjcGlF?=
 =?utf-8?B?YWNHTjIxWUgzdkxoQnR0MU9oVXFCdkI0SzRXTUtZWjhybVNWS3VPSzMwWUFU?=
 =?utf-8?B?NEwydzV2Q1BtRDdVV3hOSFN5TFpjcVkvTWgrOGcrMngwaG1RWlJxNFlJcFJI?=
 =?utf-8?B?WlN6WTBaY05hVVp4NWlaRU9jSzVMc1NJSVZ2NjkzcVFwY2x3MWxaTVcwTVNh?=
 =?utf-8?B?d1gxRW83RGZFQitDa1cvYjhjS2tNaXRkenVFRFQvWTJSdVlqd2V6dUZURmI5?=
 =?utf-8?B?YlYrZWxHeW1CamZiV0d6TkE0V1A0K01aUHZuNGdWcVdLSmFIcDdDQk9vWmpz?=
 =?utf-8?B?YjN6K0Z0RE1FV1ZjT0dVLzJsT3dFcFBtNzY1c3RMeTl4TW4xK0tmNHlMZFVI?=
 =?utf-8?B?NnYxeE5DOUcwTjkzODM0RmtrbmRsdDRFNVRFN01jSE00bTFJWXN3NzBBK21C?=
 =?utf-8?B?RHgwdFRqUk1jQllqK1pwM0pIUjltaFBVOVZUSitQMUFHOXdLUXdyQkFYck4y?=
 =?utf-8?B?YVQ3dU1IdVZFQld1ejFkdzM4a253d1pIbTNSczNPa0RZSzA0TnZ3UlFsMnBz?=
 =?utf-8?B?bFk1U2lzK1Y3TzVZbjdacmRDQlNURVBVZFE2dE1qMVNjdDdTTFllcmRaVHBP?=
 =?utf-8?B?OEovM2RNVy9Ndlk3T01iMjB5ZHgxZGVYL2Y5UFlqOG1VNWJVd1ZMazhyNEJ4?=
 =?utf-8?B?ODJSSG1PMkFWRHMvM2s2MSsxRUlsbHRIbTUwNUFnbysvL0xqeEVWTWFtUVp5?=
 =?utf-8?B?S2JDMFFMWldFTVpJMXloSVU2ZGFzNHNxL2J1Z1l6a3F4ZGlhSmpwU3BVdjZl?=
 =?utf-8?B?MFdZa1RNS2M3NE1CbkNMSFdzRk1JRHI3SjlTRHRPMUhpMTFmZ3JLK0NOMDJr?=
 =?utf-8?B?bFp2RWw4VC9BamNLQXA2RXJaSzVMSUdSeEVJaXdncFB4NWl0KzVOTG0xR1RW?=
 =?utf-8?B?Syt6Z1l1YlIwdUhyRHd0UnNLRFp0dzdTZG1OK3YyaklBRW9TaU1HalhJQjBX?=
 =?utf-8?B?QVF1eERVWk9aOWZsSXpHeTc3dlR4N3hPQmNScHEwS0lLNEdXM0J5VDE2T3Rl?=
 =?utf-8?B?UzJaWXVJUHhNNVJHZ0x5SlRSTElwTllHRUdGK3cxL3YzeTMwTnpZQ0FDdXls?=
 =?utf-8?B?ZFZHUXNLcUMwQmlONkR6MG4rUVlja3QvUjFSbTRPRU5zeVdFNkxWZ0VBN1Rn?=
 =?utf-8?B?QzNQN3hJMks4eEdmRTNVdGxkbXpPejZkVUgrZ3AzRmlHemYrcVJlWmU2a2cv?=
 =?utf-8?B?K3NxOUlORGxRTmhOejVOckZ4NTBoZ3ZWR2R4eTVkbE40NjVaVndJVVVJQTVj?=
 =?utf-8?B?TWFoTkVDdmpzNnBXbEZJQytKTUtvQm0wU0pScHo2Mm9sMFlQbUlZWTc3M2Uy?=
 =?utf-8?Q?8hYv1P9UpMZUJrMWWU7L0x462?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 628903bf-5d03-4fb3-d9a0-08de1bcb88c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:56:52.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVtoxgq4oTVn+YuIEUTfluSsJ9sVeSzKW7UT035L2hy65t7Qpq9nRydB/X50OyBAYEQ8Xu4aS0YCa3dUQfWVTm20zZLAR+fv2f+CQYb2PDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11862
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 17:57:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2419

Hi Trevor,

On 11/4/25 6:45 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> "sed -ie" is different than "sed -i -e". Although both run the script on

Nice catch!

> the intended file in-place, the first one creates a backup. These two
> were accidentally merged into one option which can sometimes work, but
> not in this case.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

