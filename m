Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B3D6AB04
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 19:51:31 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4915.1775159481642459175
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 12:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=L7V5bylb;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.52.61, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsiZbkuqWZckhcJX05kzar5AvqrHDZVCeAPkBVjuLtqsCXZ9TUjEevEf5wD4BSDjNUj/Y14PhOWbneQg1U9Q5CFkTsAfexz3O3S/R39H8tYvgvdjHzACHoVTJss2pFJIS7lhohlc1nYR5F1sfGgBvIy60cCQPRJi84+d8EHmXyKn7cKyWtYHxXHFIETZxdC9lxEwWSsNSW6HKekF90iBFdje3AFeY/9kZMTUvycDdtPF36TsKR3pl+towMyl2Y7MPaCTtxHLS6zIbMYNdyYxVqKm9j9AJNOmGVpwFE3Q1XcaY8Mb7xtxa513qa7V4t1lr8dRBvDh8oxfx0ycSnhWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZSdL1tVRdoZ66WOLUKLLXBb8nsnYG+0CL3m/r44Tgo=;
 b=JV083KsRTwMw4cW6i3goLzWH2p6qVzjgtWZc9U7QOdEM5aGuHKrUEWSzWuE1iPWk9w6IJMAxcwd4dCdjvxXZoXJ9e+8z6ztVglHQcAOyoUAKI8XW0hglSQ1UnYiLUGsnac2SHCjhSIJZ5HdXP+SFdVEe3Tf24ifaenlNrQi2Aj2ckYmkSflaId84P/PhpSp35x8L7CcEM7ceJjEVrCtDvnDIHE4lxiU/h5kVhNzBztFkE3o99PwQDId+OmIJdq4YBTSkSbwzebr2c92ZIGsoa1tLUR5mxj2YNabnr5jpnIclJefeCiiF4GxvTe7ciqmz4UBuCMV2SDUbGAo/cg4/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZSdL1tVRdoZ66WOLUKLLXBb8nsnYG+0CL3m/r44Tgo=;
 b=L7V5bylbpOVoJpDnFHJ5gDUbgRlMlQknzBF7Fy7z48myodjllpv9iUlGWxVHKQxj649ZhJxDhZT3c+XNHmB8orQbDpFB5ETrgzvgd15fVaboOA/eGLqH6h2JrWo67YJ6Q0t0eLLTU0vkcxXx7cn+iHXkbuRds/b4Dmln/MGShKo=
Received: from PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::6)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 2 Apr
 2026 19:51:14 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::56) by PH7P220CA0047.outlook.office365.com
 (2603:10b6:510:32b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 19:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:51:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:12 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 14:51:12 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH 1/4] layerindex: Add app dir support for configurable container
Date: Thu, 2 Apr 2026 13:51:09 -0600
Message-ID: <20260402195112.1369295-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
References: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a4235e-8a61-4a97-129f-08de90f13265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	sI3j83Vvlmx+LZ/85r2Hq6FA7vJvxiZu+xQKOT+gZq+uwYs7NL5S6BAvNoX2RVGdcvVhGpExuI41ld1lNsXfY9RcUTY4c2Nhd38CUoZ7PU0VgPYOrxoTo+KJ5WF2+4eWGyYSVAHtOqOBw7rKg+uVCRfEIfBMIYCZbZhaiBRxBlk1ZB+qgtN1t63DTtgJg8Pf5dO9rN1wCw4me81G+hUj14DV95WtkzebnpektfuPDsv9LYhx4Vqg1t0FTOj8aE4Mq7P4d2fo+NsWdOHQcUQ2fisB/zJtM4XhiP2jrja3kgjynfRKSvRVW3+C2oGDKnBCB/0xMlU3456yNJM2vwvaXikRQOYcyXmfn7maVwHBGPC+v3invgsAeAIYtlePyKddkoKpcfW+IQM7J1462drz9c5vnioM6z2zuJ3TYO/6hH05rqfvXVlme/th4zXwY2i3IybKt/ihQC7SjtLJ1F3Qc3YlTJoYFUNbhvUqDwet1ml9OApMQhAcuUv4goMOnWj6+KTkhp74nKCI56bdrMjRgQp9yWOG7nFl0hKrN36HnnHV6ea7c0F1l8TpsIfeARcBTFfR4s+7SAOIJPtc5OzSD4UOn2J7xpDwWxlX/O5k04I9pZ1ddplxrg+yfcKjv9pXu+23ykyRmVyK6DNRjuxeBpTuOZpT/ZmnVWP+XKr8CBg7sXrlwVmaTOA6DDW7oUIAgzH5s67U/D0kV4G4qoEzPcqys69u4dbF/YFQFHSazUGFwpZZgwWK9o5WeJwygMdbW8zG4BzV/79ch6BWA57XBg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	fJfsBXvQ1Q6K7tNNxEyu7xBnkf9OElZy8WiyjiIt731O8o42WuDii8vPTM7zw1zFaZRUS+AHH8/v8APfSYquIyVAfwhFhS6Ap0Nfi8/dCXKR/BBuOZCxrYPudtf7DILbTMK3KncYBLUnrPomU4gA3AdEpadC25UPK8Do+aoWCv2zvKv0jY0hk5kmz2Qjq78sFgQE0SWiYb0lxC+xggpumLcXeSH2KHhPuiBDfjltA6ipD2F6J3zUxBZoRKJMV9Kp0R2sVFbqaJNjgmbqvEjwnmRhk2Qgn/DIV93YKDZtlQP6UkR5PGS3iaqy4JRJUy65XU7ZAzlRUcCeFMUCS2u10v4glWP6ls2vVS++nAkHviBJ2qlOq1/bDMMUhzPO6GBYrbh67/Bd1D5mEmV5SDuRjVDQDNkp3nfnxRsaibFOmRu3qP/H+OemBfyOJpsYxStE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:51:13.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4235e-8a61-4a97-129f-08de90f13265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 19:51:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3620

