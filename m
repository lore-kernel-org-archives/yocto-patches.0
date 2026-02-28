Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72219FEE4C5
	for <webhook@archiver.kernel.org>; Sat, 28 Feb 2026 04:33:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.113888.1772253216608259164
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 20:33:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=c7ada5QV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=651954697e=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S4Lqn12590069;
	Sat, 28 Feb 2026 04:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cFpWEugxYyu6Vht6sTCirP6nQM1vMIPyna2ehNqZliU=; b=
	c7ada5QV7lBjknKlqnUNe2LU0laL5P1LgH5Ox0qMWpJR2iSuwVWci3w2wNJ5BhaC
	LCzPYZAV2P//eF3/C8XiFR+6PRq6pxZ0KfCd5BCAL7BF1X4td41w/paD/aolcl/W
	5r18Bh1YJNK/t3Mpa2T+VaPxEhtwrdvLoUTKJsPKTTx8NfuLdx4fbPKOPlNvfQPq
	H83TJEMqD/rtLb9Fyf/a3mbLUre+PusDthhygTletF4y4/kf/nA2S4lV2X1RpFQz
	iMTx3lEUQqJGxLtpsryAPssERGbm9X9fnrCdzGRb43lhyEHIc7tfyLlGlolzebS7
	MBH2bh68K3HyH03gXi1IdQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4g2wh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 04:33:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1APBpVM440C8vJEc15qcHHAY35knlIJyIoRXBuOYh1vbk/iUsW0tj6vQ5NhvsdZ8NXHep+pEUtxDGlRcC2JKZi7GE82xuHG7kS2o0HJQgiEOxYfOKMep3fFzbDBC5lHFc3kmtQdpjtZzHnyB31uFYoEmxCS3qCrHTcKTUOA5ckeK0vv0JifrTfG9QSjj7RnblMuAHd8Rda5QtBmVKIBv1NwOosw8/QezGj8Zhllp/ZvHLZMlwfp5/LKHGpfbDUyPrF1IBXN+RWNJ/1V8foW5/X+jUBdnOt0MthVGjuqbnHMLg0neA+u72bTlN5GZ/Ro3JasX3XFJUCb7SR2FL7oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFpWEugxYyu6Vht6sTCirP6nQM1vMIPyna2ehNqZliU=;
 b=uV69IHDDS8PEmFBPhLyBJjI2Fdhn7UaZmrqk7mYN3ZGnHduSXLHh9OOz+z7KdNG6Iu++D9KlVWL7fMj3ktfHX4IFW/MM24VEtY2F8ivETilbgjx3l42f2dHzUvddo4y3UuLYmVZRL67V1SBja2u2ZcfkPBsn8BBo5SHM7Ci7uGQQ2hinJ0EtQOfakHhc++2KKYm9BvkCRJ8SbTGkPqiZ1DjLJo3Dq6ERMZi0IiJ1svcHuwXtk6oWkOjieHbe2jeUSHxvV+v75RYm8WkDz5Rskrn0/5YbOLCAbfMfNdwLjUBZ5ub0/ZtCXEHSOCIVQsRp4q0tiZwJPF+ME6nMsmIC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 04:33:27 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 04:33:27 +0000
Message-ID: <6f5e7104-0848-4a16-9a4c-22d0d4cf79f5@windriver.com>
Date: Sat, 28 Feb 2026 12:33:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] Running Large Language Models Locally
 -- Contribute meta-ollama to Yocto
