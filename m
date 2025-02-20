Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B8C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 09:44:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.45836.1740044660702569602
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 01:44:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=41465756f6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7GFMI012597;
	Thu, 20 Feb 2025 01:44:19 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44w00ka6pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 01:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsjaxwmSlCoCPUSEGTXh9Ep19bNhDhZbu0UwEC08C3w1Ww74xI9luixtavbHXZBWI8BEongdiNefkYzsja049e99x7GJVtOLjpaRWR7nGJT4BlIbetRXfzr5OB4Nax07DpT8cgHrgmuxTY4pN2R0lo2Px7ZpsS0iEfwQabh7k9KWmkPG3itYSaAqcpBe/FfNKZ/nELm++rt6KB7oP5TjxYmY219W/NANp8yI1ORvR3colEWmBi8bs1zeH0NM6kB8KKVT/JWRj968XVWFfnIe3H1YDoPc6YSfVDtqpKMdiV0W67EqxCRdxxvVV0wjObM3OGSXFOkLFiWjSIRewBDpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1chmUpETNJxe3dRwsTjlM4mRsp8a/eGF7XpQc+flH4A=;
 b=d7SaiaYMKanOjION6ASBbq6qQo0GuStIANYUbBLG0ewrBLWH2ewyySUKQ4QDGvstBcmJQNmJO/Hj3kgIZXpr3uzCbzTotH8vZkeAeYjzPKB310/6mXwuVQCMImA2NXYKoTr7ixmNgd25LbXmEo3egVzDhCOzH9rN+wpbzf3ANAW9rtHgfVWH+WZ0oOioD6mZXi7FQ46IesAu3DBXtd+imrMlvmJ+XTpopOpPkDHrz5mXMWh1EpDHd/50OasaODo7lWasiZOs2bWS7UODOevqUfxN0fyuVE1r88gZzDJKNXVXH/UJ9d9ObvfRwVX/hjwzwYQ/PyRxouFQthGvCS/RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:44:17 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:44:17 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/3] selinux: upgrade 3.7 -> 3.8
