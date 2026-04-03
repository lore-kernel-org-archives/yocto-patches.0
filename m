Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B9E85398
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2222.1775241418722233852
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:36:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eCKq7cTt;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfc497a604so247417585a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241417; x=1775846217; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x9jOo5gg9/yUB0n46hVXNpm0ppxkpPClIg/kzzfCCI=;
        b=eCKq7cTtpE3FTpx4caiJfAawCRc19Xsq9OUjv8/dn5DbDQiZUh2D+LmgfWbrV3wBph
         pe0bNgfZciJ7HowZ0d6/84Z4KBs14c4AZAKkkBcBRYY5UzDYxK4K/Wd3CCWCyEWUi6dc
         K4yRRVtZ2BMJtxTrdMEQpJATn9ebUlZnoOv1ZYvJwcW2O7Q8oJi5Lul+Pw14nDSKxxYi
         FH6F4MrlgjCxB5VCyoNruJy98RtFS55ac+znBov9TE78jN2gkPMVCyTv2yQVYK4Fk9N/
         MEMPFOiHlIFFmSd3ey2HJ3250VfZfaJBwu/f8g97y5KZkfRexwhbrcmibiL74CtP7uvJ
         zb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241417; x=1775846217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9x9jOo5gg9/yUB0n46hVXNpm0ppxkpPClIg/kzzfCCI=;
        b=M0cllqVv6/Go6OhH4bLuus4mVXwnWX9LjZ1aM7LE93tAMIos28WV7gJabA+W0AoaSc
         ScblhAzq7PJvOKGCZ0UUb9kEf0hFnhIgx+g4wf0ck2aI9DWevX39DjIO+i2V+XIRiEm5
         DTz3jPeU3KCb5f324nW8/SkP7k+xXXB8NC7n30akdHZslxhjDcsZtIu66mQGieBciqnn
         S1usRCALunVgNERBpepUugFe2Jk8oXylg7KIdunC+eMlEutq1x/TaGC/ORXDODS/jzRM
         Kawa1Qcbt4b5Kg/xi9hEqmuDf9LhDmBnz+SSdESM/3r1wOzH2dL9EA6yLnMgNE2pvtGp
         ULZQ==
X-Gm-Message-State: AOJu0YyL8wf6WDxPPPtzT4P1MtGEHVQuzak/4JMl2OuhbyTGHe5yu/ZS
	W7Gb9mvXS4PqmJjf6G6FKGAqiZC0XK9zpADMkg5eqqpWGtCeycvs5HeO0U1FCztK
X-Gm-Gg: ATEYQzzvFmxNyQk2cO6Y2FQ4s9+O6YQfJfGlyb/piHEeeMAc6v7bvHgNROQhZvjcqyX
	yqpkKG3L8cjll4QUuXsk9yf1A8zGpTHe3arHfjH6Rpi+A+9LRgY+tbbaNqreb97Str+ZcidaWNY
	GUNUpeK2t0AumQHD9OPC+eILVQS537VuA1rgEcNeAXVVbIwcl/DnVgwnwojKkwGJkc51JyApNVu
	6yknUlaHlQhQQeNFWcBy9PBWpmBxMtRNRlYLNEFgKkinP02F3rI4Zf7NosG/wra0kLQPSp75RlI
	+CS5y2sRHKQUcuXtILdxrP9i8JCa/fyQacn/nvLSECjVXIdymGXK2yHuQk5P44i8pQiuQf6IFzO
	n6CP38gaMHi8AauEOgK0iitZnzMvcjCzidkEBV6WfhWtTY/u/ErceLkPAg3qdHj6jHyACYfMbex
	ED+aXTLBB7nZ8eIuwFf7Mct9fTpj88j65EyHWzJkYp6mgbIXSNcNRE16cPdRZWxibPgw==
X-Received: by 2002:a05:620a:472a:b0:8cd:8fe4:537b with SMTP id af79cd13be357-8d41d961e4bmr566017185a.37.1775241417050;
        Fri, 03 Apr 2026 11:36:57 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:36:56 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 1/9] re-organize for python src layout packaging
Date: Fri,  3 Apr 2026 14:36:36 -0400
Message-ID: <20260403183644.2783267-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3627

