Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB5CA0EED
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 18:18:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.52])
 by mx.groups.io with SMTP id smtpd.web11.4539.1756405124991419582
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Aug 2025 11:18:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=xfCWYvM1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.52, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hODQLaK7Xyra2DPasfVSmjowok/J4XngnnhAIWWjOupWvPuug8rYAmrIJ/VGhe50p9BYiE8IPJMg11bRY8wBxNmJO8gMie3T19mIbA4AtC3c4Qyi1xFwzkL0q6k6Lj+4PMtHFBp2C7iOscmxzAUvhDSr2t6KwqquVnYZtmHk1svalEomkmZFHdmvowF594gv7F1HfQDkqoY3HOP3hBTGLNMk3/YDIZOWGMKxyjN90rpM27a1frSelW3Wca+/SMV8vgPcR+LIAF9+9KGh07oK/5gODxpUhk4bPpRQzWIIruw+8xlYs5b74OHoegVsmqsOJPsno/9PY3ZjDaksH0grVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SJl7vK/O/v93av/qrfZ7f0P+c+6OH+mVOzaL6c01w4=;
 b=mM4FraUfA9bCcS5hckjmq7fovjFfa3N2VBlenVYtt/bTDRuaqoaUQ+r9TbNItzjOJmuxkrgF4GDB9VZpA+KyRlbZ3RdzKHI7HfOXShL+/gledm1fSClsqgm1FMsBqzB/Ul3W3uLafQNGDGXfBPVZPdEi2/ZH9AjcKNlFQ5l9A5Lvs49YzojtCdyrq8FU8xkkCY0myY2CPG56vtqTv73G/r+GX+X0YIEgszWfAhTtW8doUraYsx/3BoWoIpV/LRuPfl3yJU04VSGSVpvrV0pvr/amg229g98OAnC2LowxnQQ5Gfyiu/NNW6JrAg4AcL7nPtaCj19HUJAOd9dtPe729g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SJl7vK/O/v93av/qrfZ7f0P+c+6OH+mVOzaL6c01w4=;
 b=xfCWYvM1sEN+rvngYsTBtRk8fMOieeszeftKchwogMiYk3MrIEh9t6qGLjRGUoNoHiQ16CFIWC+wet4V+/OqEdafWvPAORJa1taiKyA6aCiIG/hz5/Dop5PdFrgGQfL7ks/JCX0vcqI2rjSR9aITintd1ji1RG+wsr7/K1NYvh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 18:18:33 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 18:18:33 +0000
Content-Type: multipart/alternative;
 boundary="------------e6xQJ0bmfCXmB0d8L2SAC9GL"
Message-ID: <61e57828-9a49-4d5d-b622-ef063cf444d7@amd.com>
Date: Thu, 28 Aug 2025 12:18:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1]
 zephyr-kernel: Add rpmsg multi services recipe