Date: Thu, 20 Feb 2025 17:43:44 +0800
Message-Id: <20250220094345.1119650-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220094345.1119650-1-yi.zhao@windriver.com>
References: <20250220094345.1119650-1-yi.zhao@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: a25f2997-1a2e-48b1-5c97-08dd51932482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTQ3dzVLWHRUU2xMQlgxV0Q0QWdhalhYUnlrNk9UYVpjZFlIRlNwcjFqdHM3?=
 =?utf-8?B?WC9DdU52Q3NlY2t3c1hzVG54QWZUalpoY1Q3VTUyaW5YNUx2MzkwcE16RzlD?=
 =?utf-8?B?TklFM3EyZWJyL2hpaStNdmtscllxc2VJTnNEanAyM2V2V3A1MmNFRmFyQ1R6?=
 =?utf-8?B?Um1wSnZFeEhVM284c0FPSHJ0dXVSb0hBRTNQSE1vaEhkbFg2ZDQ0Ny9WSVlj?=
 =?utf-8?B?YzV6d0oxbW5hZlpBZVcxMmJxSGdRcys1QnhzQzlWeWNBM2lSSCtmdFdOMGY1?=
 =?utf-8?B?cnhncGg2NUpzMEtwRWxQa3lrNGwySDdrTnl3YU1DcUNpNXpVYkZRbFMwVm1n?=
 =?utf-8?B?bzdJL1BKcDBpbHd5MVFCUENrdlZjTU9VRGZBQ1VhdDg1ZXRta2c4WkxQT0F2?=
 =?utf-8?B?ajh1KzlvK0dhMU1YeDZnMXU3ejVDVmkyK080Sk1WV0QyRVRvZTE0QWFEdG51?=
 =?utf-8?B?ZXFIR3ZMQTdFRjFRWm9xR0V2VnI0VzY2QkhIcW1vWU5Rc3lwdy9hN2F0YVdW?=
 =?utf-8?B?dWNKUHo4ZStJeWJyc2x4QW1JWGFDN0RsZWNteDZXbWRLcVIxK0MrSnVUOTAx?=
 =?utf-8?B?dTVGY05Sd1k0L3BOUlI5ZUhrR2FkUVlCRXZPRXMrRWhRenhTTm5qM0RvU25H?=
 =?utf-8?B?R2lGeWh1Q0hEQ1pkWlZ5Qkt4eEwrcmR0OHcwQmpBanhjVGFJcGV3Qm5Wd0tN?=
 =?utf-8?B?eGV3NytxTVdISkxqWmFwWGIrTW5tbXAzaHd6MW9BUU1XekZrdWZGa01ITUFo?=
 =?utf-8?B?UHNUekIyckY3ODlITGdSWTJ4V2ZqMFhIYjZ6ZXMvZVBPQUtKRHp6ODEzZFlt?=
 =?utf-8?B?SkVEMnZ5Zm0zMkNsZXFIMXpCWVM1TlczeUVrRGVFUm1SRDAwLzRlTENUdUZW?=
 =?utf-8?B?djRDYmdHeTV3Uzk3SDdEVjY4S1Y4b0FBaUhWOEdtdU9ZVHNQSGEvL2lEWXdp?=
 =?utf-8?B?YTZXTlk2dTNoeUpRS1NsT1NnQzFMWkFNeVJnUXhUT21IOGlZUE5wNUszR0xJ?=
 =?utf-8?B?R0ROR3puYmZza1dSOGVjN1VDNGZka1lSYSs4UXBlZ0pxbDRHc0V1WGFuNHl3?=
 =?utf-8?B?QjdPSXoza2ROUUNMWVFWcUJnVjYxeFd3UUJ0bXM5SFdRNTc5bm5mQTJLMi9i?=
 =?utf-8?B?a2l5dVpnMExXRlgvUzhYbUJvOGlmVFdsaDBlcW9qNUh5YkZwamVIMkgzcUQy?=
 =?utf-8?B?V0V0cy9ka2xuTFlYQnovQlQvUkE0NE51SmNkanc4cVpWYnpMNjhpc3NzaE80?=
 =?utf-8?B?UmdsdmsxR1J3Ynh6YXNYTUE4T3B0N09aY09XOERUN1RidlZTejRkcUtCQXll?=
 =?utf-8?B?TDJpYmNGWU14MHdXYmdPa0NrQWdZVWRmeGprMGlGemM1KzBSL2tDaVR2S1BH?=
 =?utf-8?B?bHVQUFJqS2NmRm1Lcitob2dRdkplUXpFYVBZSlBwYzdqMTE5TWY5bFYwY2lS?=
 =?utf-8?B?N3RxekUrNFJXRFczanIwY2xVbnFobkRHUjZxcldON2VXaTlHZnVUdk5KZ0pv?=
 =?utf-8?B?LzBSQ0g0dDR2dTRRYlNTN0pwTWIvSnhDVFhiZzM2ZFVDczNGd3hBSENWa2tm?=
 =?utf-8?B?TmdlSG5YckhHNUJSNmM0WVBWSU5wb1JyTGw3azNUdVpJM081R1gveTh1aGY2?=
 =?utf-8?B?MVNYNlY5MlZqWXlPeEdVRFYvSlJ1VzduZmRXcldmNXZhRUJWRVlDcmM5bjV4?=
 =?utf-8?B?bC9JeVBoc2p5cFdma3h6NXRXMWRxNnV3YWt5S3Q4aFl0dS96UkNuQ3ZIVGxC?=
 =?utf-8?B?NWZyVVdhamdZU0ZQejI3a3YwY2Voa1duS1JjQjQ4THYyZE52V1NZYktSQ2Ev?=
 =?utf-8?B?QVh6dWdXS1QzdkJMNFllamo4UUdIaVhtTURpdFlzNzBpNEgrdVZBdjJQVWtK?=
 =?utf-8?B?RmhTZ2QwelcrU2krQXhVV1VNQlR1U0Y1dHdGMlFWSHJOdXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWl6REZXMlVKQUhWVzkzcFVPczZuWEhkQjlmTm4zN1RlOWF3OWt6SDdweEhk?=
 =?utf-8?B?TDRWZlFNOE1LbUVCbXdRL3MyQlozTVVDN3czaTdoSFd4c0EvbHl6SkJ1Vko0?=
 =?utf-8?B?MGdnTmp4WlkzcHptQUl0aEQwbmxXMytQUWRsc2szRUJ6WlR1Zmk0Y1pNTkVK?=
 =?utf-8?B?NE1LemErS1Bhc1h0c1Zib2ZZNHlNaFY5dkxjbGQxek80Zy9laC9RcmRDbkVt?=
 =?utf-8?B?L2g1SmlNeU9xNTZvZWNJc2NNQThuY0NRd0N1RTFubDZ6dU83SGZ6eiszK1ZM?=
 =?utf-8?B?N0p6U2d0c215VTdUSHY1N3JTVStvcGVNZ2djZFprOUNlMndlYUE3MFdpZ0JT?=
 =?utf-8?B?TWV1KzBqN1l6dnRReGFaK3NWaHEycXdicFFtNXc4YUVoTkl5aG1QL3YrcUJl?=
 =?utf-8?B?bEFqWjhkRW1DU3RJQnhSNkxhUHJrWnF0TklOMXlVNnBrOFArOTJ1MVp3azNs?=
 =?utf-8?B?VmVzOXJxc1NaRDduOTBwaTBZZDdTQStZM1lOMm9Tb3djLzFwd2J2d3RGMTFz?=
 =?utf-8?B?ek0yUzNYakhTTXlLbmdrOGk2Ri9Pdi85KzYrbVBFUFd1WDdYN2YyazYxKzZN?=
 =?utf-8?B?OHZKNnRoNzcyRkpGWVEzL3JKK2ZULzdwa1llcnc2MGNCZnU2SUUwaXJ4Uk9o?=
 =?utf-8?B?L3NqQ2xzNkwvOGdwU3IwRTBxamx3NWFqYXRaUzJiT1d5eU1hTHlJWS92S3Ro?=
 =?utf-8?B?NG52UmtiRUlCakI3TlgyZzNoMW5tT1JWbWZZRnRKSTAvSjdleDF1cEgvcXZE?=
 =?utf-8?B?WDZ1WVppc2N4NnhibVFRRDVtNDNTUFJaVVJoaW0yVlNHUFU0aUV2NjNiaDdN?=
 =?utf-8?B?T0dhVHdKUnhyc0Y2aWlRS3lKNzU5WnpRUHlkSTJJSllYRGdFMHVnSEFValJw?=
 =?utf-8?B?VUJrR2hQS3RWbjVlY01RQTVnTnZlRHZ2M01MaENGWkM1UlZiWUhKN0F1SmZN?=
 =?utf-8?B?VmFqdlVnSGtXQ2xDcWxMZExxVXNkUnkxMEp5QkMvUmlreUNZa2VLd1hJVDRI?=
 =?utf-8?B?QWFRdm9meWNZejNsd1lGOFpocFpSMWJPMTlvdXpYTnZrV2srQ3hvUm9LLzIv?=
 =?utf-8?B?dDR3eC9iZ3lPcXhzUFh5a1VvdWs3dkhXQlh3ZHhVbXFNdVVyVStteEY3ZUFF?=
 =?utf-8?B?MTBPNXY3YmdyRm82ckw4TW1IQUZWN2ZmYWQzcGR3TTFsRU5pbWhMOWd3ZVlD?=
 =?utf-8?B?bkg3YkdCNDZrNDZUbzJNNmtUSDB6dGd4NUZndDRwZ2VsU25UQUhHWU9xUzFq?=
 =?utf-8?B?SFRIc0s4S0NmcTBGYjg5ZEFMWVBmRVUyTnF0T1B3aFAvWW56M3VocUMwQTFS?=
 =?utf-8?B?VzV4K0s3R3owbUNaVXF4REtVZ2F4UlNNekNyZGw0SDk3ODdxMVVOWHByUnFD?=
 =?utf-8?B?QXdGeHhCL2tSWThUV0dZbUI0Q0loK0Jlc1FQTUZiWmVCRFgzalZYU0FuNHpi?=
 =?utf-8?B?bWc2bzN2RzREQWU1dG8xeVV4TUNRWEpTVzQrdTIwdDg4ZUlNZDB6NlB6bDBK?=
 =?utf-8?B?cUJBNVVqODBqN1BLVS9DRUVwSTQ0MXo2b1dFODVFOGVvbVVRc2VmVDNtcXZr?=
 =?utf-8?B?TGlCQWZ1V0VKdTRoSXRWUTc2T2VzTmxLUlVFTSs5K1NTVHpuNGpFVDhrVjdV?=
 =?utf-8?B?R0VkVFUrS2licUF0UVRpdnVtODhHYTNMNUNZTXc0SjJ5eXVaVnhGRGtJL21G?=
 =?utf-8?B?QlNSL1QrdzFBcW12eHo5WjFxcHFHREErZnlDWUZjZUhTNE1DdnJmRk9GUEd3?=
 =?utf-8?B?TWwvQmFaMm1Id1J1YXBMQ0NsSGx2OGZwOUdlb2hoRFgrYVAxTW11U091aDB2?=
 =?utf-8?B?cTFrYTU2bno3bHpseDgyZnoxOHBXS1VYUC8xSDRjb0RjUnBYQkxqUkcxa3ly?=
 =?utf-8?B?dTFiRnlkcEpBT1NadXBkUHdaRVYxdWZERVZ6a0ovUkl5RVlqY2tUVTdkQVRX?=
 =?utf-8?B?cXhVeGJsREdYSDJ4S0g5TmJIZ0d0eWVod2ZISTRPL1d6TjYyTDRzRTFSdGl6?=
 =?utf-8?B?dFViclYzQ3Z4RmtqNlNMbHV4ZWxDTm11KzdzUVpwcDJpRnRVdDkyVStXTVJP?=
 =?utf-8?B?U0lFbjJaZUVoQitqWURFaFpGU3JBK2d5clBMTlg4Qzg0TDZURlVMaEZZK1oz?=
 =?utf-8?Q?h7tlQrM0wjfqYcVyCLbCWkSqG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25f2997-1a2e-48b1-5c97-08dd51932482
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:44:17.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEKS9n/9VhasVCFO7cW3Ry35d3VoyY7SMqFz7YDeGdRDSjwcmD4OI2DF0yH5APitdqp+gzThPQJuWrvxlf6JhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-Authority-Analysis: v=2.4 cv=N67TF39B c=1 sm=1 tr=0 ts=67b6f973 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8 a=9pIZn19CAAAA:8 a=KR5XLSZxAAAA:8 a=bZcZfQ3yjtHM5BcG-j4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=d3PnA9EDa4IxuAV0gXij:22 a=8RSB8XlrRKoi1kmjPpsj:22
 a=KKIIu8bCiOnaXtcgZrz_:22
