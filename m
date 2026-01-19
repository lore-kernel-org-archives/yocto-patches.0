Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F1D2ECE1
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:32:03 +0000 (UTC)
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44160.1768854720228595444
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:32:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uU/lZ5p4;
 spf=pass (domain: konsulko.com, ip: 209.85.222.196, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c5389c3d4cso523826185a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854719; x=1769459519; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0A8VlpXu2EzmifXhJtSdNfS2jmfZIDeeKcTMm4YnUc=;
        b=uU/lZ5p4aNUtAGtWltN/fnqs6YZyqawhUzK/Ah/LAvmrx9TWKvnBAO/mnDCdUIB9Ml
         xpkQLf2WAouWhwPWCcCXLFXnuW6TBqpZTdie3WO//Vgc0q4yDHLlNPhryGWCU7EgqII5
         Hx20EMWMgiqBzVICDy93wQgxq1oaEE6hKcuxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854719; x=1769459519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0A8VlpXu2EzmifXhJtSdNfS2jmfZIDeeKcTMm4YnUc=;
        b=wK/Qs8aN/T4+kPKIH9QWIQnHz7FhfnVgQE+WpAmFbor4Sekmbul5gRosZ9S4rgcw4D
         v2iPfwTyP7oQOJCGOV6sBVOMPRUQkUDjRdfaK5CxFwVmP+lZ6qpcxE6RU6QZwfFtnC5H
         MASF0uS/jJMe8NMswVAIcdS1AnzgOfcgjSNseAZNwRgbhW/HqlbaiqX04RYohahcsC4T
         ZXCTz7m4V6/Gw6WZBxAbfSEwBghchGVK/hy/ABzu6OUigfSufZcFTDk/E9PMgqtqrjdu
         Mlxnw8+Jgt+IJ2duXYP82KnVaERu2DCBId8Qe+U4ViQkJuy929kS55y8pCEJiagGsrsC
         YNkw==
X-Gm-Message-State: AOJu0YwqGJSD8MGpWyL8hWd2WC8g7sKnBv/cmlCRbbx9fnW4YvAsJMCF
	qkIVOlX/gbRuskD6E0nvQFjdRS7uxqLgywFDkRrBvDF2Q/cn75I32SyMbH/7n/EiaGjRJIEECLl
	aid7wK8s=
X-Gm-Gg: AY/fxX7BYHu290ZX7K90Q5z3U/1ntuPtY0HSPoJ9Zg44OD8OZf/WCDKhgkVGH0t5B5x
	D2xCBbW/ZPgdYnuCLvifLT/CdPclFMdVQsnViTuLyXxjrgc0yJ4wJmQUhwZPM/yWM9rBD2UFJ+t
	TOmlJNjZfHLQ2/X0VbvUNPFbV15nVVOOd4SoYn3Y4nRBZ6KSTBDMawUFPzQsFa53khWjF4wTKkI
	VFIWNNGASslQMUIerbMovKgzR2GL1H/swWyGGWhRsrIDj3MY/buZ6PSt7wJT1wBau/H9UOFnV9k
	AWEPbqKMTa69MrCdK/PpHApDcR8l1M6fwBm+6FiYbGFD+u5M039Aq0VShpU4eJcJNvtqFvagmFJ
	zv9pClDnvN3+lxQfehXGHp0dez5m/IEXC7FcBvitE4TaNrXN799CHajsR5P0IN0Kn2DOhCpr6BZ
	mI1uI1QPR9x07FjZFmnJr4TkoSKVRbEHA1WPzSWLkDZ63P4l3tfhi0jC3+jGS/w1ONaloOQx7uX
	NNCDXHSrcpefHp5ztltvbf81KwtHKjyx6NZrRefM2cDcmzhrkj6
X-Received: by 2002:a05:620a:1a86:b0:8c6:a213:8fe0 with SMTP id af79cd13be357-8c6a66e449cmr1567130285a.23.1768854718835;
        Mon, 19 Jan 2026 12:31:58 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm860337485a.25.2026.01.19.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:31:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][whinlatter][PATCH 0/3] Assorted updates 01/19
Date: Mon, 19 Jan 2026 15:31:50 -0500
Message-ID: <cover.1768854613.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:32:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3018

This patch series rolls up the contributed patches from the past couple
weeks, plus a lynis update from myself.  These changes are queued on
the whinlatter-next branch if you would like to check them out to test
yourself.  I intend to merge these to master branch at end of day
tomorrow (Eastern Time, Jan. 20) unless there are objections.

Scott


Changes:

Clayton Casciato (1):
  suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute

Scott Murray (1):
  lynis: upgrade to 3.1.6

Stephan Wurm (1):
  dm-verity-img.bbclass: filter units from value part

 classes/dm-verity-img.bbclass                     |  4 ++--
 .../lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb}      |  2 +-
 recipes-ids/suricata/files/suricata.service       |  1 +
 recipes-ids/suricata/suricata_7.0.13.bb           | 15 ++++++++++++++-
 4 files changed, 18 insertions(+), 4 deletions(-)
 rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)

-- 
2.51.0


