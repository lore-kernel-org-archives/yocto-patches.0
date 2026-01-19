Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1ED2ECEB
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44337.1768855219168676575
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IN+lQuLo;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c59bce68a1so297729485a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855218; x=1769460018; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YwWN0BLw9QbFvEB3WXy18vFRQ6dhMJlqNE50ZnN0dI=;
        b=IN+lQuLoiLFWKEUSxpuJXPDT9okHLSYl29BomdUSrIXbX5JuzXKbHCeff8lgv0k5uZ
         yBqeMILjjTbE6hIjvSsCSmu118wWQfP7i4MDh5ky9gSyqINP/TvUFLRtuIZjBp0g32wc
         x5aZHZQsjIX1rKjGI3Rl+TabWPsZUU/zPjnHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855218; x=1769460018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YwWN0BLw9QbFvEB3WXy18vFRQ6dhMJlqNE50ZnN0dI=;
        b=udMwdJ5VNLpfVm8yprmE7I76KvjGSt3Q4jp5wjLX6KmnG9AVEWzO9FnpDwZ9T7GlzT
         w6IR4gGe8CfNfgglHU7hYemuChr/PB59VnO+iqkwNRRUynepn/xYdaQSbq+jWvUeUw2a
         JsmV9BONHid+Mmmx7dzFhIAlYkEH91vp+vyV8lfxvqvkjH5S947E4gVtu/1v/CXGOjDm
         q22QJQUOuoH1sBeGC8+HP8FePczhMJUCPf85HyKjCubpFmfuVKF4rB103VriFkXr3bUR
         zWlu4qSIQvm5kf05+PvMj4wS/tOiPiBUf3J9E64LxeMbCtvFG+wumidnDcnqJq5Ovbpd
         7QUg==
X-Gm-Message-State: AOJu0YzMRN05KQQHy80SOHylB2TdBPpsXDt4e8l9mrUBPlPRCf3kSrvQ
	SkwZX+3iLxn1VoCnkyihPjGb/+aAfjZ/pdquOXfjgI8PjiJM/PnfruW61cr4bw5AEa1g4m+ImiA
	ijgfY
X-Gm-Gg: AY/fxX47bYIenhCUN92anvsHJTiYLMB3eW+AF04jMhhzwf69Gp+bHtRGmvJPPSm5V9I
	oid86+gNr3wHmo0qUDbksG1w+az5u94FGwIjryn3bVgVvhj1Ret/kgd5RD9HI83XUKY+zmGKKzb
	/suGxaZHiGdmUeHUsxz1Ndnz6nBLBCegDI5Qxr1NmVlOx/pfQxV3+4YgbD5ab7HhjTW4EZAdhVo
	kfTJvhGCNuCHS7csIDDlQK2mfjW4P4a/XLQJgmPX8leK7e/r7oIowhDRHudNM3FP8TAqt2nCCCI
	yjPQhd8OO4oXXNGpyEEGv/z8L85PzLkj4OcpIFKN+GRu+n5nkFvu630QX8MAkUWGRWmuUMmwNHw
	BF+eiLVpex+VJM6q/ZbiPyt67gKsj9V+hdjGi3OOv/WQZVH9mW0HBNWqJ3nFdEagwn6EnT5CkIF
	FcD41cpFVH0Qe0LdzMOxSSZYfyL7XbtiZEbjmZW0Y4cX5tYPOvIXJQOES9aIr5CAG2FVF2gjpyL
	jtArTSbZZM3igLNcr0hzdqkxGpdac/ittd+lwFkDPoayX+Y/FzR
X-Received: by 2002:a05:620a:2808:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8c6a67b79c5mr1762465585a.70.1768855217799;
        Mon, 19 Jan 2026 12:40:17 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 2/6] sssd: Fix for CVE-2025-11561
Date: Mon, 19 Jan 2026 15:39:57 -0500
Message-ID: <cbe6438806d061bd92a6473d3715b35a739a295d.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3026

From: Vijay Anusuri <vanusuri@mvista.com>

Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e5224f0cb684e61203d2cd8045266f7248696204]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
 .../recipes-security/sssd/sssd_2.9.5.bb       |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
new file mode 100644
index 0000000..8111ca0
--- /dev/null
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
@@ -0,0 +1,50 @@
+From e5224f0cb684e61203d2cd8045266f7248696204 Mon Sep 17 00:00:00 2001
+From: Sumit Bose <sbose@redhat.com>
+Date: Fri, 10 Oct 2025 12:57:40 +0200
+Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IPA
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+If a client is joined to AD or IPA SSSD's localauth plugin can handle
+the mapping of Kerberos principals to local accounts. In case it cannot
+map the Kerberos principals libkrb5 is currently configured to fall back
+to the default localauth plugins 'default', 'rule', 'names',
+'auth_to_local', 'k5login' and 'an2ln' (see man krb5.conf for details).
+All plugins except 'an2ln' require some explicit configuration by either
+the administrator or the local user. To avoid some unexpected mapping is
+done by the 'an2ln' plugin this patch disables it in the configuration
+snippets for SSSD's localauth plugin.
+
+Resolves: https://github.com/SSSD/sssd/issues/8021
+
+:relnote: After startup SSSD already creates a Kerberos configuration
+ snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plugin
+ if the AD or IPA providers are used. This enables SSSD's localauth plugin.
+ Starting with this release the an2ln plugin is disabled in the
+ configuration snippet as well. If this file or its content are included in
+ the Kerberos configuration it will fix CVE-2025-11561.
+
+Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
+Reviewed-by: Pavel Březina <pbrezina@redhat.com>
+(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)
+
+Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e5224f0cb684e61203d2cd8045266f7248696204]
+CVE: CVE-2025-11561
+Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
+---
+ src/util/domain_info_utils.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
+index edaf967e186..5c1f050184e 100644
+--- a/src/util/domain_info_utils.c
++++ b/src/util/domain_info_utils.c
+@@ -751,6 +751,7 @@ static errno_t sss_write_krb5_snippet_common(const char *file_name,
+ #define LOCALAUTH_PLUGIN_CONFIG \
+ "[plugins]\n" \
+ " localauth = {\n" \
++"  disable = an2ln\n" \
+ "  module = sssd:"APP_MODULES_PATH"/sssd_krb5_localauth_plugin.so\n" \
+ " }\n"
+ 
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
index cb27675..2954257 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
@@ -25,6 +25,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
+           file://CVE-2025-11561.patch \
            "
 SRC_URI[sha256sum] = "bf955cc26b6d215bbb9083eadb613f78d7b727fb023f39987aec37680ae40ae3"
 
-- 
2.51.0


