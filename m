Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33762C52D7C
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 08:50:56 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.206108.1724057446533434817
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Aug 2024 01:50:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8961296bbf=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J6g35M014916
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 01:50:46 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412q541dmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 01:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg+X7DYmpGmG1S3DV4nA9DjRNzRqoww1yIMU06I90+A6f+REra/xgIMvRNDi+Y6A79KoNwQx3jvNn/cW01UaPDlkwDWm7LJ1wrVknRcuZNGv8j7NWemJ1sRiLkX/d0tD/4vPJQzlfTZMxQn0e1qICazS+eXtY6FcEhOGLcqDDOg9vh8DPaaeizvyRIqc+jCS7D0asPgLvLjwojIDHkDRUkC4wc6txu12bEznkKhxKbPlMuzJYhT7gfDeFhkQ9485P8kx2CmJ/qiu20YPKvofGFXbmOlZ0S7pZW/vWaY9ac5zK4+hsoIbi4DgYbGBzFYnyU7jQ+yRQC8RMpJ8BOe9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIIZIfjKQXZN4NGRCeDt+tjIo5ajixIWxEUTZXIUxvc=;
 b=ymGsZKnuM6zFkKN8I/9/j08dK9mX1VyCClvdENscAUr6GtiOr+o7pWDbvJq9uMvZgI2MwPCkQguq4A/PPQ/r3hLjtGQGzM+WqwkOtKjyV/NKZ9MJpjCG+fmvS6nd37XLRvUwwePNjxOcVwp5E9gobwZgfaGYypRdOq6kuWvGS3tS3XDeeeQPJ9si9K09S7299viNEw0TEx/t7ZYjfj7MJ28Y763Ie3O52f04tK+Vn8MhvEJM1rTNBmm8WLEa/EwPqxfiky/BtnUccD7D4qCaz2StUKDnPavjK2TU8bfAoBwRUGbzBVP8b/AUmWtSKD3jmnXiDvLKGG0a2QhyYwrLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:50:43 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9ea3:51c1:edff:4d3a]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9ea3:51c1:edff:4d3a%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:50:43 +0000
Message-ID: <2b8a6a01-cbe2-474d-ba1b-c537b7b1e317@windriver.com>
Date: Mon, 19 Aug 2024 16:50:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-raspberrypi][PATCH] parselogs_rpi.py: remove
 empty and problematic case
