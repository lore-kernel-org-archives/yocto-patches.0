Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEA1076370
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 05:34:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6245.1775021664321490103
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 22:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ksXCxgzL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=855165ed89=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6315TwoY896649;
	Tue, 31 Mar 2026 22:34:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Dkpix7YQ/iT3fbNbf6h1nMWQ+ACa+ATGhC8mnsNZTPg=; b=ksXCxgzLZDti
	ASgy3678aGepUUC44KjzLv0grwSiDdKGFaq9IW6uwkISLCNq98eahNIIbiOBkiQz
	f/q/6nQ84FC1WZkUdmoiXrbOV4dxuNO7rDbsLr3h8QqSbBoimdLiN2RINncSp8yC
	OuRp8FnbsBYw0MjBbnllFquCfxbuj7Gdg6393YaY2nvCu1Qz7Oh8YY2t3A/FDE3A
	RcCtG/rIKHa5+Izz0vlqnZt7M/8v1gVsfHyxJjej8Fi/mwxuQp6ZqB0zVFA1ntry
	M9V0G12zNDfQx53KRUR6BUaSfQjnXneYx+J3FxjTy9wRw6kok+njngM959xfQVQY
	qF+/UD2U+Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vctam-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 22:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTxQWtA5GmtFo8F6Wtti0yDaG74grqWServGwLsRgmk1iCvbKQKNDs9gn5QW9OIo+b9qfUGSFw8iiGrabQksei4PcHg8HLP+QQQZcDrhzyq5ebf5dakZqHu9OYtzvR3L4kIwyWijc0IqH7Te6Pcu27KvBPcqoHISguLfr3ILVfz/W1C/NIRlMUpTh9PmA+rL1Ca0SviWZF9KxLQ086/9DyYSUL0O14ootFdNi/OkUtdMDy3rtMdGe89+09LdDWk3ZQ0fhsPQe0avT5kMdz3BoFddAo+eNBsCYW9x1l2vZGmuf607hVgkcZCiViEIGQoOlDTWUUfeXa5um4pYzSjwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkpix7YQ/iT3fbNbf6h1nMWQ+ACa+ATGhC8mnsNZTPg=;
 b=hDC+6YQNCHEHcSQDywNScDXDN4QAklHF0Kf7nkBb/0R9sgalSpZmGOhBIN6GMWjGUE0NA06QSEgRoRo9GO9xjt0IJeO3XDTygLoKelX0aJXK82YOdWC87CgoG9LDXxj0MtJLY1Yw5ulWkcTuDnDId0YY0HHuVi5RLqt+Vlp1i+ljuN1orpNoIGOALfa9hw4oTkDG9aYroJ7EATpS9Iz8NctRddcRvN01qTfw2QYVKcA6SSCxwdJ96qxVmVKCbdG2qJfpedAUvvENVl1p/9SK/nTmCoc79i1FMZavly9zdpYteyQjxvUmb8JPybQe+wPdrkEMM2c7EW+mZsXKQX7m9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16)
 by DSVPR11MB9767.namprd11.prod.outlook.com (2603:10b6:8:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:34:20 +0000
Received: from DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a]) by DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:34:20 +0000
Message-ID: <9d3a3b8c-2b03-41ed-8ac9-49ae7ec174a6@windriver.com>
Date: Wed, 1 Apr 2026 13:34:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][PATCH] tensorflow-lite: don't install
 flatbuffers header files
