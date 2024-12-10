Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D652C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 13:13:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9947.1733836400037024565
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 05:13:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=20745f6cf3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA6KQCp008981;
	Tue, 10 Dec 2024 05:13:19 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1trsf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Awo+uhyzL2UBriDAPVvgTcbheryJq30xRQCKZ5bTQqopYr5X2+1jSRcYf0v+Q/VMRM6ufmtHJjH+DYy3xTAkT20v8BBvQaX3VdBpiTMs000bODGl4KJ9jaTF9OlbWQ5HrABNbxD3wLVNU4ltbsqSBWfqopUfW1Y4br1Xnw9pJG953aCfglVhfObuM2z/nR7taBaM4nOVRLNpYHS0Mgm3Zi4o+I8FbtcnxV9J5/1QrgPADlDu08GkLayOTVY4ZFT0Hx4YKMkvxqwKAGk/DxgSvFutjS7RH9VRrrK2/YTAnMeHc2nYPygCKbcJiTgqz2FHi4iIS/gxEGXwRUSuzECfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTxpvXARs7tysj4k3NZgJfmebVEZc6XAVLkEiIt3M4M=;
 b=WKjG79ynEI+3zj0R8lt5FlNvjodvepMQrehaxhmBvdCMBQ0oKdJfr4YZevn9BKCNASgy7wsGWDC1SC/a+dANC+3URbvDuyoGUhiFeHpoQnk1lZOF/WNQsmyTL6lnJBE+o9qaxZDbCOPhMCOgu4b14rFrA8J5hKaDHm0W7Q7RgYL4mrcAQvrwxRf0ElYsAYJpNYpgCgjLttExN7UhBtPEUmVckf3RWhJAQLSsAjQHG+M+LlG9WrOPV2FGtn+aJfYWzyYTDbpRHec4WEvJY2Hp5Qb9vGlrN8S9jIZO5xOmJbkFJ3HwnnQ5tdPS/XZs6Ml5ISZLqxys3EiyWiDIMrSj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH0PR11MB7586.namprd11.prod.outlook.com (2603:10b6:510:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 13:13:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%7]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 13:13:16 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/4] libselinux-python: fix build with swig 4.3
