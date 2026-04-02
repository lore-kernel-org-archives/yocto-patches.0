Return-Path: <amanna@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF364CC6B00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 06:03:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9675.1775109781020210171
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 23:03:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=PWpeWps/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: amanna@qti.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M41PY1424282;
	Thu, 2 Apr 2026 06:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	39hA2XbUY9dkhiddjPDhn2hEFhGcTKMabHwtjFJ2Mgw=; b=PWpeWps/TVyxgaym
	xIzYbqOL5galqCbxxFuVndL4nbatp3OmoSFwOFN/KNk9bxm18SlDk8So2K0FtEn6
	ckxdQfx4TN+BfGgQdYlRRfmUWtYUoBNtPRIQctzjcQ91l7+ENhXLfjTPb4nB1eWa
	AL2HLV6RjfqskObjjvPIXIYZ1sDu9FBN8myeklmmotPzFX/OUZgzNAuxtd6Jw0mI
	AchAlVdx4rVQBhsntPwu7zYz7kRSW3iyRbt5owdcpgANMCjzly3eUvzV7t5zgYJz
	wXtuuZi5MALm9s4TVZ09INeHxpCwRz5l9Q3AXUWF5PkD1Q0df3XrIreyRel5rPfD
	1YZ0Pw==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9511b4q5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 06:02:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh8ueHFN3UuYYY86EdQMs+05wsoG0jzgePFx3TOcG5HsX1kccOxRAXggF67MZSVSjjJW900a8zQm2ngUBF+dkc2za0HfkwE1pLoy66fJOaMA5Bntakqtbf5E5OQIbW1LcGa7I2Mtgr6MrmmiAagfkwFbib42iDtq+4cPV4Aro+MKtumzapf9Sl8A4Q6KHnY09diwtB+bRZabM40S+kNybNnsHRxci6v5nuEnALN+v7Zze8zlDsiXEiX+xkHsEtXWOHqyU2bYuPJamvX2KmsLDfJd/T/xV4gxtbZcvGkqV5J8OUUVthQgnHACYS8HLHVLuR9jLxtr/oSmCBVsl3N5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39hA2XbUY9dkhiddjPDhn2hEFhGcTKMabHwtjFJ2Mgw=;
 b=ZYZQXnl7DskxNJp9EdtqgiSA7IiKb7M1fbbz67o8rg3U3lxuTwHlxSe0hC9WvbZjUZrT9iucM0yJC5K3hFMW0GniVLeUO613IywBiisFhXTkuTUS59HvxzaIAFFrtiGYoEhCnF0pZJZBaF0FRfHGVuc142VebYFKNqoxrPzXhovPnlASyLZa/LRshcSuR1L6OfkjkJ6rvcJ264hdg9kjlm5Ag1oxtFIdYGLMjKTuwzPkcfSualsid/s9IdMPtp4U+VASBrnASpSw3WiyEZrlMDSlueTmpRD/H4bxcy78+Z3UalbEoydeYFocboVeOaPQCdx7P49UYcprbWdYPA5XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA0PR02MB9662.namprd02.prod.outlook.com (2603:10b6:208:48c::15)
 by SA6PR02MB10455.namprd02.prod.outlook.com (2603:10b6:806:402::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 06:02:56 +0000
Received: from IA0PR02MB9662.namprd02.prod.outlook.com
 ([fe80::e7f5:3876:22ff:5d6e]) by IA0PR02MB9662.namprd02.prod.outlook.com
 ([fe80::e7f5:3876:22ff:5d6e%4]) with mapi id 15.20.9723.022; Thu, 2 Apr 2026
 06:02:56 +0000
From: "Abhilasha Manna (Temp)" <amanna@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "joe.macdonald@siemens.com"
	<joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: RE: [meta-selinux][PATCH] refpolicy: backport fix from upstream
 (PR#1096)
Thread-Topic: [meta-selinux][PATCH] refpolicy: backport fix from upstream
 (PR#1096)
Thread-Index: AQHcwaNbeAB85g1qcUmAUYEUtf7D1rXLSHaQ
Date: Thu, 2 Apr 2026 06:02:55 +0000
Message-ID: 
 <IA0PR02MB9662973B0F9D0FA602857EADFE51A@IA0PR02MB9662.namprd02.prod.outlook.com>
References: <20260401064624.2548716-2-amanna@qti.qualcomm.com>
In-Reply-To: <20260401064624.2548716-2-amanna@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9662:EE_|SA6PR02MB10455:EE_
x-ms-office365-filtering-correlation-id: 485671e5-ee3f-4aaa-a754-08de907d7c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 ka4zO3NS7tLOnc/XiVeHQ0ATKejfKTSeFdHImELRgswAQO82rcV7uNyfp/7qzUAM14PP2as/Tc7hjtDCJmZlrRBObU0kk8ekD04Lha8pNM4rbJhDkkzMNyPSl/WGSf7nqYp4LrKfVOfiyXsr2DOxoTIntPxrCj7ji96V4oO8yR+TiFmLFrZCSNajuyR1Z++p8stfQWHwkPjR+UfY6CKlEQ1nhH08CnRVsT4MxzjPBpimVSLqMkJBMvSqWs+VO9TsDxOxfsmhTV1YA8dt3rtCrwS1o3lqoQlF8Nx7KLq2ob5NapH6aip7K2nbH2KQDlTkB7O/Rj6JOEq1M0Gofm8cTe18WQG3+R6T3/5e7rGUVzgqdjoAsGrBHZTcP4nfkzXfka1VjQEeKJiWaefDUcu29GORL+Nj3z5VuGOG3qpvydN9p1EEggpbcGcWo/zj8jv/gOd1GM8cQ8ewqc+lhiQAitqluOiGik9lHtN68OKpxiBKMlJG1OLgHO8ihr1TPNkK6lfAcXbA+Qec1nfo+1+MzbXTGmUzkMBhV/JwPY4AXnC0bagzKnAAmCYnufqGOTJsbq53WjBuhE1bcq2GGcLKWQ7EhxoOW7zMUO/SoQcVXLiKL8DW5owml6w36q0c747pcCKQ5Nw1dRtjGnn2lZsiiGt3IhQknRtgQxwW4E8jGuV6vk9g1HxoAWcyQOeyGNooo6b2uY+rgodVNs5TGXZVgFtKxfZYDbxA644q8sMf3chV+6S3kVKY96F38/wwPa5H
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9662.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ylrNO/B1C0bRF93j2mmrAH27/xHE3Xe4rTzX6mt0l1CGaAZbSXPyQ4WYk7u7?=
 =?us-ascii?Q?MzOIlNrrZTjjRI6cDgkyibZ4NBcRudEN8Zq/n2A2+17lHzps++pdroEaO8Zq?=
 =?us-ascii?Q?QhlpouuatTJ4ztY4Di2l5YvQV7zVWTQzXh/XRggbR4yIjCjUblNbvv8pGxyv?=
 =?us-ascii?Q?gpvgfPsGaYlK3zlkojc3JSyt36mJsx5LULDH9wzlkgHQdGNJuuJDsRoguY/n?=
 =?us-ascii?Q?HL+hazInhDJ7lgk2srKsXFOC1xTjFQp7fnn3XJL/bEkPVDCx1nVOG5yVAZ5O?=
 =?us-ascii?Q?kQFy0UZ1UtTCbkIgh03pnnYfpF5f19zxutv3T7Z3S00egtsLcB1ycuIEK9Zc?=
 =?us-ascii?Q?B6/lQqgMp9EjJR6J6sPPjdOk2YCm+B/Y/yVdJmKludkTqc6yU6BI2UUMUEdR?=
 =?us-ascii?Q?nsScQMs7UQep0GmLvioz15TNJOqC6SIZGy04wtO4Q7KkQrlY+8WZNfY4pomA?=
 =?us-ascii?Q?QZSIv7nGDm0IRS8rOLl1mvdxK/oqYDSRrxkLBx+fqbjVMwfnlDIBYs/nsrgP?=
 =?us-ascii?Q?8kR1Gq2cJlsecef/qAOMZExabhcYGiFUQ5mW/P8CtjzKfTRXofL7R0SdUiY3?=
 =?us-ascii?Q?Bi/ly9kVYM+TYYWHpumOIbBhYiut0uMW1ds6kzIMadvHk+axaewDpSToZuCE?=
 =?us-ascii?Q?U7CBRIx7jhsr0I98SfW9jrawGDp1+oC6se1044p2rDzBC+tXFey591Cson4+?=
 =?us-ascii?Q?+4G44cznfvFtSpq40zLanOu2LoP8queY3OYkMHvQkgaDh0nXbKRpTaVkS9Pt?=
 =?us-ascii?Q?W25x3v9Mm0q3yf1H0xlLIOPZNWPl52K5qr1NYPkV6FC2wUhiUyV7uEks7ipQ?=
 =?us-ascii?Q?4qiokFNKmqDYccuXtXACFk5ccdZug6cnRzTZkb6sWuUaSQuNRzrPor4Y/qcb?=
 =?us-ascii?Q?9SQ3vOovcLh5MG4XVM+nue6HT21y6a8un/wyC8WsGrSMHdPaSWA4hBANFGIj?=
 =?us-ascii?Q?1VrTJVMy7JTdNHinfOkm6wnbj8gCeBV/1wvdwcMHZkRnCX/6trxUjTHwiAqW?=
 =?us-ascii?Q?+cERR7AVa9GpnvNwx+7uU4hhr9N6TUA2mCfvmTHleuYA9zKq7mb7XvWxxnzH?=
 =?us-ascii?Q?ny7PbtxUtPl/C2k6dn1T1L8E4kwkG374pZ15NMcEkv9BMglByBrKKjxiND14?=
 =?us-ascii?Q?Fxenn6b59Xe4v9PqkmGSRVMjKhS/KAdVCENWHJg1uGfm/6ZgWPw6QPD0TF37?=
 =?us-ascii?Q?J+2ChktmxxylsTQkQeBU9XPAfEpkdaRto8qRxeiYxc/ueBOsnHl897QzMI8g?=
 =?us-ascii?Q?/oz+GPkJrwmLogJXLiMdFoeP+mTLtk0WmAKo6LbynVQ7wDXLsJirYciYUJxH?=
 =?us-ascii?Q?EggvQvXGzhJnYo/Rn9344jJBpS0SQtx+3SpUv4Zp+k9e18+zx65ejmKDkz5a?=
 =?us-ascii?Q?wyMKdrVwLiVZgkqKTEXNSww+ktUxVTe42Z3jNU92KxfEEOfS6fKz9YynLo26?=
 =?us-ascii?Q?5HaEHOpVr0c/53ELRBo3FVjtjNGFOexVf2v0Iym5zzKlIteYP3n5iJDlvJRL?=
 =?us-ascii?Q?JLHuAVG8OKLeUHmSgO+awxjjKaNUyPIGv57N4uYQJF/8K2CXKe1BhiiFzf71?=
 =?us-ascii?Q?l/YPLpNUTX8jDBV1IkUKWLJpkHFlAPOcrLUcTYea2z3zihAo12yGsQ8rw0J0?=
 =?us-ascii?Q?1Oaj0fEY5x5AUwIbanrD/H0R0nZDb1YG2vB2eUl8f6qg3u3gCBfAHoF3u1U8?=
 =?us-ascii?Q?ydHBgEodk9J9O/NL+mpHzTK/GBq6jVZP89qk4t1nRQYQYfLuBPKaKf2wy2Lt?=
 =?us-ascii?Q?sxBNWhAwpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	m2NuGQ0dcmONNUoDMStAv7LFQbqMx3R50X3AyGQHnH23xD2rYRfJGwutve7KK2Nh8wQlgnl0dvi+XK7sKc74NA6Y7E0MEqgA6voXgpl94WFVwgKD27WNESopq6ritm+XO9QxDE/eYbA2YZlxLYX2n0MlZW9uzs+KZcqwASSRF/SYuTEr3GOT4h8XAKUwjE8lSR+3N7/U/oCRUuLNn3vpM9Sh3XiEBtmKBszyMwiYNAqgYyTiGobRB0j/IxebMgpUNsjGHSb8Jh9pvy7+BlnUsPvtzE6Bqx+qFhpDlVTGg45U/m5lg/5Cmu8FdL9qLQ+8rUNiiMUrjW8UrWQSbxDCcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A9XwqixrEBZdKZlytrQwi0Fk4LLcioS/JmSaZZ4iQqoEgwPLCBkp4vUzw5lhO07/5uekMN3yX9cDhCDdtaHasdNZmUUcH95OJEPL8Nrne+4cSOqPa03kYMD5ERZdNypSyjpHjQLnAeI7h7d/hQNfdFB2W35QfH5Gae+yxcFxzIGe6djppjJ69SZie25uKLHdY6H/FqyBhUjzWVCG+7iQTAwvcNMVBcdtT7li1TNU8uo9WdROVJquT4JdqQpV/jjJn37htBTioDcuJu8WEcA3MNDbCCVpGFp0Swh4LecZHcS3B8/URsRiirRrIe5EMHc63w7DuhK8Le2r26cNZz80GLxx/50BOHGTk9OkWev4MdE7eJI/v9R0Xe4rmZWfNuv9clMNnKWghHdI2Seuaht3Z3+iwgKHHVeGOZ5zXBc9xLd0XyYnpNOMecYOE8pzaIawAbSimp44lcwRlSYZkwtZDGEiCHhR0Dlg+ti1qe/jgrRtdb0pTlZta3oSaxmk4Obq5KWPjg4nEd/vLMfBDqfaQ00YWt8ZPOGrH5Zhl4a+++USnDiM16meAOOYinoxJo4bA46Snq77eSBCHs5wRa22NvUbj6OjbiJD/NLlsZf3/nXTxtCjPcHvybPEL4Tt45vv
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9662.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485671e5-ee3f-4aaa-a754-08de907d7c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:02:56.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cQrrbj/aOMCdVT1b+5UwSGzJUAcV3AJJWAreRuQFTjQcfdieN3UArs1B+hXrXSX2tEZ99GF3WogzYl5qP0oCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10455
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1MSBTYWx0ZWRfX3o5anLn4nMZU
 e/0ipJE2Z2yA8m6NTlcTBR3y5Zi7Z21yBEVWjFlQihDLeP0i3On40CpKSRHf14FjRS9QLYdSdZ2
 SWKdtd1uOU0pU9TT1XjMz25slDz0mjERH08rz5oOj/Kurz4BeVp3X0Dnkk9rusJEYFZdHf1MZ7x
 F1yE8+UAeUo9PYLMtcEGkd6abHAE+7HrfTeUcgbA/P3W+813s4sHMSM0gyFkFznkLRxcX+nPvWM
 eqos1lBKR897en2e1vJNJ7L8S+vzp1JhcUtC40oPlTnpulVCbm2uCWpjyMRk8LjBhftQdvNOSAy
 cvoc1EctxO+B6O024NcOVITBDRkElwf/7l5zygYhRSl6q2CUbwGtO0bHqPR4X8+F69Wu0xi51Mo
 VmXoBkXuNrXEGW8+LXuSGxlvQzzBXrixl64c4BvfOMNv5gNYcuAmIbAJV0yWxPL895mx1hTAszL
 KfmmaJnb/MzqYUPob6g==
X-Proofpoint-GUID: Pmzzgsiqq8fEBIUN91fSkVZmVPtfM6qr
X-Proofpoint-ORIG-GUID: Pmzzgsiqq8fEBIUN91fSkVZmVPtfM6qr
X-Authority-Analysis: v=2.4 cv=F8pat6hN c=1 sm=1 tr=0 ts=69ce0693 cx=c_pps
 a=uRVskSteZEZgYXEASZgzIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8
 a=sPfiGFTyrB_pe8csv6oA:9 a=CjuIK1q_8ugA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020051
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:03:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3602

Hi Joe & Yi

Requesting to review the patch.

Thanks
Abhi

-----Original Message-----
From: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>=20
Sent: Wednesday, April 1, 2026 12:16 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: backport fix from upstream (PR#10=
96)

Backport upstream SELinux refpolicy change from:

   https://github.com/SELinuxProject/refpolicy/pull/1096/changes/2aad2d57fa=
7e6873d3e59e6bc2848623713e46f0

This change is required to keep meta-selinux in sync with upstream refpolic=
y and to fix issues observed when building or running SELinux-enabled image=
s.

No functional changes beyond the upstream fix.

Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |   1 +
 ...l_read_transparent_hugepage_sysfs-in.patch | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0079-kernel-add-ke=
rnel_read_transparent_hugepage_sysfs-in.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes=
-security/refpolicy/refpolicy-targeted_git.bb
index de81d46..9d23e84 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
=20
 SRC_URI +=3D " \
         file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.p=
atch \
+	=09
+file://0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch=20
+\
         "
diff --git a/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_re=
ad_transparent_hugepage_sysfs-in.patch b/recipes-security/refpolicy/refpoli=
cy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
new file mode 100644
index 0000000..463fc17
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_t
+++ ransparent_hugepage_sysfs-in.patch
@@ -0,0 +1,103 @@
+From fbf9e9a5c3086b53f46f9f07378af5466d7a6ee9 Mon Sep 17 00:00:00 2001
+From: Abhilasha Manna <amanna@qti.qualcomm.com>
+Date: Wed, 25 Mar 2026 14:49:46 +0530
+Subject: [PATCH] kernel: add kernel_read_transparent_hugepage_sysfs=20
+interface
+
+Add a new interface kernel_read_transparent_hugepage_sysfs() to allow=20
+specific domains to read sysfs files under the transparent hugepage=20
+path (/sys/kernel/mm/transparent_hugepage).
+
+Introduce sysfs_transparent_hugepage_t as a dedicated type for the=20
+transparent hugepage sysfs path, replacing the use of the generic=20
+sysfs_t.
+
+Upstream-Status: Inappropriate [meta-qcom specific]
+
+Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
+---
+ policy/modules/kernel/domain.te |  3 +++ =20
+policy/modules/kernel/kernel.if | 37 +++++++++++++++++++++++++++++++++ =20
+policy/modules/kernel/kernel.te |  8 +++++++
+ 3 files changed, 48 insertions(+)
+
+diff --git a/policy/modules/kernel/domain.te=20
+b/policy/modules/kernel/domain.te index 0f38015b6..7c7fe8f32 100644
+--- a/policy/modules/kernel/domain.te
++++ b/policy/modules/kernel/domain.te
+@@ -120,6 +120,9 @@ allow domain self:lockdown { confidentiality=20
+integrity };  # glibc get_nprocs requires read access to=20
+/sys/devices/system/cpu/online
+ dev_read_cpu_online(domain)
+=20
++# read and search access to sys/kernel/mm/transparent_hugepage
++kernel_read_transparent_hugepage_sysfs(domain)
++
+ # Use trusted objects in /dev
+ dev_rw_null(domain)
+ dev_rw_zero(domain)
+diff --git a/policy/modules/kernel/kernel.if=20
+b/policy/modules/kernel/kernel.if index 01a06eb37..84d76dc3a 100644
+--- a/policy/modules/kernel/kernel.if
++++ b/policy/modules/kernel/kernel.if
+@@ -4108,3 +4108,40 @@=20
+interface(`kernel_ib_manage_subnet_unlabeled_endports',`
+=20
+ 	allow $1 unlabeled_t:infiniband_endport manage_subnet;
+ ')
++
++########################################
++## <summary>
++##      Search the transparent hugepage sysfs directory.
++## </summary>
++## <param name=3D"domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++#
++interface(`kernel_search_transparent_hugepage_sysfs',`
++        gen_require(`
++                type sysfs_transparent_hugepage_t;
++        ')
++
++        allow $1 sysfs_transparent_hugepage_t:dir search;
++')
++
++########################################
++## <summary>
++##      Read transparent hugepage sysfs files.
++## </summary>
++## <param name=3D"domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++#
++interface(`kernel_read_transparent_hugepage_sysfs',`
++        gen_require(`
++                type sysfs_transparent_hugepage_t;
++        ')
++
++        allow $1 sysfs_transparent_hugepage_t:file read_file_perms;
++        kernel_search_transparent_hugepage_sysfs($1)
++')
+diff --git a/policy/modules/kernel/kernel.te=20
+b/policy/modules/kernel/kernel.te index 26578a26d..57aa13fb0 100644
+--- a/policy/modules/kernel/kernel.te
++++ b/policy/modules/kernel/kernel.te
+@@ -69,6 +69,14 @@ type kvmfs_t;
+ fs_type(kvmfs_t)
+ genfscon kvmfs / gen_context(system_u:object_r:kvmfs_t,s0)
+=20
++#
++#transparent_hugepage
++#
++
++type sysfs_transparent_hugepage_t;
++files_type(sysfs_transparent_hugepage_t)
++genfscon sysfs /kernel/mm/transparent_hugepage=20
++gen_context(system_u:object_r:sysfs_transparent_hugepage_t,s0)
++
+ #
+ # Procfs types
+ #
+--
+2.43.0
+
--
2.43.0


