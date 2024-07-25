Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8EC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 08:43:25 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.31837.1721896996189504902
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 01:43:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=79368292ab=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P7CZMR032425;
	Thu, 25 Jul 2024 08:43:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40kca1r9qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 08:43:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anXUUDnV+25+ZhVXzc4gFadpWQWEKdGqg4Use9s3LfmyevC6baXAGBGhi4IyxGkOGGBbhgJA+E92VJSPmbTeYtksTFIoousi0dAe9uCeLdXc8VWpaDH2m3qwfsA0I1AKkEC7rXM3yADEWIQPhI6USXVDJPSvoC2n/By+YCehKRxKHBovuoTlsda65OqVrDYzm5srpv4n+1qE9ylmOuG4ojAfrGwkHNBVsUe5N7MsS4bt1KkcB0Ax7B0Vz3dpjZRxh9X86gVmZoPmIpYwv+VCoO0Fb64O1kgUYPd0OKr0sjgccoS+DZaqdgtPPO/8YAW5v+Le1FK0EbVQrcQc1LH+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0zzvnIKmxaizAKyWCJbLJ35oe+cMJgnlnOCVFlmp44=;
 b=TtIBrZYF+pfZyIekfj4mXTQmZHMEy+DZfMzrK87XWeSTMoCo718E+WoiYTVjjS3Ho36/gZfU/gf9tz8eZv3ubdX1ABKFji6CzFrEuO1WXRXWUOGXxQAnEUjFvqJudATlphs6rrps9nb3WQJc2nO5sGsUXgOyvlONdMEDr+8Pxwg0gSZ6VHGpcqsXsysZbivKl8x7FJjFTE6UDmx2S/oahX7tnzqCpmMruFLrTlH+F76W48XETBkCGg7e+ZUXvGNvgZTRCAqTt8+NRqg06ouy4u15SSSNyL0y2s+1VrlLwoJDl95kZx+8kYkq5Ozqd0WlkitopBjbP+/VCbrKkgXtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 08:43:11 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7784.016; Thu, 25 Jul 2024
 08:43:11 +0000
Message-ID: <bb8d5d5c-b857-4eaf-846c-624ec6044db0@windriver.com>
Date: Thu, 25 Jul 2024 16:43:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in
 login pam file
