Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BAE6FE28
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 19:12:45 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.107078.1766517157133493528
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 11:12:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=gvEzq12O;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.23, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWcHIaGL2COOB6hbwrY88tu3bb3QJcqoXS9YxmRUfY/ZWkgp99/ANlzAd7kNdDMOPIqmA3eLXUc199ayoV1Hl9//h5tXT+7zMFddl2NRiRFz0Y4uuWuwKxJ4i8MDPx88dKFicCkrFWe/U9vq4PZ2/MCxHvSe7dvxXk5zSNIlGUXCUcoybYE3os01qJ9bJuibsFFPzLKm3W6dP83m4Mq92jaszOBEU1DG6g42InPuNYBzF2ekRPtLJnYmqZIx/sYnnpGq9Q4aAqEhDee8neZ/jlEEX+XDFz/dlN1G8ql6jzL3J2dqxG+H2HSjig6NFbx3r7UbAsO0XyNZXcH6tzTCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDHhK9n1KHIG6BD44iPHl/X0kZSNFhWnmSdxi2lUEGM=;
 b=wFeuUbfi1gI+EkMSe+Gi9ak6J2ThEGRrq96ucwpjfzh909qrMp1tNyWXjy0vevqIFU3pyAVfA/qV9xAeNfsp87TtxXM6h1NOlHHLvAINumnZKssE0H8JjttaFW9ydQxQcpfEK8vJw7f6F3f+rDhMQEwsQUlWUQTqUmPKeN8YjQZIv1T8v63uSkPYFTasElXpvXkjcGi3cnewq/EVPzfRNtw0VTXPc21NhJuS2YDMFucQgjoUOkeo3BfgeP0UvhliFKvwA3PEkDc/uOpORL1BO8928LyVGv5XX2QhPwpzyCgM4Dv8tR9W36f6G5+rpi4PyL9JjpouiJ++dHH/+T5bSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDHhK9n1KHIG6BD44iPHl/X0kZSNFhWnmSdxi2lUEGM=;
 b=gvEzq12OiCG+VBQHxUM0UGNPFV3GZc6Cpf26QbFHNpCzoImMC4is0QDaNbGzfPehfAogBt0ZgnVNb2omxpIJSdAXM6RU8IrhyXbA6egF4t6uxz7/KJVnkH8JQd/2ajK9JCrTrysXVDMmnxUhOJrVqNS86Mr5eQaHmRBIRNtjNXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 19:12:34 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68%3]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 19:12:33 +0000
Message-ID: <a813fc85-9309-4c82-895b-5fb6f8eb8022@amd.com>
Date: Tue, 23 Dec 2025 12:12:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][PATCH] README: drop reference to
 poky
To: yocto-patches@lists.yoctoproject.org,
 Lee Chee Yang <chee.yang.lee@intel.com>
