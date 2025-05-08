Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54400C3ABC6
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 20:31:47 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.6203.1746736304831672529
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 May 2025 13:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=722352b05c=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548HqNM3028371;
	Thu, 8 May 2025 13:31:43 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3edr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C308un1Za6B5dzzKLuE2q4FB3dHfVruFEJ8vBt3Fw/VzAulFfH2E5HH9LBOfbR3oSe9+5asUS2fGvJLRcrvwdjQ8w3A3p9AE5zHnh4HmaR9M9grHexJCojy/RfOA3iIFlJTE4ikCh1DCI57W9itT3YE69kQp0QiSWaphk8fmpd5DWz6+HwKVTYJpcTLMT1S737dCYYM6rIWIavHWUnwNBRze4Khe40edXupBL5sIlicOXaZER4Curw1vFVylb8sAp+rLG0/d9FNayrwLLdd/u8VwSRudvtMUnZ7UCaGmGj6VBI2lseVySfZftkuyTHWCtTOi/LCfb5zy8p6ElT7/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp1hwQFJgVmcaAUE5Vt7JALtObxalpLXRnNswy1gzpU=;
 b=geq7D1VY0LuL67ldHSmcDcfjKjkNhkL7FnBsNEhtm6GbxJKnmykbV/VkBafZDzp80rvs75Aqhmor8lnyu923YGOFemrTxnpUd6rpsVHVHkskXiuaEGDupMRi3A1UNT1WhCYDdByhyHfLmYPJWLQqfUzXJcoY1vhd73o1/dhxhcGYLqimV8bOTaIx2ZRrAh6SZ1D4CQ5/6azHapasREZ6M0biRUWP5Eaq9pOPSnmwyKS9/4wBjKX15Q7Whip+GNXDLeuRih+cjUi9/S9OIYGNes5ZiqtUTsPLysJQ1Jep7cuGkBhTNFs8nqsMFBwcPbI1qE43hfirNKmtbxJoBhC2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 20:31:35 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 20:31:35 +0000
Content-Type: multipart/alternative;
 boundary="------------fvh8qAZ2Nhb1O4tmlyTzwR6M"
Message-ID: <2320673a-484e-4a3c-9f03-e829e2f5768e@windriver.com>
Date: Thu, 8 May 2025 16:31:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/38]
 Update to Rust 1.85.1
To: Scott Murray <scott.murray@konsulko.com>,
        "Sambu, Soumya" <Soumya.Sambu@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
