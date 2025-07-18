Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAAEC83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:11:13 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.21828.1752847870529508892
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 07:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jxhagKPb;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e2e3108841so245263585a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752847869; x=1753452669; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7VoWzdTp9VrL7Ydej6wEYGRNuwYviJ/yG/8O5sZ5Jg=;
        b=jxhagKPbaQLG8sDgLvh0ngJkh/T4zVmQ6VbVfpGQ2KbqvffG4uLvLPFxtm06lBJv97
         ZWxs8wQezzljg03N1ODNLYi9KpaiO2rw++nE4SgEPOn3AEDllt16IjppVYII3Q4btS2M
         Rwr/e2GmhwQ/hXyjd+pVKelXmtCDZuTjcCBAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847869; x=1753452669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7VoWzdTp9VrL7Ydej6wEYGRNuwYviJ/yG/8O5sZ5Jg=;
        b=lbpfvnY6IoiRvndvILh4thKKWPN/f53R8mgHXJcBVpPkbGeEZPc0aE2kXnFy8GbwDi
         vJGMYB77Ew3Wc9BPJmELlM9/P+AzUuVh8HAdxauMN24SNNdmsfybBZh/xTPvMBtie/Qp
         /EKlXTtqqzyqpUTZYds7LEbfq3U7cBcJVa+1yHVntZieXGqUaoSs1vBSUAJXwVveRyWf
         cWQiGJHTAZHWi4WLnUTfXllk+SmKfrAaZOIMy9PaOWfTaxrDLA4XW7YsJ3q1FDtYGJXV
         J6rz2AO7tkMaYT213IaC4K36h6KcyrNGR65gla0zjKKNlBDDITv8x5SxwqZ2+Il1Gqr4
         95mg==
X-Gm-Message-State: AOJu0YyXvl7+/aZn97fzwQnZHT/dX05oTTqOKGNUtQ+rN/9fQ3de8alI
	Lxjb273iEBEa6WN6JIIP2USOQdU3lZWQUnX64GH7lt7Ef+bEtU8/knbf19uvGv2fnDxwNItmAG+
	fOsxQ
X-Gm-Gg: ASbGncukiH2zCICioZhckYloBWSOB+Pxi5NBoEA2gPq0PEtMctTvX/scifpEGtZvLGD
	oOOdcACEPRXLiOL14B6LLldCumdypK2/ATHrIqyGkBNOKw7p+r9ND9bsZBPospKPEFsbT5YqZqz
	ZzSAZUQzQmmTH5KTQkcpOTRzTKSj1N33JgYEIeBWkyeeey13aHNnllmullOj4STyaQywJyHRbr1
	eyfB4s9lDJZSo/6/R0Tt04RbMkXR6O2nq80PYhi7uvIFyqZZ94xSTelbJuTiNvfgZecZdLd0OOo
	+jxEgTN1ju191xKP0LGK9b+ec+Run6EvGZQL1m399VB+xOEaaRD4+zsI1fjUMAQnm60AczUdiFl
	GqF6W1Fdj/3SaM4YOeDEvCYQY6sHPNPdsj1HjGo5BH2LGunro4w2K/4q5YBmdsDgew2MVLyCEJP
	YqQ6Am4XDJ
X-Google-Smtp-Source: AGHT+IGjA23tvAZuH5Fq8qbpwfwhvPLpYMFxBPb4vtFLrVRQns+WibQzgzmRq3jADWMlr7NuQ4L20A==
X-Received: by 2002:a05:620a:4043:b0:7d4:65ea:763e with SMTP id af79cd13be357-7e34362c57amr1351352385a.50.1752847869221;
        Fri, 18 Jul 2025 07:11:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356a0732dsm92368785a.0.2025.07.18.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:11:08 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][PATCH 0/4] master-next updates
Date: Fri, 18 Jul 2025 10:10:55 -0400
Message-ID: <cover.1752846514.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 14:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1811

Roll up the submissions since the first batch of whinlatter fixes,
plus an upgrade of scap-security-guide to get it building again
after the CMake 4.0 upgrade in oe-core.

A note about the ptest removal for scap-security-guide; while
having comprehensive ptests is desirable, from the commit history
it is clear that there was no interest in banging these ones into
a working state in the last couple of years.  As well, ptests are
not enabled in most of the current CI build configurations, and it
seems clear that the build time hit would be massive in this case
if they were.  If someone motivated to try to investigate resolving
these issues appears, this decision can be revisited.

Changes:

Clayton Casciato (1):
  suricata: fix "interface" arg in systemd service

Haixiao Yan (1):
  samhain: Adapt test output to Automake format for ptest compatibility

Scott Murray (1):
  scap-security-guide: upgrade 0.1.76 -> 0.1.77

Yi Zhao (1):
  scap-security-guide: disable ptest

 .../scap-security-guide/files/run-ptest       |   7 --
 ....1.76.bb => scap-security-guide_0.1.77.bb} |  54 +---------
 ...t-output-to-match-Automake-standards.patch | 102 ++++++++++++++++++
 recipes-ids/samhain/samhain.inc               |   1 +
 recipes-ids/suricata/files/suricata.service   |   2 +-
 5 files changed, 106 insertions(+), 60 deletions(-)
 delete mode 100644 recipes-compliance/scap-security-guide/files/run-ptest
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} (50%)
 create mode 100644 recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch

-- 
2.50.0


