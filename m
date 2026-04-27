Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68CFF885D
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:09:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33692.1777255766583100691
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XLXluV4g;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8577f77343=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R0kqIO2992095;
	Sun, 26 Apr 2026 19:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=XjZuJRtytWY10KLEszRDhU419oNzU8iV9bqkiLM2+8I=; b=
	XLXluV4gnmLwdF9Fuyu3dgXjuRQMm2+vDv01vm/IzNxwnTuKfxuFqNDwmqktrt1q
	hgIlsPd+eIiOLWRpG6avuyqF+g/wYsG8ULwE5cluM096hPoq57XeZ6mSCBKTgAEg
	js8dICIEN7MygyaDcJ6tgzFW35x3CoS1LnDAQMncUysRJW8iR4tlvCeRELanXBj9
	QAcXgHcpuHM1CXXxybqfVGgmMsDaHLeWXQR9Ka24Tp7I+sIRnCPKYtvrY3kCd60D
	vsj5SiaaQ8+56UVutDLNZm3FwGTLlipv84pnA/jGtPxXzWjJdQ6AFQoUjHlNjzaq
	b14JF20SixDm870/Mu29ew==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drw4j14as-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 19:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4X/P2Tv92GQR9No8B0XzhwHqONt+2y8hbLnkXmMZY58Ue9YFRrJiZj00wsxUwW2u4YpJ4cW99DLA9h03WNUfBeO1PHid6wHTTW1knFyL7y4sj5AZI6j+mC5z+c8sbmqdStHEKRqCr4sg5v5Lp2bMi18JW1hQuFfouzrk+N3M1CbHBF4h4xpwhEpqEFZkaMHJINkY6FHjSKIO6F4eUCtCjrGMxtjDv0ZSGec/Xt5ss9Xnwh2xXTFEw7URp52ZPu8EmFOI28EciOawE55403WUmjjTSH6sw8y5SekSyrB+bFKon+AfjdlYp+azy9F9MDI3pSN5A1qKJtTd2TNOzoQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjZuJRtytWY10KLEszRDhU419oNzU8iV9bqkiLM2+8I=;
 b=RBJRNsdYHM5vTGgGBmTLBfr55e+vL5cvNu0AHoUr27Oi/sf52K0UpNa87aQbM4zAgOQS6FSlaOQmNmkQTQ9qwHEcc74bIpYvTRVa2W43BD91Bh1gCMLWPRh7CD/0F2BOo46p6EgNFcjYZC49OMjTzEC3xpxDIYytmIvVi5N6ikqgGanh7ObVwceVRRIWdsuKSb47AuPIyYJKSiNhuKpB0kKgocM68hbCwgeQKwW3U3HjKejHEMf+6yF/3ulhhXRUC3tst9TS70dRVOGZtCQvqzFQ/9H/jN7/yi0JdAPD6RHkAJyFfdyq554a2q//jLW8/9UcZpQpeKNGgOIkH7pE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 02:09:21 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 02:09:20 +0000
