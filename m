Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535CCD8CB9
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:35 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40.1781023227462145729
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 09:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=TX4jVNkZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.52.39, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQTWaN1v00cxfVUCr6PPKefJmuNZ2OQiLntnUyC2t5qUFOIx0Ux4eD0fvOPulnsnHE/+6QQsAsug/50U6mq0jSg2lpoPeSpK1D5b1CSPxQrfiK+rytYL3ZMyKg52yi3BBECQ5kCQ7a2QmrjB8TYdkm51obsF96II8J4MJgKjNGYii3a4pn/Dgp19XOqiCmsvvr0jcCkHKoUhNd0Mm7KSI26jbGMDUqG3hGLhUJjjRacdC/9NPSHOU5eRoI4XDPk4ZT0YSL7/oee9WPUTybhf7NaIU5wl7SaUPCdxga+TDUzooBdnQfGJPeuBTq9uqctU00gZ9jJEisRIJE/sZLJkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qewx22CpLYAaxWxojY+46kZgDqrjcJ8Bh7jqwh8zk2E=;
 b=P7SYe4qb2Te3Zq+CRjXNaIlaDWlIPDXXCtdDNVfs20ILjWxQaDQpJnM2Iepu/htXkAWGxjUQVRyf7EoNREfHlEgRqOuooBzgxtmc+ZXCN+V8OQN5VIhbG6j8sTNi2HOTIfeffDEaUBMr6HoKd3YWe4kX9KT65pw7P2SVWZ0RAGOBSfz7ReIUo1nSKbwomRgzLwUpX6y9nkPeaqnp7tKyhZjjC7NnpuaVW/m8tTuxkWJ8I4eaXBEMe/Ob979EVFjuk3ZMmyHWhvZvZfHKGn6d7JyMTfbr5UlcYgNWLUFe405YFkl+S8F40GuHza1ZgCYL3ybJVAMBNwHK3HTVW8L5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qewx22CpLYAaxWxojY+46kZgDqrjcJ8Bh7jqwh8zk2E=;
 b=TX4jVNkZr1ho1OpB3PwjdubaCzqnJ2Cv6uGkCOcadGwR6xKj1KiT5TlvagtLJM4Qmu8rhvZdrSiMy1UAy7wsl2cF+4oLOtFNewX8CxV3O1y1MATh37BRES8Q48H3WTilT3ASUN2duMRzu+tX0vdo5xoW1SsgCiInVGQaWupDhOI=
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:40:21 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ac) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Tue, 9
 Jun 2026 16:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:40:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 11:40:18 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH v3 1/4] layerindex: Add app dir support for configurable container
