Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF92EBFD0C
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 07:30:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.266905.1776065420424508393
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Apr 2026 00:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CDaiD8zP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8563c16634=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D50Qtg1927629;
	Mon, 13 Apr 2026 00:30:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ZsN8zyfFzrSdGvqRXTDsSf+sC0fMqhHNAaYYdTie9To=; b=
	CDaiD8zP/dYHTbKGT3un9O76z9+la8i5gx44lDpLkCLyIHwXZu3y3WTrCN3FjbBf
	O2Cx4SVRAr/iYJYc7PVYadb/7TCAqotZL1FJBHGLSWyYgtNLLeetO40hGyS76HJX
	8oWKlrVv/29sO7ft+qzUBqkDln/ixS5BD+MxZ4cdQTnuFqGg+EEcfHgyMiEB9Vcx
	H+R0HF9oWLLf+Hikk0curryhni5BEFVVzpxJK9u01oZXRloyvoZG6mQWi1owVUl/
	RjOXbC+hzhAAgP/dGUj2CUazd4uh5KVRPH6Dne5iSUWVZA9M9OY3/PT+fF6THJs9
	mUACN0LtfpMioIEaNgJUIA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dfntds708-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 00:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJkdcBVf4mCO86u6gZHwqUHZXSqbGGOSCWwZILRxrxjRzkAqed8Vhj98Dte0LW4hup7gPOBo4zWnUPxFq/taPh1b9Z/OIRYw/UQfZL6qyr6hqgec14eDlTswAD5ka69LH3wWFftO/KxTGQCjdtJ13g4AnrbBLjIk2RZjDfqaNypYd99CVk4vzEQFPlQr+lWSzonaNcOMfjc8zzvoMTkSbPxBBjixkf//JQ9lO7H0p/tU3LHtsa8ZMjpPGasFI0Zkf373AU1bHSxJxithYljxuvsWOmtxw1Tm4Oka8msZDRQUa7zFMPxbosR8KLP3By/za/h7WarGVVwQBWzHTjRG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsN8zyfFzrSdGvqRXTDsSf+sC0fMqhHNAaYYdTie9To=;
 b=lPgzWCgjiqkUa4rC0wCyZ4r/rb/8mNtpfI9CtsDmd2jtiBgpqe9HLYn4bxqNSqt9Gb4XaQYl+AETgdUlLiED/N4J+vg+ej2VQaLNgA1GQINwfPMcLVYl0oeJU3FCD/moowPWn8evba6f9msRGpP8IbGC1qNUW+kp8f/0vK9ZM7lxdd8BhGH76jW3mBnkoIwne0Q5802cG+hYA2pyYUID5I2epB5G9cQP5n5Sj3NwY0m2TEe7SQYo3V9xuCCpRmd4tqFZeRsQXrNOQe/lzxl8ZRRs7roImkNajq+HOWn+tFgcAi4mwmghQoMKB7DyxntQCVL5WXUvAeghHAE0gcPPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MN2PR11MB4744.namprd11.prod.outlook.com (2603:10b6:208:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 07:30:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:30:15 +0000
Message-ID: <fea512dc-96a9-4419-8ec1-f371ebe6992e@windriver.com>
Date: Mon, 13 Apr 2026 15:30:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][master][PATCH 3/4] selinux-python:
 extend SELinux tooling for native builds
