Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1390CCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 05:12:35 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10647.1762837953693960141
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 21:12:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=SC784SXb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3410a7eecb=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AANtgNx2980586;
	Mon, 10 Nov 2025 21:12:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=/Zx83nWdF9GvWhvchyAftF
	0oe8nbRNttQY/TVCgaYUs=; b=SC784SXbR5dqmh6+vhz2g1Lv47LZ9qavDDYH8j
	mipqFwuxLBwGbtjj4655Oule6uBG4DFmBRKXb5lVp5PhP72y2ihOYN/ELTwyRmSF
	ke74VX5ozalOw4/tSoFa6WokgriBPOmzhiB1yin0sfcya1NcQBaDZmJ+CwMj4IhC
	XfNizEY49zfNPAKZyJitf10kTfskQUVdF/0XoyzP9WOxAoGG7bm1oyrVVJFmbKF+
	Ow9NBiyzrzxHrtP2SMJ5ywMKeEEwesgZQNsGcVemTfjEd6QBM947oJPqJpBdRizv
	eB7qHNZEwbcxLKF8Fafqw3MYsd9C/m+k3OtvIaMAmp2TW5yg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa2132nqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 21:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVAT0ln53CPC3wNs7rFOVGd3c/l+CVi/1oPDgtKVSTrjmej7AggtNOzHAp1lGS9s7PYAdd5ROda8Eu39ge20I6N89Fy70pytzmdeX0/YVxcOYkD9hmXQ6l09Janr3evrQ0mV2qBva5aOa8oZNPoLVEn9xqqYwUCJuriTV320qPuWxEySqOuzlWPDAdhQJ2IHeweNpZ2SJsTvUpUcg2ZO8h74TSEUGt7b6UWz2T1o1zkomNSm1ypzrwKm77MdLMAWuOzAm2mQc7hWmkW/3n70lu+PdAf8sHxX8DqQiamWyyqSdkxjBInYz5QONpDHt7Qqs3LOMlvqT1Z+QBh6OWdsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zx83nWdF9GvWhvchyAftF0oe8nbRNttQY/TVCgaYUs=;
 b=b+Hx75H6UosSAJfHxxUv64tr50yuWBtvvmrk3tXPzk/M8HDVkGDeO9l7kdgfR3UpNDNpQ2vGH4rJHC9n7hH3RhHYpHWo13xTH9rRmCYfKRSjgwCk8TgXrG2kT88ufcjEDGElZgWZL8z1w/YmMZls7xxt28BnfAxPUWuDvGV6jpuVLUq8ReRvm82sdnRfbuE9NZM/JCrvF6fKPZbyJaS99bTQKu7osOAUwLFLcHQ+jSb7pLJloA0ISaOWfnPIj0jOcQEhH1aEIf53UB5nL5xYhSOD+Oi0XO7WX51xgcCwv/CW3x6RGLoDKuE64lfHq2nd+QiMHM/Nv0+UkIkMsGHSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by PH7PR11MB8036.namprd11.prod.outlook.com (2603:10b6:510:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:12:29 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:12:29 +0000
Content-Type: multipart/alternative;
 boundary="------------zgSvlWdq6GPeMOAP75Xc6w8Q"
Message-ID: <ccbe42a3-258d-4187-89d7-59fbb79a6389@windriver.com>
Date: Tue, 11 Nov 2025 13:12:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-mingw][PATCH] mingw-libgnurx: use
 -std=gnu17 for compilation
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
References: <186EDBD71C15CC68.8420@lists.yoctoproject.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <186EDBD71C15CC68.8420@lists.yoctoproject.org>
X-ClientProxiedBy: ME0PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:220:210::18) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|PH7PR11MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0337bb-b8c1-404d-497a-08de20e0e8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDhVcm9zOS9kRlhMTVVjQmM1UzNNSFUxb3g4Q3NiNGs5MGxGc1JuUEs2WGh6?=
 =?utf-8?B?QTQzd1RRMkNPYXJnTUl1OFh1YjlMdld0NEJCNlJ1NDBmaXZjZ1hiRVIwK20v?=
 =?utf-8?B?SnQ0ejk3NUZnVnBQUnJidFZvODNhYkk5VXVrTkhxS0dRR1JkamdvbVJzVmhH?=
 =?utf-8?B?UzltUzNuUW5mNzVsaS9hWkQ4RGZUQmp1T0Y1SnYrZVNzSUFSOGJCMWx4TCt3?=
 =?utf-8?B?eTFpVU9IZnRKeEE1b2tVODVWRmxhM2wvbFkrMHVMNnJ1MlNIRU9pcHlHSDd1?=
 =?utf-8?B?ZWtpR0xndGN2VVpEY2l1YndiTVF2ZE9OZ3FlMXJBKyt5dTZnK1gvRjY1QUkx?=
 =?utf-8?B?TDk5azNUN1dPSnVQN1BBMUdZZ2dXWTI4SWwyVUt5T3poQW1iQkFtbGVzVE4y?=
 =?utf-8?B?cjBLZHBHdm5STE1TSmdNTVIyR1I5SllhOUZVY1RmRGM0WnJkOEYrMWtobG9r?=
 =?utf-8?B?RXNkS3JlWXdsTjJaMnVaQVNOQ1FSeDJtVlZwU1pOVGxSajcxZUx3TUtDMVF5?=
 =?utf-8?B?aGt2OVIrcUt1ZUZVSnd2bUZaSWQ1U3B3WHhuU0ExU01udmhCUFZJMUFXUmJD?=
 =?utf-8?B?UHZlQU1JQzRZOUl4S0JEL1oxUXZJNnpaUGF6aE5RLzlxaTB4dENLbFRnWVJQ?=
 =?utf-8?B?K1M4V2JaN29jR2lxUU0xblljUFNaZk9mbW1RcUFJaGZLUWZxamJGVWRpemRo?=
 =?utf-8?B?ZE9LZlFQTmhOUmgxL3pxQ0tuTFJlNUFoTTdiTVJrcE9TcjRZczJReE9vNmFt?=
 =?utf-8?B?eVI1NzdVYThCN1NNeno2dU90Q0NXQjNKTG43ZTR4cUh0S1VJeFM5NWVuakl6?=
 =?utf-8?B?VkJIanJIWkRwVHlxYWJBR21rMjFwKzN6OHg3WW5RVThZZkxWR1RtY014SjFa?=
 =?utf-8?B?UXNVZ255Y2ZSV3k5RktiZ3hubWNYQWd4c1VPYWNwczMyOHNNNlZ4Wm10ZjNY?=
 =?utf-8?B?a3B5bmNCMFlxVmNRcmlZS0RKNHpWeUcwWGVUUWxWT3lJTXBBUGRva2huSk5T?=
 =?utf-8?B?YVZOVXdlK0xQRytqV3FPaXZ5cmljSE5vRTZuWFlXeVd3UXRWOE0wTU5JT0RR?=
 =?utf-8?B?RmdjSnU5dElRY0tUQjVGQ0RGVG9aclNueWNkUFBoZUtHZnFvNnFhMXZoQ01i?=
 =?utf-8?B?bXllT0NuTkNrOXUvUzlmZ2RaTmZuUllUM0s2RG4vajFOSUZoTUQ1OVFxNitG?=
 =?utf-8?B?djllSDBWd1Qrd3ZzRlVlT1lNQWl2T3MxSGh0Ykd4TGt2ZVVhaXBycXpRbG15?=
 =?utf-8?B?NktIc2pXNytpSnlZUUo0M2NXR1JHcVd5KzRyMkRVYkZwU3FTbC9YUmJ5eWRU?=
 =?utf-8?B?SWc4bGxhTGthVk11Z0hiT3VIUkpmUGxER3hBWkpOQlBTbTgxenhHUEw1SDI2?=
 =?utf-8?B?ditrMDZsbXRKdUw2NHVVbTEzWVpTY1J6enV5NXYxYk1aOEtndjFuTmExbjlU?=
 =?utf-8?B?SVBzMGgyT1hlWGlUYlRIbXVITDBTL25hNFpUZXdrRFZRNVBlMllLdk9DMXNT?=
 =?utf-8?B?QVNMeFU1dVVDS2hwRms1VURGdmdZNUNTVHgyb1R3V0JBVWU0RUxUdmgzUHdZ?=
 =?utf-8?B?aFA0S0NhQ0tzU0xidzk3MTYwOFA5c2xvUVduT3Y5dUtZaE5PZ2tMMGk5cmJE?=
 =?utf-8?B?b2t2dEZoUjUzZldxWGliSjFnRVA1YldmZUUzL0pCQUw5YzhnNFlpTEp1c09y?=
 =?utf-8?B?SVNUTXViaDJHdjJCV3JiMUdEZnBEOS95TFl4OXJFSGlMQnBzVFdYSjc1WjRw?=
 =?utf-8?B?K2xJaEIydWJmZUZmN2dTa2JKWFk5RXVYLzdFbkVLTjkweXhjU0hxU3owcEFD?=
 =?utf-8?B?YkNTYkh1eDVOZG5GK1F1STdKZHJLUGkwOFgxM2RBTDEyQm9mdDRkczJCcEs2?=
 =?utf-8?B?Z29jYytJVjFUT3BMTDh2U3NyRHp3UGMzb09ZL0R4a1RHWVVmNVpsU253OG8w?=
 =?utf-8?Q?cv+M6F4QFeewrtVHJS/mXvMnCUYr8UOl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ti9BRkVaU0JZYklIdkNMblYwaXFMRVFrTHlXMkVQUUcyWS9DZTFWRVROdDZ4?=
 =?utf-8?B?OFZhcTRzWjFKd2FJa0V5TXNRcWpoRVlieVlvMzY5UGNVM1RYVVpPclFTUGZS?=
 =?utf-8?B?SC9kbWNOYy9qOVhsRnluYVIvb29oVmZMWmRtV0p0dEMwV2FZblh4MkFVMkNN?=
 =?utf-8?B?dHR0cHhPRHl5dEIxUlZJazBPdzQrR3RiOXF0Vjd0R25SOWJ5THJUSjFxQlpH?=
 =?utf-8?B?SXhaWnMwaHZoTU5HUWNzeEwvQk5VVSsvQ0JtZTBrVnFWeVpzLzBMSVAwVVVB?=
 =?utf-8?B?cHV0WjNoYmNvSVpramNuWVlaMEdwelRtVGV2SHlDckxuSHpXY0hubmowcnh4?=
 =?utf-8?B?alB2M05LYjdIYzNUOEZSTisrWllpUGhyTDhrMjY3N2N3N2JpUzhCNEtiQ3Fn?=
 =?utf-8?B?UjhxOXdVY0dZeWxSalRqaWJTWHFGdFRwTkxzY3dFcDRuUElOSVZDZlFPRE5r?=
 =?utf-8?B?dWZ2eFNiTFgzUENFSzJRQThSTVltQXlDbXFjYnl5dkZNK2RMYWd5LzVrWlpK?=
 =?utf-8?B?a2FDek9TNncrZ3JlajNLWkpDdDdmMWtlRlBCY0wrT2d0V0JQTm1ETU5EUGV1?=
 =?utf-8?B?QkZTYTdubHJyMlVYYjQ2WTNScEU4NWgyWnZRRWE0YkxQUXM3ejRlMGt0RFEv?=
 =?utf-8?B?Qms5cHZnRUg0L1VPK00vM240OWRhRG4wbVJxRGtBbDJYUDM4eDFXWFdCT0py?=
 =?utf-8?B?VnkyOWtyUUNnTGYxL0g4TmpHTW9vN0NxbVlDbldPYWhWMjRrem0vSlNKSkhD?=
 =?utf-8?B?eHZrRHl1S0dBV1FHODVqdStyTXF6RkUraXJpcnpDWjlCUlhuNFp4UUE5THdU?=
 =?utf-8?B?MXFZQ1lTeEtwdCtoQ1p3aVBub2pxYUk3QnBWaXVnekFEdlorSFc3UGxBdVhu?=
 =?utf-8?B?NTZJY292bTlwRDNJY084ejJhOVNOcmE3aFRMdTI3ZENnQmxiTTkwdUpScHkv?=
 =?utf-8?B?a3lOU2xEOEN1LzBXMTFONzQvTWtndHREZ0o0bXJuZ1NaTmxlME10V1ZEV0Yr?=
 =?utf-8?B?ays0ZWNkRjZFS1kvMUM4a3hrdTFSSHAvNE9Xc1hOSVhCcnZBQ1YvSWlLc0Zq?=
 =?utf-8?B?UTJzREg2VXVrNGowYXhJU1A1bHlqeUhCVWw3VFBzUzFnZGVYUjFJSjBRdlE1?=
 =?utf-8?B?RUFoUDY1bnZxQVJxcUt1c0lTUjNLcVhqaGl2RDM5MGQ0Z0RnaEEveTFNVVZF?=
 =?utf-8?B?dkRpVW9RcWNCOUVkQkkyYkp2anZWTG1oNVdBR3gxcUgxMzNzcDlkSUdLR2x1?=
 =?utf-8?B?VnJ1SmQweGJDWVBXdGRhTURZRmNtNHBKT2VhS250VHN1ZW5QZkNvZ09SSWVX?=
 =?utf-8?B?SzVFQ1ZVL0dOMzNLSitRQ0oxOHB5eUhaU3JORXBHbmxjc3cvUzU2UDNTdGx1?=
 =?utf-8?B?eHJQaEFXZFNYUU01azdFWFhRMEliTmQveSt4b3BMYmpKZktodDgzTnZxdjZL?=
 =?utf-8?B?OVo3cktUSUxHOUtneVM2RjU2ZkRRL0N0aWpHRmNwK2pBamduYzZSaWo5czNo?=
 =?utf-8?B?YUJld091am1JcWlPei90UWN3UTBDSWZyMm1uWUNoZlo5M0JRdWdIZm9KNFkz?=
 =?utf-8?B?QlFDU2xvKzRGVWJOei9uS25CQUZpL3JjRFFoSytOMStrZUgxS3dnQURCZzQ1?=
 =?utf-8?B?b29wb1RjekZBallDNjRuOWI1WmJGc3B5MTc3QmYycEx6TUkwUWR5MzlKaWZq?=
 =?utf-8?B?b1pIaGxaUllJS09SdmVCMzdqM28vcXo2NjMxQXkzd1lYR2FzNVV5aWJkK2ZH?=
 =?utf-8?B?UGR6Z0V6cGJxMFdkaFcxTi9qTUllSEUyQ2tSaEgvWGlhNWFGZUlReHUyOW9T?=
 =?utf-8?B?YUEvbGFScXpUeU9EOTIwWm9UYXk5SldCaHRRM2R4anRiN1RVTkNPK3NlYmhP?=
 =?utf-8?B?K0MzNE91cEhNUXVPVUtzeTlPLytaS3ZUbFRXSkZjNzdGb2tCaDFxRkpReVpa?=
 =?utf-8?B?OXRrTm9MN1RmK0VMbUc2ejZYb2cvdVcybUZCMm5QZnBON25vd2tvZis1dFdt?=
 =?utf-8?B?TFlqOUo4ay9CSXZia0orZktEYk9aeU1KbFVsLzkwcjd0cENvWjNrcldjcjN2?=
 =?utf-8?B?QU1PeGRkTGFLKzIycEs5bjFTNXZSektZWlhycndIbW51aCtYL0tHVjZqUmVi?=
 =?utf-8?B?cmlWSUVOd0dSeDBoM2RJTHhEaGw2bmVoV2IxV0Jpb0tsNjVBNUFTTnh6MjU5?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0337bb-b8c1-404d-497a-08de20e0e8d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:12:28.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uS0bsDNvG49D4yYUn64bRKgQ4JJqJDG7co04bEiWzLTe+pC97npV98IONVymv1gSZ3IKTSUtI7DjHEm+mdGbzPC5bdFBcmCP0gfIZISXLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8036
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAzNyBTYWx0ZWRfX1jV1dfqWPghJ
 puBhQeFQF9ffqNpwEqiDqgzTW9dIPBM7FL+W6BjlHJ8vp9LcfeuGPtEDQDMuxsUUlARyPHaK5+G
 xEAzzhV9qZyM1VXw8MZUB/Y5vyhHYIWFjd9mknn6j8zxI0MIf2NgayOYAXnSsAJsFm8CuIYBuMG
 LY93GQG8YgQw0R1/jIt0YswEeoadIt852P3yqrsR8lTzIRb2B3jLnrkvcGwuKgqtCF0E4kFZK33
 TT4hPr8ZqIqw26B2EUpPmQ8wtzutJEVej25rK5sO/w5/grjPkAqm1ZLzfg4/Q31tdkkpbvY1Rcr
 0dpGE7A+MPPQ4upD1Lgsp8iadPWE7sLTlJUvSTGMXj5S6tYjax76YdTd63V1pKOqyAuP/8Kvepl
 GgCqDBoBkk7SNHbA6VhV1YJ8mn6+kw==
