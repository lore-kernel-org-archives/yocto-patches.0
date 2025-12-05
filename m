Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82686D2F7D1
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 11:33:40 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3602.1764934418412213470
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 03:33:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=ZSGC7fTK;
 spf=pass (domain: mvista.com, ip: 209.85.214.179, mailfrom: vanusuri@mvista.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29ba9249e9dso27768955ad.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 03:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1764934417; x=1765539217; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP37Jn8AuPU3zxSdAoGWKCTs2rS3zXDBjtmHdx4EdMY=;
        b=ZSGC7fTKNO7ZbQ5/8f1SFoyZJ2UOgSp6WFfN6xeDdvBHknij98leM0HXDB9WYWaZnj
         F6ERXAWPZEtJSXfNYI7+Ao08I0NDLjzF+0rjOksiWK4sImQ1oUTpRiWpjwckrx+vk3Ku
         /ZqYD2/p9lWOW97Hu09mPzwU6ZpHWKh8aJPzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764934417; x=1765539217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KP37Jn8AuPU3zxSdAoGWKCTs2rS3zXDBjtmHdx4EdMY=;
        b=SW17v4RFILyuhrJToYW0l+HtUsMJE/Y9bWqGQDscmYT3DDYVId9PWvZGpai2FogUNm
         rp24GidM8RH5bBP46UsImLO1FZAIlVSrm86Ns9OnHcJ+pGPPD56Cp5ePcRYUWzsIDkzs
         347FTE4NHQUoUTgjg2Z8kgumTsppft8yocpvf2S8lgH/1V7jXPNz4mZWVmmrsbaPcXlu
         Vmg8GnZcIJ/4PBBaLtPtBGSfmjqMTndpaziPFc1QCyXTSaofI8eYWhD94XDyqPFY8yWQ
         mp41Kkrr+nl5mc3VhmSEr5YOL45287ZvR63KJ4/EYciBPllHdzm7iMr6p+Lhvu4jjNzb
         S1+w==
X-Gm-Message-State: AOJu0YxW/FYylMIEhSFY3+ocXGdFuUJDD960l9A5ynPf9LEsBdHkLL3w
	JPCnHFVtQM4imUkBNKOXPBWsj4+2GRpSW5YQEkKVjU7s84MdzZQqDsF55ZQtqrAcaZ7AxmK5EMz
	8/RuD
X-Gm-Gg: ASbGncsxFwRqYUSKjRxPCPzx1hpMyWr4xEpsuQTWtV/5/1bsBMqGAgLGs8k1v5hoA0O
	xZVtLAaaFFcQjwEQS4b/G8Q0zQPyhlscIzCQ2WDFy5//d7n9EnG5b6Frv0R8qeATbFcprZp3wqw
	2mMok+GlBawRh6ommeRcW2NvdsphpZxwv8Oqgkk6ZT48qeyGa2eDZ3Mk2mw+QH8XwD5qgMUT9KV
	rbkPL9qGuTLvBCqxZkyHH/L3bEpYH2Z0EkpQ+pKrNqSkPs47cRMOWa0D7n15MdfSLfECxL20ONK
	4//MFDCcwEGKVpFMljFCtJ7GfYObkvwCOMH3Wh4YUqZnAprZTGXSTxtlzkdr9+nLKPE6LvzI+JF
	7tM+2ull7w3aSZRKllFUJfu6w9Dn1BjbIR7rYs10SGHqzdRIZGkrlWpwG6PNW0Sq4gnAYbMVydS
	Yi34kU/vzdF2SKsEHCOPAB2Wg=
X-Google-Smtp-Source: AGHT+IF+opoVOvRc/vEZzzpSHa1l3IpE0ktfuJZA9LVRGA/JDxIlf4BRw0cerJUezOP4ApzgtUe7RQ==
X-Received: by 2002:a17:903:1209:b0:296:3f23:b909 with SMTP id d9443c01a7336-29d68401104mr124253905ad.39.1764934417362;
        Fri, 05 Dec 2025 03:33:37 -0800 (PST)
Received: from MVIN00352.mvista.com ([2406:7400:54:7205:8451:cf5d:1824:de5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf968sm47535555ad.34.2025.12.05.03.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:33:36 -0800 (PST)
From: Vijay Anusuri <vanusuri@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][scarthgap][patch 2/2] sssd: Fix for CVE-2025-11561
Date: Fri,  5 Dec 2025 17:03:16 +0530
Message-ID: <20251205113318.3647529-2-vanusuri@mvista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205113318.3647529-1-vanusuri@mvista.com>
References: <20251205113318.3647529-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 11:33:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2744

Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e5224f0cb684e61203d2cd8045266f7248696204]

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
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
2.43.0


