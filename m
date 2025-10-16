Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BECCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 10:04:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4490.1760609033166711528
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 03:03:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=kRFJ+/rQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2384fab4a8=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8OvLu1377175;
	Thu, 16 Oct 2025 10:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=8lEa5wxVrCaaKCX1Iy4WRK
	UAX9L2cfwbrsMNaeJ3M/g=; b=kRFJ+/rQ4H+t8XGpRzPOCT3hPX+wmE42LkuF5j
	SsLSKQszU5Y5mBIiNmStEMogEnFllYMp+XD/Mip4z0mdjZPIyc+cqlYlB7g/VLYs
	XOPg4ND+6GUu+i76bM78m/A/ZEJZqCVgaLh2w5ribGHJmcXUmtFRzOgMCnUrZDOZ
	UhAB8+txMkEzw1vFbgeQlD8HmCISI0TXv3sQ0p7e5mgv0OKNmOb0vzbsVkoSoDbh
	Chvw2Z3trvUwKGpRRG7oTywcVZ1BKjKKEF49RyC0DbtZN/HfSsRhEC+mQ9uBCM/M
	ndfIIhfrWdphTIew7cBi86+pJelXUmYACrTWR4QdGnHHNToA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qcewp5x0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:03:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLELtxzf3dXjsQf66LOzxthtoSk7eiSYwBp8rPitOLSixhhqXbEIzFDfZOOANl8ww/iRgOClkczkbkVUy5H8yN/Rw10hB4LFOZWuytzFs0R3zf3gO+8R1v3V13F0iWItX+DADX/MtBjw9uW0cHaCCXQ2f04uts5n1K9267E5EdPjzNFSWTGz9tby196yZShbYS/k+71/51X5iFQZYc9bbWSEsZu6M4TFkWq4EjRQlQtoFQiQZtfuD4ZcFuMNwGJ5wg9q7wrAqEAKz/K1/WgIckhrVwVvnBRqZAvEYufvTaEr7XUh1bfQaB9J8q+8YSvDPfFhbn1XZnWhi3SCXQXAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lEa5wxVrCaaKCX1Iy4WRKUAX9L2cfwbrsMNaeJ3M/g=;
 b=AdpzWvRtBAFNtF2KlxpvxWGAkdquALVswUlrCIshAY272CrEU6AYRyHaMv2waT3NbGxyWMIyQAupsO9p23e/HI9nETL8TjmyuvXjEn1O3/yK+8YxtFgxiA71MAra3L4p3EITP4qsjfbUzHCfAR4ZrJ9q9FwNSRraNAKalIc4PRaUiAiEpKJvsp6J4EyRSzBOWOyGCjhhbo2pyz9W9HkoLJB1ujqA8v1c+5Vm6l0UyNXuE7tTKr/63wByYH7jKDAnyL1y/JhAXesXRyBpOxK7rpQQnoZ0+9fUdfl+wlPqVl+NjLL/jXMYNgioSk1aYCrPsyeAQEVaWT3AUzQKxM7d3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:03:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:03:49 +0000
Content-Type: multipart/alternative;
 boundary="------------FvG8L8IqrIy4GKx9tRZ7qXND"
Message-ID: <f863348c-da9c-4497-a9d5-1d5c85d94cac@windriver.com>
Date: Thu, 16 Oct 2025 18:03:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
To: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>,
        "Ravi Kumar Siddojigari (QUIC)" <quic_rsiddoji@quicinc.com>
References: <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <a5ad7b6e-3a31-4fa5-83f8-918744c6c32e@windriver.com>
 <BL3PR02MB89860445FD4D9D47B7135FB6E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB898682DC436D91B19BA8D1D7E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB8986CD337ABA02BE9D5C7265E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB8986181C0A920AE4066F9950E8E8A@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB8986D34BEB507165E67BF5F1E8E9A@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <BL3PR02MB8986D34BEB507165E67BF5F1E8E9A@BL3PR02MB8986.namprd02.prod.outlook.com>