Message-ID: <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com>
Date: Mon, 27 Apr 2026 10:09:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
To: Alexander Kanavin <alex.kanavin@gmail.com>,
        yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com>
 <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
 <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0142.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::21) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edd78e5-ca1a-49b3-b2ab-08dea401fe11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	/miCmSbnYT2MqrwIPUmn874Md2K5DKnwJ11Dh6S2L3XBCsSrKZLW5aQK6Nk0ki2EWfLDbJ0rZOgtjLkABBt7iW2UWXqWwos0k0LkDza6+QRH08XJtNkKCu3r1f/H2bJ027YAttBKNoNwgBVUTkuPBTAIIQ8n2WrIOB2bPAYE9av51/Utq1Pah93U4tDnMW7s5a07f70LliEuDMBJxpODBoUtGTeF5bbi+zeYTh216x8aQigOZOYvdgW7ogGqE+RYgiO4ySM2XucMg5ahxrNLBeDfScfw9DLdKw/8SD90/bJP30D531NyrJf2KysufAOSY5o5UJzbvNJ9flFTjVp8s+eHre3+3lEEBag0uckHBY46YQbUwrDdxL+NUSQogV54AnrxVNFTmwAKQiMzyRXAH08awO2vUk6uIRaCZ5riMgaJvN5+5Pky87xL7d7Z2UbvrRcJOuXjRMywv6b/7iZkc00CfTOHZC51ju4B/jhpwd/xzflx/cXjjC+lAPrzQhnvNXzgE0281pW2zVSYziEvzspRnFqGcC6KjiFZE5gxExR2A0yickDZ8oiKPv6NC8itWk3EC01FPueSYzGqFfNidWsl5ok4p6j9MNVmSz4RLeXNXhceAPl++9r2DigfKYum1BpNzpOP6B+7ocQ5MzVkNCdyuLMBogpxbqsY/LqVVmsRItJswd861uthoweexFY4fp6fZvnKltBkAEvU1kC+dekqZS3HPvfHGyNqoiCVgKk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0dlaUhtellSd3c2VXBIZGhKclRRMVRIMC92Ymh0alhocjdJL3BMcjd6NllF?=
 =?utf-8?B?Lzh1SjRqU3JVbWRwK1dYbXFMNDFPRUNmeTRrZUlaSjE3Zm1DMlhrNFNlR2VR?=
 =?utf-8?B?TU5uWkhGU0VrM0o5SmZONkRhbWl2ZG5PNElHV2JGbHh3NGhLRWY4QUozQzBl?=
 =?utf-8?B?Ly9wVTdkSXpaZDQ5S1EwT29mcFg0T3hBa0x3dFdLcXVFUWJrNFN1ZWpDWThJ?=
 =?utf-8?B?UVBWN29CbnBSVlBqQkplc0IwcXF4WE9aVUNDZzN4MGZjbFJqUTJzZm1zSFBZ?=
 =?utf-8?B?NklxQW5WdkgxQkF2N0JTdi85bzIrWk53ZTJoVEJVakJsT1NieThsM1NFZlRB?=
 =?utf-8?B?T2VUaHlXelY2TzJIL1NiSFNoNmxBdWFpVlBrRlhaVXpYckVtSUtVdndBSE45?=
 =?utf-8?B?MWxTUWEyOXJ6N0FQQkE1eGtlS0lwYmdOMmR3bUJQalhmTlAzWUdvY2ppZlN0?=
 =?utf-8?B?bEN2N3FCWXpBL1dGWnZ2UXdLZVVrMWFiVzNvQndBR2xwVDFmR29SSmdmT1hk?=
 =?utf-8?B?SnlVNWdOc1RndHlheUx2UHR5SE9WMFR2Q3A0QTNZTDlkQVhjay93Q1VIRmN4?=
 =?utf-8?B?WWNRc0VlN2RucllYT0JGcitWYWpPNkJWMzlsUGhYUytQbjB4M1BwUXpIZkIr?=
 =?utf-8?B?WVVIWDZCY2JuZWw5UW41djM1M1lDTkxVZFd6akp1bnhPZ2N0OGpIb04zMkYv?=
 =?utf-8?B?ei94TFpBMisvclQwTFMvQ21KL0dhZ0Z1S3poRFRCdVU0ZlFEakxVTDh3Q0lI?=
 =?utf-8?B?akR1K2c1ZU16TEErbFlXNXNzSUZaMS9Vc0dZbXd2U3FqcU90Qk1mMnhhcU9r?=
 =?utf-8?B?Z09ENUZXaGlvbHZKUTdsZFZFNWdHSzdDUzVrVkZXMmt2cEVVZ1JEOGpoQUdk?=
 =?utf-8?B?eHhwZHVhTFljczN6R1JWbEtDTys2UnFldFMzZUl4RjBuRnY5SmsyU2VhSFBr?=
 =?utf-8?B?amdPSyt3a0JtSzFNdlhvSFpvTzNrRnNKYTdMcGEwTVYzMllYeUFtZmlmU3Zi?=
 =?utf-8?B?VmJmaTFMcXZ5V0ZuczNaUjZlU0ZOaExMbTlvV0FNZTVPcVhna0tSSXN4cWpM?=
 =?utf-8?B?Ky9PSVFqcGNZTFpTSXVDemt5bWlZY2pIK2dWRDBPb1NrZ05lZVRkQWZEQTlt?=
 =?utf-8?B?OUcySEVxTFBaUXpnVEVaVW4xUmlUWVFtamY2cm12NXZVdWRaNDRuamNyREQr?=
 =?utf-8?B?T1dSa1laQU1ZZXY2QnhGMlVjdEIvV0lRL3pRd2F3UnFScExSb09Mek5QbzlX?=
 =?utf-8?B?Zm5mQUxMekY5M01jOGFxMDNndCtWRWt5clcxUUtxVTV3SWxST3RqYW1tMHF1?=
 =?utf-8?B?MWp1UkQ5Znc0RnhxYkw5SzNpWHdYV0pLTndtOWVKbXp0ZUIwbTZjSmlKNzhQ?=
 =?utf-8?B?dFc1WjVaaWJpN3Q3SWpQdW5DMmFMS0VlUEpieExYQ3lQSmtHU2ZCZ3h0d1NN?=
 =?utf-8?B?eWRLMlBteksrNGxlSEw5RVVaUUtlT2RFZUJIS3d1STlMRUZrZFM3ZGxXN2Zn?=
 =?utf-8?B?NTMrNTgrNFJLYUxkRXpqMmpWeWRCSnRicWMySVdLUElER2pVK1ZwTVc5c3lJ?=
 =?utf-8?B?T3FUNXMrV1ExbUs4SHd6aEtac3RPZDM3bUkxR0hJdHZxZXB1SUNwYlk5cVNy?=
 =?utf-8?B?dnVQTHF1TTlTK0dNT3R0T1Rrc3VMOE9QMWxXOFlreEVyWXpnc0EyMU5YSmdT?=
 =?utf-8?B?Rk9uUUk0blBLNlprbjJWUmVjWVRxZ1V2ODhuRytBZ20vdkIrdmJFVnZMZXpP?=
 =?utf-8?B?UzRmZnVIUjBDd2NyT01jY2pNNUJGU0FWUEdDZFFMN25paWRQMkplNVYrRk1Z?=
 =?utf-8?B?YUJweTZxYWttTVczN2JBdk1XTHpXUmw5azl1azdPSXc4YndRWTBoVlo0YnhN?=
 =?utf-8?B?VDRRYkpJOVJsd0NNWGNYZ1VOeGNCdW9UMnhqaE5iS2hmbkx1TnJkc0I3YlhI?=
 =?utf-8?B?VklNMHVZZEtkbFFsQXRUQkpYRjFsNVI2MTFuS3pqK2k2RmZ0QWNSaTlaZnpw?=
 =?utf-8?B?d2JzSXZaM2s0OFRzelBGNWkzdy9jMzNBRysyVEdmTVpFNEwyYmMxTXVheUFI?=
 =?utf-8?B?WVRqT3hWZGFWWUc2Q1Zob0RNZ295OXArcW8vWGVhWldUM1VEZHVNUWlHRGFD?=
 =?utf-8?B?d0VzYUJsbHEwU0FKam1DbUdqdWxKdVEzdzJvTklpVHZDdVM0K0xKYmxOQmtJ?=
 =?utf-8?B?a0VtZmkrSXdGQ1RnaHpQWElaYlZkT1VVNGRJbmJuSDBZcnFTN3VpSDEzTGpX?=
 =?utf-8?B?Snh4WWM2VkJUQ1Z5RGhzU202Q1lXU0oxUnArQTZ6UTJLWTVWVzNIeW1pemJv?=
 =?utf-8?B?RFkxNzVWQ2o3NU84VUY5b3g5eWFSelkvd1JNTnpvMm1yT0lZa2NOdz09?=