X-Proofpoint-ORIG-GUID: 6NUmTFm91N0_AqnydgNh2D8VrkRXgiSc
X-Authority-Analysis: v=2.4 cv=XPA9iAhE c=1 sm=1 tr=0 ts=6912c5c0 cx=c_pps
 a=MNM/txilNqeExyaWs+jKwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=6Phglice-Fg7C_GUVV0A:9
 a=QEXdDO2ut3YA:10 a=f0gDK3h1-Z0A:10 a=lEUqEydeLye-kQrhWRAA:9
 a=idYsmF8GwmnoGUmr:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6NUmTFm91N0_AqnydgNh2D8VrkRXgiSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110037
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 05:12:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2480

--------------zgSvlWdq6GPeMOAP75Xc6w8Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping

On 10/16/25 11:43, Changqing Li via lists.yoctoproject.org wrote:
> From: Changqing Li<changqing.li@windriver.com>
>
> mingw-libgnurx does not build under -std=gnu23 which is the default of
> gcc15. Forcing -std=gnu17 fixes these build errors:
>      In file included from ../sources/mingw-libgnurx-2.5.1/regex.c:61:
> ../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: error: cannot use keyword 'false' as enumeration constant
>     49 | typedef enum { false, true } bool;
>        |                ^~~~~
> ../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: note: 'false' is a keyword with '-std=c23' onwards
> ../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:30: error: expected ';', identifier or '(' before 'bool'
>     49 | typedef enum { false, true } bool;
>        |                              ^~~~
>
> [1]https://gcc.gnu.org/gcc-15/changes.html
>
> Signed-off-by: Changqing Li<changqing.li@windriver.com>
> ---
>   recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
> index 4547298..03a61a7 100644
> --- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
> +++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
> @@ -11,6 +11,8 @@ SRC_URI[sha256sum] = "7147b7f806ec3d007843b38e19f42a5b7c65894a57ffc297a76b0dcd5f
>   
>   inherit autotools
>   
> +CFLAGS += "-std=gnu17"
> +
>   # Specify any options you want to pass to the configure script using EXTRA_OECONF:
>   EXTRA_OECONF = ""
>   
--------------zgSvlWdq6GPeMOAP75Xc6w8Q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p>ping<br>
    </p>
    <div class="moz-cite-prefix">On 10/16/25 11:43, Changqing Li via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:186EDBD71C15CC68.8420@lists.yoctoproject.org">
      <pre wrap="" class="moz-quote-pre">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>