References: <183B81D633F2878F.4763@lists.yoctoproject.org>
 <04e8df0e-167f-1a58-86fd-145924e3e526@konsulko.com>
 <CY8PR11MB79216B5AE80A363F1BDF9663818BA@CY8PR11MB7921.namprd11.prod.outlook.com>
 <9d7b5b76-2368-a7f0-58be-e32e890d32ee@konsulko.com>
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <9d7b5b76-2368-a7f0-58be-e32e890d32ee@konsulko.com>
X-ClientProxiedBy: CYXPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:930:cf::20) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 35903aa5-ea9e-4438-b7ec-08dd8e6f53ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0FkQjZMQy82TjAyd0FmZGxPbllrUUNFcUhhQndFYkh0QmlKTHA1ancyQmZJ?=
 =?utf-8?B?d280SHdXNDZSTEtXWk9PZGZxa0xLUzFsd0ZVdSs2T0xFS05NRll0bGpmVTZw?=
 =?utf-8?B?SkhUc2s4bXJVMFRaMlZremY2SnFKNjhEdGJyU0lpZURWOGNENm1YemkvaGZt?=
 =?utf-8?B?QjROMlNBczJIb1FrODkyVVhXTGV4VWx4SUJUbWpGMTluaGR2SVBvQ3U0UXdH?=
 =?utf-8?B?UXd4cXErckdMVEpuRjBMN3NDaDdWeHVZc3A0S2k5T1B6MTBjUkZDejBzSGFO?=
 =?utf-8?B?WHNjZGlkU2VLTzExdzZPSjM2U0ZsOFREQnVBZ2dBbC8wR0JNS0p2Yit6WWxn?=
 =?utf-8?B?Tko2MzVmcTR0UVZtSEpnaEpVRXhJRzZ4QUQvVmhUMzdJMXpuaXh5MnB2cWM1?=
 =?utf-8?B?UGdRUEhhdzErSEczdnFDOWlKQXJ2bjA1SnNXZkJ0RytqaURURTBka2JKYk50?=
 =?utf-8?B?MGpzTGF6UmNmbmQ0c2ZzODNLZTNDc3NPRlpyT251Q0NKTHlkcW1DbUIzd1pi?=
 =?utf-8?B?eWVsTisxOG1zcnlCWU5TaDZPaFE5MTNBLzhpVzA4MkpNNkx5TmhFcjhZOTNy?=
 =?utf-8?B?TlpSNUhVbmlpa2tNc3F4MDZ3Q3pXMlZIR0pnN0J5ZG1LV2VWL0JyaEZJWGhV?=
 =?utf-8?B?T0E3UUJ6Sk1GSlBTK3lxTkNJcGZMaTBHaG50cWVSOGNiaStGaExPdS8rY3ky?=
 =?utf-8?B?V09kTzlqeTh4WkR3UXEycTFTNEJxT3V2amNhb0M3bjFadEdVeUxHV1E2bDUr?=
 =?utf-8?B?ekRpcVk0RjZzeXYvTmFPSFQwUldYaXZ5cWNvTmpUU1Z0VFFJdEZOS3dqTURM?=
 =?utf-8?B?QTA4OGkzOUd6SDRQbTBYeUZaZUJCRHB2NTBTREhDUXIvTDRONEdseFJWVnp3?=
 =?utf-8?B?UlVkT01hUFNWU3VsZTFPbHF3QmxjMUhsVUoxeHhmZVFwS0ZtakFnMFR5OTJ4?=
 =?utf-8?B?R3NjZ1BiR1FNUjN1NlBNQldUVitwQms3UmRzNTJUTE43ajhGaG05T3BoRlV5?=
 =?utf-8?B?Q1kvR2hEdlNWdWxkZ3FTSXpzMjFDVW5nWXduQlY2eXY5OVl2THBCc1hwUWMz?=
 =?utf-8?B?Q1dDbVM0M1ltMWhNdHZZMk42NStvS0liWjVBRnRvaVNhNi9iNlBiQ05Vdysw?=
 =?utf-8?B?dVd5eXU1ZmRkTnYxdW1MNDNwUVFzWTJ0cFhHL3BPYm1vbGNyYlN5Uyt5OS9I?=
 =?utf-8?B?TjJuNkhublVWT3oxOVp5cUJvTXJOc3BZOTREUlZVQXNrODdQeEYzdVZ0dUVY?=
 =?utf-8?B?VENFTHYxMjhUUERwVXpVbGdRK28xY3RVOVNzTzlTbFFIRVNEYi9nVmNBNTFN?=
 =?utf-8?B?aTBGcE1iM1dKTkJSMENpUW0vNlcyNDBXU01kYk1zQjdtMWNsZU5NaXhUV3ln?=
 =?utf-8?B?UVduNlRDcng2K3ErRFdXNkduNEFSeE50emdsdkRLeDRZdTVwT0ZvTHNQS2Qy?=
 =?utf-8?B?T2RHd1FoTmJpYzZiZkF3RFpVMmxZaVVIS3kyUGx5YURQZ25HdldnR3VUYjFM?=
 =?utf-8?B?Z0pRTktrbjdDMitYZWY4UVZTWGRBWVY1Yk53cTM3ekQ4Y1N6MUxLcm00Um9S?=
 =?utf-8?B?eGU1V1pabmpJK1lPR1FhdFhVOGF2dTdWWkNqWGdZVlp2ejIxWjJaNDh2L0U0?=
 =?utf-8?B?MTIzblI0aFpaRkl0WjVVaFkveGVsRE5sMUxXYytBWWw5dUlVNHdDSktmTnZl?=
 =?utf-8?B?cEFKa2twaUh5MmdLcldpQ3N6bDJrcnE2NFc2LzBlYTByWGxXTUF2WjdsWnI2?=
 =?utf-8?B?eGZtZERNZ0dRTEdiblpoU0o2amtWOUw3OCtleXpEcE9jVk9aU0tUc0UrMFdX?=
 =?utf-8?B?MVE5WU1ZcGhPYS9GNU8xSE8yN2xCTjBIM1VpaFhQWUtUK2FzSHY0T1BRbXZJ?=
 =?utf-8?Q?6GsqnBjD23sJJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vm9xYmhGNmpVbkgxeFk0R0RUdGlSemhQbkMxaXB2ckx6WGg3bEo0eG9uT2dB?=
 =?utf-8?B?RGh0bGdHWlY2c3BydlZoWlFxVnB4azJET1VIVHRHTmw1dW5HRGwvVzJuU2ZO?=
 =?utf-8?B?WEpIeHNTd2U4bTNOVWhtVnpBSHJOM2FEYzkyZmszMUJucFdrdnI0QVhrcVBw?=
 =?utf-8?B?TGQrRWNVR210SDRnR3haWHJZMWhPV0JGenA2bllFQWZiRDVDbDZIbzk0ZXRu?=
 =?utf-8?B?dFplYWMzSUZRUktrR0JhUTFlRmp2NnVpdHJZYXN6b1pEbGNJSXliajhCd2I2?=
 =?utf-8?B?dkptZmd0YkFLOVJCcTdNaU84SzVqMGJ1RzJGWURkVGY0dWRSTDVnemxSUTdw?=
 =?utf-8?B?dlFjQWNOcUpmWnBlOEd3SmozMGZ4V0pkbmJaViszRmV4cDJpcERLNUpGNWtG?=
 =?utf-8?B?YzF1NHVjUWt6VW9HMk03clc3b3NnSUtQSEhjdXpsK3c1c1pjNzE2NXM0VHdT?=
 =?utf-8?B?Wk5DUEs5SHVkMGsydUtxSFVhY21BbVhTME81bEswSXZnTlhqTlZHUUNtVlRk?=
 =?utf-8?B?TVBLSFAwOHBmOEY0ZXZNT3h5NFJSa3d4aWsxN2FCQU4vSkViRy9IajVlRWVC?=
 =?utf-8?B?b2h1NnJTRXZHb3QzajZCNkZISENVeWhoTExhbTlUQ3lmRSt4RDhXeHNaTDNa?=
 =?utf-8?B?NGFTU2RrNjZ1eXJKK01FZGU0N2YxK0lJRmYzbXBtN3JZTWo5WlBmdm1iRUwz?=
 =?utf-8?B?SFNtK21tbWV0UDFJWWs1R3AyMkJGNWlxbFVkWVlrSHlBejZTVTlzcng0RVly?=
 =?utf-8?B?OGpBajlDVW9uc01RUWlIWjQzMEZMazliSUp3amk3WDhGamlweGFkcklLSDl1?=
 =?utf-8?B?eGZNWnR6eVh4WUtkV2c2eFVEZUpIa1U4YTQ2UnAvU1Rob3BndmN6OVB4SmRX?=
 =?utf-8?B?emZ3Qkk3bDNESzNXbkFRYWVEUGtrczBVVkdDTFBuRFZFTHNrR0NuOHYxd3Jn?=
 =?utf-8?B?bEJjeFBZbmxFL0lwUWFhdkd5dlo3dGIzd2tINTgrUitxLzBzVnpKdzV6S0dX?=
 =?utf-8?B?V1RETC9JdGxxRnZtUU1Db1N5LzViYWJMbmFObXZKV0Fva2RKZ0xRSTRKUG9r?=
 =?utf-8?B?WHpsQ1lWTUllM01zTUdyWlFURS9HZFhjb0Y0bi9jYkJ5eTFNSzBldURLVTJO?=
 =?utf-8?B?UGh3c1ZyZm15MkVkVEJWa1orNzNHS0NQMnA2WGNMUmN6L0RJem1la01FaW5x?=
 =?utf-8?B?QkZncjBaejNFd3BSRm0wUy90bjFXV054MEwvUmJVbkE0TXEwdDhsSDAwVmlt?=
 =?utf-8?B?Z28rRXQ2YTIxMmkxQWZGaFYrZ0txYW00SFpSNU9iZFZrS2VKSnVOeU9wbE40?=
 =?utf-8?B?bHJSZ0NZeDRPemZVc1RBV282MTB1dlYzVXhUL2ZUb1pva3dkWG1OWXR0THQ5?=
 =?utf-8?B?bjFWeFhoMWVmMU90azB3MnVRZ0x0WTl2VEoxV3ZWbzhxdmJ1YkFJdTlidkhJ?=
 =?utf-8?B?UUdweGt4SnEvUEc2THRaYzNhaFRQYnViVWtaMmswVEZTZjJ5YndkTTNMb2Fo?=
 =?utf-8?B?S0JmU0tBMjRNcWI3TmpFbVhKVjBFY3U0NGExenU2TDNySHpvb1NZeTg1Sy96?=
 =?utf-8?B?bnhpS3AxMnkveldsOWxZbUtsaVVaR3BnWjlzeFhRYzRQdGRZUnI4L05LTXZ1?=
 =?utf-8?B?RG50KytzUEJoS3Y4OEVsVW5aWEtnSHAzT1Y1cVY4VTlQQmNPMFRMakd1eFpX?=
 =?utf-8?B?amVCWmVUK0VBZHF4OEhic2Uwakt5MlQ3eGwrTVFHK1U5RTNNc1dXK1FHTHlT?=
 =?utf-8?B?QUl3UEpaYk50QTY2c1ExSkpHMW1Nejg4Q0FVRzB3ZTRpVzJubHQ0bDdBSWtI?=
 =?utf-8?B?aVBTL2FhL2NnMUxab2xoOFFMUUpsamUwTVNodjFZYlR6bGpXTlJxNU1kZExv?=
 =?utf-8?B?NmZVWkpPNy80UXJnbnAwSWtmOUJRNzdHWFdjc3R0SVQxUnA0NW1jby9MSlUz?=
 =?utf-8?B?aVhsc3k3VTZPWDF0VjI3REJTT3VLZXA5dHY0UFlJdnNTVm1MdTBPNkZJWkVF?=
 =?utf-8?B?ZFMrOU5SbHg2bnpPcis1VlBLQWRjanhjaVZrak14a0VIR3hOTFVURTR3WTlI?=
 =?utf-8?B?Nk9Ec2VKNTA2clZCdTdzQlByQll1bXhIdzd2eHVzM1ZjeXNjUFdYSGtvcHhC?=
 =?utf-8?B?OFJvUExEV3p0WHlGUTVHdVJOMUtwOGJvd0tTM2dpblAxdGJGbGg2d2JOSlA1?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35903aa5-ea9e-4438-b7ec-08dd8e6f53ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 20:31:35.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQEjQZDR81ZKkP3jHAe3BDsLy7IOrJVL+W2lG+37I3BGnlhbMMeuLDPE9suGpebueqOS2yqrG0GkH4DDSU+fxwFfJsdWZ+ZMSytx4FD12X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-Proofpoint-ORIG-GUID: STm8_3kcPHXSu62t6F7JjpBk575GncmC
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681d14af cx=c_pps a=H8RDR50mQ1szzU+C1Tr1+Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=mpEiYSQADiU0Ad_6--IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=k-42gJp3AAAA:8 a=pQu5dcfPDUbQo5YaeOEA:9 a=wiH8hiSc_PDg733d:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: STm8_3kcPHXSu62t6F7JjpBk575GncmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE4NCBTYWx0ZWRfX8q1tQO2k1S+3 fjAE4bnqURHTCtRhe84BRJo3HU+/D9BZxSPaLyMIwubtopqA/if7byFqOmchMv0KR1EJH+8cAbu Z2iIE/G5jG+dvwaQWxjVgOBumGBEfW+wmiAOZsXZRGpZeTZF3YmKJtbN48FHK3CSN7XI9VY+7mo
 auXM7UaApFpiqqf4byZsapj8fiSTHt0ssU4lRT0mnjLZo5W2Y6l4Tvawm0m0z9o9UJD/TPz2mf3 ChapEryfD9R7G7G1LHwdaLwYGEIWaCTQ5DnVXzSpnX1cB5SdV35Xd7ml24q3IHx8OjxaRMn6UPS qHegKq8bCJAy/hQPxwADLwSSSIV8dT96Scv8k4JgK7wpIv0bFmXlT63727D0BzickmhKp0CjP5j
 auyosLhEEDGDPcYRoVTDLDDAecUC2ft46l/LnlLZZQAp28LVBivT+8QzOqJmV3ZjwpiKbQsT
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_06,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080184
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 20:31:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1540

