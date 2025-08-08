Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8DDC87FDA
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 22:33:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.86])
 by mx.groups.io with SMTP id smtpd.web10.901.1754692403296160326
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 15:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=PvWr2k82;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.212.86, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHoMAQHtBx9EFvQd0s5USFPA7/LOWYXNKW90R2Nxatitf+NBSYSBu8lZosF+zy0hMad9gAfJA6Ea5eI+AHa0wPwSvdx6r37u60K6qeiN3nhYbvOf14ClHBejFgmy1vyraKrmxPtimQgnBphl9QBYW9tQB2IsU1qo44k85j4RqdVT8+p/o/gZIhf7kZGHTppbBIwmQGnsr9VK0+awLqCKmGXzgEO4UzKt5JQRC4+tTrG6Aa7pF0OIvxYTw8iz/+/mTzD3Rk4xmTUz65GLbWpveLWdeydB6iYPacFMLGjvfAE+qOn98k4f/5y10i4MWScrw2DgOlAFqrkjjn7XjIx2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7rtCSRWJGLxitAKaW9hmtsoDHXkie21TmXknID3KYI=;
 b=nBKY/BiIbjcjLI13/8s3u7oKfOeuFp/6nFhI9VSNeoxNwx9+tTVZ7Sly11ZwdojKuvCfMGdoRpAqhlbp7UaEcJkNovF8YaSiMZvU9gab7z8EfMlgqA6mXQk+M7LE6IxWN0ocVqm5ECnDk/INhIPHBmsBXQly9oSEm+33Kjs0JJaM6QgHsaII62H0HHYLS6Cv0CQiXN3N8udk3SjTXtQ/uTYMmErLR1XGo0CQcduEHPf5yDLs5gCBK5ayLHl1CAv0UilR28BNXuGLTFuQFC5V9htjGFJyAHbURRYG4T1vSKd6WPVmeJWHSq44JOMvPngw7lvjnF/j8+/yTip7tTAeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7rtCSRWJGLxitAKaW9hmtsoDHXkie21TmXknID3KYI=;
 b=PvWr2k82SBbEg+a3irJsdjNibyoIJ7Qmxalv3LPa7ynTDONegH1N4NmUmqM/ZXfyUo/dzDIZgVpyJqwPyU1kXBx49RXgY6CtTPWxDNgDZiGNi8p9waCvyp7HCelO3jlFmvJmMNblvSE4uuTo/JzfWhwbvQwFpzfWgbn4hMFncgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 22:33:18 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 22:33:17 +0000
