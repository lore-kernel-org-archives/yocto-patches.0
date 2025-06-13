Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57462C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 12:11:21 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.13])
 by mx.groups.io with SMTP id smtpd.web10.8839.1749816676368857804
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 05:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=HJSSSCDG;
 spf=pass (domain: cherry.de, ip: 52.101.65.13, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctjOCN8qjIn8eXEwgE+b95N/ZbErEEx8ui6Laqne7zBv3Dkm4Te9fTvk1ZObIezCN38i3cxRbE151dVF4L3/dvQw/UMCdKN8vFrVGaWPMHLbQgbZwTPlp5ReV3W0zHIerMlW8T5ZHTu8G8kpLKQGrUfbO2+Y6/oDi0VJhwOlKNj0G8Pee/oMV7YxfmZ26E1R0Uxh7D1er5fdoRnfYlotsrykIshvUiNTt5xvClzcirUaliAfxODzCKICCQsNZ6jYofDBYTFrxukbYvKj8KrBbE/4YWai9coIws8RIoe4wZONi7VKKYq99LlOh2NCoVdQ/NOBsR6B9Z2miFdeiakCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4+JQrX86VpoFEy3FOVv3VA/DvgReEu7C754wEVHSqc=;
 b=lzoyTgtWpWrCmZgbqKTntR8vwqG9F5JAzOvXsysEzLBBdQyM33KnIET6zKfqhgzBLYFxZWI2autHXOdumvBqQlfMGZodplNdnE6omVLYc9V/KEuNRHa4NvE/fR/S1pEsqBzd7IwUHLd7DSl6pPmXot6VoKp0Npk2xmc1/I3vHAJMGlOfUvisibvSnzXWY8ZL9yaj/8GD7F5w5oYv3qd22yIgYTUQ+rh5al9lZuQkzw/3qfjyh8O7ovRWD7B8pSIUSB/tVPikUUmBrthHJB+8zjTScGT6ZQX8X2aB0Kr4M1r5ehc3qOELQ8SMwXlqG2griZ4VfmbaAHQIx4XREdoOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4+JQrX86VpoFEy3FOVv3VA/DvgReEu7C754wEVHSqc=;
 b=HJSSSCDGgLj74gtLZo6GlvR/VOHZDUMVeUVVHrlf18lSqZHKTtROMpy4T0QJgyWTxiN+wDZ+P//O9bIU1FuO9qKK4/zZqCjcZ7D5v4oHSKqsPO2gx6LvxioM6W9KUZhy1tMaFrhRW6lbNEGKOIzllUMVg8Jvstwrf2v2qQpLoDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8550.eurprd04.prod.outlook.com (2603:10a6:10:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 12:11:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:11:12 +0000
Message-ID: <7d7b6604-a642-49ee-97fd-181a41072b0f@cherry.de>
Date: Fri, 13 Jun 2025 14:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/2] trusted-firmware-a:
 remove no-longer-required patches
