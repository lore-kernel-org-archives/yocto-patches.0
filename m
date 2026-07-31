Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACAC55176
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4580.1785497600201283068
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WvwLOi9C;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930fad20240so41797085a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497599; x=1786102399; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=veiYucu+HQrb4uuoqAcTBoBqyIZDKYDHja4bzUCGC+s=;
        b=WvwLOi9ChIZqfG5USoiMc6RV3vs3JZL3NXYK3nFW79e2uz8InO7HRAM0GHcvArXYt6
         aLixVNp+6vZ1ZqK8XeOqA5k+EGPE+/5y7OHbmhStAcq7hRIM/OIckSZctctH6cRhaQLt
         dK/dkF48FUeOcObzwVHFiJd4fKtiBy5RtBI6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497599; x=1786102399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=veiYucu+HQrb4uuoqAcTBoBqyIZDKYDHja4bzUCGC+s=;
        b=B50poedmSKB/2LUY517jbGpoJgOnabczuy0sAQY0RXcpczylTpTn4pnwYuRvbOtlDT
         SRhtxPXWCzqZQjwEFHNQnqZxq4SurslIeLLC/uDKJXoroHf4ln7UhlkvT3ugDdyiNyBG
         7jPZ8QVB92+yfK0X18xMS00rpxVH15VMGT1w4iloRq9+pwa/yGDOaSX9JzaNGaOlgV+y
         XU0zM8Z6xrzHxL+lALdn5agssZg1pN1sJNEXtqjpJvD6lflNjLjDuAEo5+MgOiKFFnDl
         3FTm4fbJ0i66SQWJKBv5t1gl1azt3krssylkgV3xyd29lCJ1RSXKAqoLYsK/v2lq4Iyt
         5Pnw==
X-Gm-Message-State: AOJu0YzEB0XW2zns/UfRxVrukR28jOBsd0tpcDfPhz04ClmDapJXkzER
	qdG8zLP6iXUQDxath2cpLCsQZvCOwkCO928xQaA5EDRI6hEI/45+xsI8ohfgMgyEdrWmGZRgGWL
	S7xNU
X-Gm-Gg: AR+sD13ezPRc13lM9Dp/lueTWlh4hC/4UACDezBlf+ohXJ4GTiY7FPILZVikX7HZDiA
	R9WhwOCoduBUDsKlu5ANdpcnd6Qc8LIAEZMtjYiikwhY4UyKRKwe8KQcfMLnORvmTH82izSR2gu
	ZaEDLbEJJayq3EmYf9nCWbyZDAf03tX8/K+d7Ry+NZyeZLQT0IQMLAUZtN/soUh0y1lhEwwcNvw
	lawznoScPJSRkFr0RPoEKafkoIuw0R6Y24hlBzrAtzLbYcs7buiUuB81fYR31c3tCTlYgxxloa+
	CSnpLz5gb3M9qB4yq4q5XHidjj+OpLjK5qGinYFx1fiorqleg1LML3OR2Wr6t+kkj6F2KwD2lmo
	5/U7kr8gTOltsZaapKqnSw7QKlCCdFOTXJsv4tUof0F8INRzBdsJWBnKb5HH4hBsmovckJqtYEn
	p5Q7xdBRyV0LgYDavxNGQI8MR0y1Y5hNxFT0rXbvJTbZbKC1AeG6JWku+AbFOtfZ0KqNnZvi6YR
	EyC1MhRJ3NtL08wKfhKFhFtaBwEWVJBdKFib7/3dgWbpqzapj4FvKq5gLyX83E/otEOe2fe07Uz
	9STXVYFdavWEm6Q9C1ERab+j5A==
X-Received: by 2002:a05:620a:a40a:20b0:92e:5612:ba3a with SMTP id af79cd13be357-934965a10e1mr171184485a.17.1785497598969;
        Fri, 31 Jul 2026 04:33:18 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:18 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/35]  cargo-update-recipe-crates: Don't fail for partially empty Cargo.lock
Date: Fri, 31 Jul 2026 07:32:32 -0400
Message-ID: <e6d15d7bf6bbc962c4209946458b1b7e460c2842.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4577

From: Martin Schwan <m.schwan@phytec.de>