Date: Tue, 10 Dec 2024 21:12:54 +0800
Message-Id: <20241210131256.2393366-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210131256.2393366-1-yi.zhao@windriver.com>
References: <20241210131256.2393366-1-yi.zhao@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH0PR11MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 41157cad-a31f-41ca-ee69-08dd191c68c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NEpwOTE4YkpDWnBvNEgzdm51VkNMaVlrMVlXU3dvaGlFMWxMRUN6YlJFQVA5?=
 =?utf-8?B?QkxOM0hJbnRXSlFhZ3k3VmkxeCtDSXdVb09XN3g0ZnpybGdIUkRaMEVUNkhM?=
 =?utf-8?B?ckpXMGJwZWlnaDRQY3hvL0hXdWVDeEFROFJ5MFZkVmJqSXZVejB1eHlickZG?=
 =?utf-8?B?dmFZUVlTZDMxdEdrcmdQbWx3Q1laNkp3MUt0cmVHbkZLSno1Rng3WkNZWEFz?=
 =?utf-8?B?OXpKRkVXeUZyakdKWXFBbUhXUHZVVjJzbTlDM25laXI1NElsbTFKczQ1c1J0?=
 =?utf-8?B?OC9EbzB1cy9udHNqZWdLalVUTTkxMmgxZVh0WjJIMWNnaXRWSXJ5eFpCazA5?=
 =?utf-8?B?T0lXM0Jyd3IyNEY5OUFWTUNYcXVLM0gyYytBbURRbE12MHozZ2ExSnNOWlJa?=
 =?utf-8?B?YVEycVhqSHY3QlNqNXVtSGlnNytXbmNRb2RtQWdtaUxYYnp3ZkZvOXdCZWlO?=
 =?utf-8?B?ODVZZFpveTk1akFUSVRrUlZBRW1hRE1DMjh3T2doQXEvNjFDZVY0emV0azVM?=
 =?utf-8?B?a2FsVmx3Y2EreXpjZkFzNzdTYUZkeWFFS3dpNEhmOTE2T2JuUTN1eFhjbVF6?=
 =?utf-8?B?bE5BR25zTzczZ1VHNkJxUkZWc3Y5OEhHcDJ6ck5iTWJ4bFdMWlZFY2ZsQjRU?=
 =?utf-8?B?bjFZYW9kZG0yMUgwRmJWTVMyeCtxSjhLREFlYkl6WnVrV28wSGp6UllxTnNG?=
 =?utf-8?B?YW5HQUJGaGRRZ1YyQVo5TXdoSzQ4MHZmU3ErSEwyYWIyVVN3akxsSVZxMi9W?=
 =?utf-8?B?dkJ3ZUZxY2FTWnJFSkZkdjQxa3BjREtwTTBGNUE1SVVOa3JaSVc2WncySXRG?=
 =?utf-8?B?cnBOL2FUYUhPTDhPS3dIelM3LzI3S0R3bUxiNDJYWWpLR21XMlQzRVYyM09J?=
 =?utf-8?B?cEJvcGJrUzNKMWV3cVpkYzBFa1ppRVVNUVgxV1dibFAwMmEvUUNQUjhkdGRt?=
 =?utf-8?B?WkRyRXFxeEJIWFN1c0NtakJPWFRxOElwTnhlWDZob0hLcGpxbStqdXA5Z1VX?=
 =?utf-8?B?WG91NEhoTmxEVzFVaWFyaFNjZmVRWlBDMVIrbkhRM0E5Q2cyd0UveHkxd2hK?=
 =?utf-8?B?eEpuVTdWY2ZHUExtcFE2b3lDaVlHdDBTdU42YURGa1hqMHluZ2JxRW1pdDRT?=
 =?utf-8?B?ZnQwZjJsMlE1WWk0bXVvQzFJenh5S0NaM01iZFUwbUdjTFI3V2VmVEV2M2Zw?=
 =?utf-8?B?QmVBaEtQZEJwbXNHUjF2NXl6RTM1cWZDcXNIUG4vWENqSWUvR2FDTnBCWEg3?=
 =?utf-8?B?UHdQNlJhT1FXdGxEMnJveDFnenBSRDEweUdZS0k0aFBpMEJFMUYzbnBXcms4?=
 =?utf-8?B?K0pUSFJSUm82ZkRSbEFoWFhVNmkxS1JBdlEyS3hyS2o0cjVsTzhuSXN1dkpt?=
 =?utf-8?B?dTFtOHpGL0FvS0Nkbzhoa2RQRlpIMU8wcHN6Q3JlcFdBSXNUZEc1TEVxYTkx?=
 =?utf-8?B?M3pjeGVGaFB0cGRQRzIzYWRDZlJuMEs2ZTNNNUhvVzhMazNYK3AvUVRKZGND?=
 =?utf-8?B?U3RMcHNVNEhuczJQcGRPMHNsRm9YaTQxNzlybFZPM1I1c0ZHOHh4bjRQK0h4?=
 =?utf-8?B?Rk44MTBHV1NqNm9kWk8zZThNNWYyY3VldWI3elBCamc3blNMM1dmQnZhMEZR?=
 =?utf-8?B?dkhNa1hSNmxCREdrcGt3WlNpaEwvZDJkbk9VRTc1VHFVQjRkeXBFMmJBamVw?=
 =?utf-8?B?T0VYSXJRcTFQMG5ZZnJxZ0RNVllISEh4S3RoWUNzRFNGa3NkMnJhMVRGQmRY?=
 =?utf-8?B?U2hZa1o5MG5Pd1RUR3RWSW5JbEo5UE5jV1ZDZGZ3SlRmSjVaRmhKbGpFdnFN?=
 =?utf-8?B?aUpLZ3prQnNUbHhaM0pyVHJZb1ZPaWlIejl5ZDlBdXB0T2thT3dDL2ZZT285?=
 =?utf-8?B?NDY4bkRoaFNGeW94Q1lkbkxITU5XQ3ZDUGhtdlJSUW1VSnhjeEVuQzRGNEQr?=
 =?utf-8?Q?52qikZVWxnY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjdiTEN4QlR0UjBiOHovMG1FQ1VWQk5PSExwdHNiSkkyL1dpbjBweFRHbzRu?=
 =?utf-8?B?M3BMQVUrTGFDT1BSTUJLbytQNFFWSmdQNVlPelAzWFdlNFd6Uzl2SWE1WStt?=
 =?utf-8?B?bktKSDdjbXNNNTllYXhLcjhPQ3NoNFozYkpHMEdDUWZkd1cwaTBkYm5JaSty?=
 =?utf-8?B?bFV0Wng2QzBjOTBpTHZXWXJKdTQwbnpVcnVpQzZuZWUzNmp5Q05QOWJnekxa?=
 =?utf-8?B?OFU4Q2FVaFoySXVMdnRKTDZlbXF0bm5WSWZ0SXNTSFF6WlFHTEMzUmZXcXNN?=
 =?utf-8?B?RnV2ekVmR0ZPbG96b0hEejRsL1lZMEhScTlWNXdtV3pzTXJla256U0FSSXds?=
 =?utf-8?B?bjdnMlpXaE5weVV0WGxDQXRaaWZqN1J4VkxCSE56RVpXc1YwSkxpbjQ5RmY0?=
 =?utf-8?B?aHVNaGlkREdxWjk2SEpMUzFwdE10KzNMRW1xRUpCbE96V2tHeVJ0MVRzcDJh?=
 =?utf-8?B?Q2ZrU2xRblU5VVo4eXVBY2lDVWk3MWc4dFhMVU9rempYbit2WFFhUXNUWnR6?=
 =?utf-8?B?dVNFTHJzZkJLeThTQzg3RWpCM2dYK2phZjJ3VlRGMGI0bkN3QUlmUVpwZ0VE?=
 =?utf-8?B?b0huU3A0Uzc4eGFEYUZ0WWtFZHhYakNRR3dnUWdLVW13WVFPWGg0NnF6Q1Qx?=
 =?utf-8?B?bVlRWHpyWkkrN2RSQWVMUyt2TngrMzlBR1g5cFFJOGtBNmRWaFIwb1h5cVBL?=
 =?utf-8?B?bXY1QU0rNGVBc2trTTE5SmYvQTkvb1U4cFE0ampSR1hlaTZjM2N4YXg2Mi9s?=
 =?utf-8?B?Skl5c2J3dnowSk9sa1pDSHlHbmE4WmU5RlZsb1BwaEE0NlVSU2owQmNKcjVp?=
 =?utf-8?B?WW1Reit6UlpuYlBGNFRoa08rOHJOa1RZajA4UG54Z3I5WFNSdThoTG50bFJk?=
 =?utf-8?B?TjJTUWw1NnRlV0FxVnVhTllDbzQzR1k3dnNGelhSOVdFTFU1ME4vS2ZhSS84?=
 =?utf-8?B?NXlKblYyY0VPNkQxeWcxaXFoRjh0YXB4cXEvajIxK1h0dW5STjA0VUhsNDQ2?=
 =?utf-8?B?cTllYUJvZ2QxT3U4dWF2dTVjTnpHYittc1hEdm1oTEVidDY1bjArc2NuVyt5?=
 =?utf-8?B?TGhqTVJ4SFQxSFF0L1FmVWU2ck5NZFYzZVYyT2ZZZkZIOGN5R2tuSXcxVGFo?=
 =?utf-8?B?eFlJZ3BqV3lXS1F5MHBna1M1eHNuRzNxUmpONjhBVS9LdGllL29CUTRZeVhI?=
 =?utf-8?B?a3FQRXczNWtSWUlrZVI2a1FQbll2Ujh0enFhdjM5NTJiWE12WXNYRXRZQ0NS?=
 =?utf-8?B?ZzN4bjVNTEpzK1hFODJRRHdkMk9kVlBsN3psRytwSVlqYUx1NFpzMC8xWTFE?=
 =?utf-8?B?QzNFMEFJRmdKK2Vhd0tvTWV1TmgwenpGU0xCM2hFaElkUlphMGpqckJVaEtP?=
 =?utf-8?B?YmdmdUR2YytHRkFHWDJKenJxbGE5NmtGbkszMXVmRjRHRzdYYXozZ2ZpcVJz?=
 =?utf-8?B?Vnp1cm1qeCtqT0ZabnYzZjZ0NFpBcTNPc05PY0JZbVRGN2pJRTlUU3JGcmtJ?=
 =?utf-8?B?cmJ6MEtVaHpLb2U4bnpLQnRFdjZLVzRNWFFHWTJHMDBSVmhuMXRGeXo3N1NS?=
 =?utf-8?B?bDlzTk5zaGRPcUhRV2U0U3duMVBMRWIzTW5TUTBWYkZuaTIzeHNSVEZlUUV2?=
 =?utf-8?B?c2NzZS9aS3V6ajh6K2dBSHQzZlV5K2MzMzhjVXMwT0F0MDlQUzRQY3dqYURO?=
 =?utf-8?B?dzZXQUFUNGU1RTVyTGJyandhTGdCaU5aU3V2WVlWMnprc09yMHdrTHk3MDFT?=
 =?utf-8?B?Ty9lblZJbCtJK25jaGxzZmE5MjJvTnRuZTRaQllVSnJVejNMYjBWZDNJMDBB?=
 =?utf-8?B?ZnpZQXVIUk5vTDZZNmlRSndTbjNrYUVtY0tOaXdsM25meXk2QmxiUHNQeWNT?=
 =?utf-8?B?bzI1TWIxUXRnVDJiVTZpODR0T21YZGZtUnlWYWZTQm12V2l3RHYxcTBpWXVB?=
 =?utf-8?B?QUt4a2JpSGpOU1NLRTkyNlV3eWcxRWlNRnZBbkFTWjY2RnhJNXRDM3dPNTgr?=
 =?utf-8?B?amRqek1HTCsyeE5RbVNGaWtqVmc1TjFVUUxrekU0U3FCZlZRRFN3cjI2eFls?=
 =?utf-8?B?OTA0RjZDL2tNS2VXYkRCK3BKUk1LbEdqN1B3cENreDE1UEg3MGlmekcwRVZq?=
 =?utf-8?Q?H8TRGKombrk0tJbi0w1eOH7L7?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41157cad-a31f-41ca-ee69-08dd191c68c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:13:16.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N5btaf14xeKMVEWPyOYrirtlVDWaCYgq5NdOYhx3G71dGJpVaKxvgaobd+Cm3nUR0E6D7bL4KPtZO34CVz4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7586
