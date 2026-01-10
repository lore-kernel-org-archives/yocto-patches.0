Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E284D277EB
	for <webhook@archiver.kernel.org>; Sat, 10 Jan 2026 14:41:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9485.1768056066968663494
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 Jan 2026 06:41:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rRKoZ/VO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54702d1050=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60AEb9AS908906;
	Sat, 10 Jan 2026 06:41:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=9Ji1J7wBd6i/Tds1WW7cbsDKu7A7MNiSETrZpAhG+Cc=; b=rRKoZ/VObM8Q
	XUnHHetHiP/h7P2Yia/rd+5mLzjpWyvLQbS9DeMQC9kGbiLfab7v9fdNBnphwfMb
	KjUZtPXwPbHdye8MIm232+JN9dWPYwcZHplVeSC3rlcgXPg/hrTjQjtYmlC1YmUA
	EdgWelwcKuktbRVdzs41tJc2/WHaw642cjv4hDIVeILaTHXwA8ZsopeEgUJZUYAj
	48wZCalJOq8GO6wkAWhomFrOh7l2TPAHUxvnJGiJ9sVbXNBtDMStTKKRXJ8dtpOj
	NGXQlPVRYJQaOV11+lSE5Nepsvk8UfdzVdFruSNXNKpI1V/aY8o4lExTBQRAJC+5
	uUwuE907LQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bkq5fr1pv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 10 Jan 2026 06:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf9n/6ObrqusS8odkGD7Ht17/oya6VfJL9IHEOQmSCQ/fzfLEvVaR5ksiKC6Y9BKmnb3knlRpN7E7boPEIp96AAMkgHIVPWr7X4t8SaGFqOAoIOOt3sEOH6AT3s5MQzj6inl47Jlt1ac/6leDKnzD4sG6N2sIbRkYk7utZdQeaOS/oNrcKM+tcgdTLdLJ/9WJiFFBt8KG6HdhDNiogXhrqjvajvPlQo7rwixjsFPJSpkG9pNKw6wBr3QonbD8e6Sk7dLYPBWl8t7X/1Ycc36T0XP1PpZjw2AZimtvqnrfUSMR+Q9HwIFT7nTiO/B6DJVfjiji2THXNSdupC8zUOVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ji1J7wBd6i/Tds1WW7cbsDKu7A7MNiSETrZpAhG+Cc=;
 b=Z8r9uPS/uaR1HQbnXV9qsBkWDyjZXI9mPWfBX+eVYl0bfhQID/0i6/xO1a0h2Jn1BVpyF//hYbiKOGdbCsyhittqbR8wdWrUO6UmXK4ieS2E/0/yu9DkY6pE81mY61YPQAS0FphjydqO89gXANhHlinVvJcPl8HVG/0VB9yAmu4CCnLI/jVhwnMDfW/Uj7IW5S0Bt3K809CD+c9Cn0U9P34sBc4fnMcahsLNU+QcIuZoVWoqdlIVxp3v9cYPkULuKEi2rAy30I7SmFcsWvPgMsEJz6tT7GF9qII9HhDvSxuWz+3pSPyXTRz9Vr907XdcVELOLWNpH6ckQWxdQs/4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.6; Sat, 10 Jan 2026 14:41:04 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 14:41:04 +0000
Message-ID: <5045cb96-b893-4c24-8a82-2493e5c9d00d@windriver.com>
Date: Sat, 10 Jan 2026 22:40:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux,PATCH/V1] systemd: remove creation
 of backlight directory during build
To: yocto-patches@lists.yoctoproject.org,
        Jaihind Yadav <quic_jaihindy@quicinc.com>
