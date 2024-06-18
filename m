Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD56C2BA18
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 01:41:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.75896.1718674897989275681
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Jun 2024 18:41:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=68999bcae9=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I1df5l022295;
	Mon, 17 Jun 2024 18:41:36 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ysafg23y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRDKrf99x5FiLUmWofa3L2Za8wA+XyJGDr38jJEmQ7YdsSyCGm6opar/alwsnnt1r+iKPy9PLChFP2t2pNi6ejAZ+XIv50Pu5yHJXI8+M9OsQWT1Jk4Mofecq0GMUY6/lNuAj3iSHyxboz8Jk/7/xUwpuKHnAa9MomKueprphnU5ewle4E6kiwzBN8NuFEuRepwYJz/jB5nQ75umW589R/CEMGhlw8y9yc3TbyxpgAUh+NTYUDAU8L0A+V/2yZbVUq1Ly4R1iQUXhenfC1Go4/Ah+HMdRNDFzUq1ZEPvIWk5DCT+3oWpzD6wFuqXyovj6NbjcNQcemATZJ2XPEGyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2uHi3xNvWSHfgX0ae5TGskGN43NdrngHUuBEi3h22Y=;
 b=U3k5YC0lyW+bS838oQeokCtOZn5xVRY3EuGyQhcJ25ecytoyyHnQxxuqAZ3JTrLzQfW72XDxWiGTLOItiHM4xk0QKQpeOIqBRxCCl4nHIUsRuk/prfnB4pU+TBqh7wW7PVJDTF+TQKYXhJnzA/hEAHnb4cGXmvhmAmv1T0O1ghbll1ifP/eLvCt6pVtDCyJN4/+CSQoUbyTJ9VNxJ0ullTsFpGfVdyP0bV8/86+oUoa4afz2Ncqg+D7aAHrjvl7e6Ui4zFCJD2szFKP2iec1MMPesklA8OiLJ/1NooiSdXWUUxSusp4kGWDBFjftwxFc4Xgj4kJA3qORTQ6t52LPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.35; Tue, 18 Jun 2024 01:41:32 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 01:41:31 +0000
