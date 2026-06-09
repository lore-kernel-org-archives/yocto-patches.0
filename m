Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B26CD8CB2
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:35 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52.1781023228074318782
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 09:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Tg580MoY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.200.47, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcyG/tk3PgCoKQF/Xs1wu7flfuOlzTvlp1GFdU5RZ5TTqwe8+CYNwaHWySSE+gIh++9sicLRupMycFcGfEsI/YTuEUsv6JzXLB6A0QXRgJSAj0DVI2pMZoCIeRxId1yFD6hzp1OopEmoJbxxQPeTiOAP1dSD82eDVgmaLFsMyEkPDDf7bYPpt5slBaxp5jz99oBFbqp/n2RLcGu8uiiFnL+6b7pEfFcOw2dy3j+7jyN0xGlZwCbCiylNWQRpVifYc7k4rFYOq69Vsfvj+ps4wvribqtqYulKQrZekVVamNfj9aikFL0421mBH9NY3MsTYusBBmfluEiylBUHBBMyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlL5tIPGV0t1/3l8xhkBzH1IbSBMH5BagQQWth+bdgQ=;
 b=FaKVCy/WfacDVhHWkXtuxqdduaMioiF8FIAsJ93sOvm9Tbsieeo2to7qqxJqaNGmlzNLBMjNRCMwhTEpEWdjwUxzFZvZxz9GmtYs3qaXfk4FR4rlbpiAxYP9cHJBRueyicof9LW+sZDG/1eo0aEsoGjfyi6yqx4dLHeo0fKMEAwYy/AOZXY97ESz/zzBhhm8k8oRgkysuaenuBHDYekcaqUiWEA4xeWngtB3inVU7Q94wNcvnirlDYTU4OXM/Q0ggJIuIzEAgx2Px++dcxxdwIkhl9xRbRKYDsTE/cGv4+6KljsF7C1EQ7jhaWr32KxnQPbwIfyhlzlgw4ONGGVD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlL5tIPGV0t1/3l8xhkBzH1IbSBMH5BagQQWth+bdgQ=;
 b=Tg580MoY5KIZ/UbOHZvhD0eOS/1w7GMVuAawYp+HKkSolK1dl8egHmhmWVWiHW6qDkox+DP5Iaw1to6PI/nWM8nxNUr40KAgZcSze8vtdSlob4ILR3Q5KsiVAtRLFp7QodYgkspabqyTbUBBNb5nAyn81vB5PL5ewh33Me81oFM=
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:40:20 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::98) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:40:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:20 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 11:40:19 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH v3 4/4] README: Document --app-dir option usage
Date: Tue, 9 Jun 2026 10:40:32 -0600
Message-ID: <20260609164032.1415124-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e52008-72ad-4905-cb91-08dec645cbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|3023799007|56012099006|6133799003|11063799006|18002099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info: 
	NtDb/SIfHcoDILgURHMtSW7U3D0W7b1gWuX2vgI5kyZaaLtuM0+3pIutL5BqN0sfnSYNYUKj6zrVKwRmvNrSrRZ0ZRM9NT5sbIZrVu90BJYVayAdEXJLu/EggUuexeGglme9Fu8rtYEnctJpW3Nm14VvSQJJGAKeAB5TvVI+CdyDnIaujmx63RGs1YqtqEPA39Q/NW7idsBJFQG06zNJftMV4Mur9DJ92jk6pk+wi9uW5P0kMDWG5pjZV3FUuFeGHPwAJKcVzMdc2HnL/Reezbbj0OC+4SghjDWHPK3JfNnXwfAoErWdykdzFg1Dv0vn8kWJd3l0NJgj7IlPgLm5Y1tllHxePIGL0cHr7z5/PPWxRUuAx5LitiLSnEGdmAAUdnvVpLHLdH9gZ7l5jMdkeiF5IiBg3Vk2QXs5CP5FfXGxSXPgPDGDc8LXL1cz7tkFXu7eows1A8uSfQL3hbFvMwY1nOOQ10ou+ME1OjFDLnyYBS+XV6JLd8v9vgkasklTndg2zDjl/DRxReigTvxkUbnnxtmqm6kqdByAScrq9aK+J+tu48nF0kGgBVX+yZXT1Wmt7yI9biIFYXSZuTxCjkcrKR0aeNeAUXkxRZXwLFL7VK5j4K8S/d6o5NNyARGhe9QWl07GFu8DlqpcZwA6y65YmzPVzgRXA2ui3YHUSoc=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(56012099006)(6133799003)(11063799006)(18002099003)(13003099007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	18Rqi8qFlvGFJBZ+PMbcrCq4028pb4LEuua7xIzGTxRYq/RmVD/tpYPrwQVGa5Ea6vbRgeBSN183GGZLTAJ5kKaowT6R9fV1PTZsv74z8nZud2n2OHYDyWRIJozMP8kvbjW/tBcKenROmr6FTPUpJOrik2LBtK9Mqga0llLkNkN2HauPGCQiDMobbf6A4NeSxPJtjdEX4PAqhH8JFXPuHtgNEaSz4mCOAXFBgth8cuodSFMg9MOL/6D7BUiHI1v/4vIP78bMUNza5tRGL2wm+tXwz7VLdv+IerghXubjvVT81BQnhUusDIWywOsDuS9+iRQ1ssxmTFskqx1HpthIAA/M6bwcJOaq/Hf2UgYES0QOSQvdVrG10FeeK4oVdIGuavn0IE0VmCyYMLXqbzNicX8SakSBreufGMAnmvPVswaMw0oJZr+GEg5qdOnMVwRy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:40:20.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e52008-72ad-4905-cb91-08dec645cbc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 16:40:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4190

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
 README | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 96c2ddd..a292cc5 100644
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


