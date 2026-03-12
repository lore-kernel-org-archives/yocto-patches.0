Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CBFED2DC
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13963.1773287567664955618
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sbmUTzIk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3obOV949469;
	Thu, 12 Mar 2026 03:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=; b=
	sbmUTzIk3O2moAVceHEOZLsfEAF2yB8QbCyvO2X0NZTa6SK5OWN4dYalxfgNoY17
	Vkbv7cDSUU+8YAdJca7SDrLYYlARxe2I01RP27xKQF5gclkRHqaUXCDKOLfFOAX7
	RfGTDUPxCC4uBBhoVICt0/+reBBGEwuGwYX3dBN5VLtE+ClnNRs+7VDtHBhzsciR
	Qz7dI9Hc/Ybe8am/PW9S9BDlWBRVi0U4ECFziY8mV/YZ6aYDaFOJVG6S+flJy/hg
	cIX5Hu+BAPP872SwWfKeIYrG2RFDOoinMRLroDnfzDTQJ7Ra3ADSAi6sXk869Qk2
	qXwC+PwBY/5tdUQK3WwVoA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t879d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw0C/00yGdkVBAeI2XJ6/B2O1teHvj70luv7c8lb/yaKyYERiIbELoOddaTnvmOWAhcLZ9cwmXBPmZvT9RcskM0PhBlXdU7NeJumGEjrn2e5+ZHjkEW9e2dq9M1fr1NOA9W4lwJRBo1hNaEQkJDP8dx26094BeAMY6dhEwyZceR/LnhvTwKWXbSKLanlbCfB9ACgNSJGE3S0YpJ/VjISFikLkaNHmkDcfkROZQFAPqLehsQNDRHQjrLZ2twAdITFnWyokF8o+vCLFZMO/aARHC8KvSWhnZPwNhhD7oe5nrNqY/18SqvAc9hX7xuH7HOfPhSSYvkhwGHJz9v6h4Zb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=;
 b=OVoLIZf5f9xBbRmYn+TlhnWFqlQj8I/Qy5Zb7OGhr35dj67QrzzC9eo6C/ORzNVTlz3CrzZPEUB3jn5aC71ax5HwOvXczcL+Ikxp+Rgj1RK9yAh2OzKGVM+sDINpzaTHdDU6MGN5eNLGlhrad1QEJPFA+D2h7ce6FV8DMy3Aaef/lx18l+ZifuidC7x98Cqv5u70Ho6oyZbodw8D7PGmPvaL7v1Oe6TGE8G0nc9nt/TZywl7LPNVCXT2p5f5XWm1KPJhhgpFngDkZUjO0oukOo8RxbKuCCJSBmLbiyvWqlrD2cT0QKv7R5fsegDgn3Y26EHqJVR3Sb0/b5sQtjUDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:43 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:43 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 10/11] upgrade-helper.py: add logging info about running bitbake-layers