X-Exchange-RoutingPolicyChecked: 
	GRAVqbHkm48m6rFaYo+ySYCSfpibH4XRB5kRCuK9js+2Jk09W/PVHx0H2fvdNKs6L3YQJiUoAbh/4U6FCVmT4p3e1QyNUYT5pT9sdgJpNcn1vGwQLg9FDeHr8NQXU2tjRTiMA/bq32nyzYCp2nRRBmtBafzTaujeOh3TglhPPjJhK9gPm74dZfdNFCHUBL86iL9N8BFh3Ru3acmHk9wLRQipOa7svUMz7k/6dffIYLfELNNIYosQGvUDXSSeplrTFCAar/ymxnz6Scn6n1iQE0+3KTH5dnau8HpDi05bz2usqKnkXySHG3mwqLqM5ROcdVquRlfhJwzHS7f8/GT4Yw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edd78e5-ca1a-49b3-b2ab-08dea401fe11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:09:20.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmO2gHDb3z5RJoIhpxI8AmWU4afKePsL0KKbPAvzNdpe5f/MMM/hLxY6iLSa4acl7+6LvQ6okFTMPZyO/kdbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-Proofpoint-GUID: e5SS0-DqrewVszru4Tg81-iLqmZQWZej
X-Proofpoint-ORIG-GUID: e5SS0-DqrewVszru4Tg81-iLqmZQWZej
X-Authority-Analysis: v=2.4 cv=Iroutr/g c=1 sm=1 tr=0 ts=69eec554 cx=c_pps
 a=Vharl4M+XVTaKge5CdhMZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=2o7fzGx15kfoRLjoHPYA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyMSBTYWx0ZWRfX7sUe+GkjvWdX
 0fXiSkIkvje46cEpBsBOG4L4ypcU9oDoPSWB7y5YVkeL8OCWZ7hcHlGw8XRrxZL7SQ2dxbGwZnk
 9SJIBE94x/bz9jvMyDxK5+KLbKcrNjldfr4hHEwUR6yhzrXSU5eeGFnsP4WnoyjzGhE9DhehFDX
 osgvB7wbTH0lio5gV0kSdJ220Ox1UlLl7KkyNyd1f7MjjxwrSlWuZm/9xe9gQPxlymAvjFrkp/1
 z5yaAz7m35vBQsz3biXS8Pr5ghpweXojeJJeHzReyuAKn2uZBf0D7njkuXSYtgNqioNYSpaNuHX
 d1SvNliUtOQC6/kM/f0rXQcsO09LaQTt/bTKYxmVCwPtFoyP+hDZ/dFGaLNiXTTtf3GH49v2Ag+
 a6+dep7Ft1f+FuH+gT4EyAvoqQycifA7UJpGj2Sk+P1XYUBWJ0xjbQbFmq6pG7rdnqTq6qaUyll
 rAbcayg3XsY5Kz513mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:09:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3820