To: "Lee, Chee Yang" <chee.yang.lee@intel.com>,
 "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20250820143951.4033778-1-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a7c92f-0866-45e7-d6f6-08dde65f4c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|7053199007|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlNzRjFPWmh2Z1VUMWNBYjhydHhVcks4RWdqQkdYNElMYzRDSG40Ky9UMGJY?=
 =?utf-8?B?YUV5UnU4bW93T0FSY0VTUXJjVXNhVWdyckc3WUFwQ2RWZmtqdDQwcEtXU2VI?=
 =?utf-8?B?cnpPT09vMCtqQXUyNjBzYW8rNjZ1a2ttaGQ3ZlFzR00yR3VhYnByaVRPRmZx?=
 =?utf-8?B?TmVDeGZxZEJmVmdSSEllcysybzc4cjE2Y3YvTjU4czF2bllsTmVVUEgrY0FK?=
 =?utf-8?B?OXYrT1Z0eTJVTjVZd2s5azRIWjNJR0N0dXhZS0RSR3QzZDBjTkJaK3ZmdFpW?=
 =?utf-8?B?WmZYaVZrTTRkV1RYY2ladlU0RXQzQzVhbnM2Q3dYVG15TlZlYzBPdWNSNEM3?=
 =?utf-8?B?Ynp2RUNuTlpuQkVvZnkvZThGbW50Qm1DZWt3b0RzeU44VDU5V2V6bVo0L25w?=
 =?utf-8?B?SzViYmliazVEU1RaQ2NFOW1BdGw5cWtQTnVYdGFNWDNlUU8xWnZoMlZvQk42?=
 =?utf-8?B?ZTR5UzhYRG95RFpqdWhoOSttY2xiZC9RenJVdWs4SEUrVEFTbTdvZTZ4UWtH?=
 =?utf-8?B?enpPcWlzUFNKYjZSUTRGaGZIQ1FtSkdCR0I1UHFvYzJKSTFiM2xWQ0pNbWM1?=
 =?utf-8?B?RHNJSzVBMHVUZE14MFpjUTAreitqRmQ0M3hGc2RKMjZKZmdVRjBwc29WNVhE?=
 =?utf-8?B?eDNUTWNocW1SWTQ3cXRJZlRRVnlxZ1FwRmVOUm9meFlyeGJhL3BCVXY4dmE4?=
 =?utf-8?B?OW90QVZFcFlXOU0zQmtENE84cW8zbERndUcyaWI4aDdrQTJmSC9zUGF2TTZD?=
 =?utf-8?B?diswdCtNRi9HTlFTcEk3YnlZNndXQUp1THVYTjJicXFrOGppeFp2WjY2Vytl?=
 =?utf-8?B?SDdTTEhhL1QxcHY0RjgvdjcveWJDTFlYbVRIUXdNOFdPdFdIQTExbzU2UlhW?=
 =?utf-8?B?MmpiM0crMVhsOFhocTlWWHNPS2RtUjdnVSt0dFFDOXptTEppUERBRHNra2oy?=
 =?utf-8?B?TmdoMDB4cFlTU01oMjVSSWRJOVZsOUVDNFVuZnR6RjIxeDRZY3RQNG5PVmpa?=
 =?utf-8?B?dVdBL1ZDSFlEckhoK0Q4K1pFVEExdURycHlWWW1DTDdWY1FVS0x5ZTcyUCt6?=
 =?utf-8?B?dld3QmhZVnhTeVMwb0YxTEgvZHN3QnZ4aUdsN2NVOWNMaE1hcjl6OFBOOEhR?=
 =?utf-8?B?dUUyMmlxTUxNMmF4SXRjZytqSUhJcEVITDNaQXZQeUxoY3FVVHVFSjJDS3c1?=
 =?utf-8?B?RHIyMWtNdkhwZjFSSFJNSjdNWXMxUGczSWpQYXZaSUpwL1FaM3hKU2RaNjlT?=
 =?utf-8?B?WXdWMlFrU1dicUdqbGw5c1RNN0wyQURpaW9CaVBuVTRnMDBwaEdyVEhoZlRT?=
 =?utf-8?B?NkVWZDVCVVV1ME10c0NjZUpVdHJrYTNXb1I5WHZpUU5PTWJnOExoV1B6NTJp?=
 =?utf-8?B?dzZvR0dGZEF2UGZlL0RCVW5NemsvenA4MkNOSWV0VXZEQVQvcVRSVVFPQi9n?=
 =?utf-8?B?a29DTnRRbm0vTmtpZmZvN0VNZThjRktvMk5ickppVTFtZGlJQUkxRDBmU3JY?=
 =?utf-8?B?ZGQrY1l4UjdyWlV1VndEYmpSTDdHdW9POEtNNER4RUpFSUNzTVd3L2JHSFZ6?=
 =?utf-8?B?eWlROVNNdDdtOU9YNjMzdW5SQ1daNVJsTlQvNmdDVkt1T3VUMjFhdjFZSUdP?=
 =?utf-8?B?UGhWZVdDZmUxK3Byb1BNeFplVVYrcVQ2dGhjbGU1R0pSUzFHTWhxL2UveTBn?=
 =?utf-8?B?dWtkcW05TEcyLzJJOFIzaW44YkdNMlg3ak1aWDBsVnROR1BQRkpWcVBDNkhr?=
 =?utf-8?B?Vjk3c1gvRFFOc2lPeVVqK2pHbDRXVFczbDdMNWh3QjY4Q0dGb0Q1VHo5Yi9R?=
 =?utf-8?Q?AdRbcoHoAizGz3DdrfXDVWTsmRWoAkC3rjMrY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(7053199007)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmlDUWVUdXNmaUllS1F2US9ud0hxZ1o0U0ZKTzQ4WU51ZVZQU0pndk1KMDVC?=
 =?utf-8?B?aDUvOVdUU0xBdXJqZDJMaUhKMEd6M3dBWDhtRnNEY3ZVKyttcG5TYjlPdFRE?=
 =?utf-8?B?U280bmFXckdzSW8yL09MV0QyT2RRdS8rb05vZlFOcVYxdU1RV0VpNTFKczFk?=
 =?utf-8?B?R3c5WDF4RWJjaU16WGVGWU9EMzdDekRoYW9DOWtHeDhJSE80Mk5Ndi9nWHZ1?=
 =?utf-8?B?WW1VTXVJRHAyUHpvTXg3RUlhSHpGbXc5bjJyYVBpWEFhSlpDcVp6a1hFZlhI?=
 =?utf-8?B?YVZqR1hwaHB2aGhwTW5UL2hna0NTSjdRT3V3Sys5L0thaGN5WkZrMFlIdm1E?=
 =?utf-8?B?OTR0cjlaTk1ya21JVzhJRXVmckNQN3FocnFFTm51NkJzQ2dNRE8rSGJTVzZN?=
 =?utf-8?B?K0ZST2FXMy9jbUtiL0tzWTBRbG1jd1Z0aHVsWGd5akRRZjNSdEV2eXFXOEM3?=
 =?utf-8?B?dUlrb2pBWC8zZFEwR2tqS2pTU21Remlmc1BiNWdveFNldXlOMkxubCtVUGZM?=
 =?utf-8?B?KzhuRnVyUG8xems3YWRhRk5jZXBGNVFDNG11eFFTaXgxaEExQTBmMkc0K2Qz?=
 =?utf-8?B?WVV6OXU1RVd1NFNwRFBXM3h2MExEM21WaEhvQ1AzWUZDQ1Y5ZVdqdytUdzdK?=
 =?utf-8?B?UCs5MEVncVdXMXFkR2g1MG1qdHZJclJCNDVqSGVJb3pJdkhpRlNCM01TRVNi?=
 =?utf-8?B?eHJIQVhLZXllZGtaQ1RvSDdhZ1ZZVHg2RHArTUVCZitnQTllMVlhL2ZuRXRa?=
 =?utf-8?B?WXpQNjFSdmlWNXo2WHN3cjdoTzhJdUJiOURJQ2pUeTBLcW5nZWJWSDA1UzRL?=
 =?utf-8?B?eCt1czFCempTWldiWTkyMFNzM0VPMTd2WVlEdHUxbXFoUFArOWVqWEpKMTRh?=
 =?utf-8?B?RWdiaWc0QW5XN0h0MFdDbGxHeGpMbXpCcllabWJCeWI1V01tK2ltRVlNUThn?=
 =?utf-8?B?OEtpcUxSODBibGVmRUxPa3Z4ckhxeHlvdExqQ29Od011Y0M3am8vQWhMTkdP?=
 =?utf-8?B?TisvbERTOGFoQWV6VkZMSmtxZDNNSFpZUVprN3FZMXVaQ2VYalFXcEpCeGJ1?=
 =?utf-8?B?enRzMTRGejhWZ3B1V3JxKzZVR2JYMENyRzYzcVRnZlkzc0d0Nk9uZVJkcXZj?=
 =?utf-8?B?Q1U1VVRUMDJ2M0ZlY0xMeWYrcjBZdlg3NTJ1RUF0V3A1TlVGSzNWNFc2bUdS?=
 =?utf-8?B?eUd2SVNGV1BWRzVoOHVVNGxGMWtuVnhOT2lTSFdwZEc0VUtLK0orVHNlQ3VL?=
 =?utf-8?B?aGNmRVpnZlFYZGpSc1cvbWRvWHlXdGhQM0NGVlg1eFZ1aklXRTNGcHVhUkIv?=
 =?utf-8?B?NzhSQlBMN3U4YUoxTHQwNW9JYUF5dHFhZDFaeDdrcmlxZVFEWEd2VE9ETzJI?=
 =?utf-8?B?M0d4Qko1MTQ1VjJxNDN6cG9nZG5KYmVzNDZKWDJuYkphMVd0QlRJTFhJV1h5?=
 =?utf-8?B?Zmd1MEQwL2xVV2taa2sxWWI0OXZLdVk1d3lCVHRUUTQ0QkpPdHRFOGk4WVYv?=
 =?utf-8?B?UDRoMFBxemtpU0tjUldVdFN6czYrTjdaY0x4ZmVjZ054R3hzVXlSZjJlRTZC?=
 =?utf-8?B?SE4wVEh6dnhTMW5VdlU3QWlKU0kza3czaWkrejNWR01CQXcrWlZBYkE2SUdV?=
 =?utf-8?B?dTBOTnJNK2ErNjdoY1pRZVNyNUNzMlpKenFzbFQ1YWVjWHFFYmNlNG80NEYw?=
 =?utf-8?B?bllmY0JaMDhJMDhZc1d4Q2h0eDhISzBFbnE3dFgyazFkeS8rWS9QaW1WeEZI?=
 =?utf-8?B?Y0pHMGVTdHZnbFZDR2FSYzJoejY2MTY3clpLNVk5YmVoTU44dVNubHhQUHAv?=
 =?utf-8?B?Sit6SncxSWJxUXNEZmhHeDJpbVo4WGFVMVhzSUJuQ0Qwc0VlZVN6L2wvOHor?=
 =?utf-8?B?bXhBQ0l2YU9ZWTg4bGhYQWNyd09pcHhIclFSNUZFZjZwUnFmTDZjQlZDUEhW?=
 =?utf-8?B?akVFUkxUdm9aUzhybnE5ZVkzQTZSazh5YXQ4OUpoQWNremkzRFZ4aFk5a204?=
 =?utf-8?B?MDRFeE5GOFNiaWYvVjRvaEJBV1QzV09qeGtvMjJqaTQ5NnpySXhiVlVvbHNv?=
 =?utf-8?B?U1RNUGJ5RjZWVjkxL1J3UEIrVXZqL1RXd3IvUzEySzhGYSsybjhQUnJzMXNp?=
 =?utf-8?Q?3z1mnQ1h82NyIAn5hQFvwQhlE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a7c92f-0866-45e7-d6f6-08dde65f4c87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:18:33.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfqpZSmTmXs8eSDf6vvwbHcqktQ2PAMPTBElCT1aM2d1r8Yq6a9DZM/aJ38/ZGoslEYeu9AjoQT6QNdHCE7LFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Aug 2025 18:18:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2089

