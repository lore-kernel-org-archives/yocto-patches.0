Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301AFD9E36
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 03:33:28 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87716.1772163204178406000
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 19:33:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=gRv0g/1m;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6518b1cadd=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2L79C1645018;
	Fri, 27 Feb 2026 03:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=2Q2RttRrW0knmMZeF/wIJw
	RauZ48CuGyPYq8YpWPKnI=; b=gRv0g/1mDRjBTl3X2y1TzSoCCgcebH7DMWjy5q
	IrfrWO1pexjxzaR0Tvrya/z4St/xbxNKXQe6/DrT+FoUYGXWBMcHbQIKBSnxxSaS
	m48jRGENpm9+h+5e4WCRSlxpoeqSjzZjCPe1os2KM/nO38iVCxQCpJTBKLAGJXbp
	X4JIgKKhntdK5VmDNCQQXBMil/SVdx+FGstSnOFQprzyczicBuXfR+cKLWTj0I2/
	7hkTAe6mdZpolhXrl2XpMkOXh6G0FVGEVZPJFQN9yzMT1goThJv0m3M27wuJvATw
	VM6mH2WnV0M0WRX61W9JMEENpMVWYAsLSMiiMCJHh3RvJIDg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cjdtmhecv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 03:33:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpBMYsN929HpyhwobGhK/jX4ifltBDa6pVa4g+DchXXKxHYQIP5mvm6l2BTfGzQWCWb8fRwzv7U2FfhozdZ+j++9Hz/ql57aTJWAIRIEnu8YQ3FOJhSuEMRSTmrkC3pjD4VlJ2WWf+06hEGrvy5l5Ij5cLZ4MkQARX8uhqb6BSvSl5/i1xQUs9/bfXPF+P4a73SC8EKaW28HgU7sLxwb9852WALU1RmbtxHx4HhnYIcSfrkx0PC9KpYwZ3kJ/oc074BM0NkLAI7yvh93+sy9KXykrCcOFcqQ1u9kgEdtyacQcb8SkGzqKOzbvLqyyDceWx39zFkVPbI1PaaH4jqUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q2RttRrW0knmMZeF/wIJwRauZ48CuGyPYq8YpWPKnI=;
 b=BPgcTVfqvduwGjC9GcRX7QyhVwrohV6YsnQNk5IQ3I+feohhYoi5ODRzmCjjdZ4CrADaDxx+RI3/yBiQZE3KWG9ZyslXRKoIjOu1mMrITJv+N1fBr++RFHoWEhfMmesopKtKGfusVEqe2cCzti44RvclMH+11Bz821NYDlES9ieJ/tJwW3jeqqTuBuJHg4GuPGTBEn31ovW2T2a8QZ7JWQBIk0m6ET0j6U/CitRxp1DXDBoeycJfgsHI0BmQug2agjQ0o6ncX+C9b2kxX9m23KQTl4OKbwXzXD5cWopiEYYvClam330UBTl1zlJlXqah5H9AxI/hNVkSDmKSJGgKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 03:33:15 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 03:33:15 +0000
Content-Type: multipart/alternative;
 boundary="------------K1T4tp0SAXNjZ0hxlHm4pU6Y"
