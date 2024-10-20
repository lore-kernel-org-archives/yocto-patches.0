Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59370D3C927
	for <webhook@archiver.kernel.org>; Sun, 20 Oct 2024 11:20:20 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.23130.1729423213089880980
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Oct 2024 04:20:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QLRVKAw0;
 spf=pass (domain: gmail.com, ip: 209.85.215.174, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea9739647bso2405855a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Oct 2024 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729423212; x=1730028012; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0bKlLL5NadinEeELcLanfUz4FLjXmVQXiC/IjEMk+Q=;
        b=QLRVKAw0ptXSgkNieGeoHXPztHfP+GxsKCkC2QAhOzcOn4XeOp5d093l6fFl2uKTTy
         ILKdGXuVBBLXvRQq8NmCuMcLLfzCbJJjAp535bwhHuhtiCIoXMGMs0osrkLLPSEXeKzh
         22FXcChryVFkvI8yagIW8Dkr52iWFUW2SiUjpUJd1ljwra8X5m8kK5n54xdF6N4N6n/a
         tW+oOBZHYEVa0EEFQPGoVguGmxMBOCS+V0bfBvIPgxgwSjETTcsCG/H5VivD/EiTuIeC
         Pr9/87Szmb0bAK43005scB+R0zrGK3SQjdYfG8OwgTFZi1UELMTopuGCUmq0zvgrLixJ
         G6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729423212; x=1730028012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0bKlLL5NadinEeELcLanfUz4FLjXmVQXiC/IjEMk+Q=;
        b=Wf1QY3rSijybGiOLh7nem+ZWXtCWkGAakgM+Q3HAvSX6LZ+vGaJaFewMhZzTDzhx7v
         9ppdxCO24YixlmytBB0UMsKb5M+F3DXFxF6U058u6ERq0DpzmQr+y9oOyWc0tvEC7/50
         eR4qHNKe5xbh/KS+JsNBm5CHMB3h8E4yBtBWXMd7nOiqzSUGolp0xWZKAbW5qC5kMYcr
         MwmlsMqFeWXBzfH/nfBRTD6LevCJOlTn6mVPYn9G/O8F087ih1GUprXhBPVy3rysleR+
         f68gSHR6vUW6Yxy+/R23wxpuXkqkxKUKA1ZOZ8J6MA3GWrlL/fy8eyWb+mTLqmNXyRjz
         0pMA==
X-Gm-Message-State: AOJu0YxeuQogf5h4TeTUBJ1tCfbWZOSaH8Sq+kFBKzx1GV6DSBgnCaMj
	wEbc3xVA2+eR8/u++WRBYwSXhmVwwH/oBNpEVltPcYxwSbJy/QRGc02A5Q==
X-Google-Smtp-Source: AGHT+IHQV0oygMKjuoBeLCtGuvUdgmVAgn67supMYLQVas3tvdLC/9oQ0ZVidDzQNZDsOAbSwGnueg==
X-Received: by 2002:a05:6a21:e8e:b0:1d7:8a9:640 with SMTP id adf61e73a8af0-1d92c583a17mr11101772637.44.1729423211963;
        Sun, 20 Oct 2024 04:20:11 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c45:9bd8:3f9e:b18a:2e1:a2d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d755dsm1000737b3a.136.2024.10.20.04.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:20:11 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [matchbox-panel-2 1/1] panel: added sysfs support
Date: Sun, 20 Oct 2024 16:50:00 +0530
Message-ID: <20241020112000.452050-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 20 Oct 2024 11:20:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/721

battery applet supports reading battery and supply
information from sysfs entries, /sys/class/power_supply/.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 applets/battery/Makefile.am     |   4 +
 applets/battery/battery-sysfs.c | 153 ++++++++++++++++++++++++++++++++
 applets/battery/battery.h       |   5 +-
 configure.ac                    |   4 +
 4 files changed, 165 insertions(+), 1 deletion(-)
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
index 0000000..c3ff45f
--- /dev/null
+++ b/applets/battery/battery-sysfs.c
@@ -0,0 +1,153 @@
+/*
+ * (C) 2008 Intel.
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