X-Proofpoint-ORIG-GUID: vjWVccRLyWUIRFFCHGGF6P1y4-txGH7Y
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67583e6e cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=AWekD7wbPusstyTxx90A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vjWVccRLyWUIRFFCHGGF6P1y4-txGH7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100098
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4BA6KQCp008981
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 13:13:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/878

Backport a patch to fix build with swig 4.3[1].

[1] https://github.com/SELinuxProject/selinux/issues/447

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../selinux/libselinux-python_3.7.bb          |  1 +
 ...bselinux-fix-swig-bindings-for-4.3.0.patch | 91 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 recipes-security/selinux/libselinux/0001-libselinux-f=
ix-swig-bindings-for-4.3.0.patch

diff --git a/recipes-security/selinux/libselinux-python_3.7.bb b/recipes-=
security/selinux/libselinux-python_3.7.bb
index 3c5c489..5099e55 100644
--- a/recipes-security/selinux/libselinux-python_3.7.bb
+++ b/recipes-security/selinux/libselinux-python_3.7.bb
@@ -15,6 +15,7 @@ SRC_URI +=3D "\
         file://0001-Makefile-fix-python-modules-install-path-for-multili=
.patch \
         file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam=
.patch \
         file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona=
.patch \
+        file://0001-libselinux-fix-swig-bindings-for-4.3.0.patch \
         "
