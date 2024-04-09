Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web10.153271.1712706973304416084
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 16:56:13 -0700
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso4539513a12.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Apr 2024 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712706973; x=1713311773; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6uu0LrHB94XSzu/aD/yrqvH5zXQjMsJCE6QHe1qw/Q=;
        b=R1iY5e7vAVHMKjsxNtCRuX3uLPgbxkh71x0ZYYUoB3h6e6d4OTwyxmFM0gpi/rqDgq
         L0f2QX5+guXvvFnxfUbwRTJlEBS3ewRlAQVRpM9x81QoAPudL2M9BDsCsz/TxqYjDdle
         khFvJQ8K3qALCUFuQRgktiZISQFTL6Vc0pxQs=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] build(deps): bump pillow from 10.2.0 to 10.3.0
Date: Tue,  9 Apr 2024 16:55:43 -0700
Message-ID: <20240409235602.3362257-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Cc: "dependabot [bot]" <support@github.com>, Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: "dependabot[bot]" <49699333+dependabot[bot]@users.noreply.github.com>

Bumps [pillow](https://github.com/python-pillow/Pillow) from 10.2.0 to 10.3.0.
- [Release notes](https://github.com/python-pillow/Pillow/releases)
- [Changelog](https://github.com/python-pillow/Pillow/blob/main/CHANGES.rst)
- [Commits](https://github.com/python-pillow/Pillow/compare/10.2.0...10.3.0)

---
updated-dependencies:
- dependency-name: pillow
  dependency-type: direct:production
...

Signed-off-by: dependabot[bot] <support@github.com>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/requirements.txt b/requirements.txt
index 256bc28..93e4e53 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -25,7 +25,7 @@ GitPython==3.1.41
 kombu==5.3.4
 mysqlclient==2.2.1
 packaging_legacy==23.0.post0
-Pillow==10.2.0
+Pillow==10.3.0
 prompt-toolkit==3.0.43
 python-dateutil==2.8.2
 pytz==2023.3.post1
-- 
2.43.2