To: Koen Kooi <koen.kooi@oss.qualcomm.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture
 <openembedded-architecture@lists.openembedded.org>,
        "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>, Ross Burton <ross.burton@arm.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
 <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
 <FFF9C420-70C6-41C8-AD1C-7C815557CFF7@oss.qualcomm.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <FFF9C420-70C6-41C8-AD1C-7C815557CFF7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0113.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::17) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|DM4PR11MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c72de41-45dc-4574-1824-08de76828425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	gCX/svN1a5HaFcBuM9Uyl9nRtoWWYZZCJ2UD8pOsbfEWXEOCxzeq4hscYoh7bK8B3w+5uPaWxwNHNgLcx54mY8IdN63FvRuIN/rnClygXt2JP4tNqpG1mCtOUpAF6p0A4HfHJ8QBR4zPUDj3KXFfyXGMahEPJjCkX0+s9m2qLsrZBx2sGXVVV/MDckX7BQo3EpS5ae8TjhN0We7LIiT6kd41VG2+VeBeBDkfTWR2jwsS286sW1gbKqnIqbOJv1lTh0IEu3Y7VICmBUnALtSe867kiVaAqv26guwdD0JhOEPdgDcGrrU5IsfZyHD4SDpjlI7enNm/g8mqV7p9+aUqBqPSzzxjZa34XyAePPpuCDXoeaiOBI1VMUet3uOW8Rj02dC9b3LlKZL1LihiMKGr0hnc6rXsHUUX3SKS83e8Rd9LygRtThLdC+BS3Hxz6KPTxTrYpNbjV4ZEkADWYEAJa/3Ze1HyIH6rtF8ksfYJg2kuube4W4BnqZY2Ux49BYQbsE5XbpG9bBbsmokf8yxDywb2JZNQHlsG3cnSp+1wJC/iC6wadgISbGFDcHidaXIFGFsOAOf6nfYTyqUCtctwmWAcJC1zjygf30GxtzVWWhLNQJaeVeIUwocPByEhDbLQbql6cZkwoZekyMc13bZqhsIpURGOZjkfEfFlauXZiGMSLacPflTZSZi9oQAei0iU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXlKSTVYTitBMVc5THFVeDhBN3dDbWhOTnFqV2VaakhSaXljSzcvUHkrTmdZ?=
 =?utf-8?B?TVU4K2p4NHcwQ2VCOXVyeUVaRVFiakF6WTFhR1lWMTAwaTdOUVJ4WU1BNzgy?=
 =?utf-8?B?TlFGMmg3TkJ6ejlWSUFRT2VIRFNCRHdjK3ZldjNvakJHYVk4RzdGWTE0NTM5?=
 =?utf-8?B?VEMrcHkxcjhuYUpiSU9MUVdDNldxb0duZWtKSEJJeVUwOTdrTVJITTV6bnhs?=
 =?utf-8?B?c01mTDF2Y2s4Z3RjQnJmQmpEOVJCUllBMEZCODE5L2pRR1o2M0Rsa0dzRFk0?=
 =?utf-8?B?U1BheXBzNVRuOWpTWHlqSDRBMUlIVlVTU0kxQzFrNmRyY0dTWmM5UndTVmYw?=
 =?utf-8?B?UnRlRVBFQ3l1UkNkR2Z2a1dZUkc0UHpMV2UvNk8yaklMWG5CM01NcUlKeVFt?=
 =?utf-8?B?OGd5dlM2bjR4TGtscUM4djZranJGcFhaNnlyZ2VLc2xXOGllVUF5ZUdEYU5F?=
 =?utf-8?B?NUpZME5kYlVFQU1YS2pNMGlnUjAyV2hPcFFSd2JBZWN4eTJZb1pDMURmbG01?=
 =?utf-8?B?UnZoSVpmQ05kN09UbU1KRkZyQnlUMXJZbzQza1hHQmVVcmdmMmxKY2JyMDZv?=
 =?utf-8?B?VlpmWVlyYzhvWGtXSUpwZThaUWxVNWZmS0ZRNEo0UEpuTTRRL2hDYUt2eTZQ?=
 =?utf-8?B?ODdReVg2MXNTY3htOTJTYlFOZG9IOUo0TkZpQUh1Z0hUZVRCR3lGaForZFZC?=
 =?utf-8?B?eEJnRks5ZVBkZnFRcHhBNlpwbUppMjZmMDdtRS8vUXdNU0EwRTYwZmdCWDRt?=
 =?utf-8?B?YVJZMUdaUU5FaHBEYWIxTG5aaG5YVzB0ZWIwWkFWaXhvcS9TTmNGb082Vkpk?=
 =?utf-8?B?VktQNDBtWFR6REtBSjdkcFpxQmlrWGFJRW1xTURTTjNKNU1nNG5INE80Mmcr?=
 =?utf-8?B?QzZKZmJQRm9qTzRGVjJtcTZIWmJwMGlWa1AyV295cmZkeUNiZWY4cStLSzJP?=
 =?utf-8?B?d0VOUzJDcHdUUHBZUWxUbjhvSUVPUTd3MEJ3U2ZNZ2p6TW5xV2Z5UkFzNjJB?=
 =?utf-8?B?M1ljODRnSmdrZStETitrZ1hKWWJkSmpvUC8wQUhhQSt2LzlYSU9JamNYN21H?=
 =?utf-8?B?QlgrejhrWXh0OEpjT2JkMjlBbXhrOUt0VkMzVjBwa1ZjTDlTN3pEbXpwcm5D?=
 =?utf-8?B?UkNsOEV6WlFxWmRHcUZDYlZsZWljZUZNVTJxdzQyMTdLeXNsUTkrSURLR1dI?=
 =?utf-8?B?WnJFTVFRcWtybTByUWZwZkEvK01NQWpoZVYwNElqZHIwS0l5RVUxTFpORVVm?=
 =?utf-8?B?a2NzN3dCUmVGZVRkSEtQbUdQTitHd1gwd3lWS200N0Y3N3NhNlhaT3F5NEps?=
 =?utf-8?B?K25IMHY0VTYxWW00RDdCQXRwQllZczVqL1dNSE5qNWlWRnE4Q0IxbThENDlH?=
 =?utf-8?B?QTE0NTIrVlplbWt1YnRPY0JoSG9FQVVIbFFUb3VjaGVJcGpuVGp5Uk1OWlpV?=
 =?utf-8?B?NnIvTHdHbldsYlhVNWhLaStoVldtcDYzL21XQkZYNkNMMlg2ZWFsOFNzMmJn?=
 =?utf-8?B?dG15cFlBVzUxaXFJOWk2WjAyQWRERytEb2dMdXNBQjlFZzZYUVk2TGEzVEdq?=
 =?utf-8?B?aEFKUEJiRnBOK1B1MGxTK0JmMmtUVEZkZ0EyVVpxMklhb3Y4TDhFSzcrT1o1?=
 =?utf-8?B?cDV6ZTJzaFJUaHdoU1RDeFMrSEdDZ1puUU1sV2U4UXIxeXNGZW45eFVEMi82?=
 =?utf-8?B?T0ppek8zV1loL0ppKzk4K2xxaW9wc3ZxVDU4a2J3Y2lRT3RkM2NlanpXSXdX?=
 =?utf-8?B?a0dsSVpGQzl3azFNd1lQT0tzWjBRU1BoYzMwUjREeDBXZ3J3S1dZVFpTY044?=
 =?utf-8?B?QjFFUlhJNUpDcEZrdDBkWE1KQk1udTF3ZE4wTnlsRWdGMHk0Qm9ncUdycnRj?=
 =?utf-8?B?aU5OS1ArN1R0NG1GaFNJUmNKcys5cnlrVFZrVm03aG0ydGFqSDNwT2JtMEdC?=
 =?utf-8?B?SW0vUjRtSTdmOHYzeGljN1hNMnZZQkQwMDh6V3JrcWhzK2s4Y0I4SHZGR1ZD?=
 =?utf-8?B?OUhCNU1IelRsdldTN05majMwQ2VDZDhjVHZSTGhPajR4Qk9CUmVCcHZXV1V3?=
 =?utf-8?B?Zlg3RWZxcmNUTHlNS3RLaTVxQWVWK1BmaVlHVDZHTCtPb2NlZldLSjJ3SjJa?=
 =?utf-8?B?VVNIU0l6NDkwWHhaSUtyUlVvb2ZiOTlRZkVTSXJITHkzb3g5RUthaXRhcnV1?=
 =?utf-8?B?UGVtWWREdzViZlA5b21mb2szcmpVMmxhZGZRMFp2YkFGWnpUbFpKUE9XTmpH?=
 =?utf-8?B?V3VpRnBEaGxyNW1LR3FOVUN5c3B4VC9jQi9WUlBMeWMwRk5qR0g3akFwdkF0?=
 =?utf-8?B?UnV2Y0RwUXFzc2xxUjNMVDFRZk5OajdjeVdZNS9zVTJYejc5bGZ6QT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c72de41-45dc-4574-1824-08de76828425
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 04:33:27.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuTu8thOvv2uVf68RvBnjw/Yy63zuKVfKLzqr7CtBzNo5IX/iV6jir9rXocp0udhHQFu43j06tbQruYljoGYql8pfPGyX1XDQOmjtWJ6H/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7375
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a2701a cx=c_pps
 a=ButkoIHTjR5vDxq5MUTXqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=iGHA9ds3AAAA:8 a=PA-OPEjjAAAA:8 a=6GhHI0MbAAAA:8 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=HWESPXQTZJh4jLixR1UA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=-Hooo-LOM9ozjEiY9UkE:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-GUID: KXVSEgXti_apYEhg97Gfd4-_H6LKDUTk