Message-ID: <923dba8d-6ae3-4dc0-8fae-fae49181c423@windriver.com>
Date: Fri, 27 Feb 2026 11:33:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] Running Large Language Models Locally
 -- Contribute meta-ollama to Yocto
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>,
        Koen Kooi <koen.kooi@oss.qualcomm.com>,
        Ross Burton <ross.burton@arm.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
 <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
 <1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3563965a-5d6a-4e57-8f31-08de75b0f115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	riwuDnzIguo8wNA3vbjDLLXdg/Ubel/W3XmlBaftoFR92LWI9sP7+Fx7nUgJ1N24zRQYOaGKogLrm8fbuQX1Ds71dxPVSQILeGgaXxHBZm4JAnBGbb1rZ8g3kxuSTHd7xdlSZDAsCtq7eDqHm3OeXJazvCDo3LkPwgEEPPtDkqNPGQKBViNFAxIAk8YlTWdkwLXIA7UPpJ8uA1sTs41kdOhVgfOQrMlxSlhpFHVpHaIfpqtRey3c+iWkuzV/uBaQujIcnp7POoP4cmmMlsiC0v8taFu5dSSG8r5ZQpVMe5h9XthFfZcB/AIF/UGMYhuDs5qLWJmrjJZIPRmhZdInSBOikfXx9QrtIXIIkgupy/4FiE9nbWgoSJOkNLxoNG1hgD8EUwsqAzi3HphD9nDgKzzZe7N23ThG3jSooN+/ikDTyrVtUZad8wF6CvWkMgz5ZsKJjNjZXT53U/rONQvY9WPLQI89zAfTYqnLtkbRy6xSIgBM4e1ztSn4Ze3vX+uKBzMDjhZmy8bwXitx/quYWe34UOuopKKjmu4hKGv6H84DZXlMpVeorWgr81NHYLPwQKRuprDC9mAT480adPcYx6iQ5FjqkJ/5x7IxaUXDRKGc2nORCcqc9GggLcSqlODeDh8IEfmZlvAZxDiorAVe/rs+jjmq4tiRpU1yXf0O27jMW9MMmNe4wTaO+RyfddEAAAnNxtf+7G8jEVTyM9iaIXqq27+JYAV9/j9PDuMBnhg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODFXVFJMbHJ4RURkaU93aVlvOVdnUWI4a1FydDJDd1hJOWpzN0c3N0UvQ0hT?=
 =?utf-8?B?aHhJa0xoOHNkMkxXdnF5eWxtRXdtZWZZZ0JIcmQwMnlnd3lLK2hwa2ROR3hB?=
 =?utf-8?B?L05Xd3U4UkI5TGRzdVhTbm51ZGI1dUJ3RjB2NXhQb0FjM1lTSjM4S3lOaSt6?=
 =?utf-8?B?ckp1QVJLSDBMOFFNUmVkbVFXU0tyeXMxWU50VFJMakJaaXRJLy9RR3BtSDJC?=
 =?utf-8?B?aWtCQU02Q2YvbjRMWjJOK0tsVzBjQ1drT2FaaElDQ0lTbmt5VFI4cjlkNW5k?=
 =?utf-8?B?YkFBV0pTdC83R0N4M0hkamV5WnpwdXpValFiOHFHVE1VOUdCRXpuRHR5K1Y2?=
 =?utf-8?B?c0VjMjBxMlFkcU5BMnB5U2JuTzRLY0VaTzkyMFpGb1E0KzV3NUJiYnNyTEpL?=
 =?utf-8?B?YVk1T1JiWmZTR0dQRExJZTlTa1NId3lqWDlwR1dMOGRISEFVSFVHRldVdXNu?=
 =?utf-8?B?WS92SnRJUWt6amVoUFFhT0xVZTBiNGxMcUI1VUIvLy84bUNGNTlPakJHdmlK?=
 =?utf-8?B?ak1Ya0IwNjVRVG1ib3lka2JVWjZxaEMyRWRwSmhQOXo5NXp3MnpqU0ozc2ZP?=
 =?utf-8?B?M2hDZW9SbXNwUGd1amZnQTZTWWtrcHJXdzQ1VUxaNXBDQnc4Vk9QOHVUdjJv?=
 =?utf-8?B?OUVML0hOSWdKbnJDSWdjUjlQNnJLNHFQVGQ4WnR0YXlBMkkwdzdFMGp2L1Ur?=
 =?utf-8?B?NWwvZG10dGdRV25WdDVYZksxZzdIU1NtUGFMdWp6VUV0K3gwYXJSSmJkczdl?=
 =?utf-8?B?SmFZN1FNNWhQUWxZbVN1RWVJWFcvMUljZXYxRTFUVFBTaDlJWjNUa1JRUjQ0?=
 =?utf-8?B?SkNoMnVseTZ0QWpOZnM2R1JEd2dSMzB4amxVY1l6MVVNSXN1N2ZNc1hKRkpj?=
 =?utf-8?B?WWthM1haVnUyNWJMQXJHZXhLQ2p1VUJSYXI1YThRTGJ5K1Q5RGZoTXhBQWsw?=
 =?utf-8?B?ejlPZGt3Rng0a0FEaTVGUGo0NDcvNWJhN2wyc0JFb3JjNTU4SHdhZ2ZUSkdC?=
 =?utf-8?B?NjZiR3BSTnFma0taSnlpMEQ2TFE3RklsSTUwQUVIbGNqblZENEc3djVkVEpJ?=
 =?utf-8?B?dUFobFVVa0RqMEorSXExWWt6cG9pck1XUWozWXRvWEpSbmVteDBidGlQNkN5?=
 =?utf-8?B?SThLN1NkVjgwTkhQN05RcGs5RGh5UnlTSVFJa3QvN0p6Q1l2b2dSZEhyMjBs?=
 =?utf-8?B?QUxjYldEVGpSaXI1S1dObXZ3RUY5SWw4L0VBcjhIZzZlRVpkVXRkWFlwbUhx?=
 =?utf-8?B?N21hSE8yNGJQQzA5M2tpSVhPSnkxQTNwSU1PVDM1eTZJYklzUUFTSlFHME1l?=
 =?utf-8?B?b1d2b25OOFhzN2xVRHJzNU8ydXVxZ0k3djZ0SGZFTjJYcVU5ZEczZW92TTRR?=
 =?utf-8?B?SXJNMTRlaEVWTmFWYkhkZDRZcTZUenpCN1lOL2FNVEwxdWJ0TjMrUTdoMGdy?=
 =?utf-8?B?MWtpeXJ1RFdCUUhCN0pINEpxRjZGS3pUV1RqWGZ2L2JSNXRiUHRic0IybXhL?=
 =?utf-8?B?aTlyMlo4cHh3a0RRQlBpUnU4R01PcXloaDZQNkJIRVhFNzdkazNRbWZINVBJ?=
 =?utf-8?B?Y3hlUHpra3Bvam5GMlMzSXlUaGgzZWVTSTUyWHhpTDFLTWxFYU5BZWRiQXAw?=
 =?utf-8?B?Z3BHbnUxeDkyaFNSYWdaRk9NaTJBQ09mMlNrVFRrWXVUdVp0bUtHT1MvWXpD?=
 =?utf-8?B?ajhPM1VKbVlBSG1iVFp2dmo2UlQ0dGh3ODZZcGVYV0pTelM5WEpHS0hkaTky?=
 =?utf-8?B?QmU0ODl5ZmM5eGRmMytoeE90NTEya0I1WjlsNFRjMHdQdlRmL2xVUU5UYUhC?=
 =?utf-8?B?UTY1aFpmeE54U2M1NTBwOU9zMzlsVVdLMWpZUEJ4S21xSVNqb0FMUXN2U1pG?=
 =?utf-8?B?d0krT0Q4LzR0SDJvbjZyMVJNWTNTeTFvRytCY1diMkR3UGVSU0ZmNmJXSjlv?=
 =?utf-8?B?dUZLR2ZhQTQvbzNoV2d0Vk1HUWxsOCtxUnR0TWx2amc0R3kybGh2OHdEZllo?=
 =?utf-8?B?R29XNjZsTHR2VGZnMGprUUtmbTgrcldhY3RoWHRnT0NaL3NnMWpadENsMUYy?=
 =?utf-8?B?TGlaK0t4VlF4bFprZE0ySVRLZjA4MkFjV2k3MWI0RU5mTmcrLzhuc1RkS3Bu?=
 =?utf-8?B?RG1rTGJDMENGWmJxNmNkcUV6ZGVnM3F2ajBEem5tMWpXWW5Ed2tvQWJFeGtH?=
 =?utf-8?B?bzNIOG1DbEwrTzJNMzhQWHdOb0VjaTI0ZTc4MTY0U0NOOEpIemh4dU1HVDE1?=
 =?utf-8?B?eWhuL20yMFM1N20zTGY0YlJhZm43QWlOVG1wV1I5Ukl5U0c5bi9jWFBPZ3BK?=
 =?utf-8?B?RUNPRmZYM3htREgzUEJNdGovaDdtcmpYQThVZGVqOU8vdGlaL1djZz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3563965a-5d6a-4e57-8f31-08de75b0f115
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 03:33:15.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoCGqGmVkuQbSHCNngiKO2TnsA2f6UjccARcdjeJrH6gpIr1Aev7lnyG5TFc5kyWCmeH9sfqFb/+W+hkWH35Lp8kBuFc30q+LO1DumTeEpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyNCBTYWx0ZWRfXwthH5SSNvzfI
 XUSclCmKr1AJbvmD/0xWTbsxOeUffBdBk2wzRJdtQW71A3LUherB8hKR9Oq7XECv0QfA6MTCaps
 6UjgFvwdjUE/6EiAoDdSCh+clEqNzCyX4XrBubgIHPDZeaLl8PXoDCncAPefugztIPl22UWcBjO
 XsqMtR9kIlS0c689504U42F4Q46raB83CQ3oq0iuTiGcc/K8gJFcLb/7r42NbywF90+GOlfS1uU
 mQ0hMRP9iUoVCLvb07NBXAU3B1Lqio5EZgqHEN/6NMpLkNzfPGei/eY714w85w4ZENIxjydACoj
 wISEwiSbpGj8yFINcU6bj7rgTfCOp/iNT732lTFy0JyR6r6q/bOp6HHtzDnbY5n1aOvYKXiGsj/
 9RJiXSXLFt1o9v5Bbj1FppKHuLrGPA17FNZ49q0IuYOzpOJqnPe0OqTheCoKIHXUFcpzjIYKEHF
 F56A43Z2b8AO7wT/qMg==
