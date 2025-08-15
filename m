Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1533ECA0EE4
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 14:29:16 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.13190.1755268152548420200
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Aug 2025 07:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=abhytowU;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24458272c00so23768975ad.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755268152; x=1755872952; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYjA5QDbSE0c0DWbdu0Xr2vmrUUrfAA2zDiVjrK2mhk=;
        b=abhytowUz9CaeibIFQswoPOF2A8oHCeiDpqAUULJQylHJbfoMct1OjN64+8lwXAs/r
         FTFbg2KFDzyhH6Na31FqarTncyXxOtJ21fSp+g421HVpP9UfxGvfEbrJcIYV+AN16oC2
         lMNNsx9AxmNBEpQRgZgSnnE0zg+CXNZjmf0SoFCxLm8OCiBwilXUPxidBmPb3nYEDQez
         jp8EledhHpmWqaPycEXO9O617rSJaFeYtly/CMCm+dEfm+6O/1D2/PcjgzsC5Z1mXfNg
         PtR8lMzXudtYNadAtq6NvmzJEqsrGoOvIqDK/WMxMAcukUhg0dvcqODoAu0ub4+cEJ/r
         eGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268152; x=1755872952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYjA5QDbSE0c0DWbdu0Xr2vmrUUrfAA2zDiVjrK2mhk=;
        b=xPKmTES1c78eT9NMhXuCroNw+Jy+n7P9tmICHwGKnLsF5sfth5AEd3kknrHYurE175
         /exUsCcabVPs93YXjbrXQy3IaKF+YPVERJQe1fmnvIFIrTSoj39f/8DtX+PeHcPVMrkH
         GLBsjFyLNU/oaLJj9dPthcZbIPBHjfMQmn6pfbvF2G7CjCmw3HRJDOcp/UlJip2bIChH
         4Qp3dhD5ZkscuqiggfH55I8WNdSvrLkAjxL/WCMkJhvuv9ns1HLSnUwSgwo8fGc20CgQ
         Ezdz+xeuquDFe2r3fi2hs/LL4XCw5VJUgsMEatixo81eWTksjgULZ8ay2YJ2edtZahg+
         ZsjA==
X-Gm-Message-State: AOJu0YwLbDW5ZO/s9jboOwSIPmJNi60KXVqnQIiR4pwoJfHPsF0Bf8b5
	Tw+QWXuD4hpmL8SMCZSyFwMBl0u4SOk3Jc6ZqrBHxamZot44qGO/6AsrRwsSAA==
X-Gm-Gg: ASbGncv5M1XT7VAVWF8nqlq/dlmCTeY8sDRyb6W+wnlorVVh1r0B4BHT28GSosulp0T
	tJeWxhZJHIyyFCt7Rsu0+mDx1NffWuNnOOT/QnLdq3Lds3+QcBijddaO82RWPlGZ3xfi50Up/rB
	v/lfDv+2P2zEwl65PVB0avAjMtnU7FTKUSr8lNHV3E0PgerTIWJbeFQUUmplKpakwk4BA66WZfK
	b9LcMZndSbDs1e+C4z/JnHa9WBgRP/cbBp94mdWpviEdzyApuTAwkZH7AWmuuby0djAIP8RR142
	FLcyoNC8tDgE1GjSwotT0jb9XOmYkOZEX59n+++EhMO+xDkZrFBHdTREB3ycX86FUJ/oEJE3wC2
	Xr4lSkcnXe6KfJiQ+77Xgs0iEZA==
X-Google-Smtp-Source: AGHT+IGIluOrNZScD6D+LJGDSQg3LDlThNShqtZCMISfsat+Ic5hGG9VUZQGCMSdzzOpZPtuqopb9g==
X-Received: by 2002:a17:903:1965:b0:243:926:b1f3 with SMTP id d9443c01a7336-2446d7a9610mr39774215ad.24.1755268151576;
        Fri, 15 Aug 2025 07:29:11 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c45:4e51:c909:665f:94f8:22a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9cffdsm15573475ad.5.2025.08.15.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:29:11 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v6] [matchbox-panel-2] panel: added sysfs support
Date: Fri, 15 Aug 2025 19:59:00 +0530
Message-ID: <20250815142901.1742993-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 14:29:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2002

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

