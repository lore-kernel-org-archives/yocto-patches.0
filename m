Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F2C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 17:11:52 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.43])
 by mx.groups.io with SMTP id smtpd.web10.16016.1737652308645626738
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Jan 2025 09:11:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Ow0+hhY9;
 spf=pass (domain: cherry.de, ip: 52.101.66.43, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhT7na6UpiH5DxVywmEafId8x1I5L0md2qJKaI2vxjv/gjcQRBCSsaBn7VVSxlYC0ipOF9DOOjjJxqXau+yRDziN68sHYI68yv6UtPWcDglEPyFeWW9JdWKKgNb2h5KYFLEgJmNedVkvzaiRtV/o8T0x6RdgNSxCDyM/1Xa96/ryGpuO45FLZRsN/cKdkycfqxw1p+b0f8z8Eg42KE3Z6NtUhT+z4Fy4d0lMAUVGbb7kRFraHfS1kREGrrMB4S6N7mtVRUnVOpoPP8P92YsQzaVIiYtGuFFgmbxhb+kxIfhhuu0Aw7tRi+vX0ULEp1uXDoiIdq3JMnrf9hG3NcYSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpGkRVdbw0hSNHli5Iriy2rCdDzXHPvqP0DIMskOh4E=;
 b=luQ0poQafA48CBoG2SE6xsIcQentjmIZZyMxni3oylY7D+Y3ApBRxmy9B4kSze2irq9+4QPflONkINm6TXMYQjEMoYtpiy6Gpgay9hLxt9M+pIPnsrJNFBdZoIi6xZf7GABIRrUtbHCmIhsnVdDxpZ2IuJN4wEWUV9JaRN3pYpiP89oGI1ydGPjwoBzIGO6g1ni3AHQ/pRMQ/JwYoxdefoaM3i27adL517ypLKop9EMXrnmPAh0eCuoer8q+y0AuAmTPP5475/g2CiPHHFyDUXpdDMlIJzFotw3IPPu/W3AQlQDPqSRU97oPlWPZAjlptm8wWqcVqXaFrLWyRdBMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpGkRVdbw0hSNHli5Iriy2rCdDzXHPvqP0DIMskOh4E=;
 b=Ow0+hhY97KlnZZLVtlWcVeVMqMzIfTxLuxtC9sINv0O69wjVjd/IXrE/NZP6/MwvkZYSxbvQJyr46IdHc6e0pAYF2aaaV6I9Rh93WtaL5m0Ai6VErMaoSNpEP8anK8PmGr+AxpBPVCdRyQ5dJ5HPTLX1loa+LL4HdZ3O9fr/sk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8081.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 17:11:43 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 17:11:43 +0000
Message-ID: <27a1a454-d868-4ff6-9fff-036af2ca6835@cherry.de>
Date: Thu, 23 Jan 2025 18:11:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] CONTRIBUTING: move to yocto-patches
 mailing list
To: yocto-patches@lists.yoctoproject.org,
 openembedded-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
