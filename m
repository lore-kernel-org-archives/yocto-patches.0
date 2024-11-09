Return-Path: <grembeter@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16380D5E365
	for <webhook@archiver.kernel.org>; Sat,  9 Nov 2024 11:29:56 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.15156.1731151791902912140
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 Nov 2024 03:29:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F1/VKywF;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: grembeter@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so481703066b.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 Nov 2024 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731151790; x=1731756590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yHD7JuIag/Nfq39MOavLeuzlIL45rTPdo5af1hHx+M=;
        b=F1/VKywF9kYP2RfHJEgrKr6nRKuBCqr1xwzpwNq935wnb1RVNRjrCF4T++JJ1qaAMN
         uwpUGkTog0O9ne4xF9dPDoAr4j7Zy3+ibr7/5/uqqFQEriXt9j4A/iHozaPB8scoNAIA
         WqQcNuGFMqbw0wDlZVfrWkFuTDm1rsjQdDUKkzvdpO+86BukubN6hRFCqBD+czNXMep0
         uA5CvbJenddC+f2/ZXaiazWqcUa3R3TU+oCy8bnOHa/yIvYjGgPVlnNzrNzisGdUkLRW
         k8J4vgusgt1KsUmwxqTk3GwIA1iQAoQxNEOzJdxSaIjKXU4YtOQa8f37ClFjTAkSpFb1
         xLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731151790; x=1731756590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yHD7JuIag/Nfq39MOavLeuzlIL45rTPdo5af1hHx+M=;
        b=GbzY/BVkRj0G8S2v8NcLvOPSNLjcmTOTv4fdJ6QPkJZ7ioozwTOeTOJ0Q8MgGfriyI
         ER5N41J5qHT/Ml7eaXKLKZoPFrvFxwsHpEL2yxpDtWJck0oeVFQgOqVaHW1VctwW7CVA
         SIf10fXa8y664g3aAfSaYHTpIh4dYqdsT7UeoxKP7Vy68/x60J0WkBbdLenCl2yV9ZyH
         uJfAcQrIYMtYpbnh5Uyu5krXh/dPHkqMwEQk3rYa2WjYHFwl+ia+cIGZXRgpQDaS+mZz
         rBJHtlrFhdMkVWbb/ayCrIVrhpE5u8WqJG2CtuthbwCyBdKOJbHhHS1fT2h2OOGQ8UWE
         l8+w==
X-Gm-Message-State: AOJu0YxYuXg9jpd2lWFlZmUJ+Zp5SlQBzqbJ4+NLQmFLIXwIfbnmt7yD
	1ZfW+QvoX/2nBL5cGBsXHaUogOjz+g7E4n0uAIAdHorIrdyg7XLHgb4OLw==
X-Google-Smtp-Source: AGHT+IG3dwYTSGpqkFVa4aUbsygHaVaIO6FC3aj39KUTSzuxBbSEW+eFcepigyo0RLh1h+fr7ujQKg==
X-Received: by 2002:a17:907:6d03:b0:a9a:1f8:6c9b with SMTP id a640c23a62f3a-a9eeffdc6b1mr595866966b.37.1731151789239;
        Sat, 09 Nov 2024 03:29:49 -0800 (PST)
Received: from think.fritz.box (2001-8e0-3c0d-4001-4e1d-96ff-fe13-2153.bbcs.ip6.as8758.net. [2001:8e0:3c0d:4001:4e1d:96ff:fe13:2153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc49e0sm355637466b.123.2024.11.09.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 03:29:48 -0800 (PST)
From: Grygorii Tertychnyi <grembeter@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Grygorii Tertychnyi <grembeter@gmail.com>
Subject: [meta-security][PATCH] dm-verity-img.bbclass: add DM_VERITY_SETUP_ARGS
Date: Sat,  9 Nov 2024 12:31:45 +0100
Message-Id: <20241109113145.1254-1-grembeter@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 09 Nov 2024 11:29:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/791

Useful to pass additional arguments to veritysetup, for example
'--no-superblock' to make system less vulnerable to certain types of
attacks and data maniputaion on the disk.

Signed-off-by: Grygorii Tertychnyi <grembeter@gmail.com>
---
 classes/dm-verity-img.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 7f79548353b0..9a3a97ec6c26 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -46,6 +46,9 @@ DM_VERITY_IMAGE_HASH_BLOCK_SIZE ?= "4096"
 # Should we store the hash data on a separate device/partition?
 DM_VERITY_SEPARATE_HASH ?= "0"
 
+# Additional arguments for veritysetup
+DM_VERITY_SETUP_ARGS ?= ""
+
 # These are arch specific.  We could probably intelligently auto-assign these?
 # Take x86-64 values as defaults. No impact on functionality currently.
 # See SD_GPT_ROOT_X86_64 and SD_GPT_ROOT_X86_64_VERITY in the spec.
@@ -146,6 +149,7 @@ verity_setup() {
     cp -a $INPUT $OUTPUT
 
     SETUP_ARGS=" \
+        ${DM_VERITY_SETUP_ARGS} \
         --data-block-size=${DM_VERITY_IMAGE_DATA_BLOCK_SIZE} \
         --hash-block-size=${DM_VERITY_IMAGE_HASH_BLOCK_SIZE} \
         $HASH_OFFSET format $OUTPUT $OUTPUT_HASH \
-- 
2.39.5


