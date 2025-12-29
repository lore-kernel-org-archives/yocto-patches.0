Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1CD3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 05:03:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38099.1766984602132901810
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Dec 2025 21:03:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=f+wla40Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSMr8Jt3896674;
	Mon, 29 Dec 2025 05:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	La3VH3XnFUO3IFvu+BXsr7zxNT4qw7s/bJFB7esK8j8=; b=f+wla40ZOTM7IG2T
	3oLFMgGwPi7mYQyR4YyllwyVHsNiVnwGd/QPBRRYwCJdqel0TzqUupQilOjGBEj8
	c3vygJiRg2Vys8e1CIkqyckILs1m6jNXNxGXBVvNvaPzjp7zE04mWtKPbIVASoyl
	mFYLDB5hTWL2I5CqZKAMOTmkDJoSf/IU4Zt+H5axcQQcZkLwiQ+0bwvJDYjWPCI8
	BMhOFiC5hpDc+wZFfd3Hj9JL+O4j80oFIM9b+SE3l26p4FVTqMAFQ4RvRBaPwbgh
	91WAn2wNHTmQ5HHGTpuNk+R54Cy1UZAE5jWx3BRGdZpwPGrq3nQxmqxMjdXYi5Gz
	zKrNrw==
Received: from ds2pr08cu001.outbound.protection.outlook.com (mail-ds2pr08cu00102.outbound.protection.outlook.com [40.93.13.74])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr3g8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 05:03:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLePE9F3Ebvp4YaY7mUqhcy78wCuTBtA0Iv9IOviHHL68J//Q3pbHirV2pbH4JsYUoLmfbSdwstNZa4aHqpRzrUgqLqOMHJYIL7DxfFOGTG5gsbPK3cLmRiP0yHHIdjfGT1M7M00HQ7vLgZuENPFKL68rVJN2sgPvYi1d9wjpIiRsIcXo3IHIgdw9RD78Gx3d8XpkLMN2epJ/6Ojy3SYOYtfbP9m6rW9+l64NXr77PBIMRI5Ti/GkGRTwR0rfdTjUF75sjGliZWm8hj3Tj3CMDqD9jLOWmR7+gAN5tSfyWZ0jNAAPODDBuZ2bB1TxKZWC6ayPAqxoqEXuRA2juG+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La3VH3XnFUO3IFvu+BXsr7zxNT4qw7s/bJFB7esK8j8=;
 b=sJwh8ZkRckI05Bb7QgtjUrY9QC99ScURjkTRn5scc4yPP/IRd3oK92ZW+szqwqCqPb+Awgmw4JUXISClreff3sTpapFEXTGvHGb+a45z80M6LwXgXjBVbK2No/cCqPvDh4HJVPjWjeAr+BAdg9LkIGI8KWaD11CY+dr3K8NMNAEHLiCzoCVD1bOeUYToj2q5lZxypcA47B2GFlhP3MrveYIvh+NvsOekbaHyco7pFCilMBdwLNDK3DGiTu11KNRDBCML9NHbMxlJb26nafaye9btC3wd0T4zrXwjBol6JeT7UtbKwrN1c7osTheoHcJxmZJDSdkahmS398ZnDFpilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by SJ0PR02MB8830.namprd02.prod.outlook.com (2603:10b6:a03:3db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 05:03:16 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 05:03:16 +0000
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Yi Zhao <yi.zhao@windriver.com>
CC: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
Subject: RE: [meta-selinux][PATCH/V5] refpolicy: Add support to configure
 policy store root
Thread-Topic: [meta-selinux][PATCH/V5] refpolicy: Add support to configure
 policy store root
Thread-Index: AQHcci7jygSG8pYsHkmTgOTGLYRPE7U4HGXg
Date: Mon, 29 Dec 2025 05:03:16 +0000
Message-ID: 
 <BL3PR02MB8986D0ECCEDCC43B7E5AC1E7E8BFA@BL3PR02MB8986.namprd02.prod.outlook.com>
References: <20251221040404.845441-1-quic_sasikuma@quicinc.com>
In-Reply-To: <20251221040404.845441-1-quic_sasikuma@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|SJ0PR02MB8830:EE_
x-ms-office365-filtering-correlation-id: 55ab1ff5-0b73-4639-221c-08de469793e1
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?MeoH78sKN9EAfjhg3+aMngu3FT4oBHmqt05DdROAHmLXthH7+oyOlDnlUjt3?=
 =?us-ascii?Q?OsTLDsNdcRuKWOl6yiokyhmx8sSr5bDeUvw/FaATk6ZRr2DtZR1N0Awvg4xf?=
 =?us-ascii?Q?VJHcyOrUbQPdCNF4SyXgHbHQDB+9rHYXHQvCTRVjPpevJEYpRNOWFGztkNNs?=
 =?us-ascii?Q?Qu/s13s3mL86iYxKcdskiYLERki5lGzC9bEAjDYMzd+SreU0+li/gpWm5j0P?=
 =?us-ascii?Q?TE1UZ4j1Y170061jZ3pySzFb0cWPdP/pDm55c47H3OXOwKLTVxibRwHJEsGa?=
 =?us-ascii?Q?s5p+eDnZIjl6yfFD6vFiOcz9OTzl+ZXpsv3sqoAOBdalx1Gi7DiIzt3XxWHj?=
 =?us-ascii?Q?k3Gl/qHORPwRQUogevWTweQz1iisR06RgvsSLiV+pfFEglD7EqHI268WDjFV?=
 =?us-ascii?Q?e1fQZGft+WXyS9wAcNv+k8F/u8TAC6HiOG/vexnYGUi+RpneAfNMGUlMDze3?=
 =?us-ascii?Q?NIVTwgAEmsPAzWbGJ/AP5H/zo/WRCehv8mcxkYrGVnKGTETq7mFXMKAm+fV8?=
 =?us-ascii?Q?qnDAKFw/x7pBi9ArYqHA3ksMS77OGtvUGRvyIM8sTaGrbDunvQ6di3Tey51G?=
 =?us-ascii?Q?yh4py18TYmanLLMBSkc+IDcaszg9HfbCHvUHgauW+CP2Y/ZFOa1aBEiEiTOP?=
 =?us-ascii?Q?G0rkVq7HDZ1O3teRhIMopUIEoxKLeNXkOPWDNbIyNL2MiLNon7sYgypaO/4x?=
 =?us-ascii?Q?oYmMF6AoSLwx3Tve7KSxfN++z5mcVCHToVNOixerFcLASeRXBRnNeP9mJW+t?=
 =?us-ascii?Q?/qGUTPi6CrKen/IpEH3UjBJV5RCYhLUuy2VwPR0Ir3HL4nWYLwVMV76cH/5G?=
 =?us-ascii?Q?yfDBBq6mHZu0vCG9gwAOA1XPGq46UFdEhjt6b67NSVk3i585i9RhAp2HmEnp?=
 =?us-ascii?Q?bazWAr2yyHbiR8og49+Tg+cx5EfgSK49U0Ghu0ckyRN+4uLqJPXqBiqStB9h?=
 =?us-ascii?Q?+LQltAhNB4DbsG3IbJnqU9hrHkwz4++gN53qiOrqpXQXtiQBcUgyL0orGD0u?=
 =?us-ascii?Q?F6GqrhhQUmqwKGz4rG/NU7dtJec/AncbQAnfWLb7oW8irvIr77NHBsDuCocE?=
 =?us-ascii?Q?XeER8f2X9U4FQhLAemsaEZV+BFV50bzCM0EObkK8w+89/CgLNhip9zRaXhqp?=
 =?us-ascii?Q?Jg8yi2n3JvYMP5Z4rbX+j5p7InLuTyMd578olokVzgY5ARp2ud3+s5jwVUXD?=
 =?us-ascii?Q?sdPPQ+/ubqfKorp2JJtb7kHW6zdC1fF746COR7q7zdK6stvOio0IalencdRa?=
 =?us-ascii?Q?v3lLyq8VK18VecxaZDb2Ge+1GJX58Kxl28iBG9cTUY2EV2wUTNCTZvf8CI1f?=
 =?us-ascii?Q?vuJn3AlZzaKID1x20eX396oxU4YSQJ+Evvo8LZznHGw34eRVR34hk7n8ZVVc?=
 =?us-ascii?Q?t7x0806SUvNZpEgXgzUiOwRQZSQDxn8Hwl1IpSoVVZtkAbc06rL4bKiS/hr8?=
 =?us-ascii?Q?aAqkLC/0B07k5ZTFnr3TEKwI1MXtFpi+4kbWJHqIgRPTJTSWZpszlpN7oAM9?=
 =?us-ascii?Q?F0jGtHUqLxxMVoF/iE3IlI+J/VsSWpg0HjoP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xLMD9D+3lT916GrGu62IdbkDp1ZwJQ/lJnnueCsgVuSRvbISiDJ+WuBcdRq6?=
 =?us-ascii?Q?oiQSjpGliwuVnUe3nfLnLpXIscCNBejpsndnyncOyMP8CyJiqbBGZBRdFljv?=
 =?us-ascii?Q?6XZh1r0C4j7bP+MxcVPF1V7VCEnkSmHDALvRhH7BhpSrGk/Rum4LeZMthH3U?=
 =?us-ascii?Q?NEXjlp6wS9rGiGJYrJSy2tM3EpXeJ3hyPQ7Fa+t4+sH4iE7G/cn5xXzQslL0?=
 =?us-ascii?Q?IovIRMc4SfsLvcTHoCf6zln4bClsT5Le7eCf1ufBG24gUh5grkfLiqKM7fMI?=
 =?us-ascii?Q?nhzneziuYTo8MIIrRPUkSETM1gOytbERO/Ba1dFZgrwpDGw3sAYGwtawXX4M?=
 =?us-ascii?Q?2NicWvVieNngMO6J4NLMc/DzfjNoZgbzBrxz+yEfrxIlinEZC30NkCf7l/mk?=
 =?us-ascii?Q?VThf2dgoXZznL4T4aXfIH8JWRqTizg+pUhBhmJMV9Lrrjk/UqYkmKmOfmemh?=
 =?us-ascii?Q?eZ92LrWQ1zseC9ApY+yY168O4y5U2Ny7nhQd4hiZGkq+euIlBWtoJ9TMrYSr?=
 =?us-ascii?Q?6K3wMJu0sRnuAxXt419i17o6qz8rQqXQPpZeGyqptuRj34WXEf6NHjGCBnwP?=
 =?us-ascii?Q?yb+K7xxJQapJSV15MBtN6bVBgFVW5CMzNPuSgd5YfUO6bsMKdAiqqwj/wFCH?=
 =?us-ascii?Q?EtSAXyEeBzikkmyNNVgasH1dpZqwkvpArFUSaTiXmttV6vq13VjJKGLyTPdG?=
 =?us-ascii?Q?JMZg2ofQBy4r8b3m/AbmxNa0DAf9loKK0T9AXRLRVWblPmdMsmQGkpQ+Wi8s?=
 =?us-ascii?Q?lIebHT8EH2L6CiuUnDMcgZUlH6Fjd0tDbnpji5zx9UmQemd1ZV35sJJ6+S50?=
 =?us-ascii?Q?0A2psJgcTTGknMJHgQgooEYbeST5ST+sFcu/bFwbWEhZhomVrD1tQ+JmGu3w?=
 =?us-ascii?Q?c2X4mW8t7WrqrFBn4t+mcRxiCqUkVK/8e3psZVIFf0WtatnjHO3WkmiI+HFh?=
 =?us-ascii?Q?9IAQ704qoJMLVfLuPkelQGq3fK1QYjMpidIw9fUnMLanRzwBTygw/zhCRf/V?=
 =?us-ascii?Q?9BMAPPjObxv7TfHiIYDqddbL1m8diCtWSJQzGnyyHCk7wcUD32DWAHZVvxFt?=
 =?us-ascii?Q?GXxr/kmG7l0mULK9KV4PjT+YCaVfbpuxfoKv18UyLX7RWg/XhWa9YQ16QqtY?=
 =?us-ascii?Q?Xzk9fXOWzEfVLOPuWnL64EfrJtY14mbTGWFA2JBjEv53U9gTnx0VUtrAmfsF?=
 =?us-ascii?Q?dUYf/WVpbeix73wQVbEgBpxgFziZCyf11u/NRe3jIEHM0gfh/CcfeqWoMizi?=
 =?us-ascii?Q?3nfpk7Uz6XKaGKGke2scXugmcYLz61LBfOzBQXladBHDnbC55M6MIfZs5HwQ?=
 =?us-ascii?Q?1vTE646UyvOofxU4SLIo5ZVJ1EZ4Z59Kg6BpiNHLXldMTJGyNEJTwQ9D67QA?=
 =?us-ascii?Q?EUpucqLgh18sa3muIPuenpk/SBNQbg7Oj6fnbK1M3pLS1FJif8uKcQajts4P?=
 =?us-ascii?Q?Zu1ueIKxFQg8Pu0yA7IDHByjZUtHz0ZW3/PIT8Jb0/ZZ7uyVtR00qJXVv0Ia?=
 =?us-ascii?Q?Df0gOb1nUja0o4D3OAlCOxYdcEjjExvdwIzwhbyH5KeH8na1xMsx2XTtBoY6?=
 =?us-ascii?Q?ybWZJYn7r3wTMLDJDhl5dJI9z7JJZtvSjJCVCPD2xL9Jzn9A+0LCKZpHpQQf?=
 =?us-ascii?Q?7q126tKEBNu8fOMXMLqnXwHr5WJxgqn6vqHDBnxSz8iwnQihvCaAtoI7KKFE?=
 =?us-ascii?Q?F0IdVNzNhh3jQU0fTom07YM+s0s3wfSNQwtD/eRfV5nL3Y+7I4wc7DffnKfE?=
 =?us-ascii?Q?Jtehx/URow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	maeMaWqbQyjPoozDF4FGWRYcn4BqVHEfEOT3gJeeQwxc4e8nTDGZVFn3XzVWyINA7cWQ98wu6xw9xkYd03ZMMy6k6MdWK/wHvQ8FomvXx5O9lYVN+wv5DThr9jsPh3ada9whMTcqCHDGPk0wTMLIOa1GminYKjNvKHwKwKbhTQe3YhCEuShjJbEsGKFHDZdaoeocxMhrSdXgxCr37IXQPFi9oB+yr6y7GCF8/u7fjp24/+CW9mqIMsNlTKKjottWWq4ZfNHpEjh6KKUML28cInzvHC7JvXD3oVFYv6jHipjS/3a3JfhqkKWJhAU8N+OPUbpzcoi2UaS9ywKk9wGXYomWsv/UPqbitqu/wFBgbUva3UJYHVdro2naSkp6MdV0G+w77AKyL7xqVxJdkBbQB2kiewBEoe/rXVYKsUIJryOxFhrjeGS5YKZHxuatxvmcHvoGs43On/peLsFgJYDiNY/xbs08lzku51MTpS4JTOCWqzSbJt3nPDkl8K1TFUMwuQFb/xakEyhH7z2Ar2VBvEe5ozClhIygxq0uG7kU4BBvc75nu6AZJkt++4Zl4lS4TKF0DxS17510neJAXXBGgepUsFPTy31LZZHl2dNxGS6gMbA7wCDcmk2x/7D++IVv
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ab1ff5-0b73-4639-221c-08de469793e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 05:03:16.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAkUPMv6MaR6gScGVBSpFPY0Gcu1ch61o4fbpECcRVDRSXBvInvJBuqrBqbIozFNSve3fuZBb3G7OymBo/rZMxe4PN7WIRO2ziu7VkjDlVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8830
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA0MyBTYWx0ZWRfX0R+JbeB+KBwz
 ef9jhQ8eGHdH50BRJG6HxJdlvu8NEjtxuMCGf0e01BupQL4KwvgI6Vb0XcUtb3RJMpJ10n9McH5
 EYZz32l3J2JheRPB8tmQ+51kRJc6jiJzSzWaVDYIWuH3ydxmihVWowlNu0YNXQ7e2rG3HfYLD3D
 13DK3+4HSAlF7pAbioO8HBchqvo3dGp5kyAopNEgVeKvSb0rboFi9sSxxR5kGBDJz5Tf1agznZ/
 AN2OZUYNwX0i1YrO/EySByHJG/WI6Dn2Wr1hdnQ/P5ykhhCGsZYAayAd7ViaYYxJt/P2pWQO1XM
 qEEpSG87TCrUJzavOl4Vm+GCaCgBKOgfrgd7bHPZHuhaSEfV9CnWb5OXFt5VHPP7M6wa6Y2ppdL
 KCXQ4J988uMNNTwReh9lME0J0MQaF/ZqxekBVrjHTfOY/7bZmGne5q6tEW945IthFHmkWvZhs8N
 WwVTAROHNj6VTfgjjBg==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=69520b99 cx=c_pps
 a=1w3Rox83O5gulhrCDwffwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=4p1s0Iwa_o4pawxpfK8A:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: OAD_UQ2s70UdNzDIq7s4Qq4vz-rUJLXU
X-Proofpoint-ORIG-GUID: OAD_UQ2s70UdNzDIq7s4Qq4vz-rUJLXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290043
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 05:03:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2876

Hi Yi Zhao,

Gentle reminder. Can you please review the change at the earliest possible.


Regards,
Sasi.

-----Original Message-----
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>=20
Sent: Sunday, December 21, 2025 9:34 AM
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/V5] refpolicy: Add support to configure polic=
y store root

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var variable data direc=
tory while build time.

