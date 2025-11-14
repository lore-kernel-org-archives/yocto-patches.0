Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C629CDB46D
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 01:50:25 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8851.1763085023762177845
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 17:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=tA3f+/Ay;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3413bdfb6d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE1P240045911;
	Fri, 14 Nov 2025 01:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=PoVosWHiSVEF3G0ld7Yp5X5Qw6DMYCMXapgiOcbmRuA=; b=
	tA3f+/AyHxBn88Zod0Gno+Vf0U3Z7miYjIhl8lZ225uESPgd/Bb4xXBmPh+h//5A
	eo38jgYbfPy5KCifylg1a/n8LppSiFvzP+61TPHBGPLyynZIwT0UPBi9cFQlah6Y
	x5yQtj1bFZiKNDxLpeJwEOnTvqLC1jsZ/hNtzV3aU9nTc4pyrVX5Z85VQbujTCIX
	q8h4ZF9oKKKBZdXfoFb4IWsWcg7qOHYXkOsu6kIsiXX876ojTYsDYRDfgGWxLttS
	GwETETbFGQ2ymRddpio9PGqnpv/tkjDirK3k9e9FRsZUyBcnc8iwo4nACjXvlZ4W
	aB1UcooFcb4jJJNTGuG9OQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtr5g0m3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 01:50:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFKKa5RqZ6qoL5Ege1TwaUKyzy/f/UwXPdfejG5vYh9Unw/wVKo98lcObDkiSu1j63QlIyBWXGxRzJqPjsu+1YG35cEULaoxWRt+HpPp1KkRqHS0R5Azh9FzGXN2wo9uQI+ejzA7+CAMpeL68DrC6KlEnfaM0fA2A50bM9AcBgBqPTZ6PVX1mVUMr6aCjbFcyr+mw9hHqQ2k10SDnPcg8+RDByiVpmQQNNTYVKs9dxzuZfqjuJhTwWxwcOwWl55TumXBkBicVCL9yHaXNTdnyCkxNV2Dkp3aHBIGpj3XfGeDyX/XqW+UzpBvutKuH7nBb3iRf3VZY7dP2/wdhJZijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoVosWHiSVEF3G0ld7Yp5X5Qw6DMYCMXapgiOcbmRuA=;
 b=OvQ6l5mJc+faCWA03FwiddWrbXiXRR2/uHbyWDkw/UOH5IXVEj+YC3bdsX8ls5zrFLI0iwnySA3thLhrT6iXWS6Czlemkrs9a9yxVGW7DFb0/jDEbwdfCmXFb0zi9V+16ZpvbR+jiAO6T9+rbXE4zwM9djhXXFTKHFni75GEQ/1FSwimHC6/EJCSe7Jyx6QEnn7pX+iZabWhzvwjGOZknWRpNrLgiqAc/FP5gcB1q2uyj2APQ3cJl8qTTioYhwLHsuTwW6FvrFXP+HXlya3BaKRKz8h5CgPuGlW6VPjDm+MIqFDURSYh5NBC4BXhjfFtKmNHc5SNLGaamEmEAahNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 01:50:17 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 01:50:17 +0000
Message-ID: <0859aa52-03ac-4765-98e3-bab602196ba9@windriver.com>
Date: Fri, 14 Nov 2025 09:50:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 1/3] openscap: upgrade
 1.4.1 -> 1.4.2
