Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A037D5B161
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 07:22:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16820.1765869749854565624
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 23:22:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=GaTlZpZ1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4445c36162=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG3tuwR3261186;
	Mon, 15 Dec 2025 23:22:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=qgW7syo8xy2eyxcvrVp0lOJOV6MAa6S9E5ZQKfMhOfE=; b=
	GaTlZpZ1eCng2XDq4ekU9R9JhZo8NQKd0db7NaU/s8MTp2bXAiwDA/Nq3myAXitA
	Vben1Xk6LgU66WpKZA7pI2ptNHk9bzsxzrthe0BEM2Stau1K5OZ3rG99aU7so3C5
	A5ymM43jDfcb4qZIfOdGlXr/MFvqLQZ+ydUAII52mjd4l7+VmZxeSktMLUahxet7
	sSc5x2bolk/Xw5BlpiidJSjVqiiIIqHcI/VSoqbcGei0YpyEJDw9X8mQOGkcA7cR
	TXRTRL7ar9bFz2ZGr/y9sT3PjU0KAmKPy0msBZiQuuuaSjiq1DSKiJ38rz2swVtC
	zmoBOQWUMFB6CT59mXYbWg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b14a5jkve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 23:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iczQaoSlhE1ndQnTuQ0RX8AFXl/zF+Nx1Ws69LWXZE+MD+6uVm9sPYnkaCFsW2z050xx0BJsOCxyKcpax55pe225Z3c7lppyyOAXECclon4pFyujIGXLOz6PSJltErIjicbcGIo9ZL0qOnicbwh7ehrJSLKYwN/IgB0bIqVzVz8Yp/qzAaXPJ9COlIsvXvdQoOjA21cpntLxch9tcDEQxuEgLD0fKx3kw6EaJw8Z25yiQXgdVnBrSrxRgi99HkoeNsceRjwAmS1H2uvwblUJ+G+i6KQK13lqMg/KxRjMuRSNLXDH2CJz65JpqnxoVaHvqs9prWG3TKWkbdYxb3M9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgW7syo8xy2eyxcvrVp0lOJOV6MAa6S9E5ZQKfMhOfE=;
 b=njunXlEZN+eY3vTu/IklPCnMd3Wq1eMaCQ/0lV3B9fWdCR5wIdWNNQ5cTSdsO+Tnrqy+DSjFGBS/x4ptK0QHMan5UrevKZVwLE+m6pgKCQAhqvekYc2Al227zzdeytoFrKxeV6hRWGBZ2te0laM+BtUQsQmktRsWy1eGU+KUqv6t3g+BV0CJcZ5upE/PYdEGgvAa7t5p4H+agIjWARp049Ooesl0y39wFefw3EKsotVozuxY+Y/c6GU1/197ALErNUv1EivgQjAjWLug0tu7/g3F9KBcazOYuD9+I9Vg2Nm5UnTtG3oZOCNfD8vbXcEURiiHX0D9cpS7qx2i7v5i1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Tue, 16 Dec
 2025 07:22:26 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 07:22:26 +0000
