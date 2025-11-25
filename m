Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA8CFD37F
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 10:45:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14165.1764067514564520349
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Nov 2025 02:45:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=KUBAcfm+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3424f5edec=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP3mcjv3344169;
	Tue, 25 Nov 2025 02:45:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=S3LUjAGwN7qB1bYEZGtdVOaU6Dg3vTD54/uGZPOfsCw=; b=KUBAcfm+kKQS
	cBpdey01dHZihe23zcyOqIjI9Qf2AZnA7xSccmqpxHvZUBG1bxkFVOR62rIJ1fkM
	tQFq1I4/1984kmerZDMrCzHdx5X1RGk+emXrMvzZIpUh7axtl9+DbLZ24iR2r8Dd
	HYUXIJE6Q9yqMqf3D2z0zr8L8rb+DpaseNLk+SGMso9DHjVkX+4ZbfqJVpc8hhdL
	r+vhCkZgwEHRUudPwS9+pPq8Qix84AynI1LF02jOhtIE/+3/1p5p1QGCiaRW9ZYr
	vNjAqPowOz5MdTGYYzd++s8gQpV/cEV7TJBhBXtnbpC43BWdAI5OcsVdHuVqxPhH
	eiTml7NFZw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5atwj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 02:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpRgtXvJ5nFbgHqvxA5oggSh8Kv/P3jjn4dYxQwtX8aDlFcUI6RRsH/9cf5hHaMYFOky0a97ruTCNx2snOZBbdQsXWXTRhX63R5CN9jk/WX/PfSXKP1CUoQOfhTx8kNx8zAwBEgYgPN3x1z5DwRsBNDtFMEfvD4Ac5oFdLqM1Jk+RaOZ/jys1DV1ke2tfd8+Lm6xVjqEEXwLYp6rudmdEaTHqf/m+iU5GAR1f2ExgjDyGpAA34f63jSG0Esps2Uvt3tFodovNgNBvgM0xg3s+vbOH7fRmLoArbhiiNI2cOm8SQmS6NUqIXuR+BLtavMdoQ2hzJ/wQ0RNljKtirLLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3LUjAGwN7qB1bYEZGtdVOaU6Dg3vTD54/uGZPOfsCw=;
 b=GEY0V1CPGIKHnQ0xf8vPtrex7338BMmlkb9oajEBbaJc0zaXsWj04FoV2oPL//ciqm6oJMcBmaXXHTvCfb2q3A8twln1nufJqnjda5ZnAHWi4uyXfAmgr2xzYcprAH7oU1ifisOQ3lYHbW+VcupMzrHh8UmFFS1JyILCkW2n7H/rsVsuwZbZheMKIGq+ZfeaiMYrur2HMpkRcIJkP2/7aYMd4dx9Q6Re+0+NnU4w4kbzz8aX32obJZqftnextMBtUMZAUrhsK9qLBtMA20132nfnI57eGfHJ9IzZCTBdfUAiHvciTqEOWwSDYPIw6758MFW7x/tcTYi/Xp4Q9nHNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA4PR11MB8890.namprd11.prod.outlook.com (2603:10b6:208:55d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:45:12 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:45:12 +0000
Message-ID: <50ec0fb4-281a-48f8-ad5a-fd933da03a64@windriver.com>
Date: Tue, 25 Nov 2025 18:45:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] selinux-image: Preserve SELinux contexts in
 tarballs
