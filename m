Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE31C30653
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 01:03:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.1352.1719450220454508948
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 18:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6908f8000e=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QNpDeC015537;
	Thu, 27 Jun 2024 01:03:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ywnk5vfgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 01:03:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwrTqrJ3SPlMEd4mp7qyVb7vGxW7yICr8MYttVtbZGPeEGnqkHPaJJxk6NRTeJIIJJWV51fnZrKQaQCZTCdj2GZypvYZRQ10RN8LeQRN8kQIS9fg/vRMPgTBzvxh2aCSjt3PgIDWlM82zyo3LkFdPjFyYhsDLH91WAXlV53sTdzbS4eyWsy2RIAYIe52/z/lt2S1eO0cTAWUr9H3hZHobV/Gmwjf27HR8yI1F77gfvIB9sUClrj/AqCbcfHReh1lFauP+wKIe1bPFgS+V4TZVQfbb/KyTD0RORUURqEYCMmRaQDZ33VRCdv2B+Izd8Z2R/zv/uEZOSywDivpEYWe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTZtP8rPJPZEu9fZcb/K/7qDeunCo7x0E5eNrdqQYvE=;
 b=Qh/4ley1uCdKdOQM4vMUgkjhXHQUrKtzDwGbUcWz2RAQ14P+rOkeiFrW31PkvyYems62hW9IbcDehdaDeeH0fyzCfwT9akVmYXT/eNZiQ8cJMNyOU9b6tgg8CzpLco+iVycKnMn2Anie8e9TmndjGHGSz6xOqUT/EGt6ak7mqng8P7BvPhjsN8Nvtjn2KxlM1GElLXmHjmr277zLiOTuN0s3N/c+h39w5RJxwwqr2KzC8V93H0QsOdktcZLBJGgA9YrKSoZgSJ95bO0TQ3GxU2eceOAhOHw6Fn6snpPwO/BiiytCiHlL4rEkYg0F0mrvP7oRs6NyMdlYa0JrvCYjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 01:03:36 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 01:03:36 +0000
