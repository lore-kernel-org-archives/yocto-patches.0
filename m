Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F2F36B98
	for <webhook@archiver.kernel.org>; Sat, 11 Apr 2026 07:13:46 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.182567.1775891618780990745
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Apr 2026 00:13:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H3EDFVMS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so38485765e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775891617; x=1776496417; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBjMxbV8q6fSRrC7YkhGXbpDD4mUV56Oj6TmzAe7KCg=;
        b=H3EDFVMS0RRPmVSYDFovEKxE2aKv811J+cyMtbgBw0Hf/7OSCFA2Cqrs+E2gp5GUOS
         VQKlpidAxIHcoP9xKYSQvgoyhzEXig7FMAuO1kuumjUEwjHjWdYekM7BS+QEXq3lXOM5
         LnKvI7BSynNODsSxcgHUZQ3gsd2xbqklugK20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775891617; x=1776496417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBjMxbV8q6fSRrC7YkhGXbpDD4mUV56Oj6TmzAe7KCg=;
        b=TL/nuZnBeC5wKb/+DLsFEv7hRGuk1CtJGoswvPgmKodYS7Wo/nvXEnYKgau4g9FjLU
         Ru83WkvJUmZSEfEmFZfvz+XT/cGtxEFfPPj4txVTa3tUCIFBSvq0lJ1AB/cw5WxVovmO
         lpWoAmzMR5tlRicYxy+R/iLQ858C6dAEv7bYy2e1QJr3MnC6ImzDA15qeSKfR8CIw5mQ
         QloXFu7HhTb0BOO+G8wOriXMSc0WENdXrWT7yR7BL0IcP4nChD3XSyPafSGveeGLhvfW
         Od8kA8lfDA339sr+Ezr3haEH7M+7mnbqSSV4xVrKrpmh+xDLjQayVem9SDe5fsBmQIOu
         Bppw==
X-Gm-Message-State: AOJu0YzQaZiWbZ9ykrDgGqDn70oE2BFx3Bbj6X7nYkCsOzcD98UgaRr8
	RHQlsYaAiLRqAjrA3lZGvjAELKQ8qFjD7wF5ud0OikhMHV2pW7zNT5G4JHrM5/R4DQwinBw3Gp6
	efaiWPb4=
X-Gm-Gg: AeBDievXeMrFlfjfrujqVaCbtdWd0hCR0/PQLbPF98PpAQBf6Rne+qWpVOfTxBP+T3B
	bLqZMQcuQ5bp16OBZrG5U/aUFw/Yqi2WBI8wjqqsz+0m7Tf7DJjm6TtHuSxdRjIPswqEpPpPyKa
	8WY4OVpemc+/93C/8uf5W0xieDP1UJDP05S8lTW/r5BgpWq5yyzPMKPdaAFr+QAYA+LNT/gkTCs
	f66tk/MSVIZT4IROCmeWajtkElU9YJDVjVzMyCKefC6tdA9ZG6peA1r5cnbB8hq55suGG+pVJEZ
	ugUU1FILM7EatJ60eLemNhIKr65SchkxQdGCtk0o7GMp5mlnPMLDve89inkVe2ESDpSuggb2MX3
	qjvl9elI+dg5hg4gSeDq5i2PGTuzpU52RBRBq4FzNaHHK5WVXsdRRF7G5Y+9NtWCVK+RLcqSXfY
	K/286TfSejLaco4hK79i4/c1AxnPza9CFCzc5tvCX5jVs1KhZs++H6
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id 5b1f17b1804b1-488d67df53cmr80013965e9.1.1775891616235;
        Sat, 11 Apr 2026 00:13:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:99d1:9089:a726:87e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538a296sm127185285e9.12.2026.04.11.00.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:13:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>
Subject: [yocto-autobuilder-helper] [PATCH] Port CVE scanning from cve-check to sbom-cve-check
Date: Sat, 11 Apr 2026 08:13:33 +0100
Message-ID: <20260411071333.518558-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 07:13:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3689

From: Ross Burton <ross.burton@arm.com>

Use the new sbom-cve-check-recipe class to scan meta-world-recipe-sbom,
instead of using cve-check.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json          |  7 ++-----
 scripts/run-cvecheck | 11 +++++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/config.json b/config.json
index 21705ff..c8df556 100644
--- a/config.json
+++ b/config.json
@@ -1386,12 +1386,9 @@
         "metrics" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "extravars" : [
-                "INHERIT += 'cve-check'",
+                "OE_FRAGMENTS += 'core/yocto/sbom-cve-check'",
+                "INHERIT += 'sbom-cve-check-recipe'",
                 "BB_DISKMON_DIRS = ''",
-                "CVE_CHECK_FORMAT_JSON = '1'",
-                "CVE_CHECK_SHOW_WARNINGS = '0'",
-                "CVE_DB_UPDATE_INTERVAL = '21600'",
-                "CVE_DB_INCR_UPDATE_AGE_THRES = '21600'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"
             ],
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index 878bdfa..43bf37f 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -74,18 +74,21 @@ fi
 set +u
 source ./init-build-env build
 set -u
-bitbake world --runall cve_check -R conf/distro/include/cve-extra-exclusions.inc
 
+bitbake meta-world-recipe-sbom -R conf/distro/include/cve-extra-exclusions.inc -c sbom_cve_check_recipe
 # Do another pull to make sure we're as up to date as possible.  This is
 # preferable to committing and rebasing before pushing as it would be better to
 # waste some time repeating work than commit potentially corrupted files from a
 # git merge gone wrong.
 git -C $METRICSDIR pull
 
-if [ -e tmp/log/cve/cve-summary.json ]; then
+# Use the latest report, in case the build tree has more than one
+CVE_REPORT=$(ls -t tmp/deploy/images/*/world-recipe-sbom.sbom-cve-check.yocto.json | head -n1)
+
+if [ -e $CVE_REPORT ]; then
     git -C $METRICSDIR rm --ignore-unmatch cve-check/$BRANCH/*.json
     mkdir -p $METRICSDIR/cve-check/$BRANCH/
-    cp tmp/log/cve/cve-summary.json $METRICSDIR/cve-check/$BRANCH/$TIMESTAMP.json
+    cp $CVE_REPORT $METRICSDIR/cve-check/$BRANCH/$TIMESTAMP.json
     git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.json
     git -C $METRICSDIR commit -asm "Autobuilder adding new CVE data for branch $BRANCH" || true
     if [ "$PUSH" = "1" ]; then
@@ -95,7 +98,7 @@ if [ -e tmp/log/cve/cve-summary.json ]; then
         fi
         git -C $METRICSDIR push
     fi
-    $OURDIR/cve-report.py tmp/log/cve/cve-summary.json > $RESULTSDIR/cve-status-$BRANCH.txt
+    $OURDIR/cve-report.py $CVE_REPORT > $RESULTSDIR/cve-status-$BRANCH.txt
 fi
 
 if [ "$BRANCH" = "master" ]; then

