Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6941ECC6B03
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 06:59:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10185.1775113148279763570
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 23:59:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=emSE1enn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qti.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M478U4009488
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 06:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=qDeLywv7WnaU3iS9rahcSwJDIO3CerREiMQOyBFjj5A=; b=em
	SE1ennvD3L7VtwESUJM2/HyI5lp/kocdTHzoC8QbY3S5bCoK0g/ddzeZ8eoz31qu
	qayNywP834bRYnLW8zaj9RqbPVRyJkiiR6XT6MFHHHodJeA1IPy/YpYzlgScZ8gy
	SsCx4GtHzK4Z4XioKvwOJGpR8RR2jC98b5KVT9BE0h7A5x1IF3m/66AgMhHANo9a
	uz3cT936cN6BuGod+WNwTaI3qSpIlUCc4NcrEX7jeK17BCATyZDbF9ah+QeECse2
	Rpmf4072aBzkRg0uLpmVyYNE6QWFSGe+0dzRmTjLnSuGe/npUpt7ynYT56U0T7OA
	xRmJNDEOjIGO605LiFSw==
Received: from bn1pr07cu003.outbound.protection.outlook.com (mail-bn1pr07cu00305.outbound.protection.outlook.com [40.93.12.5])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e02k9m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:59:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6mnOJDrsqeTmyLFJMCzubWMyIi1yCkBNRfiFsKGjxjUxoFhMqsgSjjM3vEUK4Tnvz06pfde9/+x3PiNAXihP8Vnl42S1Yv6sFSnTcY32rQRDMhbJDyPSxhlq109tjoyjPbEgpAh3Q4Ydm+Y9Ig3PNpuZ5G4/Zo+NuauEYiSZCxQ+DPRVW/biGhAH26iNBP3yTC05+N/vyRAD5wEMs9O6B1ks7TGtKrHs0zSo1NnrDRHXODP8XEhSqF/oRTdWZY5zE2L2m4GorvDk1tEuE4vtUiJ8+jyF6OOj189cpKalIDS1+Hzfm7ju1HZXrDQayyeCqhUbpPneG0TpxUkRns7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDeLywv7WnaU3iS9rahcSwJDIO3CerREiMQOyBFjj5A=;
 b=YxrQx3SstLsKvh4wZWCzkalbjE/NDYvYg4Ivc+RmeXW//yulaWGsPZ2s4Pq1R+TyfUK3zuSTtMVjuIYnQogyKtbEtQuws8xyNqeTilSKBqdpHQVHrWkhtVsEk8Am1WxnTaCM5PBFTL+GWC3I4KueUcBnoF/Hk6tTkIQ0YghS4qXGpcwB0K2uw5lN0I1tF8DoikLRKzDLChSVUDSH3CvCtsCteYB+xd2+eR3TMuAAnJXAyFSYt0q0x32tgk+de09rnFpmiIzFy6mu90atkz54CbcNDSER33a+8C4ShMyddSM7hNDyDa3sDF2BIoh37O/eMVnYspHMkxr/Se4Agt6wrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 (2603:10b6:208:542::12) by MW6PR02MB9878.namprd02.prod.outlook.com
 (2603:10b6:303:239::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 2 Apr
 2026 06:59:03 +0000
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d]) by IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 06:59:03 +0000
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux] [PATCH 2/5] refpolicy: Added policy for rpcbind
Thread-Topic: [meta-selinux] [PATCH 2/5] refpolicy: Added policy for rpcbind
Thread-Index: AdzCbhB+2f3ZqLNKQS2/Vg9i2WJXfg==
Date: Thu, 2 Apr 2026 06:59:03 +0000
Message-ID: 
 <IA3PR02MB111991B1CF7F6B24E7BA89146F151A@IA3PR02MB11199.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB11199:EE_|MW6PR02MB9878:EE_
