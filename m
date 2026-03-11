Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BEFD0633
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:47:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14780.1773211626357890186
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:47:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qAof8PUA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B6UScn2952749;
	Wed, 11 Mar 2026 06:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=asmZpyq5Lk0y6p1AQYENwJPsHzt9fXFCtqpYI+JKPck=; b=
	qAof8PUA7Is3cYGkH5XXEv9pDCnpSzzIhOTQnamXOqXTq5vLJXClMmHY1B3vDRyd
	8DV1Rj9GeZtDqu2bU3pypsX9Pdutbls4qSrjiZAbUMzXmE6wFUMZJINoJqWbDwnz
	LxZOV2a/tuXOCrxF71skQ6WgIBm4WZsPAPvdwOBgoQNM1uyY2OAOmDJHSWKa4fg/
	AoC3LvrGI2Jeo4j+SXrn7Zf68NEtoDP9xV70TxOaOU8x6ynjSZYsdSULH4B3wqFh
	d9ZVZy7kfnpsRSH4xMY6+WPKcdT5YBdyx4p3SqZvHpLVQSTF5E2PqavHycWJTsEw
	QHPeqfdLCPgkdlr1QzcxXA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r7ey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:47:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p32c3YvJWKwSgwOYCRneTdmCWGYnQg6iLflraAih7rwdL02vtYl8dyqZfnQVVrJUtR+yGSEuL/XX4fnEx+yEHGVhXqtzboayTHZBEyD4KtZ2mGcEjP3T5G4aT7tQ9lKk4pKJLXu5Rb+GlXeauPc9NSS31syDplSbJyDGZ/YKBAKLkO+33CoYvl2Wczxp0ERgw1iMGnBo0TFlZHmbXU2aYhUUFwSTYJEXwpGHYvCZEEoCOu/mO1LIY4pOLWinpZTbkhwV63Q3wPQdYMFe9NcJOZUeWe4IFYYXAOM6pEQ9m50OMy0FswN6aKqBiskzxr/4IPUwrh+Vi9x5lrhCVu+YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asmZpyq5Lk0y6p1AQYENwJPsHzt9fXFCtqpYI+JKPck=;
 b=WGoZhBJ92sFz3MoT7a1BB7VFO927+kN/y0fv7OdX6hLomboaW+HqrmkhDJyUwlN2cYtuMNeJ0L/rJpdw0XnGfi9QPAJ/Pcg4XJvFoVb+IhDKMnVX170yMNhDiXyoENqgKuuKM4mLdWe0ueXrac0yALNGLi/l5LDSfnYfeTbZX87OLdzW0eV0/nN07wOmIVopdZI2mwV/V0IKOe4l71GbMf6rcvBUAu0LBGa3V8DBfcsy/Ke9TGJslhDcnR5NE5ZfBfl4uLuxZXYzaib6BhVEcTLFqv3wcj6aSOVljnX8ZH3kMuer9CLjM4ebsTCsLmM8kuj7yfeN5lIUqpBnyPGReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:47:01 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:47:00 +0000