--------------fvh8qAZ2Nhb1O4tmlyTzwR6M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 548HqNM3028371

On 2025-05-08 3:51 p.m., Scott Murray wrote:
> On Thu, 8 May 2025, Sambu, Soumya wrote:
>
>> Hi Scott,
>>
>> I have observed the following build failures which appear to be caused=
 by the commit<https://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dk=
irkstone/rust&id=3D5b33fe5072c224b9f644272175ff4e3ea73166f9> - "Backport =
newer Python setuptools-rust and setuptools":
> I'm curious how widely you tested, i.e. is this all that came out of a
> world build?
>
>>    1.
>> systemtap do_configure failure:
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: QA Issue: This autoconf log=
 indicates errors, it looked at host include and/or library paths while d=
etermining system capabilities.
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82Rerun configure task after fixing =
this. [configure-unsafe]
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82NOTE: Checking configure output fo=
r unrecognised options ERROR: Fatal QA errors were found, failing task.
>>    2.
>> python3-grpcio do_compile failure:
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82distutils.errors.CompileError: com=
mand '.../x86_64-poky-linux-gcc' failed with exit code 1
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82...
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82cc1plus: warning: include location=
 "/usr/include/..." is unsafe for cross-compilation [-Wpoison-system-dire=
ctories]
>>    3.
>> python3-strict-rfc3339 do_compile failure:
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82error: invalid command 'bdist_whee=
l'
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: 'python3 setup.py bdist_whe=
el ' execution failed.
>>    4.
>> python3-cson do_compile failure:
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82File ".../site-packages/setuptools=
/dist.py", line 350, in _normalize_version
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82normalized =3D str(Version(version=
))
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82File ".../packaging/version.py", l=
ine 198, in __init__
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82raise InvalidVersion(f"Invalid ver=
sion: '{version}'")
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82setuptools.extern.packaging.versio=
n.InvalidVersion: Invalid version: 'b'1.0.9-16-gf3f2898''
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: 'python3 setup.py bdist_whe=
el ' execution failed.
>>
>> Regards,
>> Soumya
> I'm not sure what you'd like me to do here.  A lot of things depend on
> python3-cryptography, so it's not like I can revert the change and leav=
e
> it broken.  I could go back and make another attempt to hack the
> kirkstone setuptools-rust to try to make it work for python3-cryptograp=
hy
> and pray I don't break someone's downstream usecase.  There's enough
> entangled change history in setuptools-rust that that did not look like=
 a
> great idea the first time, hence backporting a known to work, widely
> tested version.  I'm willing to look at making systemtap build, since
> it's in oe-core, but jumping through hoops for everything in meta-pytho=
n
> is not something I can commit to.
Sure.
>   I would take patches for the
> dynamic-layers to fix them, or backports of their scarthgap branch
> version if that's what it'd take...


Great, that's our plan.

I had asked Soumya to let you know what we found out.
Stay tuned...


../Randy


>
> Scott
>
>
>> ________________________________
>> From:yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctopr=
oject.org> on behalf of Scott Murray via lists.yoctoproject.org<scott.mur=
ray=3Dkonsulko.com@lists.yoctoproject.org>
>> Sent: Tuesday, May 6, 2025 12:05 AM
>> To:yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org>
>> Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 0=
0/38] Update to Rust 1.85.1
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender=
 and know the content is safe.
