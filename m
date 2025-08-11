Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D1CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:00:14 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.43006.1754899205905106449
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 01:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lRKRnGYE;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af98841b4abso672535966b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899204; x=1755504004; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eKpgRg4mTiuES3oYr2xKwOZ7Gx9nLwrBapP/CT4q/A=;
        b=lRKRnGYEwWOaivW1vsWT6hg0aAfRrGZ3oavLbWBXaMqzYSCmQkndGc3FQNI4XB8uKH
         7Wi6yJPFO3+r1w8gCYqkCPF4zGz7+Mu3cT3Va8hyBsq005lgWjRY1fx5eA8rvJr5NAa0
         rx3SYe8qd+vcXuzQQxvCeBauaWjgunyTP9Jz5P2A6711wpdYZ/B8ENYxFvPSiaNczwXu
         KhDJ6/TRbV4JSSXFtAUdd78ZQEVtSwUtzCqjx4PlgJwSiUN/r6NYxGkaAi6HMiOM025e
         U1ZH5uROxZrd2mb1ctu/BKnJP+mlttZDMUMm/dKiPv6UysI5IUjhVQJ0+W6xT5MdcY9J
         uBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899204; x=1755504004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eKpgRg4mTiuES3oYr2xKwOZ7Gx9nLwrBapP/CT4q/A=;
        b=OVowQL/Bi/uLi266aMA3WFUuiMOf5QCxzm+Pr8fk/UbiCGfZZrBAbsvbmOhKgVs+l2
         ZFgTFR38PA6va2u6kLQEj8mgmwbIIIgpyZMowS8ziCxFjEMKtQYIhK1U8H0moVipCRm7
         XAadABf9Xo43SrRqAxgLKZIqmCMkH2l5Xn3Z/B8+5zaJt1MO8QTiCosoq22bhmIBivfr
         nmKIwryB5uhEN77KLDo9wx2XdVVS81Ndjaq1B2HgKTIxhnCW8l/2O/VsMNJ4ecp3Lu8s
         9RjYNWci1rCQvdNPxogLRZMgU723a4UoqNRvAFdBP05qCkVtdMBWpHohUwjWazagHBnd
         gJQw==
X-Gm-Message-State: AOJu0YxW9aI2HZtuAIt8XOq0oAAqO7taMBRi4EKWU+9o52Zw+dHzLzNw
	UlM6m0Pf7t7uIFpm6g6bzBci/PHhqEnij2ad7bnNYYpdy8zykf2nSv2VOztGAw==
X-Gm-Gg: ASbGnctMBGGbXBTCapfAmotaxwS1BFUZqv/BR8JoZI4eb6t+ghQjWY6N7aIxzGJ+JgF
	WGTEIYHalvb/kBN6syN1+n66QF2l6fC7XCDiKYyTTMt7tHV6D0SMMAcEohSsbaXRTKVi1mmjQcO
	7meoyU745N2Op/WqIVR/GbAmag9Bs5Lh3aQ6fpsmK+q6UWoeFMH6p70fWyiHSJgbOunuUPXaAeF
	RYkpzuQZ985qNmCa8rWNEpXdB3zrHIZ5wRn71zMgGYsMumCsaI2fV+Z9uAgDTOeU1585nrtr/Bi
	h0Vj3VaRjQqX/9lj8cSh3Q5LTzk69kWRz1wzePYkTnBOlMLrcabxpFEMBuiz0zOXv2fyLqQKI6l
	RTIPD5+UBQawOc69IyDHb6WmhVryg7A==
X-Google-Smtp-Source: AGHT+IGWJlYDdSEzAbGhmT6sdagv9OOjiasJlc9vxZj6v08WvflCj6/5kbwoQovVopL6SLuP4GkKUA==
X-Received: by 2002:a17:907:2d12:b0:af9:3727:99e0 with SMTP id a640c23a62f3a-af9c64beedfmr1134789166b.38.1754899203760;
        Mon, 11 Aug 2025 01:00:03 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99518bfacsm1002480266b.72.2025.08.11.01.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:00:03 -0700 (PDT)
