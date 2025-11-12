Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD73CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:59:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8220.1762934367642415204
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 23:59:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=ZE3nW5ei;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3411dc7477=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC5RcH33531643;
	Wed, 12 Nov 2025 07:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=lIC+DUAVPOR+0HYdtCyCdF
	KfE8th9rFPJSzcKa5z2ak=; b=ZE3nW5eiLYmTCRa+EaZCkpdKzvEq3mpN/fx108
	KiiFOh6cZ4UJV/LRufuSXALV26yvXoVfFjE/BKaRhmGxHvqz9iphYxyTElXsCl7c
	toMDz5ejxtlPlAe6WdP7+dZle8f9YMIfB8y3vSeB8MOyFBafk2Jy1q8UltPQQPzO
	ctBJ8EL/g/Rsw4dBfixxCcyOe9O/kA7gap67spo71J+xslZr8Xi4wV7kN+FG2jOX
	XvPfxiiSk4SrL5hGxGpyHlQKIAZ+ZXqV18sHtHE74ziW24NT7lXllaP9PvXE4SLd
	Mk2Pl+dBVfG4UHFVTIPh+WWmqw0NhXxQO5H/l/+OsxLiuFrA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9u2x4u0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 07:59:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+WrO9t3Kcw2heSoKnM92N2T6ZBMaTQi/I7cPYV5A3ys4mofZKfC9iUToUx2LtpchZvOzyDspsR/GSpwmzJ9zviRqVtW029XUAEaRl9ZpueOdDBc+/w6P0T6yIr8IZggl3Wt3LJkrlmmzXDwGXG7da78GSzYkLJPbIop06PkwqCAP+9jlrG1//ZoINM8thVYPNiKqtZetshamrFq69x4KJ1y1BfOvfC6nEYKgZ7fuD3dmsmQgfvCoLiZNqJ1iGiqbfebOO96nXfQMGi0kQxkyO4KmUkSQa/HU/g5//F8XClHSZSTnbNR14nGoKjeUaR9XNRyZf8z/stuHbXaUMEb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIC+DUAVPOR+0HYdtCyCdFKfE8th9rFPJSzcKa5z2ak=;
 b=RePQHLNqoSckRVKvk0FS+pjRJtzGXa4vpuRRXmwt7DqvxeKBlUFZml6NsK7pugZ+5jP+9H9esGRbQOzI/uVfX0Pri2FzgZzU+Ubm737whQmCPZKWbPrfC9FRlr00u2XYlI3LzRYVjxMJXDPcNO21ls2c70hQShzoC65q7zjrSF+yfYeu4WFTDVHwtpO6u7cyf6l+bxFXnadRmEDM88BbB14d2OEOMVjtfaTL6J38Z0WkGdhQJil4aOm5MKnksQZ1Gacq1/KLABaairCcutSVwizmtekA0duOgbjs0KHUgTkghI7TBkg2B7p96XZ+8oSJCGQ76WOo5YJdOTaIqLePyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Wed, 12 Nov
 2025 07:59:23 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:59:23 +0000
Content-Type: multipart/alternative;
 boundary="------------KCOG64EQ86J5C0983O6KMH9b"
