Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6BCD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 08:12:34 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10161.1777882349590535768
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 01:12:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DKWx0Udq;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e594413c2so23493401cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 01:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777882348; cv=none;
        d=google.com; s=arc-20240605;
        b=j0OOevi0UUa3X0DeIJlIT7dWK67TuTaaz1jmAS4I5ZL8iSTzO8BOQEXIdXVrMdkZ4N
         t5iECVIRobts5pM5gK1IFEO9DYSYZLQ/g4keJR3FAmdVgJJlywr9+Vn9lCTAM8WbCrJ+
         tvlocHEZ44PhAAomvadQN/ugDM66l4CXmLHpE0ef6qN0QoVaKqY6dp1Oy3rfkhhTGpEd
         M3WnS5tYoyefklLeXHpKOjZqUt2rtmlNgGdKZzVvchEPy1f1V8bLfFsD3gQZywyFmoka
         VqlxkAN2ZgqyhqCBPy3tjaYFu/hVTZn3v6KVztxnEJOqC6hA3kU9L3aHxOqgcD+/XGma
         ZJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ECN/cp30dXCZiWOCbWA0fqeG9hLJHlFBJlnXILUjeWE=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=Qusly6p2TbjcFFtSdy6x9MfyZZwkd/ceRErfUuOvTJJr8Y6UIa65vywBnib7LHSX9R
         pRXxlS7EbeBPMY7qkVHTtJK0jWxkGNUX44qCPvJbGXo8YymvExz3go6e3H3usqmkzLRy
         1RypERLQGVWzUwvojJp137Uh+UnFw32WDFsdp3NyDrzU9W/0HjE687IZ4RBpxIP1tghR
         z5DzXzyPnh+4IsEa35dT/i7g5UxGZJ8xBlaqhWH4I7u6P8Ktmy4+PYLnv12jXKLONFh8
         PuOAhMNiiEAxItsQ6X6Lh+9zXdwEocAJexxB18bsjtSZDjRWYjNlyztKF926mino+sTt
         +dCw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777882348; x=1778487148; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECN/cp30dXCZiWOCbWA0fqeG9hLJHlFBJlnXILUjeWE=;
        b=DKWx0UdqdHPWifvWud28Z6u2GgAT04dhGYhKAP5h3Hs/3lCfes4wYCgp3CWMLnkWrS
         RWTEu8/M4WHH18r5b8PRg2neY2yi3hCSLhO/5pSenqd7C4kEeqF/3/T2Tp6lEj849hgC
         un61fcAATXQLuzqVy5GQe2uA6az8Mf3Q/C00e8vurCeCfYll4U750aoaJYUksxphXKQI
         8XS33YigWkq9jSIEyHSMo5PkOInbm4sZyhCsI8hiV8H4oi5BQgqkt3pwzj6VnLk6YKjg
         pqCNnOwpH0+Fs16RLNcsiEajjUzdGYvu0uym2/mUMbD/mgkQudHopwMTxLU0tP9fB3l1
         ilcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882348; x=1778487148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECN/cp30dXCZiWOCbWA0fqeG9hLJHlFBJlnXILUjeWE=;
        b=LLq7k7uj8nTXakzzUtNf60G2gN/XGVX543mW8DmXrA+/uK4f9yBx9hHqtmf5feEMxt
         RAoQ3Ct3G4WRMELgHvJgWmB9Pk/CEl1lZn6bU+k7y1YbBEyv/Br/fFRT5t1lqh4lYMgh
         jkMUcQoapUlfSUnwd/3nYgPbZKLtmMfQy3F9Mol+lR/SZfaNQG4ciJm4WKsUwI2/0S8B
         lhVzZaRTvywbDMMpDi0BEW3TtQBUr0uuMWwKSIY2PhxINPcn70HZ8kx8YpfWeXQyzPvW
         gPA7skg22a01dnkZIZouNQt+UEhFJEPwwLkDdPFk9gYqmVT1Bqx7UN3xdvNY8WbtY3Xr
         FIzg==
X-Gm-Message-State: AOJu0YxLS6ftjlSq6JZwvNFd0qPCOHylS3OhMhTc3qXXvPwobwGAUuUl
	+CVWeY99omKZ7PblR++hGiTuv4Q1eUwaE7mc8zDouLM9KcceZ0yqfZPmKgACeP2YOTpuJ6jojdo
	Mom+BuTIxGLx61Co7t1zzVT3dZKAnvt0=
X-Gm-Gg: AeBDieujahBCfBkAe3FkGzpBBNEnezOZgS8O29jlVeKc0W/V5v6wBf6TkhzQmgor3c1
	XA6reBXUHXDT09LazxBI6/+kFIP9mPs68RFGgvaYsrubYZ2mVMMOzIOOVKBw+crfN+YceHIHxHm
	gtLuRtSfbXimQBgQTYIJhgWZh6yA3abMGL6Yv4XAmSekjKSCyPTXkjYIy7g+ix9NViikkZ/lYQH
	czB6fUPGFqI79eNCHnz6wWP7gOFj8V35Hoan2GlFsucpBA5NEu8f8Nu62PLp7pq6aDiz/po1WOZ
	4iKDEb7Cfv27FjNSnIkltK2de42fnfhtgQjDU3kI3mk0ZD2fMJFE+KMhzotWUyI=
X-Received: by 2002:a05:622a:8589:b0:50e:5a1c:d807 with SMTP id
 d75a77b69052e-5102d1d0c4emr170294111cf.27.1777882348583; Mon, 04 May 2026
 01:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com> <20260504063614.3831203-5-daniel.turull@ericsson.com>
In-Reply-To: <20260504063614.3831203-5-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 4 May 2026 10:12:17 +0200
X-Gm-Features: AVHnY4L1-jsOattC1xul0CtsWmZW_a-acSj9SUJtvzApjEp8lvgENBwT8gFEFM8
Message-ID: <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip
 already attempted recipes
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 08:12:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3907

On Mon, 4 May 2026 at 08:36, <daniel.turull@ericsson.com> wrote:
> +            prev_runs = sorted(glob.glob(os.path.join(self.uh_dir, "20*")))
> +            prev_runs = [r for r in prev_runs if r != self.uh_work_dir]
> +            if prev_runs:
> +                prev_dir = prev_runs[-1]

This makes me wonder, if AUH was interrupted in its second run, and we
need to resume for the second time, then AUH should combine everything
from all previous runs into the skip set, not just recipes from the
latest one, right?

> +            if 'workdir' in g:
> +                if any(g['name'] == s['name'] for s in succeeded_pkggroups_ctx):

This is more complex than the condition in the removed block below,
why not use that:
           if g in succeeded_pkggroups_ctx:

> +                if not os.path.exists(link):
> +                    os.symlink(g['workdir'], link)

Why is the existence guard needed? The removed code block doesn't have it.

Alex

