Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91DCD98F6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 21:52:54 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52743.1781905971583982138
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Jun 2026 14:52:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=tFdHTyPQ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.196.1, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyHENXuxd1MthiAmm5fubdyB9JJvyfx0hhWyYLcnpyTL1mgo5QknLVtZJqOaimszYYHZjqLA1eS788kn4BIfnMDvj9NguCzdt5QcgnlvFc2wMKZvvl9JPor6pcg9AS9HhngTC6QZqAUpx0NEFu1mN1rSa8DTI6hEVEAYu1p3GchTdD5paA+7IARk1MlOnCDsWwqbC6IosHfeyGps/1oWdCZrIOC6pJLj6Kaba/d3eRuu9ogkRnOrIR77x2AV8tMSOP9lQiMmyHlvHBNR7yB4uYOXbd2DcMPbi/U25uAM/qWH2xDebDOkgxMHqM3BGD/JhAtNl1Lqzqiy2mjK7HTIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRUBtJQgw1eeby4yTCJ6r+fgjFQhmsTLrEBQHoY3ZIk=;
 b=sOBx9ux/kzV8ZbtJ/inh0bsW8xkz5QoXFTbCxcbG9liG2weK2XDTaj5z+/tr2X7bKhY7HfMLxDZRgV6/TIEneDwyqAZX1OoRwnN4ar7sThcnl5WGKR4JiFioPtnUOpYh6jVwucjfdaDqP+qFrEwPH8xSBZGNj2mgena0Zrbl/uOHJDuqpotKNGd53hFjxa9f8yaOvDPwZwE7cMHOipDJksILt6yBlGAQmkJrEabKk1rWMeBhcgn0AhB3EPqqimoZaV0o8bKkISHYsQZL+eZxopqa6T1p3WQohBr+55675x5BuQQsWO8pPlR8zUZgj4wqhs70nf5nZVw9Tfy68ujZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRUBtJQgw1eeby4yTCJ6r+fgjFQhmsTLrEBQHoY3ZIk=;
 b=tFdHTyPQC3SYIqsWtyesYuc8Dj4PcYpcKuVWDuuqAAIlzhREBPq/qSGMrJUeuQAfbjKhFK6MrbeubGB/hgVBChmqnL77m7uo19MYURRp9aHcS5ho94q6C6Sb/YYpHdYggTcwGT+GfO9qVY++pXWXrv369JGrttYFsZVJVEIClw0=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 19 Jun
 2026 21:52:45 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::4b) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 21:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 21:52:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 16:52:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 14:52:44 -0700
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 19 Jun 2026 16:52:44 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH 1/1] layerindex: Use settings.DEFAULT_BRANCH instead of hardcoded branch name
Date: Fri, 19 Jun 2026 15:52:52 -0600
Message-ID: <20260619215252.2803094-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: f74b45cc-c25f-4f90-f94a-08dece4d1848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	txfg+ah7L3q4nm0J3dPgDO5ngjbbGmR31tD2lDCtwRnYX4rC8hesVkkMCJN+XLUMdeoKtOtbwDVL3omQF4sLMEO2wyq9GsvlAQnpCbc6Dua66sR8FFZ0UwEtD64hE4n0gn1k4L6AqORRwT9yNKPfy98YttIRA2snyKNEqg76FeXYLyPlNq0/oBidZ932ZHIdTjeCY/t05TWK3ZTGRd3iKZxKLzMcy3Cu/EsKnRNnZtRQsSrESym+WOfhqRmXGM+oxruBU7E81zbc+uK1r+kPnosDZrxVl53QlYBHr6Y2UF3I0hcaqbhw9obZVOOgUCGkdLBcxO6gx45ZtVPVGLUtQxEFH0QNsCNda3fTuXDg54VA0vfwJPs7zovXwpw3Wt1XZQLMdygpAzssdL0dMmtal/DClcdG/QQ+TunmClKILauoZLsI+zumIRUMhyEmQ2m9gdUz3c0qJUjvGj/00LZiiSL3FM8TBwu+5Clo+iisnCLx2DOn1ouT/TfdFzHZhe8YNRrGB34uVfPb6uXp18NCrFlQAiyN4+Ps0AmHK4mLYAIftrerC4R1y/pRrdl+hEZdAXd9JhM9Z6hdNx3qZbBtzAi6yoXdmjq3brtYA96ZHPhTDbVJF8WlpusbMNUfQ12lG9j2Ym7ekBIHTz3CUBaETLtYaYM7Bb+QflPglSiFglJi3JMP0KYfVbk+DZ2wkp5K03kqDiIIyty/pBNkMC8jvg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7ccGHfY69XiGWdi6sGF1qrEZGv0wrSffTOgZ86usPTKj7MqGsF6ZZSws6H69AmEn4kN18mO8mRyUY5QaQlzyJ5nOZKAsSCTAjBdvCADNrSCsMScUIWeBU6NnSd4HNDuy0Np5x1YVqVF6rNyJgRB61Guog+qa3njjX+A+fSP52YhBU2rUBXcY6htMqcs+NV8DffZCdIqj+X2bQDrafFtt2JExCtJpSlJTY6CtMJArdjovSmgVI++K5r3RFmMMEhSV8h/w3eWuATA3AOk7yOkha1cnkFLg4l4uzPxIkdm+s6d7JdPfOL2cdKjfSephoUebQVRCERoHb5vf66dGvFMCaKP+AWgt9L91dqflbhS1VY9+fQME9/IA50qBSVBBdSeZQmy802GtvYJLkQGShglLdSKzA0byTHOOUtpUspE5i9f3InQmyf732VdNFLqEuh56
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 21:52:44.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74b45cc-c25f-4f90-f94a-08dece4d1848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jun 2026 21:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4251

