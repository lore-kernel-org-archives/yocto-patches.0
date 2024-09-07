Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0AEB64C8
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 11:31:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5750.1725708690333225817
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Sep 2024 04:31:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=99806d0699=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487AsX6C024646
	for <yocto-patches@lists.yoctoproject.org>; Sat, 7 Sep 2024 11:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gdt8g8r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 11:31:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2hmX5rqXsHLgmiqis24j5oRQg+O+GnSuPP0bjbHk/1RjnkxXkoKpBrhKFzNbxjH6GSYrhiMOaEFiRENlvYifIfY6/k7NPBpYAkPxWR0Syy9hspaBlhrphX0+5YGl31/fpam9Wp8helDRQtsJKIEQgU1sbe8ODhscn+cVsmhvjOf+oZ/rUMQEhzGUkacI6RZ39a38md3c3dHuFi+mEMwd4J7u66D1VLsdviTrkqQ5xbILAfL2ieNTEbBAsixhk1KpFulQ3v+hWNwXH/YVmq8IW6LACMtGq7njYEmYHV7hAQQrcvh5/CSjXRpyAVJdKrhYX4lgyt8LKdJD+BLs97KAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KJ7jYQXBgMDl1dsn+igcZ0CwWRwSHWv5xLfFfipigw=;
 b=HMyuULn4zQ5y9fqIn9iiWbecYH9grunjmIZWqzqILEuvjWtZ0rfrSVlMnGIufLNBApCrQj6nJlH7jR+pgOtOg6CYbZGvoqYGrdGReKDQ7CKe8N4o7OJ6GDYuGlA32HbCR0LQu9Z6dLiR+FeKDLdPJNYTUXkFl8ZesHNiS+QD6PctikDfgzTAMpd1zJqGAYuHTpYk/zZavs/EjSpA4Gjhkrl+H/vud2VDv8ssjLAs0KsKvdMRwQ7/Jsu4X36kD+LynaZ0Rpmglve5S1E59kDZJh9p2cDB2jD7jaxIN15PiQTTgfNwFjpc0VAgBm48UwH0B+0qVX18DYE581IuGqrSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 11:31:26 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 11:31:26 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [layerindex-web][PATCH 1/2] rrs: fix bitbakepath variable
