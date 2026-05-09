Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767FCD343F
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:18:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6747.1778303894210250738
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 22:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QOhdLMAC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95892e51f6=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494wF9I220146
	for <yocto-patches@lists.yoctoproject.org>; Sat, 9 May 2026 05:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=z+L9Bbk5os6gnMZeAspniAhGTf1OHuWHMQNKKBtko7I=; b=QOhdLMACghki
	xuTyRtHtU18phr/UWWeUWdbB+4exxI+KWycGZOoDQ4Led8aodBlz4cpIvbna2dh1
	SbW7hrL8i1IHVod8LvmL7a4RQfZod4LaSe9vqAaygAJwCGbU9S4FZs8DK1t01hz3
	qw1UHAoFmLg1V7KAqVjtl6FSNnfhUqKEM95KaeKlnR6NaEjfKNBdjq3S5sGzb6ms
	6EImYJXpjgLkwK4aMI2fYxtudyRtuBX6p/TDtqYhrxtb2ECLIVznvk021mHA+cta
	JSw9wsGzsSnZ3ISXSTx6fyvwH7MKUIsrjYnGivhwVQjUfoyesoiQ2mPYPP02J7sJ
	nN5Iavgduw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1t50067f-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 05:18:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff/kiGsIbEP5HqYPXi8kNRbfmpGJEms3qavYBJtQuRh7993pdFQDmd9UsuZsMTu4fP+vY0Icy7HN1wxePlxS+byXs+NURcVxHYNH7Lygb2kaSzLptMdmp4OcQnCJqdXSkxxztO/9J9cCU6U39WZ6YQwyj2v+EaKKgFSJj+i9rTKO2+I9tcAwF4vAZ74W2TMC3xwUNEXwNByUu9eOcVsMUfIj0Ybgbnl1TrXq4/mSbX49DYWZoazyEGCNf/cPqfJkFBpAG3iW2IUm3HvfpiE6vZzh43uroJitWg5nAE5jsr7QHPH4qHjB0AJ9z84Zty/17x4QoHIqm0JUwrk4i2AwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+L9Bbk5os6gnMZeAspniAhGTf1OHuWHMQNKKBtko7I=;
 b=FVZKegmh0LY3Ywp3hEyOplmFiEtCKXLyKHgtRwE09R6iTGs75dR4hfYZFKGpEo4X6pjadwIvzrXHhps+bmVoU2wqTNlLbkov0rTc0gqRIZu3QujLicCAN52LG/DAsbcjvmdVCersVwERwI1INfdfjxymNfH4HnrHwviD2C4+TgoYNAm+Kq9qfgdiOoRIi1f8fzswJx6W7FeJQWV3wXia4EjxJ6mx7dLr5e+KcgpmmWR4Yt/XOEsz5HNZetQhjtJKJZJDGCYFRRhAGIL+A3ontOvmPOIIpCaIX+SbQtBHeAOkv366REoS/bTKfB8Ta8SRBabW2GP1lQi301Xeqpi2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by IA1PR11MB7677.namprd11.prod.outlook.com
 (2603:10b6:208:3fd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:18:07 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:18:06 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [v2][meta-selinux][PATCH 2/2] libselinux-python: remove all RECORD files
Date: Fri,  8 May 2026 22:18:00 -0700
Message-ID: <20260509051800.243345-2-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260509051800.243345-1-zhixiong.chi@windriver.com>
References: <20260509051800.243345-1-zhixiong.chi@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|IA1PR11MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f8df5c-b273-475d-dd25-08dead8a5a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Z4dOZHKOvBTEq8w7GWiXKOyv5PjyLF1w/dW+/SgwAM0GMfWkgSBA11RELvNSgSRFPlOTsJ8SPKq6iIbowU+S2Tf1PyUpErwbRFnDxKAF+9lRZD6pMJUZs0hgn89/ztTLUWOKQJnyoKXEXcpBM73nFe3wIp5dv5eT4bC+sfEp+W69FuH6DIL9jk/xzLnSVVHiaVB1xC+qblfwQDk4kfEyOY8FO5CgBxO1vjJBZc/f2XEdsUJoVw+1j9T/eUEXBmMpUAUN8Muytxc3qox1Yz26iVWkIzvL+D6aVSXRoAY0s2DJeU1QO0F1Yq+yMxOWLa8my4fFVIxbiZsXZOBNIM4ltMHiPJ/y0NcI+l69p9zUonjrQzrUIEOMyeXPGAJ4FWQSfvt00bQg70Nl3INC45BrXZogzmiuLts/zCWPhn+YMCwL3Zh0K/7ix2jLXIgz5wgdjouytu9u90cpPdwUrQJiKC+UJ5+3JvT3rsW7o1dXp3Osg51BMU6VrnXgBrFfPazPZ49F+umVbVOrm6+KMP2mAbCPp1lnRU8naOyrAujApzWPSCFSh0z53H1Q4Ybd974cXNxSTNEvCs+/UH9MlKuHli5dMXr3+w8KRtQv5KYqaSUxav+ng1CCRd4oDpvrZ2ggL+U5O1vojVMRLbAeDjgtjgeOvw4kfoms+AkzhQm18T65ogC20ull3YrvV0FU/cef
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/uhuvmfqT1ULPOIFr04r0MpNsZDtZGHyGpt01rzk4HJDxD7ZxgA+APdrqnT0?=
 =?us-ascii?Q?nzvncH26b8y9MGHZKJDCb6+IZaGqHL2OTqiyMvJeNrOVr0Kb7uWnmY+BCufM?=
 =?us-ascii?Q?YWz4jD7j9zd6TfFnanrQOmkfNebv8W+IynL2eMdSGouObKYkmHCpuXSjpCEc?=
 =?us-ascii?Q?LyGMj3j/Keq1GvMuzoH28jni6M9Ku6PEPRZU/GGaPQksvWlTvwCf0hqyK7tE?=
 =?us-ascii?Q?0We3NvW4C4rfVBdssNrGDkq3dbLUZmPCCti8LiIytLDIH44RpnVQECwfLnDc?=
 =?us-ascii?Q?9rgGA8oA+tgPdGKm09e/zoh2pVP5B1o0LRuWJVOxpxQU637gMgyUap2Lz9Sx?=
 =?us-ascii?Q?OHqB03jkULVFps3XIxPx+9BPpZpHMKNmb8bGSPY240R6ABUEBHQpDnKdA8EH?=
 =?us-ascii?Q?RqHulPULiW2nMzpXyvkluDdDXigcYkG3SiLEqoqy90Dtm+r2dfUtHOIE85jc?=
 =?us-ascii?Q?Th6p59FKaFgIYFumPz3wsyr2ndlrqYSW3hkK0EdemfVJxm0xARatqJs8yWjp?=
 =?us-ascii?Q?1ACH7BDSBmJF9Y4P4GL7coKMCUy8oQizBUA12JpA5/dWXv4wXZ+YAATfBjI9?=
 =?us-ascii?Q?vmg8HB2JH6jkLQTJWygTj9XM1AQoIuWuCFZ4BxeSa81vMbDNcAry/vtDJ0qT?=
 =?us-ascii?Q?HlX7W9dCBQiZ/P+ar7I5pepTMW+0qFzCdcAs38GRjLM8sjGxL/qKuGO2rHKl?=
 =?us-ascii?Q?r7hdSqtsUSJO99Mlf+MBEZ39/BgQi2wR4yDdl45bDUBuFevbmiPJZEcpQTaC?=
 =?us-ascii?Q?qOdPynQlWvB/8wCWZmpPe+rEBMRoNmDP2WpSmDWgVTt5WVyfucMZpWBbfKU3?=
 =?us-ascii?Q?VGGcxATOq2KVSotFGKyc5BWnplkg1ZhVLUe913+C83MR1iyI9Y3CCW9Szrh5?=
 =?us-ascii?Q?C/4jtDI5dtOXvpynd7WDVTT/eArk89ZTBGmYI+LDtwU8dJLPmQ86bP9jVTk0?=
 =?us-ascii?Q?BkpIrinrtat31mZbJ1c6PURIcAbN1Mj3BwoxpISg06cLeFn/0LnE7D/TicT7?=
 =?us-ascii?Q?lwjRlwmsrAYK8DxQ1mUp5CFCf3LJS6jgZ/T+Gv1jR+S3eYxLaZzaDQ4aZZQt?=
 =?us-ascii?Q?P1QOY1ftWH9Xo0JonmGHQtgxynL6WZfTlBegO9q52BQVMyqfuPuhbwpKDqnl?=
 =?us-ascii?Q?diogWC330f+e/bAE06zHA/XklBvkeT+TYThf55kUBMK+caU8R6fquxIMnNkj?=
 =?us-ascii?Q?pDaEXcNoe9au8kpTuKzW9BQ17g9ioExYkwmyCRVlcfMAt60oFr8IJBl9Jh8J?=
 =?us-ascii?Q?pr7Gk31/0rCPxKyu0CEFtgS1zV5M+sVFYkGekdMbwTi0aixxU9igi/uEmrvA?=
 =?us-ascii?Q?mYVLO6Ef6m3MQ0o1zZTaVAyuZf1e8unvasY+ZyeaJdNh+RM1ztBT0kylGsZo?=
 =?us-ascii?Q?9ONiP4HcZXnr+4Bqxwe737m6R2rgw+N+IdtRmWh9Ib2BzD3KZEJHeBnaS60W?=
 =?us-ascii?Q?JGr6bfpsQayPKUtU4m/6YM3VvKY/hyiZac51jBWkaWAA3sC7xUgx/44y7+d4?=
 =?us-ascii?Q?WbTtSKMBQqZBNGsQA2HnVM+LJq760SyD4ONUpoGzeqEKDykLQn4dLcgpMpLy?=
 =?us-ascii?Q?YoRcAcA/TYH11SgOEWzzR6uzYw31IukqKg79rjyI4pckQR5SEoQqqauxnn37?=
 =?us-ascii?Q?bXMepRv9xv77CJF+Rd4wZ3vbQbMVivaApcFtuhLIi6FPVIRBWWNazmvaCMLw?=
 =?us-ascii?Q?fIwlksVmAsIEyHEcPGdPtGaO+1msvvLvz/2eLvqFLgn86yJdxFJG2rgnUjW+?=
 =?us-ascii?Q?3F3GkodHKoFMfi8avHOl+HCW7wCvt+I=3D?=
X-Exchange-RoutingPolicyChecked: 
	W6eqWgYgjRAFPxFRTn+rmaSDu5mONSc+V4W2812KkdMHrbiuLZpUf9ZBACKVmAxdqBVW1Og4cObg47Y0cCUhXFArUa4H2wUgPvAQ0+Gur+wQH5uMkM3jO8pEjgHa/BSfhwVGGNRyLtXVvePOAqHLncsUgckkImMAwoNfvbNKpbeBgqTh4Mgad9XCvPkwOISfjXKWr6K0ngaKGQOfpcSWnLE/83z3OoadKVMjA3PnNTnR2yD3c9eynl8X8fyHART5kG5DuR8hQs3RCxOQHpw4K4oIBrW0q7OZMjcYHQyIg9XNJBwJW5jUiaWhKu+dZ0i6BJxj8Cl0y6cIQ6adAWGISg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f8df5c-b273-475d-dd25-08dead8a5a76
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:18:06.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOpDt29r9ktIpOP7NGxNTAba8XduAnmtR/Ffn8QY2Bj1PMoGAfQps/4m1QiVK1iNdBG3ZWCJRaUbKk3DrkuwoBrui0gpfzA3R8wYY+oog/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-Proofpoint-GUID: sK99nroRxexj0bEAcPy9pDsx0Yiqw66W
X-Authority-Analysis: v=2.4 cv=C9fZDwP+ c=1 sm=1 tr=0 ts=69fec395 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=SsMK-6ewAAAA:8
 a=t7CeM3EgAAAA:8 a=o8dCtG0ciBTDBm6uPjcA:9 a=49hUO6naoDravHwzbBTq:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: sK99nroRxexj0bEAcPy9pDsx0Yiqw66W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1MiBTYWx0ZWRfX/yAfHELTie2i
 T2X17RGW9ADBgCfsZYMQI98jAz1oTL4w1FKe3SGguA+QI6NSB0gJGwweX9+PiyXLmLDfzgKFBng
 kr1USM3tkqt1yUxAcDkKRMnWPQr+bbXg/jAyCFLquL6eY7UatjNtVl1U25RRMXCtG1kfgwGjgxH
 D1Rg95+OLdDwiJ//onYetjC/ztSH79CRrRf1yMukgr2B5hsavDoFc8DrpSG1fnGvPy/7SGIvDZz
 /odyyAwpJ0lJtGdA3y1P7ZqOyUqstE9FcsKipS57LHVYqVC1FcA4nM1POKEWi+u1AThB0cxspB6
 ow2ZZGotKJxoCRT/lJBNg2QamkASmFrP0X8lD8iJMRiplIPjDwp+RgGTjGercGxY9jp6zH/D8x9
 35UVIyY2kLX/asMDF4/gSkcPvup3pHhyRxk8b/SQJRWapGQgQQGHoyg4f2fCTwReRcgKQr9xtCh
 L3M+n1GVpPaiO01JlHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 05:18:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3957

In order to support reproducible builds[1], we delete the RECORD
file for selinux-python recipe, please refer the details in the
patch comments for the selinux-python recipes.
Here we do the same behavior to keep the solution consistency.

[1] https://reproducible-builds.org/

Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
---
 recipes-security/selinux/libselinux-python_3.10.bb | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.10.bb
index 98296e1..139e6df 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.10.bb
@@ -53,18 +53,11 @@ do_install() {
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
     direct_url_json="${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json"
-    oldhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
-
     # Fix buildpaths issue
-    sed -i -e 's,${WORKDIR},,g' \
-        $direct_url_json
-
-    newhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
-
-    # Update hash of direct_url.json in RECORD after build path was removed
-    sed -i -e "s/$oldhash/$newhash/g" \
-        ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/RECORD
+    sed -i -e 's,${WORKDIR},,g' $direct_url_json
 
+    # Remove RECORD file
+    find ${D} -path *.dist-info/RECORD -delete
 }
 
 BBCLASSEXTEND += "native"
-- 
2.49.0