To: martin.jansa@gmail.com, yocto-patches@lists.yoctoproject.org
References: <20260401053022.96757-1-martin.jansa@gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20260401053022.96757-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7621:EE_|DSVPR11MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2c2a2a-8c32-470e-88f3-08de8fb052c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	2mHgwYusdvkqB8dMdMJjU/4taTD8/Aw8NjwGgV7H3+cwN0YQrUvf7FHUdh4h0VMXwtn4hfgA0d4ILYf5ZfbJy6nefO0fue5GgJfXiuzCYyRskoyeBzut7JlC01CW+6z07zuBmYpEDhaz0DScGm13AdiqFDw6FPv8sl/xdIbogBHWok+67aXQOTJILYiKFIb7UWOxejzzpNO9pdEdSWW5Up/mNRs/Ga9kxj5A8v937lHJ/80zPrtf+NMPvBc2Gn1Goh4ocI5KQVdNOdGlPxuPNB5yKbTCfZcEDUxG7LLxOoOf3sWvwAm/w31alQ81LFo9dPkl/PH2rECcbcynvMQ64JnGPQ9A17xOUZ0kTUGTvQywpVEYik5DghxDGpifIpWgbfkRUB/JsgmkkOm5B5GE1OXGbqNweWpr6rYxKnxT0WecumGpxi+S7wPvxQ/RFZ/dr2eFkFsZI8cZmwDqjm3/YHP4fNDoweYixyTOrOw4GR8uS6IXp8Pwoo8LzqM/jzzcmV9Km2cE0nlaGOQDUoFkiPWSCqOnCZGq9G0eKZP6ef/bC9AOMr4M2G4n4LYB/fD9/PluSwexOttefAUIjFcv/4h4N851/ug1y4D7ZHtO+s4MmwGpD73LA2frYBw30cdRGdHQtfzzwqPXM+epm3k1otbqqxKIagDMMWyuYyPHpNGMeBfk1MKpgQx821P4tVbW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7621.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlZNa2J3dlJ6ZHBkMFNaMTNQbGFwanM4WmxHdFlaTElmM1YzZ3VwYnNJMXZr?=
 =?utf-8?B?UGsyckpYUEhsN1NOZDNTVlg2ZTZPcGRjNzhXTFVrMlh3RzN6OVFMUDhhbmN4?=
 =?utf-8?B?V2pQdWl0aHptT2xrVDFIZzA4OFZyRXUxNFJNTG1nWUtnZFB4Q01xK1FUSEg3?=
 =?utf-8?B?VVBoOVBFQ2xEajFnMk1SZ1FNNFNpRGkyTXBxT09Za1RkTExYOU1wTG92TzQ3?=
 =?utf-8?B?SC80Z1pZcDNnWXRTYVRsY3luTTJZUVZweFB0azVBWmZFcG5nYUJDWkY4WkRV?=
 =?utf-8?B?cGtUZkxJQWFlRzJteUdsSVBzNXI4dVpEZ0ZYd214bUZwRWR3TS9FbUJoc2dm?=
 =?utf-8?B?T3oxUWNQSmo4VU1NQzRBM2MzTkJCNXhzZDhvZFBCZkhSRWhQbWFrd2E2eU5L?=
 =?utf-8?B?RGsrS1hvdWRuS0NmTWtIRCs2VWNkaS9HUTBZUjR1OFRzSnVFVzVpdGdjVmFN?=
 =?utf-8?B?RXozMkxxQytrYkN3NnNWQVZ4aDAwMmlVbzJ0UUNxUjQwNEUyMi9wUVNoUUZy?=
 =?utf-8?B?N2FmSjJGbXJoK2ZuWjlBREU1cU9UVHFVR2tObFBmR1pDOE9JWWg4MDFXaDRP?=
 =?utf-8?B?OGJkRGhkZVhKU3BhbUt1Slo1RUV0Tzk0Snc5UlBueVlZeEZmU003R0cwRkJP?=
 =?utf-8?B?eW5uWTBnZXgzMkJVZWkvYm5TSFBvU2hkMGRGQ3BNOU90bmRPbHQrbFJGVm0z?=
 =?utf-8?B?aDJScGw2VENGNmsyS2dScmJrZUE5WVpKQnBBM2V2TlpLQXQremhhbUIxYTl1?=
 =?utf-8?B?bmRqUW9ENWx4NDZmWXhOaVVRdFFxRUhzRzgrZVlva01KN1hnL2VORXlBRld6?=
 =?utf-8?B?TUdWK2FsSmxoT0ttRzBXNC94WEJnRFEvM1VCQXFRaFcyVTY1TlAxcHF4RWow?=
 =?utf-8?B?Um5hNGJmc3FNODN2bUdzdjR0YUxQTnNhWExjQUxmek8zVDEzallPMWw2VWVk?=
 =?utf-8?B?b09sK0h2a3RreU1ZN1RrakVYc2xxeUYrYnRCOXhHeGRkN2pHN0xtN09YOFU2?=
 =?utf-8?B?eWVlT0VIN3hjdlJkL0ZkVEpBd2lsdzluQlVRUWhHa09lM1FaNVJ3cGc3TVlO?=
 =?utf-8?B?bHpWOVZmN2RhcVdlNDdmV3JBbWJrZE1FbE5PdjZjVGNINlZRckR5OExBajlC?=
 =?utf-8?B?dk9oTysxTzQ5Mlo0KzZqVkd0eTJUMVpqNGdFWnplb3BySGhsVVVOTERKNnda?=
 =?utf-8?B?eEJFWDAyaXJSTmVndVJ0Nm16UXZUbndSMGNvSGNsZ2JYM2JjcWVNRjdlVHd2?=
 =?utf-8?B?Z2JBYTlNQlA4OWordmc4bGlQV0VqcVFpV0RDcnRrN2cwY2E5dENHblVaa0po?=
 =?utf-8?B?cVh2WWMyT1pWTUs1Qi9yQ0VOTGU5RXRzOXV3WWx5SXE3ODdOenM2NVh2NjMy?=
 =?utf-8?B?UWdGc3lOMjhGUnd5cDArUlR6TFlRMS9MQ0hFMStpOC9DV2twa2lCVFAyY1Js?=
 =?utf-8?B?aitUeVgrdmFabWJKTm1wdlVZeUplY2FSdW16TDlFMlBDc2V5ZUpOcmNyWWpx?=
 =?utf-8?B?b1haM1Mrd294dmJ2cktYM2g4WDdVNnA5cFd2N1duSENBZS8xM1A0ODVPQ2lT?=
 =?utf-8?B?Q1oxQUN5NnFZdlB4MWR1RjZvYWN0aTErVytqelpydDc5MDU3dGVTYWpuaGw3?=
 =?utf-8?B?ajRJUVFpZXdCZ2JqN21pbTJ2M2tOb3l2a2VBMkNsbjJLdS9LbVNuRGJPa1Fa?=
 =?utf-8?B?NmtNUXcrQTZlVlRCQW5RTzBrV0dRWGgvVzFLM1I1cE5uUmg1TUcvYXRDUGFF?=
 =?utf-8?B?ajQ0d2hhcDJWVkhmMGJJRWozWFQ5NE9yNXNoTzFKZWc3QVU2L0RBUW9SYi90?=
 =?utf-8?B?UXljYW9GdWtIM1haQVJQUk5Yc3VUalFiOG5aSVZFTWJoQXJ1cng0dkp5OWRX?=
 =?utf-8?B?bGViaG9QMDJZaFZ5cTgvWHFXL09YazJEb0UvampBMXJieENlWTdFbG5KSndN?=
 =?utf-8?B?SnlsZU8xWFBPMEwvYzN3bU1PRVVJNFBkZ3FmM0ZNRThMeWpoV3o2bkpvNWtn?=
 =?utf-8?B?Mk9DbmNXdDVIZXBtS1JRTTJteWovaVJpbDFzRnhDVUJwOVE0Vit6dkRodk5q?=
 =?utf-8?B?SldXTjMwOTBtZDJQNWh2TU9xdVJGNFZnbmdEYTR0TTh4b09ZYjZ4eDk0c2I4?=
 =?utf-8?B?QTdNcXZIZHAwMkxyRkxKTkNOM3JoVHNHMGp3MkRBbGlyK1dsSGxBa1JJcnlY?=
 =?utf-8?B?SFFWNWpzWmVHSmlxRlVTVEJINEljb1h4Zm5GUnFXRklheUpMYlp5eEpXVklU?=
 =?utf-8?B?K3JHYURMc1M1akVKU0x0UWN2SW55Q3dHMUxUUGRBWFR3bm9wclBlektNNThH?=
 =?utf-8?B?RFBGRHJidC81dHBnRmoyK1ZyRmJoSWpiTnZDV3FQeXdNWWRyMmViQT09?=