Date: Sat,  7 Sep 2024 19:31:13 +0800
Message-Id: <20240907113114.3361680-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3049a9aa-f463-4c0b-6a42-08dccf309bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?q2KwOWxoaHSM32GkHnO7hbw1aoGjbC+8vqWpWyXPedJreK8o/fpobgwZyoCq?=
 =?us-ascii?Q?sb9Y1tN+frh4qukiJsAnZgMLXD/bmv4zXfnwUtE6he1xJRVKRGOUf56dsgY4?=
 =?us-ascii?Q?khV/lmFuGSQWYn02iN+7pEiVXn+Fywh8c7R5su+Og91rtPcqgzFuMobyqUbf?=
 =?us-ascii?Q?8Qy15HlcIUaJ5DPvlRqMaE0UrlhJvgm0FrnbOMhwf6d4w361MZ1C9EA+Tgsd?=
 =?us-ascii?Q?l1pRPEkQ3By66MqIJuPF9dX4Ddj02Lb2KQw1syxOL22PKxyu0zCNQmfJ0afX?=
 =?us-ascii?Q?wfk8ATAZODIxybLJwBHDYmHArhDKVg+2Henkv/SfbrEtLbdI4Kf5rCXlWXNf?=
 =?us-ascii?Q?ufVYdYcQoRCT5jNlXLIXw9jkhSLOKsIdE0F6DzfjCA0Op5olZILk4TyrZH0U?=
 =?us-ascii?Q?pckeI5esbJ/ErFXuyp5y3kK8Q0FzZxA87io9tl9xSeOnEQfZzoYWlryBLpTK?=
 =?us-ascii?Q?ZmuHKw7xA7Lwgu0WqW7jHMLyqRd/Omjcm+06jGxMjrxpTmhFN0a/wZiOdoJ2?=
 =?us-ascii?Q?QIuLd3TXkrj/fTsNn0iF3Iue0Qmwlk+zLd3zDUiBflNTRZPsuyeVVs8j2bXO?=
 =?us-ascii?Q?O21fMFe+Eorr6WhOlPsq7yTIP86UyxJldbC7Cw6cPW4vC2oS5cjLaz95w/nm?=
 =?us-ascii?Q?G+G7oF5IDzGusokDyXqXDZDV/gmk/wmrZQVl6+YU7xdjFbDj1HFdqepEenZT?=
 =?us-ascii?Q?Y9iJbvjnw8Giac9lC6D3iqO3pDxzB0T4fNxzCvFqZQS1Jqrkb0RnwNpz9Xla?=
 =?us-ascii?Q?ibfpsO4Pl8GbbzhpZMVNsNqXGbkJ09ZLarfDZCyIGHcyAMjj3mIGegdyNzXo?=
 =?us-ascii?Q?Ll5oQkkRvX4tGPGacXw7M+I8YbacPjinnOS29ZuiPjyI+bLtX4mBR3j+Jwv8?=
 =?us-ascii?Q?N/dyV11AmpJjsIWxbb9vu69EROKFlR0n8cZHqR17baEyqsRTqyaIpGbyxDKW?=
 =?us-ascii?Q?cfKbM34XFtq8msgleOzaOeBmFBxfDkyOwAHVuuQo/JYQ+kqMg4gLFhdEi6Q6?=
 =?us-ascii?Q?Z1lSE/pnOIDXuBA/zvlCVGU0qOq3yvrZX/rXKhrKuQu8svAKFzJTqHpkz3eb?=
 =?us-ascii?Q?HZvDTbzoTY+i1WFZOfMaKAIQjme7EDcJIFZkv5yhcLvFaOICkGgHY+3W24p5?=
 =?us-ascii?Q?KO0m6arxVVKJ1nTZlgrcCT0bsM1vwsbfiTMXV3YsP5AkGWn3LIH7JcY26RPT?=
 =?us-ascii?Q?OSXpBAdQPSUTx35cYz3QkKYRjPy6oOclS79v+j/hdHKH6F48OxEuMI0MWn57?=
 =?us-ascii?Q?oRK5wvbTo3oXYmW4IsZkkL6NXdB3Pk+VtAmFAEQ1d5TTK+Xz3wm3GPXFK7Im?=
 =?us-ascii?Q?bOyemUNRT00Qf+OKRlXmrpyHu2biweal4Q0NXZRhMNoKsUfvwv5WpigBOc58?=
 =?us-ascii?Q?F2mEHyc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NrkISaY16ExPx+aSfeMML7brxZrIqNXVKXjAzRlDL6C5MvRUJF3bk/CR6Twu?=
 =?us-ascii?Q?eWik5fnyqN8TR5RuW6T11oKsyrxrktgDZ+0vYl/o9FGFKJ16eGF3kKZeuWLE?=
 =?us-ascii?Q?emJn/W3JaSYCZoAG+YHSTjrdgjiNsrfDFDfgPSejNDgw9ZSwtSJx/C4GFkic?=
 =?us-ascii?Q?mHjafcWKFt7t3QltAvO3X3msBYwJZjRsK636UByAlNSVjXjnK8oCWaeOppII?=
 =?us-ascii?Q?lFmexsx+jlSd96kOMixkzDSh7wPkNWDZDW4WlnoV6aOCilYDgsYJ5VpFcbvh?=
 =?us-ascii?Q?jWAreNML5kwH4XAsGAfK6l8UUkdjf6+g8I8lZEmFtPjQsyXQETmWP51+rNXv?=
 =?us-ascii?Q?TQqyuUtFyQZMqcl0e13gN2RZw39dl4AKPH/7bw0+zw+zBRa0EEKn6xZTcMtA?=
 =?us-ascii?Q?yQmaOgWJRCTbdUlRHaRQHmBHANUwHcDQjSgEww7MeFHLs07MwYBjh3Sy5vow?=
 =?us-ascii?Q?GwimdlnDaJwJoCBqAKAO2GSejxWfL0HTtRsUJKKj3kbyo2mPV2OyAjNvcof/?=
 =?us-ascii?Q?AKt+hgXlO/zCEbUUUmmpumS3pIJL2w1h0V5DHzUE1jLOj/Mi7M74bV2NGY26?=
 =?us-ascii?Q?1ExOfFyWwioKRKBqzdfWiFyB7apQRNDLQaTv25D0JJkz7YGYc2/2ONIaSRxw?=
 =?us-ascii?Q?Z5ss1TsSrGyaDcCHztAH/dqFbDQ4SPJKNbQgLvCG9KHEn1E0OijNmsogS/Y/?=
 =?us-ascii?Q?Y3NDzIdUUXrRfFcaEgQ8q/B1juPmCYssdVZ9F68d1bFRb69bljtJwUsYxQTZ?=
 =?us-ascii?Q?tEa++rDW5W60xBy0Q2ey5ljea/CkXjQZdadwa/ZWrasSd8cO3eiaIuRyZmZv?=
 =?us-ascii?Q?tRvoLbIczGZwBPNMQ75aS/KXP8zc/naL2hAttPyvnRp7dsjU7WGztT/QPuTt?=
 =?us-ascii?Q?BFl7g0Gt6XL79Xv8HMBghDm/JLxUdZtLxAiRi96fviEOF7uRPxlb5wJmErEy?=
 =?us-ascii?Q?Nbn8irniM4fztmWnUacFbtiXZrfEmQRTDqUkknXdqRlaReKORYsGgOS/ZpM0?=
 =?us-ascii?Q?kpdrl2PpkhZDpKNBntvwRTZwo2ps13XPcI07r19XLNeyqQE6QJnZHIB/LDwM?=
 =?us-ascii?Q?9xkabz3MGfMJBR5TEi5o22QZzU6Bl8kY4OZZmPTw2WVNxJ/buTtpLb0fANtZ?=
 =?us-ascii?Q?QKFP3K1yRZ5hAN/zcaHzkS/+kdt3HgDZh5g6qbj0hRUehwUlwWycT9IxJceu?=
 =?us-ascii?Q?VfIkZSbs3kadtCl63IEwa0Cs2NpvPIgjfRXWvkDZK2Bg1SitZ/Nrcpv7eMaX?=
 =?us-ascii?Q?Bh89L8+XSQ5HkhSKlYP/+PgnVDme2b+y5Mq5OuwRfr3bJrSs6SxLkr7w8OkT?=
 =?us-ascii?Q?yz8huLjC6urWz6bzJZ1NtJXu4adCHST+Kxp77UuVyVixu04gq14ALrvLECM8?=
 =?us-ascii?Q?lXoefI9V43HwAwkHs+6Fr/k9kqs8Ln7tJHbIMBaxzoN1p++FdQ7Zn+zhF07k?=
 =?us-ascii?Q?XDpu3H2PZb+0YJsLWvbyFwJmbu4Uo1FEYjWE7W7JdIal21CTjMXtK4QaGYDl?=
 =?us-ascii?Q?hDyo3qK9X0oGBA9X1eO6XKm11pap/TVwzoYPucYGsvZlNigMnvb6sMCeADVW?=
 =?us-ascii?Q?SBLwtWj+a7AnrYFTSoH3+5W1gcGo4nelVRBxkQAk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3049a9aa-f463-4c0b-6a42-08dccf309bf7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 11:31:26.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EDSvytkCrDvNsM5IaoLt8XicXSgCCAEg28vUrkFg0f/KH+A3bQwxw7QeNmIG2uOMRYpGQfbxSl9/KkI3Ao2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-Proofpoint-ORIG-GUID: 64JlqHZi5Zy2py6EaK8tzusRi0fCJPU-