Message-ID: <30bbd824-e202-45c9-aae5-1194decbcbbc@windriver.com>
Date: Wed, 12 Nov 2025 15:59:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-mingw][PATCH V2] meta-mingw: support
 generating Windows SDK with no symlink
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <jpewhacker@gmail.com>, paul@pbarker.dev
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
 <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com>
 <87e0a761-ad36-44aa-b262-464aaeb97471@windriver.com>
 <CABXoSoW68LaasoHdKFcRV_XHBbixCakN+qq=O1hx7dFTf-pFdw@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CABXoSoW68LaasoHdKFcRV_XHBbixCakN+qq=O1hx7dFTf-pFdw@mail.gmail.com>
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1f2bef-3951-4a0c-de0c-08de21c16495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aDI5L0xuTzd2THZjS1NnZ212OVhsQVJob1lmWVNYWTlqdW96TUkzU0VoR0F6?=
 =?utf-8?B?VnNyVzJlM01HWkpXR3lHRDdPY2ZoVE9rNzZ4U3BIbGQ0WVdZTVRXRlFIN0E0?=
 =?utf-8?B?cVZXWUN4ZGVVY1kzVXVEeGhQQnBjRXZUaU54L0VSNElLL2tGUlFxQ1RxNDcv?=
 =?utf-8?B?Vm9tOFBZSjRKblhHRDZOaFJhekRTVTRLSTEycytEdUVwKzR3K2d2WlU5THJ0?=
 =?utf-8?B?a3kxTlI4b1BtWTA0UkR4T2x6d3pHSDhXc1RlTmFyWUF6M3kvTHBlaWFhbnM3?=
 =?utf-8?B?L0g3cHhZdE9oV3dsR3Z6cGZiVktXSGdkMnNSa2xpamhmNE4wK2lKcEVVNHFn?=
 =?utf-8?B?NHFFNFVmT3VVZFprZzlNb1hXRVB2MXh4ZzdOaWkwTnhVY1dvb01wQTVqZUtC?=
 =?utf-8?B?MXpGUGYrMEU1a0duRU1NMFVUWGw1VmVqb01ERG1iRVFHRkJzK2RlRnd1cDdm?=
 =?utf-8?B?M2FwNTdIVWpPK0l6TkZrQUNnZllGTXRpUHYxaVJ1SnE1b1N6d0NEZzdQK2du?=
 =?utf-8?B?SjkyNDhxQjdJRnE1OExWcEV6RVpZWmozK0ZYWTZMMXVEa0YrRER0VWdrbC84?=
 =?utf-8?B?WXk1YnpJZ1liYmNlOTM1TExqVmNpY1B4UFN5RmR6ZWdiZmw2TytBeVJ6QW5o?=
 =?utf-8?B?Y0RGRHY1MlNlRU91Z08yRjlvVjU4dXZReWIxTC85ek9DQkxjUlRYVWFaVSs5?=
 =?utf-8?B?cXJjaStrem1CQ0VJU3FJYk1aMHNkbU8xKzZCWVphdU9BeDBjN1FWU212L2ww?=
 =?utf-8?B?Rkg0OHdWdXljbmp6b0QrN01ZaUNOclVveVZhTVFoZ3dLMzBGdUZodVRRejR6?=
 =?utf-8?B?ZE9nWDVNek8rcldOVURnS1ZBMmNHQlQ4Y2YvYzZiRFBLMWtMZUhYLzVUMEdS?=
 =?utf-8?B?bzRXRysvODRuNGRDNVlQTmcwYlMxcXBuSFdIWEJsSmxHTUJUOTB1V3kxSlZq?=
 =?utf-8?B?b29GR05wUG5zdU1VQlZORjlETXVpMXJHa2FDb053K3dRMHR5TVJ2U0l4aDU0?=
 =?utf-8?B?NWNwMzZxVXFLcFlBcURSOStTRGd4encyaU8rZDhuNFg4YnQvT3dlU0pUaysx?=
 =?utf-8?B?dlVwejR3QnZoY0ZNWDY3a05FcnZ3U3RHL3phdTFibVJ3NGx4TEl5WW0xRkdB?=
 =?utf-8?B?RzlGVWliTWNNNDUzR3Q1V3cxam5HK29EUGEycE5pUE5COG9YOXlUak5DNVFH?=
 =?utf-8?B?QnphODIvV1cxQnZEYkpsc1VSNGdGV1EvUjFWN2xMU1YrcEd2MjhuSlpiYVZj?=
 =?utf-8?B?Nm4xWkp0K2tjNWdlbUE3MEkrbGQxa3k2WE1uLzBGVFFDV3QzYXB3ZTVQQzM1?=
 =?utf-8?B?WjVSNGYxekxmZlhxbjI1UngyRDBWalpxU2ROL2FUeHAwTlQzSUtHQTIydFpO?=
 =?utf-8?B?cFU5UTlqMlVxbEFNMXBaMTVCeDdVcFlPM2FBb0ZzV3dqelhpcEs3bndkbmhK?=
 =?utf-8?B?NzlWRkp3U25PYnRySXFlQWhWSFJWM3NWdk9VK1BkZWZaSWlRNFlwRjZKdGtr?=
 =?utf-8?B?TGNnNTBqWEh0U1VRakFuVVBscTFMd3BmamkxZHlYeHUxQy9LaVAxNEFzVFl0?=
 =?utf-8?B?OUpYTlhyUWY0bmROYWVleVpKZDVaOGt3UjYrMEtKellVV3J3R0V3TmEweitJ?=
 =?utf-8?B?SHFuY0dwSll5MHRaY3cvL29paExqS2NNdXVsZW8rSVNzV1FaeGFNN3dMY3k3?=
 =?utf-8?B?T2s4TmJraDAwTG9aRm1OOGkxaW9heWt3RG1sMHZLdkhmOHlYRklGRGs4bXdJ?=
 =?utf-8?B?UlZGSGluNmhaZ1JHdUpheUhiblFtb2RGaDFldjNWUXN3aVZ5VWFkNkN2QXJw?=
 =?utf-8?B?cVNkbFVBb1JiS21mSDhDdlBXT28vMzVNMyttK2lGYjRSR1J3R1E3N1VmS3JQ?=
 =?utf-8?B?THV6dm40OWgyd0tsd01VeUFpMDJna1RYRm5oMFpFSWVLS0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWFyM1dYOFg3M1JwZFpRTk8xU3dKK2s5b2IrM3VXdWdjcS9zeVZhVDZ4c2oy?=
 =?utf-8?B?L1JTTlBUblN1empMMzNTWGNNbHVPUmVETG5yZmxaK2srL0tMWktXd1ZtOVl3?=
 =?utf-8?B?SXpKazFnT1h4RkRNcmptR2hOemFkRE1qVmRqM1BDK29LcDhTek10amVLeWFI?=
 =?utf-8?B?ejRPT2NHQmNoZmNDYmdneGk0d25hdmJzcUpaV2kzQTcvSS94N3N6b25YRGRw?=
 =?utf-8?B?U1FKZGwxcUNMRHdoeU5UdENKNW1DS0g1YmJBcjlEcERMNW1TbEkvTTQvMWo3?=
 =?utf-8?B?NGVtWnI3SE5aSVEwUkxvMlV4eGN4UmMyK0lGUUE2blMvK0g5OVFtSEVrTmkx?=
 =?utf-8?B?UjZMM093NkFJbXByejAxbC80VTRJZGIrbTN1STArRHJ0STNHUWJ2NW92bnVw?=
 =?utf-8?B?LzBkTXV0VXJLTjZRRDFrZGdZWTFwSEh4azZqWWJmWUdOZ1J4U3VHWS9CNjNB?=
 =?utf-8?B?YTJ5VVlYWGUzOTZJeGxlYktFdm9ZdUQzdHdvTUwzdWlZbkRrWjZ4dHNETGJ4?=
 =?utf-8?B?djdUVmpGTlFsdHJxUkRuZzNKblE1R0VTa1hPOVZjenErbHRsYVBlSUQ2bzhD?=
 =?utf-8?B?NEFjQXVUOEFpUGtFQlhBRys1bmpodHgvM3k0bzQzTHFkVzc4NHh0N1NPNHJ2?=
 =?utf-8?B?M1EwY1VRbG0wbG9kSm4xSGo2aFFYM0Y2aGFETEt1MGRvRDgrbkNSTG1ycVk2?=
 =?utf-8?B?NHdSV3FaajBQc3puNEo5cVZsQkdzeGw3Q0U3amhwOXoxMXFDa2lKR1BFOXVt?=
 =?utf-8?B?ai9SWmxndkpHVExOMXRIL0VNY3BXVXU1MXA0YkxPSTVmamc2cEc5Q1Qrakl2?=
 =?utf-8?B?dncxN0NrQWkxdHZFMi9zajNwRk5waVZ0OXl6WVkrK1JEV1Era3dVZ1pOMy9B?=
 =?utf-8?B?bld5VVg3cUlIVDdPUmlra2VJNGRYUUZtU1h3Mjh0Skg1SmJIVUtqL3dIb0Ey?=
 =?utf-8?B?WXo1YzMyY05JcWlHY2dVYkVqenE2RTE1UXBGYlRBZXFIVVNTRVdKbVU2WXZF?=
 =?utf-8?B?THMwOUpLbXlJaHNrVzF0M21oZllzTnRsdE1tMXc0SVFtbXVvd3FzQmh6b1BT?=
 =?utf-8?B?VzJiMFJLYkxDcFlWZHdRWWU0TkEyeGh0c1RQdnhncDZJVEE1Rko2YkEvRyt2?=
 =?utf-8?B?UU5KbGl3TFh3b25aYXNPTXArZ0NxSysvL05aOTNnbUpUZWRhUzdDRWhvVk81?=
 =?utf-8?B?MEhQOVhBRWNZcVdkSUdWRVJ6QzZYRVh3ODI3bW12Z1lMQ1l2THJmYTZKVUlZ?=
 =?utf-8?B?SkZ1Vm5YYmVhSmVaWXFYc3RZRkNyR05qbjhnNjhmd2VNejc2VnRaSEl5cWND?=
 =?utf-8?B?aTNXVVZWZzVGQmk5SUhneUdsZDJGWHFMSWVJTUtzQVNNVzhVSnQyTm1vWGxJ?=
 =?utf-8?B?THJEbmhxRnBLQkhMejRJV0dUUDVxcXAwcWEzbHVydkt6SkpxRHlnYjNXbmkv?=
 =?utf-8?B?cmpRUmFBcGg2MU5DR1ZQSXVucWdRd3VmNnhNemRzdTlNNTc2VytKSy9WK2Q5?=
 =?utf-8?B?bVVYQ3ZvN3NQZUpxQXVRcmZwRUtYekhoeUx6Nk5jSlk1alZJMWxWUnQ4clU1?=
 =?utf-8?B?NU9rZ09lcitEZ2dOQTFGOFVmeEtWVEtRREZhazRGMVd3cWY4NGRndmRjSWs2?=
 =?utf-8?B?aDJ0S1dBK251WTNFSVowRkpPTGhKbWd4Ri9QY3VDV2djTUNPRlZ5L00xYkFj?=
 =?utf-8?B?b004N29BdW94SHZseStIRDVBdE4yOFd1Y0RvdjVwSXM4Q0hYSkZ4WTlQNWF1?=
 =?utf-8?B?Zmk3UmJsZ1o1ZUV2RjVHZmJtN3h6VVlvWVp0Rk9KdUNRbWxSN1dsN2dnM0Fu?=
 =?utf-8?B?dEgxT0lCUUttYlVjZmxuV0hNTTYrR3MrWGpHZFRDL2xPOU50TzNjRUdCYVlL?=
 =?utf-8?B?Vko1cDBKdHA2UWVQWlVCY2tzSmQxOFRHWDQ1eldXOVJ5c0FSNlEzY2JzSmdt?=
 =?utf-8?B?bzJvaTZheEpldWlJaDhObi9uQ3BZNnpEcnRWLzVnbVRLMjVWa2xOM1ZBSWs3?=
 =?utf-8?B?VVlvYm5xVStrcTRYcnBYQVNhSk1SNEtkVWdNaDRYL0ZxSkFieWJ2Q0RiK214?=
 =?utf-8?B?K3dBbm5HQ2o1Skp4MHhkL3JBbDU5VXVLeUMwUWE5OVplQ3ZOZFpmU1NXeHVj?=
 =?utf-8?Q?n3rY51ljtEU9x+N/V8fMsilu9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f2bef-3951-4a0c-de0c-08de21c16495
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:59:23.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwU9Lw8/kY4GbXjdzab36G/S2QFrYjyjRmCacrEE9IXs2n/smQwvlBdnKlWC7lIF6/wEB6pH9CMJ9OmaVwLesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2MyBTYWx0ZWRfX9LN36uIbyeRx
 ZPv5c64w6PpKg1QiauTzTLJqx7g/ro4ijL0Vt3LOVj+Ac5FCGRmMDCfoSxB7fAk5H0wV4m1ZMSx
 R57dSon3DR+yK2q+yawuvsYNQrlMgDN475qCvD8N+fKNpfRXU3ynRZYRHnPHGS4PqCl7f9Jz3XN
 d6HuPF7IrJUE3eywUMSRPwrRTt4uHy1X/PcbXBR73keCGS+HOoCLs3zYWLmGVxDTkbMXglbJYFq
 dyZ//arVOiSjyU7/WLk3kKVD+dXTFTxKncceTeg0Jplvly/Z/AWlgnNPZRIxGLe+uQ/JrbvRvHa
 iAxhGi1qEqJXu+2fxviRSkf14fkCqmKf95f3F2I8gZHX5OiQ/UOxq+vU9HiePldbAwvEv/83MAA
 9ik5+qvGFKmqJARFFZO221lLfxgLDA==