--------------e6xQJ0bmfCXmB0d8L2SAC9GL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chee Yang,

On 8/28/2025 2:16 AM, Lee, Chee Yang wrote:
> Hi Sandeep
> Unfortunately, with these I still can't build the recipe. Looks like we need to patch CMakeLists.txt

[Sandeep]: Not just zephyr-openamp-rpmsg-multi-srv app any of the zephyr 
app(MACHINE=qemu-cortex-r5 bitbake zephyr-helloworld)  is not working 
for r5 machines unless you set the ZEPHYR_TOOLCHAIN_VARIANT = "zephyr" 
in local.conf

We need to take a look on this issue. I see this issue in both master 
and scarthgap as well.

Some machines doesn't build if you don't set ZEPHYR_TOOLCHAIN_VARIANT = 
"zephyr". Can you try adding this to your local.conf and see if you can 
build it?

Thanks,
Sandeep

>
>
> meta                 = "master:fb4ebd60536af8672f950376106e0b0500d7007c"
> meta-oe
> meta-python          = "master:714b3adc3a92d42370a0ea57a9744ad2d031db7f"
> meta-zephyr-core
> meta-zephyr-bsp      = "master:5260aea7ef135d3b23f49c8d7bf6c6f78bdc2f50"
>
>
> command :
> MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
>
>
> | CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu_cortex_r5-zephyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0+git/modules/hal/libmetal/libme
> tal/CMakeLists.txt:1 (cmake_minimum_required):
> |   Compatibility with CMake < 3.5 has been removed from CMake.
> |
> |   Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
> |   to tell CMake that the project requires at least <min> but has been updated
> |   to work with policies introduced by <max> or earlier.
> |
> |   Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to try configuring anyway.
>
>
>> -----Original Message-----
>> From:yocto-patches@lists.yoctoproject.org <yocto-
>> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
>> lists.yoctoproject.org
>> Sent: Wednesday, 20 August, 2025 10:40 PM
>> To:yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1] zephyr-kernel:
>> Add rpmsg multi services recipe
>>
>> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree openamp-
>> system-reference example applications.
>>
>> Signed-off-by: Sandeep Gundlupet Raju<sandeep.gundlupet-raju@amd.com>
>> ---
>> Changes in v3:
>>     - Add machine compatible for qemu-cortex-r5 and stm32mp157c-dk2
>>       machines only.
>>
>> Testing:
>>
>> $ MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
>> $ MACHINE=stm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
>> ---
>>   .../zephyr-openamp-rpmsg-multi-srv.bb         | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>>
>> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>> rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>> new file mode 100644
>> index 0000000..dca3b9b
>> --- /dev/null
>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg
>> +++ -multi-srv.bb
>> @@ -0,0 +1,25 @@
>> +SUMMARY = "Open AMP rpmsg multi services"
>> +DESCRIPTION = "Open AMP rpmsg multi services"
>> +
>> +inherit zephyr-sample
>> +
>> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=
>> "git://github.com/OpenAMP/openamp-system-reference;protocol=https"
>> +
>> +BRANCH ?= "v2024.05"
>> +BRANCHARG ="${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
>> +
>> +SRC_URI:append = " \
>> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-
>> ref;${BRANCHARG};destsuffix=${P}/open-amp-sys-ref \
>> +    "
>> +
>> +SRCREV_open-amp-sys-ref = "d78315763fbacba8a74552d0ad570bd01c42ccf9"
>> +
>> +COMPATIBLE_MACHINE = "(qemu-cortex-r5|stm32mp157c-dk2)"
>> +
>> +ZEPHYR_SRC_DIR = "${ZEPHYR_BASE}/../open-amp-sys-
>> ref/examples/zephyr/rpmsg_multi_services"
>> +
>> +ZEPHYR_MAKE_OUTPUT = "rpmsg_multi_services.elf"
>> +
>> +EXTRA_OECMAKE += " \
>> +    -DCONF_FILE="prj.conf" \
>> +    "
>> --
>> 2.34.1
>>
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#2073):https://lists.yoctoproject.org/g/yocto-
>> patches/message/2073
>> Mute This Topic:https://lists.yoctoproject.org/mt/114800427/1648606
>> Group Owner:yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe:https://lists.yoctoproject.org/g/yocto-
>> patches/leave/13233161/1648606/629479993/xyzzy [chee.yang.lee@intel.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
--------------e6xQJ0bmfCXmB0d8L2SAC9GL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Chee Yang,</p>
    <div class="moz-cite-prefix">On 8/28/2025 2:16 AM, Lee, Chee Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">Hi Sandeep
Unfortunately, with these I still can't build the recipe. Looks like we need to patch CMakeLists.txt</pre>
    </blockquote>
    <p>[Sandeep]: Not just&nbsp;<span style="white-space: pre-wrap">zephyr-openamp-rpmsg-multi-srv </span>app
      any of the zephyr app(MACHINE=qemu-cortex-r5 bitbake
      zephyr-helloworld)&nbsp; is not working for r5 machines unless you set
      the ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot; in local.conf</p>
    <p>We need to take a look on this issue. I see this issue in both
      master and scarthgap as well.</p>
    <p>Some machines doesn't build if you don't set
      ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot;. Can you try adding this to
      your local.conf and see if you can build it?</p>
    <p>Thanks,<br>
      Sandeep</p>
    <blockquote type="cite" cite="mid:BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">


meta                 = &quot;master:fb4ebd60536af8672f950376106e0b0500d7007c&quot;
meta-oe
meta-python          = &quot;master:714b3adc3a92d42370a0ea57a9744ad2d031db7f&quot;
meta-zephyr-core
meta-zephyr-bsp      = &quot;master:5260aea7ef135d3b23f49c8d7bf6c6f78bdc2f50&quot;


command :
MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv


| CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu_cortex_r5-zephyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0+git/modules/hal/libmetal/libme
tal/CMakeLists.txt:1 (cmake_minimum_required):
|   Compatibility with CMake &lt; 3.5 has been removed from CMake.
|
|   Update the VERSION argument &lt;min&gt; value.  Or, use the &lt;min&gt;...&lt;max&gt; syntax
|   to tell CMake that the project requires at least &lt;min&gt; but has been updated
|   to work with policies introduced by &lt;max&gt; or earlier.
|
|   Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to try configuring anyway.


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a> &lt;yocto-
<a class="moz-txt-link-abbreviated" href="mailto:patches@lists.yoctoproject.org">patches@lists.yoctoproject.org</a>&gt; On Behalf Of Sandeep Gundlupet Raju via
lists.yoctoproject.org
Sent: Wednesday, 20 August, 2025 10:40 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a>; Lee, Chee Yang
<a class="moz-txt-link-rfc2396E" href="mailto:chee.yang.lee@intel.com">&lt;chee.yang.lee@intel.com&gt;</a>
Subject: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1] zephyr-kernel:
Add rpmsg multi services recipe

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree openamp-
system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <a class="moz-txt-link-rfc2396E" href="mailto:sandeep.gundlupet-raju@amd.com">&lt;sandeep.gundlupet-raju@amd.com&gt;</a>
---
Changes in v3:
   - Add machine compatible for qemu-cortex-r5 and stm32mp157c-dk2
     machines only.

