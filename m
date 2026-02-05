Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D747E8B39F
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 05:40:28 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14474.1770270022756559260
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 21:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=VU9K3HV5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=64960e8607=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6155B56g3474437;
	Thu, 5 Feb 2026 05:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=tFROQ/FQWqCbp4rwB8teocsva2LIBr6V6nImWc+FUHc=; b=
	VU9K3HV5y8yKF5y+Mi+kU8p2FeFU5VhQbjjgFOZE40KCu5MMdIOrs/N2EfG5n83x
	lvun2ZWmHUEO0Tw8k5X0iDZLHBJGiG7x8uwB8ORh/tz/3oBhtT8ajDGyYSCZeWEl
	3/D2ltg4vtKMV9nIGRugcN4VYxbfArTezqKsHAXeBGsbUO9z3EYyxylZEn/rVJvA
	pqd0PcC5irGwNdDoNUZRl0V4l3aq+MzNp/vls/zuVPV0Rwf3Le/Acb83FFQ5th/3
	Tnz3y6sD0YeiKM70cVeaCbzaXSqAy6yHoxgOsodWCSSQ1+ruCCe+28AC/oEiRWHT
	8nlY3mS2S7ePT9UISilr+g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c4jdhr4fe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 05:40:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFjR8zzQaFWh2rE+qxqPgarLGuzNnV7yR2N63i0G7c/tDIrUKzGUcniqWtsVjGDEgVtovUczgTgfhySAbEZy+8bztb+5PyNTrxWVUL2gFCcA6j0EPi0UZRcZ8e04LTR0/+aiz1N8l5icaxKweUKodLS/xqFVjpo0jV0k0bSsDTK9sVwezV2AG7ViqXAjGHJtH+8FAkUpLA/WE82IlJ4yus1AH2tIb+RV0/sHwHHIIznRcWYEmg/2k/Fby+P6bPdkFpoNpkpD0TH34ErPCBZbK9KAchjeEtCGrDc/YU2cqNVRyYvUIFoTubjIRgoAXAJmGOXOHmplei6IJO/ysT0lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFROQ/FQWqCbp4rwB8teocsva2LIBr6V6nImWc+FUHc=;
 b=uLIdtzi+agG112Rbrl8Uxub7wRsk3glRPOHyTESi135YXXN8TGbz51wZN1YHftVhKrNfaGoVImGtapUKB4aCyg97MNAsLs5na7l0IAZ/8NlTSmPa36mQ4XmWbqds9kUvE6dfNt9tgOYlHhIz+zaIlPtZpUjaw9F6ykL4V1RqchSNOn/9Cw2qQABhK8+xMOS2niVJHWFO4gK8Yr9ycp8IZrmbz8oWpdeL39Uv+MK4/uoWllu8z2hNjsdFFqruvEY38ziIcApGvKAUPE1/D+coemzgjrW3kJUWZFE9zvJB4H/UQU6BGMpc29C+aqryOfHEi0NNi61Khfy4JegP/y+THA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.15; Thu, 5 Feb 2026 05:40:19 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 05:40:19 +0000
Message-ID: <2392d1ad-ebf3-49a0-9b82-c3accfc2eaa6@windriver.com>
Date: Thu, 5 Feb 2026 13:40:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] [meta-selinux][master][PATCH] refpolicy:
 brctl - add changes to access devpts
