Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092FCC6B04
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 06:56:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10160.1775112999071596770
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 23:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=eRUJaGgt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: gmisra@qti.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326icul3955873
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 06:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=yyQj5rzvfH8LYwBSxvNTBz8z2WnlirVbfGvlk6+vps8=; b=eR
	UJaGgtfr8fHt3JeMiOqGivQce4sKOGpWc6Z0olM7qKBZv6sknfwzF39JwGV4VI8U
	2dxPSeBnoQvFzq2EX9w5KIJiHa7E5OK9QyvtJKFyF9tKOpcUETLRINLnirSknL7y
	8+QAw/ps6552rTqjuirHxf7scL3kcp7mlS84Z7gVDrulnJyOEY1HTzOucNELkQTS
	1ULOmquKKA+e4yun1+XuU3xRnFuBgkDPPG1czj0ato/MBN5TlyaIyq8XayqgP5EW
	aWiU/4KzdSZhpSpNMJ8kit5c4nKBRupT2FdltUG1CR/ki8sUq4SmuB1UkNO4NEaA
	oEQG8c9uvPg/VI165oaQ==
Received: from bn1pr07cu003.outbound.protection.outlook.com (mail-bn1pr07cu00306.outbound.protection.outlook.com [40.93.12.6])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9aw5ht2d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:56:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEWlSnyflPdVzqf6/fJq88A/WQLOwDRywqEvJGCZYutfXSSR7XyW8chKCwDlkiq7hT2XGjuMkijzAX1hVOBk5FJ0xUkcZ/Et/eE8qHwiKIkcXMJsqoJiadc6PLIX6jmHfwEKX5t4pKDeCEuuqSPliVU1okc7O4IGA6A6yb0mFhnwGLCmDioCzjhnbuFRHKIL2X0w9IlGd0rWZ6A6AK0Mhn9cGHSRy31TlpqoVql7Qs4DXO9MzpQKE3kKag4Zj9hV4MA1WRKutwcrIYd9/yE8sOM1wSYlQjtC0k/i1x5sWfzBBRVnBD8L1F1Xb4+gkA3xD7mDxhLGjt4EE+YqFb+sKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyQj5rzvfH8LYwBSxvNTBz8z2WnlirVbfGvlk6+vps8=;
 b=SVpsbk47vPKIBOuMdf3rdA6iHdphrA//quvMPaqH1OiEKPxImwJ2n9TK79tJvB6mmQ+PMsW2U5UAoTExz42Uchg1ib/kgvYy0Z68iFFlBjE5+9lVYAeYyAjp8zsKuHCVWmDEQXWed4WfEsGgAjx8Xgdq4yzlBkEmIIkO+eP8SsmjYVykdgg3QyZQ4dkta/dSCywbwu5C+Ilid3CxOP1ISK7u4ycXZ/SOWwat9GlIviBcJQxsM2IamwUYuDqg14RdCeyz20129J2mSZ96F6KEWR8dQjgWXXWUW0aBPk3Uy2F94BRxAFMwWvA0VvKZPYCqWifuq9qufJuLXLa1vsxxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 (2603:10b6:208:542::12) by MW6PR02MB9878.namprd02.prod.outlook.com
 (2603:10b6:303:239::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 2 Apr
 2026 06:56:32 +0000
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d]) by IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 06:56:32 +0000
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux] [PATCH 1/5] refpolicy: Added dontaudit on docker_t to
 manage /usr directory
Thread-Topic: [meta-selinux] [PATCH 1/5] refpolicy: Added dontaudit on
 docker_t to manage /usr directory
Thread-Index: AdzCbRYoAals3iXqTY2XdXSvdqargQ==
Date: Thu, 2 Apr 2026 06:56:32 +0000
Message-ID: 
 <IA3PR02MB11199D6520CA929CA400D06E4F151A@IA3PR02MB11199.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB11199:EE_|MW6PR02MB9878:EE_
