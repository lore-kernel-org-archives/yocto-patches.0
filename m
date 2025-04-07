Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A8C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 13:12:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.46597.1744031563593203977
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 06:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=61920d6902=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5375wJFk001100;
	Mon, 7 Apr 2025 06:12:41 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4a38k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 06:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqgik5MKeuSerPd1jepWQmAvH/l1CxrffMSEmIObU2unX4dEiYXpJ5ab6G+22X4UYLhLx9AeKwveYF19sakxNYNGos33zqecQTYOOE+mVbsjZbRJ8M7JkKJqkEm1t67SQIYfjxoUjtkJgMRlcj+lhxsnvWCFnmEb3LP7ob34LL7dTkeDmiFe56mb1uUmUimr7rrQO8vuF+LnjxUGUKxfiFKae8qvl9Ppf/GWEXkDdXFUnDQv/tRSH17ifOTokQI3aHMG/qz6PNSW5eh6MPgrz65zFZYFMvk+bWgL0eF86Srwey5li79q7ZlB8U6IEI4VdGOyi2W5yUAxaMk8zwfdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM7fn34+dOHNlP8L/40Qa13/bc61thLrYwOV7m3UiYs=;
 b=mxbQrCha68ooyPJM3Rg3PR7X/Lq9oNOkIBVmSM9x58lED1w0AL7eNzXhN5vkEuKgODau+DmGoUGDyVcSjLjFptnQqlmWMfue5xHr3iHnu0WpQzqysoqkthbpRG3OBKCyAqBHnNSdKtyTO41h9K27TkcSyfwWw0pyUAQ+Iv0kLtKUX+dc2hcu/aW66CL5NQCVyjRzGojU/Kupzj+gJMpnuqCCpB9DthJS8Wfvx43+38QUGNaMyJxYd2LGtuxs4kru/FMn8DclRn/+BUqvPCt+NWSHokfgz8gKLkIStOvpwAmbMq21drgm7s7S1N/b8+FuYTyipvft7YT+pO8J9Ztwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:12:38 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 13:12:38 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "raj.khem@gmail.com"
	<raj.khem@gmail.com>,
        "akuster@mvista.com" <akuster@mvista.com>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>,
        "Yang, Liezhi"
	<Liezhi.Yang@windriver.com>,
        Scott Murray <scott.murray@konsulko.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Index: AQHbl7SpLOOrZsFz+k2pVuA77y9NnbODA3QAgAKLCTKAEr4u2w==
Date: Mon, 7 Apr 2025 13:12:38 +0000
Message-ID: 
 <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com>
 <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com>
 <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com>
