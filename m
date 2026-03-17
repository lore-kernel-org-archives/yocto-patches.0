Return-Path: <jaihindy@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DFAFD8756
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:34:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74706.1773750869691644998
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 05:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Jn8+Np2i;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: jaihindy@qti.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HCO1ET1623660;
	Tue, 17 Mar 2026 12:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWP4C7TZT1AJbln+Ya1wWb9aD94fqo9YegQElOpBaGU=; b=Jn8+Np2i9r0IPnan
	xeBNzQp75pQgoeRLf00Pw5HebiIxoZ12FTye9V6v5aJcvOKz6endyPZ370RIjjVj
	/1HRrOi0q1zv5g5RUt9yPhpSmk0/c9NjT+LivuYe/AA1XONAklLLD9MOXhEjzZDU
	+EQe6j67HITz4FOedo8JVMYO/TxjUyes3Z/qTWSCOH/4/dDxmhNk3YzCfBZdvna5
	brwIh9jvEzliEdBCXaQH5u8K/zrBQk2F3GSIQy1HwTgT0+ewHjmfGV0/xlfEV+j9
	GzadmBIlNgNYoF8CM7gzazK6kYp1vLdkg7KyLLUHawXtqWztoefoG5RZfKAhwhzi
	gwnaFQ==
Received: from sn1pr07cu001.outbound.protection.outlook.com (mail-sn1pr07cu00100.outbound.protection.outlook.com [40.93.14.96])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyemjjp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:34:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qcg4XG23XmenMZA2Zc7mXmi7Ncvsq9hTVju5nIE7R/ye2KZ0DoVMsygo/V5SFss9kQV5tNnobmgojOK//rp0dyyMPY747JRt3xYRniiV5OUCCi4Qmx0m6XIPj/q+juDJDZZYRyEnVtG27PNzileQ96ou4Io2EgO2lmfOg8QpGo6D6H9VRL2rH9JWHBIAaVyBpYrBx4yoXszSipxJUYvmZXjNVXI2FrQmk1Lzkmr5rlj/6ltqtfuco5fUssQ4Q0lutuSWKYlg8yCqv37ZLM1GOKipW6nJz07asYYyvBsdxoJNRUplFERdENssxv6HnvtxMJdOigTCYBbyte28yzW58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWP4C7TZT1AJbln+Ya1wWb9aD94fqo9YegQElOpBaGU=;
 b=uXMS00iWYviuPhe/PYc155K39NyNubX7yGlpEMDnQPtndhbc/6vQSddaDqgtCisdkY/Sxb0ABkDZ2lYiBCka6HDGVn/tKC59MdKtokZOrp4ZdIK9p+jDIS2fbAQa3szQWBwWt2zIhLW8ZW5Hz06z8FmaKM0r/zyMRm8Xfiiqq7CSZptQOQ3LTR20jg8mDdmsiEgAySt5XRB4ky9iQ4PCGdiCFN7o9QpDIbJfAplS6coAV4lqLZ2xYWqveaJGMEJVbDWrV5ma7HT4hYpVDAlhacwz+F3sLREQx4hRTqZPCleYFRLWTSlMM2kEJZff8HDW13SBBAYzT1REzWpZUK/Asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CH0PR02MB8120.namprd02.prod.outlook.com (2603:10b6:610:10d::6)
 by SJ2PR02MB9956.namprd02.prod.outlook.com (2603:10b6:a03:565::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 12:34:24 +0000
Received: from CH0PR02MB8120.namprd02.prod.outlook.com
 ([fe80::de0d:9718:f5f2:7c1e]) by CH0PR02MB8120.namprd02.prod.outlook.com
 ([fe80::de0d:9718:f5f2:7c1e%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:34:24 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Yi Zhao <yi.zhao@windriver.com>
Subject: RE: [meta-selinux][PATCH] refpolicy: backport systemd user runtime
 userdb fix
Thread-Topic: [meta-selinux][PATCH] refpolicy: backport systemd user runtime
 userdb fix
Thread-Index: AQHctShgTzdItLMOGk+J2uYdC5HlNrWyp5Tg
Date: Tue, 17 Mar 2026 12:34:24 +0000
Message-ID: 
 <CH0PR02MB8120CE9C958FCE8CF563E542E241A@CH0PR02MB8120.namprd02.prod.outlook.com>
References: <20260316093619.3748852-1-jaihindy@qti.qualcomm.com>
In-Reply-To: <20260316093619.3748852-1-jaihindy@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8120:EE_|SJ2PR02MB9956:EE_
x-ms-office365-filtering-correlation-id: ca6d649e-b764-4b8b-3d39-08de842185a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|13003099007|22082099003|17002099007|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: 
 8mRLikZSRkoMTWLfI6s0I0Ei82msN+ewBGZ8UHGtYmVOtG8NquoJDYZuOm5Mz0uBlQbQTsiqIIBBcEHoYsRAwQJKkGi1HUz0NW2s7aRETRyDvwE5h3kjm74CW45yErQTvTFmELjidEXxCX1IF5w6BspGgGbxY+qTgVMuYzMV3X3x+e9pyAPbZGV2HgO+Zri6WIniQs6Gm5ilVHTqPSW+ywd4L7K9dV3LhJlM1R3Mmd91ogYdTlTxtBmukJTr8Il0mGNjKnyHChq1/+aiuF/nvFR/mYxaSAfN68eQl47PXnEm4gI78x2/UMjIe/qBrq9ghNp5gJyGRHncw8DEafw4Vfvz7UyA2IuH6x0IeDAb1nFZC5NH20lPk0HqZPPV6+HtJvYSQphMGFhIeFW/KZrqQzROj8AWTwGmnxOrk1gldl25ieKd4wy/IHipY7ELhFwdfcR7WNFFE8l4fOh8iB9QrvD/c/ZvApZ0N6wiVgvnB9THsEfRUHP2qgTv+cLCBW5/xOXFllLJL6OHC5dIdBRNxb3aNtg+HzdK5908ehRoLY90jxa1szQGa6pDaZg2j6Q5+0uoAUSoytZbkDisnHcKlBTI3G0jD8rGXhzpq3c+9ehJ02N5Py4Uamx+mOfChGfyQSfZw4JdPpbDlyFZq1OsJVHBxgN2CsS6kTvLxe4c9IZuQJvrgfDv/qstjC7pUncudn05ZDom+WWCP5bfFd71wPH7zEa41Q5W5qRMdbPib720omlns+bczs2uOBDs65rifo7+ssUifrq0lkvk9u9AxYKVAEtqf3gPFroh1IxSvpY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8120.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007)(22082099003)(17002099007)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j3YMtyD66DQm02OlnL8LIye4Zc270u1PsVaeLucPZ/fKC8PV/zxvWz57Mdoi?=
 =?us-ascii?Q?oBL10TjbhyngRKBdlhY35MMhdu15sBPphwpySq3sXXQFOAHbkxHEIMLa3lFX?=
 =?us-ascii?Q?8GpDPAVZwSCq4bOctiobUjlceOnqOhgIKzCWmWIoJZf8F4FnzaQk00WUBzeW?=
 =?us-ascii?Q?x9SSdLT/ZJ4NeSp34svV7jebo+9xj2/K43TTMxcHjioQKZyPEEbj1eNr0LJS?=
 =?us-ascii?Q?olrtkczUGDDi9vGNxX2jl4AuG8MRogRMWoUGRVOecE533ImUOo9XNSTaVeeS?=
 =?us-ascii?Q?yClkaBqq7nUbx/2oHuVxN4s9zuEkd8tpIzzSa/QTWPDowVDdXm7jXjLtRPwV?=
 =?us-ascii?Q?/Y0t91TJyGJpg8+yHJHcHpN7t0cApHJziJGXsrxJCXC62KTDi8Ql9QQojeIy?=
 =?us-ascii?Q?KOzhbAlvg/fNRokTWvZCd3neEoVGunrDu+jpVNoh7CxKHOVCbD0IwWrujHi4?=
 =?us-ascii?Q?uzaOjwQn5eKVyH2siSzfYOfwzb4Fsb585WsN+b8jsIF4mnlVC5IlA9tbBPOT?=
 =?us-ascii?Q?7Z2+Og5zwYTQT/Zii2uj3aMZJSO+sEPgQajg5DndwOyMWrBHJQV2mmfHDsf8?=
 =?us-ascii?Q?vtL8ZXnThd4cg4Be3/M7pxxDrlS2KQlPIaOoHSbxPJtcBDhuN1Ge7b/WZZBu?=
 =?us-ascii?Q?EdXy7AjPW7LhINhB1S7PaioBXQN0LQ+MoaT9Ldh1nCTj/wTDVTiKilXliA1h?=
 =?us-ascii?Q?vvyDpBLt2Or3lmenzStoIlVk5t9ighzTCbmAMrCVd4Gl++LmyMOBqBu7YfCo?=
 =?us-ascii?Q?7yMRoAxr6lgUZEMSnaVDwSz/JMzbcleaAo5vF8a9+Qi97+ogTqULpP+BlxtH?=
 =?us-ascii?Q?EoYwOvgMm3GN9StnxdgvIiQ4B1BB/jerM+0Ory2doPbkS5iSHo/lT6NozAyM?=
 =?us-ascii?Q?C/yt6jg1gkcXLCAeuGTcbzqztSNnZK5hOBwv7diShC2lRYMJJhMuEFTbKqUs?=
 =?us-ascii?Q?jCw7/8scq/Jl0BFVc/Q1KxJvOx+YVA0IVoEggEaOMPNUT8NryTcO0O/+DaMg?=
 =?us-ascii?Q?K39PP3YZeUefmOclk8Jirr/wDTzwmCICJajoOJD3X3LdWrIHIp3vprjCU/Zl?=
 =?us-ascii?Q?GzkfOxQQhUweYqF1MYRRe4Op2njq2NquFY9Qu1uWLDXTf24u/CET+eaK212h?=
 =?us-ascii?Q?rrxKbcsHvjonObzfpTHudXNwIBf1E1uUxaj/MwfO/rFbLqEaNasGeyOy7Ao3?=
 =?us-ascii?Q?4ZzNebU7XnKAhkDGfIpZnf3J4P5x3lv456u0IZu3reR6cdhRte28iasLScrO?=
 =?us-ascii?Q?BxlEy9TzaaZbN5X+VvKtAg1Yr8S6Uq1r/fE25c6ZwZ/JGIhurnA5k473Acg5?=
 =?us-ascii?Q?6nPEg7BllaP7rgpsJKt3u3VFUSF2hc/cenAC0OYVn3dQY4/SeSZfPWUNckmx?=
 =?us-ascii?Q?HhouGmcVd8zgjxW+qGroMWuE8T5lso5vwjmgD4sq6F7tlSOqu4spb8y9A1K7?=
 =?us-ascii?Q?Gjm37N+Qs/ZoAYxFKqQNaQP7eb2tbKiLiflElbG6iemiPyYx0Vw9YZjXX8G7?=
 =?us-ascii?Q?SXmO284Hdx2nsC46tcXydh3RTe6O7l6yQwajR0c0IBo9YqzPUCbMKbsGDJkG?=
 =?us-ascii?Q?grHWP/xzpvtngkOg4Pp6KLF620VsuGYk7Hvg8iGGr0xbzgcJot3m+2ULxiyp?=
 =?us-ascii?Q?Ejg0NidPyyGWiSjGI4Ts6rHNAZRecBeY72MMG9+nct7CzyYrL89+tSziF2ir?=
 =?us-ascii?Q?cxPvQYpJBXbpsxaFNPc4/ni81t8x44fjBJMFdNIe2qhHZCAehqkLIzGNgJ7F?=
 =?us-ascii?Q?f0Uc9qBXxA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	hyqO2DRgyHKuo9Zfdo/DdSRK7kiHtmmcKyQu+NX9GOhQMw/4sghEvIISU3FFVVU5Ozt7BiRiapFxjUBBCC0wz5BhRAeq8uU219gsgSiX8r8glrB/awJxIbE989I+lN9KVy+HOaXIYx72VF1Tx8DCBREMBzbAqXW/f02L7CdUtOXeTqV7bNK8fZS22Q8ouajIbNfxcv6mjR+5Il7RfjHgARn10upAArGFywBuvxctMReNWOE3QvwaGA5E/hniroxmQdXY9jpzCQx2JIvMLf8zuiL3KhuyPhZAr4HVmg/j5JlKsNIECYCm2auKhgg1tmwTljLbyP2sfmJOlyZdoF0UmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dFMSJg3FiokFWZB316JPnmZYdh2Jm1VjV4RHHSffFzmbsWar09wHS3FrIjnz9MhLVIKMBzjpz3VR6KmHP4Pjq0057iPVSRK56G6YMrsAKok95Qt/Vko10d4a5H4kdbWRmoqclmfZfXJnGUAvJLjov3Q9/NJZb7/UnW1eOQ8O1KolkspUPsJB0PlOkGy31nnhYI2o2ScI6k9QVldg8MtcOwd5E/DN/PYymwLEfq12bPzQRPWbyp6fQNO53GogGGlqr5nSPLZGrgJ0+4//b8orZiA2Wv1egd7CLA8ZLyhwhkWz4nYgiXlIP/QIXG7pEkIB88YHI8WyU/keJ6cFQL4Is5rf7A4ulYlygHxZ4WpCeEeQ9MtZNY+on22W1XIAt+ab++fGTeIHLI61Pyg9e7juE8i7/eC+SD0+JXJ2cluzqAlromt9om/3n2PCPzV4V2gvIE9Y3Ey8GEArWH3PkaKVne2wnMC87PYJE2nAFWyYl1PGEfgpAEY376Ruex+bVXDxEd8B4PSIbyLjrlCx3LSZEQrGrZy7SMEONxoW+Z9KdV2kFs3Lh4Jd8P6Yd1g+dXWrPA+7YhCs15jhL8wYktgtwihGBtYAMYBWqfBfwm+1G/72PzKEiO39O6t4LMTH7Frs
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8120.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6d649e-b764-4b8b-3d39-08de842185a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:34:24.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvqM0oJzfhVA4DmzTEhMAKpY/Uw6GQ0CW1d2Od+o9xzY7R2VOIygMPpQuAu+seQ9Mo3fgw28WWcW6KOsw4mkBZ4uoaXic5O55SpeIfIS7mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9956
X-Proofpoint-GUID: CU4Um8qmzOD0l2mjEETFog0xmAzioUrK
X-Proofpoint-ORIG-GUID: CU4Um8qmzOD0l2mjEETFog0xmAzioUrK
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b94a54 cx=c_pps
 a=WMSBjciWI9B8Zn9KP+4pDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8
 a=cVXiBSSSP3vVm7vq2SIA:9 a=CjuIK1q_8ugA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMSBTYWx0ZWRfX4vldTYeulvhD
 PizDxcIv6qPajvhYc7Gs3L1BRGP2CfZWVGRE9xwanUTpx0kMThdU0WXP1GAD42LAxfJOcv3Tdc6
 pC/jXHe05/ZnG9LxrWuCOr8HRkJZgHZBlmR1kb+K8eSk1xJGwVtdPpDRWC60grBb0FF+iaXUXJ/
 A3An8EgbOgwlMq3HxLr+1+ZeAKQiteFTjDI6XFvn68boCQuSyBBwYdvhDzR0iHaMpiYI/ogrhd2
 oPf1I4Zo5zAuwAfBYPmxKmlqvqDF7+A4q+XzYNF+Ft4b3T13uVnr0Gm2vgsSMaCL/pC8QxB9D4t
 fk4/DAeEZCSuyqG8ctPCgTSXucHewZh0lsdWJyroUfRHwejqg61S2lDn7BugAiKYnAwqERL+w6F
 /maJhorgTWK45BhrOOfr4sg9ABUOvQEz2LCdTIrQWNyvw6GIi20AazJ5eLVt1ofU7XTB4gaNVls
 1Q7JguGuHnqY6Agd6yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170111
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:34:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3483

Hi Yi Zhao /Maintainer,

Gentle ping on this patch.

This change updates meta-selinux to align with the upstream refpolicy
commit that switches to systemd_stream_connect_userdb() for user runtime
clients.

The patch has been pending for a while without review.
Could you please take a look and let me know if any changes are required?

Thanks,
Jaihind Yadav


-----Original Message-----
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>=20
Sent: Monday, March 16, 2026 3:06 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: backport systemd user runtime use=
rdb fix

Backport upstream refpolicy change that switches systemd user runtime clien=
t to use systemd_stream_connect_userdb().

This fixes AVC denials for connectto and sock_file write on io.systemd.Mult=
iplexer when systemd-userdbd is enabled.

Upstream-Commit: b3060023318b474d0112fbe70cdbbf6dbb1f37ab
Link: https://github.com/SELinuxProject/refpolicy/pull/1092

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 ...d-fix-user-runtime-userdb-connection.patch | 34 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-module=
s-systemd-fix-user-runtime-userdb-connection.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-syste=
md-fix-user-runtime-userdb-connection.patch b/recipes-security/refpolicy/re=
fpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patc=
h
new file mode 100644
index 0000000..0b15d9b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-f
+++ ix-user-runtime-userdb-connection.patch
@@ -0,0 +1,34 @@
+From b3060023318b474d0112fbe70cdbbf6dbb1f37ab Mon Sep 17 00:00:00 2001
+From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Date: Thu, 5 Mar 2026 11:59:31 +0530
+Subject: [PATCH] systemd: use systemd_stream_connect_userdb() for user=20
+runtime  client
+
+Replace a direct stream_connect_pattern() usage with the existing
+systemd_stream_connect_userdb() interface. This allows systemd user=20
+runtime helper to connect to systemd-userdbd and access the related=20
+runtime socket/link objects under /run/systemd/userdb.
+
+Fixes AVCs for connectto and sock_file write on io.systemd.Multiplexer.
+
+Upstream-Status: Backport [b3060023318b474d0112fbe70cdbbf6dbb1f37ab]
+Link: https://github.com/SELinuxProject/refpolicy/pull/1092
+
+Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+---
+ policy/modules/system/systemd.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/systemd.te=20
+b/policy/modules/system/systemd.te
+index 4c81584706..d8a62eb882 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -2443,7 +2443,7 @@ allow systemd_user_runtime_dir_t=20
+systemd_user_runtime_notify_t:sock_file delete_
+=20
+ allow systemd_user_runtime_dir_t systemd_userdbd_runtime_t:dir=20
+ list_dir_perms;
+=20
+-stream_connect_pattern(systemd_user_runtime_dir_t,=20
+systemd_userdbd_runtime_t, systemd_userdbd_runtime_t,=20
+systemd_userdbd_t)
++systemd_stream_connect_userdb(systemd_user_runtime_dir_t)
+=20
+ files_read_etc_files(systemd_user_runtime_dir_t)
+ # read /etc/machine-id
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index 2e1a929..998be7c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI +=3D " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.p=
atch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.p=
atch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.p=
atch \
+       =20
+ file://0059-policy-modules-systemd-fix-user-runtime-userdb-connection.
+ patch \
         "
=20
 S =3D "${UNPACKDIR}/refpolicy"