To: Joe MacDonald <joe@deserted.net>
Cc: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
References: <20240724141329.3326073-1-yi.zhao@windriver.com>
 <20240724145353.7yxqlbaetvims2tz@nightwinge.deserted.net>
 <df0f4afd-77cc-4cb9-9b84-2f385be71527@windriver.com>
 <20240724152601.2ti6auxh3mfpptnt@nightwinge.deserted.net>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20240724152601.2ti6auxh3mfpptnt@nightwinge.deserted.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: bda66f9d-6cfc-4e21-5e6a-08dcac85d095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VUhjU2Y0S2dVRWlpTXAreDFLVFFTS1lyRExoOER6RVVHdEUrU04vbDJpNEs4?=
 =?utf-8?B?MVJ4aWx4SUUyeFlOVjZWOFYxaDVUU0l1WEt5WWc0cjhhQjQxd25vdDgrS3pS?=
 =?utf-8?B?T3dzRDFkT0RQUHh1RVpJRXhHbUViY3NNZ3FYT3dQT3JpWG5zUEhuNHd2TlVh?=
 =?utf-8?B?Y3VQU1pQVkdzSzd2NlFTRkhOQ0FOcDkzRDBRdFphVDI2V0JxMUxIOXh2NGND?=
 =?utf-8?B?VXB0MThVUzNUUVBOOTNNWEdTNUtkL1pHakVPWEJZUVBLVXRqTytGZnNGSXkx?=
 =?utf-8?B?SWlTTmFQb0w5NGQ2TlRlb0tXeU5vSjR0TmgrMi9Sa1ZMRHVndTExTVVBRVZT?=
 =?utf-8?B?MG81NUtQb0lPemQ0UlVMZzVmcUdtMDhnSjVqRGpXSzVGRk5Ed3R5RUZVWkJF?=
 =?utf-8?B?aStVbElaU0VWZVg5ZTdpZEthWUFtR3o0QzdyRDRyaTZKQ3pWUk9aT2JwSUc1?=
 =?utf-8?B?OTZHOUI5MDdNYkwzOHltMUVZQ1l2b014TnBFZDZoZ1VScFhhSjhITU9YMlRV?=
 =?utf-8?B?S0JJK3ltVVczdE5oZHNNdzM3bXFla2c3d2RUNWsxVE1GQXY0VlBpN1dPN2hC?=
 =?utf-8?B?Zjc4d2E2dG9BYzRPTGpEdmV5MEZhYi83Z3dadjgyOSt3K1I3RWhuYnR1RjdJ?=
 =?utf-8?B?a3VOWGJLOGhGWkVwVHcwMWZFQjMrM0xiOWVJdHZVV0pHcTR2eUVkdDVsOFBo?=
 =?utf-8?B?aTBrVGJXQUYzaGNWQWt1RGZXcVA5R2crVDhvSlZIeFYvQStmQjNUdjdqcUJi?=
 =?utf-8?B?L1g4WHhVMCtyWXhGN1dwdUo3ck1FUkwwM3B2eXpjQWhpMEpJYU9uVWVQOVhM?=
 =?utf-8?B?L1N0bnJVYWlZbEpkSjZKRVExb2hJOGFKVzdSdmhDR1h4VHZIVnRqa1dLLzN3?=
 =?utf-8?B?VEQzWTFpc25jWGl4V3hvM1pMMGpmd0NhdUp0eEtTUnlJZ1hPQngwRVZURlBQ?=
 =?utf-8?B?aE1Cek1UUFZGSzRHRkVITVJUbUVwOXd3T2wzeWJDbnlIaWtyanRLZ0EwNWVv?=
 =?utf-8?B?SDl3TEJob0NzaGFjSDEzSlhKNWRsdWZ4am9DTWNhQlRIVHRyQUJRZUZ1ZUVP?=
 =?utf-8?B?cTRMU0FRb2dyeTRRblBhTThXcWxQVDhBOFlrZlVLUGM1K1p5M1JNbGVOWDR6?=
 =?utf-8?B?MHdpdnYydzdPOWpFcDlpdS9HYm5aTDZ6NmIwS092RTZhZEpOT1NDdlVhQitv?=
 =?utf-8?B?dkZwYzJsQ0tSaW92N0oyTExIQ3VCUGhDMWdwTU9tUnVTVFI5ckw3NU93TGRm?=
 =?utf-8?B?UUJpYktYT0J5RjhKbGVYUFQrbWZhUlZxYXN6WjV4NnJ3NjRKbFNlZ2cyTyty?=
 =?utf-8?B?OFU0WDE5T21FMVhEazluVitaTEpLdnpPV2FPZThNRUY4RUp6aGpKWklTUExG?=
 =?utf-8?B?WEU0M3RDVHI1T1hLQnRkbDBLRFBRT2kyZWFZSzBOKzFyc3Uza0VScS9VQVZJ?=
 =?utf-8?B?cmZDTEhzSFgyclM0REo3YnFDczFXaS9TQmYxT0o1dDdnZ0tIcElWbWp0VVpJ?=
 =?utf-8?B?MFRWNG1CUFJHZFk4UzErTmRHOUFTNlpsTWVuU0pTNkpCQ01SMmNOT3ZxUzdv?=
 =?utf-8?B?YlFnZExHSk9yY1pWS0tMRkE2dTJqQkp5TTROYjNDajJtLzNTalZUa2tmWFNp?=
 =?utf-8?B?QTJHemFBRmpNdG1ON21ybE9qbFo1aWx2Z21adFhPcFdHUDF5K0poblBnNVNz?=
 =?utf-8?B?c1R0UDVLU3c2YU1wZFVzZmwyTWdyR3Zsa3FJZ3JHb1JBVktiaDJtc3N6L0tI?=
 =?utf-8?Q?E/EfQ9uxfk6krR9ZS6sG6DTn4yEOf+cF+E1ARW+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dE1VcWQwc3ZmNnNkcTMxZm94MVFtNTA2bmlBQlQ3bVZrZXJ1UHUzY3phUHBO?=
 =?utf-8?B?N0gxNGoraEVEaVpkbXpiV0FHM0loR1MzQzlMOXF3VHdDTzFuMzE5QXFtTnc3?=
 =?utf-8?B?MnhlK3JPNS9pYWFjZHJyN0FMajQvQVRrejhNRG5UT3ZZRE85UTg2N1NXM1Z4?=
 =?utf-8?B?OTk2Q3YxK2x0ZURmVWF6cGN4RitqUEtFZVJVM3FKYWtYb2hUdUdwbm1pVEpj?=
 =?utf-8?B?eE1FVytkWjhkZ29rVkxPanF4alFxenhaL1VQWW5hdWRhTFpQRmozSHFhb0RV?=
 =?utf-8?B?VzRvZkNja2sxeG54VkpjSnYxQ3k1VEZNVGUwTHpTYVNNUVFKd0pCNE9ZYUJ5?=
 =?utf-8?B?NTF2b0xtYzhSSCs3cFYrdGcxLzhpOHhaaFBHWG55anIrZUozTTh1SEJxeTJj?=
 =?utf-8?B?UjdQY1lLNkF1dm81akhNQXNVaExqVHpQdzRuZTVIdzhkb0ZFNGNLSWFXTUd0?=
 =?utf-8?B?MlA3WHJkcTNCempjQlR6d0VnT25PTkxZMVI2cHhmT3F3bXE1YTkrZC91ZlRS?=
 =?utf-8?B?NUxaYlNyNmM5Kzlxekt3RWhOd3BBbGxUdmoxb1d0UVBReUkxYVoyTEZHeVRL?=
 =?utf-8?B?azdadUVhazBFSEdib1Vmd05TK2ZXSmpHRDlKYStpb3JKRTVGVVNnT1FzcTRN?=
 =?utf-8?B?b3hZaDJlQnJiMWpkVFZvTEFmanhRZ0xuS3hzWnJKRmQ4ZStLS3ZWaTRMK0Jk?=
 =?utf-8?B?RTlTWVFpeUEydUd5ZEw0VWlmMysvNGtxc2RUTWszV3NzdFlaRlpWVkIvSzhj?=
 =?utf-8?B?WDBDbURHVmJHN2FYcXR1YjhpcGcrNHFIMU5LU1FUdWJDdGM2b2RTbFUxWEJV?=
 =?utf-8?B?eFZxNWVHbytaRTMvSnhCQ3kxZkduSXA1ZEhpaGpRTmFmajBDQUw2NTI5Y2hM?=
 =?utf-8?B?cm56VkR3cWpNQlJReXRrc0xnQTBOMkRQSnBHZGRqNktiNkZWcXRpOGNrZ3FZ?=
 =?utf-8?B?N2NxeDJSdC9CYjQ3SktZQjFHODIxWnRhaEJHNlBYWkJBSThBTHR0QVZOZ3pR?=
 =?utf-8?B?Z0JwZis3dU1QMzYwQ2ZOVm5OWUVzOVhjMms5U0tsNTVaajNuLzJjMjhKNG9C?=
 =?utf-8?B?bWhSaFFvNG5HMGhFaTgvUGxGTzlid2tDVC9Iam1zWHNqNEVrTkVyY0FIK2tK?=
 =?utf-8?B?KzFWV2tiWi8ybk40aXIwS2JCeHpLZ3NrODFFYnZSUnViTUcvcTY5cGI0Vi94?=
 =?utf-8?B?UHNsL1hKQnhNaENBbVlkdEYvMTc1c1JWRTQ3WFlNRHU5VndadTl6RjVwSEw3?=
 =?utf-8?B?T2hNMnlOZ2NVOGpLNWZQSVFPK0xZU1NYaHNqYlUyM1hZYjdDWUFxdGZHZThY?=
 =?utf-8?B?eGxPbkh2U1ZSK0JkR0wwUXo2RHdQdllXRFdZUDI4aUI5eUlGQXl2M0lMYTB3?=
 =?utf-8?B?Zktjb1Y5dnQ5cDQrdmVBeTIzeVJkYWZIRkhENFdtbC9JNjNLY3loM3BZUDlE?=
 =?utf-8?B?dFZpMlBrb3kwdjNacVRZSjFjWnErTE1pbDEyR0NNdUtUMlFaMFJldUROdUM1?=
 =?utf-8?B?cVgwbkF3U2prTS82cFN3LzRVZlhFaytQQVlSNU5SdkYwZ3Rwc0plT29PaTFQ?=
 =?utf-8?B?M05jc3orT0ZkejNSdy8rc3VRNE1MNEE5Y3ZWeUd5M3ZETTJueDIwTVAxdUVz?=
 =?utf-8?B?SWxLRVQ0MVpadnd5dzZUVjZhd0t4NFlCbUhzTEhOUUlGQW1TMjdCVVdvelhX?=
 =?utf-8?B?QktGR3dBUnFsZ0ptd2huWVBaR1lzcnlmZUxNSzlzODJpSUVTakhzRkFtMUg3?=
 =?utf-8?B?a2FPZ0x1b2JjTnk3QkpJUE85NmdTQS93YVMwWkg1WG0yWlErUHh5dHdKbmFi?=
 =?utf-8?B?TnN1SUFkWVNnaHVuS085OTI0akJyWlhYanFiNEp0WWQ0aVRkSWozY1duOEky?=
 =?utf-8?B?cGNNRXZzcElia1Y5aVdzNGxwamRXMlNHUnZNMDIxV216am9TVTFKaytjVENV?=
 =?utf-8?B?YnhjV3RzR20wSzJVZmJ0dHlCWjVWSk14bC9rK2xFRVBiM0FFVEd4V0J2bmsx?=
 =?utf-8?B?Q2R6aWdlUXZ3NW55dDRvTjVkL1h2WEVGY2t4c05QWlB5OFZDSWpYTTRBR3BV?=
 =?utf-8?B?T1EzbTQxMWN6QjlYdkJzY3FSRHRCOFJVUVB2STJEcjdkS1dyMnY4QTdtZ0F5?=
 =?utf-8?Q?fSCG4h2h3xiFgZoPRfh/I4PfZ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda66f9d-6cfc-4e21-5e6a-08dcac85d095
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 08:43:11.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8DZBT2vtb6kEfRbzuSmHhVcMCDNJvQ6CaWKvJF2RENgkZ3q6MHMd7BCTcUwx0qaQwTiwJlNc0HSyKZlWLQjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-Proofpoint-ORIG-GUID: I2zhIY9Nf261okUNxfg3anTbyENxAA94
X-Proofpoint-GUID: I2zhIY9Nf261okUNxfg3anTbyENxAA94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_08,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407250057
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 08:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/457


