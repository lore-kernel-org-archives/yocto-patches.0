Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2CCD5BD0
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:06 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7096.1779624957343335102
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=E/13MXJ0;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b8e98fd885so113568356d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624956; x=1780229756; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKXpIRGosAao4ZiDaqipTjqC296HLzXBgJEYXvS42rA=;
        b=E/13MXJ0HmemqyaTTRx32BN2DmWms4BHmCgk5uh6169EDbW0cJrj8ewg3aJH1UNNmu
         BhBOT54e0rnsgb5/2eUfIgfdQ0YY7XsIKkcGsNMgXORLP4DF3Y5PDXStI0C4raFWb5eP
         U7kkx1nL8yA6mq2YnW62d7SL9YL5KPoZnafW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624956; x=1780229756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKXpIRGosAao4ZiDaqipTjqC296HLzXBgJEYXvS42rA=;
        b=hCLsMFK6KQ65jBhjcReaD9r+7U+yHn9fLg4DNlN45Vojg391+usG8DHp9brENGk7Eb
         tkWlw1AEJOfEWM7gZOHCaafFnnhXxX5jYSIBAUdnvWUDRXacBs8s+G7DywMcbLzAQjtX
         GNhwBqaevNaXGu4DcuGAus55+c/RkTXAUm5mIPACmclYNl5mHVHIs+s+1aLR1KuL+V6k
         0A+KeUYfnoImoYmMGd8lWLyY40NFZ3J8lBX4C6NAtUcQJGTxoHrz8vB6c8DSjIq+7neC
         fkUNbhqxTN8zpOdPBUbFxg4cU9zaP602DjjBlnUIFjeUfUW2ytPwfeTQthPqcUE5vl4Q
         g2rw==
X-Gm-Message-State: AOJu0Yy2LiY7grdA7VWhp8eylWJ+BTQS0sYY4HM3RDH59MZx9qfSo6Jy
	m0aAVw6Asv+xRMWRvsFU9KfRzZmzTZ78O9yYXkoNClKjkPt/KUKOfa/7J6hvT65cdn8ZYuk2XC4
	YTmNI
X-Gm-Gg: Acq92OH0wrEymf+j8javKVlS2I+bWf4PpxguZGSupSrJPOmjCDpG2ogiT6qnNsy20AQ
	i1e/btN8qYlb+N/WPsCZEBzkAaXOyxbm40FS/a/77O8YpcSwPqU9CvC+Xvegr/fToCdUfNRSMhh
	ndErpSBPB5jrtSTUH3n29JLC1AZnM6WkDAULLTvMIBdhmFK6+WoMrEj1/GifyCeQDQNyGxy8Av0
	6NbVWEZ+yQgSj119lX7LoOJJscjQa0zv9+vZ55PFwEn0BsUbUvTnhdFBnZYwiHg3/vcfWnKTdmT
	mqlCnVFP2yDCyKNEKwRQlesP5katgUBjCyzZShxYHsfwBdkVSDGo/DAxu7uAjw5v9jhWlHwaon9
	kOS2/ZfICt0qu3uC0214JcM6iUQYc+5vtjHQ+xwPAVvUKJiy06RL/4dZLr0q8QMQRNAQ/RKG5MF
	BkCA8A9Tg3W1HF3VhpkjI8KIcmnxNilm/c85o4Q9Bcu4HiVifE5yMC0IxMsKfu0RfzN8aR7wh4k
	mp8u5Xap3WQzZLgzrNhgmnLZXCfUw9jlplnbcoLhqtgsT7ZXedf1qFQJQjh3wNb
X-Received: by 2002:a05:6214:400b:b0:8cc:d61:3559 with SMTP id 6a1803df08f44-8cc7b5dbc40mr179008246d6.46.1779624956137;
        Sun, 24 May 2026 05:15:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:15:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 00/13] Assorted updates 05/24
Date: Sun, 24 May 2026 08:15:27 -0400
Message-ID: <cover.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4006

My apologies for the delay in getting this out, this patch series rolls
up the contributed patches from the past few weeks.  These changes are
queued on the master-next branch if you would like to check them out to
test yourself.  I intend to merge these to master branch Tuesday evening
(CEST, May 26) unless there are objections.

Note that there is one known issue with latest meta-oe that has blocked
getting clean CI runs that likely will impact anyone using the dm-verity
bbclass.  The root cause seems to be a new packaging conflict between
lvm2 and libdevmapper after the recent upgrade in meta-oe, but I have not
had time to try to dig into it and come up with a clean fix.  I plan to
look at that if time permits while I am at Embedded Recipes this coming
week.

Scott


Changes:

Anton Antonov (2):
  parsec-service: Update Parsec service version.
  meta-parsec: Do not run Parsec CI jobs on 32bit platforms.

Bin Cao (1):
  samhain: upgrade 4.5.2 -> 4.5.3

Li Zhou (3):
  firejail: fix COMPATIBLE_MACHINE setting
  layer.conf: correct WARN_QA
  aide-base.bbclass: correct STAGING_AIDE_DIR

Peter Marko (1):
  tpm2-tools: make efivar optional

Ross Burton (3):
  parsec-service: assign PACKAGECONFIG in one line
  parsec-service: do group membership modifications in useradd
  parsec-service: update TS group name

Yi Zhao (1):
  arpwatch: fix typos

jason.lau (2):
  google-authenticator-libpam: update 1.0.9 -> 1.11
  aide: fix pkg_postinst_ontarget shell script

 .gitlab-ci.yml                                |  12 -
 classes/aide-base.bbclass                     |   2 +-
 kas/qemuarm-parsec.yml                        |   6 -
 kas/qemux86-parsec.yml                        |   6 -
 ...Fix-unnecessary-qualifications-error.patch |  50 -
 .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
 ...rvice_1.4.1.bb => parsec-service_1.5.0.bb} |  30 +-
 meta-tpm/conf/layer.conf                      |   2 +-
 .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |   5 +-
 recipes-ids/aide/aide_0.19.3.bb               |   4 +-
 recipes-ids/samhain/samhain.inc               |   4 +-
 recipes-scanners/arpwatch/arpwatch_3.3.bb     |   8 +-
 recipes-security/Firejail/firejail_0.9.72.bb  |   5 +-
 ...bb => google-authenticator-libpam_1.11.bb} |   4 +-
 14 files changed, 533 insertions(+), 473 deletions(-)
 delete mode 100644 kas/qemuarm-parsec.yml
 delete mode 100644 kas/qemux86-parsec.yml
 delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
 rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.bb => parsec-service_1.5.0.bb} (78%)
 rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)

-- 
2.53.0


