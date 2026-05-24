Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FCCD5BCF
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:18 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7297.1779625690726438329
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sQIp3HlP;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so92544066d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625690; x=1780230490; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7Fj1KMZhh5v6aBpPn/olVTB7LCRvofMHukX0CKZt+s=;
        b=sQIp3HlPJj0IOG/dW0u/vw7Ol+Qi/db5IlbnBA+9r+t/nwLo6X6Q/HQkDNaweCxTFj
         MTbfP/80J+7SM+ghvGgunufTKY+19LO2ht6dnX3Y7ci8Mm55cLq7ivIHJKMiRIeuMjhA
         nARXCPGbO90Vbrhc2/SBBmYV45frsKBwBbIDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625690; x=1780230490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7Fj1KMZhh5v6aBpPn/olVTB7LCRvofMHukX0CKZt+s=;
        b=Pucnls2V+lXlrWY+4ziyJl3/IET8FWdm3THYaO/NySoYTE3hnmYQuKOQ4BH4PMCRw4
         ordv3cMPCV2Q9Ya8oMYwsvMtVOFYnD8iqeXvnVTm+cO9MVJY4DBU9FiwUEpXgMKzhxAe
         VYnp22IDmP1BNeoB9YnyFAHu2rraLFoFMxkx/oU6odw/PJ4xSeq+7bh6FmgSRe6uMdB2
         iEdWYFv2lDVVcmDKIbIGmwchw87INRtw3NxxMN7/VO9Mq6is2QgFein7f8F8RSpW/Mh9
         UAOuvp49HLe2zCTb1He1sN1JeV1Ef9Jo1Z/dYs4avyzfdbHuUYhe02lpKs+FmQV8Wc6Q
         oMxg==
X-Gm-Message-State: AOJu0YxKxnnbfZ0rrSYWTaSejqc9cxPVjLfCAOAPlWXcKqMSCYZK/5jH
	y/BBBEs5Hlpfydv0sF/tPcFqPhHskegnpqTnDnToGdR3UR5Vo9GyLNTPAoixnxlRGuJ7cs7dh+Q
	R/LdT
X-Gm-Gg: Acq92OEG1Tw94FsQ6czT+qDXVbvfj6RK698NupqwV8/tTgOSPcltWBltwtb8bGD0ICK
	cfqKrO9NDcVyASz3BNPte6+5+3ZCVGehQkYTsCo44u78eUl3m90xwq8vAaH+YZi1lwD6UkGPRQO
	lehoH0hcyxK9h8JoPPxsjU0XKR80Up3HkMPz7ADV0lHEEaYxY4K0wzjySWlfCzHmjE/y9JXPFcX
	s5oOsd91vbIAxSq3M3nab0jCnQe2YJSDJyLLx/vuwy2J+gwR/tgM8s53azfdKZ3/dv6Oat373oe
	T0TFpRhrz65Z0JEwr7dWgvg6402z272o+TxgOGmSYrOKw+WnSObq4iDVRYW6OfRWTAXrANtRRMo
	wwGVgBEB1ziSxHDD9PsDtNas1Sfh6B/5N9OMJqmqgJLqw7k81LvfZy1oo1dfkLOi3UCAjnLMhto
	RdRsuu36irSsc4qbtByZoqxHRwQMaSjvtodV+frzpdeZQ8auosus2yJHth2tldA9JWVQA7is+zW
	+KRGmdVIFoTD80Wguv6czo+z6U41rZZLG725+IxvCd7MfaAf0vEJrsW02RCnF37
X-Received: by 2002:a05:620a:2a05:b0:905:ebde:ffa4 with SMTP id af79cd13be357-914b5121cc6mr1226289085a.23.1779625689399;
        Sun, 24 May 2026 05:28:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 00/13] Assorted updates 05/24
Date: Sun, 24 May 2026 08:27:49 -0400
Message-ID: <cover.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4020

My apologies for the delay in getting this out, this patch series rolls
up the contributed patches from the past few weeks.  These changes are
queued on the wrynose-next branch if you would like to check them out to
test yourself.  I intend to merge these to wrynose branch Tuesday evening
(CEST, May 26) unless there are objections.

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