References: <20260106070544.3668128-1-quic_jaihindy@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260106070544.3668128-1-quic_jaihindy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ecc219-8d08-488d-fabd-08de5056481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1hIWnZyUzZsMWdXTENwdDhmdDYxdlZmL09wbEkzK1Y4ZGhVNFBCSzdaOFlt?=
 =?utf-8?B?UWcxQ2JxcG1JbzhSTXVoRW5qd0U1dkZyQmN0VjVkMzdLclROSGNvckpjY3Np?=
 =?utf-8?B?YTRrRnZXYStMcDF6U1JCM3pPc3ZNbFowSm5iOUhNYjVzUHpnL1NuWG5udkhv?=
 =?utf-8?B?dkFnVHF6b0IzVTdpc2x3bmdiaGFMdnpwNjhGMUF1cGZOekNyREtxNjYyM0Fk?=
 =?utf-8?B?RXhiTmRxSjlEOFhEaXhQOVNRUXhQcnZtN3ZZcGdGbFVIWXJvTUNxSVd6R3Na?=
 =?utf-8?B?UjhVZFVueEhlUDI3R3NnWWx0eVh3c2ZjYTMyNnJGcDR2eXlROFdtb0hXM0ps?=
 =?utf-8?B?NGgvNDVnV1JxRWRXa2JkNzR2OVBJbHkxTjY4d0RYdHZFQU1LcThGVVVpdVVI?=
 =?utf-8?B?V2I3T3hRSG9pdys0L0tnbStlMFNEcGhVdlk4Yy82MUg1WDNoNjB6U25qTlpH?=
 =?utf-8?B?ZHp0Sit0MVQ3OXFObjJJVmxzdHhlaHBoQ1RPeng4NW11ell2WUJLRTcrTU1R?=
 =?utf-8?B?MmNVWFYxa1RURTFtSDExN2NQN25ncjRSRkt3bEJNWThCUW9JLzJ1SDFmQmNK?=
 =?utf-8?B?ZmE4ak5DVU8zMTlkNkxmaUd4U3hTSkJMQWNVSmNESXlDb3NkOFpFamZNcDFz?=
 =?utf-8?B?MUV2VUJRVDBLWTlGaEt3UFhNQ28rUUVCd25LRldDQXBudFdjRDg4eG44K0ps?=
 =?utf-8?B?eE1VRmVaMEEwSUtkS1dtT21tYjcyVEVMRG5tTFc3bVBaQ2NwTEZkeEpwOHBE?=
 =?utf-8?B?WEk2cThhS0poN0h4SUZ6NW9HZFFPUFczcGx1ZW1aUlRHTmJDSnoyTFVOcW5P?=
 =?utf-8?B?KytTcW9rdU1Ic0Q4cmNpVTJldWRmU3ZtYVg0bmE3aDF2ditLdm4rOHN5SVF2?=
 =?utf-8?B?N0tnb1YreUNKU0xLYUlmRSs0QmZvcHRtTzU4ejg2Y1Z2aFlJNjFnU29PKzlo?=
 =?utf-8?B?VlJrY0Z5SnJmcnVzS2w4eVd0L3M2QjFiY1k0dkdyY2QzMnBWekFLYVZDZjhs?=
 =?utf-8?B?M2MyMzJwVy84QkIyWnorUEtjSzRmSEpwWUE0TmRCWkxhVEJhSXdZcy8wbHM3?=
 =?utf-8?B?QUhyWWxUMWtGUXlnSFkxcGJ6bmNBT0RhS3ppUEp4ZmZqU243RlUyVE50bWRz?=
 =?utf-8?B?NHJ1L1lkalc0U21La2RGbXk3WHV0QStqN2prMzVYb254RmxlU01MZjZuWTcr?=
 =?utf-8?B?TStNNDFGN01pMmQwT2VHMW1KUnVjV1d3SVVtQUZNaHBtVW9IUGM5UzNKT3FR?=
 =?utf-8?B?R21PNWJLclZNRW1TdnVLZUNseTV6U2FQRkU2L1ZRT3pJR3FFbnRIU2syUU9N?=
 =?utf-8?B?VkpidEErdERLcHd1YTQ0YW1pbXVrREFuRGN6Y0JUUWRob3BkVUcraGJvaUcx?=
 =?utf-8?B?QThKN0lpM1kxdW10WTZFR1lKa3ZnUE1oU2NPMGNpUUhLVGVWY0JpTnBkVDh5?=
 =?utf-8?B?c0l6VGJtWFV1UDlEVTJaWDlKQ3BkRXNpMnlkM2x4dTNtMmFMVHozelZOa3Zn?=
 =?utf-8?B?M29TSEtxcmV0RHd4Mkl4OVV2NHVNRjU3ajRIdUc4OW5Jd3NWMDFRd3NsWVJw?=
 =?utf-8?B?bnczZlhyeFVPU0dSaTgrbm5HYjVORzZJWlhZcTNTUlhFYU1FWE5rdUtwMUlT?=
 =?utf-8?B?enBJSi9wZDFoSThZa2tHQkhqbXBRTXlOZG1VbkVxNGJ6bU1IZUdrWEJCNmFE?=
 =?utf-8?B?MmdPRXBvaEdOZWo1ZWZ6TnBYT09UT09kM1JUM24rSU1EUkpkSVpSNGNFOWFw?=
 =?utf-8?B?M3FEZVNZVVRWaXljODBTUFlHOG1HOXQ2OHBPTUMzSWRFK3VtZTUzTE5YVEM2?=
 =?utf-8?B?WWVIWUxhQ2VTa1pQQ1RYQVNpa1VYTXpEUG52T3ZTdHdTRGFMWncwSy9EUGJ0?=
 =?utf-8?B?aHJydTZwSFdoWmE4b1UxdW9Hb05rZUVTRzRCVlcveEdIK05rTStrUGVMNWV4?=
 =?utf-8?B?OE5VaFM2UDNBTmh3WVBJUDFVTUg2ci82U0xTMlR6bFk4MVRuN0hzS2lncHJB?=
 =?utf-8?B?c0RlR2NHVG5nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk5yTFZrWUNvempCNXBvUnYyam5qV1VuOTVOZ01iZmJoQmJnUEJ4MGwwd3dJ?=
 =?utf-8?B?WHNGa1ZQdUVzbXVTLzZwTk5TbEE1OCtHOXh4aDYxaURON1pDM0gxem51NS9C?=
 =?utf-8?B?RG00RWlqdU9nMHVtUk4zeUpVWGE5ZWZWcnQyYlhTU1NxQmJES3RXOVNDN01R?=
 =?utf-8?B?N216WGh5Z3pWNnlKejVuR3hPV01aMzR1T3Q3eCtsSWo1MEEvYTh6Q0w2RDZF?=
 =?utf-8?B?UVp5WlpQUzhQWlVvQmlyYkZTSC8xaHcrejBxLzVoTGV5ZDNFUFJ4NXEzSGVJ?=
 =?utf-8?B?RE5YMW5UYVNxY0VURFlWVWtyQmxrQldSelZ1VTdZZWo1dW9jcmZEYjJVQmtq?=
 =?utf-8?B?aGYxMVpVMlJ6cDJITFZkQTVTTElGdWxQaFBQNjV2c0llK2xGSWltVkh0Y1hF?=
 =?utf-8?B?YjZtc2dJSkZkNkcremlucU1vVE5mbmg3OVNHVFJtUmNzN2s1NXhMMTVweXlr?=
 =?utf-8?B?Q2Q5OHBUaFZoSDZCbVZ1ZnVUTXpzMnRmd0UzdDlyUXFSUWVuaVdRa1B3Q2ZV?=
 =?utf-8?B?MnhvU3hEVWNKV2YrdEc4UDYwWlBiZURyL2ZiVmpFQldHSEJHRXJJcjZyZXhY?=
 =?utf-8?B?NlFZN1QrRnVST3RRd1pSbHJOU2psWmFYWHhTeGZwa1J5RlUvQUpZRjNrRGlU?=
 =?utf-8?B?U2xlUmVLT1FxNVJod0VmaC9nb0hlcm5QYVI5dGJtLy9pSDF6N2FHa0NWbG42?=
 =?utf-8?B?TUtSaklURHJjOGNiOEhPMzQ4MitKSE1OWDhPQTE1SVd1OERvOFFCSWszZnNa?=
 =?utf-8?B?R1dQMXF6REZQcW1jdU5KWG9XTTVPNEE0QWJSeVNSY3NTY2pNTUdsbWdRWU9q?=
 =?utf-8?B?aHdoSTJPdEdnOVpmdHp2L0lSbFRTQ0VxUnhZcU9kYjMvTnpmQ3pmZWptS3RV?=
 =?utf-8?B?NC8zcmJVVXlrV3Y3Q0w4TjF1WmtBeHVhYWI1dStqUEdmTXcxZ0c4MHFlZko3?=
 =?utf-8?B?MDhmU0F0YWVqd3dLMEwwbWQ5RGN0MDVWTmFIdEF1NXJkSDBGV0xkOFJtRGdx?=
 =?utf-8?B?L2YzWWxJVXJTOWhIUXIzVUQwS0cwVnJrckpjVHJ4OVVhbzAzbHZKZzJSNlRx?=
 =?utf-8?B?V2ovR2pWOE80QXhYdDRJVldDTWx4dlpHMG9GampCQ1FyU3IyZVhydFAvem92?=
 =?utf-8?B?ODBwR3RDdzRSTkRSUUt1cW8yUks0NE1pc1hubDk5elpjUlM4ei9vL3h4MnUz?=
 =?utf-8?B?TGNTeUl1WTB3WkxWSG9FSEVYdmM3c21xNnJFazd0U2FkN0kxUENNYUdGY1Fs?=
 =?utf-8?B?emZZNmRickJ5OWY0N3BvaXZpQ3hLUXYyejN5N1ZHVlYwUUloSGFzUFhRVGhl?=
 =?utf-8?B?aWNqbUFXa25QTGh5ZDhSa2R2TFArU015YjJsS2ZxNXd1bEpobTRMeDV2RTNj?=
 =?utf-8?B?UGdWR2VmeThZQ3ByZXVLYTdkVFN0M3NSaWt3YlUwZVV6TE5Pd0d2c29GektF?=
 =?utf-8?B?RnlIMHJzVE0xc3RWN0ZtMUFPbm56TnNkbzN0NEEwbjhTYWtEZ0Zqclo2VG1r?=
 =?utf-8?B?ZWIraFBsU2NBK3VVUUVwMCtYY1h4bFJVbVBXY2lQMlZUV3lsb0FoMlYwMlh5?=
 =?utf-8?B?LzBLRTk4SmwxZmF5VldKelVNcC9SUzdENkpSaThJVEZZbjBEQkp5amhhMEtv?=
 =?utf-8?B?OUFoV3VWOUFkanE1eC9jV2w2Q0NRQUNRVDJ6cEZ3RHI3SmlBbWU4ekx0UGli?=
 =?utf-8?B?Q01Ja3phZFR2SEQyREdpS2VHK1lDZjNodDI3ekZzVmdjRDJwRU5ZN2o0cHBB?=
 =?utf-8?B?dnJTTXlXdWl3dDh0TVV6c3k1ZzBQdmtUQnYzOXl6TE82dzlrTEFZRkFrclhM?=
 =?utf-8?B?d0ZxNWh5QUJIUUZLaVRPQ3NoUkJ6aVJxdGd0dTc2NEt0K3RmY256VVdScXA3?=
 =?utf-8?B?Vk5UVTI5UFhnd0dpS1g5UEVQa1dieGpvZDNTV0RCeFJrSmJjK24reGJOckRX?=
 =?utf-8?B?cXFoSkhlWXlJVXNKd0drNHY1OHZrQjhtV1hwcWRIdkNISllrdkdyWmVQSlJz?=
 =?utf-8?B?MXA4WlZ5cWhDT2UxdWZUN1hLTHFDWUlkME1wbFkrRko2Q2NRY21tN1FHUkxC?=
 =?utf-8?B?TjhtNEd2TVBZNTNLMytaVkVVOHJYQVBMallLR3VSaExtY0F1azdsTE1iU1dF?=
 =?utf-8?B?eFhhdjNxQTlEUmltNExZRjRUUC9LdU5HQlVlKzR5bk5nK3JPZG9NemlxUmNQ?=
 =?utf-8?B?QXB3cDZYR1lhQTRMUTMrcFh5aTY2OFNEOFVkb1BycFJONWtncWhHaTA0Yk4w?=
 =?utf-8?B?SlgrU0d6Tm1jeGpJRkFCWFk3enVYZ3RRcHVtelBaN01JdTh1OFJYZWZoZEZ4?=
 =?utf-8?B?R0JIa2k1RjZmb2ttRXJvaWZac2VCaWdqU1NQbUlvd2ZXa01PSUwvQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ecc219-8d08-488d-fabd-08de5056481a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 14:41:04.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEDthaOJs9oSL3KXAEqw4LthWBpCVrNXub10oaOmJEZM4iBCCP/Xo8wtKlZFM7mXY2cqVxdUD+yeFwbyQeYMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-Authority-Analysis: v=2.4 cv=d/z4CBjE c=1 sm=1 tr=0 ts=69626502 cx=c_pps
 a=hhtN0wN0XYjGptQO8Yv39Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8 a=t7CeM3EgAAAA:8
 a=1VXCtZ5oiIZticidm-0A:9 a=QEXdDO2ut3YA:10 a=tOIqXpxfQm4A:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=TjNXssC_j7lpFel5tvFf:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDEyNyBTYWx0ZWRfX9AWbILaVqtgy
 mYoMmJ2thXBcvt3Z/ShtVveTf13ztuY3HRU3P9Ptk+ZheOS5VlJ9QjAreciC8M1G+zPdu5rWIuy
 6IxHQaLxEtFLznzdnlMHjd54fLpJNKTnjbFwdRCkfP8H3pKLJl4RfU2tgZO/ybDm8CtoBnpptVO
 56ngCUoD+gPy3Z8jGmypzplq0gWo8Hptk8iR4ZUH3ezARAvXbYvS/JiMyzxtZAKvhbk9zQxOnYb
 NvVCsyT/60T/g/B48ZVtHxAweSWf0UGjsD493G7nFUHU5Hko8mwJt+R9thsufn3biSPZJSYhhpN
 mial2lYEaJ8y5WV52tKI9dQLETA/zEbXdqzIFPxjOIecrI/ot5knvxYuH6ovDBfBc4Zau/ST5mk
 UEzRuOgwiJQnJWX7ms6b9+xpxR58D67suXTLqv8WpIZHKw2QtYbNV17rcY3wxV2zvizZHTQPCij
 LBTVj+8dgp6Zxj66iHQ==
