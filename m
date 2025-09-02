Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33AACA1007
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 05:59:05 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.70753.1756792737007822721
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 22:58:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=apOZdZah;
 spf=pass (domain: mvista.com, ip: 209.85.216.47, mailfrom: hprajapati@mvista.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3298961169bso1750921a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1756792736; x=1757397536; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqbCzKenzG0Qx+PlTBWOvNN7jzso+L/qk6lwssXiBQo=;
        b=apOZdZahMxExKwhXKGQBNruRSVqcAgThBZ/kgguUoeF0PbDkJKzqgdGvxdTGQBSzyR
         JJBzuYL72SAB7B4mfiDHTieEseXvBUyA9oRSxMeu+D6f150BpRy9t6cTus2y02N4zrhM
         kEaCST/DcjJgVDyJ79B+EvEuQpRaTl95+kwGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792736; x=1757397536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqbCzKenzG0Qx+PlTBWOvNN7jzso+L/qk6lwssXiBQo=;
        b=gFgi7+MZgEJoTlPzqcgVwKuZaLW0rkUvxeYyEDr1mxGYuab8eDPyPpvY9A7pg2iBZm
         MoTv25pDu/Wtrb+yVhBwJ8OHp6UboAZGz229CPHSrbIwPxxSH3ig+Q29z6YfymyIgGzv
         e450He3r89cMCkdQuooUzHxe62ySvwfknAH60ZQsWYPIvI2MJENwy1NJ00IgwXG0qIuC
         KbCxBDK1K7cEftgEXlGf5HCPb785B/Zaok6JumNHLWM3uCbVMvKQPAfo5jBeuctwZenh
         iQxHbdMaG+eETJPRNJ81C9Z5ggqU88LHvMB94UZECupevR+9dPZ5vWamOOAZcVw9+f8F
         nonw==
X-Gm-Message-State: AOJu0YwsrTpwaKwvB+p1pCzDHbpa0WCWoCDxKQjqCp8JWqf6wxJcZI/5
	ylNoDxenfgG+a1sDqYNLmKblxoJzR/fJ0nK9PIf47cgZWRZd1Lm3Ga9LYy60wNC/TE1GqGbig68
	KxDZR
X-Gm-Gg: ASbGncv+NHEB9snQv1q1WKuxADgsPa9jEnnXImKjQe4075wkeBNiCN4bPIkwONwIaqf
	9x3NnA9Q/hE3hnAKm00hwT7ogTFC0J395Mi8T3/KMJ7KBxPwVCKKp1qhRYx80YHjqJMMGaCytGH
	eQnY8sqVpO8r7IQyt8EiapzdUqyLh7Kf1jxebAoLR8rRaaKMl+XT/IVoStPqJhnUSsyx9iG91J6
	dxowB88/HHrrEsFoXEoJR5Yw1l1d6tyVV5jTK1JMkm/oCDNy2RNMkvTon7rvoH5IlaOqakJFl+s
	nZGuUGbV1sv/8oCWUKvr0e2t9Z/J4oc31DbWAsJPiGFUwHn6oH/S1HmY/WJCbKERKHBv3jP0rzE
	PbbwYc+CJjEaeqbYkhKzq5oMiibWYj8UUELPHLbJH+RJHy4M=
X-Google-Smtp-Source: AGHT+IF/HVZXeiJigFL8JjxRQkpsguQOrw189xKGKrA1XgZ01++c/wOKIACjCtvbS/xQmEg7BDqyiw==
X-Received: by 2002:a17:90b:2692:b0:327:96dd:6299 with SMTP id 98e67ed59e1d1-328156e57a6mr14115697a91.33.1756792736150;
        Mon, 01 Sep 2025 22:58:56 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725d5b90fasm4306176b3a.100.2025.09.01.22.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:58:55 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] libhtp: fix CVE-2025-53537
Date: Tue,  2 Sep 2025 11:28:38 +0530
Message-ID: <20250902055838.29035-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:59:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2105

Upstream-Status: Backport from
https://github.com/OISF/libhtp/commit/226580d502ae98c148aaecc4846f78694b5e253c && https://github.com/OISF/libhtp/commit/9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2025-53537-001.patch   | 79 +++++++++++++++++++
 .../suricata/files/CVE-2025-53537-002.patch   | 31 ++++++++
 recipes-ids/suricata/libhtp_0.5.45.bb         |  2 +
 3 files changed, 112 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2025-53537-001.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-53537-002.patch

