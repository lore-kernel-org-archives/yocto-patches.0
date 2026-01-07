Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE2CFD648
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 15:00:26 +0000 (UTC)
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7725.1767798025093354476
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 07:00:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gw2+utAF;
 spf=pass (domain: konsulko.com, ip: 209.85.160.196, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4eda6a8cc12so22544811cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767798024; x=1768402824; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7+E+XIi3V/MKuqQmIgec/8GGkGvaX04duKYUFQmapQ=;
        b=gw2+utAFHUhuIHHeiUmV+OKBFWuAVe9YDE6SKzgmPClCxcz3JoSV3j3nde5dlhnaCl
         nMxMqUKNWo8BKIaJnqEDzXO7JxzqsSg2p8GwEsvAKX5X0yMV9vzntvsvzJVlVuBsFm9o
         eKARBK4jIn6hubs/l1e7HKehtuFX10OlejzZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798024; x=1768402824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7+E+XIi3V/MKuqQmIgec/8GGkGvaX04duKYUFQmapQ=;
        b=GPFvDg2bywE1sed+c88SQb7SsF4VktCBKhJ+cV35RkzKuIGnUeOU2ob75TTrXm6Esk
         qRtN15+qXbRgakD+E2KSF04FbL27uwzo/Gh50gkdRf7dKsnSQHtD3263L6gnzJcocEDU
         E7vv0rFlTpLliqRyfCsV31/+u1C7jQdNrDizaEsBx222z+DrD+xXgnBLD7mUyxy8hxpf
         am935e94V+nZ5a+PeWwNfOsXc1+/s9rUoEYyGBI2hjiBr4ud2INg3fFl3Tiky8c/ivsB
         5tDo0Mpj/DG0jjPxNRIAXNW0TQIiRB/6tgMCsesAZ1PdjL8q7QL5/US7kAdARJQvhx3z
         AOng==
X-Gm-Message-State: AOJu0YxlDMxlSRZ1EnSJUUuuwyz3a2JRjSWMgFcquxghamlf394ElEhJ
	sa5XCZtrGJySgpbu7tnto8SaVuKC5ssosqh906+NcnBwriSdIivwfMRwHj+i87d3vMBcnQ+oYjX
	8jZmVGCg=
X-Gm-Gg: AY/fxX4Bj6wbVLAksNLce3v+y6kTaSy2IgOc18n3EswCuscenXkW2LsJToTj5fLP5+G
	HtJh5OifvKnsIlZtQ/vsDeh0IEv+ZSOtJHuOt6R0gW9d/zAokwTwBhQAx+r2VqfKehLGso14ggC
	F0DKICH/MxbsxBt5R0uIswFG4Du0XBukaYGQyDX65OyaEZHz2iZZPr6U6couYSWuGqgvSgilvxR
	asPe/D67zprFtOAcrAxYCnDLcuRFySCPm+ApmLtxcoJZpcwxUbKNsydWXXvtS5+G7q9SnpPN4ZH
	7/P4Pk2867fVmcVpm1dGlXZXFb6DCF8+jKPy2rlmPhQ3FBtciNwm6Qb/dLX1pTocAX4uLnM4FgZ
	QXfUHzRMcaYQvC2hzo9w+A99ADcAaU3u9nADco9GKmAOxfYLydMJdQ2FuYDRQKfViNnOMPYpFhI
	hR8CQGXghA9cWEM8DLbWfmiexXRQZ2j/OTrlvgGk2pQDfFp6XVfTNs3AXS7wnbNhO+pycXyU3eu
	CX1jSSxGwUFXINJIPneCaKYA2rWSLgRrTJcQOOlVpyG4lZsN9FQ
X-Google-Smtp-Source: AGHT+IE6iSbdh5rY1/KPYmAPPJCOX0CD8E+d6KySukH5N+hYrN6t+6U06UoAK7XAvfeD06zDV3yXdQ==
X-Received: by 2002:a05:622a:608:b0:4e8:b4d1:ece2 with SMTP id d75a77b69052e-4ffb49054ffmr35552071cf.18.1767798023527;
        Wed, 07 Jan 2026 07:00:23 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d568cbsm34113551cf.11.2026.01.07.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:00:23 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH 0/4] Assorted updates 01/07
Date: Wed,  7 Jan 2026 10:00:05 -0500
Message-ID: <cover.1767797568.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 15:00:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2907

This patch series rolls up the contributed patches from the past few weeks,
plus some clean up changes from myself.  These changes are queued on the
master-next branch if you would like to check them out to test yourself.
I intend to merge these to master branch at end of day tomorrow (Eastern
Time, Jan. 8) unless there are objections.

I have not yet created the whinlatter branch due to some distractions over the
holidays, but that should happen by tomorrow as well now that some CI hiccups
have been fixed up.

Scott


Changes:

Clayton Casciato (2):
  suricata: drop trailing whitespace
  suricata: update PACKAGECONFIG[jansson] option to required

Scott Murray (2):
  meta-parsec: Remove meta-clang dependency
  Update kas configuration

 kas/kas-security-alt.yml                |  2 +-
 kas/kas-security-base.yml               | 18 +++++++++---------
 kas/kas-security-dm.yml                 |  2 +-
 kas/kas-security-parsec.yml             |  6 +-----
 meta-parsec/README.md                   |  6 ++----
 meta-parsec/conf/layer.conf             |  2 +-
 recipes-ids/suricata/suricata_7.0.13.bb | 20 +++++++++++---------
 7 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.51.0