x-ms-office365-filtering-correlation-id: 93f5c608-fef5-4d5c-9b9e-08de9084f953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 Nl8aUneYP+WdEY54mc6Fq2z10THV5aG3l6jt7XBtFMDQ/R5+w5yGB6mJOvAi4tcPnQ9lZloLl1O6yVVRvueqGEmIz7Fkwer8DWrexUrZhG3im4ClFWV3vcXn+nNutGfCBNGLuXoPEEqCFqWrMmQM380z6u2qg51oSBK69HDqj70PbsXCuaD8ivVIAG4wFXowciHgSSOO1eh91cNH6qz52NqHyQPhZ9BoOTljWepSMjFJtbl/JKBWzIXFNzqzuw+sSQ8CEMvP/UuJRg0/Xd7weK9okffTrW/Lc6u/ngPGKLGggcnOgZHkYkxMmPuyuEt1sRFpw3+LyRWuSyK0NRsnk/7Z/AyJ/cxHI1wWSG/5d0+2w+yK+Cvl/Ffg1FsEzhGez0ZNR0m/WS7+vAw17foNANLLtKVrEAExHHvGN6RD25S9NXn7zIcVeaSOO96+ygDvA3/eD8X40TkZHgm1EcdM2FJZzbn7K1FFk3NOtXc8QRzpWkeBUDo26ltMW68T8R8/N6L5V20QtCwX8BDTBaJWxRGSGqlcOaTP4QHcD8R+PSykXqI8QnEdksHLCw0aAeGN/ynAMI7+AVLAIaJ26KDEHXNEPpU1IlEwlsfVmTyEQ3U9SjL5YvXhilUfFzBybRyZeXSKXFcwfaWt2tb1g/IrclBKg6954VWV8vNOz+MoeM5eVSW5UQ6y6CpkqPfIMZgvm95zmlAMiU7RbKeJj01XoF2u8BMwxWHjNlcOCm+0ANxXpDWXRcv/EZPLofXDQOC4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR02MB11199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PzOPmE1CPJJ7gId17q3kR3vaeTPPBe7XvJZWoPyxx95kvNxu4wZirwp0RRzL?=
 =?us-ascii?Q?wA2t1hJa34qD2dNSkyvW9xx/f/GKOpxVlol3iCT04Tigq/2a9Xhb36v7+WgX?=
 =?us-ascii?Q?i2rPCGrtngDcoAVv+JExNa7Y6QLwh5xf1V63hwGTV6QOjg6NPIichI/AuBa9?=
 =?us-ascii?Q?fuCekU0ka/lC9RYBKfH/JDLx5XCl2QdopWJbt8yli6mGSnQm2B0EEaA6N+/t?=
 =?us-ascii?Q?CmBNtUIUh+wswhQQft7p30UCeIeiVhrgUhrCJ4KYhoDv3sdxGpcOENO71pgF?=
 =?us-ascii?Q?VwvFU7J7/LFC3OuHtZPSISueGgNDOyqbZ7o4byFFbNtdTFtMgz9D/PXRXCmP?=
 =?us-ascii?Q?VoS6MX7c0DuWrTOb1G53OkLtQrcAsXgSiffFSabkTNW5xcrhZmEbhIUpqr/3?=
 =?us-ascii?Q?MYVXxmlH4pzH88QerRrSx2tqltoveWNVm6d6TppQvcWHahPy11TwOOX8Xj6L?=
 =?us-ascii?Q?tsHYdCe7OZbgeQ47E+Z9Gs6q7ft0a3ht+ZF+D6caciUw76QdbPf6GxgO21w+?=
 =?us-ascii?Q?aCRL+ZL6gc7o4Fh6rKVV7Q0VNRL06sIPyo8o3tG8Jo1BlQBqdruGOqvzwnsh?=
 =?us-ascii?Q?xbZQIXPhfxDn5Pb4DouWAaLDTHJFbGK6/n3p861zQ5IoHplvNrnGG64XU34V?=
 =?us-ascii?Q?xzNi1IpXuIYLPkQbgFE83bXIbfKm8F2BvqKcLYFC6sucQrvdCmxuO8kaID0I?=
 =?us-ascii?Q?GIrVzN67yZnqCdjY4yEVqiq+zDF4TvkiCPXsuD71155fhSjAq4gcBaE1INrR?=
 =?us-ascii?Q?t+hEAmTKeHmbOBrOzmZB/ammzm17YG9UIbj4mcYfthfbX2/dQM4NO5Ro9ScH?=
 =?us-ascii?Q?bZuTC5CET57hgGtO1bn8j1w0h4GnThRFckkV1eF2xrJYciqRjihIWww4yoKo?=
 =?us-ascii?Q?Vpo95boszlQp0Anyfku/uiuN3RhGU22dWT76TnLhVwbSDjmBJVNqXt+xdZdm?=
 =?us-ascii?Q?oUVKjQFoRiZYPOJkrE5nRe0LR81Dh19fYW3zgfUHQNqu+Sf8nJM+DvEdSeU1?=
 =?us-ascii?Q?RbvK2NJzWIKL/+A64vIBF4aKLYIR2tT6vzQKznBlhejFe/IeFUf7umJJRNrm?=
 =?us-ascii?Q?5MQ5nXOptCIh0IxEelkEycU2ycNW3vhOmQ7eUpCxgg8DtOUODQXsw4nP/nIa?=
 =?us-ascii?Q?fLiPA/nZjmiDjhUipWMrfmGInjZDD6hGqBnJo6PTyKzNahCdp1D1BDtfYsty?=
 =?us-ascii?Q?Eir5mL019Js1TOrAMMZ2d8SqaY1sWg8Mu5KDsRFPGoc26BRygTpUKXKjf6wl?=
 =?us-ascii?Q?vCQG+HzbNE9Ne7A8Va/2BsbEMW8uWIL48YiizCYCXyw6XuSxDLW9MggDiRAi?=
 =?us-ascii?Q?OPCF4o+YPEksBr4ktqtdB/2vSEg6CB7S4gekJ0rJLIRFyL65M4XK6Ar37S/I?=
 =?us-ascii?Q?2W0QQxhnwyPxUeRY2JzIR1CEE8QKKDonYteCKL5oVIp64XzbUEZ7myB/l5sv?=
 =?us-ascii?Q?uvmyqNHze+3uYKJDD1t2FAkMNF0v8LoQB6SmEoCd5T6dQsAKD1/NRHGOKBk3?=
 =?us-ascii?Q?yV9JA/6h/z9ibu3dsCJjFoIS9PuvkRsbgv/LLQEE7JEQ7Ehk0spdWmcL7Jw7?=
 =?us-ascii?Q?xn7/IxqELgLewuxscITgcW/IVXv2w01+aZCwH7E+FoZtZ+PNMOmst7L17wdO?=
 =?us-ascii?Q?mLQg2zrEOBtZs7ZL4jTcp+yE9VNTyKFz7oWTrQOvyo6jF6zGJaBqXMUPSxii?=
 =?us-ascii?Q?VHK+V5m1BVbQe5at5nWxx64OnnB6Ch19BHomsParz8dzRjqfOD28s8f8bnXY?=
 =?us-ascii?Q?q1bBakxKEw=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA3PR02MB11199D6520CA929CA400D06E4F151AIA3PR02MB11199na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	JL5hqyNE8uh4ohkEwv4S/hQgTlOR8A5C4QMh67UZacOJUUSHwBeF91Qn+aAiJPcm3ZmHAo/k7rEQFn6wGh/x3Ex1NQAYqb3KpS1JrxjDFaHMlZJlyGXGqCZ1Cz1jzzt6VSrlARDeebKa3V2vwfvzX9oVkiscEUXNFIj0IKo8jqOS1map4clyhhWmbjuDlKefItJ+C7U5Gd9jhQ18ZSQbEswovMBct0YysLjPC6rknXn037bDmJ9MFhCg9CBdiHBNp/BK/mnKm2hm5ovpcgMO25QS6PnV+f11z81Q8GENt08rVqZy+KFuWxzoqmhoo3bVrtxrAFGFRgNR8m1+3WXZfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ObnxrvAHql9NYqrljJqPe0OtTSw1+SA+0FpVHoipU1XzEVG2T8n/dQAtM5qal5DUy1872Ffzb98zChBbbS7G/ddMBLs8K+oBh7L9wNqG7iDcFxbNVbrcmachQVVu+MBUEELN+x7TRl91LYn5oCwjkurfX2uZe6yhRr4oC02jhyH7H79+JOTdc4Ju3ZbRxgIttz50EMGWjIgXR9qoqmfYEEeK9MaKVWYf/fViMKOo5C3KzBDU4hvell3/z02HBBdA1xrNTfw8ta9jVO6qZxCMWdnNFqsT4WAj3uNVsEVg5ty/IAaMNcLYdkGpjbJxyNFEIoPSyaEDn4bsQiOL3/7GEcGRLvxi1bV2OiSvVHJtVAGScYtRO7dgxe0Iy/IKbaADNZhtaTJX6KgKj/2YcPle8McKhjzCJzyweSBHbbBVkM6lWJSG4/QIFvzVMtbbBfUsOlyTD1ib4ms9zZ0Q1+TMC3evz6ZV0euE0rkYxW7BIqGKC5tkL9N9pctfmp0nrS6L600Zgf/ijKdseuzk+Q5BaH1oxiEc6vqsjc+p/kQyrIyWIq4f8e3cU3EUwM2X68z9d4PAaJqZ4pWnJPYGnvtjGBf9ggvKFTAEQxoqKnRWiwRPEcFjODzGOMzzNU3+xkRe
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB11199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f5c608-fef5-4d5c-9b9e-08de9084f953
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:56:32.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4q7erwwMFXZ5eYGxnYF10kKTpkZxtt0yRn3P+O0Uffa+T3Nirz/eab8t+kcdmcZrbX6xAWjQPWEjFaGu+A2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9878
X-Authority-Analysis: v=2.4 cv=Q9jfIo2a c=1 sm=1 tr=0 ts=69ce1325 cx=c_pps
 a=vyniI6In/5XBr/U1JZq+ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=x1E27W6KMhRVoqMcxFEA:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=TKGAfZJ2wu4n1VY2EM4A:9
 a=7tIEifjFCRw9X6Mt:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-GUID: zt4bE9cq7_VZAgTiWr2Vfjv-1xyUxzMv
