Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF53FED2C8
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13961.1773287567356668981
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LROU1etK;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0o2877391;
	Thu, 12 Mar 2026 03:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=OoShnhdaUcYBU9kzOHqohgPwou2yPhwzlHv6mmqEaFg=; b=
	LROU1etKrVlRmwQnfJfVPXjI2uXSAo0ndvYKvjQ1W+HpWSafP/6+xl7d3fMJyxWm
	EmNDRZBkhMglCxJxzTnKegvdWGiaw/i7PI29n+4Hq9YRoYQqQoXdOrcJZjepLTkO
	lh2Q16zJLa6mF1m28h4bS9m+muB1AS310XaInhog3XVZsB9ED6BSPLCKeXMJ/sTU
	RRbf9AdUczhi1StIqbYU3BkWTpwPlL4x/cVjZDBIrw9mDAH/TTUBPgIcGnJdmn7q
	NAvijThkD21Pa8bRn43s9l9rsXhPpM0DnSGLxOnUPu+EMRua5KxlZRoi5uu/o5HA
	GMv/3fxJJkzgxW8LDDLuOw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-8
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2CXwn3t1bvQ0OhC9lWBnGVhpA3Se2jAwo4+f35Kxsv9fh0A0LvH0UOqqnJKhNUb0u8PUeje05uEBKTDDYSJ0pTiT5Dvn/B7iDb5bUH6B5MpB/plEImuhUGe73xG5hcP47wBzoP/fW5IJvgutRvezNNfNa8AoIXiz5Gnw/2Sf6Y2b16LwlGlH4uR3njpJtyjg9LbzutQHOdebYbvMl9cd3JCyj2leFL0sSSF9hz8M3tL3bjxBViRV8bsY2vP4tYiNmLgNfM/qWFKqBAHlDrfzxNMuNgot0dCC2XRBtdWwVdTc6BbVGbYRZUHFK5xYVPnxYyQOZ9sVL2Y1oNElJMNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoShnhdaUcYBU9kzOHqohgPwou2yPhwzlHv6mmqEaFg=;
 b=P4YFpJT9b83yJwXlZ1bdDWpFz0M5A1+et+XIQDNzzbYH9QQ+Qe6fwSI4pra2uzNG/Nnv1X6GjsQY73kRX3yIXEBBWkAF7l9wmbs+VuQ+Mu/n6NZ9HzWDCv8XiOboo0TZVH7K66acme+pk3NAQW9Bwm5CIwahfxGBOUeBRMZ8dSC/SdctuD6EBquB8Hfix5irJSE+Y135uC6dhcOg8F4VmgJ09ti0eF95R4HTGJHTknjuup7tU0FI3yBVY2l5mwZZcbj0KBp7f0/OoKEMAEEVjIW9InO9QwMVCs+QVOaShZfZdf24mldjtuu4A34DMGvbetY8w9FZTCo5fL4gzE/PJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:42 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:42 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 09/11] upgrade-helper.py: use global_maintainer_override if it's set and the recipe has no maintainer
