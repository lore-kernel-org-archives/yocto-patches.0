Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61A7C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 13:46:41 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.19738.1724161598958043972
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 06:46:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8962190df6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5snYd003515;
	Tue, 20 Aug 2024 06:46:35 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412q542sss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKcmPICi+wNXA0nENvypIsCAKbPn9lcdzDtCH4yP53As68Aw65sNOPAs9czrA2gXszmlJ8WpkRZ5HQNJi3ZGe94ICsBsPFXVPRLKYPHEEajZnDuuh7Xu6GCU/xaHN47AFZQgkNiLHwizIq/+2kD8sW+AUV2au6ZTBiVLhPqU56zRTWluGZv4sp3BdGTeBoZ90a5NPxAcbbtUay0N/82a5td0jse0FrNAEss/I2gbn7OgpTNeIfoN9dDlwN9HLXJa2WduF9Av5QWJSEnKyrOAU50Ui6hqlLA6Poi6VlidrYL+tqCQVeGjd+HXglU4fpkxhqucCkGDrQrrWYCJ3rXVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiMRyI4BUpxT04m9ofF9KxJyjurOg2WZrg+vKKfHU60=;
 b=Y8eUVgxgyKY53r2JrdCFvs738O4q3LsFuMS2zIEQ9pTjKpn42VEzxpqAs7PUZGd7SUchExZ9JqxXYOq5FXTAc61rsca7C8LbUNv5UI/nCaKyQDGTEsLxpfDJvysQ6h4pHNs785Y96NPZgQ9e53Donw9LA+UCRFN8UeIb4I1JGS8dDZZmhMM2G5bxL7naSGLJZHKu9YoPW375oZMaWFO5nC3ynu2hXTQhc2RO9NkoLQEnaEKMM9t8L0Mgnb9x9K7aWnyHAz20nWADggXrDBKVhXRWqoXXd7ES2XmfBESLktk0jg8fp+z7eMwpS8d3lvnVAr1G5pUQPREkpaI7dV7v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Tue, 20 Aug 2024 13:46:26 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:46:26 +0000
Message-ID: <a6f9f35f-d640-421e-963a-be402d428977@windriver.com>
Date: Tue, 20 Aug 2024 21:46:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH 1/1] Add SELinux specific
 configuration snippet for busybox.
From: Yi Zhao <yi.zhao@windriver.com>
To: Joe MacDonald <joe@deserted.net>,
        Joe MacDonald <joe.macdonald@siemens.com>
Cc: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>,
        yocto-patches@lists.yoctoproject.org
References: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
 <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
 <ef6ee660-e678-45ef-b7ad-021b88d8616d@windriver.com>
