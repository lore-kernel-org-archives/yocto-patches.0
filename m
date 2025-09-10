Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F30CAC58C
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 05:49:08 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.10400.1757483347113974919
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 22:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KmI5q7tO;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445805aa2eso62953335ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757483346; x=1758088146; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCuzXzC/IGxxlMQuWzNTK/x6zPQXwiAr96oXnYXL1+o=;
        b=KmI5q7tO7vnTkD9XTKABrXBOdRrrWHj2o0Xg1kceH3E1sa8j5jwb/UbAGnrVJbnM5S
         6KoR/0hcNjYcND/6/vuAI/qTBnXvr7ihAIbkDUdxIYBkTVpmvIE0u0Gwu5N0NsbSDPj1
         5WwBrSfefgU7vvPlet8Psv7Lm/F3+p8YvvsF4MjtlWZuk/3FjSVjFjWU2/48g8TvmouO
         NoptK46EpAv4S0yv2epH8V8P0bzeKP7BM4IlMH/J+Y/SU+XhvvvMSHbLkiwi3xfVR94E
         l7InlTSDk6avChs8iz4+PWcyaL6KK4jj/rTAW42iEzy16atMrjdWNx/uYaxRJ4ciESV4
         sGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757483346; x=1758088146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCuzXzC/IGxxlMQuWzNTK/x6zPQXwiAr96oXnYXL1+o=;
        b=RPBPUHS3UO2EQpp253RZyChRcKbRdZ5aLhSktdN+agbHfk8qU2M2/7EXwNtADhfbxN
         KQa6aUvKb4otMCtZWsU/RchMflggY9FVWMiYsmsPmM48idKx56MlE3a4fTY+W2RQreZW
         Z3gkBHuzLaWmyPQ1XMtNtlbHODisA5NG8ud8nDStsmGx1xDgLt810vB7cjrGXD+oXSVL
         kqI+abv3PYPnHiLzTiPBiahc4eWZ3cWHi5QhfJOgqceFO9ZBO3UFknISx65kYAPPpweG
         27kclCwUGqBylbiB6ueAevXsgAatDKSpXlgX4Jo7MDzI7Zvgpv0KYKMDI/gbrHOgG4Rx
         MEIw==
X-Gm-Message-State: AOJu0Yzh8uB/laqkSuWqfqWHtBqU9ND1Q44IKgWNbu6s5LFE/SHpsYp4
	IVQC1PWda9WPbIJm+7QtlimApywydUN+aSVwWzy0l3F/blcyii95J+nYFnqp4g==
X-Gm-Gg: ASbGncs4IDDF4lE2MVR3g2tfCIaJbfktB3xhz3I2v4nk+/Dt8cfTuYAGO7MZzL/nwiu
	AURnJasO8k2XJj6aBW8gA2g4llpSmsmIB5u0B4ms8J3TFKSBpwq/QSO6KGHbF2lrQEEqZYZCZIv
	7y1p2W0VZBvQFf7Q342YAzEjzA413HR95sRXmJRagzmHSlC5TjQxr4n4qGFmPii7KSKX0dzp5CI
	nns6v6WKAiDw3VbR2uHV5/NWMDLfVzHvA13x8IZySRNxIeWJZuEIYM4g6WSq17+7sU+7wCXYQUO
	/cpduadWCSHD9MoHbeP2VXfyLmADTEK3DUIbTP+d4eX9vO73pJAcswLzBgirPwgZ9S6Nu/m4lWR
	OlAs6vF8vb+DrJRB38OYEWaYC53y9uUbAyg==
X-Google-Smtp-Source: AGHT+IGCwrQ5F3NoLJW9Pz11ZIARxRlRUiLF46dVOGMixnDnS90H7NPtWpPHJhFX5wX8emaWdi2XhQ==
X-Received: by 2002:a17:903:2ec6:b0:24c:9309:586f with SMTP id d9443c01a7336-251703910c3mr203493185ad.24.1757483346067;
        Tue, 09 Sep 2025 22:49:06 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c7e:73ce:c1b3:ae9:98ce:970])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a344c28sm15433485ad.84.2025.09.09.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:49:05 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH v7] [matchbox-panel-2] panel: added sysfs support
Date: Wed, 10 Sep 2025 11:16:53 +0530
Message-ID: <20250910054700.76888-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Sep 2025 05:49:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2178

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

