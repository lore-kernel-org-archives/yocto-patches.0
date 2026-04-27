Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1682BFF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 11:02:02 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42385.1777287713055833387
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 04:01:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JUpqbqOf;
 spf=pass (domain: gmail.com, ip: 209.85.210.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcc9b506d9so6637311a34.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 04:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777287712; cv=none;
        d=google.com; s=arc-20240605;
        b=S2AN6j4zf6He58jpugAuHPq8ZyHo+tNiaLJgA9ZTcIR310p0+x+zs+a8qmWvCTAJ6P
         wGEUddh2xYw0X882UYGt6TlyRLBDF9Cb0rw8MaTRZfJl6zNHAy7QRDtrTwCIAepTqu8b
         IfZEStf6BMfOrDRkV6vEqopEtAcYCeWfCcX1hz7Has+krDhwxD6WCR+W87qyjqzEYuqR
         +USh8+3bOxj/58ebcQhrIOxwjAfcf+O0Z/ZpvWjFW1s7gtGSoczjq8rEvDcYIDOILXGt
         THeBfRjv62YnpPzVFpa3UvzGx/M2UGiHq55+0CDx4qYKKqmCZFmNuJMzZPUh5zR2wUK/
         oXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l7avY3U1nVfna/jfrxNsi/mM/dIzeY4UK5YmVPNyX4U=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=WDQ3EG9UzhOV9NppHq7kT2xhNYsSlu6HAnvFGqdkPZZuMdu7aAGyFqlLBAndTmkaZz
         p1iB+Gbdu/n2jyIyOn4pJ3pz9NRGWqdiIQbf6vtuj7HlvpBm/QTgDfgaD4PqA8qtrnCr
         z54mQU0QFsxQ1F0+JU7/NcmzTftAdbopWiD55NW0cVv11gB6uCPGqSHa5IpRD5kbpKfn
         oYqMQqMP75bVI8iJgiUiqtH/m/fZHGC+1os9uyGfHZBZvK6JIeb2/vH55husDO/9aoea
         jfjvgRSqnfkZ7qy1B9qu2pOuD3qptdj8v5NJbb2eH3h1dhgaMZ6paZz98ZskKXKW5zuo
         FkZA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777287712; x=1777892512; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7avY3U1nVfna/jfrxNsi/mM/dIzeY4UK5YmVPNyX4U=;
        b=JUpqbqOfFXp4pOQaACkqBUORR33KuNB8jYF7BW1bg1cPSIOvhVgccPcFmvFEx7MJ85
         xI+moFBEn71OlVgCAaPGWcgJaOydU/D/1SJyFfKDNNhNnNG8EQnW3LFTIUrtu6cvJyEX
         NVAA5CpYmuplHzEb4YMGb6W/Kag+bgxVYeP6JgqxnILa3VDsjVvTJoVdRd6TpaXNcPSf
         F2/+fnxsdLqgbR6+FdedZAJaIuEmOnWm02J27NZrBGaCJlwF0UY84Rl6FG+xZBl9DbWU
         yFFB3XRphNkm0tHLYWJzsKDJ80nThPliG9ChqHb/Bw7R4pfL3ufVAEKVALesICUuADpD
         1Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777287712; x=1777892512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7avY3U1nVfna/jfrxNsi/mM/dIzeY4UK5YmVPNyX4U=;
        b=L4zUMijs0A60RLW8iVUnLTe9cp1Z01EzOgUHdghRp5FlZ7YIofEKpOB11g05BPmE9T
         fIpcwqJE2YdXDJc+g5zX4fiVtwbKC1ooIDnzmSy1dJB/2KYLl/G0KsfJ1RqrMMbL+BiA
         QO8bgePIxaZBZMB3zV7Js+rVPGm7Iz3Nvu7gKUiMNCkOhifXt/3Qkzy9ZqbEL2YdoOYM
         nR/K7Y0L+d2IjVkFd5YgWkc24WLWodynGCYrsrDlTQd2YFoOZRFfMG7I/B4OUcYtkCU2
         t7ePURU2jaiQrlcDR1aSMcdOOjQsnMo7rgI6SDbrxSkCZgLDdw5HjhSjyvfZ9F8Jn8br
         Y4ug==
X-Gm-Message-State: AOJu0YxRcsfpIYw4GSLxujv2x3J0Odk9DOQSdj9i+DHIn3QTD2MSYaEU
	9p9WzleLIKRVE0t6swUoOxyPi56ZXnScFmqBbL8daD5vpFgMCY5BqeMv2KgaBWuLh0eBkVdiJyo
	rdGYaGCz6LYaSJCC0ZwPmI1tdzF3LuQk=
X-Gm-Gg: AeBDievIGxGSp4JlgAUmoeeboqeNxfjbUV54n+RSvQsNDbN927fpL9AWOSR4B56xCnp
	M5DCwkdSlAMfRsdmm3XNnIsrbeJFbg2z33uKDNcs/nPBvBZJrar6d+sF9wmrVQH/RddVF7ydqW0
	oj5J6YUlXxm8j9C26yfiBApJUbUjDufEMY7qJlHLbPrDpVGHqzCfopYKsPLG0TWldHPWMfM4QuJ
	fr5MYDdZO9TDFBH5GheNKq057KedYOWOtqq3OaQYvGUARbjEUN/3GPgazV1E7RR683xRh07GLZD
	bbVEfGbIyVcZDuKhx/s4/ZOe5pxRG/iqbnd2JXamhcZdr513dNbX
X-Received: by 2002:a05:6830:82ac:b0:7d7:ed69:81b2 with SMTP id
 46e09a7af769-7dc94f95d2dmr24905366a34.5.1777287712264; Mon, 27 Apr 2026
 04:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-2-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 13:01:41 +0200
X-Gm-Features: AVHnY4KxHC1MhEbyiZq03htsWTxE6hEm8iljvWwiCudvsCi4tjFoF0QV3rA6JRk
Message-ID: <CANNYZj9GSyEOPhJW7vV9kXo5atKDquFE-zXdiKNQAEDMa686fA@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 1/9] upgrade-helper.py: Add compatibility with
 Yocto scarthgap
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 11:02:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3839

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
> -        pkg_ctx['recipe_dir'] = os.path.dirname(pkg_ctx['env']['FILE'])
> +        pkg_ctx['recipe_dir'] = os.path.realpath(os.path.dirname(pkg_ctx['env']['FILE']))