In-Reply-To: 
 <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: raj.khem@gmail.com,akuster@mvista.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: 5d3f88f8-de75-4087-b978-08dd75d5dee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?JnUGHiXZmfE3ehAhC1pJvaF9MnTvBDd+tQ9o9nWm6Mv3st9lbvQPphG9?=
 =?Windows-1252?Q?5p/3VrloHnOf+TBJ7anlY4IEDRaQU/NPrvU6QOz945Z9aWIIXQsl/AFE?=
 =?Windows-1252?Q?ueVXUcdFXPzlSUamdEMIbzQIEtJSVPkWADHAWkTlK4RbAMBlsOjXCDtQ?=
 =?Windows-1252?Q?xzvMmglEDKSL/kEBpEhSdZ09Clu3ytvXR0Yqgd/xQmrr4hsYjZPTr5hC?=
 =?Windows-1252?Q?PgxnBU0KUbxUHjM2yjgb6IBYFqlesqcEOZPy171r68hPmWvkjBsAQX2X?=
 =?Windows-1252?Q?EIyvjaYg49B66bL11rvaHECs5x0rc+JJLLGbyTwbCm3hOAWDGX+6bW1J?=
 =?Windows-1252?Q?f27ZACLWU4R0VIaSSarmIEyluGk0zN5n8sm7hCRu1OeFX2K3cnAMRZYS?=
 =?Windows-1252?Q?bdroBlAMBHc7IGSkJl+yXbcFWQ3AovkAY4n/RXfJvrikzY8gGeL3ri4P?=
 =?Windows-1252?Q?eSNSx0QAQFqT1XSRIKvvTl1xv3vd2IE6gUo1EWHRsNFb8nu9Mcfr5jR/?=
 =?Windows-1252?Q?EXZLpTmd8pD8NQkQHhqcPq1mkN5adLWtA1oK2c9BmzTWTBqt9ZLL9qi4?=
 =?Windows-1252?Q?ZmjYGwuGS8GF2bcmd97BB0GvV1B269BhTLLAI/sZybJngX936QGrbbTB?=
 =?Windows-1252?Q?PzZZ96+7qu6s06dAX8Rl+eZ6M9MI+2BMmuZacN7cGFWK2Asy2GxBsgM/?=
 =?Windows-1252?Q?z8XvSCFw5epk/PzDUg3kjfrpk0OI6IeK4WtKJAvI3rB/c2/bInRuNbSO?=
 =?Windows-1252?Q?RoiCcy87dZC/TldcFStna+pDkK/j36o/ZZWGravTqjcAiMwnbnxrvIX6?=
 =?Windows-1252?Q?KQjLFlzpvVKe09tA1ZEsWt3y2VrxMB8EigCvuy9T3ovztcEwcpINpAii?=
 =?Windows-1252?Q?NR7jeSxhNPmP453A/kGjAASFBS5e1ZlyJXNa5RGYVbN6cdrmVT2PGNrH?=
 =?Windows-1252?Q?uF2frCAmeePIKuuzQELXRCrBuNhkL93ynATE8cDIJEa8VfQWiOd4yBfY?=
 =?Windows-1252?Q?gGMzL9BRu3WYnjRlLi2bUveX0PZhm+Bm8uC3UmXiNbORTnAXDmH5GoVC?=
 =?Windows-1252?Q?15k15NhN8vSu/mYu7eO+a0oyAea2tExCiCcpioAW+bqr8YONP5gGO9Xf?=
 =?Windows-1252?Q?Qe+n6Ftb/vQb1VAJB65m61M91gypxRrZyqUIq2teSWurcr6rLRTzq6st?=
 =?Windows-1252?Q?RP7Z5sMam9+yQM7kveuMuFp6JKo0sr+T4FPyqsNbFhOf5io9JQJni8B2?=
 =?Windows-1252?Q?RNcJzTbykattKeDUT+wlXurmqDwDGJDprJmXqF4elwTg0do4I8FmqGtR?=
 =?Windows-1252?Q?hG+zhcUNG4HlDH50Shzp8t/DqQ82p740TMQTcL75AnnzoKxXeTRJ1l7I?=
 =?Windows-1252?Q?1nkUJhWUrB/tAq06GgouDpRo7kpQUqCccEtGwPMl11MFB/s8Ep01NYUr?=
 =?Windows-1252?Q?COLsdDh7vsVXi83LxUSpkmXhwGAj3efkoC5j1Oy3lUtkHOxlDs6IbXe8?=
 =?Windows-1252?Q?gPM8c6elln9iUY4mnFTDUYmVHVTvWcDlqZiHeNCEh2jcK79LCvXasgMs?=
 =?Windows-1252?Q?oQjP4JbJQdg6CzIf?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?niVNshs92bOkKnqCQrB+Tiu2zMKJRQaEsZF1Qv2JIvEdd1hAMsV1oFag?=
 =?Windows-1252?Q?qb0adD75a36ZUEEfr40XT2qBGaZsXJkwsVI1FQstdTP0uSV9pSLqGI4D?=
 =?Windows-1252?Q?gMjOPeiwkX5dXhOVYaT1Gzm+yZgiz+85p9QbIYPTklFA9QxFzs1GLkr4?=
 =?Windows-1252?Q?XXANegGwJo/laTUv7euNkjJcVqHM3sCCuZ4G5WZgkT6pWuu7wINQKfK7?=
 =?Windows-1252?Q?4AEjLxIu5mFmca2kgMOKlLUkv9JVZr9psXK0gN+zHLMQl4EHZ1JLRJUA?=
 =?Windows-1252?Q?AxrS1lL9LyVsv2HYbcjDLA3V900oF0By2MLSJTFGgn5L3dP4WUHW6ImG?=
 =?Windows-1252?Q?Qg5UwnL3S/uPSiFmPXw87OjSPc5p44R1swRQxP92N2COndqSWYzaHYaC?=
 =?Windows-1252?Q?6cy778ej3tDzlwqWbo3vv3/AnWtbvPQMiuMaHk2DUuqwmTipHieUKIbP?=
 =?Windows-1252?Q?eVyrtUM45ZORT+eY/lyvALdk8CnRCS2YkC+HEL/+QesDWxwjWChLS6pp?=
 =?Windows-1252?Q?GhZ7DtSdXbzw1atCYZcaj5vy19gqHBTTKJhAkoQvqkWbFfYAte37OpFg?=
 =?Windows-1252?Q?ez7oLO9oHJxkmQr+PVAAE389fFuCEtRO0wq/7moz2KRBMW85k7UeeNeI?=
 =?Windows-1252?Q?0upwqKVd1BzK2lLqAg6wp5BJybFTLpvsl6f0zuWSyZ/qQ6tWRh05P/Sz?=
 =?Windows-1252?Q?DGTbsBe5HxAddGyRo/R6WRRkpS6hlHh6qrBfTHm7azk+dNSBzQAiZC5A?=
 =?Windows-1252?Q?0dKJfXOJESLlEt5i42x4bt/CsoHSZs9C43AhMjy3h5MWguME87+xGPNA?=
 =?Windows-1252?Q?V5wnBCNOQP6FnuF+I3xld8NY3eC4eLfF/4ye/naFe8GLUo7Nc8PLAcot?=
 =?Windows-1252?Q?U8TjWu0wDDYYc6G12CcKlrN79iWE0DFiyRPmCdGGogdHoEIvBYDBbBpt?=
 =?Windows-1252?Q?Z3UgMyTQyhusDyJB9s1PAltld6gOWEuf7cCAGqOfc5dw726AB769pAoG?=
 =?Windows-1252?Q?i/BZ0hcR3hzQdWB510m5AD2eRKDADO9OqRdGhFvaEGbCmMo8s3IBYnmm?=
 =?Windows-1252?Q?4zaVhpEuLHAFIggMjfQMo3fZnTJ4YIMiI3AFgsPl+iLekKU1NwIN1Fz+?=
 =?Windows-1252?Q?qQlKcGA0kXme/P7hOm0LiL22crB80vt6r3zrLmJXOJtC5ieS4mV1KwDC?=
 =?Windows-1252?Q?cIfoqsxUpUSzC+Wv3jq2zB73Z5qaq2dcu+Wyr3IkC2e7RmG7ntaYte07?=
 =?Windows-1252?Q?ZXfvZQUBvOMddVaLsXxrmADTvC46l3kpiehJLChX2C9aGlzX3qB7L2Yv?=
 =?Windows-1252?Q?XfMAUJA/x608eZA6eP6yjmeEu2D6lMqb9QS2pIDZrrrtddW2x1v1yWCV?=
 =?Windows-1252?Q?LEYuRfjb62H6H55xEMayonRmMtLGlJKD4EIymdS/7MRuo1q5whioPVA2?=
 =?Windows-1252?Q?IFf5iDmUNsP9G8rGSENKQoqOLcOp7QsTTdjcMduZHATFw+mwisj68IaV?=
 =?Windows-1252?Q?mmuNMsRvthw7kUhfzwshdacQwa+hMLis7Hdu5UMetSaMPwyo9HPR4sOw?=
 =?Windows-1252?Q?O+Bl1fzTPTUekGarQRZDnQX4Z8JmZQrM2mnGPpLiVpBihGcj3yf/c65p?=
 =?Windows-1252?Q?Xm+RALjWxAtuOqyYxYnBw3QJcIqqeS2oOZ/NBuGcoTa6iUEo8cFrMf0D?=
 =?Windows-1252?Q?e0ayZy5SUtOeJcl4dLUSP2qD1tywqzTCcFOz8mn2pVMtwkajawSMqQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB79218088835F33FAD84274B381AA2CY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3f88f8-de75-4087-b978-08dd75d5dee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 13:12:38.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3WBRyzM0JRxHkJo+Vz9qvLkSFsYHPM33AXIfign7t2bQ9DGS7mFFK/Ey8DqkS4DFMZP0gAAHuDQFeUN9OSdGcCChDjPYO31hhLTwPseOzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-Proofpoint-ORIG-GUID: 17PD-VRi0lHllEyWktbmWd_hs3_flHZ4
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f3cf49 cx=c_pps a=kSx+wkOqrR7DBdLtetN7AQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=pGLkceISAAAA:8 a=fk1lIlRQAAAA:8 a=t7CeM3EgAAAA:8 a=k-42gJp3AAAA:8 a=iGHA9ds3AAAA:8 a=UBFVfQAFWYhimOpKR3UA:9 a=pILNOxqGKmIA:10 a=NXX6MSoyfP1CK1lI:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=U75ogvRika4pmaD_UPO0:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=uCSXFHLys93vLW5PjgO_:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: 17PD-VRi0lHllEyWktbmWd_hs3_flHZ4
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504070093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 13:12:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1291

