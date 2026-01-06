Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F12C47BEA
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:53:18 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87468.1767696787669673542
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Jan 2026 02:53:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h+mzrPyM;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so4784506d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696787; x=1768301587; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMXsT8Txsp5E/N8SGzfCAwy4LUXQPxSEXGNV6Q8Cup4=;
        b=h+mzrPyM4AYtbf982dqvdRFC61/JOYU6OYbExKBZs2SofcIu3HWYftxX9+2c7FVGzf
         jMKRkDlEEZiSNO8jm21z2SgtRQ7xTBHxU8MNHyNGijZzT8weKo6He/gCLo/hmM5sfAyd
         KzipRvfB9tRcWCw989CESqGFuDqWMhOFtFfjCIEnz7Ka27K0OhcWJoHFA+wRiRUyYTwk
         RL4aRy49+RmDoUHcxVFcwoumc16zNO6Nu9zoxOmLHBnc8Crnk3V9TTZURUYrHLky/D78
         9dSDDDE3hQxm8r0FRv5y2OgorrYMoW1xewTd3kymwqxqX7xKiLYGIyXTDBl3aYQ90XFK
         n/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696787; x=1768301587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMXsT8Txsp5E/N8SGzfCAwy4LUXQPxSEXGNV6Q8Cup4=;
        b=NU1HGu1+61rjsB05+CuE6XDWjASW4zhfEP3eFQgZoxiqSO8KDNeH+LByGjCMTS5DkP
         tvxd01YP4AlVGOpE7ut4RKugsdvH5f0I+gX+hXmdBW8/cMWTcAGo3AXfu6IInilHyw3b
         1hCwHYhv8SHidsy1NtTHJ7sTwSZxPqW9SaB24NEwdWsz/gJEEJXon1tM+tT/Im+1vEtY
         U+Z895E9QaNbb13w4pB2G7q7Aus+FmBdJ+B6uRmg9s7gDXtf34J5A2FNI+exNGLjMRvZ
         ftu+8KGYcGl2e44R2e11jdAhu3rDluv2XDFtWqnekdv1//xfDLzcpnT1V3TOy9iMfe/4
         JrLw==
X-Gm-Message-State: AOJu0YwtGvVPfGw0rfGk8gILeezkloR3XMX7KB/z0RiA2ziaWhVTpzUw
	3L1lt6mU2NmnWb19A2ia971p9BAJRYdAj8UQjxB6HGDv7NYbikV4MM8ycnBRZ5JQa++qvQ9W+gh
	7wRf1x4i0H4MHRZOVTL9AwnPpZPPazeg=
X-Gm-Gg: AY/fxX6t0JO01X2gXGAKAmfLbNVheryLSfiaRJXWPoRWqyejgpwCFCOR5pKUlj978JP
	rMzwO/lBEkB3KtfQIHtwcwDLrLrrRa5gjdGvg98ahaJMSrJUEtyabFkVmWMrhzvvR4Z04zYIO7Z
	qBD7FVe3OqTD49vUaIbKYOB5Je3gAxhvVB8B7YmxxLgXJvIxiruwixVRP2oc8RVDVgrcVg/P7qF
	dZKVQhJJ0vhtCKYUJWeC1gKPxCcwD8wJ75GCwWpGwh/58vru8ZVZe0NLrVfBV1/HhcAPLet6pr3
	VIbacmk+ZMsditYcNyUHDTGUCMbS/w==
X-Google-Smtp-Source: AGHT+IFmq9eT55gkUCnDAFraVh3o+M1bd5DSuStIe/tRQfZnIVvsbOczGTk9x1+eFD2r2PAp5FhU9cCit74T4n7YtNM=
X-Received: by 2002:a05:6214:2682:b0:888:fc37:f9b7 with SMTP id
 6a1803df08f44-89075e7d567mr33425866d6.25.1767696786616; Tue, 06 Jan 2026
 02:53:06 -0800 (PST)
MIME-Version: 1.0
References: <CAJo0Az7nERXq4M8Lk+hwjqnBA8uUDXgy4EDGhOj3wYJ2=4y8Hw@mail.gmail.com>
In-Reply-To: <CAJo0Az7nERXq4M8Lk+hwjqnBA8uUDXgy4EDGhOj3wYJ2=4y8Hw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 6 Jan 2026 11:52:55 +0100
X-Gm-Features: AQt7F2pnCiDMQ3sOLfBY_3nwfQX_ymglC4azKsoc6M4kjY5ssq-mFU79YeOHATc
Message-ID: <CANNYZj-xYfMcqmVbUkz6OxKuyaMvXcMwQYH7cAsjwOONf63YRQ@mail.gmail.com>
Subject: Re: [auh] New Patches
To: Tom Geelen <t.f.g.geelen@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 10:53:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2904

On Mon, 5 Jan 2026 at 23:58, Tom Geelen <t.f.g.geelen@gmail.com> wrote:

> I have resubmitted this one, as even with the above fix that problem is s=
till there as I believe they are also not related per se. This problem aris=
es when one tries to call AUH on a recipe on a non-core repo and it will go=
 through the AUH steps correctly but on committing it will fail as the git =
root is automatically set to the core layer, instead of using the layer the=
 recipe is actually located. With this adjustment at least now there are no=
 false positives generated anymore.
>
> I'm working on detection method for recipes so git is used in the correct=
 repo.

Thanks, I've applied and pushed these. I wonder how AUH ever worked
with non-core layers as people did use it to run mass updates on
meta-oe for instance.

Alex

