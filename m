Return-Path: <fangwu@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910BC53200
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 06:14:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5388.1785305682652675933
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 23:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=GUPUwEep;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: fangwu@qti.qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4cJZ41153569;
	Wed, 29 Jul 2026 06:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I63IfoTw9iYFak0f/MeYOm
	iwC4ZsZ0VxCX7sZY80qpw=; b=GUPUwEepHI2CPmoEBuuQGpwogL1phpSnd91+aT
	yWDB+cR2NeRXyEJMuKNKmd+I6cjEVcoaVhHFCAl5sGmbJPTyjukaE0dv32pMxgYV
	9+qwOE/0lmyXy6CffYlkuXPCjwW05Ewwhmw+Z6TYCRa+1EepitX8aduzV+cboxYV
	smricbf25fKDqQ5uo9dnLb8hQoi0JbNeq08BCcGzCjG/nLnfGP4D8x9Cxn246WkZ
	lfBNBXC2JnCZdylOPbWa1FU5uGhMhlJd2ho8v4toZIBLZ5GXdKqfh6fXhvOg7AoJ
	2CCd/y0hUjNDH4EaVAp4lg03EoM1eHWsydeW4Ddyuxqh5SoA==
Received: from bl0pr07cu001.outbound.protection.outlook.com (mail-bl0pr07cu00100.outbound.protection.outlook.com [40.93.4.0])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq108te75-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 06:14:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcyPYvatrhcdtbX3oH4fIK2b/mVkCrmv5o9UMXgfYkdAhzrwrzlStIK89LOUgUNOmEQbb8Y/e9cuOHlR9yFZGpp0fn5aKWsFrrn2wyw4QWLUj+mV6PdF9jqaREn5kYeKtPSeqrd/DRXCBaRzaZIaaolIZye5Mn1+NgBCI6OdJs2Qx/AkHpjXE6Iyco9sALx+j5TVssWK9Ynk5eRMXWTBqqA7AG7ZskrkSP5HyD2yAaOmljWB4tOY05TBphhZVKghm2I0sER76i2/vM8JDbiiuf/H6lrtLL5ga47B1PSt3vW0QtyMWoyT4f7aUMklkEn7r5+zicoMRPjh36BafGPjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I63IfoTw9iYFak0f/MeYOmiwC4ZsZ0VxCX7sZY80qpw=;
 b=SP/8M6iCuKn/Q4GqwSsLZpmoYqxd2reHF1Flt1GmWzXMvrt06QRkWi0GSn58UwQkWUUoBPgifjEYIswXSRp8IKK87RsQJRfL6Opt6FStifqJXDNWzeqJQgniRGS1U1MsrWSzCjo7dUbP1IL/RN1nfXeYqdI145RezPFIlD5vRI3gTAlWAwmh9wpYzrNcjqmgHBVviN28C4iLbVrTsq7qbroXYUdFWL/6IJpIkx/CbWgAXIqwoqjMRzY8+rYR3OYYIaB+KCuLdNseRhjLemCfDtFYRUWLpOnHzC5n0Ixr2ShetEu+dMOJksAgS8kGbLm35O8W4N+vQtKKneb44TROig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 (2603:10b6:510:3a5::22) by SN7PR02MB9332.namprd02.prod.outlook.com
 (2603:10b6:806:34a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:14:37 +0000
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4]) by PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:14:37 +0000
From: Fang Wu <fangwu@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Topic: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Index: Ad0fH8c4xm6AF+UMTV6idpEC7MTsWQ==
Date: Wed, 29 Jul 2026 06:14:37 +0000
Message-ID: 
 <PH8PR02MB11449169EF0D123545D058321FECA2@PH8PR02MB11449.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR02MB11449:EE_|SN7PR02MB9332:EE_