X-Authority-Analysis: v=2.4 cv=eKceTXp1 c=1 sm=1 tr=0 ts=69a1107e cx=c_pps
 a=FOw1GTnNYXmOwZ/eduxC4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=Q4-j1AaZAAAA:8
 a=OgA_oIkCL_4pcP8sIgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ag1SF4gXAAAA:8
 a=LVVdaqqDU9W9cF4QaU8A:9 a=7LYsWyu0hFIc27e3:21 a=_W_S_7VecoQA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: b-m0eAAgTzZaNRhgPMNnvZYSfVer3HmH
X-Proofpoint-GUID: XZ17MVVBO9FhLc_OosbpeBa_6Gw0yoWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 03:33:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3296

--------------K1T4tp0SAXNjZ0hxlHm4pU6Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 61R2L79C1645018

On 2/26/26 22:20, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Wed, 2026-02-25 at 13:22 +0800, hongxu via lists.openembedded.org wr=
ote:
>> Ping, what is the status of the approval from Yocto Project TSC?
>  From the TSC perspective, we were waiting on the answers to some of th=
e
> discussion/questions that were raised.
>
>> About the suggestion to rename the layer to meta-ai or meta-llm and
>> collect other LLM applications, such as llama.cpp.
>>
>> I am open to it, but I strongly insist to maintain meta-ollama as a
>> standalone layer, further more, if we support llama.cpp later, we
>> should add it as meta-llama-cpp
> You mean that you don't mind a meta-ai repostory but within that you
> would want meta-llama and meta-llama-cpp to be separate layers?