Add a new --app-dir command-line argument (default: /opt) to allow the
base directory used inside the containers to be configurable instead of
being hardcoded to /opt.

Changes:
- dockersetup.py: add --app-dir argument; write APP_DIR to .env file via
  new write_env_file() so docker-compose passes it as a build arg; update
  edit_dockercompose() to expand build: block and inject APP_DIR build arg
  reference, and rewrite volume mounts and celery --workdir accordingly;
  propagate app_dir through setup_https(), check_connectivity(), and all
  direct docker-compose run call sites
- Dockerfile: add ARG APP_DIR=3D/opt + ENV APP_DIR=3D${APP_DIR}; replace al=
l
  hardcoded /opt paths with ${APP_DIR} in COPY, RUN and CMD instructions
- docker/migrate.sh: replace /opt with ${APP_DIR:-/opt}
- docker/refreshlayers.sh: replace /opt with ${APP_DIR:-/opt}
- docker/updatelayers.sh: replace /opt with ${APP_DIR:-/opt}

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 Dockerfile              | 24 +++++++------
 docker/migrate.sh       |  2 +-
 docker/refreshlayers.sh |  2 +-
 docker/updatelayers.sh  |  2 +-
 dockersetup.py          | 79 +++++++++++++++++++++++++++++++++--------
 5 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 72f57d2..8e6e508 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -3,6 +3,8 @@
 FROM ubuntu:jammy
 LABEL maintainer=3D"Michael Halstead <mhalstead@linuxfoundation.org>"
=20
+ARG APP_DIR=3D/opt
+ENV APP_DIR=3D${APP_DIR}
 ENV PYTHONUNBUFFERED=3D1 \
     LANGUAGE=3Den_US \
     LANG=3Den_US.UTF-8 \