>>
>> On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:
>>
>>> After more of a delay than I would like, here is the patch series to
>>> backport the various Rust toolchain changes for the 1.81.0 -> 1.85.1
>>> updates that have landed in oe-core master branch in the last several
>>> months.
>>>
>>> The likely most impactful change for users is that in order to fix be=
ing
>>> able to build python3-cryptography with Rust >=3D 1.83, I have had to
>>> backport newer versions of python3-setuptools-rust, and more importan=
tly,
>>> python3-setuptools.  Extracting the required fixes in setuptools-rust
>>> seems potentially possible, but untangling the change history in it g=
ot
>>> to the point where I lost confidence in not accidentally breaking som=
e
>>> behavior relied upon by downstream users.  As such, using the tested
>>> version from scarthgap branch seems a better solution for now.
>>> That said, if you are a heavy Python module user, there may be some
>>> potential for breakage due to the unexpected setuptools upgrade.  I h=
ave
>>> not seen issues in my testing with oe-core recipes, but have not yet =
tried
>>> a world build of all of meta-python.
>>>
>>> I have also included a README.me update to document my requirements /
>>> guidelines for submissions of bbappends in dynamic layers.  They are
>>> for the most part what I posted a few weeks back.
>>>
>>> I intend to push this series to kirkstone/rust in about 48 hours
>>> unless a serious showstopper is pointed out.
>> Sorry for the delay, I have now pushed this to kirkstone/rust, along w=
ith
>> backporting these handful of newer commits to catch up:
>>
>> 83ce817 rust: Fix build with GCC-15 on aarch64/musl
>> aad06c9 ptest-cargo: fix incorrect FAIL count when multiple tests are =
run
>> 98dd739 ptest-cargo: refactor run-ptest generation to remove redundanc=
y
>> 398374c ptest-cargo: handle packageconfig arguments
>>
>> Hopefully this addresses the ptest-cargo issue that Peter Marko pointe=
d
>> out.  Please let me know if you see any issues.
>>
>> Scott
>>
>>> Changes:
>>>
>>> Alexander Kanavin (1):
>>>    rust: restore parallel builds, disable lto only for rustdoc
>>>
>>> Deepesh Varatharajan (13):
>>>    rust: Upgrade 1.81.0->1.82.0
>>>    rust: oe-selftest issue fix with v1.82
>>>    rust: Oe-selftest changes for rust v1.82.0
>>>    rust: Upgrade 1.82.0->1.83.0
>>>    rust: Fix build break because of download-ci-llvm
>>>    rust: Oe-selftest changes for rust v1.83.0
>>>    rust: Fix bloat issue in recent rust updates
>>>    rust: Fix build break because of "download-rustc" and "llvm-tools"
>>>    rust: Upgrade 1.83.0->1.84.1
>>>    rust: Fix build failure when multilibs are enabled
>>>    rust: Oe-selftest changes for rust v1.84.1
>>>    rust: re-enable the unit tests that are ignored
>>>    rust: re-enable the unit tests that are ignored
>>>
>>> Enrico Scholz (1):
>>>    cargo_common: use 'config.toml' instead of plain 'config'
>>>
>>> Harish Sadineni (2):
>>>    rust: fix for rust multilib sdk configuration
>>>    rust: remove redundant cargo config file
>>>
>>> Igor Opaniuk (1):
>>>    rust/README-rust.md: fix markdown style issues
>>>
>>> Jean-Pierre Geslin (1):
>>>    cargo: pass PACKAGECONFIG_CONFARGS to cargo build
>>>
>>> Khem Raj (3):
>>>    rust-llvm: Fix build break found with clang
>>>    rust-llvm: Disable benchmarks by cmake options
>>>    cargo-c,rust: Fix build on risv32
>>>
>>> Martin Jansa (1):
>>>    cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
>>>
>>> Pedro Ferreira (1):
>>>    rust-common.bbclass: soft assignment for RUSTLIB path
>>>
>>> Peter Kjellerstedt (1):
>>>    libstd-rs: Correct the license to use Unicode-3.0
>>>
>>> Richard Purdie (5):
>>>    meta/meta-selftest: Fix variable assignment whitespace
>>>    recipes: Drop ld-is-gold support
>>>    rust-source: Fix remove_gcc_directory
>>>    rust-llvm: Compile llvm to use dynamic libraries
>>>    rust-llvm: Disable libedit
>>>
>>> Scott Murray (3):
>>>    Add selftest backport to ease maintenance
>>>    Backport newer Python setuptools-rust and setuptools
>>>    Update README.md wrt dynamic layer submissions
>>>
>>> Sean Nyekjaer (1):
>>>    rust-cross-canadian: set CC_<triple> for nativesdk
>>>
>>> Yash Shinde (3):
>>>    rust: Update "do_update_snapshot" task for rust-snapshot.inc
>>>    rust: Upgrade 1.84.1->1.85.0
>>>    rust: Upgrade 1.85.0->1.85.1
>>>
>>> Yoann Congal (1):
>>>    cargo-c: Update patch Upstream-Status
>>>
>>>   README.md                                     |  49 ++-
>>>   classes/cargo.bbclass                         |   6 +-
>>>   classes/cargo_common.bbclass                  |  20 +-
>>>   classes/rust-common.bbclass                   |   2 +-
>>>   classes/rust-target-config.bbclass            |   5 +
>>>   classes/rust.bbclass                          |   8 +-
>>>   conf/layer.conf                               |   8 +-
>>>   files/common-licenses/Unicode-3.0             |  39 +++
>>>   lib/oeqa/selftest/cases/rust_mixin.py         | 134 ++++++++
>>>   meta/lib/oeqa/selftest/cases/rust.py          |  85 -----
>>>   .../packagegroup-rust-cross-canadian.bb       |   2 +-
>>>   .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
>>>   .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
>>>   ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
>>>   ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
>>>   .../python3-setuptools/CVE-2024-6345.patch    | 312 +++++++++++++++=
+++
>>>   .../python/python3-setuptools_69.1.1.bb       |  58 ++++
>>>   recipes-devtools/rust/README-rust.md          |  24 +-
>>>   ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
>>>   .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
>>>   .../rust/{cargo_1.81.0.bb =3D> cargo_1.85.1.bb} |  13 +
>>>   ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++
>>>   ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 +++
>>>   .../Zdual-proc-macros-additional-check.patch  |  31 ++
>>>   ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 ++++-
>>>   ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++
>>>   .../rust/files/rust-oe-selftest.patch         | 279 +++++----------=
-
>>>   ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
>>>   .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ----
>>>   .../rust/files/rv32-rustix-libc-backend.patch |  33 --
>>>   .../rust/files/zlib-off64_t.patch             |  31 --
>>>   ...ibstd-rs_1.81.0.bb =3D> libstd-rs_1.85.1.bb} |  11 +-
>>>   recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
>>>   ....81.0.bb =3D> rust-cross-canadian_1.85.1.bb} |   0
>>>   .../0003-llvm-fix-include-benchmarks.patch    |  25 --
>>>   ...ust-llvm_1.81.0.bb =3D> rust-llvm_1.85.1.bb} |   8 +-
>>>   recipes-devtools/rust/rust-snapshot.inc       |  81 ++---
>>>   recipes-devtools/rust/rust-source.inc         |  10 +-
>>>   .../rust/{rust_1.81.0.bb =3D> rust_1.85.1.bb}   |  76 +++--
>>>   39 files changed, 1492 insertions(+), 619 deletions(-)
>>>   create mode 100644 files/common-licenses/Unicode-3.0
>>>   create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
>>>   delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py
>>>   create mode 100644 recipes-devtools/python/python3-setuptools-rust_=
1.9.0.bb
>>>   create mode 100644 recipes-devtools/python/python3-setuptools-scm_6=
.4.2.bbappend
>>>   create mode 100644 recipes-devtools/python/python3-setuptools/0001-=
_distutils-sysconfig.py-make-it-possible-to-substite.patch
>>>   create mode 100644 recipes-devtools/python/python3-setuptools/0001-=
conditionally-do-not-fetch-code-by-easy_install.patch
>>>   create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2=
024-6345.patch
>>>   create mode 100644 recipes-devtools/python/python3-setuptools_69.1.=
1.bb
>>>   create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-i=
octl-codes-on-riscv32gc-unknown-linux-g.patch
>>>   rename recipes-devtools/rust/{cargo_1.81.0.bb =3D> cargo_1.85.1.bb}=
 (87%)
