Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CEF531EF
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 05:32:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12275.1776144733808454021
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Apr 2026 22:32:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=EtiDrFlR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85642e362d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DNiTW31269595;
	Tue, 14 Apr 2026 05:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=pQsN4jFL4
	V72e0RfXB/RdvJe2Ekoiu9INXgrASph0qU=; b=EtiDrFlRIWHYnZE7E8cIdEGXy
	Znhj0c3HknWBIw3hz/g+IeAEEuJ6xD4d8bO25oprRz4ctgA0htTD+K3NW26baTGm
	T90rgppD8schcqSCmkfpdBn7qA1DjU3fUxoi/0V2lD9gcjaP6+P7zIpJxsi7dCkD
	5oUBbyjzoa2sprbRw4FVkq9cKYvoBDGdCML4pKV0UBFpoiNWu7aY6Q+CvFcEMJ+j
	19x9NOVvSjg/G0j5Oq/0sr0TENXqZgYrBi53Xl0tn/cQN5rWK9+O4WMPrfYECOX3
	juM6lDmZQVqSLWmYZf4kkPosR/jOdZfeK09dkdhinZbS5U1Y1P7jXW3YHxFmA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877gatx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 05:32:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZBl3ChhawS9iqf21HHwq5WqYbhQWOnhOVXd+ECmCa8LGmZ4LaGTWDPHZIB/mcwqHpwLgcD4HhsvMaqJCSl1YtFov2PWIC+M6L1681fPAz8rIX/nAtbvPn4/JY8/cT1FICHvBYnAJ33+l6sEPazk4DilsKorUsB7rPr3e76tdLMnXIHM/2hUr7ZZQ9IjYkYAB2pwJf4imyv4dZD2/jaAlzpQKgovTWhHcVJQw6iuqF9YtVvNDU/wTk1Zh8Hq52rIveKM9Ky9k02HUAbULAm/Az1qhB4OepUHXGDrAPcTFYA5zRptXYLSgg38AtlQIsWLn9MQSD3mNwm27j3a5JLjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQsN4jFL4V72e0RfXB/RdvJe2Ekoiu9INXgrASph0qU=;
 b=N+EnYLandgGwwC6nXKxFzOqaa3lTFOy+vuUYYZBWnfw1vC29FleAat65a2j5zmylUeHqFV88HTjpaSztEc44hULupfgLwzvyekl6L4tOal/2g518XGJPY9tKp4pDEQxsscdlExb+LUZC6ofbUgfuk835x/oruIqnRYb5DTau6rr9W4bLeyDeTet/HVjmqejOxwgPyif9zuw2RmhxG7MSpp8Jhg4Uada0zwrQvXk6Ixl3KPYC+WhIwrPlP19BWXKT3zS8LXhkQAYdL53KD4A/L/pPGb7kjtQvFCdVmx62rmNSmCCthCmUnAMT4HM4wH7ApWvt2EQCeEmnZcPZfnYNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 05:32:10 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 05:32:10 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 1/3] upgrade-helper.py: remove gcc-runtime pre-build step from upgrade loop