X-Proofpoint-ORIG-GUID: 5yWf7SHCPzzV6sSbOitE5lZjNiGEhS00
X-Proofpoint-GUID: 5yWf7SHCPzzV6sSbOitE5lZjNiGEhS00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502200071
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 51K7GFMI012597
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 09:44:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1098

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.8

* libsemanage: Preserve file context and ownership in policy store
* libselinux: deprecate security_disable(3)
* libsepol: Support nlmsg extended permissions
* libsepol: Add policy capability netlink_xperm
* libsemanage: Optionally allow duplicate declarations
* policycoreutils: introduce unsetfiles
* libselinux/utils: introduce selabel_compare
* improved selabel_lookup performance
* libselinux: support parallel usage of selabel_lookup(3)
* libsepol: add support for xperms in conditional policies
* Improved man pages
* Code improvements and bug fixes
* Always build for LFS mode on 32-bit archs.
* libsemanage: Mute error messages from selinux_restorecon introduced in
  3.8-rc1
* Regex spec ordering is restored to pre 3.8-rc1
* Binary fcontext files format changed, files using old format are ignore=
d
* Code improvements and bug fixes

License-Update: White space cleanup for libsemanage/LICENSE

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...{checkpolicy_3.7.bb =3D> checkpolicy_3.8.bb} |   0
 ...python_3.7.bb =3D> libselinux-python_3.8.bb} |   1 -
 ...hon-modules-install-path-for-multili.patch |   6 +-
 ...bselinux-fix-swig-bindings-for-4.3.0.patch |  91 ----
 ...T-and-rely-on-the-installed-file-nam.patch |   6 +-
 ...re-drop-the-obsolete-LSF-transitiona.patch |   8 +-
 .../{libselinux_3.7.bb =3D> libselinux_3.8.bb}  |   0
 ...semanage-fix-swig-bindings-for-4.3.0.patch | 422 ------------------
 ...anage-Fix-execve-segfaults-on-Ubuntu.patch |   6 +-
 ...anage-allow-to-disable-audit-support.patch |  14 +-
 ...-disable-expand-check-on-policy-load.patch |   2 +-
 ...{libsemanage_3.7.bb =3D> libsemanage_3.8.bb} |   3 +-
 .../{libsepol_3.7.bb =3D> libsepol_3.8.bb}      |   0
 .../{mcstrans_3.7.bb =3D> mcstrans_3.8.bb}      |   2 +-
 ...oreutils_3.7.bb =3D> policycoreutils_3.8.bb} |   0
 ...{restorecond_3.7.bb =3D> restorecond_3.8.bb} |   0
 .../selinux/{secilc_3.7.bb =3D> secilc_3.8.bb}  |   0
 ...elinux-dbus_3.7.bb =3D> selinux-dbus_3.8.bb} |   0
 ...{selinux-gui_3.7.bb =3D> selinux-gui_3.8.bb} |   0
 ...ux-python_3.7.bb =3D> selinux-python_3.8.bb} |   0
 ...-sandbox_3.7.bb =3D> selinux-sandbox_3.8.bb} |   0
 recipes-security/selinux/selinux_common.inc   |   2 +-
 ...ule-utils_3.7.bb =3D> semodule-utils_3.8.bb} |   0
 23 files changed, 24 insertions(+), 539 deletions(-)
 rename recipes-security/selinux/{checkpolicy_3.7.bb =3D> checkpolicy_3.8=
.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.7.bb =3D> libselinu=
x-python_3.8.bb} (96%)
 delete mode 100644 recipes-security/selinux/libselinux/0001-libselinux-f=