References: <20251206070923.2254134-1-chee.yang.lee@intel.com>
 <CANNYZj8i7_nR1x+eAt_zXmiYvTvRRNV96YjADJBE87ZDkNSkuw@mail.gmail.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <CANNYZj8i7_nR1x+eAt_zXmiYvTvRRNV96YjADJBE87ZDkNSkuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:930:17::32) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4ea2f3-ded2-4582-07b2-08de42573a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SzRGY3dSVVo1WGx2UTZyL0dIMDA5bzZTN0hWLzF3WGNNYlQwT0syUEhXRGlp?=
 =?utf-8?B?dkNXeVhaV1JUN29WTnVRTWJzdzlyMTI3U1lrUSt4ZllmU0xLTVpmQUJBaDR2?=
 =?utf-8?B?SjN5T0tzb0VaalBHSHNxdzJXdHBBa1FuS29qYTQwQmlpaE9vTnhWalNxcVlL?=
 =?utf-8?B?VXNjUFQ3LzdKQ1hlY0F3bURKWTlqM0ZwWmJ0TUdpbXdHTy9oNFI2ZWhGYTNS?=
 =?utf-8?B?TW83c0dpZnFtWDdGK2lTZW9XQVVLbGc1T0RNdWxjL2hVTVlDWnpvMjNQbmZU?=
 =?utf-8?B?WlZrL250Zk5pVk8vMTh4bWo0V3JpaHE5eE5OTTFSS25rK2c5SStlbFhLOTYr?=
 =?utf-8?B?ODhkRDBFOHNBSFdVUHR4YktCSUw5WXhqaHdsWi9xTC9mTzU0bWd1VzJKZVNr?=
 =?utf-8?B?cTRZVlJaZHE4TzQ2dFlFSTVSVnVMa2dmTzgrd2dDaml4MVVCRktBYjRKdXFC?=
 =?utf-8?B?UGExWVM4Q25XNzVoZG13cUtFUjFYNzZnSWFwdW03dVMxOEpBWTVRM3M0aTNz?=
 =?utf-8?B?MlJoQ0V5VFQyN0swYmhFL1J6S1FFYjdJZkZHR1VLL3lrV1VuOFhEZCtvRGpT?=
 =?utf-8?B?bzR4R0cwMTRlRUdrYjJxdENkNi81cUVLV1NYaFExaVRpRi9YKzRCbVRnbm9T?=
 =?utf-8?B?V1ZybU5tN2hmTWtyd1BBZ3ZiZXNocnM3M3BlbVdhcjdxaFhaaUoyQ05SbkZ2?=
 =?utf-8?B?N05YV2d0R0dDeWNRakFVWmRpV1FlYkR3aWszYSt1M3NGOVlkNE9XbHVKdGtv?=
 =?utf-8?B?Y2xheDlQa2l4d0hRWFdDb2M4SnNCOTZ2eVc2bFFrZXYrTjNlbXkvbUVzTFNY?=
 =?utf-8?B?YkJWYzh1RWZwaGhxbEQxd0dkazJqd3pKWnZIT1hwaGpBSFhCaFBaWEd1cGd3?=
 =?utf-8?B?TE9jNVZpTjNoeWpqWFBoS1g0VExYUGpRdmh4SjJtR3QrRFBIejQ0Y21yc1FT?=
 =?utf-8?B?L2xBMm1ZSUYzMlY5QTgvZkYyMHlTT1hLRENRT3FiTGJHTmVaSy9BZWt1NVVa?=
 =?utf-8?B?ckxxT0lSMDdIWm9NdUw1Z2Y4V0xlZHFzNndoaFREUlAxL3lqV3kxSFYzb3hY?=
 =?utf-8?B?MU9FaXptMEFxN2V3NG9BdmZWSlNwYlZzZmxUWnF1cXYzeXNjZlBDTk9iWThS?=
 =?utf-8?B?TmczVTRDOFlMSlBFTmoyTTlSc1dUUkZ1QVg5anlna0hWZzR0S3ZLT2ZrRnNF?=
 =?utf-8?B?ZStuM3RMSUJQODNlbExLbnoveUd3dHl2SHdrcTV2bU9qekcyeGF2a2FzT0Zq?=
 =?utf-8?B?TU9WRyt4MmtDam1UNjRVNGk5NUY0cjVUcEhjQ1pFRnBoaDFMdVFibkNEQUc2?=
 =?utf-8?B?NFBSOU5jOUNxaTFWUGNGWXA4b1JQZVZvTVVxRUhZTVdmRms0a2FlNHJKaVRM?=
 =?utf-8?B?Nm9WaFpzR2VRcXpHSEJNaUZOQ1BJOFNPckNxMzc0cmlsOHltcGJMWEdaSnow?=
 =?utf-8?B?RGRzbENXYW9pbVo3S3V5T0EwQlJ5d2RPQUdaSmI1RnhyNmVIQ2JLc2ppWXRX?=
 =?utf-8?B?VTF4NytaR3c3YmUzVjFZd0dGR3BmemZpUzA2Tk9veGhJRHI2SnJnZTAzQVpF?=
 =?utf-8?B?QzdOTi81M1NCczVsZEJPZDFObkVkMExrVkt4dGhlQjU5ZFllbjZObHpqUFFH?=
 =?utf-8?B?dnkxR3Voa2NxY0NxOHdtZDdZaEd5YUZ6d1pZY3duOEtCVVFUVXcwYmlnVEVC?=
 =?utf-8?B?UVFISERDdldGRTMvZ3Vub0NLdzFrd2dQajBhZFRtSFR0WW1ST0dnb0d5bTRp?=
 =?utf-8?B?V2Fwc2t2VWZ1cWx5b2tmaHZTOHhRZHNLQ25BWUZiSVFqbXIyUVpXek1XaVR1?=
 =?utf-8?B?UHZ3VUEvdWVqczhBTUErL2krbFhkcVVWTWpQZkFwTFFhZTdmb3pEcUVERmVl?=
 =?utf-8?B?Lzd5MUkxdDRjc05YeGNvTGxLOG1CY3dVdVZWNDM2RlhOOHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1ZKYlhUS29IejdEd2xWVEEzU3RoQm0xYlYrVmorazJ4Kzd3U1lkU2RDRlZ5?=
 =?utf-8?B?Mi9wUTRvVVRCRWZyR1h6bks2dkl3THhDQTI5N1M0dkVKNDVzOWtuYS9GL1Yv?=
 =?utf-8?B?ZGxHMGY2SkU4TVlENmpxalhoN1ZFcDVkR095Zi9lRFVxaTgzeUVRdVI4ajVa?=
 =?utf-8?B?WW5zSDNNWW1rYVR0M2pxTm1NQXEyN0Y4akV0bHVUU2gxM0VyOThUR0NhK1E3?=
 =?utf-8?B?NUM3bW16bGs1TGJPU3RyUzdxb0graEdVY1F5clFrK2oza3ZveExjWnl4SHNT?=
 =?utf-8?B?cFQveVNSUkhhLzhvMXg2NnRjVGNCMmcyaVo2Z3oreDJqS2hQaHhjYTBHc1k5?=
 =?utf-8?B?b0FWeE13d25XM2NyaWVXcEpTZ1pmc3pzN3BkczVVcTZEZDI5eVlrS1ZlbTZs?=
 =?utf-8?B?NjNWNzhEbVRvYmFvaHhYQ3JJdEN5VTVkWGxlbURick9nTnRkZjlsSHdFNy9j?=
 =?utf-8?B?RktrVHdmZFRCcUJXdjU5OFNGWHZVdFRBSGxSdlMyWTBGMG0vWk16VmNUZ3py?=
 =?utf-8?B?bXJSb2dCNXJMWVdCejFoVVBocnBCTi8xNTZHUHJSa3kvYkJKOHJNTWpiVGlC?=
 =?utf-8?B?NDdhZDdjS0U0emUrTG5KRGFVSmpVYzRMck5vTGo4TkYrZ0xZNHBhR1NBbU01?=
 =?utf-8?B?cldrWEp6OHEva2Y4Tmlna2xVSllpVlEycXM1U3NURjc0U2dPSGhBeVpjS3VC?=
 =?utf-8?B?MG5ONTBBaHVGYW5YbTBIcU55K2wwUEVXMlhMZlhibms2MUNLaERmYWJ1NFAw?=
 =?utf-8?B?SzRyNkJQdlRPNkE2YVBYVzAvdTRXKys4Z3U0RCtQdi9nWkxvZmdzNGRoZldR?=
 =?utf-8?B?T0xnVlhmN2tIWjdWSXFmZnY5TWFQMEN2ZDlWdjJuQ3AzeEV6dWpJQUVWVW9u?=
 =?utf-8?B?MWJFSjYwVjJJU2dYKzJmUkpPK2t3WVM2dWZHUXBudlZUaUtweVFtdXVtbm54?=
 =?utf-8?B?MFlZdHlKQ0xReFdGTVUwYk1yR1RnTG9tY21aTksxZGFHenVOd2lOaXhWV2c4?=
 =?utf-8?B?c0s2UHNEZEJEdk91SmRHOVJrcklIdXNnenB6cjEzNEoxN3B3K2ZuRmdNSFZ2?=
 =?utf-8?B?dHRnSkx0ZTdhZ0tRbXYxTEJNd3hGZkdNSGU3U1A0a2JpdUJ0ampFaXdFamI4?=
 =?utf-8?B?OXJ2eXl5NTk5SE04MDRLUHVxM3lrcUgrcVhra3JRNDBEdFBSa1A0UEt5ekpr?=
 =?utf-8?B?ZUMyTjRZVFZzajBKNmFSV3R6UFY0ektGUVUvK3FWUkxUb2NaV1ZEMlY5Sysw?=
 =?utf-8?B?eVRrU29wTXhtMVVMeWpPSFFkYmVEVkEyMDU1bTFKck1HRHQwZC9VTlZkYXJC?=
 =?utf-8?B?MnZMMkZ1Q3FweDdMMU9oNmFSc1o3Wmh4SFVhWlM5NkxYYWtLeXZ5NnRHeUhM?=
 =?utf-8?B?VjFnRkMzSlo2cUQ1MU1DVlBsa0NZWUJUWVdmRlpLa2w3QklwSGZQNFF2L1U3?=
 =?utf-8?B?a1FINXR2c1h0enpOV2FTWVpLWmVPS01DbjNBVjRVWnpFTHY3d0d5cy80S2Zk?=
 =?utf-8?B?MXRlUENuNktzdkNhNUUxdlpvZlM5RXRlV2JDSlNkcGFXVkVDaHdoeHNxYWlH?=
 =?utf-8?B?b1BNS3NGNGQrL3V0RlZaV3BUbkJkbU5XQ0Qwa3BkazRvUEM1a0lUQlBORFly?=
 =?utf-8?B?NHV5VTdhYndaZnZjUGlaVitodkNQcWIwdjhuS1JmM1o5YWoydkkxWWlvbXhO?=
 =?utf-8?B?NFlTVW15K0lGZVBzMFgzbXQ3VUl5V1lCR1ROenJrZVEzUTV1cjdkWHlOYS8y?=
 =?utf-8?B?SzNreEFIeEI1YThUd29yOXg3bitwS01hYVVsVVJHOUFKbHZOL21sTU9LMm40?=
 =?utf-8?B?QnlZNm5UZURudThjSytLTEdFeXo4c3grSWRHTVZBYjA4bXNBR2Fjb21oODB4?=
 =?utf-8?B?cm1rMEsyQ0ZoS3luQkdXQU9WWWdVZEFxcTJHK1RlSUlaUnhlZ1dpcXp2MGZV?=
 =?utf-8?B?Y0s5UFpMNnNpK29wNlBjUnJjWlpkRGtyUjZzYzExSXIrWXVUV2VNdVhDa0JY?=
 =?utf-8?B?a2JkQWdGRnBDMUwvSi9XbVdYaGZpak5zdEJjSDQ5MysxM0lGYldOTEphcUx4?=
 =?utf-8?B?UmNCeWxrTFpvSXJoeVYyaWU0aUxoOXI4V3dVRVpLa3l0WjgzbGtkb2h2S2ZC?=
 =?utf-8?B?MnljVktiZmh0bnllek5Qc0tGbW5JZkdHOVBWeFphQWlaNU11alNzZ3lDdmtB?=
 =?utf-8?B?Q1hBa3BuV2xNWnRkRDZmUkJkUG9vOExlckdjZVRENDlSUEZqRDdEazNLS1g4?=
 =?utf-8?B?MTlKUzNQQ1VaV1dtSEhIKzU4cE90RkRFakRJOTZzaUxHUUsrd1d4UGtsUmFZ?=
 =?utf-8?B?aFNXQ1loci9mQ2s0RlhYK0NzamtDc05zdFdNS2xvMTJSSXd1RVZDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ea2f3-ded2-4582-07b2-08de42573a10
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 19:12:33.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfIlJhAE7GPAm+VKY08KuquTYhUM0FQcn0FQtteSOGdw3QjlHRbP7rF8CRMZYDSKwz5ro/XD4+QuomQVZfMA/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 19:12:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2864


