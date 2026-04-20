Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A52F588C7
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 13:45:11 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20003.1776692707407079025
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 06:45:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=AtKeOlOj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8570f975cd=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K5BbcN2579828;
	Mon, 20 Apr 2026 06:44:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=NmuaVNYTJg+mraS8cnY39U3wKn3h28Pvbzzh1wpQRbg=; b=
	AtKeOlOjeEg0lJRWE0M8PeoQGQLhvHfML2KBDg0PKJf1vdgpLNAzIHIVauX1JIhp
	zWyHPl1ZS6kPevt16Pd2RiaiNmeHpO6+dwxCL2Zt7F6HxWOsF3s0omENH18at+H0
	q1Bd4oUFCHjN7Z9Hjp+70lexNqapCYwqTn7eDNJsWG0aCRQgIpScvRNqm9fMNKt9
	NEMg1TBespQKOAZVHHQ9Fh6XT/BuSWYAdtscgqgnrw/+FdU5lPxeWV77cDqAc7Kj
	FC9EsfsWAkXbpVQuI4D1REgUK0fDOkjRlMLD/h3AYhv+DsrPCTGhsPqSqmXv8v3P
	JV3p7bkq8o1pWsDrsrvMsw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dm9fcsraj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qk4ZvdCaeVEtD4pQRm3HZfdscKz8lxF6VlZ2oKTQSJjljNATPMAugCZS/6+Z63a9/Zm4q3T5ou9YvB1UT+UwaCRLy5V8u7PjaKFo4NmOeI90CfPiLG34NAAKEWiIbN8Y91vJ78jw7z2UZVHUcyOhRZKaoR39kUB79kpBQSdaSOrk+/v6wui+pAasrE76ZSkIe61qMdIGl2A9UaH03I62fCdQyfN1w7jCy9bne9Gs0Jdtrlv6gppvtCFiQN/TXyqwdgv9KQfjP5ZP1H6QYDNWNH7niEPc5dmt6I4yXxmSTFvTLY45N7guNnq3joTRAazjB59y6zA2GiLNtldVrJ37AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmuaVNYTJg+mraS8cnY39U3wKn3h28Pvbzzh1wpQRbg=;
 b=GqGmk0ZAODT55sC9tMpnYqwCuhlYVb7lNhxcOkyvz13Gg1iD/A5Ooqyiza6lnP7n7zBwFcBxv7qRc10zPBYzePmErPQhaJiaa9JHOX5F/YJcllCNHa4TXhgCV/BCVNFL3QJ26wOdm0uARGTPBazvq6AEeo9Cjcd5iZe6fQ1/B89oAcVPmmUJS47Z9yEN8lo9QxtvSPyCo8IPk1ZV5lYHMUfuHR0wmxF7WyS8LXSkpvH8N0yObgqHWryMZ8EuMznZMYLpGi/r9LxI5C+8wDxCtMkgoWYPDx3BeVgv5bM6a7iUVC7OCQBEuoXgqGHK7uqQJJ932w9tYZkGPMffiUp3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.15; Mon, 20 Apr 2026 13:44:55 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 13:44:55 +0000
Message-ID: <ba17bd6d-11fa-4527-89c8-21f8495f3eb7@windriver.com>
Date: Mon, 20 Apr 2026 21:44:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH]] libsepol: disable LTO to
 fix buildpaths QA failure
To: Thomas Perrot <thomas.perrot@bootlin.com>,
        yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com
