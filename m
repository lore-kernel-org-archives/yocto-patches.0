Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F3D2CE08
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 17:11:07 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.24043.1729617060977211017
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Oct 2024 10:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JIHeDlIs;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cb89a4e4cso41778695ad.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Oct 2024 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617060; x=1730221860; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8a8M67SIj69js2Dpx1hghY3XAfd6tW1rpGa2jDh2O1g=;
        b=JIHeDlIsXd0bqn+xhhTiE4XNBc671U9voZE2RmyRiK6gtzTWFX079pLpIKATYq+zIO
         daP2SEZDd4jtfECX0ZpYIyZ9UrwbC9nRsrEsnexbwJuISAjbDYQKZjGMSYB34WRbuir0
         xugW1ROeEhrVkgbKDIwQsVdY4HbmYARxgL4uC85ByQdCiiYcsSEjJUwEzlcktHTjaBWZ
         JUGFAy1i7llMPPH45ZJ1aEhz/ddJAkiUjsBvINAoh88KZ+i2UQfB9ZAAh3OLMHzbyg/9
         9dVyDWX9AEuR6CPHlUO+xN4e23KSh3HCukr3M7SGp60pINpaLFB5D7yFV7BmmpW/ymz7
         ozLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617060; x=1730221860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a8M67SIj69js2Dpx1hghY3XAfd6tW1rpGa2jDh2O1g=;
        b=EVjmusPdKZSlXBb5ivM9f5cQzHs1VTP3n7Z2H7elIVJJKI+Rv5izMGNhm2OGnjNjB2
         2Y9+gnqpDjJ60GUyuF8KvleyQoq0lh1ERTrfgoLwaJZbzl0vTi76N+mqpChOwSkAIlMI
         +92DExQHvvbfzJBiiUQDVmRF3QdX5iHpqrGav3fKcBrhL2imYEdJM1hiGMMtsIq2t7BC
         eWlDijguPPnoySdjASDXiZSdF2H1jkRceXBJOmEENoNcmr7bBU+jPindriSV37+zWD/d
         o9zF6d4I72MBtjZG1somstjLtdb2FxtFLgTyiTlZzUAjR71XXF+618qQ7zROqifF3NXT
         NS8A==
X-Gm-Message-State: AOJu0YymVHjQoEPF/Hdqq7Ek1/hSAac3/nLy6sPg34nElnsC3ZXGhJCn
	yS0lyKe4X2JJrR6r8dHwkNlFeiLjPqiBnQDk9GSCP/bhIPL38j2vcp/RnQ==
X-Google-Smtp-Source: AGHT+IHfrqjTx/TF9A7pILA3ZgAtGEw5bhf69tjfQbu31BxkaqEFI+Vblokk5uq48QEgieGmjRE5Gg==
X-Received: by 2002:a17:902:e54a:b0:20b:a6f5:2780 with SMTP id d9443c01a7336-20e5a75a128mr207188995ad.17.1729617059878;
        Tue, 22 Oct 2024 10:10:59 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c45:8d8f:cf:df59:6e29:e080])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f33a1sm44820655ad.260.2024.10.22.10.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:10:59 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [matchbox-panel-2 v2] panel: added sysfs support
Date: Tue, 22 Oct 2024 22:40:35 +0530
Message-ID: <20241022171035.460059-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Oct 2024 17:11:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/726

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

[YOCTO #12904]
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-sysfs.c | 155 ++++++++++++++++++++++++++++++++
 applets/battery/battery.h       |   5 +-
 configure.ac                    |   4 +
 4 files changed, 167 insertions(+), 1 deletion(-)
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
index 0000000..523b652
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,155 @@
+/*
+ * (C) 2008 Intel.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Licensed under the GPL v2 or greater.
+ */
+
+#include "battery.h"
+
+#define PROCFS_PS_DIR "/sys/class/power_supply"
+
+static char batt_dev[128] = "";
+static char ac_dev[128] = "";
+static char batt_exist = 0;
+static char ac_exist = 0;
+
+int read_file_content(const char *file_path, char *buff, size_t len)
+{
+	FILE *fd = NULL;
+	int ret = 0;
+
+	fd = fopen(file_path, "r");
+	char *line = NULL;
+	if(fd != NULL)
+	{
+		ret = getline(&line, &len, fd);
+		if(ret > 0)
+		{
+			memcpy(buff, line, ret);
+		}
+		free(line);
+		fclose(fd);
+	}
+	return ret;
+}
+
+int read_file(const char *dev, const char *f, char *buff, size_t len)
+{
+	char file_path[256] = "";
+	printf("%s/%s\n", dev, f);
+
+	if(dev != NULL && f != NULL && buff != NULL)
+	{
+		memset(buff, 0, len);
+		snprintf(file_path, sizeof(file_path), "%s/%s/%s", PROCFS_PS_DIR, dev, f);
+		return read_file_content(file_path, buff, len);
+	}
+	return -1;
+}
+
+int pm_support(void)
+{
+	DIR *dir;
+	struct dirent *in_file;
+	dir = opendir(PROCFS_PS_DIR);
+	char buff[128];
+	int ret;
+
+	if(dir != NULL)
+	{
+		while(in_file = readdir(dir))
+		{
+			if(in_file->d_name[0] == '.') /* Skip . & .. directory */
+				continue;
+			if(in_file->d_type == DT_DIR || in_file->d_type == DT_LNK)
+			{
+				ret = read_file(in_file->d_name, "type", buff, sizeof(buff));
+				if(ret > 0)
+				{
+					if(!batt_exist && strncmp(buff, "Battery", strlen("Battery")) == 0)
+					{
+						strncpy(batt_dev, in_file->d_name, strlen(in_file->d_name));
+						batt_exist = 1;
+					}
+					if(!ac_exist && strncmp(buff, "Mains", strlen("Mains")) == 0)
+					{
+						strncpy(ac_dev, in_file->d_name, strlen(in_file->d_name));
+						ac_exist = 1;
+					}
+				}
+			}
+			if(batt_exist && ac_exist)
+				break;
+		}
+	}
+	return (int)batt_exist;
+}
+
+const char* pm_battery_icon(void)
+{
+	const char *icon;
+	char buff[128] = "";
+	int ret = 0;
+	int ac_sts = 0;
+	int batt_present = 0;
+	int batt_percentage = 0;
+
+	if(batt_exist == 0)
+		return NULL;
+
+	/* Check battery presence */
+	ret = read_file(batt_dev, "present", buff, sizeof(buff));
+	if(ret > 0)
+		batt_present = atoi(buff);
+	if(batt_present == 0)
+	{
+		/* Battery is removed */
+		icon = "ac-adapter.png";
+		return icon;
+	}
+
+	/* Check Adaptor status*/
+	ret = read_file(ac_dev, "online", buff, sizeof(buff));
+	if(ret > 0)
+		ac_sts = atoi(buff);
+
+	/* Check battery percentage */
+	ret = read_file(batt_dev, "capacity", buff, sizeof(buff));
+	if(ret > 0)
+		batt_percentage = atoi(buff);
+
+	if(ac_exist && ac_sts == 1)
+	{
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
+	}
+	else
+	{
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
index cf23431..5c60744 100644
--- a/applets/battery/battery.h
+++ b/applets/battery/battery.h
@@ -6,8 +6,11 @@
 
 #ifndef MB_APPLET_BATTERY_H
 #define MB_APPLET_BATTERY_H
-
+#include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <dirent.h>
 
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