X-Proofpoint-ORIG-GUID: zt4bE9cq7_VZAgTiWr2Vfjv-1xyUxzMv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MCBTYWx0ZWRfXyf0QkcyUP1/v
 8P1UEL7sCUybVxV7hj6V4m3mvijhuZUgBW/uLZcCSR1tzHroLHqAkWVYucZnKXrk1LEE8fKNAnM
 LgfaBmpvWZbuTBHcTboYQw7x3EVbgQpQZ+kEfn50WnUA8smIb67JlbYOIf11OzQapxgLiqRl1WF
 djjS8qHAGqIgU0NXjcCa9TjuGLebrkkJI+OZP9pqgaQRHzcJJaqelpoPVw4EjU2ay19MhaDuIP8
 sVH+ApoXICvmIe0OEIOji07hEqqECB8FlHChenYSb9H5QG3fQtFi36wTTT40rRKVnRjFVY/6DSX
 LEWVDzSs0AKs2pXYyNJIFohSbso4Tmy928hIGsZc9WDPG8/bgMFAifwL8a2I+LE1j2s/Ca3Dvh9
 CqCo3TntxFBjeJMDPW2QbkozsTIoQM16cj46SQ98U8fUuzo5Y5HrTa0/xAR9pnpqlA8YG8xxPaT
 mUFPCmb/OwwoFKGGnSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020060
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 06:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3604

