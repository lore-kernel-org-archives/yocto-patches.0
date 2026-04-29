Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA9CD3424
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:22 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14370.1777477211469943678
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=flUqQumH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8f0579401c4so882616585a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477210; x=1778082010; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNIM/e1wtXn8IoyZOUtyjhYuxIXV80diBcOXpynwpjg=;
        b=flUqQumHcZRst0uNuFgoJVDBQZhTXcFFClTmFiW0AN0xeoxX9+90B32ANS+rMn5Pev
         HtP1VPe83E6eOZMmwNNlGp41Yyly2ebz3kqym7T3Vo714rn1eaeriar85Crdo+jvW+kE
         CD2X5/sHIVIRaKO2MMrFm4/hk0ce702S7SUCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477210; x=1778082010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNIM/e1wtXn8IoyZOUtyjhYuxIXV80diBcOXpynwpjg=;
        b=FpkDbxOXtkbdeRZYPfCQ4UhrvggVwJDkk6Bwt/iD1dOVlN466Qf+L//cU8hZbqpFI0
         6ATb7NPLLTpefXXnY32HeUICzrlsBmMdIZ2pjrpsA5FQ7T/rop3/4Xkz2P5nNJ/2V7q0
         kcHqZM2p8sZhGobW8nWqJ5q/DeVUHUeK5SayANZZ8367gJBS0QANyNxy+mJ+6iOGWWb4
         DgxnmrF7oF0G0Uiw8oEgd2JYhPF1+Mc79WLKpiXVfwlocIfkFx3/hfuucXoHU+HTZqjc
         HmaytRGSmpoJbispQh/qFvLERoudR81NOSh6+qlYxRkMlGUulr+iS5lWsxQlKxRMtLvB
         soRw==
X-Gm-Message-State: AOJu0YyroyfVsjIBWEyCRlFPF99QIJPQU3NmSvY3Dc0vkCTO23b4XkRe
	koRyo1GVQgy72FqYUaMZRWMz8UERMsGldA4w9W+u+eq5yY04ETTbABuGgW9YuL1KLkqqUWJxtYJ
	YC8D+
X-Gm-Gg: AeBDiev6LDJVTW4Bn0B7MLx4zYQbAO70wFfo/CjcEZl4XKruAUJ8AEarORZL+EiCWWW
	32yYzuiUeW6bslEuSzz+Bu08wvGf/EExgwPI/SDAcLJX3eeSkHRwiud5PTxhiojyqBdA7jI4kdA
	zv7NFPp0dIRxp6DTjaKvaFflh4KzecvZ6gPk1RlAhO9X7+ftFCTmlmeG5kUR++bI1wJBDa/lv57
	7PNCnLDwtYArbNbUPnqMoAbjfli0nQkdyBCKKz5/pCX6I1P5Wj00W7nMOusJ5/i6bD8gcKS95A9
	/XGouhaTalzkSsD6qRMZ6khJk2wlmeq85Qc6SWE274v4TWmtEvldEkJVfp6VQiv1IjWJHiRIMTk
	6eWUF7htQC+40LH8zcdBtAApu3cLj327Hb8Y8b4kv7HrZqLPjMcno52XjEq/Bhnn9ntnHpL5eqN
	WquClQtfSwmC0ti0sWCZBukPKifQQ1lgWbdxusWBIAQmfmXalOciqhnYRfm4clgTlCsltbXjaiO
	Y+lgCQ2HFvf5HMI8ovONKgTFs/le88CPuGjlwYVlzamI3IPvgTQPb7ToLU95K1I6m3irJJzcec=
X-Received: by 2002:a05:620a:2697:b0:8e5:b6a5:8d0a with SMTP id af79cd13be357-8f7d9e0e427mr1052629585a.62.1777477209586;
        Wed, 29 Apr 2026 08:40:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 00/13] Assorted updates 04/29 and wrynose branch plan
Date: Wed, 29 Apr 2026 11:39:30 -0400
Message-ID: <cover.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3874

This patch series rolls up the contributed patches (barring some from the
past few days), plus several recipe upgrades/fixes from myself with the
aim of getting known breakage fixed before cutting the wrynose branch
(see below).  These changes are queued on the master-next branch if you
would like to check them out to test yourself.  I intend to merge these
to master branch tomorrow evening (Eastern Time, April 30) unless there
are objections.

With respect to the wrynose branch, the plan is to push it by the end of
the week, or on the weekend if vetting CI takes a bit longer than expected.
The one remaining known breakage that I am aware of is parsec-service
not building; Anton has triaged it, but so far we have not come up with
a fix.  Once we have one, it will be backported ASAP.

Scott


Changes:

Clayton Casciato (1):
  suricata: update 7.0.13 -> 8.0.4

