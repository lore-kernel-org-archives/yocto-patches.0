Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B371BD3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:31:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39996.1766997105341705808
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 00:31:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ooiu8MB+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5458d64c08=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT7kiAQ3870423;
	Mon, 29 Dec 2025 08:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=uXEqTtauQH9y7lQCF+8UmvJmLpBeH5I6NZWWSp5JDRI=; b=ooiu8MB+SUkN
	GSCGMA+bu9EMwoz4ftshJHmUW2JJV4HPBUN1T3NzqklUjmTjHKhvrngB+8mmuMsZ
	Fc99UN5H3xdb5bmzq5Vo+Ni9RdNe5XdZ9x5XnrAaxnAffn8ZTKTOD1MHgryduX8S
	NA24tX/aiCQZzSA4CsIviCMUqmu/IBQ+wdo1i1mGFBwWefkaciMqhM536ep3nagJ
	Dlxl8w3sa61pzmUWWBhQg0e61v/VRBvczOe5Mhz4uHA5yUapOFs6sbJvywT/4UlS
	K+a+9XJM7otvyHLH7A8T0orVdARTQLx3QqbDmclSKl1+3beHoZGjM+g3qVFagata
	BMOkxRa/QA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ba4nxsjf3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 08:31:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga6DNUeWL+zO/fk5Jt1wj8DDrLQCwyRO9Y6l8jhdnjaP8q86/FHoazeqqjhmgjAIPAsl1c/TTdMgjpErpWpjCKg86MIDKmfZHyT61ol7zE40NVpMiLNWDxixZT7WPZrDAKf4OCjLvxtKA2O8Kqfb5zayrKyh7Xw0pBcmSS8qU4y8d9Y3AYg/fxJpNtDnvTISm1QxTMCWAcXEeT68h8YXFKtEYIf4xX+mNPQ0R8KlbqEKEiNmRc2d7gYRJUS8O+pJaTRoS0xeSvR4RjeMDPb+enwPY0av//k9CbR9e8VVi/Hi1Og/Etq0JPDaHaywAI7L2CFlKOW6VFpNx4Tb1fl2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXEqTtauQH9y7lQCF+8UmvJmLpBeH5I6NZWWSp5JDRI=;
 b=dm0/oIfpufn3Dd/o5WkRN5nw+njLateIb16xFbRaAXyq5YE8KAAok+SZY8E4ucHccXIIv2q3Ikk7jnjQh9256SyDBcYRiJvIwdXCZk3GGHJ9EOYewS2XzCuvJyNBIcoRppTwwOz7ITuVd99qq6+XfsuOySXwyrsXKD2PEGLr4L70NueAM8Uh6oJzAhK2OjPhXiYT8DqcE9xERT526/Gnv22fQ5tHYuob3YhqUaq3Rt7xpjr9/12SIppFBlIfaKC1bYCYNYU0QiLB3/y2V/0Wir2SadPqlRygdd/cytASYwzykebxzm+jpeDVAZ7DpogBg4ZMlAa1grYKFTMXi+dFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ5PPF8AFAE74CF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::841) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 08:31:41 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 08:31:41 +0000
Message-ID: <41ee791f-bea2-4450-823f-2468aac99297@windriver.com>
Date: Mon, 29 Dec 2025 16:31:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH/V5] refpolicy: Add support to configure
 policy store root
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20251221040404.845441-1-quic_sasikuma@quicinc.com>
 <BL3PR02MB8986D0ECCEDCC43B7E5AC1E7E8BFA@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <BL3PR02MB8986D0ECCEDCC43B7E5AC1E7E8BFA@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ5PPF8AFAE74CF:EE_
