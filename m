Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC35F46C70
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:30:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60424.1775496606987918127
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 10:30:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=o21fey7o;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.198.17, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHcpRbV6mRrXRsdUcAIEh3U+xvF6qNQJ74QqykPXcGHx+2PrQh69nW/7HZCArPpNXOWZ9tQMYJkbQl/NnErVq74x56B/t886JPTdnA8Ag3+4LmgCdsEOiVuUqawpG16LjvjXUlqob2F65qko6KzBV15oV4AOtcsEPlqnS3cj7BPiersjAjojM8BvTGVTgNkJrQQdJA83T6UEO8HjcN3Sadb/Wf12fSw4rhqrLq61yTCtpm33wzAoaTeK46j8PjSew37mgpw1CFMBWVtU+tfxQCBMwBWBYTIEyfORCnPVSXIZfOfDn7OSF7gPClR9/WhpGLzz/BQYwJBBvo76QQrftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86KA/ukUW/4qka76K7U3wAKQOUIoLCsXBtfJxjf9M6A=;
 b=Xp2AEO/yei/dQmdW5w7dAqHPepWjoBl087WShksiuaLtiWtlCzbELaNvsfBm6fRzREPpkFg67T5jGWWVTVKOCrBzeQ8RDYV7g/CevE4O3wODGbmZUc1O+f2B8c2A7jsQKaj1KYizoqlSzVVg2x11xbao/n6SHtvTBxI0Gm3qkyj/GyX8dV+ZT8isko6fQ1irm0QV/vZIhvtUdpeUMXHpPqDZteb8vEZ9+vPBKC48PyviAd9dAwoQ+zCzq3A5oLR5jkXHSDxF4TwNOFdyd0IA0rrKu9h+CspLcQg7+vJv5uhO7BwFZMH/pya320FSQnOKFF7TaTET2KwNnbtMOpxc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86KA/ukUW/4qka76K7U3wAKQOUIoLCsXBtfJxjf9M6A=;
 b=o21fey7ogW4wu71Fp1ZoSXpgqGkSuSacctTwGkr27CKZsBH0sSbSAFmqiaR7Cll85JdFnQ3ASx51BkU4CIemFWnUlnK7/Kjl/Bn4bn2NKkr+KS0RM9/fe2vweorqPSdCUXEXXk8FNh+ym9XMN+gqcIIWWT+NAlGft2OSPOJ0fvw=
Received: from PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::21)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 6 Apr
 2026 17:29:58 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::d5) by PH8P223CA0028.outlook.office365.com
 (2603:10b6:510:2db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 17:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 17:29:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 12:29:53 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 12:29:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH v2 1/4] layerindex: Add app dir support for configurable container
Date: Mon, 6 Apr 2026 11:30:07 -0600
Message-ID: <20260406173010.1366742-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
References: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed0e089-1aa0-4e14-b313-08de94021fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	6WE+mMe8p5o2xTfet2xhi27gkUyJxySrUOwYE0iVECDX549BC67mPlurG34eCClVWbQSTnieIeERoplZvBpaEZ34QK3FPiNyt0fbuFGwz0Fdm3wRLVFLBefT86ylXOxmlBH2qey5JcNrU+a7rlHQszsRyI+9gnmjR8Fb3E98kGhXY6K4cH6aWspIWgsGashKxg2rtaCpJiWag1QMrAV2qWVcvsUiYRz+Rxkmz6KVxs1LhDK8uKMybLVSom0sj2Z9IH0ksY4m0R2xmu7l7u0QaZnfLNBF4xympthdE6f9gM8/TlP+tPXD8JCXKGxN1vdMQeDvKDGi1/hTJwnmrlzHC/c2H6dVjyq3/tYJhavqsZE1RGt5wMQaDdfE9x4yyo6Y/KLQqHBX8RwB5rPQj62kYsR8+ZjphqYQgVpstJAq+KVtqGg3I+PC21CPRbdmPQ00LvYbfNSeNHLXw4C5OR2FWbxaDDIYmSXalu7EZ5/KvFGWL4zH7Kqi91X7I2z2ZvoBW32sBBDigKRgeFh/8LnRnVRlaGL6FkaPFC96cqu2ZqSD5fZMwM7ZwW5awhDYlUrgoMRIq5ropia5pvVILwE3AXIPgJFmweEhtGo/meLJrLcXZ0mFpq2KGvYSHS7eskPIM8/94fVRTEyHF+u/rc6d/5e3bCuh19H7KzLeWNxGP3oLbnOjHtWFJv8hG0hyKNvPrxgf+eGLY4O6ghJTbPbI7RliM9bTVRj0yczawJoJvAx2hnSjXompECPS8YJqSA+qnxAlC0EUju+MQqpl5TbY/A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	nvW++dTeiE+yBKpxveYIX0Hp2qfgFw3jZIQBkWBsyVyJdN6Z/GWXRcwJiZS07oCJs/9wmMTkyWhOBQmBVT1XJbpy4pb0NTPhbro6JBwSCdp8z/8Q3+bCdhrS36Vm8M2enkHzwXLNRG611cAT/5NQtcjuyVxT5ORrbKziZO+znjrznsS38geefpY4hjUon9H5XAqE8gcif+bM7ZnCwFNpsGonvGqcmqD2K0WHp1+syjmnJWYeNYkjyGLRYpJM3tQdRHF7rNjBA33S8PjFhbJyeLJQr5orUPmIoQG375xMt8u5Q6tkA+N0r5q5hw72N/mQbj9J3v6wTBneuaYwnEMrpJ994vXw/BSCYReqaAdhrFxnvU6+MhC7yS/DDGhdAXCfCwuBiPnNrAmV8itF+dGoiGXMzhnQ1+DmQDzj5nLEjaEjBTPakUsU63YM3RRkeZPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:29:57.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed0e089-1aa0-4e14-b313-08de94021fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 17:30:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3649

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
Changes in v2:
   - Pass app_dir to edit_settings_py() and replace the hardcoded
     LAYER_FETCH_DIR =3D "/opt/workdir" with app_dir + "/workdir", so
     the fetch directory respects the --app-dir option.
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