x-ms-office365-filtering-correlation-id: 647aeaa9-94ea-433c-3937-08de90855371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 vMFUBZV+Rqx2bVSVly5rE0GCdS6VlZTlFSlns47pVzjChCHbG7aIJUXkTTMTVWMyB4XrhDjHcvb455A4HyMWKaQZKs4kYgU6dmNiBikWkbaYVA2BlNdx+nzTEXDFjonnNm078SneJnqVSNG08PJnXq4IiZ/yTUrp2BlzCmboXiamkPiX+/2VYzmNw2bcgmDF5QObLZs1y2rcLkMA/uOKnptaJHh4er/eu67HlfqObxQBEJQZInV6o9j2MyTAUhrhE1EQnkRB6NsiF1cr+Y756bMXkUbAt3zoL9Yt1LWZIezPJvLxldoB+IpjLPSOe8Ak4wMb+ZrB63hS2DWTvodXmykWd+Obf/5lcravTHpNsQ7fZ0C8E9ZMp3W+8Hz7sU7NZRiePK73nQDdscWfAK+nBZq4OrD+YVbG3wMHCnO3tE0x/0cIgGUGs+IwCRw9buXImiV65ldRhj36ifGdCh+6u1s7OXcAXg3/6j/1x8mJGENhiCIFwZlxgH10OthNTv3UK5s7IdHI0fKmig0urKEFfd1cgSjdZMX1gpJEpO6kydIS3+f8HaoSepZC1Rsl0A6tHXXMyYuvbYZg8C/pxtNcO/oAGQQIRhJnw4rIEEIYzD9Bx5L0n4y52tToJQG5euJlLLeHvRw5BBRC+ch/XDr0FAgkXrmTodaIdJyJkc1NkLo+LG7D+nQrBD9QGWfgNSM+b3mAPk7tYnGHcjfkEWluKnbEBsM3QzMZ+mgWvIDpZLWHxga2EUvtueF4WFt7fZ8f
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR02MB11199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sD/bwzN/D7TEKebWEexwknxondyZxSFkiN8rLE9XIoyJ1WZyxxZylBq7e2Hv?=
 =?us-ascii?Q?nHVxuk/Rl1eeuEcByf7Pw0fdRl5hXcgp6cwN+Qyz+xllmqRtUpIH3eNV72Cb?=
 =?us-ascii?Q?HPmdY64iblPGWoaWLvfate/Y/Rkfr+m0b07XLIXRlbmPWF8tQ03U6CLHwyp4?=
 =?us-ascii?Q?dnAtikcQ41ylnp8nIYn9iEv8UptUdWXMVNyONB5A2vBME17DOFgCgU129JmB?=
 =?us-ascii?Q?clav9Davx2CtTd0cN7WfXTpRzQN6PjQy1ozixhUrxMMxyPgS+u4bUe/D484e?=
 =?us-ascii?Q?ZywPisoAWDdtcELLqKQoUHYkJZIGJs6MLI33w7MOGfU+ghPVqHNr9dR+PqNT?=
 =?us-ascii?Q?E7DmrU+TwHQAvDb4Ys8KXlb2A08U7HQ6P6Ol6sqnia4S+6lHjf6PhSrEgTfg?=
 =?us-ascii?Q?Ql7/tFSMdfNQ/SEVUErMi/pmhRi3eggBcZ44nLY/e9kSP2N77cLFCKAr3smV?=
 =?us-ascii?Q?nWmX0qvv+fHj+0NiCTTzkxI1+0kB3W6w2sHp0lE+fa30v79GWQ5fVPjNMqwn?=
 =?us-ascii?Q?PV2aryag8ohP8mfjL8KzRswnxO/Nxw4a4+uwwkRKEb2lAS0uteA3gPWmKXxn?=
 =?us-ascii?Q?QQuka+hlmcWty1aP9Yf1+Ako488T/tVdFKswf2fQpJVXXkzYvQ03xWLknGzt?=
 =?us-ascii?Q?JRtysKw9bWEfDXZ8uVfsN7zS4R4dlTKp4TgGWCoQs2soZb9Dylj7r0QGANOQ?=
 =?us-ascii?Q?KJ6hIMz42ga/9EGa+zhHaNA2w8kGZyxKpRPrfM8PY43OdyoUkl4Wtf4shQdi?=
 =?us-ascii?Q?doSmwtxvDtne7imUqBdSd6YX0+0/MN7uvURYfa2NCAZsa+LlK9eunTD7oi3k?=
 =?us-ascii?Q?I7YbObuXyzwOdGcuMXh5VsgrGRUGZwU79ei4UJsP68B7IcYUpRPFoyYEDBpB?=
 =?us-ascii?Q?CuDgS0LknSztBbHZrgCkWjfZ3nIJQr5T6PMIzDSHQCuIKFZxnzGQRkLIAKNH?=
 =?us-ascii?Q?P3i+3C6yls2BF64g9pIMfvzan4MOdx+8CAPmlUwAmACfaWyG10pF3ADL1Bha?=
 =?us-ascii?Q?WQX75cZjTrP3JWFZ/XFy9M5kHqPZpXMasOQvQmh2Cw7bSghTRI0qUndy3n1y?=
 =?us-ascii?Q?kvzIWa/bN88wb2wLuL2ZwLaG9vauTjnF9Im3LYxQxUFY+qLh+lxDvTtgqN+R?=
 =?us-ascii?Q?I3HrrSCKpr4cqbBeyjkdb95i/uem0ouoMe30gnSEwK212kW7HFje/BUy0TFE?=
 =?us-ascii?Q?LWUoC4DJdlt2liScBOgIkD56drN1Bgc4nHOIN6bniJJ7phQ2OhDgz8McC51r?=
 =?us-ascii?Q?CqgSuY7KmUhMdA3ZLMrsgdY2L9PN3Ht3ZNVxiJt41pcFedsNxkSKOKkiY3I2?=
 =?us-ascii?Q?I2OA6bDvkO/+TZDSXXkHdZmZ1tvq0gn9pkHBsV8/le+hrfbObyX0FfmhRYHG?=
 =?us-ascii?Q?BhN+UrDflVSxK0hLBpoV43rf1EtWIOY852JGCHHkmuSVBIr3Fx6sxE/0iBCA?=
 =?us-ascii?Q?ItsX/Q3eXeo84pmSti+7jU47m3sLcoZhaVlFNgp+zphb3NQAOhnqRIZr6uh7?=
 =?us-ascii?Q?PnMwiY7vYaw1RElrqRXC+J7SOxS9k+drmYCk6a7KIhAA3Z+WdnLejt6sXVLl?=
 =?us-ascii?Q?aYMmNVpdGHuHC++mL5+4OXVQ8294jEBn8Dh9FUHzcRX2aip26h/TufLyGU+j?=
 =?us-ascii?Q?8GCAIfCKDKnUaikyZ+p9pTvZIKGeKERdJIf/UI0u5g7RIUqhLJ3oIqfJJQf9?=
 =?us-ascii?Q?P4YF0cB1Asy2NjLoK58nTRVqIzc6m4OZVIOT1x2SmaybhBLBOdqqCm5VCuPb?=
 =?us-ascii?Q?4fAj09AzDw=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA3PR02MB111991B1CF7F6B24E7BA89146F151AIA3PR02MB11199na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QU1/OPuKpf0XW1adBKzMdHGrtXhBAvQsYYBwb1LJRG+6QHM/12NBxPrae0Zr7TkKQfMm2YTqMpWHpHCqEymvCGFnvSpHEdtzYBCC/0lTNf6k7ms8q5olIgcZXHSuySAJTRFu+/vGnoV2j12A4hEmvRAH1jiIuupFHW9sxuq5d900NoRpcOkqXU++qcIuFHjv/eWN1I93vhJrOjHOaNHqTbrI6A2x/eCJEIjeHyQLcllasXhkVEB5QwXbXMQe2A86qGx+HHNfxWecAWUNhwf882XTfTSrT1Qgbsr1WmoP6O640lP5/grhSgX98LuYPxuPNvblUTVOMKKY3tf2P4mFgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Way5Xxbobl5Pj5AFcKP6cHBPqLnQYYWK1bxcl4ulMzHUGQbizBZ/8Xg9ukCa4XrM+Vfds+TXksjU8L2em4SMFnIGcMwPtmJpqP9rBPMr+IRUEvwNXoS4OmFwos97EI+bsv3iE2uTiaa/nJLYSC/6EAEk7w2+An1dtSp7Rx5Ec6O2Bsi9EeIwLAAn9yF69xmsy21qXP3vTQPxOIfF938eJpG6QLP7fAN0gMRLDczCTF/wi9X6WQhkXZ//htHlwv2EYXSnH8jxFj9YNXKPY8tRYZj0tDEdMN5jxWbXZWcBSyjdiEfkjRrYSNnO7WcKK3tKoA6sqCl5FaTvisoAq7nOkYaNePUNt0rsrQMelE9Vl04gWqFXY+Yw8pHM/qje35/oDgrdkmuqAZf3O4rubJ/nxIk6ij9lB5rDJ6BJOr7L+2NTNcw/U3z3h7SpKAm/LjzZBb0VI7+9VlMTpzlxBa3hp702xDe4KIXMKNymx58yWsxhM4sHApNO6k2OpdL2sFcL1HtMPcunB7ivzUdf22RrjZJtbrHw1dgj43hmk8lZsVPSGYxtGhWbFP7Qmzep78S5wAZhs6TJJUDKvHYyHSAhYsMEZyZOnzZmDXRhfW1btmkZQZpf8Tx6cFDhG2XHpjq+
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB11199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647aeaa9-94ea-433c-3937-08de90855371
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:59:03.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zB1WCmoGQhaCDwIO15zhY33+2c7vCQumRRuHsMnTh1r+u+OUB64sehwNoW70WJ8bo9UH8ry1j2w66w1PDJlngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9878
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce13bb cx=c_pps
 a=xHYxGUywFvkkdmbedG1HCQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=9sh29r-yUNc6sGW3eI4A:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=xOvUGthomhZvmT7E:21 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: GEy9G7VIwxdv5crPcOLAcuzEbWLj_UWh