Message-ID: <81afd828-1cb4-4970-9ced-0e088c0d48a4@windriver.com>
Date: Tue, 18 Jun 2024 09:41:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 upgrade 0.1.72 -> 0.1.73
To: yocto-patches@lists.yoctoproject.org, Armin Kuster <akuster808@gmail.com>
References: <17D105F17209C86D.21587@lists.yoctoproject.org>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <17D105F17209C86D.21587@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: cbda6674-8ef7-40f5-99a5-08dc8f37c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VnJaZm1MNkJUdmVFUXBvWGxLd2NQOUVrNytFVnU3OXFEZkU2MnYwTUg3ZStj?=
 =?utf-8?B?b2FJb3cvWUo0NXd5dkMzdlUyVmRRbzh1VkE0elZBOG9URnRSdmx6QmIvMnR1?=
 =?utf-8?B?WHdhckhRVDAxZE1HbmZ2ZUF6TEhhK1VTanJhVDErSmhYYzRKSnNZVVRuL2NP?=
 =?utf-8?B?OHlLcVYyYldmNXZwZUQ0eUtqUE4zVVY2WmdXSi9TZUUxV2E0d2RxVE9TN2gr?=
 =?utf-8?B?WmlISHIrbzdNbG9uM0ZmOUJIbW1kUnhXNWg4dUFERzhpVjk2WWVFUzkrdVEz?=
 =?utf-8?B?WklUb0hSck51Z0R3cnhwUUJnMnF2VURldUNKZ1c1V01FcWRKY09pdk9nQit4?=
 =?utf-8?B?VWhVeW54VzdWY2h5TFpFdzNzcllTK0Qwd3JveUQ0SW9LbnY5UWJDUGpYbjRu?=
 =?utf-8?B?UGxCUnBDN1h4aklWeHh6azM0N2x1YjZRczF4L1o2VjlrWnJjd09Lb21UQ1Q5?=
 =?utf-8?B?ZHNlUE02bDZ1b3JaSmh6Wm11dCtEcFo0Tk0xMDF4UzV4QlFnWFlQTTFUYXE4?=
 =?utf-8?B?dFEwTXIzaVB0V0ZaOU1uRTJ0cXFOa0k5ekVyQ3Y4OU5lU1oyY0lSU3kwOEp5?=
 =?utf-8?B?emhzRkVVbzloM1NYRnJGQzB5b1B3VVZUL0QvbS9LMFkrK0FjQTUya0F6WlFE?=
 =?utf-8?B?di90MTFWV0dsRlFnQW13ZThJczNjUFBVay9uWUt5cld3Q2E5SjR6NEIvdlVu?=
 =?utf-8?B?eUtZSEE1bjFDOXE5SFp0c3NkbFVRMlNxUEpIUHh5MC85bmFLV2pyam4wQlc1?=
 =?utf-8?B?cERVdyt5MU5XWWJnYmpoTXhkZVJXUGdrajNIZGU1ak9LUEdSVk9BMG5BU21s?=
 =?utf-8?B?eVRwUEpTalZadkM2YitxME5JdHBIbjhtT0JKSWxWazhqTUczRUR4ait2b0VB?=
 =?utf-8?B?cXd2ZEJOcUhtV093SWZlUFoxKy9EY0l1Z2MxTGsra2hJOEorckx5RTZZS2FZ?=
 =?utf-8?B?UUsybjRGbEdlR0JrV25oNDNJNThTNjc1M2c3RTFrcExmYzk4WU1NZ1pJdmlz?=
 =?utf-8?B?T21qNm1iVVNzZE1TQXdETEdpdGc5b3ZVMlE2YUtUTUxqSjhnSk03SldzYzlE?=
 =?utf-8?B?NUZkMU5Ub3A1dlE0QVl3QUhBdEdZb0V2ZU1YWEtYa1B0Q1h2K3NIcGZOSWY0?=
 =?utf-8?B?UmFZVGRkTWZvQ2RLanlTVXNHZWRpUnF6c05zOVY4RDhmcHpjVmg1UktaUmZY?=
 =?utf-8?B?RnlmcHNINWVqWDBXSkZUWXhJOUwrNkRESU0vRUZNcExTMUFyYWY3QzA3YVpJ?=
 =?utf-8?B?Uk53blcvMUFGazFpNWhVdXk0UHVha3huMzFQWkt4alRFMkpSVWtLdnYvTDZK?=
 =?utf-8?B?UlB6V0VFbGxjZHJCZVlVUTBTSVozblRDMkhwa3B0R2NSVVA4K0R6MkZtYXlq?=
 =?utf-8?B?ZTlWOTVPdHdCYTA4OStUUXllM0I3VjMzdjUrS25raUcwZFJvVDM3cnFXUnR4?=
 =?utf-8?B?ZHhpSW9pUlRBSzNHWmxRYWdib2liQUNLS1d3OER6MGp0aHdRNzUvN2RIVmFP?=
 =?utf-8?B?VnRtQWRBQnFMaURIa1QxY2JJb1dIbnN1UGdLK3pELzZGdVFSZ1FSYzZreGh2?=
 =?utf-8?B?N1lNbVNPZlhrMk1XUkVhSitJYTRRRkgxM1Rwdk1qM2p5OEk3R2hnZGgvY0FQ?=
 =?utf-8?B?aE00cnVUTVFPbEZSUE9jMEdaenE3QTREbmFSUmFkYlZYT1g4Q0JJZWdrZ1da?=
 =?utf-8?Q?qFKls4EHR/uqOhOI3+u+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q05yc2ttRWZXTDRleE95R1ZBV0ZOMFk2V3hXT2c2d2NKL2tnbE5pOVVpd3l6?=
 =?utf-8?B?T0M2ME1DeDdzYTlZYUg4QmhTTWhJQjA0UGhTQlduMTJIRS94dzJBM0ROS3JY?=
 =?utf-8?B?WUZyaHhQajh3QituaUFBQS9hMDlleTFDb0lSN0dCeFZoaUpjM05WcTJFU0d2?=
 =?utf-8?B?aEdRcmMrZTBBTFdtbXQvUWo4N083STlYRTlJOHEzTVcvZFpzb2NnbDZRUzNC?=
 =?utf-8?B?TmVjcXIvbUpWdk9DWk1NenVHUHpQT3A5SnoveUtxUDNZQnBIR2VkWXBDY2hF?=
 =?utf-8?B?SU5OZ2duUXZ1U081NzNKcU9tZXhMZWNBZ2RIWUEwSFhEd0J1VE5nUkh5czdO?=
 =?utf-8?B?VU9PeXI2UkhYQVpSWlgvbkNrL2YyVHRGOGdkZjd4TTRsQ0daM1ZRWnZwQnBT?=
 =?utf-8?B?VzJ0M1hkZHdqVEdleUZFOGhUSDd0dHB4dGZnMHRycUJmbnp3M1kwcEsvcVND?=
 =?utf-8?B?cTVRQ0VtOG95c1Q2cENBdUZDNVI1NjJDYVBXY2EvUXErTW9MSXhMYzVueTJL?=
 =?utf-8?B?aEJ1THNlY1drSGU5VEY4MTJncldleFk0aHZuNHllendheGEybTlDaVZwR1g5?=
 =?utf-8?B?QkVPVXJ2VjRWTXJ2VGpoOTJSL1p2eXFnRWZjTjkzT0RBRWpHaGcvbVhxb21r?=
 =?utf-8?B?NVpNSGVoMU0wMGV5UnUvWEx2d1FkWG40eVJWRnJ6WVFISEdvanY4NVBFUnkw?=
 =?utf-8?B?L1V5MDNCdGJMeWRhbHVrOFRSbHRWaU5GNzB0cktoelVLeU1EN0lPNlFvT0xx?=
 =?utf-8?B?ZVlUK3duTWxVU0YxOWlVdjZFbTNxUXBvL1pKdEw1QjAxR0xMS29kWmsyTHRj?=
 =?utf-8?B?VWVEZU5BNUxvVEdVYnliLzZkYXlwUGFoNC8xZXdvNlhYa3NEb1NtUndVU1VK?=
 =?utf-8?B?TDRSWUtLSXo1Zy9WdDdZNVk5UTYyRk9tdjgzL1dzNnpzS2NyeklvUWRUb2hQ?=
 =?utf-8?B?U3d0TXVIN0V3VUJaMGw3ZmwxTWtnNEliTE1HK1IwVnR6OTBtSzU0THNTTjBC?=
 =?utf-8?B?aVNXa0RsY1E2NGR5dTM4aC90K2VtOElRMXBMZFU1SHJ2dmhWY1prTTVHNUZC?=
 =?utf-8?B?d1dEVUpmU0NTTGdEdDFmU0RKS01jckZGdzcwdDZWcjVwaVFGV2MvanMxSDBT?=
 =?utf-8?B?c3FYeVpZdUVGRVFrQ1JJc2tIemhDQncyUzdVM0FDN2Y5bEJSNjVHZlZ4OXVS?=
 =?utf-8?B?UmhDZjlSUDVJQW1rNnJMYkhxTXBwcjBaeXBkZE5mRWxsNUc4aHJEUGRnZG1K?=
 =?utf-8?B?aEh3SVd0UFU2R1ErdXMwTzJ3R1hRY2VaRXNxTVdSaG9KYjE1bkpTK2dLdmhu?=
 =?utf-8?B?NWtRWVJHU3ZDMlNIOWkvR3M4NDVTTDRtalYyRXhTRWYxNUs3cHpKUDFQU3g4?=
 =?utf-8?B?dXUreWRmWUQyVjVsM05IS0I2bWJtTTV4c3Y2aWFPUDFGa3FqcTdjNnJzbDdQ?=
 =?utf-8?B?aFNPaTMvL1NKQlNTZnhzc1k1MXFnVkppUVhTWFM3L2ZaQWRyMHZmamQyTVYy?=
 =?utf-8?B?VTZyU3hGTEhJTUVXT1F0NHp4Y0J1UFJXUXdYTVd0T0tBL2Jnb2w4aXV4UDYv?=
 =?utf-8?B?TlZpWEFyQVUzempaNWx1c2JtTGVNRlgzQmxtTEVFc1BtSzVUMncyb2hmbHpS?=
 =?utf-8?B?Yi9sYkN2RUM0VFJ0YkRjN0tXSjV1ejIwM3B0YmhrN1ZPWGQ4T3hhaVlGZDh5?=
 =?utf-8?B?R29URTFiY2ViVXVIbXdFTFdJUnZydjFnTFRWbDZjUGZ0LzVTYlFTVFR5VmRx?=
 =?utf-8?B?WEJ3VEJJd3I2S1diUGVnUEFCbzF0dlRLVWI0VFJrZlZnYSsxQTFMQkZ3WGsz?=
 =?utf-8?B?NDBqd1M0Y2FmNzlyRzNsM0ZPeVZEZTVXeStXY2tTd0swZ3VPTmZQVm1VUXNO?=
 =?utf-8?B?ZXZ2Z2F3V2pqdC9WQzU4NzJnakZCMjV3WlhDSHFoVHdDZU1Nbm5Za2E1TVZp?=
 =?utf-8?B?YUpzY2U1SnZKR3JhVTNMUEZ4MjFUVzlta1dlQUhHZVE5TDlPNEpSZkhVaWRn?=
 =?utf-8?B?VlZ5TTJPWEtuYnlxdnhlLzhrS0l5RkdVN213azhPU0FDYi9tSTF0UjM4VERn?=
 =?utf-8?B?QiszdjdjTW9IVU8rR3NjL1pBS29WSk9Ua3JhUGVrYlg0S3lSaUk4b3JNOHlS?=
 =?utf-8?Q?gfDYF1LAao8ojVsnBgKnbLw5R?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbda6674-8ef7-40f5-99a5-08dc8f37c770
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 01:41:31.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4qbEPOYEjB4yhfbBCkkMMxQ1rvHhwqc+0iWUpmrml9lzyPOpWESicSjysdwCcCBkAMy6k1O1s9Rc7VIqBeD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-Proofpoint-GUID: ychzH1vKxbU-dYSh2I2qYzChLZMh2bEg
X-Proofpoint-ORIG-GUID: ychzH1vKxbU-dYSh2I2qYzChLZMh2bEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406180011
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 01:41:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/335

Hi, Armin,

Would you please backport this patch to scarthgap branch ?
Somehow there was a force push in upstream repo causing the v0.1.71 and 
v0.1.72 rev commits to no longer exist. So now there is a do_fetch error 
on scarthgap branch.

Thanks,
Yi


On 5/20/24 06:57, Yi Zhao wrote:
> ChangeLog:
> https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73
>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>   ...p-security-guide_0.1.72.bb => scap-security-guide_0.1.73.bb} | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>   rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.72.bb => scap-security-guide_0.1.73.bb} (98%)
>
> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
> similarity index 98%
> rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
> rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
> index 549f04a..84f5a11 100644
> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
> @@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
>   LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
>   LICENSE = "BSD-3-Clause"
>   
> -SRCREV = "7fb44f78bf33232aad587e87a799afcf576f9b47"
> +SRCREV = "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
>   SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
>              file://run_eval.sh \
>              file://run-ptest \