Message-ID: <e592b77d-b500-4e5e-b08a-624fce6e0d55@windriver.com>
Date: Wed, 11 Mar 2026 14:46:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [auh][PATCH 01/11] upgrade-helper.py: remove
 unused self.poky_git settings
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
References: <20260311063557.229656-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20260311063557.229656-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2PR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:100:55::31) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9138ea-8132-4e9e-d36b-08de7f39ff49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	032zABdRmspqdZ3NqoWxd2YaM4OlcByWTMQc90IMgedLA9susJ2dJYEnaF3FVl0oSMsguNPZcKcGbuV8IuAk/fyxmhe3vIfIZCDZGQ+1OZTmwn6izvSUqPiIjdpHnpmoz2PyN/POZNuNFsFb2R/ls6DjoOJmLe7xTqiVNOcBihlvf2+9SAtJKGTAoIbOMZzTfaRg9ZLsFiBPtV0Ar2ypj+ulyP2/4CNs9+bx/7i1hKmLxQblEXkFEbV62OrCUjf+ZEMrkeuCFS6GpkwJJJv5VwpOyi5vxaXKr00L/w7NVUNdCUrzXwjLoa/7g8k5V4FJYjhi1jxyKQe2yOrA+80xs/BPFKSeSgzS+vdCLwhVoUx90J0V+JCfRmvIMhXECdyQzwhXDBNtxoiNodSjGFVteHufCHMm8B2wqdro5Joy5jtbW8HOG6z7B+d7doDuDmeS06ev/uqWWiG535VEwOr4lSE1jOzOvSeVlHbcDFOfmyWWH1lg8Ki3Uopu5ruVV5u+VGwey6XYwMU0U2+efteRb4HmjoWhZHCvTYxCtrV8BBbtcqIQAnQYA57Cx137PP5W5KkQmY4R2CbxEuXQYspM4MxRuAjGdQWgcfPL8VzZ8ewIoUWOyVxHAAkCg5SomnE/8iXGhBl/n2b4tUgHwln/UEtB4/ZCebK+NZxpJdUDp+V5CpdILR4CI91Lji9obNEMc0yPKsB9ObK8mnFGoqN2NaCfrwLk05g1ruDUUHidXso=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LysvWmpCVTkzUHZDejh2RTNRUDVGem83NmVVdjFkZGQxcGZxM095SjhWQkNC?=
 =?utf-8?B?UmlYS3dGSi8wV0kraGtrWExpOU9QTURIN2F5YTg2azM3ZzNiSVZDc3lKM3c5?=
 =?utf-8?B?VVJaSytzN2ZDZ3puZ3dHZ2pKOTZMSk1ocGowMFlyOTlxRnBXU3NFdm9LdVNX?=
 =?utf-8?B?cEVuVThLYzYrSm12ajJONko0S0tSckQ5SEttSkM3ZTNnOU1MOVFHbUs4bFB3?=
 =?utf-8?B?dnVRLzQ2QzQxU2NBZmh6TkEwY3hzV3RtRFp2Snl1NmlVcllLK015ZHdMWGxN?=
 =?utf-8?B?OFVoN1ZHcUdQejBoclJJZUZsaC9JN3lzUm9TeFNaaUhyLzUrb1FnVUZNR2hX?=
 =?utf-8?B?Z1JHY1NwQ0lzeDBycEtGdHBnVmVGWlJNMGR6a1g3aXR3YWo1Z3dIOXRjMG4y?=
 =?utf-8?B?dVFwNU56b2tQZ0hqVWVmWGNUOTFXQkp3ZnJlWnZxdmw5MENqZlYxTTNEOXBO?=
 =?utf-8?B?dm50RUtRRmNyUUIyT240RGJpRUlYVFJ6VURtd3pnRTBoZ1VLTWhJNXE5Uko4?=
 =?utf-8?B?UjFWdG8rQjZ1RkRIOE1yRmxEc014QzNReDBYRHNidXRUaExYYlEwaXlaSC9K?=
 =?utf-8?B?Q2dHN3dHRks1R1ZSeklSTlJVanNzdkV0MngyUm0xdXJ2azg3STZBbUt1QjRS?=
 =?utf-8?B?R3F5OE1KRy82dnlYWFJwUzhtUEZaODhFM0d3dkk4VEhGRkFnSWNjcmdlY2FQ?=
 =?utf-8?B?UW15MndxQkk0akhYeENGVGJUTjZlOEJlT1k1VFZub0F4dkhndGo4Tys0SVcy?=
 =?utf-8?B?TVkyVGZQY3FvWTdueUV5dndLemxrc0RsbmV1Yktkc2czeUhDbXBJR2N1Q00y?=
 =?utf-8?B?K0hsVTFISG1WVkNNQk5vV0w2N2tXMUhETEZTMFpPSTluWGMzdVJ0QmtCa2RM?=
 =?utf-8?B?SDRIUEFQZHdDNkdWYzBuM3hEaFdsWkl2ekptaFFkTHB1QWJmVDNwNFpBNVRT?=
 =?utf-8?B?MlJRNzZYVEdNMVkxZVM1WFpLWHJyZXl1OTVURkZqc2tUMGt4UWZRY0RlUlpk?=
 =?utf-8?B?QU9sVGwxbW1TSW1IeUZKS2lzVGFJcW1EL2F2clZjTjBEaG9TbXUwWnZ1SzJt?=
 =?utf-8?B?SHFEQ0J1ME54ZnRHUmZycG5penJsdTUzcnl5Tkp1S05KUlViYmFETVRkaFBF?=
 =?utf-8?B?RStOci94TkF0VlVmNWI5M2tRcEtpM0FWVFJQRHRTS0FOZWxlcWI3QTJaZ01k?=
 =?utf-8?B?bnVnVi9OSFhYTG1pdUExRVltbHBxV1RodmRvRkt2S0FCSEpQL0ozQUdsMmda?=
 =?utf-8?B?eU1pYWd5UHlnR05qNmZocVB3K2RheFJndUs2dGw0L3NhK3RLVURGd3BMbGlz?=
 =?utf-8?B?YnZEWmlnZWo5VFhDaXhDamltcWxuVzNaQXFXNDR2aERJdjF4TkY2ZmYrbnhH?=
 =?utf-8?B?bXdjOUg3WUtEc1RhaUY3dmVCRXBDbHhEMXk5L3FGcHA4VGVmUGNhS0djM3Rj?=
 =?utf-8?B?VG5vRFNNUXFaSlo1dTlUWm85VnpuYmY3MHIwTW5WQ0kzVi9pUENpejBiRTg0?=
 =?utf-8?B?YnZnWWJtOFBndkhGenFUNEJaZDBxbUlGRGhua0tVRUJpMm8xTC9EU01DZ1BY?=
 =?utf-8?B?THRScnJLdEQzeWl6U0dvcnVWajBYWjFhVzFmT2dTZ3hiQlQzNE9JT1BMVEpH?=
 =?utf-8?B?TmlZc21IVmt6bkdRZ1k5Q0NuMmMwT0FLSUVoN1d4M0pOcVd4Q2RtcTREVENo?=
 =?utf-8?B?eWVLZnY3aGRKNmx6T29hWVdrQWwzU3YyQTJLQkJwOWxRWnFHdllNb00rdCs2?=
 =?utf-8?B?MUFIWTQxY3JwZFJBaWlzUGlDeVZxU0IyT2Y0OFN4bVVENS9BaktrenJUYWxa?=
 =?utf-8?B?bURqbjBmRGNVV2dhWjlUbWlsVnQzTnArQmtwRDd6aTExM0YrdjVLVStwdnl5?=
 =?utf-8?B?K09TQndiQ1A3QUlBMzRJQ25ZaEZRM2JRQnhLVlBsM2RtMFE2TDNEWEtVbEVE?=
 =?utf-8?B?MUErakZDbTNaWWhxWFZSWEpVa0pXa0RRMFRkR29WRVRlaGg4d2FXWVB5M21x?=
 =?utf-8?B?WFcrY0krQVVzTnk2QTFYWE1lRDEySlJQdVNhK2VtQmRWUTRSRldUeTJBS0hh?=
 =?utf-8?B?TEdOVWNaS3FuaHBIS2JneXZuSjMyaTEzZHpNd1EvNEVHU3FTUXpMQTl1Y0VN?=
 =?utf-8?B?bW1nc1hKNENUY2tScVIwdGREbW1vbXVycTlhemd5RUtUcXlxbmxIcW5WSTFp?=
 =?utf-8?B?bjN3dnZ4MTFUUHNrZ3FNNS9XYTU2TmFkaUw5L01hSkJ3K1FjUk9RcllxQlpI?=
 =?utf-8?B?OXU0RWduM0hsVTY1UFV4K1NaNkloSDdOWGY5cWNGNGZSK0hDZStVREovUXVo?=
 =?utf-8?B?SVJjZk8rUXhDdWt2T0tBbXV1U2Z5UWFLRTZRaVVLeTVVVXZxcE12Zz09?=