[YOCTO #12904]
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
V6: https://lists.yoctoproject.org/g/yocto-patches/message/2145
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-acpi.c  |   2 +
 applets/battery/battery-apm.c   |   2 +
 applets/battery/battery-sysfs.c | 143 ++++++++++++++++++++++++++++++++
 applets/battery/battery.c       |   2 +
 applets/battery/battery.h       |   3 +-
 configure.ac                    |   4 +
 7 files changed, 158 insertions(+), 2 deletions(-)
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
index 0000000..ec1d179
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,143 @@
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
+        GDir *dir = g_dir_open(PROCFS_PS_DIR, 0, NULL);
+        if (dir != NULL) {
+                const gchar *subdir_name;
+                while ((subdir_name = g_dir_read_name(dir)) != NULL) {
+                        gchar *subdir_path = g_build_filename(PROCFS_PS_DIR, subdir_name, NULL);
+                        // Check if it's a directory
+                        if (g_file_test(subdir_path, G_FILE_TEST_IS_DIR)) {
+                                gchar *type_file_path = g_build_filename(subdir_path, "type", NULL);
+                                // Check if the "type" file exists
+                                if (g_file_test(type_file_path, G_FILE_TEST_EXISTS)) {
+                                        gchar *file_content = NULL;
+                                        gsize length;
+
+                                        if (g_file_get_contents(type_file_path, &file_content, &length, NULL)) {
+                                                file_content = g_strchomp(file_content);
+                                                if(!batt_exist && g_strcmp0(file_content, "Battery") == 0) {
+                                                        batt_dev = g_strdup(subdir_name);
+                                                        batt_exist = TRUE;
+                                                }
+                                                if(!ac_exist && g_strcmp0(file_content, "Mains") == 0) {
+                                                        ac_dev = g_strdup(subdir_name);
+                                                        ac_exist = TRUE;
+                                                }
+                                                g_free(file_content);
+                                        }
+                                }
+                                g_free(type_file_path);
+                        }
+                        g_free(subdir_path);
+                        if(batt_exist && ac_exist)
+                                break;
+                }
+                g_dir_close(dir);
+        }
+        return (int)batt_exist;
+}
+
+static gboolean read_val_from_file(const gchar *dev, const gchar *f, gint64 *val)
+{
+        gboolean ret = FALSE;
+
+        if(dev != NULL && f != NULL && val != NULL) {
+                gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
+                gchar *file_content;
+                gsize length;
+
+                if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
+                       *val = g_ascii_strtoll(file_content, NULL, 10);
+                        ret = TRUE;
+                }
+
+                g_free(file_content);
+                g_free(file_path);
+        }
+        return ret;
+}
+
+const char* pm_battery_icon(void)
+{
+        const char *icon;
+        gint64 temp_val = 0;
+        gint64 ac_status = 0;
+        gint64 batt_present = 0;
+        gint64 batt_percentage = 0;
+
+        if(batt_exist == FALSE)
+                return NULL;
+
+        /* Check battery presence */
+        if(read_val_from_file(batt_dev, "present", &temp_val))
+                batt_present = temp_val;
+
+        if(batt_present == 0) {
+                /* Battery is removed */
+                icon = "ac-adapter.png";
+                return icon;
+        }
+
+        /* Check Adaptor status*/
+        if(ac_exist && read_val_from_file(ac_dev, "online", &temp_val))
+                ac_status = temp_val;
+
+        /* Check battery percentage */
+        if(read_val_from_file(batt_dev, "capacity", &temp_val))
+                batt_percentage = temp_val;
+
+        if(ac_status == 1) {
+                /* We're charging */
+                if (batt_percentage < 10)
+                        icon = "battery-charging-000.png";
+                else if (batt_percentage < 30)
+                        icon = "battery-charging-020.png";
+                else if (batt_percentage < 50)
+                        icon = "battery-charging-040.png";
+                else if (batt_percentage < 70)
+                        icon = "battery-charging-060.png";
+                else if (batt_percentage < 90)
+                        icon = "battery-charging-080.png";
+                else
+                        icon = "battery-charging-100.png";
+        } else {
+                if (batt_percentage < 10)
+                        icon = "battery-discharging-000.png";
+                else if (batt_percentage < 30)
+                        icon = "battery-discharging-020.png";
+                else if (batt_percentage < 50)
+                        icon = "battery-discharging-040.png";
+                else if (batt_percentage < 70)
+                        icon = "battery-discharging-060.png";
+                else if (batt_percentage < 90)
+                        icon = "battery-discharging-080.png";
+                else
+                        icon = "battery-discharging-100.png";
+        }
+
+        return icon;
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


