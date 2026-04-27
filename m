Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD801FF885D
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:35:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34090.1777257326103410064
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ajPPx166;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=857747364e=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R1SjN82618514
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 19:35:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=nJ9svflx79LT6c6aMYVzikYuSN2oWgddUaI7Ko2v3Ng=; b=
	ajPPx166NZWUcZ3YvFPcZnk4kJca3DNmtGa6FBIH91amf/P+VTL9zUFP6flf2PRv
	dyN+uGooP1LIRlgtmBwkbV7k08EPrGXArnvPwFkMEMaclIus3O3k4kA6FnRwAe9c
	F6Gax/Dh0fzLoPKteKrdev5/xn0aKOJHHSdJXktTu80V3B2xYI52FzUsoD4CH0aF
	qA/4QRPoByPgFqsNvGKGxK0ZNnfK7Be1pNIYm6GMZx/sZ2SiRC9dFdDyp5T25bfL
	M3S1HiRAQICSr2OJuYXJDNWX/lrnMAT10Mu7i65dDlfWW5XHFuVppmTCqrN7dpaj
	WdWnlizx95uG3WWjl9SKFw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drrw2s9gs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 19:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EImhb7EIzsc+9oU79o38ywj4X92gMT49fFReuTFjIdETnzYikzFbBRNHrAMUgN6bAl+Zh0H9Fn1p5Srag6VRKgiQbUfefeHvGU1jzs0scCbSY+AYrRm5tkGxNYWhvimiS05zE/Uk26uGFJmk63wkQM1x3y6kYd+bwvkJqOtQ2bLDpr3yVa2dKU6X0YHvmJ8faicC8QmeD+jw8eAdasiDlmagpahgIHI/unD6ajVzdGmoTTS4ZHOK5SuAj+YbmMTM8hlSMHRuUarDdW0s4mnDFb474KHWjHwHfy0djGGbYmnXnOKrz0n2rID8YFphHFSQEVxsLwvzHMkc7GIqA4Di9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ9svflx79LT6c6aMYVzikYuSN2oWgddUaI7Ko2v3Ng=;
 b=i+z7k0qdrssdnIvHWJ6T89wYb2TnSR4sJCaskA+9VzwRN5DxFuGx5BblR5gJU9q/w6OBTBVNTFxbg7zgsyqDZ27mVAuTj9/sm1Y8pY7M9pKjif+OflOqwAJQb/SjV09ZkKGBWJmRH6tW4gOFS1aHlXxZ7bMfoM2Hh8K1LN6MGZkuwFN5ECSwmqxKHE8sFODE9niv5zGHOnEQ1GL81186mPGd1fL18JcO7FgXyvXCDeGnew9rDWzpxm9zpHL0HrzRicw1NJazLb8HTVpUgM4qFZYlsBMp27h+D9mG+/tn5jFX8hcudEs6VWP+I2G+f3b47rfzn7vYwwSU5zuN2Ep0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16)
 by PH3PPF496D5EAB2.namprd11.prod.outlook.com (2603:10b6:518:1::d1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 27 Apr
 2026 02:35:22 +0000
Received: from DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a]) by DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a%6]) with mapi id 15.20.9870.012; Mon, 27 Apr 2026
 02:35:22 +0000
