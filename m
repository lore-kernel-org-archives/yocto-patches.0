Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1031F46C69
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:30:08 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60416.1775496604086317361
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 10:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=kb88lMzk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.198.34, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIwfAwL0CYmXqOpQgfdMGFsttpEUdfRRIJom1ZZ6uJbwzMh9dJkErDlO8WJxIndOpaDizRPOi/L0uR+vni9SKj43nDjIYDigKxsp+AAKzDAxyMptI/5KPr+tk5cxnHPpdvwuOQWbPpibsRNBkgOUowsGo/I0KeVsLZ/iAQiq/leAMqwXrqwbajO7qzXQhzUzNZpSASvrt8NCYNY1Uaotd85BLlrtHt5Dvq7okvSu3Cx7/sm4rPpHjk/K+/SjPU5YmeWluresk02B4wProcHgmn8xTbhJmUxoe3AkiTwiz++JHh/yBxTF9XARyceolnspT9+jDHud/fqXr4LnQ6nCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCOo6i3L3jywv0NzEs33nuDWDAQyMZ9nf3FcTwjKvVI=;
 b=zKFoLVAUNFgMgfJu3/KQ39LEPPnMd3Z1ZeavAFozglSnY9B6rhWdQeGqOMNs31pSRUwLE+AqaF+rz6izTZS3mRacK5u9bGSU5+6gXFK4nKNbyfgqylYsp7fW0VGt9IfIJCtB61IHYihW0k9KOOmjCWT1WuuCZBBPon74/gGSS7S2KnE6Vslol2XLVdsLPPqdNZy54SGDjY92uXgHiwbLdda3srjBtMXnpKQFhzb+m3S1umFf8wdEJ+zx2xfG48ykSUqmuIuXywnK9LJID/f9JWPe2m4UJGZkMwdWYKHCp7diTXDbWKEif5q0N9fG3QP7Pn0Qdry5adIO1SyfRdNTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCOo6i3L3jywv0NzEs33nuDWDAQyMZ9nf3FcTwjKvVI=;
 b=kb88lMzkySwQY+E6mBkriExshA7WUSqQh02nOvnhBAJEs9Kwzfr/q2EwsneXNvWMmJZTDYdTeP5gJAQxDghsCb/vX0txKynX9uKDM93vdRyq5itjVG1BO9nGz+wZm3iCsEnd8OjtjQr/wpcDzXXYE6geIV1l6ZBKJQM2Ncmn+sU=
Received: from PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::8)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:29:59 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::9c) by PH8P223CA0002.outlook.office365.com
 (2603:10b6:510:2db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 17:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 17:29:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 12:29:54 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 12:29:54 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH v2 4/4] README: Document --app-dir option usage