Message-ID: <11487568-da56-489e-a7eb-12129619c28c@windriver.com>
Date: Tue, 16 Dec 2025 15:22:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH/V2] refpolicy: Add support
 for custom policy store
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
References: <20251215135126.1605250-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20251215135126.1605250-1-quic_sasikuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA1PR11MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 88856763-6695-464b-05bb-08de3c73dc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RWlla2lFYVpVSlRTUWdtbXRqd0xoZkVwZUczcVZVdm1VN0dDbjNzWDIrc1E2?=
 =?utf-8?B?elg2ZUVKV3BlWTJEMEtLdEJQd2paRm5wQ1hrdzFkK011OGRKK1hyaksvOW12?=
 =?utf-8?B?M1NraExsaXlZUUYxV0RZczZMZEFVUmRaS0JldHVjcXlzNm0rMEExRzhqdUxL?=
 =?utf-8?B?b1hyZnN6bzkwMkFVTHJQNlBGR1lDN0J2WXZkemlMNkhGazBCSE1uRW9NVzcw?=
 =?utf-8?B?Vkx6M3V4VHE2RURTK0NId1Y0OTF5SnV5WUZZVktQaHBxL3lMZm95dEpGa2Iz?=
 =?utf-8?B?NG1kc29TQUFtYlR3RnYxU3czcUp5NnltVWV2Q0hBdnpDa2R4ZmNYTjN5b1hP?=
 =?utf-8?B?QnIxN1hsR3kveXpDSU1FV0tRd2pzMWNkR1JJc1NpbFd2MHlMM3NuUXEzells?=
 =?utf-8?B?RlowVTY3L1RIcXlNdkVmRGxJMFJjZ3lIT2Z1OU8raksydjRCbTQrUGpMcGpM?=
 =?utf-8?B?R01NVUhVc2lkS01lcGhpVnVUMHU2UXVwUmVMNkJCbU1VbTdLeXZyREQ3Tmhu?=
 =?utf-8?B?dlNMT3ltNHJ5Nk9QenFVMStnOXBKdHpUK0FGVVVNek5CSVdWWVpBODRIZ211?=
 =?utf-8?B?bWg3Q08zbmhSeDdqTGl0bGx6VlZzTkRRT0hmbStiazZYQ2dSeVZJdWphalBN?=
 =?utf-8?B?MG4yckI2Z1JKODd0Y0ZVVzRWR1R2NU0wcms0bzhyTVVzN0RVRVRuZnYvQlVE?=
 =?utf-8?B?L00yc1o1Zkp1ckl0bHBtaThEbzRlVG00aFh4bFUyTS8xR2ZOTEwybm9OOXFY?=
 =?utf-8?B?ZUdvamdrRGpra0U5R1JWMm0vZkJwNllhang2WHgyWWQxVDhWTmpvSTJEVmN3?=
 =?utf-8?B?dVBCUnN0cFVZZlVkcWRmK0VkOTE4QVpmUmNWZWpvTjFqWmhDWFNQQWRPTjc3?=
 =?utf-8?B?RG9qd2M5cU9wUUdmemM0Mngxc2lWQXluWDNPYWE4dHBsMUVYb3AySkpqQmNS?=
 =?utf-8?B?OVJVWDF2N2RyYnk1RlBoYnZGeFM3TGlzQUI1OWV4RFN5NXNyUE1yUDF3Tm1R?=
 =?utf-8?B?WHBaRGp6bkVTb0I3Z0tZQnhjYXY5MUsyaEIyTmtpV0FvaTU3cmhrSmlzTTVz?=
 =?utf-8?B?VVhxZlBQVzN6dENMeTFkYnQ0MnZwVXc5RSt2Y3JSQW1VeUNGZWR6QkNKQlo0?=
 =?utf-8?B?QTA2UWNMREFtcjk2cTRHcHpBNnBRcmtpbkFwb0gyNUUzWmE3U3E5SFp2elcy?=
 =?utf-8?B?L29QRmdFTmdUR3dJQzNUZjlNZ2dqMzNkdGx5N1lRWURCbnN1OWdZemJva0d2?=
 =?utf-8?B?dEcwczExWFpQckd1Nk5CQnJoOVJLamxvSStTNWlrNHAwVXdGYSthTnBtUnh5?=
 =?utf-8?B?bkM0YnpacnYyM3UxVjJGRDdYL3dwZ0tOSklXUXhEY0hRa0Y3NHh5akcrZHNJ?=
 =?utf-8?B?YXJRajBtN05mMy9YV3E1Tk1WdGJocFNMZUo0VXRCNEVNSCtITm5GTVR6aGdM?=
 =?utf-8?B?UlUxSnZqTGpzNUhDdXZ4ajUvRUZiaTdiU01rL25RV2g0K1hLYW9JeU1TcDN0?=
 =?utf-8?B?K0lzSlVVNEVpWFozeDdTY3loOWtHU2VpVGtPbjZJaEFzc0lzZk5uMFBLZ1pv?=
 =?utf-8?B?SzNJR09aRFpBZ0pFOW5rYzdYdkk3cTZPNVV2NWhzNFJsR3c5eDc0cEwzT1dZ?=
 =?utf-8?B?eWRyVktIamlsanNHenk2TDF2YXYxZGxZV1dhY0FKRFBubU9JeGgzd1FDdzFN?=
 =?utf-8?B?UW9TVUttNC9kYUZRQ01OMlhvSVJ1VFBHTjVtSFJ2d2FWOUdodU1OZThqeGlK?=
 =?utf-8?B?ZEhUNHM1Y0FPVjZxbUFGS1VSdjNOODFoSkFjazZmcm4rNVlWaWxZMUxxU243?=
 =?utf-8?B?dG5TQVduWHlzZlVZdWY1QWQycnMzU200ckdmdWJoN2xCVEpwRjFiNitRY2J6?=
 =?utf-8?B?QVRFWXEybDcrWVBjMThGZG5MM1hsOEpxU2RzeFZGMTVTQXhIbkZrTXpnWTJF?=
 =?utf-8?Q?0VtUI524b4CrenptvDxRSZuHewNdX8+E?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVN4QU5rQy91L3lXZjlGcDdFMlI0RXhiTXZsZHphV2l1VVNBOWFQQ2xOTEZI?=
 =?utf-8?B?TEk0UGhkVUYwWU15N0hqT1kzeHo4NmI0QjFjTU81Nm9qNS9RRGlESEl6U0Rt?=
 =?utf-8?B?TUpRbU15TWIweDA3TExTaWlkYys2aStHQVVGTG13U0k4YWIxbDVzZHJ0Q1la?=
 =?utf-8?B?Q0kwV3lpR2FYMTJxbTJFNXJ3WDFRcHlwZXRzVlJkTUJKZkJvdFRkM0RBdy9s?=
 =?utf-8?B?cG9SSHZsR2U5eE5rcWJmcTJJaEdONlZ1MlpIa0pzM3VEZFFhVHlVYXVBNkxp?=
 =?utf-8?B?RTRJbHlvVVY0cFRHMkhNcWJjdjZmVjRqSG4wL2F6TXNpMzg5ckdDTE1weEVL?=
 =?utf-8?B?eHhkNFF0RURYclBhSU9yRTVuQVpKQVVNemJOOUlYUnZ1b293U1BySzRVMHlz?=
 =?utf-8?B?OXg3UGVLWk9JYlBBVTY1V1RZazhvdmFrby94VDhUM2FWWjZiQU5FMWNpclpM?=
 =?utf-8?B?bEVTNjF0TUlsYTdMRWR6TDF6TGw1OERiWVFPcHhpcFFVbDhGY29Wd1VZOGRs?=
 =?utf-8?B?UGUyNXlhNVVkd3ZZb3hRZk0xdyt5Zk1scURTMTI4WjdLdHdHdXZ6dkluRU52?=
 =?utf-8?B?NTY1TFRSL210a1ZUNTlER3ZDL1dBZjFvSC9DNEE2UFpJWFk2VG5VUFBXT2Vo?=
 =?utf-8?B?bEtrRGw0QkVaZG16ZUw4WThQdmdNUERFbko0eDFJbkZyNldRb0ZWMUVNLzdT?=
 =?utf-8?B?eXdsUnlXTXczN0JCSlVuVEIrcFZ0QjlkM0NFc2VxQVgwNDNtUGxzMmpTOTQ0?=
 =?utf-8?B?OFlIUitYV0p5dHBmMDAzaHNHWjNOanJ6T2Q1ZG15a2VLaTBhSzBPbEw3Vmhr?=
 =?utf-8?B?dWYyTFNFalhkemFxcTBMOTZZd0VXZWkrOGpCRGF3U3diTWs5UktvV3hEeDgw?=
 =?utf-8?B?ckJJeGI0T1pyWGVmVC8wUGlScm1ubGNWQy83YmxaeGcyMEZFQ3BpdUYwSWV5?=
 =?utf-8?B?eXNKU0NLa1FqL09JdDR5K0ZEMzVtQzNIa2xqV0hLcmxuekpjR09KU2llVkNx?=
 =?utf-8?B?ZkhIN2FNSW5pTzBzVDdNYm51ZjJUd2NVajdnc1RXMWF2TlFYdzRKaDhoekU4?=
 =?utf-8?B?K1psRUl4NUFyVXM0a0wvWlkvL011L0QyYngwck1qZUI1RTNWUTN1cHRKZjVl?=
 =?utf-8?B?QTZRRlVnRFZqbWcwRndEdThBQmYzMWE1Wml3bEsxb1RzSU5hZ3ZFc3BvYTYx?=
 =?utf-8?B?b1RjY3YwQkxvMkcyTUI2Rld5b2hUMTBTTGRlM1pCT004Wk1SNHZpQ0hLM2pJ?=
 =?utf-8?B?WUxxcXZQemtHRVRJZHkzU3dyNnd2bkJIdXlkMzhYVmVmaXVXOXZQL1VlYW56?=
 =?utf-8?B?bVJ2UHc2dCtQN2Mzcm5jb2g4VTd0N1REbFpKSEJQY3BUSnM2dEJDbCtrQlVh?=
 =?utf-8?B?M3RjNWRLbS9YWHRVcnV3SXEvbG1hT0orb1pmOGUzKzF3NVp2SzhNbGk2ejVU?=
 =?utf-8?B?RFVXQ3YrRjVvVkg3YVlmSlVKRTZSZHpXOEh3WXE3b21QalVtd05lQU1NaUpM?=
 =?utf-8?B?V1Vha3UrQng3WjAxcUExaUtNRnA3NSs2N1hhZlVZMnRrZURVOEhDdVBSc1E5?=
 =?utf-8?B?dWVuRjE0ZkhwN2czTFV2T0ZlQ3J6MThBd0ZlWTdIM3hNcUZiUTFMZnd1dlBj?=
 =?utf-8?B?MDZxc3d0N1QyYlN4b2FNVzVPUHF2YmxYOERLcGdvZGFMdi8wLzhsYjVFV3la?=
 =?utf-8?B?OUdMVTJ4TGpjNjcrR2tscmxRWGJ1N2J0VTZoL1BxMmhnTDFmWGtLU0t5aGto?=
 =?utf-8?B?djlHYTBNTmU2R3JjV3JHRGY1eUFwc3k4R2MzVjBpVnV5ZUVyZDdUUTBPUkJX?=
 =?utf-8?B?Q21PZ3o4blV4YzRFUE5lTkpHZldpSjNmOFBRUzlabTdWTlF5dUJsNWR1RGxs?=
 =?utf-8?B?TDM3OU1Ed2k2MDg5N1BFYW9sUEo1Zk5rT1hkUytsQVJLbURKUUtsczZHcEhm?=
 =?utf-8?B?RHZEczdndFRXdHhhOWlzOUhuTlQ0QWQwc1NmQWRmQkMxSnpxREpUUlBFQmJH?=
 =?utf-8?B?ZFdJdVZwTUtabkl2RGJQdjJnbk4ydi9tQmF3VlNoNVZ5QzBBbTNNb202Q0lM?=
 =?utf-8?B?OVNyQTJYWFVHSldjNTJVVnlWV2pGeERzcUVFWmE5WkR3dzF2RWhGcXFxbVoy?=
 =?utf-8?Q?+J+o6Itim6B9Fqdjf/+bmnl8T?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88856763-6695-464b-05bb-08de3c73dc7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 07:22:25.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwKE5ODn4nQLXDiWiUt8qqiAxjhdmQnct/SSqZ4+b6UHFHH9qN+FiwZWVmbygwjB8H26troGKcy3mUZf+InXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-Proofpoint-ORIG-GUID: yX8Q3-1ALxRCyRi7t_r0XXewfWeZI9A1
