Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34AFCD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:21:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14744.1778167302605238750
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 08:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JnVgg7vV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9587cd6908=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647AObYB1489908
	for <yocto-patches@lists.yoctoproject.org>; Thu, 7 May 2026 15:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=bP4ajcxQsZSsh3bg9oq+
	xD0XsIc70Gs5MyETWcjuIbs=; b=JnVgg7vVgd3XIJVYnDUjFx5VYO7dVLweJfaB
	kXHldykZ/bwen77Yu0YQBPNswP0njlYnqa+EHQXqGK2KHp9vox1Q9KlXPUBOFI+m
	+4DJM+7brobHxgGMmfISYNb0/Gpn30zNCE8xytMJ4fp3UIkNXAotphu9taTYMEnv
	d2IpV2jHO/kXlLGT76bD/HQWB0cACwd/09ppXZsQdnRhFmjxFhwSLvcISMJB5XC4
	ryEu7Wi8ADMxmEr1AyMRe4fidpmp4fGiCbboal3hzlHTK+KdI20SL42UQF54Zb9f
	jaKqVnh/mOwK1GAdjDkpthvOZ2IxVSPWGBbiKuQQyCXHQwzIIQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dw8t5xq61-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 15:21:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm+lmJUjRN9FHv8kdtrGRUkjX159THPEN8XtxWj8GJClFXf92aHxEyfWANh3nIO93PHme1PmtxgS5xAznBVp1hm3q8SOnzJgLKvIrsxmTJah2mWtzbd35ILiCLiH+H8E+XHWvuMH4UV9deX7N/yp2wIYpAlojKXEJB9nwyogVRBic3b6M3EysTjemVUHPcUL2ji5PD6yOjFijfjTYhgLxilZ8Hykx259hS1ngwnvH18rsxXryPxb7d/1Yw2DFCEC19GeUggJh5wh6AmCYflPS80SUSLl1J+5BTMQzP+CZNNyxDhegRw7p8/dZZ8nRRTn8RM4yDKIA1GbTwmAZv6vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP4ajcxQsZSsh3bg9oq+xD0XsIc70Gs5MyETWcjuIbs=;
 b=MBwo8r6lFwKVvdU3m0tgJ80eLGV8J/wvk3TNmvmSmMCD0/CWfo+h6ir9tN48AtHhe4m7Y5MIgXeQ66zbtr/8lrPN2cITX8iCbHFQEFTolnUCGMyznT3Asf3BSf9RJ9+wC6Dz0wiYt8fhx3xD4Zc5wMU/+FCck/YBEdvaX12u1fK+1cFcHT7lcK9gyRduXc5Y9qIcZx00JsNc47x0HfHyx3JV7tOiyBy98QqAvSo5TjvTdqIonm7USrozY1KF283xqoA9Hz7a0yPJtlhV9Ms2niI4tgQFioQNwuTEgpXpvhGLbztOe6ikXxy/P6hhMSJkGJTj4TyQsxwhOzYdjTN6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 15:21:35 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 15:21:32 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] arpwatch: fix typos
