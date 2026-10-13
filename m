Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625ACCC6B08
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:39:23 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7347.1791898755050385527
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Oct 2026 06:39:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=K4WcBxgJ;
 spf=pass (domain: mvista.com, ip: 209.85.210.179, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1184745b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Oct 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1791898754; x=1792503554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPvGcPaZPXKQWtaRSWnVJPa6hr5ni9NaWkqRBnaQy+4=;
        b=K4WcBxgJXGr2glNFpHEEhbzboHtJPSeT0HyEBoTh9MIMPKhHhWiTNVX8vjcsUH9M+M
         RsCepMGulWP8lS3b6eHX+drhje5JIUWZE0hc/M2cs3i4sG1Q1GeIH4olh+PyIj0f5CsS
         OayVzU8xWBC7N78ORwNVrjCoD5AXl3aPzqXtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898754; x=1792503554;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sPvGcPaZPXKQWtaRSWnVJPa6hr5ni9NaWkqRBnaQy+4=;
        b=zsPAuvnQ2vz4wT5AWEs0WYGIBUUnW04wjqS+C4GstNLRdzyUYXQqhJqm5Oa8BXohK+
         4i/gdrlOtw2TeYXOBsqlyYfuYE6OH8z2rQdMGsIf6l5CttO/N9ZP2Kp0K/hZVZtja4Ns
         iFdMH5GbQfDICtY8rIS7mS3WTqx7kwCNfaogQHn192Sovbh+nViXVEXofU/CIFZ/Spcv
         yW0d1vCQjMCB1wK2oZdXANc8Jk9hQ389eoAHwZ/oK4Qk2kdX3xFKoPW1+QdfwPg46rnZ
         +xWIuPemvQxcx7CJrha62BWPlgn9eqK87J6bX1uIdzzj+LX1u8E+tJYCr6XPTKSM0Mfo
         ERrQ==
X-Gm-Message-State: AFq9FYJ17N8QtnGwjAv5t9HsnT0QwUuLIk2heYLwN9cUK7+Ya8CtewOU
	jbGPxm3glVSmPzKDDGAcIvUfksv2bcFbbm82ieZvFgAVDMkt1Yv/jTV01x4HAa0AMU8CswKNPlo
	o+T4Tmg0=
X-Gm-Gg: AYBFou0cr+lm4dz62w3UwTh3S1HF8eTXRAwg71sRASFcd21rGgluMGLvtQlVucH3ZIE
	wMhc7rltpDSbHJxAOZw32hSL46VFLMCNiisEcyXcwi+TmY+V3gh+sHHH1dMd/xNAcBwGIrq1fU8
	EFAnEtiGTCymNt5S7SN2Arr8SRqaeX3mL8X3D0Mw6BYBcUiunRLDeWh1l9RaliQPwW/4m8JZnv7
	FDPfYYh3OrB223WG0UEgIvuwIdSDloduuB72tt0fZzCPgX2wvHPmDIWzXTULnF6zgYrrxqAhgkx
	MtHyJ5sOMiit5sWi+9O3i7IwASP80yJlqjKBrD9zsM8ZeufEVMnIPLhriLvNOISXihT0Aqk8nny
	kk4wNq5UNYVE6K52mAGXN6aHNPQa5VR6UXX/ebez/IK3riyJQuuAB8LQ9P2KLTfyPgY/7GUsSTf
	PVVYVO6kSaBIJRNU+jKvGXiix5uMTidcjuws73p5tDswjWGrcM5TLipFLRVqXJCzgn9FrItbIWb
	cARx9OnTg==
X-Received: by 2002:a05:6a00:987:b0:874:706d:8574 with SMTP id d2e1a72fcca58-897c6a30ee9mr9989023b3a.28.1791898754214;
        Tue, 13 Oct 2026 06:39:14 -0700 (PDT)
Received: from MVIN00352.mvista.com ([106.200.31.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4869421b3a.40.2026.10.13.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:39:13 -0700 (PDT)
From: Vijay Anusuri <vanusuri@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-security][scarthgap][patch] sssd: Upgrade 2.9.7 -> 2.9.9
Date: Tue, 13 Oct 2026 19:09:00 +0530
Message-ID: <20261013133901.892663-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Oct 2026 13:39:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5004

Dropped CVE-2025-11561 patch which is fixed in sssd-2.9.8

Release Notes:
https://sssd.io/release-notes/sssd-2.9.8.html
https://sssd.io/release-notes/sssd-2.9.9.html

Handles CVE-2026-6245

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../sssd/files/CVE-2025-11561.patch           | 50 -------------------
 .../sssd/{sssd_2.9.7.bb => sssd_2.9.9.bb}     |  3 +-
 2 files changed, 1 insertion(+), 52 deletions(-)
 delete mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.7.bb => sssd_2.9.9.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
deleted file mode 100644
index 110444a..0000000
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
+++ /dev/null
@@ -1,50 +0,0 @@
-From 9fdc7f2b4ed50a5ce788a86f2a5be448668381f5 Mon Sep 17 00:00:00 2001
-From: Sumit Bose <sbose@redhat.com>
-Date: Fri, 10 Oct 2025 12:57:40 +0200
-Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IPA
-MIME-Version: 1.0
-Content-Type: text/plain; charset=UTF-8
-Content-Transfer-Encoding: 8bit
-
-If a client is joined to AD or IPA SSSD's localauth plugin can handle
-the mapping of Kerberos principals to local accounts. In case it cannot
-map the Kerberos principals libkrb5 is currently configured to fall back
-to the default localauth plugins 'default', 'rule', 'names',
-'auth_to_local', 'k5login' and 'an2ln' (see man krb5.conf for details).
-All plugins except 'an2ln' require some explicit configuration by either
-the administrator or the local user. To avoid some unexpected mapping is
-done by the 'an2ln' plugin this patch disables it in the configuration
-snippets for SSSD's localauth plugin.
-
-Resolves: https://github.com/SSSD/sssd/issues/8021
-
-:relnote: After startup SSSD already creates a Kerberos configuration
- snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plugin
- if the AD or IPA providers are used. This enables SSSD's localauth plugin.
- Starting with this release the an2ln plugin is disabled in the
- configuration snippet as well. If this file or its content are included in
- the Kerberos configuration it will fix CVE-2025-11561.
-
-Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
-Reviewed-by: Pavel Březina <pbrezina@redhat.com>
-(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)
-
-Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e5224f0cb684e61203d2cd8045266f7248696204]
-CVE: CVE-2025-11561
-Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
----
- src/util/domain_info_utils.c | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
-index edaf967..5c1f050 100644
---- a/src/util/domain_info_utils.c
-+++ b/src/util/domain_info_utils.c
-@@ -751,6 +751,7 @@ done:
- #define LOCALAUTH_PLUGIN_CONFIG \
- "[plugins]\n" \
- " localauth = {\n" \
-+"  disable = an2ln\n" \
- "  module = sssd:"APP_MODULES_PATH"/sssd_krb5_localauth_plugin.so\n" \
- " }\n"
- 
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.9.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.9.bb
index 52dce32..8fcccab 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.9.bb
@@ -25,10 +25,9 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
-           file://CVE-2025-11561.patch \
            file://CVE-2026-68743.patch \
            "
-SRC_URI[sha256sum] = "6b5284a4d72b67c0897699794360d79e0f67461957e20273c2649f025e76c248"
+SRC_URI[sha256sum] = "7f7ddd96bac991622e901a3102d0bdbae9b22da611dde334885377c28ae78e55"
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-- 
2.43.0


