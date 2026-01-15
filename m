Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B0D46638
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:47:08 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.711.1768517219140641290
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=odth+q/Y;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6a7638f42so31265885a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517218; x=1769122018; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02X8hHfA861eBXS5qRBjxR2C+6LN8TNnDmopccDa9Do=;
        b=odth+q/YuMeYkhy4EIXHyuk5u64XQZ7QTvU5XS6UsGeH1jC1zSZac9PSpoOdxh5AvC
         /SoyBM7tpYlDcmelklNlKFt7NjYkQUp/xo7PPrH+3DrioyP3jc96cg/yUh+OYLyvmae1
         H5t3M24XCq30LkqH9/90PVk/rm+SaDQxhnask=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517218; x=1769122018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02X8hHfA861eBXS5qRBjxR2C+6LN8TNnDmopccDa9Do=;
        b=UoAPhnIJA8c66RM/Xiqt+Vk4Mfghfpk7KdDGHATF05bIWV646VaojaT+O5hTfukZsl
         ExsZ1l88kY9wDcJ11X7ZUdBg7KZfsolhCJv4lffj/uKZVfWFRzJ1Yq0Z7uFN0hVzdu6S
         Z+9ho1D+FH1bZkxTLedkc892wW110gMDyq3eJB2caYYPh9Il5TuwUIu5lvi96TR+Di2Z
         xmc2H1wU3DnvrWWW7Rzi1Y1WvsDAfslZvbCRtyScusMaoogGflMDlvOmLHhCBgMVC8HK
         +hAEApcEMumW+hW/NQRFUI72GsA3D7ntaNd3ZZ2ecAFkLLIyEqBkXe+Vxc1YfqxPUCX9
         HWBA==
X-Gm-Message-State: AOJu0YyJn9Zj8hz2YhJpx6h2scsiB7SGUG3bumVencOd1DG0Cq87AFnh
	Y7EGrbrBaqNY2VlMMs0rcLqlrfane//IpKqzoD5OgW/NZ7Au9jsYPnrMAmyQySqoDTbZWvshQRf
	aTS6F
X-Gm-Gg: AY/fxX7BIqge+IueT5iC96E9jYr5TAJqVwhnvddDIvKQSWTTbIGEkNKsuhUx6ZuF7T9
	OnfsxM39AYYedHTLzfXwz8F++aoASCaNalq0j1qY6s0JNAd1v3rzNv78e4Wr+vg3vFbcu4GqGxn
	mI0VHTjzvlqpy1ttSubDClExpV7JrcFtI4uYYF1WY7qiyyzV/qJ01noefl827H4w9dg+o4XQb23
	ViVnSDGhh/cojRWwiwJWbq1Vy4NuWL8LLRig49ojEMAsQWokkI5xvHoPIItPxVyoNVf7GDUNs3K
	KLfPFY933RGjK9n8nMs9wjXYgC4uZJ07aYoD6VvPL5r8JRBx0Zk+8qF0kcccCVTR6kJGYtHeAjk
	rsUxLLa9ZlDZyqP8bAlk7IoKKaXC1eM4qA1f5DVOlEIVQVoor3083TH407WC4exLP/SIWE0yvAM
	eas6Z+UhjihkfRx/gfA8gPicKMss0DyuZI4tXUNJtvdVE/vzlFaEp+ckCXwO3QfiojUtboRUGi7
	CN4uXlxaSTXTsUi0MByPSt7ZWL2VvJrsAPqf3XHR508fmOWVQJR
X-Received: by 2002:a05:620a:1723:b0:8b2:dfda:66c4 with SMTP id af79cd13be357-8c6a68d2f67mr162361085a.8.1768517217870;
        Thu, 15 Jan 2026 14:46:57 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:57 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 8/9] sssd: Fix for CVE-2025-11561
Date: Thu, 15 Jan 2026 17:46:29 -0500
Message-ID: <1421bf8d3b64f88abde6bf4349e4a71a0fda5d75.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2973

From: Vijay Anusuri <vanusuri@mvista.com>

Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da4d2]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
2.51.0