X-Proofpoint-GUID: 64JlqHZi5Zy2py6EaK8tzusRi0fCJPU-
X-Authority-Analysis: v=2.4 cv=a+hi9lSF c=1 sm=1 tr=0 ts=66dc3991 cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=SonEJ9wuKpChJPSynFAA:9
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=632
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409070094
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 11:31:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/619

Since commit[1], the bitbake default path no longer uses the path
'bitbake', but instead uses the same URL processing as the layer
fetching.

[1] https://git.yoctoproject.org/layerindex-web/commit/?id=c91372587bbddd4c595d7202e51a8740b787a06e

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 rrs/tools/rrs_distros.py              | 8 +++++++-
 rrs/tools/rrs_upgrade_history.py      | 7 ++++++-
 rrs/tools/rrs_upstream_history.py     | 8 +++++++-
 rrs/tools/upgrade_history_internal.py | 8 +++++++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/rrs/tools/rrs_distros.py b/rrs/tools/rrs_distros.py
index e4c6045..4c5b273 100755
--- a/rrs/tools/rrs_distros.py
+++ b/rrs/tools/rrs_distros.py
@@ -33,7 +33,13 @@ if not fetchdir:
     sys.exit(1)
 
 # setup bitbake path
-bitbakepath = os.path.join(fetchdir, 'bitbake')
+from layerindex.models import LayerItem
+bitbakeitem = LayerItem()
+bitbakeitem.vcs_url = settings.BITBAKE_REPO_URL
+bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
+if getattr(settings, 'BITBAKE_PATH', ''):
+    bitbakepath = os.path.join(bitbakepath, settings.BITBAKE_PATH)
+
 sys.path.insert(0, os.path.join(bitbakepath, 'lib'))
 
 