Date: Mon, 6 Apr 2026 11:30:10 -0600
Message-ID: <20260406173010.1366742-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
References: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 791951d5-0f43-4da4-ec7f-08de940220d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Mc93YHYdaqYJgEcS1NiZeG88eqnK1JGjjcVP1kQwFizYY6EJKM+ylhAUUhwsZrbjYNZm9idgm+P+tOw9PHCG8xvCnusMv9/Ag4BWNHUBmR2kFCbvASwf40zodGn++di8267Gm+r49Z50y5PJcG3K7d1HrEQBZHpeFiLr5x4DXZPdrnFXpVkNcLRtHVizUjJ1ZCE9psAJ3Io6w5nt06t+ko9uYI0dr20QrCku9EZgLoBNsB0N8Rh/O+1TKnDWMJStFNpdNa45y0z3cFZ7zKaUrdRXoy3ljO3/wuiN0Q08JiTlYan8EbjpEHyeRwLTuhgmL8qFvPXZabceY9EuJ9/Mtfk9zUVcrJuHwP5N/lTd2MYy37h88Gw8cfG6apUggNmqM45FkCk0wBMqeYvoJXQoI0mhC9scL85g/EQeQUG/KyCd+7f6PI6jZqGXgfnjft16RiDhWQmGndfdQ3vb/7vgpitdmdW1wAyvoKeP2Xj6ApClYgEJx1v7R4MNWqjUpgY5S0CwaqArTHsomktm+FDtGAZXvGtDrQPRL6xI167qBxQ0W+eBSHvHe/D0hx5cUIrgh4zK8U0y4cUSrELYFt/KGE6O+GCVxIfJEUiU+MBc67OHQGZZ224on9iY6Jz/EVH4hZhmIuZSrnLJeiHlk/8Y5eKYTixvRUz+ZrHC9JgoBNKxPIlD12NPmwN0E1wfJI11RUcymOA75+miyIWy6SVKEw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	4cVwSxIHP6uyvnVYG9BAlSk0fjyUdoEj1jRR74xOl8JsP1QJWXsN9lLCRES5lerOLbHVLuCKqGhGtMB5ZtEzuEU7dV0weXuq/cyvrbix6rSGBKsRdnLNzPNeTbDuWYnnZttrFIHF9dpSAph1/Aw5qk6kbqqu7jf1efcO2eUM5fNdAVoT3m/oADMVtY3BYm/FoFWTTo8zTEkVnSWyyaFBj57aItKbVqbvNewnAuXO43HmzOsCbWmjXNg9YJPNC1LHaF/KEI+g8nh4q6YwZrFQG1jbw+VWuV1ALUlbtYiXKI1U6J+40NAI7ySvkMuBAzpXp6x1199TpbS1QMMQFUqfqH/1TI1UPrH2bGUs1oNa0wBsS4SbQyzvDJize0j1PSHLBCO7+gOsIWzmf/aFrtJzp346M7xPd3KoR/t3+FItXqYF8z3CdqAMBOwUVAiN8iiR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:29:59.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791951d5-0f43-4da4-ec7f-08de940220d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 17:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3648

Update README to reflect the new --app-dir support added to
dockersetup.py:

- Step 2: Add a note explaining that the default installation base
  directory inside the containers is /opt (requiring the repo to be
  cloned at /opt/layerindex), and document the --app-dir option for
  using a custom  directory (e.g. when the repo is cloned to a
  non-default path)
- Database Setup: add note to replace /opt with --app-dir value if used
- Updating OE data: add same note
- Security section: add reminder to substitute --app-dir value in the
  changepassword and axes_reset commands

  AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v2:
   - None
---
 README | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 1335b7a..e40ff25 100644
--- a/README
+++ b/README
@@ -49,6 +49,19 @@ instructions will walk you through the setup.
=20
         ./dockersetup.py -d ~/databasedump.sql -p http://<proxyserver>:<po=
rt>
=20
+   NOTE: By default, the application is installed inside the containers un=
der
+   /opt (e.g. /opt/layerindex, /opt/migrate.sh). This means you should clo=
ne
+   this repository into /opt/layerindex on the host before running the scr=
ipt,
+   or alternatively use the --app-dir option to specify a different base
+   directory inside the container:
+
+        ./dockersetup.py --app-dir /path/to/appdir
+
+   For example, if you have cloned the repository to
+   /scratch2/myuser/layerindex-web, you would run:
+
+        ./dockersetup.py --app-dir /scratch2/myuser/layerindex-web
+
    NOTE: If you want email sending to work (required for user registration=
 and
    password resets), you should use the -e/--email-host option to specify =
your
    outgoing email server.
@@ -99,11 +112,14 @@ Database Setup
 Once the application is running you'll need to do a bit of further
 setup within it:
=20
+NOTE: The following commands use /opt as the default base directory. If yo=
u
+ran dockersetup.py with --app-dir, replace /opt with the value you specifi=
ed.
+
 1. For a fresh database (without importing any database dump) you will
    need layer data. To import the full set for the master branch from the
    public instance at layers.openembedded.org you can run the following:
=20
-   docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/impo=
rt_layers.py https://layers.openembedded.org
+   docker-compose -f docker-compose.yml run --rm layersapp /opt/layerindex=
/layerindex/tools/import_layers.py https://layers.openembedded.org
=20
    Alternatively, you can populate the database manually -
    you'll need to add at least the openembedded-core layer to the
@@ -169,19 +185,22 @@ You will likely want to update the OpenEmbedded layer=
 information on a regular
 basis. To do that by fetching and parsing all layer repositories, run the
 following:
=20
+NOTE: The following commands use /opt as the default base directory. If yo=
u
+ran dockersetup.py with --app-dir, replace /opt with the value you specifi=
ed.
+
    Incremental update:
=20
-       docker-compose run --rm layersapp /opt/layerindex/layerindex/update=
.py
+       docker-compose -f docker-compose.yml run --rm layersapp /opt/layeri=
ndex/layerindex/update.py
=20
    Reload all data (should only be needed if the database structure has
    changed as part of an upgrade of the application code):
=20
-       docker-compose run --rm layersapp /opt/layerindex/layerindex/update=
.py -r
+       docker-compose -f docker-compose.yml run --rm layersapp /opt/layeri=
ndex/layerindex/update.py -r
=20
 Alternatively, you can update the data from an existing layer index instan=
ce
 (as per above during setup):
=20
-    docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/imp=
ort_layers.py https://layers.openembedded.org
+    docker-compose -f docker-compose.yml run --rm layersapp /opt/layerinde=
x/layerindex/tools/import_layers.py https://layers.openembedded.org
=20
=20
=20
@@ -356,7 +375,9 @@ REGISTRATION_OPEN =3D False
   reset function ( /accounts/password_reset/ ) or alternatively from the
   backend you can run the following command:
=20
-  docker-compose exec layersapp /opt/layerindex/manage.py changepassword <=
username>
+  docker-compose -f docker-compose.yml exec layersapp /opt/layerindex/mana=
ge.py changepassword <username>
+
+  (Replace /opt with your --app-dir value if you used a custom directory.)
=20
 * The web-based password reset function will ask the user answers to
   security questions they selected and answered when they created the
@@ -387,7 +408,9 @@ REGISTRATION_OPEN =3D False
     (default 4, resets after an hour). The lockout can be removed
     immediately using the following command:
=20
-    docker-compose exec layersapp /opt/layerindex/manage.py axes_reset
+    docker-compose -f docker-compose.yml exec layersapp /opt/layerindex/ma=
nage.py axes_reset
+
+    (Replace /opt with your --app-dir value if you used a custom directory=
.)
=20
     If you wish to disable this, remove or comment out "axes" in
     INSTALLED_APPS. For more information on configuring axes, see:
@@ -412,12 +435,12 @@ To back up the database within the docker-based setup=
, you can run the
 following command (no need to substitute ${MYSQL_ROOT_PASSWORD}, it's
 already present within the container environment):
=20
-docker-compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root --p=
assword=3D${MYSQL_ROOT_PASSWORD} --max_allowed_packet=3D512M layersdb' | gz=
ip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
+docker-compose -f docker-compose.yml exec layersdb /bin/sh -c '/usr/bin/ma=
riadb-dump -u root --password=3D${MYSQL_ROOT_PASSWORD} --max_allowed_packet=
=3D512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
=20
 To restore one of these backups you would run the following command (take
 care, this will overwrite the data immediately without prompting!):
=20
-zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c '/usr/=
bin/mariadb -u root --password=3D${MYSQL_ROOT_PASSWORD} layersdb'
+zcat backupfile.sql.gz | docker-compose -f docker-compose.yml exec -T laye=
rsdb /bin/sh -c '/usr/bin/mariadb -u root --password=3D${MYSQL_ROOT_PASSWOR=
D} layersdb'
=20
=20
=20
--=20
2.43.0