References: <20260315124642.2968859-1-deeratho@cisco.com>
Content-Language: en-US
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
From: Yi Zhao <yi.zhao@windriver.com>
To: deeratho@cisco.com
In-Reply-To: <20260315124642.2968859-1-deeratho@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MN2PR11MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: 139ba886-6972-4b48-cae2-08de992e8150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	TWH8IRks/xXbc4b3mqYDbUdID6KkhNiHD4gXk5+FVckBzqmkKr4BvPygDpV5Vv4Y7oHT+Kko6xyKdM1J/T/DmfKDO81qj/632dZIer1fbzkw+1dPPtf3uXiIeVsZJIyI9lj7bZ/FDhbDymIAvXPE5QCA/dPyGuYWSylFFtVtig60yEpZytGozJv0TEC2+TMvotxg7DKVptCdQRNna0gn2G2TDX2SyqX+pYHpNnNvt0dvVVfn6oBal/JvoD3dZ8fdDz2rxwe3vHX4hGskaaE6Xn/WPh/7EDDR55ZIAHghuvc/FuSHm67XH9nlo3QkQZeKu6N796/QCocxjwykGZRvNp1gh5yulo1HVhHbWOYTkZz1+NGePvt50mHTG5YcyQPNrGnHU7Kcj8ZDA0uhSNWPcvrUeisvFHTWDorIWI9GuSHrPkZz6ElFBoOh2X0XT51dp8gkA+iNx7rXcbuJqrtFkgsneZnHZuDy1kIT8i4MOnlbsi95qOhCW5puYx3G1yl2XdXpLnDwy6xRK3wSnEDBtry+XnBNCMqRsULWoIIqp6igdeoxdXi3WzDlEmDECZ9tPDHo1evbKQWClQf+/zzoLdKzEYyQQSCMdYjZuCflnKSfQZM5KS0cE1uF9Kevj/ZJGFpD35sCs13cwk6wsbgx29Esy6bRjL+jMdf/NHMOl0bPhIHpCGl4YEPq0taye3RjMAKKDdjNL0rAPyx6tzXWnYnLHWDPb8zFqkKnyHDXUjY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1JXMDZHY2l2Zk43QVZ4ZVFZS3RHd0ZtUUZ2ajI3bml0bVBodkpPVmdqVHZC?=
 =?utf-8?B?TDVEalc3R3I1MHE2bTRDTzR2d1BNU3NEd0Z0a3U2ajdFSk1JendtUjJPeHd2?=
 =?utf-8?B?eXl3VzJXQWRLUEhTMzFyUXgxa2l1dmRoZnJkakJjeFlreGlYNlFqNG42VTZR?=
 =?utf-8?B?dTBueDkxNUpTUEJHUG1qYVZ3ZzVxSWk0YnhsUm83SXA3QlJxbDlRSE5pdEdt?=
 =?utf-8?B?eWx3Y0VTdE9qRGd0RmtHNzBzOGhiK1pkaGNXTmkvUjJ4YnhvSEk4WjBYd3Jr?=
 =?utf-8?B?K1pGK05lK3NiV244c05jS3dEekY0dk9oU3c2YTdxSW1aMVVZcmRwYmZxK2lp?=
 =?utf-8?B?Y242MkNKUDBkdmFIMXg3QXY2cDNydEw4N29UeVVqQWpUdVVwSklFa3FuWVMw?=
 =?utf-8?B?Z1BHc2dlVEd0dHBib1d2VXdqdWFSYWlHRXBzbHIyTGlOQmxRM0V0NURsWWJM?=
 =?utf-8?B?YXoxVkY4RmlSc1ovdHo3SHlKOFg3WDFLZFI5Sm8xQjBhNjkwck8vUDZhTmF0?=
 =?utf-8?B?KzJaWWNkbnF6SzBKL1VVZVNYYnJLeGMvUzFpVTl2eU95dmk3aytzelp2MlpZ?=
 =?utf-8?B?VWVEVkdGb3Q1ZnVmOUdud0Roc0JoZU5HWll3ejVSeVIxQU9kTm51NHdrNUVs?=
 =?utf-8?B?dTUzdGIyQnpQSy82bkdnaStya05ZYlBBUVNjNzlyb0M4ZmY4ZzRnSEFYM3gr?=
 =?utf-8?B?QnBvOC91RWZydVZGYjJvSlJuazQ3cEg1SEk1RExBUExuQkY5cTdvM3VMd3Jj?=
 =?utf-8?B?N0hiTmxlV0xNb2tNNTJoNFJJSU13eDhaQnVyVTJaelUvR0FRaUNFZ1BEYVQ4?=
 =?utf-8?B?OVlMdUZJOEZFaUpmMVh0QW4rTWtoa2ZEYmE0R1NuZkVYSjcranlZbXdoUGpF?=
 =?utf-8?B?OENPd2dQQUZLK3IxWGk1UU9WVXFHZVBFd1Nja1lPWHc2am1IVGlKdFhDWlc2?=
 =?utf-8?B?amVEZk5CQzNGcGxYTzQ1L21uYVc1NFRVOG1vcHBLYVpka1NEVG5kTE5UZkk2?=
 =?utf-8?B?Ym8xdnB6NUV0QVNvd0ZYU3B0Z0lUSkF0alZIS3RoN1d2aU1uMkREdWxRM2U3?=
 =?utf-8?B?OHNVMlFsZUZEZC9nY1FrOVFXck4ydm9lY2RKcFN1dGNRZ1Q5Q2dwMnVqWWtV?=
 =?utf-8?B?elZkc253ODI5dXRzVndpdktYb0l6SklteG9oTkxkQ0d1M3UvamZnVWZoQWZG?=
 =?utf-8?B?SCs0UHVWeUx4czJXc3JOWGJ6MGZ3VE1uZHBjNDM4ZkE0SmhuVm5pQW5sK1Fz?=
 =?utf-8?B?am90Y1RmVkx0MXhkQXdjNzNQTWMyRWh0d0lxbU1zQk9xSWV2V3NYRThRMVlM?=
 =?utf-8?B?b0pMcUZEK1ZGNDFHeDE2NlJHMTZrdWdqa3NVOXhQOTd5UWcra0hNUzRhT3p5?=
 =?utf-8?B?OW81dDRRYS9DSHZFTDdCTi9WTEtLNW0vOUxobzYvdEpIVzRIQzh3Q3d3Mm1i?=
 =?utf-8?B?b2NGSmsvenY4cVByWVYxWlpyQkRiSm84cnpueFE3eTNyVmVmdnNISWE3SVFn?=
 =?utf-8?B?UEF3KzJmb0RXZURIMFdsZXQvVU50K1FuUGxJTlBoWFVpN0RUaHNBY3VudkRE?=
 =?utf-8?B?aVZkNERpTFZzcEhHTGdTeExsRitrcExGV2EzVjZXU05XV2h5UnRveUF0TTJ0?=
 =?utf-8?B?Q1JsQXdVUDlSTFBWWEh6aW5pWnR2ODg0Z2hZOVZ5eXlPL056ZWNaYnY5SWU4?=
 =?utf-8?B?ejlyK3licEtscDl3YlN0TGtRUXlicVVPVGZEblRPeHRCbVRlMlRvbnlkZGJC?=
 =?utf-8?B?d0txbXBVc0Ntd0cxN0FPa0MvRmpDWEVsbkFnbTh4OHhQalp0azhNTzhWdC9s?=
 =?utf-8?B?eXN5eVFjK3lNVVVOYlVNbVR2b2JIUkl2N2hKWWFPY1B5dXd6ZWhoRnU4QVMy?=
 =?utf-8?B?eGlUdC91b2FmZzgzaVpCbVVaVFRsNEM3clBhTUMvYk96a0RWbXFvcU5TMTd3?=
 =?utf-8?B?Rm91dVErekdCaFVab3VpM0RrV3UvSUlUcXdrZ2YzT2JtdEovandWQitacllX?=
 =?utf-8?B?Y3dGcmV5aGQ5TjY4d3JpMnR6MytGdjNEZUVYZWVabjRuZlQ3ZDZlV1BSemNT?=
 =?utf-8?B?RDEzck9iOG54enRQL0F0VGdFOUVBVHhNOFlsaVhqdGgyYmU0ZzhrL21WQTNW?=
 =?utf-8?B?RUhEaGhmRFRCa25hN1A2MkNTZXpjWGhxMEF2Znp2bnNxcHorMVBXRENOVlY1?=
 =?utf-8?B?aGFuR0thUUNRblB0Mms5K3poR2V2OFhCODZ2amtKVEVPT0JjYnRiZjBwYUR5?=
 =?utf-8?B?MW5ZZVZyUUVaQzVUMi9MOHUyRVZKc1lZMUtWL2N2VzFNeWpYU3NBWGVPSENY?=
 =?utf-8?B?dnNKelVqOVcvTi9jaXZQN1o3cVJWbUNadjNPdFhuV2pSQURmcDlYZz09?=