References: <20250119065155.1947971-1-tim.orling@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250119065155.1947971-1-tim.orling@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: b591a245-8531-4350-545c-08dd3bd1025e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEtucVAxam9uRDZBaTM2THBGektQMi83bFNXR0lxbXlYaElsNytqRk9ZNVFH?=
 =?utf-8?B?ODc2Y0JKVUxCNjVhQythMWJKd0Y4YVhlMVg4SW4wUFd4SHRxVE1jNGJTTWFK?=
 =?utf-8?B?em1XcjBwaGIrVmg0NGR1ZFBFdXpsbWJsTE1FKytweUJzNjRjZDdFbkQyRk8v?=
 =?utf-8?B?ak9iMEFJMlBWWjV1NTQ2Y05sdXFKSExpZVZuY0xFcnFBa0JKUzRzbDk0eEp0?=
 =?utf-8?B?U1Q1R3k1YWVSbjFueGVhdzRiVFJkVHZhbnUzTldGd3hPbVBxWXg4akV4eGVM?=
 =?utf-8?B?SktOSmhuRm9RK0RjK25QNDkxK2dCM0hRN2VtQ1J3dE1WRDVkcSsrelVCWk1N?=
 =?utf-8?B?NFJUMzNHcitHNGZwQjJET2lxaUxncXNTVlBjVmJtQ0phWTV1dTlEMVBhL1lo?=
 =?utf-8?B?YmkwQmVQN2NGYmV5aC9FNHVPMVh4dGhQeFdBdUMxQzFOeHdXdEd0d2FjUTcw?=
 =?utf-8?B?ZUlzV2Z0cHBZbGtraVpNenBpV3EvMFBXNzQyTzNodnZsdjZrTUZGWFNZMlNt?=
 =?utf-8?B?MGhkOWRLZEgvb2hFZ3hNWFRPYS9YdEtITHdlLzFEbnhIclQxM3VNQlZ4cGw5?=
 =?utf-8?B?R3F2TjlmN1J0ejhzUlJVZ0NFZ2I5YWhrYkdqbWN4enZGRjZTOUJwZzF2c0dn?=
 =?utf-8?B?dWlFMXNUbSt0SXBBVVdDMW56WWdCY2ZmbFlWSWJHNzJ4SDFGMk96RTM0eHFi?=
 =?utf-8?B?TWRIczRPalhjTU41aUZqTHZIN2phK3M1M3crNkNkbW40SUJwdzEvMkE3N1Ux?=
 =?utf-8?B?ZFVXeXhzVUt3OVJWWXJ5M2gvV1VWQUdmNm5qeHl6RG4xWmEyeWgzczF0dXF1?=
 =?utf-8?B?ZGhYQVBncGcyUUhBZjl6YVFqam1YN3FNa2FnQ3ZvU3BOYldzcFZ1Z2pGczR5?=
 =?utf-8?B?eU1OV2llbHJaanlvalU0V3VBYkgwaWRrT3NlRnpiR0pkaHhUU1A0R3I3VnRo?=
 =?utf-8?B?VVozZ291SjhzYnI0WFJJeVNvaXEzR01ETXRQUEI4bTlrbW15N3M2ek5mdUMr?=
 =?utf-8?B?Ym1FbkFsQ3VJTTFqWFNLNWdpZVVYb05YcXYrWkdtcE01bTIrRnJKNFBnSkg1?=
 =?utf-8?B?K0gvbkFvZWFqNXJFYnN5UFRRRk0xQ3pwSzl3SE5RL2FFeXE2RmRyWCtXL3Zx?=
 =?utf-8?B?ZnlVbk9ub0ozSzhoeStYOWlNLzdYVGdBZ0I4U2t0My94Q0g3V0NUL00yQkpB?=
 =?utf-8?B?UjI3MkZxN0JIOUw2NU9mcW1TU2hER1Fvdms0dVUxVERpM0VDam5XL0hYcm9q?=
 =?utf-8?B?NUx2eDNrZnZPTyswb1lFenZDMkZPYmVORzYrejA5VGdqZjZQa0lZTkxPcXFn?=
 =?utf-8?B?Y0dVanp2TVlHNy9XWVpScjBwLzExZHQxeHZlNU5sbGVYSks5OHorclBxZ0VU?=
 =?utf-8?B?Y29UeDhwNDBaZkY1ZXNhQ3ZkRnRZOFQ2WjB3aitGbVIzbldVclhFbHp1VEcv?=
 =?utf-8?B?aUs2N2d0ZVZOSERxZW85SWpGVHpPeVQreFhIYUFSdHlIL2dvK1E5VW1oWHdl?=
 =?utf-8?B?b3NhbU9KYU9NSy96WG9FbUEzWWQxeTZSRXpnL0huTEZIOXpEU3luaGlGczNX?=
 =?utf-8?B?c1U5Q2VLOUdnVEllQVVJMVFXRDFQdHpwZ1FURTgrWENPcUxCUjE1WVRjcjg0?=
 =?utf-8?B?VHhQazhaNWVmOXFVODdrSThDZjNuYnU5Q1BKVDhia3Jrc09OWDArV1ZrOUx1?=
 =?utf-8?B?Y3Jhb09ZdjBMcjE0Z0xmYmtEdVRrbWVqYkVROGJwcmQrbENNdjg2bmV0bEly?=
 =?utf-8?B?bkQ0ZnBNZXdsYS8vbzJrRFFlcmR6QjREbDY1SXdKS1FTZmlFSlRucVpsWCs2?=
 =?utf-8?B?ZUd6SlpFK1hweXpnWnVTZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmhMVnh1QnNja3VzcHpNWk9xRTVVSWJ4YnlpMTE3ZTA4TXZYaUlSZzl0UlYr?=
 =?utf-8?B?ZG9Ra0paeEhEQnVjcEg3aDd0ejBCUG5DL2EvaG93VW43UEtsYkowdUN1eTVW?=
 =?utf-8?B?QUt1endIbGpIbDQwQzV1YkJtWGh4UDV6dUVReHhSdWg5c1dVUWVETWkrTW1P?=
 =?utf-8?B?WE9LNExFeEtUZVAwNlBzWWhJM2JxWmFJNTVOUkkvVGhJSlFtVGlQMXJBSERz?=
 =?utf-8?B?ZWpUVjA1dHNuKzNGTVNOdE8zYzFRMnhpYVpqR0pleG42L3lLbFB2eTBRQ2tK?=
 =?utf-8?B?Z0F0bkd4ZnIvYkgrbjFXWnZCeEc1VTZic2J6NnJyNzNkT2E4eCtVTUFEWU5J?=
 =?utf-8?B?TDhZNXp1dTNYVGRyZE42V05YblhnaHFwSWwwSFpRWW1vWTExV0FPTk5tWDhr?=
 =?utf-8?B?djZCN0xTSU1XbTYrVU1pTkJ3ejh3KzQyT3o5SGE0OTdEazhmV1loOTlPMjk4?=
 =?utf-8?B?R1FCOHg1TDAwUEIxbWpVZ3YyMkxxY1d4eE4yQzVpUGg5ZERnakpqRitGbnI3?=
 =?utf-8?B?MlpRWHlXNCszVGE4MTQ4SERnSTRxbmVicjNJZ0tRKzBlYXFEQldaUEpBSDI3?=
 =?utf-8?B?ampMTXhrU3hEVDlPZkxQOEp2ODFtQjdmeHZQblphQzBBRnRSazlyRGE2OVo0?=
 =?utf-8?B?dVBsS2hIM05wUGRtQ1JxR1l1a1BNelF6L2szVHFpOUExWEg3bTZPVFJ2UVI5?=
 =?utf-8?B?cTAwOWpZSnhnZEovRnQ3ektOMWN3L3doemhtMWlnMituMy8xMEdXTWk1ZndT?=
 =?utf-8?B?OVdHNHd5aUN4VTVNNnlBeXhHRmdaR1BITVExSisxWTZMbkUxZHpmRlJWbjZq?=
 =?utf-8?B?MzB1anNZS256aVhPQkZwU1phaElvNjhaMGxtcEVIR29nSERLTkJJL2p0aHdw?=
 =?utf-8?B?WFBzbWpvaW9oRWl6d0REbDJic1k4cTAyQzBYKzI3MGtLT1pqMEJJelgvUjla?=
 =?utf-8?B?bUF3ZHdsL2N3VElxU1MxSzdHZk5sVkE0Z2F6Z0tyMmpEQ21pOWdETDRIRGwz?=
 =?utf-8?B?NjN4NnQvTHZHbCt0b3VXd29xakxBK1JlOTdGNERpWE9CVEY2THEwOFQ1RTU5?=
 =?utf-8?B?eDZnUjJDU2xFYjdzbWtibmVSVU9DS1lFMlExbHhFaUhrZEQva2FKckZCcHdE?=
 =?utf-8?B?SmRCdTYxaHZOeTJuMGQyMjZiZGc3QTY0M2ZOUE5mcmVEeWdUdVVqclAreDFt?=
 =?utf-8?B?WXF1MDdqYy9hVzQ0aTlZU2ExL09TSnE3ZzV0OEhTZlVBZEJ2WDQ5VVNMaCtN?=
 =?utf-8?B?VkxjS1JLWTExQzVQcnVTaHR0K1VQL1p0NFY4aG5QNGprS2U3WTM4RGI4Zkpi?=
 =?utf-8?B?UDBOQmJyL3Y3clNUM1lNN3JoOVJ0QUwrZm9BWFRpa21lRWpKZ0doVEJkNHZQ?=
 =?utf-8?B?eGlSdmtCVHBmWWo3WVJ5L1U4TTRsR3RVdGpkejFzUUZIbUR6aW9laG5hdkVK?=
 =?utf-8?B?SSt1aGoweEtvWGpyaVIybzBZTkpyN3ZZUFJ2U3ZZNnFDTHo0WE5xWnRSOUdn?=
 =?utf-8?B?bGxFRXRZWUh4dUJBR3g1ZnRxRmthcDlJSUtZSzREby9aSUNIb1lLSjBlNHdU?=
 =?utf-8?B?RUkrdFJIQXpPeFFzS1ZLK01heG91c3JOMVZzaktKckJKUnVKL0lxUEtnMGZy?=
 =?utf-8?B?a3JWU05IbkQ4NzB0RS8vOEFMVHNtR1BiU25lNVVuWEVyY2hWMTdLeGJndllw?=
 =?utf-8?B?NkM0ZTd6NFdWMWxHcWpNaDZQaDNtWkJBRXZQN1ZqZ1ZHR2lsM3ZoeTdwZFZL?=
 =?utf-8?B?bHdZWXhGeU9qSGlBVmFWUHd3U3ZzL2FucVIzeVA4UVAxVjJmRGM2ZDJPOFhB?=
 =?utf-8?B?TCtWY2NwRFZ0MS9TODlrNGNyMFgvWUdYWEJZckdiR3UvOExaRTllZ01RMkt6?=
 =?utf-8?B?cHBuaVp2MzZPRVJrSk93WEkydWlJbXB5TktSbThOZDFIbWViaTM4VXNxVzlY?=
 =?utf-8?B?QjB5am5xWlhlMVJZb2x2RUllbTgvK2hVUDhNb0hHM1JjVUg5KzVSbThvYnV3?=
 =?utf-8?B?aWdjQzQrUDJ6NXVWbGxsdVh0ZFVRdlpYVy9NZCtIWHBkU29LeDM1aisraWJR?=
 =?utf-8?B?VjA1Szkvc2x5SWl4MzY1eDJxL0diYnVQc3hlcHJmUHdFcGdXRGtCS1ZTNEdV?=
 =?utf-8?B?dFViaHlRazByTkFRRGdGaE1VRUU2LzIzVGg5RnF0b2c3MjFUT0hQanNVa0Rt?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b591a245-8531-4350-545c-08dd3bd1025e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:11:43.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QDrR4DWtgDZjtObJaGmqNiACGItUIdYxecDSmaMLNW6VIpqlAcIIdm4vbBN9QQdbcqjuDIR5RYjFsD/+OWUfTeC63kQ4+dn40F6FWlmzGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Jan 2025 17:11:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1005