Message-ID: <d9eb8729-63b5-4e84-a125-b2ebc91032b7@windriver.com>
Date: Mon, 27 Apr 2026 10:35:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] python3-keras: fix
 DEPENDS override and add missing pybind11 dependency
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaozhan.Li.CN@windriver.com
References: <20260427015644.749023-1-Xiaozhan.Li.CN@windriver.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20260427015644.749023-1-Xiaozhan.Li.CN@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0116.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::10) To DS0PR11MB7621.namprd11.prod.outlook.com
 (2603:10b6:8:143::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7621:EE_|PH3PPF496D5EAB2:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c4dc03-cd13-41b3-24fe-08dea405a141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	de21w5Lw8o0Of9V75vro0c3mwcZ1IayLGfp6xGUt1tRTR4tvpU6rvZpDTyG9JCjIHuT2gRopbNOOwS57Bb/2/+X9ZUBumvaZ4sjUByE1cfHh55iEp9grdA4Xan9BAw4dN1Hq3lFpSLaklxeEK8PITBOpq3QGRoGhzP1Bn+SITSfbppWlvHnwqFRIeeuEA5FudYZjm3S29FTq8vNILJr9hBpEJ0HAdvWChAG5pX+SGSrdOjnNxYrJ3Lq6KFoBZVh2ZaOsB3pJh/YrvKA9tU56AxVafgtFArGpLy81lQuQlZgmV/ASJ71wf/4jjkhI3NPnzClSJb1JagWPDZnDBC7lwaO/b2qQl11zKwLoVsrdSjUoWRng2Y15vQVepiJtFlfw35wa+x9/fq2t54waWIqGj3v+woyqgxiYcHQUXHEqWelb20nYObe0r8POAV6GIpR2RUtO72eFSPuI8ERizL5tQ2sXcehCv1/KdN7cz8+m8BeOKnh3TyIMFa6UdszqGevh3njNlULehQ73TyXeTN4AOxbZbzJb80LAAeJr+Qo+tU8Bh/L4BYMsEbOzSkWAmREx0QnIxUJn/f0Hqh31AZri0JXr4svqbjBhzYgqdaN/TavPPJeTks2KdQlovKJgo+3HKHZH6ou5MdX+G37KhqcFHam8lL39ixjQWKAzaQxUFM50dRZ+SOCECVp7fl4TgI65egdXBqAMONGibF2MDh9Vqm1xUvGb0omMgEDXqtwQ+SQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7621.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW9yVlhXUG9tSkRqMUQ4RUZVenRNYmdnQU1Oc0krU2dWcDBUUS9WTHlMaFAy?=
 =?utf-8?B?MWVERHdtWE9tLzJpRmwxaEpRbXpRQVVWZmV0VzlyblBna1BhY1M3U2tWUytG?=
 =?utf-8?B?SVIrRlUzdmdiN1VJS0QyMmFORUpNWHc5VURUWkhzZm9SdStTT2tGRk9ZVkFm?=
 =?utf-8?B?QW84YjdIYmdCd2V1cnZReHkwQnBrQlI5OXRuMGg5Z1J0T1FPOGRZNWRyTzhz?=
 =?utf-8?B?ZGRZVmZpU0ZjaXN5QitOUDkySDB6UE44eGwrU093ZEQrVzBWdXV1WEU5MHBP?=
 =?utf-8?B?OEtZZ29zeXNxcjM3SmpDQVU5UUFpM2cxQXJRQ2RqUzV6M3R1S015VE9TaW81?=
 =?utf-8?B?aDl2anFhNTdMbkt3MlNKa1pPTVZzbXRBYVlVOUZsNmNpTnFVV2J1N3VyVm9K?=
 =?utf-8?B?TjNZMTZodTZJSlcxUnUvSzNLSkhuUEw3SDlvZlZ0YmNiNmkxeHBWNS9WMXAv?=
 =?utf-8?B?NjdQeHJ0SWhGV0MvYTNOekdmdWNtRzM0ZjRiZWhnSzVXNGRCRzdPODdmYk96?=
 =?utf-8?B?bzB0UVZZNkFxS3VrdkpXd3l1a3RQZFVIU05yYTdSV2NEMmhjV2FjSG51dVJ2?=
 =?utf-8?B?OWxndzJOeDcxeXk0OXpxYjlaQStIZWF6VERwSUJuMFpHblJUUFdBUUZOcEdy?=
 =?utf-8?B?QStCOTZjemU5TFBWR1RoZmFTRHhzUDRTLzcydmo1c0JVN1hqRGloZ05rczRX?=
 =?utf-8?B?U29ET2RqOGJaWXVMNnVKU3JVK0F3SUdXY3RsTmU3cUd2Y0krWjRWR3lCNU1y?=
 =?utf-8?B?WlUzb3cvQk04Z3dmWlphZzl6Ry9CWjBvTmNBMWtPVE1SWnRMUEJjV050N1Jq?=
 =?utf-8?B?SzYwMzhXNXE0dDMxaEZVMmFmcmQzdHNmM21sNmJscEtnS0dOTWlBNWsvL0NB?=
 =?utf-8?B?MUtXcTRWU0FJcm84OGlrZk9RYkw3LzBGSXZXWWJieDlKQkxOTFUwdlpQcDAx?=
 =?utf-8?B?bkJCWG11UlNGUThKVzd6OUdPbFByZDk0a2FNOFNIMVlVY1lEUDNMRTRsSHA2?=
 =?utf-8?B?Y1hrOC9UZERXV2dlSEdiSkd2S003eG84bzA2MStGZm1NRVBOOWdVdWMvdFdx?=
 =?utf-8?B?TFkxT0J4OENCdmhtT0VISU12SzVVYzFPZHJ1WlBvZ1pYQVZzZjRIVUxqdmJH?=
 =?utf-8?B?blQwWmNyRG5HWjBLbEVzSE9nWnV0aXhRa0QvS0lUVG1FYWNNWTNyR2RpMElP?=
 =?utf-8?B?WkdPUzRmajdIRkxGM1c3UFhHQmlWMHR4bUtiZzVzT2VuTi9ZN0dWRHI5V1kz?=
 =?utf-8?B?OTd5enRDMmZNc3ZKTkdadUdnaGl4RUZDNUZIZ0RsZmxqS1prbXd1NFl0V09a?=
 =?utf-8?B?a0JJV3ZId21haGZqR2ZDVDZuZWhsbElPMTRmZXJsejBlN0xqekdqR2t3VTNM?=
 =?utf-8?B?RGRTSExQRmhmZG5RNnp1RFN6NG9FS0dpa2svekxoVjlyUitJZmliWmx6VWoz?=
 =?utf-8?B?Mno5MnZkVkZ6NGZXd25MU2w4cjBIbGJSOGMvZkZha1NrWDdXZGNKUHNQSThN?=
 =?utf-8?B?V0RJbjZUS3ZSYlF6dG13ekNjaGdiSzAvNE5WYkxBOUZzcGMxSVRpOUJROVVi?=
 =?utf-8?B?aHI2MnVQOXVNNHBEdDg2TzVON01LZmk0UXVmTHlreDRiSUtVQVNUVUtvSVpw?=
 =?utf-8?B?NVZDc0ZTanJGaHhLSG1IQjYwMThQbXgrcGtVOWtETkNMVC9ES0hMS0xIQTZF?=
 =?utf-8?B?dGlmSmJuNlFrUXlqbUlLQWNsL3hZcEJwSHJYTlRlL28rN2pCSE9ZVkp6L3N6?=
 =?utf-8?B?ZlZyUmhNN0VIZGNDOS9TTW4yRkM5TElCOEN0UnZnU21ZWGkyRjZrZzRyMWZ6?=
 =?utf-8?B?ejF0OVhzNDJKbi90dDM4ZkJHY1ZDVXFOS0IwVDZsdmdNR1UwZXJHUXhiMDVC?=
 =?utf-8?B?QlZhMWJrcW10RUlCSUtEZFRhUHB0RFoya29ZWFJ3VDFxZGRFaGYrT09iWE5v?=
 =?utf-8?B?cWo3UzNqWmZYNmN6YUhiZGVqMi85cUp3VE9MT1ZRQUFTSlpya3R3VFlFdHUz?=
 =?utf-8?B?WUFHaW9DQXJ4NTF5b0tHV3pkK25XQXoyOXVOWTVrUTVZRndyUlBscThJS1VT?=
 =?utf-8?B?NE9TdWtwWTVHcGYrVysrMDEvdVpPczBEeHRlbDIxVXVmb3ptVTQweldtVy8w?=
 =?utf-8?B?WURVbG1NcE5VeFBMTlE0Sk5ja1dnZTlGZUp2MUJwdnNhcmppOFhPZW9qTkZy?=
 =?utf-8?B?b1J2R2dqU0tkS3UzbmtjdzYxeTBQTXBaRTI2NHNpYTZ5N1crRFA2eXA2VXdh?=
 =?utf-8?B?cXd0cmtwMU9wNHkrMnM2N1NEemZQMU56aEk3NncwWFJCRXNiaVFZS3RQT085?=
 =?utf-8?B?di9COGRVUTUrUkZDMVd2VUVWMkVMMG1jTk83dWdxdGxGTTFLQ2dPZz09?=
X-Exchange-RoutingPolicyChecked: 
	iwAF655fNJC+YoN0X3FS+qR+EfZmI9CgExKPC9L+461RwOwYkn+S3HgfETRtM/hneEA7Yp+QLjkZanTlC9Q1YcXMSO0C2zFltuuHqHo5xN9KuPCIJloLzOFvPw9g/SVhaZ2AxPv6VRi08+mShD9DRPSeXYc6MzKAhlbCAqq7XHi/XtLQfVXJjy5k46my+IZd7ZAm7Opj2XiONi8ccTLf+fSql2+BGJ94veze+KD+bJOh+dzaL+Neiydci8O+NToRRwI5voR6vD+gYcmKZtY6RntBGirH6S9BsXqLWWV3BJngPHpNtBMGPvNpmL+OLAf/tsXFQxot+ZHrHabo1L9IbQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c4dc03-cd13-41b3-24fe-08dea405a141
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7621.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:35:22.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqHCoQIiNIyfvxHGYaHL8K7+RS5GkFQmaK7ZxjU4UQUueVsOF9OsXb/FkALXnz0xZePzbIcACjoIH3z1F1x49XDQYACY1j8D/w/OpyvjUD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF496D5EAB2
X-Proofpoint-GUID: vZEx1TWvRchwbjpu4qqJfcbUO1_X-ZcV
X-Proofpoint-ORIG-GUID: vZEx1TWvRchwbjpu4qqJfcbUO1_X-ZcV
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69eecb6d cx=c_pps
 a=LPv6HZ59J3TLgKTE/qPS5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=yGLbprWrvWm6bXuyGnEA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyNSBTYWx0ZWRfX9AxgzvFOUPOX
 UKUmfpqx3ljedrXfE9AzCub121Su4hHbBCpw7zBKR4QWjHDJ+NGLDMloK+4sUKo2zMLvC78raDo
 zgs1qjBl6Zyee1qvltl95rrnhpmsXx2pMfpVSF5S/qheilaKkccIgTyjePX044D18Jh8NV9XnP9
 /CBpsZSxBdfifkwS/3Zl1xooRm+7EcrkR4s72fgblTcCn0fdYN2miwQuJeSBx9gJYTtqUU4UmFC
 T/kGx9JJaefqrr6rJD+RsrZ8/8rHU7Mm5kUrdn9GniMqJ9lZaamVvUWmIOvqQ/kmVjBKY3zSjVY
 RcxXz80sXM9X2SaW0KFMMQxPlkBXFgm241mE4+TXENx/pnZU+cqrfCP0abB9EDrO8rxffZ/KxJo
 LugEJsvwcuOvtDbZy25XsfJitPk+602OvqG4M075Xzf5Iec7r0uFRzcZr7AVfSbBJYBrNXsjUav
 ABSkYgk4mnut8bGClDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:35:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3823

On 4/27/26 09:56, Xiaozhan Li via lists.yoctoproject.org wrote:
> The DEPENDS variable was first appended with += then overridden by a
> direct = assignment, causing all previously declared build dependencies
> to be silently dropped. Consolidate into a single DEPENDS += block and
> add the missing python3-pybind11-native dependency.
>
> Signed-off-by: Xiaozhan Li <Xiaozhan.Li.CN@windriver.com>
> ---
>   recipes-devtools/python/python3-keras_3.13.2.bb | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/recipes-devtools/python/python3-keras_3.13.2.bb b/recipes-devtools/python/python3-keras_3.13.2.bb
> index b5b9338..6bc8adb 100644
> --- a/recipes-devtools/python/python3-keras_3.13.2.bb
> +++ b/recipes-devtools/python/python3-keras_3.13.2.bb
> @@ -25,9 +25,6 @@ DEPENDS += " \
>       python3-h5py \
>       python3-mldtypes-native \
>       python3-packaging \
> -"
> -
> -DEPENDS = " \
>       python3-pybind11-native \
>   "
>   

Thanks for your contribution, merged

//Hongxu