To: yocto-patches@lists.yoctoproject.org
References: <20250613102357.1539-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250613102357.1539-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO3P289CA0024.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 98450049-6784-4e67-2031-08ddaa736372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aVE2UHRibC9Ybk42c1M1V0NKRGtZc1RDeHM2MkJ1Sm4wZlFWNVdJT0gwRUl4?=
 =?utf-8?B?bllDSHdqUXdwNXJtSWt3OTJOM01VdnFGbGdSVEQyZkp1VFpOa3NqdUxOejZy?=
 =?utf-8?B?VVRHelVvcEdHSjM0Q0dyVXhnVjdQOTI3Ri9GT2RJT3RGQVpzOFY5dW1wU0ZY?=
 =?utf-8?B?RDh2TjRqSjl1ZTQyTUlsaWxoM3RNaG1Xb2E2NzRpekw1UmFPS0YzdE5RVDdR?=
 =?utf-8?B?MFFWOVdvQ3BxRXJIbis4YUprRXBDRklUN2ZqTW5RZXpvZkZyN3pLV0J6ZzlP?=
 =?utf-8?B?UnRhUEFHZ1pPUUhaRGJ5VEYzUVI3UGRQVU56SXVGL0wxRitaWEtOME13OWc2?=
 =?utf-8?B?N01oRlAwamwvQk5TQjBpWFM0eFJIMmxpcGpwZWhlOC9lbTNkNUJBWW1MSjk5?=
 =?utf-8?B?N0RKbGsxUktZVHBOaXgzbDNmS0JsL1ZELzNXMWJGQnljdFRITFdONmp2TFF1?=
 =?utf-8?B?QnFpcU0zdEI2elBONVB2Y1VjdDlOc3dlaG8yUElCbUV0d0ovVGxmT3ErVnh3?=
 =?utf-8?B?bm1UTjhRT3pqcllHSVVTM2tOWG1yZmRBajk4bkVMYWV0ODB3bkN6eWFzS245?=
 =?utf-8?B?K0xIRWJxUHBuNHVqTy9qREcvRDl4bFg3NWhBc2M5aC9GOERJaE1PNUF0a0c5?=
 =?utf-8?B?cWdKbGpLdmk3YW9JTnZRSWplZVRZYm1YOE5oZ09jRi9qMjhQNEZHYTlubktQ?=
 =?utf-8?B?ZTFFQlo4bWxTWG1YY0o1N1ZBZkJzeC81bCtldWU0TmtJRkNTYUwyandGYUJT?=
 =?utf-8?B?eDNFVFV0Z2F1bG9nN2hNZnJPTHYvS3VMSHZ1SnhUVlppMVdlYnVLQlNKQWZo?=
 =?utf-8?B?bkZtTVQ1eXhJeU5kcHlwd0UxUWgvMVk4S3VEQ3hNYXNHall5MlNSLzZQU2hQ?=
 =?utf-8?B?R1ZCSFhTeU1iL2MxTEV0Yjdja2xNVitzTk1zL3R3bW1Jc0FmWXNmVlJvVVdi?=
 =?utf-8?B?YVlucmFQd3lyc0hueTMrYkRmMzdxQ0dHNzM1allXY3NKVFBoM1ZoOWFzN25u?=
 =?utf-8?B?Ui95MkZYN2xNSGtScnZ2SFpnQUhISC9yYVBndUpqcDdacEJLaHg5N2tUOTYz?=
 =?utf-8?B?VzVyNmJQM3VUSkszeUQvT2tuMlVLRlk5VGY1U3plbjVIakczNVhKTFczbkFj?=
 =?utf-8?B?Z2xsOS9XcGRVbTFqQjRNd0tqUnRXQ3pDYXhMK2tNdWY4WTNoRW1qakdSTXhz?=
 =?utf-8?B?ZDNUbEEwZFdheEYyWWM4UEJIUUM5REFncmFZbjJVQlBMdWhQODNwOERCVnV5?=
 =?utf-8?B?K09EcEdER1JtTWwwRWdhQTBBTjRLajZiMnZTeUltN2o4ODZMenR2bnltMWNh?=
 =?utf-8?B?M0hmMU40aHZHQ3VRK2w3cjh5K0d0Wmk3WStqa2U4ZXJ3Ui9xd3lWN2RUM3Vu?=
 =?utf-8?B?WWVsYng4ZlZpZHpRRkc4bGVZVDVjSVorQ2F1Y3hQYVFSYlVlbEk4aXgvUzg2?=
 =?utf-8?B?NGhiMWtkNVdIODdVNEI5TVhKTkE5ZnRKQmsvdzRkZU1UbGpYV0xPSnJHSXRQ?=
 =?utf-8?B?ektxRE4wN3UramtJcnRNQ29UVDJiTUdVTHY3ZlU3QVpLYlNnRE1VOUNSTWxX?=
 =?utf-8?B?L3ZocFdEOHJ1NEJqQ1lXRmM5UkJzcDhpNkg0VTlodm8vS2ZkdktBUVJlQ2p6?=
 =?utf-8?B?UE5FZjMzNXVHVXN4UzRWUFB1aFRmS0hIRExKWnA3MW0wazJ4RVdIRWZYNE9r?=
 =?utf-8?B?dmlYSGlVMlJUdFkwT2ZmUHlkbFVkMEo5OWVzRXlSY09IeTNURHplTUVsVXox?=
 =?utf-8?B?bnk1Y1pVL0ZoQjEzNVpTeGZ3SnBIelowSS9MVnZxS0RBd2RrZHVkd0lHUmxv?=
 =?utf-8?B?WDNycDVLR1BmNGhUUXFYa3hVMUZ3dXM4eWVFTytVVFJlL2ZoeFNiODE4K2l1?=
 =?utf-8?B?WWsrMlJvUHFJOUlCTFhKSE0yRUlMYVM5NWtabURZU2kwSGNKQnAzYVhFSm1l?=
 =?utf-8?Q?MZs1Gux9MJE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVZJNXd1TWMyajNpWU9xOE9BQUZWZzZCdXlHakpYa0hRUE00RUxZOWFNa2Vh?=
 =?utf-8?B?b3pxSmRvTW9PL29maGNDNDljOXFRMlppSzZLbkR0aisvTVVzUHVDaTJFU1hW?=
 =?utf-8?B?UG1ROW51dms1REdyeEgxelJSOHpweGhGMTRXazB0QW5Ua09teWxJR1dmTllE?=
 =?utf-8?B?bEV5b2s0V3VQSjJka1FHR3dOeURYSFlWMTUyb2RMVSt1WWlWakwvZ01INytv?=
 =?utf-8?B?TFVRNFN3VTMyRmxjRzBpSHdxOHpQcFpCbWY4ZUlZb0FySWxXSGRvdEttT29J?=
 =?utf-8?B?M0pRM1BxOWdVdzNRT2RRdGdJZDBrb2RnVmtLbFFJZzl1UHRDd2xXL2dFVXJw?=
 =?utf-8?B?Tnp2SHF6RlRDMVJIYWpOR1ZYOFFKTzAyUlVvckpIcmxNdmR0eFZ4U0gvUW1F?=
 =?utf-8?B?bEFJMnJQZit2U0hrb000cmdDbDVvMU43eHMzTjdDMXhqOEpFVmhsMWJ4K0N5?=
 =?utf-8?B?ZUg5RmFDNDlYSTdha2VYNldLNXV0WGVpYncyenRxb0V3ZmtXNWJweTVoYnJs?=
 =?utf-8?B?MGpNL015ZE0xZllkRHNuZFdQb0lFeFg5b3NONzhnZFFWS1FXZktabUtxUkVG?=
 =?utf-8?B?QnBwYlIrTDhYSWJOR1dDRFhGU2ZnZUZFMFVoSjJteHBjZFdHV2FKbjZCcWJz?=
 =?utf-8?B?aFVUNUpGVmJ5REh3aFdIUVVrVCtsZVRFRWFNSEE2SmM5Q2pnVlhWTE1DZ1Ev?=
 =?utf-8?B?RG1zZURZcDNyZjduS3lCekhyVWI5RHZ4bDA3Skp5SmdoU3VnQmltcFZuaE8w?=
 =?utf-8?B?N25vdmVLTjRsU3REcXhlQmlvRzFBUUJWb2NRbXdTK1NkWVo4QnJCbzJ0eWgv?=
 =?utf-8?B?N0haWjAxMkNlTmlOenc5Q1ZQZXRHd2RmdTQ1Q2x0TXM2cVc3RTZFSy8wNVY4?=
 =?utf-8?B?aHpaaUhhOFozeFBnZU9uYVozbng3TmFQeS9qL1hCcjBXTU55R25sMlNySFpz?=
 =?utf-8?B?RDJRTHhDc01aWHlvdGxTZWNFS3pyTjMyeUJQWWQ2VExTaCtoN3RmMGpZd2tz?=
 =?utf-8?B?NzdYSzNTc2hZUW5GWXN4bUJsQnU4clJHTHE2dmttV0YwVEszT3FtUHNDNjNY?=
 =?utf-8?B?UkYrVTFFb2pxZWZLSjNoQk5GbWZ3UjNGRG1ia3JIRWJCMWxFenkxZkxUNFAr?=
 =?utf-8?B?bGQ1QkwwNnd2ckVRZU5ROTZvdUxTKzBrbVFpelNEV1NTZUFTeVdUenZ6eGpv?=
 =?utf-8?B?R0YycGhrcnpQbFh5RVMrVG9RRDgyazM4MzJJc2xsbW1GRGpISy85MjFIdnZX?=
 =?utf-8?B?ankwYUE5d0NpSVdxYllUNHpKNGdQT0ZLTVdmdFNtZHhrNGp6RkR1V1JJeExw?=
 =?utf-8?B?NzBlZ0tpVjVOYW56WmdUWmxtbmtjT3p6WHg4UDBxNHdEVDlPN1YxY2laMWFT?=
 =?utf-8?B?MnlUbkZwV1did25JMjd0QWhPTE9qUTVjelg1NDkwWUFrb3NjTFl1VmJ1NWZN?=
 =?utf-8?B?NXArMjlWLzlGbVIxTU5vZER5Z28xYnBwU3V6UEtUdllUZzd1MVo1M2dBNlN2?=
 =?utf-8?B?NXRtMTBkclZ3NFlNM2hWSjR3VnVrc2MydDZDaVFRNExSZ3U3aDdWcmNUTENU?=
 =?utf-8?B?dVdCb25aMmRmTmZUZXN1b0xXa0R1RHkrWVNKSit4TGV3N0hTL3hpZjhBVWdt?=
 =?utf-8?B?bC93NVRkQmNBU2tVZXpzaGFDOVJmUURqMGkwOTFxbGE4VFZ3azkybzU2bk1h?=
 =?utf-8?B?RkNvcHJYMnh3UlBSaGdyWDl4RjE0VVVrRzdJek1UMGtNVDg5aEhYN2JCSHdF?=
 =?utf-8?B?VkdJajdFYU5CVjk4QUFqOGM0Qm5jMy9heE0yZk12Ry8vOFRlV09TR29KTU5N?=
 =?utf-8?B?RmxWdS9RdGwwRjJNUDB5RGsyRVVmR2lHUzM3S1NFVHhoR1VSaVQrZ00xaEo3?=
 =?utf-8?B?cCtoL0RBclpWN1V3d1R0MkFaS3QzbVYyT0xBc1VSVUt2ZFVOaVhwcm5WZ2h4?=
 =?utf-8?B?SGNBWjR0M3BZOXc3d0oxTW41V2wyNGxodldpYk9tVUdTekE2ZUl5UG5RSUlI?=
 =?utf-8?B?a3RkSUthUTdYK0xLdjJRaDdub0xkdFgvaGZ4YURTeEFBVVRTSGpFSlNpMjFC?=
 =?utf-8?B?SmNlYm1odkJFRGtGc09xQS9NcG00T2YyR3F1T0VzMXlqcWRXeFdhbVBXOEJG?=
 =?utf-8?B?NG9LSlpYdzQ1ZGNUTVcwM0NBWkUvZHlvL3BONkUrRmdRZnFZOVdmL3lOVVpH?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 98450049-6784-4e67-2031-08ddaa736372
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:11:12.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R21IlJyif/sCjEpUi0hr+IxXWs+pF/u6F9ESroM9tVaX/bTrrRJgWFkHxtSwV3k+RVKnYmIjByneePVV/f6+tlN+jVMKsJPiORkvChgjlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8550
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 12:11:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1639

Hi Trevor,

On 6/13/25 12:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The two patches being carried in this layer for tf-a are no longer required
> and can be dropped.
> 

Better even, they were merged :)

f86c230ab02c ("fix(rk3399): dram: Fix build with gcc 11")

for the first one, part of v2.13 (but maybe will be backported to lts 
releases?)

7f25d3cc7823 ("fix(rockchip): pmu: Do not mark already defined functions 
as weak")

for the second one, part of v2.13 (but maybe will be backport to lts 
releases? watch out for Yocto branches with 2.12 release for example).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

