Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56FFEDA17
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 01:05:43 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com (DM1PR04CU001.outbound.protection.outlook.com [52.101.61.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4442.1773795934011261137
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 18:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=lFW4bRQr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.61.17, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqIcDUKxwZIyGTae+ZRoZXveeVj/NXsypZTavBBKkVgIqnl5wCB6nFQGJswu1cnSZ9b7e79aFwAmgcPm0c3EFHP6f/oFhfpSGb7fLI3S9OPSIjMsS9xZ9aOG5d3mA61naCEJwlW2A+lExsBp+rBIEge9kTT5K4S98xl6AQq8Cimt3fTJIoYSE55TRK2gli51ufkYwuIxI0RJb5SqFK7Mcord6U5zT+d15f+M02D51g7bxgQcis3ABUc7N/2d9vck+MgCvlneWqotaDUhWbIK7cqF3z16zdOY06bhSvKSd5KyfrEMRLXJHY7RRXzvgG/U0fWVUuuer2HR4nw/CMivZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4KBVGw0hUg5EbmCeZcw+CC0aTdpTrBn7h5w41SGjT0=;
 b=eXlH1oAB2mPg4CibyU5WnDDoWZtYf2Dgkvi/99Z8UEJRc4fYtLHu7Pyr06KITAh3dt46cuE8RnXUbSdvhOl+i9TfAS5QYEljk9IapZdUATl/2/Viub6SwRyIrg+MfcW31/2euUCVcLO5DGsyhPEQPnpWLSvwKXOOK8Y1dLlwx3F+N/s9/snssbmR1yusxKaHuzBPczxLJf2NWzDMVoH3OI4HpSNh/CBr7lFegfMR8bSlrFSd6pg/3DRigWXS0QmgtL1fGuHlEHpelnz3RboaQb+3QAKR9dOBxaLwQgo17Y3iKDpqTofvlk0zwsNWNPmlbpwC9REwdz4yUetKDxBdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4KBVGw0hUg5EbmCeZcw+CC0aTdpTrBn7h5w41SGjT0=;
 b=lFW4bRQry6ks5drii/GgxRd6ncKzI5RGadgQSQl1cSSEVRzPK2KXAe45wgqFrMUiETgNm6A1GtnapePLnfdhryfhRKVvf3/Kyr5uiw9y0tJyKXoqSEEePh+FO+a9i7IoB6EHQxDeegQ1fA0aR/Q6blHqdaxD9QGeF23wTsJxTug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:05:30 +0000
Received: from SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc]) by SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc%6]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 01:05:29 +0000
Message-ID: <d23273ec-a148-409a-aea6-c0bd544836d8@amd.com>
Date: Tue, 17 Mar 2026 19:05:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: Fix
 PREFERRED_VERSION for zephyr-sdk-native
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com
References: <189A5C41295DB830.2162755@lists.yoctoproject.org>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <189A5C41295DB830.2162755@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To SA1PR12MB9004.namprd12.prod.outlook.com
 (2603:10b6:806:388::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9004:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cbd999-debd-4db4-b8e6-08de848a7274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	NBrHpH5ksOZLVgqEHtzdOZqYlFKKEePLd2IFKWThV4MNeDUnw4SpxWVAngQu7bPREE0CD8+2gARvrCuMjjku/WJFEPSKhW2LxyP8VJ+qmBpQkxFhIAhW2fSIOc7NQWNMAnyiNMSrjreByC0ta+5gJYjMbFxJnZlqtbLfYj927Srlul+s5dO+a2Cut+I98kJsoFp93oe/G5RQlVNeZ+eLnBewpvuWrw52ZN5iGiZUm/ntUCXKuVuoNn8QklXt3gW33hP9lgqQI7dHtGSxH7J1JqWYeOShiblWfKCMo0QkIH9vKATx78p3j7knRH3g2o+Oya7O1wxjfyTuTtg6Enj/6BWPc+D34A+A+p6+ufizc37yNg/q+IN9THt8z2omEURsZUryOZR92tez9/bvwafNus8L6OcgkbFfEcnRyLUj4u7wXV3fWboRyMQKNDfFrHpXMy/akJWf5lCMBLCdfZKi0X4LGyPZnHhfYmh7AtSweQwX5IlXMSmg98VzOCzGdy4JCPJLcgKSNWXv8khADu8aF5tQoAEbNtqwNb2e6H2dgSWSLrhCDnmP3qUA6Fr4v1W/aRhDZj7J+piiX7EFqqUwOF01XILh/kXcsiLQRsIWGYNSMFY7L2JrLJ8ruMQPALT0HG5Hr2a4MFZO9UPijCiJbJRFouMIEqeccj/7afjpacBHs9sBGCMXd0SXuTNpxMqNxahB1JhVR/Wxlh4DKskp0hLQCFtCARVMwmq/6G1vzcQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RE8wUnFvUEs0TDA4elU4VjRBWGEwdmlyQ3dESStFd2c5T282bzg2RWE3K1JB?=
 =?utf-8?B?RE5NK0VvV0c4Qzc0TEtmOW5ST3Flb2FUZFp1THZ6VFpWWVU2RldXQ295Vzhx?=
 =?utf-8?B?VldUa216UzF4SEhycG9kS29na3k1UFI5TmN0dDVKVHRURlBWVVNiYm82cVFh?=
 =?utf-8?B?a05UM212RU55YXhKQW1vZjZCZDlmclIvbUZxSVFTLytBVVRaWjd0dmptazNR?=
 =?utf-8?B?VFpGQk1ONDdOSWlhNW1UeTl5TURRRWFoendHOWx1c05wWDlZVWlSa0NSdnUy?=
 =?utf-8?B?YWo3Z2JSa1Roait5bGdWbVNyN1pSVG1nbG1VSS9jcmtUdkhZRDk5UGhvTnlQ?=
 =?utf-8?B?azFlSkFSK3ZFaWl5UkZLQ01WRmlwWnhITTFWbkI1YURCa2E1MWFyQVFSYmRo?=
 =?utf-8?B?MWZHMHJHTWVUVWJoQmlnbFh5Z2loelpITWJtRk1GeVk4dkFBSTNPeTREbzhO?=
 =?utf-8?B?Q3oyZHZYY0NDZ0dpeHB1aVlyRTVGZHBYdnRSUzltZWRGTC9ZNlNWWU50MzF5?=
 =?utf-8?B?Mmh4QXFxRHVTRzhNaFlSTFdYY2Z3Ykhvd01Mcyt4TjFlMk51T0J1d2svOXV4?=
 =?utf-8?B?dTg0K3pxMFUxOUZ4Tldnak1KVXBqenNINCtqQjVIVjZCRUIydTJRTGwvR3hZ?=
 =?utf-8?B?VjkxMms3ZWhoZkpud3d0d05wd1hlSlkxOW11NldZTHIxc1JBWnZRTmw5bXpM?=
 =?utf-8?B?RlNjd0diSjJSd2l5NzVidTVCUG1WVXJxVE9HVkZFQUNhR2NhaUhRSThzcmFx?=
 =?utf-8?B?WEUzenlJL1hNODlBNEhLdkVUbW5aSlpaUS95TGI2YWtrQk80OHB0d1hEQVlS?=
 =?utf-8?B?WHdKNFp5K1hqdkl0b0xTMUhTYXd0aGE3Wnh5dWZabXFsVU9zMWMreUtid1RX?=
 =?utf-8?B?Nkp6WUd3TzdWNC9lYnJHZC9NSkx4ZTZBQ0laa0c5a0h5c01sVDU0aFVDbUZI?=
 =?utf-8?B?Y0tWNHQxUFJPRk00WWczN1pCQUs1K1lmMExGWkhFMEJEMHlMRG94dzIwWnhn?=
 =?utf-8?B?QlJoZlZDYTBkSHUrLzNPN2IvM0tzUEVDSTE0MUVuZVJ6R3VvQUk1L0k4SWd2?=
 =?utf-8?B?UUFaOFdyV3JGUTVJc2dzU2xTaUJsUURrTUdGeE9JcUg4MkhGZVZMTlJ6b1lU?=
 =?utf-8?B?TVo2OXNHK1U4ckVlUit3WDhzbWViT3BtaldFNWlma1lMUWN5cFQ2WVMzdVlN?=
 =?utf-8?B?T1dyNXlmeXhCK1h1SVgxd0lrUDdUb0xiNU1tNHZ1Y1VSNXBqWHNqWnMvT3JD?=
 =?utf-8?B?eDJ0ald4VWlCdUVJYTJHVENDZFpWODRvei9QQkN5d3plUFZhVndvY3d1VDNI?=
 =?utf-8?B?R29FWjhUbEpWWk4rVTlmOGdhOGh5NndEdHZBczJzb0ZBdDF6N2pGY0JZMHVL?=
 =?utf-8?B?aXJoSkI1SnVOVnIxZXdROFpoc3V1bTRsTjVTQjh6cVRLTmFhRisyQU5IaVZF?=
 =?utf-8?B?M3J3cDdMVUMrYXZjQ01mMmg1ZEJmVTN4WHdVRldPUFhrQk53Nys0ZGFUMGVM?=
 =?utf-8?B?MkFMQXhRSWFuMFBCM0lDN0V0UG8xRXVRK1ZRMzNIRkV2TnRCYTJia1ZuVEJx?=
 =?utf-8?B?OXVpZldGVmdlc3J3eG1aNHBiekNhcDJhcU81VDE4bHRVQ0Nncmcvd1JtcFJE?=
 =?utf-8?B?MXgvc0V2blJXdlFCQzhsb3RFRXFuSkozUVRHU0JZNzlVcDVuclo5ZHBSN0Zy?=
 =?utf-8?B?UXl3c0c5ek40N1piWVN0dTBWQWtzcFlETVhkbHRUTWVveWYvTVRSSnhVLzFJ?=
 =?utf-8?B?MVQxODdWMmNPZTl0WE56ZkxpSFgxdHV4M1pZRm5BL3ZXU3pJOVl1THdwd2dq?=
 =?utf-8?B?angyT2Q2RmZpMkl5N1FCN0cxZ29FOW9pdEV2VVlvaHZoc0xNTWFhZG5TaFNH?=
 =?utf-8?B?NExFMmQ3bnI1UEExdno2RUdPS01OeW9oOHpRdGkzOUZ6dXZzNUF0ZGk5RXBj?=
 =?utf-8?B?ZjFVdjBBRkk5ZWcrTGNqazB4WGZWckZJS0pDa2ZPQTdFV1dtZEEzWXFBb3Ez?=
 =?utf-8?B?S1E4Mm5WTUU1MUIvUWFVU2k4d0RIQTRVbWJ2U0gyWVFDN3dMem56VGlsaGJY?=
 =?utf-8?B?MGszMEZtTGxwN3pGZ3dpOVB4aThqMDNFaXJBakZSbjRycjF6eUlBd3RPNEc3?=
 =?utf-8?B?ZlFsTUFmVWVqek5DWlZQYTAvTWlyYTkrQlVRZ1JLdGdQK0JLTllwVkRjM1dz?=
 =?utf-8?B?MGVuOExzYnhjajE4L2d1WG8xVFpodTNFbmZxQ0JMdXY2KzMzWno5S093NDZo?=
 =?utf-8?B?d05IZG5lT2tBbFNSZC83VXQ4WUFoNVZEYnJxR2NBZGY5QjQ3U1hibkJvb0l6?=
 =?utf-8?Q?+Um/wdVFordEBD4ysT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cbd999-debd-4db4-b8e6-08de848a7274
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:05:29.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnDTJD/l+5Imo1FKrip3cOgHCpx4uo5GcoOUom+ZfMjFzyBIx1E2W3cmkWHYc4T6E1w8Sh0Fen8D7RKHEL625w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 01:05:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3501

Hi Chee Yang,

Can you merge this patch for scarthgap ?

Thanks,
Sandeep

On 3/6/2026 2:00 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> zephyr-sdk is a native recipe, So fix PREFERRED_VERSION for
> zephyr-sdk-native.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   meta-zephyr-core/conf/layer.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
> index e355b3f..a01657a 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -23,4 +23,4 @@ addpylib ${LAYERDIR}/lib oeqa
>   
>   # Default to a stable version
>   PREFERRED_VERSION_zephyr-kernel ??= "3.6.0"
> -PREFERRED_VERSION_zephyr-sdk ??= "0.16.9"
> +PREFERRED_VERSION_zephyr-sdk-native ??= "0.16.9"

