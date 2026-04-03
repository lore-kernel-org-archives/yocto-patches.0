Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C1D7308E
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 03:11:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4029.1775185887188056453
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 20:11:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kVXH585n;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85536a21e9=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632NASrH1442666;
	Thu, 2 Apr 2026 20:11:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=XF8kGfcTKOatYZecxQY81dd96A+/B7afi/CL5waDE9s=; b=kVXH585nLMvU
	snGKW2V3QcqRjRIqIbJzNnVp0dvwNgOZT1BI9c9u/tXiof+7xYhUuNaAXXwpm/ZF
	HyAuyLqZeZgc4+N8HD0HwiFsq59ksudcSOOSb2r/emPUy72fvrRbOeqZISa2ZJJ3
	KCzYSd7FrRLTL/a9wR5mINUvyETjFpmJHrEdvqLSxzSrNHcueicwzztplK7jWhnY
	OLWSOxsBZLk8yuRbfjlTh/4wHRd6dMyWQxjkKUadTvOj3HrmZPaH06E+e0Mw8BlX
	zHSTr8vbCvPz9I8NvMbFoXDcTuBjpspAEo6nw9gAZWdS6ltBpYdrlZcXckmHlvIa
	7Pom0fkyzA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vgn55-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmWbnf/qe7LYnDCGVrYIT2p67xxBI5Z+kYE7xi/Wz8lJJ08BgqWGfgHAbpk0zvEPHuZujQ9pM9rULdzqonmRKDZcBexfm3rQ30gho0PwYrZnyeISFMFI9zdq9Sl47hiZ9/CSq/nf2IcSL3j0E94lPiiDje8cn83VercNFX/mW9QJKbwlgOe/zZ5Bp5OdCiOx6VpUwu3gDH+ul5i6TbZ36AwaCfEY2M74Y9kuW3Vsx3PxGEhr+vWl17whSqF4FpyW7jXTsni/CkhsJpjXRYoV643sp+V4mZsympKFxLz8w2sTNpUYKzrgE2UMudnSO+F9eeYsBTML3VMRFPIwhbz1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF8kGfcTKOatYZecxQY81dd96A+/B7afi/CL5waDE9s=;
 b=S2ais56kD7RwIgS5hHPL30q0LeW9PUtPFc28QD2JnAk7mmaSzujGySACSNLeCkfKAeGbo4WocV/by+kChNmafppV75Y/fXrnizxjocK0e07gom1MrviPYhMbeKLzRS0gJg5tnpOZORsSN9Z9TwNOSJMM5Ov/4xK+Xraw2iEDpmM4IqCOYMbO7bdRXMAp7d4Wfci0fHcEnbfLCnJuC32d1UhWj9liWwqesT3Vd1PjS1nlw9e1kduHCOnrnL0XE4cfm8Gn17NrdMu/4VG1fjl0H4HDjGPONJYdxY5t+RT5/FBuhuMGUdxyZxtxS1zfqLFz33P3EAYq///ba4Iq5GmLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by PH7PR11MB6697.namprd11.prod.outlook.com (2603:10b6:510:1ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 03:11:20 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 03:11:20 +0000
Message-ID: <6bc9f68b-2ad7-4918-8675-9996557d12e5@windriver.com>
Date: Fri, 3 Apr 2026 11:11:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][PATCH 3/3] bazel: update the arguments for
 local resources
