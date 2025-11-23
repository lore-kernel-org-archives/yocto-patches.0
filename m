Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27148CFD316
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5039.1763941531885412661
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EZrHmhDg;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b29ff9d18cso370985185a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941531; x=1764546331; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5zuB1tqVtyEjN0u11rGQ5DAWrOa+zMpvt/tL6z9eGk=;
        b=EZrHmhDgexiMXrh713xN89pyyDrj2hZZfZWdHPkQOWGsSL5n9RM3BV8PygLIHXWbkv
         x9/xAU078z1mxi4K3z0RLOLJ+BFIdJ3I/Rl7rXaCasw6xwOb60ULc6kDlFdSUui7/Iw8
         zkL4vUq26lunAlcygkxBKWvdrAal56J2Pdny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941531; x=1764546331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5zuB1tqVtyEjN0u11rGQ5DAWrOa+zMpvt/tL6z9eGk=;
        b=jnlqOoNUbSdTjeT9N46p7dEk4B0p3UHdphXD+7u4oEkrjKPlYnCQv8ocwN8sqzE/vL
         nPVnK3ndauSh1iIhYkKJsB6ADLl2DiOXCHI6oy2nxCN2A8onUoU4Sy/Nrk8WrzAspBL/
         vzaGDk32WKkplDejbTr0Zs4haQ09BNHbGipxZ182dXPrR9kjxpvOJ0wYm6lLHin3TpLS
         NC/rDK1wk+E9ajw8yTjgoqNOTfo1HgvDqhYPs+1hO6P1zTwP9s8hJO5UIicxXmLwOoO6
         R0W0Na/fT+wIEwRvSkpdVFNmUW8D3c61+fIMSoPD5GuQaObzVUDtECOr7Xa3yMZcNibv
         aZWg==
X-Gm-Message-State: AOJu0Yy6t+TBsGPZTBWRcbFDOnrFWF7wltX3ZeRi0irow8mlolOfHs6m
	6ci2mU15X3VWGUHhqlWwbZZ4ptgGEHtX453E2sKWLZ5CBnHkA5neYBcIytiWaIcE2UERiNQ15A2
	TzfTP
X-Gm-Gg: ASbGnctb5U3bSelVdPmxtYTaUNwtUmlEmgrykM0BJ6eSzuSZIRwmPUZ99wUoZJKk6AI
	gxi+mpcl6XFKXh7j6oZjr+bDCO3SypXRHwVDZWYVXl5s+gNqBTtaXF5Z0nI4n6U4C0L/LH/anLn
	uEeanGCKgXtlxWCq2/1M7h+MY901W5nCofgzZ7ft1JxqqIDKh7zYVVYX2qOr9uTPYyzYP/LfZ4v
	zgNxYJS+pS+g8LLSf7lcuQIFwp5K2qFKdrakQkbuuBo55I2/xTV2T/Gw9zzuvFQYjXYist97pGD
	jYLvK3KXg4jjnYvTHdh9XIkEYmUvSXhQ48vJ+BipUel11XP3fFOKPytcxRMV0X+ZwdhimM7zz/I
	/Hb9dtnZcy8KmYgp5kO8+gBHQ47SZ5L2WaY1xyaToZAQZA7MeQTEycJHliazCWYpo4IrR/igCP9
	4XCT1br2alWMmEN1Zyh/fzHFZauzS1UOeLmP6XE0cxycIfdSX9sgTWSZIT09a6dqo=
X-Google-Smtp-Source: AGHT+IHYuIAgT8dKghC/robag+heGN3CVaczThyKdaStpzTb8RbIkHLM5Cunf0fijSqEzgto5lpUQA==
X-Received: by 2002:a05:620a:400c:b0:883:9b33:f6b6 with SMTP id af79cd13be357-8b33d48b7e1mr1285354685a.84.1763941530560;
        Sun, 23 Nov 2025 15:45:30 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:30 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 14/32] suricata: fix CVE-2024-45795 & CVE-2024-45796
