Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEACFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:57:53 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5233.1763942264785163606
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:57:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qSybXs5A;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8804ca2a730so55300976d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763942264; x=1764547064; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7VJLPr2JfvyJWRrTmNy1UUnDws33mEPFsVkkhoLvgQ=;
        b=qSybXs5AsgD8E4lYSk2vbLYVB4ooJZX2Usgnp3ZyvaeDAqMLWW5z9RbXqQXt8BGaJ5
         l9+VeI6esWZuLP6O89Ke38Qb1zxmiKOzQhRJfUo1ca5e6i/qlePXsynB3vzjLBXJCh9T
         6yXkDn1Xx2Uav8Bx+LBiKU00N0f5rzkejEMrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763942264; x=1764547064;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7VJLPr2JfvyJWRrTmNy1UUnDws33mEPFsVkkhoLvgQ=;
        b=IByP1oOUyEZsPSfwklnA0AoVQflNabYvaj90yana8MRUDbDL857wb7YHqksKkJbajA
         MPByQFv70RmEP6IraPdOrlm4W9Lu9ieF6JCkPwvYdZBOvzWA+of3fP5565+Pcso53CCg
         nEFvlJM5Dq72jlzyRK7NnjQ9iAbxTn49CAbpEpdJlpttAClutsHup5o0CPSNCInCMwVn
         Lfe8qkqr1Uycy69ISjAmAgu3TBQbAOp6g9bIfPlJvz1Os1xnGpVUkxNJHNnH0z0L+gVj
         cVlncc9Pam5Jc1iU4gtCZlyHrRttRlUQrjyn0vZMz5pkiqRftIn045R4kI6Vv9FPmk94
         5k0w==
X-Gm-Message-State: AOJu0Yxv9tXY3J9Ep8RJdjFAASCAFGDjm+Leo7nBD2a75W7s0pQOS4UB
	cVbbMn5quqWFiom/0Xxkd4URQ/d76j5RVUfWGL56XMaSaqYMT/AU3xODTVlwyo/+RZk=
X-Gm-Gg: ASbGncv/5rPIG2sN2U8gq120a00jIbhNYJbnVfmg4hNSBhaeubqE2vasLbotb7fzVzS
	sHTPoOtGrwBYcJOF3HYF6oUmD9WdAnuD5q0mGPzB7Ck0+thddGJ5zXmVa2RseItBZ9x3/hz0aZA
	qlvLQdSEtlZ6jnJJHCatB1QGdV+e0XzaOT2ieeBCLqvc1w8eIueJxNnYUlEEKiKjuWrWxHLzJyT
	3+JlLBtKbKpjjSvVmHqWwS88Gl3Kx81Xt+Di9saLPnQImfeeU90EurE2bHkyYdQ87KgPKuYqu5p
	p3BjRryWybQPBE52Qaxq2rXsRjWUIJB76VVsZ6bb133P5+NpYccsOzdQ/fceEAewdCQiTfymSyP
	h2MVO+ozraVnu8LAC5dLz6vqI14p2c1sdhEVGgGZUiEQUQ2zwK9DI+/cO4yQ1Ugj5d5SBftDauV
	07WY5BMoc5H+cerrM6iKnjsgKgW+cFC2UlUKob0MCnV9Gm+Q==
X-Google-Smtp-Source: AGHT+IEqBS+ybP35CTCBCvZAIeX0SaxROrPrkHmKmuSUcCVKzrD5b43f7HBW9C6VdibYO9kkZm8B9w==
X-Received: by 2002:a05:6214:20a4:b0:87d:622d:dd7b with SMTP id 6a1803df08f44-8847c486986mr138022466d6.1.1763942263602;
        Sun, 23 Nov 2025 15:57:43 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d398efsm76613101cf.7.2025.11.23.15.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:57:43 -0800 (PST)
Date: Sun, 23 Nov 2025 18:57:42 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Hemant Jadhav <hemant.jadhav@emerson.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 1/2] clamav: Add recipe for version
 1.4.3
In-Reply-To: <672520.1763935693231696616@lists.yoctoproject.org>
Message-ID: <2a78e262-0747-923f-4deb-43036e22711f@konsulko.com>
References: <20251120231345.1004458-1-hemant.jadhav@emerson.com> <5cf5a43b-152a-099b-1aaf-b5a5f7a9a129@konsulko.com> <672520.1763935693231696616@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:57:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2691

On Sun, 23 Nov 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> On Fri, Nov 21, 2025 at 08:05 AM, Scott Murray wrote:
>
> >
> > I was just about to push a series with v5 to master-next for a CI run
> > after finishing local testing, but I'll drop it for now seeing this.
> > Instead of the pkg_postinst, please see if you can get those directories
> > and files created in do_install and/or the volatiles + tmpfiles
> > configuration, pkg_postinst should kind of be a last resort for changes
> > like this.
> >
> > My other recommendation is to squash this and patch 2 together since
> > this is an upgrade, I had done this with v5 in my tree. Ideally the
> > recipe update would be a rename+diff for a smaller, easier to read diff,
> > but in a pinch I can try to fix that up on my end.
> >
> > Thanks,
> >
> > Scott
>
> Hi Scott,
>
> Thank you for your patience and valuable feedback on the previous versions of this patch.
>
> I have run additional testing scenarios before sending this V7 patch to ensure all the runtime configuration issues are properly addressed.
> The changes now include proper directory ownership handling through pkg_postinst scripts while relying on volatiles/tmpfiles for directory creation as you suggested.

Okay, thanks.  I am surprised you have pkg_postinst calling
populate-volatiles/systemd-tmpfiles, AFAIK those are run by
default in early sysinit, and shouldn't need to be run
per-package.  Did you test without the pkg_postinst to see if
that worked?

Thanks,

Scott