Date: Mon, 13 Apr 2026 22:32:00 -0700
Message-ID: <20260414053202.3869771-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5611:EE_|CH3PR11MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bbba40-8071-47ea-5df4-08de99e72ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	b0Cd1cOJFGOJdM/E7a7+iRS7vlqU2FHbvStjxt5kQXcwZNvN/2334Cxxg4exm41QYWEYaMGE8tAJsOAZnnzH6TzCoayMovbf2wzgrLIzlpckqiVc59CU36FgpjQFWEPoHPCj8dGyYVs80XhzgPwuZFvx5NyuL67r0+4W9/4My65xD1PotLYWSh0MqpUwaFtjsZLbhWGf/EMAsU8zE4d5d2pBKJjWMpqvsNtRU86YwzJiGf2/YswLmXlLsRIn7DUyNxp/U+QXkFH65z7yV2P9ut23WJWejwBkLyOykOc3sz6+vcI5uQTRdxv2sfA2aLQQ3B8DIr265vfT94okSyOhDpalu4YzXpcvPe4UeccHQblmAXzuqDrawuxYpU2ZtKhSMplKJNTLLhD/Diz3y9fajW6l2Snf9ZI4GGQRfu9k7G4qSUgDk+j++Ixj5Qsueg90gRollAp2RzIhBFtSgpKJKWXVEExBV+O+63J9+21OVp/PNqHMQvvztXM2juBNmRatFX3K8MdvKG1fHyoj+sn4GUTjJF1C0vvMVidOG4btL2melimhmB9YTe/x2EygrD937ZcqI0J6aKe7v0iigCPl7D/ieyY/81/zWfH2dSyP8PtPpn3f9yidS2iNyuVdXzgjsM4vCCqBh3lBUupaqFY6rhNNrrxTBRrPzAwY0t5zLlKiUimBNkJyENsZhhV4DzKKGdEJe2hTI7mfo6hfODsZQ3L8mBMYnAd71U+AWZS/jtrE6m97biV0MNFlqN0rVfSQnpsJ+zNnQrKwYF5PirFG5yvieg16kWNRZs+hO9zom2k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o4wU9uwXHkIBbqQyJ5cHOPsR7wJdlPecEtrU37y19I6XfVIBdf/+ZEarjv0V?=
 =?us-ascii?Q?M14978DGkoLghPBLvpWqcNxgksN0Nk1K+onUFunHWB1K1i6QJ4qvvwtRqBdX?=
 =?us-ascii?Q?qB0gDNG51w4Ih7/r6W6/yG22HkE3NkA4ZXzWmlG73OFZy2UlPRmmGRorwxx9?=
 =?us-ascii?Q?kgg78lBy51EZdGlwBX3ImWDjzGat5mU0HGkR+tBbcVrROax8U1/MeQuAKRJ9?=
 =?us-ascii?Q?o82HJVV0VmHfefdmzGNnDdB0AA9sSY76JM6gugbk9bajHzRH+g7nptANQElj?=
 =?us-ascii?Q?xsqmva03dTcwNS2JhKhp9xdWo1X9TPZVuCp56Z/lmdOocNoKoZlf0VEW8WBo?=
 =?us-ascii?Q?cwcm6Hx/ftHWRs9GAQTteq9X1Nosgxp+zxG1rIGCTtKVT9AHsGuoOhOyF046?=
 =?us-ascii?Q?GoX0tIHl5T0s9iYQbOrhXyHyGld/dUrKZqwnUNmt33vr5aFTtdHpq2S43gSr?=
 =?us-ascii?Q?Enwlb53BI2vRZ5BRvbM8kAS1CDxwBJAI2il5Kglciy6YD7ZrsJghhd6ZLizi?=
 =?us-ascii?Q?lZ1Q7riLgS1XryQW+pAjdi9lGo5HbutkfyGd/r6bl666ZKnpFSdc9+53EpCk?=
 =?us-ascii?Q?N8UtXPJdgCtkVuTBKHCwDiGCDNmFQZ8qqDYrQEOaI5Vblm750pj3MU73Syb+?=
 =?us-ascii?Q?STHKnmIXy8OPmlV117FsaSkGrUnh0W+kgLbLNkslmuq/oe3mwxLo+5HX1QRO?=
 =?us-ascii?Q?QsrmcCNLrFMYNyVMRwi3J7Q4HmDr5uFpbG1/T47OOO3oiypIuKhpZ5fCWth3?=
 =?us-ascii?Q?t0p1XMhAf1fUA6jHv8uFk+JNzhS954IG/f/BqUAxbT0jyP8ICF9lT8JOz4Z/?=
 =?us-ascii?Q?PF5unzgF287AsR24wbntd4qB4XGJGvLFBvlH5bkE1U49j2aWQTgEwyBmwQi7?=
 =?us-ascii?Q?TAvbqmF2KdHddf+XmJ+CuYdHKkFwFuWoX/6MxLVh4UniGt1qBytlCLCIV5mC?=
 =?us-ascii?Q?1fywjRMnKvZxhKl1cVh39jx4uDrPC5wdvxex9X/C3fklgWncSM/gHU6m2pwg?=
 =?us-ascii?Q?KXk5bXxEKn9dsJMfOh4A+ZzEmtUDlTHupYq/Nyrgj28wGon88SQXRw8pBLa2?=
 =?us-ascii?Q?TsgVpa7KIbRMmj9NzJikB3aDJLFB4sOjLPhqCgw+0GISFnEkJDX4H9GZvZTt?=
 =?us-ascii?Q?DDkt7NS5swK6fTtAp4McAnv1ckFXnKOBQxUMyJvxbzUzaD5pN3eUO7gq9X3v?=
 =?us-ascii?Q?lI6+HNsr37JsUtvL8NmxRUdOjdTan5Mf2MV0ILKVuu05bEI47NwlcZLtlsoc?=
 =?us-ascii?Q?13N3P012FZlHP/dt4ti3n5NpdVNfEniCJSkfLS6vbsUTtib6PVZEN8mvTe0d?=
 =?us-ascii?Q?iw59g2Ir9FKEyciEOEkYndCwIMV2JSLpfjhwEAoq4RstIRMJqUOMxfRGJn5N?=
 =?us-ascii?Q?iTfJ1TUi88Mmbzd/giaqNgTkrfc6nPlhzmQjs91pfNQNFt4iAb2EsT0NqjMH?=
 =?us-ascii?Q?YmRAyfyUvresDgnRZflH3lHWOuUxHgDymF7ZIEY3dSfPuTVlky8OeJHjuq+J?=
 =?us-ascii?Q?SwGcQTDODgD8WmYiEmF4gkxP7Job/lmO0xfVN6wsruf/NykafnuSlbOpnYnb?=
 =?us-ascii?Q?jEDI0BkAevQZh0Ryx7eDdGawhf8OcEDxskjM90KGTXwd5IIt8XevldL6Vng0?=
 =?us-ascii?Q?7aDloU9HH9vx4SiHfXoOG7C4eeKZGHQ+8zBJh+aeuhwzXPIo5YdnoaGK6/1i?=
 =?us-ascii?Q?/XTDheD1cdQcGPkISiHW4X2ujKzQHLNhH8R2VSZfK3QUf66UFjMDfc/pUIDj?=
 =?us-ascii?Q?+kWYiifBUg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	AGUB3cMnDJ9qFY70g74se4dyBU8+30adHT086/b5v4KWL9GH41iHG7cKXibka/0jGGq4tse+fvB8diK7gHUMHsplCrJW7WbsUAF86Gw01YU24CL2SKh6FvE6LAVCsRg9ezwWZe24VjOzg1CKBTAgZHDYn+8ZOttmd+Fzbr9OqySmEOEtBci6Of8ylxpZ6AjqczPY0usI1EXBZiIgVjhmU03lhKdnooEARVY5UOpuFRqwY7/7eWLtlZc0OE77eQ1vjWzQMYhNXjk6IjzCYa/56v4wD7WFJ+8E19VfDkHoffSu8hkSaBsybe4VhBOOpnvPQGFJRN+DnueMzrCjroB2Gw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bbba40-8071-47ea-5df4-08de99e72ca5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 05:32:10.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oduKin470zypzrjIjJuVsFMAnzFwurK410cxkoDQwiCsECQVMvHFqtPvTbz7ouqI5H5P7ophYLU7Wi4MOvC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-Proofpoint-ORIG-GUID: bnVtMrQDTUw_9-5TN4nZPqX7kd5Ql5D3
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69ddd15c cx=c_pps
 a=Bsy78vmKOeQIAJqgrxlU3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=-XOzb-gzF2HJyuXJSQ4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bnVtMrQDTUw_9-5TN4nZPqX7kd5Ql5D3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1MCBTYWx0ZWRfX+UJfkyD0u60L
 QFEDWNpsmSMGJeRQxjHtX0CWKr0E4ekPGpaFVbn/cMnwLKPd8zZnULJRaTQYtGQapAxyIyTFM48
 PPnYw7aCD7tRMqtHstPgmKfGlhmZv8jYF1xpHZAvyj13vKdklK7nJGxDBzQnkDq3p3djERsEugO
 icLYquqhimQtQvdXdLuIdOLlDeEoYinUXPJsLF31uNSs4n+DtjmX0R+qWca4ezdSPCiIqSQl2y5
 pjgnxLIGYxbAS8Fot4HHI75WEtGVpXxr016r9RTw1GVwvrXfC1WooCXw7/2YwxXgJIvhT+OLZuY
 Q+jhgmj3lYi3PG4Fx/yNEaF622VQY/s1MpBpm8R7TLrsEAy4W8jMkD+eoLfhEmPTtCA/xxHnBLh
 qxXomKR81U9qo7h32hihBlhR3TPT0s0tTOYKswPDrwU+sKoGYidKSwsqxBZYYeiJZNyNJDuhV2T
 cwGwPuueRo77s/fUFwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 05:32:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3695

From: Chen Qi <Qi.Chen@windriver.com>

Building gcc-runtime for each machine before upgrading recipes only
slows things down with no net benefit.

1) It will not error out early.
2) Building recipes will natually build gcc-runtime and things will be
   more parallelized.
3) Yocto project is in a good status and will very unlikely to have
   gcc-runtime build error.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..2ceb722 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -468,21 +468,6 @@ class Updater(object):
 
             pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_ctx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_all_dir})
         I(" ############################################################")
-        if pkggroups_ctx and not self.args.skip_compilation:
-            I(" Building gcc runtimes ...")
-            for machine in self.opts['machines']:
-                I("  building gcc runtime for %s" % machine)
-                try:
-                    self.bb.complete("gcc-runtime", machine)
-                except Exception as e:
-                    E(" Can't build gcc-runtime for %s." % machine)
-
-                    if isinstance(e, Error):
-                        E(e.stdout + e.stderr)
-                    else:
-                        import traceback
-                        traceback.print_exc(file=sys.stdout)
-
         succeeded_pkggroups_ctx = []
         failed_pkggroups_ctx = []
         attempted_pkggroups = 0
-- 
2.49.0