Date: Thu,  7 May 2026 23:21:18 +0800
Message-Id: <20260507152118.3202686-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::8) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9841b6-07d3-4da4-9218-08deac4c51ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	4oHU2iQa2QKeCBhygGZ6J4Aog5yqpFEvn5wZE+G1KvC68MutZ+l4wXX83YEghSD7VraFGf6HTjYR9Ufhhw0luLKMwxW0n0y0ceJU+ouGOn5q2w/PDLTp8sq4R35AmXY8m0efSu+Pu9mMpsSOAJBQuWKDXsZ4gugZ3WDKbl3i+ROT6bEOIIAbHlDEqavPzIzZ2x/uoYgS6Ua72xvWk4iOKpgp1kYobip5g7dSPnZv9SIjgdbGXjUQZ3uTsUUVb6c9/bjPh+KHwV980HjDPY+/KMTQHpNwFhtq+Ec8wg+7I42DLWhLJqm0q8Q7uECwtkJTST5IqzhRag3zyyum4fZMR79MokZIt+jPjXkjKFikvUQdWDKXueMm+LH6Ho8hvNd5IuYKEk3qPQMM/LwuIlVNuYhp6oTOIPUmxcAIeKdfQqzMJxSEXUdLvimguSPxxBk46RhNaitn2OWe85V+M+9LALw7O/fBytsL+fnBG70VBPjuMRX+JEv3qOgP6zuG9qKOjPDy+ERVHoMcf63NAoeczUGKA6tB+UNrPPAi3a95R8vae+87+sYVUPG0W2A7LKJ7M2XW4vDovwX7Yc1/zf8fCkRz/E5Q2qx5qFz8FG2Y0dGTrdyHJjd4qMDIddnRY5M6vQ8UaWeXneyYfnrUdOWCtbFt85Sg4w+Eoy/Ut7CDuYAGMn/eZ73731Mr+XfsAIno65oD0pPAE+B35c00NGHMb1d9jiVO43HNixPbZUqFOfr4aHZF369mxFTwfm+RD+tW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?koeSlDGwJf8IqDZGBa22h4DmoiFLmDrRZQWM1N1+oYjds8qnzNMfatt+6SQJ?=
 =?us-ascii?Q?L/Zrh7zqpe/77nBA36EQCOaZC+Lb962YDnkLwnmEwhyDw4X2jT8QWtrJz3wX?=
 =?us-ascii?Q?g52xqEZcYkdivT55Wgxmx2jrFa/FaQQY/F83q+boS5PMlsuquCL/q1MIeT+5?=
 =?us-ascii?Q?yundR9Rbrjkk/uJiwSL71zT1Enbi6pRyuufePOwgJqeFsmuENri18NQInmli?=
 =?us-ascii?Q?p2PtJFApJRx/FxzDrVWcA0x1uMj562kDULqFeYsdkJVVXShRzhyMGsdjHI2/?=
 =?us-ascii?Q?OyMW0RzQuWlNfzLajUkf7MyCcfqGSGDcjswk1QeXYi0ZttMgz7YxrtgNIrCb?=
 =?us-ascii?Q?mW+w47k/E5l/AxSXtQb6K+BtyMDUujOMHmYsKydYanLcU9+6wC6UZMcJS33h?=
 =?us-ascii?Q?F/sHM18sY7vg3vDJqK96Yc9T5L6eiGMKN7rsLYTMKI+P+w8V3F0QkjtoYmRq?=
 =?us-ascii?Q?3S8qcge2VTEd/O7BfuJuJK7iMiQKfQlQTk66wPmJjVZG/UuMttGEguL2byh9?=
 =?us-ascii?Q?pUA1VIf3tQcbns069JaDDdgVaE4uI9DsgATrK9rrz28+YabXJ/+MgKrgXK46?=
 =?us-ascii?Q?mav2o7aanSBag5wCKTffyFyuewfjnx/4byffq9bV0oCr6Aa2vjvVExGNrm+a?=
 =?us-ascii?Q?e3SDrvhAU1AzqXV4RN1kQku5g0n2Bszf0i2br7I5yQPcYCtJ9Tx4PGI23yuy?=
 =?us-ascii?Q?QxDoMgp8G2lq+gXGwEU+cYXKN+UOwdmGfan3ErJ9tinNnRqWmJFHtWwXpx4x?=
 =?us-ascii?Q?TtjoVM1H5VLcBEz4YzY2l0pD84deTXqPYNQh/lMeF9bAUWL2IjqmS9rhDkoL?=
 =?us-ascii?Q?L1MX2zE5Yt2AcT2ga+6jscVlASO1M/N3SbkPRGyVo3lEsvCdYho/qLJb8/6j?=
 =?us-ascii?Q?Zghpw8dIie6OfVVjKTF+4lnsi2vWEBbCBTMrTzp7vGvwoP6/S2CE63AmZjks?=
 =?us-ascii?Q?90T+k4e4z7RZNvIxo8zBZBq119TfPwaBph0kwJzSbuc2gDcHW67gES95hV8R?=
 =?us-ascii?Q?jE0mvxn+870S4yYK+fob/hoq0sVqQTD00Q1/rHzuI5tepxEnZNopaZh+7sdO?=
 =?us-ascii?Q?IWxnOGo9nlNvMgHW2IQMb96PvH/Ws79hnnly/rP4cvVmWKybnEXYNQYx9EtW?=
 =?us-ascii?Q?K8kYiuQR8Zk5mwsRXosQ9Y8+Q/75961t/DL461VY7/Y4jnZKJb8Racn0L8ud?=
 =?us-ascii?Q?uV0/QvnAH1yNhYx8MtDrEo0U5u3GjcAzDN3uJ05k0TYlSw84GMxXOhjE3rQB?=
 =?us-ascii?Q?w8l9I6HQL//3w9NsZQcsWqs7vv7lyrguaM7Ztt7ubR01z7qzk+ecR3UkOX0L?=
 =?us-ascii?Q?aPr7SiD3daTdd71OMvZe/Wt5/Ixyl1v6O9eWDoUEGZZcUlA6emoAHZwB4/y1?=
 =?us-ascii?Q?Ky096qY2o6WYDpeAPUvpK9UpF/k6rfFDxSB7strCG2mfGq5r/76fhjhbFgdK?=
 =?us-ascii?Q?6+jAEAcmkHQiMCpFH0xJzox71EEQJftSO4sA3QJa1xINaF84YzGR1pWnQV0/?=
 =?us-ascii?Q?naIRmEv9m/pWga9MMRPE71Thqe0ax/3iMJoRtxAHc/dVg31lVxKB+x4z3Vu2?=
 =?us-ascii?Q?kbgo0QSsJq43xbeYK1zr6DsYusVpU/wyCUpToB+X+7XD4rx3C5EYday5VwNa?=
 =?us-ascii?Q?hGuBimHofmFRJkCg9fvtWJbdWyLTWqaDBWV7QyzWfcklezkoYm0kgspys+WY?=
 =?us-ascii?Q?41PjF9GUayKcfkva3IGJ7JlqrvFya5WFw0+VBFhZYfcQX6PlcmrRDln6As7W?=
 =?us-ascii?Q?Gwc2EqJoxw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	oeuSDff1Nl1R4DPdU5+w/SNYVfl1xMF0DVkUIZWNVRItSrAq3fSSzLLyB73kdg7NHLMOpeiwpz/RzjL2twVORRekBEthX6ZzTLNAgQ8Z1yyzJ+13P540RT8kpH6a2DR1GJbMUSdgDgBSdB3t7OIB+ptyxL2rhKxqFkGwwvwTERJjn7obv0CtTpHVhQQUyy4yeTu4CU0+OHxeccavkdJ5FvYVaP7rSTAWKaqZ/+dYtgMPDJL14AUWMiQzAJJ7h4FZG2wGk6m7HMbNx9Og46PHmatqMl4oo+0PU06R1C3wklaDbG0Mn/VqkprYLjSigBcrNQFE+u0LP7/HasTAEmyHdQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9841b6-07d3-4da4-9218-08deac4c51ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:21:32.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IIG0a0popBiQlhdk72UR/U1wuTd2olkFBIwbULRmpuRpFG6B0Cg6/nWVBzG4GHWn6DqmC6jm6JHKMR5gONmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MyBTYWx0ZWRfX0XmGuhDo80OO
 Sm3f0U1eGirLpUbl6OTx7P5/Fn625sxN3SkeyaQRvjWqKNpjSdfQFVWOqQmM3gveXSjZfv9VKe5
 KfBLk9ItuAW6xxUy4fHn31bmhqMpO5XuhxBQyP88ZK/Ai6DRgxF6glX1Esqu11APBhSUtnPi3dC
 bcY64Xtc8W9RpRs3gspshgAMiwHYhiMpWtbclOYFuWQM19DP2ZlnBDNQh8Gw7zaz9Dfv/Cb1qSD
 Ac76ReJ2n0aV0bG+pX+rIkkZwvYr3P5ewPAndWmywjdTwyId097ddfGoKJgAguU8b7qg06kQJXN
 tQ4vWU3ISgoBc76wTaaModuH+1oazpv3QRyxox1fKmzROuVubyrJt8XqBgHp3R8giWcg4wMi9qX
 Eqd3KyzOYTKZB6oBsfa4k/eY2FOhfI4SYggHvfoPnCS6m2DDYwPR5XfO+fq99Oaw3TUUWp8lg2/
 oXh6nVzkH2JFU0ZVCIg==
