Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A373C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.1066.1751649112497438320
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LqCbfthx;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a7f61ea32aso21655471cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649111; x=1752253911; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itRlGvvNEJGATs6xK1+AGVVK3P+r40VAsoWppsxfPVw=;
        b=LqCbfthx+MI8WowmgnS9SlV/YtS6zhLIQCXVnWiHtvL+KL/SnbUNbCblRf6CbZ32pV
         lRnqjPAIFN4D2eL+uvyCdSFIy74waChuLcNYaQXuqXdjLs/+CHE6T82kJeu3MjAeUfT4
         4zxgl/rLPT45PFysAFo97Sfn/32XiiD4Gp4Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649111; x=1752253911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itRlGvvNEJGATs6xK1+AGVVK3P+r40VAsoWppsxfPVw=;
        b=WXzXfoy8w/+Nt2/k/FupAFWh/zcfGeH22PKvZV9UvH11WZYGeOhdnF/8c19Y5+hXs2
         QDqaIJUgW7UmPFoWnwCkjUL8/pJ8DnCumTh8fCUvy6q/Uwv/XcMtmL5UUDWkYMFpHAIJ
         UG/wkOSoGwUk6oBAZwBf7TWazz9moNCcLC7OVKI4Wu6ykomLjHM4feKeOm6crWuwRCv6
         glSj1M8YeuG0duRqy8wF5pzfMlbzOlWsug4q3PQ4NcUIU6L2oQiE/iSWNbAqeAJ7fex+
         60UnhzVQ/bp5e5dtf9Ggf7VR4h7lVE+92kLB63cgNpw9oQpIa9G6s3icg2sIZ6h+5DTy
         cH3g==
X-Gm-Message-State: AOJu0YybSo7z5BWb3lZM2NT9XOiV0WYGmSNGLSDde2gvSjheXGjWo/0M
	+jQOvtOuDLi/wX0jUTkDgESKsYLAWCaZcwm5W7LDauuJ2fCjX3kQGcJUyeXQnvXmVugD3SXoPDd
	hXXSx
X-Gm-Gg: ASbGncvfZPVWLAjNXycWKGx06YYsoTaEuWy41fODoxepI/LY91KkYrJYfIXcw8s2AdQ
	lsdgs4Wezjg4c4dWFMF+dfXwWnULRDqiyZgOgDnmytDgWPlfhKqlFqdlpj08dKH371gQbwohreX
	P0m86PVBc2u1XIESnFwjXFt8IRg3iX3zdHaLOYGDsNdZw0PsLF+2vK7570wlI4xDIO3BsNjtOsh
	S4cp4SazbVJ3IWGmNZiuQOV9QG4zOKgnPJLaOvutZuXxqrGMCA02krAJkBi4H57h4BtXKW18Yao
	L6dBaEafGS4pj4OS/3uWu0G7fn2e63aVqhVisIO8eMWgXlD1DDkLaO2V5339qLtOFlAJnHAkR22
	T4j8OMJTkwq46ShG4pFQPuaMmwMKaQfXsoXrumP+hwlUophPZ
X-Google-Smtp-Source: AGHT+IF/pbnGIWDJTGMD5Bfhj9ApBNW67NocAxyK/R0AGGoLihR2/Y2cstp4naaJNNuvAdWzq85dCw==
X-Received: by 2002:ac8:5e4e:0:b0:4a5:a63b:4796 with SMTP id d75a77b69052e-4a9968344e4mr54715831cf.48.1751649111070;
        Fri, 04 Jul 2025 10:11:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 03/12] layer.conf: Update to whinlatter (5.3) release
Date: Fri,  4 Jul 2025 13:11:07 -0400
Message-ID: <ea67ceefdca42da806f3312c6703eff769463b8b.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1755

Update LAYERSERIES_COMPAT in all layer.conf files with the exception
of meta-parsec to whinlatter.  For meta-parsec, whinlatter has been
added, and the EOL releases removed, as an initial update.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 84d40a1..7a86054 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "styhead walnascar"
+LAYERSERIES_COMPAT_security = "whinlatter"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index a7e32e5..367d3d7 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "styhead walnascar"
+LAYERSERIES_COMPAT_harden-layer = "whinlatter"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 33127c7..23d6848 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "styhead walnascar"
+LAYERSERIES_COMPAT_integrity = "whinlatter"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index 614c17e..29a8f11 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "walnascar styhead nanbield scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core clang-layer"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 5f96114..582fe1e 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "styhead walnascar"
+LAYERSERIES_COMPAT_tpm-layer = "whinlatter"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.50.0


