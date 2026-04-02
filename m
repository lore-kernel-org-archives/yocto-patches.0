Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC4D6AB05
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 19:51:21 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4914.1775159480741078231
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 12:51:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=CrFVO3Ct;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.46, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd1qE8Bz4K9+gtpzcaW9zBlKUSpw7kcr6pXyCv0Ekw6qQMAzJr6mIGn3yAPEVoYHQjgD1fmt4Fag82L6N0EHh3lm6YOleFk0LaudOuYvVuvXh/x0xVvqBjIrAD7dWfLfkOMQn/74aZRmFYspXV+3bkQBP/TltUUEidDk7NPyAEsLZY/Zs3h0syaa5BYKrwx7WzpSlXwuTpjTpeNnaLzPn/1h87OtaONbEOJs8Tbb5PwQUg+i5GQ7qHPNMbTVfF5q8bZcdX75JDu4iHkpRUEg1UZUSWc19lIDEI+Z3LrXQooRFOxR0zoAkYI3P2ld9hxLZzPBZWKerOjx3E4PqXrEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dlOB8mhFSXhaWBWBo7nsPT04aVN9/4msVUjcpjB3J4=;
 b=WvhXr51AskbYt6wf51p9yzjhr/SctUvoPOnBGSJQeHr3Sx41c+n4STmuhxS6s2WxKWaEPkEIgy9mLoNE5MoJbNDiOHHPPN0Y2QVq2UVKMd65teNtEKrUy9ZgzXBhGxcXq155jPjllrdACKjzvu2iqfvz18T0E8JbD/JZOa5zS86Wq0RGojxRpgQNV8WlfFYkxAGAJGFVrdvPdsBUztBI5hnFgbIxhzz7AXcjf5cMloA7WY5bSeQAbJjZ7PPC7xpb48et4nVhhOtKAhlRB7zbLo1xjiGBqK7OV45zMKSxaVljpQ8hK+igneOX7yovnhg8nUqbWlW1YwxqnLU3PrssjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dlOB8mhFSXhaWBWBo7nsPT04aVN9/4msVUjcpjB3J4=;
 b=CrFVO3CtQSEGL2kA0tmeWrLipkE7hyHcG4VnJ0D3ArwmE0EaVOwIAgLYVkkA1HbWLftqI13so+At2njYz3pPURGcbsH9u9fl2sxds8Oz6KBwM0ARZjZWocyu8ZNs57oRrPmP3axXW3mWPHe9Q6rhFVaPZ97kL5S8TvaN6DXNT94=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:51:14 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 19:51:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 12:51:13 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 14:51:13 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH 4/4] README: Document --app-dir option usage
Date: Thu, 2 Apr 2026 13:51:12 -0600
Message-ID: <20260402195112.1369295-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
References: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd1512f-a2af-4764-7ce0-08de90f132ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	L4W5xCUPOH0ks7B1dYV4WKLpMu6TWyd2x+N+lkuMjqPx20TugSMAOADhW+4ECyq6VzV3cTjk7Q0nIe7W9OvBY1R6ht0GQRfFwnztCEKWTebJgdapwEek35dhtYTHAiLtwjsKCM+JeFSzlhNXm3CkUxt8DX01riJfqiwLrVoJys8foMW7jLSbQL+VDx3msmSmEZSdtSLAYiNt1m1g3N52M2/nnQepK3iHzF3qxqeY8UtpsMNG/oHU0BN7ziA+BEr1V5UPI+Y+utpxMaIJYsWSUgPGhptr9vs5Vd9zKz1Rv9kZZf12XlsNkqNxbH6saAAEZbClgJFTFuggDadV7ji7bAcXNQDTkaECdUFPPhfK9VW85srtxXa1+o+VtIIc3xL4yhO09GKAe24348WVOBJgkDU0wFk1DF5juB/yukk+sn6SZJCBvmkSZUGVqnl+WVA6e+GgwJ0zxI/+KXbYHY+kmpL8f9TtK8UMX4GpAYjwvIPKadXxlIGVGWh64OoGaREcF2OGr5UHpdZ9Lz62oE2d967YBjljMWpHJd2EYBM40nx1WlVr578MvQKPXf3K6eQtKXsMVVf1nbklaszM9YxGnN7YPYh+nM0Kll2bNz5xTdUVw94YNs0UER4Oivg6ytzsGae525TKSUA+ZsaXsLa5C7SEh0gDrIFmG+LwPsOHpFzlsrfaJWe6aDPhEre1uyEsfd3TZ5jYAL/vhxh6pGoDng==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wz0hOIP6rP+KeY70dDREzvF96RI0sjQlLQ5CzKqkf7Gqlu5JdY7Z7pzBrH9HXbtfHNTtgFpN2qPHBP5wdVAQsaTs3R1hX+8JHZO1zIAhRsHGNUg12mNxiwdGMH9kHXCWoDQLslHLmdUXgZboW2YZ5hMetBUdxYe5IDGmc4gv6X85W3NMnCLnBSB4lKPlxHZg4csHc8z/Dfr50aKh2EV6iQluY0Bj//tMeWtSdOQ6ff0yRdyiUXPRG0Qkdge0cfs8c5owheCnDfalcBinaPXAjDRnqazQZoU+qKFnioRGtf4uCLLB02AAnW3GjkTJVjIXsjc3+rWWSC78ABhU/a4FtVKBXOvcPnfC5qT0lOMw0H5hUDVf9DJqEEQNsJbCANd2+QeYZsGvfoL1+0BcY5ynoonc+WF5XlrhbSEpy+Iy1MOCpAU6B//mChvyBuoWRlzp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:51:14.5759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd1512f-a2af-4764-7ce0-08de90f132ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 19:51:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3619

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