X-Proofpoint-GUID: L0XLEZlWtxaifmyKKWKoydv3eUt7A8of
X-Authority-Analysis: v=2.4 cv=Uvpu9uwB c=1 sm=1 tr=0 ts=69143e5d cx=c_pps
 a=fLgsFiGMcCN2bMhaTK1NuA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=lxEWtBMArU6aNcZvPCsA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ltsVsjNxyn08V2SGbzQA:9 a=VvHwodcdPuhPAagu:21 a=_W_S_7VecoQA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: L0XLEZlWtxaifmyKKWKoydv3eUt7A8of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120063
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:59:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2493

--------------KCOG64EQ86J5C0983O6KMH9b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AC5RcH33531643

On 11/12/25 15:39, Samuli Piippo via lists.yoctoproject.org wrote:
> Would it make more sense to leave out the INHERIT and=C2=A0WINSDK_NO_SY=
MLINK.
> Instead, if you need this, you can inherit the class in your recipe or=20
> local.conf
>
> -samuli
Hi Samuli,

 From my experience, users will usually prefer a variable setting when=20
it's possible.

Take this case as an example, they could put this setting in their=20
<distro>.conf, site.conf or local.conf, then no matter meta-mingw is=20
included or not, 'bitbake <something>' still works.

Regards,
Qi

