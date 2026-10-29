Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12547.1793282251968309360
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Oct 2026 06:57:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=BGox5WOi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5762ce2ea8=sunilkumar.dora@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCbV6P821253;
	Thu, 29 Oct 2026 13:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=LlfJXbfdA
	hpOLjEyK4nJmEWk6LxPTimroae8fe6uq8o=; b=BGox5WOisH3NKAvWXsR+Uo54X
	xjjs8jzPb875Amrdn3AzkWZrB+dRNVZFa6cnl0ngwCX/QtnIhDo+h9ZZ/k1OfrW5
	bJNgH5TPeyG18DOgY4oFWXjg8viUyl2rFZExmqcHk5yNN8M9FJGTwARRsgURKK8o
	59SUS48Z18YK5eXQhbCsUPc93N6unnbq1kPM+7oS14Bu6qiZAVMIvidBSa5pIzd1
	7cublRhKx82f9aiS7H5b72Fe1PG5/4lXEXbbmMyqPKmix3/9yLwWtN4DX4tLsuB/
	dkdosoC2wz1zqfDdkCpy+Pxg3y2wvcAtXCm0U/2v8W7UpkWB005gKS/ujVaiQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022099.outbound.protection.outlook.com [40.93.195.99])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hkhhmtg8f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:57:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQo8cR0jQGKD+oo0VWkArlMylN7fGWEiPWZtWhZ4BoazmKMqSCuBs2kX0zSDMXDpGllLY+Q6fCbC7AT6qDIaF29sgHhpUMrjLk1iXRnxexSb3jPaoTePPWBZC/nY86t8PPMX/0HyWidez8vuYs26CMzekBhgyBmhK4dKzj/kPIH8OFR9Ifgd/xkTlSMBd/6VURFt6P/W7u09geIQ0l1GE7ruRug005YSrSvwHv6SJHQFfPgWOT3WwgshYJ1rS7I2VmYDqzH1WC9Edu5m71GI8RX1Jg5BtyI1VLDjCBCEcg+f3VStqzAPFugd+65IjjQ0RLzTNvtY+CrA/RwLD+1jYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlfJXbfdAhpOLjEyK4nJmEWk6LxPTimroae8fe6uq8o=;
 b=L4On75eiDc7K3BcLtceXnKbh14JhP3rb0HXB06/AwWMeo9sS1CQ9oDm/Q9rfXAtCSBuLZEPth9BML7EENt9F7+7Slugw48QLjGydywUOBJFYDZXQv87WWD9FIJPDd9KAsGLdrOT0TjR2y6flUdflinDVuNEgiRdgGSo4urms4TsBT26j0WHSIWShS7kLaYiqqkgTZ7ul2D2zF2lxr/gOZF4H7w0t3EShAODYXKjkFu72JLZ83ww00n/dAZKoQ6RCher4N03AMvyRqtBgNXV3qHlhue6r/h5kxLOcW2ujOa+dkiUcQJaqlqY4GQdlHqlVSN9Ozr5eBXS5HK7Tj4piwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) by
 PH8PR11MB9855.namprd11.prod.outlook.com (2603:10b6:510:3c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:57:22 +0000
Received: from DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f]) by DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 13:57:22 +0000
From: sunilkumar.dora@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, mark.hatle@kernel.crashing.org,
        liezhi.yang@windriver.com, sundeep.kokkonda@windriver.com,
        Randy.MacLeod@windriver.com
