Return-Path: <amanna@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA10CC6B00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 06:05:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9647.1775109920452738941
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 23:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=MHL2lEgI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: amanna@qti.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M40qY547072;
	Thu, 2 Apr 2026 06:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O0ucN/LPpxLIw/kPtPnzFK63Ct0XDqV4cuymhJKiFMU=; b=MHL2lEgIIrEZaH2E
	tJWjmlkBqTm+R1vQ51pllIiYiijvFVcc1VIfuI6NiY645y7IFUJgpPRyeoiuLEXn
	Yf/fu4S0O63QDQfeRinaFOZZaln5/pWEW/u42o09N6lNAR5j1Ctbo14y9n5yZ+6y
	1g1fOf83uFMWflE7M7kJe2uVua1cnYmffqMBa3KByuVvgXhlHavSzWAN/HExI5f2
	0+CJIcwZfDchc1fOOlDw2NyfGHCr8vtp6c3Rjjzl0nJCJrv5CM/45H1QMeTbZLup
	BHvVY/OdLoIE6nKa22uLZOwnwu+2OPkVkkQ84qp1aTm6op1/pzGPgF2g+mGkqCdL
	flcf+Q==
Received: from sj0pr08cu001.outbound.protection.outlook.com (mail-sj0pr08cu00100.outbound.protection.outlook.com [40.93.1.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d94vvk6j0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 06:05:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INjufBbzti5pmsFhEWwFsxobnyav8vWytcIbPSEWbUQEo2f4uXMr7scGg+bQCHXw8yTPCI9FaVtPVU1msS0QSMfBPBApCbkyF/QWYPzRdNgkUQdFZqs+38XcJ/5jzWKZ5zwcacUY54nmNcQYdS0pUk90NvzR8hdBpBVLGH1hHs97EbC1SNDZWXgqPVgCGhEhoYRt3GocdMJcVNjaHiHPB4b20QUON+BvdG8U2/NI3Ev8DzN2RHlfanNtrerAiFj11uUY+sQ7zS8xNxhMsRLSyoPVy3jYaOBIKt/r17HnT2Mu5rahoiIh247CDobjxw+Nubd/vc/FTRxKPJ5k7jkuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0ucN/LPpxLIw/kPtPnzFK63Ct0XDqV4cuymhJKiFMU=;
 b=RF1JLK6rRG+gsVRB1Z/ENFy/lFp5NrN63HO3JONjALfSiWVJU66wViIQo5C/RC/t6mkGAj28+DqY6/PG8Wupwy1bqo2d15Dd0tL/i7fFvKNLS/NoRlNW6M8XZWHvI/nqyS/cxJtjI9ezlZ+M4Kp/+1FpWn3YooWKC+SXjeyutBbIuvRPfBI2mXPXF043tNl4RtCnxTtqSWMsNndrmi+xrnLA7KM/ZsHh18IiY/90Bn4yKbJ1VR6hVmhdTCfko9f+1CkAZcGo1QKcu4rXBAw368Ncm/pNb6/l+U3pT60rMaD2A9XBwBPSQhqDjipaUJ405XEhpuX35SUmQmE3X3WLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA0PR02MB9662.namprd02.prod.outlook.com (2603:10b6:208:48c::15)
 by SA6PR02MB10455.namprd02.prod.outlook.com (2603:10b6:806:402::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 06:05:16 +0000
Received: from IA0PR02MB9662.namprd02.prod.outlook.com
 ([fe80::e7f5:3876:22ff:5d6e]) by IA0PR02MB9662.namprd02.prod.outlook.com
 ([fe80::e7f5:3876:22ff:5d6e%4]) with mapi id 15.20.9723.022; Thu, 2 Apr 2026
 06:05:15 +0000
From: "Abhilasha Manna (Temp)" <amanna@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "joe.macdonald@siemens.com"
	<joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: RE: [PATCH] refpolicy: backport fix from upstream (PR #1095)
Thread-Topic: [PATCH] refpolicy: backport fix from upstream (PR #1095)
Thread-Index: AQHcveBQvrkMbhvxQ02fSLg1HFVomrXLUU9g
Date: Thu, 2 Apr 2026 06:05:15 +0000
Message-ID: 
 <IA0PR02MB9662151AF1EE58C0F587AE16FE51A@IA0PR02MB9662.namprd02.prod.outlook.com>
References: <20260327115257.2625298-1-amanna@qti.qualcomm.com>
In-Reply-To: <20260327115257.2625298-1-amanna@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9662:EE_|SA6PR02MB10455:EE_
x-ms-office365-filtering-correlation-id: 23d8db7d-4692-4646-a0a0-08de907dcf78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 3CDod61DDAIp1yFP9DvNpu6k4ST0mkP2W/hlyCAuGeyWojWD7UskdvKKm1RT4HT+NUbWZiaV5Q8qzRflyKC4kXMFASaF/9Ghs/3XETjz8xrriaH8R/z6fzy7k5SCV3E2qyvwBhfs5KovW+IGRyNIuTBhlyMTJkFCeJ9SX3mS1eA6aB/ID82dj2jehDKF1VHAEpRrTnpw8oZNZkcHfP6D/Ar8UwDNFz0fSsBsRJgnyPa/AlFi/LVsEQXXivypv1CSH3F4rKE515USriOdtvyz/g0RuhYfSGQQHsSlVvGaKb8YkgK3NjUiyjLMVthQ3pTqvU++3+/iJye6qMLvLk8vAmR0YZKBxomLjb+3ZsQAYEM4MJPdKubLGZJBE5x/qlxSrdJEIglSVxciYjRP45aoWmPiyGnLwPO1hlU7JRKvC9Un8RpeVwBNLTRvsh42Hh5W8rneNObmvLxQpUgtQ1neZu71IObYyahTEyjW7C/sPyQl8g+MA2mlfw20Ggv5sOsR5TLchV70jStyuVDR1DZlS40Tuo3B+uRdk/pFATrCVfXoROidw1gMQaAxNckmviuv7406FeBpQ7iqlpmquPGN7NRRqCnmryqDbRSQFDZaD14xFEqOLjzYUUa4Sxd28GfKqs5/HRX51G2rU6kgf2/DHLqJ8Eqcmg06fJ/pUKkOJvNiQum5N8vdAJkG5nfOXd2XMxB1UNUWau9wPrFlt24oU0rVQXetq0JjnigccZgCYbmNsdltsaQdiL7cwtKPRaZ1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9662.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7ni2CFRIsFRRFtHPscmcDrRKTZgmGaOaWzeUkNzq2DL9jEqLbU4iWMOSNrND?=
 =?us-ascii?Q?pouLRVrqNnurxirm3ClHeaLQP2IRZB8HHtHWxG7vtJbQTRNw/S9cMHufDAHg?=
 =?us-ascii?Q?+KhhqbV7jr/0dUQhoHbpIijbW2TtQPJf4pxdzN5wc95Uki/B1TFimaPlx3vB?=
 =?us-ascii?Q?IaOQ34iDmLk83tQl0dGa66NWH0tpcEEjJKm0nA/uIzN8rypbiI34kLtAbI2b?=
 =?us-ascii?Q?cH8WsXI88MCyRzTfssfXKZ9MDchaxSQcif3reX2jLkqAnVW0/uY3HP9nHyGd?=
 =?us-ascii?Q?GrHd3oKuxbdLj1uEkzkB87Mq6FvTpzlgpah6z0Sqzn+wVHaiLlT2abBUx4RM?=
 =?us-ascii?Q?qiNYRnUmIhpZosz47HWX4s2ZFv8dHaX9kMBiQCQA66tc+PdyRHoZKkWpi/YB?=
 =?us-ascii?Q?a7oF7A3qRb8H1Gj3rFm999bf9PdPkjEUDNDpsUQWjIytzf+6kqKtt0V5+iNB?=
 =?us-ascii?Q?dCMVkccrOMxLqyK+4JQHLsPvZuz7AmZ9kEkHPPRw0k/pDPzeF3DaKPUZVmvF?=
 =?us-ascii?Q?7v768g/3Xa+TuOCSnhaw2PHaOvu54DEnZ2mgpveszfNmokzWViMYdnOMvXxo?=
 =?us-ascii?Q?g7/wyi4s8i3CC1CTPg2RfwLuWS4Yk+yh5m/aosCUBy0d1sq3yX+WPdPYTRBP?=
 =?us-ascii?Q?rRgEk2UMUE1rM62CmsHifX2HxGv50FENm4HG9xIY0rMfLhzj04hNT2KsIXk5?=
 =?us-ascii?Q?2POL9qfQpgiJSnlyOAb+Xkk4pS5rBtuuDub+b/JWfAUdsxyk94AKZvr6WdlS?=
 =?us-ascii?Q?uc6vSldyu0DiwY0aH9LTQYmfl1BLl1id21tl3kROll11ZA+g0ZfYWQeEg7iE?=
 =?us-ascii?Q?Y/8QHhF9YHcUXUimP2D0uVdK6U5NfgHFCp3gIw418Q1JhzLLYWoYVisqQEt5?=
 =?us-ascii?Q?07+cCbhwdPprwyAsOOylIZJ2WLrmAJbNkTep16gAHqTdrfl6hfMP/NMqFPt+?=
 =?us-ascii?Q?q4x83qnje7reQWT9difDuY0CW//LUXiJu49RAMyQKWbYsootGUU4ch8qZjja?=
 =?us-ascii?Q?1TE+5CbdhyXDXF2OgOcZq9dB8GUBOZXgrw6+jmjwm5re/S+LuhFMZA8oIQOa?=
 =?us-ascii?Q?+XoXniBwEZQdF334+N3dzhbvtCjoGOOG/ip8H3YaF2+MW53uxSda8a47r/Gn?=
 =?us-ascii?Q?ReYjEtjQif+unLhqUQCK9I3TB2NqyiNNNfbL5Wl+ssZ6/00qfIdJH/hTLWoB?=
 =?us-ascii?Q?YBoCBxpcjs0Rieo7U07o2DkT2sT8bKDUQVqn3/wNIe8sitFuhxejwhig/QyB?=
 =?us-ascii?Q?Qr55Uv/+z/uVTsl7razRA2xGxima0yDpnKApYumfsU7mKrW0OGL7rMtCv6C6?=
 =?us-ascii?Q?DPReakOToRlfklsFdQ1+JVLBwvTVsTOWjbgbRIIiF2k8P1EbvWiVUeid15bg?=
 =?us-ascii?Q?2scWRNTGIEqj+Os0dp+1OP6UrPwa3eOPkRTGuQuB+wPHRZRBFWv8i6eBuYGj?=
 =?us-ascii?Q?9WnChw/dy/G3JhywrKmdtFjqyb2mKuMRq/nhv3gr/a+BZKS30uMLA8Vm4ebH?=
 =?us-ascii?Q?97aRZAcJl0tCyjSr4Q/ILz25OqFhOVYqFayk17C/FGl1JNN2uOnWLgP2HOxn?=
 =?us-ascii?Q?dZqRTmaV69ZuDnqZeeNSGCLleXbIuwElNRLeG3SMeIB7tnsTOGZmMPRCHML2?=
 =?us-ascii?Q?y9oKV2EQJ577LXHeyAHJ2v3VGFQk9Luzz237OhSPzXHQdziZ8DEaCc3McXsY?=
 =?us-ascii?Q?eeVtdIIABhql5Reek88P6YNmj3dPZTFtYeTd/ZNUflQB1hWkAj0yOJjf3/pU?=
 =?us-ascii?Q?6ZlP2OKF6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	CiKRYwUmQGJOEGj2LuzmaY+ezrt/GMTp7s+iUoAttx8BUENkucABtdfm/gW9DluY+YLhrd5bLJcwl2KVwz+6u+oTYmBKEAm9sQuhr9XuUMXQcvr+xkZQ3JTr4G3wQYFVAD/399o0V9gGYHUF9T1ResiTOwaPvtn/jwxk7h3uyBjphxG3pDnr7VrUk7VM/20rMF0Yk+wcmytqYxie58124Y6PHDGQDozNCqGA/l8GbRx/4u2rYgpOmiKA/v+RqEzJtJ1a9bwvT6DpylUsLZhp1fdtXtPfns4p+aB84P7KiwPXOY17nkcZ5CzLm5IwZorzky3E5hw+TW71MN33lPdUhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tjnA7BzTdUBTw434OvSakSofabGFk+l+aTxoPpSpfWm/mqrASSFFDVPaJdnZ+KX6sie0UgT3l0rgD8u6nU3hDIOrrh6uWkCrs3JBdIHYQsZ39PkSdmaGim9/d69dPaN8F2ZMapD5UugAHW3i1uzO1UfptCHANLkBIgYzbacAA9mSEWPK0g+HCvXw/gLawqemwZ0ShkbkeTZ1EjQU6kRm/Tvo75LhEOdWajwW/Tuc1S3naWHJ/Bl48ZoD+0z7sMoykkLIBERPDJlPLFoijgspl7IL+Fk5DuCyinjijAo4/YiC/mHe8wsTsjIKYM41uJbGpcmEYnWvnpAuumRJiR2H/zv2tMoU5OM3T2AnF6+s6gwwikcLFOPW1ndJHSNNIJiELhpeX294uXoba2roAT606EOJrpVwWoX+HsHJqzfe6Oi0JVvrT7l3xhUhDX0UDGQya4Yv59Sv8F6JdlUfFVlCQWixB2SDdrnSEcDi0bsORrI55pSmODtDkFGA1MIiWkCkooLvmfkwQdIdlMnHtrKrKUjKEtwKKLp4E6ZvlsM6Ja20ZcGo3VHMWR9sOQ9rL/QMN6fLJCHVYZy1LsQNDzr2Re+vL+5XlYtNPxEp3GQL/yBcWRW9qWrQhDhJ8uTg3Hg7
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9662.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d8db7d-4692-4646-a0a0-08de907dcf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:05:15.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lP9dF+CvaOLKZMT+VUt22GLqgvIzF2nWZMfOnlyKJNWxYD3jPlIyJyGFrMKQyGHJvy594omD8POvlFi7EsaKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10455
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1MSBTYWx0ZWRfX9Qqu3rGMFVi1
 23AtE+gaQc4gcYFuRbnsVnn9+BeFqJFqsdAfPOFfbwPWBNExAuqrimbNzhayL5c1ZPL3YHOsvYE
 qZQ2m6UQbaeCruwx3Xw5thksWnPaFXm73R155uxaGzCj0UaKsF7du2P8zZQxI4oIhMMJfZ1sul+
 e0T4WpnR3Dvi+BsjrhhvHbIaoetxNZryqjcJoHP5UtGdIeKGIYK8AId4jWUuduPAb3nIdSQsgyh
 kVf1FuyIBNB/fr9t7PmZD73q1uA9km3rkemBRXAQ+ir9qxfywVqNVKBykoiIMZ4QLquWj/yP+rQ
 f/2+IzgxdUlAn6kWGcJuD5PaS5pIVJ7LFmKEl1b6d9yZiK8K5afUcJ+Eh6NwLz+Zsbx9dGbooYi
 kD6GTAke3u8UtMSRkPKthpcKl6Gt5iolCU1Jj0cNRxL5XUVp8TeMZ4xJkFdyUsKenDOnRYRBypC
 b4yKKnerTy01z/Ao1zQ==
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=69ce071f cx=c_pps
 a=uKiHT0CEEWUIj7nPKFokmA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8
 a=JvC2pvXHn6Sk9I6_jSEA:9 a=CjuIK1q_8ugA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: ZUebGJreC-yTmk8EYbJr5jUm9Gla76G-
X-Proofpoint-GUID: ZUebGJreC-yTmk8EYbJr5jUm9Gla76G-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020051
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:05:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3603

Hi Joe and Yi

Requesting to review the patch.

Thanks
Abhi

-----Original Message-----
From: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>=20
Sent: Friday, March 27, 2026 5:23 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>
Subject: [PATCH] refpolicy: backport fix from upstream (PR #1095)

Backport upstream SELinux refpolicy change from:

  https://github.com/SELinuxProject/refpolicy/pull/1095/changes/e393fdc3c39=
43b27d9808311e92c14af68345f29

This change is required to keep meta-selinux in sync with upstream refpolic=
y and to fix issues observed when building or running SELinux-enabled image=
s.

No functional changes beyond the upstream fix.

Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |  1 +
 ...irt-hook-scripts-with-dedicated-exec.patch | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0078-virt-label-li=
bvirt-hook-scripts-with-dedicated-exec.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes=
-security/refpolicy/refpolicy-targeted_git.bb
index de81d46..beda1c5 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
=20
 SRC_URI +=3D " \
         file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.p=
atch \
+       =20
+ file://0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch=20
+ \
         "
diff --git a/recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-h=
ook-scripts-with-dedicated-exec.patch b/recipes-security/refpolicy/refpolic=
y/0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch
new file mode 100644
index 0000000..79209fc
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-hook-
+++ scripts-with-dedicated-exec.patch
@@ -0,0 +1,74 @@
+From 2edbd77f1f6aa720a9ed48f27f9dca43b8935261 Mon Sep 17 00:00:00 2001
+From: Abhilasha Manna <amanna@qti.qualcomm.com>
+Date: Wed, 18 Mar 2026 10:53:58 +0530
+Subject: [PATCH] virt: label libvirt hook scripts with dedicated exec=20
+type
+
+Hook scripts under /etc/libvirt/hooks/ are executable files invoked by=20
+libvirtd on lifecycle events. Their current label virt_etc_rw_t does=20
+not permit execute, causing AVC denials.
+
+Introduce virt_script_exec_t for hook scripts, add the
+virt_exec_script() interface, and update file_contexts to label=20
+/etc/libvirt/hooks(/.*)? accordingly.
+
+Upstream-Status: Backport=20
+[https://github.com/SELinuxProject/refpolicy/pull/1095/changes/e393fdc3
+c3943b27d9808311e92c14af68345f29]
+
+Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
+---
+ policy/modules/services/virt.fc |  2 ++ =20
+policy/modules/services/virt.if | 18 ++++++++++++++++++ =20
+policy/modules/services/virt.te |  5 +++++
+ 3 files changed, 25 insertions(+)
+
+diff --git a/policy/modules/services/virt.fc=20
+b/policy/modules/services/virt.fc index 1441a50dc..eb72de5be 100644
+--- a/policy/modules/services/virt.fc
++++ b/policy/modules/services/virt.fc
+@@ -72,3 +72,5 @@ HOME_DIR/VirtualMachines/isos(/.*)?	gen_context(system_u=
:object_r:virt_content_t
+ /run/user/[^/]*/libguestfs(/.*)?	gen_context(system_u:object_r:virt_home_=
t,s0)
+ /run/vdsm(/.*)?	gen_context(system_u:object_r:virt_runtime_t,s0)
+ /run/virtlockd\.pid	--	gen_context(system_u:object_r:virtlockd_run_t,s0)
++
++/etc/libvirt/hooks(/.*)?    --    system_u:object_r:virt_script_exec_t:s0
+diff --git a/policy/modules/services/virt.if=20
+b/policy/modules/services/virt.if index 9b28d670e..272034f0d 100644
+--- a/policy/modules/services/virt.if
++++ b/policy/modules/services/virt.if
+@@ -1274,3 +1274,21 @@ interface(`virt_admin',`
+ 	dev_list_all_dev_nodes($1)
+ 	allow $1 virt_ptynode:chr_file rw_term_perms;
+ ')
++
++########################################
++## <summary>
++##      Execute virt hook scripts.
++## </summary>
++## <param name=3D"domain">
++##      <summary>
++##      Domain allowed to execute virt hook scripts.
++##      </summary>
++## </param>
++#
++interface(`virt_exec_script',`
++    gen_require(`
++        type virt_script_exec_t;
++    ')
++    files_search_etc($1)
++    allow $1 virt_script_exec_t:file exec_file_perms;
++')
+diff --git a/policy/modules/services/virt.te=20
+b/policy/modules/services/virt.te index b0bd0a8d4..50028f615 100644
+--- a/policy/modules/services/virt.te
++++ b/policy/modules/services/virt.te
+@@ -1257,3 +1257,8 @@ sysnet_dns_name_resolve(virtlogd_t)
+=20
+ virt_manage_log(virtlogd_t)
+ virt_read_config(virtlogd_t)
++
++type virt_script_exec_t;
++files_type(virt_script_exec_t)
++
++virt_exec_script(virtd_t)
+--
+2.43.0
+
--
2.43.0


