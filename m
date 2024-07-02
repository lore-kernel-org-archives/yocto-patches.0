Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842DC3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 06:28:17 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.18263.1719901691548768034
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 23:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=f3rJOKjQ;
 spf=pass (domain: mvista.com, ip: 209.85.210.179, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706b53ee183so3286150b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719901690; x=1720506490; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYmNEztYcdtN61eXGoacaAGdZRg87Dak9obwFto0l0Y=;
        b=f3rJOKjQ9ZHN9C4cmFRSFmKYl8KvHG3q3MKyYQu543PRoq3MXWdztOE21lfhvk1vqF
         liOihe/6+lC6JE3eFP1CoPRl9fRhhmWOJ0XtXRXraVdUkgYNHoJP/inXaAwzbWpAdeIk
         3Obuzn0Rf/qN4cHZ4y19kcnU6aZjDwPaZWWp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719901690; x=1720506490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYmNEztYcdtN61eXGoacaAGdZRg87Dak9obwFto0l0Y=;
        b=hs0rK7ITwa24EhLhztuiTrxS3+tQzyH/XdoDveXINUmTzcL3IIlSim22sdn7B0BZRF
         XRyyNVpWMt0kKWqhVn92GLXIFqexgel6VPFVbXaFefFMi260k0CL1DZBBVq5WhxPno1m
         650Qwuz3GqVa4RWF6Z32JLaWbiMHkLDo2otrSTynWf4eo11itBPR6o3nCOpsVOB+VZJH
         O7QkwvnURqubsd/sjjGDKKvrv391dH/c3SmQwWLKUPPSusTHM3MBwg4KjBlMwA1jyAz1
         l9siCnKrisgctwYddFUbfXz2fDYdw8LI+6ij7bggxnqSCEubUNCOE4BnylGAlGwT6QvO
         ygAA==
X-Gm-Message-State: AOJu0YxNvedsM7jkH9FNJfjsjGV4efLWaYHLz9k/AXXjt5q7zH9i/tVa
	uiITZo+Ot/8i5ijDYkUd1cqXGLKWMvuc1Gu4mLN51v+QQUyAm4rqBRyWubHMTobqAAh5ovID1+0
	FHwk=
X-Google-Smtp-Source: AGHT+IE+aGVMGHm1VOY3Ch6sdTxL21ksW1MijV9UyHDAwHhpA3bxdJ3B1IzyyKA5r85xfr1QuDXSXg==
X-Received: by 2002:a05:6a20:729c:b0:1be:3546:4a92 with SMTP id adf61e73a8af0-1bef613802bmr12697827637.9.1719901689752;
        Mon, 01 Jul 2024 23:28:09 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882f:8929:cdac:a43:d5de:ddd8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044adb98sm7865945b3a.172.2024.07.01.23.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:28:09 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][kirkstone][PATCH] clamav: Fix for CVE-2024-20328
Date: Tue,  2 Jul 2024 11:57:59 +0530
Message-Id: <20240702062759.1557557-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 06:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/403

From: Vijay Anusuri <vanusuri@mvista.com>

Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/fe7638287bb11419474ea314652404e7e9b314b2]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 recipes-scanners/clamav/clamav_0.104.0.bb     |   1 +
 .../clamav/files/CVE-2024-20328.patch         | 153 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20328.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.0.bb b/recipes-scanners/clamav/clamav_0.104.0.bb
index 18e8329..9e6693f 100644
--- a/recipes-scanners/clamav/clamav_0.104.0.bb
+++ b/recipes-scanners/clamav/clamav_0.104.0.bb
@@ -21,6 +21,7 @@ SRC_URI = "git://github.com/vrtadmin/clamav-devel;branch=rel/0.104;protocol=http
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
     file://fix_systemd_socket.patch \
+    file://CVE-2024-20328.patch \
 "
 S = "${WORKDIR}/git"
 
