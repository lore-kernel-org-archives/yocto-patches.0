Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703DFCC6B00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 07:05:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10288.1775113531089268877
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 00:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=PxZM6M/5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qti.qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326q04M3745952
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 07:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=daiEkRZYPnThkUinlctOnzBQpkom7HdC5bN1wMi0rD8=; b=Px
	ZM6M/5DOxwXLTKfA1neuBUNsgD/qAcrdKnKkKMip4OlygHW+7E/GKj560RfXqWAt
	qXG0rnOJqg5vKP9xwFvlkQ2ILxe7nstELJc/Wf6/v1w2kch6+Y5w0t5l/8lVVk98
	Kgi+Z3EP0aaMe0rJTxNi5RVfkq/4iG7IbewpGpA6VN0tb6fihAthioG5f4dbvkGN
	SBNNJ6uuJ48E8hPbrOcxTplODEIfob6EZ3vja/2/tpXUU3tJpgIDss1/q2t9Aqbe
	IjX8J8Zs1qIbVwjsalYEA8qcg1qNZhU0jhyaL7VaVxXaV77pP1vEZAJW8od0BWXn
	oAUyApyw0Mvs+WoDlPPA==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00302.outbound.protection.outlook.com [40.93.13.58])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9324kwau-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:05:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaQHf5A7US5FnfK4CFeHxpNeF2GzMJCaEfhxtAKLZAeH2mjH+8LxviwxHxyfSAz28CyVbice2QqWyhyOcGFgP0xNgF52qN3HIOxCrKSEqE94zoc1V6/TCEwwJRynR34vcFcbPcLiBue8t2Gf225GR1LLnFY/UkM/dF3vEO+1+EzzvJUAqWY508Kqk2eaiqkXATvWFZTjpSz+R8bqKvfbeBOBSpeaRICFUHbK5Rq0SyFOEtDUDVu6Max8zlIyS9oKMgvOFc7WafIwhvNK8El3NykPmzq0JmfJWR+f/uMFZETLwE8dYSpsvf0h4B4TCkxTflpgDBXdAKPnawM1rGLTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daiEkRZYPnThkUinlctOnzBQpkom7HdC5bN1wMi0rD8=;
 b=lUNYAGd4xTTPpRih5cSkqxemQYgbwEs6AkNv2T+26hCBOtAnrU2ltA1kJLGRaK6sR0i18rOzkVGcsnHg/3eb3EekvTsEJ7A0fgwgyrLPz+QTTVPzuniZIWgr+l1bFcAYiIAMFJsHrsHZSA8+b7s4CvyDQHsIabBTaXDaVWmzraauYZOo9buwDIk1eydM9k7hdSnCTj7MlfmlhfQMc9ICg0tprJC9xkGBDbryicayYl5JP9X/ESLqocTx0jfy0Xjs7PuvYgz828vfJYeYNQXXWjAEWt5Dy0W36jeGboOSFJfoJf8KKxkbD39aGlrw7HnQSrHktiwTxB3ymODUzxj4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 (2603:10b6:208:542::12) by PH0PR02MB11318.namprd02.prod.outlook.com
 (2603:10b6:510:38f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 07:05:28 +0000
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d]) by IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 07:05:28 +0000
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux][PATCH 5/5] refpolicy: donotaudit rsyslogd for
 net_admin capability on self
Thread-Topic: [meta-selinux][PATCH 5/5] refpolicy: donotaudit rsyslogd for
 net_admin capability on self
Thread-Index: AdzCbveT7eMirkQsSPWTlkv+Wf+gHA==
Date: Thu, 2 Apr 2026 07:05:28 +0000
Message-ID: 
 <IA3PR02MB111995AD3CC1BADED7E4CDCEAF151A@IA3PR02MB11199.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB11199:EE_|PH0PR02MB11318:EE_