To: Wei Deng <wei.deng@oss.qualcomm.com>, yocto-patches@lists.yoctoproject.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        quic_mohamull@quicinc.com
References: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
 <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
 <50724a7f-6cc7-41c6-9406-017777b7801f@oss.qualcomm.com>
 <8bc62b8a-ace4-4f1e-af85-ef0e2d920061@windriver.com>
 <a99ab9c9-a364-43c9-b59d-afa16663c308@oss.qualcomm.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <a99ab9c9-a364-43c9-b59d-afa16663c308@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYWPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MN0PR11MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3293b198-e24e-4fd2-621b-08de64790bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SjF2K2thNk45OWNIWEoxem1KbVVoZkh3cEtEcXhZQzRkYXhDVDMzaldMd0VX?=
 =?utf-8?B?MnQ0UGh5dmphQ3RscG5GbC96R0JkZ1NjTnJDc3FNMXhoYks1STFhWnBMemxK?=
 =?utf-8?B?VGJUekZQTTF6cmhGb2txcGFkalFpa0kybVdCalhnK2IzRkprdEFBRDN3YTVn?=
 =?utf-8?B?Q2c0U3ZhLzRqNG5wSk9HSDdETWNKQjdlWjE5a2hRdFpDZy9LUVk2L040ejNo?=
 =?utf-8?B?OE9KUjBnWCtvYTJIbUo2TUtZVnRQNER3RWZZdXIzUGRMTy9TdmhrZHlPK3Fm?=
 =?utf-8?B?dkRSQWk0Ym5aOWFTM2FlWHd0aVFIRzlycm9SRVY2dU9CYnlsRXprSXRMOWNZ?=
 =?utf-8?B?UFg1dldjc2lyc2tic08yQ2taV0lndExCQmxmR0M0YTRaeWhFNlBhYXhYbkpM?=
 =?utf-8?B?Wk15c1Z3NHJ1dm1yaW94Z1lXdjFIM0ErSTBobEd3VGpRNHdaWGlpVTlyQzJN?=
 =?utf-8?B?UFNqTGo1TnJpYnBHcitYTnRJMmdYb1VDb2NlZ1JHNnFFVXhzWkp0bUhpNCtG?=
 =?utf-8?B?aDJLc3U2S2ZDQWVSZHFUVnBONjRUVzVHbnJiUjNPdHoraEx6dDZySy9CL3ZF?=
 =?utf-8?B?VjJFdjF1RHRJelJuRm1zbnlXczZLblVuaEw0OXpQNzQzY2l4ajQ4T2xSeCtM?=
 =?utf-8?B?RmZad3dDOGRuODBlbGJhbVp6R0k3WWg1aU4wUTNnVThwNnpIUmlQZGpUQjVx?=
 =?utf-8?B?QlhqV2ExSnhkRkYrTXpHdHRQODNPWWFaR3pwNmxHdFBkdGwrR0ExczRIQ2o0?=
 =?utf-8?B?Q2pqUlA1aC9EcmM4Y3lVa3lmaGhXcjh2bGJWd1hlMWgvZDdUUHhwRkxPaldB?=
 =?utf-8?B?QU1hYWJZaTJGTC9jUjhKMVo4SVFCVmxnOWNlK3piTjM4bE56b3ZKZHNQelZj?=
 =?utf-8?B?SU5yWlVUZk8xQi9aVUdjWGxZd1VleFcrdFJENnJqNm1uWmw5T0IrUFVLeFpz?=
 =?utf-8?B?QXNTbWQ2NWJKbm1sQ3NTR3NSaUdzSXJUOTc4SG5kV1lvVFRFL2Y1S2E1UjR6?=
 =?utf-8?B?UXpGSE9INitkc2g4ZnVPa0Z2emIyODArMjlybG05VzV3QUdzZ2VlRHpYRzV2?=
 =?utf-8?B?QXg5RXFhWGtDTE5jc2lhTlUxSHNoTXdUWmpNMkw2ODF4dXZWS1M3a05vUGVD?=
 =?utf-8?B?QmV2R2UzSlBtRnFFcWt1SFVaU2ZCS2pqa1ZWSjZ5SXZHTHpXcTExNmhTM2lz?=
 =?utf-8?B?WlB2eEg0eXIzWnpUUDZUVzd0WUJ3UWd2K1JpRy9mNXhIQTM1ZXVranJlaWEw?=
 =?utf-8?B?Mmw4MmFHL2czZ0Y4Y09raUVxN0RuNThTSkNmcHpCamNrVy9JT2pmSDhYclNC?=
 =?utf-8?B?NUx0NmJCZk1xWnFpQTJJN0lqanY5eW16UUxzWWhKRXV2YXlWZHBsY0ZpdWRw?=
 =?utf-8?B?TldVdnNDYWwvUEVRUkdlaDJSOTZxY1k2eFJGdmtUZDduUTdGUHBYMXc3RWZk?=
 =?utf-8?B?VXRsV0poV0tGRHJFTmg3MVRpZmwrdUk0QnM0dW9zTU4rUXFtK3RmbnF6WVdY?=
 =?utf-8?B?TWVkZ1NFVTNxZWFsUktFZWRDQ1dld3MzWlBodDZJUnpWL3hjWlVVK0dDN2li?=
 =?utf-8?B?THU4VWtIWnZCaVV4VDFPZExXbFdTbzdyeGhEVkF1YnJPTTFOeU9BV2JZRjR2?=
 =?utf-8?B?OTUzekFsRHJCbm9CUDZIL09QZDJIU3RwbElJMWxLUlYrSWFSTkJ2TUlUOHU1?=
 =?utf-8?B?TjZvMzFFais2WGhZdU5WM1U1eGNXZkplKytZeStPR2hyZjVBK1lRVHZvNjlG?=
 =?utf-8?B?VzhhUHRZRTgreDdZQTVjZk5nOFZVS1dXTkNYZFlBcVFBT3l6RlFhYitQc1VL?=
 =?utf-8?B?QnFmT2RZRWJscWQxdmlJSER3MWsxQVFYUHhNZTlJcU5zYU9CRkduREZXTDRW?=
 =?utf-8?B?M2gzZFRsUEZnMDFEVmZkSDhmVzhIdWpKK3pwcmxjbkhjZWluVExUTHd1VEpv?=
 =?utf-8?B?d1N2d1RubG1wcDhobHRRSkRhZmZGVU9YWkM3Q29lSXRwOEJEQ3R2U1NDRTBF?=
 =?utf-8?B?ZE1hZmJhYlY1dGZZS1ZhUS9iQm1pV2REZ1lpYjZLYkZZL05WR2dpUzByaFdk?=
 =?utf-8?Q?H74lFn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TldvSTRKdGY1SFRwYVA5SjBCRWMxQXU4cHVwRDNtbnhHMklJd3JwcmhCaEtJ?=
 =?utf-8?B?dWViMzNoYUhEb3BYemJhQkNIZXByNXJmaXpObWRUdENJK21JYmRPcGJJZlZB?=
 =?utf-8?B?d0RQYVgydlBLZ0JlWWZXci8yNDZYang5WGpvdHU5TnVkZ1hvUlA2NW5UUnFm?=
 =?utf-8?B?TmYxeVp2UnVpdERvOEVOMEdEbTc0d0ppTTRWL3JDTTM5MU1JeUxqRDFidjZp?=
 =?utf-8?B?SkJBaE4ydTltdGdLVU5GSmg5YytUVWZIS1hhSzk2eTR5SVJQbi9pRDBLUjd5?=
 =?utf-8?B?QU5HZEsyMGZnOVR2dU5SZmZKQkRHODFIdktMczN6QWlEWHBPUGM3cFlVbGVR?=
 =?utf-8?B?TTc5RXA2NjdSZjIyRkZZaTllNUgzSkh3d1ZDSFlTblhDaE9VRnl0ZlRNVHRD?=
 =?utf-8?B?Qzl2MC9JYzNpYlRmcWJodCtSVTJOOFA3ZTBESkwvQ0VRRE91bzhBOXZIYU9S?=
 =?utf-8?B?blBTNDJsQVBieTBJelpqbnVTNlRhbm5BWlR4RERlOUtzOVJhYmdEZ2lWZVNu?=
 =?utf-8?B?OUhXMmRFVmRkd2J4bitHTHlzamxPVDdtcFhPSXNBTGtxUUlWako1RFBDNmhL?=
 =?utf-8?B?NHdkeW9JWEFSSHR0UnNkQy9tYitqa0d2MlViL3pweUhwaWpFbGhlSUs0N0w5?=
 =?utf-8?B?N3Z6dlF5UG4vSTExWXZBd3I1YW9va09oODBWTkhURXZhOTdEa0UwUWR2SVhI?=
 =?utf-8?B?K21rZUdDbm10WEJDbTlqSFEvejFuOVJndVBFVWRoUFdkbTl1S3Axc1RzZUoy?=
 =?utf-8?B?dDZpRHhOTWlGOEpMRjNuUU42bGpvaWp1OUh2VFhPbnNyTUd0bEtmYTlXSEhN?=
 =?utf-8?B?clBWNEZIZjlWOFZXVHF3QUIrRzl4Q0dPaEpsQ0hrNkdjODVhNUZVQ3ZOV2k2?=
 =?utf-8?B?RkNIdmVTaENVK3Yvc05ac0x5VkdHZWthRExKV3d6R1ltZzUyMFYvTm9QUlBs?=
 =?utf-8?B?b0pYWEhzeUtOTkkxSXdoQmtWclVwNkw3NXZUdHNFbWhaYzcvQ0xGaHd1Tk8z?=
 =?utf-8?B?TUQrbjVGVkpCZVQ4TEVURDlBa05ldm9CcTJKYzdFTmtyTFVKeVhWR2l3a2ZM?=
 =?utf-8?B?bDZxTGFJOEQvKzJtdFZCUjRCd3pIRU5LOHRhUDh4U2xNdjNvNDVlNUtPeS9N?=
 =?utf-8?B?YUMzREpDRjhkckhDZUtSWVZYZmZmQ2hKRDhkcTJmZDRwczRaWm9tc2JueWJO?=
 =?utf-8?B?Q3p5WWE1WG9QSEdYYVAyOGwyaEJhVDFpMjFaSXVIbE1wTGNMN1F2Kzk2cTNM?=
 =?utf-8?B?SURSZzBkU3FaajJtK2VISVZnRGRYempsTFhuc2laR2k3YkNLMFdUL0tGMlJS?=
 =?utf-8?B?QUVHa1JOZUw4RU90aWNFOG9wS2paQ2JTK2loZkZVRUd0cWtSWWVSQys5cjI4?=
 =?utf-8?B?UnlZZEFOZ1JqNzRJa0pqQktGdWIydHdsaDMwejdtNWtoUzVFeWk5aWV6WkUv?=
 =?utf-8?B?SjNoUTZNREkrL2VFZ2hnU2xXbHViT01KVlBicVFvNk5JZlpTdTB6ME55QmN2?=
 =?utf-8?B?SFk4WkFxaTdnVmVya3BzNEJOc0kzQk9tUitaOWcvTUozZXZtbXpVazNscjdV?=
 =?utf-8?B?b01ZQXg2N1V2aEkvYkZVOEd4bHA3dThPVFQ4NWowbG42bHA3ZkhpN1lPOGUw?=
 =?utf-8?B?RXpURFYzR012bTBPN0pnNFRsRHpCTnpBWkg0aHd4bU1yU3E5K3Z6UHNEL2ZU?=
 =?utf-8?B?UDVURnB0TmJnRURyaGR1ODY4czVOalQxYTk3QzAzdFhCL084alMyd0toc1Fu?=
 =?utf-8?B?UDRkSW1iU045aGpXcGt1SU9xNVM4clZQOVBjWVc0cXovVXBtb0JlTktBU0dU?=
 =?utf-8?B?K2laYWhwekFSQ2g2cnlhdXVSWld1Q1FsdjgrVys3aVV1aWM0Y01tZStCQ3FP?=
 =?utf-8?B?UkN6UlRoSG1ORGNQNXppdythckhhYmlhaHZHWGs2ZUw0L3lqL1FsSVB1d3Fm?=
 =?utf-8?B?dmFEY2R4UHkwL3VhQXVRNmhsVlp3azVCMnhOVXg1TjFBNnltblp5elZUTUF3?=
 =?utf-8?B?UnhKV1JrbUhBVXorWGE3M3REMTdqb1JGemFKZnhvUERFOUMySk5wcWpDTTFL?=
 =?utf-8?B?Ykpsa2J2WkErSWtENEpkbjY0Z2tPamRka09KelFScnFVRUw4MC8vaXM4eXpW?=
 =?utf-8?B?Smw5ZWZleU1FWXloL3V5ZllNNExRa3pSV3NMbmlrd2xIZGlzaHdBT2QvSjhm?=
 =?utf-8?B?L0g3V3ZBOUFuaTZLTlF2ZS9vd1dPQUFxb1R3bVNjRU9sTHBsZ2hzUlpLMW84?=
 =?utf-8?B?THBrc0ZRdmxIb3FDWEgrOFhqNTNqckxQOVo3MHhZNkxJQVJRV21lRGg3VUxZ?=
 =?utf-8?B?TXROMmprQnB3Vng3MExYV0J1TDJnN2JxM3JqT2xLQTh1WUc5a0hFdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3293b198-e24e-4fd2-621b-08de64790bf0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 05:40:19.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk98oyDcTZdIKZIsoGMAEOPHk3V8Zqxlz1DZWfB4n8ULKxr6m09NQdntvzUGR9DwYue54vPQnLa/7wi6DibwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