To: Scott Murray <scott.murray@konsulko.com>
Cc: rybczynska@gmail.com,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <186D6728E3F9CC27.13356@lists.yoctoproject.org>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <186D6728E3F9CC27.13356@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 27719884-9f0c-4189-d35d-08de232028ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V2ZIVFg1R0hsbnNEN2VYKzBZbDVhMThXcS9uK0hyekFtQm9wTWt0UXZNRFh6?=
 =?utf-8?B?U05uczh3cFhnOXlFMHFUa2RVTlEwMmp4YytNYkVOYTd5NUNzUDh0bmQ0YzQr?=
 =?utf-8?B?cjNwWkE0MWc5RzVXdUVZYXpQRFlLOHZnMEZkT3ZkSGJNUDlCMWp0d2gzMXVS?=
 =?utf-8?B?RE5IRmljSkswZEdWRTU0WEJ1dG54NXQ2Z1ZRM1phSU9FNENlMytUdDdqU1g4?=
 =?utf-8?B?Vi8yeDNJNWpBcnFoNm9teEFPVUE5emJDdmhZclJ1TzBGTENJa1hGNnNIUngx?=
 =?utf-8?B?M090K0t6WjBrNGpNQzRKQ1JNL25QM0kyc01wbTVOU1ZlRGVpNDJnYVd6ZDFa?=
 =?utf-8?B?YXN6OVdJdGg4bDNKaUhOdS90UGFJN1RmSjA4YnlhcDVVb2NUWnBtZENsaFpq?=
 =?utf-8?B?UHdkV0E5UjIyVCs0TTBBSHc1Rjh0cmNCelprS01RUGpiUmRaSHNLTHNReE5s?=
 =?utf-8?B?c3J0cWJ6WFBMQVN6dFJBV0JwQzlITXlhZ1EyalRMUk1jSkJJc1MzcGVMMXl6?=
 =?utf-8?B?MVBBMi9GcVJicTN2b1pmK1JDNjcxTHhBZjZGd3pnbklRTk5Sb2hpc3pnZXZ2?=
 =?utf-8?B?RlZCVytFelJCL1NxZ3hxOHRZYnVvaU1Gb1ROWmtqb0lZQVBzZmx3TlkzaVlz?=
 =?utf-8?B?Q1ExOE5aMDdveURjOVlub0lHU1lGV0xrS2pQUEcwKzhUeHdEVWdBNXAxMmZK?=
 =?utf-8?B?NytxM3V1Yi92TGh2R0dvdElZZzlhUEhEUk9xZkhzUjRMaHcwWXBqMkZFaWV1?=
 =?utf-8?B?NXZoWkQ4Y3QveGdZaUsyOXc5djFudThodmovdFJ5NXdWbHFpV0N0ZmZncU0z?=
 =?utf-8?B?a2lwMnJ3QmJKR0xPRXZhVXJLc2Z1cVhzZG5ueHdOVjNHOHJIRVpVUWVDQ05N?=
 =?utf-8?B?RGhGYm5TVE5aRUdQckxVeVNoUWZVRWlzblVVc1FhdVlqWFBaM1RWTnlqUVpX?=
 =?utf-8?B?WVpreGFVTDNHejJDNFRGOGc5TzFPV2VSNWZDSGlkaWlUWjN5UmxIWGRHbGQ0?=
 =?utf-8?B?eVIvb1FUbG9kVXU1Y0JBOHIveW4vdy9sMXFyL3g2aWFTZmx1ZEhhMEJiWkFk?=
 =?utf-8?B?UnNXWm1idGVmRkZ3YkkrVTMxVFBvaEpSTHc2Qm5jYXhNdDZtbDg5RWFpUU9C?=
 =?utf-8?B?aUZrYW9YaWZHQzFyb3NmcFg5Wm9tRnRJUGVYWGU0UUY2TFZsSWZsSzZMbXB4?=
 =?utf-8?B?cHh1ZlpZYTZzNll0SmVpV3lKTVVhWFlOMllmTVFLL0hlRzJ5Zis2ckN2eERl?=
 =?utf-8?B?T2NzYzdXbUowQlFZMjhrNlpUTW9SSzZWSFg1QlVhVWF6WS93OStpZVR6Z3dv?=
 =?utf-8?B?MHZYS2ZLTW16bnp5MWJJTUdMeEVJSlJWZy85SENXcCt6Yjd0YWYzSW15WUxm?=
 =?utf-8?B?WUFnd1Vvd3lrc01ON2FkSmdwT0xxelJWV0xMc3lqWlJUZVNtbkgzaDNMMS9h?=
 =?utf-8?B?YTlEWFBGWEFWbHhSQit5c01iWXBJQUNVOG1LcG13YlUzaW5vd1dPdG4zcTFE?=
 =?utf-8?B?blBMVWZja3JyOFdYWUJBTjhyUXpWTUxNYkdaMi9WMmtNOHBoTFBMa3lOSngy?=
 =?utf-8?B?YmtML1pFZUtZNGhyQ3MzZE5GOXJtMjU3Z0gxcXQ5QzlIT1hUak03dHFsWDdO?=
 =?utf-8?B?bDJFTklNOVpFS3FLRjBVUU1jSldBcjJ2cUpyeks5cGpQRXlQbUxFaXVhWjli?=
 =?utf-8?B?MXc5aFdkZFBZSzV6SUwwWkNIbklJQVpGMnFzUlZTMk81MVMrTDRremkyN1lz?=
 =?utf-8?B?aHl0SkZzMS91RzFYZDhMc2NzdWFicWF6dXZYOXNGd3RORVZyZHFVSmljbVRK?=
 =?utf-8?B?OWZDbVdyNnh6RTZBcG9XQ0d1ZE0weGRxcXp0bGVqNXFuMHJLTG9obTBkTjlp?=
 =?utf-8?B?MmNpN3ZDWUNoNkRsZUFuc1BQNWlwcXpDVDlBbUpYNUZtYTFLV052dHp6K240?=
 =?utf-8?B?MlVOSkFQLzZldFRLUVVFK210Wms1WXBjMzhuQ0U4akgwODkxMHdGRjYwT2k2?=
 =?utf-8?B?MCtJditlNGF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2w5SC9zZkhlOTV6blBJS1dVK04rSUh5NEpoWU0wQlFzdXNZSkdmNGJjUHV6?=
 =?utf-8?B?LzBIY21ON3JaQkNqanJ4VWt3M1ZTdzlicm9WU1dxVVJ1RGJoSGVORkpLVnlq?=
 =?utf-8?B?M1doZEE2N3BwYkxJRGpSenZTcHVLaTEwNDJ0amJ5d05CbDVHd3Job0xWTkh2?=
 =?utf-8?B?bEhjdVZZbUc4ZmRNMThRYzNGSmp6L3FIYW5XQ0hjNHRvWSsvVVZzd1luZGhs?=
 =?utf-8?B?ZGtoZ1F5QVNGYmhJNVR6UkptS1hKbjVkaVV0K3BUVUFEK3dwS1I5WUNOcTFP?=
 =?utf-8?B?UC9JVUk0aGo5YmpMUnNuN3Q3TlJkK2V2ZkdQWEg3YW8rUDdlcE9rbllmbllZ?=
 =?utf-8?B?NFE0R3RLSVpkYmhwVkRiRDViZjlpd21OMkMzbnZVOUFMeDJJUnhTRVd1MkYr?=
 =?utf-8?B?Z1I4b2p2bUpqYlFGSEJIWVM3ZFRNdkk0ZzFTM0NLa2F6NkRHeFNQVWNBRzB2?=
 =?utf-8?B?YXI3N1RNWHNjTWV1cVJaUWtsb3EyRG5UQkdjVDNqNHVJUG9kVVJTVVZsbkFj?=
 =?utf-8?B?Uk5PVzNXTkQ3Q0o0eitIUEJ2NlZjak1ZOVF3d3VYL0NsUXRtcGRndnY3bVdO?=
 =?utf-8?B?UnBLSkkwdkpYVWZMMnBxQVJYZkRVMVR4T2I5RVJvNnRMUkFTTEZiQ3J2S0M5?=
 =?utf-8?B?czl4TWVldkw5cTJzUkRMbkpQSk0wZGZSVWl0UitPU2Rpdk9FU284SXlHQnNQ?=
 =?utf-8?B?cGtEdlptNVY0eUN0MGN2MGZjaTRlRzM5cG5lMGFIVFRGWlNOajIweU1BTTR0?=
 =?utf-8?B?MzJNL2pIMVVrNlZJRzkxZE5xZmdpT1UyQVdWL1ZyaStmUWpOS1ZXTWRXZk9R?=
 =?utf-8?B?WElVMUYyK3hFeTg0OHBzdHEwM3pybUwvQm55YjhBWDMvL0IzSk9NcG9rTGFZ?=
 =?utf-8?B?UWVNOGFMY2drbVZ5QXoyNmdHT1lFb095VEtVc2dXRFRXSEMzQko5T0JVVWVk?=
 =?utf-8?B?UG5mRE1UTGI5UzBobG5uWjNpT2MwMGZvZkUyN3BTVTVrcS9xM1lFVnR0ZDBF?=
 =?utf-8?B?K0xQQUdGOFYyd3BvQ041VW9NOFVvVjRIMllSWk9KVDhtTHpDMkt3eUdqWWd2?=
 =?utf-8?B?T3c5cmpCd2lBV1l5cm9UYTI0Mm5PeWY1WDhVRHdFUFpPa01VQ2lCeVQya0ZI?=
 =?utf-8?B?VjdhMWozdHRxZFE2TndMSUdFZlB3KzE2Yk15QnBIZktrWnVJOTVwMk9ZUE1k?=
 =?utf-8?B?bCtvUjFRZVBtU2dqMU1XZmRtbXUwMGNaSFhWb0sydWVmTFJBRVRGVXc0YmxP?=
 =?utf-8?B?d0I0QWo2TkxVVTlQckxzeThoK1d1UW1xOC8yOXJlU05nbEhScjloL0kzSTBl?=
 =?utf-8?B?SEFNeElxaUVGdWFVenQvTE9BVnV6bnM2bVpCWHhWY09RUWpMRElnSDE1WjFJ?=
 =?utf-8?B?WVBIRU9LMVkvdXB5ZjFWVkhQSXFUZ21xdlM2aExMSEJTKzRaTCtVSEo4a2Ex?=
 =?utf-8?B?a01oTWtYS0RZamluZzVzeFBvQmJDT3Q1VCtsWktWMll3VEUyOXlLRW1CaFNE?=
 =?utf-8?B?ME9HbWNqNTBYZ0dVY0F5UWZVYkc3WmlIWFdHbzlrZWI0VEdzR3dCdFA4bzRB?=
 =?utf-8?B?Q3N3eUdBK0tveGlwWlVUakFxQXNqaGMxNzJkK0hXMkNpZlBEQThLU0hCbHJh?=
 =?utf-8?B?SDdxd0dESHZta1UxVGREQmlickgrQ1dFQ2tjRDVVcUluek9JQmxTZUwvZzhx?=
 =?utf-8?B?dU5kY0syQnNYcXpEbktBSWJIWU9GSEx1ZUlKSHh3aVJvK2hOdXVuNktmL05n?=
 =?utf-8?B?VVBNeWRBOUFtcDNzUEhjMjltbHlwa3FOWjBISWd0YUpHcjEwRlVDK3lCVmNu?=
 =?utf-8?B?Z25CRENZSUZLZXl2d2NQbWhWaUxpRzVMZ0lJSzJBTlM3cGVZNTNvSTVmWmxr?=
 =?utf-8?B?VVlueThPSzhpdU05ak5JSm1MMGhwdGRYQ0VIMStuZHVYOXNsWHZXQld4ZWo5?=
 =?utf-8?B?SU9nZVhvV1ZaVmZHRjFNelRmYk1pbHBlYWRuYnN5MTBrV1JWc2Q0Z2Y4c2VU?=
 =?utf-8?B?b3JnVWVod29OWGZlMWh5ZUM5cW5YaVNuRkxmdm5maWhjbXBVSmJzdlFXeC9J?=
 =?utf-8?B?ZjJqRHZHNW15TWNPR3JxUVMzejg5Ni9mejlTbDhMTmZDSk5aRXZmemJ3UG5B?=
 =?utf-8?Q?EPptsa+3GfIN4W+g4InPJIAEX?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27719884-9f0c-4189-d35d-08de232028ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 01:50:17.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Yj49iu1cB7JJvEnYUEfhkM+JYlxIZNfqnmWuT8Z5p44n5BYSIqNF1amHTHB99Q1nqMtNniQeqrjdJuh1R77+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-Authority-Analysis: v=2.4 cv=KY/fcAYD c=1 sm=1 tr=0 ts=69168add cx=c_pps
 a=AyKazF/bLMNy1/nXoCkdcg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=_CYp1f5LEN6j961qsCwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VeISTaA6qc8kc8nx7vsV3cpLb2D5fDHM