[YOCTO #12904]
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
V5: https://lists.yoctoproject.org/g/yocto-patches/message/1802
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-acpi.c  |   2 +
 applets/battery/battery-apm.c   |   2 +
 applets/battery/battery-sysfs.c | 144 ++++++++++++++++++++++++++++++++
 applets/battery/battery.c       |   2 +
 applets/battery/battery.h       |   3 +-
 configure.ac                    |   4 +
 7 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 applets/battery/battery-sysfs.c

diff --git a/applets/battery/Makefile.am b/applets/battery/Makefile.am
index 9b02240..1b93a0b 100644
--- a/applets/battery/Makefile.am
+++ b/applets/battery/Makefile.am
@@ -5,6 +5,10 @@ applet_LTLIBRARIES = libbattery.la
 libbattery_la_SOURCES = battery.c battery.h
 libbattery_la_CPPFLAGS = $(AM_CPPFLAGS) -DDATADIR=\"$(pkgdatadir)/battery/\"
 
+if HAVE_SYSFS
+libbattery_la_SOURCES += battery-sysfs.c
+endif
+
 if HAVE_LIBAPM
 libbattery_la_LIBADD = -lapm
 libbattery_la_SOURCES += battery-apm.c
diff --git a/applets/battery/battery-acpi.c b/applets/battery/battery-acpi.c
index d1d3de9..42ef9c8 100644
--- a/applets/battery/battery-acpi.c
+++ b/applets/battery/battery-acpi.c
@@ -14,6 +14,8 @@ global_t global;
 adapter_t *ac;
 int batt_state, ac_state;
 
+void pm_cleanup(void) { }
+
 int pm_support(void)
 {
 	if(check_acpi_support() == NOT_SUPPORTED){
diff --git a/applets/battery/battery-apm.c b/applets/battery/battery-apm.c
index edaba43..f1501a0 100644
--- a/applets/battery/battery-apm.c
+++ b/applets/battery/battery-apm.c
@@ -9,6 +9,8 @@
 #include "battery.h"
 #include <apm.h>
 
+void pm_cleanup(void) { }
+
 int pm_support(void)
 {
 	if (1 == apm_exists ()) {
diff --git a/applets/battery/battery-sysfs.c b/applets/battery/battery-sysfs.c
new file mode 100644
index 0000000..e9c6c80
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,144 @@
+/*
+ * (C) Dixit Parmar
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Licensed under the GPL v2 or greater.
+ */
+
+#include "battery.h"
+#include <glib.h>
+
+#define PROCFS_PS_DIR "/sys/class/power_supply"
+
+static gchar *batt_dev;
+static gchar *ac_dev;
+static gboolean batt_exist = FALSE;
+static gboolean ac_exist = FALSE;
+
+void pm_cleanup(void)
+{
+        g_free(batt_dev);
+        g_free(ac_dev);
+}
+
+int pm_support(void)
+{
+	GDir *dir = g_dir_open(PROCFS_PS_DIR, 0, NULL);
+	if (dir != NULL) {
+		const gchar *subdir_name;
+		while ((subdir_name = g_dir_read_name(dir)) != NULL) {
+			gchar *subdir_path = g_build_filename(PROCFS_PS_DIR, subdir_name, NULL);
+			// Check if it's a directory
+			if (g_file_test(subdir_path, G_FILE_TEST_IS_DIR)) {
+				gchar *type_file_path = g_build_filename(subdir_path, "type", NULL);
+				// Check if the "type" file exists
+				if (g_file_test(type_file_path, G_FILE_TEST_EXISTS)) {
+					gchar *file_content = NULL;
+					gsize length;
+
+					if (g_file_get_contents(type_file_path, &file_content, &length, NULL)) {
+						if(!batt_exist && strncmp(file_content, "Battery", strlen("Battery")) == 0) {
+							batt_dev = g_malloc0(strlen(subdir_name) + 1);
+                                                        strncpy(batt_dev, subdir_name, strlen(subdir_name));
+							batt_exist = TRUE;
+						}
+						if(!ac_exist && strncmp(file_content, "Mains", strlen("Mains")) == 0) {
+							ac_dev = g_malloc0(strlen(subdir_name) + 1);
+							strncpy(ac_dev, subdir_name, strlen(subdir_name));
+							ac_exist = TRUE;
+						}
+						g_free(file_content);
+					}
+				}
+				g_free(type_file_path);
+			}
+			g_free(subdir_path);
+			if(batt_exist && ac_exist)
+				break;
+		}
+		g_dir_close(dir);
+	}
+	return (int)batt_exist;
+}
+
+static gboolean read_val_from_file(const gchar *dev, const gchar *f, gint64 *val)
+{
+	gboolean ret = FALSE;
+
+	if(dev != NULL && f != NULL && val != NULL) {
+		gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
+                gchar *file_content;
+                gsize length;
+
+                if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
+                       *val = g_ascii_strtoll(file_content, NULL, 10);
+			ret = TRUE;
+                }
+
+                g_free(file_content);
+		g_free(file_path);
+	}
+	return ret;
+}
+
+const char* pm_battery_icon(void)
+{
+	const char *icon;
+	gint64 temp_val = 0;
+	gint64 ac_status = 0;
+	gint64 batt_present = 0;
+	gint64 batt_percentage = 0;
+
+	if(batt_exist == FALSE)
+		return NULL;
+
+	/* Check battery presence */
+	if(read_val_from_file(batt_dev, "present", &temp_val))
+		batt_present = temp_val;
+
+	if(batt_present == 0) {
+		/* Battery is removed */
+		icon = "ac-adapter.png";
+		return icon;
+	}
+
+	/* Check Adaptor status*/
+	if(ac_exist && read_val_from_file(ac_dev, "online", &temp_val))
+		ac_status = temp_val;
+
+	/* Check battery percentage */
+	if(read_val_from_file(batt_dev, "capacity", &temp_val))
+		batt_percentage = temp_val;
+
+	if(ac_status == 1) {
+		/* We're charging */
+		if (batt_percentage < 10)
+			icon = "battery-charging-000.png";
+		else if (batt_percentage < 30)
+			icon = "battery-charging-020.png";
+		else if (batt_percentage < 50)
+			icon = "battery-charging-040.png";
+		else if (batt_percentage < 70)
+			icon = "battery-charging-060.png";
+		else if (batt_percentage < 90)
+			icon = "battery-charging-080.png";
+		else
+			icon = "battery-charging-100.png";
+	} else {
+		if (batt_percentage < 10)
+			icon = "battery-discharging-000.png";
+		else if (batt_percentage < 30)
+			icon = "battery-discharging-020.png";
+		else if (batt_percentage < 50)
+			icon = "battery-discharging-040.png";
+		else if (batt_percentage < 70)
+			icon = "battery-discharging-060.png";
+		else if (batt_percentage < 90)
+			icon = "battery-discharging-080.png";
+		else
+			icon = "battery-discharging-100.png";
+	}
+
+	return icon;
+}
diff --git a/applets/battery/battery.c b/applets/battery/battery.c
index b11517d..755042b 100644
--- a/applets/battery/battery.c
+++ b/applets/battery/battery.c
@@ -24,6 +24,8 @@ battery_applet_free (BatteryApplet *applet)
         g_source_remove (applet->timeout_id);
 
         g_slice_free (BatteryApplet, applet);
+
+        pm_cleanup ();
 }
 
 static gboolean
diff --git a/applets/battery/battery.h b/applets/battery/battery.h
index 534988f..7c54a3a 100644
--- a/applets/battery/battery.h
+++ b/applets/battery/battery.h
@@ -9,8 +9,7 @@
 #ifndef MB_APPLET_BATTERY_H
 #define MB_APPLET_BATTERY_H
 
-#include <string.h>
-
+void pm_cleanup(void);
 int pm_support(void);
 const char* pm_battery_icon(void);
 
diff --git a/configure.ac b/configure.ac
index be4d591..0f607f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,6 +61,9 @@ AC_ARG_WITH(
 )
 
 case "$with_battery" in
+     "sysfs") enable_linux_sysfs=yes
+     enable_battery=yes
+     ;;
      "acpi") AC_CHECK_HEADERS(libacpi.h, enable_linux_acpi=yes, AC_MSG_FAILURE([You need to install libacpi]))
      enable_battery=yes
      ;;
@@ -75,6 +78,7 @@ esac
 AM_CONDITIONAL(HAVE_BATTERY, test x$enable_battery = xyes)
 AM_CONDITIONAL(HAVE_LIBAPM, test x$enable_linux_apm = xyes)
 AM_CONDITIONAL(HAVE_LIBACPI, test x$enable_linux_acpi = xyes)
+AM_CONDITIONAL(HAVE_SYSFS, test x$enable_linux_sysfs = xyes)
 
 # glib-genmarshal
 GLIB_GENMARSHAL=`$PKG_CONFIG --variable=glib_genmarshal glib-2.0`  
-- 
2.43.0


