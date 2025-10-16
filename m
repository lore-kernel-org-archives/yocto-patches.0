Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CD9CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:35 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.1658.1760649753425697291
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=K2fzNBqY;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88e51cf965dso248130985a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649752; x=1761254552; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8dwE+FeRSNv/hnPaZZz61DHocoI4Jaosqdzou4Hr8U=;
        b=K2fzNBqY4hKMLPoQvnuqTrGnFu4qPnbxABWcMgjyUqAzTunK6FTjvvaHeo/RXBLQwN
         fTJ2vVMiHQO26tLaf+9ko5My9gzQRNBb/4CEnzgn144H00tHz15T1j0AdfsJ4ZW/r2Hz
         kCnqcIKsKCLq/uS6VdbEfOT+J5v/PPkezefKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649752; x=1761254552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8dwE+FeRSNv/hnPaZZz61DHocoI4Jaosqdzou4Hr8U=;
        b=XzHX88V7X5qi9SF+V4d4KcTYbbgO/Pj3wyeJjf5CWCzlR4thj4eZA/lnWl1BZATPiG
         u/CFY0ng6KYRnx3pqipeaECvUfzANVy9r/VUDac11kMN7vInhCM6bZ1r79J832U3jBWY
         p+Db7tyhmihc/MteWKuB5ElbO+qmVoBdA9SBfh0lFdQyTCF+70Qzr3oH2NCk8GmneZ5S
         ZkR5eh5igwCbaGNjpvGLpd+IN6uf8LjM/bVcGzwBndHtCZ4fATkNNUgy1R4EOs2q5pf9
         qmHkUCfnITwHrI7xhl6OsZNtWl2jP/i+qokrUtdrR73/7Li93DJk7bxqAYRL76D4EtDx
         TawA==
X-Gm-Message-State: AOJu0YwKBCuedeTVcK144tL2hG7COFEy9KbL26lZ6ikoURTz+UP3t5sr
	XMVlwbPbYPUOreRM/ez7WmoUJuXz1esPGKqfdzrdpOB5uGSKQaiwliVPwu4vuE5egyOgNnJw1Ce
	NfwYQ
X-Gm-Gg: ASbGnctPdcy3BTSD/Bmc/SJNFKuUFgipSdJWxcVpAos8cuANg4uEAh+xHRbSPsXDJDR
	6xPXOEF1VcOqNUXD6IPVvhLxcwUBpr6vRT0sWKtI3E/FwvQvzmgo6e+QakBRCfLeHokHVrQjavM
	YNslgLBrdpmsG8TOWAouUag01CC9L/hjJKUccDh8JMJehsrv7tpV1VBDIo2wIDcR9EGHMUEbC5z
	3BvQ3GCx3MVqkhDxpYkfyqTcBAuZI+5448UyKzvIBIWE5RT1fq8tIuNS5yLRC/o75ykpPjC+Zvp
	hFE+1bTGcBRBhyhZtP3cP7zWQvaVJofCJuaK5SGqJcFBlQN8OIydpMLaWvmrESTw9xGMKLeDjeX
	BtP7RHO2OhyCmU5qCLSXSezTWit8MbnjkHaGiajH45PpTK6QnfSS92kHI4uJ4hC4PzuCSHaNzgd
	wsT+IijBXyF4L3N60bH3sVYGOPSrEkv4nkAeey41qmW4Pxg1MFG1OL
X-Google-Smtp-Source: AGHT+IHBkzhNQZwVPCRcs4sBVI/F1uNkF1zn8ip3eefPoPFD+zve5cICxhxuIEE5jrWV0yQcc32C1A==
X-Received: by 2002:a05:622a:352:b0:4b7:a680:42fc with SMTP id d75a77b69052e-4e89d3708bfmr19722631cf.45.1760649751860;
        Thu, 16 Oct 2025 14:22:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 00/15] Assorted fixes
Date: Thu, 16 Oct 2025 17:21:59 -0400
Message-ID: <cover.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2325

This patch series rolls up contributed patches from the past few weeks,
as well as some other fixes and cleanup.  I intend to merge these to
master branch at end of day Monday unless there are objections.