ix-swig-bindings-for-4.3.0.patch
 rename recipes-security/selinux/{libselinux_3.7.bb =3D> libselinux_3.8.b=
b} (100%)
 delete mode 100644 recipes-security/selinux/libsemanage/0001-libsemanage=
-fix-swig-bindings-for-4.3.0.patch
 rename recipes-security/selinux/{libsemanage_3.7.bb =3D> libsemanage_3.8=
.bb} (92%)
 rename recipes-security/selinux/{libsepol_3.7.bb =3D> libsepol_3.8.bb} (=
100%)
 rename recipes-security/selinux/{mcstrans_3.7.bb =3D> mcstrans_3.8.bb} (=
97%)
 rename recipes-security/selinux/{policycoreutils_3.7.bb =3D> policycoreu=
tils_3.8.bb} (100%)
 rename recipes-security/selinux/{restorecond_3.7.bb =3D> restorecond_3.8=
.bb} (100%)
 rename recipes-security/selinux/{secilc_3.7.bb =3D> secilc_3.8.bb} (100%=
)
 rename recipes-security/selinux/{selinux-dbus_3.7.bb =3D> selinux-dbus_3=
.8.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.7.bb =3D> selinux-gui_3.8=
.bb} (100%)
 rename recipes-security/selinux/{selinux-python_3.7.bb =3D> selinux-pyth=
on_3.8.bb} (100%)
 rename recipes-security/selinux/{selinux-sandbox_3.7.bb =3D> selinux-san=
dbox_3.8.bb} (100%)
 rename recipes-security/selinux/{semodule-utils_3.7.bb =3D> semodule-uti=
ls_3.8.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.7.bb b/recipes-securi=
ty/selinux/checkpolicy_3.8.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.7.bb
rename to recipes-security/selinux/checkpolicy_3.8.bb
diff --git a/recipes-security/selinux/libselinux-python_3.7.bb b/recipes-=
security/selinux/libselinux-python_3.8.bb
similarity index 96%
rename from recipes-security/selinux/libselinux-python_3.7.bb
rename to recipes-security/selinux/libselinux-python_3.8.bb
index 5099e55..3c5c489 100644
--- a/recipes-security/selinux/libselinux-python_3.7.bb
+++ b/recipes-security/selinux/libselinux-python_3.8.bb
@@ -15,7 +15,6 @@ SRC_URI +=3D "\
         file://0001-Makefile-fix-python-modules-install-path-for-multili=
.patch \
         file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam=
.patch \
         file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona=
.patch \
-        file://0001-libselinux-fix-swig-bindings-for-4.3.0.patch \
         "
=20
 S =3D "${WORKDIR}/git/libselinux"
diff --git a/recipes-security/selinux/libselinux/0001-Makefile-fix-python=
-modules-install-path-for-multili.patch b/recipes-security/selinux/libsel=
inux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
index b307b6f..28a2cc0 100644
--- a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-module=
s-install-path-for-multili.patch
+++ b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-module=
s-install-path-for-multili.patch
@@ -1,4 +1,4 @@
-From dff260851ccecf9723a6ddfce0103e09f3ba4613 Mon Sep 17 00:00:00 2001
+From 626d07afcb8e8b3a68158e8a3ea1654620769644 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 13 Apr 2020 12:44:23 +0800
 Subject: [PATCH] Makefile: fix python modules install path for multilib
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
=20
 diff --git a/src/Makefile b/src/Makefile
-index d3b981f..265f1be 100644
+index 213c7d3..92227cb 100644
 --- a/src/Makefile
 +++ b/src/Makefile
-@@ -191,7 +191,7 @@ install: all
+@@ -193,7 +193,7 @@ install: all
  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$=
(TARGET)
 =20
  install-pywrap: pywrap
diff --git a/recipes-security/selinux/libselinux/0001-libselinux-fix-swig=
-bindings-for-4.3.0.patch b/recipes-security/selinux/libselinux/0001-libs=
elinux-fix-swig-bindings-for-4.3.0.patch
deleted file mode 100644
index 277c36c..0000000
--- a/recipes-security/selinux/libselinux/0001-libselinux-fix-swig-bindin=
gs-for-4.3.0.patch
+++ /dev/null
@@ -1,91 +0,0 @@
-From 8e0e718bae53fff30831b92cd784151d475a20da Mon Sep 17 00:00:00 2001
-From: Petr Lautrbach <lautrbach@redhat.com>
-Date: Wed, 16 Oct 2024 20:48:11 +0200
-Subject: [PATCH] libselinux: fix swig bindings for 4.3.0
-MIME-Version: 1.0
-Content-Type: text/plain; charset=3DUTF-8
-Content-Transfer-Encoding: 8bit
-
-https://github.com/swig/swig/blob/master/CHANGES.current
-
-"[Python] #2907 Fix returning null from functions with output
-parameters.  Ensures OUTPUT and INOUT typemaps are handled
-consistently wrt return type.
-
-New declaration of SWIG_Python_AppendOutput is now:
-
-  SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void)=
;
-
-The 3rd parameter is new and the new $isvoid special variable
-should be passed to it, indicating whether or not the wrapped
-function returns void.
-
-Also consider replacing with:
-
-  SWIG_AppendOutput(PyObject* result, PyObject* obj);
-
-which calls SWIG_Python_AppendOutput with same parameters but adding $is=
void
-for final parameter."
-
-Fixes: https://github.com/SELinuxProject/selinux/issues/447
-
-    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_compu=
te_user=E2=80=99:
-    selinuxswig_python_wrap.c:11499:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
-    11499 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist)=
;
-          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
-    selinuxswig_python_wrap.c:1248:1: note: declared here
-     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
-          | ^~~~~~~~~~~~~~~~~~~~~~~~
-    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_compu=
te_user_raw=E2=80=99:
-    selinuxswig_python_wrap.c:11570:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
-    11570 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist)=
;
-          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
-    selinuxswig_python_wrap.c:1248:1: note: declared here
-     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
-          | ^~~~~~~~~~~~~~~~~~~~~~~~
-    selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_get_b=
oolean_names=E2=80=99:
-    selinuxswig_python_wrap.c:12470:17: error: too few arguments to func=
tion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
-    12470 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, list);
-          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
-    selinuxswig_python_wrap.c:1248:1: note: declared here
-     1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, in=
t is_void) {
-          | ^~~~~~~~~~~~~~~~~~~~~~~~
-    error: command '/usr/bin/gcc' failed with exit code 1
-
-Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
-Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
-Acked-by: James Carter <jwcart2@gmail.com>
-
-Upstream-Status: Backport
-[https://github.com/SELinuxProject/selinux/commit/8e0e718bae53fff30831b9=
2cd784151d475a20da]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- src/selinuxswig_python.i | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/src/selinuxswig_python.i b/src/selinuxswig_python.i
-index 17e03b9e..03ed296d 100644
---- a/src/selinuxswig_python.i
-+++ b/src/selinuxswig_python.i
-@@ -71,7 +71,7 @@ def install(src, dest):
- 	for (i =3D 0; i < *$2; i++) {
- 		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
- 	}
--	$result =3D SWIG_Python_AppendOutput($result, list);
-+	$result =3D SWIG_AppendOutput($result, list);
- }
-=20
- /* return a sid along with the result */
-@@ -108,7 +108,7 @@ def install(src, dest):
- 		plist =3D PyList_New(0);
- 	}
-=20
--	$result =3D SWIG_Python_AppendOutput($result, plist);
-+	$result =3D SWIG_AppendOutput($result, plist);
- }
-=20
- /* Makes functions in get_context_list.h return a Python list of contex=
ts */
---=20
-2.25.1
-
diff --git a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-a=
nd-rely-on-the-installed-file-nam.patch b/recipes-security/selinux/libsel=
inux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
index 7ebe64f..ae0da8b 100644
--- a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely=
-on-the-installed-file-nam.patch
+++ b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely=
-on-the-installed-file-nam.patch
@@ -1,4 +1,4 @@
-From 303d8dfe53fcd02ea5818f976369cdb629bc1114 Mon Sep 17 00:00:00 2001
+From 1048b80be8fe800fa343f26db833a6e89b5ba9ab Mon Sep 17 00:00:00 2001
 From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 Date: Fri, 25 Oct 2019 13:37:14 +0200
 Subject: [PATCH] Do not use PYCEXT, and rely on the installed file name