Marta Rybczynska (1):
  README: update CI links

Scott Murray (10):
  crowdsec: Upgrade to v1.7.7
  aircrack-ng: Upgrade to 1.7
  opendnssec: Upgrade to 2.1.14
  libmspack: Remove
  clamav: Upgrade to 1.4.4
  aide: Upgrade to 0.19.3
  libmhash: Remove
  ncrack: Update
  packagegroup-core-security: Add missing packages
  packagegroup-core-security: remove python3-privacyidea

Wenlin Kang (1):
  krill: fix missing dollar sign in FILES

 README.md                                     |    6 +-
 .../include/maintainers-meta-security.inc     |    2 -
 .../packagegroup-core-security.bbappend       |    1 -
 .../packagegroup-core-security.bb             |    5 +-
 .../aide/aide/0001-Fixes-build-issues.patch   |   37 +
 recipes-ids/aide/aide/m4_allow.patch          |   40 -
 .../aide/{aide_0.18.8.bb => aide_0.19.3.bb}   |   15 +-
 recipes-ids/crowdsec/crowdsec-go-mods.inc     |  523 +++
 recipes-ids/crowdsec/crowdsec-licenses.inc    |  239 ++
 recipes-ids/crowdsec/crowdsec_1.1.1.bb        |   40 -
 recipes-ids/crowdsec/crowdsec_1.7.7.bb        |   29 +
 ...kefile-from-using-its-own-rust-steps.patch |   36 +-
 recipes-ids/suricata/libhtp_0.5.52.bb         |   23 -
 recipes-ids/suricata/suricata-crates.inc      | 3282 +++++++++++++----
 .../{suricata_7.0.13.bb => suricata_8.0.4.bb} |   31 +-
 recipes-scanners/clamav/clamav-crates.inc     |  180 +-
 .../{clamav_1.4.3.bb => clamav_1.4.4.bb}      |    6 +-
 ...001-Remove-build-directory-reference.patch |   79 +
 .../aircrack-ng/aircrack-ng_1.6.bb            |   36 -
 .../aircrack-ng/aircrack-ng_1.7.bb            |   54 +
 recipes-security/krill/krill_0.12.3.bb        |    2 +-
 recipes-security/libmhash/files/Makefile.test |   13 -
 recipes-security/libmhash/files/mhash.c       |   32 -
 recipes-security/libmhash/files/run-ptest     |   12 -
 recipes-security/libmhash/libmhash_0.9.9.9.bb |   47 -
 recipes-security/libmspack/libmspack_1.11.bb  |   16 -
 recipes-security/ncrack/ncrack_0.7.bb         |    8 +-
 ...1-Fix-implicit-function-declarations.patch |   51 +
 .../files/0001-include-utilities.h.patch      |   33 +
 ...rder-header-files-and-include-time.h.patch |   39 +
 ...ndnssec_2.1.10.bb => opendnssec_2.1.14.bb} |   15 +-
 31 files changed, 3941 insertions(+), 991 deletions(-)
 create mode 100644 recipes-ids/aide/aide/0001-Fixes-build-issues.patch
 delete mode 100644 recipes-ids/aide/aide/m4_allow.patch
 rename recipes-ids/aide/{aide_0.18.8.bb => aide_0.19.3.bb} (85%)
 create mode 100644 recipes-ids/crowdsec/crowdsec-go-mods.inc
 create mode 100644 recipes-ids/crowdsec/crowdsec-licenses.inc
 delete mode 100644 recipes-ids/crowdsec/crowdsec_1.1.1.bb
 create mode 100644 recipes-ids/crowdsec/crowdsec_1.7.7.bb
 delete mode 100644 recipes-ids/suricata/libhtp_0.5.52.bb
 rename recipes-ids/suricata/{suricata_7.0.13.bb => suricata_8.0.4.bb} (86%)
 rename recipes-scanners/clamav/{clamav_1.4.3.bb => clamav_1.4.4.bb} (98%)
 create mode 100644 recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch
 delete mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.6.bb
 create mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.7.bb
 delete mode 100644 recipes-security/libmhash/files/Makefile.test
 delete mode 100644 recipes-security/libmhash/files/mhash.c
 delete mode 100644 recipes-security/libmhash/files/run-ptest
 delete mode 100644 recipes-security/libmhash/libmhash_0.9.9.9.bb
 delete mode 100644 recipes-security/libmspack/libmspack_1.11.bb
 create mode 100644 recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch
 create mode 100644 recipes-security/opendnssec/files/0001-include-utilities.h.patch
 create mode 100644 recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch
 rename recipes-security/opendnssec/{opendnssec_2.1.10.bb => opendnssec_2.1.14.bb} (70%)

-- 
2.53.0