diff --git a/rrs/tools/rrs_upgrade_history.py b/rrs/tools/rrs_upgrade_history.py
index 42ba9b8..b762144 100755
--- a/rrs/tools/rrs_upgrade_history.py
+++ b/rrs/tools/rrs_upgrade_history.py
@@ -31,11 +31,16 @@ import settings
 
 logger = get_logger("HistoryUpgrade", settings)
 fetchdir = settings.LAYER_FETCH_DIR
-bitbakepath = os.path.join(fetchdir, 'bitbake')
 if not fetchdir:
     logger.error("Please set LAYER_FETCH_DIR in settings.py")
     sys.exit(1)
 
+from layerindex.models import LayerItem
+bitbakeitem = LayerItem()
+bitbakeitem.vcs_url = settings.BITBAKE_REPO_URL
+bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
+if getattr(settings, 'BITBAKE_PATH', ''):
+    bitbakepath = os.path.join(bitbakepath, settings.BITBAKE_PATH)
 
 def run_internal(maintplanlayerbranch, commit, commitdate, options, logger, bitbake_map, initial=False):
     from layerindex.models import PythonEnvironment
diff --git a/rrs/tools/rrs_upstream_history.py b/rrs/tools/rrs_upstream_history.py
index 73b6d91..2a17c30 100755
--- a/rrs/tools/rrs_upstream_history.py
+++ b/rrs/tools/rrs_upstream_history.py
@@ -33,7 +33,13 @@ if not fetchdir:
     sys.exit(1)
 
 # setup bitbake path
-bitbakepath = os.path.join(fetchdir, 'bitbake')
+from layerindex.models import LayerItem
+bitbakeitem = LayerItem()
+bitbakeitem.vcs_url = settings.BITBAKE_REPO_URL
+bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
+if getattr(settings, 'BITBAKE_PATH', ''):
+    bitbakepath = os.path.join(bitbakepath, settings.BITBAKE_PATH)
+
 sys.path.insert(0, os.path.join(bitbakepath, 'lib'))
 
 from layerindex.models import Recipe, LayerBranch
diff --git a/rrs/tools/upgrade_history_internal.py b/rrs/tools/upgrade_history_internal.py
index 842fe81..7f3b93e 100644
--- a/rrs/tools/upgrade_history_internal.py
+++ b/rrs/tools/upgrade_history_internal.py
@@ -448,7 +448,13 @@ def generate_history(options, layerbranch_id, commit, logger):
             return
 
     # setup bitbake
-    bitbakepath = os.path.join(fetchdir, 'bitbake')
+    from layerindex.models import LayerItem
+    bitbakeitem = LayerItem()
+    bitbakeitem.vcs_url = settings.BITBAKE_REPO_URL
+    bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
+    if getattr(settings, 'BITBAKE_PATH', ''):
+        bitbakepath = os.path.join(bitbakepath, settings.BITBAKE_PATH)
+
     if options.bitbake_rev:
         bitbake_rev = options.bitbake_rev
         if not re.match('^[0-9a-f]{40}$', bitbake_rev):
-- 
2.25.1