X-Exchange-RoutingPolicyChecked: 
	wGQcGTo+wZH3QNPgUQtXseP12Le35jMNW5c0GLfIBTl8MKVwmAopSjbV3aBJxFPnroH//afUSMUHS5ugN61jGBhxRXVLIxLHe8Z2JdeqCJW8G9rwiZQp1xgh9pR13TsZe3KZS+W5lEGupezv49QZYtbh2xHxBl4NNAPDHVa7ryvcsth4ndvj8xung5Szuz3t6fVdy6V+NBV8jqQXlbDRzCDVG0N0G80hyYrzXM9szkzks1lFiYP6THjXT+OdQu2HqLJzPfuqXoWZf/UwNJgBGsB4QWAZNKDwdKy+4lSf25hYbjorGzYAw0UoaDrmtNVpTMAHKiOVqY6fSHVq8/vaPw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9138ea-8132-4e9e-d36b-08de7f39ff49
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:47:00.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCvjxgiUW1nV41Pu9GeyzadowhxkWe8XtsMoKBq9WUVgsVsI0dryWU5jlguhM79rGeW6H455i7pWHKjX0oyK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10fe9 cx=c_pps
 a=F1HhE1toGRAZ88wdd1wKFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=L503Xrm6eU2yinHAwy0A:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: WvohSGZx6lwvxc6u0NnYhmjrsqAqI6b5
