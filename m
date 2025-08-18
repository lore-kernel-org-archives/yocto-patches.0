Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FFCA0EDC
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 02:16:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.65853.1755483396688362033
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 19:16:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0325f816ac=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57I1Y8bY2123394;
	Mon, 18 Aug 2025 02:16:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48jgy696km-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 02:16:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbIO6ohnNRjlm+ke22bnuT9Fqm8yYa6sQMtiFaWY7EMcKzqz2/GEKLI/2tKyCvKjsPtaT6kqXx6SUzTCYk0bErqdYp3rNSAa2zHpeqkGo/rHfYTuzb19+kP7HP2qp4N72E/QdoRA1VTeDhyy3JzEdDhWm99Ab1EpPHU9QbIlgDflYdrmoBbnGa1PCV4YGIIho+3Em6z0je7+jLXadpFPg0aLXPnF/+Muu03lR/Tjq679A9emGAx8laJBQyAae5GSMVgl2dQ9g7brCsAGxlWevxg6y1ceMys3ZsvAwEOO8+/G/ps0aLLZMS+iDoaV8eOM0fMslR8TaoqueZyXm8TRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGcj+856jcu++L/2ejME148lvjaX+YxLxfmiWNkEicc=;
 b=ZUaNBfHDRfNLDO6kxYx1KLgWRa5Gp7+qQUYSkqpXxjaRzr0ND5Xep0mq50SmA1WoEP9QVNNYXlfOPGj7WKSEIh9zD9Y7jE61laqvF2Q3/uagWfUd++AWJy6HEcgI6oqrcAIk3qL7wYYISDXVdD63phMrwvhIfNArD5x67BABvMuxck4frdhE5M2gFmvCvnjztJFuFXVCrAhYRXu2wA+lSHIWStaVn8U6GoLoB1a8ZYsH+7AqcwXZxWI1fiWQiAXf1rI1arkyLwx9+WTD6l/x8Bwuo+dd1rOmxrfzM1C7skPpyluCsKf/CXQCqbzw0P6VOukvFWxvOvt6nV07WC9lZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Mon, 18 Aug
 2025 02:16:32 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%5]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 02:16:32 +0000
Message-ID: <83270ab8-56f3-4dd2-8fc3-97500bbba85a@windriver.com>
Date: Mon, 18 Aug 2025 10:16:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][scarthgap][PATCHv2] bazel-native: fix build
 with gcc-15