>>>   create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioc=
tl-codes-on-riscv32gc-unknown-linux-g.patch
>>>   create mode 100644 recipes-devtools/rust/files/0001-src-core-build_=
steps-tool.rs-switch-off-lto-for-rust.patch
>>>   create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-ad=
ditional-check.patch
>>>   create mode 100644 recipes-devtools/rust/files/revert-link-std-stat=
ically-in-rustc_driver-feature.patch
>>>   delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-=
fix-cargo-config-for-codegenunits.patch
>>>   delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.=
38.28-fix.patch
>>>   delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-bac=
kend.patch
>>>   delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
>>>   rename recipes-devtools/rust/{libstd-rs_1.81.0.bb =3D> libstd-rs_1.=
85.1.bb} (76%)
>>>   rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb =3D> ru=
st-cross-canadian_1.85.1.bb} (100%)
>>>   delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-in=
clude-benchmarks.patch
>>>   rename recipes-devtools/rust/{rust-llvm_1.81.0.bb =3D> rust-llvm_1.=
85.1.bb} (94%)
>>>   rename recipes-devtools/rust/{rust_1.81.0.bb =3D> rust_1.85.1.bb} (=
81%)
>>>
>>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#1515):https://lists.yoctoproject.org/g/yocto-patch=
es/message/1515
>> Mute This Topic:https://lists.yoctoproject.org/mt/112569336/7320427
>> Group Owner:yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe:https://lists.yoctoproject.org/g/yocto-patches/leave/14043=
740/7320427/1891404428/xyzzy [soumya.sambu@windriver.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
> >


--=20
# Randy MacLeod
# Wind River Linux

--------------fvh8qAZ2Nhb1O4tmlyTzwR6M
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 548HqNM3028371

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2025-05-08 3:51 p.m., Scott Murray
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:9d7b5b76-2368-a7f0-58be-e32e890=
d32ee@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Thu, 8 May 2025, Sambu, S=
oumya wrote:

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Hi Scott,

I have observed the following build failures which appear to be caused by=
 the commit<a class=3D"moz-txt-link-rfc2396E" href=3D"https://git.yoctopr=
oject.org/meta-lts-mixins/commit/?h=3Dkirkstone/rust&amp;id=3D5b33fe5072c=
224b9f644272175ff4e3ea73166f9">&lt;https://git.yoctoproject.org/meta-lts-=
mixins/commit/?h=3Dkirkstone/rust&amp;id=3D5b33fe5072c224b9f644272175ff4e=
3ea73166f9&gt;</a> - &quot;Backport newer Python setuptools-rust and setu=
ptools&quot;:
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">I'm curious how widely you t=
ested, i.e. is this all that came out of a
world build?

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">  1.
systemtap do_configure failure:
=E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: QA Issue: This autoconf log in=
dicates errors, it looked at host include and/or library paths while dete=
rmining system capabilities.
=E2=80=82=E2=80=82=E2=80=82=E2=80=82Rerun configure task after fixing thi=
s. [configure-unsafe]
=E2=80=82=E2=80=82=E2=80=82=E2=80=82NOTE: Checking configure output for u=
nrecognised options ERROR: Fatal QA errors were found, failing task.
  2.
python3-grpcio do_compile failure:
=E2=80=82=E2=80=82=E2=80=82=E2=80=82distutils.errors.CompileError: comman=
d '.../x86_64-poky-linux-gcc' failed with exit code 1
=E2=80=82=E2=80=82=E2=80=82=E2=80=82...
=E2=80=82=E2=80=82=E2=80=82=E2=80=82cc1plus: warning: include location &q=
uot;/usr/include/...&quot; is unsafe for cross-compilation [-Wpoison-syst=
em-directories]
  3.
python3-strict-rfc3339 do_compile failure:
=E2=80=82=E2=80=82=E2=80=82=E2=80=82error: invalid command 'bdist_wheel'
=E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: 'python3 setup.py bdist_wheel =
' execution failed.
  4.
python3-cson do_compile failure:
=E2=80=82=E2=80=82=E2=80=82=E2=80=82File &quot;.../site-packages/setuptoo=
ls/dist.py&quot;, line 350, in _normalize_version
=E2=80=82=E2=80=82=E2=80=82=E2=80=82normalized =3D str(Version(version))
=E2=80=82=E2=80=82=E2=80=82=E2=80=82File &quot;.../packaging/version.py&q=
uot;, line 198, in __init__
=E2=80=82=E2=80=82=E2=80=82=E2=80=82raise InvalidVersion(f&quot;Invalid v=
ersion: '{version}'&quot;)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82setuptools.extern.packaging.version.I=
nvalidVersion: Invalid version: 'b'1.0.9-16-gf3f2898''
=E2=80=82=E2=80=82=E2=80=82=E2=80=82ERROR: 'python3 setup.py bdist_wheel =
' execution failed.

Regards,
Soumya
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">I'm not sure what you'd like=
 me to do here.  A lot of things depend on
python3-cryptography, so it's not like I can revert the change and leave
it broken.  I could go back and make another attempt to hack the
kirkstone setuptools-rust to try to make it work for python3-cryptography
and pray I don't break someone's downstream usecase.  There's enough
entangled change history in setuptools-rust that that did not look like a
great idea the first time, hence backporting a known to work, widely
tested version.  I'm willing to look at making systemtap build, since
it's in oe-core, but jumping through hoops for everything in meta-python
is not something I can commit to. </pre>
    </blockquote>
    Sure.<br>
    <blockquote type=3D"cite" cite=3D"mid:9d7b5b76-2368-a7f0-58be-e32e890=
d32ee@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre"> I would take patches for th=
e
dynamic-layers to fix them, or backports of their scarthgap branch
version if that's what it'd take...</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Great, that's our plan.</p>
    <p>I had asked Soumya to let you know what we found out.<br>
      Stay tuned...</p>
    <p><br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:9d7b5b76-2368-a7f0-58be-e32e890=
d32ee@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

Scott


</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">__________________________=
______
From: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yocto-patches@=
lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a> <a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:yocto-patches@lists.yoctoprojec=
t.org">&lt;yocto-patches@lists.yoctoproject.org&gt;</a> on behalf of Scot=
t Murray via lists.yoctoproject.org <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:scott.murray=3Dkonsulko.com@lists.yoctoproject.org">&lt;scot=
t.murray=3Dkonsulko.com@lists.yoctoproject.org&gt;</a>
Sent: Tuesday, May 6, 2025 12:05 AM
To: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yocto-patches@li=
sts.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a> <a class=3D=
"moz-txt-link-rfc2396E" href=3D"mailto:yocto-patches@lists.yoctoproject.o=
rg">&lt;yocto-patches@lists.yoctoproject.org&gt;</a>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/3=
8] Update to Rust 1.85.1

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">After more of a delay th=
an I would like, here is the patch series to
backport the various Rust toolchain changes for the 1.81.0 -&gt; 1.85.1
updates that have landed in oe-core master branch in the last several
months.

