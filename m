Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3110ECD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:21:13 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6093.1778134870366970344
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 23:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=WRoDyVZs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6474uxxn3229685;
	Wed, 6 May 2026 23:21:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=0JCrOb/uQ
	zGYZLNYqXRL75wdOr2FjbfPVcLwn4o0nrc=; b=WRoDyVZsZESWtkuXZeeKtU7vK
	sczp4zX4NmVbdyDcl1A4KrUvHikl4jUklrNSwQ7BBqBvnf8bYJFjIsoj2X+KQ0oD
	Pd60AxVeZ/yb8BScVRLLoRlMlwGV0MTg8JRmoHh5r0xGLQUaPBtqe2Pfu5nQB751
	MD6zH+RYnlGgWb+y32TwqhM+qWy3U7sDDvxdbq+IWE9trgRFphAeirpsBpmKWiqK
	bcfsIrKeZEkA+YMbpQ0sQb2fkaZ9vQho3Ufj/kgli8KMJD6QrToqlnLYreeoe1jA
	aL88sXPZ+qWzt3uJv1aTnd/31j9kSrWPM5NgBNTraJhP5RI8fl94TQ5oUTNWg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchywwr1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6hHKIQmHcfokSJAUzCWTv0tVXr7sd1RZ7ulXGmODj7VFrqmrqBQOQAzsOjZ++UF93YfbeYxWV7vvsnypjsJJQ3j08jQRdUGqGHVpr3atDwpBmD5lXEFH7CPEFx6EVQrk5fv6SAuwgN/4MzjJrQRDPUESqH4by5Rr8DTOYlKhyJapKHDO7BdmVGEzmDd3lArCedGOWvakmZYRQD3yb70ovqa5OSEidMmqfcYzefhr7I0OwhV5EpQLDfmHjo++NK2b2Y8U/73nOn3aT5EWeqzC9xdTyRO3RA3fTN2CXo0PXlnPLV6yediYrjc6lzI4wS5ndz6O27K1KFGVZ83n29tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JCrOb/uQzGYZLNYqXRL75wdOr2FjbfPVcLwn4o0nrc=;
 b=QcpMTQCsZMmRmuaS8i0fdQiFNiid7IgATFHj6HzqPkdeJRBNS7X0YIV36C/VNia1e0+jlJxj3mZ+G8kDqGLhXDC/LQWaI91dDldjW7gQrzoUXYg7L6sifPna2kxt4zqNZ0PeRRoyUBgDfAbHFby6p5E+/FMwD8XtjFLHpUYk4UfzwefOSi0nTAlLGLhokCp77Niz/jjf5rVyI++52Z6VOFONXzk22AoT1QRh+imuF6Cq/8LbdjYdfpAaLuAN/wT1Cy1OlSIPUYx4wsdAC5BET5ksJCYgsKxSLCsmcdnVhbf5Aeo2P3aF29LKmhvWS0PiFMFm7HBshWkjK3TEdolavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS0PR11MB8764.namprd11.prod.outlook.com (2603:10b6:8:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 06:21:07 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:21:07 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH] upgrade-helper.py: add --stable option to do stable version upgrades