@@ -27,7 +27,7 @@ Signed-off-by: Changqing Li <changqing.li@windriver.com=
>
  1 file changed, 1 insertion(+), 2 deletions(-)
=20
 diff --git a/src/Makefile b/src/Makefile
-index 265f1be..47e51d6 100644
+index 92227cb..7c71c65 100644
 --- a/src/Makefile
 +++ b/src/Makefile
 @@ -15,7 +15,6 @@ INCLUDEDIR ?=3D $(PREFIX)/include
@@ -38,7 +38,7 @@ index 265f1be..47e51d6 100644
  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarch=
hdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"=
] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBR=
UBYARG_SHARED"]')
  RUBYINSTALL ?=3D $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchd=
ir"]')
-@@ -193,7 +192,7 @@ install: all
+@@ -195,7 +194,7 @@ install: all
  install-pywrap: pywrap
  	CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip insta=
ll --prefix=3D$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(=
PYTHON_SETUP_ARGS) .
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__=
.py
diff --git a/recipes-security/selinux/libselinux/0003-libselinux-restore-=
drop-the-obsolete-LSF-transitiona.patch b/recipes-security/selinux/libsel=
inux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
index 0cd8f20..39edb6c 100644
--- a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-th=
e-obsolete-LSF-transitiona.patch
+++ b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-th=
e-obsolete-LSF-transitiona.patch
@@ -1,4 +1,4 @@
-From 6c2af45ec8cff9b282d599dc098db0ca127bdc59 Mon Sep 17 00:00:00 2001
+From f33b426680492629d3d8ed664049cbe584f26f18 Mon Sep 17 00:00:00 2001
 From: Renato Caldas <renato@calgera.com>
 Date: Thu, 29 Jun 2023 13:59:11 +0100
 Subject: [PATCH] libselinux: restore: drop the obsolete LSF transitional=
 API.
@@ -14,10 +14,10 @@ Signed-off-by: Renato Caldas <renato@calgera.com>
  1 file changed, 2 insertions(+), 2 deletions(-)
=20
 diff --git a/src/selinux_restorecon.c b/src/selinux_restorecon.c
-index 38f10f1..5b3d035 100644
+index bc6ed93..3bc0d8d 100644
 --- a/src/selinux_restorecon.c
 +++ b/src/selinux_restorecon.c
