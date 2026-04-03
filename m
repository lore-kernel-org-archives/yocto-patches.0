Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF452E8539A
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2220.1775241417219055863
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pVQXHyOS;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfdac74050so279791585a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241416; x=1775846216; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORAWKUD0FhABRfEYoRLJJ5azED7599/PTzzA/IN/ZgE=;
        b=pVQXHyOSgWYPVfrag9PUaQA4K/OHoSUcbS1iwxmIs/fKQOpl8IQCgTkR2sIneG5+4j
         /Pnk2kGoO3enFaEnzyup95hsmtgpd3uQvLEBh7HRKZj+mBKO9N4wnbSFTs9XoArxjdxx
         UaQcvQITNJUyRIHhngmADOkIFAGN7lk4cY+Efs6ew+pXk37/6zN9tL4y0igbG803LOCN
         0SgBCiYUCbVAq22pM9K0tAECJ2vWxarOeBActfeZnXtU1hGjxzBQp/3mLuFXMnh2MucR
         ed6dYwQkhf7+GgnoWGO4AOGhVN9AFfTN1wvXf708PxEWX3XwTGArkuIQxiaV8hdQB64r
         qUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241416; x=1775846216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORAWKUD0FhABRfEYoRLJJ5azED7599/PTzzA/IN/ZgE=;
        b=tYc8yLWDnVj5a/HrqzYCBIQtYt4OYbfoyHPm1kb1FjMOVqxWhwc5OUYH7is+HXEL6T
         bTYdVJ2YVc4m265ftjcX16nzsWRsD4kS2M2v2QQgBNY12+qlllmieoG/Vfyrs9ye+FRY
         Y/CUg6JgpsCD+ieaduFRfPNumNVlUT4/B0eckzZ+731mWer+xl5wPbYedNSu7+DWArol
         ApGtIQoFM05SOeQkLzP1DdB06g5IJgYlYfgj0yROOtFK5hLg/phWztNGkizh2dhNh0D7
         dLL6+cf2C3Kb3xjuo27ioSJyzlL4DqHny+9Afti6tnQ7FXnm7+T8xlbtBtxSVWY6wjh9
         vcJg==
X-Gm-Message-State: AOJu0YyVOdEMwtzd/rQCdIZkgsh1MQx6Fj6+BK0P0+Gch74hJZ4iBHpa
	NV/6rYtCZDUReif5X09rxBxQOVya3soAPHdRpgT/pMduYxMVbBq1byMek5I3dvNf
X-Gm-Gg: ATEYQzwh9iQSkYlhsMjLzEgcFk3saNAQc3L7rZzRf2DiwN2Bed1UiKeRUYSkoKYWGmG
	lEgxifcSlEjNSSn2lV1wi1bUZML0OphX1MpiSN0siD+FLv54PuvVwImPJWcRSrgGQ6C4woypbUM
	akVt5N/JSaf4TEXstRcNrCfJey5GlzuTijTnF7lR7tAMgBvV9LAhEVtwPWY2zQglRZlLg0L4C0a
	GiVvi8tspPGX3jztKdx81x+ftMujSS+LmvwOgquIVCarOnRI0gtCXTIWk0BjuYEy/gJZApsffgd
	lI95pbn/v5vfpzQpNhM/1XJlVn1uf2BLOrBl4+eL3fbnBU4drgdtjoMYhHKvXPUdWgwnNjG0GvS
	ZeuChqyUZcD2E7C/QkHWZFT6gbLfeqWgjJMOTgggRvdpk7VCzcPlvEKuCTVcPhQLGJBVJAMoJPh
	IGUTvLbmZO14iMMm9bW80RvwGmXWSCeVrk7SBrob9MynQr0Bwb7fi0mCzpNoGBOzp0hA==
X-Received: by 2002:a05:620a:2a04:b0:8cd:923a:8798 with SMTP id af79cd13be357-8d41c5a6a6amr551228485a.20.1775241415544;
        Fri, 03 Apr 2026 11:36:55 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.36.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:36:54 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 0/9] standalone wic repository
Date: Fri,  3 Apr 2026 14:36:35 -0400
Message-ID: <20260403183644.2783267-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3626

This patchset is meant to be applied to the wic codebase immediately
after wic is split out from the OpenEmbedded-Core codebase. Afterwards
this project was turned into a hatch-based Python project commit by
commit, demonstrating that the starting point for this code was an
unmodifed wic from oe-core, and showing how it was transformed.

The starting point for this repository involved using git-filter-repo to
move the wic source into its own repository without any modifications:
    $ git-filter-repo --force --path scripts/wic --path scripts/lib/wic/

