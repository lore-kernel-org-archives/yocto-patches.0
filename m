Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0ACD75BC4
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 06:45:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.5245.1732171494001138873
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Nov 2024 22:44:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=D3R467Ya;
 spf=pass (domain: mvista.com, ip: 209.85.214.175, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-212884028a3so2327435ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1732171493; x=1732776293; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4pjBUvBqg4ajYt5pyVIwhT05H9e+wRrT/boTSzBb9Y=;
        b=D3R467YavVTQi8BF3oJg1IT5t2+LdpyYLzmiwBtxD0AGX5FjvJhbtc0+mNws8H3lOK
         XjGbcOMAaD/m8IYbho2Jgudiks2VGz4Yw0Ov1ARa1Ba0hnaKQzKAGQ1SgOkLyDT6HYLD
         311ma2C8yUM7BVNw59iKH4KUhljXeu/KuGp74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732171493; x=1732776293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4pjBUvBqg4ajYt5pyVIwhT05H9e+wRrT/boTSzBb9Y=;
        b=hHbCzxSi3SataBRlJm8brMf2c6zzSfPv9C9cpf0LHqI5Pladvvx79WLd3J0n0tqxd8
         Fdo5AFZnnnHqnyrTdFNIIAxkbPbZFN82srQ04KY69xgcTbCqOTuHG4YoSRiSh677G119
         p2vtXQN3DgSGltZOr14+27VMMtBSuxEUvCTP1ALNK+x70owQEjp5DRkz+v7EZBZzrjBj
         piGB5GwGuTtFs33rS5mTHSI996IizRw5Xn5F3cYCzrZA5nC5Ld7EQmSEzlDdefqGlGqS
         SGK/3F7cSO7+ne+3lxM5/kkuqpIuc8EwaQU4I9d8q/KfCZPkTDgBMYShPhlEF/tF5+KB
         0seA==
X-Gm-Message-State: AOJu0Yz0Sha+FeWqMJYKMe+78S3qV0LDwHyR5+IsWz3MTz9xbb5x39Y9
	NQqO+7zvRSFnQ8FJ2ySos4+ftBFzlY1EGtckzT4xdNBS5fLwwLARhdp+9ROprB8pv+59xtL3Ihl
	u
X-Google-Smtp-Source: AGHT+IH1ja09Qom46xnUcrexpKRAVG2BBC5ma2SZaVwblpanaLW5bIp0gffZeAIhlBbijP9ZB6eo2Q==
X-Received: by 2002:a17:902:ebc6:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-21283c8bfa3mr35307545ad.16.1732171493216;
        Wed, 20 Nov 2024 22:44:53 -0800 (PST)
Received: from MVIN00016.mvista.com ([43.249.234.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befe29b7sm2798829b3a.175.2024.11.20.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:44:52 -0800 (PST)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: fix CVE-2024-45795
Date: Thu, 21 Nov 2024 12:14:42 +0530
Message-Id: <20241121064442.43618-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 06:45:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/828

Upstream-Status: Backport from https://github.com/OISF/suricata/commit/72456d359bf3064306b62024c809bb30b162f18c && https://github.com/OISF/suricata/commit/96d5c81aed01f2bc0cd3e2e60057d0deb38caa99

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2024-45795.patch       | 123 ++++++++++++++++++
 recipes-ids/suricata/suricata_7.0.0.bb        |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2024-45795.patch

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
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index a01b3d9..8debf10 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -16,6 +16,7 @@ SRC_URI += " \
     file://suricata.service \
     file://run-ptest \
     file://fixup.patch \
+    file://CVE-2024-45795.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.25.1