X-ClientProxiedBy: KL1PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::26) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 115f504f-5bd1-403f-1c5f-08de0c9b4d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VFVIMUNMcnF6b2FBSkNsRGpWOXh6aUFKUGplV3R1MXlsWG96aHc2R1QyUlg5?=
 =?utf-8?B?Nm9FTjVsc0prTVZkN2w0K3prZTZ3MjNrT3lQUFc4S2V5amp1RmZFVVhDbm9M?=
 =?utf-8?B?NGZiZlJFY2xCdUx0RDRKU1JBZllSQ3M4N2ViZ3JKbzdFMFBWUlYxOXBJa1R6?=
 =?utf-8?B?VDNBcHovUjhyK2pJT1duNXJHMW1mMVY0ZWVTN09SU0orU1VlTnAwUW45ODIy?=
 =?utf-8?B?WXl2cEVUL1FheGQzMmlsNldHWnhmY0JUdHdzWUQ4L2lDZFBGczNCRUZLblpj?=
 =?utf-8?B?SkdlWHpmZktSdVowUDVUcmRxaGVBOHNRamxhMFBKdUNJUGNqRnZTUHlDMFVV?=
 =?utf-8?B?WlJNMXd2bjZvcDZZa09vSnhrOWxYbWNxbTZmTDBoSnB0MjIyV2h2Vy9OeSt1?=
 =?utf-8?B?UWR6MExtZGRQemJ3Q0V0dUJDNnJQcnNNcU4wcVZJbmg2SU05a1ZZWm04SUhO?=
 =?utf-8?B?YXNvWmsvd09tVU92Vkd0NFI2bHpZNjZwbWdkYlV0ME85bFFxd245eW1hK213?=
 =?utf-8?B?Szd4NFpCOVlmK3YvYStKYXplS3VCL0pjVGFPMm1nUUJ2TVQ2c3UwNlRIT0hS?=
 =?utf-8?B?cVpEZjQ0UnNxZWg5R25SdDJoL2Y1akt0QjFOd01oM0puODFKWllQRnRCRVRL?=
 =?utf-8?B?dmUzQzNGQ05IZnRKTHc5aktSdWg4OTBEOWNVQSszUEEvc2dPZkJFMk1XQ0Ny?=
 =?utf-8?B?RmZaV1gwaUswbU9KZUJESDNGZmtadjFoWUpYTThVN1V1SzNxU0Z6SFllTzZF?=
 =?utf-8?B?RXVYSDNNT3A1MmNIOHlnYis1NkMxaXJyOXIrbGtJL3hibml4SzRIaDFPNGFz?=
 =?utf-8?B?K25vckI3d1dXbm5kQ3FlLzFyVE5ETjl3VHNxbmM5Sm12eVhaRTArZ3dkdHhx?=
 =?utf-8?B?VU1YZmpEem1WNUVnQUYvaFdMWE51UElGZ0VYd2FzZHZHNW9LZVRMVkQrMVpD?=
 =?utf-8?B?RUhxQVFBa2R1WForREdqa0lFd0hjZHFwenRoZmpXL0xyNUt0YjFTVFdndEtP?=
 =?utf-8?B?alJIOW40TnprS21GbDdxTW5QMy9kWXZUZDhTM0RVT2ZRL2YzdEgxMm5BZUgv?=
 =?utf-8?B?YWpUSHB5RjMzdCt5Y3k2bDdpMnFyVmMwSzk5azVEZ0JNWlNCN0Rka3hvdWFv?=
 =?utf-8?B?MXBSbERwWkJoNGJYNldseHhzYy9mNTB2TkNSaE9EWlVLQkJ2LzBEKzBOdTBm?=
 =?utf-8?B?UStMWmR3MllSbjY2Y0pMNGJwM0NUVVRhZlFqK240RUF6dHVvMWtrejl3dTN2?=
 =?utf-8?B?SmNpNFZ3RGV0M0lsZXdzYjhac3plRi9DZTdYeWx2eTRHd2tKTThyYlkrUy94?=
 =?utf-8?B?SGl6eUtkZU9Ya2JnZzIrMHk3SVk5ZjlKOWFLMng5SmgzQTl2NmY4cmd6S1ZV?=
 =?utf-8?B?WVVSUzlNWlBXeEdlQlE1bGtpc3BEVWNyRTQvTlZQeTJyREl6d1F4MGNRNDRp?=
 =?utf-8?B?b2Mvc1ZQaGsyMTRSNHI1NEZYOTZJcHV3ZHlwNkNUcXpkZXdWQUd2NkQzYlNh?=
 =?utf-8?B?SG5qODg1RXJ0bVBsbkxDWGlqUUhBZmV3bHlRYnFsUlFNRUU5NXdCZGhMZlNR?=
 =?utf-8?B?cE40K3VVZlpiQzBhdmVrWkp4a3NEdXNhZkRGYXdYcS9seUtIK1dEMnFVSVlz?=
 =?utf-8?B?Q0VUY3VPc0xuaDhIdUdVL2M3czBhVEJJb044V1J0Tmo2Vk1DOGVrSmtRNlpQ?=
 =?utf-8?B?WmVrZnNQUVllQkUwcEE2UmpaS1NyeDUrWUw5NWY5alUrRTFzc1pLNUZyU3ZH?=
 =?utf-8?B?R3dXUnhjUG1MNmFIdmhuMk9pK0tZYlRXNmJNNGpTd3hSTHhwc0RLQjVTK2F6?=
 =?utf-8?B?WmNSSWtsdGVtWkdKS3JmUGptMm0ydDd3emIrQ1BjWEJQc2pmTDZXNklkK2E5?=
 =?utf-8?B?ZiszMzNaR085QmVkN1ZFbGVuYTYyUUlOZHhXY0FSNk04dTNWM1J3SVpZVC9i?=
 =?utf-8?Q?sGk4XPGhe0vB8Sr8sYWw0l7nxTzdGTNX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1ZFbzhyNW5DRnpuMDVXeThCTVdReG1LQmtpdkphWWJ0V1Z0VEhoQndMZG52?=
 =?utf-8?B?cVhlWXAyUnMrOEZlM3hDWEJ4WE1QOVRjVTNDSXJsRkI2UXlQMzFKMzVNcWhL?=
 =?utf-8?B?V2Rlb2lkTVgxVmQ5SVNZditRQUpJeHg0RlNIOVhpY2IrbjlPSVdEYzVHVlZn?=
 =?utf-8?B?Y1luUE9YQmlGNnhUNHhEaGlCdWFXYU1BQnByVEEvV0JpRmp3UEZISHcrd2p2?=
 =?utf-8?B?cVhuQlMrZVlsR29SM3BLUDNSaDNIM1FxRGxneHU1ZE1ucE9kYXpBa0cxbXBD?=
 =?utf-8?B?STl3TzkvbERwWGZNMXNrdkNLWHk2UTRTTHIrMFFsazA3TmJ5NlZqZzJvMWI3?=
 =?utf-8?B?SnAzdFR6QTBnRHBkc1doZEU2bTRrMitqRVI2V3Mvekt0MmxENTNhY24xSXA3?=
 =?utf-8?B?MXB0S3R3SjZZYzhnK3JSWHJrWm40eElZRVBKTTgvRHQxWkNpV2FxS3orQTdN?=
 =?utf-8?B?UzNYa25QT1JOWVpYcU5NMkQ5RU5TdDhvNktjSmNmdVdQZmx2Q2ZBN250R24z?=
 =?utf-8?B?SjRibkRqNEpJV1pNZHVuS3JpcVYyZW15WGVOVXlHRG5oR3FnOUZia3VMcTcr?=
 =?utf-8?B?OWRqdDlXYVRYZUs2d1U2cExmMlR3Y0xLZmtpNWFDSU1jQzMxYk1kQ2dxZERJ?=
 =?utf-8?B?OFByaVdWNWpNNitJd2EzVlg2eWlpaXplRGgzandjNXJETUFtRjJuay8zL3Aw?=
 =?utf-8?B?aGlKZ1MwaGZxTEdsQUtOVlU5MytEcWJDeEdnREVJSVVNREErTWc5dWdrSWNh?=
 =?utf-8?B?TnhHNEE3NDl4aHB4SEd3YUcrVWRFVDd5K2dyeTJFZGE3VXUvd3p4NGJDSXZV?=
 =?utf-8?B?MzFEY0FMT0dlRWZWYytEMEZxMnJLRGRGSW52MWJlcWVPZWs4MFhFRlREWFI3?=
 =?utf-8?B?Ris1MkhxcEZhMzNGeC95SFZ1N3huWDBYc0hBME9kTFUrMUlJUk80R09RbC9y?=
 =?utf-8?B?U1F3dWZEKy82WU8vekMvaW0vRVhJVm1QeFpnaEdHQTR5N2swM0F1TXlsdVk4?=
 =?utf-8?B?WTJ1a3RqZXg0Ym1qOW1ZRWsyd1lRWWVYbktYb1BYVlB0QkkySVgySG1SUmk3?=
 =?utf-8?B?NDVFTkR3cDNJdW9SN043OVQ2R2MrTG9Wc3BoMVVVYUVVck9tM0tlWWpxSlA5?=
 =?utf-8?B?Rmd5MEwwTzgzbEltczZMa2Q2RmhWenovYThnQzVxdHdCbWRkMTF0ZTJweFhD?=
 =?utf-8?B?aUZVYjdZdWlxc0RzTDd6TzBVaStwK3EwL1V5ckV5WC82R0RLbVlYV3c4Z3FI?=
 =?utf-8?B?ajJtZEYvTzJicTR1WkNBd1UwcDQxcFJtMDNqYld3b0xjV2ExUjJ2VmI5TjNZ?=
 =?utf-8?B?MHFhY1VkdkxpVkJHdXdQL2NQeUd5MEFPL2FvTVVBUVAramc2bS9rc0dyYk5J?=
 =?utf-8?B?clZVbEEzczY5di9MNGdYeGNLakxJVWFla082c2JTc2xGWjB4TE1iSnozV2l6?=
 =?utf-8?B?a1FhWE81aFlEOVdOdlg3cnU3Y1Nyb0xTS0NycXlOQnc5c2gyeWZtckozWSt0?=
 =?utf-8?B?dGhBYlpTUUU0RUhuVDFQVnVGdzlHL0RUK0lpRXIrUnRhWW40Tk0rSkFoQ242?=
 =?utf-8?B?YzZwTWJ2blZQWk1EYnNHYU1mNXAvcW1Bc3QyQlhtY3RhMVJnOFVlQnFjVlVM?=
 =?utf-8?B?Nk9ZRGxFeE56SjBzSjRiQklpSUpnM3N3UkdCMWlaWWxOWFMvdjNOT1FvUHVr?=
 =?utf-8?B?ekxUaExkTTBpc3NkNWxYS2p1SGJra0EzbzlscVZwd1Vkeno1bE5XQUJMdTc4?=
 =?utf-8?B?VGJYSjVoSGxKcVdKRkN0MndaRWhYTWsxLzRuK2tIYUQ4WVJOekhwR29sN1Y1?=
 =?utf-8?B?V1c4VDdhYVE0MXJXdmlvb2lyNXhVUnNZVWhhOXpzWmFnOXR1OWVQMEllSVNW?=
 =?utf-8?B?dmo4WlI4dzBTeU5UOEIrTFFVd25YTGhYdkdMVWcvdTlWTmNvSjZ4NG5BV0J6?=
 =?utf-8?B?OVlvZnVlZmNPbTZNNDlES1IrYkhGOHdFK3JwTFVqL1EyWVFLSTRkZ0s0WHUy?=
 =?utf-8?B?TXJPbGExNkhocG9mT2Y2ZzFvKzVmM2I5L3BjdDJUY1YzRSt1TVY5S0dTcW5n?=
 =?utf-8?B?L1dMT245cVNQbkE4Tk9Pak9zWnQ5SzEzRTF3Vk5uLzhSU2NMU1hoOFhJcjJv?=
 =?utf-8?Q?EHOhhz1ILk/ccYxUKmsLIXrIR?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f504f-5bd1-403f-1c5f-08de0c9b4d38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:03:49.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JguYn7D8CY77BByC/JdcPZJv3phS8G6gflP56broqI0UAfVQ6xNvxn9Hw9Uqg/6dTHAy/W1C1xBX38KVGT3gXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-Proofpoint-GUID: xaD-oaWAccNhYeuUQmtaMAKTsmgLZ0sS