X-Proofpoint-ORIG-GUID: JYJdN8rPIyXuAAghj92f7eCLygrMvNsU
X-Proofpoint-GUID: JYJdN8rPIyXuAAghj92f7eCLygrMvNsU
X-Authority-Analysis: v=2.4 cv=BcLoFLt2 c=1 sm=1 tr=0 ts=69fcae05 cx=c_pps
 a=XjJJ5mbNlFGUOIV2PhjyRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=gNY748s-8Yihb4aNIn4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070153
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 15:21:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3933

APRWATCH_FROM -> ARPWATCH_FROM
ARPWATH_REPLY -> ARPWATCH_REPLY
CONFFILE_FILES -> CONFFILES:${PN}

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index 3ab5993..bb9c2b5 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -18,8 +18,8 @@ inherit  autotools-brokensep update-rc.d useradd
 
 ARPWATCH_UID ?= "arpwatch"
 ARPWATCH_GID ?= "arpwatch"
-APRWATCH_FROM ?= "root "
-ARPWATH_REPLY ?= "${ARPWATCH_UID}"
+ARPWATCH_FROM ?= "root "
+ARPWATCH_REPLY ?= "${ARPWATCH_UID}"
 
 # many configure tests are failing with gcc-14
 CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
@@ -27,7 +27,7 @@ BUILD_CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaratio
 
 PACKAGECONFIG ??= ""
 
-PACKAGECONFIG[email] = "-with-watcher=email=${APRWATCH_FROM} --with-watchee=email=${ARPWATH_REPLY}, , postfix, postfix postfix-cfg"
+PACKAGECONFIG[email] = "--with-watcher=email=${ARPWATCH_FROM} --with-watchee=email=${ARPWATCH_REPLY}, , postfix, postfix postfix-cfg"
 
 CONFIGUREOPTS = " --build=${BUILD_SYS} \
           --host=${HOST_SYS} \
@@ -78,7 +78,7 @@ USERADD_PARAM:${PN} = "--system -g ${ARPWATCH_GID} --home-dir  \
     ${localstatedir}/spool/${BPN} \
     --no-create-home  --shell /bin/false ${BPN}"
 
-CONFFILE_FILES = "${sysconfdir}/${PN}.conf"
+CONFFILES:${PN} = "${sysconfdir}/${PN}.conf"
 
 FILES:${PN} = "${bindir} ${sbindir} ${prefix}/etc/rc.d \
                ${sysconfdir} /var/lib/arpwatch"
-- 
2.34.1


