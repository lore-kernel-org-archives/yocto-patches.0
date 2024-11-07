Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC111D43376
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 16:19:15 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.76269.1730996353152627585
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 Nov 2024 08:19:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fbrDjl81;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so969084b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 Nov 2024 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730996352; x=1731601152; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwDgIbTUTqYtFXDLbxdu7QOoPe/r5AwyO/BKlYgc5E0=;
        b=fbrDjl81GFPo+RBf/W/kHZpQDJl/BovVSCuLkOmnBTv9RXFI8Z4U+APng5Fsv36AgP
         +BjzlE2MnGq9/jXVpgXjhtI9ZRvqJYtHGndb3cGaH7CrM+jlvtevv59LkHa5zF0iK7O3
         wJyK5jST4XYj/KoD+vaCkHkkQdFzIAjF0kFLRipsCFresv1NMppIhFggGpNNGpoEcbaO
         V1h+N1IEMuTWElzzBYnTjEUzMnjPlTZr5miMuL2kayQgwa+dXRMW6tH7NYh5SzdhoIAU
         qjAC9yztCZOcUbrnPhwLg8DRRK+xuaMro48bi2BWfdikyZtUjVKMAClLVIvr4ikr45nA
         2sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996352; x=1731601152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwDgIbTUTqYtFXDLbxdu7QOoPe/r5AwyO/BKlYgc5E0=;
        b=Rt0c35d/OBUIXA40TTTXfyRP6L6r/DtkVF5cgjBFqGQkFIrtPzlX1+2vZsAI9800Zx
         W8DU72mA5ibEK9cwp6h4ZXTCE4INuVIJcBtOsLyyO0Cj09quNaTIU2ioxSeHvcuWTL3A
         TMO09Z6qeJQCIPDgi0Bq0QH+/iINbAc1qtysUSBC0AtiJt3zqSMK8HEN0kRZEbN7Pt4x
         FCWENsIHpIccBcW6sWo+OuZ0PY1BPdoLa6VMFei8wdzGSuNWSRBO3vjnZNrUXIVaV15K
         jl3lquqkDyjv2lzpuLwNqHavmcZofckY9y+xXMEx1FPtlwNa2x5ZAZQRvpbrY6jKRVFZ
         3PWw==
X-Gm-Message-State: AOJu0Yx3tfzgsQtMbwRyPaAq6D98Tvx4LYXVC0kEfT2BsfEYbSkh4jw5
	uItbFgphMqYtbyOmSv2ZYWbW8mG3nL2kMjHwIl55MMy9Uoh/J3NhM0m50Q==
X-Google-Smtp-Source: AGHT+IHdLvvBJLw4OYUyrzQEYJ0f0dgfAorXNWYdwtA0tg1ZAaI/Q4ZB33CZNGvq78B1Ii1INJPSVA==
X-Received: by 2002:a05:6a20:4303:b0:1db:eba6:225 with SMTP id adf61e73a8af0-1dc206283b3mr126888637.35.1730996352266;
        Thu, 07 Nov 2024 08:19:12 -0800 (PST)
Received: from dixit.. ([2409:4080:ce39:d13f:6fcf:5b33:f7a0:45cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3a9csm1731730b3a.110.2024.11.07.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:19:11 -0800 (PST)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [matchbox-panel-2 v4] panel: added sysfs support
Date: Thu,  7 Nov 2024 21:49:00 +0530
Message-ID: <20241107161901.43148-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 Nov 2024 16:19:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/789

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

[YOCTO #12904]
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-sysfs.c | 142 ++++++++++++++++++++++++++++++++
 applets/battery/battery.h       |   3 +-
 configure.ac                    |   4 +
 4 files changed, 152 insertions(+), 1 deletion(-)
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
diff --git a/applets/battery/battery-sysfs.c b/applets/battery/battery-sysfs.c
new file mode 100644
index 0000000..c71d8cf
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,142 @@
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
+static char batt_dev[128] = "";
+static char ac_dev[128] = "";
+static char batt_exist = 0;
+static char ac_exist = 0;
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
+							strncpy(batt_dev, subdir_name, strlen(subdir_name));
+							batt_exist = 1;
+						}
+						if(!ac_exist && strncmp(file_content, "Mains", strlen("Mains")) == 0) {
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
+int read_file(const char *dev, const char *f, char *buff, size_t len)
+{
+	if(dev != NULL && f != NULL && buff != NULL) {
+		gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
+		gchar *file_content = NULL;
+                gsize length;
+		if (g_file_get_contents(file_path, &file_content, &length, NULL)) {
+			if(length <= len) {
+				memset(buff, 0, len);
+				memcpy(buff, file_content, length);
+			} else {
+				length = -1;
+			}
+		}
+		g_free(file_content);
+		g_free(file_path);
+		return length;
+	}
+	return -1;
+}
+
+const char* pm_battery_icon(void)
+{
+	const char *icon;
+	char buff[128] = "";
+	int ret = 0;
+
+	gchar *endptr;
+	gint64 ac_sts = 0;
+	gint64 batt_present = 0;
+	gint64 batt_percentage = 0;
+
+	if(batt_exist == 0)
+		return NULL;
+
+	/* Check battery presence */
+	ret = read_file(batt_dev, "present", buff, sizeof(buff));
+	if(ret > 0) {
+		batt_present = g_ascii_strtoll(buff, &endptr, 10);
+	}
+	if(batt_present == 0) {
+		/* Battery is removed */
+		icon = "ac-adapter.png";
+		return icon;
+	}
+
+	/* Check Adaptor status*/
+	ret = read_file(ac_dev, "online", buff, sizeof(buff));
+	if(ret > 0)
+		ac_sts = g_ascii_strtoll(buff, &endptr, 10);;
+
+	/* Check battery percentage */
+	ret = read_file(batt_dev, "capacity", buff, sizeof(buff));
+	if(ret > 0)
+		batt_percentage = g_ascii_strtoll(buff, &endptr, 10);
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
+	return icon;
+}
diff --git a/applets/battery/battery.h b/applets/battery/battery.h
index cf23431..a941aec 100644
--- a/applets/battery/battery.h
+++ b/applets/battery/battery.h
@@ -6,8 +6,9 @@
 
 #ifndef MB_APPLET_BATTERY_H
 #define MB_APPLET_BATTERY_H
-
+#include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 
 int pm_support(void);
 const char* pm_battery_icon(void);
diff --git a/configure.ac b/configure.ac
index d6c57d8..7038212 100644
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


