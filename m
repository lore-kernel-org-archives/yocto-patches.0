Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F21C02190
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:26:08 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.11923.1738229164551735167
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Jan 2025 01:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LGYixmo+;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so5899676d6.0;
        Thu, 30 Jan 2025 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738229163; x=1738833963; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=deUBJiSFo0vZzUg/xNIbVVPJB3cUlCVuiNXxSsgY+lE=;
        b=LGYixmo+TeeAtSje65D6WCnocoruEKDD9MbfYIMSlqjTfxZI168twLOeeHorHZFfpM
         lqcRc9kwycaPnHnnmXHPTl8Orb6IMYZn8uev3iUAKhBzEt6rGZ+o0vQh0dSX6UQ5ZD8S
         ueo32yGxHM6W5NjYVMQNPaIGsdLvpnxBJI/Jk7JS9v52a1izo5yrjmiLN7jM/9zfTKVe
         CAas2h3Eqh3a/5l2BvXNt5+JMUTeXytbWyzKIAYiLZEasvg1M2OxZ6+Q49az9N1/eqpp
         m9Jb2a6soes04XOYOcLjubC9tS3MP+d+c1124p/qgVZ7jdjcCawQgjypJlbo0TGH2dLI
         Twvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229163; x=1738833963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deUBJiSFo0vZzUg/xNIbVVPJB3cUlCVuiNXxSsgY+lE=;
        b=iGeRduvsrx7hc3qtTXpsquIHgH47mAZf8VXkJT6urzYZzSBjrQKNrxNvJbCFTMW92k
         1LvD+Zpq1B4eSCFll4FIEEmohD1v985JGP+t5IQcddvk/28BfOvc5JCdR3UdZ2Js+5m7
         TCE+zbzL2MVI+6XZk+ezogHJYmprVD8Yjd4HC5lT8fRvaozZO3iy52XRBQYl34BUqwO5
         nDE9JjZufCgu6rXH7GeCEiSVh/EP20w22wXWKDBuo0c5MTq+G3Umzl0j8ZGILdln+k8d
         5E/tG13BH0X4YnaH4tlG8B+ZaLg1Vf5yfnE1Yw8MwVr51RGI5O9olTdVgnhEV6oQpFEQ
         58Ng==
X-Gm-Message-State: AOJu0Yx/mbVeRfEtXM3jWnp92Efb91x0Ioqj96yfJdePxX3Q8HRLN56X
	Ne/RYdXb8MV1waecyZCXnsaYEyytnsLa3RavDhWZvd7997wmm3uSABbEth3IPcIIrNdM/+whPj5
	t9EqG5kg17CkbG28MIUh4ZzMKpV2N+A==
X-Gm-Gg: ASbGncuXWmh8CQY0RB3c14jiakT0j0HHTIdXeEXvOPyMne574O+PXQJQy4kkxOolZjO
	ruKjJ5MAfUIZI/bYIehb/dxxTKTmn1wh6Hxk3t1yKBQSANos68I5sJ6ravp7ZzE550x5P0Lj3sb
	YYejZXMI2ecwC7YTyRDGRWM42/qwLLHtk=
X-Google-Smtp-Source: AGHT+IG4aPiUuT0iPo7wVB9OYPqBhb9OXTXgZJQGyMYBSIWhjGKMXF7EBz5UP+uLu0qE9QjM5n6ByjeQO/bIlOd70ck=
X-Received: by 2002:ad4:596f:0:b0:6d4:36ff:4358 with SMTP id
 6a1803df08f44-6e243bf672emr117711486d6.25.1738229163431; Thu, 30 Jan 2025
 01:26:03 -0800 (PST)
MIME-Version: 1.0
References: <5ed9ec27-cc24-f086-afe9-c77ead2f359e@konsulko.com>
In-Reply-To: <5ed9ec27-cc24-f086-afe9-c77ead2f359e@konsulko.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 30 Jan 2025 10:25:52 +0100
X-Gm-Features: AWEUYZnnKIatc_O9Rh6crMaTfZga-tZQzmSzPPYLtGvafD1ZroubTiFM9GOM2Sw
Message-ID: <CANNYZj-6urBa_Sm-k0nvw-gv4PreyLpdrmcfiDU+SMtPdeOBwg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust] RFC on librsvg support
To: yocto-patches@lists.yoctoproject.org
Cc: yocto@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jan 2025 09:26:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1024

On Wed, 29 Jan 2025 at 19:58, Scott Murray via lists.yoctoproject.org
<scott.murray=konsulko.com@lists.yoctoproject.org> wrote:

> I would appreciate input from users of the mixin on which approach they
> would like to see, especially options (2) vs (3).  I'm sort of ruling out
> significant hackery to enable using new meson for building librsvg, but if
> someone has already done similar without needing to carry a lot of
> baggage, I could maybe be convinced to try that approach...

I'd say this hits the limits of practical LTS backporting, and you
don't owe anyone a current stack in a three year old yocto. If people
want new stuff, then they should upgrade away from kirkstone. And not
only when it becomes a pressing issue, but as a regular scheduled
product lifecycle thing.

Alex