X-Proofpoint-ORIG-GUID: VeISTaA6qc8kc8nx7vsV3cpLb2D5fDHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAxMiBTYWx0ZWRfX4RyITQGBuCzU
 LSKCQJS/jISmeXnsqjbRSnrTfwLXVZHcuSggDraFFYKxik+RCvXjoWXBTxgEvQk+uGNPawRsOVj
 p4gvHmReYXcePRSOHJoyPEidOFUALBPicTcB66k6/O799kPS9MPxl9B8ICvDEuz0ih157kAiowO
 b1V3z2yBjY3qAvcqcjKxD8vf90+xD+qNTHEtTqXKyW+CVL0bKscJoOTNJ270Oon5rtU0Wk+9mmS
 rE/VF/eBwX3w0u68RIJTYEmWvOuh//9QMxxHmcsSEcdfhatmhAWtlnrdli+7WqL8eWUnGy49zcc
 9kG7Jn/P6xkhhqPyxNDUO/lcbgakfe93ZI/28UTd/RRH3em6vcVIRUfEhVqJpFLdtyYlnsCZyrz
 feAVKgtp7YIY6+tOHjfjl9GCl3Dqqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140012
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AE1P240045911
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 01:50:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2551

Hi Scott,


These patches were sent a few weeks ago.=C2=A0 Can these be merged? Thank=
s.