The git-filter-repo tool was used to take OpenEmbedded's wic utility and
import it (without any modification whatsoever) into its own source code
repository while preserving the entire git history, removing any files
and git history not related to wic. The specific command used to perform
this conversion on a clean checkout of the OpenEmbedded repository was:
    $ git-filter-repo --force --path scripts/wic --path scripts/lib/wic/

The goal of this conversion process is to end up with an independent
Python package for wic. This commit moves the wic components into the
Python de facto standard packaging "src layout" order. All components
are moved as they are; the main wic program is moved and renamed to
`src/wic/cli.py`.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 {scripts/lib => src}/wic/__init__.py                              | 0
 {scripts/lib => src}/wic/canned-wks/common.wks.inc                | 0
 .../lib => src}/wic/canned-wks/directdisk-bootloader-config.cfg   | 0
 .../lib => src}/wic/canned-wks/directdisk-bootloader-config.wks   | 0
 {scripts/lib => src}/wic/canned-wks/directdisk-gpt.wks            | 0
 {scripts/lib => src}/wic/canned-wks/directdisk-multi-rootfs.wks   | 0
 {scripts/lib => src}/wic/canned-wks/directdisk.wks                | 0
 {scripts/lib => src}/wic/canned-wks/efi-bootdisk.wks.in           | 0
 {scripts/lib => src}/wic/canned-wks/efi-uki-bootdisk.wks.in       | 0
 {scripts/lib => src}/wic/canned-wks/mkefidisk.wks                 | 0
 {scripts/lib => src}/wic/canned-wks/mkhybridiso.wks               | 0
 {scripts/lib => src}/wic/canned-wks/qemuloongarch.wks             | 0
 {scripts/lib => src}/wic/canned-wks/qemuriscv.wks                 | 0
 {scripts/lib => src}/wic/canned-wks/qemux86-directdisk.wks        | 0
 {scripts/lib => src}/wic/canned-wks/sdimage-bootpart.wks          | 0
 {scripts/lib => src}/wic/canned-wks/systemd-bootdisk.wks          | 0
 scripts/wic => src/wic/cli.py                                     | 0
 {scripts/lib => src}/wic/engine.py                                | 0
 {scripts/lib => src}/wic/filemap.py                               | 0
 {scripts/lib => src}/wic/help.py                                  | 0
 {scripts/lib => src}/wic/ksparser.py                              | 0
 {scripts/lib => src}/wic/misc.py                                  | 0
 {scripts/lib => src}/wic/partition.py                             | 0
 {scripts/lib => src}/wic/pluginbase.py                            | 0
 {scripts/lib => src}/wic/plugins/imager/direct.py                 | 0
 {scripts/lib => src}/wic/plugins/source/bootimg_biosplusefi.py    | 0
 {scripts/lib => src}/wic/plugins/source/bootimg_efi.py            | 0
 {scripts/lib => src}/wic/plugins/source/bootimg_partition.py      | 0
 {scripts/lib => src}/wic/plugins/source/bootimg_pcbios.py         | 0
 {scripts/lib => src}/wic/plugins/source/empty.py                  | 0
 {scripts/lib => src}/wic/plugins/source/extra_partition.py        | 0
 {scripts/lib => src}/wic/plugins/source/isoimage_isohybrid.py     | 0
 {scripts/lib => src}/wic/plugins/source/rawcopy.py                | 0
 {scripts/lib => src}/wic/plugins/source/rootfs.py                 | 0
 34 files changed, 0 insertions(+), 0 deletions(-)
 rename {scripts/lib => src}/wic/__init__.py (100%)
 rename {scripts/lib => src}/wic/canned-wks/common.wks.inc (100%)
 rename {scripts/lib => src}/wic/canned-wks/directdisk-bootloader-config.cfg (100%)
 rename {scripts/lib => src}/wic/canned-wks/directdisk-bootloader-config.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/directdisk-gpt.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/directdisk-multi-rootfs.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/directdisk.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/efi-bootdisk.wks.in (100%)
 rename {scripts/lib => src}/wic/canned-wks/efi-uki-bootdisk.wks.in (100%)
 rename {scripts/lib => src}/wic/canned-wks/mkefidisk.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/mkhybridiso.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/qemuloongarch.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/qemuriscv.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/qemux86-directdisk.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/sdimage-bootpart.wks (100%)
 rename {scripts/lib => src}/wic/canned-wks/systemd-bootdisk.wks (100%)
 rename scripts/wic => src/wic/cli.py (100%)
 rename {scripts/lib => src}/wic/engine.py (100%)
 rename {scripts/lib => src}/wic/filemap.py (100%)
 rename {scripts/lib => src}/wic/help.py (100%)
 rename {scripts/lib => src}/wic/ksparser.py (100%)
 rename {scripts/lib => src}/wic/misc.py (100%)
 rename {scripts/lib => src}/wic/partition.py (100%)
 rename {scripts/lib => src}/wic/pluginbase.py (100%)
 rename {scripts/lib => src}/wic/plugins/imager/direct.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_biosplusefi.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_efi.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_partition.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_pcbios.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/empty.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/extra_partition.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/isoimage_isohybrid.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/rawcopy.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/rootfs.py (100%)