X-Proofpoint-ORIG-GUID: dsU8gkmx_-0I7-EZZV09Y2wd6uDV5jiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAzNyBTYWx0ZWRfX+teZhnoMRpYv
 LakL8CZbuonlChpGHVhSricV2vB2ENI0dt7HawSFuVsaNEMhrMcEtBghIrTQ+/UfYzpSGB22Tgh
 IpEF9O3Z2tg5jtYwn36Uzr+mQFH8RPHH/biBR4dmSB4pWPqqewURzGr5vJZJZ7Sff+1kivtRDpl
 aQWpo7scu6CD6Cj21x84goP/F/Eq8OmfCeqXcVjAqbAQaWiznAUgUOviCT6uyBMjUB3BgoGLN9y
 J0/04a7Wcd+qixhafu9eA6kLOa4pd4Wnip2DSlKfgRHFudNORv05QK1g4niYemXHi0hEwBmhoiA
 LYk5A+FSyV0ttuOUPXsGy2Vmx0PMuE71NJB5t7pfKEC1RI6CGImU7KifGr4+SsyWO9PNw0p+Qze
 KPcvoMRw0+QPv608nB/o7hP6gpnF6Y9JEpSFRwZqbZQGH0Ifra2FYqHyBv344E2bM9t9fK8v2a2
 DVqIkOb+qzb+oE3+J/Q==