Added support for custom policy store. We can now configure path to custom =
policy store to variable `POLICY_STORE_ROOT`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index 964906b..59dfecd 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,10 +77,12 @@ SRC_URI +=3D " \
 S =3D "${UNPACKDIR}/refpolicy"
=20
 CONFFILES:${PN} =3D "${sysconfdir}/selinux/config"
+
+POLICY_STORE_ROOT ?=3D "${localstatedir}/lib/selinux"
 FILES:${PN} +=3D " \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
     "
 FILES:${PN}-dev =3D+ " \
     ${datadir}/selinux/${POLICY_NAME}/include/ \ @@ -165,7 +167,7 @@ prepa=
re_policy_store() {
     oe_runmake 'DESTDIR=3D${D}' 'prefix=3D${D}${prefix}' install
     POL_PRIORITY=3D100
     POL_SRC=3D${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=3D${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=3D${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=3D${POL_STORE}/active/modules/${POL_PRIORITY}
=20
     # Prepare to create policy store
@@ -207,13 +209,14 @@ args =3D \$@
 [end]
=20
 policy-version =3D 35
+store-root =3D "${POLICY_STORE_ROOT}"
 EOF
=20
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_STORE_ROOT}/final
 }
=20
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security=
/selinux/libsemanage_3.9.bb
index 2425a2e..99adde4 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python =3D "${PYTHON_SITEPACKAGES_DIR}/* \  F=
ILES:${PN}-dbg +=3D "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} +=3D "${libexecdir}"
=20
+POLICY_STORE_ROOT ?=3D "${localstatedir}/lib/selinux/"
+
 do_compile:append() {
     oe_runmake pywrap \
         PYLIBVER=3D'python${PYTHON_BASEVERSION}' \ @@ -46,9 +48,21 @@ do_i=
nstall:append() {
         PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR=3D'${PYTHON_SITEPACKAGES_DIR}'
=20
-    # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
-        ${D}/etc/selinux/semanage.conf
+    conf_file=3D"${D}/etc/selinux/semanage.conf"
+
+    if [ -f "${conf_file}" ]; then
+        # Update "policy-version" for semanage.conf
+        sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
+            ${D}/etc/selinux/semanage.conf
+
+        # Update "store-root" for semanage.conf
+        if grep -q '^store-root=3D' "${conf_file}"; then
+            sed -i "s|^store-root=3D.*$|store-root=3D${POLICY_STORE_ROOT}|=
" "${conf_file}"
+        else
+            printf 'store-root=3D%s\n' "${POLICY_STORE_ROOT}" >> "${conf_f=
ile}"
+        fi
+    fi
+
 }
=20
 BBCLASSEXTEND =3D "native"
--
2.43.0


