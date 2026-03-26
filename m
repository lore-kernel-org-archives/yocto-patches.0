Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07610A3D9E
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 15:13:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50773.1774537975220689364
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 08:12:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LpT1Ad+T;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75452d79ea=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q5fMaR324396
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=ns8vGYcWNLaKCdN+xmRe
	+oJ+iEfDdBSpX7XpdAFUSUE=; b=LpT1Ad+TSBcLn7dQT/xVZCZgPYsfGBnfsuPf
	2+RzfbYKZG6+nqpoQkF56u5vygWoecNaVtcfW30LSaG32vm219hGxf+5HOo5g8K5
	VqnYl+3kQg8/2k/rACg8rx4XJoUUiawONIZD2fUOk3z/yXd1nBPssjO5wJDb5aRJ
	EUjkhU9z/PIo8Sy/OltBICi25KOJDipO+TL4G2tOQd9OM4Jpo/GwDNuBZ0ycbWq+
	dI7f4YnpXFBFqwsSTpkr8nWXu+zg978ODL5Hh8C3vbGmtOomF5iQ684RJXCC+MRo
	xN0UgZWkLBQcfyIBllWNALwwD/3+fqs7nnTTJl1tlAVZ5WKdcA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6xq7v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:12:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqjDYT1zPYVUVO7qR0z7gC9r96IQroAe4qzM/wggsTwQqY7J1tDwxr/faiM9Yo1kn/Ap25uTuzuml0WOlXnBV+s5MB/fJdnRp/smbaOD7jHLcl4nqaF7MK5M5Fb5F3PrmkEuvjZu+KhpgaS/j+J6+3qdaeFzs4aJhE6rnTAf5Qo2c8m06FHHcFJByoufYZZgM22zOnglflJxt7oC2tLnfVKrmGEHXPwvtprZlFKqUtnd371ei2cxEuNJ8XQ2wIjfNyg4V6IbVUMNezBI2ZlSBSwpI0A8ZFPzoyuF8piRkMRAK5vAZpcHU5U2fypiXsElInj8ivA23p4olguwOMdTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns8vGYcWNLaKCdN+xmRe+oJ+iEfDdBSpX7XpdAFUSUE=;
 b=ImNcxqJwpc2fsvhhC51qqldgeAo2WxigXOe4S6KUQ3BNC4hwJxssIrPDQBYKkhPvqtM7ApKETtB1H0slv7MpetziVRsSZgCZOb99PyW39dPycamx0jkYK3l96WLxM6d/43C3wkQharYIdVXZe0Ia3IO6XDL2ZrkJXGerrAhc4nsfEMgnr0CFl20AdOj3aB+z+TTdxzRP1/sm/E2lj2xJ2IWQlOnlOv0qQ4OqYFsY30JJIQXsxh9qi24qyLmxekkPFT9QV+HDLELv77aHP05xfMJLiybMpl002vjXyRb7u87Aj4B2wvW1j76QgAcCRdt2nzPphRmXwdtzdQTQOYRMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:12:51 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 15:12:49 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] openscap: upgrade 1.4.2 -> 1.4.3