Testing:

$ MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
$ MACHINE=stm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
openamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
openamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..dca3b9b
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg
+++ -multi-srv.bb
@@ -0,0 +1,25 @@
+SUMMARY = &quot;Open AMP rpmsg multi services&quot;
+DESCRIPTION = &quot;Open AMP rpmsg multi services&quot;
+
+inherit zephyr-sample
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=
&quot;git://github.com/OpenAMP/openamp-system-reference;protocol=https&quot;
+
+BRANCH ?= &quot;v2024.05&quot;
+BRANCHARG = <a class="moz-txt-link-rfc2396E" href="mailto:${@['nobranch=1','branch=${BRANCH}'][d.getVar('BRANCH',True)!='']}">&quot;${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH',
True) != '']}&quot;</a>
+
+SRC_URI:append = &quot; \
+    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-
ref;${BRANCHARG};destsuffix=${P}/open-amp-sys-ref \
+    &quot;
+
+SRCREV_open-amp-sys-ref = &quot;d78315763fbacba8a74552d0ad570bd01c42ccf9&quot;
+
+COMPATIBLE_MACHINE = &quot;(qemu-cortex-r5|stm32mp157c-dk2)&quot;
+
+ZEPHYR_SRC_DIR = &quot;${ZEPHYR_BASE}/../open-amp-sys-
ref/examples/zephyr/rpmsg_multi_services&quot;
+
+ZEPHYR_MAKE_OUTPUT = &quot;rpmsg_multi_services.elf&quot;
+
+EXTRA_OECMAKE += &quot; \
+    -DCONF_FILE=&quot;prj.conf&quot; \
+    &quot;
--
2.34.1



-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#2073): <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/g/yocto">https://lists.yoctoproject.org/g/yocto</a>-
patches/message/2073
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/mt/114800427/1648606">https://lists.yoctoproject.org/mt/114800427/1648606</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches+owner@lists.yoctoproject.org">yocto-patches+owner@lists.yoctoproject.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/g/yocto">https://lists.yoctoproject.org/g/yocto</a>-
patches/leave/13233161/1648606/629479993/xyzzy [<a class="moz-txt-link-abbreviated" href="mailto:chee.yang.lee@intel.com">chee.yang.lee@intel.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------e6xQJ0bmfCXmB0d8L2SAC9GL--