diff --git a/recipes-ids/suricata/files/CVE-2025-53537-001.patch b/recipes-ids/suricata/files/CVE-2025-53537-001.patch
new file mode 100644
index 0000000..e16a59a
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-53537-001.patch
@@ -0,0 +1,79 @@
+From 226580d502ae98c148aaecc4846f78694b5e253c Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <contact@catenacyber.fr>
+Date: Tue, 11 Mar 2025 16:45:35 +0100
+Subject: [PATCH] decompressors: do not take data after end
+
+
+CVE: CVE-2025-53537
+Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/226580d502ae98c148aaecc4846f78694b5e253c]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ htp/htp_core.h          |  5 ++++-
+ htp/htp_decompressors.c | 21 ++++++++++++---------
+ 2 files changed, 16 insertions(+), 10 deletions(-)
+
+diff --git a/htp/htp_core.h b/htp/htp_core.h
+index 7c23212..fb142c9 100644
+--- a/htp/htp_core.h
++++ b/htp/htp_core.h
+@@ -161,7 +161,10 @@ enum htp_content_encoding_t {
+     HTP_COMPRESSION_DEFLATE = 3,
+ 
+     /** LZMA compression. */
+-    HTP_COMPRESSION_LZMA = 4
++    HTP_COMPRESSION_LZMA = 4,
++
++    /** No more data. */
++    HTP_COMPRESSION_OVER = 5
+ };
+ 
+ /**
+diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
+index 19950df..0d94c30 100644
+--- a/htp/htp_decompressors.c
++++ b/htp/htp_decompressors.c
+@@ -203,6 +203,8 @@ htp_status_t htp_gzip_decompressor_decompress(htp_decompressor_t *drec1, htp_tx_
+         }
+ 
+         return HTP_OK;
++    } else if (drec->zlib_initialized == HTP_COMPRESSION_OVER) {
++        return HTP_ERROR;
+     }
+ 
+     if (d->data == NULL) {
+@@ -316,15 +318,9 @@ restart:
+             // no initialization means previous error on stream
+             return HTP_ERROR;
+         }
+-        if (GZIP_BUF_SIZE > drec->stream.avail_out) {
+-            if (rc == Z_DATA_ERROR) {
+-                // There is data even if there is an error
+-                // So use this data and log a warning
+-                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
+-                rc = Z_STREAM_END;
+-            }
+-        }
+-        if (rc == Z_STREAM_END) {
++
++	int error_after_data = (rc == Z_DATA_ERROR && drec->restart == 0 && GZIP_BUF_SIZE > drec->stream.avail_out);
++        if (rc == Z_STREAM_END || error_after_data) {
+             // How many bytes do we have?
+             size_t len = GZIP_BUF_SIZE - drec->stream.avail_out;
+ 
+@@ -351,6 +347,13 @@ restart:
+             drec->stream.next_out = drec->buffer;
+             // TODO Handle trailer.
+ 
++            if (error_after_data) {
++                // There is data even if there is an error
++                // So use this data and log a warning
++                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
++                drec->zlib_initialized = HTP_COMPRESSION_OVER;
++                return HTP_ERROR;
++            }
+             return HTP_OK;
+         }
+         else if (rc != Z_OK) {
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2025-53537-002.patch b/recipes-ids/suricata/files/CVE-2025-53537-002.patch
new file mode 100644
index 0000000..ff4f1a0
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-53537-002.patch
@@ -0,0 +1,31 @@
+From 9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <contact@catenacyber.fr>
+Date: Tue, 17 Jun 2025 10:12:47 +0200
+Subject: [PATCH] decompressors: fix leak in lzma error case
+
+Ticket: 7766
+
+CVE: CVE-2025-53537
+Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ htp/htp_decompressors.c | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
+index 0d94c30..ce6cfe1 100644
+--- a/htp/htp_decompressors.c
++++ b/htp/htp_decompressors.c
+@@ -351,6 +351,9 @@ restart:
+                 // There is data even if there is an error
+                 // So use this data and log a warning
+                 htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
++                if (drec->zlib_initialized == HTP_COMPRESSION_LZMA) {
++                    LzmaDec_Free(&drec->state, &lzma_Alloc);
++                }
+                 drec->zlib_initialized = HTP_COMPRESSION_OVER;
+                 return HTP_ERROR;
+             }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/libhtp_0.5.45.bb b/recipes-ids/suricata/libhtp_0.5.45.bb
index 604a0ca..b87db35 100644
--- a/recipes-ids/suricata/libhtp_0.5.45.bb
+++ b/recipes-ids/suricata/libhtp_0.5.45.bb
@@ -6,6 +6,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=596ab7963a1a0e5198e
 
 SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x \
            file://CVE-2024-45797.patch \
+           file://CVE-2025-53537-001.patch \
+           file://CVE-2025-53537-002.patch \
           "
 SRCREV = "8bdfe7b9d04e5e948c8fbaa7472e14d884cc00af"
 
-- 
2.50.1