X-Proofpoint-GUID: dsU8gkmx_-0I7-EZZV09Y2wd6uDV5jiR
X-Authority-Analysis: v=2.4 cv=TsDrRTXh c=1 sm=1 tr=0 ts=69842d45 cx=c_pps
 a=E1AkXC+xFF28g4y6WI75Xg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=4ff6wpWW6FzUAqUNK94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050037
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 6155B56g3474437
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Feb 2026 05:40:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3192


On 2/5/26 09:55, Wei Deng wrote:
> Hi Yi,
>
> On 1/30/2026 2:47 PM, Yi Zhao wrote:
>> On 1/30/26 13:38, Wei Deng wrote:
>>> Hi Yi,
>>> Thanks for your reply.
>>>
>>> On 1/30/2026 11:22 AM, Yi Zhao via lists.yoctoproject.org wrote:
>>>> Thanks for your patch. I won't merge it at this time because I am cu=
rrently working on updating refpolicy, and this backport patch will be in=
cluded in the updated version.
>>>>
>>> We have another patch need backport as below, hope it alse be include=
d in the updated version. Thanks.
>>> https://github.com/SELinuxProject/refpolicy/commit/1783c0c4eb9aaff6b7=
b1b18fbd86f933e398ce5b
>> Yes. This will also be included in the upcoming update.
>>
>> //Yi
> Thanks for your confirmation. When you have a moment, could you please =
share if there=E2=80=99s a tentative timeline for the version update?