x-ms-office365-filtering-correlation-id: cc985978-943f-4436-8245-08de908638e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|8096899003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 JCesEKbspU7ES2fk8etHevD9070FhaROyERc6/SWiKyMwvDgo++Lg1ppgROfKufMGB4XiyL9uDWV+oSrVej4yVyZk7XDziKxC9IsxagQanBkaUh2fYM5a1hsPRJ3ZJuyzNVqBDHRLtoYv5UO9Pq/3T2PmZhNgYeU+YaeqgPdnS/xFuaordm4je7coTJqWUGjHQ8cZxN5swXdifRpIejCBzcwU5xmovH35n3Y4M2mblbU2n1nxbmbXaxTFzOgZUEyFZZAzbAglqYd2zGRnSOhfC5J8MmBHzJfgT9KZjj9vDzhJ7ESUXXQaQzyE5eUcbv+ugltmvlX3feBYLqsJfX8KnhoO3iM8B4jCfHwZM5Mz8CeBlIM8cQiboej9qZERjSbDgwdMgDRU0Fl4GiYDoEt6EJt2F/l/7GEZfvaZqXPu4Xjmu63zyV9LnPXNhG+tisa46RUo32SwpxicVHU6cXB4N28Dft0iAF3Z1kJXmFkhVXvlMoXmNGxlPjEgiHnciFxdV1Y1Kt/8jeI/mTxYXwEPouSvo5kMV3/LmZfceakTdJKWq38u/W/TFAUBYli63GnBUheOV4T28zqdnvcQhQoj+b/Swk1vehvw/hZljAN3vzjfVkvgJ0o9gQJAbblihiLrEl84eA82HHCZYEBo/BbEFGIRv3SiUNXy6eFuLIdFu3VHas0PpVqzwsjdKMDpnBJyrwGhBA3XAK6L55HPjLFpq05HVeMElWyuzbgbVmlf+0lnMO2b+56iekTpTIepUSF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR02MB11199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dqP5Qkdca/daCIm4/RYcLTBhd96gvTb63On3+5K9IsoM5mcm9ufZlYlr4k7T?=
 =?us-ascii?Q?crlWQ1zP2sOK+Vc695XG2xUgNKhrd6u7BSnlTkRH8EzqXJdvEpmKYQKEfwO1?=
 =?us-ascii?Q?ilFV3ejkxxvF2vNvpMbggGOeCWRITT88iMKz55Ed3IGJqW/S7i15I8VxQ22N?=
 =?us-ascii?Q?mem0b7fpHQq4z9mbekdzLkOhLssDAPYklfKD8WMwkvJcqBTDMiZWAcYTqfB/?=
 =?us-ascii?Q?e3rPAwub1bH7reL/BU7Uf2oZRDZqFwPYqFmVc6WRWw1IVw1hle8S5ydCUJww?=
 =?us-ascii?Q?LIQXHm7akY1Eew37gHF7JcESa9G4JU1qzWOjg2A+A+Hofax8Cfbe0KHimBHm?=
 =?us-ascii?Q?FmDwCvRLdQFXjEnJOocLDfbB+MO6V7Yh9BzAjWH1qHRKjlp27mxTircUAG16?=
 =?us-ascii?Q?HYV3/ToWW09nn+x92HOhwg576fqNxbjbsxevke8OLAL26eMcWOUUq3fgx7gT?=
 =?us-ascii?Q?C6kVVhLu8QAoswL7w/FoZ7EqGw988ol8ZF2//TUROkBAK7Lu/q1fS9QwNm2u?=
 =?us-ascii?Q?ActxD81u4b8g/k47cAfo52RLGuQ8n6wUQiS2fnlKHR+5HTXPhFmZrroqC3Zb?=
 =?us-ascii?Q?P7gFMIcJgp69htK2MFHoXOgjRxjSx9LXVN7adXvyRiNIwMU7d3TqhqOckgYC?=
 =?us-ascii?Q?y8zU5XCoajWqxmC0aNYtB8sJXemRPPqIRzwVnhvvSTy0oAMul2wMWHlNn7qM?=
 =?us-ascii?Q?aGyGLDFBD6Ik+PaojxPkWW/8zLgn52H8nVN1x8hIkcBfoLRvU383ezARA3Gi?=
 =?us-ascii?Q?JgX3zFPmKXByTDa3mj5YhEaVd2vuW8tUfuGAqEz9ULagtOpyXjCMIbfgZV0K?=
 =?us-ascii?Q?r6GIaRv4TyV22ot9Tt2u1QN/RBRQDssw+lzLtofbpcMoqcKT5ELmhu00PLUG?=
 =?us-ascii?Q?NO6lWuwy9hKMU8sHlW+9MFFW3qF+x+9/p7BhryvbLdDWl9qisA8+WTZV1M5z?=
 =?us-ascii?Q?jAFzWOG2bngaZ94uweuWEOowGqO08a2+w6dkj9DDmpEOqI1QAxacViSbQHOT?=
 =?us-ascii?Q?wfAr1U152peb0pyB95uYrv8HLmijCd1BpsNRKyDS0x319r/tAwPZaKbq2j5R?=
 =?us-ascii?Q?X5Q4f1VIOdGzc+dfkIZItbF2qQeG1PreuRWkbvPMReuL7INKoCxcOSQMTuf6?=
 =?us-ascii?Q?q2iVg+RFhF7LDzReaGvqxrCXLV7avo94DuaVxjt9kHIyLvXNlanAZo1P+9/y?=
 =?us-ascii?Q?X8B/8acc9A2x7lTKInTAf/mleQXdlSWMthkOE7Y435XNMY+0sYxWxDycm1g1?=
 =?us-ascii?Q?BBrJK5QJer3oObcYp3d6CKjoPklir8wAMLnjGIrIlV3xAeN4NJfKHp9XzT/8?=
 =?us-ascii?Q?m+DeI/7oEbVSFfM1c6TTsqb6QRqqavp5/7O/OaXrpF1voK+cKoR2m5bTietu?=
 =?us-ascii?Q?w9QYvXhFhIuXfGGyNOEr0IBd2YzrhN9VSciaq+OHTqeyl8SG0m+jxBaIiaEV?=
 =?us-ascii?Q?K05zFLygr8tPdb7fevluwHmIial01xRGGxhaIVrszLC0eHTf8Oxk0nnsIGT1?=
 =?us-ascii?Q?V0cUaGkISkhDuzHUUzM+C64YDk0SfB3jbv/DeM131JAO8D3tvb84W7uaWmG7?=
 =?us-ascii?Q?U56cTnW8HML8p31qL1m3sQkK7Tgclmy+AoJsuupNvRUfvL8uGBkPc6LJFBMP?=
 =?us-ascii?Q?6CDbbDr4jtSVy/afa/8iJm9hMBJqhy2rzjREbaKIGZwf/ebFcVdp5fNaaVM9?=
 =?us-ascii?Q?mxZ4zBNgBMYPlccxiMBh++3je33ppsTpnVq6WbTp5fkVycsozIpl152yS5+f?=
 =?us-ascii?Q?/FPFR/NqhQ=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA3PR02MB111995AD3CC1BADED7E4CDCEAF151AIA3PR02MB11199na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	kMOOF7RFXvxW1EiCgRfWdaIrKEN0lhDwlglRgEmjU3X5vVI8HzXLO6JDZ7uXU44NdpE1Ed3zaxRavDqbNoBEezi6LPfi3iYL1mgQRwN+Pvep4OF9wzBpOekVtS6bC8jwK0IYLkDxktUG5+YofJ/upChUc4BWewHudJjmMh0CICwLQe4ihwFkuePniXnZRPJ0fQvLAI15qEH+jg7QI/P3DqFm5bPzGpOuXXo/Dwkln8WyMJnMyjvi4bllDF2o+kgdCm1dwSaO4D5gOI6zjZMooqiLwG1lUQilKsM7gvbrqiS/oQrayk9rIw6bf42iCBoK3wx5XWSRBtfbi/XIDBxPlw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	toy8bp2E9tOJdgfkFD7isazVPffMq2vOcUBoNOhPNn0iXkSEkNMfNpuEcwSLL7avQ2i/Nii1VFjvUNPuHjL0sXVS+wX//KLB2yT/Ad5NqeZaevea2JBWnN/R7HR2mhzlhNLQzA3SxDNSRR4MfokzIVn/nR0lY5YRLroiFnI71mJnrqQyFvzJnWtOBUO5Xbp4rNp6F+ZW/GYNf3pvnFSk/z0QIiFdOtrzXoRRfZWz2UN6lJd+ZtjWjbLil3BJTb52ROnpp427zhz0KPS4e5/6HV9brKJrr03ky1hOPWoPC7hPiV/HEtBeJIkT65Y+GCf+OoPJwwTTFwn51Vr4RGISdo51wUFjD1+VKjQ2mwLhF/s3rPwEnixWbWpfQ58PjhEhm8W3+r0xiGVlcQI3sdqejfMPADbhg6UWNdwlYY1sIAfXiX8juk7O8lJrnCbeM5b14Lf/6Wgx6Scyuu2PXNwzJ+SEYMCCifDgK/Nqvg1qamE4aNpW5XaA5bBHY27mIi0pdMvzx724aSX8lszLjlVxzNKi72O41HtQR7JYZuhufJQsIqRPnya2XYrQP4KXr8/FaCY0gTtIOJTz6qMvvRV4nY0GTU5yR+VWol41LSPBnvvt2o638guhSx6I3o0wNS9E
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB11199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc985978-943f-4436-8245-08de908638e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:05:28.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtAuXkiK52rQhkI72nOzY11Cj8QLbJa3PDkZ3n1MWtkIShin81zjJhs9g8pUKRYESvQR+v4/h+yG9K1gSJCWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB11318
X-Proofpoint-GUID: DDBGfp2km0iHfKXooM6sQW_gD-46TMpa
X-Authority-Analysis: v=2.4 cv=TKBIilla c=1 sm=1 tr=0 ts=69ce153a cx=c_pps
 a=1HtwilQDvHI2YA4O/KCv+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=50YQJQeRvSoVMKN6iSgA:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=t3Xqqeb88XhHY6j-vlAA:9
 a=xOvUGthomhZvmT7E:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MSBTYWx0ZWRfX8gQDrNXQi2mp
 2LZDldCUYPVibYHVrSZ1ETERQl+0VJJhQOZI4uFGQH0hSBZffRs6tOgjWq7TndMvsxgk3kuegbV
 LhUWyk2dF25GQqx4swFtfKU4MPsB4KLxDZJp4ZAvFF7v8UKHKVXk6SDhDtwvvDC8MVi2zoHme1v
 dWFR3UExl9szQW2s9wkzf/dHySlr3xylz9mjOUL5qeSqoDO5eYEs/dp7mLvO/OfHkbe0xUc2IYH
 h5qCp25Q32v1spGZ5w4MKbQMVEPlTC/hsDHzASscFeOxOMwpeQH7V1HumAj64pvc8wjpmdDAcBT
 pyhyu59+8E3cfsvQpc2oewpIESV+eZOgN89Uux/ivzytHquxVEJ5LEob/7oJpBNvGqNHRZHhrKZ
 VnuKSvuS56XjtTQVeXr0DHKAcvttRK2oIO06ZHOHGdOqsTgXzzr9cNkgjZBQ+hPP55ef7r2yqNd
 dxY8qgF1+AxD2gnDW9w==