To: martin.jansa@gmail.com, yocto-patches@lists.yoctoproject.org
References: <20250817204644.3817415-1-martin.jansa@gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20250817204644.3817415-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|BL1PR11MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7add85-42cd-421f-8eaf-08ddddfd3f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NVNoY2hESUxrVkptQlRXbDlBdkE5d0JVVGZUSWpzeG04V1doaXNRSkhmM0Qx?=
 =?utf-8?B?N1VNU1huMGh1NkpDSE1kWnVIVjllaTBVWUpiQkw0NkVGQ2F2MWNXSmlBVWlW?=
 =?utf-8?B?bVo3d3RDZTZmNmZxZ3g2ZFlVem9uWUNaR1JiYzFzWlMwKzQzb0V2KzlxbFk0?=
 =?utf-8?B?Sm5OWG1RSENySzBJTmgzYjY4NFI2RHlDMk5EWExXaHUyeGlLUlU4bjJmWmZl?=
 =?utf-8?B?OUorbzBpNWMxUTQveVFTRitESW5ucGxFSlFPb0xlRzIvU0k3b0RQanAyVHpO?=
 =?utf-8?B?VTRJbWhzUDh1MlJYOStSalJib08xdHdZYTBSbC8ya1FRUVlYZDliZHFqM3Vz?=
 =?utf-8?B?d29DSWlXSEtuQmVxMDYyTEdEN2s2K1BGanlDeW9IOGM1YkVRRzFyNHpMb2hm?=
 =?utf-8?B?bk1FNEI3TmNYMS9rRkNodWRHTUE2USswdUk0SGkzZFcwTEZrUzlEbkRITDB3?=
 =?utf-8?B?S0JieWV1NTgrRktHeUFNNUJzY1hhTWtIeXJHQjBxdTFQemRzbnI4U3hLeGtt?=
 =?utf-8?B?S2ovc0ZmVkJNK1QzemxKbmkyNGl4TVpSTHNLelg2dGlQeXBTYjNJOEZXME1Y?=
 =?utf-8?B?ZDl2WEhqMzE5SEZnUG1EZlY4T2ExZ1NCVnB3Q0tWZUhGb0EySnNmK0VBVFIx?=
 =?utf-8?B?SHR1a2FUQ2xMNytDWEQ3bk5kYVY0VzIrRkNhYVRhUENhVUxxNDVNT29ySVJm?=
 =?utf-8?B?S3M2anBkeXhNcDdlZ0JCV1dGNFR5RUlwcWhIcy9WTnVsc3pMdER5c1BjZWNP?=
 =?utf-8?B?elhsWnczYkN3K2diY0xXSWhvM0MvSGNvb1BKVkFlZTRVc0ZKZFhPZVk2bllp?=
 =?utf-8?B?b2R3ZnZRV09GQzNTcXFZMlpYR1VBRVpFZUNkbS82c0x5VGtpTkdnUTVRa2ps?=
 =?utf-8?B?QnBsR2piSFh0MFpTUTRUN3Mvd1RtMitQSzlyOVJyZU5WUHlFWEVzNmdQZFYx?=
 =?utf-8?B?U3c3SnJid1dRVlRCQkNmazNtVTd5VGlMbVNIWFN3OW1JcFZiUm5HS0VQcXI2?=
 =?utf-8?B?WUJTaVBxV25LMW9Ic0JheXVkbjI4dnd5MWw2YWh3NS9LYWViSHVESTcrUTlu?=
 =?utf-8?B?RU1vQytmZVRsOUR4clZKa08rUFpBV3lvU0RJRUQ1SXBEd1BtZFArRS9BeGhp?=
 =?utf-8?B?SDFFK1BuUXEwWlYvUzM4UFFjUjY2SEdGNFNQYXJUOUttQkU4YWdaRkU1bFZI?=
 =?utf-8?B?MS9leWhJaFBPc1F3SzdlejU1MU41OXhkUUo2MjZFNVkwbXV2VGNsSXBBbU80?=
 =?utf-8?B?QlFSUGltWXdBd2toaEZxWngxN1BPeElTVGR4Z0M3YUgySVpUQkdCSmtsZmJT?=
 =?utf-8?B?bGtRdVhnWllUU29WSWJuRWlmblRreXZtdVA4amhEWWtKRUY4ZFlNaGNRWEFL?=
 =?utf-8?B?ODZUc1VrdndLQU5EeDNBR3VGRk5JSmVyME40bnkvZ1BCeitBOFBtbnF2RUpB?=
 =?utf-8?B?cll4bDBGRlZySkpadXYxV2J2Ukh6NlRIcFVUbVQvbFE2bzlsTWF0amMyT0Jy?=
 =?utf-8?B?dE1yVEtIVnJVTWZZQnZVNHlzRmZVN0ZMZEhnWCtyZk5RTkU3c3MvMHhyRHRY?=
 =?utf-8?B?ejdyMWY4WHllY2k3S0tseVdpS2p0S25tdGFoQ0J3WnlvYWEveXpLc1RtWnJr?=
 =?utf-8?B?TmpUaStrZnZLazNDM204VFlqSkpsc05uYnQ0SDk2bEZSSUdibFBLNlAyNnBJ?=
 =?utf-8?B?YzhlTFBqZGNaSDhEZVBTK08rM1hSZEdkRyszeFRDU05QVVVIUlRXcUU0NnZL?=
 =?utf-8?B?Y2VUay85dHZmalplL0ZTelNXbUtaOHo5R1IrcURlTStHbDR3dXN6ejhyM2ky?=
 =?utf-8?B?a3E4bUwvdkZ1TFZBT09yUUh2MTAvKzI5dXoxTXlEWStLUDZLNXROYXFRVDhM?=
 =?utf-8?Q?mSGPAJbHh9w06?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bE9SMlFWYXdtZWhaYVMwTTdoN21CSXlvVGhRMHdRQU04Q2JtSGUyejBqU3ND?=
 =?utf-8?B?TlNoUU02akN1RHcrMkw1N3l0RVhGQ21MOUQ0cmRnZGdXK240SEk3eTlSV3d0?=
 =?utf-8?B?Zm5zckJ6QVdieExzT0RZSDVxK1FyeEpwZDJyYTdBekJmUWN5STJMWnRJTWJm?=
 =?utf-8?B?ekw4Snp1cXlRSDdIcXZFb1BkTkRZZ1AxcXdFSVBneHdrMmlWdlQ1NlN2Vm9C?=
 =?utf-8?B?STcxM0pHQ281U2Zna2Q2UGlqa1ZGc0p1OUlIM1puVStBWGNMOXBhUFJFL09C?=
 =?utf-8?B?bFp0ZENvWFNhTTlxTHFlKzdySjBKRjRhNHNDbE5MVGV0ZHNBNmpuRUduODUx?=
 =?utf-8?B?UTBjK0RpWEJuaG1EZndjWFpqdmxrZ0Y2aXBDUVQ4L0l5MWpNaXZOYWw1azAz?=
 =?utf-8?B?SzlQYUkwNW9yaFRZQjJhcXlTaWI3ZDJxcmdqcVN0RUJxUHpKR1QzTUVwZXBo?=
 =?utf-8?B?czFIMkhqR0RFZW1UR2I0bktGdStvR1ZwdjMreHNWYURWU3Z4ZzR3WTJwanJI?=
 =?utf-8?B?d3BjWlJ3RWVOUkNZU1c5cERLcjAxNXdJbS9zYmU3MjFsZGEvYThybC9JdU52?=
 =?utf-8?B?WVFxWDN0cEhCSkN5QytyVDN5d01VQVgxUUNjeEtQOHQzOGNJRGVzK3I3eTNI?=
 =?utf-8?B?ZFIxOTNOcFBmN0ZuMnFydGFJWEM0RFJxVitQTmNjblZOa2xWWm54aHpvN1B0?=
 =?utf-8?B?aU5EbVZ6cUhaOHdLb2F0eDBYMENzVVhqSTBSS2xnaC8wa21rM1ZFNHQydXVH?=
 =?utf-8?B?RlVjb2lMbkM3VXFqTEtMeHA5VE9kbGh5bzNQTzlac3FWYkZKSHdJUVNEc3Ns?=
 =?utf-8?B?YldGYlpxVGVvb3lCeEpvWGc5TWtCOGc0ZWpyWlFtM2FyY0pYQjR1RWtSQzZy?=
 =?utf-8?B?WU1aeEhuR0VOVUhVaXIzZjlEK2JTMFlDdU9iQi9DUCtnVmFrVHBnWU1UZ3h4?=
 =?utf-8?B?M1FNRWFpZEkrM2x2MVAvd3hDOVdUN21HOS9tSVZjempDc29KelM2eFlFUS9n?=
 =?utf-8?B?UWd5K0czbHoxbmpZNE8yNGx2bVRZQXpKWnlwNnhMYm1Mc1dJdDNiZXVsMGty?=
 =?utf-8?B?RExScGlhQ2FIQ2lTRUcwZlY0V1diUDczMlZuZXhBQzRNREE5U3czZU1abXRj?=
 =?utf-8?B?OHRFK0tVMEpQMkRIQTNRRDBIcUt4UE43YlBLSVhFRXJtRFhnZWhJY1FjNXhI?=
 =?utf-8?B?bkZ4SGJRMmJZMFlKK3o5QjJTblNOQWZPTGNPUFRTVXcxYUhTenhDeFpzdDBo?=
 =?utf-8?B?d3B3Z0I3QVR3OVpFNUZHMTRiN2ZiTHRIOFZqeFZ4clZYMkcyNDhOLysyYmkz?=
 =?utf-8?B?QUpOYVBCRWhoR3hOSjBadDk3WUFlTlB5MERhcUVvRnNmVzhEYThYRTVmNmFa?=
 =?utf-8?B?SVdWbi8xeUQ3a3BXU0tYN2RId3pSaDIvdWFtRzlkVXA2azgvU2pvYm9YSmhu?=
 =?utf-8?B?ckR3RDl6WlNJNEp3b2o5M3k0R2pkT1laUjdNckRrKzhXMWxQUVcvNS94REIv?=
 =?utf-8?B?bnBGWnVVa1NDK2piQmhLK25QRXplL1FoTnRNTEIzSFFxcUZPc1NYV09pNHRY?=
 =?utf-8?B?UkgzbHBFUWRpWHV0SnViODJDY0VFbTJsTWhDSlhMVzZRVmp6dThFcTFBLzh6?=
 =?utf-8?B?YjFIc0hKSUtyZURTTG5FVDlXb0FOazJzRnBPaTY3MlJkemRGSUNmMitmTGJx?=
 =?utf-8?B?NktRWWwrVDlzS2twLzBHS2FDRWR0a3poUWxEak5WTi9QV042QVlaVlhGR05J?=
 =?utf-8?B?STczd0oxR1NvNEJERyt3MXVNSk0zMWlqSVhsRFBKT09sQWFVUmxwZHRDdzZq?=
 =?utf-8?B?RUxKVmRmNHNQWXJ6M0I1Y2R4bGdnRW9pT3B1STJad1RFVEpTVmMxU3krb3ZD?=
 =?utf-8?B?WFI0czErNWNsZmVnSGxQS1h2MEY4ZUlwWmQvdTZGTGg5VTJMYm5oQXNleGZR?=
 =?utf-8?B?UGhlT3pxYWhUZFprN0RIU1ZjcDZqM3pqNEZET1lpdVhUNHVVRmljbWlqWW84?=
 =?utf-8?B?SDc2YkhFUDhZKzNua3J0SDVVMDFpRXdnY0hQemx5OTlHSzkyWDJNNTB6VmVL?=
 =?utf-8?B?dUNoZEJybGhiK0RGa3ZaMGRTSnMwdmIybkYyNndCYVJHU3RQbDI2VlQwSEww?=
 =?utf-8?B?NDVESWVpRGJsUys5VGtiaDc0VGlvZEpiWW5kaS8zSi8zMzg4V0ZGem9HWVJD?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7add85-42cd-421f-8eaf-08ddddfd3f9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:16:32.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUvsie1kByCaS4kBHSsPVKciyl4+ijvnTrH40KWdCYfuAK95VQLf5p7dMGTMmBA9f24Y3ynDFze6x3hLCgM7M/wFaX2SqZsQQjHv34B1FtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-Proofpoint-GUID: Vf20mpwA4MxAScP0cThCz5E_yEcK9zEE