X-Authority-Analysis: v=2.4 cv=bs5BxUai c=1 sm=1 tr=0 ts=694108b5 cx=c_pps
 a=9FhzUGQqNQs6ZJfz/MkW+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=zdeCQEUv-cenZ4bfbSQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA2MCBTYWx0ZWRfX0Jsnvel3wuRY
 Uc9aPBJwsXINZrCjDtgjWR2MZwkwIrwKnaZzclnFLyk2uEazs4fng/MbvJVV/Wpf5qcEVktGA6s
 iaFHgswJkmhi+r0co82IgHS+8KRoANcpeQ8IIMUKxWcoLOHqP9DRxtL3FhPk6hTCyWNRBUtJ3yY
 gdonoNXBvPmfuXRbmb5TP9Zu30TRN5spOhsoHJzibIzOrQcR/se1KXATvsN5r6XRCelAMLQedrZ
 1OdbtxfeuaHJfLFaoIuOByH9VfaDQ4aQsE2/PYCoCMjg4QQzhQGJL2XaytkSMZlrCrrGHmp7Hyu
 Ic75Wdbj6JeiOIFKqfEHAI4iaXtPsVcCEAAYz2s1EqbbDnSt7ht694PRmHC5z06MpsgUDbUsJcE
 qpJ6wVkLOKvKtxZaUXYFyWFioG2zkw==
