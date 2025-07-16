Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D37C83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 03:17:22 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.13243.1752635834309040810
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Jul 2025 20:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WpRTijwq;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2352400344aso55791835ad.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 15 Jul 2025 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752635833; x=1753240633; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCGKpU+YwCcM9srmW/65aLcbh1SFZPACGo+VxvXLWAQ=;
        b=WpRTijwqc86EqJ0D8feTSl2/fysvmNBN8f6ysIyBy4pPTXp7TCwidikgUrfpIE2Kqp
         ci7QbTuniaYpPPLuYFOg+iVElehpFLHMksV7iiLYYAEeOVjb1IgbvnfJ3YgsPVrAqf8R
         qKr37+u/u0UOlj2/S5TV3p6MfNETHAx6BZ48QQt0GSlqhfZE/vkTMwWoJh0KPxZDnyUw
         yZAPjEZHgPjyw+79Dt9ko3dgzsKbL8y5JOVpG8ds5Kyvy4sRsYN46YfezZsSQyspHw1a
         2Rbg5lryF6/gB1Tz0s0DS+fgA2JxD96D1jPPLoX4ymRZ2j5AW++z4hTg+3Xs/aFPvEaz
         pGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635833; x=1753240633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCGKpU+YwCcM9srmW/65aLcbh1SFZPACGo+VxvXLWAQ=;
        b=NmzsIXvJieoZaJZ0wXUo1bTtlK0PJlql43/6LAe0/4tI3gL+f6Dfo/Pw/F+HhZaybG
         YgzM0u/gOwT9mP3sBf2fP/L7KbPQn0gUxWMNo0VBgihxtZQvC0dKpjs9CgUro/14RCeV
         6NSMJemD5+vjFD8eM7lg1TmxoWcP3AGjtddF3KpbgWVTqfLXN6cIRqQOradLT2zPjuI/
         pILjvkwXUtQi78Rf/l4XzBHvQyrQPiv1RehqXtTfZl/ogLLjy+ngcEaPHyrQGYeUWwvA
         FVeR4cVP8ks1R5NtAIenaqlTsPkGLKi9GjRUiL0MIcULCf8iRDHNgYSQRJpi32sp0Flu
         E/0w==
X-Gm-Message-State: AOJu0YzSjEmMmvtjzDStWLhjUgkNHaNgWADl2icmbY4zkqSJdbTgOzj5
	7QSJToC3oQk42NspvSEhgFCo9PBKH9qusnWnN7XMUZY8RgQShV3O0udItzI/Og==
X-Gm-Gg: ASbGncspo3SVFwe8u4b/OY1zv6gsJkAaF6fNxUD+4uVyy/sJ4x90oR8NAn+GdUFoIqj
	1reTUTYaW3UMS8RsI9cuWGBWn0OIAUw6O3QkavjExfCAwbb81URGuP78UyR1FW8bj5ktsLbrZgK
	u64g/+x8OnRK1yDkwxxsJrRooYkuTzZxt/s71YfY+Cp9f0CYzmmPoAV0hTOFe1qyDLecCPH0y/Y
	c6H5aCBXfSRlNYP+H05eOt7bFhicq3FVrfeGB9KYZSNILaUydO5mWERasslB20SnFcTnSelSD0U
	mN8NTJVUNz2TPHFpG99mmTYy9NAULt5xr7wESzpytF73yNZc8PmOyPGdiIfKCN+hWoCYZZLAyoK
	psGVG9zHEq/7y4eBMt9H8M62gzA==
X-Google-Smtp-Source: AGHT+IHn/MRkhaFh9ex/AbIHnx0Ni/7zzzYqRABpxmymNZpUk3KkpC1VmCE27jPEVnsONJFwdMG+Zg==
X-Received: by 2002:a17:902:e745:b0:224:76f:9e4a with SMTP id d9443c01a7336-23e24f49469mr17861805ad.14.1752635833339;
        Tue, 15 Jul 2025 20:17:13 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c7e:dba6:18ef:48fa:8f71:443e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4284898sm119335705ad.24.2025.07.15.20.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:17:12 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v5] [matchbox-panel-2] panel: added sysfs support
Date: Wed, 16 Jul 2025 08:47:04 +0530
Message-ID: <20250716031705.110773-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 03:17:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1802

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

[YOCTO #12904]
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
V4: https://lists.yoctoproject.org/g/yocto-patches/message/789
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-acpi.c  |   2 +
 applets/battery/battery-apm.c   |   2 +
 applets/battery/battery-sysfs.c | 148 ++++++++++++++++++++++++++++++++
 applets/battery/battery.c       |   2 +
 applets/battery/battery.h       |   3 +-
 configure.ac                    |   4 +
 7 files changed, 163 insertions(+), 2 deletions(-)
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
index 0000000..acb01b3
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,148 @@
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
+static guchar batt_exist = 0;
+static guchar ac_exist = 0;
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
+							batt_exist = 1;
+						}
+						if(!ac_exist && strncmp(file_content, "Mains", strlen("Mains")) == 0) {
+							ac_dev = g_malloc0(strlen(subdir_name) + 1);
+							strncpy(ac_dev, subdir_name, strlen(subdir_name));
+							ac_exist = 1;
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
+        gboolean ret = TRUE;
+	gchar *endptr;
+
+	if(dev != NULL && f != NULL && val != NULL) {
+		gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
+                gchar *file_content;
+                gsize length;
+
+                if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
+                       *val = g_ascii_strtoll(file_content, &endptr, 10);
+                } else {
+                    ret = FALSE;
+                }
+
+                g_free(file_content);
+		g_free(file_path);
+		return ret;
+	}
+	return ret;
+}
+
+const char* pm_battery_icon(void)
+{
+	const char *icon;
+
+        gint64 temp_val = 0;
+	gint64 ac_sts = 0;
+	gint64 batt_present = 0;
+	gint64 batt_percentage = 0;
+
+	if(batt_exist == 0)
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
+	if(read_val_from_file(ac_dev, "online", &temp_val))
+		ac_sts = temp_val;
+
+	/* Check battery percentage */
+	if(read_val_from_file(batt_dev, "capacity", &temp_val))
+		batt_percentage = temp_val;
+
+	if(ac_exist && ac_sts == 1) {
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


