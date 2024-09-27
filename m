Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7626ECDD1A9
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:59:24 +0000 (UTC)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
 by mx.groups.io with SMTP id smtpd.web10.68251.1727441960015666550
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.174, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVsf0mftzrms;
	Fri, 27 Sep 2024 14:59:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVsd5THlz2Kj;
	Fri, 27 Sep 2024 14:59:17 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/2] rk35xx: add support for upstream TF-A
Date: Fri, 27 Sep 2024 14:59:02 +0200
Message-Id: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABas9mYC/02NS2oDMRBErzL0Og3S6DOfqwQvWkorbpyZUSTZB
 IzvHuGEkGVR9erdoXIRrrAOdyh8kyrH3oN+GSCeaX9nlLeeYVSjVcs4YbkYh9dcW2HasCUkNM5
 PXtnFpaihg7lwkq/n6Sts3AjLES/xLBlOP3Xhz2tXtd/Nn2kd/nmC7FjzhzQsHCVzRa+dMklNM
 wW/3p6uQJUxHtsmrcOWrNakp2TmxTsVbWQyc+CkU/9cdG8ozAynx+Mbje7nefoAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 12:59:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/682

Upstream TF-A (> 2.11; no release yet) has gained initial support for
the RK356x and RK3588 so one may be interested in using it.

The default still is to use the downstream blob but the option is now
given to the user who can simply change the value of
PREFERRED_PROVIDER_trusted-firmware-a in their own configuration file in
order to use upstream TF-A.

This depends on two different patch series that have yet to be merged:
- https://lore.kernel.org/yocto-patches/20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de/
  for meta-rockchip
- https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/
  for meta-arm

Only the RK3588 support was build and boot tested as I don't own any
RK356x board.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      rk356x: add support for upstream TF-A
      rk3588(s): add support for upstream TF-A

 conf/machine/include/rk3566.inc                    |  3 +++
 conf/machine/include/rk3568.inc                    |  3 +++
 conf/machine/include/rk3588s.inc                   |  3 +++
 .../trusted-firmware-a_%.bbappend                  | 23 ++++++++++++++++++++++
 4 files changed, 32 insertions(+)
---
base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
change-id: 20240927-rk35-upstream-tf-a-356760495fc1
prerequisite-change-id: 20240927-rkbin-split-recipes-61503f078ab6:v1
prerequisite-patch-id: 852459a4ef85dcfa74407f5455af93ac5e2ab3ee
prerequisite-patch-id: 0ed848000063d5b8b9dbc02f63e09a199e90bd64
prerequisite-patch-id: f665b620ee911de701142439dd00566dd12131d2

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


