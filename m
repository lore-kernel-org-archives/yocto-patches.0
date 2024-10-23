Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1F9CDDE5B
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:14:20 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5513.1729678455812321263
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 03:14:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dXT7jhCQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so6285464f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729678454; x=1730283254; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8Se1nqhM+qYuVuXWZT60pz227fMk9cY34C0kkovtXM=;
        b=dXT7jhCQd1N+UVtnQ0P75wuAkgL3USTTqKWOrtTgOvhMRjW84Dsd2rlD+1srrQEioM
         bVahbOPWucv/0yWi+UMRG8DxJ6kf2BtjtnvQKDbg6icwr2FzHvwxhie4BGQQp0jdBFDB
         U6vmJwfIoyPa0Ugv43C8OxqdBmWjDQmGLP+Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678454; x=1730283254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8Se1nqhM+qYuVuXWZT60pz227fMk9cY34C0kkovtXM=;
        b=g21Si2J37iV3F0fJjL2oM1wTd4CwKgZJcYXW7uA42WKed2hiGD+xbdGjj+WAtQOrx2
         jHCVk6izUhzqZ7sGhlolU6m3nS4K0hyw02LhCxpzPrC+2Tlsaa7e8D+PFMqUhyXuO0Br
         isLcg6PrRfOfzpPN3EJSskvmXvzbb0rPBOxtGEEskekLKDL6jmMkfL0Hh//LlD4Vp8OB
         r3fu17Y00xZTMZEwB+LUw35iBBi2xR/BFAin6InPneDgkTF4IQoMPLvXql+ySMg88C3X
         ajlsF6JKGw3K9eJjQQANwrmBfgL8JPJYX3794N1XSoqdEdmMr2Pb4jwX3Sc1YzSG3Twf
         j9ig==
X-Gm-Message-State: AOJu0Yw14yXRhCeY4O9Ejj/CHJ7YFX1+RbtpXmCuzofPBYiZQqsn+YT9
	1hWLG0SJ1TX4HZD8knS4l7TmjaCihJ9HTQnYx3qcxzpnBd+jiE+lvro19uPWonLYt3e7emZRv+/
	X
X-Google-Smtp-Source: AGHT+IGBwYtDe7HvA3ZsQJUUNsDlYYoliyRSy1bQBRp0LaXqpxLB+GxxD+S02oNdTkXNBbH2+2wDfQ==
X-Received: by 2002:a5d:680a:0:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-37efcf33a99mr1514210f8f.35.1729678453899;
        Wed, 23 Oct 2024 03:14:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f? ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93dfesm8501225f8f.66.2024.10.23.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:14:13 -0700 (PDT)
Message-ID: <636e764f8709d1ffc9dec1f1b3fa304b9ed13839.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] Add branch selector
 for Mathieu
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Ross Burton
	 <ross.burton@arm.com>
Date: Wed, 23 Oct 2024 11:14:13 +0100
In-Reply-To: <CANNYZj8B3jKqA4EDrVS2jwfTH8Dn1BbVK=3TAaBVB3VA_6DPQg@mail.gmail.com>
References: <20241023100242.3953188-1-mathieu.dubois-briand@bootlin.com>
	 <CANNYZj8B3jKqA4EDrVS2jwfTH8Dn1BbVK=3TAaBVB3VA_6DPQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 10:14:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/733

On Wed, 2024-10-23 at 12:08 +0200, Alexander Kanavin via lists.yoctoproject=
.org wrote:
> I wonder if we should give this branch a generic, stable name? It
> would also help when we need to point to people that, no, their
> patches aren't ignored, and are in fact being tested in a staging
> branch.
>=20
> Ideas for the name? 'master-next-next'?

master-next-under-testing
master-next-ab-testing

?

We should probably move from the contrib repos into the main repo at the sa=
me time?

If Ross were doing it would this be:

master-next-ab-testing-ross

?

There is probably only a small number of people doing this. I'll
probably merge the branch selector change since it just helps people
run builds but we should resolve the bigger question.

Cheers,

Richard

