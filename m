Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1515.1794712730392159578
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 19:18:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=jRXNpg4t;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1225116b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 19:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794712729; x=1795317529; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUpVLrgI6bfjLOcCN4NATVqbIqXRUHv1+8M40dVX0c8=;
        b=jRXNpg4tuONKutnoVbN12ONRuwA1B7PPz8F4l/nOQr9Hi9ag1B2GLCtqgQJczRJwAb
         yqlqDSU0M45PbHZc/PwCYZYdmGjn3Ond7HIlIvohtua71KtzBx4BKCuguQp876o04fTg
         dAv0OZ6z2vm5jCkBZHXJIvszGipXzO6ojmN9q+RCT/IKik2x/jvmLLXXBS3zH30K42Uf
         nm0wQitEgdgPcNgIxZ9THYAjlr3XFnGG2UScyHxsrRTmzAwD/uHMtV4klllCu7Wu4vP9
         6X9Z12uP0KtFZtqvmnxBg4m4xXyeS7JBgmYCGjEw08Uwv3hLUGcXwBYapzNmaoVREuZU
         mitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794712729; x=1795317529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUpVLrgI6bfjLOcCN4NATVqbIqXRUHv1+8M40dVX0c8=;
        b=2Wm7HcxwS0OOUFAC+dEBinO32WrKWlcKHQK0Nt22CQToOaHtvpGiarMKEzRuYV1uin
         SbRZRZViYR6/ewNauORdJji09MCoPV9Mlz1LWXMtMabi9TPFbH8KyXWo0+CEJ/oPDcgF
         HyTTeLy4RjWjY4zPrF919faSP5PfhvT0q0a3xlmpVlmLvI4J/lc1ae3//xTescbWfUdb
         tS1/Z+W+5qz2R3dVBfKSeWUN4kqgZ5EojTuEXIR0GJ2YPxNkNRR+ZKAVe8FOK8ank9TH
         nT5y5XPEAzwdzbUWlHUzg1zLXohS135kg0AzJ28xlVQakym2/OOVpJLuPMthlKGOgKk0
         NXxw==
X-Gm-Message-State: APuU4Z9756r55Au4NFBQXF3V8BYtbeTU+KPoFnvyxYcPpF+cm7DQpIz+
	u7Ew0baLrAK57K1HvtR3esMS/ympot9p3UQmclN6VXc2lQ7JhURb0XCV5YNfGQ==
X-Gm-Gg: AYBFou3mBnKbNts4Kbf2OWXwezlwm5Y+T95RcJtYFdYpvyiA9fIlDxlOe/0IrsPhKco
	bTAqejmSpDZ1fSNyQc3RGU6vbqlf2VDv7kjebTJalVOFTv3Am+UK6PFioIWvF3iQweTf19P9HjW
	fluJfiGk/yspyHHGysmjvQ7upQeFgY1rKnu0G+ZBd2u8t1ytqcG0mv1Dd+owIyx8he2o6hK9HHo
	nx049nIQFfQ9iO46t5g9UNxFY8z/3vixqZKAGEMwAxsN4oftEqyKaHt1yRvihdFGZl9X2uDeZeo
	LPENbMz+NQz8+qIiMTs7TxtZpUTA4zi+OV8mGJ1TaQR1+jzidrBI5svjCpO9xJyWiED11z2QaWt
	H4xPn2VpoBfWvW7My+xfnh93HUnvIfDIhx49i71l955BrfstGHnSflk+15FhNt47HDuIprwAGkt
	BbW7snTipjS8OaVMfQYKwwFCBpRGtAlsvEKSi3YHTfG9tF0G+398I3pt2flYO+HcMFWFoMTRxDW
	fkila7gJv9papXZ2WEu5F9u2pqlW7Husu9w4FFZHa/YCCCEFNqi3CP9kRFsq70waZPJ0s2lGmgy
	TZKFAKNtAwJvovsABVCnayx1lZfGG2ExSpyFIVom12N6zSfXD4p7gmZ8UYa/4A==
X-Received: by 2002:a05:6a21:e109:b0:3e2:97ac:274e with SMTP id adf61e73a8af0-3f7a9cff089mr6745434637.65.1794712729411;
        Sat, 14 Nov 2026 19:18:49 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1898afbsm2761560a12.19.2026.11.14.19.18.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 19:18:47 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/2] rrs_distros: match python3-* recipes to distro packages
Date: Sat, 14 Nov 2026 19:18:02 -0800
Message-ID: <20261115031803.74076-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 03:19:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5388
Content-Type: text/plain; charset="utf-8"

Almost no python3-* recipe was matched to a distro package: OE names
Python modules python3-<name>, Fedora and openSUSE name the source
package python-<name>, and Debian and Ubuntu name the binary package
python3-<name>. On a test instance, 7 meta-python recipes matched.

1: Fix the suffix stripping in search_package_in_distros(), which
   discarded the result of str.replace().
2: Also look for python-<name>, and record the name that matched. Debian
   and Ubuntu's python3-<name> binary packages are matched once OE-Core's
   distro_check lists them, which is sent separately to openembedded-core
   (bug 16512).

With both, on the test instance, 574 of meta-python's 727 recipes on
master matched at least one distro (7 before), and recipe-to-distro
matches went from 4177 to 6045, with no false matches seen in a sample
(e.g. python3-lz4 matches python-lz4, not the lz4 C library). The test
suite passes in the Docker image.

This applies on top of the series "Get the RRS update scripts working
again" (patchwork 104071-104076), which also changes rrs_distros.py:
https://lore.kernel.org/all/20261115003506.53654-1-tim.orling@konsulko.com/

Tim Orling (2):
  rrs_distros: strip the native/cross suffixes before matching distro
    packages
  rrs_distros: match python3-* recipes to distro packages

 rrs/tools/rrs_distros.py  | 15 +++++++----
 tests/test_rrs_distros.py | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 5 deletions(-)
 create mode 100644 tests/test_rrs_distros.py

-- 
2.56.1