X-Proofpoint-ORIG-GUID: xaD-oaWAccNhYeuUQmtaMAKTsmgLZ0sS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA3NiBTYWx0ZWRfX116fnjUf7yBp
 GO5dO5+KzLGbRS/+V9ehrAeFCBV3hXlR3oaaJt2Xp6haYQRWuKNowRQoaxMk2bL5t656uuUmuzU
 z21b6VTSEmMzoo93DygXaCvIxF2lumG2Xa6A1fFDae0HjFJOg2GA49EO+A1NFLSy5mNCYAL57PA
 Qwf2CQhUPQOEwetq9Ke8jqZjhKt20mAdyW5BJDkfuXIj9N7ptyVe4JJXdx/gv0YOSTkxQzNTwto
 rb7L3uFmouFJqJYQQkAWFCZF9WF6VRREedC6dcrc7UhvukG+tf/EXNqJ/ZT4pfn6I0dR0G19onD
 l1Fy3aQFBYsWwCwMamFzrgWGcw25qs2PnJ1O8Gu43UEGuofx2chmqiswevSTvwByUsnupg/LV4N
 3KaePBJrILzMnx8yAVUW6JygVWwE4A==
X-Authority-Analysis: v=2.4 cv=M+xA6iws c=1 sm=1 tr=0 ts=68f0c307 cx=c_pps
 a=jolozQ03zpjfpn/maDJ7eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8 a=wucjtUSzTXSsk-0dnPcA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=UqCG9HQmAAAA:8
 a=Domy4h1UGIxyq2BMxAYA:9 a=o8g_MMf4FsFOY4DD:21 a=UiCQ7L4-1S4A:10
 a=hTZeC7Yk6K0A:10 a=_W_S_7VecoQA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510160076
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 10:04:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2311