Date: Thu,  7 May 2026 14:20:49 +0800
Message-Id: <20260507062049.1461147-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS0PR11MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 16311bb8-f9ed-457d-9fed-08deac00d287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	vyjFznBsCA+KKx2FtN7NKE7SE31eHzL/iCD9KE6lZTEMYRTPieoouTTVwT0os97b69AhVrAZaw3Z4T9cFxFCzhLs0aXSWk0U75Girt1CBKZukM/lRiHeJ/QysXWEwNEF+c6azttEPR0OKPllU/Sk/aLeMp/fQzwDzqd5L2xQeF33JINVXx6FVT8WTmsyDmb2xR0hA63nmsSNFBKontCFLqypIhGUPJUsO2L21SIZrMRK4dQhX6kkOFViD1z8VyczXcz4LWCzaBTm5syYmlBBVMgrMhAeVTpVI4HQs0+PIZPi4KsbtrOlhUA8zxiNuCsf/JfhNYaIpAE2GAL/k/3oPr6KWe+nYdnwXWyN8q+OyL21kCXcproC88SRD3/IyFqF4tjzza9QZpqcOZVtMmKBjhvHEB1gynAVuzMc/unH10b6pbhcVwiDwEusnSDQvkfLJhIGmRzAiVmgFlrML4r1Mh5P7V0PcBKfMt0qHQ8C5NVya/LAphsOQ69EQ/fPGt7NEmsZB1bScIUE2qeo+ZKsxCYvw5PQegZH9LTDFPADVHTeBat84s49BWK3SPhqpKpKrrli1/z9aanqB5sZ100MhBQEC6Nn4lz9EYliNMO71Nm9GwaUiJ3AkkWAjF+qvoNf6qa/epwq6PtiNVDrrFzjczKQ3An9DE5zxxPErzqVV6PO/jKzV7Qw7cVslp1VVUFTDrMmG/OZbk8gVE9yG4uKtZNfR8iM2UlknpLQ2DG2Ozrp9SwXawYJtqC5osHbjd95
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sSNwlw9ywpwIRvbY6syiPgYvoQwlPjlv1csOaEGaXsmeM1UJ00rbPpEcnAMS?=
 =?us-ascii?Q?53i8yQDqgyLQEAVRbw6LGu+A3CbFSd4bOnmqEdy0Y1eDNQK5YC+VJrm6MP/8?=
 =?us-ascii?Q?sjjTt4eX7B0/Mvh2adjrkOtYnDQ0fISoiSwLFYCwnHOP4Z9SqYtFYDlEOtZl?=
 =?us-ascii?Q?fG+lOfNl9kUzvWDw8Lvsd1gndSq/5xRSZ6xqPqYgI0HM8H/ByVW85xp9RoOY?=
 =?us-ascii?Q?h7mp8PLO5q3KiF6S6Xh8h73hjXP4PKCa2MoCpdywLim2YYUUPbXTL4zvqGVb?=
 =?us-ascii?Q?KnPCeBMEuK1h2pLPCD5015He8CWfMYSG74y3Y2OqjMRmC37+u/5v6VhvNgbE?=
 =?us-ascii?Q?f6je8KNHlcK11GSVOTjRGt3Gl9eE06WkExIfUDRugTLQUqtcLQCe4qLQ+Gw0?=
 =?us-ascii?Q?3AcTXlezieuw+vvtHcoIY0DQnDIz7Log5DShUKQssfWCcXncURiVbr2NotvL?=
 =?us-ascii?Q?pDA1AJ0/8MxWGw21mVaZ9bVFtnV5t8ejrNQVDZS5IQfQ9Xixi0IQ/i4TFL4e?=
 =?us-ascii?Q?JBVdlwjCaNGB9YMGatBw7X6UhBha8zuNeMoiIEjCebu6DGfiUWETLdEpVk63?=
 =?us-ascii?Q?pptnEc4l2Qly3AaLPkk4O5d3naEOGcvXs9cCCEEF9AjO3rz49+m8B2/GdNp+?=
 =?us-ascii?Q?KC/FkJsaeoOKC/yfwFenGzyG7IunRFcWoKvKb++TaucPqdpNPlUhDf7oM4p9?=
 =?us-ascii?Q?zwMhc1sFboYLH3zRIHr5ZWxAk85XDYIYesJM8Ao3KEh4RYFnZva+TXNHCnPl?=
 =?us-ascii?Q?Pt5/vO4bTDD3GdzgrJgMDOFVBjsOuj+su1wycDMujDQ4SpK/+yjlSvOudyw5?=
 =?us-ascii?Q?x3Uc5/G14QHfxahAxfSpuntnjMy7uw4+cBq+D+L7Nslo3V+nJvApgMjqElL9?=
 =?us-ascii?Q?ujt79Yg2WU69dKxD3++vi8GbKC2+n/Tu0sifoUT4iKaF1bXsUa6XVyKHjts7?=
 =?us-ascii?Q?dAb8/2wZm/x4l/D6JN/zc9BrnO8Tu8d6TImC/o28dUAr8WSoI/s2iQ97AUjq?=
 =?us-ascii?Q?gXHcJe6NoWSQ2E9Ac3TM94KnbgcXwtUWMT3wGKn3YBL9NTfGCLZzn0YQgXm0?=
 =?us-ascii?Q?TM6ePC0h4kypXwIEYdgKUBwkyjEH7rKZ4JEXbbIxfdZkiwjpX381YWKYsv2w?=
 =?us-ascii?Q?CPamh/KZgPvPelJ9MGJMuWsTuUX9DM++z2OkLX5+Alh68rWYHHox72oLtRTJ?=
 =?us-ascii?Q?IohSgU9G9ba3K1AgOd/4ddNL+59qdlpl6BGAlzsUDc6OZgcYO/xdIQHCKdMx?=
 =?us-ascii?Q?hU7rZGkMQiZcTQ+lQPB9OsmEt+pJcjFiY3aZMoimdXW2wwyHxER7pFKzwmjm?=
 =?us-ascii?Q?q8DcAvyHjpJnIl0vLAyxAR9OxXJgCcL4gaUp7XIJInhyDWPXErIvNAdgmAsS?=
 =?us-ascii?Q?9hMvpqvVwovln/kWK0IUc0idU+t4eVO3gVAW+RF0a7JCzS9Yz4l5yNi4Sjlo?=
 =?us-ascii?Q?UO4LL4hpKnuqfJ61RqN7R8mkttCE5LORNZaIKjbZIPBSX4OeEFRjAoSQB1DB?=
 =?us-ascii?Q?aqlBxmA7ox3tiC54hfbvZ1U9CElZjHiQxwUL+lMBzMNDyBWlPSMcxBoQdleC?=
 =?us-ascii?Q?ZLwlX9kpxcGVtc3ScIBt2DSEIpdjX8qZ8BA9BtpPvywAb8w9rLNJkTwABCxd?=
 =?us-ascii?Q?aP8VUG43JeCSQBC5dYcyTeFhQR1Ui/lXF4dlsN5QmlHrCYXUeL+2Ozpa12GG?=
 =?us-ascii?Q?BqzHFc2LI1sHF9cdzvL16Ekyha11nGrqPJKPALRXcG4gSXbgfweOcovSe10z?=
 =?us-ascii?Q?/7eflqs16A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	qku/Vhe6CSdbmK7WAe5dAdTYlxZqin3yFQ77Tk6gIUzOHD/NdbZJ9RYUtUYdKDzXrUxgTHB1SoPM9UUfYZGrL0QO1aIJArIirpMwUCeWXt4rhmY8Fa/CKuIacd4jsusD60a0YGG2RRdw8TLir7tQ9uLSfqdRYJmB0604uAjwTvmfcp94yJyNg1nLyg5+iaznf7RJGEWFLDEJiMp8e6dBUtrYyyRKOVUuRb/ymqr3R5q6dFwb4glEvgViwN1scUQkD1AdVnQHP91jWDBbm2TOzhGefNpMcjuaGJ0lximnQKh1+4JH8kxLhpF5UFpogYq8zC5IKZZb7fUgGmQ5d8BgvQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16311bb8-f9ed-457d-9fed-08deac00d287
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:21:07.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZRVGoOuzH05L8Tjf0Gl+O1tvDZ5iKJBn9qWKu1VLFFUsQpj6Z7FOrHysvhBKMqM97aWrYUUJp7RLXPzy5M4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8764
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfXwANtn26nePGw
 mGQrzdQ0RBpCJv7X48a2ORuGCW9zePMWXLGT6m7RusksgE3bWtZjIBqRafw55H3ftgVgUVwk+pO
 v2/sUiQ+K0L7T4Q0AF8ciCMC9NRz0saz5S92C+AFa8t6RNUpXH9kTy4nyUmo1L7V+Th9+twI0Oq
 eHyvxqQO4EShL4xEB+ur57Z82M0frrNRo57CAaDa8ErCya2letYYACl7z28M+89q/NSsyAkwDIQ
 PP3OScTy8QDRjbteHEz7WsPweVcCzRAUKaZOLvRoulgwz7AO4x0/btqP7+dPRkUv66KYVgagcBE
 5nYwAbhXG4JaqkMSUP3tSAwi4V+dsmUQ47WPNUf6MEWg+z75LtT4QbiI9TrQRPgfdpYBr9jlxFt
 mJ4pnwST+5Y7/JDieB0358K7GNzfuO6Rpmzoj8zlG4KfoygDIQracGXt14TY3S8Vymo7a1ddBy9
 BCa9zj+Tv/VN4efu5tg==