X-Proofpoint-GUID: yX8Q3-1ALxRCyRi7t_r0XXewfWeZI9A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160060
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5BG3tuwR3261186
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:22:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2796

Hi=C2=A0 Sasi,


I got the following error with this patch:

ERROR: refpolicy-standard-2.20250923+git-r0 do_package: QA Issue: FILES=20
variable for package refpolicy-standard contains '//' which is invalid.=20
Attempting to fix this but you should correct the metadata. [files-invali=
d]


Can you have a look at this failure please ?


//Yi


On 12/15/25 21:51, Sasi Kumar Maddineni (QUIC) via=20
lists.yoctoproject.org wrote:
> By default, policy modules(*.pp) are stored in /var directory.
> Features like: ostree remove files in folders like /var
> variable data directory while build time.
>
> Added support for custom policy store. We can now configure
> path to custom policy store to variable `POLICY_CUSTOM_STORE`.
>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   .../refpolicy/refpolicy_common.inc            |  9 ++++++---
>   recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++--=
-
>   2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-=
security/refpolicy/refpolicy_common.inc
> index 964906b..5a4b500 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -77,10 +77,12 @@ SRC_URI +=3D " \
>   S =3D "${UNPACKDIR}/refpolicy"
>  =20
>   CONFFILES:${PN} =3D "${sysconfdir}/selinux/config"
> +
> +POLICY_CUSTOM_STORE ?=3D "${localstatedir}/lib/selinux/"
>   FILES:${PN} +=3D " \
>       ${sysconfdir}/selinux/${POLICY_NAME}/ \
>       ${datadir}/selinux/${POLICY_NAME}/*.pp \
> -    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
> +    ${POLICY_CUSTOM_STORE}/${POLICY_NAME}/ \
>       "
>   FILES:${PN}-dev =3D+ " \
>       ${datadir}/selinux/${POLICY_NAME}/include/ \
> @@ -165,7 +167,7 @@ prepare_policy_store() {
>       oe_runmake 'DESTDIR=3D${D}' 'prefix=3D${D}${prefix}' install
>       POL_PRIORITY=3D100
>       POL_SRC=3D${D}${datadir}/selinux/${POLICY_NAME}
> -    POL_STORE=3D${D}${localstatedir}/lib/selinux/${POLICY_NAME}
> +    POL_STORE=3D${D}${POLICY_CUSTOM_STORE}/${POLICY_NAME}
>       POL_ACTIVE_MODS=3D${POL_STORE}/active/modules/${POL_PRIORITY}
>  =20
>       # Prepare to create policy store
> @@ -207,13 +209,14 @@ args =3D \$@
>   [end]
>  =20
>   policy-version =3D 35
> +store-root =3D "${POLICY_CUSTOM_STORE}"
>   EOF
>  =20
>       # Create policy store and build the policy
>       semodule -p ${D} -s ${POLICY_NAME} -n -B
>       rm -f ${D}${sysconfdir}/selinux/semanage.conf
>       # No need to leave final dir created by semanage laying around
> -    rm -rf ${D}${localstatedir}/lib/selinux/final
> +    rm -rf ${D}${POLICY_CUSTOM_STORE}/final
>   }
>  =20
>   install_misc_files() {
> diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-secu=
rity/selinux/libsemanage_3.9.bb
> index 2425a2e..98ff73d 100644
> --- a/recipes-security/selinux/libsemanage_3.9.bb
> +++ b/recipes-security/selinux/libsemanage_3.9.bb
> @@ -32,6 +32,8 @@ FILES:${PN}-python =3D "${PYTHON_SITEPACKAGES_DIR}/* =
\
>   FILES:${PN}-dbg +=3D "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
>   FILES:${PN} +=3D "${libexecdir}"
>  =20
> +POLICY_CUSTOM_STORE ?=3D "${localstatedir}/lib/selinux/"
> +
>   do_compile:append() {
>       oe_runmake pywrap \
>           PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
> @@ -46,9 +48,21 @@ do_install:append() {
>           PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
>           PYTHONLIBDIR=3D'${PYTHON_SITEPACKAGES_DIR}'
>  =20
> -    # Update "policy-version" for semanage.conf
> -    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
> -        ${D}/etc/selinux/semanage.conf
> +    conf_file=3D"${D}/etc/selinux/semanage.conf"
> +
> +    if [ -f "${conf_file}" ]; then
> +        # Update "policy-version" for semanage.conf
> +        sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
> +            ${D}/etc/selinux/semanage.conf
> +
> +        # Update "store-root" for semanage.conf
> +        if grep -q '^store-root=3D' "${conf_file}"; then
> +            sed -i "s|^store-root=3D.*$|store-root=3D${POLICY_CUSTOM_S=
TORE}|" "${conf_file}"
> +        else
> +            printf 'store-root=3D%s\n' "${POLICY_CUSTOM_STORE}" >> "${=
conf_file}"
> +        fi
> +    fi
> +
>   }
>  =20
>   BBCLASSEXTEND =3D "native"

