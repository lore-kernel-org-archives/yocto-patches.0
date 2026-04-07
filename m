Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D544FF5134
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 18:49:47 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88752.1775587777258010990
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 11:49:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=m/gE7agb;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50b392f1846so76262001cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775587776; x=1776192576; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpUbaPDCmPz+QT4Z34c2/Tnfbzj/iyDEmihKCoZWEAY=;
        b=m/gE7agbHTbna+NgRwnjwbxoa7L1pCqWg8pnEsbXYLMhp/3iQWAJ+sXs1NgDnmPGqH
         2APjeLmoU2SXYjAwodPrNyG5Wycj1b6M7RtGvB696ewKFTNUGLb2Pds9sPWgecU0AF8t
         5ztq90WYrd9wGx5xrYdJqq6zBsVLRTC45gbnbEGEwa9h8KHVh69VlHMNKgUEEAMTBbQc
         Mof0P1rEiC5Sv6kIWPDmIIpa69bb+u6xeUom7DYz0luvxaA/tR5w6QTCkXgwB01CSziz
         jhuidBt80DAG8l+rQ5XSlobxTlqCdZY3rw0d4SHKVfLqSTqYI8icyDvkLthbHlx4g3cq
         yP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775587776; x=1776192576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpUbaPDCmPz+QT4Z34c2/Tnfbzj/iyDEmihKCoZWEAY=;
        b=a2yzC0QF/qclWNl+BDhItGkJjSz3HmRQ64T9i2sedRWap8+f/+B5HzZ9xdpLRna0EH
         ILJHHx5SmAC2goGOvpdfCVpi84mJY49NpnpKaTiTvk0dGmVz/W9wKOsEBo7m8qlldeQL
         TpNkwxpaqqBnIF18JEWJhFLk66qJPzgf4hYFyr9eyPgY+bvnqX/8NMV0EJfTGK6I5usp
         FnCStXwkV5wI0a4CHgoKkCaFvqOHdT+uoAUuNGD/WYtx9ztIBuXfyL5GKqYo1KTsyHTv
         u7H9LgbBD7t7vQEgbVw2QcViMuCv0f5nxL+M82paB6eXIp9/jUhzftIzwyDoh6HdvFZF
         G+zw==
X-Gm-Message-State: AOJu0YzKx+b771ZS7i93kB8H1OAEpSkI/kV4/iXqutLt6b8jjDiMtnBj
	Wv0iguYRr9jty558tEceP7d41/FFRb4RxKhUhTvJiR59X4wZtmErKiRE5FjHqg==
X-Gm-Gg: AeBDievcKVuLaRORMEBoBuKKgm78s9OdQ7eOk1xGn3M6Vhn0wv4nfLZ/H1c6Ej1MjSZ
	rj1/3wQlz1EJjOK8CxChVkgm/Y2lL59iP9FTcVrqavsHj+5E7yGRoK93Vt0n0CiPObvqPQdKmO8
	awDy8Zdn5UrYlyMdx6CzxB29JIJVRhyD++epdVcjdEYVku0w+WgGd5pbj2sNZw8UroPTEfxoD7r
	M2VqCmZqvAhfdgwbyzMekJ/SiSt7+f/yR3d6nLFySpjsCv6f/3L9lylCIt1KMTmtLIzKAT5U7UC
	dGp+HpGVn2mYTJHjWoYUaKizJ/4LrHHFJgSz2oK1WAw9az+K+8qxB6Nk5TDtA7I69O7ZdvnIUTA
	YlNgPTUYdpZv4xCJKTYb4EWnx1kQfm2R1zqk5wD3ikQsDq8jJnOcd5EqNtfryDaAHZbt+vZSPgW
	DWbBF50/CqfZFe0nrNobJkPLXfblaPxo8r/ncmaEpQxaVAtk5WlV9KNaPOaAEVPVQklw==
X-Received: by 2002:a05:622a:5590:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-50d628a559emr276551401cf.25.1775587775618;
        Tue, 07 Apr 2026 11:49:35 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d82afc7d5sm96623641cf.30.2026.04.07.11.49.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:49:34 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic] README.md: update env usage
Date: Tue,  7 Apr 2026 14:49:32 -0400
Message-ID: <20260407184932.3466366-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 18:49:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3655

Update the README to clarify that the --vars argument works with either
one BitBake-generated environment file, or by pointing it at a directory
of environment files.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README.md | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index 8ee02d89738b..c6fed6626e10 100644
--- a/README.md
+++ b/README.md
@@ -1,13 +1,13 @@
 # WIC Standalone
 
 This packages the OpenEmbedded Image Creator (`wic`) as an installable
-Python CLI using Hatch. It either consumes BitBake-exported environment
-files (generated via `bitbake -c rootfs_wicenv <image>`) or will invoke
-BitBake directly (if available on the PATH).
+Python CLI using Hatch. It either consumes a BitBake-exported
+environment file or folder (generated via `bitbake -c rootfs_wicenv
+<image>`) or will invoke BitBake directly (if available on the PATH).
 
 ## Quick start
 
-### Using wicenv
+### Using wicenv (one environment file)
 1. Ensure you have a BitBake-generated `<image>.env` file (from `rootfs_wicenv`).
 2. Install locally for development:
    ```bash
@@ -18,6 +18,17 @@ BitBake directly (if available on the PATH).
    hatch run wic --vars /path/to/<image>.env --help
    ```
 
+### Using wicenv (environment folder)
+1. Ensure you have a folder with BitBake-generated `<image>.env` files (from `rootfs_wicenv`).
+2. Install locally for development:
+   ```bash
+   hatch shell
+   ```
+3. Run the CLI:
+   ```bash
+   hatch run wic --vars /path/to/envfiledir --help
+   ```
+
 ### With bitbake
 1. Ensure you have bitbake available in your PATH.
 2. Install locally for development:
-- 
2.51.0


