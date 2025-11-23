Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DAFCFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4854.1763941518051995033
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rnmJTRbm;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2da83f721so421181685a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941517; x=1764546317; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLLltTlNYD/qaFQZrWaEhCOqo/SlpejFvc3qcoo/zXk=;
        b=rnmJTRbmuO9wN1VUGNwkBWTxhup4eYwuXSDz+qicAogcsSAzkUU+k6kmfAloNiZgwt
         yK3nWjmrPCgC6YROwN2bfawwocmoDtQ0quEH4m4pT09ANs2ZzC+JKu/e+6Eqb1YoG7js
         kq4aa99o3KRKKETwjyltA+aD+QyfeI3uXttOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941517; x=1764546317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLLltTlNYD/qaFQZrWaEhCOqo/SlpejFvc3qcoo/zXk=;
        b=w/VsGRe9BB9P1YSHrrYp6RokGVvDIOUIgyCtaq4KzP6yjYOu+XI5VJUlDRmzN8qtUm
         8qu7mFTic661sSHRklWfVmpdy/YnVAxVWQT0Z/+wPW1YYsusNpNKAm80Yi2ctz4clpmQ
         oBAWXlMecBpv/3CBV8mXB6VVqFf86uPLtb1ZxTtlSjQS/J7x84tWJrjllUL9oNrVNZC/
         yxoZD1vvVtQb4JONkvHDJ5qcbDdwEGwczgMMkjfyZXLyBGKLLb/QFoaF2VfCH/F8hoKR
         rMCA6fHH3Y6WsDRk6ZbPvFBX/ymqTSD5BdNUnSzYZP5ZXx4eYXGgw9x7p68rfZS54P9z
         SSpg==
X-Gm-Message-State: AOJu0YwUZ4J+iJe5FoiTg8mbByfVQojRvZTjB85mKT67gmZqw5rO4uJs
	g1FgCUTBnJfagkxAA3WjSd5tAPI3tRHO6coQWFgox0eGq2p3kfmOr6oGHYJlpFNS3Asm4rzaKHP
	x3xXa
X-Gm-Gg: ASbGncsZk0eqO7NfFb1YeFBd/D7EHlg3GhsmcTS/nt3jRimYhlU48pIvMrpJJjddq1u
	W+sClNyk6TJuLO/w5J/dpW9ogU1JEV8FZtCJxOOx6Q+Rt+Pk/RTcymNOjjJg7xNWxL+erg8g1hB
	cx5sWDOkAowVk5t7GxvOF6PEX4zlr2BvSDpTFQvqd7llu7YytpLeyJZTwBBbvGXhGNy/qBKU/n6
	eLluT55L/b7wBBY/PENcOkiG5DmB1h+dMD+46cSpzutz3ynNkTgbD+UItejwkkB71DNjm7ckhNJ
	h2pDvC0RLJiRXwtqolpHGGcZPCkcth8mI7bl+xUUSGasTw0AAUbGzOoqTcTVEa1PJ3ThMeue5Rx
	Bs0J2Gt5Q3sCMmjcIJJa1VB7J2yypbEubqL46aiq+L9XMYJmNauPo6volt8cVzL/3kd6NoL5Kfz
	Ayz+XXVa6PWR9BSdPeANpsc6Ms8S2lPYYfOXt4q3ES6ABpAsyc1ozU/YQk3TjAd4/QQPODqfBqx
	w==
X-Google-Smtp-Source: AGHT+IHeFkhiCCpg8s1r6QAKqv2eAOpNMD1oIvWqMWqFEj96egBbGsSb+ZrVWC027IadMIQzPEYSTg==
X-Received: by 2002:a05:620a:178c:b0:8b2:ea3f:2fa4 with SMTP id af79cd13be357-8b32ab88726mr1783087885a.6.1763941516460;
        Sun, 23 Nov 2025 15:45:16 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 00/32] Roll up outstanding fixes
Date: Sun, 23 Nov 2025 18:44:40 -0500
Message-ID: <cover.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2658

This patch series attempts to get scarthgap branch back into a
usable state.  These changes are on the scarthgap-next branch of
meta-security, and my plan is to merge them to scarthgap branch at
the end of day Tuesday (EST).

It includes:
- All the outstanding patches to the mailing list that I could find,
  barring one duplicate python3-fail2ban update that did not apply
  and had a newer alternative available.
- Changes to get the gitlab CI test pipelines to the same state as
  master (i.e. build tests all passing).
- Selected backports of other changes from master that seemed
  appropriate.

Things to note:
- I chose to keep all the suricata and libhtp CVE fixes history even
  though I've backported 7.0.12 and 0.5.52 updates on top, since I
  figure this approach makes it easier to check if a patch submission
  was missed.  Plus, I'm lazy, and didn't feel like squashing all that
  away after I was done testing.
- Going forward, I would prefer suricata and libhtp upgrades over
  accruing a large set of CVE patches until that stops being feasible
  for the 7.0.x and 0.5.x versions, respectively.  Those should go
  through master branch first until it has switched to newer major
  versions (which will be soon for suricata).
- I believe all the backported suricata systemd support changes are
  effectively fixes, please let me know if I'm missing something and
  they will break your usecase.
- The packagegroup-core-security change of PACKAGE_ARCH to MACHINE_ARCH
  is potentially a breaking change if you're using on target package
  updates (e.g. with dnf or apt), and for some reason using that
  packagegroup.  My guess is that no one uses that packagegroup since
  it's effectively special purpose for the build test image, but please
  let me know if this will break something for you.