X-Proofpoint-GUID: GEy9G7VIwxdv5crPcOLAcuzEbWLj_UWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MCBTYWx0ZWRfX4PAIX2oaVpKP
 2fyjHCtdFoj0vHT11zvUd0XjtWVHdHNfKdQTNf8HO5mHbcpXm6n3ylYZYXg2nwctQqmyIZq8uMB
 v2vcm46u8Ainht/BJABF3pf5AAl/jS5MOnCzrVWXjiapDQRHTzRcmHI8jFec2tiM9xZ1fHK1B3K
 7gIjuBuV2IVW23Eyg3yUJ0d4QEsMZvPw2CNd6uO1wgaKztl51fxnwtEouJlsPnDUhEtpAykjzxC
 05oJXAEwJXnPaHdlc4DVE+8NurAWXTJDajhnyisUZ6jTroS3WxaljmKJO94Fy2L202Ns78CUbNW
 9mLCs1yjDKC8mUyhU1s8bcr6vnttXl9l8FCGM7rT7qTi9uvfRRBaL7vsK108+BDtDve9p5+qI3H
 gVuObbomfuqUDArEAykx9Qd14GaxVNUJD45RGKUmOk2aYev3HlPZv8xuT2dqRtwM8aKpvD7Phqf
 1gpoDy7GknQb5TOT3Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020060
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:59:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3605