Trevor Woerner (9):
  re-organize for python src layout packaging
  move example *wks files
  create python hatch project
  add oe-core and bitbake helper packages
  bump version: 0.2.0 -> 0.3.0
  cli.py: remove bitbake coupling
  plugins/source/bootimg_biosplusefi.py: add import os
  ksparser.py: search for *inc files
  cli.py: fix main() for standalone mode

 .gitignore                                    |   1 +
 LICENSE                                       | 288 ++++++++++++++
 README.md                                     |  51 +++
 .../canned-wks => example-wks}/common.wks.inc |   0
 .../directdisk-bootloader-config.cfg          |   0
 .../directdisk-bootloader-config.wks          |   0
 .../directdisk-gpt.wks                        |   0
 .../directdisk-multi-rootfs.wks               |   0
 .../canned-wks => example-wks}/directdisk.wks |   0
 .../efi-bootdisk.wks.in                       |   0
 .../efi-uki-bootdisk.wks.in                   |   0
 .../canned-wks => example-wks}/mkefidisk.wks  |   0
 .../mkhybridiso.wks                           |   0
 .../qemuloongarch.wks                         |   0
 .../canned-wks => example-wks}/qemuriscv.wks  |   0
 .../qemux86-directdisk.wks                    |   0
 .../sdimage-bootpart.wks                      |   0
 .../systemd-bootdisk.wks                      |   0
 pyproject.toml                                |  38 ++
 src/bb/__init__.py                            |  14 +
 src/bb/utils.py                               |  23 ++
 src/oe/__init__.py                            |   1 +
 src/oe/bootfiles.py                           |  58 +++
 src/oe/path.py                                | 351 ++++++++++++++++++
 {scripts/lib => src}/wic/__init__.py          |   0
 scripts/wic => src/wic/cli.py                 |  14 +-
 {scripts/lib => src}/wic/engine.py            |   0
 {scripts/lib => src}/wic/filemap.py           |   0
 {scripts/lib => src}/wic/help.py              |   0
 {scripts/lib => src}/wic/ksparser.py          |  18 +-
 {scripts/lib => src}/wic/misc.py              |   0
 {scripts/lib => src}/wic/partition.py         |   0
 {scripts/lib => src}/wic/pluginbase.py        |   0
 .../lib => src}/wic/plugins/imager/direct.py  |   0
 .../wic/plugins/source/bootimg_biosplusefi.py |   1 +
 .../wic/plugins/source/bootimg_efi.py         |   0
 .../wic/plugins/source/bootimg_partition.py   |   0
 .../wic/plugins/source/bootimg_pcbios.py      |   0
 .../lib => src}/wic/plugins/source/empty.py   |   0
 .../wic/plugins/source/extra_partition.py     |   0
 .../wic/plugins/source/isoimage_isohybrid.py  |   0
 .../lib => src}/wic/plugins/source/rawcopy.py |   0
 .../lib => src}/wic/plugins/source/rootfs.py  |   0
 43 files changed, 847 insertions(+), 11 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 LICENSE
 create mode 100644 README.md
 rename {scripts/lib/wic/canned-wks => example-wks}/common.wks.inc (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/directdisk-bootloader-config.cfg (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/directdisk-bootloader-config.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/directdisk-gpt.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/directdisk-multi-rootfs.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/directdisk.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/efi-bootdisk.wks.in (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/efi-uki-bootdisk.wks.in (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/mkefidisk.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/mkhybridiso.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/qemuloongarch.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/qemuriscv.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/qemux86-directdisk.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/sdimage-bootpart.wks (100%)
 rename {scripts/lib/wic/canned-wks => example-wks}/systemd-bootdisk.wks (100%)
 create mode 100644 pyproject.toml
 create mode 100644 src/bb/__init__.py
 create mode 100644 src/bb/utils.py
 create mode 100644 src/oe/__init__.py
 create mode 100644 src/oe/bootfiles.py
 create mode 100644 src/oe/path.py
 rename {scripts/lib => src}/wic/__init__.py (100%)
 rename scripts/wic => src/wic/cli.py (99%)
 rename {scripts/lib => src}/wic/engine.py (100%)
 rename {scripts/lib => src}/wic/filemap.py (100%)
 rename {scripts/lib => src}/wic/help.py (100%)
 rename {scripts/lib => src}/wic/ksparser.py (95%)
 rename {scripts/lib => src}/wic/misc.py (100%)
 rename {scripts/lib => src}/wic/partition.py (100%)
 rename {scripts/lib => src}/wic/pluginbase.py (100%)
 rename {scripts/lib => src}/wic/plugins/imager/direct.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_biosplusefi.py (99%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_efi.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_partition.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/bootimg_pcbios.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/empty.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/extra_partition.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/isoimage_isohybrid.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/rawcopy.py (100%)
 rename {scripts/lib => src}/wic/plugins/source/rootfs.py (100%)

-- 
2.51.0


