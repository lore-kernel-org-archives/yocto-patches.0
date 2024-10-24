Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D36D2E02D
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 11:09:57 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.12198.1729768179346895189
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 04:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BqcPLwrG;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c77459558so5827155ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729768178; x=1730372978; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnQPaFmUlHdnQmf079lKJFyr33Nr6jc4BKoUQ5X7ORM=;
        b=BqcPLwrGf4LqiVzwLuOppWgvH7ljlVFMaGfXfTuejjo81ANu7srmO/Boywy84hXxn3
         qDYlNb80jPrxu9Kh9VxDCDx0wfyRvNuxO/3ufhHFsj1duoTERm51E3+9aNjqLXLa9EnR
         DxMsoFyT6MaaAfUEcXKnOsXitcGu3kqkezp+RWvHG7sFrBomLiK/8UEQ3NUMwrlQBl3c
         j4vG29LG+hLcO2mRRMEa/DTtgErwVjVYQPRHu0w7ZQywnJ0/i/Bg0CJqvhFVYYF8KGc4
         ft4HXG28Mzr+W2TZUP/fIwOJbv58+FLk+GSPsrm2m16+uTdhERykq97XXdXEHWcz+TmI
         UOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768178; x=1730372978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnQPaFmUlHdnQmf079lKJFyr33Nr6jc4BKoUQ5X7ORM=;
        b=SjjLQQQ/WB7XXlT+jJfVEonm6V+pJ3fOjlj2qyogfiTmTuUjityToBQHGFB9wFiu2X
         805b4NV8j6yZrj+9joHJBnxT7Gt1d4WZ1YrW73qCPoJiawtWYepFjDAF4EFP4vN7Mo9c
         +cZsFRmSFvX3KlxRR3sX5OS261Gh1J6Ct+hZ3REn49UDLLpPmpdsm3fQo2zGz3Qldr4w
         f5qqBv/kRbI3Xbo+k62DDTTsELAmS0ssf9x/zy1zcpz81uqejVPhYdQzbBnsRs7az15v
         ViKhEKdm737XhRqBsIH385/wqUXPudx9tA/aMJenmRKl2dmY/LP2n/dABQJt0Zx5abF6
         +oEg==
X-Gm-Message-State: AOJu0Yy/E35acnKusk0Ikb83exweanDQYXU3PSKVA5FPWClznZdVzAnp
	3TN4ALFp6dETKz6mPuVyqYR9tDdnKWhLeUtJLFUZvu6kFOtxSCCS7CvHLQ==
X-Google-Smtp-Source: AGHT+IHkUI5rmeiHtgXh8lQ7/ErqfMlS4joKnI3LPWdpPtmGTni1pCbv3xzKEunINbf9LbViE4nynw==
X-Received: by 2002:a17:902:fc50:b0:20b:65d6:d268 with SMTP id d9443c01a7336-20fa9ea3de1mr72399995ad.53.1729768178425;
        Thu, 24 Oct 2024 04:09:38 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c42:292:437c:e2c1:8aa2:578f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f354fsm70242165ad.262.2024.10.24.04.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:09:38 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [matchbox-panel-2 v3] panel: added sysfs support
Date: Thu, 24 Oct 2024 16:39:27 +0530
Message-ID: <20241024110927.494096-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 11:09:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/740

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
index 0000000..7a416ea
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,155 @@
+/*
+ * (C) Dixit Parmar
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