mingw-libgnurx does not build under -std=gnu23 which is the default of
gcc15. Forcing -std=gnu17 fixes these build errors:
    In file included from ../sources/mingw-libgnurx-2.5.1/regex.c:61:
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: error: cannot use keyword 'false' as enumeration constant
   49 | typedef enum { false, true } bool;
      |                ^~~~~
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: note: 'false' is a keyword with '-std=c23' onwards
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:30: error: expected ';', identifier or '(' before 'bool'
   49 | typedef enum { false, true } bool;
      |                              ^~~~

[1] <a class="moz-txt-link-freetext" href="https://gcc.gnu.org/gcc-15/changes.html">https://gcc.gnu.org/gcc-15/changes.html</a>

Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
---
 recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
index 4547298..03a61a7 100644
--- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
+++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
@@ -11,6 +11,8 @@ SRC_URI[sha256sum] = &quot;7147b7f806ec3d007843b38e19f42a5b7c65894a57ffc297a76b0dcd5f
 
 inherit autotools
 
+CFLAGS += &quot;-std=gnu17&quot;
+
 # Specify any options you want to pass to the configure script using EXTRA_OECONF:
 EXTRA_OECONF = &quot;&quot;
 
</pre>
    </blockquote>
  </body>
</html>

--------------zgSvlWdq6GPeMOAP75Xc6w8Q--