Replace all hardcoded branch name references with settings.DEFAULT_BRANCH
so the default branch can be changed from a single location in settings.py
without modifying individual source files. DEFAULT_BRANCH defaults to 'mast=
er'.

- settings.py: add DEFAULT_BRANCH =3D 'master'
- docker/settings.py: add DEFAULT_BRANCH =3D 'master'
- layerindex/urls.py: use _DEFAULT_BRANCH from settings
- layerindex/views.py: use settings.DEFAULT_BRANCH (10 occurrences)
- layerindex/models.py: add import settings; use settings.DEFAULT_BRANCH
- layerindex/update.py: use settings.DEFAULT_BRANCH
- layerindex/update_layer.py: resolve branch from settings.DEFAULT_BRANCH
- layerindex/bulkchange.py: use settings.DEFAULT_BRANCH
- layerindex/tools/import_layer.py: use settings.DEFAULT_BRANCH
- layerindex/tools/import_wiki_layers.py: add import settings; use DEFAULT_=
BRANCH
- layerindex/tools/import_classic_wiki.py: add import settings; use DEFAULT=
_BRANCH
- layerindex/tools/update_classic_status.py: add import settings; use DEFAU=
LT_BRANCH
- rrs/tools/historytool.py: use settings.DEFAULT_BRANCH

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 docker/settings.py                        |  2 ++
 layerindex/bulkchange.py                  |  2 +-
 layerindex/models.py                      |  5 +++--
 layerindex/tools/import_classic_wiki.py   |  3 ++-
 layerindex/tools/import_layer.py          |  4 ++--
 layerindex/tools/import_wiki_layers.py    |  3 ++-
 layerindex/tools/update_classic_status.py |  7 ++++---
 layerindex/update.py                      |  2 +-
 layerindex/update_layer.py                |  4 +++-
 layerindex/urls.py                        | 16 +++++++++-------
 layerindex/views.py                       | 20 ++++++++++----------
 rrs/tools/historytool.py                  |  4 ++--
 settings.py                               |  3 +++
 13 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/docker/settings.py b/docker/settings.py
