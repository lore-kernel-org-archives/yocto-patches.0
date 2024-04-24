Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.826.1713975407406392228
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Apr 2024 09:16:47 -0700
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343c891bca5so5613875f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Apr 2024 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975405; x=1714580205; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdhmw5h7FnJpxfy0ylBENEdqpfLMPyHabI2qG7b8oFM=;
        b=TxmEJp5PgMYN6XASDHBym4o1dURZ8HAjO8TsiBJ6HC9yCM6rutFzwj7I7ndlwCgW8k
         fRZmkyHGmuPgdjyBsAyEe+nAZng7QEtDvkuiw4V1IP7RykgEgjsxQuQxvVcGza8w3kAD
         b+MXzrYK/TOT5xr5Xp9iDIEp4M9VhHKxW7CUSvOsQUN9tbZekcKNZ7rwhVI5DO8WgAdK
         z1S1Z6JIdEgx19zqeJ8YCp0xNMnvSTyNLk6Q3/lDDing4p97KeTPyHNCeP3qdrSJVt9d
         R9T7XjwFToMl0OdPxA5olqTNMVdJiTSmeA24iuN1e2SNHatQ0s1dLexOuunyXEcvUzYh
         nj4A==
Return-Path: <rybczynska@gmail.com>
From: "Marta Rybczynska" <rybczynska@gmail.com>
Subject: [meta-security][PATCH] lynis: update download path
Date: Wed, 24 Apr 2024 18:16:29 +0200
Message-ID: <20240424161629.1658945-1-marta.rybczynska@syslinbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@syslinbit.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

After the release of lynis 3.1.0, older versions are now in archive/

Signed-off-by: Marta Rybczynska <marta.rybczynska@syslinbit.com>
---
 recipes-compliance/lynis/lynis_3.0.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/lynis/lynis_3.0.9.bb b/recipes-compliance/lynis/lynis_3.0.9.bb
index b8b97a5..0586c98 100644
--- a/recipes-compliance/lynis/lynis_3.0.9.bb
+++ b/recipes-compliance/lynis/lynis_3.0.9.bb
@@ -6,7 +6,7 @@ HOMEDIR = "https://cisofy.com/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
-SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz \
+SRC_URI = "https://downloads.cisofy.com/lynis/archive/${BPN}-${PV}.tar.gz \
            file://0001-osdetection-add-OpenEmbedded-and-Poky.patch \
           "
 
-- 
2.42.0