Date: Tue, 9 Jun 2026 10:40:29 -0600
Message-ID: <20260609164032.1415124-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 411cffe6-8217-4b0d-4835-08dec645cb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	T7nCexYC17u+GqRZGW4GNljUy0j8qmWKSiq53x7AIHKwtbk4MIpqCk5uBqShyBoQnygLe+NFY97kyCX1dtDLLILjWJH2nCB40hP+Jg9kOviSuldQTyEFFlSkBFh9JX7XEGutSvZQvOeGvoOITeKcHiPMtLNbFqo8AScpPcFuj4RjAHdv2BnckG4JGJqGt/g1h/fdtAz5c0lXXmmjqIgwk6bvhFwJ6HYAwAUCKwGlY20vOzspb5EPSrB/Qr3FyNw2TR89Ol+aF4+zk/U6WR7MKP7arTvYjM16Bn8I0ddtrLSMDB6deCCcLw0CquT33aJGlKic9eR+2ixhRky7AoXIbDoxk+/Z2GMGu8vdVObiDMd9GEv3snUPReNvvHQwoVmmucL57mbOF5Q6ydMhqjmoKj+nis2v7wsfRUf8qe0THVR7CmPe0GoQy/iklIexwHl0L27uiLoAR/0daoPjmKEQlGseg9u8YAhTw3AAjJnDv3PTtLlYK7RR6F5dMJvpeicKTie8HEAItyA9930VWUWbjXEhHrD5DZU1/qMR4g5iEFxll5rqDfZ3JLOPaC6f5mgEx3mOde7q978TI2mv9V8g8dgXj6itemC5qAuj2xJdqqneShLIiKBfDW2dT/zekr77vYYelgZXhFXs3iakgxwnwE6AL1DWZiTn8nw6g/Njp5+1PsO7LOw/XBHbJVtbk4LCowUT+SBWhRFT9FCScDc0TVP/y/w3F/YOmxq25YLVSZI=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FKNdFhXyyhHEsZE4wIopxcAwFW3Q1rnGXO1hkbnQMMyKjmUdp+9OMzgyFXFNOLLk62m5fPka3LHoi6pUYe1/2BG313couzTPcI7dtgshpww754R72Er4De7VkY/9oInK+MVUzEJH72bnjtEzW2c6gfCcRNlKFU4F7WC8ui10nhFwAu3xZED7sDWwKOy9AttOYetm0T4q3np6OVd56wQLWJ3BMAFMOkGRy688c8yQm3Uwer4+aj2c4z2g0J7f2/QXogG7zDEVcUPKugsKRjYAUwEmA7rYJK6nsemKWkj2iXvupI00igCyTypCjtQ7e50HGBhSNy7UcjDnJ35l4FBlWwweRvKA08P0eokGxCrSBQxDIRbJSwDULtzzol/tPrrNdYBPs+PWYPottbfQN/oEKtoIWHFG03Q1TlsUJH21o7+Aae4AV6qK2nDYPx0jFg+4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:40:19.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411cffe6-8217-4b0d-4835-08dec645cb26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 16:40:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4189

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
- Pass app_dir to edit_settings_py() and replace the hardcoded
  LAYER_FETCH_DIR =3D "/opt/workdir" with app_dir + "/workdir", so
  the fetch directory respects the --app-dir option.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 Dockerfile              | 24 ++++++------
 docker/migrate.sh       |  2 +-
 docker/refreshlayers.sh |  2 +-
 docker/updatelayers.sh  |  2 +-
 dockersetup.py          | 86 +++++++++++++++++++++++++++++++++--------
 5 files changed, 85 insertions(+), 31 deletions(-)

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
index bc7478c..3a74eb3 100755
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
@@ -426,7 +456,7 @@ def edit_nginx_ssl_conf(hostname, https_port, certdir, =
certfile, keyfile):
     writefile("docker/nginx-ssl-edited.conf", ''.join(newlines))
=20
=20
-def edit_settings_py(emailaddr):
+def edit_settings_py(emailaddr, app_dir=3D'/opt'):
     filedata =3D readfile('docker/settings.py')
     newlines =3D []
     lines =3D filedata.splitlines()
@@ -444,6 +474,9 @@ def edit_settings_py(emailaddr):
                 newlines.append("  ('Admin', '%s'),\n" % emailaddr)
             newlines.append(")\n")
             continue
+        elif line.lstrip().startswith('LAYER_FETCH_DIR'):
+            newlines.append("LAYER_FETCH_DIR =3D \"%s/workdir\"\n" % app_d=
ir)
+            continue
         newlines.append(line + "\n")
     writefile("docker/settings.py", ''.join(newlines))
=20
@@ -474,9 +507,9 @@ def edit_dockerfile_web(hostname, no_https):
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
@@ -578,8 +611,26 @@ def edit_options_file(project_name):
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
@@ -741,24 +792,25 @@ if args.uninstall:
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
-    edit_settings_py(emailaddr)
+    edit_settings_py(emailaddr, args.app_dir)
=20
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
@@ -768,7 +820,7 @@ if return_code !=3D 0:
=20
 if not (args.update or args.no_connectivity):
     ## Run connectivity check
-    check_connectivity()
+    check_connectivity(args.app_dir)
=20
 # Get real project name (if only there were a reasonable way to do this...=
 ugh)
 real_project_name =3D ''
@@ -830,7 +882,7 @@ if not args.no_migrate:
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
@@ -864,13 +916,13 @@ if not args.update:
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
@@ -891,12 +943,12 @@ else:
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