I am open to meta-ai repo, and use meta-ollama and meta-llama-cpp to be=20
separate

> The other key questions I don't see answered are with regard to:
>
> a) contributions - is this open to contributions from others? how would
> version updates work? what testing needs to pass for patches to merge?
> Basically, what is the plan for maintaining it?

We are open=C2=A0 for others to contribute, we promise to maintain=20
meta-ollama or meta-llama-cpp which is original created by us, and try=20
to keep them as new as possible, promise to upgrade them >=3D2 times per =
year

Review and merge the contribution patch if normal build is passed,=20
currently we do not have sources to support oe-selftest, but Wind River=20
Linux have test resource for normal build

If we have co-maintainer to contribute other sub layer, we don't promise=20
to maintain them timely.

> b) specific architecture support - what would someone need to do to add
> support for a different architecture?

We prefer to keep sync with Yocto/OE-core policy, currently meta-ollama=20
works on x86-64/arm64, and verified on genericx86-64, qemuarm64,=20
qemux86-64 for public BSP

We do not promise to maintain for ppc, riscv and 32bit arm. But we are=20
open to accept the contribution patch

For Nvidia GPU, it supports CUDA on x86-64 and Nvidia orin BSP, but only=20
verified on genericx86-64 for public, the Nvidia orin BSP is Wind River=20
for commercial using and not public