X-Exchange-RoutingPolicyChecked: 
	P8GB6D3Od69qWBE2Wymvtj2p4ZtrVnxfa7qRj/h2fYs2RTLD5ddlqZtefniWEAsAqxv1AII7xX8Fnq/TXjfG6QRjXU0RiHA+kya2+7AZrbiNDCuIHrNxrJCuQ8Nd3Yp70DdIZRnlfd/TcfbZ540U/9SDA8ZfdPondPhZ9aO4SRVAZDNYn+RVy4tJh1n7AB3zbHecRl39X+V4vjsPCqGYQdHpwCjCGh3yz+YSk6OYlQtrqh2CqeT2R1xNvdVd09FUX/MQxhdt9djLi/E0vu+BlnYtBWanyiguoScw74jmI4K4Pd6XqpCIYUmeXtu3/zsy4MoW7UzpTMEPFHqP52aPwg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139ba886-6972-4b48-cae2-08de992e8150
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:30:15.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X4DCOdjs3EvFSlp3Jb66Bjc0OPNdq8sCrCNKcjWfCs2cHfZz08oQSq94Ziv45GWwito2+QWvJ32a0wpaCYM2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4744
X-Proofpoint-GUID: 3cLucydRwbgXXfw_encM11WIkZqBVy19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3MSBTYWx0ZWRfX7kYc1RYAk2B/
 SLUVmt7yXCb79s/KIitogX8YMikPoNB8gmNhSP4vx/dFsXh0xWJr+09zWGgQ043ksq2jRPBV4Mg
 JUeLSnGnoPPVLf7vLIGH90bmvzebv4ISuJVWg3H35BUhGnIIYnz8PXP3QOqIm2NulEFTyJyKQ4i
 hqXRT4PrVa02muEQu5Ot2somspdwaGaasZkutkMiKMTzakxBE0WryXgrD+2Lnk6oAaRWy8oHitO
 ia8p5DQ+Jk6r29MIKoTtM0kw+xsEx8aZZTKMSJuulZA0VeIe/HtXepE316O6BsDLR+PplfP+nx1
 GGPM2eJD+y5GWwTByQ0lh4lgBNvvSa2kv5I0efiW3WTYFwENI7AvpD2PpOyRUY1pFuqkfZ6tOaj
 OKGjefYio1C5NQGoHX/VGJmdPIUKAarsBHXyUdIwxASwkp9X4QtQ5eIv91gdk/RaVbIvJUNgLU4
 iGWNbLGbe474DZ+qdxQ==