On top of the contributed patches, there are some build fixes from Marta
that have gotten us to a working state with CI, and some hopefully
non-controversial recipe removals from myself.  The recipes in question
have been disabled for at least two years, and there has been no obvious
interest in them in that period.  I have worked up a list of a few more
recipes that were not getting tested in the CI testing that are broken
atm, some of those may be next in line for removal if there's not a path
to a simple fix via an upgrade.

On another note, now that CI automation is working well, my thinking is
that going forward I may usually just post a list of commits queued on
master-next rather than these full patch series, as it's not clear the
duplication of contributed patches provides much value.  If you have a
strong desire to still see these explicit patch series instead, please
reply to indicate that.

Scott


Changes:

Clayton Casciato (2):
  suricata: populate SYSTEMD_SERVICE for service autostart
  suricata-update: add package to pull files

Marta Rybczynska (5):
  kas: use repo name
  lynis: move to GitHub fetching
  chipsec: update to 1.13.16
  chipsec: disable until 6.16 support is fixed
  test: allow root login for test images

Scott Murray (5):
  tripwire: Remove recipe
  libest: Remove recipe
  paxctl: Remove recipe
  packagegroup-core-security: update for recent changes
  meta-tpm: Small maintainers fix

Yi Zhao (3):
  python3-fail2ban: fix ptest failures
  python3-fail2ban: update to latest git rev
  libmhash: fix build with gcc 15

 .../include/maintainers-meta-security.inc     |    2 -
 docs/overview.txt                             |   27 -
 .../fail2ban/python3-fail2ban_git.bb          |   12 +-
 kas/kas-security-base.yml                     |    2 +-
 kas/qemux86-test.yml                          |    1 +
 lib/oeqa/runtime/cases/tripwire.py            |   47 -
 .../distro/include/maintainers-meta-tpm.inc   |    1 -
 recipes-compliance/lynis/lynis_3.1.5.bb       |    6 +-
 .../packagegroup-core-security.bb             |   20 +-
 .../suricata/python3-suricata-update_1.3.6.bb |   15 +
 recipes-ids/suricata/suricata_7.0.0.bb        |    1 +
 recipes-ids/tripwire/files/run-ptest          |    3 -
 recipes-ids/tripwire/files/tripwire.cron      |    8 -
 recipes-ids/tripwire/files/tripwire.sh        |    9 -
 recipes-ids/tripwire/files/tripwire.txt       |   69 -
 recipes-ids/tripwire/files/twcfg.txt          |   15 -
 recipes-ids/tripwire/files/twinstall.sh       |  320 -----
 recipes-ids/tripwire/files/twpol-yocto.txt    | 1107 -----------------
 recipes-ids/tripwire/tripwire_2.4.3.7.bb      |   75 --
 .../{chipsec_1.9.1.bb => chipsec_1.13.16.bb}  |    4 +-
 recipes-security/libest/libest_3.2.0.bb       |   28 -
 recipes-security/libmhash/libmhash_0.9.9.9.bb |    2 +
 ...ckage-error-if-DESTDIR-is-set-to-usr.patch |   26 -
 recipes-security/paxctl/paxctl_0.9.bb         |   40 -
 24 files changed, 47 insertions(+), 1793 deletions(-)
 delete mode 100644 lib/oeqa/runtime/cases/tripwire.py
 create mode 100644 recipes-ids/suricata/python3-suricata-update_1.3.6.bb
 delete mode 100644 recipes-ids/tripwire/files/run-ptest
 delete mode 100644 recipes-ids/tripwire/files/tripwire.cron
 delete mode 100644 recipes-ids/tripwire/files/tripwire.sh
 delete mode 100644 recipes-ids/tripwire/files/tripwire.txt
 delete mode 100644 recipes-ids/tripwire/files/twcfg.txt
 delete mode 100644 recipes-ids/tripwire/files/twinstall.sh
 delete mode 100644 recipes-ids/tripwire/files/twpol-yocto.txt
 delete mode 100644 recipes-ids/tripwire/tripwire_2.4.3.7.bb
 rename recipes-security/chipsec/{chipsec_1.9.1.bb => chipsec_1.13.16.bb} (90%)
 delete mode 100644 recipes-security/libest/libest_3.2.0.bb
 delete mode 100644 recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch
 delete mode 100644 recipes-security/paxctl/paxctl_0.9.bb

-- 
2.51.0