Message-ID: <640c51ab-eb52-45bd-a3a5-b734b75e49de@windriver.com>
Date: Thu, 27 Jun 2024 09:03:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][scarthgap][PATCH] refpolicy:
 backport build fix
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
References: <20240625143317.1644238-1-ecordonnier@snap.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20240625143317.1644238-1-ecordonnier@snap.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a20b60d-ca18-4482-3ff5-08dc9644f920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Wk5LZ3paeDF4Ny9Hbm1GaXEyWmozTVoyVzFzdmY3UkFUdHl2MERTeEViZVM1?=
 =?utf-8?B?eU82Y1JzdlZjckh1QWp0cXlOZ1NXS2xqWE5pUy9mTjlNVFFQcGV0NDhzTldz?=
 =?utf-8?B?K1BZMncvSE5veDFIa09oM0xJbnFNQWg5NUVKdjlMekJYZVhUWHBSMmNWeVdN?=
 =?utf-8?B?aWdwVFozelpPeVFvSUMwZk8rWjhyM3dFdityUHo3Tjk0QnRSdjYvZ0t3QmNB?=
 =?utf-8?B?cTMzcFpDYWlIamxkOFF5bW4xa3VwckRYdkJYZ2cvZ0F5bFhqczVXSWF3YjB5?=
 =?utf-8?B?UU8rRURidjdaY0hudEI0ZmRwWU5HT0d6VUZha0g2djhXTEU4UFE3NldTV1NK?=
 =?utf-8?B?cnh1VHdTemNLVFB1Qy9TRVZqQnd2d3JRZUdZYlYxbTM0OWlCVDhsSk9OMEh4?=
 =?utf-8?B?TG81MHhBK1ZnS2tmMkh3UFZJRXJ2S3BwMlNmNk91OHBibWREeEQvalRFT3p6?=
 =?utf-8?B?am55TlZVNlB4NFpWNzQwbVFMZ1pIOXh0WWtLcVZ1am1rT1djcytSQjZqL0Zp?=
 =?utf-8?B?YU1mTlhTSy9kc0VjcFlKTUNXbmNsWTArcTRWNGhCTHZ2SWp1Slg0RisrSnRv?=
 =?utf-8?B?RElXZ1MwaXBCRmREdDNoUGFScW1vSmRGN1FhbXZFKzVPdjk2QXJjU0RvQ1U0?=
 =?utf-8?B?SEVXQnREN1EzZStTa3BGQlJCcVlxVEZQSEJFWXR5dE0zS2laeUE2TC9TSFh6?=
 =?utf-8?B?SlAyWGdQNjQrd2JseFc0SGh1TGJUeHErWXVCSnVXVWR3NnN5TmJqdlJLRlBG?=
 =?utf-8?B?M2FzYTJ2Y0NtcFdDYmdIdDMwZ3J1ZmV2Y1BtU3FxWUdqaGZHUVl4WFZuZk5O?=
 =?utf-8?B?bEVOWjYxRXdIaTlDMzNXOXc0SWg2QVptYWlsbkZ3R3VzNDREcHVSazEvbkZ4?=
 =?utf-8?B?M1FjS3R5Q2pSUlB4TjJ3WHk1d2NZdmJIMFVYSERmc2ZIdkRmTVRwTU1zY0JS?=
 =?utf-8?B?RXJSMEtVUEo0d0NJK3B6dkVMay9CSGp5QUdFL3BwQ082ZHZBaWg0dlpzQTBy?=
 =?utf-8?B?S3dDdWtXUEFJcDA4akRjcnJWTWp0b0hWZzFZeHp5NUQ1ZkRCTzJwbllPTnYw?=
 =?utf-8?B?RWtPcXlaZHh1YkdHTjlCbHUwRnJkQTUzRFZmeDNacG1yc2dxN0gyUWx4U0tJ?=
 =?utf-8?B?aEhiWXMwRGIzSTg4bWJGMmlnTUlEVHQwMU1idDVrS3VzK2VTRFpCcjg3VW9W?=
 =?utf-8?B?N1FCRmFWS3hGdWJEcTk5VGFLbjZFSVlWU3hFeXNRZmc0b2E1WjNvbUJSNHlN?=
 =?utf-8?B?cWl6Q2hTNUErRFVHVC9UMU5ZYzQyTTdja0FJbjhBMXh4VVVGSzJONXRvWEJR?=
 =?utf-8?B?YXBQZFByNFRMdGNYalo1MFNPUGpJKy9XOWFvbk1nbk56NHpFVlN5M0xJOUgr?=
 =?utf-8?B?QitPN1pJZFpkWVpMa3l3TjlLeXhmR1hrdGVSQVdJRlpySUxtZFlGajJrZHFX?=
 =?utf-8?B?WFlWNlorbVNEZmpvZTVkR090RVBUa1RDazF5YjBibUI4eldRQUk5bCtaUXQy?=
 =?utf-8?B?Y0R2MDJrbU1QS3dmakVlY0hoYllNVEZhdEZvVHZQeXZQTDlpM096bGJuT0FX?=
 =?utf-8?B?NzV1ZmJOMTBkNno2MmZtc0MwMEs5bmM5c24vR3NOeUpnbk94RE93OWxEOFlm?=
 =?utf-8?B?dmt2Rzc5N0Z6eDR4TWljK1I3S1kvSmIxcjBRZStDZ0grTnZ3M3dock4zcnlo?=
 =?utf-8?B?NG9oazVIK3FmZHgyWlNXa1BRRmlQMXhDVGxXMGhFd0pJMjdOdXBjMmJGa1dj?=
 =?utf-8?Q?JYAot//19oFtT0rlNk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmFnLzF3alJ5UDgrbnhVRzZPdUpTRTRUN01jSlhCdk14a1hkZkRidGdyeWV4?=
 =?utf-8?B?Qm9NT2wxK2NoMm1zMjBoRzhURmVxTXhCRVp2UVBEVHl0WWRlTkJKVnM1Ukxp?=
 =?utf-8?B?cElGRFZCV2FoTERINEVRNEpaeWJvNDMwWVdjcFRMa2cxZitVd0NmMUI4UWdX?=
 =?utf-8?B?ZEp2MGVmTzcydm9neHc5V2pSVCtaMWs3YVlGY1NoMDR2MjdkTGx1WXBFbnNB?=
 =?utf-8?B?VGl5Ly9XbWxUOUg2dHBHa3pEL3AzaWtQU0N1aVY4Y2draU9TbnRrdkFCMmp6?=
 =?utf-8?B?dnBuY1VjYjJURE1hamU0SHk3QU50NnNlaGh1ZnBpQzBXWDhoeVRXN2dzTUFE?=
 =?utf-8?B?Y09LNjVFUVF3N2RHbFJ6eUY3cVJTNUNNRWJ0MlUvbW40RUFKZ0NqQkgzUkJX?=
 =?utf-8?B?RmJPenhyQnkxV3N4TVRWcFJycHY1SFdIcHd1emtOYVl4VlltVWJkbE5VUWx2?=
 =?utf-8?B?cTNqSEkvZ01YSk1hbWVJRFhVbURUdFMvRTBYZmcwRVJCRWJVMld3U0tMeW5q?=
 =?utf-8?B?NWE4aGw3MHBYY1JHQkR6R1dNR1ZvbGNSclFUV0NQVDlIallPbW9TTThZYmpk?=
 =?utf-8?B?WEhQU1BPd0QvY1FLbG5yQ0NaK01KYWZUWitQam9sYUhkeitmcExDNC8zZkcx?=
 =?utf-8?B?SkwvdlBrL2ZzVjhCQ00wS21nZXoxTy84c05mQ2FITzVjbTFjeExoWEtNR0oy?=
 =?utf-8?B?a25EK3A1TTRYN0JlY1RlM0dMN2V2Mk43clhaRXVxMkZlWk5nSDhVU25wSlNZ?=
 =?utf-8?B?NmdiUWhQaXR2QlRDZTkxQXNHaGVjY3ZyOXplblZRbnFMaFFUbEFyL29xMHNJ?=
 =?utf-8?B?bEVjUnorZ3RPNWNBZFBMWnk3Q0RrOE04K2VMdzdGS0ZqQWIvR1FuTG0ySVFz?=
 =?utf-8?B?ZGFQZVBGaEMxbk5nK25zMzZ6SUUrNXZSOUt1Njl1Z0NTR2lSRzZibSszR1Ur?=
 =?utf-8?B?djJPM0tORjVFdjdhOHBHYWJoY0d6S1E1ampVOEVkZEo1dlFvUEllRTkvNE5z?=
 =?utf-8?B?ZzJZK3FTdFRoMVpiQldQVE1lMk1mVlcvYzk3STJWM25obVhkMUF1NE9GRXVr?=
 =?utf-8?B?WjkxR3l3a2pLT01yVlIrSkQzdmdJeXpRL092SGw5SWlsRXYwY09IUThSTEJQ?=
 =?utf-8?B?eE14ZVdHSjVwTUZtbUdWRTB2a3dSMER1aVQ3YW0rZ3lVTFJCRVYyckRnUTF5?=
 =?utf-8?B?SnM5WUxFYzNEUG9CY3M4bWVwQWtmdXh3aXhFeHpleER3ZzhjaTVhSUF6ajBT?=
 =?utf-8?B?TEhNaWtZZlFuQXAxREtncmNkYjViaHRGanlSRjY1SVMxcFhYdlplRjhsQjU0?=
 =?utf-8?B?aTByZmhpc0tEaS9OR0tKS0Nidm5hNlhqQThrMnYrL3ZDWkJPV3NvN3JMdDU0?=
 =?utf-8?B?aldxaEFlSUE1bmYwSGVIMWdvZEg3R294b1dvaUYySEk1Q0xtbjQyU3gwdXlp?=
 =?utf-8?B?aVZEUDM4TXBla0dDOVBmTVpCQ29hOGd3Q1EwNTIxSXF2NmQ2RnAwNDJHaWo4?=
 =?utf-8?B?V3F3eERpeTJXT2JuaS8zTU05WFRwQXJIdmVmTWRCcUJlVE5BTUdmZnk2Ym1C?=
 =?utf-8?B?a2FrVXlveHl5NURSdVlzN0FnRmhEc0RRUzVSYzM4Y3BkelZYVXNwSk9JMGZU?=
 =?utf-8?B?bkluMWQ5aE1ySlFkQzlvTmQxK1ZPSmE0ZS9OUFFBVE13dlNNa0I2RzhzK2lz?=
 =?utf-8?B?TWlrR3FUY3dwU3RPRDA0VmVkelpCNjE1VE5ZYXo1dTZFQjJFb3lqYXA5WDcw?=
 =?utf-8?B?K2dDR2RvNjFEanhBV0F4WWR2UnhHUjZVdHdrU3RJckZlUjdlK3VGSHA1NGVp?=
 =?utf-8?B?eU9vNUFieXdObHhnUTdwcVlLR2lNWWNZZ2J6NEh5MSttUHdwSWRFcENYNXlT?=
 =?utf-8?B?ODNucXRyN1pDTXpRbVZiUnJVbGF1bFZTdTlUWnJnMnROc2NsWkxyLzNlWFdD?=
 =?utf-8?B?b2ExWmNtcC9lTGFDdUMzTE1nRDB4b3ViRnp2SVM0eEhqdXFnNzlrdVZYNkQ1?=
 =?utf-8?B?UWw5VTVLNGc3TnY0N3JzcmdFNWUvWHE4WVF3R0Y5bWZqSFc1VG94YjBWbVJW?=
 =?utf-8?B?OXN2VmMyMFJkM2I3WUFRM1pzYXhYUmJabzgyRG1nNTRrVzYyR2lyaURiVHFS?=
 =?utf-8?Q?AqhwwPlSs6prrIXsb2McfoDwo?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a20b60d-ca18-4482-3ff5-08dc9644f920
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:03:36.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7hfrBciwC4cvdI+7psYwSoiAT/OXa27BiaP1rlKSKq7Tl9of8PpJzVT1GWcNrZPftmf6OmNeQyPBWyz7lilnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-Proofpoint-ORIG-GUID: JV0UAT0P3XR3_E25vp8lpWPm163MABAx
X-Proofpoint-GUID: JV0UAT0P3XR3_E25vp8lpWPm163MABAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2406140001
 definitions=main-2406270006
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 01:03:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/386