=20
 S =3D "${WORKDIR}/git/libselinux"
diff --git a/recipes-security/selinux/libselinux/0001-libselinux-fix-swig=
-bindings-for-4.3.0.patch b/recipes-security/selinux/libselinux/0001-libs=
elinux-fix-swig-bindings-for-4.3.0.patch
new file mode 100644
index 0000000..277c36c
--- /dev/null
+++ b/recipes-security/selinux/libselinux/0001-libselinux-fix-swig-bindin=
gs-for-4.3.0.patch
@@ -0,0 +1,91 @@
+From 8e0e718bae53fff30831b92cd784151d475a20da Mon Sep 17 00:00:00 2001
+From: Petr Lautrbach <lautrbach@redhat.com>
+Date: Wed, 16 Oct 2024 20:48:11 +0200
+Subject: [PATCH] libselinux: fix swig bindings for 4.3.0
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+https://github.com/swig/swig/blob/master/CHANGES.current
+
+"[Python] #2907 Fix returning null from functions with output
+parameters.  Ensures OUTPUT and INOUT typemaps are handled
+consistently wrt return type.
+
+New declaration of SWIG_Python_AppendOutput is now:
+
+  SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void)=
;
+
+The 3rd parameter is new and the new $isvoid special variable
+should be passed to it, indicating whether or not the wrapped
+function returns void.
+
+Also consider replacing with:
+
+  SWIG_AppendOutput(PyObject* result, PyObject* obj);
+
+which calls SWIG_Python_AppendOutput with same parameters but adding $is=
void
+for final parameter."
+
+Fixes: https://github.com/SELinuxProject/selinux/issues/447
+
+    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_compu=
te_user=E2=80=99:
+    selinuxswig_python_wrap.c:11499:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
+    11499 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist)=
;
+          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
+    selinuxswig_python_wrap.c:1248:1: note: declared here
+     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
+          | ^~~~~~~~~~~~~~~~~~~~~~~~
+    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_compu=
te_user_raw=E2=80=99:
+    selinuxswig_python_wrap.c:11570:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
+    11570 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist)=
;
+          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
+    selinuxswig_python_wrap.c:1248:1: note: declared here
+     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
+          | ^~~~~~~~~~~~~~~~~~~~~~~~
+    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_get_b=
oolean_names=E2=80=99:
+    selinuxswig_python_wrap.c:12470:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
+    12470 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, list);
+          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
+    selinuxswig_python_wrap.c:1248:1: note: declared here
+     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
+          | ^~~~~~~~~~~~~~~~~~~~~~~~
+    error: command '/usr/bin/gcc' failed with exit code 1
+
+Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
+Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
+Acked-by: James Carter <jwcart2@gmail.com>
+
+Upstream-Status: Backport
+[https://github.com/SELinuxProject/selinux/commit/8e0e718bae53fff30831b9=
2cd784151d475a20da]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ src/selinuxswig_python.i | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/src/selinuxswig_python.i b/src/selinuxswig_python.i
+index 17e03b9e..03ed296d 100644
+--- a/src/selinuxswig_python.i
++++ b/src/selinuxswig_python.i
+@@ -71,7 +71,7 @@ def install(src, dest):
+ 	for (i =3D 0; i < *$2; i++) {
+ 		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
+ 	}
+-	$result =3D SWIG_Python_AppendOutput($result, list);
++	$result =3D SWIG_AppendOutput($result, list);
+ }
+=20
+ /* return a sid along with the result */
+@@ -108,7 +108,7 @@ def install(src, dest):
+ 		plist =3D PyList_New(0);
+ 	}
+=20
+-	$result =3D SWIG_Python_AppendOutput($result, plist);
++	$result =3D SWIG_AppendOutput($result, plist);
+ }
+=20
+ /* Makes functions in get_context_list.h return a Python list of contex=
ts */
+--=20
+2.25.1
+
--=20
2.25.1