>
> On Wed, 12 Nov 2025 at 07:35, Chen Qi via lists.yoctoproject.org=20
> <http://lists.yoctoproject.org>=20
> <Qi.Chen=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
>     On 11/11/25 23:25, Joshua Watt wrote:
>     > On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM <Qi.Chen@windriver.com> wr=
ote:
>     >> From: Chen Qi <Qi.Chen@windriver.com>
>     >>
>     >> On some Windows systems, symlinks are not allowed due to IT poli=
cy.
>     >> We need to be able to generate Windows SDK without symlinks.
>     >>
>     >> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass=
,
>     >> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
>     >>
>     >> By default, things work as before; when setting WINSDK_NO_SYMLIN=
K
>     >> to "1", SDK will replace all symlinks with the actual contents.
>     >>
>     >> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>     >> ---
>     >>=C2=A0 =C2=A0classes/mingw_sdk_handle_symlink.bbclass=C2=A0 =C2=A0=
 | 25
>     +++++++++++++++++++++
>     >>=C2=A0 =C2=A0conf/machine-sdk/include/mingw32-common.inc |=C2=A0 =
3 +++
>     >>=C2=A0 =C2=A02 files changed, 28 insertions(+)
>     >>=C2=A0 =C2=A0create mode 100644 classes/mingw_sdk_handle_symlink.=
bbclass
>     >>
>     >> diff --git a/classes/mingw_sdk_handle_symlink.bbclass
>     b/classes/mingw_sdk_handle_symlink.bbclass
>     >> new file mode 100644
>     >> index 0000000..2f6dbe6
>     >> --- /dev/null
>     >> +++ b/classes/mingw_sdk_handle_symlink.bbclass
>     >> @@ -0,0 +1,25 @@
>     >> +WINSDK_NO_SYMLINK ?=3D "0"
>     >> +
>     >> +archive_sdk:prepend:sdkmingw32 () {
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ "${WINSDK_NO_SYMLINK}" =3D "1" =
]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for pars=
e_type in "file" "directory"; do
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0find "${SDK_OUTPUT}/${SDKPATH}" -type l
>     -print0 | while IFS=3D read -r -d '' symlink; do
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=3D$(readlink -f "$=
symlink"
>     || echo "NOTVALID")
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ "$target" =3D "NOTVA=
LID" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ ! -e "$target" ]; th=
en
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif [ -d "$target" ]; th=
en
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ "$parse_type" =3D
>     "directory" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm "$symlink"
>     && cp -r "$target" "$symlink"
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ "$parse_type" =3D
>     "file" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm "$symlink"
>     && cp "$target" "$symlink"
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0done
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +}
>     >> diff --git a/conf/machine-sdk/include/mingw32-common.inc
>     b/conf/machine-sdk/include/mingw32-common.inc
>     >> index 56b8052..bf3f14e 100644
>     >> --- a/conf/machine-sdk/include/mingw32-common.inc
>     >> +++ b/conf/machine-sdk/include/mingw32-common.inc
>     >> @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D ""
>     >>
>     >>=C2=A0 =C2=A0# wine and wineserver are required to test MinGW SDK=
s
>     >>=C2=A0 =C2=A0HOSTTOOLS_NONFATAL +=3D "wine wineserver"
>     >> +
>     >> +# handle symlinks
>     >> +INHERIT +=3D "mingw_sdk_handle_symlink"
>     > Does this need to be unconditional? I'd prefer something like
>     > INHERIT:mingw32 instead if that works
>
>     Hi Joshua,
>
>     I just tried it out. Using INHERIT:append:sdkmingw32 works.
>     We have to use :append instead of "+=3D" to avoid overriding settin=
gs.
>
>     I'll send out V3.
>
>     Regards,
>     Qi
>
>     >
>     >> --
>     >> 2.34.1
>     >>
>
>
>
>
>
>
> _._,_._,_
> -----------------------------------------------------------------------=
-
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2490)=20
> <https://lists.yoctoproject.org/g/yocto-patches/message/2490> | Reply=20
> to Group=20
> <mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20meta-mingw%3A%20su=
pport%20generating%20Windows%20SDK%20with%20no%20symlink>=20
> | Reply to Sender=20
> <mailto:samuli.piippo@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5By=
octo-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20meta-mingw%3A%20supp=
ort%20generating%20Windows%20SDK%20with%20no%20symlink>=20
> | Mute This Topic=20
> <https://lists.yoctoproject.org/mt/116091557/7304865> | New Topic=20
> <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription=20
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/7304865> |=20
> Contact Group Owner=20
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe=20
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13175947/7304865/=
1848005690/xyzzy>=20
> [Qi.Chen@eng.windriver.com]
>
> _._,_._,_