X-MS-Office365-Filtering-Correlation-Id: efa0fe91-e449-4042-8f84-08de46b4b11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OGExcFhWeXVHMWxta3JEZ3VCc0ZYaThvNDAzYmQyOGJzKzlPTzF1KzA5M2dh?=
 =?utf-8?B?cHZnMTV3WmlnemNmR3JWZ1BOZHZBTWVnTy9iQ1BUbWJrSFFxOGJ2WDYvbmdE?=
 =?utf-8?B?NGlnb2dpR09QcDJtU0FGUW8rS2RNc3VwWDhoTzFXQ1BBeWZnY0h2ajhxNkNT?=
 =?utf-8?B?bURmQnFCTyt2WXIvVVFxYmIvVlF3S0YzMkxhaG5HbDZVMVdhZFgzblBtdkEz?=
 =?utf-8?B?ZjdHSzVDNGNxM2hmanVyRFltZVVyZGUxTHZjaWV2TmRDYXJwdkpxa0thZkp3?=
 =?utf-8?B?dXNRRUNEenBhbjh1NFZtbDc5UXJWeGhoempxVlhvT1J5WDFQeHNLUVlNRmYy?=
 =?utf-8?B?WUNSRlFJVGxBc0RaT2dsZzJQdGlSRTROb1h1a0ppUXhUZTJ4VUFNM0NlYUpG?=
 =?utf-8?B?NUhGSDJibjFjK0pjNVRwVjcwdWdPTVBKblB0aHJ6VkxMRHFkOUQrU0RTa3c5?=
 =?utf-8?B?dm1DNW5iNDJJN0NoTU5XZXRqUWc5Tm9WRHVlQzkrcWk2Um5tdlcxQ1ZkMVAr?=
 =?utf-8?B?YmxnK0FuWWhBL2VsRzNUQlg4K2MrdmRXUUJXUlhrVE4wMUg1YmZlekpVTExp?=
 =?utf-8?B?UEM1Q1FSaUs5WkpLR2V3WHEzZWxVZE14OW5mRy9oNlAydENYR3hrMUE1bU5o?=
 =?utf-8?B?STBnck9SVk1WeWpsUFBzVktINXozSm16bzJ2Y1pCc1BmRENnbnpKTnJpUnhQ?=
 =?utf-8?B?dEhMUkxTZDJnU0UxR2JYSm9XaW44NzRMcTN6RU8vMmZhbS9WcjZkNmNIaGNJ?=
 =?utf-8?B?WEJWM3pvTUYwR1FBS2lFdDZQQW1vUUdtSGQwMVl1Q2lMT3VCZGg1eFRxYkFF?=
 =?utf-8?B?ZjdwRjIycTY4MGNvbDIrc0o3eko5WWJaWnprOXAxOE9TNnFIVHVlNmR2WFdP?=
 =?utf-8?B?U0RsbEphdkxqbjdsTHd2VmdCM3ppaWVrM3lJS0YzdXN5UE90QlFwbURCZW9U?=
 =?utf-8?B?M0xiY1JRYldpN1dBWHlsUEZvTEJlWlhZS1VmYzVsSEFYTXk1RTJHMnNqcEFn?=
 =?utf-8?B?OExsTXl4M1RIYjR3bFpZVTV0Sk42OVlSODc1cmlRMTBRQXZMMmdBZCtxNHBZ?=
 =?utf-8?B?c3ZxUkJMd0EwZnlrMzdHaHdtN3ptSU9IVTVDaU1saUp2NWFBNUdVMEQ0M0NK?=
 =?utf-8?B?T3dldlUzVGdtcTJhS3FHb0dEU2NFMGVYK2ZkMXFjR3hHcG42M3pTYkIwbjl3?=
 =?utf-8?B?MFJaVHJXaXZYR2dIVmR0YTNGZmdTVU9xRTFVRUlPU0pVUENaSFNHZDJNQkd4?=
 =?utf-8?B?YjdObm11QkVYR0tHV0lBVTY0aEFoZUZYTHc5d0pPT2VvS04yNVN3M3p2ZXBR?=
 =?utf-8?B?SHRJMi91dlNuckREZ1B3SmpFS3JjT2RCQUY4Z21SSmNrU05GVnhDZk1ZYkU2?=
 =?utf-8?B?MDFmS3JnZ0FmMHpWTk10K08xY1o1Q3pkRHAxaXlHcjAwRXdBZTF2OFpBTWZ6?=
 =?utf-8?B?N1hJMzF0UmJMc2toUzdUVllRVlZSVkNPd0J0VzBFK0QyZmtac3B5L2xzeHNL?=
 =?utf-8?B?K1dGdkdFekhoRmpZbEtHWDYydEl6cDVSYmp5a2NsV1UyLzJjc0VHaG5QK1Uv?=
 =?utf-8?B?VEdSZ3FTOGhialdiZlh0RjZlRGFkYkRZRG81M21ncHA1N29HK2VUYVhQSGNL?=
 =?utf-8?B?Y3FCc2E2QkhHR1YzNW4yT21hcmxyb2JqVlBpV1MxNUNBS0xHNGxkakxhd08z?=
 =?utf-8?B?a2V2c1BUcC9vamw1T21USFhpdEI5QUhuWm5xSm1yaTJzVTF3ckdDQWtXdTNS?=
 =?utf-8?B?UE1yTXdxd280Zk5sK2Y2Ty9Oci9aQzB6c3VBTGRRNXgrcng5Y0pTUzhWR29z?=
 =?utf-8?B?eVl6aHl0TGFxMlcyS2MvdjcvSFhGbnM1QURoRGpTQ0MvNTJ3NWk5SVArMy84?=
 =?utf-8?B?UHg0SUJiRFdtQW9obWVyZVVSeUpzRUlmVUhIOTJJaG5SVXduZS9mMzNwcmZV?=
 =?utf-8?Q?wgOO+ZsCBYwYbFtdMDCqk4bxQFAikJJ1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzZ5VnhzN0tZRk5oNTFvMndvekRMdzVIdUNXWnpqT0l3dE8wdUdJV1p3RE5P?=
 =?utf-8?B?eWY5alF2M0hYVFl4bFR4cVRaVkdSYzJveGgxbU5tMXV6U2dTSkpidCtLUHRI?=
 =?utf-8?B?dCt1WjMzYW5GWUM1aGdEbVI3ay9KQkRJa05WYXk2VUFkSXk2clFDM002QjIy?=
 =?utf-8?B?L0RQU0R3aGhKZlg5S1BnRytJOVh1N1RiK2g5OFJ0RERndzVSV1JBSWwwSDRJ?=
 =?utf-8?B?QlhIUDNpRzI5VWtUeDZCeTg0OVJJQmEvcWxwaHJUZ0dXTzZLcEdvbyt6anpi?=
 =?utf-8?B?YkVINmZMV1ZRKzZxdHZ4V0lXckkxcEVwemoxT3I1M2xQSmJpaHlkRUZNRk5O?=
 =?utf-8?B?TU5PRmhqWmFxSWFPUFFuUGMwcGRxVDd1ZkhyQjlqVG5JK1JCRzdFOTVuZjcw?=
 =?utf-8?B?QjF5Q0JjaitYNzBHd1NxTnhnSVJSdXRDbUZ2NGpzT3YwTmEwcWZ4SnUzWnpD?=
 =?utf-8?B?Z3IwQ3kxd2hhTkthOGM4RUNjRDBtM0lTOUxFTHQ4ZlQ0UjFadFRpWk9EaExI?=
 =?utf-8?B?MEl0WlAzSFZTSHdZZ01DMmZBaUcyRkMyUm1NMDJzQlV2b2JqVzR1MW1LUzRB?=
 =?utf-8?B?L096NC9oL0ZYbW5yOGp5VkJuNDZNaGNqOTVGam4wZVNsREdNL0kvTGhqV21B?=
 =?utf-8?B?eVVTRUlTUEpKNHFrbXloZE93OFpramt1NmZOSnNWSTVPSUtNTlZhK1dLN2Vs?=
 =?utf-8?B?VVJGa2VaMlBuZDBFNmI2RWJzV0ZndHZHT3l0eFpCWDlqNStkSnVuazhyNFBF?=
 =?utf-8?B?akF0SjZOclZrNlJqU1BLRzU5Y0E1MWQwblJVOWNkL2NQU2sxY2crL29wa01I?=
 =?utf-8?B?OG9FVWNJMXJtTUJsSmp5a09GWGhsOUR0TUlnczdVdmZpamhYa0hrb0EvWU1W?=
 =?utf-8?B?UGlENU42ZW1BcWY2djExaExKUW9sNlo2SWt3ckRDYVRqZjhUNzIxWkFtVkkz?=
 =?utf-8?B?dFREdUlRT2h4Mm5VKzlvUmExWndPN2tiT1pKYzBjNzFyempGcjJLZTFEeUk0?=
 =?utf-8?B?NU5USnZia05BT3VrdmlZZ1JTTDd6NXNId25KWDI2SlVNY2p1aUZEN1pPbHV5?=
 =?utf-8?B?cmZybjlUSGZXdEE1Y01IY2p0UTBTUytXVW9tQmkxaDgrMG9aQkRPdVlhS2Zi?=
 =?utf-8?B?RUxKdnQ3dDgva2pOY3hHSm9sTFdmTWFpVjM0Vkhma2FUZ2NFc2hvdk51Nkp2?=
 =?utf-8?B?czNEMFc5U1pub1VlMzdmdlE2ZG02L1hvVmV3Ym1FTkphR1V3S3hYeHlRalhL?=
 =?utf-8?B?YjJQVGw5dmxueThhMmVWbHFDV0RNSkh6QStIMm1mMHlQclJyMmhqVHdSdHEx?=
 =?utf-8?B?bUpGb2N3MWRSejhiWm1EN2hjNklTaVNWRDQ0YzAvR2trSk1SSXpjOEJCeEdW?=
 =?utf-8?B?QmNJWW1EMFhVU0Z0UXhQdWl2cmdKU2JrL2UwaTNqK3NsM3FnRUNlTjkxa3pt?=
 =?utf-8?B?VExmbUhuNU1UZXViMWZNLzZ1aytRcjVaMUFldU5sWnFKaGdVZSszN2RRMytM?=
 =?utf-8?B?VS8yQ0M3RU5ndGFDOHFmUlhwNjdYTHh6Y2pHOWdyc1JSbjhUTW5DODRZbG44?=
 =?utf-8?B?amI1QnpzVVFmOFpJL3ZVRTFRTmw1NGR0SVI5Kys0ZXpZdjcwSXFrL09lWUFD?=
 =?utf-8?B?bUpTNDYwUkhVdnJyQkhVa0pjWlRQZmtZVVRoNll2OWVyVUFmMjkzdUZqck1J?=
 =?utf-8?B?WkdSeVMwSzRXL3RvRVVQL0orbDB1VndSSk1DaEx5RjZZYkxpN3VoekNZSlF0?=
 =?utf-8?B?QmRIWGl4dU9aL0JSQXdJS0VjUUxhZk91blc2WndObmNxQ00zKzg0Y1RvelVO?=
 =?utf-8?B?RURIVm1XU3lnd210bzdsODhmb01MK0owNWtuYnNaeGdlaXhMUlFkUHU4YWJV?=
 =?utf-8?B?Yi9NRFJSa1pabUNienFwcUZtOTRGbUJ2RU9YZFpjT1I5Uy94R0ZPNVZ4d0N4?=
 =?utf-8?B?VTFrV1RtVzVySkhuTlJuSmMyZTVTWVVFK3MxOVBMdis5QUdtajhIUTJRR3Zn?=
 =?utf-8?B?VTcrRzEvYUh0OERadExOaWJYMXp0akhnejBjN29yMjJBYlN2WldUREJpVThX?=
 =?utf-8?B?aVR0eU5oaS9nS3FJU0dMN0t1MXRaTFVzZmJyRnF2ay82OC8xdUxuQmNjOXBp?=
 =?utf-8?B?SE1jQU1Ra25HQzdIa3RjSW82V0hHNjFaT1lERmhvZmFmRGxOWjhsYmlZRUtq?=
 =?utf-8?B?bkpoUmg3SXFWMDVwenQxWEhyN3d5dTFjV2U5MHZCeGI3RnZXWkZ4dUo2dGlK?=
 =?utf-8?B?b3FXTFhJQnZRMGM2V2tDb1pWeUpUWDVYRzZNSXBlOXQrVTdManVUWHhTcmZJ?=
 =?utf-8?B?SnFUNTEyWmx3cEJLUnBrRk4ybk5wMmdFSkFlY1BxVSttSit2RHQ1QT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa0fe91-e449-4042-8f84-08de46b4b11c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 08:31:41.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJH45XsxyIwufEDXAYYwJ6keqVojcUTkEN0Jv3DRGFCVeXbDxF077kFLYaHtbkykNxOu4SxF21o4a4ul/nMOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AFAE74CF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3OCBTYWx0ZWRfX8h0mmn0oIJ+P
 fP9b7hDqgAPSP3IZ17Ie9vbLtX26pxZjuW3e3rrY18yMx7m4TslReU8MYKVx5tw9HA9r+21Y6V6
 rh74ta+8LlqzeJkebK97n4+ERirJ0rboBlmr2y4sGSQnawPQ8zI5dPPbWLN8t2Tx24RYy30LC5p
 7IhJXSn1MjcS/FOnkL48sRHu2i3WZ2nG+cP/pbyiRq2hu4LdiM9XIyA+Ug/bUuUDrNeU9zm9z/d
 7cPUquBopcbgqQT1yESU82WeLxJhXz65TduunNF2KU/s63j0usY5+ov+BtL/3ItBGzSL3ryTamf
 sBS1Axpov8jLVqqYOTXvj4mb9QMx7uhHFvAnll74HdaodqEAKKFWfs3LcZ6CyBWcUGYm3g9qetg
 T4SoiRAS2jB38hc2LFxcXw2FujXVB5k1Xk/rjEOJfjE6WMfd8N7w1gupNeT/WP9+jBnQ76Kq7oI
 Pd8POsNsUMoGA8Ud/BA==