This has been fixed in 
https://git.yoctoproject.org/meta-selinux/commit/?h=scarthgap&id=17c7cd46219e74bf7404dca23b9b9f6380e2d3c0


//Yi

On 6/25/24 22:33, Etienne Cordonnier via lists.yoctoproject.org wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>   ...-selinuxutil-make-policykit-optional.patch | 36 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  1 +
>   2 files changed, 37 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch b/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch
> new file mode 100644
> index 0000000..62b35d5
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch
> @@ -0,0 +1,36 @@
> +From 0f997a134adb6c68d871a31ec27d63f02297c588 Mon Sep 17 00:00:00 2001
> +From: Yi Zhao <yi.zhao@windriver.com>
> +Date: Wed, 5 Jun 2024 10:32:34 +0800
> +Subject: [PATCH] selinuxutil: make policykit optional
> +
> +Make policykit optional to avoid a potential build error.
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c6dd4087def22fa0f3e2b62bce5fc531bbf824a0]
> +
> +Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> +Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> +---
> + policy/modules/system/selinuxutil.te | 6 ++++--
> + 1 file changed, 4 insertions(+), 2 deletions(-)
> +
> +diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
> +index 57c2e0e01..c65d5e8e6 100644
> +--- a/policy/modules/system/selinuxutil.te
> ++++ b/policy/modules/system/selinuxutil.te
> +@@ -501,12 +501,14 @@ corecmd_exec_bin(selinux_dbus_t)
> + files_read_etc_symlinks(selinux_dbus_t)
> + files_list_usr(selinux_dbus_t)
> +
> +-policykit_dbus_chat(selinux_dbus_t)
> +-
> + miscfiles_read_localization(selinux_dbus_t)
> +
> + seutil_domtrans_semanage(selinux_dbus_t)
> +
> ++optional_policy(`
> ++	policykit_dbus_chat(selinux_dbus_t)
> ++')
> ++
> + ########################################
> + #
> + # semodule local policy
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 6ea1fc2..0f5fe1b 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -72,6 +72,7 @@ SRC_URI += " \
>           file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +        file://0057-selinuxutil-make-policykit-optional.patch \
>           "
>   
>   S = "${WORKDIR}/refpolicy"