x-ms-office365-filtering-correlation-id: 5836580f-cadb-406f-a95e-08deed38ab04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|56012099006|10067099003|3023799007|18002099003;
x-microsoft-antispam-message-info: 
 YwLwaLkr7a+LLuPTny84NmUcTTdQl9mfHihFs2JixVLhcqzqlhmBUHwBRwacQBZP8+GPjPZplGvpyCVk/TEU04JCJHHrggrA0TAariYTReZGlGJgw6JMukn1a0PPI1NsjzuNQvj8fB4q55P0u2FOOW1fueN9uRdBeJ3r7v11PoffgBWoR9FRdjEKLtcfC+UqOlQ25o7ihZcOuK5MZBdqnyGX01Doi6djaJkoCFg7K1SDvT9qhZERXCoTnqGje319e+8pAD3aOWJ4Io3numNbsYL7B9NWnQiEhoG7dZsU3fom6tyYeQ+nEIA3E+Ldh3bpWOQRyr1gn6A6dZmvTsi2O8ZQtdD7dO+f7aJeKlVLDs0UNRPmUYQM65rcBlxOrKPaHV/aUFwwF9MrWz7c/ZMQ3kCKg3OjPq98IUT4jHaSnWPSwZFy+ewBomshT+m5CA6KYyA0ZIizyYenq3Q+Ih+5Y0p/Rj76Yy7sIkJ6PaWq65ZqBAk3DMJx95da4FooqEZ6wA2MaTmB6t4DdAyST3N42onjO6reJj7ZKWd/gJp8/VWSqIEF4kzGM1W4WYJPzF3Bovu7d/3XDbXYH64z1AG8bB5SFwS28ZMTBWA7mtnwMA10WV7Dzaw13Qmz/M56tKmtWosWnB2QiApRvcJA725Wjgijzub7mmucMHiv3ncpUVhLmyNT9nrPGgGxZIaGEXrmaZR2NtMcqlWrIosdkxODow0gPxAusZnSTzHfvUa71/U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR02MB11449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?YuWhAmv+OBA7X9TmG3sOrZmSKttI7aNDgJh5zDoQF9zom6s7MVxgep/r/H?=
 =?iso-8859-1?Q?l6ZkbnV9KkaOVKAIM7fmGlO9JaW20r373Gzn7unSrK5Bg30xzQPxt3XiH0?=
 =?iso-8859-1?Q?lxotQjbvmNnNpb9VTKYWI8kct2Ir+rBCR4BEnaoFtIzVGqjuerQuIXm/KI?=
 =?iso-8859-1?Q?NVs8jRkPjjGXvx1o8fDhI3lDju+W1Wo6pR/gdXpIIH7HjJo+mnvwQTvV9b?=
 =?iso-8859-1?Q?aGjdOpDWI4K1rMS+pwDHB0GEPwUmQEJPu5rBmDO6BiR5CTrHvOv/iP0WSF?=
 =?iso-8859-1?Q?K0FoiT2KZLHNiN/AKshjhpoRsQD6gmcN8psOzcyO98E53jrCYeJyEdk9Ig?=
 =?iso-8859-1?Q?tA9NbSjyxZIEzlhXg9+stnHk1rIJmr4beWOWbERCRX4DFTbDYwVRfyLQm8?=
 =?iso-8859-1?Q?/UCUbFRJCf0xFKAs7DsUB1eeggdUsPAxd6pnfm7WX7ZufI5xlMbPPVsB4W?=
 =?iso-8859-1?Q?GsABuyZxVnzKaUmLbFM6p8L0tBAMbnPx77AtqvAt8Ly1+r7hwPE2fOhZxp?=
 =?iso-8859-1?Q?QaZbLkY6QzXpRJziqQInbCenEefVdDl5vcCo1VtJZmSG6anTaJe+xmEqNs?=
 =?iso-8859-1?Q?Oaqz+6z56R95KHWl7xMoz2evURYxbuzGZHdcbM/0wyzotB1tPtVi9PeSl8?=
 =?iso-8859-1?Q?A+WWzajbsiAkx1YkG+x2UXBxaCebhGas4jz0slm5KneDIpze3GoGdOhQ9s?=
 =?iso-8859-1?Q?xuAgiwRTZZv2Y8KTdmhbdWzAhmsVF+cpS+zG7tnuK4eJWIGoStgXyVqJxd?=
 =?iso-8859-1?Q?4uNSdcxq/OUrwbbhRCYdyg91mr3dvlEgcxi1aHeaev6dCvrlF72BjBXCSj?=
 =?iso-8859-1?Q?+P5bCXirnnsHSY5niNmBUdVVuTci/vFiKKi7uqr9RXKj34rAjAL37lpCaD?=
 =?iso-8859-1?Q?H6TY1gFI72gaICiLp/DaDdomsE2DNPbj8b0t6oKb2/Hd47JwCWHR0OPcox?=
 =?iso-8859-1?Q?us2zagh7/S9qRsEQh10dBTi3BUwe4JUnHo5k7vPDVM4lJ34Y+waMiev+9W?=
 =?iso-8859-1?Q?hiZMcqZvQoIn7MaSDupsmSHNS8bOEHuMNimUS6vFTGMzg6gdejcXBaKcTp?=
 =?iso-8859-1?Q?84HmxKtoymgfxtwG7NRKWNcDco0e+nlQYGloO0z9WO4dY0RBJoYWUWGkg7?=
 =?iso-8859-1?Q?xOkRLBpN7mtojkQkj37/GXjxmoHxO3tVjmAUNRiOkuwNhXy+LdDRIIqeOj?=
 =?iso-8859-1?Q?00+pNjvfi8zGt8b1Eao22GJ6EovXyLgTBVjkMUDv7gmKY8Xdf7YymUDA95?=
 =?iso-8859-1?Q?DqVGNICZ3SvotBaRNYuZFBhLSBbegFIqaEfddmuHl9Tt/i2risQh0FZqpT?=
 =?iso-8859-1?Q?0nOAvgapmkDimuOUxqUPKKcynLQF9vNtkQjSyaV3uYjOvUVidhyMmuNWOH?=
 =?iso-8859-1?Q?4JcJ0bOihYbkq3+c16LdoiwnAlMXwzxz1ErtJaEuYO9t7PaW+JrR7YIJwN?=
 =?iso-8859-1?Q?jkmU2T/nHCEgdkSVbAp24M21gXwjXBhfizzzmSj1ky/rhm82MK+sgITuH8?=
 =?iso-8859-1?Q?rH+B1IXT2VvZh39FT3iCZ2Y7zVve9G60dqFqkZoWCdJZHbvTsreIcXrBC7?=
 =?iso-8859-1?Q?798Xg1VKeJ2ur6YdZ7Al9IGV43X8J55GN9ksXKoDksrncQD1i3iGXwUEao?=
 =?iso-8859-1?Q?0MKLxiyWAc0lZcJZ9Lu9YE/84xQv11/yKPT1WvqQjSdwEwgnipbygyIgaj?=
 =?iso-8859-1?Q?F13MuX9gJ48fdYPDRA3z3tfN45cfYqg3A8HVJNfQeaSUTgHswNuXGYdKfA?=
 =?iso-8859-1?Q?DZgK0l0s7JRdKSE9wI8YkZihp9drs3pFaAis/8kmnd6QHOEc3N2d4UhiyX?=
 =?iso-8859-1?Q?U4nG74uwOQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	VpU86sopfO/rNYNh+OumCmWeTXLd4zm3AX/J4HaBXzvvR3xHeM2J99VT+k7yGqkyCtNAvvEsqHG6ZWuIYJIsLmj9EUtIQg802xP+4DcYBINSgAPFtT/CkczpODs8HHRErRs6ouyZeHjK3aYkV4uJizrbZpxGKpgfMOc4txgRIUpdJhiPDxOV4fstrtcNwS1Xcor6HLvisqYrsR2TvifOszNXgOgvVzVeluRrlBGamFBnz+lj9c9mpSffiYfmQ5J2Q6vB8SE5ccNepcbGKZfmz60YrwCG/VToCOFSCpcV/lxpy1EB6Gu2MH/ajJ5w8eQjm8BIzhTGgONAZYEXHMAE0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TjCnY80J7x0KKeyY9+lveC5MMYxxSN7mnKhKO0GwT2Lf0MF1WAaKSFCSotF96kVksAcGKQq/gJYiEBLtYBnH2eRh7js7eyCcyMZMMCWBIEfnuAwiVJHfIzOA+i64litn/wfn1/Zv0lLrO1LNoVDYW4wf5GVJbIlS5zzOKV9fvbpO5tvXoa6WyUlH0LFa88OtVmwoIaq+Byyap41lJYzQ5dYRba0QHAo2hy8kSIZLq0/4Aeu3ofEOEKyI5FeuOUqXDr42/+WINUxDTyMmgTyEkU+J7+2VV87AxqYn7P1HyLj6LV5OR+dLZoiarwdKFhA9+VZnc4ryEc9YDvFfK7PJ1OuaxDOM9aiucY0PNygGbDZLP8OvlNqaeWDpEAzQYJw28wHqsAXC/oWNxuPYwaBVNnYbFhLhQ6TPJtiK/B1kKCmLJkMEtmn1xhouMnTAqfKkGf/7dj4vOwoTrZARFNTHK6dP4JxOFwgWEaukVe31jt6ChV1xa4YgUtusDHZr9bVAFFfHgrTWsWY/nbi3xdrQSv4tkVlurSFnzplLYlEYoxC9rCFqIXdIx738tv4ae+h/9ZDRISLoyty4yQ6+5S6WmtQdoyIlGx/G9kDEE9UNtvpHCigF4AedjMqjBjrETm1Q
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR02MB11449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5836580f-cadb-406f-a95e-08deed38ab04
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 06:14:37.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HYqXISzX2Drsg2PT9QG5U4N/rV5i2DjWUWLFJ8rxaGm2xxNKK9kVc9eSpRwDtExZPY57cjva+68KWVlM/hS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9332
X-Proofpoint-ORIG-GUID: rZqjWIPi8uZSS_CkYN2AT-rjgsKrJbZY
X-Authority-Analysis: v=2.4 cv=fufsol4f c=1 sm=1 tr=0 ts=6a699a51 cx=c_pps
 a=R7I9PRAlQjBSNlIBhwzs+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=PuXHDeuyIxIEfjUnmKIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: rZqjWIPi8uZSS_CkYN2AT-rjgsKrJbZY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0OCBTYWx0ZWRfX2QJTDTzURHH0
 DH7kJ8ua/vrb8Mt0Pwr8h+00hFm5VCZ9kb0bY41PcL8K0EYoBjatYV/aGbwMv1ZooSi0Yc17eWT
 oW+ZulCdrR0OJrZFu7wb7fLFU4WRCvg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0OCBTYWx0ZWRfX1S2x30lOY4i+
 7kSmIhcHZuPADTQd941vO28pjzBCExPsl0Iu8+Wm7adbXK6xmF82vA7jLD6GBlHomUfg38Urq4P
 okQd/Rc6kupALGMlXHGftlXkJWnW95uATDDhM6XW12wzsPfcH4ETwID37UEAwFYdLXCTREDdJII
 wmcueSe+48KjlhTimETXQDebDjme2qZ4FU+rggJ/nkAAPSsQL3KIQuF8LaowASCK9p+rS03LU/7
 ty2QR3jf6fv7m7LIUqBu9wrPl1EcBbKHkmioJSVcT/BKjoBB9weyiYAJm6xQpvCzdFBVcWWalPp
 esV6Fk8hEnmKk4aaKgh6peVBbjyP8ZKNxIbn+Qw6JW25WgWXses/0dA0Ml/xrzVcSIyrIs4LE8q
 Ct2GWXEVUtAHnTzZIxHmBaHtKSs8Mh2bJTgBjimaS4qEIXFb0ei99dl9pxZBt/Gi7kOe/rNGKmH
 PJpkKepd+8C61t9xzDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290048
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 06:14:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4562

