Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EEECD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 10:48:16 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51734.1780915687046820716
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Jun 2026 03:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=IFiVM/C3;
 spf=pass (domain: 0leil.net, ip: 45.157.188.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gYpfX65yhzkXJ;
	Mon,  8 Jun 2026 12:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1780915684;
	bh=Ih/lNsPwIwBtmcaUOesg+xjodZN/L6C/z1p3cRRI0Jk=;
	h=From:Subject:Date:To:Cc:From;
	b=IFiVM/C3OXKBnO17s6PqHOr9xsiax65xKtImjFaass8Jl1ICPoPnZ/uBrrSZIUH/M
	 lVoEMIHM0aomDfRmgppSBKFjiTxc4mdXvSjHCUpTVST/jMCgkImW0IWLHNQgQB8CXM
	 8c2BKjhp91ury3BSwEJaQsxjUGnOzQGLk3e5yIrObQ89h7C92g4iAxF7dN2PUtTP2E
	 XxOazNEiNuaZJNrRDFQhli6n1NMtb9FyBag94QGwQvTH2bEzq/T4NoJ0b0+jZ37mKv
	 3HCycTW2l9h8BA8Wj5a/9GoBki8Fi4z7EK2V7zGsLR8q93+2xYnQo4mc9aFcLaAWuH
	 WNW5WPwPFfA5g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gYpfX1dNjzM1d;
	Mon,  8 Jun 2026 12:48:04 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH wic 0/2] README.md: add single git command as example + add
 Trevor in Cc
Date: Mon, 08 Jun 2026 12:47:57 +0200
Message-Id: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwML3ZJ83eRk3RRLo0RjA3NTA4tUcyWg2oKi1LTMCrA50UrlmclKsRD
 B4tKkrNTkEpAJSrW1AJ0vxX9uAAAA
X-Change-ID: 20260608-to-cc-d92a307508e7
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 10:48:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4175

Provide an example on how to generate the patches correctly (I have not
tested this personally, I took the example from meta-perl in
meta-openembedded).

Add Trevor in the Cc recipients in README.md to match what b4 is
configured to do in .b4-config (as suggested by Trevor[1]).

[1] https://lore.kernel.org/yocto-patches/aiHUEFS-ucG_p3kV@localhost.localdomain/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      README.md: add example instruction for sending patches
      README.md: add Trevor (the maintainer)'s mail as Cc recipients

 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)
---
base-commit: 1f9e8c77c0494f51a58ed139497bbe1bde0898de
change-id: 20260608-to-cc-d92a307508e7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