X-Proofpoint-ORIG-GUID: Vf20mpwA4MxAScP0cThCz5E_yEcK9zEE
X-Authority-Analysis: v=2.4 cv=da2A3WXe c=1 sm=1 tr=0 ts=68a28d03 cx=c_pps
 a=4lC6S8e886TEfyFe2sOs/g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=LNaGZ4S3K2rB8VsfzXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAyMCBTYWx0ZWRfXwJxUY376hasi
 D2PXP/Toebo6IOQ4ZU94/FoIpfXQ2UpRuhHTd9wNV3lHO5xM+2Mlt3yJUhR3d+itLUIx8rqFJT5
 5lAyN3cB2wBLDGSzl5zrxIrzlAPwrKGAc1S8njkPN0hP6HcDdo+MjCXA2BTVbFG9fGEhKsqjHz4
 7OelKdSVvcH9BXe9mqdlWb+vQ8OkdnzwV3gmKsXjZhIBhAp3lLB+dDS8SxBfri8XydAmQFIrjlg
 ireEULQlZTpysKGIkUdG+YOsjGuW0tqX7dvQg5XnL8arTLhQ3RSKVWDJ6Jv5yJSlQJOLDRUf0og
 rDDDOpR207RIH5Py0INQBik0O4SCRP50lCoi+wgjrderVK1TLEqi94bkH++H9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 02:16:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2031

