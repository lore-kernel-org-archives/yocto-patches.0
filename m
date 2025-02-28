Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEBCC19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:46:19 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.86])
 by mx.groups.io with SMTP id smtpd.web11.15503.1740750370948479279
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Feb 2025 05:46:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=LSwEmufK;
 spf=pass (domain: cherry.de, ip: 40.107.104.86, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR27I19MRtRFfBFpXHPjsl9sRHk0fuPPb+MAASaWMAZfiLAk7590bahZWwK1hVRZy7/n8gxbxQLzEAmVlUjN1960ahBGyZHMazYyWlk7GhMGjsRaHqSj7/m7iOF0sdyV5Tcs3YZru6MWtm3/fD3omBilUtoBJKdkqEj+7CtWo0lEpYONXCMkThFEXGkLWUrYiNC3OAXIRi+MTkuf6D7njPvHmczLZRGA0/gTDQV8FrPbEwkYWDJh1tGrf6DxofUrS9QHkEmSFFyEPd3NyRZ4CaaPd8dN3MeYsYCZ8jhzYzS0pQ2J6dGLm/OxSIG/TavjsJ17EGOFiCAAYL3kZrPYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzlMwDL7iCZrOYDheCghRgNWSjkaZp6ru3R1OVqsYE8=;
 b=VhVwSZBvG5RKhJJOSJZ4A1/Typy4RcZdj8zew9uxGYb2aNTORvPp5+EcX8z2ywo/2Bwulryz0pqrRLcU3u2xc6UlBgrJvxX2epIjd0H9+ZRznETd/hKpo3OwcoDnqC3/VACi6aM1jxJWXdx6qmO9u3jV7jUDqYexWusqe1E13mY5IWH8Uo0PcKYcGsYsAFpJeqkw6ACKRFwg2kPFI6ThLthjrgmA3GiiOP6Rrh050P8v0hs/M43vySs0xLdYxDSb1U1Scf/bCuiv4JfuJJi+IGOm8SNZEJjwgWMJRtqajPIxXZ3VXBsHHmJPqYqSSGrEsDnT9fNbDdFLMIDFTj/lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzlMwDL7iCZrOYDheCghRgNWSjkaZp6ru3R1OVqsYE8=;
 b=LSwEmufKOn7XGhWtExvm13zP3WqerdGoW7MLvXG+CZEcxSFWOC16XYEJXrCHyh8zbUxfIMHiU7wsczclz6u1LJs5HWyVoy/q8t4sfm1Y831hUIg9KUPTxA3IXExOfXmabcpsdckygPNO9zX7dZGq1hWB41EvrFGFd0NCT9scl5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9721.eurprd04.prod.outlook.com (2603:10a6:10:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 13:46:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 13:46:07 +0000
Message-ID: <692d280d-b656-466c-b3dc-a2b6c50f2bea@cherry.de>
Date: Fri, 28 Feb 2025 14:46:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] rauc-conf: set arch to
 machine
To: yocto-patches@lists.yoctoproject.org
References: <20250227145529.8651-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250227145529.8651-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 71552d28-2084-4d31-fbb1-08dd57fe4081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Uk9mWkNVemdjVGQ2WW1LV3E0Wlk1ZCtIcktjQ3pjOURuVERIRmhBT29oWFNo?=
 =?utf-8?B?Ri9nWnJlUTN2Smc4RTlkVlJISEgvTUgreGp2SnhtSlQ2WkpzTUdrMzRmRmVa?=
 =?utf-8?B?ck8rbWwxdkVVMUZES0NYZWQyeWpta09SZmRBSXJFS3UwTWVubkpqZExnUk96?=
 =?utf-8?B?bklzV00wOTNoWk9OaUFkdnhZOXNyQVl2WmVBYitodVo1MHVBTXYxcHN3Z1NM?=
 =?utf-8?B?YkVZMWQ1L3R0RGlkZEFnb1Nac0hKRzFQR1lPUFJ6dGQrQlk1ZW1zYStxUkpY?=
 =?utf-8?B?d2JIbXRSNkNMZXNqNmQzV0crMlRteDVSK1VJa3lTMHBHVm1TQkhmM1MwcVgr?=
 =?utf-8?B?Y3RYN0x2bXVkREJZSFpzRHNBaUc5QjNxdFFnRWJLRWhZOURRR3RpQVpEWllo?=
 =?utf-8?B?UnNGMVFoZnYwWHF2dEQzelNPWGI2MmEyaHJYZC9XejNsMGpHVk8wSXlHRFNI?=
 =?utf-8?B?MHpEbCt3c1ViaUJvQm9Qb2ljVFdQN3ZTcStySEp4MXVTU2NndEhTc1V5M2da?=
 =?utf-8?B?WGhxYXNFZTJkdXJNdTdIdnFrWHVua3l4YlBJZ1R1RE9jU1dDbnN5MDQrT3pN?=
 =?utf-8?B?U2lPNnRrTUJ5OXQvYVJOcEcwbmMzcTJMOXgwRGNRVjV4ZWRRenZaamdudlhC?=
 =?utf-8?B?UTNPRVVBRzlDMG4yMlY3eWRpbFlaMFVNZGV5Y3hDTUNzL2RRYjlXRFZ6MDgy?=
 =?utf-8?B?b3ZOcVl3UGlOOEF5VittYWlSM2d4QVJiVzN5OEx0YytVNUx6TDVYcHlrMnF2?=
 =?utf-8?B?c2E1TGNtTUwzckVDa0RKSSsvR3Y0YUpqNW10Z3J5V2pZa2hRb0p0Zm8zdXlM?=
 =?utf-8?B?UTVjSEVtVnpoNXhMbVl4bXRFWmhhc2hnbmpUNGpwbGE1MEpxcHZWZTRlZkEr?=
 =?utf-8?B?aStqb0dHQWt1VzNvbkwwaFB0RVJxZm9RbVUyVEc3dFZzYnQxcDhwTDdhTDNU?=
 =?utf-8?B?OXAwbTRjdE5sdFh0ck1sRWZteXNNMmxocGlVYVoyZk9kc2pNT2Y0VmE1WXBV?=
 =?utf-8?B?SmRCc1RkZG5wT2NKUE1ZTEI2Vm9WWHlXaVB3eUEyYmJCR1NRTkdZYVZPMTF0?=
 =?utf-8?B?ZnNjSnN4cDE5WUhkOWZxYk8yeUxWN3BzYmJxcnBmWGRWQ3BRWVJoZ01PaUJN?=
 =?utf-8?B?Z3p0ZGxmMVhkMDNOa1dHZFUvQUMwKy9pK3JrZERMWVVha3Zsem96QUVLOThl?=
 =?utf-8?B?MS9aenhHcXA5WS9pak1JZVlEbzRaR3hyaWExNzFPK241VDUzNU1PUDhQZnFL?=
 =?utf-8?B?M09KQ1BnUk5WWldrQmJVYUlTUnI0dmRuL3RHLzF6WU9YeXVuK3FuR2VQQmcz?=
 =?utf-8?B?Z2hsVmUxRld4ZDNtOXA0b2IvYTdhYWhQdnIyL240RkdHeVpGalZjeld2Kzhl?=
 =?utf-8?B?MGViN0VxVk5rYVdkMVhlSE0xV25lYWUzWmZPc1RQVHErY3FhcmVSSThjek5K?=
 =?utf-8?B?Y21pMnhCajN2UWtmaWpyWW9adnAyb0FOckN1K1A3L1dBQ3JQUmlmaXVWSmMr?=
 =?utf-8?B?WFBOb3lTNmNGNjU4VkRvZjBHZVhtT20yaGkvMlUwUWtvT0F0T212SHJTb3Nx?=
 =?utf-8?B?enE3M0p1UXhFRmx3TWtQVHh5M1hycWpXSytENDRDamtSTzJKZlJTNU93S1N5?=
 =?utf-8?B?amdjM2pyaXFTS09BZUJvRHpsd2NEK2lKTy9DQ1Fxc2cyb1VKSUNLMVlxWU9D?=
 =?utf-8?B?d21wY1dSMUZNc1l5NDg1dGk0RVFrYUlRdXNoeU5FZEllNmtvSmxnL2M3S1cr?=
 =?utf-8?B?VmxXSTJ3TnJqaTlGYmR3MjBraW1tZnVaMS9xbExmaFNnWWlLQU9raUlERVMw?=
 =?utf-8?B?SlVQOEVXSlRaam5LNlJpalAwQzZOd1ZDRzd0UHRHbnBlN1FNd2F3WDhMMDBM?=
 =?utf-8?Q?UxNMVndOb8qji?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGRQWWFOa3Fnb3k4N0o5TDM1RVhCMmxZRWFhY0JrRFFnclRHaW9DNEpCZTE1?=
 =?utf-8?B?bnFrM2REWlZ4U3RiV1I2K2hVa3dsaXNMdEk5M1V1cERZbXV1R2wwYmxTWHYz?=
 =?utf-8?B?M1lIVXM1OTVrQXY4WVB0cTZGUXh6NFpwZXp0ZjZUdTl2bmFqc00wMzlEV0JE?=
 =?utf-8?B?TXIzdHBXZlBRVitxYVIweTJDTGdLNGRUWURpVmxmZWRUTmR1blJqREQxT3Bp?=
 =?utf-8?B?OVl5L2l2anBFa2xXQlhURmQ2THVhcEQ3elJPV3B1UGlJNjZDTFVmZVcycG5a?=
 =?utf-8?B?di9VbmxpSFBROTU0UEd3Z0lHL1IveFYrRXFXN0xRZ3ZEcGkwaEJEems4U05j?=
 =?utf-8?B?ZEw4U0tvMDFkeTd0RTN5VWlkOUFBeWNKaWtQSThwNUhZbXo0ZzZFRkdMKzly?=
 =?utf-8?B?anlkSXVtVkNISnRzdDVqZzFjYmlhbWdHOUR0N1dUMnJmWlBneExpbXlvZnlN?=
 =?utf-8?B?T1l6emRTSkh3TzdnN1VoOHhON2U4c3R0bkZiaHlNVnJ1Y2JnRFhZbGJFblIv?=
 =?utf-8?B?SkpJMlY2anJMUXZ6OGFpZ0VOYmVZdWxRU3JIak5tSzIxUkx2cnNWenZYOWRa?=
 =?utf-8?B?RXBmRDFLdG82cTQreWtmeFBlbFF6ZG5Ca3RCM2Y5c2JPQmtvMVBGNHhJbXdB?=
 =?utf-8?B?cmduVEF2UUs3eEhxcGxiUTFYWFJxL0piOS8vdUsxTk9BWEdkNkc2bnVtbVB3?=
 =?utf-8?B?Mkc1alV5cVR4Nm50TDFaNExxSlk5dCtiU09HdnN1bnVKS1B4ZHVWcTY5WnF6?=
 =?utf-8?B?T1BTNXZaelc2TGo0dUlXajJTU0J5cWJYckV0MVdTSWxJQnZrY0JsSkRWOVJS?=
 =?utf-8?B?eWVRMS9GQUhqd3N4ZWk5cGRYWnpJZTJWVzRMYWhaNGhNaG9RSTZEVkgwZEt6?=
 =?utf-8?B?aFh2bVVzMUlsd0J5QlJDQjRMSE5rZGd1aTArNitkeHVZOFVZcUlEV084WEIv?=
 =?utf-8?B?QmZHSE9LdlRqUmtwd1VXSC9YVjZXUXFhUlEzaDk5OUF6bHlKV29tNzhpaUYr?=
 =?utf-8?B?ZFVoeXArc3VuMGFwYTR2anhwYnlhUEdMYUtNRkZ3ak9UdmVjOGNVdENnYjRv?=
 =?utf-8?B?SXZvVGdhbXJUZUI2ZGx2RFZjd3ZqYWZyQVRnUFFVdDBnRGJ6YnhKYWhLZUM5?=
 =?utf-8?B?U0hVekxBenhJUXFYYTFiMmw2RTNiWCttMk9tN1ZWSjhialVxWGZJdDRKK0Zt?=
 =?utf-8?B?N3UrbW9LelFuMjQ3dllVRkU2K3NiM3ZKUjI0QTVRK1F6TUZNSTBvaVpEZHJM?=
 =?utf-8?B?VCs3bUxid3FSYW5kY1U4Ym5EZUhzTEZYWFVEWGY1ekwybVJPTy9tUFdYRzdl?=
 =?utf-8?B?dDZqUFVLMlZwSmFSRjNWQlk5NFRNT0IvNW5nTCszZW03bGticlc3TkFaSUxo?=
 =?utf-8?B?ZGVkQm5kUnAxSDEvUUJtNzZKYWovcFFMT1E1WW96aGNhK1BFTW95SzF5c0xq?=
 =?utf-8?B?RlpubmR4NlF5Q2wzb3dkZVJQT0VQZUhuc1ozSTJqUk5IM3NVUUFaeENUWndF?=
 =?utf-8?B?WGN1WnNHK1duZHdhUFFTTVpSYkpJbHdTdkRjVTFBWWN6SUtibUE3bDd3WC9h?=
 =?utf-8?B?Ujk4eWUvQ2hDNnhyQy9oK2JBSDJPcmhJRHNyV1hTc2RZai9EQ1cxYXVNMUZo?=
 =?utf-8?B?SlhXRmJtakdBRUV0RGxEcU4xZmNTRzQvNFFINUJXc1RqWkRvRm9Fb0FjaE9l?=
 =?utf-8?B?SzdTdUVYelRGYXlBcWE5SUlBZURVWGlleHZSNGFkSUw0cWY0bDNGbDZWMFQ2?=
 =?utf-8?B?OHV2eXdkUUtZUW80Vlord2RMUlNWVEhFL3VhejBKUmE3VTdGNk5UNld2UmFi?=
 =?utf-8?B?VmtLTVJOUE44MzFjOEdsTTdaRzg3bHdkSDY3UU4rcW9aZjJQdk5YNmp6bDJs?=
 =?utf-8?B?ZkUwZmQrYnlUa1JCK2hqcSsxdzhpdExGbFlFNEFLT0RFcE1XOWlVeUJMQ0Vk?=
 =?utf-8?B?UXRSRmhMVUw5QXB2WXh1ZDg3bmY3M3c5eXQyaDJ2M0pQOXZxVisxU3ptYmJZ?=
 =?utf-8?B?RjROcFR6aTREWG82VXZYSDlIbnYwMlhOaEwxVHdESGJJanRMaVo0cTdoZm5z?=
 =?utf-8?B?NFd0d3ZSSVVVRkRiWlVGTEhHV2dyRTlTR08vaG0vZEdDMzI1TVBRK2pHRmk5?=
 =?utf-8?B?YjVBczM2c1o3VVFkZlBtblpqQVZBdjN4OUZBWmxPZFhWNGdVL3ZTN0V6S3lO?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 71552d28-2084-4d31-fbb1-08dd57fe4081
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:46:07.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odVCk4Y7UUj1TvAyxhRUtsrEwYdDEENsMlw4diDir2xMbwNn5skTNtOCCJUymsA/FRRGJZXS5olrSQlh/Ri3hc1gm1rlCYt+Kzwcihh3Qi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9721
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Feb 2025 13:46:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1138

Hi Trevor,

On 2/27/25 3:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Since this bbappend is modifying the rauc config file with a MACHINE-specific
> search-and-replace, the architecture setting of the package needs to be
> MACHINE-specific as well. Otherwise if multiple images are built for the same
> SoC, the sstate mechanism will use the first-built SoC copy of the
> rauc/system.conf file, which may or may not match this device's MACHINE
> setting.
> 
> At runtime this leads to compatible mismatch issues:
> 
> 	# rauc install <bundle>
> 	...
> 	LastError: Compatible mismatch: Expected 'nanopi-r2s' but bundle manifest has 'rock-pi-e'
> 

Uuuuuuuuh, that sounds very odd. The sstate-cache should be invalidated 
because MACHINE differs in the do_install:prepend:rk-rauc-demo task no?

Can you check if MACHINE makes it to the sstate-cache? It could be that 
somehow BitBake doesn't detect it should be monitoring changes for 
MACHINE and invalidate the cache for that?

I guess we could also add MACHINE to do_install[vardeps] only when 
rk-rauc-demo feature is selected?

In any case, making the package MACHINE_ARCH specific is the good thing 
to do, though... maybe we want to make it happen only when rk-rauc-demo 
feature is enabled otherwise including this layer even for non-Rockchip 
machines (or when rk-rauc-demo feature is not selected) will still make 
the package machine-specific?

Cheers,
Quentin