Date: Thu, 12 Mar 2026 11:52:09 +0800
Message-Id: <20260312035211.745546-9-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f4a9097-75a1-4eff-1b2c-08de7feacfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	h/nM79EmsZk6OQlF128FQtxDtvo1sh9EAnIy3yEPRTHIrXH7Htz6rvsQUMf/Z8l3j7YJu1m/ochJjv1OuDWRJnjp9fJjDtlZ5WDYmn70QnZey2ZjJzoNAuy6xBFefOXHTj7B0KFA1wR2XcnEcSlAsVaHS0B71nhmlYnoEfVtsqShcs3PbU/YpYAmsBMBQfCEv5M+ii4/oDuo6k41ww1TJzM4oYG4dghtqM3p9GOdIrtZjvoh0PqGW/+wZgyvsSk3lCz0hm+qR4m0JSW56EVu9I8rtpjHz34jRmoTBnw+HYn6MsCkPcuN4usYLD9CRGBk8HrIFo9QjN09vinKifvEY6ZU/O++wgjkIuYQqxMGIefQKeSo8abWefNZ9BtHDGje8/Wi9pP06AyY3ILFpStChes6KciyHD5fX494kU8hHZEChXW2wpUU2UBKBk1jKtLY5Pa3KdG8RTDCObcszPBW+W1UTBskIEoA1Od3v8H3yYqJFYhgif3x69R4tIUltfUesM046NinNaK9/Cfe8uvosQJd7uFuhFSADz3UlZNQTVjIwHcQd0NfYvGibX2gjUvwvfBjCPhzw6hcDNgYcztOabZxc2s0bgHum6MLRQ6Qkn/x1M2wn/l4IYIPsEZtc8xFBK3k4fxNq9ZBqJjpudtZrGcEJUu46e7cduCbmXAs8mXEmUaIikypHvUZUdy+/7ktCoPK5CKLXVfOrfqtdGsaxakaUrrUa4gMfkLZC9qGUQ1+4cQOpg0YFoE/WVrStEY1R6hvizVhAWdMSosI8sw3ONcMcx81Api8FG7bghVkmVw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tivfgnMZaITTjmEcBc7RXKbq+j/7NciHoplG7zImVxMsgGkDwUPn3Xz69L+d?=
 =?us-ascii?Q?vMhP/OaZ9Orn2j0svP/QbDQ7GPka1AH2EnIBfIAv1+Dy2+uq/YiX1PHuu1tc?=
 =?us-ascii?Q?3aGdmneu3Z3NrL24WiO/mAihZr8scVXa1HYRb3kDz4BpV63/GGtRimYVt2Mq?=
 =?us-ascii?Q?PwdxIyMpbSVXc6JUqIKHPo1l/xtLcZRK+qrrngJ8+zzeRCNpX+XmAtfh/X3P?=
 =?us-ascii?Q?4S0G9oi9Y7jdb+MssBiJG/H76QvQ64h+UN15Cw0JLV9C9t+yDUx/QhcbmSU/?=
 =?us-ascii?Q?BR7Y/hnxjP5v87FrlT0RK/n+LAqqP8G+5r/ZDs3gB6L516BlNksqBOrGeV1b?=
 =?us-ascii?Q?QOp055qQ6cBxaBZQJTjxAULil0PDPY+9oBwWue3sk1KFQhw9SjpPdeHTFmnJ?=
 =?us-ascii?Q?1KJuoOCWIvNR1CuIe9w+y3M87/dNN9ZWpbp5fDBmyIphsrwgkDL1a0KvvHq9?=
 =?us-ascii?Q?pSDuFOdnR9WDZVTxQgL2uccrnnikz0o7j3p4bK4y6VQ+MOTri4BEAoA/IKZd?=
 =?us-ascii?Q?yh+WJ1V2oG5pCbHdxu1B/7O4A+4CFH2oAL9HphMOcn5q19TTT1dSIih1zYAB?=
 =?us-ascii?Q?XFIvtQvDhyFKji1OmjuMf39Ktm5/ZUpNCmd+8JHYpUj6avzzAOYCqpTU/6Ob?=
 =?us-ascii?Q?rUg/4e+b/JhAHyDlocCG+qRkMlTTIfQI7PSnrkiCpJ/sNO60GxOkFTQFUK3x?=
 =?us-ascii?Q?bdrzbkV8W+abR8IA+I8CdHn39aQJkx3lC1bNBhI3M3vXNEABjzXCZPbZ0sOI?=
 =?us-ascii?Q?vQFXgMjHiCRUonK4fRVinxDsKXnFYhK3LJlwC01bieeD8luyvSV2pYTjELXU?=
 =?us-ascii?Q?TmsZxGsGc5eSoRni1YoQIOkwOgwLmwN0bWUX0uZ2W+zbd6AYXQOZVw8+ozn3?=
 =?us-ascii?Q?QbJ9lIx/i+Q/XLGNlZPdr/2i5wBGfvsg1VgClz15DdETttqEuxPasrxoEBuo?=
 =?us-ascii?Q?++xPrHllom9jecAlWwpmZjrKxTHTCeZmwsAja1jOaerBEQ91lZhIOst1BfND?=
 =?us-ascii?Q?0ULeKm5HJsAjtimBYYS2AjpGgr4ii1+yf8euM9U8oL0yo8dfYWGqcxLtoRfO?=
 =?us-ascii?Q?Lw5isoobh0Nf7N2IvMbjdKtxhNB0MREiDpKxRLSMcsdsEMxM45v492n+gO4I?=
 =?us-ascii?Q?yBPHY3rlG/euhZyqNTdx47bAixNqFGeHRbjK0LmKdupJZ1fXoBdwuvAAPU6h?=
 =?us-ascii?Q?Ts6HMhm7YN6IStxmll2qDoTgmTMn/NK5pqbAd24+pQZPRbN2OhzK+v1QyjbH?=
 =?us-ascii?Q?P2gzgl0CliJl8MH4LPpFjTZH+9lmTuUDfF6FgLpsLVeWd0WD1HiJVCLaG2ch?=
 =?us-ascii?Q?mJ6gsTWcwdY4Ij1kKr6bPhrdOTYTHEh+WxKvru/8w/zw5CRjGF6EqVy/yOTA?=
 =?us-ascii?Q?khBQHGOgZPtjJzPJYlCzDdqTvwQXt+onrtxtqKC1mUa1enei5xFkLJndzPq2?=
 =?us-ascii?Q?TZTTt6DzEK4qL6A8JFww+Ujr1pGL0RzlCTQcReINPgNZO9ou3cjiM67I0xqq?=
 =?us-ascii?Q?Npo62fO7YfOmLTzUkOGkx2ptecMW0wK8X56TCTk9Oms/bkZcH3Ed830+J1eZ?=
 =?us-ascii?Q?acIz0qtvzAsud+hCNAbWVT7EeAA0kYvNenA3BzjVd2WblxtcJWNT7hXxSyGN?=
 =?us-ascii?Q?JAyrbMUOGRjUChYD0wrqfgaH1nSgSCJwkz0uSWcYxQbUjFL4635Vs6Ohr7u1?=
 =?us-ascii?Q?mTHLtiaWJjn45GT/M42zl9XAoYzPCOV/ncTsy6KJoe0e6m1jbYjE+sgMGOZN?=
 =?us-ascii?Q?yTAeMwEfyw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	kE/uyWajjUgGUFNXlVx3o+gGRWi4MlTexV4EkqbMj1SsmIsgMknbYgLcy2pi7RsFzSh0jGRPBRDRPrbgitmpJTin8vokeEcCmLPCOC1cx3XttS52hDq0OVIkWTA0gOl/5/UckJAD01+XFpkha/uG5kGz5NGq3Lx055yeHCvCAnJW0Z31d3BiAhfDEET3rqxdmRaWVno8V3/o30BQS9Ohv7xu2BWTav7pZQA24mu+IBX1aFpfolp/Ur20VRHbLKAR76WYLCMpDiw4ToNWs8mT4nGgrBfLotb7lk3sU7Fyy/p3YcEWRcUymmOrkHRJ4oKbc6sHnwo0vhT/PGfiXsNdkg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a9097-75a1-4eff-1b2c-08de7feacfd8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:42.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1ankejKBoUkM4RcljO4EDem64EQHAMatD4yUK6XCNv/OjMSng6LFDl/BejMaczNnqJCStNk5lDFaKCeGvR8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388e cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=slLyD0mBEoi4DCJX:21 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=43dznphUI-UhAOROJDwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX5XL1/Tl4iup8
 NAwoMASABjpjVAiLOvDERlsDNALOhfdcAO9xnSkgRlkcKnz9YbVNn00KeBAUwW+0KWYDYk2BqE+
 cAyVaeBwDbV/bZ6PJPsaatRRSonwROC0UurHMQsz4C+6ucngClrUq9IXfkr88jrqOsk9v8XhpTL
 1G8XdVtEIAHFHXCnArJrZeRs4cN3BcnBOuJ4eFjqJisKf7AHabDKykk7dqC16HgnnjgCaEQvCm1
 TdrqkPtPuyndzW7nRButyqdK/vjb8rQ4ZXK9ePGACpckZ8pSIDVeQowIb3+AD9YwaIc1PWIj7C5
 lOjhucIFZCYNMaYo6OBf0DoFgACtUftfzjSwvOAT9APkTV6zNPrVj23qhh5PWwCQICSBpchR4qm
 r/y7uRioc54s+1pWXoPR/+y4Zvim6J+I1vohiRm8/0j/WpV4SqYuKwyxQ9a8uCNqkSRmvwn5eed
 TRZG47iZf/4bJejsXjg==