To: martin.jansa@gmail.com, yocto-patches@lists.yoctoproject.org
References: <20260402001645.1717722-1-martin.jansa@gmail.com>
 <20260402001645.1717722-3-martin.jansa@gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20260402001645.1717722-3-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::16) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|PH7PR11MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: b901860c-ee22-4345-5484-08de912eadbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xjWLgnprPoK3yAVH3tfdhoa57vEaJO/Vi4vni3OIQv+qneEZEMwxW8lCc4g1lfLbMmiyijVsZ1qQIPbXcgSvql1k9SJuBke8cbcxkl0NJC7tlxr4IlomPg+otIsLJmFsn6bhZkM0TJgLIO/Ex4VcjzLaiQRCUKRmIYSo2+U9QyqSdzRZeGbWCjL7g+m8Ko3iPEBngXuRRKK3LjWXeiMz2EJPICTfn5Vfs7EQxsSQz1u6Xhgk/4FDD8DPmdADjSKJUqJi10M1WBkCXh3tQdvmYCQ26Ka/+FyqF49Gft1H7snjgKGyJEm1RcOHfQsOBCmBls1TiIOgjgMP51XfzrI/gKW15IrNe50NQJVw1h0rNXfHif79fJ4RY53HvgOnpAw038+h38pV4eZRdA7XotWGtoaAyGX1Hsvnz2wkd4gQo56SdWaF7k/H4oFYkJbMwIWVDCmIhfqusz58pK8c5XegFyEUYeuca6fB/UB8ExTcQ1kryeZOTleA8RgNJ7E+TjpLRXT/KtsS5TT0e1LIOyqWhIBePXZ9ElwnPTyFu4Df47/NKgNZtxfT98qcjyTSxMip+mLl/wSb8ety9AfEf4zJOwfjFXS5udDUG4gTwtge4HgL4Wz3wRjDmfzg4WQl35NuhfHOSbbsF0IJ4feNp/PemM1yXvpQ/TmD7rGXMolnvXWxdjh/XSVUjYxvgmZ3UF/Ii6O7M33MShf/RcEh7l6aYdIQ0lBbdROdLSm8loKzZ/A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDFJdzYyS1o0cFZwZ3RkZmJzZTI5U2d3RG5hblNzcTJuQit3cDE4aVE5a1o2?=
 =?utf-8?B?VzNYWlNZVG0zejRBbEhaenBvclk2MVNoalRrRDlWKytzcEdHT1E1aXlMZUVD?=
 =?utf-8?B?LzIvU2RIMktLOHFmUmFpZWVudUdHK1ZEL2p2MkJpMkU3MVFJL2ZOaGo3RndX?=
 =?utf-8?B?dE11Y3dNdGJueWY0c3dmSWpWQ0ZPQUZqL0tFc0FMUkJiZmRndjhjSGk1Tlk4?=
 =?utf-8?B?WTlobWpsbHFCbW9pVkNsVFhWWDdkbDlFWHoxR1JpblFVa1N5dHU4SkxIZnNt?=
 =?utf-8?B?cHF4K0pZK2pMdC96WVV0M2QvMXl4N0UxaWNhOEE0YjlzRHM3WEJQYnNobGNW?=
 =?utf-8?B?YUtUSktJYmE2cVArUW1ubUxjVFBieEFtem5FeEZrVDJBY0JTNlpmQko2bFJI?=
 =?utf-8?B?WkNLL25pOFFkdlVHYWd2QjFpNFl6QXkxbDRnSkFQdnJRWldhd1lqTkdyVXhV?=
 =?utf-8?B?ek94dk9kdUFhdEd6Y00vVEJDYzRiWlhSM1FqUk5ETkFWWXFMQllIbGZ1ZUJ4?=
 =?utf-8?B?Q1ZCb2VYUExncThyQ0h6eFdTdHB3SGtKK0tNdmw5a1JHOUF1VWVFSG5zcC8y?=
 =?utf-8?B?bXk2Q2ZVVTBHUE5na2dXWklhaUFyY2lDMmRLeFhNbmtKMnhFRnRHQ1Z0MDFt?=
 =?utf-8?B?STVXd0Rmc0s4bmNSaytRQjZkNGJDTERJWnVQS0JHYlQzZjBqUE56d1E2aHAz?=
 =?utf-8?B?M3R6bmdPNVNmS3pXVlVRK0F2M3g5WEFqR0cyQmNsUDM5bDN4RVZXeTNlNytE?=
 =?utf-8?B?aU9yZEphTk56RlEvSkR0VytyajUyeTFJSkErK09qN3NJK29rTFRNYjBjRWdk?=
 =?utf-8?B?ZVo5anAzbXQvSWltOEtSYkdrbHFTa0xpMmZuOE0zWTIxSlJmVk9kZ0pQbyt2?=
 =?utf-8?B?aSsvSHdSYXczMVNoWjkvbE5tYWVhamIyMUNTSEtoREl1TTBJTTQ1dFdMZFpl?=
 =?utf-8?B?VWJ0M0tEQ1JyQXNYZlFzZS9FS0Q3K09idVM0SXkramtXSk50NWZhRjA1c2U5?=
 =?utf-8?B?SjNYVDZEZnBJdHgrTmlJYTJzd1ZydEVjYk1ZRENjZElrTXRrYWxtS0RXcHF4?=
 =?utf-8?B?NXVrRW80VUlYOFovUW9VekVWVm5odnJva0Fja0g0VytRQy9YU3h0RFFjTjcz?=
 =?utf-8?B?SUt3dUljSVNmakpBY0wxMzBnOWxnOUpOZW1YRmx1K2ZnK3VhYTlqUEloUFNa?=
 =?utf-8?B?cGFiaStRci8zYUJzRXhZTzdNWS9hNklyL0pDNVNEZERsVk4yMjNnVjhwbkcr?=
 =?utf-8?B?cm9nVzRkVmU1NmpGYytVd3Nza0QyTHJ1K0t1TTBsRTkxRnBSeGs5NS9YQUd5?=
 =?utf-8?B?ZGxvUDgzQmo5OFpmNmxHK3F2bzNMU1ZKWnAwVGh2NHYrVm9WYTB5L1Q1R2lB?=
 =?utf-8?B?TzRDN1Z1ZHdmUzNqTUFLVXpQbnc0VTNaZDF6L21rTE84ZmY4aUxPaFgzQW1R?=
 =?utf-8?B?YjY1Tldpc3djRTNtR0dYY3ZwRm9GVk82a0s2YkFWRkNjamhCUEo4RjludVpZ?=
 =?utf-8?B?bnlabmh1VnROOVQ4b3hNMTZ4WFVic1IxdWR5emc1aTJxR1ltUHdML251ZWty?=
 =?utf-8?B?a04zUUJyVjJVSjNKbkdZSnJjbldlMGtSdXp6QUk5eFppakxvZ1poOVA1WkRw?=
 =?utf-8?B?VlB6VjQ0TmxlQmdCWE0wZk5rOXZxOWR6RE8vNUNjVC9JZWRXdzAxK2tsVHF6?=
 =?utf-8?B?WThDUlU2MndlYTJSZms1OVFuVnUySFpVSzFNQmt1Q0xOT3lEcVE4TGp3czhr?=
 =?utf-8?B?c1dkNmNmL2lKOVBtUVJNbkI4SnV0STJwOEZTeEdXUHFMdzg2L3pJcVhTK2Z2?=
 =?utf-8?B?SVVrTDJMT3hmdWlBZHgrQXN2UlJLVlhCdGVZRitMOWxMTkFydFZFWmJweGlJ?=
 =?utf-8?B?aUw2dGN4LzQzMk9pS2EvVHh2Um05bzRuWEp1THNYcDRxTTNKRysrUE01b0kv?=
 =?utf-8?B?M2FLemxHcU0zMnpPTzBzVThPVUsvZUJ3WWdjeUNJTlY4RGNxZlQyaklocCtj?=
 =?utf-8?B?T1ZnRW9NTS8wSGRYaUM1c20vQ3JOUm9WN3hxTFNZOUtGYWJGUGo2R1lZR2l2?=
 =?utf-8?B?b0FlSHZuQWFWeDExaEJGUlMzWVlla2dQWmFYaDNzL3Foc0QwYUtjRFdKUEwx?=
 =?utf-8?B?Vi8vRTFabUF6ZldVNi9XZE5hVlIveWU1cGNybjZjb1VFTm9KSUxTb0pIb3ND?=
 =?utf-8?B?cHYvaDEzY1lObFhwblUyM3J3SC9zdUlSVFMxQzM3cDdoQ2tHYUpkU0Q1cWdS?=
 =?utf-8?B?Q00vYWdXeFgwM3IrQnZZNEY2WGdpM0hFbVBVbGU5cThhZEZMYklhZk1IeTl4?=
 =?utf-8?B?QXV2bGMzTVZWQ2R5OWUwbGlxeHg4bytHaVF4aVhueU4yOC9YT0tYUT09?=
