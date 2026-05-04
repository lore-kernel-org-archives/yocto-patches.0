Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA38FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:36:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9184.1777876591522821079
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 May 2026 23:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=Rhq7dWio;
 spf=pass (domain: ericsson.com, ip: 40.107.162.8, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwLV5bFvdwoHUaZhuFIOtkRZoXfxF+mV+nC+i7eFi2w4N4eLG/3UP6deyUqs3gNFW9VmbABzM8H8rdDXFdpvKbI9HEg/lg4npKzBQwT71nmQbhIxdGO5evSCZnxTzbG/7mOuM4GK6cMpM0aLHyi67E08Iq9GdN5PC5JjxeiYlY4c3F6ystJoXTj8qLQ1CPnF/4DaolGFCvxJhUdgd7TJUNLQBMoM1Wzl+RrPo71imboGmPWABVCicEutyLar2RmqqA1VRsDgoDhv5gs4PiJ7uQyFu19Nyf40i8Qyl8WChvqpFU/2aZ09N3/rJjw95Vpt0DcpR6ud9NCEBsHkGW95MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YADxAm3orDF3CHpqrbA74XUx5UoJ5YI6SvEalGdUJqk=;
 b=dAuM5l5QgFzfZVg6vnXCacNtqZ9UwN/cy2fR0bBT/4cR7e8sH66YkWHUmKV3JKR6Ax+MQUWv9b40ye74xzoexug3NvhZfpOHQfsd5TObJgdZs1wftkECddRQYtqGcnkuY4KVYKOt+yM7b2HLk03rfaokQcL3F/jKeW7wcGXMFGZ8cy7R2bOZ3xpM/nfPlIioPiLykOu9CIxA7RRwzl1u5PfNiu94kK5zhfYLBUiVd8OZkLR6ghKVU9yfjoHdIOrXyadkIhtmZPm3XMAe39OZLNR3oyZKJVyCYQGbcdwYHaSWkNbEW28iPq5A7/7J+LdZTrucOrVKkOzMbLUR66tUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YADxAm3orDF3CHpqrbA74XUx5UoJ5YI6SvEalGdUJqk=;
 b=Rhq7dWio5VggdC4MGXqmbcD8nW7fjIeQiGm5vceQMysR8CJejE/4DeMi7Vzuxl6qfwO723CxY5OUC1ILPoJMQK08XSLUhnsjv358Z/tav5vBYI9PTZahBxt/TUtMhVSDHdo78rfAexwA2XQwZNX6qD2w5VCVwuAUsdCnwmEOJia7htKu1tpn5LD10sQHmktND24/QD5Cpkzw39arucrlLO7mqhkh7S2P6YX+yd0VxhkztJA6g1CY3XcfZOhNLR6KfDHM1VXep1sLeKA4J899wkgOCEgMV50btr3cHTqn//tmqJ8KFnw+EhlmXJt/ObX8TYFQN72Vp1zFDm5l3EeIjA==
Received: from DU7PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::22) by PAXPR07MB8030.eurprd07.prod.outlook.com
 (2603:10a6:102:131::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 06:36:25 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::cd) by DU7PR01CA0026.outlook.office365.com
 (2603:10a6:10:50e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 06:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 06:36:25 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 4 May 2026 08:36:23 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id C40FC9569F;
	Mon,  4 May 2026 08:36:22 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id AFC5D700DB93; Mon,  4 May 2026 08:36:22 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>
Subject: [AUH][PATCH v3 2/4] upgrade-helper.py: Add compatibility with Yocto scarthgap
Date: Mon, 4 May 2026 08:36:10 +0200
Message-ID: <20260504063614.3831203-3-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504063614.3831203-1-daniel.turull@ericsson.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|PAXPR07MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf1da25-b35b-4d7f-fd97-08dea9a77716
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	FRbtAKUk2Q0nCOqp+ASs4xsL2ECn2MmhRDe3N+KZSqnsYQ/GTyDEaU5layMQlQ1PqpvpMfxrw4dCqGP558B3zvo2xhQhO1LRPWVTAy/SK95MkRLT7IAtNHaJVFGTkGMuVOq6VS6AQczeqXeM+wHqsuctQtaVg7Xpks1YEQr8Wyk9xJAuJoUPwxRFC3OSC7zglt7pdyRHbU6fgDaNK5DG42NJJUtNVtGO2inFJARfRe9dsWoaETz7ANWodowkRC6YPBKWAI4NrG6/Or5+6LfjT2+OyeTe/5jchBEPX21M9PBfkvjrDbGEyZ3R6CFu1kE+9Cq/xxrjkCLromXvi4RGd2KQzSqHbMh1y/74eTF8LgDHhSBejMV6MnrayfvIHC6vQULw5bl5/AHXHAcXh2YdmTNiyG1zzJTlSebqS0UEVs5uRxgmudnHR/VIBLKZlwwh+J4/mjS2NNv0YyoIS/mGJ/RpHoSfLZTXu95fvmMfPKs6ZlEgU0maybzPSsaNUsrhP4cV2bpCfK7wfGsql+yZkCIfZ6ljnQuVDURMd5kKkEl7RpRaDADtDfSDsgSN1I1sK4Cv97yGge2pk9pqm9unVSk1dxiMQ/9XYGCdBfnhzPIY8oyIVccEBvcO99L/4r/zlK28k0rRXosQ+P/luIz+/GUw2tGTaBbRchyZFMiy3pOEwmjPHyVp8hoEKzS24xb4JfHZAffUHA7FHTFb6iZiH3jFf/LSssXIcssi9WkUwxY=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	k0Yjo66IZbVGgX1ybpOg+s2uDXATB7li/URzKikoNFGT1NKPx1kNr+9K9+kYxu94uCeJmdzMZsrD8kIejaC44SrHXqlAs2GCsA1dpbrBTI7M3qT4ti8tXywR1DqQ0uRT0wdyvthdt7RaPXGKoyYaR64/QtanalBsfG5TjmIQCZTFqPrVc1oIhmLaeE8pyiwht6bJam4nEoYIqO7vm18Xess5lGTy3KS3QAO3/TFBInZB7eX03xY0qlVGAySgkjp4CoViO1m9RJXIq8o0bGb8CEtSuRG+R2azBS6LjLVlQlzc5WmIJ4VWPNqzSuzsxDQF2RVeFtjKntW3rdxCskVFpnCV2Be6BWWB8aaLLvkiCUGM0EM7eMJDGcFo58irMb+d0DKu7HXcUd8dFWHm/nYJjsac3tt8r77khW9vgGgBFiCDS8SzVYVzsnrGSoImJbcT
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 06:36:25.5007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf1da25-b35b-4d7f-fd97-08dea9a77716
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8030
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 06:36:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3900

From: Daniel Turull <daniel.turull@ericsson.com>

- Handle flat tuple format from get_recipe_upgrade_status (scarthgap)
  in addition to the list-of-dicts format (master). Scarthgap's
  _get_recipe_upgrade_status returns a plain tuple of 7 elements per
  recipe; detect this with isinstance(group, tuple) and normalize.
  Add a length assertion to catch upstream schema changes early.
- Fallback to MACHINE env var when bitbake-config-build is not
  available (not present in scarthgap).

Assisted-by: kiro:claude-opus-4.6
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/utils/bitbake.py | 11 +++++++++--
 upgrade-helper.py        | 12 ++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index 5514c98..bd670d0 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -24,6 +24,7 @@
 #
=20
 import os
+import shutil
 from logging import debug as D
 import sys
 import re
@@ -123,8 +124,14 @@ class Bitbake(object):
             env =3D "TCLIBC=3D{}".format(libc)
         else:
             env =3D ""
-        bb.process.run("bitbake-config-build enable-fragment machine/{}".f=
ormat(machine))
-        return self._cmd(recipe, env_var=3Denv)
+        if shutil.which("bitbake-config-build"):
+            bb.process.run("bitbake-config-build enable-fragment machine/{=
}".format(machine))
+            env_var =3D env if env else None
+        else:
+            D("bitbake-config-build not found, using MACHINE env var")
+            env_var =3D "MACHINE=3D{}{}".format(machine,
+                                            " " + env if env else "")
+        return self._cmd(recipe, env_var=3Denv_var)
=20
     def dependency_graph(self, package_list):
         return self._cmd(package_list, "-g")
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..9954a66 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -714,6 +714,18 @@ class UniverseUpdater(Updater):
             pkggroups =3D oe.recipeutils.get_recipe_upgrade_status(layer_r=
ecipes)
=20
             for group in pkggroups:
+
+                # Scarthgap returns flat tuples from _get_recipe_upgrade_s=
tatus();
+                # field order: (pn, status, cur_ver, next_ver, maintainer,
+                # revision, no_upgrade_reason) =E2=80=94 see oe/recipeutil=
s.py.
+                if isinstance(group, tuple):
+                    assert len(group) =3D=3D 7, \
+                        "unexpected tuple length %d from get_recipe_upgrad=
e_status" % len(group)
+                    pn, status, cur_ver, next_ver, maintainer, revision, n=
o_upgrade_reason =3D group
+                    group =3D [{'pn': pn, 'status': status, 'cur_ver': cur=
_ver,
+                              'next_ver': next_ver, 'maintainer': maintain=
er,
+                              'revision': revision, 'no_upgrade_reason': n=
o_upgrade_reason}]
+
                 upgrade_group =3D []
                 for pkg in group:
                     maintainer =3D pkg['maintainer']
--=20
2.34.1