X-Proofpoint-GUID: eLc3dJCsO2KEJrIg64WKct39qb7cdj58
X-Authority-Analysis: v=2.4 cv=OO0qHCaB c=1 sm=1 tr=0 ts=69523c70 cx=c_pps
 a=k+Wq2vL5ZRQmlAOTCyP+eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=G0mVUBcp4cNwccoF1NMA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: eLc3dJCsO2KEJrIg64WKct39qb7cdj58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 08:31:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2877


On 12/29/25 13:03, Sasi Kumar Maddineni (QUIC) wrote:
> Hi Yi Zhao,
>
> Gentle reminder. Can you please review the change at the earliest possible.
>
>
> Regards,
> Sasi.
>
> -----Original Message-----
> From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> Sent: Sunday, December 21, 2025 9:34 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>
> Subject: [meta-selinux][PATCH/V5] refpolicy: Add support to configure policy store root
>
> By default, policy modules(*.pp) are stored in /var directory.
> Features like: ostree remove files in folders like /var variable data directory while build time.
>
> Added support for custom policy store. We can now configure path to custom policy store to variable `POLICY_STORE_ROOT`.
>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   .../refpolicy/refpolicy_common.inc            |  9 ++++++---
>   recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
>   2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 964906b..59dfecd 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -77,10 +77,12 @@ SRC_URI += " \
>   S = "${UNPACKDIR}/refpolicy"
>   
>   CONFFILES:${PN} = "${sysconfdir}/selinux/config"
> +
> +POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
>   FILES:${PN} += " \
>       ${sysconfdir}/selinux/${POLICY_NAME}/ \
>       ${datadir}/selinux/${POLICY_NAME}/*.pp \
> -    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
> +    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
>       "
>   FILES:${PN}-dev =+ " \
>       ${datadir}/selinux/${POLICY_NAME}/include/ \ @@ -165,7 +167,7 @@ prepare_policy_store() {
>       oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
>       POL_PRIORITY=100
>       POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
> -    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
> +    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
>       POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
>   
>       # Prepare to create policy store
> @@ -207,13 +209,14 @@ args = \$@
>   [end]
>   
>   policy-version = 35
> +store-root = "${POLICY_STORE_ROOT}"
>   EOF
>   
>       # Create policy store and build the policy
>       semodule -p ${D} -s ${POLICY_NAME} -n -B
>       rm -f ${D}${sysconfdir}/selinux/semanage.conf
>       # No need to leave final dir created by semanage laying around
> -    rm -rf ${D}${localstatedir}/lib/selinux/final
> +    rm -rf ${D}${POLICY_STORE_ROOT}/final
>   }
>   
>   install_misc_files() {
> diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
> index 2425a2e..99adde4 100644
> --- a/recipes-security/selinux/libsemanage_3.9.bb
> +++ b/recipes-security/selinux/libsemanage_3.9.bb
> @@ -32,6 +32,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \  FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
>   FILES:${PN} += "${libexecdir}"
>   
> +POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux/"


It's better to remove the trailing "/". This will keep it consistent 
with the variable in refpolicy_common.inc


//Yi

> +
>   do_compile:append() {
>       oe_runmake pywrap \
>           PYLIBVER='python${PYTHON_BASEVERSION}' \ @@ -46,9 +48,21 @@ do_install:append() {
>           PYLIBVER='python${PYTHON_BASEVERSION}' \
>           PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
>   
> -    # Update "policy-version" for semanage.conf
> -    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
> -        ${D}/etc/selinux/semanage.conf
> +    conf_file="${D}/etc/selinux/semanage.conf"
> +
> +    if [ -f "${conf_file}" ]; then
> +        # Update "policy-version" for semanage.conf
> +        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
> +            ${D}/etc/selinux/semanage.conf
> +
> +        # Update "store-root" for semanage.conf
> +        if grep -q '^store-root=' "${conf_file}"; then
> +            sed -i "s|^store-root=.*$|store-root=${POLICY_STORE_ROOT}|" "${conf_file}"
> +        else
> +            printf 'store-root=%s\n' "${POLICY_STORE_ROOT}" >> "${conf_file}"
> +        fi
> +    fi
> +
>   }
>   
>   BBCLASSEXTEND = "native"
> --
> 2.43.0
>