X-Authority-Analysis: v=2.4 cv=S6/pBosP c=1 sm=1 tr=0 ts=69dc9b8a cx=c_pps
 a=jETFHvz8UvQZFuPXE07H+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=AUd_NHdVAAAA:8 a=rD86j70_2OS2URcsawsA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: 3cLucydRwbgXXfw_encM11WIkZqBVy19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Apr 2026 07:30:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3693

Hi Deepak,


This patch appears to depend on a patch of audit recipe in 
meta-openembedded layer, which has not yet been merged. Would it be 
possible to merge the other patches in this series first? Thanks.


//Yi

On 3/15/26 20:46, Deepak Rathore via lists.yoctoproject.org wrote:
> From: Deepak Rathore <deeratho@cisco.com>
>
> Some SDK dependency chains require SELinux tools to be available as host/SDK
> artifacts. The current recipes only partially provide this, which can lead to
> dependency resolution failures when these tools are pulled into SDK-oriented
> builds.
>
> This change does not alter target package behavior; it only enables required
> native variant for build and SDK integration paths.
>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>
> ---
> Changes from v1->v2: Added new line at the end of recipe.
>
> diff --git a/recipes-security/selinux/selinux-python_3.10.bb b/recipes-security/selinux/selinux-python_3.10.bb
> index 7a4b781..5756c6a 100644
> --- a/recipes-security/selinux/selinux-python_3.10.bb
> +++ b/recipes-security/selinux/selinux-python_3.10.bb
> @@ -127,3 +127,4 @@ do_install() {
>       sed -i -e 's,${WORKDIR},,g' \
>           ${D}${PYTHON_SITEPACKAGES_DIR}/sepolicy-${PV}.dist-info/direct_url.json
>   }
> +BBCLASSEXTEND += "native"

