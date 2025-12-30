Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD74CE92722
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 03:23:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.58004.1767064996467708556
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 19:23:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UeHKU6FA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54599ffcd1=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU1f4ZI2884790;
	Mon, 29 Dec 2025 19:23:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=9wA1tRNjxyWOOFDHhAr1h4Y4rTyIPgdisbWNJJhg8oo=; b=UeHKU6FAatn8
	iJASxYmr7BbVDqstyRpS9tBshbiFPnDDF8/QM+fVIeh3pVSbu1vsKbtHfC4rSSRQ
	G+zw3dlouG/sDcF3rrL2QtQDcz27Q5NXsnSfkX/gPRhlYhH73GSiFklCkTfKy0Hl
	qiE3rnoxdmjdxfDa3kZlmKe0DX13yYqNnuCkO+VE/xP6oSm+ncG9vVxmci57Wk4w
	CiBpgqMYyH5v1s0OpaJaTdcVtOuqAUVy/jLauqv2tq3h5Sh6wkSbcJqQ9bNXylLX
	qFfZ5HoVJYiOajhk4Ch2rI5JilwRCavGIvD6hI45wW7cq/LCcyUPGOW6koR/qlD8
	zdiG6AhE+Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4babm22a81-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 19:23:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awq3k8slkjy+SXgKtZtMlapMrlvouvg9viPbGnKZ+3I1yKROI2jcDHRTnUinjkiP8jAZzmXRS4X5Wraw7oWtt9KBu7jtv9oVAnIDXCeN+4cfiCNDfzp6lR14wpx5yHPE2KJVnNwnsemiydryMOBui30GYDwIp/5JcyKw/UAL1oxyRIRyRoel7dJCye7XIio6OtIzi+sbcTWHOPOrcTufQogQZcZTFX4gGadgGCHlw4CnQ+HYsauBWuR46cTKWJBU8uuyFgPio2smoO3RUucRJMIQcnLdCvm00uODDFVxccoxUXs7s0qc1oVoL0uBnFa7dhgBT+e6yTEdhcwV7Saawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wA1tRNjxyWOOFDHhAr1h4Y4rTyIPgdisbWNJJhg8oo=;
 b=o5mgtmyHTj8OOTZ2ZKE/ATAaChElqCckOAEZUJPVJpnqdzA6TiiLLluHSRyUAELdhjmOm8KGyVwjSJt6lptzbgcaLqlZeoxFot+HRwUwupFG2l4L91MUc/2yU2eeUIVjeyrPvqPhJ6TfEjXASpYUap+SiwIyWRVG+fJI+My8wFuhZgSxFx3RkIyrCMx1a2dzTRc1btx8n85BsJ5tcMBvJJ8nqpbfeLqMNJYUA1hxQa3ypyNee0Scv3Sk5lcxcsfJBlbeYvN96zrVtnaqsR8VlCsxbO+ocTM59OvWYg91QBrXzDOXgimZDGsj6SIWYqRvnNshqpfRbc0mrjpIPsJqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 LV8PR11MB8677.namprd11.prod.outlook.com (2603:10b6:408:1fa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 03:23:12 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 03:23:12 +0000
Message-ID: <98922eaf-0ab3-4dcb-8a77-65eda40be1b1@windriver.com>
Date: Tue, 30 Dec 2025 11:23:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH/V6] refpolicy: Add support
 to configure policy store root
To: yocto-patches@lists.yoctoproject.org,
        Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
