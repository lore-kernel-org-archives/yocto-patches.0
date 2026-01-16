Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E8D47CC2
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 10:00:45 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2769.1768557635934753778
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 Jan 2026 02:00:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jWH6E5R6;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-655af782859so805911a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557634; x=1769162434; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrryZ2EjDqE8xFzUcw25tOkdr5/zdvPLotZZ+NE8ko4=;
        b=jWH6E5R6asehCovgbtDbLGUOEvjhLqsIQEtaSiiJZZ58ZTEpUFRTdHqaAHWK9YLKd0
         y66JP9Bw96xXkTnxeNa3nzXrp0jleKbj781Q9kXy0OVSAX2N+kMfwXP/DPeTrKNtUxXE
         KuxRH1ykoIdGJe15OvkeVZ5b5VPqQQiK7a35sVALkyxPE4llP1/JqRGbZ7+/kUM+Pvaj
         bP+Q0/42Ajuf89EG24MWNMsqIdLRRe5RGAEJQY0hxhu7yXpzifiV8djiRH834yycK4+H
         Pe66/yEEHs4j5l5HVZC94lA0J0g9QMLtI48XeSxxuCXHYL7GG/3uZ0bLFNZJYczzmb/0
         qtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557634; x=1769162434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrryZ2EjDqE8xFzUcw25tOkdr5/zdvPLotZZ+NE8ko4=;
        b=kRH8fQ+7l2qGe+SRVkAZB1g/W4P49lBr8R7eh7cVXjsD1cAeqSWY17QAMQTYRE+9Ij
         O61dhzjZ1td6r/gV9baZ1PzqgjbCrlgk5Skcb4PSLBw7nSdraqOtN6Qte9/Q0tvXAzeu
         qPoe/vwsIZjARI8eqvegvgaZJx1ru2/uTBEfhmfjdROcax6tDDdpUckUNUDjGrLy2H7P
         B0rQy6++DsGkhc9lyKCcu/dhTCPZXpajPaxS+WH833cy5NQvZnHaKnjiwS5W4+NUw+Bf
         dz3SYCUvqxa4YvW8r9nB2Xujt7L+2fgkoXe53T1T1aGK8dS3x21jTSmjViSw+msx+ONx
         XSVA==
X-Gm-Message-State: AOJu0YwMrHOszABE/JC776zS5kqv/B8RsGm4RNAyg9ElvmRwoUbfc8qf
	4qmEsXiqnjK/onwW1dh54onoX7TtojSz2ag/yy+7upGtIH8RqbV/lkN7AOq+9BIX
X-Gm-Gg: AY/fxX4eojSyDRzrWQ1H9UJwsVeC9+6CRWUB1YAi1YkfgJjU0n21v4dqa0T3uElKL7f
	Yti/LlKhN/brmnSY9IXWBQs+n1hlzNt9A+Y99huw7h2bSe6Ik1EOLH52QkQ9SPO7MZESCneXXMc
	s1zn7YRpwAzf3UQwDiigUOVjn66VVOKUqo/u6C1fia+f7s1lp68ytjH2r/gkONOSViqTtz5cZtx
	97cxh89k3rrPQfGIs349OQ4LjDvakdEWFG9QixU8MAnksPHzeFyJQuv8t0ZZ/XsINUEUk+w88K5
	J1aHJtB+2qgADXFSgU+GWx44CwwoKth48zoR9ASAhGVLfRft+b/TVHgWEhf6fQnYR4Unpf6yFlE
	qXJ/sgquV/mP6M/QO5bkUAzSqKjCua0Lv8KzBFZBn8gRft08CktEJdG1l/bJyUxRQMrFY3udwVc
	5OC2V92+eM8RbdD/w3VQ5Bmk1krw36w3Ir9FzU3BQ/J9U=
X-Received: by 2002:a17:907:7201:b0:b72:70ad:b8f0 with SMTP id a640c23a62f3a-b8793244100mr222418366b.36.1768557633895;
        Fri, 16 Jan 2026 02:00:33 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:3036:26b:2ae1:326c:bbe5:35b0:aead])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca4casm190229366b.34.2026.01.16.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:00:33 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json: auh: remove the git hook that disables commits
Date: Fri, 16 Jan 2026 11:00:24 +0100
Message-ID: <20260116100024.3644730-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 10:00:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2999

From: Alexander Kanavin <alex@linutronix.de>

bitbake-setup adds this hook to prevent commits in git checkouts
as such commits can be overwritten on bitbake-setup updates, but auh
does need to make commits there and isn't using update functionality.
Rather than make a separate writeable clone, let's just remove the
hook before starting auh.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 3229cde..4f6d305 100644
--- a/config.json
+++ b/config.json
@@ -1625,6 +1625,7 @@
                     "git -C ../layers/openembedded-core config user.email auh@yoctoproject.org",
                     "git -C ../layers/openembedded-core config user.name 'Auto Upgrade Helper'",
                     "git -C ../layers/openembedded-core switch -C tmp-auh-upgrades HEAD",
+                    "rm -f ../layers/openembedded-core/.git/hooks/pre-commit",
                     "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./upgrade-helper/upgrade-helper.conf"
                 ]
             },
-- 
2.47.2