X-Exchange-RoutingPolicyChecked: 
	ILV2HfXngofJFAG8IpJOM7w/xbZbyvvwcdjSv3Azm2E0AVW1DXtXmyq6ZVvCoHVkz5aMRKnfZGiCAptq/pmMRINkj8za5Pdo8x+oITmVbY0y/nni84BJPTwfXaI+w/U2XuuAz8w5cpwY2kd5cc4q6BXSbQrD5xDgevobcTcuH4k6s4bCyx3EjUHDsmXlFQ4VIMmhIJG7GuFQnOL30PQPYAoY8PXbC1Rn/GFRfvvA2TI8xB+lcKtTMJZbpPztfzvsxq/dpcG+xUKl9NJedfOiWnDaGCUUXJVOmVPS2n+0CimU36Cs62AEGmUFDcdQj5AaXxWlhSW7AZI8NH0yg+6Hlg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b901860c-ee22-4345-5484-08de912eadbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 03:11:20.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJN8jsXn2ZUf/LjEqRnMLN/2SLsgnI7NyIttVbAV+XIN09C5xx1Jv6npQbcUAmx0qxq1zOXupX3IFd2g/IPlhKRdweV57FY0wqHcbgNnsBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6697
X-Proofpoint-GUID: fy1VEqdFZlzYe6mV0wkmPiBFfCNlfJ3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyNiBTYWx0ZWRfX4IAMDJ8v5fil
 VZlJdSTBkwsoSqCLviHQUi77OvJMIk+AENSlaLVHtnJygIeY+69+rMazjv4Jav996vrhzthk4uH
 2p9wuDEaKLOwcZ4x8FFSwwWVmhW3MZ+IaNx2csHAZI4AXN2x8rfZWcZDj4a6Y3yPWyxAQv+8qvI
 B1nJqbChxT+CkftP5P9jOQrQyW4nVN+o6uj5o3ghn5hHmPhshbKujSZVQ4SsUW95fRddus7fNSN
 NXR1SELlaE+KVpwDJV+bOKqrOR+M4a2muDu8hYmBm9aAGEUSuCi6U/YbJUIQ/wfk/zE9hpkwg55
 +GShBkBspOW8oZkYMzXczhpm8FGePnswL1ukFWBePNlnH9Y9rK2VzVoydcj6woFdwkL/Py90oki
 5aaGo1HhjbTFen6dPIOJi+kUACntpEj7MIRb+CWA1ltOSiBgtOIvA63BoYd+6bbdQSTLz3xMVBD
 qms+Vu6jtmhhBvU3TSw==
