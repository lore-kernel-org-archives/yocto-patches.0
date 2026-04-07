Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E46BFB5183
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 02:40:05 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71102.1775529595180056528
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 19:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=NM03tDkc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8557b2b917=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6370rWIl2426667;
	Tue, 7 Apr 2026 02:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Kwa+LyZ4DvRIIkkO9eFh/AJ1z6CP4Ydlk9EDRmKc/5k=; b=NM03tDkc0U+l
	KGcc2laNrBIsREf4+4cgP7nlEKR2mhGMu6IRSd44rDKNWNQM53vayW8vdBXP0/eI
	eO8SDU/vemBh+c/wJJlNnjki/JhhcLm7UsZB8BqWfVQdtnnbB6RESiQxIuw+zpNL
	pnq55Wp2YMHhCT5sYWKvg56I79nqD/S0HnXYhOYd4M/msg62LTGSXT30zjNAIp68
	D5rsbfuUNFlAXsRq6dhz1ffDUn+wbgdz9j7rxdtzWp8SILkvNPG4iLqnLsKwvQA4
	Ifow+7URmRbVya8NjaabkksqymDOKnMeEo1TyVuAaE2ZkizgvGRxpCzEQH83s51O
	4vcUb8cgJQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrqg664-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 02:39:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlPh0Hg366XnELLBj84i4bnQILCSIhTeK9isMwG9zA8fEXJQaJBd2HYhwXQz8u8YiU939bTKhlet/2hicZb11NuGgiZGkRXGq+bwPS5h9lhezJ15TSrbIMmBuN7qH9YnPslVwT1A65/jv2XodAJoVPgddCI6+KvA3JUiz5OuyWhAaAcdf5Qt6M8KJ2ZZbvkygOz2Yz+GcPJnyj3R0O8S5TnpyHmw/Zd5WS3Uw2XFVlJUXuf1M3EBbq9UIUvui9HB8QgebTV97c0rDwWmYmEPg5ijv19XmOTVRh1kFObmkRxCGcbkbl2pLkh2o7oJYxLTFmpIIaOuHULUs3jwoX3/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwa+LyZ4DvRIIkkO9eFh/AJ1z6CP4Ydlk9EDRmKc/5k=;
 b=BqiHvQBtZkFi+T5L62V4q/xTlnWWQotcwRpjS19t6QEBc9vIVldva5tXq/NOKqLNmha9kJwueOBOm2lgskR+THVJI9vphg0PErV19Jje6Q766qVOgJ8n5DbNrGujyB41m7zFLNixunwJaeLsCFtqEGDjkWQL4B0OOxDke/4jUUjGnEpdx6w2SyXkrFpriUC+DZL+ezcRrv8YdynXJC6vyJBe0LFswFeqOmaD2IyhDcfwbde/t7zZZdOgMZ9F4xGv21WXvUOfbW0z3g8Uknr0LbJ9K8VszaXR7gwQoRelVh+fo/NNRND9Rj3MqyzhMzhxp+3lejbvu/WKnsoWui+7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SJ0PR11MB5867.namprd11.prod.outlook.com (2603:10b6:a03:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 02:39:50 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 02:39:50 +0000
Message-ID: <061c01dc-0d72-411c-8190-89c84999de79@windriver.com>
Date: Tue, 7 Apr 2026 10:39:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow-lite: don't
 install flatbuffers header files
To: Martin Jansa <martin.jansa@gmail.com>,
        yocto-patches@lists.yoctoproject.org
References: <20260401053022.96757-1-martin.jansa@gmail.com>
 <9d3a3b8c-2b03-41ed-8ac9-49ae7ec174a6@windriver.com>
 <18A23E43F60C98CB.509824@lists.yoctoproject.org>
 <CA+chaQe03v1X3wkfVAg=wVi1wk7my+pzrzG39zzeXE9uLaRkvg@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQe03v1X3wkfVAg=wVi1wk7my+pzrzG39zzeXE9uLaRkvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SJ0PR11MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f636223-16b8-4533-75ca-08de944ef093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	nk3te3e3lcJWGv/On1c8DqTAMrzDmsjOWqtGDJp78dZRtSvyLI9aMoaXHHMqweB4yH5Tb6ZsAzPZ5D2AzMykU+aND104CpG85YI99m2nHjNtmqaoqJwasm4+7gscrfAYsDa9CBOx27u8phXZ6uJaAiEjUx69xKRZ5kEfFGEG09N4uEVLbZwAjNEHlTj/Nmgt2SRbPWNwlEiDulUlWbaWPGTa40CHIcB3M3Q3+Xq1ehN6ICqSh8P+e2dQSJ1Negnb594+lDqTdfkA4GSpue0tZDPrOcJ6x7zWRTmuLnJsHColWfVJUjyWaydXpGRELko6Uz56DlUSwZ61k2j77kfTDjb2Ts0/nzGrZPMVaL/rQTbBcI7lYoqOealLZrlIK71qDGz0aWGTTza30gVwKZd+p+pkVE3zuxnPoUudR7lFGpO4+dFKW4qD7uogAc2v/JB0GaRrsPO5g22OL056liMJJWhw2v5o0/AWV/ApEU5PxzpbU0Sbnklo/Ze1MMTD6fEPkoLdqwz8rcBJ0g5DS4dF8gCDGPy30DmEdX315DE2/68KmULr0xxkaIfXAcDAxwnkuy++/Kwv2mlfPWcdD/MPMh+Xc2sc+1CwSwWUhhrkLD8XbdwdLc40HpFFq01LVF/LXr5ECBnPApUzlQb3+H0noeuK76peqVQ5FO1WlXXbOSRjLMkxIkwKvHDrqG0iIq2e
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXRnNEsrblA0U3FnY0RCQmRMMGh6a090ekxBVFZiMVNoc1hmRzlkcVJaMGVY?=
 =?utf-8?B?RFpDaXFja2tRZlpNZ1Qzdld6ekFybHRRSU4vTGFsTXpHSVlzcUM5N0JNVjZ3?=
 =?utf-8?B?NU1ncVVTSDBrR0J1YlQ3WEwwT0hsZ2thQ1Q0ZmZzYTNwNDIxUjVKUllOS2ZU?=
 =?utf-8?B?M1ppNVRPRDM0dmFDS0dacXJFSDhsS0YveGdvZFFpaS9BU2NkODFyUVBudHRm?=
 =?utf-8?B?V01LK0U3N3dJdksrWkVMZDFqQnYzQmRSVVdIem90Q0ZVNDVOWWNMbDd5WjNY?=
 =?utf-8?B?bXVDY2VJUVR0Mk5BUTFyUmhsMjFiaVUzQ1V5ZlZSUXpPQVN1QlNxL1VrZ1Ur?=
 =?utf-8?B?QXRyYVhaZFMzaXk3K05oNGN1ZXU4VGR6eUZpbkQ5N0RIQ2dRcVlpUGFFSjEy?=
 =?utf-8?B?cVlKUjNUeFdYbGVDbDhHWXRPUUtkTEsrUVFBd0dYVkZYR0tYQldSZ2dxUmtQ?=
 =?utf-8?B?NjlqTmFTcWZXc1RIRWFoVmhDTTVSQmZ1eTExcFNIeXAyUjBmVlIwMkVkY2gw?=
 =?utf-8?B?ekg0SVkvaEx1dzJ2L0JrYUVhbXR2dm1aTGhRZTdnd0g5YTBqbDk4Z2hKbDBE?=
 =?utf-8?B?QTdTZUN4SFQ5Z1A2RU9oZHQwWE9WZjFTbGVCUWxpelZTUVp3UVAzRUVUWkpV?=
 =?utf-8?B?SUFWcnVMR1lqZDAvMU82ZUl4bkVlY1NYNTVXcGROTTJLVWRZWDRqQ0hSb1NG?=
 =?utf-8?B?UUx1SGxsdldCRGQzcEdZVWZBZWR1cXhvbmtKVUhFMHhselFEYzFBeGJ4MnBC?=
 =?utf-8?B?YUFQVDZERngwR0FRdkxqQW91RXQxeitXSlpkaUpHYUkvbUxBUjlmbVR3OUtC?=
 =?utf-8?B?c00vK3lrYkFtSDJrd1JaQ3NUSkJDS2UwTFBFZ0RuRUhvc0Qwdko5K3JMUk1C?=
 =?utf-8?B?SkN2UGxSRUkxTEdEa0pOYm1wMGxpWmhkYkdzdG5MKy9COXhiVnpTaW9zM3FF?=
 =?utf-8?B?VGx4cTYxMUZvYXB4aVlCWkt3YlNZY3pPZWxxTHRtblZUdzcyOVJaVXZMMW53?=
 =?utf-8?B?NjNsaSs0cFgzNkNYbWZnMG82aHVvNEVnZWE3NmtFa0ROZUIzT3BPU2FxNllJ?=
 =?utf-8?B?UVVLM0FWVHZSVmlOWnFtSVNleUdzSkpCb1R2THUrMExXaDc1YkJENlVxQzlU?=
 =?utf-8?B?dVFkbWRRMVIrNy9WZmcxYW5mWXNoZ0FNckV2eERteHluRGRFR2t3TGFlOGNX?=
 =?utf-8?B?Y3ZtRjB5T2RWWlB0YWMxUlNhKzQzMjZodlJzMno1UTFwdlIvTWRkWFZTZ0ZX?=
 =?utf-8?B?QnkzTUQ4YnVUUWpTOEZCV2JYREdGK1hlaHhiK1lxUVdDcFFFQzlPZDVjQVdQ?=
 =?utf-8?B?dDloYUNpcUdQZXh1TTFCM1JDeWFuSUU5b243T0tHYlc1Z3N2Nklaby9lMHVr?=
 =?utf-8?B?bXArQjg3QlRHanBRbW1QMDd5Q09qSjdKd1JXMnRUenZsaUdKR01wSjU5V3kr?=
 =?utf-8?B?Qk55YW1hWHpncXpGbDlZMDNMZVdIK1dzSGFwRGVOMUVqZXBFdTlFNUJhQTZU?=
 =?utf-8?B?QXJxOTgyRFFUMDRXajQrQ0RLL1U0SWJ3YWVzVGE5M3liTVZUeVFudHZSL2NV?=
 =?utf-8?B?RlBvcEp1ZzdJd3VnYStUSlVvc0RNaEpObkJtSkFhTzBtdkkyLzNiemNGVDZr?=
 =?utf-8?B?NGFGVWprM0FyYW9iRERYNjRMWlRBbWszTU5rcTduK3B6WnNrZThrSy8yd3ha?=
 =?utf-8?B?VExuNERNNGtGQUdDZEc0dlo4T052NENsZjcxZmNBTi9vdUd6ZHFyV2NZY3dJ?=
 =?utf-8?B?NWtWTkRFN2hVTW50U1E4dUplSFhHcFNNeUFhYXVLeUFBVGNDeVVBWTdwKzZs?=
 =?utf-8?B?N2EzOTZtSEZmWWVVQUdBZHRRdGFHeWY0TldOZVZUZzdyUVBhU21vTHZpVzNn?=
 =?utf-8?B?TUJEakhETHhLUEFydjJWZTd1eUl2eFN3Zm9XckpIMndXYy9tMDF4WkIzZVhO?=
 =?utf-8?B?bFJIYXEwYm12b092VytXZTB3aEJtTEI1L2lkcDJVR3djVSt1b1poaTAvZUhX?=
 =?utf-8?B?YlMzbU13MjR4TW9RRm9HeTh2dm92NTU3cUZHMlhMSDM3U3JBOE5kVlcxQU04?=
 =?utf-8?B?c2t6YmkrYmFIalBsQmlvMDkzYjBvZUZDeHR2UE5Ddzhrd0x6ZGJhbGU4SGtH?=
 =?utf-8?B?RFQ5aDVoWk1TV0JLcDZZZURwL1BGdUhIREc0dmtDL09RQ3N0V29xMHczeUV6?=
 =?utf-8?B?aEpFaStncElMVTkyeHR0dDIvNVZLOVNJejJ4ZG01Z2paSGh5aTlHeGJsUUs2?=
 =?utf-8?B?K2YxVEU2TzlaSy90TVRjeW8rcnd4WkNpWi9VK1hMS2NubWQzTmNHYXpPdzhr?=
 =?utf-8?B?YWpXN3lhNndhTFFDRURhZUFuNW13N0RPNmY1Um9HZEI0V1VDVCs5Zz09?=
X-Exchange-RoutingPolicyChecked: 
	wOICwcq/ShQFLt/VPEnsS6zilhVVFfLb0ihGMRcMhPfjVjTu5k08ULXvxagi9w3Mn2IpWjXZdW6ZbocPIg/izyj3LYi901OYqqWeS+Y+AxJtFpW2Qx5NswQsvd5o38eMKtquwtuTAcO9xPYyxj1T8KzE8Ks+S1vNCpB0F5SgUinKOU+8cIwXLWX0UlPqQLrUojxsrEkm4lwVVdfb0h56/7swpM62a0aWy20zb1SE2jyj5s3PjXpQWh23kPFooptg5Hr989odlshpzYjg5wVSYOPr9/KuoFGA02Ev7mbFqrNXH7Q2/hj6NkgHlH/BCg134SqpS67QvPGuyaUxcwGzYA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f636223-16b8-4533-75ca-08de944ef093
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 02:39:50.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouLFk8w3S+WWwQ0yvN7i9AUvflbJ4NORUQYgQVYMdL93YRxASzoJk8tlpy51yOzb4RdPN5CuggRZYFR9DweZa5C2nnUXtxZjsVQCufWDPZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5867
X-Authority-Analysis: v=2.4 cv=RPCD2Yi+ c=1 sm=1 tr=0 ts=69d46e78 cx=c_pps
 a=iByqbumfC+QZNsSPXlDUmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8
 a=VaEqMeQ28d8h1F9eb1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: EkREJsXR30ibv235hTo2OaWOuBF2_m5A
X-Proofpoint-GUID: EkREJsXR30ibv235hTo2OaWOuBF2_m5A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMyBTYWx0ZWRfX27k81dIU1w4l
 CkpdsxvR9vMmp9Ivpxbt3y8scsYO/KsH1AA8Th41sowre6xqk7mLk4E2wAvIxFb79uRrtDG3Rrk
 ePcyx/2W+Fy1xnn92tkbdOS7PsU2fb7gA1IxkaFhnkHhuHsIAtX3kG6zTZEbTRHL/vS/5na2wKB
 szUAm3qzw6dYHtL2JEtzfxI2JyldFzCehNeIWZT72X4BLP5dSu6vW9YKB8nTV+BPSiTwDC9XFLH
 njajXfIJi3WHMZ+Uw3Qs/4lz8KGs7om8vYlbgDpOn9MlIqzTwM5+UrfPAlTu/9XPUp40K3MwIFN
 wrxFCZo28QJEqk+aYeMJOVHf2v+4jKLVza2lYHcn5zBDWzxDAXAb5ZzFsgqc8WkeC2LiE80t7D5
 AR1DuIWyggPCmwwAIEvLcaAy68sqFSSKqez4qPvPpnRutyp0et0sn7cZ+VQPCAPTqf976v/3JGc
 p3uDw+DM1dYQ1zPYf1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070023
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 6370rWIl2426667
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 02:40:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3650

On 4/4/26 05:06, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Wed, Apr 1, 2026 at 3:21=E2=80=AFPM Martin Jansa via lists.yoctoproj=
ect.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org> wrote:
>> On Wed, Apr 1, 2026 at 7:34=E2=80=AFAM Hongxu Jia <hongxu.jia@windrive=
r.com> wrote:
>>> On 4/1/26 13:30, martin.jansa@gmail.com wrote:
>>>> CAUTION: This email comes from a non Wind River email account!
>>>> Do not click links or open attachments unless you recognize the send=
er and know the content is safe.
>>>>
>>>> From: Martin Jansa <martin.jansa@gmail.com>
>>>>
>>>> https://lists.yoctoproject.org/g/yocto-patches/message/2186
>>>> breaks a build for recipes which depend on both tensorflow-lite and =
flatbuffers because of conflicts in RSS as in:
>>>> ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file /usr/include/f=
latbuffers/array.h is installed by both tensorflow-lite and flatbuffers, =
aborting
>>>>
>>>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>>>> ---
>>>>    recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 7 ------=
-
>>>>    1 file changed, 7 deletions(-)
>>> Merged
>>>
>>> //Hongxu
>> Thank you for quick update.
>>
>> With newer ubuntu on host I'm seeing one more issue with bazel-native,
>> will send a patch or more details when I figure out what's wrong, but
>> it fails with ubuntu-25.04 and newer while in ubuntu-24.04 and 24.10
>> it built bazel-native fine.
>>
>> I'm sharing it now just in case you've already seen this issue and
>> might have some pending fix already.
>>
>> The log from 24.04 doesn't show "Linking src/main/cpp/util/libport.a"
>> at all, so I guess it's util:port dependency somehow not required, but
>> I'm still searching why (in all that bazel output which is a bit
>> confusing to me :)).
> Thank you for merging those small cleanups for bazel recipe.
>
> Maybe you've noticed the fix for this "ar" issue as well:
> https://lists.openembedded.org/g/openembedded-core/message/234468
>
> Now with a lot more debugging I also know why only ubuntu-26.04 called =
ar
> while ubuntu-24.04 didn't and it boils down to detected features, mostl=
y
> supports_start_end_lib in gold linker preferred by bazel in 24.04:
>
> work/x86_64-linux/bazel-native/7.7.0/sources $ diff -uNr
> /OE/lge/.cache/bazel/_bazel_bitbake/*/external/rules_cc~~cc_configure_e=
xtension~local_config_cc/BUILD
> --- /OE/lge/.cache/bazel/_bazel_bitbake/0e259dd960791f8b4e31fbc469f1929=
9/external/rules_cc~~cc_configure_extension~local_config_cc/BUILD
>         2026-04-03 20:55:30.662177841 +0200
> +++ /OE/lge/.cache/bazel/_bazel_bitbake/a47ed104727c1f493f7aa830ae20096=
b/external/rules_cc~~cc_configure_extension~local_config_cc/BUILD
>         2026-04-03 21:03:44.814557111 +0200
> @@ -111,13 +111,13 @@
>       target_libc =3D "local",
>       abi_version =3D "local",
>       abi_libc_version =3D "local",
> -    cxx_builtin_include_directories =3D
> ["/usr/lib/gcc/x86_64-linux-gnu/13/include",
> +    cxx_builtin_include_directories =3D
> ["/usr/lib/gcc/x86_64-linux-gnu/15/include",
>       "/usr/local/include",
>       "/usr/include/x86_64-linux-gnu",
>       "/usr/include",
> -    "/usr/include/c++/13",
> -    "/usr/include/x86_64-linux-gnu/c++/13",
> -    "/usr/include/c++/13/backward",
> +    "/usr/include/c++/15",
> +    "/usr/include/x86_64-linux-gnu/c++/15",
> +    "/usr/include/c++/15/backward",
>       "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"],
>       tool_paths =3D {"ar": "/usr/bin/ar",
>           "ld": "/usr/bin/ld",
> @@ -147,8 +147,7 @@
>       dbg_compile_flags =3D ["-g"],
>       conly_flags =3D [],
>       cxx_flags =3D ["-std=3Dc++17"],
> -    link_flags =3D ["-fuse-ld=3Dgold",
> -    "-B/usr/bin",
> +    link_flags =3D ["-B/usr/bin",
>       "-Wl,-no-as-needed",
>       "-Wl,-z,relro,-z,now",
>       "-pass-exit-codes"],
> @@ -166,7 +165,7 @@
>       "-D__TIME__=3D\"redacted\""],
>       coverage_compile_flags =3D ["--coverage"],
>       coverage_link_flags =3D ["--coverage"],
> -    supports_start_end_lib =3D True,
> +    supports_start_end_lib =3D False,
>       extra_flags_per_feature =3D {},
>   )
>
> And then linking e.g.
> bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so was on 24.04
> using .o files directly with "-Wl,--start-lib .../*.pic.o
> -Wl,--end-lib" while on 26.04 it was calling ar to create .a files
> first.
>
> 24.04:
> action 'Linking src/main/native/libunix_jni.so'
>    Mnemonic: CppLink
>    Target: //src/main/native:libunix_jni.so
>    Configuration: k8-fastbuild
>    Execution platform: //:default_host_platform
>    ActionKey: d581ae102ab4782b26755373f49cb81a01b48d113e4cb7e31b4e87666=
7acc6eb
>    Inputs: [bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/bl=
ake3.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_av=
x2_x86-64_unix.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_av=
x512_x86-64_unix.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_di=
spatch.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_po=
rtable.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_ss=
e2_x86-64_unix.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_ss=
e41_x86-64_unix.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/logging/logging=
.pic.o, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/md5/md5.pic.o, =
\
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/port/port.pic.o=
, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/strings/strings=
.pic.o, \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/blake3_jni/blake3=
_jni.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/latin1_jni_path/l=
atin1_jni_path.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/pr=
ocess.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni_linux.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so-2.params=
, \
>      external/bazel_tools/tools/cpp/build_interface_so, \
>      external/bazel_tools/tools/cpp/link_dynamic_library.sh, \
>      external/rules_cc~~cc_configure_extension~local_config_cc/builtin_=
include_directory_paths,
> \
>      external/rules_cc~~cc_configure_extension~local_config_cc/cc_wrapp=
er.sh, \
>      external/rules_cc~~cc_configure_extension~local_config_cc/deps_sca=
nner_wrapper.sh,
> \
>      external/rules_cc~~cc_configure_extension~local_config_cc/validate=
_static_library.sh]
>    Outputs: [bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so]
>    Command Line: (exec /usr/bin/gcc \
>      -shared \
>      -o \
>      bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so \
>      -Wl,-S \
>      '-fuse-ld=3Dgold' \
>      -B/usr/bin \
>      -Wl,-no-as-needed \
>      -Wl,-z,relro,-z,now \
>      -pass-exit-codes \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/pr=
ocess.pic.o
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni.pic.o
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni_linux.pic.o
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/blake3_jni/blake3=
_jni.pic.o
> \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3.pi=
c.o \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_di=
spatch.pic.o
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_po=
rtable.pic.o
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_av=
x2_x86-64_unix.pic.o
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_av=
x512_x86-64_unix.pic.o
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_ss=
e2_x86-64_unix.pic.o
> \
>      bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_ss=
e41_x86-64_unix.pic.o
> \
>      -Wl,--end-lib \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/latin1_jni_path/l=
atin1_jni_path.pic.o
> \
>      -Wl,--end-lib \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/logging/logging=
.pic.o \
>      -Wl,--end-lib \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/strings/strings=
.pic.o \
>      -Wl,--end-lib \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/md5/md5.pic.o \
>      -Wl,--end-lib \
>      -Wl,--start-lib \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/port/port.pic.o=
 \
>      -Wl,--end-lib \
>      -Wl,--push-state,-as-needed \
>      -lstdc++ \
>      -Wl,--pop-state \
>      -Wl,--push-state,-as-needed \
>      -lm \
>      -Wl,--pop-state)
> # Configuration:
> 7986f41e68c0f8695304d476c9d739fc4489b6ae519d039e958db1eb026d1faa
> # Execution platform: //:default_host_platform
>
> 26.04:
> action 'Linking src/main/native/libunix_jni.so'
>    Mnemonic: CppLink
>    Target: //src/main/native:libunix_jni.so
>    Configuration: k8-fastbuild
>    Execution platform: //:default_host_platform
>    ActionKey: 7fd7cf007954470fff795125ded88171fc21fb1c446fe65adb18abfa4=
0564ce8
>    Inputs: [bazel-out/k8-fastbuild/bin/external/blake3~/libblake3.a, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/liblogging.a, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libmd5.a, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libport.a, \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libstrings.a, \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/pr=
ocess.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni_linux.pic.o,
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/libblake3_jni.lo, \
>      bazel-out/k8-fastbuild/bin/src/main/native/liblatin1_jni_path.a, \
>      bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so-2.params=
, \
>      external/bazel_tools/tools/cpp/build_interface_so, \
>      external/bazel_tools/tools/cpp/link_dynamic_library.sh, \
>      external/rules_cc~~cc_configure_extension~local_config_cc/builtin_=
include_directory_paths,
> \
>      external/rules_cc~~cc_configure_extension~local_config_cc/cc_wrapp=
er.sh, \
>      external/rules_cc~~cc_configure_extension~local_config_cc/deps_sca=
nner_wrapper.sh,
> \
>      external/rules_cc~~cc_configure_extension~local_config_cc/validate=
_static_library.sh]
>    Outputs: [bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so]
>    Command Line: (exec /usr/bin/gcc \
>      -shared \
>      -o \
>      bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so \
>      -Wl,-S \
>      -B/usr/bin \
>      -Wl,-no-as-needed \
>      -Wl,-z,relro,-z,now \
>      -pass-exit-codes \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/pr=
ocess.pic.o
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni.pic.o
> \
>      bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/un=
ix_jni_linux.pic.o
> \
>      -Wl,-whole-archive \
>      bazel-out/k8-fastbuild/bin/src/main/native/libblake3_jni.lo \
>      -Wl,-no-whole-archive \
>      bazel-out/k8-fastbuild/bin/external/blake3~/libblake3.a \
>      bazel-out/k8-fastbuild/bin/src/main/native/liblatin1_jni_path.a \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/liblogging.a \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libstrings.a \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libmd5.a \
>      bazel-out/k8-fastbuild/bin/src/main/cpp/util/libport.a \
>      -Wl,--push-state,-as-needed \
>      -lstdc++ \
>      -Wl,--pop-state \
>      -Wl,--push-state,-as-needed \
>      -lm \
>      -Wl,--pop-state)
> # Configuration:
> 7986f41e68c0f8695304d476c9d739fc4489b6ae519d039e958db1eb026d1faa
> # Execution platform: //:default_host_platform
>
> now with intercept script fixes it builds fine with both (and
> tensorflow-lite as well). Thank you.

Copy, thanks for the tracing

//Hongxu

> Regards,