References: <20251229090000.3305357-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20251229090000.3305357-1-quic_sasikuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|LV8PR11MB8677:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c326a7-537f-4569-2881-08de4752c2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K1N3VUdsT2pTVk52bTd2MGptd1VuZ2dMWUFmMDNUK2hVa2QrOXp1dmpoZ2U4?=
 =?utf-8?B?ak1vR2Z2VFBYaEJFVkJFWXNZTkJMdEgzMXgvUGZqcWJ0U1Rwb3FlTFZmSis0?=
 =?utf-8?B?QnRWc1ltd3ZjZDJUa3JyRGw3dlVpQlI5aU9TeXhEOGFqTDNhbE1ZaGV1c21Q?=
 =?utf-8?B?UVdiZ0VjbzNBVGxvUTl5QzZBVWg2aDcvaGRnKzhObmtxeFIwVm0rN2MycDJq?=
 =?utf-8?B?dDBEbFY5TkFlUE53V1piSU8vYmlBQUNHWXR3ekhKRnVMT1RuS0x2SXlielo0?=
 =?utf-8?B?Nm1ONStyYytDUi9Lc1p0RS9maUplVTVWSEVOZmppeXE3enNKWUUvVXVubWRG?=
 =?utf-8?B?cDJsdDRHTldEMUZPOG9ZWk5mQUhVazlmTHpDbkxpWGt1U3c5dlpQSUF5UUFN?=
 =?utf-8?B?SERXajBGb2gxdUtFRVNGMzE2VGpZdzlZT2tXcWpRcmtlVXV1LzBIZU0rSHd5?=
 =?utf-8?B?dVdlQmxJVFhEczRoMVVwUkRYbmx4SWlvSXllK0dBeGNvcVNKL3JyTVRZWjVY?=
 =?utf-8?B?d25aNjhwTGRKOG9qRVo0WERVT2l4dmpOV3pWT2g3Um9SLzRPczFtSGdWM01N?=
 =?utf-8?B?QVh5aXV0OWVOSTdBdlBMeW5ZNEY5RFVCT3NhSnJkb3Y5YktQeWRGdzd5K0hK?=
 =?utf-8?B?MmdrMlpRblBvREQyclJIdTBiT0VDWDhEQWl5UHBUYjdBbURkQUhHeFVqdWRT?=
 =?utf-8?B?QVZUcnFIWGtuMzlQL01VUFJyUmozN0NZNWhjS0FYb3B0TlZzRTgyL1I1SlNx?=
 =?utf-8?B?Zkx6VHlJTWhYUmQxaWpMUDM1aW5nSmU3RW1ONXVJeEMva01tYlU0S0NuVDB5?=
 =?utf-8?B?c3FGWjFVOElRVkhFdHE4WHg0aFl4cUhYZWJ3bi8zWTRaZ1JHOU9ncjVCUFJX?=
 =?utf-8?B?RE4ydHU2dFlJNmlpTWhFRHhJb2pjN2xTYm5RQk53S2VhQklTYkNJTm43eHpX?=
 =?utf-8?B?UG4zOE5LQVQxTFBBRXZVTTRyS1JMZGZjSHMrMmdhK3dEcG5VRXRsOHJRYkFo?=
 =?utf-8?B?UElHOHVmU09CMk9wVHJNTU5RcCtKQWFNanhqTVpxczJZNGhTY0c3QmpNVytO?=
 =?utf-8?B?aXNONm8ySmlXWm5iZkRjcFNRWDIxWGtabk9TeXV5UElKcTNhK2tnVlQ4NTBR?=
 =?utf-8?B?ZTRBdmRiSFE4K2NXS3p0cWMwVDc3MTRhWHB3dnpBOFR4U3o0MzFMbHRhQlQr?=
 =?utf-8?B?b2EzZGsyS2UwcktpZ3JxMm12Y3FSYXRNdTdCQ3I2Vy9zWmRvU083VENEU3NB?=
 =?utf-8?B?SkFQejJ3ZkFiN0JMbmR5UTVGNDVHYXlXOTZ2cWVPbmtURDZUWEl5c3RSOVZT?=
 =?utf-8?B?TjhaZjltYlVmNFNEbzZOZDk5QXYwbVdVa2pJS3EyMFIvTHNIVW1mNFcrNXhM?=
 =?utf-8?B?dHprZ2luKzJVUE81WjlyMkFHTXcrME9INmhaUjduUk9IdzQyNDN3RzZSeVpB?=
 =?utf-8?B?WXVXRnZoTnZRRUhRS1U1TjltdnFCSGYvYi9FL0szUkVvV0xha1F6NytWK3Mx?=
 =?utf-8?B?TExoT3pLbWNlZzFDVkg4MTRlOTFhOXZSWElDdVNSNHVFWTdxQXlXYUhkRlZ5?=
 =?utf-8?B?NnFoand4OThVcFNuYU1sUUlTNG5MTjVqYXpEb05YUEpWNXd1eVZvZ3BBWFRE?=
 =?utf-8?B?bVpxeTlRb0dEYWtOTlRyRW45ZjlwaDFCYVRkTnEzdi92VUc1NGcwaG5GcTh1?=
 =?utf-8?B?cUEwdHR4YjFCb2dLaldKUGF4VkJFZHZsNk40NEN4Y29ZMDFGY25BWTc5Yjdl?=
 =?utf-8?B?MWUrSEVRMkM2Nk1ibUVSM3NhWFRyR1V0WlFuOXBHakRqbWV1dlNHa3Rxa2cw?=
 =?utf-8?B?MHZDK0pJeWlBcTNUUHN1QVMzcnozN2FKa25qbENaL0psNGR1d0VuNXdMM01j?=
 =?utf-8?B?dE5lUmFGRlBoSlVwUzRNN3J2RXFmeFNhRnRtc1NoajF5WmxWem5TcE5EWHZT?=
 =?utf-8?Q?vs7NP+FMQw33sVQ1cgEj55/3xicyvNGL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YldpOU5teXhKakZ4bTR1RVdvVVNlRmsrTXhMMGdKUDFQNmFpR1djd0tQelpx?=
 =?utf-8?B?b2hSanB4UDBrdE43dEVUVXF2RlA5R1pMdXpuV01sME9zbGdjb0pCaVVJVmJ1?=
 =?utf-8?B?bnlXczVCTW5lb01uTFlGNnBBb3A5d1N0MTBuaFRRZldQMldqUHdtWmIvL24v?=
 =?utf-8?B?T0lnR1FQd2lobXgxRExBY2RZNm0zNVNUK3puVGVJRnovWnNrYTl3N3BySG91?=
 =?utf-8?B?TnBMbkVGWFZjRUNyenpQeXZpWEhISUhsNG44N2pLTi9EM29MMXBDeXFSbVNO?=
 =?utf-8?B?dVViR2NPQlpReUhMUHFvTXh1SkxFdHBDNkI3bTUyc01qMEZhNEI1QkNQMDJ0?=
 =?utf-8?B?QjBUSnNDUm94cVpCL0NZNGtlWExCN0U4NU1EQlYvOWk5Y0hlSXZKckQ2c2w5?=
 =?utf-8?B?WnE3a3VEQU5OSTNhWDhlSG1qT3BTNHYxS0M3ekhZbUx4clBzQytnaE45aTRu?=
 =?utf-8?B?NjJYY1M5aUQxRVRVNS9XL2l6aXR4UkxoamVVaU9HeDBCOXg3cmQ4TXFRa1o0?=
 =?utf-8?B?U3VrLzZyR1NnT0dQcUhGYmdveHdSYnlFRzZEaWkzTjdxd2t2Slo2RnhrQk9M?=
 =?utf-8?B?T1BLZDBkYjdyUTFCMTZwaWJWRGRJLzY2cVltd3crU3poSFlGTERHUURZN2ZK?=
 =?utf-8?B?SmpOZ05IQkNZVEI2a01mRjlVZWI3czBUOFBNNy9rcVNXSnEzREo1NHU2S2xq?=
 =?utf-8?B?WnVyTUZaVXJBREtyYUhDYm1PY2pOelMyYlpMdEZaaU9uc3BTS01EZnFQSm5Z?=
 =?utf-8?B?VEhZU2owWG40c2tCUnhpb0Jrcm5QTWF0bXJ0TVg2anZXUlp5c25mYWVjWnhj?=
 =?utf-8?B?NWdZVHZEUTI2WjAzYXZjOS9MaHdCdHBHTmxueXRMcEpnZUticm5Mc2lzMDA1?=
 =?utf-8?B?Wm9nSGJ2SnRyVnRibDZwNS9UUFQzUFY1d0NnbDRiTjFCajdtNy9zbXpXWXEy?=
 =?utf-8?B?cURFdWVnamQ4N01sZkxWWllZemRWRWJjSTNqRVI5dmo1ZEpZS05BY1pFT05y?=
 =?utf-8?B?VkwyUXo4REh6SENReFROOUZBSkhOd0hSaUdldERPeFpUSk95QktjWmFPUTg2?=
 =?utf-8?B?ZUJ0cjlnN20vdzY3ZUVtUnEyTDc4a3g4K3JZNEptYjZSakVTR2c3QTZ0L3M2?=
 =?utf-8?B?VWZSeFdMWnlDcEQ3eHRnTlhNQWp0bHZSSGtJNmRJdUJSVzlPMHp4enUvNTlB?=
 =?utf-8?B?WHpGcjdNZE14VWhEa1lOWCtHeHorY1RGRzdPT2xjSHFzd1RucEoxYVFQRDh3?=
 =?utf-8?B?UmVIa0I2WjlNU0JLZEt6UkR1Mnl3Q09jYXVsWnFtR0dUMDl1NUFxOWJSTmRq?=
 =?utf-8?B?Z2hidlZFN2hsQSt0a29PMi9qMVNuOEthOFVGWTY4MmJGNkpHRy82VWZCZVRG?=
 =?utf-8?B?Y0JPVlZBUEFkV2VsN01ONzJyaE1za0pEZlduTlp6a1ExS3J1RmMxL3NTWVlr?=
 =?utf-8?B?RUZEb0c5R3QxbkUxMVdXajBqdFNiN3Q3aEZiMm9DK0ppNFlSTFRxWUo5eE5T?=
 =?utf-8?B?WlFXVFphUjF0ajhydlZ1SG5MNU93ZnE4R2FsYVpCZUhEci9FZUlOdEFHR0dU?=
 =?utf-8?B?Yjd6QkU4OXlKdDNicGpURnNIWTRnQzIwUksvdnlDd2RKSDhlelREMllTNDds?=
 =?utf-8?B?cXlsVG1hd0tCOHpTN0VEaDBnbDhkVTZNdUtJYzJrQ1ZGdzBMNWpJa3E0ZUln?=
 =?utf-8?B?OFVDanV0QlhUNWZ2Q3NpRTdYbFYvT25WcEpxOE9keHFpd2xqa0tKZ2RNbWpV?=
 =?utf-8?B?K2Zya2xVUW1hZ25qdU9YMTNySTFMUzFhU3VVQTI4TnZncG5ja2N0T1JBaWZj?=
 =?utf-8?B?eEFyWDJhNlFyL3p0cEJNT29wNHFxcGZZSGJEenNvVlRzalJ4RzdYVUJhaEs0?=
 =?utf-8?B?RVdDREgySllQTXF6ZVJKbGhBZlVhWjVjSDROeDlyS3o1Z21xTkM5U1V6cVVP?=
 =?utf-8?B?VmdybmJqQWc2VlhJYmpmRXZNUDFYTC83RkVHVFJwQXQxLzRrakhyYnJ1anpo?=
 =?utf-8?B?Mk9IMnB1Z01LSFVwODZ3bnpKanNYaTBCSVVJS3QwOU9ocGlXc1pXV3lyWFZt?=
 =?utf-8?B?bURaaEE1R3JodE53cmxzUkJEamJFLytBZ01DajFqYnBFQ3QzaktFN0hkNk04?=
 =?utf-8?B?YUZzOHdHeG92bWFxVEtLMDZZUlBOVHR1M2xlQ2dYMTFUTkhmaTlMaTFTZ3Y4?=
 =?utf-8?B?V3RiN2UzeVkwdjVIUFpoZ3RJT0JVQ1dvQzQ4T2NjdkV4V1BFTWlPakg1ZmlY?=
 =?utf-8?B?SHRLRnlkZUFmZjlGUmpPMjZVVEZRY1l6MDhyU294L0FCMkIzY2hiUFhPdDdl?=
 =?utf-8?B?bDk4SnpSdng1dDQ3U2IwYjRxYzhrbXFnYTBRQVVRbzRaaHkyaWZOQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c326a7-537f-4569-2881-08de4752c2ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 03:23:11.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVYCfXXNZ2xUvKwU+8IhS8oSvDfXTQnQdz1EU+xeAKxsyURM5IQF4JCRrWouDZMK2/V7CwNvrkcM3GNjweESyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8677