X-Proofpoint-ORIG-GUID: 8OgUQXpwi7YfWWFHwpA47EWxuRwYZsy3
X-Proofpoint-GUID: 8OgUQXpwi7YfWWFHwpA47EWxuRwYZsy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3446

From: Chen Qi <Qi.Chen@windriver.com>

If a recipe has no maintainer, it will be skipped, and there's currently
no switch to force the upgrade. Note that for recipes out of oe-core,
it's so common that they do not have some dedicated maintainer.

The global_maintainer_override setting has the meaning of sending
upgrading emails to the specified person. When it's set, someone
must be using auh to do upgrade. In such case, skipping a recipe
merely because it has no maintainer does not make much sense.

So we could extend the meaning of global_maintainer_override a little
bit so that when people set it, recipes with no maintainer can still
be upgraded.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 9920126..8589f8d 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -712,7 +712,10 @@ class UniverseUpdater(Updater):
             for group in pkggroups:
                 upgrade_group = []
                 for pkg in group:
-                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], pkg['maintainer'], pkg['revision'], pkg['no_upgrade_reason'])
+                    maintainer = pkg['maintainer']
+                    if not maintainer and 'global_maintainer_override' in settings:
+                        maintainer = settings['global_maintainer_override']
+                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], maintainer, pkg['revision'], pkg['no_upgrade_reason'])
                     if pkg_to_upgrade:
                         upgrade_group.append(pkg_to_upgrade)
                 if upgrade_group:
-- 
2.34.1