Update SRCREV to pick up the latest commits from the SELinuxProject=0A=
refpolicy upstream, including:=0A=
=0A=
* a7e7df1b seatd: allow self fifo_file read/write for signal handling=0A=
* a1a878c2 adb: add SELinux policy for adbd and adb shell support=0A=
* fdea2b8d wireplumber: add SELinux policy module=0A=
* 0e8bfe52 tpm2: fix tpm2-abrmd D-Bus communication under enforcing mode=0A=
* d3e82b72 lvm: label dmeventd on all distros, not only gentoo=0A=
* 74cdfe59 pipewire: add policy for PipeWire multimedia daemon=0A=
* d4a85ae3 wayland: Label sockets under /run with wayland_runtime_t=0A=
* 5352d9c1 Fix file_contexts for systemd runtime generator output directori=
es=0A=
* 9417c19a rauc: new module for the RAUC embedded update framework=0A=
* f9578765 Allow net_admin to the nfsd_t domain=0A=
* 66a1682f rasdaemon: optionally permit access to ipmitool=0A=
* cc59e75f Remove mptctl_device_t type, alias to fixed_disk_device_t=0A=
* 1b0bf2acbd Merge pull request #1138 from tkanfade/wireplumber_module (and=
 more)=0A=
=0A=
Full list at:=0A=
https://github.com/SELinuxProject/refpolicy/compare/30d3cf5abd18...a7e7df1b=
5bb6=0A=
=0A=
Signed-off-by: fangwu <fangwu@qti.qualcomm.com>=0A=
---=0A=
 recipes-security/refpolicy/refpolicy_git.inc | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-securit=
y/refpolicy/refpolicy_git.inc=0A=
index 4d207a2..a3742e4 100644=0A=
--- a/recipes-security/refpolicy/refpolicy_git.inc=0A=
+++ b/recipes-security/refpolicy/refpolicy_git.inc=0A=
@@ -1,8 +1,8 @@=0A=
-PV =3D "2.20260616+git"=0A=
+PV =3D "2.20260729+git"=0A=
 =0A=
 SRC_URI =3D "git://github.com/SELinuxProject/refpolicy.git;protocol=3Dhttp=
s;branch=3Dmain;name=3Drefpolicy;destsuffix=3Drefpolicy"=0A=
 =0A=
-SRCREV_refpolicy =3D "30d3cf5abd1872d3da5dd44de37de4251674f736"=0A=
+SRCREV_refpolicy =3D "a7e7df1b5bb6b98297c3306bc5b1832a5d86a47a"=0A=
 =0A=
 UPSTREAM_CHECK_GITTAGREGEX =3D "RELEASE_(?P<pver>\d+_\d+)"=0A=
 =0A=
-- =0A=
2.43.0=0A=