X-Proofpoint-ORIG-GUID: huFeXjOoLWCzkZPugJIBwqf-5MrEKR3X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDAzMCBTYWx0ZWRfX3HYa97nQNwXs
 5ufd62MlNK2eJmvmzZtyXv0DES9gPIEPqJFgi6AJZh3KzolDzl6g3Thq7J41cljyC3Pc1Y8sDEg
 45zeotew1tEvlLdU0DdTOTSSzbwHRHC4alrsHR7Uv0AgPW4zhOppEAsp4NAzvDduSmwdZIsvF85
 NM7mYjJkezfZDCNq8318m+4iH1vxSgrOoNmRxqeTo+2N+DBLMmfAeP1V+2UDYOYqAkIpjU8uBsJ
 PX7COG2qUtnFkjbAGsfhsF2ILFUSoUR8jNCpujEzNaqGXGUT7ae1E+oRlW9V2b8Tyj2AI7Jy7p6
 FgfBoqnT52mmxlIc/cWwmAyR7Qr8J4L+EJZV1NuIy17oyX2wop99KMbgwdeZBUz04mvNxMiKe2B
 rF+Tmi9De62N8o5UqE2ey1Km3cmknmnrp/K5LeBLn3ySUy15tzD+oFvvaMAccF3TNtMWrukMPUW
 qRsZ4CfIRReSDR4K/Wg==
