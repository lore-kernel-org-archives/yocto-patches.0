Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E3D4663B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:47:08 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.692.1768517220020828951
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:47:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DncPdyvE;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c5389c3cd2so156823385a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517219; x=1769122019; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71Z5MnYQtuLe18l49zldZVEwOJL43vV4p9V58yzInbc=;
        b=DncPdyvEpwPX8pngC6cFK6EXXaf1r3Uk0Cl3weqBkQu3a/HmokZESdeiot53sO7Hp5
         sZSh+xDJds5uW0g9aR9q+CwKcDLJq0fWBVL5AgrO2t23RozV+E7KZJoyuR0CY3IwiBCp
         mNudgsXXfrDiagXgiSMfgWoXVJ8LocgYnnac0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517219; x=1769122019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71Z5MnYQtuLe18l49zldZVEwOJL43vV4p9V58yzInbc=;
        b=XhCIvrCRtik07d6EA172oZDUVQSb5AlKY45pDMLsGGTGNvw+FHbprsUhs2Wm8K2MYn
         NM+1Z0NVDkjI0b2E3d9xkj1kJVk5OHDYHSM8rHbtVmWJd97sVw/1HX1AfLP77YrnDJA6
         eZXDwR9oo0kB6Tf2jZnM96CDT6/XDW6uO+/fuAt+jKqV2pwbuCZf377vlDE9b9rGa4q1
         Z7J/iiSmMcqAMRwUNQRkBlbVOCeNu6EeRAQfQLRUEgisPWQqjceMGlGmBOQp3pbLklgU
         rvwxBfZEd/w8wo1+b61fkAZ7dhZ+pkhJhh8MV0ly5cixHmvMzExY+LZPww73aXra0X13
         BFLg==
X-Gm-Message-State: AOJu0YxT7UYOCvuzzhrt5qzRHjAC58i3MG2LoCb3cctb0URb2Rl14klw
	4PVZtUhfxRqxhfo9PGfys3l5Wzb6tq0J6oMGI3Zd0rGIU2GQLY0oe15kkdgwoNobW4kV2aZW1py
	+wP2C
X-Gm-Gg: AY/fxX6ACChLj7xn4a1FVv2BjhBcBDHSfoqAngK1PeTiRBnCGnWy7eQjFlVCms69Glz
	d0ToQ5vHaIQv3tqa3ylIMrhipb9nFXQ0fdX1LIjeVHhqY6b6zV2uMcSl1kdjh+FFpiflurEZJyE
	xCWpLqS3SgwwtBnFm1b4wLNn64qk+P0bYcWPQCGmfyYCq2VQ9iC+DIVb2gHE4CzH1OOKHIojFNJ
	VZ+gs4XZzP3QjZw5fEb2ziVXleCtxvyE2yFC5rMvBaZvHN+YwE/XDn6hGkKWgQ5Um4AYyg2u8Lg
	QQbdUcebPXE2zrg/1NFxmw6Nr+LXLHA/oaRnTWfNBnJcQ+2o2OHDE0h4ltZX0oO7ok4KG+71gPl
	GLbuBqsRQVyylwj6DLfb6OzNaEjI0VhcxTu6Ny5IWDyRTBoWcQAF/sseR/d+zK8FXWGonCYmkyE
	JIfqtiN10mn+nWC1rqv3FXa/8Ix600rFggpTmDJpJ+J+SS5os7Pu6MgbXW/ZkhqxAyvC/lpD9ND
	pYvlUULPmlxKyG0hsFTGSOh2on/DSCdSht+nTuhsXXggZuiPx80
X-Received: by 2002:ad4:4eac:0:b0:890:5096:513a with SMTP id 6a1803df08f44-8942dd02ac1mr15511436d6.18.1768517218725;
        Thu, 15 Jan 2026 14:46:58 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 9/9] clamav: Fix for CVE-2024-20328
Date: Thu, 15 Jan 2026 17:46:30 -0500
Message-ID: <2ad57a27337ecba58e59ed7aa6fe9769d27804ac.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2974

From: Vijay Anusuri <vanusuri@mvista.com>

Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/fe7638287bb11419474ea314652404e7e9b314b2]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/clamav/clamav_0.104.0.bb     |   1 +
 .../clamav/files/CVE-2024-20328.patch         | 153 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20328.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.0.bb b/recipes-scanners/clamav/clamav_0.104.0.bb
index 0a6b92a..39abda9 100644
--- a/recipes-scanners/clamav/clamav_0.104.0.bb
+++ b/recipes-scanners/clamav/clamav_0.104.0.bb
@@ -21,6 +21,7 @@ SRC_URI = "git://github.com/vrtadmin/clamav-devel;branch=rel/0.104;protocol=http
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
     file://fix_systemd_socket.patch \
+    file://CVE-2024-20328.patch \
     file://CVE-2024-20505.patch \
     file://CVE-2024-20506.patch \
 "
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
2.51.0


