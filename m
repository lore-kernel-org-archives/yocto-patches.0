Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87540D2ECE9
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44335.1768855217321221152
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Bjb+aF1e;
 spf=pass (domain: konsulko.com, ip: 209.85.222.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c59bce68a1so297728385a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855216; x=1769460016; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd95pWZPcEEQP9/Z6cQNOI6JvwsFIKU/RqcnCvoKGIk=;
        b=Bjb+aF1erIn5+CQfiSHry9DmV6NULdR8+30S+B6zjOdMpRy8OaOOrzpG75KCrKD4Ll
         2QtNFFsn+pNYg4bdvaVmYarBgHw1lHx63TZasWD2ctrCJNYMpasxnHjflgprVUjPyQ4/
         VaFGumFwpkzmuQU8cZ2knN++WgdCRWkSt/mnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855216; x=1769460016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd95pWZPcEEQP9/Z6cQNOI6JvwsFIKU/RqcnCvoKGIk=;
        b=Frijfo9kzw+NXNKNMRkqNB+z8XIFXlwjagMxxLaOuH6HECeUy6mspI+YDJOPHZ7SBr
         eEv4YcMofWTkJDjZIeqZiARl0nUEXGysPMEhLcyCeLzqYUkybWfP8aQHkZn07x6oeNMn
         Y9a8KIc7zD23nEeqBwdiYNo1uBfKw/ITZChAO8QBf549sEnsqiASR3VBme6ILHc10onN
         6SXfl8m50t4vCmElzrRCHHYDXv/+ZGql4hgCp2Iccr65kXlbsQcYrKG5H6hiC01/0W+9
         BwDEWlYihX2bFyVzgUzLMS7QnQ2hBIf2X4OZ62RdeWmDbC1psLbZCYpX6vCHeqThUaT3
         9ppQ==
X-Gm-Message-State: AOJu0YwLoQR7NOgFoLyExCbK+8XTUKGTMLTzwmqN5CXC2i8kjjAZEA7k
	v6OdypGkdaoUkWrz7IXlcMkJ5M6gCGE329aPZ53aj8SMuuQZtD61Jai+o3D3bx34iULQO/bVCXU
	3tw6aq8E=
X-Gm-Gg: AY/fxX6ZasGXZVxyONkDjUSyElew4SNTQph3ZaW+5hIyWTVen743/kW4wqQrZWGVOV2
	eNEZJtMO/jnRHfidHRwq9hRnflizGzfp2hnp6438ycuISXyi5rfC6uiBlOoh10oJD+hdMT+rXAU
	d3nNskkB0q4tvDRM9Rxft0gyA97T7wmh/ul/+cIq9tZliGh7P5WFX9XI29tPgoaZ1maVfwmNR0u
	J9s6ydFxj1EJB5PkbhN6Fd9/gX2cXZgV1wakRx+dFUtQBha3ym/IokbXjcB+S00T0+TbpxgKSpZ
	4Ac5X7GukQeet/g11l/ztPypMlXBdGiXqe1rVqXhV4/iXR752iHgB6QtAs08u7PmRGc4g48R9nr
	KCyfctTC3ks0RISmkGy9DVUoY6yNYfkM8sgH2FuwZFuYDjHixhGXIbrpEaoCLFLwSpeHFZnqsTg
	biM8zQyvSscLAM3jos56CdK/MYI8kD8BvaTaAbof9KNPIicntTlX+UI6Ndbhb7k2dobfSWm0M/S
	/oJjX/Vgbjr/Nk1pCNJUX+bEpaO6hrLrHWwzJOlgtNVI1iSzcJs
X-Received: by 2002:a05:620a:1912:b0:811:f742:c752 with SMTP id af79cd13be357-8c6a6718331mr1863399985a.36.1768855215939;
        Mon, 19 Jan 2026 12:40:15 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:15 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 0/6] Assorted updates 01/19
Date: Mon, 19 Jan 2026 15:39:55 -0500
Message-ID: <cover.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3024

This patch series rolls up the contributed patches from the past couple
weeks, plus backported lynis updates and a sssd update from myself.
These changes are queued on the scarthgap-next branch if you would like
to check them out to test yourself.  I intend to merge these to scarthgap
branch at end of day tomorrow (Eastern Time, Jan. 20) unless there are
objections.

Scott


Changes:

Marta Rybczynska (1):
  lynis: move to GitHub fetching

Michael Opdenacker (1):
  lynis: update to 3.1.5

Scott Murray (2):
  sssd: Upgrade to 2.9.7
  lynis: upgrade to 3.1.6

Vijay Anusuri (2):
  sssd: Upgrade 2.9.2 -> 2.9.5
  sssd: Fix for CVE-2025-11561

 .../0001-sssctl-add-error-analyzer.patch      | 42 +++++++++-------
 .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
 .../sssd/files/drop_ntpdate_chk.patch         | 17 +++++--
 .../sssd/files/fix-ldblibdir.patch            |  9 +++-
 .../recipes-security/sssd/files/fix_gid.patch | 16 ++++--
 .../sssd/files/musl_fixup.patch               | 34 +++++++------
 .../recipes-security/sssd/files/no_gen.patch  | 18 ++++---
 .../sssd/{sssd_2.9.2.bb => sssd_2.9.7.bb}     |  3 +-
 .../lynis/{lynis_3.1.4.bb => lynis_3.1.6.bb}  |  6 +--
 9 files changed, 141 insertions(+), 54 deletions(-)
 create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.7.bb} (98%)
 rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.6.bb} (87%)

-- 
2.51.0