//Yi

On 10/11/25 17:53, Yi Zhao via lists.yoctoproject.org wrote:
> ChangeLog:
> https://github.com/OpenSCAP/openscap/releases/tag/1.4.2
>
> Disable building on musl as scap-security-guide already does.
>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>   .../openscap/{openscap_1.4.1.bb =3D> openscap_1.4.2.bb}         | 4 +=
++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>   rename recipes-compliance/openscap/{openscap_1.4.1.bb =3D> openscap_1=
.4.2.bb} (97%)
>
> diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-co=
mpliance/openscap/openscap_1.4.2.bb
> similarity index 97%
> rename from recipes-compliance/openscap/openscap_1.4.1.bb
> rename to recipes-compliance/openscap/openscap_1.4.2.bb
> index 3e5f00a..f1eb647 100644
> --- a/recipes-compliance/openscap/openscap_1.4.1.bb
> +++ b/recipes-compliance/openscap/openscap_1.4.2.bb
> @@ -13,7 +13,9 @@ SRC_URI =3D "git://github.com/OpenSCAP/openscap.git;b=
ranch=3Dmain;protocol=3Dhttps \
>              file://0001-CMakeLists.txt-fix-installation-directory-for-=
system.patch \
>             "
>  =20
> -SRCREV =3D "23a8ea3de3c4fd6017db4067675a81287177166e"
> +SRCREV =3D "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
> +
> +COMPATIBLE_HOST:libc-musl =3D "null"
>  =20
>   inherit cmake pkgconfig python3native python3targetconfig perlnative =
systemd
>  =20