To: yocto-patches@lists.yoctoproject.org
References: <20240704084326.3899266-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20240704084326.3899266-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5611:EE_|MN2PR11MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 0740419b-88a0-460a-d2db-08dcc02c026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bnNJZ0JPTHJ5aXpmL2RPVTdzYkV3emZRbi9DU1N1SGM2ak4waEVYZXVFQWYy?=
 =?utf-8?B?TFNveXFrQTRsbTZSeHRuV2xuTGJtT0s5dnhZZTNJTVZnNzQ5UEJhWFNsV1Fw?=
 =?utf-8?B?NXFFOTZtUXpObUxoTEFzNTA1SUNScFdXVjlhY3EwazNIcDRmZ0xXbWsvLzFD?=
 =?utf-8?B?VHZsR1p4dzBjbEhibmZwNEFnMi92cEp5TnNLd1ZPNGt3SFcrakM5SWZ6YS9E?=
 =?utf-8?B?bnlvYXNoVks2dXJPNittR0RrWWc2aHNBYUZOeUVlV205eEpoQ2k4bnBhS0c5?=
 =?utf-8?B?cC9Hcmc1Uis0ZXI3KzFabUZyY0VIc2dKZDIxUTFNVFQxSENrR1BiZWhaeldN?=
 =?utf-8?B?SXpxdExYWUE0L0ZYWjdtb3pFS2NYcmpJUTVTTUdNZVkwRG9FeTRUcEpOSnRz?=
 =?utf-8?B?M1hpbUc5WFZlTUM3czZFUXZQS2ZzRlduMW51RTBMQnhyRnh5Q21XTGVQRlRa?=
 =?utf-8?B?R1JQallvVkFjcDN0SFVPRVoyVXJBL1hjSExIVWVtNjNMdXZiYStldi9RSDZK?=
 =?utf-8?B?MkI4MUdDUGhEcjhRMlF4VGdkeXZhNTVNU1ZYMDdPMWNxU255aU1CTzVkY2Vo?=
 =?utf-8?B?TWs0d0RJbDgxK29KWDZJUHJ1amhvWGZDSVhLbE5tdm1yRXZPQnhMOWlrUjJV?=
 =?utf-8?B?YmhYTFBCbW42MjY2S3pqaVNad093T2VSc0ozYlNvQjZtTTQvc0JyTE8rTzl1?=
 =?utf-8?B?TVVjTlFVQVdwQ0JNanpSUm81NnRwRTVJYmpyTDdFMHNzckcvZkM4M3VNODRo?=
 =?utf-8?B?UnFPZ0phdEV0S3FBcEc4UkJNTi9FRXlmTnBHdU5NU1lkbVpUbVF5cVhrOTdu?=
 =?utf-8?B?NGc2dXNUYXdCU3RZV3hFWkprenNtamZOSG1ncFJTS2FDZzhBYVhYOTdVV21w?=
 =?utf-8?B?eEhicWNOcS9qTUtHUVU2bVpSL3Q3dVRMeDZXOW1TYlp5ckphcjZPZnJJWXM2?=
 =?utf-8?B?UVFiYWZRaEUzZGR2TE92VFp0Yy9uL0l2Y1JqdHUxLzEvQi9rWGFNUzBNTjk4?=
 =?utf-8?B?aG04V2RVL2lHcW1FM2xLM3AxbzczUE95RUVpR3ZwK2QzVUNXaDFrM2RNeXVO?=
 =?utf-8?B?MmpsQWIzZjU2b0JFVEdDTWNwM2tlb3NCOGVMZ0o3NENxMEFwZjB2dTYrNk1V?=
 =?utf-8?B?a1hldzVVZURaQzBod2JhRGM3TElyajVOaWE3UDRyUHpOekU4bFFrbm1RRlZ2?=
 =?utf-8?B?eExzRVJQU3VndVZOc2syeEhXc0M2a3pjSXllejMvUnR4bys1MWZ1RFcyUFdW?=
 =?utf-8?B?Y2tIbGVST1hSM0s0aHBIMVQ4bUhSMEFFVVVsUW5UNjFTQ0M3Qi9Rb1RxaHl5?=
 =?utf-8?B?MGFFQ2lYM2tVNmxaRERleXZIbyttelpKektvaktWU09iWmY3d1MvR2tMcVdV?=
 =?utf-8?B?WHVHK1kxTGM5VXF3TWdTVXRaYUFXM1QxR1pQR3RZQmlKemlvR2hkSC8yRjNO?=
 =?utf-8?B?U3RhWnlCVk1rbFlXRCthS1V4NzlmYTJqdlpoazh4RFpNVEN1dC8xQWlic250?=
 =?utf-8?B?eFd5ZEdhNUlkWGlwdEhvNjN3d2xiLzNtNGF2dUYyTXhZaVUvVUFMbFE1dVhP?=
 =?utf-8?B?QlltcHdxOE5INDVJc3J6NUFaZ2RLdWduZWJVOStscjFNYUxrMENVVFFablJ2?=
 =?utf-8?B?enlKZmtlakJRZWpUTWtoOWVncmphUTBOaWxQYlU4OTI1MTk2WTA5NUkrYnpH?=
 =?utf-8?B?S3ZUaEliVWtCVWE0SzhnUWdtUlVuTWdMYUpadFF4UFdCYTlObzlHWjJUNk1L?=
 =?utf-8?B?aHlRQ04zN1lFM2Vvc2kxZk5la1M0UU9oUVBtR0JYcFlTeTZOVCtEUmN0RWg5?=
 =?utf-8?B?cGpMWkxRanJqNGs2M2lxZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGR0SVdiTFpYRTZ2R3RuTFNxZmRON3lwdlVYeG5FamVnRnhnQVpSU1FYdEpx?=
 =?utf-8?B?VXJGenNWdmFLZWJ4NVlwZmxlNGlXUldkR3ZrMEFXS3g1L0V5RjllMExCeFJm?=
 =?utf-8?B?ajNnRDgxNG1HQmlXTC9hdTRQa1hxVFhkTHZMcUFBQW9FLy90bTFCN1hzZnlQ?=
 =?utf-8?B?VmxvZlZ4RzMxSGtmK2FnbVFPeHhhM0dZZEp3N0dPQlB1bGRYUU5kSTZRSEVn?=
 =?utf-8?B?R0FSOFZNUGd2WitzZ1ZDNUp1bUxXbGsxcG0raVVtTkQxV3dLK2NxUUgyTi9X?=
 =?utf-8?B?L1YyYlp1OU9kNE4yT1dlLzN4V0p0c2kzVnRwNnRhY2hvZjFGQ1Zoa1F2U1Np?=
 =?utf-8?B?UldITlhiRmIzaFk0S3R1czhSczJKWEZsZG9WMkd3MTNQZHpRSFl1eTJFMFVu?=
 =?utf-8?B?WjFrdldYUS9FMGpCM1NnV1pDbTBKUVE2eGtFcW1sQVNLN1BYZlVUaEVrSFhB?=
 =?utf-8?B?ZzlMMzJNM2F2WDdWTkVtSWdwUzdqa1N1VHdzTC9jaW1ZQjliTFp5RTdQc1JS?=
 =?utf-8?B?WVlLR2ZPQjBnQTVMbmY2YTJEd09vMEk1ZlE4ckZGQWhBQTZNemE2QmlTeENh?=
 =?utf-8?B?ZGZLbm1PMWU1RDArNVhWTlY2a1lZclBMZnFsT1RZR3pKeTgwTnRyZjAya05m?=
 =?utf-8?B?TFFJYlJ1OTM5SmNpL0lIclNzU0J3VktGcytkMjB0OWJjTWVCazY3T1FCR0Vt?=
 =?utf-8?B?Qyt2YkNvZFFpNTR4R1FkRFQ4a05ZWFVLcTZmcXloZ0d3RWViODZIZWhIdG9V?=
 =?utf-8?B?Y0FrbUx4dXJxZlpkck9NRUJxUjJNN1dpYzVYbEc4NXlwRThQazlBUEZlUUd6?=
 =?utf-8?B?TXZsOUVGVzJMYzByc3NZV0luQ0ErRVhLN093eXY5b3hFMGE3M0hWOXJhSytt?=
 =?utf-8?B?eEZvQ2xlOEhmSWhJbHNUSXZJTkNiS3JYNDA4c1ZjbGluU0xRTW8vRUdIV3po?=
 =?utf-8?B?MmNvM1ordVNHRDVIWmNNLzZhN0ViWXdiamt6bFBHOWd3eHlrVXRsQ2NWaXBJ?=
 =?utf-8?B?L0syVXRLQXk0MFZwWVZ4ellMRXV3TFpUMnFjNFF5M1haczdFR2NUYjM3ZGdG?=
 =?utf-8?B?TXBJRnl2RXY1NTZyZWVDV1MvbmcyQjF1d1VRNUQwVUp1ODFzVDZqRkovSmxB?=
 =?utf-8?B?UmIzL09pdGQ3YW1NYk9pTmxaeHNvZ3NoQi84TDNSU3B0bEN1am9hVzA4dWlH?=
 =?utf-8?B?UzFDaWpjVVcxR05LU0o1V0dEbmZjeSs5dGVvc3kxTk1TRndIMEFkOHFUcVFO?=
 =?utf-8?B?WEthdThEd21pcVdIK21xSHNSZGFYYitSRTk3SitYT2FUdDh0NWcvNW51aHVz?=
 =?utf-8?B?U0RkdklHNlVLaHRISHBzZGpIalB1dVhiRUt5Y3pWVGRCM2IvbWxvQXVYQzZw?=
 =?utf-8?B?ajVUOC8ycnFnTUtMalNtSWdxcWczQ1M0NDRqdngzWHlhelUvUlM4NnZsZ0pw?=
 =?utf-8?B?bVRyK3dxc2lDcFMzYWM5TjVITkttWkVLM0RWWTZVaXJ2ZE5QSnZyYVJJbm1J?=
 =?utf-8?B?R21JMWRrVGZYRTJhdE8rM2I2Z0ZVMEZ1WTVzRmhqZjV1dmlBS3htYitqRm5N?=
 =?utf-8?B?ZG9hSFFISDl5V3ZjUUNsU29JeTkrV1I3eHRhRkFuRHBuMS9aMVBmeGpMVFJu?=
 =?utf-8?B?ZXhLdlN1MXlMeGFkdFIxRHAySm9IenN2TmhzM2svazM2N0drR0g1UUxFMFVu?=
 =?utf-8?B?U1VEVE5JTWR6ZDNHYmRJOXg5dU0vcjlDb3pWMW81VjNoN29DL3o4TDEwZEZa?=
 =?utf-8?B?SUVtRFo0NWtxcjR2bU4zbmVKYzZGRHNjbDl6aXhuUVNBWWJNdVc3a2doS1ds?=
 =?utf-8?B?eTJLekhSVzZSSGNKcUlKcWI4ekRKaWZCaVpydmhya1oyOXEvNndaU3Rtbmda?=
 =?utf-8?B?aEcrWStieHVkTFVYMlQzcGFVOXcrVmcraThBK2ZSMDRTb0s5dk9yWmQ0N1pa?=
 =?utf-8?B?RDFPbGYyb1AwOFhsbE4zOXdJMUZxZW9OazlXeWh4eVpmUW5nNTZaL3ZQZTNt?=
 =?utf-8?B?Nll3Z1hKNjcvWGxuazJBaU1nNXRMRlpJcXRoTm5rZ0pFb2taYjBlSWpuS01k?=
 =?utf-8?B?S2wzRjkxNWRqN0N4NWZQbTZIZmtKQ090UkpMWVRHU0cyanRFMEFOVHdtSThu?=
 =?utf-8?Q?Fl57CYN+w9//uvAfLXCoKQAlQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0740419b-88a0-460a-d2db-08dcc02c026f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:50:43.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPws4WLm3QoBrE5JIXJee06dBeL4e43G06+q5Tz/iJ8jN+tx5wxFGNL46AWhjlmftPCY5wy0hXOgXct/l9cqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