X-Exchange-RoutingPolicyChecked: 
	GX/0+pkyjFug0R5q2Hz8BkizJmQQyi2772IgyPKPI7/i2D698YNMpE1lAuqDR/i+hryFcFQlUjqUScQu37PKsaKjhaa1nzuBEfTu5eZe14aUWbDmhtUc7bWodjmlnOG2Jv4cT2mO8GWcnndkC1YKyXghHi3/xXnGWOJ5BxCtBPXFOoO6K9NbNW2XlnXrpEgIhnz3eZEP9yxGVpmMzHLXE4Mb1tFwhyt9AjkjRWzb9rVLPbkBYyIIDAZMBpeYdarObg4PrjfrW2gMshcksdkcIji5PiEycE2QRMKuqRaRIXjejSr9dd/Fvz00x4wXQ5rHuqFGGWGFxrP5PCJGb2Si/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2c2a2a-8c32-470e-88f3-08de8fb052c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7621.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:34:20.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfSf1lN7QkmAdok4Mgzy1UhpShEVw5P9e91/o2rHBl9rht8gauAnrdzd7ivIUj5eZseDeCa5O5Wb03Wc8D+xUcEXBF0QKTn521p7i7bXvYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9767
X-Proofpoint-GUID: LrRWbOhqktfkNDACDSAAJzRnowrP1uGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA0NSBTYWx0ZWRfX+Cmo5yMyIHx1
 +q8V3pwkqHLUhbPf+BNFrKS4O3HGu/nLDuYm0WANB7qCc9mJG6v9Z9KfOk44m3BsvXLCjIHuHIl
 oetAMlQ/SuND75TGvIwr+io0QgRqpWfUDxI+z1oJzyuFi67FrEaDzUltkiMJQhiALz6bigzhUiE
 TOMUHfqBorwyDvEoUAT7kaulBJ3r6kkdD3+A/8sfSBhDCE/NoSU/CgdUQ8xJj0RLA9b3d50xrgM
 aNGjlZYnW4mK6etmlLjYCEPv5Tx2rfbXHfWQmVYyw13zzS9FPwhehCdRaRVb1v0jZGMMGHI+pTc
 ZqnRRESeLZTU1s44MN4T0jwUuNUakW5dJlWLd/Zo2KBWnkii5ohOsW0dNmuo1E3iGNQikYlQoaf
 bu+Vuqp7/ChF0LLiaOJuqRFg7cN0BoVRQq/X5M7vJF/PbqYLeWLkFfxbIiGv1AU2IZdXW+CRIaz
 L3X3PS1Jgb/a1zTULtg==
X-Proofpoint-ORIG-GUID: LrRWbOhqktfkNDACDSAAJzRnowrP1uGj
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69ccae5e cx=c_pps
 a=BmqlPTxv9Tigz04FbX2T4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=XDLBkkhQYpYFinbdINEA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010045
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 05:34:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3593

On 4/1/26 13:30, martin.jansa@gmail.com wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> https://lists.yoctoproject.org/g/yocto-patches/message/2186
> breaks a build for recipes which depend on both tensorflow-lite and flatbuffers because of conflicts in RSS as in:
> ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file /usr/include/flatbuffers/array.h is installed by both tensorflow-lite and flatbuffers, aborting
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>   recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
> index 41646df..4951fbc 100644
> --- a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
> @@ -123,13 +123,6 @@ do_install() {
>           install -D -m 0644 $header ${D}${includedir}/$header
>       done
>       cd -
> -
> -    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
> -    for header in `find ./flatbuffers -type f`; do
> -        install -D -m 0644 $header ${D}${includedir}/$header
> -    done
> -    cd -
> -
>       # header installation done
>
>       #echo "Installing pip package"

Merged

//Hongxu