Date: Thu, 12 Mar 2026 11:52:10 +0800
Message-Id: <20260312035211.745546-10-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d35f253-3d64-4141-060b-08de7fead0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	AOR7/r4JKg85BTbThZUfdlsYJoUOP4Hz+Yp57dW9bwN0tajGLOqSZz9cxJW2aT2YEB/qkX62N+Fnwj+OQ4cylmTdYzvKOGedjMvsaBlapnRNqSkbTxStciY1H0hHtPsDggKaiqC53EfxNinfNVTW9EUcJuNx8brbouuF3g6cbAy7v325WqaLyA8XLUjVshis0z0k8JjZHZs2p5VQ9jQS0+/sTxOBFDSnWVP7Oopx34liZetxMF3LodBG+D/tgExW4zV6wOgrl6/lLvZMLMxopD6q9dx24aZJwRDMPGqmzrDFBUl7vRwYm+nbKUnv0PLbVdyL2nkVLOv1czr+KpJqO2VtJ42bltFieh4J2gn8Hrdq/8xsXOC2XF2yFk7GfNpPT/GDtS0DLEAlcgWjJNj/cCxJRozBp+SJ836qqm8W7yWZ2/vlbAkccV3ZqyBSZY43X41l4ZjSWIKYQIlpmVPIXI/gTPw0v26iS8+bWpk7qNcTqnFLJo/euQPbPoiECPiwR0h63HRXpwzTimLzj4kq5eEXYZDSusy8XwTMlHBVNWc6QY9HtH08XVKBEPtTpRvW34HFTdnhq8neYt7XuQVfneCKNtr4T7+qpWX28TaGZvpzQIp2/O99KuzyBGQZWuuZdvlONeZiLW3a/eSvUkxcGgl+cZA5XPStnDw9pkH7avuWIHg3UVMt/P3boFRUKLf+EEm6Hu4OYZQudHhKueVy2hgMvHS2o+O1uheBwpnwW7Yr3m5V4ZlHXc/NLjCNTrD9HN1R//xj5aLOeTqr7GewxY2molZddpSJYUJWp99DkMs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OtPGpLdx2D6LbGwsKT2wBzc3uKMp9yRjpEyp6I+jdiJBf8J/FAolJvkqqMTS?=
 =?us-ascii?Q?8lP/cWEpk+BCgNTG3W0VeJ1/2/1PQh58LqxsOoP8V875/UVw1OR+KdVqmLqn?=
 =?us-ascii?Q?8B8U012Le1pdZGEYLL65WZY9xGfRIGIMk3S6w1usajvctIqftS9F2uq486ZC?=
 =?us-ascii?Q?DYS0lqcVqudrWw+z5BQLzfB9cCOJ7f4rEejrXEKtdcRZaLHEIdyomNzE+Y33?=
 =?us-ascii?Q?M02YXWfG1RBeOZvqAjNSskgcgD1VzyryoYPWjTmWlqNTX9WUsT+b6ZFlw1zH?=
 =?us-ascii?Q?gK2zpfCdwH2vjNLPmrE3AIOIpovo39x6HY3hapkvzvTmwa7qz1bj/Dvi5rZV?=
 =?us-ascii?Q?+zmRKkPzcD7HajWdkZWfdZ43YjmpGnx4iS8pDOxqWUDLfRpe9uMSOuyYKNsr?=
 =?us-ascii?Q?36tsORLX+KCRAqxvmmE0cJPHcRu8aP/jeZnuUQvW1I8b/Xh2fF9Dwu/xH6hL?=
 =?us-ascii?Q?T5x6VqkyP4YGMMq8J6GNVvDdtYKyxSmTm9yRt46OLlvHFoGgEzV7WblwGZvV?=
 =?us-ascii?Q?4NsZlwYno/KlrxOzU4SltgTNoJnyBwCjYigJaDhrkn2oako0xca1xlHSAmAZ?=
 =?us-ascii?Q?xn7OFjgQmJzdGhvZV4mNi9JVsqLWI+1XuVj1XdBvdhcouh/wCHk+pgqwZHXM?=
 =?us-ascii?Q?slPtawixpfW66ZG7dPP3IBzuhsoF81US6WLO+xbajgEckFHPd6NBKZjMXUmA?=
 =?us-ascii?Q?ta/69qqlfwTi+zrRI6+q/0vE3ARhWFiEMmmlvm4AK4pHfVPXlPCq61r+d/HR?=
 =?us-ascii?Q?Mx3UP7e5PvF8zL0CvhvueUbDd3bywkI74S2nXLhhabZ3yfiLZodYOEv8gMPS?=
 =?us-ascii?Q?oF3P3SFqlp6P/97jfAbyumilt3Bt7Wboi2BM7/tHBfMS5e5SXUNOWpyss3Kz?=
 =?us-ascii?Q?w4SklIgQnyyT2bJIBm9qDli5sCvnRLakdsDU4c9PgqLNRd7aO3ZMwwNU4AO0?=
 =?us-ascii?Q?I9A902p8BV79/ptLS8irKcFIK2UAx8vceztOTN5ehL+EbMdYtk72vp95TDEp?=
 =?us-ascii?Q?tIDPApF8lukfrmx8kVqvsV96lSka7KWOAGspzNrKRbvkkkZ4wMZTGjfHbsX4?=
 =?us-ascii?Q?yxED9XzET4wZrapIV4t1rB0j0sK9uEMgeuUSVl4+6FW4WRx0Yvzj9kc2mnC4?=
 =?us-ascii?Q?V6zGmi7aWrTzPUwWQYUAjfPvaCm0ZccBxC2IMOsCH7XpvL/3qDfka51VGvW+?=
 =?us-ascii?Q?uFZ1gE6Yz2tsZ6GrAoUtj8nM9dKIi7pegKlQVuPDJlYKxicXn4gL4iBVq+qr?=
 =?us-ascii?Q?+htB50TMJAA4GoRxoLnu9NN2WG7za12NncM4NNSQEh4snwcaEUlAZDWTkpb9?=
 =?us-ascii?Q?UnQB2GcSFgCPtB1Ab2a2mJMVz+eKxhSfmAHMY/b+Hd4mTXLzPaYxlebDlCdS?=
 =?us-ascii?Q?x9T3KduZunBaXTwCnw6/uTR+9m0ouK8pADi6SWeDJ3UHEkRClD4LBO4SGS4R?=
 =?us-ascii?Q?BNuMerVs7dOlzsFcqXu9GoxGZawrrHHUg5yv6S+phAtb1ASnnIKu3Ky5USoI?=
 =?us-ascii?Q?CXYnJBgtW4j/Oi6F2moBG64K0lt2m+ZTOulqAMX2KgfEePbK2FENSWrzd5l/?=
 =?us-ascii?Q?SYXzOYp/pr5YBE4rKRRsbXaPj2xrTUdzTy1ZaKIflaukro6BXrPUW1YhEefh?=
 =?us-ascii?Q?jQjTHpm0pY7qnWUoz1uzvK/3Gp2DwJmTagwT5T1uOu9L9DbavmAjU1x1JZpF?=
 =?us-ascii?Q?Blr7EtFLnvfRzKuJVcyifAmawXJrJl3IMofAzXOKUvstvgSFn+Dk3XM1r/lY?=
 =?us-ascii?Q?qA4I/HEYrw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	kO6yaji5I5YKzJAKRKvSQo8iQIFFlmZOc3FOhZU0qwAbRH5OvtIkIDOP1HeckJDdojNupOH93D0bO4FRCpKRkwZQgw28CHvV3s+8IoIg0Bx/RV6wn6uYIb2c0kSB9HJpFqAmyroNH2/SNucUkrYEbU8PI19321U8+9tFg4x4y+MzvRrC/50dxoFwpUpXTXpL3RlkD9OioqeM0kafTmZMfGn61NAZx6kb/G0MpS87MYW/A4YIYd0J8j5bfdIqFdpxYxjD0NwYNKebybBTrb9ocpZr1JNul+5u12M1sYpGgO4etyH4/5oCY/6jK4EPgN0VNeqPu7CARERoI8IBnZkoBA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d35f253-3d64-4141-060b-08de7fead0b9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:43.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za+7Lqby4ZwuwFxv4ahxuJFxKUweXwBRJijr6YCJRCgl/8GjoS5bQEwcnIwWiBImiVYaEA4u1BiaRJ0RvElmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX+mw7AdBfvTPQ
 n6XiDoT/YkduXyG8fQTgK+Ie7t2r68bT7g+2k0X9ro/FTW6M8c/33zka+oDRlTR3s+zUnagtpDk
 xzCdzb5MF8aL8pIysHq4xuk6uJ/yX4PcSzB9CYsbSuiiwFUSHXtpaY90O8Y5Gd2k054bX+Oa13a
 rD8C2FFqaTQYcAVL3oO8BQXeMGRl3OgvW7/94AaLxil2rr6anp+1mlru0ztrP8oir8MO0BURzh9
 bMS9QDR7zvsvlMePx7enazVlFc/26IDHOqEGhEXeVoBKY8cwETQsYkmd2GECZsWfCtbB+g5r+/5
 EWUAjw2hAPi2Hmg7/QdtC0ilG4gsyhwpMNlkAqwVOeEC31HbaKv+JcaMzsiE6ccnoibl54dlxoj
 pgn+Tsie/wWy9Ge9gJHx77y6EwxMXinudsQqgB+Sk7g9fJwYhlE2SGe5HNq2c4P4To3BFYdkNRK
 9ma8YwULzgYv0XaR+KQ==
X-Authority-Analysis: v=2.4 cv=LYoxKzfi c=1 sm=1 tr=0 ts=69b2388e cx=c_pps
 a=yaJUXpcFNTkE3gTvo4ZtIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=bmEcsPE48WtV85cMDF4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 5a8KAYjEvojWo276sCMkxrlPoOGdBFLG
X-Proofpoint-GUID: 5a8KAYjEvojWo276sCMkxrlPoOGdBFLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3447

From: Chen Qi <Qi.Chen@windriver.com>

When layer mode is used, 'bitbake-layers show-recipes' will run.
This usually takes several minutes. If there's no output from
auh, what people see is that they invoke auh and it gives no output
for several minutes, making people wonder if things are stuck.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 8589f8d..7edb6da 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -619,6 +619,7 @@ class UniverseUpdater(Updater):
 
         name = ''
 
+        I("Running bitbake-layers show-recipes ... (this may take several minutes)")
         output = subprocess.check_output('bitbake-layers show-recipes',
                 shell=True)
         for line in output.decode("utf-8") .split('\n'):
-- 
2.34.1