X-Proofpoint-GUID: 6E4hipxrj-2zq2F3HyWGhxqEc4Otd6gE
X-Proofpoint-ORIG-GUID: 6E4hipxrj-2zq2F3HyWGhxqEc4Otd6gE
X-Authority-Analysis: v=2.4 cv=b+3g4cGx c=1 sm=1 tr=0 ts=66c30765 cx=c_pps a=hHPfuxNGWHHq0fQgDGst2w==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=7_ZwDpIsg93xsRtd5F4A:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_07,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408190063
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 08:50:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/520

ping

On 7/4/24 16:43, Chen Qi via lists.yoctoproject.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> This test case now is basically empty. And due to the change in
> oe-core's parselogs case, this case is now problematic. Because
> there's no common_errors any more. This means when this layer is
> in BBLAYERS, any 'bitbake xxx -c testimage' will error out.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   lib/oeqa/runtime/cases/parselogs_rpi.py | 12 ------------
>   1 file changed, 12 deletions(-)
>   delete mode 100644 lib/oeqa/runtime/cases/parselogs_rpi.py
>
> diff --git a/lib/oeqa/runtime/cases/parselogs_rpi.py b/lib/oeqa/runtime/cases/parselogs_rpi.py
> deleted file mode 100644
> index 49226ae..0000000
> --- a/lib/oeqa/runtime/cases/parselogs_rpi.py
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -from oeqa.runtime.cases.parselogs import *
> -
> -rpi_errors = [
> -]
> -
> -ignore_errors['raspberrypi4'] = rpi_errors + common_errors
> -ignore_errors['raspberrypi4-64'] = rpi_errors + common_errors
> -ignore_errors['raspberrypi3'] = rpi_errors + common_errors
> -ignore_errors['raspberrypi3-64'] = rpi_errors + common_errors
> -
> -class ParseLogsTestRpi(ParseLogsTest):
> -    pass



