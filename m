Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F5F428F0
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:53 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4572.1776284385901184235
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lwC9Q0Wu;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so729680785a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284385; x=1776889185; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbNg0YEJzpoFJrZYu1R22nOLEasT4gDRuhz5XbstCT0=;
        b=lwC9Q0WunpvgsI9VEw4I0cGOesCxHQH4UO3nO4lC6NxDMSycL516TsoU70qDSSHdv0
         GWQ8cDHKPE4vCeTO7eMClyjPH9BnhPvPw1Wx+6nfLX39+15B2ns78Z+h/ZR/KOUui0X5
         sCkaGFj/2c+LgjfcGXnQfkOdT2tuyf63frdTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284385; x=1776889185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbNg0YEJzpoFJrZYu1R22nOLEasT4gDRuhz5XbstCT0=;
        b=PnoIBTuhnJi1DEsDnyuUiV8KRY68j7q5oUGkkZGiOFlfJxSJ7jXhAtcVp1OACiOrEr
         tlpAv9vL6eUDQvAguHK2cYP7uTfkLeR3C2x/3hLHzhaCY6XOlE0EH6Z+QBY9ZP7KvV1H
         dm7sshKb2kGSLAdn/RpAjr9i4ZjfWyhnkZXKzWHg6Ke0iyQL1PMrHq7HkPahadxk3hDD
         uLzGFjT4sq4Jz8WuYYu00U02RI09Ub5WfI/fnwEqLwAoBLfABPfa7ofsYj/i3BNknK6B
         4gVm6kFJ02xsnK0jG3r62uYW/VxtbftKJm6i1S2FGnTtnPB/D1wenGpvshaOwQhG3jwG
         LY+g==
X-Gm-Message-State: AOJu0YyVx17YZeAQXKKX7t7oXuwwW9MN4DYumoSQImeUDoPWXcC6mFh+
	NgSDQqMP0ptB/ReEYKuGelhtAVmId483JB2Ya0/F/h6avGKiLeneNSQJUsp9pCBRoV3/AEQ+gLm
	7wxEx
X-Gm-Gg: AeBDietZs2Uh0NbsjwULJjh8Vd2O5bPdhy9KRnNJI7GwhTbgEpW2wGC5JNkHXJXEfdp
	vZw2ze0Y+Z0dLo0EjhCy+dgCPbjENJjoHDA+ZnAB5DfHzLdZvyvZSWFNyH127N6Ya4xzZ+lzYWA
	GM/4hWkszYLPFz+l7DIYNYpyTnUbUo78E2EXXEJDh74pWDjI5khwG5yOPXxFv9DE7aKHNs1X4v1
	A0DgxoSqeXG34yrf6vyrapUl1VRTe23Em+FiQwY25GedHU4GWsAx4Dbev916nkiUiI0/iz700WP
	Ie39dBlhi1hNNEqiRrJPpbkj43HYlvwqOjCFheGlXHy+tXdGP2BPOMRQZgDFHUntHXGcsjzvtLO
	ntp+JsnIR2JpprsM/1WxEU7mF+VJWI6ovlNRRXhFEX0GoPW2gFBIUyNYR4mFwlNlVUdcD8k3yui
	ivWzhZSdiWucwVU11N40BLzzrOH0DoY6+8YQlsISOBp3x49Z2+Lt0H04VdUjS8u7NoCP5UVqw30
	TupCr40DwPxPSS505VvCg63klYUOOAlt3BF0tJhbbEflIlwu1X/KKuKUmy4/5bp
X-Received: by 2002:a05:620a:a1dc:10b0:8da:4c20:50f0 with SMTP id af79cd13be357-8e5db94c2d6mr131240485a.8.1776284384426;
        Wed, 15 Apr 2026 13:19:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/7] Assorted updates 04/15
Date: Wed, 15 Apr 2026 16:19:20 -0400
Message-ID: <cover.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3708

This patch series rolls up the contributed patches from the past few
weeks, barring the suricata 8.04 update that will need some rework for
Lua 5.5.  These changes are queued on the master-next branch if you
would like to check them out to test yourself.  I intend to merge these
to master branch at end of day tomorrow (Eastern Time, April 16) unless
there are objections.

Note that there are the following known issues atm:
* parsec-service currently fails to build with an error in the
  cryptoki crate.  This was likely triggered by the upgrade to
  Rust 1.94.x in oe-core.
* Including python3-privacyidea in an image results in packaging
  conflicts between python3-cryptography and python3-pyrad that
  need to be addressed in those recipes in oe-core/meta-python.

I hope to get these addressed in the next week or so.

Scott


Changes:

Haiqing Bai (1):
  isic: fix RDEPNEDS typo

Khem Raj (1):
  wic: wic need to be moved to files/wic within the layer to be
    found/used

Peter Marko (2):
  libtpms: fix build with glibc 2.43
  tpm2-pkcs11: fix build failure

Yi Zhao (2):
  scap-security-guide: upgrade 0.1.78 -> 0.1.80
  openscap: upgrade 1.4.2 -> 1.4.3

Zhang Peng (1):
  meta-security: fix incorrect HOMEPAGE variable names

 .../wic}/beaglebone-yocto-verity.wks.in       |  0
 .../systemd-bootdisk-dmverity-hash.wks.in     |  0
 .../wic}/systemd-bootdisk-dmverity.wks.in     |  0
 ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
 ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++
 .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
 recipes-compliance/lynis/lynis_3.1.6.bb       |  2 +-
 .../{openscap_1.4.2.bb => openscap_1.4.3.bb}  |  4 +--
 ....1.78.bb => scap-security-guide_0.1.80.bb} |  4 +--
 recipes-scanners/arpwatch/arpwatch_3.3.bb     |  2 +-
 recipes-security/glome/glome_git.bb           |  2 +-
 .../google-authenticator-libpam_1.09.bb       |  2 +-
 recipes-security/isic/isic_0.07.bb            |  2 +-
 14 files changed, 75 insertions(+), 10 deletions(-)
 rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
 create mode 100644 meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
 rename recipes-compliance/openscap/{openscap_1.4.2.bb => openscap_1.4.3.bb} (96%)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} (93%)

-- 
2.53.0


