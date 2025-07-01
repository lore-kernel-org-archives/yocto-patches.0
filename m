Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343DC83038
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 12:48:53 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.9956.1751374127838112881
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Jul 2025 05:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g3tv62Ev;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d5bf3300e0so34772785a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 01 Jul 2025 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751374127; x=1751978927; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E2xlHDAtK8CcgvfKgeS72aWn+yxLCl2Zz5v9lLycgi0=;
        b=g3tv62Evs+8Z8oTlgLnQYwfFa/18XIx7+GHjNeAbY8FlpvC5u717Suena1v553IdvG
         YRbkKbDTykJtby+ipNb8lTG9UO0OJkUu5pjT3om2GGEhLsTRNud0kJxocMkEaoOC8KTE
         Hiq74UBedAzfulaHA92fbhdkwZjTgtD32/XyKx/oGZk57mLqp3GzaC7whcweKF9eQIhz
         faihfFzEjlF+YMgysuQhTvPqQDXQptlECFAP6+UABy4lJkkfRAbIcERv7sWMeb7xKvJV
         ZRPyfufs0WaB/aG21wlKpt9PSajJk8HIPRg3pxHmAa63YzLdisWHjh64DnhG3LDd6AEy
         /WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374127; x=1751978927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2xlHDAtK8CcgvfKgeS72aWn+yxLCl2Zz5v9lLycgi0=;
        b=UaKEh76gJUja4JXi5qEN3YgTX22bpQRPjY60oQgCyTk5de4Q9+mhEWrVLLCIgaT5Fs
         YaxocsEiC1gcaSlu3A2PkENZhZRHA5ElSxVsYXEn+DzazME0P7P94oSnLrAc83IaoOCU
         /DnOavDiXUYCT4nAQ7OEO0eXCzrlkJCffmwACufsHQwVLJdnKX0ZAm46VFmj+8qYECHP
         LB9XBHbr467lZwoT/Gw8qcYBSMmlEXfRPwDuPre5cXSdS9FVrB/0ORfOa9evVtb921nq
         7eSsbNIkm9Y66h0zYrKQJh6VgUAzH92qjKTdw0BK8KNb3Ko+WwOz8QtwME8HfwNKXhWq
         +4kg==
X-Gm-Message-State: AOJu0Yzj9lcqg4VSyNZzX6yz9QiYENakTYbKUcO1w+7snECcqzO563f+
	SoNznOLFqrDeDdURpvTWrz2X34O5H11WFp27eB0b3usa6U2NG/H0jLbwqfY26UdgXgh/xUTp4rD
	NsCqALhMWp1PVKxrFr1Juhfmk9bw2wmaIkYqP
X-Gm-Gg: ASbGncvWu0jo6/QS+Zm/pttVNarkyXAuz9LqN7pFgVXojOJKOu6UgWpYFtU5kXex4iO
	QESTrcZKCBM6Fqb0fU+D2mlvQBtOqUGVkiIc1gLrl5UJbq/h7IFWO514lH/t2vb87POSFeikj8T
	aak6D9kj8MytrhtAPcox3BshGr8bPqpUQ6AqVs8AhqgQsuQi71vzAZAFYve0PknLbHuaR6y/pmm
	f+XyA==
X-Google-Smtp-Source: AGHT+IF2/VHzBV/O7pXA4dGp1i6ZERzqgp5O4ZOo9uklzV8LJ9PGbZqdgEO9nL0pY4e+sOGaxq5loABwbACjHiZ+JLo=
X-Received: by 2002:ad4:5d6c:0:b0:6fd:7520:da87 with SMTP id
 6a1803df08f44-700037a5a9bmr301991426d6.25.1751374126573; Tue, 01 Jul 2025
 05:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250701100013.826-1-liuyd.fnst@fujitsu.com> <20250701100013.826-2-liuyd.fnst@fujitsu.com>
In-Reply-To: <20250701100013.826-2-liuyd.fnst@fujitsu.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 1 Jul 2025 14:48:35 +0200
X-Gm-Features: Ac12FXztHZp2bZenWEigp-iI8igHikNCsit64V6XGXn22CSv90MT5mn8LMdUYGk
Message-ID: <CANNYZj_GaH8zKp6j_YUuO7T1rDUK3XM5-Fg_0WYCj9yopgiBHw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 2/2] global: drop unneeded
 S assignment and update WORKDIR/UNPACKDIR
To: yocto-patches@lists.yoctoproject.org
Cc: maxj.fnst@fujitsu.com, Liu Yiding <liuyd.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Jul 2025 12:48:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1732

On Tue, 1 Jul 2025 at 14:27, Yiding Liu (Fujitsu) via
lists.yoctoproject.org <liuyd.fnst=fujitsu.com@lists.yoctoproject.org>
wrote:
> -S = "${WORKDIR}/sources"
> -UNPACKDIR = "${S}"
> +S = "${UNPACKDIR}/sources"

Did you test that this works?

This doesn't look correct, as S was ${WORKDIR}/sources (and equal to
UNPACKDIR), and becomes ${WORKDIR}/sources/sources/ (while UNPACKDIR
stays as it was) .

Simply S = UNPACKDIR is enough.

Alex