Subject: [PATCH] makewrappers: Allow the wrapper architecture to be set for cross builds
Date: Thu, 29 Oct 2026 06:57:01 -0700
Message-ID: <20261029135701.300718-1-sunilkumar.dora@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To DS0PR11MB7901.namprd11.prod.outlook.com
 (2603:10b6:8:f4::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7901:EE_|PH8PR11MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: f165ab39-7c3c-4a6c-0a19-08df35c48de1
X-LD-Processed: 8ddb2873-a1ad-4a18-ae4e-4644631433be,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|52116014|1800799024|6133799003|3023799007|18002099003|38350700014|56012099006|11063799006|261028144727099003|10067099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: OKS6vp+9QIAJckmXYUkOjJglm0QOiVzhn1zJtDFkhCB4uoE9WUnK/qk3Dz4Y6voH1pcCO2iWwdL6WhTTCVf7Y6TX1GpVSTkzlOHijLYTX8PH4Aj4HslnhADj9H1WiHI3+QDgPKHU8ZFKXh3BoM8QW4Gx5RaU4VjIwA+RAr+Of5GecoM1QixSl+zfArEgBO3QrjkLrwaotfTUs3p9cc1Fd8BFqs5bR0Rcilcwokod8GsYdtYVqObgfeCfVi1vOa79El+v0U9q0A6CuPE+o8ql6L07Iq0T4+NUVPGwxrsVvPGwKfEwPqOA/JnpUeVoks35UhTpltnkjz4KH/eBoJf4PUAp3TJfXdA+p3WoBeMZlJOGwI6IFrr/8pA9n9qpl5sihEsaB0oJLxNpN8Wx4ANPuHDNlonuo6ydPXXmqM7Ht/rDI6T66a2XF9P9LNbHrkKRdLbBYaiJfgQAVWNb9pPl0vRHDb+wuxRGTcQ3wuY/4SEcv5Y/LCl+srCj0TUWRS/uW66MZ+HoFkK3rZHdAwFvlMtVNncI8tis1uL11dLvhXfAnMs5ROTdS8/LpSZOKG5yz8/NxMzAXFF7PDBXOYOk5QiWhIcDZ35l5GiNeK/sVKC+/rKzBVN9L1PdiuZR4WFpcOVToa1bXzlq8kQy92Ez1z/Nztw8A9b+3WQCYHINq0wbGkNMgd1+VnEmOjTCEHNJWRLLVxZg/RcEEU/C+ZGr7l2Y11JceC2HRxKqqfQDFuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(6133799003)(3023799007)(18002099003)(38350700014)(56012099006)(11063799006)(261028144727099003)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9BMn5T09HRJJV+BVhflM5+2G2B7nyBAyEpm0Ay61HJtJrHmR6NIjo/i3YwOh?=
 =?us-ascii?Q?vRWdSwMXEdOOwXtUe2QnwjvU5HgCVI2RSH/trrOKkjyu03HrdJZqfStQXBw7?=
 =?us-ascii?Q?k1b7dAa+I95Sl2B9EIrAh80uAi19gDDKavYOBUdDvyiXYRsp2MEoeZklZYFg?=
 =?us-ascii?Q?G8YdNqwiujYVet+1BbJCs2jW83sDf1I0WUIZ/L+PCL2FLaMZY5mG6cAFRsz7?=
 =?us-ascii?Q?wjKjcIvLxkouAlulHVzg9NFMVYC0pHOTduADb10LrkmDYIIq/CLhUQ/UjutT?=
 =?us-ascii?Q?k/ZLv25W/+HSJLkuwmKXNG4KVnksDI8aoyfzUtIKlYaB1na8J12OQfXF49J7?=
 =?us-ascii?Q?404D5Hz0PJ7n+8L/UlpFuh7I53SGsk/hd0fUfUEpnhbfTHMf/eQyAk2Ttl+v?=
 =?us-ascii?Q?ABIoXQzASPONj0tqfw7WVlYzCTm5kWvfDfkQTu7SHbikajKhIK4JmQlGlRYu?=
 =?us-ascii?Q?xlbSUMoBufVftQfRaeVnPsdOgcm1Yo45AVM2Gd0IP2NzNTIrvfscuOF/MXSL?=
 =?us-ascii?Q?aut9EQbN5XOb6H8m/N+F+85Hri2yC4jmFjYQyVnh582BrwD2zWPd04v0ls2w?=
 =?us-ascii?Q?vv64nWMfZnFvimZ1g5kbVrFq96SPIn1IaDdU1vitnn87gKsK6GPh/Y0B1FCb?=
 =?us-ascii?Q?khz57ilOlxIZgnjSwN8wris/UHzAENlQNJztxCKOx0P4HRjA4EGt1Jp/q7hT?=
 =?us-ascii?Q?Nu4lEFPoC2P2U4G28c8+AEYy7pTrzn1X2LYP15Itu8KNl3p7WRYxDycdgGwu?=
 =?us-ascii?Q?pVaWxguFx5fv4YkqeWtPXvrdOX6SiFDFy4UAqVh/SqS5EzyvsgxVpNqmW0rU?=
 =?us-ascii?Q?1tW3JND6H2Wa3gKBrD+58nSP/z61Z6sVkWlNJ4shaDAA6cSryofrsccmNlhk?=
 =?us-ascii?Q?7+YupE615Hvdt1cZbaRGB+9Vv1yQXrluh5l9NGkjkHrsYRmbCG2LAhBFlzxC?=
 =?us-ascii?Q?Q5jE+wtBE0N/ejqqinIXL9hNcr+QZgSm6mLdBT+a70azRsMU7EvclFDzkK7l?=
 =?us-ascii?Q?IEzFjC01jBq/Apizbtk5UMwyoyYwv4AYj9/ePV0dbqYmv5Nb0gy1iuLy/j/7?=
 =?us-ascii?Q?GVGAKYM1lJUJdy5/elOBPGjiyvTO4d9VSg3Bvwf+FHKg3tRr450IEbkBue+W?=
 =?us-ascii?Q?mgqpDnCvZ4/V2MBh53GsUa9kQZaOZ5PVP2mQk+JzAb7pKSo4vHWSgxRn4RnU?=
 =?us-ascii?Q?cm1zj0mIca02tElQu3f9pXlb69jzHjfb8Uo50fzxkvyV1jKiZU7Aq9/0yF1K?=
 =?us-ascii?Q?pDoURlxI/rymtnEdig0U0warthLtSYjsyD+sYyxMA9APvMw3ixu1D7lF5dUz?=
 =?us-ascii?Q?emYjjBIV/DG6yNWi1mciNp9JKfg5Qw02v3x57WYtkXAQvuS4lBMLmLDU0bm8?=
 =?us-ascii?Q?KDjVFktqMHIEgdZHlJwhRt/Y7irKNdmPgcPtyACqmGNEi3A5So80LeK5cKbW?=
 =?us-ascii?Q?UyST+hP3jJs839qktJnj+JrrTmzmzrjfDsdsOQrSvbgbn9355i4Kr7aUrtlN?=
 =?us-ascii?Q?nIHzqxqtild3cA3Ltcfn9/vIGJ1doVPjTo1xsVpa3632u1olDBLhbRpXJ3kI?=
 =?us-ascii?Q?pPjBoBpcjBrTntj3rpe26GIOKevjm7yelPiR8rUZirzxhaJk71pn67tCB+hG?=
 =?us-ascii?Q?vQKrkgwFa0Zc5f57uIjQsHnHa0G2eRyeepjbMfzjJfhDua3+LsTd8/1fSg8D?=
 =?us-ascii?Q?0tCyO6/QGb29+QRdX9rupGWPO6ESF76hV+BnYELEP+w8QpWesazRZR72p/w7?=
 =?us-ascii?Q?9twC6uD4Dz7sF+5n1kMITnlU187NAq0=3D?=
X-Exchange-RoutingPolicyChecked: Etf9k2fz/pLxKF1kh3SUkHAdIdGalxD16bwsNZtLL308zYVLjhGVORwteVLxw37Ei6tAfML4w4c6nXFGXQJhWeIeWbrefjk9mrVEt6ZzlStYC5avKkzZJFr3ZqjwIodHcyTXm60RXduOR3z7DKA1D+IXBZC879HObuh3uKV+LjnkeOMO52qZBQyi7sSlyloTOMcmepmQwKi9nUrCFqYrCju0pDREYXGj/5epHC4jPLyw6TMks1vne2r/uHGdCeiz+V3VcmMc7hgpsddRg3hvxuSAn0ADkFK49Hxfrv3CCmw9xqJrLOVE9+6Sd9rqPbwFludeZMEoQUPjRUEcRHlopw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f165ab39-7c3c-4a6c-0a19-08df35c48de1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:57:22.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gOu2GE6/vYNfhMd8OIWQ2xL01wJQjru0N7yOx7dAuY7e7w7rUAph9NEfvc8n3wu68kubnxz4UOepK7mfpCpmv+70smT+T7cswH4sx/7wcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9855
X-Proofpoint-ORIG-GUID: NcWC_ecJvz57EY5p6xs8HNj3ZfzU0VsO
X-Proofpoint-GUID: NcWC_ecJvz57EY5p6xs8HNj3ZfzU0VsO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NCBTYWx0ZWRfXwp6W8X3pnJRr
 Nd0cjbBopP2aMKepxiwwIc1EyoE3xbq704HQtRAU65NVq+XJayNC4hHkKelhl2UxO0eG5ibtc7y
 hLPitqkUbPIJB0VytqXnTaSOf2KFfjk44/W26xmoW1W0MlziPwuh
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6ae350c4 cx=c_pps
 a=QfAu5cRUQmedtNjS8psswA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=ETI6BCwV_f4VujdROukA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NCBTYWx0ZWRfX5v/aD36Z8jTW
 X2d8KR6JTOPYKEaWYdRTcfmMdF7OnfFgNPzlTuknmXk2URYumEwSSsNYxLFzzMqy8PHvmslch0a
 Aq1SkhtecCJBb7TFGsik3YpIh0MIHgYmP6+HL1Dg5JC9VnVg0yqx44owd1MqqY8AkCIhiyTuRjR
 /ayUWnM/okgTnAv8YAGZPF5306ZtLGB1qgBsNmfL5tpeA2Sq0gaF1x4Vif3MSJza+fZ5tZZSO6B
 +s2c04800yPrZfRmqFscOR9ea9XimxHKuf+Sm/A5B2ADjByFiCUf7ibHG2ecTL2VZHJElFsyES3
 4BUTzHtWf9OmsDX2gd0KpYr8b0cdI1FMLaXQM4d+WyUaJghDii9b7uzdBFxtyHM8gskCeLF2VoB
 VXG69xPLvNn0SH7hFmrvece7GGBnr1bmen3itrl0nGYpgILbGGO+bFtCnDNyrWRUvfvrySqJn5/
 dzrQJeNdTzLhiQmZRSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 13:57:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5183
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

Architecture specific modifiers in wrapfuncs.in, such as
version-aarch64="GLIBC_2.17" on the xattr wrappers, are selected with
platform.machine(), so they follow the machine running the script
rather than the one pseudo is built for. An aarch64 pseudo cross built
on x86_64 ends up with GLIBC_2.3 and the reverse with GLIBC_2.17, which
shows up as pseudo not being reproducible between x86_64 and aarch64
builders.

Add a MAKEWRAPPERS_ARCH variable the build can set and pass it through
from the Makefile. Unset, the build machine is used as before.

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
---
 Makefile.in  | 5 ++++-
 makewrappers | 9 +++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 6640a73..bc2ab92 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,6 +34,9 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
+# Architecture the wrappers are generated for, as a uname -m name.
+# Empty means the build machine; set it when cross compiling.
+MAKEWRAPPERS_ARCH ?=
 VERSION=1.99.0
 
 LIB=@LIB@
@@ -146,7 +149,7 @@ tables: enums/*.in maketables templatefile.py $(TABLES)
 	./maketables enums/*.in
 
 wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
-	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
+	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" MAKEWRAPPERS_ARCH="$(MAKEWRAPPERS_ARCH)" ./makewrappers "xattr=$(XATTR)"
 
 .SECONDARY: tables wrappers
 
diff --git a/makewrappers b/makewrappers
index 19508fa..c90f5c7 100755
--- a/makewrappers
+++ b/makewrappers
@@ -15,6 +15,10 @@ import platform
 import subprocess
 from templatefile import TemplateFile
 
+def wrapper_arch():
+    """Architecture the wrappers are built for: MAKEWRAPPERS_ARCH or the build machine."""
+    return os.environ.get("MAKEWRAPPERS_ARCH", "").strip() or platform.machine()
+
 class ArgumentList:
     """A (possibly empty) list of arguments"""
 
@@ -319,11 +323,11 @@ class Function:
             # Strip all leading/trailing whitespace
             modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
 
-            arch = "-" + platform.machine()
+            arch = "-" + wrapper_arch()
             # Sorted so that versions-foo appear after versions, so overrides are easy
             for key in sorted(modifiers):
                 value = modifiers[key].replace('<equals>', '==')
-                # If the key is version-arm64 and we're on arm64 then rename this to version
+                # If the key is version-arm64 and we're building for arm64 then rename this to version
                 if key.endswith(arch):
                     key = key.replace(arch, "")
                 setattr(self, key, value)
@@ -702,6 +706,7 @@ def main(argv):
     port = Port('common', sources)
 
     # the per-function stuff
+    print("Architecture for wrapper modifiers: %s" % wrapper_arch())
     print("Writing functions...")
     all_funcs = port.functions()
     for name in sorted(all_funcs.keys()):
-- 
2.49.0

