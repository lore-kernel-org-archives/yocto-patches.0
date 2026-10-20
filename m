Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2005.1792529855914518443
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 13:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VEeY/THH;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so96655a91.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529855; x=1793134655; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBHwcwiyh/SN/ydADcbJ/WkMMQnGR2B81v4C0sugE7k=;
        b=VEeY/THHRBO+QVTUQqZw6y01aXrGJdd4anYHnZ30akgaFLyladQGZLbek95yw+j4kn
         irsf3wBxexMXlHcSOvJhpeo1IqUBbiw3TyO+UdynxfOwo2qbx/7o0Yx04uJH+f4MaXoJ
         Mvnr7CtXj5MMH4RibcL2uEtRyMIOSPwNtM4KlMaRTjwYyOsVS4jKa96JQkHU3MYfzscO
         VoG+U1ImAvQg6VBdTjma/go0BWD4Zq5Scht8hAAyBgbN7JZBD/lpPGbz+9d6GSzuBmSw
         z9AaNybcA2I/y8CbXGD44GXY3C0x5ZVZqSCOlrKJ+SiNW1saAASjSsTtpoThJx8J95fS
         dVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529855; x=1793134655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBHwcwiyh/SN/ydADcbJ/WkMMQnGR2B81v4C0sugE7k=;
        b=pSikiGcygrsOw6wu1UCBbV92pLMVsaHQg6bI/2PiLGxWVL5hIdLGtOic/W5sc8GYAq
         nwrjraJgpUYRDMCkduLsheIFWJ0q9kolqVtJP7Z3cP7ySkYYsySIGccrfAuk0kJS+4d6
         xsZmtCGhTzMIK/3Tkv6wqjE50ZDITlUDS/NSFqrHRkBzIkMM82ofZegD5NMgiUj4T2Nv
         vqwL+5bHn7TfxfY3OsTFpCvGDzBmIV4A0HFAjk7bfklBp5Z/+tKw2ZelSgBMK6g3/Hbb
         2i79Z5gANMkdXH4YXf3ryqZ1WettJIEKnc4RiB65cPp9S2P1p8/syr+veTiZhCiggigj
         POJA==
X-Gm-Message-State: AFq9FYKiv5KFhWbtMei1rDueYj9t7cKQmA9uwcQVU3O0XWb5I0vlpSmi
	xGdrjkXZ3s1kjBO8n8dbYuQSuYeoaEJglxl03+XmZ+g7hLJ+NuG1Qyi2qPKcf1Vc
X-Gm-Gg: AYBFou3K0k4yaPgppfbHNUDnScDjYr5tDjz7wtdEr//SSOR/fmc3HVy2/he3PVl0+47
	tbNUJIpKWB+q0J7PXvOcQ2mIbaHjDLdKJCmAvGo2y6FkkraLwpd0znASFIlBxswxvgaQEaBnQKr
	Y7fW2Vl0lNEejWia0YpRfLPLSCnQxgDR1AhtJZ46GKtaaeiQO/csrS0BHGj01B4iWQY7iKlxJcz
	4jbWWM7n5nrdoLrBTOGyEpKGnDXEDcEPdCCgSuGiiH5uoMAo+xrRWwTMGHoXK/dlHUoGyVsmcTP
	9LQic/kcfyhsDMfIYKFEFD0Bh21uMcQJl8UiWqcoRmZ2SNNg/dOGIIK9xXynyRium1IibGTOaJz
	ykT+bez6wmyhjrPB9DLhnu5CPIkdKhCGRF8S8dsfcrQQ2tone5bfCKf/Oc7+F5hrv8KxExO9ZJX
	lzf4yS+7maTWnqw4mhUseeCX0bWK0dS+WO/gHepqP3ax+nkCbEpmKvsYFpUzpck5hqwCHa09zTY
	SlGVszlSCA41oJqjoLNDxK/qUEAbJzOcXlWHYPFkvVMm6uZEwwn34KHQYUjAcLoRbpz9g+lHPvt
	l9jUShV3kSaDCjVd7IedPu0TAuIpsRjeDQ==
X-Received: by 2002:a17:90b:4cc1:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3ad86dddbbfmr105802a91.9.1792529855118;
        Tue, 20 Oct 2026 13:57:35 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8029765fsm1039115a91.10.2026.10.20.13.57.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 13:57:34 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Security fixes: XSS, bulk change access checks, error disclosure
Date: Tue, 20 Oct 2026 13:57:26 -0700
Message-ID: <20261020205730.53370-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 20:57:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5113
Content-Type: text/plain; charset="utf-8"

These fix security problems found with GitHub CodeQL and manual review.
They were held back until layers.openembedded.org had been updated.

1: Reflected XSS in the recipe CSV export: an invalid "fields" value was
   echoed back as text/html.
2: The bulk change edit, review and patch views had no login or owner
   check, so anyone could view or edit another user's bulk change.
3: Patch generation errors (tracebacks, server paths, BitBake output)
   were returned to the browser.
4: A test for the existing protection that an email change on the
   profile page needs reactivation through the new address.

Tim Orling (4):
  layerindex/views: fix reflected XSS in recipes CSV export
  layerindex: restrict bulk changes to their owner
  layerindex/views: don't expose patch generation errors to users
  tests: check that changing the profile email requires reactivation

 layerindex/urls.py              | 10 ++---
 layerindex/views.py             | 39 ++++++++++++++-----
 tests/test_bulkchange_access.py | 64 +++++++++++++++++++++++++++++++
 tests/test_profile_email.py     | 67 +++++++++++++++++++++++++++++++++
 tests/test_recipes_csv.py       | 33 ++++++++++++++++
 5 files changed, 198 insertions(+), 15 deletions(-)
 create mode 100644 tests/test_bulkchange_access.py
 create mode 100644 tests/test_profile_email.py
 create mode 100644 tests/test_recipes_csv.py


base-commit: 5b55c485d56be9a7314b329ca5d2466a72e7ac48
-- 
2.56.0

