Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30EC83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.1102.1751649109116865391
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=junNYr5z;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5903bceffso16567081cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649108; x=1752253908; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz5Jj1Z35SjUmmaQ2ODGjCzikun+QnoPFiSCT7CSdjE=;
        b=junNYr5z9n8slDBGP1CxzcMdFr+5uzPzBJgjjj3LimegKlaoxjvNgTdvuqTroqqCQF
         5GC/Zc9fMvMCZ4SS19Ps9NzlOaUqAWc4OBinSriBAaUrvUJAsSaC6vPeIqQkVz7rhR13
         0MiHG98Z15+30qhJyuYih7kOO9SrRaPlVUCFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649108; x=1752253908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz5Jj1Z35SjUmmaQ2ODGjCzikun+QnoPFiSCT7CSdjE=;
        b=OwPwTuDEYzmKgMeYAkHNnmJly1nJ32F4wAC59hPCpHeLOMpbPzOf7u/GEBOyYhXfgo
         B76RAZwXvKxiT4DWx65JMlk4qgAUFs52v/rN0oJiCW4IFt5zOVedrnUciChfgegwuwZf
         4bn4irUvF/E3QkOa64s9ufQpuPuI/4p23NmCpvMBCAVXfsBQevJjtAUjIrj+4hT66kSs
         EETvLvJWFTloBo/q7G848MVJL1/MsrYISSizro8aY4GB9RX1qWFtSsYWR9paHqNa5aQW
         oaTIz8gHkXnwlHDTnlADnNBy1gv+nh8QezKAtRdstlIRgdwLaI5GZlJVowyF0vVIPODW
         c8QA==
X-Gm-Message-State: AOJu0YyWwqilfJEpbZAm4od6TSQq8EtaeH1XE1Pey6oW67F9NJl551AP
	B24EW2h/1k9t3OUmZx6pUud7Mrsl1s98QdKDqJ6kHRCRxmrTCHRcKyC4JGy7/XTEvHWqWhk/zaF
	QTEhA
X-Gm-Gg: ASbGncvptMBN/KTFDBnuFl/SC1VqAPguOWPqh8s6KdcIPq58EonvSkX2+ACnpg9AA/8
	U3CnJc3C+qNt6ioHGw554cFbLEevt4JOSIvymobhirv1QejHHLBqtn/Z4QC/JrcL41lpdWUq9mW
	RR4VhaDK8+Dbd1VFqMfW7Rx06NVhVzZLWTdQ2hSOqwJ5fo3RLZHoxrbgHQVKNSpSwG942zMAw6y
	vICfOmNbXjR9v1cI/5HBjMP2Bn20a/gWWAbtcp45/ypfw8awzSaRN3DJq/yjtc2goGrYP3gQPOA
	CP6BL/nwl5fMafKrCT2HXC+0fs3vg1t/jScGtpJvNYNV8shGaY9aOjmDS0iJgNGhpaGnwEqTRsB
	LK4ldfNlPw1s31XtCAU5PTjanUFaKM8p/S2fdndbRKasnFnX7
X-Google-Smtp-Source: AGHT+IEZmtJNeOwkpacGUGCftJuCBAQ3+KjuhwQWPGFCdOwn4GmTgdIAYzZQOaLjsCMk1bQ/u8fGLA==
X-Received: by 2002:ac8:7f44:0:b0:494:a436:5af6 with SMTP id d75a77b69052e-4a996843478mr55614311cf.47.1751649107627;
        Fri, 04 Jul 2025 10:11:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 00/12] Initial fixes for master branch
Date: Fri,  4 Jul 2025 13:11:04 -0400
Message-ID: <cover.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1752

Thank you for your patience, this patch series is a start on getting
master branch maintenance back in order, and allowing Marta and myself
to try getting through some resource estimating for the new CI setup.
The focus has been on patches that allow getting through clean builds
of the majority of the build tests in the CI pipeline, which I have done
manually for qemux86-64.  We will shake out any other issues as the CI
setup is tested (or reported via the list).

Note that I did pick a few patches from the backlog on the mailing list,
but generally not things that were not build warning or failure fixes.
I did the S/UNPACKDIR changes myself, as I had started on them before
any of patches were posted to the list.  Additionally, there are 3
fixes for gcc 15 issues (the libhoth patches will be sent upstream
in the next day or two).

I would ask that you give us a few days before sending (or resending)
patches with any expectation of immediate turnaround.  There is still
quite a bit of work to recreate a working CI setup, as well as ensuring
walnascar and scarthgap branches are in a testable state.  This series
has been pushed to master-next, and while I'm aware of the US long
weekend holiday, the goal is to merge these changes to master by Monday
afternoon at the latest, as I have some conference travel next week, and
we do need to unblock folks testing against master branch.

Scott


Changes:

Anton Antonov (1):
  parsec-service: update PACKAGECONFIG options as lists of cargo build
    features

Clayton Casciato (1):
  smack: Use new CVE_STATUS variable

J. S. (1):
  Fix warning : lack of whitespace around assignment

Marta Rybczynska (4):
  scap-security-guide: fix fetch
  chkrootkit: use Debian mirror
  CI: update build for new CI
  .gitlab-ci.yml: add logging of jobs to files