Message-ID: <b7ea93d9-a879-4df2-be9c-684651999bf3@amd.com>
Date: Fri, 8 Aug 2025 16:33:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [scarthgap][PATCH 0/9] Update for scarthgap
 release
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com
References: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: d81105d6-a524-4b2e-6cbf-08ddd6cb9239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWlraGJhZjlqUHlNdENYMjgvRm9WUFdUVGg1SEQ2MjZpcGhDbmErRXJBREg5?=
 =?utf-8?B?eHh4WXl1YW53OUYzY3BuRUpwVitKeFFDMmhDTm9CMnFGUmd0RElRZXE2M0cv?=
 =?utf-8?B?MGpSWmZoemx4NEltUWpvV2xubjRuam1vbmVYb3hkUzd4ZmVqV2owcXpaOUpL?=
 =?utf-8?B?RXg2ZUNoTVhyOStBVDd1cHE5dnN2UTl4RjN2MHpBQWlUQ3BSMTdhRVAvQTVK?=
 =?utf-8?B?WjYyZDc5cVQ2NSs3bm1rZi8yL0hXVEtRcDFxY0xmMGJ3WU5Xb2tMSHVOem5k?=
 =?utf-8?B?NVpWMCtjRTQ1YW1UcnZPNlFSbWJ2Qjl6cFpZZUV3NWw0aDh6U01SSTNmaER3?=
 =?utf-8?B?RXhVdCtFRUtsUDRHUHpVeE5NVm9PYVgwcGJsTXpUQnIvUHNuNzZTR0t0WVZ5?=
 =?utf-8?B?UWYxKzk0K09rVGxPT2tVekNpQU54QlV2S00wV0k2VFV6cVYzYkNjOGhKVzFi?=
 =?utf-8?B?cXRiOWVvTmt5K2t4MWtxMlpUVllWSkk4QmVmaWsxNTFtN3dVc3VrRE0zWDZH?=
 =?utf-8?B?WFpsb0NCcE85WFlYajgrK3VISi91cHMyUGJ6bXpTdnJ0ZHkzNmxibElnT3Jr?=
 =?utf-8?B?Q0h1S2wrUGpmNWhhM1NXblRzT0tTcXhaMDNoRlB3dVFwMkdTdFBzUWFsMFVV?=
 =?utf-8?B?dGVIeEFyWU9DU3V2UWRLbFB1bjM1b0FsbEsrTExhTFMvajNtb2hianNtV1Y4?=
 =?utf-8?B?NDRrRzJIZW5Xek5lNVYycXgxSFROY1VqSGQ0UFNKUGM1T25aa0VPVW15OHRk?=
 =?utf-8?B?Z2FoZ0d3OGpoM2F2ek1oU1paR1IwS0o2cjBJS2t2NzBTczNRR0JxUkFlMlVw?=
 =?utf-8?B?RlorVFZOVDlxY0xueTE0ZTRrZjBtb2ZBdFJnY3l2dE9XT3JoWVB1TjJtVnA2?=
 =?utf-8?B?dlNQL2g0OHBzNVBoVUVmcERhckZtMWNsQ0MzMHl5Qi9WakU3bjA3bk1NRDl1?=
 =?utf-8?B?U0hSODNsSG9KeVdaSEwrbVZ5cTVRVkpWVnhDY0dlWklFZUptM016ck1iUXFr?=
 =?utf-8?B?c0RqY2JHTEJjTFhmdWhoVjhKNEJvNVlubjFiZitML09OOWNhaGJjT1hEaEp5?=
 =?utf-8?B?cWF5R1poc1ZuOW9BaFVlWVp5cUIzdEtIN0sxYzFXdExicHFaYk9jRmNOckFI?=
 =?utf-8?B?cy8rcE9WNzhvR0w2WEpoZHRVaXdiWUREZWRFMDNFaThZYmNXTWpYanFSMnJr?=
 =?utf-8?B?T3Y5NVJvMDU1aXJ6RnlCdXI1VGhacHZSdFVjNGJzR2YvVlA4dmJlTXNiaVJT?=
 =?utf-8?B?ZGRIcHBpSTNRMkFwc2VvSHNYWXNsWUp2Um56bkY5ekVGdWlDYWs5c0ZmT0h1?=
 =?utf-8?B?Ynd6UURjNGdSeFFiTXlJVklvdEZoVTc1Nzdvc09wbnk2aklBZmFnck9mREVv?=
 =?utf-8?B?eGxsLzd3RG1xcWJlUnNFMEJQMUJXVDlVaCtBQndrNS9NZXRvUUFKekdyamlk?=
 =?utf-8?B?UWhFZDRJMm1odVNKdThiTEhUdzYzUno3cWl4eXB6cDhQRG1SUWI5SkNMRkhF?=
 =?utf-8?B?ZkZINEw1akJmMWNKM0VKODVDeXZUa3dmSnd1cU5ybzd5dzByenplOUVlNGlO?=
 =?utf-8?B?QWp0V2QwbDlNWDVaTSt5VzVLaW5JSDNhU1dqajZnY3NzUHJreWVoSGdZTzBE?=
 =?utf-8?B?YTBCOU5wVzAraDhIYlJqZGpGc2w3cGRSMW0vUU9hbmRQY2VZeHFlTSttT3RN?=
 =?utf-8?B?bHBVenBza1ZKeG9kYXZDSG9Oang4VU1OQVZFM1BVVnR6N1pzSmZjWndpVllt?=
 =?utf-8?B?YU1pV0E3bGExMmdIVDVnMDV4V3ZtTGFnMkFFamZpbVY4cXRmQzZQR0dtSnQ5?=
 =?utf-8?Q?zzI2+o1Db9XvIK3/jK/HQLOCb+Mpavaj9BbQw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVdYY1JmRFZMMWQrcko1MXp0VWp5ZEF6aVVwTHZBVFkrOWpxQVh5TFNQcDNU?=
 =?utf-8?B?eHl0bEI3ajRqc1pORU1KSEFDeDBrZlJFTDN2TE5NTTNhQzYvcEpVekoyUVFP?=
 =?utf-8?B?MG1LSzNVYmhySGZnZm9MWFhOQno4NkpaUThXMVh1WWtlWUk1aW5UM0k4blRR?=
 =?utf-8?B?WWlnREhzOEp0SWtxQnFTWnR3SERlNnlWa3g4VE5hUGYvR3k2dGxPUWhjdm8w?=
 =?utf-8?B?b2hiZEFteER5d1U2VWdtNUZsSUFHOEdPQkFTSStYd3ozRU9OSzVPZmRBODVM?=
 =?utf-8?B?RVF5bmhQTTY5RmxQTDREK09CUHR2aWtuUjIwSjBHdUJ1TUI1UmJGRGorN3JI?=
 =?utf-8?B?T1V1UzVLMFgwNFVSOGZWbmp2Y1h6SHQrajVMTCs2UVh1OGp0V2VFOSs4Uk94?=
 =?utf-8?B?UFE1VWJDSDlCK3dTMVdieXlsVzM5S3Q4b0tDL0RBamRscHp5Q055M09kMkhV?=
 =?utf-8?B?YzdRZ2g4Nzl5SnJkQk40N090SjZoSjNaN2NuUzdoazFjeVg5YlVDZllXU2Ri?=
 =?utf-8?B?bnh2bHQ1OVRacm9zRWQ0Y1hXU3JiTzhnK05Ddy9DWHNEYmEzMzlIOXcxTTJz?=
 =?utf-8?B?WGIxVkNxdmJLVmVQNWZHaWY1R09JUGpKV0w3dTZIUVVVc3h6MmI5WUV1Snh6?=
 =?utf-8?B?b09hQTBuTXNZNTMwUjQyZWQ2Q2Z3bTBCOGw2Mm1xNGd6RVZZTjc0R3pMT3Zh?=
 =?utf-8?B?SUUwVU5CQWlmTHRac2xlWDZCMy91L3JsY2h6OFp3RGlYQXpKc3phSnlkYXMv?=
 =?utf-8?B?M1JCdXVsN0FITytJNW9Ya2RmL1hzMkRNOHNXTnp3KzBJSWNaTHRMWitIV2VV?=
 =?utf-8?B?S1BDbW9uWTJBZUVOdDFuQi9Db2pDQmVmRW00ZUprNGhiZ3IxN2pUR0prUDlp?=
 =?utf-8?B?V1oxNVFaVUYrZnJIbGFNc1RBZnFCR1NFeDJLNTBkeS84R1FGZ2czTVdKYUNF?=
 =?utf-8?B?Ty9kVkNLbEpVc2JLUmp0UVNieGtjQzY2dUZST1V5K3NBempldVZqMGFVTStL?=
 =?utf-8?B?MERZYmZsekhpbmZwYU1DdEQ3L3RTc2JVU211Nk5qTTZRNmtBRkh5dk9xY3c0?=
 =?utf-8?B?bE1nWUZqYzlQQzY4NjN5bXA2a05zeGNiQTd4N1NTUnhESkNHcHNvVnFJa0dw?=
 =?utf-8?B?REFmUS9BSEQxKzNpUUxuSk42d1lQZnM5ekhya3RReGVMVHVRYVM1S2RpbjJO?=
 =?utf-8?B?WHRhYzI2UERzWEN3eHBSOTR2SU92RFVYVHh2V0o1d1FmVXhuVmdxcldkWDQv?=
 =?utf-8?B?SjlPbEdmNzB3cVQ4VzlhMkc0ZjE2dStZL3NLbWxMb3NIcjMwS0hoSFZLcXRC?=
 =?utf-8?B?SmpGYjBnMEZBR21NS1QvQ1V1WUl0REx3bnlBMWlGWm10dm5jcWZBQTBVZk1z?=
 =?utf-8?B?L1pRdUFRZk1iTDB4T1FHNjF2ekYybFR6ZWM5ZGlCTW42RGFVNHNla2tROGt3?=
 =?utf-8?B?VnZoQitFY3NwNDNKcFl5MFJINlRGeE9xeWJnVHM0NHIxS0VpbGhHN3hZeFZ1?=
 =?utf-8?B?QllRekVxWVBuZzZxazZXQmpNVDN6NTFBWXBTTVVsZk9Mdlh3NE9abVlEOXpC?=
 =?utf-8?B?YUE5S3RJYjREOTFBcDBYekdRVHNlajZhSkJmSEdWM2tjU3FLSVJzNWFkb25D?=
 =?utf-8?B?V1R1N3ZnR1VtVXZ2UzlnU0NsMTMvTTBtOSt6U0FSLzErYWcxckgvcVJHR0xM?=
 =?utf-8?B?MWpCeGFyTmp1cHZrbTd0NlpneENyMXdZQlBXZXA4K1dzUnkxRk1vNXNRQitm?=
 =?utf-8?B?Rkx3ajhOUERIeDR0ZVVZRWtPZzh4NVJYZ0dsWmhmWFdpeGlzanZSaHc2SnpD?=
 =?utf-8?B?TjJQWnRQQ3BWbnU3Q2V4L0JrQWtzdG92TlRlY2tVaVA4QkJKeTA3d0ZXNlR1?=
 =?utf-8?B?KzBQM2xZQ1RwZE5zMXBRNGN6b1RBVURkTTlZZUp4V1gvWlMrYjM2dmJlZzVR?=
 =?utf-8?B?R09Lb3NFdXhOakEraVlVSGMwVE0zbiszamY3QnVkNmN6U3JldVg1YkRoTVNi?=
 =?utf-8?B?V1lMNEIzMG5wdnRHTU8zeU9ISUVXU00xeTBpQW41T2hqTVdVd0RsckIxSWxt?=
 =?utf-8?B?aVc4ckNVZHhoaCtpNGp3MTlFUE5Qa1dwVFI0NFVQNWJLcWhnNUpBb09GUkY0?=
 =?utf-8?Q?Lx+6YhCbfo0wIPXZHTVNSb4C7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81105d6-a524-4b2e-6cbf-08ddd6cb9239
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 22:33:17.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WCZB0OgDzOu6E9wnMec4pIM8R6gkJoLcRqzUKRp8VkvVn5a5/UBZ9MeFQDtJYre4aN5dA/VKm49uH1ShY3gGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 22:33:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1909