--_000_CY8PR11MB79218088835F33FAD84274B381AA2CY8PR11MB7921namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Just following up =97 @Khem Raj<mailto:raj.khem@gmail.com>, @Armin Kuster<m=
ailto:akuster@mvista.com>. Does creating a mixins layer for meta-openembedd=
ed sound reasonable? Would really appreciate your input.

Regards,
Soumya
________________________________
From: Sambu, Soumya <Soumya.Sambu@windriver.com>
Sent: Wednesday, March 26, 2025 8:45 PM
To: Scott Murray <scott.murray@konsulko.com>; yocto-patches@lists.yoctoproj=
ect.org <yocto-patches@lists.yoctoproject.org>
Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; akuster@mvista.com <akust=
er@mvista.com>; raj.khem@gmail.com <raj.khem@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] m=
ozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS

That makes sense.
Should we create a mixins layer for meta-openembedded?
So far, we only have mozjs, that needs a bbappend.
@<mailto:raj.khem@gmail.com>Khem Raj, @Armin Kuster<mailto:akuster@mvista.c=
om> - Does that make sense to you?
Regards,
Soumya

________________________________
From: Scott Murray <scott.murray@konsulko.com>
Sent: Tuesday, March 25, 2025 5:34 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] m=
ozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:

> From: Soumya Sambu <soumya.sambu@windriver.com>
>
> The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D${H=
OST_SYS} and
> --target=3D${TARGET_SYS} respectively, which leads to an error when using=
 Rust from meta-lts-mixins:
>
> error: Error loading target specification: Could not find specification f=
or target "x86_64-poky-linux".
>
> Updated target configuration to resolve this.
>
> Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This =
was fixed by explicitly
> defining the linker for Rust.
>
> Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>

I'm not planning to take this, since carrying bbappends for recipes
outside of oe-core is outside of what I had planned to support with
the mixin.  If I take it, I will be signing up to test building those
recipes on every Rust update for at least the next year, and it would
somewhat open the door for people advocating doing the same for
scarthgap/rust, which has 3 more years to go.

Scott


> ---
>  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
>  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
>  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
>  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
>
> diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust=
/rust_1.81.0.bb
> index cc00053..2d91d68 100644
> --- a/recipes-devtools/rust/rust_1.81.0.bb
> +++ b/recipes-devtools/rust/rust_1.81.0.bb
> @@ -146,6 +146,9 @@ python do_configure() {
>      # harness are debuggable just from logfiles
>      config.set("rust", "verbose-tests", e(True))
>
> +    # Override default linker cc.
> +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}"=
)))
> +
>      # [build]
>      config.add_section("build")
>      config.set("build", "submodules", e(False))
> diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extende=
d/mozjs/mozjs-78_%.bbappend
> new file mode 100644
> index 0000000..8e8c24a
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> @@ -0,0 +1,14 @@
> +EXTRA_OECONF =3D " \
> +    --target=3D${RUST_TARGET_SYS} \
> +    --host=3D${BUILD_SYS} \
> +    --prefix=3D${prefix} \
> +    --libdir=3D${libdir} \
> +    --x-includes=3D${STAGING_INCDIR} \
> +    --x-libraries=3D${STAGING_LIBDIR} \
> +    --without-system-icu \
> +    --disable-tests --disable-strip --disable-optimize \
> +    --disable-jemalloc \
> +    --with-system-icu \
> +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold=
", '--disable-gold', d)} \
> +    ${JIT} \
> +"
> diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extende=
d/mozjs/mozjs-91_%.bbappend
> new file mode 100644
> index 0000000..c0214b0
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> @@ -0,0 +1,13 @@
> +do_configure() {
> +        cd ${B}
> +        python3 ${S}/configure.py \
> +        --enable-project=3Djs \
> +        --target=3D${RUST_HOST_SYS} \
> +        --host=3D${BUILD_SYS} \
> +        --prefix=3D${prefix} \
> +        --libdir=3D${libdir} \
> +        --disable-jemalloc \
> +        --disable-strip \
> +        ${JIT} \
> +        ${ICU}
> +}
>