X-Proofpoint-ORIG-GUID: JxRnbS4nw_UVvtAfOQh4zh0JHC4CnY-u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAzOCBTYWx0ZWRfX0cJuoqZODLWk
 1PHO0UWiSoOadz6lLku06mpGW77qfP6LmWlwlpxvHl3PNDi0r9JuEhLbHiQiDV350fSJ9qAYJhm
 xkYX+7XDdppWTHCywwuoxsRs/b5HWF/ZkaE2JhB7v8vO+IjUenMF17wS6G7JM6rBCEPGswHW1Jg
 AgKOTdNGrfkHCFnb52DUBfnq/Qr93IjStSJRnnR9QlvoC7Mdj07/o+cL6pzYNNA7yV1NpzRNWco
 bpTuvJkO65kVD7ws7EEoWGGIOgrcTt4aQzoz8XxBLrE12i+CbIeZ5wKuBLmFfdFClGz1X1ObENV
 mfoxSgPnopzIn7Uw4PrlL1pt57zzb7uLb1tLUioXMyIfLZFDdrZGseQrG8KmdItwswpiyrkU4vE
 iPe53BL0tNtV38Pv1yIaoMs+1pGYbgS+3qqykrvKoFR/GDcuEyPXMATJyEUAVMJ+8LclhN2qW8y
 a+KAmSGvVQvpjxiriFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Feb 2026 04:33:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3308