Content-Language: en-US
In-Reply-To: <ef6ee660-e678-45ef-b7ad-021b88d8616d@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 961ed0d6-f831-4ea6-bd20-08dcc11e7c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MXppMno5Z3c3WXQzSkFYaVBFUENKWXhrZlpNOGtEazVJallwZkY1TW5LRlF2?=
 =?utf-8?B?cHp1VkNVMmQxUUxtcUtZOEJ5R3plNm1vTWxqVTJVYzh1VWkyOGhrR2lsQzlx?=
 =?utf-8?B?eVM4bENlVk1sdkl4cC82TXMrTGlHdlZjQzNLOEY3RUsreTlxbGw2QTRFdzlF?=
 =?utf-8?B?STUweVcrRDJNR2NWVUw2QkZrNHhBcDBRLzUrejRVQWhTU3ovVks4WENabS9S?=
 =?utf-8?B?VGpHUEhoSWZ2NUtpZU43bDBJMnJuaVdmeE5GVllPL3BnUzlLOGMvVmtrNHQz?=
 =?utf-8?B?QWxNaUljd2JLbW1hZ2NXQ29BVjFrMEZTNkV2TVFYYnhYRU02NFU2M3l3TEIw?=
 =?utf-8?B?WUhLL2E5dWppeDQ0QXZJWlpFcnN2K0F6eEJoRlRHV1cxUkdYK3hLbm5mNThR?=
 =?utf-8?B?WCtjd0NSN2ZlNncrYTBFMVUzOWwyS0VSZ09GTllweFU5RUgvWDg2NzJpMEJO?=
 =?utf-8?B?dFZjVllFSExWVEhoQ1loaDhKY09OVVJuZ2crendsMG42N3lRL0lLbGtBdGd4?=
 =?utf-8?B?YXdVenVtem9DSkk5a21sNXhGRE0rQ2hDeVpqb1A2QmlFZkx4NUZBcHdISTZy?=
 =?utf-8?B?amdaeHAxMWJIL1puYk1NNW51SmFWL0tDSmcyZkp2WGFCeUlDenhEQlRaQzdq?=
 =?utf-8?B?Mm5md0lGV2pWME9jQzh1WDlJUVY1UE9JUk4raWdXTHQ3QkoxVit6aDhuVFZB?=
 =?utf-8?B?Y1ZaU3Z2dHhXQTJKaXRtTDAyYXZ1NldqQ0s3eHVtVXNISGZ2QjV3ZEFubjJJ?=
 =?utf-8?B?NHd5eG56KzF6YmpVd2Q5TEw5eWZLNjE1cllVazRXTDVDNlAxTTQyTUI3d093?=
 =?utf-8?B?a2pmWitmd1RrakN3emsxR09JUVhqNkNRb3cxeEZtK3BDd1VyNkpvdnBEdVBj?=
 =?utf-8?B?dWFucCtrSWNPeGk0MC9HbGlzZzRSUGpZSUs5MXRjR1hTQTVmV1B0dnVNeHB3?=
 =?utf-8?B?bHNFMXcxK2FlVnVTQXNKM25YVDZtZXRPaGZXV2VsSHhZR3NGWmlTanFxMjJP?=
 =?utf-8?B?d2V2eW43b1dDTGdQSzF5YWJUb1dVRWliUGk3NWJ3SVNFMDdqdVZFNU1HdXZP?=
 =?utf-8?B?UnNwc1RNZVdXekZlajUyeGhUaE5GUTBDK0w4MlVGSFZ5bHJoamgwSzhEUW00?=
 =?utf-8?B?cG9VaUxJSno1dVFlc1o1bEVOZE1DdnlQaUI4QzFkVHdvTDBpUm9VUkdDUEQ2?=
 =?utf-8?B?ZDZVS0NkaSs4TE1GVitmWlVIb3EvOTZmTWVxWFFSNjNhYmI0emJyNklRNjR3?=
 =?utf-8?B?d2JjV0l4NGxrbkVNK1E4dmlHV3R1MXdRR1BrQk9ENUpPRGt4ck9mRDl4N3JU?=
 =?utf-8?B?NysrR2taQTR2RXNad2FVaWY2WmVTeUlMa3dPRlVrTUU5V3VtbDQrYXB3VXNx?=
 =?utf-8?B?SUtEQUtBVHBkZ2wwT0VxWkVvNlJpN1ZjZUxicWhoYys1b3IzWEk3N1NuT3Rt?=
 =?utf-8?B?eWtEQjhrTU9nUVlNOEV5OStDSVg4NDRqWlZESGdBODF4aWhpUXhUeVpRVzly?=
 =?utf-8?B?eGtKbXl1Ym5OdFJmME9VRFBHU0FyRW84bkErUzVLMWZzcEZLZDBwU0hyU1Rq?=
 =?utf-8?B?RklYdEdweDQ3U1BXQ3dPNVJjRnJlMnoxTEl2RlQyRVk0Sk5qdEhmRHdSMTln?=
 =?utf-8?B?WlUrbnkzYUVaT245czhMQTFybGZpNkVUbTdEREoxaDBKMmZtMVFJV29wZVQ5?=
 =?utf-8?B?dnhUUGdKbWwwQXdIQ2xUdzBzcmY3Q2JRL1dwM3U1YkJYTktBY2RTY1dEbDRF?=
 =?utf-8?B?QUEwTmUreGpsMlpQQ3QzSU00bHBIUTI1cVU4VkdEZ2pDRWZXcW4rQmx0SmFt?=
 =?utf-8?B?TUgzU3ExenQxdUc0bmFpZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW55dlVnOHJVbmlNMlM1UUVjTzJ6cXBVUGtydVpmQ05rZ3hVSEdtM3ZIT1h5?=
 =?utf-8?B?VmFIcElUZzFzV0dHejA0YUdSR1NwZzkxMG03c2hEZ0pqczROaHFMaTZmU1l0?=
 =?utf-8?B?TEdVQ1JRY0dUU1FIdld6Sk1EWkt6dCtrUk5rZm9BaXVwU1VvamFyRzhLS29N?=
 =?utf-8?B?K3VHV1JTb21YU0w5OFpqcnRKQjJrRTMzR3M0SDR0MDhaUEFUUkJabytaYTVx?=
 =?utf-8?B?eHZtamNLajV2OFNmQ3FFRUs5U0plN3g4Ty9QWUtNVEZZU1NlSDdFVmFPWGJO?=
 =?utf-8?B?bEkzVlZCVEk2RWlOZG13WllIbjQ5cUFLUEFwUTFhZTVLQUg1RFR5ZU53Z2Zs?=
 =?utf-8?B?V3NIQkIrV2x5Q3VpYmZPVUJkKzQzVUJlaUt3cjRXVHdKVjVjV0xNVWRvSW1p?=
 =?utf-8?B?Si9SdkUvdkdGQzFQMTdJcnFQN0lObkxtNjh1aklVM2kyamdZV2txMzZTMmVt?=
 =?utf-8?B?aE9uWUtnVGtodUhzKzFHU2h6bGtHMXJGSHUreVhNQ0VKN2hGOTZFV0YyaG52?=
 =?utf-8?B?U1pBSlk1Y0Vxd3pjVnRxZTJrVWdKRFFWempFVU5YMXlOMzhoTUdjQXVLVncy?=
 =?utf-8?B?VzA1WGpNQXk0RXpJTHVCdVZUMGprOUdNbkRETVVHZk5rbG9qQ3dTa2NJOWVD?=
 =?utf-8?B?Umt1VENBTDVIQmhyN2pidkY3bVQ5NTVDbzRIUUUwa0N1elN3dlNqM2RXS1ZE?=
 =?utf-8?B?K1BxYzZ6S3pZSXR0dXQ2eWVDaHpBZG42a3lLS0VYUzhjY2V2YTFxMCtoV1l0?=
 =?utf-8?B?OFRqSzNwd0xxUmROQWdEY29QMWs3aC9HOU5SUHk2NmE0bmlZMS9uNk14bjNx?=
 =?utf-8?B?QnFuN1JYRHRtU1BXSXQrL3JaZS9DakZPWE1sa09NR0Y5Y3BmRlV4cGlYVlpv?=
 =?utf-8?B?K3d2SENBYStkQ3hBdWRxOGFIamNUMnc4OU0zWDZlMEtndmZ3Y28xSUh3WkQv?=
 =?utf-8?B?Lys4dzFGNFRhd09oU2Q0K0V4YWxTRlVrdXV0dW02LzJrQ05JYVQ4d0d1SGJh?=
 =?utf-8?B?anpGNDJIV3NPSDNLd1E1Slo2UEJuZXZudnVodlo4YkR1Q0QyanEycWFSWHlw?=
 =?utf-8?B?TTNoMjVZU2h2c3FTRjhtZ1hlMlNTSGZVS0xiZjF5MHZaU0hON01iRWc4aHV2?=
 =?utf-8?B?dExMd0JYNVRZUDF2K1hOTVRZY0tkTVNhYW1sSzVLOGYxanVLdjROUjJBU3JU?=
 =?utf-8?B?YlNqOVczdTlsSmhXNEhhZm1JT1VVYVppVGNBV050OW51YkR1TTRpTHk1dndB?=
 =?utf-8?B?MFNRY1RuRTFBdWZPdEdsNGhOenZUUjJKYStyeGFQSmNiSm5iRzVDRFRkRXY4?=
 =?utf-8?B?TnF5YnBETit6dGVuVUhJTEUrWWgvRWljN3RhTEtSYTNTU3FxQWdScmlBVjM1?=
 =?utf-8?B?dzg3MCswV1VzamNTTVYwN3doRHVQbEVsVlMxS1pwY3hrUWtHZ3ZxeDFHY1FK?=
 =?utf-8?B?aThUQ05ULzFUMFVrSzFxRGtDTlQ3SDE4OVpzQUFGeWFUMDBYRVZQcmRKNDUr?=
 =?utf-8?B?ZnNVaGVJMTFib2J5L3BaYmxxcVo0Q1hGRWNTS05PWW5pZTV3ZEtRTHVzVjZw?=
 =?utf-8?B?NFZJWmNRM3hzYUtVcDUvd2pnVUZISURrUjAxRi9CM0Z3OERZTnlncnhtWlli?=
 =?utf-8?B?RFdhbmlVOW9TSFREc2xhNzd4MHZNU0srMUxJdFdMdmk4TURIdXlob2dvMkVk?=
 =?utf-8?B?aS9xUFIvVW93R2pEY3EwMHBXY1B3bGhXZWJxNUZWRVhXS2ROOW5FL0cycHY2?=
 =?utf-8?B?RllFMStqQzdkTm9Fa1NFRkxUOGF6QkNaN2dyejBJN3pJMDFqVVNyOUF6dUhR?=
 =?utf-8?B?dFljSStvYUN4QnZINm9yL2txVlBXcERyR0dVOGdLZ0JvdFkwVnJtWjNJMmI3?=
 =?utf-8?B?TmdCOWdsV3psc3Y5dWoycnI3RXdsMk1LRC9mTUdTak9zeVV1dXNVaWpSTEo4?=
 =?utf-8?B?dDNrQVpCVUNrYWx0Y2l2cGFWSE5hNjFaK1lBd3BGeGNYYTFXa2J6MWhwUUFT?=
 =?utf-8?B?QXNhV2xpQ25rU2xzQWQrQ0Q3TFp1SVp5dklnOE5Bam5KeDgzbmZqRlhVOWRy?=
 =?utf-8?B?UXNiRStNS3p1M0hKUG5ROUZpeVFyS2lUOWhZcmluVFNWK1dDMjIremhtU21p?=
 =?utf-8?Q?xlWkN4ijoSUW8ZVFdmR/UJnrL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961ed0d6-f831-4ea6-bd20-08dcc11e7c8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:46:26.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2H1NH/O4n1nT4095fI0gcmi577bka0NQ4NOIAJNO7bIBfn/XXZwsUY89EqW7XEKVU4WGPR3M8NvhT5hZSEl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-Proofpoint-GUID: TtKbi--MvYhVxcuif0vPPnmtBfX1PvL3