On 4/25/26 02:51, Alexander Kanavin wrote:
> On Fri, 24 Apr 2026 at 19:04, Richard Purdie via
> lists.yoctoproject.org
> <richard.purdie=linuxfoundation.org@lists.yoctoproject.org> wrote:
>> Whilst we do need to be mindful of this, I suspect there is some room
>> to parallelise a bit. How much parallelism is this expected to have?
>> Some existing jobs like oe-selftest do run a lot in parallel already so
>> this could be not that much different to that...
> Patch 3/3 sets the parallelism to four:
>
> -        self.opts['machines'] = settings.get('machines', 'qemux86-64
> qemuarm_musl').split()
> +        self.opts['machines'] = settings.get('machines', 'qemux86-64
> qemux86 qemuarm64_musl qemuarm_musl').split()
>
> Alex

Yes. The parallelism is determined by the machines setting.

Let me add more explanation for this patch.

The biggest problem of auh is that it's running too slowly. With serial 
run of builds, you don't dare to specify enough machines because it'll 
just spend too much time. For example, you upgrade the whole oe-core, in 
most of the time, what the build is doing is just building one recipe. 
The first recipe upgrade has already got cross/native tools, glibc, 
etc., available, and subsequent upgrades will only run its own build. 
Such builds consume very little resources. On my server, if auh is the 
only one that is running builds, the PSI data are very close to 0 for 
most of the time.

We don't need to worry about auh using too much resources, even if it's 
running with other autobuilder tests. Because Yocto has very good 
techniques to control this. For example, if we put 
autobuilder-resource-constraints.conf config fragment in local.conf, we 
don't need to worry about auh exhaust the servers' resources.

With this parallel build added, Yocto can configure oe-core's upgrade to 
use machines that oe-core uses as the acceptance criteria. This means a 
successful auh upgrade will very like to be merged without any change. 
If there is some failure, e.g., qemuarm64_musl, the 
developers/maintainers can see it directly without doing more local builds.

Regards,
Qi


