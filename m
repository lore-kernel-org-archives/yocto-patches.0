Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD1C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 05:08:18 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5176.1785215297658737713
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 22:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JeJXuljz;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso4616250b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785215297; x=1785820097; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3b8AAKTOA8NNW0m5qZ2IqB5Jt0WFEGanYlp/iamMqX0=;
        b=JeJXuljz6FOstdQF/qd4/7Q0POqbIlQWRVsLUkwS6fg+twC9BB/gERbn3+ZBrgGUx1
         gRW35fv+0sku0Zc1F4WQTj4lcRG3CkwahIaZfYxGHf7ygONcYuCFSFuLwEaSQWvJmlpX
         LmyqpK0dimkfy4M6TdR3HW8139HmeY4ppEPmdK/gLcDsk+kh+8r10MjkGBIQ5teak4az
         qehZre83cugdRRnDQNPq3VAQ2CodouidRNBnXwdhvqyvc9+xRhLa2/rbTU/SCYayYn0w
         0ofwj2+uNryPi2ToGhdc676Bjqh4DZwNAPzSgTLddi6Y/+Y2ezZkHrQtLwGhCw/N2CXf
         NU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785215297; x=1785820097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3b8AAKTOA8NNW0m5qZ2IqB5Jt0WFEGanYlp/iamMqX0=;
        b=GBFN0VZenFIUXRgpmbxHGAu/ACy8QpT7YkJ/dlZwF7aXrirC6gjb/AblW2/ywh6WGm
         Hz/3dMnymM6qP2MWMU9PM8Kd8ZvgnYpgHzDqVaaeoNz/z2cNljHXkHFh5Ts87HKtIg9T
         lDyifYAypxSO/5gA3qcc7R3czvczr55NqCpZeAtUuEAUw0P4/rN9K7/PPUuMww5t2gJt
         ZOeWkhc6AAB3v4jbAY5rQM6MXSK91Ih6PFXmUcLgwnxTQ1d0JVAL4llhZtNjfWSxTy9o
         VMaNi43+J97efefiNQEdQBvX60gLXOZruObgHzrZWEJGyJc0/fqesb8OA35wccvhTrQ3
         DkKw==
X-Gm-Message-State: AOJu0YwZFp8+xCXf4C/rRpc9U7kmUP10ZnPKDmadAiYq/NAfmrwujR/A
	sD5qmHcTtcHWlC6IKwEXwRyagzeL1bikLEDnrjrtYYVfuQZLpWUvX0utJ6i+CVpti2c=
X-Gm-Gg: AR+sD13UX9aA7s0XpzRpo35p2aTFaJe58zPweXwQE4tIvgWvpWkxopUtOdWsVF2BrPt
	W6NhEO3jyH8R2WqNPHoOxYmV265+4Fx92z9xa/WxSge8DQ6nqrYHJAJrmnxONt9OzpYPSjiQ31V
	lhtXGTTko1WU2jpw0qqpNfUN3kkB/naPQ0PJbttJsaG+6auA1Q6GWbs9Nvj8pLtjgI0oop1jAqc
	G4B1VMe5WEv9xs0Sbc6ECPP3Rd9V0LET59dKDSmxUtiTDNReLiEIm0NlWLN2RlKRHRqO3FOw8Ch
	Txj4YbY7x2MrrFS2wO/y+sRn5by7lGRdl95F2SO3b42UvoRuHe+9nNaHtB2ZFUm308UF+cQkhLy
	hfniJcBnXoaP9wtw4/ZA8R2IdjRxVsEb7NZf77qyGXr/Ex7i0E31U7h9EuDiW+MWPmac3WsF2XP
	Q1b1UftFiB1Zb0
X-Received: by 2002:a05:6a00:2e28:b0:848:2f77:e2e2 with SMTP id d2e1a72fcca58-84e933abf71mr848965b3a.75.1785215296840;
        Mon, 27 Jul 2026 22:08:16 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1386sm3862490b3a.36.2026.07.27.22.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:08:16 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every pseudo fd, then drop one
Date: Tue, 28 Jul 2026 05:08:15 +0000
Message-ID: <20260728050815.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718043750.7-1-bbnpreetsingh@gmail.com>
References: <20260718043750.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 05:08:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4552

Hi Richard, Mark,

A gentle ping on this series and the close_range v2 it stacks on
(which Richard okayed on-list on 16 Jul).

I noticed pseudo master has moved since (now ca47829, with the
memory-handling and openat2 changes). I've checked that both series
still apply cleanly on top of current master, so no rebase is needed.
Happy to rebase and resend anyway if that's more convenient.

Thanks,
Baban