X-Proofpoint-ORIG-GUID: dlwgtc2NX19hnw_x7Ogb12dft0yfDyGE
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fc2f55 cx=c_pps
 a=IzBZuH+2DL2Wyeknq0uBXA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=a96ckkBvAUUsUnGPunkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: dlwgtc2NX19hnw_x7Ogb12dft0yfDyGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070058
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 06:21:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3930

From: Chen Qi <Qi.Chen@windriver.com>

Add --stable option to do stable version upgrades for recipes.
This needs to work with the recipeuitls.py change in oe-core and
fetchers' changes in bitbake.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..668839a 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -100,6 +100,8 @@ def parse_cmdline():
                         help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
     parser.add_argument("-e", "--send-emails", action="store_true", default=False,
                         help="send emails to recipe maintainers")
+    parser.add_argument("--stable", action="store_true", default=False,
+                        help="Do stable upgrades")
     parser.add_argument("-s", "--skip-compilation", action="store_true", default=False,
                         help="do not compile, just change the checksums, remove PR, and commit")
     parser.add_argument("-c", "--config-file", default=None,
@@ -711,7 +713,10 @@ class UniverseUpdater(Updater):
         upgrade_pkggroups = []
 
         for layer_name, layer_recipes in self.recipes:
-            pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
+            if self.args.stable:
+                pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes, stable_upgrade=True)
+            else:
+                pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
 
             for group in pkggroups:
                 upgrade_group = []
-- 
2.34.1