-@@ -436,7 +436,7 @@ static int filespec_add(ino_t ino, const char *con, =
const char *file,
+@@ -438,7 +438,7 @@ static int filespec_add(ino_t ino, const char *con, =
const char *file,
  	file_spec_t *prevfl, *fl;
  	uint32_t h;
  	int ret;
@@ -26,7 +26,7 @@ index 38f10f1..5b3d035 100644
 =20
  	__pthread_mutex_lock(&fl_mutex);
 =20
-@@ -450,7 +450,7 @@ static int filespec_add(ino_t ino, const char *con, =
const char *file,
+@@ -452,7 +452,7 @@ static int filespec_add(ino_t ino, const char *con, =
const char *file,
  	for (prevfl =3D &fl_head[h], fl =3D fl_head[h].next; fl;
  	     prevfl =3D fl, fl =3D fl->next) {
  		if (ino =3D=3D fl->ino) {
diff --git a/recipes-security/selinux/libselinux_3.7.bb b/recipes-securit=
y/selinux/libselinux_3.8.bb
similarity index 100%
rename from recipes-security/selinux/libselinux_3.7.bb
rename to recipes-security/selinux/libselinux_3.8.bb
diff --git a/recipes-security/selinux/libsemanage/0001-libsemanage-fix-sw=
ig-bindings-for-4.3.0.patch b/recipes-security/selinux/libsemanage/0001-l=
ibsemanage-fix-swig-bindings-for-4.3.0.patch
deleted file mode 100644
index cba77c9..0000000
--- a/recipes-security/selinux/libsemanage/0001-libsemanage-fix-swig-bind=
ings-for-4.3.0.patch
+++ /dev/null
@@ -1,422 +0,0 @@
-From e38815d7b44cac435195c82a54d2bf2517bc4b1a Mon Sep 17 00:00:00 2001
-From: Petr Lautrbach <lautrbach@redhat.com>
-Date: Wed, 16 Oct 2024 20:48:12 +0200
-Subject: [PATCH] libsemanage: fix swig bindings for 4.3.0
-
-https://github.com/swig/swig/blob/master/CHANGES.current
-
-"[Python] #2907 Fix returning null from functions with output
-parameters.  Ensures OUTPUT and INOUT typemaps are handled
-consistently wrt return type.
-
-New declaration of SWIG_Python_AppendOutput is now:
-
-  SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void)=
;
-
-The 3rd parameter is new and the new $isvoid special variable
-should be passed to it, indicating whether or not the wrapped
-function returns void.
-
-Also consider replacing with:
-
-  SWIG_AppendOutput(PyObject* result, PyObject* obj);
-
-which calls SWIG_Python_AppendOutput with same parameters but adding $is=
void
-for final parameter."
-
-Fixes: https://github.com/SELinuxProject/selinux/issues/447
-
-Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
-Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
-Acked-by: James Carter <jwcart2@gmail.com>
-
-Upstream-Status: Backport
-[https://github.com/SELinuxProject/selinux/commit/e38815d7b44cac435195c8=
2a54d2bf2517bc4b1a]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- src/semanageswig_python.i | 64 +++++++++++++--------------
- src/semanageswig_ruby.i   | 32 +++++++-------
- 2 files changed, 48 insertions(+), 48 deletions(-)
-
-diff --git a/src/semanageswig_python.i b/src/semanageswig_python.i
-index 5f011396..0e27424f 100644
---- a/src/semanageswig_python.i
-+++ b/src/semanageswig_python.i
-@@ -111,7 +111,7 @@
- }
-=20
- %typemap(argout) char** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_FromCharPtr(*$1));
-+	$result =3D SWIG_AppendOutput($result, SWIG_FromCharPtr(*$1));
- 	free(*$1);
- }
-=20
-@@ -134,7 +134,7 @@
-                         	NULL, NULL, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -148,7 +148,7 @@
- }
-=20
- %typemap(argout) semanage_module_info_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- /** module key typemaps **/
-@@ -160,7 +160,7 @@
- }
-=20
- %typemap(argout) semanage_module_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- /** context typemaps **/
-@@ -172,7 +172,7 @@
- }
-=20
- %typemap(argout) semanage_context_t** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- /** boolean typemaps **/
-@@ -197,7 +197,7 @@
- 				(void (*) (void*)) &semanage_bool_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--		   	        $result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -207,11 +207,11 @@
- }
-=20
- %typemap(argout) semanage_bool_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_bool_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_bool_key_t **(semanage_bool_key_t =
*temp=3DNULL) {
-@@ -240,7 +240,7 @@
- 				(void (*) (void*)) &semanage_fcontext_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -250,11 +250,11 @@
- }
-=20
- %typemap(argout) semanage_fcontext_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_fcontext_key_t ** {
--        $result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerOb=
j(*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_fcontext_key_t **(semanage_fcontex=
t_key_t *temp=3DNULL) {
-@@ -284,7 +284,7 @@
- 				(void (*) (void*)) &semanage_iface_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -294,11 +294,11 @@
- }
-=20
- %typemap(argout) semanage_iface_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_iface_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_iface_key_t **(semanage_iface_key_=
t *temp=3DNULL) {
-@@ -328,7 +328,7 @@
- 				(void (*) (void*)) &semanage_seuser_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -338,11 +338,11 @@
- }
-=20
- %typemap(argout) semanage_seuser_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_seuser_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_seuser_key_t **(semanage_seuser_ke=
y_t *temp=3DNULL) {
-@@ -371,7 +371,7 @@
- 				(void (*) (void*)) &semanage_user_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -381,11 +381,11 @@
- }
-=20
- %typemap(argout) semanage_user_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_user_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_user_key_t **(semanage_user_key_t =
*temp=3DNULL) {
-@@ -414,7 +414,7 @@
- 				(void (*) (void*)) &semanage_port_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -424,11 +424,11 @@
- }
-=20
- %typemap(argout) semanage_port_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_port_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_port_key_t **(semanage_port_key_t =
*temp=3DNULL) {
-@@ -457,7 +457,7 @@
- 				(void (*) (void*)) &semanage_ibpkey_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -467,11 +467,11 @@
- }
-=20
- %typemap(argout) semanage_ibpkey_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_ibpkey_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_ibpkey_key_t **(semanage_ibpkey_ke=
y_t *temp=3DNULL) {
-@@ -500,7 +500,7 @@
- 				(void (*) (void*)) &semanage_ibendport_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -510,11 +510,11 @@
- }
-=20
- %typemap(argout) semanage_ibendport_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(argout) semanage_ibendport_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_ibendport_key_t **(semanage_ibendp=
ort_key_t *temp=3DNULL) {
-@@ -543,7 +543,7 @@
- 				(void (*) (void*)) &semanage_node_free, &plist) < 0)
- 				$result =3D SWIG_From_int(STATUS_ERR);
- 			else
--				$result =3D SWIG_Python_AppendOutput($result, plist);
-+				$result =3D SWIG_AppendOutput($result, plist);
- 		}
- 	}
- }
-@@ -553,12 +553,12 @@
- }
-=20
- %typemap(argout) semanage_node_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
-=20
- %typemap(argout) semanage_node_key_t ** {
--	$result =3D SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
-+	$result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_des=
criptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_node_key_t **(semanage_node_key_t =
*temp=3DNULL) {
-diff --git a/src/semanageswig_ruby.i b/src/semanageswig_ruby.i
-index e030e4ae..9010b545 100644
---- a/src/semanageswig_ruby.i
-+++ b/src/semanageswig_ruby.i
-@@ -38,7 +38,7 @@
- }
-=20
- %typemap(argout) semanage_module_info_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- /** context typemaps **/
-@@ -50,7 +50,7 @@
- }
-=20
- %typemap(argout) semanage_context_t** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- /** boolean typemaps **/
-@@ -66,11 +66,11 @@
- }
-=20
- %typemap(argout) semanage_bool_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_bool_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_bool_key_t **(semanage_bool_key_t =
*temp=3DNULL) {
-@@ -90,11 +90,11 @@
- }
-=20
- %typemap(argout) semanage_fcontext_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_fcontext_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_fcontext_key_t **(semanage_fcontex=
t_key_t *temp=3DNULL) {
-@@ -114,11 +114,11 @@
- }
-=20
- %typemap(argout) semanage_iface_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_iface_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_iface_key_t **(semanage_iface_key_=
t *temp=3DNULL) {
-@@ -138,11 +138,11 @@
- }
-=20
- %typemap(argout) semanage_seuser_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_seuser_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_seuser_key_t **(semanage_seuser_ke=
y_t *temp=3DNULL) {
-@@ -162,11 +162,11 @@
- }
-=20
- %typemap(argout) semanage_user_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_user_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_user_key_t **(semanage_user_key_t =
*temp=3DNULL) {
-@@ -186,11 +186,11 @@
- }
-=20
- %typemap(argout) semanage_port_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(argout) semanage_port_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_port_key_t **(semanage_port_key_t =
*temp=3DNULL) {
-@@ -210,12 +210,12 @@
- }
-=20
- %typemap(argout) semanage_node_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
-=20
- %typemap(argout) semanage_node_key_t ** {
--        $result =3D SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(=
*$1, $*1_descriptor, 0));
-+        $result =3D SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, =
$*1_descriptor, 0));
- }
-=20
- %typemap(in, numinputs=3D0) semanage_node_key_t **(semanage_node_key_t =
*temp=3DNULL) {
---=20
-2.25.1
-
diff --git a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-=
segfaults-on-Ubuntu.patch b/recipes-security/selinux/libsemanage/libseman=
age-Fix-execve-segfaults-on-Ubuntu.patch
index daaeb3b..3cab867 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaul=
ts-on-Ubuntu.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaul=
ts-on-Ubuntu.patch
@@ -1,4 +1,4 @@
-From a91134e98ba4b3b6645d12bb68a07976b60f86c8 Mon Sep 17 00:00:00 2001
+From 418a2736fd7da15758ab84f9448e7517e3ad82c1 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 26 Mar 2012 15:15:16 +0800
 Subject: [PATCH] libsemanage: Fix execve segfaults on Ubuntu.
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
=20
 diff --git a/src/semanage_store.c b/src/semanage_store.c
-index 27c5d34..519f298 100644
+index 2ca2e90..914d720 100644
 --- a/src/semanage_store.c
 +++ b/src/semanage_store.c
-@@ -1470,7 +1470,7 @@ static int semanage_exec_prog(semanage_handle_t * =
sh,
+@@ -1445,7 +1445,7 @@ static int semanage_exec_prog(semanage_handle_t * =
sh,
  	if (forkval =3D=3D 0) {
  		/* child process.  file descriptors will be closed
  		 * because they were set as close-on-exec. */
diff --git a/recipes-security/selinux/libsemanage/libsemanage-allow-to-di=
sable-audit-support.patch b/recipes-security/selinux/libsemanage/libseman=
age-allow-to-disable-audit-support.patch
index e9df8be..8abf847 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-a=
udit-support.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-a=
udit-support.patch
@@ -1,4 +1,4 @@
-From c96010440e7a2a87787a535fd0f9ccf26a2b4a5e Mon Sep 17 00:00:00 2001
+From 0fddb654b4193e91b8534cbbeaa5fd9b6aa1ead2 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 20 Jan 2014 03:53:48 -0500
 Subject: [PATCH] libsemanage: allow to disable audit support
@@ -13,7 +13,7 @@ Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
  3 files changed, 31 insertions(+), 2 deletions(-)
=20
 diff --git a/src/Makefile b/src/Makefile
-index d525996..2f5e159 100644
+index 8dfbd76..4012f28 100644
 --- a/src/Makefile
 +++ b/src/Makefile
 @@ -27,6 +27,14 @@ ifeq ($(DEBUG),1)
@@ -41,7 +41,7 @@ index d525996..2f5e159 100644
 =20
  $(LIBPC): $(LIBPC).in ../VERSION
 diff --git a/src/seusers_local.c b/src/seusers_local.c
-index 795a33d..6539cdf 100644
+index eb3f82b..45da825 100644
 --- a/src/seusers_local.c
 +++ b/src/seusers_local.c
 @@ -8,7 +8,11 @@ typedef struct semanage_seuser record_t;
@@ -72,7 +72,7 @@ index 795a33d..6539cdf 100644
 =20
  int semanage_seuser_modify_local(semanage_handle_t * handle,
  				 const semanage_seuser_key_t * key,
-@@ -164,8 +170,11 @@ int semanage_seuser_modify_local(semanage_handle_t =
* handle,
+@@ -165,8 +171,11 @@ int semanage_seuser_modify_local(semanage_handle_t =
* handle,
  	(void) semanage_seuser_query(handle, key, &previous);
  	handle->msg_callback =3D callback;
  	rc =3D dbase_modify(handle, dconfig, key, new);
@@ -84,7 +84,7 @@ index 795a33d..6539cdf 100644
  err:
  	if (previous)
  		semanage_seuser_free(previous);
-@@ -181,8 +190,12 @@ int semanage_seuser_del_local(semanage_handle_t * h=
andle,
+@@ -182,8 +191,12 @@ int semanage_seuser_del_local(semanage_handle_t * h=
andle,
  	dbase_config_t *dconfig =3D semanage_seuser_dbase_local(handle);
  	rc =3D dbase_del(handle, dconfig, key);
  	semanage_seuser_query(handle, key, &seuser);
@@ -98,7 +98,7 @@ index 795a33d..6539cdf 100644
  		semanage_seuser_free(seuser);
  	return rc;
 diff --git a/tests/Makefile b/tests/Makefile
-index 69f49a3..f914492 100644
+index 241ff17..fa03fb6 100644
 --- a/tests/Makefile
 +++ b/tests/Makefile
 @@ -4,10 +4,18 @@ CILS =3D $(sort $(wildcard *.cil))
@@ -114,7 +114,7 @@ index 69f49a3..f914492 100644
 +endif
 +
  EXECUTABLE =3D libsemanage-tests
- CFLAGS +=3D -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format=
-attribute -Wno-unused-parameter
+ CFLAGS +=3D -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format=
-attribute
  override CFLAGS +=3D -I../src -I../include
 -override LDLIBS +=3D -lcunit -lbz2 -laudit -lselinux -lsepol
 +override LDLIBS +=3D -lcunit -lbz2 $(LIBAUDIT) -lselinux -lsepol
diff --git a/recipes-security/selinux/libsemanage/libsemanage-disable-exp=
and-check-on-policy-load.patch b/recipes-security/selinux/libsemanage/lib=
semanage-disable-expand-check-on-policy-load.patch
index d880e1e..4b1d3cc 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-disable-expand-che=
ck-on-policy-load.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-disable-expand-che=
ck-on-policy-load.patch
@@ -1,4 +1,4 @@
-From 7af73c1684ce0e30ce0cd58b51708bde1e3a1984 Mon Sep 17 00:00:00 2001
+From af4948d5a1cfb41338a7539dcd80735b5c250e58 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe@deserted.net>
 Date: Wed, 7 May 2014 11:36:27 -0400
 Subject: [PATCH] libsemanage: disable expand-check on policy load
diff --git a/recipes-security/selinux/libsemanage_3.7.bb b/recipes-securi=
ty/selinux/libsemanage_3.8.bb
similarity index 92%
rename from recipes-security/selinux/libsemanage_3.7.bb
rename to recipes-security/selinux/libsemanage_3.8.bb
index 7e6c91f..ef22957 100644
--- a/recipes-security/selinux/libsemanage_3.7.bb
+++ b/recipes-security/selinux/libsemanage_3.8.bb
@@ -5,7 +5,7 @@ as by programs like load_policy that need to perform spec=
ific transformations \
 on binary policies such as customizing policy boolean settings."
 SECTION =3D "base"
 LICENSE =3D "LGPL-2.1-or-later"
-LIC_FILES_CHKSUM =3D "file://${S}/LICENSE;md5=3Da6f89e2100d9b6cdffcea4f3=
98e37343"
+LIC_FILES_CHKSUM =3D "file://${S}/LICENSE;md5=3D03068f550c635f6520e0f025=
2da412fc"
=20
 require selinux_common.inc
=20
@@ -14,7 +14,6 @@ inherit lib_package python3native
 SRC_URI +=3D "file://libsemanage-Fix-execve-segfaults-on-Ubuntu.patch \
             file://libsemanage-allow-to-disable-audit-support.patch \
             file://libsemanage-disable-expand-check-on-policy-load.patch=
 \
-            file://0001-libsemanage-fix-swig-bindings-for-4.3.0.patch \
            "
=20
 DEPENDS =3D "libsepol libselinux python3 bison-native swig-native"
diff --git a/recipes-security/selinux/libsepol_3.7.bb b/recipes-security/=
selinux/libsepol_3.8.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.7.bb
rename to recipes-security/selinux/libsepol_3.8.bb
diff --git a/recipes-security/selinux/mcstrans_3.7.bb b/recipes-security/=
selinux/mcstrans_3.8.bb
similarity index 97%
rename from recipes-security/selinux/mcstrans_3.7.bb
rename to recipes-security/selinux/mcstrans_3.8.bb
index 4a8482f..4c8aed3 100644
--- a/recipes-security/selinux/mcstrans_3.7.bb
+++ b/recipes-security/selinux/mcstrans_3.8.bb
@@ -31,7 +31,7 @@ do_install:append() {
=20
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false=
', d)}; then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        echo "d ${localstatedir}/run/setrans - - - -" \
+        echo "d ${runtimedir}/setrans - - - -" \
             > ${D}${sysconfdir}/tmpfiles.d/setrans.conf
     else
         install -d ${D}${sysconfdir}/default/volatiles
diff --git a/recipes-security/selinux/policycoreutils_3.7.bb b/recipes-se=
curity/selinux/policycoreutils_3.8.bb
similarity index 100%
rename from recipes-security/selinux/policycoreutils_3.7.bb
rename to recipes-security/selinux/policycoreutils_3.8.bb
diff --git a/recipes-security/selinux/restorecond_3.7.bb b/recipes-securi=
ty/selinux/restorecond_3.8.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.7.bb
rename to recipes-security/selinux/restorecond_3.8.bb
diff --git a/recipes-security/selinux/secilc_3.7.bb b/recipes-security/se=
linux/secilc_3.8.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.7.bb
rename to recipes-security/selinux/secilc_3.8.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.7.bb b/recipes-secur=
ity/selinux/selinux-dbus_3.8.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.7.bb
rename to recipes-security/selinux/selinux-dbus_3.8.bb
diff --git a/recipes-security/selinux/selinux-gui_3.7.bb b/recipes-securi=
ty/selinux/selinux-gui_3.8.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.7.bb
rename to recipes-security/selinux/selinux-gui_3.8.bb
diff --git a/recipes-security/selinux/selinux-python_3.7.bb b/recipes-sec=
urity/selinux/selinux-python_3.8.bb
similarity index 100%
rename from recipes-security/selinux/selinux-python_3.7.bb
rename to recipes-security/selinux/selinux-python_3.8.bb
diff --git a/recipes-security/selinux/selinux-sandbox_3.7.bb b/recipes-se=
curity/selinux/selinux-sandbox_3.8.bb
similarity index 100%
rename from recipes-security/selinux/selinux-sandbox_3.7.bb
rename to recipes-security/selinux/selinux-sandbox_3.8.bb
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-securi=
ty/selinux/selinux_common.inc
index 8dd6c2e..30109b9 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE =3D "https://github.com/SELinuxProject"
=20
 SRC_URI =3D "git://github.com/SELinuxProject/selinux.git;branch=3Dmain;p=
rotocol=3Dhttps"
-SRCREV =3D "2eb286bc0841791043567437ba5413f3014fb94e"
+SRCREV =3D "71aec30d068789e856e7cc429b620ae1cfa890f1"
=20
 UPSTREAM_CHECK_GITTAGREGEX =3D "(?P<pver>\d+(\.\d+)+)"
=20
diff --git a/recipes-security/selinux/semodule-utils_3.7.bb b/recipes-sec=
urity/selinux/semodule-utils_3.8.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.7.bb
rename to recipes-security/selinux/semodule-utils_3.8.bb
--=20
2.25.1