For other GPU(such as AMD ROCm), we don't not have resources to support=20
them, but we are open to accept the contribution patch

> c) specific feature support - if someone wants to add a feature
> WindRiver aren't using, would be it accepted?

Yes, of course, we are open to accept contribution for the new feature=20
that WindRiver not using, but we don't promise to implement them, and=20
only maintain them for normal build,

//Hongxu

> The TSC needs more information in order to be able to make any kind of
> decision.
>
> Cheers,
>
> Richard
>
>

--------------K1T4tp0SAXNjZ0hxlHm4pU6Y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2/26/26 22:20, Richard Purdie wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

On Wed, 2026-02-25 at 13:22 +0800, hongxu via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Ping, what is the status of the approval from Yocto Project TSC?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
From the TSC perspective, we were waiting on the answers to some of the
discussion/questions that were raised.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">About the suggestion to rename the layer to meta-ai or meta-llm and
collect other LLM applications, such as llama.cpp.

I am open to it, but I strongly insist to maintain meta-ollama as a
standalone layer, further more, if we support llama.cpp later, we
should add it as meta-llama-cpp
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You mean that you don't mind a meta-ai repostory but within that you
would want meta-llama and meta-llama-cpp to be separate layers?
</pre>
    </blockquote>
    <p>I am open to meta-ai repo, and use <span style="white-space: pre-wrap">meta-ollama and meta-llama-cpp to be separate</span></p>
    <blockquote type="cite" cite="mid:1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
The other key questions I don't see answered are with regard to:

a) contributions - is this open to contributions from others? how would
version updates work? what testing needs to pass for patches to merge?
Basically, what is the plan for maintaining it?
</pre>
    </blockquote>
    <p>We are open&nbsp; for others to contribute, we promise to maintain
      meta-ollama or meta-llama-cpp which is original created by us, and
      try to keep them as new as possible, promise to upgrade them
      &gt;=2 times per year<br>
    </p>
    <p>Review and merge the contribution patch if normal build is
      passed, currently we do not have sources to support oe-selftest,
      but Wind River Linux have test resource for normal build</p>
    <p>If we have co-maintainer to contribute other sub layer, we don't
      promise to maintain them timely.<br>
    </p>
    <blockquote type="cite" cite="mid:1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
b) specific architecture support - what would someone need to do to add
support for a different architecture?
</pre>
    </blockquote>
    <p>We prefer to keep sync with Yocto/OE-core policy, currently
      meta-ollama works on x86-64/arm64, and verified on genericx86-64,
      qemuarm64, qemux86-64 for public BSP</p>
    <p>We do not promise to maintain for ppc, riscv and 32bit arm. But
      we are open to accept the contribution patch<br>
    </p>
    <p>For Nvidia GPU, it supports CUDA on x86-64 and Nvidia orin BSP,
      but only verified on genericx86-64 for public, the Nvidia orin BSP
      is Wind River for commercial using and not public<br>
    </p>
    <p>For other GPU(such as AMD ROCm), we don't not have resources to
      support them, but we are open to accept the contribution patch</p>
    <blockquote type="cite" cite="mid:1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
c) specific feature support - if someone wants to add a feature
WindRiver aren't using, would be it accepted?
</pre>
    </blockquote>
    <p>Yes, of course, we are open to accept contribution for the new
      feature that WindRiver not using, but we don't promise to
      implement them, and only maintain them for normal build,</p>
    <p>//Hongxu<br>
    </p>
    <blockquote type="cite" cite="mid:1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
The TSC needs more information in order to be able to make any kind of
decision.

Cheers,

Richard


</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------K1T4tp0SAXNjZ0hxlHm4pU6Y--