I will send v2 patch with somemore changes.

Thanks,
Sandeep

On 8/8/2025 11:58 AM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> Description of change:
> 1. Fix runqemu errors for qemu-cortex-a9 machine.
> 2. Add new inc file and update to 0.16.9 version for scathgap
> 3. Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
>     move to layer.conf
> 4. Add image artifacts to output files and use these files for qemuimage.
> 5. Add Zephyr LTS3.7.0 support for scarthgap release.
> 6. Update README files.
> 7. Add rpmsg multi services recipe for openamp.
>
> Testing:
> Run the following commands.
>
> $ MACHINE=<machine-name> bitbake zephyr-helloworld
> $ MACHINE=<machine-name> runqemu nographic
>
> Summary of changes:
>
> meta-zephyr (scarthgap):
> Sandeep Gundlupet Raju
>      zephyr-kernel: Add rpmsg multi services recipe
> Sandeep Gundlupet Raju
>      meta-zephyr: Update README files
> Sandeep Gundlupet Raju
>      zephyr-kernel: Add Zephyr LTS3.7.0 support
> Sandeep Gundlupet Raju
>      zephyr-qemuboot: Use image artifact file in qemuimage
> Sandeep Gundlupet Raju
>      zephyr-image: Add image artifacts to output files
> Sandeep Gundlupet Raju
>      layer: Set PREFERRED_VERSION for kernel and sdk
> Sandeep Gundlupet Raju
>      zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
> Sandeep Gundlupet Raju
>      zephyr-sdk: Add new inc file and update to 0.16.9 version
> Sandeep Gundlupet Raju
>      qemu-cortex-a9: Fix runqemu errors
>
>   b/README.md                                                                                                               |  163 +++--
>   b/meta-zephyr-bsp/README.md                                                                                               |    5
>   b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf                                                                        |    1
>   b/meta-zephyr-core/README.md                                                                                              |    6
>   b/meta-zephyr-core/classes/zephyr-qemuboot.bbclass                                                                        |    6
>   b/meta-zephyr-core/conf/layer.conf                                                                                        |    4
>   b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc                                                             |    3
>   b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb                                                       |    4
>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-efi-binary-generation-issue-in-cross-compila.patch |  106 +++
>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc                                                          |   28 -
>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc                                               |  274 ++++++++++
>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc                                                     |    2
>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb                                         |   23
>   meta-zephyr-bsp/README.txt                                                                                                |    1
>   meta-zephyr-core/README.txt                                                                                               |    1
>   15 files changed, 559 insertions(+), 68 deletions(-)
> ---
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1905): https://lists.yoctoproject.org/g/yocto-patches/message/1905
> Mute This Topic: https://lists.yoctoproject.org/mt/114604775/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