The likely most impactful change for users is that in order to fix being
able to build python3-cryptography with Rust &gt;=3D 1.83, I have had to
backport newer versions of python3-setuptools-rust, and more importantly,
python3-setuptools.  Extracting the required fixes in setuptools-rust
seems potentially possible, but untangling the change history in it got
to the point where I lost confidence in not accidentally breaking some
behavior relied upon by downstream users.  As such, using the tested
version from scarthgap branch seems a better solution for now.
That said, if you are a heavy Python module user, there may be some
potential for breakage due to the unexpected setuptools upgrade.  I have
not seen issues in my testing with oe-core recipes, but have not yet trie=
d
a world build of all of meta-python.

I have also included a README.me update to document my requirements /
guidelines for submissions of bbappends in dynamic layers.  They are
for the most part what I posted a few weeks back.

I intend to push this series to kirkstone/rust in about 48 hours
unless a serious showstopper is pointed out.
</pre>
        </blockquote>
        <pre wrap=3D"" class=3D"moz-quote-pre">Sorry for the delay, I hav=
e now pushed this to kirkstone/rust, along with
backporting these handful of newer commits to catch up:

83ce817 rust: Fix build with GCC-15 on aarch64/musl
aad06c9 ptest-cargo: fix incorrect FAIL count when multiple tests are run
98dd739 ptest-cargo: refactor run-ptest generation to remove redundancy
398374c ptest-cargo: handle packageconfig arguments