--_000_IA3PR02MB111991B1CF7F6B24E7BA89146F151AIA3PR02MB11199na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

refpolicy: Added policy for rpcbind

avc:  denied  { getattr } for  pid=3D768 comm=3D"rpcbind" name=3D"/" dev=3D=
"pidfs" ino=3D1 scontext=3Dsystem_u:system_r:rpcbind_t:s0 tcontext=3Dsystem=
_u:object_r:fs_t:s0 tclass=3Dfilesystem permissive=3D1

Upstream-Status: Backport [refpolicy: Added policy for rpcbind * SELinuxPro=
ject/refpolicy@2a85bb8<https://github.com/SELinuxProject/refpolicy/commit/2=
a85bb850c4b9ad843f10be7e01326f028599e4b>]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
policy/modules/services/rpcbind.te | 2 ++
1 file changed, 2 insertions(+)

diff --git a/policy/modules/services/rpcbind.te b/policy/modules/services/r=
pcbind.te
index 137c21ece6..a0bedbe69b 100644
--- a/policy/modules/services/rpcbind.te
+++ b/policy/modules/services/rpcbind.te
@@ -67,6 +67,8 @@ domain_use_interactive_fds(rpcbind_t)
 files_read_etc_runtime_files(rpcbind_t)
+fs_getattr_xattr_fs(rpcbind_t)
+
auth_use_nsswitch(rpcbind_t)
 logging_send_syslog_msg(rpcbind_t)


--_000_IA3PR02MB111991B1CF7F6B24E7BA89146F151AIA3PR02MB11199na_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">refpolicy: Added po=
licy for rpcbind<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { getattr } for&nbsp; pid=3D768 comm=3D&quot;rpcbind&quot; name=3D&quo=
t;/&quot; dev=3D&quot;pidfs&quot; ino=3D1 scontext=3Dsystem_u:system_r:rpcb=
ind_t:s0 tcontext=3Dsystem_u:object_r:fs_t:s0 tclass=3Dfilesystem permissiv=
e=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Upstream-Status: Ba=
ckport [<a href=3D"https://github.com/SELinuxProject/refpolicy/commit/2a85b=
b850c4b9ad843f10be7e01326f028599e4b">refpolicy: Added policy for rpcbind &m=
iddot; SELinuxProject/refpolicy@2a85bb8</a>]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Garg=
i Misra &lt;gmisra@qti.qualcomm.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/serv=
ices/rpcbind.te | 2 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1 file changed, 2 i=
nsertions(+)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/services/rpcbind.te b/policy/modules/services/rpcbind.te<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 137c21ece6..a=
0bedbe69b 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/services/rpcbind.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/services/rpcbind.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -67,6 +67,8 @@ d=
omain_use_interactive_fds(rpcbind_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;files_read_et=
c_runtime_files(rpcbind_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+fs_getattr_xattr_f=
s(rpcbind_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">auth_use_nsswitch(r=
pcbind_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;logging_send_=
syslog_msg(rpcbind_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_IA3PR02MB111991B1CF7F6B24E7BA89146F151AIA3PR02MB11199na_--