X-Proofpoint-GUID: WvohSGZx6lwvxc6u0NnYhmjrsqAqI6b5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXw7NlwlK0BLnk
 8UffC6Wa64KNRBGJJ1xOwtc/AB8QCFb0cqME/RBYTuYljG0HXeFJww8uaoLMjbW1Jm4/NipJUvf
 r3/miiQIFOuJFqgP9Ws3NOWKDrMFpVJRwcBdWYvRfQq3XRmSEFwzB+JXU6PXn6hjWN3uqb/OAn4
 tuWHju7WCEUrEfSdrnSiObGpb9U3S9QXfhOeAh0xbZVUDpROeu77p9ENrFLKWdE0KEWqfDXS1Um
 dziLLfXUkqum0Qe1YB5ekM9y7fP/zmD46s75FfYLnr9Ac4Sqj9c3lkLKulMmZ4n33Pl4g4v10yE
 rMHFvvZIHhH+UJyNAm5aQAv4Wre9XoSvuPj5kj/NAPHZ7UVavFV/uws9rSpJx06wFq3KV0DpdL7
 HUzvnUX/v/7oUFdp5CJwTRTbl/tlu6FQwbg7Om02b/BYmY5nZ2FBOKPYeKxUHvABKXSwUzw03hD
 IWOVm4DhfamTws/FsEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:47:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3413

Sorry, there's another patch that is missed in this patchset.
I'll send out V2.

Regards,
Qi

On 3/11/26 14:35, Chen Qi via lists.yoctoproject.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   upgrade-helper.py | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 2f38e0a..3b98f7c 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -184,11 +184,9 @@ class Updater(object):
>                       _layer_settings_error(s)
>   
>               self.git = Git(self.opts['layer_dir'])
> -            self.poky_git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
>           else:
>               # XXX: assume that the poky directory is the first entry in the PATH
>               self.git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
> -            self.poky_git = None
>           self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
>   
>           self.opts['send_email'] = self.args.send_emails