To: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20251119063652.1704687-1-sasikuma@qti.qualcomm.com>
 <BL3PR02MB89860C180DA851163D3B14B8E8D1A@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <BL3PR02MB89860C180DA851163D3B14B8E8D1A@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA4PR11MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd59b99-a503-4d28-cfc8-08de2c0fb59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c21Nd05tK1I5WDBjUjhxUG9jRGpPQ3RMWjNRZGp2WDdoV08zY2M3NzBiSU9q?=
 =?utf-8?B?eCt1c3A3Rk5raVJtTFkzSmVudnhLZUJkQVl0NDNnNXZsWXlwdjl3TjBjYmZp?=
 =?utf-8?B?WnRQa2V3Z1dBWk5zakdCSjAwcU1wQmhwUW0zZ2xBK053YSs1YnZDUm42OTBM?=
 =?utf-8?B?NDVjTDJLT1NjUmg5cUVCSkxEaUIxOG1ZbGUzc3NKb3piNTR5NHN2dW1VL1I3?=
 =?utf-8?B?YjhSODJRVTZTVDJ1U2NPNE41dTcxeWJCSzgwTG9XZHNmUHd0ZVFMbldZZEpv?=
 =?utf-8?B?MU5hamxOWjNRRk5yT2Z2TkVJbU1XZDNtUGdvMzhlYmNjZjhFaWcxNFJKY2dI?=
 =?utf-8?B?TEZxZnFrc2twSk9pTmdFS3lIS0dGcUhOMjhFc3plUm9XTk13SXI4RmRwN2Jw?=
 =?utf-8?B?RmFsVVFsSXYvQ3pWdURhcVZwd1dsdHFFUzN2KzJPUmZSbVJqakVHRWRkaytr?=
 =?utf-8?B?MXN5RzBCb0Y1aWEzOU1tc2VzM2wvNDdDM2hEZmlTeE4rQUhVSWVPYkRWRUR1?=
 =?utf-8?B?M01CZTBQRWdlZ2NiMzhZUVR1VVJ5eGpZMXpTYVhsZnBmK2NUN1Npb2dkYXk3?=
 =?utf-8?B?Mm5BZFdxSjR4eUNqOHRxVk41MnhyeGlXSm5DMHExVGw1TmUrS3lUS1o4RExh?=
 =?utf-8?B?UTcwUUUrUjdZa3JqZWVCV0ZxaHVJRnhlc09OWjVUcXlEU3dwelh4eFA4Sytw?=
 =?utf-8?B?VEhzYlN0RFVLQi9TREJMSTZzdmtmWGJ5VzhJTnBwdjFiNjNKTStPbDlnaE9D?=
 =?utf-8?B?Tk9Sb1ZmbDN0QmJjS2EzUXRXbWFOK1VPUmljY1VyNU5CdVZYbm9NT0x1K3RC?=
 =?utf-8?B?L1YxL25xUmRwOFlEbW5hT1lVb0tXVllkZjFlZ2g0QS96NjIzc1ppZU4xQ2Iy?=
 =?utf-8?B?OUg4WEJUMUxCZ1VOZ3A0aW5aVmh5NDNjcG5laGJkaWF4Nk4zZmdadUFtRGtG?=
 =?utf-8?B?c0hQZzA4aXYvajR4a2x3bytzbWtyeGI4cmt1eThpRkd5OFBCTE9YdHdxRXVB?=
 =?utf-8?B?aXFsYngzU1l1MzJZcHZjZGFWTkF1bUQ5SDJEME5sWTJLRWtBMUhha04yc0VK?=
 =?utf-8?B?Znd4RkVzV0JtTHF5SkM4STNXbFpDQnlUT1M0K3RTbjFwcU4ycU9xWHZ4cXBv?=
 =?utf-8?B?SFRCOWRHRk43N2JEdUZxM00zK0x0ZUdtall4bWo2TmFJWlozbFZNeUxxRzlp?=
 =?utf-8?B?TDFwQStJWEhFUExoeHoxNmphcE1xQU1kckRkV1VUTUc2dCtqSXpYQW56V05K?=
 =?utf-8?B?U3JpamFjUTJ4enRuU2EvK3hhaXdLWmd2RWtGdTJMWXp0SlovN2M2RlRvWGwr?=
 =?utf-8?B?S1NGNVZraG5BWjRaYW9zRDdUaUFKNk1OM2dQbkhMZkxzRWdHRWM2TldqZG9L?=
 =?utf-8?B?U2Z5TWcySndlYlZSVjdjZmFJRkpBMm4wR0p1bEJjTUFISGFCclRvajR4b3hJ?=
 =?utf-8?B?TktnV2ppcDU1Nk9GeGRLSlNuR0JjQ2lKTjVQQVcxTmxGRGJlVTVvS2R1T3RJ?=
 =?utf-8?B?Vy9oZDhGY3k3TEp2M3VrbWQrVWpkZWNLbFJ5b281V3RSMk10dFlRK3ZUWGly?=
 =?utf-8?B?V0lCZTcxblJRZ0RYRkhZR2RPRTU4dElNblB6OUo2TTY0S24rdGNRNDlHc0Vv?=
 =?utf-8?B?OWw3L3hLQ2l6RmQ0ZHR3ZVhHclVsNnBoU2tmRjhrbEU3VXVqOG9wclhyUkZR?=
 =?utf-8?B?cFg5bU00cFBCbVh6bmdaWXUvaEpPaGNJTFF5QWwwVHloSWFBUDl2MCt4czVH?=
 =?utf-8?B?aEN2YlBKWnlSSVhqZ1JPbDJGa200T1I4OU81bHpHSVlJTUlubVZRK3dBQnNq?=
 =?utf-8?B?SnhEalhzdlJrRGZBTTgxb0E1aWQ4dVdrU1ZDS2N4dkY5TnhJUS9hZ1BrSHhm?=
 =?utf-8?B?QUxuTUlsL0VRdkVmMlEyZ0dmelBOTVl6UmVYY2RlLzROKzBZdVNtZGRBcnNT?=
 =?utf-8?Q?PAqokJ4K1D9oEan2Wbxs3X4zz6jLamMK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTc5ZThlTWZKdnNRTzBFQ1hDZmorMEV5L3BJTWpOYnh6RHExMnd6dnI3OFcx?=
 =?utf-8?B?aERpYjI2WGU1ZGRJRkY2RmNsM2l4YVNMNG1UbFFQSHhQaXJuTGVwMTN6VU1s?=
 =?utf-8?B?Rk5HQW05RUg0bWo2VU9xZlN1c0VzWGM3R1BaV0MrV0NkRlUvMlhaeWhZUzlP?=
 =?utf-8?B?TTF1QS9PYmlHc1d0b084K1RxaVRQVEVSeDR0VUxWc1RQUTM0WmRCQmF1Umhp?=
 =?utf-8?B?ak5LZFB5MkRUZ0Jnek9mOTJ1OUtkNUJwNlZQMU5oazZDdEt5ODVHRG9iWkUx?=
 =?utf-8?B?VEY3VDhhU0MrVUptdGszNWxNT1NGa25LR0txbUlSR0JJRXhxOGI3cjd1dlpN?=
 =?utf-8?B?OHVPOVQzM251d3V1cHJJUUwyTW9hRTFaTlRhbEMyS1JxVFZFczliVm4xcmpK?=
 =?utf-8?B?dVIrcjFxUkY1TlhDUjc1cUsrMXM3ejdIZ0R0NisxUm1JcS9iYjlKeEh4d2V2?=
 =?utf-8?B?VURtY1AvQVNzTmZ0eTVKVVIraXA1WnVEcEZUWC9lZ2VXaHh2QmRnR3FOZXVx?=
 =?utf-8?B?KzZ4KzB6OU13N3ZWWW92UW5yeUxPZ3p3U05mbWQ4T2trK0x0T0pXSlo5NWd4?=
 =?utf-8?B?d3hjbGRtNDNlUmlIN3pER0ZNRzZyNGdpVG9VWnIxSCtMOHVuZyt6TmFuN1dk?=
 =?utf-8?B?VnlSQjA0a21zMlVKblVOcUt5MFpUSVcrNEl6VndDbko4NmV0OVlxYU9WS3di?=
 =?utf-8?B?cUJTenBGc3RZRDUrTVFrTFgxdGdmS1loaUcwdHE2Q2dwL1BIMytMTUJ0RmlD?=
 =?utf-8?B?MWF6d0JHYjFmRzFzRGhjZXFnOEZUK3FmbllFbnRjRmFSRjQ4aWlpUXN4Qkpr?=
 =?utf-8?B?aGppOGlCL0c2SENqbmF6N3l3WS80QTgyUmhxWjNObDVPbGVPSnhCL3gwY3Iy?=
 =?utf-8?B?OFJLZzByTVVNRVJId2tGeUVnMXhlN2tiaTVFa3p0TUpCQStRRVBFOVB1Rkx1?=
 =?utf-8?B?YmtQMzRtMThRdWNrdDZDak9yNEhwR0g4djg0R2dMSUtpU2JLUGFCcFIyNEh6?=
 =?utf-8?B?eUxsc2YrMHEwZHM3ZUlBbGJTWlZ4dmpzZzlTWFgySjNaLy83UTZPWVFqenl3?=
 =?utf-8?B?ZnZhRHIwV290T0g1ME01TDFHUXd1ZklMckZHVlNkWHR0cjdDTitzaXV2YlFC?=
 =?utf-8?B?b3hrV1JqY1JBNGFpVUZQMnA1SklubFFVR2RzejA4alZSSTVUUThZNUdYa1FD?=
 =?utf-8?B?VGRyVFFKS09EVkdyaFpQdHJoRzkzVkdRUlg1NkxmSGVtQW1JSVVsb2lFUW1Z?=
 =?utf-8?B?cnZWOGU2YUhKTTdRT0xLaGN5dHUrMFhrNEp1VXBMenl4QXB6R2NVTEsvcHYz?=
 =?utf-8?B?STVJUk1DVmwzMWpFYkNWRDJjak1ET3hjRFJlTkZWNHNxaHhNWmZhNisvdWYz?=
 =?utf-8?B?WlV2QTNDVGE4bUQ4R0x6bXZHQVpFU01wUHJ2ZXV5RHZMcVA5eVdXNnZqd3JR?=
 =?utf-8?B?KzVwTHNySnFndEtZbjlHamJJZzNsTmF6UW5RY1NFaVRlSThYb3poRlJCcHps?=
 =?utf-8?B?dDY2R2I2V3E0VGNnbS9yT2gwMC9qdzRWYVZ1RVB5Y0ZmN3NkOGEyNzhPNUtr?=
 =?utf-8?B?SGlucGtLWnNIUDJXU00xTGRMMkRPNWh2OUp6dmlsZ01SNWM3Y01sd1RMV0Fl?=
 =?utf-8?B?SmFjT0pVNEJkdmplenMvVi9PVWZESEU5b2ZUaExkOTJkZHpwZ1Nnajd2NXBa?=
 =?utf-8?B?SlRqcDN1VGc3VkRmNE9TSHpZSUxTTWhHZWIzbUMza1lkWUFoakJmK3haUTFa?=
 =?utf-8?B?VWVqQ2hiR1JoQW5YZk5VcGVMeVllZitVa1BCVjUrWmcyTjIySFVNMFZMb3Ji?=
 =?utf-8?B?bU1URXNRYWRWYkpScXFXWXZQQ3BENWtGdmd0VUVkR0RWam4vS1hNL3RYWHhh?=
 =?utf-8?B?cFhWbE9GY2hxMlgycGU4ZjZnNzk5TmdwOXdqcFg4RGo5TkdtdytEUXg1UVhJ?=
 =?utf-8?B?alprRFpCYlo5alorNklhOEZXdEFSck5jK2lwbGVLbWZNb0hGVkMyMldBODNZ?=
 =?utf-8?B?b3dNc3JUYjNBTjNON2ErUk54UFEwaWZ1eElCMG8zMXVKR0FDUE96STFkb1h3?=
 =?utf-8?B?eXh0RDluQisvMzdlZ1JXS0YvNWFyWXVDam5aZ2VXSE1rVmpJa2o1eFFIWmhO?=
 =?utf-8?Q?h1Tto1qrB93WParJDfeXE8yN2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd59b99-a503-4d28-cfc8-08de2c0fb59c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:45:11.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XLBlv1eqLcxd4QzoN8hwgkiJ4hWeSmOAQ15yw5DcpZgxTtr81RxZXTdlqp15VDBXO3+UTmRSz57+b/T9GxjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8890
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=692588b9 cx=c_pps
 a=BI8ydP9R2Zc1CK2A4JEEvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=GobL_thplWIVK3s5NRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4OCBTYWx0ZWRfX+mi1QjZyGjit
 AQYCXMiIEFl37s52+bjylxv4B+rv17TAspXJpTFulwdkDXsGGaefvxLA64zFzS6WVrT1skcWiy0
 g+qdeaoFO1JlJIHYWyNgmTeA5nqYAUkZ/uUYJRx6Fa9QI6QoCaA/bbqjN1MQi/X2a0wkR6WYbiN
 gSdHfEWaJfI0ADSJAgMwzwkIRWjFGzACHKQBSoJg95JjGj06Y+9jBWU0vsCyriu9wrKZ5rE/P5R
 RhUGzjdx2qi8hIjHXdKBD38AkTClYZy1TUzLB3Nf6soPJN6OA6/OugxGiohOBPXnPZKfeyRqkYf
 ofSXwB03ZTJ7hbSXDKd7u9WpiEl8XW+r/+xWCi9XUO6fEwVv+BjfuVhZiPfkpN33mUXh00fk/vd
 yJ6fcCgil9ei0XC9Q8JhO3/T5VzNWw==
