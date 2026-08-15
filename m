Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5E2C5CFC1
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 09:55:39 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6025.1786787734349126285
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 15 Aug 2026 02:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LQ44Qwg2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17610665e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 15 Aug 2026 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786787732; x=1787392532; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0e5fxvE6HbKNdfnxhSDsZPPausPhbknzscEAdBMQda4=;
        b=LQ44Qwg2gCGO5MBYtWmtThF8nK/zdvnLSMXeoS0Y6GYF+V7mrxJyBx5WfTxVfvJbT+
         TQmgVTuTY3la44xa5CRo0IMekspi+ZTnwOltXWQ7jcTfHmgwAvo/vqck39x6hechn6nn
         sES4MNwCs06fGepRI4qjJX9Xr114OGQoVXa8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786787732; x=1787392532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0e5fxvE6HbKNdfnxhSDsZPPausPhbknzscEAdBMQda4=;
        b=f38I0ambC7nfmUcwNRbxFUhYTCAOshXBTEcMCoBJvY/KgQenLnRH9VNFv2DDrMxDG5
         ljNWJHYG/UuNVwb4/5BFVTv9fINI6iNjnDYWENrWFUal25jCoHU2cJNDDQf86/dFDfNm
         YwJvoc+xzLw9hSO8H5T9wLnLt8Qk9M8dbIJCDO1mbSKxDDtpy1bggObPQIBUY5SJ7UiO
         z1jJGOEdb4V4DG94Y/vsollrCeW0KNSeVi5IUwJ4xz8FvyTutQzQZlSa1wQwhFUuf4Tz
         njfYBQjx2DvZgbYK86MXiIH/OpkAwTahWu/sGUDlUwhZCt7xcFchK2krxl2dQ5Kaxvt9
         zKJg==
X-Gm-Message-State: AOJu0Yy/2Tkh8wsfLzdoxRaDBOhPlMdcjD3dqih1e5zZSHNP4Ya6ioxD
	+MZOBOdXEwyIwOoEbKAuNqk2usaYucE+Kl0Ad8PVLidDviRe+EYYN2Blxw7A/wFlaphWwKR+lm0
	vWD2vzuE=
X-Gm-Gg: AR+sD13V+DUyneyESTuXQEwAZ0WCO3ldN8044UmmhfnlfKy67sXAZDowBP2kuQl912L
	lOaQX/3+OK1PnQtoiWgQPQ7X3hBf+wKnju3HTvk7lNP/FvY/73KaISHTZk/hulZX+b5kLclx+dk
	nFINs8WEXjAjP1kLdPIHmVt/8miR8nixRC2mlLBiXgZMYpYkv+M1Qg+QduNJfMdJPxrACRM9703
	11BBZRpSfmhOSp8twodTOdtrcnhqDL9z82BrGv84mmGtKcp+qN/Ac3dqDwgrdd+EDFKlg3i261Z
	IcTUHkQgod5h53lgSpUHLXQy62FDf35WdT+rF6J6UtlZSpwtn4Ve/oINNEb5eaaeTgqvXJTebxm
	Ij74kVgnBIM0bQ0gVPoxP21J2GlduYajpAgut/O00f0qCgGEK6KNIvLKZYBgDBpfJqgiQUo9GrO
	AZpcEmT9A4R5oFc6XQmU5KM3udxuaPD8VMUP7RePcG8tewhL8lytcANuBxgQNW8FIH80gYN/Qef
	ZzqDl0woLmslfwQ
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id 5b1f17b1804b1-49987979c41mr186651475e9.12.1786787732357;
        Sat, 15 Aug 2026 02:55:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:76a9:d146:8f01:f2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899bff2csm95596435e9.7.2026.08.15.02.55.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:55:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Use own-mirrors for auh/buildperf
Date: Sat, 15 Aug 2026 10:55:30 +0100
Message-ID: <20260815095530.3524320-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 15 Aug 2026 09:55:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4667

Now that we disable the yocto mirrors from all builds, we need to tweak the ones
that populate their own DL_DIR to use the sources directory as a mirror and reduce
network traffic.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.json b/config.json
index 9fd9ba3..b887900 100644
--- a/config.json
+++ b/config.json
@@ -243,6 +243,8 @@
                 "BB_NUMBER_PARSE_THREADS = '24'",
                 "PARALLEL_MAKE = '-j 24'",
                 "DL_DIR = '${BUILDPERF_STATEDIR}/downloads'",
+                "INHERIT += 'own-mirrors'",
+                "SOURCE_MIRROR_URL = 'file://${BASE_SHAREDDIR}/current_sources'",
                 "CONNECTIVITY_CHECK_URIS = ''",
                 "BB_HASHSERVE = 'auto'",
                 "BB_LOG_HOST_STAT_CMDS = ''",
@@ -1560,6 +1562,8 @@
             "NEEDREPOS" : ["bitbake", "auto-upgrade-helper"],
             "extravars" :[
                 "DL_DIR = '${TOPDIR}/downloads'",
+                "INHERIT += 'own-mirrors'",
+                "SOURCE_MIRROR_URL = 'file://${BASE_SHAREDDIR}/current_sources'",
                 "INHERIT += 'buildhistory'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "INIT_MANAGER:libc-glibc = 'systemd'",
@@ -1590,6 +1594,8 @@
             "NEEDREPOS": ["bitbake", "auto-upgrade-helper", "meta-openembedded"],
             "extravars": [
                 "DL_DIR = '${TOPDIR}/downloads'",
+                "INHERIT += 'own-mirrors'",
+                "SOURCE_MIRROR_URL = 'file://${BASE_SHAREDDIR}/current_sources'",
                 "INHERIT += 'buildhistory'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "DISTRO_FEATURES:append:libc-glibc = ' systemd usrmerge'",