--------------KCOG64EQ86J5C0983O6KMH9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AC5RcH33531643

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 11/12/25 15:39, Samuli Piippo via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CABXoSoW68LaasoHdKFcRV_XHBbixCa=
kN+qq=3DO1hx7dFTf-pFdw@mail.gmail.com">
     =20
      <div dir=3D"ltr">
        <div>Would it make more sense to leave out the INHERIT
          and&nbsp;WINSDK_NO_SYMLINK.</div>
        <div>Instead, if you need this, you can inherit the class in
          your recipe or local.conf</div>
        <div><br>
        </div>
        <div>-samuli</div>
      </div>
    </blockquote>
    Hi Samuli,<br>
    <p>From my experience, users will usually prefer a variable setting
      when it's possible.<br>
    </p>
    <p>Take this case as an example, they could put this setting in
      their &lt;distro&gt;.conf, site.conf or local.conf, then no matter
      meta-mingw is included or not, 'bitbake &lt;something&gt;' still
      works.<br>
    </p>
    <p>Regards,<br>
      Qi</p>
    <blockquote type=3D"cite" cite=3D"mid:CABXoSoW68LaasoHdKFcRV_XHBbixCa=
kN+qq=3DO1hx7dFTf-pFdw@mail.gmail.com"><br>
      <div class=3D"gmail_quote gmail_quote_container">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, 12 Nov 2025 at 07:3=
