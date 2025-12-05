Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF63D2F7D4
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 10:11:10 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2391.1764929462645026867
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 02:11:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=aaNLw4un;
 spf=pass (domain: mvista.com, ip: 209.85.216.49, mailfrom: vanusuri@mvista.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34381ec9197so1697640a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1764929462; x=1765534262; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/awC803CYu/WoLzJDdpvB9i0+atmW9Pzna0JM8uuEH0=;
        b=aaNLw4unnWmTkKIzxLzrRNL0eDRYDfoysU88gzi5bPM+iKgQwWKY7lgli8nEMaUgNB
         rTcrl3JpRQ0CAnYgPrfalDOz510FUSla6gh2WC5DeCbRjpaCGjjSJKCr3QOdw7uJbw8M
         3efjyI5VHvGqttrtYYq9rc9NNhRinBdxScEKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764929462; x=1765534262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/awC803CYu/WoLzJDdpvB9i0+atmW9Pzna0JM8uuEH0=;
        b=fAdcm7Kyz/XH3PmagZi0Ig3kNFOQ8c0ntv9p3WsfGYU/Ep9nOrjCD18ut/wIsl1JiI
         KIGT9P3H2eUA1UUBJl5fa3MAI4wo1mFzZUuUjSzz98qQLMI8sTi0xRA0+2enTAkoaYkX
         cfE0Wy4r+k1fcehxaRUFzfRNZataG7vE9HDPrDE1BoHxnfhG7tIg6G7yqS3m7F09iStc
         O3Yy5uU6fY5hg+a8ne+gq4Dcf0VrEh8DRB7k1oBfJKEIJbWgEKcnxeABgzcRPPZl5OS1
         xn4d+MZkRyR9JKhV7oyUiMku5QxmCP2HzAziyTEaK9yqFV8xBgRgSov8Ci9GjyLf62RO
         P/8w==
X-Gm-Message-State: AOJu0Yx+2Mr0OWeBtOw0dDU8nFnr8PulTH/XWmLJbSvUWgfAhzhu3Wgm
	WXdXEXZPLgFdU5K51PO5S5ygtVlNdIunb2bLQZtuQelZmJnaRPo2TrWEDJ1yWR4gjyf13MB302Q
	TYpZK
X-Gm-Gg: ASbGncs2lESdEVjySly0XkHxTowBCtwf7T3uZnonOx/gpYWHiaiAk+mSneRYDg2g3Qt
	TUPZpwQx1gWsJ23NCVpQaDnCAfWO8gMawXMAq3Nmbx25EGxsX4DpswbPIBu9g4NYAImqJXTDldE
	ocQR40T6IAd1sWKwnkjoWN80AuQPKBhMDUmAVmlEuUknMCOm7saKf/A/3dvw+BebjRDLr0KyeBx
	LwEUTTCjjiYMyjeiKKMbQwOm4qMft7RjUgAKmglA49d0ZpebRDpIlcOcGvXQRUpHUx1rntYNThW
	jPwThY8YtAZYZlaSKbeH9CquM+gVNqkNt352FPmlAgjq1sYxDS+AP4gOa2I/YbA/HWdmX9bomEB
	WBZlg8GFWlC9iC5DSBplE31iHqfAhxT8EZ09qKHulxELERpne7z2tvVC2EcNwuASq+KD7LpbI7z
	uhpkc20TJ4tuOPfe534gY0HsBa
X-Google-Smtp-Source: AGHT+IFRjp+YYhKC0hfChsfJj4K0m67+2lDDGWOQpzRnUMVhT1oOFuy3SsTg5ykOM5qAtvlssn0d0g==
X-Received: by 2002:a17:90b:44:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-349125d33b9mr8670701a91.9.1764929461622;
        Fri, 05 Dec 2025 02:11:01 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:54:7205:3804:9694:8b55:4cfc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f38a18csm4169699a91.1.2025.12.05.02.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 02:11:01 -0800 (PST)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][kirkstone][PATCH] sssd: Fix for CVE-2025-11561
Date: Fri,  5 Dec 2025 15:40:51 +0530
Message-Id: <20251205101051.171885-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 10:11:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2740

From: Vijay Anusuri <vanusuri@mvista.com>

Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da4d2]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
 recipes-security/sssd/sssd_2.5.2.bb           |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch

diff --git a/recipes-security/sssd/files/CVE-2025-11561.patch b/recipes-security/sssd/files/CVE-2025-11561.patch
new file mode 100644
index 0000000..0bfed6d
--- /dev/null
+++ b/recipes-security/sssd/files/CVE-2025-11561.patch
@@ -0,0 +1,50 @@
+From a0336f4cd69c25b3d501a3d361d3d286c00da4d2 Mon Sep 17 00:00:00 2001
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
+Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da4d2]
+CVE: CVE-2025-11561
+Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
+---
+ src/util/domain_info_utils.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
+index e131a5d96af..160e1711bcd 100644
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
diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index c07559c..43c31ee 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -25,6 +25,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/sssd-${PV}.tar.g
            file://musl_fixup.patch \
            file://CVE-2021-3621.patch \
            file://CVE-2023-3758.patch \
+           file://CVE-2025-11561.patch \
            "
 
 SRC_URI[sha256sum] = "5e21b3c7b4a2f1063d0fbdd3216d29886b6eaba153b44fb5961698367f399a0f"
-- 
2.25.1