Hopefully this addresses the ptest-cargo issue that Peter Marko pointed
out.  Please let me know if you see any issues.

Scott

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">Changes:

Alexander Kanavin (1):
  rust: restore parallel builds, disable lto only for rustdoc

Deepesh Varatharajan (13):
  rust: Upgrade 1.81.0-&gt;1.82.0
  rust: oe-selftest issue fix with v1.82
  rust: Oe-selftest changes for rust v1.82.0
  rust: Upgrade 1.82.0-&gt;1.83.0
  rust: Fix build break because of download-ci-llvm
  rust: Oe-selftest changes for rust v1.83.0
  rust: Fix bloat issue in recent rust updates
  rust: Fix build break because of &quot;download-rustc&quot; and &quot;l=
lvm-tools&quot;
  rust: Upgrade 1.83.0-&gt;1.84.1
  rust: Fix build failure when multilibs are enabled
  rust: Oe-selftest changes for rust v1.84.1
  rust: re-enable the unit tests that are ignored
  rust: re-enable the unit tests that are ignored

Enrico Scholz (1):
  cargo_common: use 'config.toml' instead of plain 'config'

Harish Sadineni (2):
  rust: fix for rust multilib sdk configuration
  rust: remove redundant cargo config file

Igor Opaniuk (1):
  rust/README-rust.md: fix markdown style issues

Jean-Pierre Geslin (1):
  cargo: pass PACKAGECONFIG_CONFARGS to cargo build

Khem Raj (3):
  rust-llvm: Fix build break found with clang
  rust-llvm: Disable benchmarks by cmake options
  cargo-c,rust: Fix build on risv32

Martin Jansa (1):
  cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote

Pedro Ferreira (1):
  rust-common.bbclass: soft assignment for RUSTLIB path

Peter Kjellerstedt (1):
  libstd-rs: Correct the license to use Unicode-3.0

Richard Purdie (5):
  meta/meta-selftest: Fix variable assignment whitespace
  recipes: Drop ld-is-gold support
  rust-source: Fix remove_gcc_directory
  rust-llvm: Compile llvm to use dynamic libraries
  rust-llvm: Disable libedit