index e3ae0fd..85b7efd 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -315,3 +315,5 @@ SECURE_PROXY_SSL_HEADER =3D ('HTTP_X_FORWARDED_PROTO', =
'https')
 SECURE_BROWSER_XSS_FILTER =3D True
 SECURE_CONTENT_TYPE_NOSNIFF =3D True
=20
+# Default branch name used across the layer index
+DEFAULT_BRANCH =3D 'master'
diff --git a/layerindex/bulkchange.py b/layerindex/bulkchange.py
index 0ec4058..11cd7a6 100644
--- a/layerindex/bulkchange.py
+++ b/layerindex/bulkchange.py
@@ -98,7 +98,7 @@ def main():
     utils.setup_django()
     import settings
=20
-    branch =3D utils.get_branch('master')
+    branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
     fetchdir =3D settings.LAYER_FETCH_DIR
=20
     import layerindex.models import LayerItem
diff --git a/layerindex/models.py b/layerindex/models.py
index 864264b..7a09962 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -18,6 +18,7 @@ import os.path
 import re
 import posixpath
 import codecs
+import settings
=20
 from . import utils
=20
@@ -190,7 +191,7 @@ class LayerItem(models.Model):
         return fetch_dir
=20
     def get_absolute_url(self):
-        return reverse('layer_item', args=3D('master',self.name));
+        return reverse('layer_item', args=3D(settings.DEFAULT_BRANCH,self.=
name));
=20
     def __str__(self):
         return self.name
@@ -672,7 +673,7 @@ class ClassicRecipe(Recipe):
         ('E', 'Equivalent functionality'),
         ('D', 'Direct match'),
     ]
