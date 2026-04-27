Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB54FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:35:30 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40475.1777286128303256826
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=m42iotR0;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ec37d52c0dso1012149485a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286127; cv=none;
        d=google.com; s=arc-20240605;
        b=YBbze+vOs5ZTq5e6C9znQSsGjYaZFGEd789misBuT95ImhoPkBrCiEz3ifJ+lwMFTU
         LsHdiz/4w9ZvzLDvBky1hv1Vio/QpJcOzX+uXG9YJdMjjkEkbHmk3pwbLJDHl3JIycGX
         5uUg9ZSUaQ7R759+PR/PTpM1o8aKWkaf1GuNZitkg2TkyFQaJeoMAd8JJ/YdZl1HvLgj
         SHLqOhrTkgLkp5tttQdTrGcUpWHZ5b/57Tka9ABkluGR79xqE1BTXuLPJSNaR57sF3XW
         PqG/8FnkqMB8WGBc/GYq2lPsN+yFYywxcDOFBNW2k+Vj40M1yTACXXXsStAnjqyIQBD6
         MfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L7g8PGVKtEMJYR9QiHMqLvFKetFv6ZnXfbPzoWtuAIk=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=OYgh+uPYEiokFyvlHbZ4AlXmIzDtxB1niMZoBIL5VnIbtoofldJ1C0W+LxYkdyw9yw
         E7eN3NCwSuZbv06mMYBBn8XYSwrvvdAOQxufV9gptRB5L97lX16O4FiK4VJj2yoBP21V
         UW7JG3WKmKEincLXtM31EP4OAAPSK3uj9lhMgVlrQWAGuz66qnEH4dY4l9kIibnVICLi
         d5NGWXJhnrqHPN0uFxQK/+xBunf7cMyDLWClb/dfmODtJLfkJX+Z7gVj3vfEraY9IRHn
         iUL/CQv8lkijGwbOgJQ647tV8vOQyVxe+TxWEHYon2pMRU5O4lCNKh1K3MwSSOxkxaaH
         thAA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286127; x=1777890927; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7g8PGVKtEMJYR9QiHMqLvFKetFv6ZnXfbPzoWtuAIk=;
        b=m42iotR0c8h4tSpLXrnLxyM0OvLgl0CW8lkd/LaW5BHWsgucFYekpig8uqciZrbRoM
         QLWcIGi6Wy6xMYv9ZVMrjZjnqfk2QOJg8HgNW/HUh9BiPgzjv/dsJ1a409KxwvcXtrEM
         RC66Dpqjwl5SmxENucL6xyPJD0JgkHB7JqKcOKkdOVMIaEcbL/kNhH1xeIwzLVrAbzaE
         NwU4V4FR7d8lJPzpC8iUA1q47RI5gWOhWT2+AscrYWPTspQbRJ1bH1l8ClfOJ1euqDoB
         nZ7EA5+yHQYajHwLmJSVdKJ1wuTcNl8iOjEb+Mwp0ZxvJqdwd3TIjnwNyjJ/XeENW4mx
         U5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286127; x=1777890927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7g8PGVKtEMJYR9QiHMqLvFKetFv6ZnXfbPzoWtuAIk=;
        b=Ihp30MDIog+8zlr5F/yJfVvswmom3M+1otYjqz9gR36chZj8r6L2Q4KZkDBPfIXye9
         z2ViGVxQK/azTntWZTNUTae6sKrW8bNNp3kVIiw4X4r/hkKJOqvHq22iYygV0kiyRJUa
         39jmINT3FLcbsw57LpqreRfdz5CT1LryIcq8ylLzgeiUJKK2eHUTPn9Wwy1SE3HDjYdj
         vMZeKRRrMWqG/mXZrroIG/nyg2L24tEUQtpX3QGjGts7WuPPqYGNQZ+ThzOdB5DCt7H1
         f83UtK8RsDJcZ1mZ1s+UayUXsOowei6tTnasuXHPfIIIQP7LvYWWMboFAVrXDCFCoqU7
         oQQg==
X-Gm-Message-State: AOJu0Yw1uC8Cp1SpsoqSb51485nm90meu6p9T4UKdtGNeCRc+uj2jR7f
	EEgkUeO3TOxe8QWH2o6GN3SeCvQDvSUNEFG28der52p4N9LzxSC/HoY4J996k/VbsAixA4UaNZn
	zrZEqS/nvSRJaT/brRRUhIIsUpTaqUwc=
X-Gm-Gg: AeBDievUdsGcOToHbrOTAKJfW/WsYBbfFNeBi0PdcG+mdx01aPxCQl7LAfpqT/ldhJL
	rVLwxqWmXvZk2DpP+Jh1dGS1vwZGhxy8b3B1i0+1z3jkRdh7po7U6rDt00DWc4zXGgS0Uw7vysI
	kLzNFuGC3FQH/r1KMkNHTAp1ebE6X8T6ZLUB/LhCN+fZNXaVc9y9Hka2VxbS/DWrkwhTsZPWM/P
	Rdp0OI9ZxHBc/UruCrDwrULW2MyncnP3OvwFsdUok3bDTmtoW5ba1FG+gNe0MGtfKyCNd6cFhfJ
	sFpn9LNGsHBkx7sPZ1CjBzN5t+JEll5gNx2Xp/ny7w5NRjOddUqW
X-Received: by 2002:a05:620a:7102:b0:8bb:ac44:bd3c with SMTP id
 af79cd13be357-8e791d89af1mr5897115885a.52.1777286127281; Mon, 27 Apr 2026
 03:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-10-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-10-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:35:16 +0200
X-Gm-Features: AVHnY4LW-EKKI2iHYpQa8CsbarRNTucG1qSu1E10yksxSLlQJCACvQUrGQUUo48
Message-ID: <CANNYZj8sG7A+o2tmNr2EXVd2td7+CGxRuvB6X9YWPRmWUFAYJQ@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 9/9] upgrade-helper.py: Limit number of requests
 to remote servers
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:35:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3837

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
> +                pkggroups_iter = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)

Any such rate limiting needs to be handled inside this function by
passing in a parameter, and certainly not by hacking
oe.utils.cpu_count. Also, I'm not seeing the issue locally (256 cores,
64 worker threads in 'devtool check-upgrade-status'), are you
redirected to some gnu mirror which does it?

I understand that you want to automate scarthgap updates, and such
tweaks can't be easily backported in oe-core, but code shouldn't just
'fix issues', it also needs to be maintainable in the long term.

Alex

