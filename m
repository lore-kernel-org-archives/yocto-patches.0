Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB405E85399
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2216.1775241420962391587
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iza418Jb;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd71fb9f06so137900185a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241419; x=1775846219; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ara3uTTvGb8FLGFq2Jd/5TwmPU+UAuG5QxJWZbybs8w=;
        b=iza418JbvTslNvg+MBGLCTJ3QwgQ7LuzvgtKiYqgJmsbr3p5vjJZwY2gS9vcR3Tgvr
         1et5gGZewI+73LOqblAKKTfNFSoHWt3jvLxJEMwqduuBlpBjqFNlK2fCk9utSMmOPym/
         2sCh8qSi5oEMFJCEqIA49UP1JCAGXcfgDiY4VmJkOSLWgb1kpml+FUglrTlEsZTIiYKa
         ejBMm6AhBb59UyjOoz5KTQBvtOLWBGzrUN9Ea5AizT0D4LPFVeIBBWZzrEqIb5lWmHCC
         UDQ+cC+hfbhirJX0lUtzJUD29+0LWRvRRJPg7V4AGkhv1pn0lG8m3Tv2dJrs3l4x0CaG
         Ditg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241419; x=1775846219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ara3uTTvGb8FLGFq2Jd/5TwmPU+UAuG5QxJWZbybs8w=;
        b=PA9kVVUuEPPTJxvuFxPzU4cFPqv2v+UOcRHUIqPHWfH2immsHbWurwKBf0epfWXerB
         eHN3xWF3IkiKjBD40FBYhSUOwTXnS3fXUOtkheqW1XZf4VKpVMiUnglPMYObsHTQ6g2o
         JX/dQc63/r4Tk4zeUYmdS0rHdvTEFWKXtXv9+6yeydNyTINv4oTZ1QcvEXgTm3YuPLNE
         ds0xhPeGaadr+kX3eD7Gyi/bdMsQ6txrAlU0gLl6dBc7glGQAv3vevmehyjGHFnnee3V
         MQw380D03KqPR0WCYVhJZU/bYObsIVHzVE6qNBr+Ku99KNfTtEBiK5NaMzXoEWgoiKuI
         tGVw==
X-Gm-Message-State: AOJu0YyEWDoQuy4BcguqLl5Pej4KCgKjmZk2/1QbGZRuzTbvcf2qJiV8
	ubDZ+dfnuKkzCxlHaxRjN8Hc/YS7amuoaAAUwmTr9htY5DYbt3ofzwtBcDFa+mkP
X-Gm-Gg: ATEYQzylv1qLOFOUXJpIn8F9UOS13GwqEQyaxtJ0sLdU9tzZpBNWfCEpzroGN4+9FRM
	c3Itdx4QJNY+Y+yxgwtvRIjdGPbhfy/sRb/JQf5o4YMM4MLAS6KptVui+IdghD64GW8hHqNTyK8
	cjkgobcugNMVwmHq05IdQO++U0t0RsIuM1DJeey+u4L4fHMRHWQl54XS0mPNLCgh2qJ7F/hO4Ok
	kPZrAOrlfuH5t1Q1zKSNB0hT4INDP2h5cUBm1vxE4MDZxTvtZA0NjMf/a3i+MyOMYuFqkkvkxwG
	ixoNGY6nMPI6P9eIEk1Z5cl5La+V+1pSrI0PShyNBvNkWs97X51MWjF68QtKo2KQlGO3JYuddvR
	be5lHJorrFjgSwqeONpq3SmNIyWNtQLNJS01J0bIFDfRBslCuDL3kU9KCWijDqGOGBaOIIb4Hsi
	Lga1E9DHSGQsVTsnsq8x4FSaepgyD5JA1WOjsJdDIRyRED7aNysCoFB29UIzcYMX/66w==
X-Received: by 2002:a05:620a:7112:b0:8cd:8635:c031 with SMTP id af79cd13be357-8d41919026cmr592919485a.20.1775241418496;
        Fri, 03 Apr 2026 11:36:58 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:36:57 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 2/9] move example *wks files
Date: Fri,  3 Apr 2026 14:36:37 -0400
Message-ID: <20260403183644.2783267-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3628

These canned *wks files come directly from the OpenEmbedded project, are
only relevant to that project, and therefore should be preserved there.
Instead of removing them, keep them around as example *wks files for
this project.