--_000_IA3PR02MB11199D6520CA929CA400D06E4F151AIA3PR02MB11199na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

refpolicy: Added dontaudit on docker_t to manage /usr directory

avc:  denied  { add_name } for  pid=3D1154 comm=3D"containerd" name=3D"cont=
ainerd" scontext=3Dsystem_u:system_r:dockerd_t:s0 tcontext=3Dsystem_u:objec=
t_r:usr_t:s0 tclass=3Ddir permissive=3D1
avc:  denied  { create } for  pid=3D1154 comm=3D"containerd" name=3D"contai=
nerd" scontext=3Dsystem_u:system_r:dockerd_t:s0 tcontext=3Dsystem_u:object_=
r:usr_t:s0 tclass=3Ddir permissive=3D1

Upstream-Status: Backport [refpolicy: Added dontaudit on docker_t to manage=
 /usr directory * SELinuxProject/refpolicy@bd3c6e0<https://github.com/SELin=
uxProject/refpolicy/commit/bd3c6e00e87b08af23ea3fd50bfb76a3e7ba4c73>]
Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
policy/modules/kernel/files.if    | 18 ++++++++++++++++++
policy/modules/services/docker.te |  2 +-
2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.i=
f
index e55bf337e3..de77c0f090 100644
--- a/policy/modules/kernel/files.if
+++ b/policy/modules/kernel/files.if
@@ -5529,6 +5529,24 @@ interface(`files_delete_usr_dirs',`
               delete_dirs_pattern($1, usr_t, usr_t)
')
+########################################
+## <summary>
+##      Dontaudit Manage /usr directories.
+## </summary>
+## <param name=3D"domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`files_dontaudit_manage_usr_dirs',`
+        gen_require(`
+                type usr_t;
+        ')
+
+        dontaudit $1 usr_t:dir manage_dir_perms;
+')
+
########################################
## <summary>
##          Watch generic directories in /usr.
diff --git a/policy/modules/services/docker.te b/policy/modules/services/do=
cker.te
index a23c21c8f6..f40713d121 100644
--- a/policy/modules/services/docker.te
+++ b/policy/modules/services/docker.te
@@ -47,7 +47,7 @@ container_runtime_named_socket_activation(dockerd_t)
# docker fails to start if /proc/kallsyms is unreadable,
# but only when btrfs support is disabled
files_read_kernel_symbol_table(dockerd_t)
-files_dontaudit_write_usr_dirs(dockerd_t)
+files_dontaudit_manage_usr_dirs(dockerd_t)
 kernel_relabelfrom_unlabeled_dirs(dockerd_t)
# docker wants to load binfmt_misc


--_000_IA3PR02MB11199D6520CA929CA400D06E4F151AIA3PR02MB11199na_
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">refpolicy: Added do=
ntaudit on docker_t to manage /usr directory<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { add_name } for&nbsp; pid=3D1154 comm=3D&quot;containerd&quot; name=
=3D&quot;containerd&quot; scontext=3Dsystem_u:system_r:dockerd_t:s0 tcontex=
t=3Dsystem_u:object_r:usr_t:s0 tclass=3Ddir permissive=3D1<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { create } for&nbsp; pid=3D1154 comm=3D&quot;containerd&quot; name=3D&=
quot;containerd&quot; scontext=3Dsystem_u:system_r:dockerd_t:s0 tcontext=3D=
system_u:object_r:usr_t:s0 tclass=3Ddir permissive=3D1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Upstream-Status: Ba=
ckport [<a href=3D"https://github.com/SELinuxProject/refpolicy/commit/bd3c6=
e00e87b08af23ea3fd50bfb76a3e7ba4c73">refpolicy: Added dontaudit on docker_t=
 to manage /usr directory &middot; SELinuxProject/refpolicy@bd3c6e0</a>]<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Garg=
i Misra &lt;gmisra@qti.qualcomm.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/kern=
el/files.if&nbsp;&nbsp;&nbsp; | 18 ++++++++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/serv=
ices/docker.te |&nbsp; 2 +-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2 files changed, 19=
 insertions(+), 1 deletion(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/kernel/files.if b/policy/modules/kernel/files.if<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index e55bf337e3..d=
e77c0f090 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/kernel/files.if<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/kernel/files.if<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -5529,6 +5529,24=
 @@ interface(`files_delete_usr_dirs',`<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delete_di=
rs_pattern($1, usr_t, usr_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">')<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+##################=
######################<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+## &lt;summary&gt;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+##&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Dontaudit Manage /usr directories.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+## &lt;/summary&gt=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+## &lt;param name=
=3D&quot;domain&quot;&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+##&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &lt;summary&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+##&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Domain allowed access.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+##&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &lt;/summary&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+## &lt;/param&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+interface(`files_d=
ontaudit_manage_usr_dirs',`<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; gen_require(`<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ty=
pe usr_t;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ')<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dontaudit $1 usr_t:dir manage_dir_perms;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+')<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">###################=
#####################<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">## &lt;summary&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">##&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Watch generic directories in /usr.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/services/docker.te b/policy/modules/services/docker.te<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index a23c21c8f6..f=
40713d121 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/services/docker.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/services/docker.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -47,7 +47,7 @@ c=
ontainer_runtime_named_socket_activation(dockerd_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># docker fails to s=
tart if /proc/kallsyms is unreadable,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># but only when btr=
fs support is disabled<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">files_read_kernel_s=
ymbol_table(dockerd_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-files_dontaudit_wr=
ite_usr_dirs(dockerd_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+files_dontaudit_ma=
nage_usr_dirs(dockerd_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;kernel_relabe=
lfrom_unlabeled_dirs(dockerd_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># docker wants to l=
oad binfmt_misc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_IA3PR02MB11199D6520CA929CA400D06E4F151AIA3PR02MB11199na_--