5,
          Chen Qi via <a href=3D"http://lists.yoctoproject.org" moz-do-no=
t-send=3D"true">lists.yoctoproject.org</a>
          &lt;Qi.Chen=3D<a href=3D"mailto:windriver.com@lists.yoctoprojec=
t.org" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">windriver=
.com@lists.yoctoproject.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          11/11/25 23:25, Joshua Watt wrote:<br>
          &gt; On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM &lt;<a href=3D"mail=
to:Qi.Chen@windriver.com" target=3D"_blank" moz-do-not-send=3D"true" clas=
s=3D"moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;
          wrote:<br>
          &gt;&gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.=
com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt-link-fre=
etext">Qi.Chen@windriver.com</a>&gt;<br>
          &gt;&gt;<br>
          &gt;&gt; On some Windows systems, symlinks are not allowed due
          to IT policy.<br>
          &gt;&gt; We need to be able to generate Windows SDK without
          symlinks.<br>
          &gt;&gt;<br>
          &gt;&gt; To do this, a new variable, WINSDK_NO_SYMLINK, and a
          new bbclass,<br>
          &gt;&gt; mingw_sdk_handle_symlink.bbclass, are introduced to
          achieve this.<br>
          &gt;&gt;<br>
          &gt;&gt; By default, things work as before; when setting
          WINSDK_NO_SYMLINK<br>
          &gt;&gt; to &quot;1&quot;, SDK will replace all symlinks with t=