@@ -55,22 +57,22 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive apt-get update \
 	&& rm -rf /var/lib/apt/lists/* \
 	&& apt-get clean
=20
-COPY . /opt/layerindex
-RUN rm -rf /opt/layerindex/docker
-COPY docker/settings.py /opt/layerindex/settings.py
-COPY docker/refreshlayers.sh /opt/refreshlayers.sh
-COPY docker/updatelayers.sh /opt/updatelayers.sh
-COPY docker/migrate.sh /opt/migrate.sh
-COPY docker/connectivity_check.sh /opt/connectivity_check.sh
+COPY . ${APP_DIR}/layerindex
+RUN rm -rf ${APP_DIR}/layerindex/docker
+COPY docker/settings.py ${APP_DIR}/layerindex/settings.py
+COPY docker/refreshlayers.sh ${APP_DIR}/refreshlayers.sh
+COPY docker/updatelayers.sh ${APP_DIR}/updatelayers.sh
+COPY docker/migrate.sh ${APP_DIR}/migrate.sh
+COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh
=20
-RUN mkdir /opt/workdir \
+RUN mkdir ${APP_DIR}/workdir \
 	&& adduser --system --uid=3D500 layers \
-	&& chown -R layers /opt/workdir
+	&& chown -R layers ${APP_DIR}/workdir
 USER layers
=20
 # Always copy in .gitconfig and proxy helper script (they need editing to =
be active)
 COPY docker/.gitconfig /home/layers/.gitconfig
-COPY docker/git-proxy /opt/bin/git-proxy
+COPY docker/git-proxy ${APP_DIR}/bin/git-proxy
=20
 # Start Gunicorn
-CMD ["/usr/local/bin/gunicorn", "wsgi:application", "--workers=3D4", "--bi=
nd=3D:5000", "--timeout=3D60", "--log-level=3Ddebug", "--chdir=3D/opt/layer=
index"]
+CMD ["/bin/sh", "-c", "/usr/local/bin/gunicorn wsgi:application --workers=
=3D4 --bind=3D:5000 --timeout=3D60 --log-level=3Ddebug --chdir=3D${APP_DIR}=
/layerindex"]
diff --git a/docker/migrate.sh b/docker/migrate.sh
index ca15368..bb9f646 100755
--- a/docker/migrate.sh
+++ b/docker/migrate.sh
@@ -1,2 +1,2 @@
 #!/bin/bash
-python3 /opt/layerindex/manage.py migrate "$@"
+python3 ${APP_DIR:-/opt}/layerindex/manage.py migrate "$@"
diff --git a/docker/refreshlayers.sh b/docker/refreshlayers.sh
index 0c550bd..5adaf86 100755
--- a/docker/refreshlayers.sh
+++ b/docker/refreshlayers.sh
@@ -1,3 +1,3 @@
 #!/bin/bash
-update=3D/opt/layerindex/layerindex/update.py
+update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py
 $update -q -r
diff --git a/docker/updatelayers.sh b/docker/updatelayers.sh
index 21640ba..6f0e8f0 100755
--- a/docker/updatelayers.sh
+++ b/docker/updatelayers.sh
@@ -1,3 +1,3 @@
 #!/bin/bash
-update=3D/opt/layerindex/layerindex/update.py
+update=3D${APP_DIR:-/opt}/layerindex/layerindex/update.py
 $update -q
diff --git a/dockersetup.py b/dockersetup.py
index bc7478c..920b2c8 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -70,6 +70,7 @@ def get_args():
     parser.add_argument('--no-migrate', action=3D"store_true", default=3DF=
alse, help=3D'Skip running database migrations')
     parser.add_argument('--no-admin-user', action=3D"store_true", default=
=3DFalse, help=3D'Skip adding admin user')
     parser.add_argument('--no-connectivity', action=3D"store_true", defaul=
t=3DFalse, help=3D'Skip checking external network connectivity')
+    parser.add_argument('--app-dir', type=3Dstr, help=3D'Base directory in=
side the container for application files. Default is %(default)s', required=
=3DFalse, default=3D'/opt')
=20
     args =3D parser.parse_args()
=20
@@ -253,14 +254,16 @@ def yaml_comment(line):
=20
=20
 # Add hostname, secret key, db info, and email host in docker-compose.yml
-def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpa=
ssword, portmapping, letsencrypt, email_host, email_port, email_user, email=
_password, email_ssl, email_tls):
+def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpa=
ssword, portmapping, letsencrypt, email_host, email_port, email_user, email=
_password, email_ssl, email_tls, app_dir=3D'/opt'):
+
+    in_layersapp_build =3D False
=20
     def adjust_cert_mount_line(ln):
         linesplit =3D ln.split(':')
         if letsencrypt:
             linesplit[1] =3D '/etc/letsencrypt'
         else:
-            linesplit[1] =3D '/opt/cert'
+            linesplit[1] =3D app_dir + '/cert'
         # This allows us to handle if there is a ":ro" or similar on the e=
nd
         return ':'.join(linesplit)
=20
@@ -305,6 +308,33 @@ def edit_dockercompose(hostname, dbpassword, dbapasswo=
rd, secretkey, rmqpassword
                 newlines.append(ucline + '\n')
             else:
                 newlines.append(yaml_comment(line) + '\n')
+        elif re.match(r'^\s+build:\s+\.$', line):
+            # Convert inline 'build: .' to block form so we can pass APP_D=
IR as a build arg
+            indent =3D line[:len(line) - len(line.lstrip())]
+            newlines.append(indent + 'build:\n')
+            newlines.append(indent + '  context: .\n')
+            newlines.append(indent + '  args:\n')
+            newlines.append(indent + '    - APP_DIR=3D${APP_DIR}\n')
+            in_layersapp_build =3D True
+            continue
+        elif '- APP_DIR=3D' in line:
+            # Keep APP_DIR referencing the .env file (do not embed value h=
ere)
+            format =3D line[:line.find('- APP_DIR=3D')].replace('#', '')
+            newlines.append(format + '- APP_DIR=3D${APP_DIR}\n')
+            continue
+        elif re.match(r'^\s+context:\s+\.$', line) and in_layersapp_build:
+            in_layersapp_build =3D False
+            newlines.append(line + '\n')
+            continue
+        elif ':/opt/workdir' in line:
+            newlines.append(line.replace(':/opt/workdir', ':' + app_dir + =
'/workdir') + '\n')
+            continue
+        elif ':/opt/layerindex-task-logs' in line:
+            newlines.append(line.replace(':/opt/layerindex-task-logs', ':'=
 + app_dir + '/layerindex-task-logs') + '\n')
+            continue
+        elif '--workdir=3D/opt/layerindex' in line:
+            newlines.append(line.replace('--workdir=3D/opt/layerindex', '-=
-workdir=3D' + app_dir + '/layerindex') + '\n')
+            continue
         elif "layersweb:" in line:
             in_layersweb =3D True
             newlines.append(line + "\n")
@@ -474,9 +504,9 @@ def edit_dockerfile_web(hostname, no_https):
     writefile("Dockerfile.web", ''.join(newlines))
=20
=20
-def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_=
production, cert, cert_key, emailaddr):
+def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_=
production, cert, cert_key, emailaddr, app_dir=3D'/opt'):
     local_cert_dir =3D os.path.abspath('docker/certs')
-    container_cert_dir =3D '/opt/cert'
+    container_cert_dir =3D app_dir + '/cert'
     if letsencrypt:
         # Create dummy cert
         container_cert_dir =3D '/etc/letsencrypt'
@@ -578,8 +608,26 @@ def edit_options_file(project_name):
         f.write('project_name=3D%s\n' % project_name)
=20
=20
-def check_connectivity():
-    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', 'lay=
ersapp', '/opt/connectivity_check.sh'], shell=3DFalse)
+def write_env_file(app_dir):
+    """Write APP_DIR to .env so docker-compose passes it as a build arg.""=
"
+    env_vars =3D {}
+    try:
+        with open('.env', 'r') as f:
+            for line in f:
+                line =3D line.strip()
+                if '=3D' in line and not line.startswith('#'):
+                    k, v =3D line.split('=3D', 1)
+                    env_vars[k.strip()] =3D v.strip()
+    except FileNotFoundError:
+        pass
+    env_vars['APP_DIR'] =3D app_dir
+    with open('.env', 'w') as f:
+        for k, v in env_vars.items():
+            f.write('%s=3D%s\n' % (k, v))
+
+
+def check_connectivity(app_dir=3D'/opt'):
+    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', 'lay=
ersapp', app_dir + '/connectivity_check.sh'], shell=3DFalse)
     if return_code !=3D 0:
         print("Connectivity check failed - if you are behind a proxy, plea=
se check that you have correctly specified the proxy settings on the comman=
d line (see --help for details)")
         sys.exit(1)
@@ -741,15 +789,16 @@ if args.uninstall:
 if args.update:
     args.no_https =3D read_dockerfile_web()
     if not args.no_https:
-        container_cert_dir =3D '/opt/cert'
+        container_cert_dir =3D args.app_dir + '/cert'
         args.hostname, https_port, certdir, certfile, keyfile =3D read_ngi=
nx_ssl_conf(container_cert_dir)
         edit_nginx_ssl_conf(args.hostname, https_port, certdir, certfile, =
keyfile)
 else:
     # Always edit these in case we switch from proxy to no proxy
     edit_gitproxy(socks_proxy_host, socks_proxy_port, args.no_proxy)
     edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
+    write_env_file(args.app_dir)
=20
-    edit_dockercompose(args.hostname, dbpassword, dbapassword, secretkey, =
rmqpassword, args.portmapping, args.letsencrypt, email_host, email_port, ar=
gs.email_user, args.email_password, args.email_ssl, args.email_tls)
+    edit_dockercompose(args.hostname, dbpassword, dbapassword, secretkey, =
rmqpassword, args.portmapping, args.letsencrypt, email_host, email_port, ar=
gs.email_user, args.email_password, args.email_ssl, args.email_tls, args.ap=
p_dir)
=20
     edit_dockerfile_web(args.hostname, args.no_https)
=20
@@ -758,7 +807,7 @@ else:
     edit_options_file(args.project_name)
=20
     if not args.no_https:
-        setup_https(args.hostname, http_port, https_port, args.letsencrypt=
, args.letsencrypt_production, args.cert, args.cert_key, emailaddr)
+        setup_https(args.hostname, http_port, https_port, args.letsencrypt=
, args.letsencrypt_production, args.cert, args.cert_key, emailaddr, args.ap=
p_dir)
=20
 ## Start up containers
 return_code =3D subprocess.call(['docker-compose', 'up', '-d', '--build'],=
 shell=3DFalse)
@@ -768,7 +817,7 @@ if return_code !=3D 0:
=20
 if not (args.update or args.no_connectivity):
     ## Run connectivity check
-    check_connectivity()
+    check_connectivity(args.app_dir)
=20
 # Get real project name (if only there were a reasonable way to do this...=
 ugh)
 real_project_name =3D ''
@@ -830,7 +879,7 @@ if not args.no_migrate:
     env =3D os.environ.copy()
     env['DATABASE_USER'] =3D 'root'
     env['DATABASE_PASSWORD'] =3D dbapassword
-    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', '-e'=
, 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', '/opt/migrate.sh=
'], shell=3DFalse, env=3Denv)
+    return_code =3D subprocess.call(['docker-compose', 'run', '--rm', '-e'=
, 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir + '=
/migrate.sh'], shell=3DFalse, env=3Denv)
     if return_code !=3D 0:
         print("Applying migrations failed")
         sys.exit(1)
@@ -864,13 +913,13 @@ if not args.update:
                 break
     for volume in volumes:
         volname =3D '%s_%s' % (real_project_name, volume)
-        return_code =3D subprocess.call(['docker', 'run', '--rm', '-v', '%=
s:/opt/mount' % volname, 'debian:stretch', 'chown', '500', '/opt/mount'], s=
hell=3DFalse)
+        return_code =3D subprocess.call(['docker', 'run', '--rm', '-v', '%=
s:%s/mount' % (volname, args.app_dir), 'debian:stretch', 'chown', '500', ar=
gs.app_dir + '/mount'], shell=3DFalse)
         if return_code !=3D 0:
             print("Setting volume permissions for volume %s failed" % volu=
me)
             sys.exit(1)
=20
 ## Generate static assets. Run this command again to regenerate at any tim=
e (when static assets in the code are updated)
-return_code =3D subprocess.call("docker-compose run --rm -e STATIC_ROOT=3D=
/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp /o=
pt/layerindex/manage.py collectstatic --noinput" % quote(real_project_name)=
, shell =3D True)
+return_code =3D subprocess.call("docker-compose run --rm -e STATIC_ROOT=3D=
/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp %s=
/layerindex/manage.py collectstatic --noinput" % (quote(real_project_name),=
 args.app_dir), shell =3D True)
 if return_code !=3D 0:
     print("Collecting static files failed")
     sys.exit(1)
@@ -891,12 +940,12 @@ else:
 if not args.update:
     if not args.databasefile:
         ## Set site name
-        return_code =3D subprocess.call(['docker-compose', 'run', '--rm', =
'layersapp', '/opt/layerindex/layerindex/tools/site_name.py', host, 'OpenEm=
bedded Layer Index'], shell=3DFalse)
+        return_code =3D subprocess.call(['docker-compose', 'run', '--rm', =
'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py', ho=
st, 'OpenEmbedded Layer Index'], shell=3DFalse)
=20
     if not args.no_admin_user:
         ## For a fresh database, create an admin account
         print("Creating database superuser. Input user name and password w=
hen prompted.")
-        return_code =3D subprocess.call(['docker-compose', 'run', '--rm', =
'layersapp', '/opt/layerindex/manage.py', 'createsuperuser', '--email', ema=
iladdr], shell=3DFalse)
+        return_code =3D subprocess.call(['docker-compose', 'run', '--rm', =
'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser', '--=
email', emailaddr], shell=3DFalse)
         if return_code !=3D 0:
             print("Creating superuser failed")
             sys.exit(1)
--=20
2.43.0


