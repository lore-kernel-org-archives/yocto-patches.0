Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E14EE9DE70
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.127865.1775725714806929004
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=fUR6FwC+;
 spf=pass (domain: ericsson.com, ip: 40.107.159.63, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRSnx8qRenQu2w/bYP2HMdo3oGXr0V7rv1LsvSPt8+g/w1D9yPviahJ0Fz9TteMd1uFLx1Qqltxc96O9EEXyNWAjndg0Nf53BLXDo5ruF9V9yLvwrPVB4qnMdarLqta/De9l87eXXJos7Nvcw2plE9DQCRQeNSyProhYZkAHe8vlTjT9aAgxT0toeIAsdSVnvhYSDvKYBcAjtWhjcHQOGNIn0VO1Cqu0hr8Ob04/ShsSuDTR4eFwINkGstasllH23yYCvqnojSMjOu8Dofnq4ExkBdRmbkal/V+i4FOn76XqCtUcUH2rtzlgXCombz5lsYwMCF/5KDy7Uw+ukKa3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svLAzzyfu3lCNFUOub7AezKO/5oZ5Ejo5SVI5D+37wg=;
 b=QuS5yWHWo4J1YBPW9OA7l/dgYZ+KdoMoqcxz1wmr516VD9JB/O2c3R1ezD0b9cBOM9w2SaOl588CE7G6XHsLXflWCCDAJmm5eeNODqSO494X65CljbFENayGrSIJsSAQ4Ki/gxJlDaAGNjLuK5bEgjQdg27ESTNHJBzBG3qvS6HinK5WlOqxsg31SzEmEcrcDbQK/F3csFhgHLfSQRCcDCykLZT7daBUr+fWsOFu3my4lPZgQ084wIJQn9NdFLTnOmh85Gq7LppszxbJ5xNaeDTZbsgYVWWXmkMloupEsgNKlpC55Q8CfiPnmufCw4FUwitdMlS6+OUwrkZCa8VOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svLAzzyfu3lCNFUOub7AezKO/5oZ5Ejo5SVI5D+37wg=;
 b=fUR6FwC+FyNoUUlnSRa766rC4n5TP/O825x/I0pIqEz7pGFwQFx9KH5Veqf4QuJLv91PMnpJnpKGR3zuuXGvkVBk0Z1XBTFNfj4lyn/b6MJcHCKkA03xu6XXkJPZZ7F9IzYTd7I88ax47aTdkzS0HVEvbAKrK6zdmovcsUdz4wjcfYNjTk5UMwnw9GcE9HGlz/0yApIur6heKQW72GOn5U+6gkmJs0b7/wE9E6PAT/ts/n+2/KZZvt4yrVwIeC1oM1wpJRLn93UKVMF7Or/lkvgMLFfAgdobom4Apk6cGrNyxaYmYqfpKe4Im3QuRXPCRp+cz0H3mWGsxEvkVvMSvw==
Received: from DU2PR04CA0246.eurprd04.prod.outlook.com (2603:10a6:10:28e::11)
 by PR3PR07MB7020.eurprd07.prod.outlook.com (2603:10a6:102:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:08:29 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::53) by DU2PR04CA0246.outlook.office365.com
 (2603:10a6:10:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 09:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 9 Apr 2026 09:08:28 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 1F7A54020B70;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0C58B700DB92; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 1/6] upgrade-helper.py: Add compatibility with Yocto scarthgap
Date: Thu, 9 Apr 2026 11:08:10 +0200
Message-ID: <20260409090815.1731294-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PR3PR07MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: ea40926e-c882-4114-6d1c-08de961790c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	MZ1b0U9XsVDE87EMHHG++ownPzxBXV9KUdiRzFh6MVIAIoLgTqf8nwbF8NgFFA+wBHQ5okscF9qZmOYv1BJeJtKAgsXXgVcs6sAVjCTDBedpU/2JvRlF/olV/OU4Engl3b9L6wvLQ2qcRdJ8quUdwlXHIjK+zWebu97Tly4ydiV5+uHUGjKEcrVBuynP0P8Nr4rB2d4RpHqKulxZ6ln5rBIKLfkgBif5/SrM4RDLhTQnFMGtCgh99FkZ/kxM0GBvu4qOgpYSsVf4YNuKfTCdWg6U67Q9ktMcXofmOxkqnGkbbRH9Y7y8+fyeTsonnCdP4umTBXmRLqlzpfvMAxcTP6LyZF/KPV43jyLznXS8tDKfMWZhjj3tHz8b9ew2aeVTkH76JkukjU3FSJN/uGiYqjmImPvxGznIKIdrJ8O4oUWM6gt9SqEbSJi0QoEGwVGdNTvdMwpEeAr/hiVdHfol1YdI/9au+3vt9Z826Z19hCiPXW+LnoRA2So4nJQO2KO+qp8YcqEeT4WUlIjPadGCbR9B1q0iTkHrFtkgR6BNLchHCgZImXb9vwIMjfE9yE66UIQK0z6YTHpFCJ6HcZgvViAxbvW6eHUY7IBcjLQjpGykF5gHxNuqhlkhRc8NhnnPXiau76b5P2NoIGEX4n4WSXOBaN4wOOpsoU/FOaKHhe4yBCoAwjaLOe7WpMRsy7h08EateVsgX3Mq+n+fHwI5l8A2kERNwIEFFSqmeZpHPhkl+aO/Rk0ocAlYBHE6yUuoHXbeVcnoWkrXB/n3Vxy90g==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Y2B0GYnRnTElTqFIqlwfjhXwrGurqoi1buhQJ30fqQ2l4UbD+I9z5K062cS/ebiqqMve7rGy37ZXaBJhxb1WVSsCSSJqILRhesksfSnu9F7ji9/Fg4fJuft2v0nNhhJlW0KwEJMJNYRTJfpFYBF3HBwJ/7ldpJMnyi6NeLQfafhB7O14O63VvXIfrFLD1GKNp6i9KvKAKddxAJYIj16Nlj6ZbwS0TdTG215YjfF9c+BCr2CB+tWEcI5z724MJxQbOvQtVPjrWxs5G6j6XJG99wxReToSe3X2TgyRQ3xz67nAjTlteR2B2nsWCMpAWX3y7EWBjRgezzayuW6eDv7TOy/1qi63XqgrAjKU2xRzpWN7R6cjYXmsdNgqomWnOsKeFtQklSzfScRWEEnz0LXGCpb/unHXvcU4JK2ydd34mJs9fjhQXqvJivFOiAU/Pspb
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:28.9652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea40926e-c882-4114-6d1c-08de961790c5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB7020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3668

From: Daniel Turull <daniel.turull@ericsson.com>

- Handle flat tuple format from get_recipe_upgrade_status (scarthgap)
  in addition to the list-of-dicts format (master)
- Fallback to MACHINE env var when bitbake-config-build is not available
- Resolve symlinks in recipe_dir with os.path.realpath()
- Handle fetch errors gracefully when iterating upgrade candidates,
  skipping unreachable upstreams instead of aborting the entire run

  Without this fix, a single unreachable upstream crashes the run:

  bb.fetch2.FetchError: Fetcher failure: Fetch command [...]
  git ls-remote https://git.savannah.gnu.org/git/config.git
  failed with exit code 128, output:
  fatal: unable to access [...]: Failed to connect to
  git.savannah.gnu.org port 443: Couldn't connect to server

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py         |  2 +-
 modules/utils/bitbake.py |  8 ++++++--
 upgrade-helper.py        | 21 ++++++++++++++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index a6ec341..b3ec61c 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -36,7 +36,7 @@ def load_env(devtool, bb, git, opts, group):
     os.mkdir(group['workdir'])
     for pkg_ctx in group['pkgs']:
         pkg_ctx['env'] =3D bb.env(pkg_ctx['PN'])
-        pkg_ctx['recipe_dir'] =3D os.path.dirname(pkg_ctx['env']['FILE'])
+        pkg_ctx['recipe_dir'] =3D os.path.realpath(os.path.dirname(pkg_ctx=
['env']['FILE']))
=20
 def buildhistory_init(devtool, bb, git, opts, group):
     if not opts['buildhistory']:
diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index 5514c98..f6821bc 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -123,8 +123,12 @@ class Bitbake(object):
             env =3D "TCLIBC=3D{}".format(libc)
         else:
             env =3D ""
-        bb.process.run("bitbake-config-build enable-fragment machine/{}".f=
ormat(machine))
-        return self._cmd(recipe, env_var=3Denv)
+        try:
+            bb.process.run("bitbake-config-build enable-fragment machine/{=
}".format(machine))
+        except bb.process.ExecutionError:
+            # bitbake-config-build not available (e.g. scarthgap), use MAC=
HINE env var
+            env =3D "MACHINE=3D{} {}".format(machine, env).strip()
+        return self._cmd(recipe, env_var=3Denv if env else None)
=20
     def dependency_graph(self, package_list):
         return self._cmd(package_list, "-g")
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..68f315b 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -713,7 +713,26 @@ class UniverseUpdater(Updater):
         for layer_name, layer_recipes in self.recipes:
             pkggroups =3D oe.recipeutils.get_recipe_upgrade_status(layer_r=
ecipes)
=20
-            for group in pkggroups:
+            # Consume the generator one item at a time so that a fetch
+            # failure for one recipe (e.g. unreachable upstream) does not
+            # abort the entire upgrade run.
+            while True:
+                try:
+                    group =3D next(pkggroups)
+                except StopIteration:
+                    break
+                except Exception as e:
+                    W(" Skipping recipe due to fetch error: %s" % str(e))
+                    continue
+
+                # Scarthgap returns flat tuples; normalize to list-of-dict=
s
+                # so the existing loop handles both formats.
+                if not isinstance(group, (list, tuple)) or not group or no=
t isinstance(group[0], dict):
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