However, move them away from a location (relative to the wic invoking
script itself, cli.py) so they do not accidentally interfere with any
usage of this tool.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 {src/wic/canned-wks => example-wks}/common.wks.inc                | 0
 .../canned-wks => example-wks}/directdisk-bootloader-config.cfg   | 0
 .../canned-wks => example-wks}/directdisk-bootloader-config.wks   | 0
 {src/wic/canned-wks => example-wks}/directdisk-gpt.wks            | 0
 {src/wic/canned-wks => example-wks}/directdisk-multi-rootfs.wks   | 0
 {src/wic/canned-wks => example-wks}/directdisk.wks                | 0
 {src/wic/canned-wks => example-wks}/efi-bootdisk.wks.in           | 0
 {src/wic/canned-wks => example-wks}/efi-uki-bootdisk.wks.in       | 0
 {src/wic/canned-wks => example-wks}/mkefidisk.wks                 | 0
 {src/wic/canned-wks => example-wks}/mkhybridiso.wks               | 0
 {src/wic/canned-wks => example-wks}/qemuloongarch.wks             | 0
 {src/wic/canned-wks => example-wks}/qemuriscv.wks                 | 0
 {src/wic/canned-wks => example-wks}/qemux86-directdisk.wks        | 0
 {src/wic/canned-wks => example-wks}/sdimage-bootpart.wks          | 0
 {src/wic/canned-wks => example-wks}/systemd-bootdisk.wks          | 0
 15 files changed, 0 insertions(+), 0 deletions(-)
 rename {src/wic/canned-wks => example-wks}/common.wks.inc (100%)
 rename {src/wic/canned-wks => example-wks}/directdisk-bootloader-config.cfg (100%)
 rename {src/wic/canned-wks => example-wks}/directdisk-bootloader-config.wks (100%)
 rename {src/wic/canned-wks => example-wks}/directdisk-gpt.wks (100%)
 rename {src/wic/canned-wks => example-wks}/directdisk-multi-rootfs.wks (100%)
 rename {src/wic/canned-wks => example-wks}/directdisk.wks (100%)
 rename {src/wic/canned-wks => example-wks}/efi-bootdisk.wks.in (100%)
 rename {src/wic/canned-wks => example-wks}/efi-uki-bootdisk.wks.in (100%)
 rename {src/wic/canned-wks => example-wks}/mkefidisk.wks (100%)
 rename {src/wic/canned-wks => example-wks}/mkhybridiso.wks (100%)
 rename {src/wic/canned-wks => example-wks}/qemuloongarch.wks (100%)
 rename {src/wic/canned-wks => example-wks}/qemuriscv.wks (100%)
 rename {src/wic/canned-wks => example-wks}/qemux86-directdisk.wks (100%)
 rename {src/wic/canned-wks => example-wks}/sdimage-bootpart.wks (100%)
 rename {src/wic/canned-wks => example-wks}/systemd-bootdisk.wks (100%)

diff --git a/src/wic/canned-wks/common.wks.inc b/example-wks/common.wks.inc
similarity index 100%
rename from src/wic/canned-wks/common.wks.inc
rename to example-wks/common.wks.inc
diff --git a/src/wic/canned-wks/directdisk-bootloader-config.cfg b/example-wks/directdisk-bootloader-config.cfg
similarity index 100%
rename from src/wic/canned-wks/directdisk-bootloader-config.cfg
rename to example-wks/directdisk-bootloader-config.cfg
diff --git a/src/wic/canned-wks/directdisk-bootloader-config.wks b/example-wks/directdisk-bootloader-config.wks
similarity index 100%
rename from src/wic/canned-wks/directdisk-bootloader-config.wks
rename to example-wks/directdisk-bootloader-config.wks
diff --git a/src/wic/canned-wks/directdisk-gpt.wks b/example-wks/directdisk-gpt.wks
similarity index 100%
rename from src/wic/canned-wks/directdisk-gpt.wks
rename to example-wks/directdisk-gpt.wks
diff --git a/src/wic/canned-wks/directdisk-multi-rootfs.wks b/example-wks/directdisk-multi-rootfs.wks
similarity index 100%
rename from src/wic/canned-wks/directdisk-multi-rootfs.wks
rename to example-wks/directdisk-multi-rootfs.wks
diff --git a/src/wic/canned-wks/directdisk.wks b/example-wks/directdisk.wks
similarity index 100%
rename from src/wic/canned-wks/directdisk.wks
rename to example-wks/directdisk.wks
diff --git a/src/wic/canned-wks/efi-bootdisk.wks.in b/example-wks/efi-bootdisk.wks.in
similarity index 100%
rename from src/wic/canned-wks/efi-bootdisk.wks.in
rename to example-wks/efi-bootdisk.wks.in
diff --git a/src/wic/canned-wks/efi-uki-bootdisk.wks.in b/example-wks/efi-uki-bootdisk.wks.in
similarity index 100%
rename from src/wic/canned-wks/efi-uki-bootdisk.wks.in
rename to example-wks/efi-uki-bootdisk.wks.in
diff --git a/src/wic/canned-wks/mkefidisk.wks b/example-wks/mkefidisk.wks
similarity index 100%
rename from src/wic/canned-wks/mkefidisk.wks
rename to example-wks/mkefidisk.wks
diff --git a/src/wic/canned-wks/mkhybridiso.wks b/example-wks/mkhybridiso.wks
similarity index 100%
rename from src/wic/canned-wks/mkhybridiso.wks
rename to example-wks/mkhybridiso.wks
diff --git a/src/wic/canned-wks/qemuloongarch.wks b/example-wks/qemuloongarch.wks
similarity index 100%
rename from src/wic/canned-wks/qemuloongarch.wks
rename to example-wks/qemuloongarch.wks
diff --git a/src/wic/canned-wks/qemuriscv.wks b/example-wks/qemuriscv.wks
similarity index 100%
rename from src/wic/canned-wks/qemuriscv.wks
rename to example-wks/qemuriscv.wks
diff --git a/src/wic/canned-wks/qemux86-directdisk.wks b/example-wks/qemux86-directdisk.wks
similarity index 100%
rename from src/wic/canned-wks/qemux86-directdisk.wks
rename to example-wks/qemux86-directdisk.wks
diff --git a/src/wic/canned-wks/sdimage-bootpart.wks b/example-wks/sdimage-bootpart.wks
similarity index 100%
rename from src/wic/canned-wks/sdimage-bootpart.wks
rename to example-wks/sdimage-bootpart.wks
diff --git a/src/wic/canned-wks/systemd-bootdisk.wks b/example-wks/systemd-bootdisk.wks
similarity index 100%
rename from src/wic/canned-wks/systemd-bootdisk.wks
rename to example-wks/systemd-bootdisk.wks
-- 
2.51.0


