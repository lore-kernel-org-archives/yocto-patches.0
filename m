Return-Path: <florent.allard@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13858C3ABCB
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:05:06 +0000 (UTC)
Received: from fallard-pc.mtl.sfl (fallard-pc.mtl.sfl [208.88.110.46])
 by mx.groups.io with SMTP id smtpd.web10.54088.1747065903011967767
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 May 2025 09:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=none, err=permanent DNS error (domain: fallard-pc.mtl.sfl, ip: 208.88.110.46, mailfrom: fallard@fallard-pc.mtl.sfl)
Received: by fallard-pc.mtl.sfl (Postfix, from userid 1000)
	id 134B314BBEE; Mon, 12 May 2025 12:05:02 -0400 (EDT)
From: Florent Allard <florent.allard@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Florent Allard <florent.allard@savoirfairelinux.com>
Subject: [psplash][PATCH 0/2] Fixing autoconf options handling
Date: Mon, 12 May 2025 12:04:58 -0400
Message-ID: <20250512160500.244466-1-florent.allard@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 May 2025 16:05:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1546

This branch makes the handling of autoconf options more standard, by
using standard variable names, as well as using default variable values,
which makes the options compatible when either --enable-feature or
--disable-feature is passed as a command line option.

This is the standard way to work with autoconf as proposed by the
documentation: https://autotools.info/autoconf/arguments.html

Florent Allard (2):
  configure.ac: standardize default-enabled options
  configure.ac: fix autoconf code for img_fullscreen

 configure.ac | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