he actual
          contents.<br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@w=
indriver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt=
-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt;&nbsp; &nbsp;classes/mingw_sdk_handle_symlink.bbclass&n=
bsp; &nbsp; | 25
          +++++++++++++++++++++<br>
          &gt;&gt;&nbsp; &nbsp;conf/machine-sdk/include/mingw32-common.in=
c |&nbsp; 3
          +++<br>
          &gt;&gt;&nbsp; &nbsp;2 files changed, 28 insertions(+)<br>
          &gt;&gt;&nbsp; &nbsp;create mode 100644
          classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt;<br>
          &gt;&gt; diff --git a/classes/mingw_sdk_handle_symlink.bbclass
          b/classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt; new file mode 100644<br>
          &gt;&gt; index 0000000..2f6dbe6<br>
          &gt;&gt; --- /dev/null<br>
          &gt;&gt; +++ b/classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt; @@ -0,0 +1,25 @@<br>
          &gt;&gt; +WINSDK_NO_SYMLINK ?=3D &quot;0&quot;<br>
          &gt;&gt; +<br>
          &gt;&gt; +archive_sdk:prepend:sdkmingw32 () {<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;if [ &quot;${WINSDK_NO_SYM=
LINK}&quot; =3D &quot;1&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;for parse_type in &quot;file&quot; &quot;directory&quot;;
          do<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;find
          &quot;${SDK_OUTPUT}/${SDKPATH}&quot; -type l -print0 | while IF=
S=3D read
          -r -d '' symlink; do<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;target=3D$(read=
link -f
          &quot;$symlink&quot; || echo &quot;NOTVALID&quot;)<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if [ &quot;$tar=
get&quot; =3D
          &quot;NOTVALID&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;continue<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if [ ! -e &quot=
;$target&quot;
          ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;continue<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif [ -d &quot=
;$target&quot;
          ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;if [
          &quot;$parse_type&quot; =3D &quot;directory&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rm
          &quot;$symlink&quot; &amp;&amp; cp -r &quot;$target&quot; &quot=
;$symlink&quot;<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;if [
          &quot;$parse_type&quot; =3D &quot;file&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rm
          &quot;$symlink&quot; &amp;&amp; cp &quot;$target&quot; &quot;$s=
ymlink&quot;<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;done<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;done<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +}<br>
          &gt;&gt; diff --git
          a/conf/machine-sdk/include/mingw32-common.inc
          b/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; index 56b8052..bf3f14e 100644<br>
          &gt;&gt; --- a/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; +++ b/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D &quot;&quot;<br>
          &gt;&gt;<br>
          &gt;&gt;&nbsp; &nbsp;# wine and wineserver are required to test=
 MinGW
          SDKs<br>
          &gt;&gt;&nbsp; &nbsp;HOSTTOOLS_NONFATAL +=3D &quot;wine wineser=
ver&quot;<br>
          &gt;&gt; +<br>
          &gt;&gt; +# handle symlinks<br>
          &gt;&gt; +INHERIT +=3D &quot;mingw_sdk_handle_symlink&quot;<br>
          &gt; Does this need to be unconditional? I'd prefer something
          like<br>
          &gt; INHERIT:mingw32 instead if that works<br>
          <br>
          Hi Joshua,<br>
          <br>
          I just tried it out. Using INHERIT:append:sdkmingw32 works.<br>
          We have to use :append instead of &quot;+=3D&quot; to avoid ove=
rriding
          settings.<br>
          <br>
          I'll send out V3.<br>
          <br>
          Regards,<br>
          Qi<br>
          <br>
          &gt;<br>
          &gt;&gt; --<br>
          &gt;&gt; 2.34.1<br>
          &gt;&gt;<br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
      <div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target=3D"_blank" href=3D"https://lists.yoctoproject.org/g/yoc=
to-patches/message/2490" moz-do-not-send=3D"true">View/Reply Online (#249=
0)</a> | <a target=3D"_blank" href=3D"mailto:yocto-patches@lists.yoctopro=
ject.org?subject=3DRe:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-mingw%5D%5=
BPATCH%20V2%5D%20meta-mingw%3A%20support%20generating%20Windows%20SDK%20w=
ith%20no%20symlink" moz-do-not-send=3D"true">Reply to Group</a> | <a targ=
et=3D"_blank" href=3D"mailto:samuli.piippo@gmail.com?subject=3DPrivate:%2=
0Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20m=
eta-mingw%3A%20support%20generating%20Windows%20SDK%20with%20no%20symlink=
" moz-do-not-send=3D"true">Reply to Sender</a> | <a target=3D"_blank" hre=
f=3D"https://lists.yoctoproject.org/mt/116091557/7304865" moz-do-not-send=
=3D"true">Mute This Topic</a>
        | <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post"=
 moz-do-not-send=3D"true">New Topic</a>
        <br>
        <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub=
/7304865" moz-do-not-send=3D"true">Your Subscription</a> |
        <a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" moz=
-do-not-send=3D"true">Contact Group Owner</a> |
        <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/1=
3175947/7304865/1848005690/xyzzy" moz-do-not-send=3D"true">Unsubscribe</a=
>
        [<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Qi.Chen@eng=
.windriver.com">Qi.Chen@eng.windriver.com</a>]<br>
      </p>
      <div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------KCOG64EQ86J5C0983O6KMH9b--