Message-ID: <74c4ff06-6665-4da2-a328-aad36300a892@gmail.com>
Date: Mon, 11 Aug 2025 10:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH v5] [matchbox-panel-2] panel: added sysfs
 support
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
References: <20250716031705.110773-1-dixitparmar19@gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250716031705.110773-1-dixitparmar19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 08:00:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1925

Though I'm not Ross, added some notes inline. I gotta admit that haven't
read the reviews for v1-v3, only for v4: if there is something that was
discussed beforehand, and I'm just repeating it, just ignore that part.

On 7/16/25 05:17, Dixit Parmar via lists.yoctoproject.org wrote:
> battery applet supports reading battery and supply
> information from sysfs entries, /sys/class/power_supply/.
>
> [YOCTO #12904]
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=12904
>
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
> V4: https://lists.yoctoproject.org/g/yocto-patches/message/789
> ---
>  applets/battery/Makefile.am     |   4 +
>  applets/battery/battery-acpi.c  |   2 +
>  applets/battery/battery-apm.c   |   2 +
>  applets/battery/battery-sysfs.c | 148 ++++++++++++++++++++++++++++++++
>  applets/battery/battery.c       |   2 +
>  applets/battery/battery.h       |   3 +-
>  configure.ac                    |   4 +
>  7 files changed, 163 insertions(+), 2 deletions(-)
>  create mode 100644 applets/battery/battery-sysfs.c
>
> diff --git a/applets/battery/Makefile.am b/applets/battery/Makefile.am
> index 9b02240..1b93a0b 100644
> --- a/applets/battery/Makefile.am
> +++ b/applets/battery/Makefile.am
> @@ -5,6 +5,10 @@ applet_LTLIBRARIES = libbattery.la
>  libbattery_la_SOURCES = battery.c battery.h
>  libbattery_la_CPPFLAGS = $(AM_CPPFLAGS) -DDATADIR=\"$(pkgdatadir)/battery/\"
>  
> +if HAVE_SYSFS
> +libbattery_la_SOURCES += battery-sysfs.c
> +endif
> +
>  if HAVE_LIBAPM
>  libbattery_la_LIBADD = -lapm
>  libbattery_la_SOURCES += battery-apm.c
> diff --git a/applets/battery/battery-acpi.c b/applets/battery/battery-acpi.c
> index d1d3de9..42ef9c8 100644
> --- a/applets/battery/battery-acpi.c
> +++ b/applets/battery/battery-acpi.c
> @@ -14,6 +14,8 @@ global_t global;
>  adapter_t *ac;
>  int batt_state, ac_state;
>  
> +void pm_cleanup(void) { }
> +
>  int pm_support(void)
>  {
>  	if(check_acpi_support() == NOT_SUPPORTED){
> diff --git a/applets/battery/battery-apm.c b/applets/battery/battery-apm.c
> index edaba43..f1501a0 100644
> --- a/applets/battery/battery-apm.c
> +++ b/applets/battery/battery-apm.c
> @@ -9,6 +9,8 @@
>  #include "battery.h"
>  #include <apm.h>
>  
> +void pm_cleanup(void) { }
> +
>  int pm_support(void)
>  {
>  	if (1 == apm_exists ()) {
> diff --git a/applets/battery/battery-sysfs.c b/applets/battery/battery-sysfs.c
> new file mode 100644
> index 0000000..acb01b3
> --- /dev/null
> +++ b/applets/battery/battery-sysfs.c
> @@ -0,0 +1,148 @@
> +/*
> + * (C) Dixit Parmar
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Licensed under the GPL v2 or greater.
> + */
> +
> +#include "battery.h"
> +#include <glib.h>
> +
> +#define PROCFS_PS_DIR "/sys/class/power_supply"
> +
> +static gchar *batt_dev;
> +static gchar *ac_dev;
> +static guchar batt_exist = 0;
> +static guchar ac_exist = 0;

I'm not very well versed in gtk, so if anyone tells me that it is
idiomatic, I will believe it, but: why are these guchar? The code
doesn't seem to do anything char-like with them, they are used as bools.
Why not guint, or gboolean?

> +
> +void pm_cleanup(void)
> +{
> +        g_free(batt_dev);
> +        g_free(ac_dev);
> +}
> +
> +int pm_support(void)
> +{
> +	GDir *dir = g_dir_open(PROCFS_PS_DIR, 0, NULL);
> +	if (dir != NULL) {
> +		const gchar *subdir_name;
> +		while ((subdir_name = g_dir_read_name(dir)) != NULL) {
> +			gchar *subdir_path = g_build_filename(PROCFS_PS_DIR, subdir_name, NULL);
> +			// Check if it's a directory
> +			if (g_file_test(subdir_path, G_FILE_TEST_IS_DIR)) {
> +				gchar *type_file_path = g_build_filename(subdir_path, "type", NULL);
> +				// Check if the "type" file exists
> +				if (g_file_test(type_file_path, G_FILE_TEST_EXISTS)) {
> +					gchar *file_content = NULL;
> +					gsize length;
> +
> +					if (g_file_get_contents(type_file_path, &file_content, &length, NULL)) {
> +						if(!batt_exist && strncmp(file_content, "Battery", strlen("Battery")) == 0) {
> +							batt_dev = g_malloc0(strlen(subdir_name) + 1);
> +                                                        strncpy(batt_dev, subdir_name, strlen(subdir_name));
> +							batt_exist = 1;
> +						}
> +						if(!ac_exist && strncmp(file_content, "Mains", strlen("Mains")) == 0) {
> +							ac_dev = g_malloc0(strlen(subdir_name) + 1);
> +							strncpy(ac_dev, subdir_name, strlen(subdir_name));
> +							ac_exist = 1;
> +						}
> +						g_free(file_content);
> +					}
> +				}
> +				g_free(type_file_path);
> +			}
> +			g_free(subdir_path);
> +			if(batt_exist && ac_exist)
> +				break;
> +		}
> +		g_dir_close(dir);
> +	}
> +	return (int)batt_exist;
> +}
> +
> +static gboolean read_val_from_file(const gchar *dev, const gchar *f, gint64 *val)
> +{
> +        gboolean ret = TRUE;

Should this be not FALSE by default? If the next "if" branch is false,
it stays TRUE, even though it fails to read anything.

> +	gchar *endptr;
> +
> +	if(dev != NULL && f != NULL && val != NULL) {
> +		gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
> +                gchar *file_content;
> +                gsize length;
> +
> +                if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
> +                       *val = g_ascii_strtoll(file_content, &endptr, 10);
> +                } else {
> +                    ret = FALSE;
> +                }
> +
> +                g_free(file_content);
> +		g_free(file_path);
> +		return ret;

This return above seems to be superfluous in view of the next statement.

> +	}
> +	return ret;
> +}
> +
> +const char* pm_battery_icon(void)
> +{
> +	const char *icon;
> +
> +        gint64 temp_val = 0;

Space and tabs are mixed here. There are some other instances of this in
this patch.

> +	gint64 ac_sts = 0;

Nitpick: batt_present and batt_percentage are nicely spelled out. Could
this be called also ac_status?

> +	gint64 batt_present = 0;
> +	gint64 batt_percentage = 0;
> +
> +	if(batt_exist == 0)
> +		return NULL;
> +
> +	/* Check battery presence */
> +	if(read_val_from_file(batt_dev, "present", &temp_val))
> +		batt_present = temp_val;

Nitpick: I wonder if checking for "present" is the best way to determine
if a battery is present. This file might not exist in all drivers, in
which case the battery is considered to be present (according to sysfs
docs). On the other hand, as a first version I consider it good enough,
it can be iterated, when/if needed.

> +
> +	if(batt_present == 0) {
> +		/* Battery is removed */
> +		icon = "ac-adapter.png";
> +		return icon;
> +	}
> +
> +	/* Check Adaptor status*/
> +	if(read_val_from_file(ac_dev, "online", &temp_val))
> +		ac_sts = temp_val;
> +

ac_exist isn't verified before trying to read. While I believe it
shouldn't lead to anything bad, but it is checked later when the icon is
displayed.

> +	/* Check battery percentage */
> +	if(read_val_from_file(batt_dev, "capacity", &temp_val))
> +		batt_percentage = temp_val;
> +
> +	if(ac_exist && ac_sts == 1) {
> +		/* We're charging */
> +		if (batt_percentage < 10)
> +			icon = "battery-charging-000.png";
> +		else if (batt_percentage < 30)
> +			icon = "battery-charging-020.png";
> +		else if (batt_percentage < 50)
> +			icon = "battery-charging-040.png";
> +		else if (batt_percentage < 70)
> +			icon = "battery-charging-060.png";
> +		else if (batt_percentage < 90)
> +			icon = "battery-charging-080.png";
> +		else
> +			icon = "battery-charging-100.png";
> +	} else {
> +		if (batt_percentage < 10)
> +			icon = "battery-discharging-000.png";
> +		else if (batt_percentage < 30)
> +			icon = "battery-discharging-020.png";
> +		else if (batt_percentage < 50)
> +			icon = "battery-discharging-040.png";
> +		else if (batt_percentage < 70)
> +			icon = "battery-discharging-060.png";
> +		else if (batt_percentage < 90)
> +			icon = "battery-discharging-080.png";
> +		else
> +			icon = "battery-discharging-100.png";
> +	}
> +
> +	return icon;
> +}
> diff --git a/applets/battery/battery.c b/applets/battery/battery.c
> index b11517d..755042b 100644
> --- a/applets/battery/battery.c
> +++ b/applets/battery/battery.c
> @@ -24,6 +24,8 @@ battery_applet_free (BatteryApplet *applet)
>          g_source_remove (applet->timeout_id);
>  
>          g_slice_free (BatteryApplet, applet);
> +
> +        pm_cleanup ();
>  }
>  
>  static gboolean
> diff --git a/applets/battery/battery.h b/applets/battery/battery.h
> index 534988f..7c54a3a 100644
> --- a/applets/battery/battery.h
> +++ b/applets/battery/battery.h
> @@ -9,8 +9,7 @@
>  #ifndef MB_APPLET_BATTERY_H
>  #define MB_APPLET_BATTERY_H
>  
> -#include <string.h>
> -
> +void pm_cleanup(void);
>  int pm_support(void);
>  const char* pm_battery_icon(void);
>  
> diff --git a/configure.ac b/configure.ac
> index be4d591..0f607f8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -61,6 +61,9 @@ AC_ARG_WITH(
>  )
>  
>  case "$with_battery" in
> +     "sysfs") enable_linux_sysfs=yes
> +     enable_battery=yes
> +     ;;
>       "acpi") AC_CHECK_HEADERS(libacpi.h, enable_linux_acpi=yes, AC_MSG_FAILURE([You need to install libacpi]))
>       enable_battery=yes
>       ;;
> @@ -75,6 +78,7 @@ esac
>  AM_CONDITIONAL(HAVE_BATTERY, test x$enable_battery = xyes)
>  AM_CONDITIONAL(HAVE_LIBAPM, test x$enable_linux_apm = xyes)
>  AM_CONDITIONAL(HAVE_LIBACPI, test x$enable_linux_acpi = xyes)
> +AM_CONDITIONAL(HAVE_SYSFS, test x$enable_linux_sysfs = xyes)
>  
>  # glib-genmarshal
>  GLIB_GENMARSHAL=`$PKG_CONFIG --variable=glib_genmarshal glib-2.0`  


