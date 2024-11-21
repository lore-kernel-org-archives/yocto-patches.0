Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31641D75BCB
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 07:01:21 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.5430.1732172477754231425
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Nov 2024 23:01:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=NW3fi0za;
 spf=pass (domain: mvista.com, ip: 209.85.214.169, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211fd6a0a9cso4224245ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 23:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1732172477; x=1732777277; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXt+GXZSVsq5Nn1K4cR03KUC+hJj+mj6bqCQ9D1IDgM=;
        b=NW3fi0zatKa8HCovt2FwERvjCwayGidPpzKtron8hu11UQ6PA4mihZhdT+N8IXOb6q
         kc4y6BTwMsKI0s5nx7Jss5sDOTzAkEzI5jB7T5YXCtiFEM5f/BHS976VrwmADdZB/X2s
         85RTvqL6w3uDt856ZyMqitEMlSeE3V9Teq4OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732172477; x=1732777277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXt+GXZSVsq5Nn1K4cR03KUC+hJj+mj6bqCQ9D1IDgM=;
        b=gKmJNeGmGpOyhDFxfBTp1jDMbYbQLFOCi4uJXhn71ParKlw289qsEXyf6ky4wXeiH+
         8/JPSdNpNXDxuwrzu1lrALhJozOrdroRx0GiD3WV52cc/1Ti6xJBbGkQqvqXn+isyLEC
         xMqsCLqCtmow+pqPtB1rag9Qnkr9YvQDwnba1TDx8SyzBPTrDl9B5b4uLYvSK33WXLgL
         lqBewuO/I9FA3X/UMn4DV6e4TItNyNoqZSWtth0HddfAGwmLcBuwi/hYssCAAVlsCM7n
         UPfb0IMgKEP8G5+oW8QhyaPUMBmXytFui8www3QtP5kywlOPkTrjmNHIzMoJP4sVEpp6
         YGNg==
X-Gm-Message-State: AOJu0YwbdG81xnkTZFhcYVzxFkL8ETlzx9QQfJvhxv8ip1wGhGhuKwMT
	og9O0aVhuqyBePzoPzBHoyI1Xy5Sg3pODayqVy/BxxjwICHRsWjx07IlbxZRlog/6A+6LMfYaR6
	e
X-Gm-Gg: ASbGnct7N68DqR/7EvAq+LxFxr2o2P4aP18T+2o2zk3VxscYa0MMN3Hp3tAYOrMW985
	3ugtJ1os1tc4Ir5Nbp9e8RqUNn6/863u1CdV+zgHY5Tc0DK6ZjW29JGmqSXj4D8o5O2E65tvYeI
	OtgJ6bvW9fpzafhLzaMifVeKT1wV8mYkuvL6qcnPjT6aUm43fg+8d3jFf3u+7BxW36t1i95YVNP
	DmlihP9Pp3BTlw7lDGl4g5Xa1Reyp5zVeo30JUopHvxBTq51eTZFlID4IO58iY=
X-Google-Smtp-Source: AGHT+IEwoLVRZcRduVT1DFBscY7x1gRDlg0+oLBZ5h66D2HnxnXjkntDnR/V2xkqVCTghnrMptj3jw==
X-Received: by 2002:a17:903:41c2:b0:20c:3d9e:5f2b with SMTP id d9443c01a7336-2126a492d30mr66495455ad.57.1732172476866;
        Wed, 20 Nov 2024 23:01:16 -0800 (PST)
Received: from MVIN00016.mvista.com ([43.249.234.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212882d3b8csm6544545ad.194.2024.11.20.23.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:01:16 -0800 (PST)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: fix CVE-2024-45795 & CVE-2024-45796
Date: Thu, 21 Nov 2024 12:31:07 +0530
Message-Id: <20241121070107.67563-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 07:01:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/829

* CVE-2024-45795 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/72456d359bf3064306b62024c809bb30b162f18c && https://github.com/OISF/suricata/commit/96d5c81aed01f2bc0cd3e2e60057d0deb38caa99
* CVE-2024-45796 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/9203656496c4081260817cce018a0d8fd57869b5

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
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
2.25.1


