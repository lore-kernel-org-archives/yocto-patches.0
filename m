Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3CD46634
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.687.1768517212148487036
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=b7+K+cLU;
 spf=pass (domain: konsulko.com, ip: 209.85.222.193, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c0f13e4424so168868585a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517211; x=1769122011; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgubk4+AvRw7z73vD/HkGhwGeSGO4IZV9wplR+BkH1I=;
        b=b7+K+cLUt/FbviSsUdcgDfpYR+9MyUB7e3dWE4u68RZQXuJ7SDGUyTjHvHfWhSj6or
         SEUqF6rxMOsMpwKIxhp4mdOoC0VTnl1q7t7U0ZmStkXq9sA0tduIU6NzvtXiOJ0hBJAC
         uLRcmSAZj+ohDQmZHfgjMHmu9a5gwRDHY8K8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517211; x=1769122011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgubk4+AvRw7z73vD/HkGhwGeSGO4IZV9wplR+BkH1I=;
        b=MGfpoMZbf2Qor9WYLjHzy+eR/nj/36ccVPD5nm5mVGutpY8yeE+XabE34h171mEKTe
         ptwCaYpJtmf0Jcuk4XMJYTN8w9sqMh+3ZmHNuZmP6kZN4F56+gqpkddBuObczsIq/CO0
         hKdEE25nVFy+Ed+vUnsdqUSWpmP9zX2RhGiqzTdBDxYjVJDQNUWsEjv1Axd1UzPky2cB
         LnfEOIiXpuXp3Cy1Yk+UMJwMSo8fbWCc0cbN5Ka+nOtm3qEqHlCQyzTFR4YnzocC3qBL
         41VUYvB9YtfQe42zQvY60Ll/XBitPFNlwZqgnIwHFnmyic/8jeGj3E+YMcclXUf6G5gi
         6w7A==
X-Gm-Message-State: AOJu0YzCvgifrcOo1MjX9D/OqQ0y50ABWusDxcKPqylQ2Yx2YeaPrh5k
	BDJceUr6SrEvTfjmE9gUsEWuCHuESktYx/AzEmJArhTk6JEL/1HtL9hLrvNbabl0edl0LptMbzo
	YQPIBYOM=
X-Gm-Gg: AY/fxX4FM9+T4poVK0vr9EJNga2uaOn7OrtupdCZBylVLTMlkWteb6BN6J0kQ/2J6n4
	l8ub951Avq9cTiNeAQs1uJwMXHstqGOHW21C70fDNimp1kbvKDlhaKoOdtSXozDxHt/w2L9JllZ
	teq1ZzB9Jt7jGhPjcdVl91Yj9VGWGxrM8C9xgr5EF6WRh/jCDhCBNcZ4RaTwf2FG8PQTCPV0D9C
	a7eNFF2hH18oCnjJJn1w8LK8ssI6lvshJ17tPd80pIcy09U3uTO1wqxHcwfO7kAb8kZIrXxbmNc
	dJWvzFu+xMUc9AMF+5QLWMW6ONqV0Qc3fOvCOO8ByGhwVUnkX1Xz+NM3sjfCJ0joWpxh2km62mg
	XkVEqssOZg5R4diAWf5avlktQ46NsQfWqyBiNcI7oxxrAKcWzNRnyLmKODqA92pqRAOyJv9Gcxy
	T4OiAwAfyKGwqsMuMrbD/xG3J55OVRLZ224GSE6E9ijg2Jh07hkPsJesA5HerWydrqgyYzDX7mI
	xyBxZAONtBRlzCbxIFxaZ65YNC17o6kfdf00C9R9Zdr7bzRKQU7
X-Received: by 2002:a05:620a:28c5:b0:8c5:3045:3e7b with SMTP id af79cd13be357-8c6a66f1e53mr176265385a.26.1768517210821;
        Thu, 15 Jan 2026 14:46:50 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:50 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 0/9] Assorted fixes
Date: Thu, 15 Jan 2026 17:46:21 -0500
Message-ID: <cover.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2965

This patch series pulls together the couple of recent contributions
to kirkstone branch with selected backported changes for known broken
recipes plus getting the base CI build tests working.  These changes
are on the kirkstone-next branch of meta-security, and my plan is to
merge them to kirkstone tomorrow evening (EST) if there are no
objections.

Things to note:
- The Parsec and musl build tests fail, and given the impending EOL
  of kirkstone, debugging the failures is currently a low priority.
- checksecurity and lynis have ended up with minor upgrades due to
  the process of working through cherry-picking fixes from master.
  I believe in both cases the upgrades are minor enough to not be an
  issue, and that seems a small tradeoff for actually building now.
  I would have considered being a bit more aggressive with updating
  lynis, but it does not seem worthwhile given the impending kirkstone
  EOL, and no one having complained about the recipe not building.

Scott


Changes:

Armin Kuster (2):
  chkrootkit: update SRC_URI
  checksecurity: update to 2.0.16

Marta Rybczynska (3):
  CI: update build for new CI
  kas: update configuration
  checksecurity: update the debian package

Scott Murray (2):
  Update maintainers
  meta-security-compliance: Update lynis

Vijay Anusuri (2):
  sssd: Fix for CVE-2025-11561
  clamav: Fix for CVE-2024-20328

 .gitlab-ci.yml                                |  49 +++---
 README                                        |   4 +-
 conf/distro/include/maintainers.inc           |  72 ++++-----
 kas/kas-security-alt.yml                      |   4 +-
 kas/kas-security-base.yml                     |  21 ++-
 kas/kas-security-dm.yml                       |   2 +-
 kas/kas-security-parsec.yml                   |   4 +-
 kas/qemuarm64-musl.yml                        |   1 +
 kas/qemux86-musl.yml                          |   1 +
 kas/qemux86-test.yml                          |   4 +
 meta-hardening/README                         |   4 +-
 meta-integrity/README.md                      |   4 +-
 meta-parsec/README.md                         |   1 -
 .../lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb}  |   6 +-
 meta-tpm/README                               |   4 +-
 meta-tpm/conf/distro/include/maintainers.inc  |  33 ++--
 ...rity_2.0.15.bb => checksecurity_2.0.16.bb} |  17 +-
 ...k-setuid-use-more-portable-find-args.patch |  16 +-
 .../files/setuid-log-folder.patch             |  52 ------
 recipes-scanners/clamav/clamav_0.104.0.bb     |   1 +
 .../clamav/files/CVE-2024-20328.patch         | 153 ++++++++++++++++++
 recipes-scanners/rootkits/chkrootkit_0.55.bb  |   2 +-
 .../sssd/files/CVE-2025-11561.patch           |  50 ++++++
 recipes-security/sssd/sssd_2.5.2.bb           |   1 +
 24 files changed, 346 insertions(+), 160 deletions(-)
 rename meta-security-compliance/recipes-auditors/lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb} (84%)
 rename recipes-scanners/checksecurity/{checksecurity_2.0.15.bb => checksecurity_2.0.16.bb} (57%)
 delete mode 100644 recipes-scanners/checksecurity/files/setuid-log-folder.patch
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20328.patch
 create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch

-- 
2.51.0