References: <20260328155821.407004-1-thomas.perrot@bootlin.com>
 <031bf8f6-0b96-4ad1-8f84-8f9ba01acb55@windriver.com>
 <67d4c3642fdbd5c1aea60667dad6856374658fd0.camel@bootlin.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <67d4c3642fdbd5c1aea60667dad6856374658fd0.camel@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SL2P216CA0129.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::8)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: b2171fa2-1e85-407f-31f7-08de9ee3015d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jsPkunFhopGe/NRg9uO+JHuq41ttxvr6NnlpjsKSVKRtq/uNKMvR80XUwERJJBbMLrF0/vF9HRTc1Kydm+NCU4j1uqI8/M3pvEsDUwFjDVnlfnzZ4iAEClORG0KKD5suhbTFQ1w1r+QAgSD1NWAwZHyOnDQKG+wArdy1zOAv/QH1jhpm6gDG76eEhLZsPIg7Mf8dsOWh2c7hJifgxzz81RqsuHyZ8IhZwd6szB5ZuXYLkVi1y+Zxv5zwpt/XToJpzrFduU6u79IRH0XvXSn6yKGOdq3F3rrzEjCAIsSFEhvs/0sRt4dTcdXqm119kxDdsj0ldaTuGTxvpHhD/X+2A1/7ckzFrfqtVfHruKXNWdRU1h0ypNOAEeUbBIDHeR0CSJGSp8hLfV0g0ZSFVRCkOjyOYHARAhzIzn4XqZp0iUloz6qByiMjVPmv857ODa6wZ5SKBXHVcXDlHx7ZOEVOL6ewZgMkqv6l0psKQfLiVBjshFJjh+X3vdrjM41dJGjxP9PRxjgFWIHHxdIycTImDdQW5vqcGQ98IoLCkeMmOfSHJShaTLaRtXe+Xne0HLy56lMq2qX8Ur4Y8ZUPsrbfsSAEgRbomKgZ+W1xXFKv91BjbFtgO6k4BhC5bY/UkVdyMv+Sz5z/rvFSAgB+JJPNzhIlaP+R5ZLxxHJZ9iZOguGjVYtuP+CQkUuUe/efmTrQnO0kxreQUfsBgILqLr7fV/JAcTpSR2cLKbqEsWXsDAU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXQvSTdtOUpoQk1XRlZJWHZzSUpLVWJyWUZ4a3h2YUk3RlpaL3NJSC9QQmJJ?=
 =?utf-8?B?eXJ2a3krd0hYU29aNjR5MlE3NWtvaHZUL3A4a2p6Y3p2YjUrdGxpMUREY0RP?=
 =?utf-8?B?bzU2WTl0M3JnYzVidU44UUNEUlJwSU5pTlZ0TzBxMzArbS9ZTjlrMUJCaUFZ?=
 =?utf-8?B?ZW5YaWprRnB2Vm9JRkU1QjV4VmZ4bHBZRVBHTUJML1hMK2s5Y3BZNFVCWGVD?=
 =?utf-8?B?OW9GbDcyWUlPVUs0a3pjZkFydDIvNDBaaElFMnJGVlBZNjZLMS9qVHFXMVpt?=
 =?utf-8?B?SStkdEhBWVlKOFJwWjMrbXZ4dFNzVXVtZEM5V01lVy9OcHJRWm5IK2lDcTZE?=
 =?utf-8?B?bWdRdHlJMGJzdUQ2cWc0eGEzS0JxUjdiWHFlOC8yVzVrdXFSZklLTlFPeERJ?=
 =?utf-8?B?K0R2UlpvZXFNbzRaTWZ3NG15NWZIN3poemtoUEY4aGZkYVlNbEtKUCs2ZnlF?=
 =?utf-8?B?R01TZDhmM1FudkNKK0ZZemxpY2s5bmpWTk9qTzE1cm1YQWRkblUzM1h4UzNI?=
 =?utf-8?B?bkFva1Q1OFkyOXZzWHAweUViTnh3TlNObmVaZm9VZGdyZzU1eUR2U3JjK2JI?=
 =?utf-8?B?UWFERE1CejhjZWFFSG9mWklPRXhjaEJjTlV6QUxNYnZSSGtkNFF2dXgzdGU0?=
 =?utf-8?B?TlZVQlNIMk1GOXhpNW5MZGVTY2k0NFJrOUtGU2duaG5TTTlhVmRTQ21KZnl2?=
 =?utf-8?B?S1FweVdzUjlVclJtTEE2cjd4cG5jTU0wWUdzNWNEd3ZhdExuT1dnUG0xakNO?=
 =?utf-8?B?aUpGWmlVOG9GL2w4UHdIdko1MkF1SDdmcUlTUlVzNmtua2NUc3lWRjhuVWZD?=
 =?utf-8?B?L291TmhZTnlMOXoySUpBNlhQcDVtM3JnZEZJMmZmMXFkSDR3dFZtMU4zSEdQ?=
 =?utf-8?B?dFhYd2VrR1VpdmNEeU16bzFKTHJ6NTN0d2ZwM2dvQW9ubWhWR1BNRllzSWJ5?=
 =?utf-8?B?OXJZK3h1RVIrM3BRVmo4TGpGNWR6VEN4b24zVnFZZUpKQ1krK09LZUl2SlBF?=
 =?utf-8?B?Tzh0dE9EdVQ3bFVNd1Z1ODh6OFZzNzVBNGlBMDBaYm1ZeHhGNjJFb3BReHZR?=
 =?utf-8?B?RFVxQVljRW15TjRKK3RubGMxdWUyQTg5RlZFN0c0QXRSdWJCUCtlSFFPSTE1?=
 =?utf-8?B?ODhZTmI5c0ZGd3RJTGhmcmEwemFrOHdMTmwraXRSOWJxZU1CRm5kNHdpZngy?=
 =?utf-8?B?OXUvdEN4SWVkcVZDOWd1RjNkRTBLSVdJRWE0TGd0WXB0ZXN6VW9mWGFJYnlY?=
 =?utf-8?B?NlRoOGgwQjFZRGs4NjhHUmdSdXVJZitkbE9qMTNGdjlQZVFZRUJIUFJySnVC?=
 =?utf-8?B?bGRJQzk1Z3FFdzdlZEJtT3BieXRqUFFTUzF5WER5M2FwNHE5K0RiUFlPWktM?=
 =?utf-8?B?REJSanNoVTdmbmJMVXpUMmx0dEcrL254cFZZNCtGbUFJZ3JTRG80NGNlMjV3?=
 =?utf-8?B?V1hjWEU2c3ZnUnJVcXJndzhZSFQ2WWpPZVhvREtYMldsOUxpWVJiUG1BbHBP?=
 =?utf-8?B?ZUNVQkJXRFhlejZxeUZodjArRnZEc01RYVFjNVphajNYdC8yYzBYV01yZ2xV?=
 =?utf-8?B?Z3YyVDdQNjN2RGl5cVNDenltcmF5VktaVVJ6eFdPRkgranVKYlZEamZVVTBN?=
 =?utf-8?B?TW9oZVFHWEI3ZmZQQ3d4a0dZaU5neCs1enVtYkMxc2FLdjI2THQwa044Q053?=
 =?utf-8?B?aXg5eFkxOUpFRStwMW9XVWZVajkveFA5T2dJSEE0VHBhYk9vMEZkVnMySW9C?=
 =?utf-8?B?SjM3YndkWFBYMTc4RW9vbk53bTFPek5ucGJ5RU5oSDcrLzkvQ3RML1hsWW84?=
 =?utf-8?B?VFE5RzVFb0VSUWtKS0Z0U2JmVVg0d2diTVphc2xIalZUTW0yVWFvdHJrdkVW?=
 =?utf-8?B?Qm9vb2RBRXFmaFlkNWVmOUZyVXpzWlQ3WlBTclcrcVBDWXViZkhuTS9mWDlj?=
 =?utf-8?B?Tkg4ZFdieHJtTGVPdkROMW1mZVE1U3Q2amY1VWlZNGVRcWxwRTR1N2tvNjVm?=
 =?utf-8?B?UVh4SFM3YS9tU1RQcjRkUTl6cllNb1dHS2x0eHpXYUp1Qkl0NXIxVm1zWjBL?=
 =?utf-8?B?UDltcjZnNEx2MHMxU1FOcld0RVYxT1RpSXpyKy9ZL2RvNmVJSEpRMzVKVWtw?=
 =?utf-8?B?YUdUNjdDVHFKWGpDMEZndmpPVGJKS3hmVnV6bStRNVRaYUFhQkQxbVB0Um5L?=
 =?utf-8?B?RWZUQ2NMVWkrMWZoMSsxOFJMSnowSWl1NnJMdjlQTThSMUxGakVxY3ZybU9H?=
 =?utf-8?B?dXJNcmRIeUlaWFo3ZWFpTzJPR2VQU0dMS1JQYmVhY3dyUEdjbDJvM2RaRWs4?=
 =?utf-8?B?bitUV0FOaDY3VlEyemNLTzdaOHdnelo0Z2RYT0U0aTdJSGNZVkJCdz09?=
