Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC6FCD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 07:52:24 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9970.1777881140587953039
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 00:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XAKoVigJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acae26e564so44792606d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 00:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777881139; cv=none;
        d=google.com; s=arc-20240605;
        b=XAQb0JEG+lQObL/CxjL+FBh+GRA0ez78oueeL+Bbdd55k+4AIf1+jfB2ILHzyy3CF8
         2NbJXeD8Btx3mvlSqDD746UrqgO/rsd8jIkbElKxP7pNZbokf+Y27w9mDlX5RHkAR5AC
         ul5PZERUF6tBSX5dx1DsOFZ5u9dkJOTgZfu8V0SMKCjXvewb3SYr0vao0POx+qLUEmFg
         zhVnaiGeVY0/YRpFQJ5cQqzxhywfCwkJmpHrgV+kAauSJJjYs96G2gH9fCZVVhJmOQ/G
         n9XEVO03tQ5LuZhlCbpDu/N5Kv0JdnS6TaGxw4EKphFXbH9aEuPFxiejLq7zUPJPaGPl
         lxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XXMg5nyCerF+JNLJMZc50ilOzAvNRG+h5LU8hKW6qXY=;
        fh=5f3juoVmFZAcDZXxw6MpSCyKznmuK5IWEecktzwNVBw=;
        b=IRPNui6o1qsUhRn9/26DEg70FJYTD/w1QlaG6OFxnNtU5xT6maSkViaRAuwWecPv+0
         ld79FYQEGKfyoSDMhi5epRizIhA2YyOJkZckzei3QJIdeMrVCZcDDIFkoPx4MPLV9jzl
         9BVuzrmeTE24QTdIaVjdGM242CSJNedai/4ErD8RixRfwgAJbM3c9oTNUq7yMUeIGQXq
         Fe0FXIY1lh2b/JpgiLNPSdJSBwuwtKrRbwfjaQoC0uQkUzSBtNDh0MBkijHIXZ1+vtx3
         8CY7XEjP3ULP3wpc5rg3suJRIm7lFXL4V9cCGgQ4ZM3yqVXD2eYfyn/POc13peBTWQqI
         0xyQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777881139; x=1778485939; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XXMg5nyCerF+JNLJMZc50ilOzAvNRG+h5LU8hKW6qXY=;
        b=XAKoVigJq82aDPkwoX8SRzQkeKoDc6Ac/773MRBIXLb1Lh0ehm9eRN64sZm7KHWite
         JfkCKRCLYmGT6k/gvUwyLUCJN8rnejHkbBNKdoY1mZo0VIr/9bFEWI039LiKuwq+Tea0
         Q0ND3p2iKW35TXCh9XlDKdt7+7Ci32mXy5tAK9oS7z7mP43Xspby2byRq1Ro4jVpSVkM
         rLL/3uP1uiIrqgeEsUHJwYSkgA3uLfvyBvWsqPb7ID0OIEFG2/XTMW2WPMLCPoZ/ja/C
         lqgiq5YsIiVwuR9tqYMqWkUWgT5hjynH5ln/IwJ0+uatWZ28Ykn+9Cuz2GV2/xEW2EPM
         HP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881139; x=1778485939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXMg5nyCerF+JNLJMZc50ilOzAvNRG+h5LU8hKW6qXY=;
        b=pbVRa9BwnFp22oL5OJr+EMs2mZtiVDh6dQNY6Qup6KKkvAxOr1yPSCCrEFKTUFvPQY
         EiKPsWZwPSRBsxuJfRlZCn8pj46IR6xwFWYkqUb3KM+Fln8hvnteaOzK8P9BHU3+LJ2F
         oOrQYpHOW0MQcEjJBCxfw160cUai0nO5pFR4P2EaypibMda0X6vF3cd+0Ku4kqRLbIex
         32cSV7kqgUy1vEQC7jX0HWQl/biHZM+G3OVTE/cpmOGSsAbbwXen2PLTqqmtzyt+L3zV
         id3ZKPJdFksBNZAdR13nE1bA1Vcr5Z77lU05qnZFbt2/h82r48hVeNp47Sr/tfRaPvvh
         mbqg==
X-Gm-Message-State: AOJu0YzBK3cKcJ6MTZA13VPeRZ36QPs7/m/nZjq+kjCaUJJjm3v9LI+z
	gLPWDXkaREUXQj+EOE8Jl4oGi1WDaHXep3GrJ3LyMHuAdGrEM9O26IhJOfM0cvxFMXalMACAeif
	SbGkEw8rykW8FciOCJHw7LpVPTc4QFEE=
X-Gm-Gg: AeBDiesTFqtRyGceG1T2b7DWoHkN+tbKHqPKnWZu5S/edh/k46ju4MT5R9QwUhn+rCy
	zZqnNFOrxfLgcPAVeAqGasJ10GDpzm8PL38lZymZ8jcSAEZNGuK3MhPuFi2qbzqxSOaC5UimzXe
	MSKnBJ/fOzVJnEUPeVmDpTLWNlfxHAjEjildfgYlFHCr9WBzwjJQY5EEwWr8VJfEB5PSOKNiKVh
	qXd4h2iwEp1l6XPIJbSrqkgQdafwIgcI94JsLynfzHsdXjnbJTrL+2yy4sG4M23hWQeN4eOSpVs
	ulDmzm5QD2URgndxuZlWclJc5QI32uDcrYze9vJC629mgcA+ShYOrvacBSnih18=
X-Received: by 2002:a05:6214:4d06:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8b6682579b0mr132582556d6.24.1777881139505; Mon, 04 May 2026
 00:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-4-daniel.turull@ericsson.com> <CANNYZj9O=uZJ-VvnMP+2TOfqEmzQ18dmDu3VA+19R==XHKPwTg@mail.gmail.com>
 <PA3PR07MB107217FDB43D6E8BF8639C0138A312@PA3PR07MB10721.eurprd07.prod.outlook.com>
In-Reply-To: <PA3PR07MB107217FDB43D6E8BF8639C0138A312@PA3PR07MB10721.eurprd07.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 4 May 2026 09:52:07 +0200
X-Gm-Features: AVHnY4KUFsItkarjS6wTGZ3t0r2Jhl4WQ7Cmb5z7jDbJM0S-XRxkd2uZ0Mro2vI
Message-ID: <CANNYZj_4JtdrbCtuBgcDpf3a3gusQJs2_DUMCZyiRO7dRFCWYw@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for
 patch-only upgrades
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>, 
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 07:52:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3905

On Mon, 4 May 2026 at 09:34, Daniel Turull <daniel.turull@ericsson.com> wrote:
>
> Sorry, I misunderstood you. I though it was only the changelog going into devtool.
>
> I'll check the bitbake-level. I missed it.

I meant particular this response to a patch from elsewhere that aims
for a similar function:
https://lists.openembedded.org/g/bitbake-devel/message/19414

> So we keep patch 1, 2 and 4? Probably the most important is 2 [PATCH v3 2/4] upgrade-helper.py: Add compatibility with Yocto scarthgap, the other two can be optional.

I have to ask, if 2 is applied, would that be useful without the
ability to pick only stable bugfix-only updates? You'll probably have
to maintain both 2 and 3 privately while the 'stable updates' issue is
resolved properly in oe-core/bitbake master.

1/4 seems fine, the function of 4/4 is fine but I need to review the code.

Alex