This needs to be further explained.

> -        bb.process.run("bitbake-config-build enable-fragment machine/{}".format(machine))
> -        return self._cmd(recipe, env_var=env)
> +        try:
> +            bb.process.run("bitbake-config-build enable-fragment machine/{}".format(machine))
> +        except bb.process.ExecutionError:
> +            # bitbake-config-build not available (e.g. scarthgap), use MACHINE env var
> +            env = "MACHINE={} {}".format(machine, env).strip()
> +        return self._cmd(recipe, env_var=env if env else None)

The condition needs to be 'bitbake-config-build doesn't exist', not
that it failed to execute (e.g. returned a non-zero).

>              for group in pkggroups:
> +
> +                # Scarthgap returns flat tuples; normalize to list-of-dicts
> +                # so the existing loop handles both formats.
> +                if not isinstance(group, (list, tuple)) or not group or not isinstance(group[0], dict):
> +                    pn, status, cur_ver, next_ver, maintainer, revision, no_upgrade_reason = group
> +                    group = [{'pn': pn, 'status': status, 'cur_ver': cur_ver,
> +                              'next_ver': next_ver, 'maintainer': maintainer,
> +                              'revision': revision, 'no_upgrade_reason': no_upgrade_reason}]

Can the condition be inverted, e.g. be checked for the 'old' format?
I'm not sure I understand why 'old' format is determined by any of
three different conditions being true, especially 'not group' looks
incorrect.

Alex