I'm working on it and expect to submit a pull request next week.


//Yi

>
>>
>>>> //Yi
>>>>
>>>> On 1/28/26 23:08, Wei Deng wrote:
>>>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 ...cy-modules-admin-brctl-access-devpts.patch | 39 ++=
+++++++++++++++++
>>>>>  =C2=A0=C2=A0 .../refpolicy/refpolicy_common.inc=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>>  =C2=A0=C2=A0 2 files changed, 40 insertions(+)
>>>>>  =C2=A0=C2=A0 create mode 100644 recipes-security/refpolicy/refpoli=
cy/0057-policy-modules-admin-brctl-access-devpts.patch
>>>>>
>>>>> diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modul=
es-admin-brctl-access-devpts.patch b/recipes-security/refpolicy/refpolicy=
/0057-policy-modules-admin-brctl-access-devpts.patch
>>>>> new file mode 100644
>>>>> index 0000000..cc6abd1
>>>>> --- /dev/null
>>>>> +++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admi=
n-brctl-access-devpts.patch
>>>>> @@ -0,0 +1,39 @@
>>>>> +From 43ef3db9bc4247222d773bb24da71352bf84f4e5 Mon Sep 17 00:00:00 =
2001
>>>>> +From: Wei Deng <wei.deng@oss.qualcomm.com>
>>>>> +Date: Tue, 20 Jan 2026 08:28:45 +0530
>>>>> +Subject: [PATCH] Sepolicy changes for brctl to access devpts
>>>>> +
>>>>> +Resolve selinux permission for brctl tool failed to launch in adb =
mode
>>>>> +with enforcing mode enabled.
>>>>> +
>>>>> +Below avc denials that are fixed with this patch -
>>>>> +
>>>>> +avc:=C2=A0 denied=C2=A0 { read write } for=C2=A0 pid=3D1407 comm=3D=
"brctl"
>>>>> +path=3D"/dev/pts/0" dev=3D"devpts" ino=3D3
>>>>> +scontext=3Dsystem_u:system_r:brctl_t:s0
>>>>> +tcontext=3Dsystem_u:object_r:initrc_devpts_t:s0 tclass=3Dchr_file
>>>>> +permissive=3D0
>>>>> +
>>>>> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpo=
licy/commit/43ef3db9bc4247222d773bb24da71352bf84f4e5]
>>>>> +
>>>>> +Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>>> +---
>>>>> + policy/modules/admin/brctl.te | 2 ++
>>>>> + 1 file changed, 2 insertions(+)
>>>>> +
>>>>> +diff --git a/policy/modules/admin/brctl.te b/policy/modules/admin/=
brctl.te
>>>>> +index 026b0002d..45ca94c60 100644
>>>>> +--- a/policy/modules/admin/brctl.te
>>>>> ++++ b/policy/modules/admin/brctl.te
>>>>> +@@ -23,6 +23,8 @@ allow brctl_t self:unix_stream_socket create_str=
eam_socket_perms;
>>>>> + allow brctl_t self:unix_dgram_socket create_socket_perms;
>>>>> + allow brctl_t self:tcp_socket create_socket_perms;
>>>>> +
>>>>> ++init_use_script_ptys(brctl_t)
>>>>> ++
>>>>> + kernel_request_load_module(brctl_t)
>>>>> + kernel_read_network_state(brctl_t)
>>>>> + kernel_read_sysctl(brctl_t)
>>>>> +--
>>>>> +2.25.1
>>>>> +
>>>>> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/reci=
pes-security/refpolicy/refpolicy_common.inc
>>>>> index 59dfecd..4af7f43 100644
>>>>> --- a/recipes-security/refpolicy/refpolicy_common.inc
>>>>> +++ b/recipes-security/refpolicy/refpolicy_common.inc
>>>>> @@ -72,6 +72,7 @@ SRC_URI +=3D " \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file:=
//0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file:=
//0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file:=
//0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0057-policy-modu=
les-admin-brctl-access-devpts.patch \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>>>>  =C2=A0=C2=A0 =C2=A0 S =3D "${UNPACKDIR}/refpolicy"
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>> Links: You receive all messages sent to this group.
>>>> View/Reply Online (#3147): https://lists.yoctoproject.org/g/yocto-pa=
tches/message/3147
>>>> Mute This Topic: https://lists.yoctoproject.org/mt/117539373/1024023=
8
>>>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>>>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14=
866895/10240238/1555622025/xyzzy [wei.deng@oss.qualcomm.com]
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>
>>>>

