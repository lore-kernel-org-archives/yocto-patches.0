Return-Path: <fangwu@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD404C5DF70
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 09:45:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5215.1787046300994050711
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Aug 2026 02:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Yego3t+1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: fangwu@qti.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BEnn747606;
	Tue, 18 Aug 2026 09:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+VaRA4LhX7uLPCf3KAeng5
	+fGQRAxWUgJzReYLdJXEk=; b=Yego3t+1FnxOcwj6JdwOoz2P/M8KT8DuuJUChN
	LRQvtb33hzMWwkxxKKEvro/FMe2fzaHNi/5LMo3zkAJLF0p85x3L/4zdsxNWScH1
	lq4tjiX/aiukt1CdUF/4cMkAIIZ1EDg7nFPalmlFGc6P5kGa7c+f7JN4LlA47Q4X
	Q0yEWQhKCQ3Wx67/Z/GL5p4tFfv0g0M4IHXqx6Kbtps+UeIfHhTmXF0RgYMpUjbC
	y0SASf9xQ0IKbGLGvWzh51DVvJp0C9o/W2OoJ7oTiaJcNcB9azlI7f010j35fqKC
	OysVZoGvmwwGzm3ro36jqzje7u6IoBrrIGzvwNnEs27v9rbw==
Received: from dm5pr08cu004.outbound.protection.outlook.com (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0u1tf-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:44:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbcM0wnZ4nx6s1uvh2R6l7LwQ2UQZtTuqEcgLWT78X7sy6blgVL+4eMyoRjmc3B9wOyGsemNWwNoWH1UWIYMsg4OVkyNOxi1vCAmCn+Zrqk9Kult8127bqFCdhV99YXfO2lUMLHp4S0Y5X/Rd3TNiNlyNjGdzj+va2JA00QnbRHPuGI7aW94aVZQRVphuGrP7aEToPWj+f9LxbcxysEYfbV5JqnVZ13tMMBST/0rheYnzIGwlJxFbU+ytgh33x/t7Pt6cU4Xw5k7hrEb/w96g9Y2RDSngozukjdTkHOsHSjj3A1dsH/Npc/fCL2uAHPdBUgMhyZHGg57SpA9fYgENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VaRA4LhX7uLPCf3KAeng5+fGQRAxWUgJzReYLdJXEk=;
 b=tNDoUdmGzkFbiGoqvJeYx/yWqXSmPMGs7uUSgE/rWY8osxM6STNXNI9OqbtcOMBTJZ0uf905BOKTBl3sf+vrAsh053iehQEpcEgoAGm9g5rHGcLRCrdIObSkc52Fx6b0gbWpp+q9/zTivMPs5uIwoTpkvMKrcwiqeXu40KDh3UaDIRO1qVWlp6N/5GzgMY81jGoLh44CBQQapl37DHE/nsvDd1wW0YAabcYc3onjukeR2lbAkf3yD6uTfqK+/mbolnlFT4uKtuuA7w+zGnb4v1cxy/mkHjJIIR5a8WbxP5tOS755eBCBmumwG1QpGd7gxpcGeN9rcasvnP+oxaojZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 (2603:10b6:510:3a5::22) by DSVPR02MB11916.namprd02.prod.outlook.com
 (2603:10b6:8:41e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:44:55 +0000
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4]) by PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:44:55 +0000
From: Fang Wu <fangwu@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Topic: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Index: Ad0fIFf1VQKcYdeHS0aoGwCTifwsmQ==
Date: Tue, 18 Aug 2026 09:44:52 +0000
Message-ID: 
 <PH8PR02MB11449601460C7A329056D577BFEA62@PH8PR02MB11449.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR02MB11449:EE_|DSVPR02MB11916:EE_