Date: Sun, 23 Nov 2025 18:44:54 -0500
Message-ID: <4f19c6b49a69ce915c41925879c9e5dd133e380e.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2672

From: Hitendra Prajapati <hprajapati@mvista.com>

* CVE-2024-45795 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/72456d359bf3064306b62024c809bb30b162f18c && https://github.com/OISF/suricata/commit/96d5c81aed01f2bc0cd3e2e60057d0deb38caa99
* CVE-2024-45796 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/9203656496c4081260817cce018a0d8fd57869b5

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../suricata/files/CVE-2024-45795.patch       | 123 ++++++++++++++++++
 .../suricata/files/CVE-2024-45796.patch       |  33 +++++
 recipes-ids/suricata/suricata_7.0.0.bb        |   2 +
 3 files changed, 158 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2024-45795.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-45796.patch

diff --git a/recipes-ids/suricata/files/CVE-2024-45795.patch b/recipes-ids/suricata/files/CVE-2024-45795.patch
new file mode 100644
index 0000000..10363c5
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-45795.patch
@@ -0,0 +1,123 @@
+From 72456d359bf3064306b62024c809bb30b162f18c Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Mon, 12 Aug 2024 09:54:43 +0200
+Subject: [PATCH] detect/datasets: implement unset command
+
+Ticket: 7195
+
+Otherwise, Suricata aborted on such a rule
+
+(cherry picked from commit e47598110a557bb9f87ea498d85ba91a45bb0cb6)
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/72456d359bf3064306b62024c809bb30b162f18c && https://github.com/OISF/suricata/commit/96d5c81aed01f2bc0cd3e2e60057d0deb38caa99]
+CVE: CVE-2024-45795
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ doc/userguide/rules/datasets.rst |  2 +-
+ src/datasets.c                   | 20 ++++++++++++++++++++
+ src/datasets.h                   |  1 +
+ src/detect-dataset.c             | 11 +++++++++++
+ src/detect-dataset.h             |  5 -----
+ 5 files changed, 33 insertions(+), 6 deletions(-)
+
+diff --git a/doc/userguide/rules/datasets.rst b/doc/userguide/rules/datasets.rst
+index 647b12e..dd9ecd2 100644
+--- a/doc/userguide/rules/datasets.rst
++++ b/doc/userguide/rules/datasets.rst
+@@ -78,7 +78,7 @@ Syntax::
+ 
+     dataset:<cmd>,<name>,<options>;
+ 
+-    dataset:<set|isset|isnotset>,<name> \
++    dataset:<set|unset|isset|isnotset>,<name> \
+         [, type <string|md5|sha256|ipv4|ip>, save <file name>, load <file name>, state <file name>, memcap <size>, hashsize <size>];
+ 
+ type <type>
+diff --git a/src/datasets.c b/src/datasets.c
+index d89ed8d..32bcf6e 100644
+--- a/src/datasets.c
++++ b/src/datasets.c
+@@ -1741,3 +1741,23 @@ int DatasetRemoveSerialized(Dataset *set, const char *string)
+     return DatasetOpSerialized(set, string, DatasetRemoveString, DatasetRemoveMd5,
+             DatasetRemoveSha256, DatasetRemoveIPv4, DatasetRemoveIPv6);
+ }
++
++int DatasetRemove(Dataset *set, const uint8_t *data, const uint32_t data_len)
++{
++    if (set == NULL)
++        return -1;
++
++    switch (set->type) {
++        case DATASET_TYPE_STRING:
++            return DatasetRemoveString(set, data, data_len);
++        case DATASET_TYPE_MD5:
++            return DatasetRemoveMd5(set, data, data_len);
++        case DATASET_TYPE_SHA256:
++            return DatasetRemoveSha256(set, data, data_len);
++        case DATASET_TYPE_IPV4:
++            return DatasetRemoveIPv4(set, data, data_len);
++        case DATASET_TYPE_IPV6:
++            return DatasetRemoveIPv6(set, data, data_len);
++    }
++    return -1;
++}
+diff --git a/src/datasets.h b/src/datasets.h
+index af4fc17..0f28a9f 100644
+--- a/src/datasets.h
++++ b/src/datasets.h
+@@ -56,6 +56,7 @@ Dataset *DatasetFind(const char *name, enum DatasetTypes type);
+ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save, const char *load,
+         uint64_t memcap, uint32_t hashsize);
+ int DatasetAdd(Dataset *set, const uint8_t *data, const uint32_t data_len);
++int DatasetRemove(Dataset *set, const uint8_t *data, const uint32_t data_len);
+ int DatasetLookup(Dataset *set, const uint8_t *data, const uint32_t data_len);
+ DataRepResultType DatasetLookupwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
+         const DataRepType *rep);
+diff --git a/src/detect-dataset.c b/src/detect-dataset.c
+index 3d29646..aad5cf0 100644
+--- a/src/detect-dataset.c
++++ b/src/detect-dataset.c
+@@ -41,6 +41,11 @@
+ #include "util-path.h"
+ #include "util-conf.h"
+ 
++#define DETECT_DATASET_CMD_SET      0
++#define DETECT_DATASET_CMD_UNSET    1
++#define DETECT_DATASET_CMD_ISNOTSET 2
++#define DETECT_DATASET_CMD_ISSET    3
++
+ int DetectDatasetMatch (ThreadVars *, DetectEngineThreadCtx *, Packet *,
+         const Signature *, const SigMatchCtx *);
+ static int DetectDatasetSetup (DetectEngineCtx *, Signature *, const char *);
+@@ -91,6 +96,12 @@ int DetectDatasetBufferMatch(DetectEngineThreadCtx *det_ctx,
+                 return 1;
+             break;
+         }
++        case DETECT_DATASET_CMD_UNSET: {
++            int r = DatasetRemove(sd->set, data, data_len);
++            if (r == 1)
++                return 1;
++            break;
++        }
+         default:
+             abort();
+     }
+diff --git a/src/detect-dataset.h b/src/detect-dataset.h
+index ca83267..d243552 100644
+--- a/src/detect-dataset.h
++++ b/src/detect-dataset.h
+@@ -26,11 +26,6 @@
+ 
+ #include "datasets.h"
+ 
+-#define DETECT_DATASET_CMD_SET      0
+-#define DETECT_DATASET_CMD_UNSET    1
+-#define DETECT_DATASET_CMD_ISNOTSET 2
+-#define DETECT_DATASET_CMD_ISSET    3
+-
+ typedef struct DetectDatasetData_ {
+     Dataset *set;
+     uint8_t cmd;
+-- 
+2.25.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-45796.patch b/recipes-ids/suricata/files/CVE-2024-45796.patch
new file mode 100644
index 0000000..ae00a5f
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-45796.patch
@@ -0,0 +1,33 @@
+From 9203656496c4081260817cce018a0d8fd57869b5 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Mon, 15 Jul 2024 09:52:00 +0200
+Subject: [PATCH] defrag: fix off by one
+
+Ticket: 7067
+
+This off by one could lead to an empty fragment being inserted
+in the rb tree, which led to integer underflow.
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/9203656496c4081260817cce018a0d8fd57869b5]
+CVE: CVE-2024-45796
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/defrag.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/defrag.c b/src/defrag.c
+index 71cf420..38704c9 100644
+--- a/src/defrag.c
++++ b/src/defrag.c
+@@ -808,7 +808,7 @@ DefragInsertFrag(ThreadVars *tv, DecodeThreadVars *dtv, DefragTracker *tracker,
+         }
+     }
+ 
+-    if (ltrim > data_len) {
++    if (ltrim >= data_len) {
+         /* Full packet has been trimmed due to the overlap policy. Overlap
+          * already set. */
+         goto done;
+-- 
+2.25.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index a01b3d9..e5d6ed1 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -16,6 +16,8 @@ SRC_URI += " \
     file://suricata.service \
     file://run-ptest \
     file://fixup.patch \
+    file://CVE-2024-45795.patch \
+    file://CVE-2024-45796.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.47.3