On 12/6/2025 1:34 AM, Alexander Kanavin via lists.yoctoproject.org wrote:
> On Sat, 6 Dec 2025 at 09:20, Lee Chee Yang via lists.yoctoproject.org
> <chee.yang.lee=intel.com@lists.yoctoproject.org> wrote:
>> @@ -23,17 +26,19 @@ https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
>>   > **Pre-requisites:**
>>   1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/singleindex.html#yocto-project-quick-build) documentation.
>>
>> -2. Clone and add following layers to BBLAYERS
>> +2. Clone required repo, refer to [Yocto Release](https://wiki.yoctoproject.org/wiki/Releases) for compatible branch name and bitbake branch.
>> +    * bitbake
>> +    * openembedded-core
>>       * meta-openembedded/meta-oe
>>       * meta-openembedded/meta-python
>>       * meta-zephyr-core
>>       * meta-zephyr-bsp
>>   ```
>> -    $ mkdir sources
>> -    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
>> +    $ git clone -b <bitbake-branch> https://git.openembedded.org/bitbake
>> +    $ git clone -b <branch-name> https://git.openembedded.org/openembedded-core
>>       $ git clone -b <branch-name> https://git.openembedded.org/meta-openembedded
>>       $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
>> -    $ source poky/oe-init-build-env
>> +    $ source openembedded-core/oe-init-build-env
>>       $ bitbake-layers add-layer ../meta-openembedded/meta-oe
>>       $ bitbake-layers add-layer ../meta-openembedded/meta-python
>>       $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core
> This looks like a nice opportunity to add a bitbake-setup config into
> meta-zephyr that would do these with a single command :)
[Sandeep]: Alex, I'm having hard time to use bitbake-setup, does 
bitbake-setup will clone and include dependency layers? For example 
meta-zephyr-core depends on meta-python (depends)-> meta-oe. If so we 
can simplify the instructions.
>
> Alex
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2748): https://lists.yoctoproject.org/g/yocto-patches/message/2748
> Mute This Topic: https://lists.yoctoproject.org/mt/116642940/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

