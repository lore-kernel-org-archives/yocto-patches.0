Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83252C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 05:54:03 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63437.1782971643071379619
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 22:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nCvCznpC;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493a6258788so409355e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782971641; x=1783576441; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:sender:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZD20ao5aKw8SwU8NYXRrM63u+RaFsGJLcAkToKkXHFk=;
        b=nCvCznpCmminYFJAcXT6R2/1luPqplGn9cuVfoZ2/bO2A17MXBktKk57jNqw7ji2XL
         jXLGCQK+JvG5v+phXY3UbsCSkLOWAGSkWOHdHjFP5Iw+FrYzXIN8sOThK7AoEmLbYJaF
         owuuyxkgzeh8qfPctg1DFCRv8mEExY5D1SNsWikPqpXDPGaWvusVMw8S5EzrPplBwv77
         fXx/Tg3DQG3m3px50pDYDFeQJ7m5icNJFDm+ISR0Jh63ZY9hyh/WxdtquI5K6M3urktg
         4Rt8Jqop/j7PpIywGPPZqVEVGa4XagFJnPLOOFoErODfQnhA3vPm8ADnqnaluKjge4r4
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971641; x=1783576441;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD20ao5aKw8SwU8NYXRrM63u+RaFsGJLcAkToKkXHFk=;
        b=U/7BY5OFLRZnkr1j10CogBTlXObZAJaVJ09/x5Psx8bus1+1W/UCgKrFKfkgkbszFi
         0t8g/gPd99C3RUqzP6naO7RH54693BXCJi6awExKaJu20egg2Coatkkv0dlI96uGHPht
         Q6cg4BmXjEwv82lIPELDA7UZfm8wYr4LthQ/afAFXmzEEDuL3AJq+h0tjGiXKUTDOn3I
         XwY+XYffQ6m9dp0wJgb2eeE8bFdYfQRJOgZA2kNFuMuZisHGy8Z9gkoWRi1IgEF4egU1
         BfQuoG21QkAxNHxUb+QLIEZt+weFd+jvJANYQRwtALIegkryBR7FseXfUpMididsSYTi
         rB3w==
X-Gm-Message-State: AOJu0Yw/8F3YT6eY+0kIQmjZz/b4P3mF8Tu8JhLUXYGBZMg5PFeLMyqx
	1iMnboA5EfVLtXCLpJpHniXV3+5WEwEnucrwFmFIKlq4DGCvJwnLrtuhA0ej5XuI
X-Gm-Gg: AfdE7ck597hqxO5jTL4n7DBwWBz8UhOPfmZsSCspPOr0TQbzsjTPvMuHgxNkYljiJRp
	Q06sP2HBBnEQUCSOodNgnu+P0bsKlaejNOJuUTgnN4Mp+vI1Dm5XI2/FBk4rYZsv9e6SoxaQFsD
	PO8xSnsVt1jPwNYRCVLdIc93M36ePdOYp2W0ucvC7kJCnL3pZt6br6SGogyUL9MM1V1pCkN41ke
	yG47+zvKY+Knl1S6RRlXjEgFu0c+gnTKsPi6SDKfZ9Piyzz7yeSPwmZ2GSfpjRAt9axl1hppgmX
	BrxrRC5y62PdAz9WYMo7h3y2k2Dd/0Yr+9t7Y4YsVTd7epNkXfLWcxn+eRen4fwr/2BS2RHb3wI
	6Dr/tJg2QoBSZ1SNDdhHZqaPPLm52iFR04kWuBif2CL/dsPB7ErXTNStpJ/iFRz2zA2t84OJC3v
	ud5ojlxst9O/DOyaQTgRnEfj4qUZv7NVVX61SVfLebVPinIA1UXVk=
X-Received: by 2002:a05:600c:5010:b0:493:ad11:6d5c with SMTP id 5b1f17b1804b1-493c2b7e259mr35654605e9.4.1782971641182;
        Wed, 01 Jul 2026 22:54:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm22047025e9.8.2026.07.01.22.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 22:54:00 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 07:54:00 +0200
Message-Id: <DJNUP3YO8KUG.39DIX5U7FDR6H@gmail.com>
Cc: <seebs@seebs.net>, <mark.hatle@kernel.crashing.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 6/7] exec*: Replace bash
 workaround to avoid memory corruption
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay+rtone@gmail.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.17.0
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
 <20260701131336.3578279-6-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260701131336.3578279-6-richard.purdie@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 05:54:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4361

Hello Richard,

On Wed Jul 1, 2026 at 3:13 PM CEST, Richard Purdie via lists.yoctoproject.o=
rg wrote:
> Bash intercepts getenv/setenv/unsetenv and does magic with it internally.
>
> The data pointed to by environ may not be allocated by glibc but by bash
> and the glibc env functions have their own memory handling outside of mal=
loc.
> Unfortuantely bash doesn't keep environ and the result of setenv/getenv/u=
nsetenv
> in sync either. This means the current workaround badly corrupts memory a=
nd it
> is just luck we're not breaking more often than the occasional opkg-build=
 segfaults
> we've been seeing.
>
> Fixing this is tricky, the best we can probably do is to read through env=
iron and
> create our own copy of the it, modifying it how we need to keep the pseud=
o variables
> correct.
>
> We do already have a function which can copyn and modify the environment,=
 we can

s,copyn,copy,

> therefore swap some setupenv calls for setupenvp and switch out environ a=
round
> the exec calls.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  ports/common/guts/execv.c  | 19 ++++++++++++++-----
>  ports/common/guts/execvp.c | 15 ++++++++++++---
>  ports/unix/guts/popen.c    | 16 +++++++++++++---
>  ports/unix/guts/system.c   | 16 +++++++++++++---

Don't you need to make these changes to execve(), and posix_spawn{,p}()?
i.e. in files:
 - ports/common/guts/posix_spawnp.c
 - ports/common/guts/posix_spawn.c
 - ports/common/guts/execve.c

Regards,
Ga=C3=ABl