Scott Murray (5):
  layer.conf: Update to whinlatter (5.3) release
  Adapt to S/UNPACKDIR changes
  sshguard: Update to 2.5.1
  libhoth: update to latest
  chkrootkit: fix building with gcc 15

 .gitlab-ci.yml                                |  45 +++---
 conf/layer.conf                               |   2 +-
 .../checksecurity/checksecurity_2.0.16.bb     |   5 +-
 .../bastille/bastille_3.2.1.bb                |   2 +-
 .../recipes-security/nikto/nikto_2.1.6.bb     |   2 +-
 .../python/python3-json2html_1.3.0.bb         |   2 +-
 .../python/python3-xmldiff_2.7.0.bb           |   2 +-
 .../fail2ban/python3-fail2ban_git.bb          |   2 -
 meta-hardening/conf/layer.conf                |   2 +-
 meta-integrity/conf/layer.conf                |   2 +-
 meta-parsec/README.md                         |   4 +-
 meta-parsec/conf/layer.conf                   |   2 +-
 .../parsec-service/parsec-service_1.4.1.bb    |  15 +-
 meta-tpm/conf/layer.conf                      |   2 +-
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |   1 -
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |   2 -
 .../0001-Fix-building-with-gcc-15.patch       | 151 ++++++++++++++++++
 ...02-Fix-building-without-dbus-backend.patch |  36 +++++
 meta-tpm/recipes-tpm1/hoth/libhoth_git.bb     |  13 +-
 .../openssl-tpm-engine_0.5.0.bb               |   2 -
 .../recipes-tpm1/pcr-extend/pcr-extend_git.bb |   2 -
 .../tpm-quote-tools/tpm-quote-tools_1.0.4.bb  |   1 -
 .../tpm-tools/tpm-tools_1.3.9.2.bb            |   2 -
 .../recipes-tpm1/trousers/trousers_git.bb     |   2 -
 .../ibmswtpm2/ibmswtpm2_183-2024-03-27.bb     |   2 +-
 .../ibmtpm2tss/ibmtpm2tss_2.2.0.bb            |   2 -
 .../tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb    |   2 -
 .../recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb |   2 -
 recipes-compliance/openscap/openscap_1.4.1.bb |   2 -
 .../scap-security-guide_0.1.76.bb             |   9 +-
 recipes-ids/aide/aide_0.18.8.bb               |   2 +-
 recipes-ids/crowdsec/crowdsec_1.1.1.bb        |   2 -
 recipes-ids/ossec/ossec-hids_3.7.0.bb         |   5 +-
 recipes-ids/suricata/libhtp_0.5.50.bb         |   4 -
 recipes-ids/tripwire/tripwire_2.4.3.7.bb      |   4 +-
 recipes-kernel/lkrg/lkrg-module_0.9.7.bb      |   4 +-
 recipes-mac/AppArmor/apparmor_4.0.3.bb        |   1 -
 recipes-mac/ccs-tools/ccs-tools_1.8.9.bb      |   4 +-
 recipes-mac/smack/mmap-smack-test_1.0.bb      |   3 +-
 recipes-mac/smack/smack-test_1.0.bb           |   3 +-
 recipes-mac/smack/smack_1.3.1.bb              |  10 +-
 recipes-mac/smack/tcp-smack-test_1.0.bb       |   3 +-
 recipes-mac/smack/udp-smack-test_1.0.bb       |   3 +-
 recipes-perl/perl/libwhisker2-perl_2.5.bb     |   2 +-
 recipes-scanners/checksec/checksec_2.6.0.bb   |   4 +-
 recipes-scanners/clamav/clamav_0.104.4.bb     |   1 -
 recipes-scanners/rootkits/chkrootkit_0.58b.bb |   7 +-
 .../files/0001-Fix-building-with-gcc-15.patch |  39 +++++
 recipes-security/Firejail/firejail_0.9.72.bb  |   2 -
 recipes-security/chipsec/chipsec_1.9.1.bb     |   2 -
 .../cryptmount/cryptmount_6.2.0.bb            |   2 +-
 recipes-security/fscrypt/fscrypt_1.1.0.bb     |   2 -
 .../fscryptctl/fscryptctl_1.1.0.bb            |   2 -
 recipes-security/glome/glome_git.bb           |   1 -
 .../google-authenticator-libpam_1.09.bb       |   2 -
 recipes-security/isic/isic_0.07.bb            |   2 +-
 recipes-security/krill/krill_0.12.3.bb        |   1 -
 recipes-security/libest/libest_3.2.0.bb       |   2 -
 recipes-security/libgssglue/libgssglue_0.9.bb |   2 -
 recipes-security/libmspack/libmspack_1.11.bb  |   2 +-
 recipes-security/ncrack/ncrack_0.7.bb         |   2 -
 .../redhat-security/redhat-security_1.0.bb    |   3 +-
 recipes-security/sshguard/sshguard_2.4.3.bb   |  11 --
 recipes-security/sshguard/sshguard_2.5.1.bb   |  11 ++
 64 files changed, 319 insertions(+), 151 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch
 create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch
 create mode 100644 recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch
 delete mode 100644 recipes-security/sshguard/sshguard_2.4.3.bb
 create mode 100644 recipes-security/sshguard/sshguard_2.5.1.bb

-- 
2.50.0