Hi Tim,

On 1/19/25 7:51 AM, Tim Orling via lists.yoctoproject.org wrote:
> From: Tim Orling <tim.orling@konsulko.com>
> 
> Since the definitive, canonical repository remains
> https://git.yoctoproject.org/meta-java the official
> mailing list should remain in the yoctoproject.org
> domain. Move to the new yocto-patches@lists.yoctoproject.org.
> 
> Please remember to set the "meta-java" subject-prefix:
> git format-patch -M -s --subject-prefix='meta-java][PATCH' -1
> 
> This makes it much easier to find patches for meta-java.
> 

For what it's worth, b4 should be able to do this automatically:

"""
$ cat .b4-config
[b4]
   send-prefixes = meta-java
   send-series-to = yocto-patches@lists.yoctoproject.org
"""

Haven't tested that myself though.

For older releases, you could also add scarthgap to send-prefixes for 
example.

https://b4.docs.kernel.org/en/latest/config.html for help on the 
configuration
https://b4.docs.kernel.org/en/latest/contributor/overview.html for 
contributor workflow
https://b4.docs.kernel.org/en/latest/maintainer/overview.html for 
maintainer workflow

Note that I only use b4 as a contributor but b4 was developed initially 
for helping kernel maintainers if I remember correctly.

> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>   CONTRIBUTING.md | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 5420797..00c7b88 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -23,7 +23,7 @@ for some useful guidelines to be followed when submitting patches.
>   
>   Mailing list:
>   
> -    http://lists.openembedded.org/mailman/listinfo/openembedded-devel
> +    http://lists.yoctoproject.org/mailman/listinfo/yocto-patches

404 here.

I think you meant https://lists.yoctoproject.org/g/yocto-patches?

Cheers,
Quentin