Do not fail if only some Cargo.lock files are empty. Only fail, if there
are absolutely no dependencies found in any Cargo.lock.

This fixes the following error message, which would occur with "bitbake
-c update_crates python3-orjson":

    ERROR: python3-orjson-3.10.17-r0 do_update_crates: Execution of '.../python3-orjson/3.10.17/temp/run.do_update_crates.70693' failed with exit code 1
    ERROR: Logfile of failure stored in: .../python3-orjson/3.10.17/temp/log.do_update_crates.70693
    Log data follows:
    | DEBUG: Executing python function extend_recipe_sysroot
    | NOTE: Direct dependencies are ['.../sources/oe-core/../oe-core/recipes-devtools/quilt/quilt-native_0.69.bb:do_populate_sysroot', 'virtual:native:.../sources/oe-core/../oe-core/recipes-devtools/patch/patch_2.8.bb:do_populate_sysroot', 'virtual:native:.../sources/oe-core/../oe-core/recipes-devtools/python/python3_3.13.9.bb:do_populate_sysroot']
    | NOTE: Installed into sysroot: []
    | NOTE: Skipping as already exists in sysroot: ['gettext-minimal-native', 'cmake-native', 'libtool-native', 'quilt-native', 'texinfo-dummy-native', 'openssl-native', 'expat-native', 'ncurses-native', 'util-linux-libuuid-native', 'zlib-native', 'libedit-native', 'make-native', 'patch-native', 'perl-native', 'python3-native', 'bzip2-native', 'xz-native', 'zstd-native', 'attr-native', 'gdbm-native', 'libffi-native', 'sqlite3-native']
    | DEBUG: Python function extend_recipe_sysroot finished
    | DEBUG: Executing shell function do_update_crates
    | Traceback (most recent call last):
    |   File "<stdin>", line 41, in <module>
    |   File "<stdin>", line 12, in get_crates
    | ValueError: Unable to find any candidate crates that use crates.io
    |
    | The above exception was the direct cause of the following exception:
    |
    | Traceback (most recent call last):
    |   File "<stdin>", line 43, in <module>
    | ValueError: Cannot parse '.../python3-orjson/3.10.17/sources/orjson-3.10.17/include/cargo/simdutf8-0.1.5/Cargo.lock'
    | WARNING: exit code 1 from a shell command.
    ERROR: Task (.../sources/oe-core/../meta-openembedded/meta-python/recipes-devtools/python/python3-orjson_3.10.17.bb:do_update_crates) failed with exit code '1'

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1ef39b3fa731fb121d338aea2b1ac004620063e0)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../cargo-update-recipe-crates.bbclass           | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/classes-recipe/cargo-update-recipe-crates.bbclass b/classes-recipe/cargo-update-recipe-crates.bbclass
index 3251d5e..ffc658f 100644
--- a/classes-recipe/cargo-update-recipe-crates.bbclass
+++ b/classes-recipe/cargo-update-recipe-crates.bbclass
@@ -38,7 +38,8 @@ def get_crates(f):
     crates_candidates = list(filter(lambda c: 'crates.io' in c.get('source', ''), crates['package']))
 
     if not crates_candidates:
-        raise ValueError("Unable to find any candidate crates that use crates.io")
+        print("WARNING: Unable to find any candidate crates that use crates.io")
+        return None
 
     # Update crates uri and their checksum, to avoid name clashing on the checksum
     # we need to rename crates with name and version to have a unique key
@@ -65,14 +66,11 @@ for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
         continue
     for file in files:
         if file == 'Cargo.lock':
-            try:
-                cargo_lock_path = os.path.join(root, file)
-                crates += get_crates(os.path.join(root, file))
-            except Exception as e:
-                raise ValueError("Cannot parse '%s'" % cargo_lock_path) from e
-            else:
-                found = True
-if not found:
+            cargo_lock_path = os.path.join(root, file)
+            c = get_crates(cargo_lock_path)
+            if c is not None:
+                crates += c
+if crates is None:
     raise ValueError("Unable to find any Cargo.lock in ${CARGO_LOCK_SRC_DIR}")
 open("${TARGET_FILE}", 'w').write(crates)
 EOF
-- 
2.55.0