--------------FvG8L8IqrIy4GKx9tRZ7qXND
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 59G8OvLu1377175

Hi Sasi,


On 10/16/25 11:52, Sasi Kumar Maddineni wrote:
>
> Hi @'Yi Zhao' <mailto:yi.zhao@windriver.com>,
>
>
> Gentle reminder!!
>
> Re-attaching all three patches. Can you please review and provide=20
> comments at the earliest.
>

Please use git send-email to send patches, rather than attaching them.=20
This makes it easier for us to add review comments to patches.

For the QA error, this is clearly not a false positive. Please fix it=20
first rather than skipping the QA check.


Thanks,

Yi


>
>
> Regards,
>
> Sasi Kumar Maddineni,
>
> Qualcomm Innovation Center.
>
> *From:*Sasi Kumar Maddineni (QUIC)
> *Sent:* Wednesday, October 15, 2025 10:01 AM
> *To:* Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>; 'Yi=20
> Zhao' <yi.zhao@windriver.com>; 'yocto-patches@lists.yoctoproject.org'=20
> <yocto-patches@lists.yoctoproject.org>; Ravi Kumar Siddojigari (QUIC)=20
> <quic_rsiddoji@quicinc.com>
> *Subject:* RE: meta-selinux][PATCH - Do not look HLL files when=20
> POLICY_MONOLITHIC=3Dy is configured
>
> Hi @'Yi Zhao' <mailto:yi.zhao@windriver.com>,
>
> There is one more issue, where yocto build system task=20
> =E2=80=9C*do_package_qa*=E2=80=9D stage checks for host reference paths=
 in the source=20
> files and flags it.
>
> Yocto's "do_package_qa" task says "*ERROR: QA Issue: File=20
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs in package=20
> refpolicy-targeted contains reference to TMPDIR [buildpaths]*".
>
> This is a false positive and needs to be fixed somehow. I have work=20
> around which is to skip the =E2=80=9Cdo_package_qa=E2=80=9D stage with =
the change=20
> =E2=80=9C*do_package_qa[noexec] =3D "1" *
>
> The content of =E2=80=9Cfile_contexts.homedirs=E2=80=9D will as follows=
 which is as=20
> expected.
>
> */_File_contexts.homedirs content:_/*
>
> /home/[^/]+/\.pki(/.*)? user_u:object_r:user_cert_t:s0
>
> /tmp/gconfd-[^/]+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -d user_u:object_r:user_tmp_t:s0
>
> /tmp/gconfd-[^/]+/.*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -- user_u:object_r:gconf_tmp_t:s0
>
> /home/[^/]+/\.dbus(/.*)? user_u:object_r:session_dbusd_home_t:s0
>
> /home/[^/]+/\.java(/.*)? user_u:object_r:java_home_t:s0
>
> /home/[^/]+/\.kube(/.*)? user_u:object_r:kubernetes_home_t:s0
>
> /home/[^/]+/\.wine(/.*)? user_u:object_r:wine_home_t:s0
>
> /home/[^/]+/Music(/.*)? user_u:object_r:xdg_music_t:s0
>
> /run/sudo/ts/[^/]+ user_u:object_r:pam_runtime_t:s0
>
> /home/[^/]+/\.xauth.*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -- user_u:object_r:xauth_home_t:s0
>
> /home/[^/]+/\.gconf(/.*)? user_u:object_r:gconf_home_t:s0
>
> /home/[^/]+/\.gnome(/.*)? user_u:object_r:gnome_home_t:s0
>
> /home/[^/]+/\.gnupg(/.+)? user_u:object_r:gpg_secret_t:s0
>
> /home/[^/]+/\.irssi(/.*)? user_u:object_r:irc_home_t:s0
>
> /home/[^/]+/\.adobe(/.*)? user_u:object_r:mozilla_plugin_home_t:s0
>
> /home/[^/]+/\.gnash(/.*)? user_u:object_r:mozilla_plugin_home_t:s0
>
> /home/[^/]+/\.pulse(/.*)? user_u:object_r:pulseaudio_home_t:s0
>
> /home/[^/]+/\.pyzor(/.*)? user_u:object_r:pyzor_home_t:s0
>
> /home/[^/]+/\.razor(/.*)? user_u:object_r:razor_home_t:s0
>
> /home/[^/]+/\.spamd(/.*)? user_u:object_r:spamd_home_t:s0
>
> /home/[^/]+/vmware(/.*)? user_u:object_r:vmware_file_t:s0
>
> /home/[^/]+/\.cache(/.*)? user_u:object_r:xdg_cache_t:s0
>
> /home/[^/]+/\.local(/.*)? user_u:object_r:xdg_data_t:s0
>
> /home/[^/]+/Videos(/.*)? user_u:object_r:xdg_videos_t:s0
>
> /home/[^/]+/\.fonts(/.*)? user_u:object_r:user_fonts_t:s0
>
> /home/[^/]+/\.docker(/.*)? user_u:object_r:container_conf_home_t:s0
>
> /home/[^/]+/\.gconfd(/.*)? user_u:object_r:gconf_home_t:s0
>
> /home/[^/]+/\.gnome2(/.*)? user_u:object_r:gnome_home_t:s0
>
> /home/[^/]+/irclogs(/.*)? user_u:object_r:irc_log_home_t:s0
>
> /home/[^/]+/\.kismet(/.*)? user_u:object_r:kismet_home_t:s0
>
> /home/[^/]+/\.galeon(/.*)? user_u:object_r:mozilla_home_t:s0
>
> /home/[^/]+/\.spicec(/.*)? user_u:object_r:mozilla_plugin_home_t:s0
>
> *From:*Sasi Kumar Maddineni (QUIC)
> *Sent:* Tuesday, October 14, 2025 7:31 PM
> *To:* Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>; 'Yi=20
> Zhao' <yi.zhao@windriver.com>; 'yocto-patches@lists.yoctoproject.org'=20
> <yocto-patches@lists.yoctoproject.org>; Ravi Kumar Siddojigari (QUIC)=20
> <quic_rsiddoji@quicinc.com>
> *Subject:* RE: meta-selinux][PATCH - Do not look HLL files when=20
> POLICY_MONOLITHIC=3Dy is configured
>
> Hi @'Yi Zhao' <mailto:yi.zhao@windriver.com>,
>
> A minor corrections were did in 2^nd and 3^rd patches and re-sharing=20
> the patches. Apologies for the inconvenience.
>
> Please review and provide your comments at the earliest as possible.
>
> Regards,
>
> Sasi Kumar Maddineni,
>
> Qualcomm Innovation Center.
>
> *From:*Sasi Kumar Maddineni (QUIC)
> *Sent:* Tuesday, October 14, 2025 2:22 PM
> *To:* 'Yi Zhao' <yi.zhao@windriver.com>; Sasi Kumar Maddineni (QUIC)=20
> <quic_sasikuma@quicinc.com>; 'yocto-patches@lists.yoctoproject.org'=20
> <yocto-patches@lists.yoctoproject.org>
> *Subject:* RE: meta-selinux][PATCH - Do not look HLL files when=20
> POLICY_MONOLITHIC=3Dy is configured
>
> Hi @'Yi Zhao' <mailto:yi.zhao@windriver.com>,
>
> Attached additional patches required for compilation of refpolicy in=20
> MONOLITIHIC design and also corrected policy version in semanage.conf=20
> as per checkpolicy.
>
> Apply patches in indexed order.
>
> Also, why we don=E2=80=99t we configure POLICY_MONOLITHIC to =E2=80=98y=
=E2=80=99, if our focus=20
> is consumer embedded devices instead of server distributions?
>
> Regards,
>
> Sasi.
>
> *From:*Sasi Kumar Maddineni
> *Sent:* Tuesday, October 14, 2025 2:04 PM
> *To:* 'Yi Zhao' <yi.zhao@windriver.com>; Sasi Kumar Maddineni (QUIC)=20
> <quic_sasikuma@quicinc.com>; yocto-patches@lists.yoctoproject.org
> *Subject:* RE: meta-selinux][PATCH - Do not look HLL files when=20
> POLICY_MONOLITHIC=3Dy is configured
>
> Hi @Yi Zhao <mailto:yi.zhao@windriver.com>,
>
> I have few more patches to send. I will share by EOD.
>
> 1. One issue is the build system is picking the host libsepol instead=20
> of recipe-sysroot.
> 2. Another issue is in rebuild_policy, we need to change policy=20
> version to 35, since policy version depends on checkpolicy version.
>
> I will share patches in a while today.
>
> Regards,
>
> Sasi Kumar Maddineni,
>
> Qualcomm Innovation Center.
>
> **
>
> *From:*Yi Zhao <yi.zhao@windriver.com <mailto:yi.zhao@windriver.com>>
> *Sent:* Tuesday, October 14, 2025 2:00 PM
> *To:* Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com=20
> <mailto:quic_sasikuma@quicinc.com>>;=20
> yocto-patches@lists.yoctoproject.org=20
> <mailto:yocto-patches@lists.yoctoproject.org>
> *Subject:* Re: meta-selinux][PATCH - Do not look HLL files when=20
> POLICY_MONOLITHIC=3Dy is configured
>
> *WARNING:*This email originated from outside of Qualcomm. Please be=20
> wary of any links or attachments, and do not enable macros.
>
> Hi Sasi,
>
> On 10/13/25 18:59, Sasi Kumar Maddineni (QUIC) wrote:
>
>     Hi @Yi Zhao <mailto:yi.zhao@windriver.com>,
>
>     I tried configuring POLICY_MONOLITHIC=3Dy for our consumer embedded
>     devices platform.
>
>     The recipe is looking HLL(.pp) files in case of MONOLITHIC as well
>     and build is failing, which it should not be doing.
>
>     So, I raised a patch with the fix and shared the attachment.
>
>     Please review provide your valuable comments.
>
> Thank you for your patch. I found that even with this patch applied,=20
> building refpolicy still failed when POLICY_MONOLITHIC=3Dy. So it looks=
=20
> like more changes are needed.
>
> //Yi
>
>     Regards,
>
>     Sasi Kumar Maddineni,
>
>     Qualcomm Innovation Center.
>
--------------FvG8L8IqrIy4GKx9tRZ7qXND
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 59G8OvLu1377175

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>Hi Sasi,</p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 10/16/25 11:52, Sasi Kumar Maddinen=
i
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:BL3PR02MB8986D34BEB507165E67BF5=
F1E8E9A@BL3PR02MB8986.namprd02.prod.outlook.com">
     =20
      <meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered med=
ium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">Hi <a id=3D"OWAAMDDD46DF40EC543B18DF07FBFB=
2A68B99" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"true">
            <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-=
decoration:none">@'Yi
              Zhao'</span></a>,<o:p></o:p></p>
        <p class=3D"MsoNormal"><br>
          Gentle reminder!!<br>
          <br>
          Re-attaching all three patches. Can you please review and
          provide comments at the earliest.<br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Please use git send-email to send patches, rather than attaching
      them. This makes it easier for us to add review comments to
      patches.<br>
      <br>
      For the QA error, this is clearly not a false positive. Please fix
      it first rather than skipping the QA check.</p>
    <p><br>
    </p>
    <p>Thanks,<br>
    </p>
    <p>Yi<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:BL3PR02MB8986D34BEB507165E67BF5=
F1E8E9A@BL3PR02MB8986.namprd02.prod.outlook.com">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">
          <br>
          <br>
          <o:p></o:p></p>
        <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
        <p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
        <p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
        <div>
          <div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;paddin=
g:3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none">
                Sasi Kumar Maddineni (QUIC)
                <br>
                <b>Sent:</b> Wednesday, October 15, 2025 10:01 AM<br>
                <b>To:</b> Sasi Kumar Maddineni (QUIC)
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:quic_sa=
sikuma@quicinc.com">&lt;quic_sasikuma@quicinc.com&gt;</a>; 'Yi Zhao'
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yi.zhao=
@windriver.com">&lt;yi.zhao@windriver.com&gt;</a>;
                '<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yoc=
to-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</=
a>'
                <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yocto-p=
atches@lists.yoctoproject.org">&lt;yocto-patches@lists.yoctoproject.org&g=
t;</a>; Ravi Kumar
                Siddojigari (QUIC) <a class=3D"moz-txt-link-rfc2396E" hre=
f=3D"mailto:quic_rsiddoji@quicinc.com">&lt;quic_rsiddoji@quicinc.com&gt;<=
/a><br>
                <b>Subject:</b> RE: meta-selinux][PATCH - Do not look
                HLL files when POLICY_MONOLITHIC=3Dy is configured<o:p></=
o:p></span></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Hi <a id=3D"OWAAM2ADB39E2792B4DD5B665BA4F1=
F686F84" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"true">
            <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-=
decoration:none">@'Yi
              Zhao'</span></a>,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">There is one more issue, where yocto build
          system task =E2=80=9C<b><span style=3D"background:yellow;mso-hi=
ghlight:yellow">do_package_qa</span></b>=E2=80=9D
          stage checks for host reference paths in the source files and
          flags it.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Yocto's &quot;do_package_qa&quot; task say=
s &quot;<b>ERROR:
            QA Issue: File
            /etc/selinux/targeted/contexts/files/file_contexts.homedirs
            in package refpolicy-targeted contains reference to TMPDIR
            [buildpaths]</b>&quot;.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">This is a false positive and needs to be
          fixed somehow. I have work around which is to skip the =E2=80=9C=
<span style=3D"background:yellow;mso-highlight:yellow">do_package_qa</spa=
n>=E2=80=9D
          stage with the change =E2=80=9C<b>do_package_qa[noexec] =3D &qu=
ot;1&quot;
          </b><o:p></o:p></p>
        <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
        <p class=3D"MsoNormal">The content of =E2=80=9Cfile_contexts.home=
dirs=E2=80=9D
          will as follows which is as expected.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><b><i><u>File_contexts.homedirs content:<o=
:p></o:p></u></i></b></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.pki(/.*)?&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:user_cert_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/tmp/gconfd-[^/]+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -d&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
          user_u:object_r:user_tmp_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/tmp/gconfd-[^/]+/.*&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
          user_u:object_r:gconf_tmp_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.dbus(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:session_dbusd_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.java(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:java_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.kube(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:kubernetes_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.wine(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:wine_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/Music(/.*)?&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:xdg_music_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/run/sudo/ts/[^/]+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:pam_runtime_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.xauth.*&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:xauth_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gconf(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:gconf_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gnome(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:gnome_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gnupg(/.+)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:gpg_secret_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.irssi(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:irc_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.adobe(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:mozilla_plugin_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gnash(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:mozilla_plugin_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.pulse(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:pulseaudio_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.pyzor(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:pyzor_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.razor(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:razor_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.spamd(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:spamd_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/vmware(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:vmware_file_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.cache(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:xdg_cache_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.local(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:xdg_data_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/Videos(/.*)?&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:xdg_videos_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.fonts(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:user_fonts_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.docker(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:container_conf_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gconfd(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:gconf_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.gnome2(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:gnome_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/irclogs(/.*)?&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:irc_log_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.kismet(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:kismet_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.galeon(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:mozilla_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal">/home/[^/]+/\.spicec(/.*)?&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          user_u:object_r:mozilla_plugin_home_t:s0<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;paddin=
g:3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none">
                Sasi Kumar Maddineni (QUIC)
                <br>
                <b>Sent:</b> Tuesday, October 14, 2025 7:31 PM<br>
                <b>To:</b> Sasi Kumar Maddineni (QUIC) &lt;<a href=3D"mai=
lto:quic_sasikuma@quicinc.com" moz-do-not-send=3D"true" class=3D"moz-txt-=
link-freetext">quic_sasikuma@quicinc.com</a>&gt;;
                'Yi Zhao' &lt;<a href=3D"mailto:yi.zhao@windriver.com" mo=
z-do-not-send=3D"true" class=3D"moz-txt-link-freetext">yi.zhao@windriver.=
com</a>&gt;;
                '<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yoc=
to-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</=
a>' &lt;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org" moz-do-no=
t-send=3D"true" class=3D"moz-txt-link-freetext">yocto-patches@lists.yocto=
project.org</a>&gt;;
                Ravi Kumar Siddojigari (QUIC) &lt;<a href=3D"mailto:quic_=
rsiddoji@quicinc.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-free=
text">quic_rsiddoji@quicinc.com</a>&gt;<br>
                <b>Subject:</b> RE: meta-selinux][PATCH - Do not look
                HLL files when POLICY_MONOLITHIC=3Dy is configured<o:p></=
o:p></span></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Hi <a id=3D"OWAAM7A261387817A42238D5AD9DA1=
14BDD5F" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"true">
            <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-=
decoration:none">@'Yi
              Zhao'</span></a>,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">A minor corrections were did in 2<sup>nd</=
sup>
          and 3<sup>rd</sup> patches and re-sharing the patches.
          Apologies for the inconvenience.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Please review and provide your comments at
          the earliest as possible.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
        <p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
        <p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;paddin=
g:3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none">
                Sasi Kumar Maddineni (QUIC)
                <br>
                <b>Sent:</b> Tuesday, October 14, 2025 2:22 PM<br>
                <b>To:</b> 'Yi Zhao' &lt;<a href=3D"mailto:yi.zhao@windri=
ver.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">yi.zhao=
@windriver.com</a>&gt;;
                Sasi Kumar Maddineni (QUIC) &lt;<a href=3D"mailto:quic_sa=
sikuma@quicinc.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freete=
xt">quic_sasikuma@quicinc.com</a>&gt;;
                '<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yoc=
to-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</=
a>' &lt;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org" moz-do-no=
t-send=3D"true" class=3D"moz-txt-link-freetext">yocto-patches@lists.yocto=
project.org</a>&gt;<br>
                <b>Subject:</b> RE: meta-selinux][PATCH - Do not look
                HLL files when POLICY_MONOLITHIC=3Dy is configured<o:p></=
o:p></span></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Hi <a id=3D"OWAAMBBCC4A59E57B4FDB8A73BA086=
1EF52CB" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"true">
            <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-=
decoration:none">@'Yi
              Zhao'</span></a>,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Attached additional patches required for
          compilation of refpolicy in MONOLITIHIC design and also
          corrected policy version in semanage.conf as per checkpolicy.<o=
:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Apply patches in indexed order.<o:p></o:p>=
</p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Also, why we don=E2=80=99t we configure
          POLICY_MONOLITHIC to =E2=80=98y=E2=80=99, if our focus is consu=
mer embedded
          devices instead of server distributions?<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
        <p class=3D"MsoNormal">Sasi.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;paddin=
g:3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none">
                Sasi Kumar Maddineni
                <br>
                <b>Sent:</b> Tuesday, October 14, 2025 2:04 PM<br>
                <b>To:</b> 'Yi Zhao' &lt;<a href=3D"mailto:yi.zhao@windri=
ver.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">yi.zhao=
@windriver.com</a>&gt;;
                Sasi Kumar Maddineni (QUIC) &lt;<a href=3D"mailto:quic_sa=
sikuma@quicinc.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freete=
xt">quic_sasikuma@quicinc.com</a>&gt;;
                <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" m=
oz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">yocto-patches@lis=
ts.yoctoproject.org</a><br>
                <b>Subject:</b> RE: meta-selinux][PATCH - Do not look
                HLL files when POLICY_MONOLITHIC=3Dy is configured<o:p></=
o:p></span></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Hi <a id=3D"OWAAM76F26AF067584A9B8776F5412=
7DF480F" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"true">
            <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-=
decoration:none">@Yi
              Zhao</span></a>,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">I have few more patches to send. I will
          share by EOD.<br>
          <br>
          1. One issue is the build system is picking the host libsepol
          instead of recipe-sysroot.<br>
          2. Another issue is in rebuild_policy, we need to change
          policy version to 35, since policy version depends on
          checkpolicy version.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">I will share patches in a while today.<o:p=
></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
        <p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
        <p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
        <p class=3D"MsoNormal"><b><o:p>&nbsp;</o:p></b></p>
        <div>
          <div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;paddin=
g:3.0pt 0in 0in 0in">
            <p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span><=
/b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none">
                Yi Zhao &lt;</span><a href=3D"mailto:yi.zhao@windriver.co=
m" moz-do-not-send=3D"true"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;mso-ligatures:none">yi.zhao@windriver.com</=
span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,=
sans-serif;mso-ligatures:none">&gt;
                <br>
                <b>Sent:</b> Tuesday, October 14, 2025 2:00 PM<br>
                <b>To:</b> Sasi Kumar Maddineni (QUIC) &lt;</span><a href=
=3D"mailto:quic_sasikuma@quicinc.com" moz-do-not-send=3D"true"><span styl=
e=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none">quic_sasikuma@quicinc.com</span></a><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">&gt=
;;
              </span><a href=3D"mailto:yocto-patches@lists.yoctoproject.o=
rg" moz-do-not-send=3D"true"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none">yocto-patches@lists.yo=
ctoproject.org</span></a><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;mso-ligatures:none"><br>
                <b>Subject:</b> Re: meta-selinux][PATCH - Do not look
                HLL files when POLICY_MONOLITHIC=3Dy is configured<o:p></=
o:p></span></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p align=3D"center" style=3D"text-align:center"><strong><span sty=
le=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:bla=
ck;background:yellow">WARNING:</span></strong><span style=3D"font-size:10=
.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black;background:yell=
ow">
            This email originated from outside of Qualcomm. Please be
            wary of any links or attachments, and do not enable macros.</=
span><o:p></o:p></p>
        <div>
          <p>Hi Sasi,<o:p></o:p></p>
          <div>
            <p class=3D"MsoNormal">On 10/13/25 18:59, Sasi Kumar Maddinen=
i
              (QUIC) wrote:<o:p></o:p></p>
          </div>
          <blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
            <p class=3D"MsoNormal">Hi <a id=3D"OWAAMD1F1AEE518A641D18477F=
C9978CA9D0C" href=3D"mailto:yi.zhao@windriver.com" moz-do-not-send=3D"tru=
e">
                <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;t=
ext-decoration:none">@Yi
                  Zhao</span></a>,<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">I tried configuring POLICY_MONOLITHIC=3D=
y
              for our consumer embedded devices platform.
              <o:p></o:p></p>
            <p class=3D"MsoNormal">The recipe is looking HLL(.pp) files i=
n
              case of MONOLITHIC as well and build is failing, which it
              should not be doing.<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">So, I raised a patch with the fix and
              shared the attachment.<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">Please review provide your valuable
              comments.<o:p></o:p></p>
          </blockquote>
          <p><o:p>&nbsp;</o:p></p>
          <p style=3D"margin-bottom:12.0pt">Thank you for your patch. I
            found that even with this patch applied, building refpolicy
            still failed when POLICY_MONOLITHIC=3Dy. So it looks like mor=
e
            changes are needed.<o:p></o:p></p>
          <p><o:p>&nbsp;</o:p></p>
          <p>//Yi<o:p></o:p></p>
          <blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
            <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
            <p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
            <p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p>=
</p>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------FvG8L8IqrIy4GKx9tRZ7qXND--