X-Proofpoint-GUID: huFeXjOoLWCzkZPugJIBwqf-5MrEKR3X
X-Authority-Analysis: v=2.4 cv=bN0b4f+Z c=1 sm=1 tr=0 ts=695345a3 cx=c_pps
 a=UIgYboCJ6PpLVfK8zyfvEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=MR3xLmAU5zZSSGEm4lEA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300030
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 03:23:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2884

I encountered the following error when building refpolicy-minimum using 
a custom POLICY_STORE_ROOT:
tmp/work/qemux86_64-poky-linux/refpolicy-minimum/2.20250923+git/image/var/lib/sel/minimum. 
(No such file or directory).
libsemanage.semanage_direct_connect: could not establish direct 
connection (No such file or directory).

The changes in refpolicy_common.inc also need to be added to the 
refpolicy-minimum recipe.


//Yi


On 12/29/25 17:00, Sasi Kumar Maddineni (QUIC) via 
lists.yoctoproject.org wrote:
> By default, policy modules(*.pp) are stored in /var directory.
> Features like: ostree remove files in folders like /var
> variable data directory while build time.
>
> Added support for custom policy store. We can now configure
> path to custom policy store to variable `POLICY_STORE_ROOT`.
>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   .../refpolicy/refpolicy_common.inc            |  9 ++++++---
>   recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
>   2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 964906b..59dfecd 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -77,10 +77,12 @@ SRC_URI += " \
>   S = "${UNPACKDIR}/refpolicy"
>   
>   CONFFILES:${PN} = "${sysconfdir}/selinux/config"
> +
> +POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
>   FILES:${PN} += " \
>       ${sysconfdir}/selinux/${POLICY_NAME}/ \
>       ${datadir}/selinux/${POLICY_NAME}/*.pp \
> -    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
> +    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
>       "
>   FILES:${PN}-dev =+ " \
>       ${datadir}/selinux/${POLICY_NAME}/include/ \
> @@ -165,7 +167,7 @@ prepare_policy_store() {
>       oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
>       POL_PRIORITY=100
>       POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
> -    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
> +    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
>       POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
>   
>       # Prepare to create policy store
> @@ -207,13 +209,14 @@ args = \$@
>   [end]
>   
>   policy-version = 35
> +store-root = "${POLICY_STORE_ROOT}"
>   EOF
>   
>       # Create policy store and build the policy
>       semodule -p ${D} -s ${POLICY_NAME} -n -B
>       rm -f ${D}${sysconfdir}/selinux/semanage.conf
>       # No need to leave final dir created by semanage laying around
> -    rm -rf ${D}${localstatedir}/lib/selinux/final
> +    rm -rf ${D}${POLICY_STORE_ROOT}/final
>   }
>   
>   install_misc_files() {
> diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
> index 2425a2e..1279cce 100644
> --- a/recipes-security/selinux/libsemanage_3.9.bb
> +++ b/recipes-security/selinux/libsemanage_3.9.bb
> @@ -32,6 +32,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \
>   FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
>   FILES:${PN} += "${libexecdir}"
>   
> +POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
> +
>   do_compile:append() {
>       oe_runmake pywrap \
>           PYLIBVER='python${PYTHON_BASEVERSION}' \
> @@ -46,9 +48,21 @@ do_install:append() {
>           PYLIBVER='python${PYTHON_BASEVERSION}' \
>           PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
>   
> -    # Update "policy-version" for semanage.conf
> -    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
> -        ${D}/etc/selinux/semanage.conf
> +    conf_file="${D}/etc/selinux/semanage.conf"
> +
> +    if [ -f "${conf_file}" ]; then
> +        # Update "policy-version" for semanage.conf
> +        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
> +            ${D}/etc/selinux/semanage.conf
> +
> +        # Update "store-root" for semanage.conf
> +        if grep -q '^store-root=' "${conf_file}"; then
> +            sed -i "s|^store-root=.*$|store-root=${POLICY_STORE_ROOT}|" "${conf_file}"
> +        else
> +            printf 'store-root=%s\n' "${POLICY_STORE_ROOT}" >> "${conf_file}"
> +        fi
> +    fi
> +
>   }
>   
>   BBCLASSEXTEND = "native"