x-ms-office365-filtering-correlation-id: 33cbd11a-1743-46f2-ff78-08defd0d5be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|38070700021|3023799007|18002099003;
x-microsoft-antispam-message-info: 
 +TxeaujECNc03pRRGlokft7n5q/sUzwABWFz/yoJ2RJmxfoypu7/CRwYmyla9Lbblfxz4Sj9j05t+SZbVwbqMod4c6amDe9C1Ui3hJLhMhwwTRdUIbJ76YPkPjfZLKuLNs7nTj1mTYMY9rw/p1d24FHtMiC5nAqvHM3GUsAVuO0uVN9wYs1Ier5HY/tl5xnu53FmDHy34bJU7uiZBvtc740ulk4fNGIpgo6fAkLEgJTUa8D55aiBk0N1lEuMlr/CwGdE8PgyijPHYA1M2kF9P2az7CiVy2oNjCab8TbP0dPmzciAVJP5YlPACK3GfyeNfRO0E9+OvcrckNOx3syCxijZ0eqgl1d2PHpMESzO3BdIrv1sYeOoKxTND5Ytv2Mx6bPL74x01NMLeWCUnsegaNKoaGKOwHZsv42y5/Pz9G+pxC4JSQvWqlIHbbn9Kxrizca8SgLHYeMu/h9zou53LrSvtVVCQv/ngwarMTBY52s+jAL5b+B5rtT7NC8yfdZbUud+Gw2yGWibXn3uAFUPX6ji8IjZdpJSV3jmYaFpRdUe+fRgacpZcWKQ5mZM/0xfKp7/MNjK3qJXoFpzEZYILY8c8rnOkpgbWDy0YGTUxmhWVDDNXZ2hilT0j1wQOT1W70j2CAhyQPy6IIW2menR+wPHJRyy/qUjXmt2g/GSzCB5F3G5mdi4xt36zKzkV8SBghbEjiu/eKZugkDlqvggf9JUG8oaX9RcenuPlUF3Q9I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR02MB11449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(38070700021)(3023799007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?whlwx+3rfIJK1/bCRBBe8JgAVhPJOIpz11I9n6zWWTJgAg+iU6B8H5Sx+5KM?=
 =?us-ascii?Q?r4hjvGzBuL8ntQJl1Kb1Aa0PpgB0axuOLLeYuGlR0t7QSVtNWGicsWZVUEvO?=
 =?us-ascii?Q?5t45Rry6cRRZ6kV5lgGhuuDihhL8TSHxm+Kt3nqCZxC3v38Di+oPfq+j2abr?=
 =?us-ascii?Q?GMud5JRjNvniEptwXr8+MbnkNnQ/GFbgb5vZd1amJDHO8CgF5afJ4+8Mx9Dv?=
 =?us-ascii?Q?LPezWSbq+hQrCkCdDCl1TyF8YFYQcpfdHyG2GFTPJjoh1dAmTJ5RHWzaLfzZ?=
 =?us-ascii?Q?hNH2O4Tnq0UxG2iYIzPapcKEoLTL0vvbcG8VolgzamIQoElQ6MONiCq8IB/Z?=
 =?us-ascii?Q?FxBbdjwSf0YeWrZJXti2coW/dXtBugzVGebMe59BPYaxMOUDhNxDozBVuiN1?=
 =?us-ascii?Q?83sh7bP11LUqn4+zPHKNBPdsDagbNXoRup2Q5i6zhJSyA0mQRuIIo+sKCUz4?=
 =?us-ascii?Q?+NoMKGCmcZKo275veUp/WRZlaljR1q/CNzJib1B1cfOq08/udckIuoaIojg9?=
 =?us-ascii?Q?l+FCa66xRmXaOGyjJDzdlvO454PQdGyUORCTksn7qIE9Ame8UGbTnUKMejx+?=
 =?us-ascii?Q?XezhYQtue7DAgWhBdgV5GTdi/4YgGqp5AX8mmAUvBAg+lHLnMu6jBfTNiIcS?=
 =?us-ascii?Q?2nPnpYaFnkonAqW29p3zmFxNCusp81mIuH4DzyYzuXGFBAsjF5qWhH7uIX9x?=
 =?us-ascii?Q?McFpOXpVJVPdQO1OZE42BAf+N9jH8Q0NhfROSJYNz8Uz4GO2Ak4li5Gftxpa?=
 =?us-ascii?Q?jeZ9XKpx+yODkRvFLmRh7XJbtLn6+0xsmLLlT/Yku2YzDGK+Ixu9xFgA2Kos?=
 =?us-ascii?Q?Pukzf1gR8vMHi4WgylNf+JElc7Uxx9dbyH+RzW66XDdUEboxwJNOhjlU31BV?=
 =?us-ascii?Q?UlZKJ1e/Op5ixJE7JMEEJ8cLKbcjS8P37DvUYTOBC4W48OXPNzdTcddyy44c?=
 =?us-ascii?Q?v5+wmusPa2PVt6oZawCVdoP/uCPZYuOHmwmaxZwmmFrU11eH9pwBNSt1RF8b?=
 =?us-ascii?Q?FZXr4VxT99p5Bzxq5uP04LOooW69vdT0k1gFQaKMVMe5axSPINr+wEugHYTB?=
 =?us-ascii?Q?Zl6ftD1XA/gQ7RA4zjrz6mDFjtGNo0zebxHhD2qRGf+uWsehSuTO82SJluHo?=
 =?us-ascii?Q?JUSCIYwdOxA7NTyzOdvlLO6sxTbVKlayuYm+PFEF1pQ2w0YkpXavbMkUkSc6?=
 =?us-ascii?Q?YJPp+wUSJM3FS/oGyrSMmsBIpLvFjKPxJXqRS+LvrCjdx+AyqGYK+aDfp8rG?=
 =?us-ascii?Q?ouWyuXzbfH649zp2bA1f1YW1ojmsI/G956n26f8moLZ1ronDIaNangcPz1Yj?=
 =?us-ascii?Q?JUoytHzUaI8hCIvVH3dF7SJBenFX67hnhHxycpi6QDVR9cw9X4YhCHkGlXYb?=
 =?us-ascii?Q?oRMIKEA5HlC94i1akF8HgiWOUQAPtP3u0rBQUYkfP5z3iR5k+3GEAtTbbNDQ?=
 =?us-ascii?Q?fmmAFHCJ5ABvW7GQXzXalMAgDGpgpkFFSanLm8os0UuiKVVPI/jHblwPFEd6?=
 =?us-ascii?Q?MeaNJQz13p5C4liaZzqomTpADIpQ3GxR8GUVq3Lc5Y+4tjN8D0+ihPyYkgiw?=
 =?us-ascii?Q?3h0T1ACWJenmL51GhvJJ9pLEaI4+i+EHfAD9TbCWvBSMXd9hkxrWcVc1kSh4?=
 =?us-ascii?Q?OPqDHQSBEEbE66TboN0M0vBNde8z4kVeIIg43sB+BhWTzYpEC0487Z2wSHHA?=
 =?us-ascii?Q?X7agNoSQjMKwNz8M4DlrsmElKyuQsQYiEJx/9Jwudohle+ghHvmKs6gvIPvG?=
 =?us-ascii?Q?L/2oJs7N5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	p1dEQDAOnLjyA/CLkA10cIu2Oa2Yauq/eQSS02HWyEsHFDV7vwHw61ZewDbAdrnuAjtSIgqY7JdT8I4j8/vIB6L1QaPKrR4RSDdWSjuP2+lZt8oqWfhpBZj4fH1N9+pyp9BWQKmZ5CIL5jme7QeCf2Rm1+Os09wr5Wens8aowBm6P4HmsL/EQipA2B020T+x+7ZHD22g5ToXkha/v117OkBG9nbrF3sYEg/mb6fDdSN8O5AS/bj7omX89iNY6+PQX6fm9JCcCdYXe18hzPlsX9nZgajRqvW9FoINzpVmWyGB6HZFyqrQLXXQidpjgW4dbE/MUaq7TF0lQV3jx7sYiQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9QFSfuFWAmcFNSBVXythq17X1DmwjAEfKS6vwquJoeaHl4S3rITXsWydY2KdSNlo/GD0hrQ6PHCcdP1Y9qOLKUaTNQJKdGy6tjwuZHYEqlksWE+O6nyXsCSUPS+6Bpftw4PjgPTHE8PbYssvXhMQ4Qq0ds0+bGU/muRBbwrDwKlQMjnf9o5OTujriY/OL8G7J5aQ1SjkYbSMy4tUDgihEewXLWNYasB+qou0VzGMpxbs15IwhbA9MvRzv6c/EKkdpDgAoJvbhRG82sgOYsEjy1iuOjuyjc+x7xjtsouPCYT9Mf203n8mlB3blCPz28np4iCw5t5/1QLxQJVdROPX68LBjlChm323mattbm2sn0ay+YtN+QS0gq0Sq6aWOqexbfaKyvlGuXLT+h/TwE/QGR8aT5A+/AqVzKgZF+1V0YIu5zo9CTGYsuGH3XzFmLjE+7/oJR515MWxcgkM/pPlZRSojt/Gjhkb2iMCpkR9pr3rcL+UDDmcvJriyOHYuV4+g7/sbojJLxHAEw0xReYSI2NEhj3kzN5pupx2QigIlZ2A2aHvvW3ozem38BL+Bw0wpCrcliKF6xiaaV+WJAhf2w5tvOEVVjtgMEuZPRrZ+F2zso07sigP8OGcxqZvmsWp
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR02MB11449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cbd11a-1743-46f2-ff78-08defd0d5be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:44:52.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JP3/g8DJRXSNhF4Fm5ENYzTjinc/x69kkiF6fDljA098N/J6WbRSo+5IUvEcWaDH/za9QglpIagnKZo6AEA2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11916
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX48mikyxt0zVF
 2DojS3GAUHnOV6OhW05wrIPDLmrrNrkH2DmqQ6OK54GxfQuCRRSzUpC9kBxHU1/JRsK4uBOI5Wb
 kpqr11Tx56SiUPcaySq9HHJv5acxAsQ=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a84299b cx=c_pps
 a=lnBElVBKEKT3wjluJUCtwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=PuXHDeuyIxIEfjUnmKIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3OjaQa3rEzBiC_rYpGhuiX-a7o1F6imB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfXx/gqYjbIYPRT
 2R+PrxHMj+0p1FqjEjshfTt3Ni0TgkThx3695Bz0gGdHD37w+Kaene7O/giFWGDchecmWA9EfAg
 3wgEf/Ib6HIhTVduPqUjoNj1k681wq6Nj4R7SfeaPCwxI8tD4rb9rGdn44LJMDLhdv+DW2OuuzA
 0y+m5vQKMVz9A+w4k5KLQW/2X2zaN+6vvhkW/kajByiyZK8aFLM33HOVnH5MlNM+nhRkobJOVbj
 sX7PL1elRkKAda17ZJ8nNw4auo0pE+unk69FeOfBlIUZ5QlMw6sBWAWeArfsC7qNjj94mqnk3ii
 6QWr3vwlTUHKwy0Q1cSjzg6A9+rJR9OxgWy2RUxZjb/OO+fs50H5AJibJORpsljbqCbpWusUa4M
 uCHrR9OELgpMWBbWBodSPP67Ku+mIgSEJqwpXktT1Rigub8raNKU5Y1P+QCyW1ujVT1n8QALaTR
 D4JtUi8f7FqohCYofVw==
X-Proofpoint-ORIG-GUID: 3OjaQa3rEzBiC_rYpGhuiX-a7o1F6imB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Aug 2026 09:45:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4671

Update SRCREV to pick up the latest commits from the SELinuxProject
refpolicy upstream, including:

* a7e7df1b seatd: allow self fifo_file read/write for signal handling
* a1a878c2 adb: add SELinux policy for adbd and adb shell support
* fdea2b8d wireplumber: add SELinux policy module
* 0e8bfe52 tpm2: fix tpm2-abrmd D-Bus communication under enforcing mode
* d3e82b72 lvm: label dmeventd on all distros, not only gentoo
* 74cdfe59 pipewire: add policy for PipeWire multimedia daemon
* d4a85ae3 wayland: Label sockets under /run with wayland_runtime_t
* 5352d9c1 Fix file_contexts for systemd runtime generator output directori=
es
* 9417c19a rauc: new module for the RAUC embedded update framework
* f9578765 Allow net_admin to the nfsd_t domain
* 66a1682f rasdaemon: optionally permit access to ipmitool
* cc59e75f Remove mptctl_device_t type, alias to fixed_disk_device_t
* 1b0bf2acbd Merge pull request #1138 from tkanfade/wireplumber_module (and=
 more)

Full list at:
https://github.com/SELinuxProject/refpolicy/compare/30d3cf5abd18...a7e7df1b=
5bb6

Signed-off-by: fangwu <fangwu@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-securit=
y/refpolicy/refpolicy_git.inc
index 4d207a2..a3742e4 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV =3D "2.20260616+git"
+PV =3D "2.20260729+git"
=20
 SRC_URI =3D "git://github.com/SELinuxProject/refpolicy.git;protocol=3Dhttp=
s;branch=3Dmain;name=3Drefpolicy;destsuffix=3Drefpolicy"
=20
-SRCREV_refpolicy =3D "30d3cf5abd1872d3da5dd44de37de4251674f736"
+SRCREV_refpolicy =3D "a7e7df1b5bb6b98297c3306bc5b1832a5d86a47a"
=20
 UPSTREAM_CHECK_GITTAGREGEX =3D "RELEASE_(?P<pver>\d+_\d+)"
=20
--=20
2.43.0