X-Proofpoint-ORIG-GUID: 28fhmhTf8CDJNxd9Z0K2GEKBoe4GA8qB
X-Proofpoint-GUID: 28fhmhTf8CDJNxd9Z0K2GEKBoe4GA8qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601100127
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 Jan 2026 14:41:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2931


On 1/6/26 15:05, quic_jaihindy via lists.yoctoproject.org wrote:
> From: Jaihind Yadav <quic_jaihindy@quicinc.com>
>
> The recipe previously created ${localstatedir}/lib/systemd/backlight at
> build time when PACKAGECONFIG included 'backlight'.I Tested it on myboard
> and can see directory is correctly labeled by SELinux at runtime and the backlight
> service starts successfully without this step. Removing it simplifies
> the install process.
>
> Example SELinux labeling:
> ls -laZ /var/lib/systemd/
> drwxr-xr-x.  2 root root system_u:object_r:systemd_backlight_var_lib_t:s0 backlight
>
> Reference:
> Previous discussion and initial change:
> https://docs.yoctoproject.org/pipermail/yocto/2018-April/040854.html
>
> Signed-off-by: Jaihind Yadav <quic_jaihindy@quicinc.com>
> ---
>   recipes-core/systemd/systemd_selinux.inc | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/systemd/systemd_selinux.inc
> index 7d466ee..35411b2 100644
> --- a/recipes-core/systemd/systemd_selinux.inc
> +++ b/recipes-core/systemd/systemd_selinux.inc
> @@ -1,7 +1 @@
>   inherit enable-selinux enable-audit

I think we can move the line above to systemd_%.bbappend, like this:

inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 
'enable-selinux enable-audit', '', d)}

Then we can drop systemd_selinux.inc file.

//Yi


> -
> -do_install:append() {
> -	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false', d)}; then
> -		install -d ${D}${localstatedir}/lib/systemd/backlight
> -	fi
> -}
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2901): https://lists.yoctoproject.org/g/yocto-patches/message/2901
> Mute This Topic: https://lists.yoctoproject.org/mt/117101833/7283133
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy [yi.zhao@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