On 7/24/24 23:26, Joe MacDonald wrote:
> [Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 23:16) Yi Zhao wrote:
>
>> On 7/24/24 22:53, Joe MacDonald wrote:
>>> Given that this is deprecated and disabled by default, is there any
>>> reason to keep this in at all, rather than just removing lines 67-70?
>> Although lastlog is disabled by default, the code is still there and
>> users can enable it via configure option --enable-lastlog. So I did not
>> delete these lines. In addition, keeping this line will allow users to
>> easily switch to lastlog2. Just change pam_lastlog.so to pam_lastlog2.so
>> in the line.
> What about commenting it out but also changing pam_lastlog to pam_lastlog2
> since that is part of util-linux 2.40+ and that's the version in Yocto
> today, then?

It's good to me. I will update the patch.


Thanks,

Yi


>
> -J.
>
>> //Yi
>>
>>
>>> [[meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 22:13) Yi Zhao wrote:
>>>
>>>> The pam_lastlog module is deprecated and disabled by default in
>>>> linux-pam since 1.5.3[1]. Comment out this line to avoid loading
>>>> pam_lastlog module by default. Users can use lastlog2 provided by
>>>> util-linux as an alternative[2].
>>>>
>>>> [1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
>>>> [2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0
>>>>
>>>> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
>>>> ---
>>>>    recipes-extended/shadow/files/pam.d/login | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
>>>> index ec5bba9..eb43f3b 100644
>>>> --- a/recipes-extended/shadow/files/pam.d/login
>>>> +++ b/recipes-extended/shadow/files/pam.d/login
>>>> @@ -66,7 +66,7 @@ session    required   pam_limits.so
>>>>    # Prints the last login info upon succesful login
>>>>    # (Replaces the `LASTLOG_ENAB' option from login.defs)
>>>> -session    optional   pam_lastlog.so
>>>> +#session    optional   pam_lastlog.so
>>>>    # Prints the motd upon succesful login
>>>>    # (Replaces the `MOTD_FILE' option in login.defs)
>>>> -- 
>>>> 2.25.1
>>>>