X-Proofpoint-ORIG-GUID: TtKbi--MvYhVxcuif0vPPnmtBfX1PvL3
X-Authority-Analysis: v=2.4 cv=b+3g4cGx c=1 sm=1 tr=0 ts=66c49e3a cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=iGHA9ds3AAAA:8 a=n9SCklZpAAAA:8
 a=505BBjbih4DutP26zJYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=MDYma9B3dblYkEs0OMj2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408200102
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 47K5snYd003515
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 13:46:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/534

Ping ...


//Yi


On 7/29/24 22:39, Yi Zhao wrote:
> Hi Joe,
>
>
> Would you please merge this patch into meta-selinux=C2=A0 layer ?
>
>
> Thanks,
>
> Yi
>
>
> On 6/24/24 17:02, Weisser, Pascal.ext via lists.yoctoproject.org wrote:
>> This patch adds a SELinux specific configuration snippet for busybox t=
o
>> enable SELinux support in busybox out of the box. This is needed to=20
>> enable
>> SELinux specific command line options for certain commands like ps -Z.
>>
>> Signed-off-by: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
>> ---
>> =C2=A0 recipes-core/busybox/busybox_selinux.inc | 6 ++++++
>> =C2=A0 recipes-core/busybox/files/selinux.cfg=C2=A0=C2=A0 | 1 +
>> =C2=A0 2 files changed, 7 insertions(+)
>> =C2=A0 create mode 100644 recipes-core/busybox/files/selinux.cfg
>>
>> diff --git a/recipes-core/busybox/busybox_selinux.inc=20
>> b/recipes-core/busybox/busybox_selinux.inc
>> index 740980f..ade30cf 100644
>> --- a/recipes-core/busybox/busybox_selinux.inc
>> +++ b/recipes-core/busybox/busybox_selinux.inc
>> @@ -1,3 +1,9 @@
>> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
>> +
>> +SRC_URI:append =3D " file://selinux.cfg"
>> +
>> +DEPENDS:append=C2=A0 =3D " libselinux"
>> +
>> =C2=A0 PTEST_BINDIR =3D "0"
>> =C2=A0 =C2=A0 FILES:${PN} +=3D "${libdir}/${PN}"
>> diff --git a/recipes-core/busybox/files/selinux.cfg=20
>> b/recipes-core/busybox/files/selinux.cfg
>> new file mode 100644
>> index 0000000..00aeb51
>> --- /dev/null
>> +++ b/recipes-core/busybox/files/selinux.cfg
>> @@ -0,0 +1 @@
>> +CONFIG_SELINUX=3Dy