X-Proofpoint-ORIG-GUID: fy1VEqdFZlzYe6mV0wkmPiBFfCNlfJ3n
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69cf2fdc cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=pGLkceISAAAA:8 a=2-h0LiQZbze1zYPN_voA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030026
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 03:11:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3622

Thanks for your contribution, merged

//Hongxu

On 4/2/26 08:16, martin.jansa@gmail.com wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> Fixes:
> WARNING: Option 'local_cpu_resources' is deprecated: --local_cpu_resources is deprecated, please use --local_resources=cpu= instead.
> WARNING: Option 'local_ram_resources' is deprecated: --local_ram_resources is deprecated, please use --local_resources=memory= instead.
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>   classes/bazel.bbclass                        | 4 ++--
>   recipes-devtools/bazel/bazel-native_7.7.0.bb | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
> index 43e2c9c..085eff1 100644
> --- a/classes/bazel.bbclass
> +++ b/classes/bazel.bbclass
> @@ -85,11 +85,11 @@ def bazel_get_flags(d):
>
>       if d.getVar("BAZEL_JOBS"):
>           flags += "# From BAZEL_JOBS\n"
> -        flags += "build --jobs=%s --local_cpu_resources=%s\n" % (d.getVar("BAZEL_JOBS"), d.getVar("BAZEL_JOBS"))
> +        flags += "build --jobs=%s --local_resources=cpu=%s\n" % (d.getVar("BAZEL_JOBS"), d.getVar("BAZEL_JOBS"))
>
>       if d.getVar("BAZEL_MEM"):
>           flags += "# From BAZEL_MEM\n"
> -        flags += "build --local_ram_resources=%s\n" % (d.getVar("BAZEL_MEM"))
> +        flags += "build --local_resources=memory=%s\n" % (d.getVar("BAZEL_MEM"))
>
>       return flags
>
> diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
> index 042f456..3b81be5 100644
> --- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
> +++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
> @@ -35,8 +35,8 @@ EXTRA_BAZEL_ARGS = " \
>       --distdir=${TS_DL_DIR} \
>       --color=no \
>       ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--jobs=${BAZEL_JOBS}", d )} \
> -    ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--local_cpu_resources=${BAZEL_JOBS}", d )} \
> -    ${@oe.utils.conditional("BAZEL_MEM", "", "", "--local_ram_resources=${BAZEL_MEM}", d )} \
> +    ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--local_resources=cpu=${BAZEL_JOBS}", d )} \
> +    ${@oe.utils.conditional("BAZEL_MEM", "", "", "--local_resources=memory=${BAZEL_MEM}", d )} \
>   "
>
>   do_compile[network] = "1"