diff --git a/recipes-scanners/clamav/files/CVE-2024-20328.patch b/recipes-scanners/clamav/files/CVE-2024-20328.patch
new file mode 100644
index 0000000..2f422cf
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2024-20328.patch
@@ -0,0 +1,153 @@
+From fe7638287bb11419474ea314652404e7e9b314b2 Mon Sep 17 00:00:00 2001
+From: Micah Snyder <micasnyd@cisco.com>
+Date: Wed, 10 Jan 2024 12:09:15 -0500
+Subject: [PATCH] ClamD: Disable VirusEvent '%f' feature, use environment var
+ instead
+
+The '%f' filename format character has been disabled and will no longer
+be replaced with the file name, due to command injection security concerns.
+Use the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead.
+
+For the same reason, you should NOT use the environment variables in the
+command directly, but should use it carefully from your executed script.
+
+Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/fe7638287bb11419474ea314652404e7e9b314b2]
+CVE: CVE-2024-20328
+Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
+---
+ clamd/clamd_others.c                  |  8 +++++---
+ common/optparser.c                    |  2 +-
+ docs/man/clamd.conf.5.in              | 14 ++++++++++----
+ etc/clamd.conf.sample                 | 18 ++++++++++++------
+ win32/conf_examples/clamd.conf.sample | 18 ++++++++++++------
+ 5 files changed, 40 insertions(+), 20 deletions(-)
+
+diff --git a/clamd/clamd_others.c b/clamd/clamd_others.c
+index 23f3b022c7..32d0701a0d 100644
+--- a/clamd/clamd_others.c
++++ b/clamd/clamd_others.c
+@@ -101,6 +101,8 @@ void virusaction(const char *filename, const char *virname,
+ #define VE_FILENAME "CLAM_VIRUSEVENT_FILENAME"
+ #define VE_VIRUSNAME "CLAM_VIRUSEVENT_VIRUSNAME"
+ 
++#define FILENAME_DISABLED_MESSAGE "The filename format character has been disabled due to security concerns, use the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead."
++
+ void virusaction(const char *filename, const char *virname,
+                  const struct optstruct *opts)
+ {
+@@ -145,7 +147,7 @@ void virusaction(const char *filename, const char *virname,
+     }
+     len = strlen(opt->strarg);
+     buffer_cmd =
+-        (char *)calloc(len + v * strlen(virname) + f * strlen(filename) + 1, sizeof(char));
++        (char *)calloc(len + v * strlen(virname) + f * strlen(FILENAME_DISABLED_MESSAGE) + 1, sizeof(char));
+     if (!buffer_cmd) {
+         if (path)
+             xfree(env[0]);
+@@ -160,8 +162,8 @@ void virusaction(const char *filename, const char *virname,
+             j += strlen(virname);
+             i++;
+         } else if (i + 1 < len && opt->strarg[i] == '%' && opt->strarg[i + 1] == 'f') {
+-            strcat(buffer_cmd, filename);
+-            j += strlen(filename);
++            strcat(buffer_cmd, FILENAME_DISABLED_MESSAGE);
++            j += strlen(FILENAME_DISABLED_MESSAGE);
+             i++;
+         } else {
+             buffer_cmd[j++] = opt->strarg[i];
+diff --git a/common/optparser.c b/common/optparser.c
+index a7bdbee064..1be7afe867 100644
+--- a/common/optparser.c
++++ b/common/optparser.c
+@@ -333,7 +333,7 @@ const struct clam_option __clam_options[] = {
+ 
+     {"DisableCache", "disable-cache", 0, CLOPT_TYPE_BOOL, MATCH_BOOL, 0, NULL, 0, OPT_CLAMD | OPT_CLAMSCAN, "This option allows you to disable clamd's caching feature.", "no"},
+ 
+-    {"VirusEvent", NULL, 0, CLOPT_TYPE_STRING, NULL, -1, NULL, 0, OPT_CLAMD, "Execute a command when a virus is found. In the command string %v will be\nreplaced with the virus name and %f will be replaced with the file name.\nAdditionally, two environment variables will be defined: $CLAM_VIRUSEVENT_FILENAME\nand $CLAM_VIRUSEVENT_VIRUSNAME.", "/usr/bin/mailx -s \"ClamAV VIRUS ALERT: %v\" alert < /dev/null"},
++    {"VirusEvent", NULL, 0, CLOPT_TYPE_STRING, NULL, -1, NULL, 0, OPT_CLAMD, "Execute a command when virus is found.\nUse the following environment variables to identify the file and virus names:\n- $CLAM_VIRUSEVENT_FILENAME\n- $CLAM_VIRUSEVENT_VIRUSNAME\nIn the command string, '%v' will also be replaced with the virus name.\nNote: The '%f' filename format character has been disabled and will no longer\nbe replaced with the file name, due to command injection security concerns.\nUse the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead.\nFor the same reason, you should NOT use the environment variables in the\ncommand directly, but should use it carefully from your executed script.", "/opt/send_virus_alert_sms.sh"},
+ 
+     {"ExitOnOOM", NULL, 0, CLOPT_TYPE_BOOL, MATCH_BOOL, 0, NULL, 0, OPT_CLAMD, "Stop the daemon when libclamav reports an out of memory condition.", "yes"},
+ 
+diff --git a/docs/man/clamd.conf.5.in b/docs/man/clamd.conf.5.in
+index 2d9748a39e..a9926533b9 100644
+--- a/docs/man/clamd.conf.5.in
++++ b/docs/man/clamd.conf.5.in
+@@ -240,10 +240,16 @@ Enable non-blocking (multi-threaded/concurrent) database reloads. This feature w
+ Default: yes
+ .TP
+ \fBVirusEvent COMMAND\fR
+-Execute a command when a virus is found. In the command string %v will be
+-replaced with the virus name and %f will be replaced with the file name.
+-Additionally, two environment variables will be defined: $CLAM_VIRUSEVENT_FILENAME
+-and $CLAM_VIRUSEVENT_VIRUSNAME.
++Execute a command when virus is found.
++Use the following environment variables to identify the file and virus names:
++- $CLAM_VIRUSEVENT_FILENAME
++- $CLAM_VIRUSEVENT_VIRUSNAME
++In the command string, '%v' will also be replaced with the virus name.
++Note: The '%f' filename format character has been disabled and will no longer
++be replaced with the file name, due to command injection security concerns.
++Use the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead.
++For the same reason, you should NOT use the environment variables in the
++command directly, but should use it carefully from your executed script.
+ \fR
+ .br
+ Default: disabled
+diff --git a/etc/clamd.conf.sample b/etc/clamd.conf.sample
+index 37fb03bf20..54738128da 100644
+--- a/etc/clamd.conf.sample
++++ b/etc/clamd.conf.sample
+@@ -209,12 +209,18 @@ Example
+ # Default: yes
+ #ConcurrentDatabaseReload no
+ 
+-# Execute a command when virus is found. In the command string %v will
+-# be replaced with the virus name and %f will be replaced with the file name.
+-# Additionally, two environment variables will be defined: $CLAM_VIRUSEVENT_FILENAME
+-# and $CLAM_VIRUSEVENT_VIRUSNAME.
+-# Default: no
+-#VirusEvent /usr/local/bin/send_sms 123456789 "VIRUS ALERT: %v in %f"
++# Execute a command when virus is found.
++# Use the following environment variables to identify the file and virus names:
++# - $CLAM_VIRUSEVENT_FILENAME
++# - $CLAM_VIRUSEVENT_VIRUSNAME
++# In the command string, '%v' will also be replaced with the virus name.
++# Note: The '%f' filename format character has been disabled and will no longer
++# be replaced with the file name, due to command injection security concerns.
++# Use the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead.
++# For the same reason, you should NOT use the environment variables in the
++# command directly, but should use it carefully from your executed script.
++# Default: no
++#VirusEvent /opt/send_virus_alert_sms.sh
+ 
+ # Run as another user (clamd must be started by root for this option to work)
+ # Default: don't drop privileges
+diff --git a/win32/conf_examples/clamd.conf.sample b/win32/conf_examples/clamd.conf.sample
+index 5a8a9cfeae..a4813f99cb 100644
+--- a/win32/conf_examples/clamd.conf.sample
++++ b/win32/conf_examples/clamd.conf.sample
+@@ -182,12 +182,18 @@ TCPAddr localhost
+ # Default: yes
+ #ConcurrentDatabaseReload no
+ 
+-# Execute a command when virus is found. In the command string %v will
+-# be replaced with the virus name and %f will be replaced with the file name.
+-# Additionally, two environment variables will be defined: $CLAM_VIRUSEVENT_FILENAME
+-# and $CLAM_VIRUSEVENT_VIRUSNAME.
+-# Default: no
+-#VirusEvent "C:\example\SendEmail.ps1" email@addresscom "VIRUS ALERT: %v in %f"
++# Execute a command when virus is found.
++# Use the following environment variables to identify the file and virus names:
++# - $CLAM_VIRUSEVENT_FILENAME
++# - $CLAM_VIRUSEVENT_VIRUSNAME
++# In the command string, '%v' will also be replaced with the virus name.
++# Note: The '%f' filename format character has been disabled and will no longer
++# be replaced with the file name, due to command injection security concerns.
++# Use the 'CLAM_VIRUSEVENT_FILENAME' environment variable instead.
++# For the same reason, you should NOT use the environment variables in the
++# command directly, but should use it carefully from your executed script.
++# Default: no
++#VirusEvent "C:\example\SendVirusAlertEmail.ps1"
+ 
+ # Run as another user (clamd must be started by root for this option to work)
+ # Default: don't drop privileges
-- 
2.25.1