-    cover_layerbranch =3D models.ForeignKey(LayerBranch, verbose_name=3D'C=
overing layer', blank=3DTrue, null=3DTrue, limit_choices_to =3D {'branch__n=
ame': 'master'}, on_delete=3Dmodels.SET_NULL)
+    cover_layerbranch =3D models.ForeignKey(LayerBranch, verbose_name=3D'C=
overing layer', blank=3DTrue, null=3DTrue, limit_choices_to =3D {'branch__n=
ame': settings.DEFAULT_BRANCH}, on_delete=3Dmodels.SET_NULL)
     cover_pn =3D models.CharField('Covering recipe', max_length=3D100, bla=
nk=3DTrue)
     cover_status =3D models.CharField(max_length=3D1, choices=3DCOVER_STAT=
US_CHOICES, default=3D'U')
     cover_verified =3D models.BooleanField(default=3DFalse)
diff --git a/layerindex/tools/import_classic_wiki.py b/layerindex/tools/imp=
ort_classic_wiki.py
index bd7ab9a..e8c4c8c 100755
--- a/layerindex/tools/import_classic_wiki.py
+++ b/layerindex/tools/import_classic_wiki.py
@@ -84,6 +84,7 @@ def main():
     options, args =3D parser.parse_args(sys.argv)
=20
     utils.setup_django()
+    import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicR=
ecipe
     from django.db import transaction
=20
@@ -178,7 +179,7 @@ def main():
                             res =3D list(LayerItem.objects.filter(name=3Dn=
ewlayer)[:1])
                             if res:
                                 newlayeritem =3D res[0]
-                                recipe.cover_layerbranch =3D newlayeritem.=
get_layerbranch('master')
+                                recipe.cover_layerbranch =3D newlayeritem.=
get_layerbranch(settings.DEFAULT_BRANCH)
                             else:
                                 logger.info('Replacement layer "%s" for %s=
 could not be found' % (newlayer, pn))
                         recipe.cover_pn =3D newpn
diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_lay=
er.py
index 79c679e..cdbd40d 100755
--- a/layerindex/tools/import_layer.py
+++ b/layerindex/tools/import_layer.py
@@ -284,7 +284,7 @@ def main():
     if not os.path.exists(fetchdir):
         os.makedirs(fetchdir)
=20
-    master_branch =3D utils.get_branch('master')
+    master_branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
     core_layer =3D None
     try:
         with transaction.atomic():
@@ -311,7 +311,7 @@ def main():
                 logger.error("Fetch failed: %s" % str(e))
                 sys.exit(1)
=20
-            actual_branch =3D 'master'
+            actual_branch =3D settings.DEFAULT_BRANCH
             if (options.actual_branch):
                 actual_branch =3D options.actual_branch
             try:
diff --git a/layerindex/tools/import_wiki_layers.py b/layerindex/tools/impo=
rt_wiki_layers.py
index 061f6df..f287bf6 100755
--- a/layerindex/tools/import_wiki_layers.py
+++ b/layerindex/tools/import_wiki_layers.py
@@ -35,6 +35,7 @@ def main():
     options, args =3D parser.parse_args(sys.argv)
=20
     utils.setup_django()
+    import settings
     from layerindex.models import LayerItem, LayerBranch, LayerDependency
     from django.db import transaction
=20
@@ -49,7 +50,7 @@ def main():
         nowiki_re =3D re.compile(r'</?nowiki>')
         link_re =3D re.compile(r'\[(http.*) +link\]')
         readme_re =3D re.compile(r';f=3D[a-zA-Z0-9/-]*README;')
-        master_branch =3D utils.get_branch('master')
+        master_branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
         core_layer =3D None
         with transaction.atomic():
             for line in data.splitlines():
diff --git a/layerindex/tools/update_classic_status.py b/layerindex/tools/u=
pdate_classic_status.py
index aa5d2ef..c8c373b 100755
--- a/layerindex/tools/update_classic_status.py
+++ b/layerindex/tools/update_classic_status.py
@@ -83,6 +83,7 @@ def main():
     args =3D parser.parse_args()
=20
     utils.setup_django()
+    import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicR=
ecipe, Update, ComparisonRecipeUpdate
     from django.db import transaction
=20
@@ -121,7 +122,7 @@ def main():
     try:
         with transaction.atomic():
             def recipe_pn_query(pn):
-                return Recipe.objects.filter(layerbranch__branch__name=3D'=
master').filter(pn=3Dpn).order_by('-layerbranch__layer__index_preference')
+                return Recipe.objects.filter(layerbranch__branch__name=3Ds=
ettings.DEFAULT_BRANCH).filter(pn=3Dpn).order_by('-layerbranch__layer__inde=
x_preference')
=20
             if args.import_data:
                 recipequery =3D ClassicRecipe.objects.filter(layerbranch=
=3Dlayerbranch)
@@ -141,9 +142,9 @@ def main():
                         orig_layerbranch =3D recipe.cover_layerbranch
                         recipe.cover_layerbranch =3D layerbranches.get(cov=
er_layer, None)
                         if recipe.cover_layerbranch is None:
-                            recipe.cover_layerbranch =3D LayerBranch.objec=
ts.filter(branch__name=3D'master', layer__name=3Dcover_layer).first()
+                            recipe.cover_layerbranch =3D LayerBranch.objec=
ts.filter(branch__name=3Dsettings.DEFAULT_BRANCH, layer__name=3Dcover_layer=
).first()
                             if recipe.cover_layerbranch is None:
-                                logger.warning('Could not find cover layer=
 %s in master branch' % cover_layer)
+                                logger.warning('Could not find cover layer=
 %s in %s branch' % (cover_layer, settings.DEFAULT_BRANCH))
                             else:
                                 layerbranches[cover_layer] =3D recipe.cove=
r_layerbranch
                         if orig_layerbranch !=3D recipe.cover_layerbranch:
diff --git a/layerindex/update.py b/layerindex/update.py
index df3939f..788daee 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -333,7 +333,7 @@ def main():
=20
             # Get a safe bitbake branch to call into from this script (use=
d later on)
             safe_bitbake_branch =3D 'origin/master'
-            master_branch =3D Branch.objects.filter(name=3D'master').first=
()
+            master_branch =3D Branch.objects.filter(name=3Dsettings.DEFAUL=
T_BRANCH).first()
             if master_branch and master_branch.bitbake_branch:
                 safe_bitbake_branch =3D 'origin/' + master_branch.bitbake_=
branch
=20
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 33c5cfb..6248f78 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -250,7 +250,7 @@ def main():
=20
     parser.add_option("-b", "--branch",
             help =3D "Specify branch to update",
-            action=3D"store", dest=3D"branch", default=3D'master')
+            action=3D"store", dest=3D"branch", default=3D'')
     parser.add_option("-l", "--layer",
             help =3D "Layer to update",
             action=3D"store", dest=3D"layer")
@@ -304,6 +304,8 @@ def main():
=20
     logger.setLevel(options.loglevel)
=20
+    if not options.branch:
+        options.branch =3D settings.DEFAULT_BRANCH
     branch =3D utils.get_branch(options.branch)
     if not branch:
         logger.error("Specified branch %s is not valid" % options.branch)
diff --git a/layerindex/urls.py b/layerindex/urls.py
index 51a832d..e7b0531 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -20,6 +20,8 @@ from layerindex.views import LayerListView, LayerReviewLi=
stView, LayerReviewDeta
 from layerindex.models import LayerItem, Recipe, RecipeChangeset
 from rest_framework import routers
 from . import restviews
+import settings as _settings
+_DEFAULT_BRANCH =3D getattr(_settings, 'DEFAULT_BRANCH', 'master')
=20
 router =3D routers.DefaultRouter()
 router.register(r'branches', restviews.BranchViewSet)
@@ -39,23 +41,23 @@ router.register(r'incFiles', restviews.IncFileViewSet)
=20
 urlpatterns =3D [
     re_path(r'^$',
-        RedirectView.as_view(url=3Dreverse_lazy('layer_list', args=3D('mas=
ter',)), permanent=3DFalse),
+        RedirectView.as_view(url=3Dreverse_lazy('layer_list', args=3D(_DEF=
AULT_BRANCH,)), permanent=3DFalse),
         name=3D'frontpage'),
=20
     re_path(r'^api/', include(router.urls)),
=20
     re_path(r'^layers/$',
-        RedirectView.as_view(url=3Dreverse_lazy('layer_list', args=3D('mas=
ter',)), permanent=3DFalse)),
+        RedirectView.as_view(url=3Dreverse_lazy('layer_list', args=3D(_DEF=
AULT_BRANCH,)), permanent=3DFalse)),
     re_path(r'^layer/(?P<slug>[-\.\w]+)/$',
-        RedirectParamsView.as_view(permanent=3DFalse), {'redirect_name': '=
layer_item', 'branch': 'master'}),
+        RedirectParamsView.as_view(permanent=3DFalse), {'redirect_name': '=
layer_item', 'branch': _DEFAULT_BRANCH}),
     re_path(r'^recipes/$',
-        RedirectView.as_view(url=3Dreverse_lazy('recipe_search', args=3D('=
master',)), permanent=3DFalse)),
+        RedirectView.as_view(url=3Dreverse_lazy('recipe_search', args=3D(_=
DEFAULT_BRANCH,)), permanent=3DFalse)),
     re_path(r'^machines/$',
-        RedirectView.as_view(url=3Dreverse_lazy('machine_search', args=3D(=
'master',)), permanent=3DFalse)),
+        RedirectView.as_view(url=3Dreverse_lazy('machine_search', args=3D(=
_DEFAULT_BRANCH,)), permanent=3DFalse)),
     re_path(r'^distros/$',
-        RedirectView.as_view(url=3Dreverse_lazy('distro_search', args=3D('=
master',)), permanent=3DFalse)),
+        RedirectView.as_view(url=3Dreverse_lazy('distro_search', args=3D(_=
DEFAULT_BRANCH,)), permanent=3DFalse)),
     re_path(r'^classes/$',
-        RedirectView.as_view(url=3Dreverse_lazy('class_search', args=3D('m=
aster',)), permanent=3DFalse)),
+        RedirectView.as_view(url=3Dreverse_lazy('class_search', args=3D(_D=
EFAULT_BRANCH,)), permanent=3DFalse)),
     re_path(r'^submit/$', edit_layer_view, {'template_name': 'layerindex/s=
ubmitlayer.html'}, name=3D"submit_layer"),
     re_path(r'^submit/thanks/$',
         TemplateView.as_view(
diff --git a/layerindex/views.py b/layerindex/views.py
index 84750f7..d3d8181 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -114,7 +114,7 @@ def delete_layer_view(request, template_name, slug):
         raise PermissionDenied
     if request.method =3D=3D 'POST':
         layeritem.delete()
-        return HttpResponseRedirect(reverse('layer_list', args=3D('master'=
,)))
+        return HttpResponseRedirect(reverse('layer_list', args=3D(settings=
.DEFAULT_BRANCH,)))
     else:
         return render(request, template_name, {
             'object': layeritem,
@@ -122,7 +122,7 @@ def delete_layer_view(request, template_name, slug):
             'cancel_url': layeritem.get_absolute_url()
         })
=20
-def update_layer_view(request, template_name, branch=3D'master', slug=3DNo=
ne):
+def update_layer_view(request, template_name, branch=3Dsettings.DEFAULT_BR=
ANCH, slug=3DNone):
     if not (request.user.is_authenticated and request.user.is_staff):
         raise PermissionDenied
     return_url =3D None
@@ -157,7 +157,7 @@ def update_layer_view(request, template_name, branch=3D=
'master', slug=3DNone):
=20
     return HttpResponseRedirect(reverse_lazy('task_status', kwargs=3D{'tas=
k_id': task_id}))
=20
-def edit_layer_view(request, template_name, branch=3D'master', slug=3DNone=
):
+def edit_layer_view(request, template_name, branch=3Dsettings.DEFAULT_BRAN=
CH, slug=3DNone):
     return_url =3D None
     branchobj =3D Branch.objects.filter(name=3Dbranch)[:1].get()
     if slug:
@@ -444,7 +444,7 @@ class LayerReviewListView(ListView):
         return super(LayerReviewListView, self).dispatch(request, *args, *=
*kwargs)
=20
     def get_queryset(self):
-        return LayerBranch.objects.filter(branch__name=3D'master').filter(=
layer__status=3D'N').order_by('layer__name')
+        return LayerBranch.objects.filter(branch__name=3Dsettings.DEFAULT_=
BRANCH).filter(layer__status=3D'N').order_by('layer__name')
=20
 class LayerDetailView(DetailView):
     model =3D LayerItem
@@ -492,7 +492,7 @@ class LayerReviewDetailView(LayerDetailView):
         return super(LayerReviewDetailView, self).dispatch(request, *args,=
 **kwargs)
=20
     def get_context_data(self, **kwargs):
-        self.kwargs['branch'] =3D 'master'
+        self.kwargs['branch'] =3D settings.DEFAULT_BRANCH
         context =3D super(LayerReviewDetailView, self).get_context_data(**=
kwargs)
         return context
=20
@@ -738,7 +738,7 @@ class AdvancedRecipeSearchView(ListView):
                 query =3D Q(**{"%s__icontains" % field: value})
             else:
                 query =3D Q(**{"%s" % field: value})
-            queryset =3D Recipe.objects.filter(layerbranch__branch__name=
=3D'master')
+            queryset =3D Recipe.objects.filter(layerbranch__branch__name=
=3Dsettings.DEFAULT_BRANCH)
             layer =3D self.request.GET.get('layer', '')
             if layer:
                 queryset =3D queryset.filter(layerbranch__layer=3Dlayer)
@@ -825,7 +825,7 @@ class BulkChangeSearchView(AdvancedRecipeSearchView):
     def get_context_data(self, **kwargs):
         context =3D super(BulkChangeSearchView, self).get_context_data(**k=
wargs)
         context['changeset'] =3D self.changeset
-        context['current_branch'] =3D 'master'
+        context['current_branch'] =3D settings.DEFAULT_BRANCH
         return context
=20
=20
@@ -1341,7 +1341,7 @@ class ClassicRecipeSearchView(RecipeSearchView):
             filtered =3D True
         qs, filtered =3D self.search_recipe_query(init_qs, query_string, p=
referred=3DFalse)
         if qreversed:
-            init_rqs =3D Recipe.objects.filter(layerbranch__branch__name=
=3D'master')
+            init_rqs =3D Recipe.objects.filter(layerbranch__branch__name=
=3Dsettings.DEFAULT_BRANCH)
             if layer_ids:
                 init_rqs =3D init_rqs.filter(layerbranch__layer__id__in=3D=
layer_ids)
             excludeclasses_param =3D self.request.GET.get('excludeclasses'=
, '')
@@ -1735,7 +1735,7 @@ class ComparisonRecipeSelectView(ClassicRecipeSearchV=
iew):
         return True
=20
     def get_context_data(self, **kwargs):
-        self.kwargs['branch'] =3D 'master'
+        self.kwargs['branch'] =3D settings.DEFAULT_BRANCH
         context =3D super(ComparisonRecipeSelectView, self).get_context_da=
ta(**kwargs)
         recipe =3D get_object_or_404(ClassicRecipe, pk=3Dself.kwargs['pk']=
)
         context['select_for'] =3D recipe
@@ -1761,7 +1761,7 @@ class ComparisonRecipeSelectView(ClassicRecipeSearchV=
iew):
             layer_ids =3D [int(i) for i in selectedlayers_param.split(',')=
]
         else:
             layer_ids =3D []
-        init_qs =3D Recipe.objects.filter(layerbranch__branch__name=3D'mas=
ter')
+        init_qs =3D Recipe.objects.filter(layerbranch__branch__name=3Dsett=
ings.DEFAULT_BRANCH)
         if layer_ids:
             init_qs =3D init_qs.filter(layerbranch__layer__in=3Dlayer_ids)
         qs, _ =3D self.search_recipe_query(init_qs, query_string, preferre=
d=3DFalse)
diff --git a/rrs/tools/historytool.py b/rrs/tools/historytool.py
index 9f03ade..92e4b04 100755
--- a/rrs/tools/historytool.py
+++ b/rrs/tools/historytool.py
@@ -77,7 +77,7 @@ def rrs_import(args):
     if not core_layer:
         logger.error('Unable to find core layer %s' % settings.CORE_LAYER_=
NAME)
         return 1
-    core_layerbranch =3D core_layer.get_layerbranch('master')
+    core_layerbranch =3D core_layer.get_layerbranch(settings.DEFAULT_BRANC=
H)
     if not core_layerbranch:
         logger.error('Unable to find branch master of layer %s' % core_lay=
erbranch.name)
         return 1
@@ -130,7 +130,7 @@ def rrs_remove_duplicates(args):
     if not core_layer:
         logger.error('Unable to find core layer %s' % settings.CORE_LAYER_=
NAME)
         return 1
-    core_layerbranch =3D core_layer.get_layerbranch('master')
+    core_layerbranch =3D core_layer.get_layerbranch(settings.DEFAULT_BRANC=
H)
     if not core_layerbranch:
         logger.error('Unable to find branch master of layer %s' % core_lay=
erbranch.name)
         return 1
diff --git a/settings.py b/settings.py
index 94b3dd1..08004cb 100644
--- a/settings.py
+++ b/settings.py
@@ -299,3 +299,6 @@ TASK_LOG_DIR =3D "/tmp/layerindex-task-logs"
=20
 # Full path to directory where rrs tools stores logs
 TOOLS_LOG_DIR =3D ""
+
+# Default branch name used across the layer index
+DEFAULT_BRANCH =3D 'master'
--=20
2.43.0