Scott Murray (3):
  Add selftest backport to ease maintenance
  Backport newer Python setuptools-rust and setuptools
  Update README.md wrt dynamic layer submissions

Sean Nyekjaer (1):
  rust-cross-canadian: set CC_&lt;triple&gt; for nativesdk

Yash Shinde (3):
  rust: Update &quot;do_update_snapshot&quot; task for rust-snapshot.inc
  rust: Upgrade 1.84.1-&gt;1.85.0
  rust: Upgrade 1.85.0-&gt;1.85.1

Yoann Congal (1):
  cargo-c: Update patch Upstream-Status

 README.md                                     |  49 ++-
 classes/cargo.bbclass                         |   6 +-
 classes/cargo_common.bbclass                  |  20 +-
 classes/rust-common.bbclass                   |   2 +-
 classes/rust-target-config.bbclass            |   5 +
 classes/rust.bbclass                          |   8 +-
 conf/layer.conf                               |   8 +-
 files/common-licenses/Unicode-3.0             |  39 +++
 lib/oeqa/selftest/cases/rust_mixin.py         | 134 ++++++++
 meta/lib/oeqa/selftest/cases/rust.py          |  85 -----
 .../packagegroup-rust-cross-canadian.bb       |   2 +-
 .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
 .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
 ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
 ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
 .../python3-setuptools/CVE-2024-6345.patch    | 312 ++++++++++++++++++
 .../python/python3-setuptools_69.1.1.bb       |  58 ++++
 recipes-devtools/rust/README-rust.md          |  24 +-
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
 .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
 .../rust/{cargo_1.81.0.bb =3D&gt; cargo_1.85.1.bb} |  13 +
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 +++
 .../Zdual-proc-macros-additional-check.patch  |  31 ++
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 ++++-
 ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++
 .../rust/files/rust-oe-selftest.patch         | 279 +++++-----------
 ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
 .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ----
 .../rust/files/rv32-rustix-libc-backend.patch |  33 --
 .../rust/files/zlib-off64_t.patch             |  31 --
 ...ibstd-rs_1.81.0.bb =3D&gt; libstd-rs_1.85.1.bb} |  11 +-
 recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
 ....81.0.bb =3D&gt; rust-cross-canadian_1.85.1.bb} |   0
 .../0003-llvm-fix-include-benchmarks.patch    |  25 --
 ...ust-llvm_1.81.0.bb =3D&gt; rust-llvm_1.85.1.bb} |   8 +-
 recipes-devtools/rust/rust-snapshot.inc       |  81 ++---
 recipes-devtools/rust/rust-source.inc         |  10 +-
 .../rust/{rust_1.81.0.bb =3D&gt; rust_1.85.1.bb}   |  76 +++--
 39 files changed, 1492 insertions(+), 619 deletions(-)
 create mode 100644 files/common-licenses/Unicode-3.0
 create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
 delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py
 create mode 100644 recipes-devtools/python/python3-setuptools-rust_1.9.0=
.bb
 create mode 100644 recipes-devtools/python/python3-setuptools-scm_6.4.2.=
bbappend
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-_dist=
utils-sysconfig.py-make-it-possible-to-substite.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-condi=
tionally-do-not-fetch-code-by-easy_install.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2024-6=
345.patch
 create mode 100644 recipes-devtools/python/python3-setuptools_69.1.1.bb
 create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-=
codes-on-riscv32gc-unknown-linux-g.patch
 rename recipes-devtools/rust/{cargo_1.81.0.bb =3D&gt; cargo_1.85.1.bb} (=
87%)
 create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-co=
des-on-riscv32gc-unknown-linux-g.patch
 create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps=
-tool.rs-switch-off-lto-for-rust.patch
 create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additio=
nal-check.patch
 create mode 100644 recipes-devtools/rust/files/revert-link-std-staticall=
y-in-rustc_driver-feature.patch
 delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-c=
argo-config-for-codegenunits.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28=
-fix.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.=
patch
 delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
 rename recipes-devtools/rust/{libstd-rs_1.81.0.bb =3D&gt; libstd-rs_1.85=
.1.bb} (76%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb =3D&gt; rust=
-cross-canadian_1.85.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include=
-benchmarks.patch
 rename recipes-devtools/rust/{rust-llvm_1.81.0.bb =3D&gt; rust-llvm_1.85=
.1.bb} (94%)
 rename recipes-devtools/rust/{rust_1.81.0.bb =3D&gt; rust_1.85.1.bb} (81=
%)


</pre>
        </blockquote>
        <pre wrap=3D"" class=3D"moz-quote-pre">
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#1515): <a class=3D"moz-txt-link-freetext" href=3D"htt=
ps://lists.yoctoproject.org/g/yocto-patches/message/1515">https://lists.y=
octoproject.org/g/yocto-patches/message/1515</a>
Mute This Topic: <a class=3D"moz-txt-link-freetext" href=3D"https://lists=
.yoctoproject.org/mt/112569336/7320427">https://lists.yoctoproject.org/mt=
/112569336/7320427</a>
Group Owner: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yocto-p=
atches+owner@lists.yoctoproject.org">yocto-patches+owner@lists.yoctoproje=
ct.org</a>
Unsubscribe: <a class=3D"moz-txt-link-freetext" href=3D"https://lists.yoc=
toproject.org/g/yocto-patches/leave/14043740/7320427/1891404428/xyzzy">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/14043740/7320427/18914=
04428/xyzzy</a> [<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:sou=
mya.sambu@windriver.com">soumya.sambu@windriver.com</a>]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">&gt;</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------fvh8qAZ2Nhb1O4tmlyTzwR6M--