Date: Thu, 26 Mar 2026 23:12:33 +0800
Message-Id: <20260326151234.2077655-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: db8a244c-f675-43a1-5944-08de8b4a24d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	rTcW5BcG0rEuZOzEKi/ZusMy8EVU8L6psMHnFHLEYfysRhGVKAnumm5e8QMbLZ91ZSkOmHcrf1YNCyQU77Ru5oy07A6fzpGJdFDhaDj+CTXtDiXUL7QlPmnKCWmQ8Y7QuChkmHuQSZo5A5Mb60u3TaxjZVlWwV/Ap6QPVUCfXpZ44JY/sqdeWFX/J+wGEZN6yjyT+vrgRjNbvOgDRPJRgpoyCAlMTVrSwNU4e2gDPjnseZ9ldgoOSG0KmYQiwrNKaBz/VTV/dD6lO6jsG7Ff2I0WJH2P1aMK1mtHeYyG6m+tsk/NBa5jNytTy6szmV52sGLxEy0rfAkO4HVbZ+wsaHLQOWjaj/at5pMDrXjTITmbvQ4IHEu/9KfvgKXMfCT4pHTcHi/XJknKSe+OgBXlH0X2u7fSU6DrI/uGEr0H6BqzqtmooqgHYmUKjCyNK4GmFPxRXnJ+yN/+Y39GD1H7CMbiJuoDZ14VO6SFPCFqBHrOoKwlejuVF1jMNWUGE/abQF9uU+DAfVHqsfxMZ5wC2WTlDUQSZUp1O7kunjVgNDuh1/sXv5nJUUNUU9JFPpP2wmaE+2iXwdkLA3+A5eHHLERQYPHImysOd+IqUt81Y915c3h6ebhYDPXOeJo05znXABaKvlTEYfYYPUs7cUHQrXuPRnY/G+btlPsZ5VDHc5XBmTI+pDhNGC3T6zulhr1t3tYZwIia7So7NOUnbDKKAR5rcr37jmhi81O6WivDkPyOda05McY9v7mjd+9AvyMrDI5dcL/1RW+2Xma6sL7MFOVZFVGsA1NF6DTy1w647QU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xAv8ek4kDeSYFdrUUKak5+7HdyDEwCfVCK2BrtA2jNkJdttUV3WhtOzAb9kJ?=
 =?us-ascii?Q?3eBvTL5rJeP7yqq1tcBNqht+xkDfkCo4OHNNEesdNCDY8I8qSpyM0bRyKdVI?=
 =?us-ascii?Q?8ljUzJWwtdCwJNxrJH2h3YPLsBN6vdIXuY/z2oSjRR0MjFtOBh/MgH+eSTF0?=
 =?us-ascii?Q?mh7UcfmqCmKctZ8izkWLPvZr1gJc4jRj04aIViUF5nNPSKO2MaO4O0vChPCU?=
 =?us-ascii?Q?vgrUwXdHcX0y7id56hLhcD98SHJlxOxoSWfrtaD7/juN27mMVAznCdno7Owr?=
 =?us-ascii?Q?YLRz8g5E9fKhITIHBpuixm4tvvXaC/B4o1jKbmRqZRQsF1PTmLCZTqmLd/ug?=
 =?us-ascii?Q?yUOQkB5uDrHtfMEhfDuwee2JZEYF7nu5tZAgPNOlUWTGxbic1BBedOmoeW0k?=
 =?us-ascii?Q?YdoCk/H7BCFC5bdRzdIpGS3U3F8OQ+6vGt+arCjYl4Y9fAyfgfdGOL/e734B?=
 =?us-ascii?Q?dnkcox4V1mzSbAQvGLpiLwozb/UhIZ6ZRpASOMY9+Vjr3WJnWEK/KI2MckbY?=
 =?us-ascii?Q?LTiyjbwv7o+NBdkYuJQbNk+I5Pz1M+oE2WAvd9J1CIq5kAvR7SpiVisxqD0L?=
 =?us-ascii?Q?hfX0g9BW7q3654LMKnLUu9RBfOoPrqL/nA884Z5X+yL2wP9CYwnGEylZDIaS?=
 =?us-ascii?Q?JJFgyTFxmRmGd90/idXGOE69XO3kDq5C8Q9eQkjUCv/ZtJnRg4fTN21aWDae?=
 =?us-ascii?Q?y8tHOaIBmWf5WCwt5h4sb5dpXNuk+8hXPp5VfimGOkANl391vuGu/gUANnLP?=
 =?us-ascii?Q?uDALs1npJaDbEynbulcqWYHQM8mIBUMQr/4G3oBnNJiSkuG8u39S+IzyzFS4?=
 =?us-ascii?Q?TDG18ZoRVZxye5aZggcB8BBq/X4dPi7csDaggZWvZqz0t8OT1r5IbxumNmbp?=
 =?us-ascii?Q?HS1IJEKu4lg/CClIUHUB63bOWT/U1KZbKoNaBW6w/rvIoISGQNVVUoIr3h2f?=
 =?us-ascii?Q?+WEPqsBzq6nLaR2v8kGohDLh47QeAfejUpCIHMi/F1J6IhhxGgRMIoueQ71T?=
 =?us-ascii?Q?fqLb+TDIai6GOxs7FGLhhJFVu8OUu9oRfMbgC5SvITBxQGDwkVIk9mRPYXF1?=
 =?us-ascii?Q?oj3DyVf89UB5RgLuz9oX1Y7D9PxPMuvDnjBOiJvT0o4eFcterxD+WV8GyTxG?=
 =?us-ascii?Q?sfz5zVWEfA0c8sRhDPsHbMAMjBbNi0SwZzcodiDL5CDtrtcVgt6KgufNZAgt?=
 =?us-ascii?Q?48jaiyZBOd2Hh8e2Qe/CVXIYy/lnbJ9sxNe38o0S1Mb1xRWVlipIGzGmegve?=
 =?us-ascii?Q?nDLtGvlGQIiySDmneG5CZoPiVzAXUsS8EvbEDDEuwwZULsJo7Ad0MVoSIsRC?=
 =?us-ascii?Q?iCaLyYvq94tZ5V0FFsCOOtEJK8dw5CQ5Gj9ctsfk54a+wo3V5xrGIhy2F63B?=
 =?us-ascii?Q?xRmAEeazr8gB90dgdY89VPRUfPzMnj8HOd0U+pSvuAzexQGu8D+dgLaq7yYR?=
 =?us-ascii?Q?t+Ibs4wK0cvBzaEI7CHrqXDCS1Q7IHnjHX1O3AJ15TYygTeu/BSEnKLWBhq8?=
 =?us-ascii?Q?LWIgCIWc/wCRXBosdMZvJvSHPVmZoPxnT8bRLolaGk4aB24Fkr6E3Asawu+m?=
 =?us-ascii?Q?B4PBgfPC7NhR+OsWc+JB3D48T5VkBBOikHKxJuj6PCb02oH71CV9qxrDNmOb?=
 =?us-ascii?Q?6RNUzDvxF4qoWm15Dvsmosg0+qrrc7V/sWgg3FSPt3nk1SF246L5oJcy77Ic?=
 =?us-ascii?Q?6QvKFPMaWKYrQ+IB2ljJgzDTv/QHElcmmSLtpP2giGoD3F0/p3avE6R3gIAL?=
 =?us-ascii?Q?nDDi3QfDvQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	I+oiLAfs135P+S2J7WMezL/E2xDrWfTPtouOHPPwebZdWBZeE88F+8bzL/HLjEDwrzuJZP44zQmvkxumOhaqQ1l7AxC5zL75y1bwvpDFU7KqEUtn+JMbnu2+OiT12qpvZpb5Dt0tIyKVSzyMUXZLtQ9PyLGQ64kChPx1vE97rwJrD+1KgkSdbNCwYUdbkQ+d6dRQ+d025Aepddg52UlPRdds0y1kDiJuU/CRcSWDp/YYvCds2bMnBReXCdGn/arce04Ksh58e+ntXSSyUbHfxturb+SIypoN8vFBF9KGWs/j5csXGfxsOzBD2Pfz1tb0bi0ZnNEFkUy/JQM4Ozp7SQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8a244c-f675-43a1-5944-08de8b4a24d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:12:49.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1Z4Zt/n0IZ3Dp/xsTMSI9jNmk4dcXPEp5hsjnY0yDaLQMC3WmlgI2az0Uh3Mc9Cgk9/jGSWb53OlByDjoJ6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNyBTYWx0ZWRfX226ncJB0aF0i
 +uj+m/qoBv7kDS3jCoOMM6ZMts9EHjHzfAPfgwjsAybgtHw8t2xo5QZ3xPOKJQh0MDp0nxKq2U8
 zB5yYoavHP3yEuBnMdLiCKjKbVnexPm8IPgFMaVX+x1xVRBduyUtk+S/35NHJIMp1Jzea1C3QE7
 8IOzTHE+guIfq2WlI7yncE5tL9j6l8DVfCtrY3T/0vloBrOIuakYnFB9RWG2X3ymEw6XH8PWLdt
 jxenTixndGxY1V5DSOdeln3jqSRSAPvgMD+o/HviaKfOUudNUM7AQyvrfrIPozm/iIoBEVJhaUX
 TK1C2YHBUVbodb6oMv6rjaSuLEHSp54kcqG59dTlDlZfj+pWBRwOMxhNL4lfUkhu5qAP9lZWbPA
 lJ8SfQQFkLIBZSvQ6o6ScDe5vQNJAytpkQl+CL/K5UIR5LbL/6RAD4USfxMEcI9N1adlyJEQPpk
 QSTQR5zZjrn3QsEeOMw==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c54cf6 cx=c_pps
 a=+HTpKnCyMzx6Y2VIV8u7NA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=59VzxU5JAAAA:20
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=iMqMkZj06GA_XbzDSekA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: txS3BPGcmfamyZwqtyYs169NRoPcMEwA
X-Proofpoint-GUID: txS3BPGcmfamyZwqtyYs169NRoPcMEwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260107
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:13:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3557

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.3

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.4.2.bb => openscap_1.4.3.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.4.2.bb => openscap_1.4.3.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-compliance/openscap/openscap_1.4.3.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.4.2.bb
rename to recipes-compliance/openscap/openscap_1.4.3.bb
index 7b3786e..e1cb295 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.3.bb
@@ -13,7 +13,7 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-SRCREV = "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
+SRCREV = "24986066961363e24fcff83294995b3cfe4058ba"
 
 COMPATIBLE_HOST:libc-musl = "null"
 
-- 
2.34.1