- There are still some other outstanding CVEs for firejail and clamav.
  firejail is potentially upgradeable, but clamav is problematic since
  I believe 0.104.x was already unsupported when scarthgap shipped.
  If you care about clamav support for scarthgap, plus provide some
  input on if an upgrade to one of the LTS branches (1.0 or 1.4) is
  something you would like to see / would be able to help test.

Thanks,

Scott


Changes:

Aidan Stewart (1):
  smack: Switch to CVE_STATUS

Armin Kuster (1):
  harden-image-minimal: Fix usermod

Chen Qi (1):
  libgssglue: switch to use git source

Clayton Casciato (6):
  suricata: resolve TMPDIR QA issues in do_configure
  suricata: drop pkg_postinst_ontarget systemd init
  suricata: fix "interface" arg in systemd service
  suricata: install classification, reference configs
  suricata: populate SYSTEMD_SERVICE for service autostart
  suricata: update to 7.0.12

Haixiao Yan (2):
  fail2ban: Adapt test output to Automake format for ptest compatibility
  fail2ban: replace fail2ban-python shebang with python3

Hitendra Prajapati (7):
  suricata: fix CVE-2024-45795 & CVE-2024-45796
  suricata: Fix CVE-2024-55605
  clamav: fix CVE-2025-20260
  suricata: fix multiple CVEs
  libhtp: fix CVE-2025-53537
  suricata: Fix multiple CVEs
  suricata: fix CVE-2024-55627 && CVE-2024-55628

Marta Rybczynska (7):
  CI: update build for new CI
  kas: update configuration
  scap-security-guide: fix fetch
  lynis: update 3.1.1 -> 3.1.4
  chkrootkit: use debian mirror
  checksecurity: update the debian package
  bastille: prevent host uids on files

Rasmus Villemoes (1):
  fail2ban: update to 1.1.0+

Scott Murray (4):
  Update maintainers
  packagegroup-core-security: add missing packages
  meta-tpm: Small maintainers fix
  ima-evm-utils: remove unnecessary FILESEXTRAPATHS tweak

Yi Zhao (1):
  python3-fail2ban: fix ptest failures

akash hadke (1):
  meta-security: Remove True option to getVar calls

 .gitlab-ci.yml                                |   47 +-
 README.md                                     |    4 +-
 .../include/maintainers-meta-security.inc     |   72 +-
 .../checksecurity/checksecurity_2.0.16.bb     |    7 +-
 .../bastille/bastille_3.2.1.bb                |    2 +
 ...ges-the-IPs-again.-additionally-it-g.patch |  210 +++
 ...ao.unittest.TestRunner-for-ptest-out.patch |   43 +
 ...case.py-set-correct-config-dir-for-t.patch |   34 +
 ...l2ban_1.0.2.bb => python3-fail2ban_git.bb} |   40 +-
 kas/kas-security-alt.yml                      |    2 +-
 kas/kas-security-base.yml                     |   13 +-
 kas/kas-security-parsec.yml                   |    2 +-
 kas/qemuarm64-musl.yml                        |    1 +
 kas/qemux86-musl.yml                          |    1 +
 kas/qemux86-test.yml                          |    5 +
 meta-hardening/README.md                      |    4 +-
 .../images/harden-image-minimal.bb            |    4 +-
 meta-integrity/README.md                      |    4 +-
 meta-integrity/classes/ima-evm-rootfs.bbclass |    2 +-
 .../ima-evm-utils/ima-evm-utils_1.5.bb        |    2 -
 meta-parsec/README.md                         |    1 -
 .../parsec-service/parsec-service_1.3.0.bb    |    4 +-
 meta-tpm/README.md                            |    4 +-
 .../distro/include/maintainers-meta-tpm.inc   |   32 +-
 .../lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb}  |    2 +-
 .../scap-security-guide_0.1.71.bb             |    2 +-
 .../packagegroup-core-security.bb             |    4 +
 ...kefile-from-using-its-own-rust-steps.patch |   40 +
 .../suricata/files/CVE-2024-45797.patch       |  148 --
 recipes-ids/suricata/files/fixup.patch        |   32 -
 recipes-ids/suricata/files/suricata.service   |    2 +-
 .../{libhtp_0.5.45.bb => libhtp_0.5.52.bb}    |    6 +-
 recipes-ids/suricata/suricata-crates.inc      | 1509 ++++++++---------
 .../{suricata_7.0.0.bb => suricata_7.0.12.bb} |   27 +-
 recipes-mac/smack/smack_1.3.1.bb              |    7 +-
 recipes-scanners/clamav/clamav_0.104.4.bb     |    1 +
 .../clamav/files/CVE-2025-20260.patch         |  366 ++++
 recipes-scanners/rootkits/chkrootkit_0.57.bb  |    2 +-
 recipes-security/libgssglue/libgssglue_0.8.bb |    5 +-
 39 files changed, 1612 insertions(+), 1081 deletions(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
 rename dynamic-layers/meta-python/recipes-security/fail2ban/{python3-fail2ban_1.0.2.bb => python3-fail2ban_git.bb} (63%)
 rename recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} (93%)
 create mode 100644 recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-45797.patch
 delete mode 100644 recipes-ids/suricata/files/fixup.patch
 rename recipes-ids/suricata/{libhtp_0.5.45.bb => libhtp_0.5.52.bb} (82%)
 rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.12.bb} (82%)
 create mode 100644 recipes-scanners/clamav/files/CVE-2025-20260.patch

-- 
2.47.3