Thanks for your patch, merged

//Hongxu

On 8/18/25 04:46, martin.jansa@gmail.com wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>   recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
>   .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
>   2 files changed, 29 insertions(+)
>   create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
>
> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> index 29abd0e..04ca4cc 100644
> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> @@ -12,6 +12,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
>              file://0001-cutsomize-native-toolchains-for-Yocto.patch \
>              file://0001-fix-compile-failure-on-gcc-13.patch \
>              file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
> +           file://include_stdint.patch \
>   "
>
>   inherit python3native
> diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recipes-devtools/bazel/files/include_stdint.patch
> new file mode 100644
> index 0000000..35c57c2
> --- /dev/null
> +++ b/recipes-devtools/bazel/files/include_stdint.patch
> @@ -0,0 +1,28 @@
> +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde26df426e12/bazel7/include_stdint.patch
> +
> +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues/25514]
> +
> +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_utils.h
> +index 18856ab..5298a36 100644
> +--- a/src/main/cpp/archive_utils.h
> ++++ b/src/main/cpp/archive_utils.h
> +@@ -15,6 +15,7 @@
> + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> +
> ++#include <cstdint>
> + #include <string>
> + #include <vector>
> +
> +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.h
> +index b2cd459..7bf5a00 100644
> +--- a/src/main/cpp/util/logging.h
> ++++ b/src/main/cpp/util/logging.h
> +@@ -14,6 +14,7 @@
> + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
> + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
> +
> ++#include <cstdint>
> + #include <memory>
> + #include <sstream>
> + #include <string>



