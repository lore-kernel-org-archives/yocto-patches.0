Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3063C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 16:51:34 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.40939.1737391887259064371
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 08:51:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=p1yqVXaR;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 50KGpOAV1870085
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 17:51:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1737391885;
	bh=0X0lqAdSBgGeqhZqfrRfXUW7J1TyldfNgkuvb+NsyFM=; l=2556;
	h=From:To:Cc:Subject:Date;
	b=p1yqVXaR1eJShYkTWGZs/NoFh2wt65Vv7fWCVJs+dD9VXyHsPwM2+TePHrA6vPcJr
	 xhwwsfVdEqC6hYTS2ceXlecR/NlP5J6nIuAh7kxizDa4HHiwMPjq1VO6hAAy7zfbzz
	 hphlpTnrOoxXp7KBHxa01AXYsUN8+b0iHpY+EmseoyXW1OODG04qrJrurR66Vcy0hA
	 cquHPBjqYqtJbMM5eTQ2XEDtPG6WGAg2TIHfXEx6HM0JHWZXOVmtkPHvWdfc45b0Vi
	 5WNfh5lLYIQnrTcC9yoOVNoKrvm6S/waIX9Gbu64E/GzmjidZg25lQgBDrV0lE99Fx
	 HfD7Us0Z70twg==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTP id 50KGpMQq178672
	for <yocto-patches@lists.yoctoproject.org> from enrico.scholz@sigma-chemnitz.de; Mon, 20 Jan 2025 17:51:23 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id B494ITJ2ZB; Mon, 20 Jan 2025 17:51:20 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 50KGpKw81815319
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 20 Jan 2025 17:51:20 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1tZuzg-000000035ul-1Fc6;
	Mon, 20 Jan 2025 17:51:20 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] classes: rename to classes-recipes/
Date: Mon, 20 Jan 2025 17:51:17 +0100
Message-ID: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 678e7f088c284250d7b37cbb
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 16:51:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/988

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

bitbake looks first in 'classes-recipes/' and then in 'classes/'.
Hence, content had no effect and was just ignored.

Rename folder so that it overrides the OE-core classes.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 {classes => classes-recipe}/cargo-update-recipe-crates.bbclass | 0
 {classes => classes-recipe}/cargo.bbclass                      | 0
 {classes => classes-recipe}/cargo_c.bbclass                    | 0
 {classes => classes-recipe}/cargo_common.bbclass               | 0
 {classes => classes-recipe}/rust-common.bbclass                | 0
 {classes => classes-recipe}/rust-target-config.bbclass         | 0
 {classes => classes-recipe}/rust.bbclass                       | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename {classes => classes-recipe}/cargo-update-recipe-crates.bbclass (100%)
 rename {classes => classes-recipe}/cargo.bbclass (100%)
 rename {classes => classes-recipe}/cargo_c.bbclass (100%)
 rename {classes => classes-recipe}/cargo_common.bbclass (100%)
 rename {classes => classes-recipe}/rust-common.bbclass (100%)
 rename {classes => classes-recipe}/rust-target-config.bbclass (100%)
 rename {classes => classes-recipe}/rust.bbclass (100%)

diff --git a/classes/cargo-update-recipe-crates.bbclass b/classes-recipe/cargo-update-recipe-crates.bbclass
similarity index 100%
rename from classes/cargo-update-recipe-crates.bbclass
rename to classes-recipe/cargo-update-recipe-crates.bbclass
diff --git a/classes/cargo.bbclass b/classes-recipe/cargo.bbclass
similarity index 100%
rename from classes/cargo.bbclass
rename to classes-recipe/cargo.bbclass
diff --git a/classes/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
similarity index 100%
rename from classes/cargo_c.bbclass
rename to classes-recipe/cargo_c.bbclass
diff --git a/classes/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
similarity index 100%
rename from classes/cargo_common.bbclass
rename to classes-recipe/cargo_common.bbclass
diff --git a/classes/rust-common.bbclass b/classes-recipe/rust-common.bbclass
similarity index 100%
rename from classes/rust-common.bbclass
rename to classes-recipe/rust-common.bbclass
diff --git a/classes/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
similarity index 100%
rename from classes/rust-target-config.bbclass
rename to classes-recipe/rust-target-config.bbclass
diff --git a/classes/rust.bbclass b/classes-recipe/rust.bbclass
similarity index 100%
rename from classes/rust.bbclass
rename to classes-recipe/rust.bbclass
-- 
2.48.1