X-Exchange-RoutingPolicyChecked: 
	bfEsh0+07a90Hk3OXI9xs53qsepPfHQSlgzhtOkY0ncMfuvwm0dY1tIdpIg3Fmvk3jcbckopWI/f2Y4HYAZsVsY7AQeu9Oa9wPjgdZamaHLyVkWrnySGKQ4mdZsOWzKuG3ErAvLAFL78qVrsU0wSzM1lw52l6KZWh0ILRaZG6f7escLE7CYiBj5/tWJOco+ROVJdAW4B9XwopR8BCPelMO9lCSLdsvu+O6swJcibVeOQQLbszQWHUxOUQlQJslv9ZCVKwsHNB5sWNKVU0sPQhXTioKA0JQMShcfDGNw1mEecTdZ0Fm06LHiKGWc6Fr5XaeXb2Z6fznKClJRFXL81Jw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2171fa2-1e85-407f-31f7-08de9ee3015d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:44:55.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1wJjI7W9gVd/Hp56Giq6E7KJbZjVXlyiFk2+/QkBB6M8kU7xerQuCVMuEIIrioM5v3za49RicUo0KjM2xMDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6801
X-Proofpoint-ORIG-GUID: DxL-OMc5tM1l7FIy2Sjq_d8qVFzHl-E7
X-Proofpoint-GUID: DxL-OMc5tM1l7FIy2Sjq_d8qVFzHl-E7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzMyBTYWx0ZWRfX6yq7an+JEdLQ
 NR59PJMmAE7QtT3hvDAQahB4Ui9Zdgi3rhBYw4Z4WgHawDMIGl5D8tdyGOnAu3o006CCxfJm0/W
 TcVib1J6PAJViQnWCcA6TcGctmlybAmDA1Yq8Ntq0IAmGlJNH+/cEAXqQPzDvDPGcx3abzdlw24
 feOYmGMXLstDtcVeiTYxM54qR9K6rGi7kyDZMJsLU37gIwFh8k3HPznOXflAcUusfWqxoI/fx2O
 M1b5QREKCbFof0cxoeDHAB+NWlmnuJDkA8d/6b1UuarlB3ComElxgSEeEWRQPTw+AoEx9XgyPnM
 TWIO59cAlwRFOyb5LsdDkH+DGbY4xTwX2tMbJCM0u5mav+wk5CSLUUsoLe6mkjfi6EtSkZB1Bt1
 ytUXpC+U+LvcaqMS8h/2/h2k7HiSuq+ExZMyFH480KyUFLdEuu9Hkh73deEcarZoz5BpWOixlwL
 XLRXGA8m+ywrcj2YL9A==