On 2/27/26 16:44, Koen Kooi wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>> Op 25 feb 2026, om 06:22 heeft Hongxu Jia <hongxu.jia@windriver.com> het volgende geschreven:
>>
>> On 1/31/26 00:56, Richard Purdie wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> Hi Hongxu,
>>>
>>> On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
>>>
>>>> Would you please approve to add this layer to
>>>> https://git.yoctoproject.org/, I will maintain
>>>> meta-ollama for recipe uprev and bug fix
>>>>
>>> Thanks for sharing this, it looks really interesting and I like the
>>> idea of it a lot.
>>>
>>> Also, thanks for volunteering to maintain it, that does help alleviate
>>> various concerns.
>>>
>>> Approval for this rests with the Yocto Project TSC so I have asked them
>>> about it. We should have a decision after our next meeting.
>>>
>> Hi Richard,
>> Ping, what is the status of the approval from Yocto Project TSC?
>> About the suggestion to rename the layer to meta-ai or meta-llm and collect other LLM applications, such as llama.cpp.
>> I am open to it, but I strongly insist to maintain meta-ollama as a standalone layer, further more, if we support llama.cpp later, we should add it as meta-llama-cpp
>> Then we could customize and isolate each LLM application in a layer, including:
>> - Add model recipe for LLM application, the format of LLM differs for each application (ollama vs llama.cpp)
>> - Boot up LLM application for Yocto image, add systemd service file
>>
>> - Customize GPU support (CUDA) for LLM application
>>
>> If Yocto decides to use meta-ai or meta-llm, I suggest to add meta-ollama and meta-llama-cpp as the subset of it, such as meta-xx in meta-openembedded
> What are the technical arguments for needing to put those into their own layers? As I've stated before, I'd like to have a single layer that has the most used AI/ML things and I can help maintaining that on company time. Splitting that into multiple layers would increase the friction for both consumers and developers of those layers.

As above mentioned, the format of LLM differs for each application, the 
model of ollama from ollama regristry https://registry.ollama.ai/, the 
modle of llama.cpp is from huggingface https://huggingface.co/

if we add a model recipe, we have to split the application name if we 
place them in one layer


About boot up management, ollama has a single server to listen on 
specific port for all local models,

but llama.cpp start a server to listen one port for one model, it does 
not support one port for multiple models, and we have software 
llama-swap https://github.com/mostlygeek/llama-swap to manage multiple 
models for llama.cpp


Currently ollama and llama.cpp are standalone LLM application and no 
direct relation with each other, splitting layers for LLM application 
will help use focus on each LLM application,

It is helpful to classify the maintain scope, based on LLM application.


//Hongxu



> regards,
>
> Koen