X-Proofpoint-GUID: riw6QnZmpRJkIKCt3xtp0dnxFBAn20yQ
X-Proofpoint-ORIG-GUID: riw6QnZmpRJkIKCt3xtp0dnxFBAn20yQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250088
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AP3mcjv3344169
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Nov 2025 10:45:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2707

Hi=C2=A0 Sasi,


For some reason, I didn't receive this patch in my inbox. I also=20
couldn't find it on https://lists.yoctoproject.org/g/yocto-patches .=20
Would you please resend it ? Thanks.


//Yi


On 11/25/25 17:13, Sasi Kumar Maddineni wrote:
> Gentle reminder!!
>
> Please review the change ASAP.
>
>
> Regards,
> Sasi.
> -----Original Message-----
> From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
> Sent: Wednesday, November 19, 2025 12:07 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
> Subject: [meta-selinux][PATCH] selinux-image: Preserve SELinux contexts=
 in tarballs
>
> Tarball images were created without SELinux context information, causin=
g loss of security labels during extraction while working with features l=
ike:ostree. This breaks SELinux policy enforcement and requires relabelin=
g after deployment, adding runtime overhead.
>
> Append "--selinux" to IMAGE_CMD_TAR to include SELinux file contexts wh=
en generating tarball images. This ensures security labels are preserved =
across image creation and deployment.
>
> Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
> ---
>   classes/selinux-image.bbclass | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/classes/selinux-image.bbclass b/classes/selinux-image.bbcl=
ass index b4f9321..852db5f 100644
> --- a/classes/selinux-image.bbclass
> +++ b/classes/selinux-image.bbclass
> @@ -26,4 +26,6 @@ python selinux_setlabels_handler() {  addhandler seli=
nux_setlabels_handler  selinux_setlabels_handler[eventmask] =3D "bb.event=
.RecipePreFinalise"
>  =20
> +IMAGE_CMD_TAR:append =3D " --selinux"
> +
>   inherit core-image
> --
> 2.43.0
>