--_000_CY8PR11MB79218088835F33FAD84274B381AA2CY8PR11MB7921namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Just following up =97 <a href=3D"mailto:raj.khem@gmail.com" id=3D"OWAAM4339=
07" class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b">
@Khem Raj</a>, <a href=3D"mailto:akuster@mvista.com" id=3D"OWAAM721147" cla=
ss=3D"tWKOu mention ms-bgc-nlr ms-fcl-b">
@Armin Kuster</a>. Does creating a mixins layer for meta-openembedded sound=
 reasonable? Would really appreciate your input.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Regards,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: black;">
Soumya</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sambu, Soumya &lt;Sou=
mya.Sambu@windriver.com&gt;<br>
<b>Sent:</b> Wednesday, March 26, 2025 8:45 PM<br>
<b>To:</b> Scott Murray &lt;scott.murray@konsulko.com&gt;; yocto-patches@li=
sts.yoctoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt;<br>
<b>Cc:</b> MacLeod, Randy &lt;Randy.MacLeod@windriver.com&gt;; akuster@mvis=
ta.com &lt;akuster@mvista.com&gt;; raj.khem@gmail.com &lt;raj.khem@gmail.co=
m&gt;<br>
<b>Subject:</b> Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH=
 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
That makes sense.</div>
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Should we create a mixins layer for meta-openembedded?<br>
So far, we only have mozjs, that needs a bbappend.</div>
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<a href=3D"mailto:raj.khem@gmail.com" id=3D"OWAAM301067" class=3D"x_tWKOu x=
_mention x_ms-bgc-nlr x_ms-fcl-b x_elementToProof" style=3D"margin:0px; pad=
ding-right:1px; padding-left:1px; border-radius:2px; text-align:left">@</a>=
Khem Raj,
<a href=3D"mailto:akuster@mvista.com" id=3D"LPlnkOWAAM576038" class=3D"x_tW=
KOu x_mention x_ms-bgc-nlr x_ms-fcl-b x_elementToProof x_OWAAutoLink" style=
=3D"margin:0px; padding-right:1px; padding-left:1px; border-radius:2px; tex=
t-align:left">
@Armin Kuster</a>&nbsp;- Does that make sense to you?</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Soumya</div>
<div id=3D"x_appendonsend"></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family:Calibri,=
sans-serif; font-size:11pt; color:rgb(0,0,0)"><b>From:</b>&nbsp;Scott Murra=
y &lt;scott.murray@konsulko.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, March 25, 2025 5:34 AM<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Cc:</b>&nbsp;Sambu, Soumya &lt;Soumya.Sambu@windriver.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][=
PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size:11pt">CAUTION: This email comes from a non Wind Riv=
er email account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:<br>
<br>
&gt; From: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
&gt;<br>
&gt; The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D=
${HOST_SYS} and<br>
&gt; --target=3D${TARGET_SYS} respectively, which leads to an error when us=
ing Rust from meta-lts-mixins:<br>
&gt;<br>
&gt; error: Error loading target specification: Could not find specificatio=
n for target &quot;x86_64-poky-linux&quot;.<br>
&gt;<br>
&gt; Updated target configuration to resolve this.<br>
&gt;<br>
&gt; Additionally, `mozjs-78` encountered &quot;linker 'cc' not found&quot;=
 error. This was fixed by explicitly<br>
&gt; defining the linker for Rust.<br>
&gt;<br>
&gt; Signed-off-by: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
<br>
I'm not planning to take this, since carrying bbappends for recipes<br>
outside of oe-core is outside of what I had planned to support with<br>
the mixin.&nbsp; If I take it, I will be signing up to test building those<=
br>
recipes on every Rust update for at least the next year, and it would<br>
somewhat open the door for people advocating doing the same for<br>
scarthgap/rust, which has 3 more years to go.<br>
<br>
Scott<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; recipes-devtools/rust/rust_1.81.0.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +++<br>
&gt;&nbsp; recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++<b=
r>
&gt;&nbsp; recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++<br=
>
&gt;&nbsp; 3 files changed, 30 insertions(+)<br>
&gt;&nbsp; create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend<br=
>
&gt;&nbsp; create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend<br=
>
&gt;<br>
&gt; diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/r=
ust/rust_1.81.0.bb<br>
&gt; index cc00053..2d91d68 100644<br>
&gt; --- a/recipes-devtools/rust/rust_1.81.0.bb<br>
&gt; +++ b/recipes-devtools/rust/rust_1.81.0.bb<br>
&gt; @@ -146,6 +146,9 @@ python do_configure() {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # harness are debuggable just from logfi=
les<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;verbo=
se-tests&quot;, e(True))<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp; # Override default linker cc.<br>
&gt; +&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;default-linker&=
quot;, e(d.expand(&quot;${RUST_BUILD_CCLD}&quot;)))<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # [build]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.add_section(&quot;build&quot;)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.set(&quot;build&quot;, &quot;subm=
odules&quot;, e(False))<br>
&gt; diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-exte=
nded/mozjs/mozjs-78_%.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8e8c24a<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend<br>
&gt; @@ -0,0 +1,14 @@<br>
&gt; +EXTRA_OECONF =3D &quot; \<br>
&gt; +&nbsp;&nbsp;&nbsp; --target=3D${RUST_TARGET_SYS} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --x-includes=3D${STAGING_INCDIR} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --x-libraries=3D${STAGING_LIBDIR} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --without-system-icu \<br>
&gt; +&nbsp;&nbsp;&nbsp; --disable-tests --disable-strip --disable-optimize=
 \<br>
&gt; +&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
&gt; +&nbsp;&nbsp;&nbsp; --with-system-icu \<br>
&gt; +&nbsp;&nbsp;&nbsp; ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gol=
d', &quot;--enable-gold&quot;, '--disable-gold', d)} \<br>
&gt; +&nbsp;&nbsp;&nbsp; ${JIT} \<br>
&gt; +&quot;<br>
&gt; diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-exte=
nded/mozjs/mozjs-91_%.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..c0214b0<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend<br>
&gt; @@ -0,0 +1,13 @@<br>
&gt; +do_configure() {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd ${B}<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; python3 ${S}/configure.py =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-project=3Djs \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --target=3D${RUST_HOST_SYS=
} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-strip \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${JIT} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${ICU}<br>
&gt; +}<br>
&gt;</div>
</div>
</body>
</html>

--_000_CY8PR11MB79218088835F33FAD84274B381AA2CY8PR11MB7921namp_--