diff --git a/scripts/lib/wic/__init__.py b/src/wic/__init__.py
similarity index 100%
rename from scripts/lib/wic/__init__.py
rename to src/wic/__init__.py
diff --git a/scripts/lib/wic/canned-wks/common.wks.inc b/src/wic/canned-wks/common.wks.inc
similarity index 100%
rename from scripts/lib/wic/canned-wks/common.wks.inc
rename to src/wic/canned-wks/common.wks.inc
diff --git a/scripts/lib/wic/canned-wks/directdisk-bootloader-config.cfg b/src/wic/canned-wks/directdisk-bootloader-config.cfg
similarity index 100%
rename from scripts/lib/wic/canned-wks/directdisk-bootloader-config.cfg
rename to src/wic/canned-wks/directdisk-bootloader-config.cfg
diff --git a/scripts/lib/wic/canned-wks/directdisk-bootloader-config.wks b/src/wic/canned-wks/directdisk-bootloader-config.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/directdisk-bootloader-config.wks
rename to src/wic/canned-wks/directdisk-bootloader-config.wks
diff --git a/scripts/lib/wic/canned-wks/directdisk-gpt.wks b/src/wic/canned-wks/directdisk-gpt.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/directdisk-gpt.wks
rename to src/wic/canned-wks/directdisk-gpt.wks
diff --git a/scripts/lib/wic/canned-wks/directdisk-multi-rootfs.wks b/src/wic/canned-wks/directdisk-multi-rootfs.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/directdisk-multi-rootfs.wks
rename to src/wic/canned-wks/directdisk-multi-rootfs.wks
diff --git a/scripts/lib/wic/canned-wks/directdisk.wks b/src/wic/canned-wks/directdisk.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/directdisk.wks
rename to src/wic/canned-wks/directdisk.wks
diff --git a/scripts/lib/wic/canned-wks/efi-bootdisk.wks.in b/src/wic/canned-wks/efi-bootdisk.wks.in
similarity index 100%
rename from scripts/lib/wic/canned-wks/efi-bootdisk.wks.in
rename to src/wic/canned-wks/efi-bootdisk.wks.in
diff --git a/scripts/lib/wic/canned-wks/efi-uki-bootdisk.wks.in b/src/wic/canned-wks/efi-uki-bootdisk.wks.in
similarity index 100%
rename from scripts/lib/wic/canned-wks/efi-uki-bootdisk.wks.in
rename to src/wic/canned-wks/efi-uki-bootdisk.wks.in
diff --git a/scripts/lib/wic/canned-wks/mkefidisk.wks b/src/wic/canned-wks/mkefidisk.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/mkefidisk.wks
rename to src/wic/canned-wks/mkefidisk.wks
diff --git a/scripts/lib/wic/canned-wks/mkhybridiso.wks b/src/wic/canned-wks/mkhybridiso.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/mkhybridiso.wks
rename to src/wic/canned-wks/mkhybridiso.wks
diff --git a/scripts/lib/wic/canned-wks/qemuloongarch.wks b/src/wic/canned-wks/qemuloongarch.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/qemuloongarch.wks
rename to src/wic/canned-wks/qemuloongarch.wks
diff --git a/scripts/lib/wic/canned-wks/qemuriscv.wks b/src/wic/canned-wks/qemuriscv.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/qemuriscv.wks
rename to src/wic/canned-wks/qemuriscv.wks
diff --git a/scripts/lib/wic/canned-wks/qemux86-directdisk.wks b/src/wic/canned-wks/qemux86-directdisk.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/qemux86-directdisk.wks
rename to src/wic/canned-wks/qemux86-directdisk.wks
diff --git a/scripts/lib/wic/canned-wks/sdimage-bootpart.wks b/src/wic/canned-wks/sdimage-bootpart.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/sdimage-bootpart.wks
rename to src/wic/canned-wks/sdimage-bootpart.wks
diff --git a/scripts/lib/wic/canned-wks/systemd-bootdisk.wks b/src/wic/canned-wks/systemd-bootdisk.wks
similarity index 100%
rename from scripts/lib/wic/canned-wks/systemd-bootdisk.wks
rename to src/wic/canned-wks/systemd-bootdisk.wks
diff --git a/scripts/wic b/src/wic/cli.py
similarity index 100%
rename from scripts/wic
rename to src/wic/cli.py
diff --git a/scripts/lib/wic/engine.py b/src/wic/engine.py
similarity index 100%
rename from scripts/lib/wic/engine.py
rename to src/wic/engine.py
diff --git a/scripts/lib/wic/filemap.py b/src/wic/filemap.py
similarity index 100%
rename from scripts/lib/wic/filemap.py
rename to src/wic/filemap.py
diff --git a/scripts/lib/wic/help.py b/src/wic/help.py
similarity index 100%
rename from scripts/lib/wic/help.py
rename to src/wic/help.py
diff --git a/scripts/lib/wic/ksparser.py b/src/wic/ksparser.py
similarity index 100%
rename from scripts/lib/wic/ksparser.py
rename to src/wic/ksparser.py
diff --git a/scripts/lib/wic/misc.py b/src/wic/misc.py
similarity index 100%
rename from scripts/lib/wic/misc.py
rename to src/wic/misc.py
diff --git a/scripts/lib/wic/partition.py b/src/wic/partition.py
similarity index 100%
rename from scripts/lib/wic/partition.py
rename to src/wic/partition.py
diff --git a/scripts/lib/wic/pluginbase.py b/src/wic/pluginbase.py
similarity index 100%
rename from scripts/lib/wic/pluginbase.py
rename to src/wic/pluginbase.py
diff --git a/scripts/lib/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
similarity index 100%
rename from scripts/lib/wic/plugins/imager/direct.py
rename to src/wic/plugins/imager/direct.py
diff --git a/scripts/lib/wic/plugins/source/bootimg_biosplusefi.py b/src/wic/plugins/source/bootimg_biosplusefi.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/bootimg_biosplusefi.py
rename to src/wic/plugins/source/bootimg_biosplusefi.py
diff --git a/scripts/lib/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/bootimg_efi.py
rename to src/wic/plugins/source/bootimg_efi.py
diff --git a/scripts/lib/wic/plugins/source/bootimg_partition.py b/src/wic/plugins/source/bootimg_partition.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/bootimg_partition.py
rename to src/wic/plugins/source/bootimg_partition.py
diff --git a/scripts/lib/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/bootimg_pcbios.py
rename to src/wic/plugins/source/bootimg_pcbios.py
diff --git a/scripts/lib/wic/plugins/source/empty.py b/src/wic/plugins/source/empty.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/empty.py
rename to src/wic/plugins/source/empty.py
diff --git a/scripts/lib/wic/plugins/source/extra_partition.py b/src/wic/plugins/source/extra_partition.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/extra_partition.py
rename to src/wic/plugins/source/extra_partition.py
diff --git a/scripts/lib/wic/plugins/source/isoimage_isohybrid.py b/src/wic/plugins/source/isoimage_isohybrid.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/isoimage_isohybrid.py
rename to src/wic/plugins/source/isoimage_isohybrid.py
diff --git a/scripts/lib/wic/plugins/source/rawcopy.py b/src/wic/plugins/source/rawcopy.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/rawcopy.py
rename to src/wic/plugins/source/rawcopy.py
diff --git a/scripts/lib/wic/plugins/source/rootfs.py b/src/wic/plugins/source/rootfs.py
similarity index 100%
rename from scripts/lib/wic/plugins/source/rootfs.py
rename to src/wic/plugins/source/rootfs.py
-- 
2.51.0