X-Proofpoint-ORIG-GUID: DDBGfp2km0iHfKXooM6sQW_gD-46TMpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:05:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3609

--_000_IA3PR02MB111995AD3CC1BADED7E4CDCEAF151AIA3PR02MB11199na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

refpolicy: donotaudit rsyslogd for net_admin capability on self

avc:  denied  { net_admin } for  pid=3D1360 comm=3D"rsyslogd" capability=3D=
12  scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_u:system_r:=
syslogd_t:s0 tclass=3Dcapability permissive=3D1

Upstream-Status: Backport [refpolicy: donotaudit rsyslogd for net_admin cap=
ability on self * SELinuxProject/refpolicy@9ff571c<https://github.com/SELin=
uxProject/refpolicy/commit/9ff571c7998d62b75df2d575a3eeeff58fde12f4>]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
policy/modules/system/logging.te | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policy/modules/system/logging.te b/policy/modules/system/loggi=
ng.te
index 0ba5d3d8b6..314b2559bf 100644
--- a/policy/modules/system/logging.te
+++ b/policy/modules/system/logging.te
@@ -399,7 +399,7 @@ optional_policy(`
# sys_admin for the integrated klog of syslog-ng and metalog
# sys_nice for rsyslog
allow syslogd_t self:capability { chown dac_override fsetid setgid setuid s=
ys_admin sys_nice sys_resource sys_tty_config };
-dontaudit syslogd_t self:capability { sys_ptrace };
+dontaudit syslogd_t self:capability { sys_ptrace net_admin };
dontaudit syslogd_t self:cap_userns { kill sys_ptrace };
# setpgid for metalog
# setrlimit for syslog-ng


--_000_IA3PR02MB111995AD3CC1BADED7E4CDCEAF151AIA3PR02MB11199na_
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">refpolicy: donotaud=
it rsyslogd for net_admin capability on self<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { net_admin } for&nbsp; pid=3D1360 comm=3D&quot;rsyslogd&quot; capabil=
ity=3D12&nbsp; scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_=
u:system_r:syslogd_t:s0 tclass=3Dcapability permissive=3D1<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Upstream-Status: Ba=
ckport [<a href=3D"https://github.com/SELinuxProject/refpolicy/commit/9ff57=
1c7998d62b75df2d575a3eeeff58fde12f4">refpolicy: donotaudit rsyslogd for net=
_admin capability on self &middot; SELinuxProject/refpolicy@9ff571c</a>]<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Garg=
i Misra &lt;gmisra@qti.qualcomm.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/syst=
em/logging.te | 2 +-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1 file changed, 1 i=
nsertion(+), 1 deletion(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/system/logging.te b/policy/modules/system/logging.te<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0ba5d3d8b6..3=
14b2559bf 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/system/logging.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/system/logging.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -399,7 +399,7 @@=
 optional_policy(`<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># sys_admin for the=
 integrated klog of syslog-ng and metalog<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># sys_nice for rsys=
log<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">allow syslogd_t sel=
f:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice s=
ys_resource sys_tty_config };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-dontaudit syslogd_=
t self:capability { sys_ptrace };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+dontaudit syslogd_=
t self:capability { sys_ptrace net_admin };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">dontaudit syslogd_t=
 self:cap_userns { kill sys_ptrace };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># setpgid for metal=
og<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># setrlimit for sys=
log-ng<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_IA3PR02MB111995AD3CC1BADED7E4CDCEAF151AIA3PR02MB11199na_--