X-Authority-Analysis: v=2.4 cv=WKZPmHsR c=1 sm=1 tr=0 ts=69e62dda cx=c_pps
 a=XNh4DmHdy4Cg7KTw7bneTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=P-IC7800AAAA:8 a=FJJgiYTG2X_qd13MOb4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200133
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 63K5BbcN2579828
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 13:45:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3737


On 4/20/26 17:30, Thomas Perrot wrote:
> Hello Yi,
>
> On Thu, 2026-04-02 at 16:31 +0800, Yi Zhao wrote:
>> Hi Thomas,
>>
>>
>> Could you please provide the build steps to reproduce this QA
>> failure?
> To reproduce it, LTO is required to be enabled. For example:
>
> DISTRO_FEATURES:append =3D " lto"
> require conf/distro/include/lto.inc

Thanks.=C2=A0 I have merged these patches.


//Yi

>
> Kind regards,
> Thomas
>
>> I
>> can not reproduce the issue, even without applying this patch.
>>
>>
>> Thanks,
>>
>> Yi
>>
>> On 3/28/26 23:58, Thomas Perrot via lists.yoctoproject.org wrote:
>>> From: Thomas Perrot <thomas.perrot@bootlin.com>
>>>
>>> Fat LTO objects in the static library embed original source paths
>>> in
>>> .gnu.lto_* IR sections. Unlike DWARF output, these sections are not
>>> affected by -ffile-prefix-map, causing TMPDIR references to survive
>>> into the installed libsepol-staticdev package.
>>>
>>> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
>>> ---
>>>  =C2=A0 recipes-security/selinux/libsepol_3.10.bb | 4 ++++
>>>  =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-
>>> security/selinux/libsepol_3.10.bb
>>> index 0423a2a6ea31..0a51aba28ee8 100644
>>> --- a/recipes-security/selinux/libsepol_3.10.bb
>>> +++ b/recipes-security/selinux/libsepol_3.10.bb
>>> @@ -13,4 +13,8 @@ inherit lib_package
>>>   =20
>>>  =C2=A0 DEPENDS =3D "flex-native"
>>>   =20
>>> +# LTO fat objects in static library embed original source paths in
>>> .gnu.lto_* IR
>>> +# sections which are not affected by -ffile-prefix-map, causing
>>> buildpaths QA failure
>>> +LTO =3D ""
>>> +
>>>  =C2=A0 BBCLASSEXTEND =3D "native"

