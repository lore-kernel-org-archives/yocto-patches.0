Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691B0CD6E79
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 09:49:28 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75582.1780998561100142577
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 02:49:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lEdHdtlp;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9158c621ebbso637910285a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 02:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780998560; cv=none;
        d=google.com; s=arc-20240605;
        b=dcIhNyRtoMurV+RGC+CaYfHyaibpjAsg0debSwgb3I6A/oeH/bK+TQHTJvuzkks4S8
         7ge5VuZohbWPLoRT7UbDvU3nCpKkBh3k8bGDGuE06vTWaMQcDO9s7aAThaDzmhZpse6W
         Oc/KQAL7mTcyMSfK9Qdqzt0o95GCNaE7HZ+7lhmeo8yQ57pi4sWERC7sZDF965kKQePv
         EGGJzKhBxLdyi1L713yK20IopgfC+rNgyLhrwQLlDV9vk7YjgI4M3MjKoeVFUSIgjKeh
         OtdRizuisz+9DodvLWyFu+VHUrU7DwYxF0zIxXcgUEquAmyBrgMYe5i4EXTHr54DItom
         tYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8wPHrZ1vw+KgnDJrlRR6oaU3aPpq0X8crbARWDoAa2E=;
        fh=dl6hDswrRM/UxJNnYCvEBdIZalBhgR71Ri7j4SsRvWI=;
        b=MPhUSfTMy4whOFvbJufoFPHh6+IKysCg7qo/TlVLDQD1xdX2Cjn7nwDk5za7roOuG1
         VPQDsY6Q1xbkEKjfM+R7JC27x3KpXeTQQbUyvi38H5J1SY74TK8qBQ9ZX8jh46gziyUd
         QE975+bMJBgxZ9/mqAqzjiRsl70JVq0iHaRO0/JnvxkBT06dAVoBmmip3RFZEMlnzBHA
         Vjl0NprXpTFsN5iRuMOujAdR4HJYv8/K+nyEY31y/pp5BKNoYKSHVlcieE9h2xFFkD89
         5wHyPp4h1wg3J5KXEWJhO/CmdgOvNCPZs79P8pp0hjSq/dUz/iBhchLcli1JtdDACaBG
         RtfQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998560; x=1781603360; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wPHrZ1vw+KgnDJrlRR6oaU3aPpq0X8crbARWDoAa2E=;
        b=lEdHdtlp2AlaFPGu48ORAdWe2jYhqbDS2vl0uyrGSdZxWrveXDnABTrTHPZXaR+x/p
         vROXXDiHHF8l3Efje3HHEjMShiTTqckF9ZBDF73+YxnmOH58RKuXTXy/i/wzHpFEvez3
         l+SExvx2gKUhrCZ+1chap6eN71b95hN7P8S7T8B0RZ8wzlq2CVGUr27GOIw2Oq9oXGFW
         ncZg1G2Oq9TH6m7FdgIB78U5ufeVUzIDl4wsNN3563LesJzvQZ/FaXgwkKepouGFft/w
         w7ORtjOBy66XaMM5cd4itjb65t2k9Lcbaca8KqgZrEvXXcfVT1Vu8kOwzH1tH9dByTAA
         GTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998560; x=1781603360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wPHrZ1vw+KgnDJrlRR6oaU3aPpq0X8crbARWDoAa2E=;
        b=LGzOcSGpg5nE6CGJurE/RWpdD5rJxWXaGsBiqeZZcHlDHl19QprvnvXIQp/RSA/ziX
         ID6q4EFKd8PL+Yt7CY7Jy9o1dUpuhN9tLUVYNTE2OGDScb6XISKlwRuGf02kiSJRg/20
         5aU4Nfb/C5h5on64RsfRh1brcX6vRuZMMn4vsOP1Lt5bM+jo+zFrgTOjvrWV5xPvoKpG
         T3qCFNJzQvnyBfkneAH3Hd/TTs6Awnt34+jNB+zrnlRwo9cJ4ffppXiXLuiY7oZdAe1Y
         NTRDFko9pwYDkD9rhW9OHqFpqEaI5q+Fg/Tr0yzOcO0Bb/kpdovaO9K3gYHn53gpPQpy
         frQA==
X-Gm-Message-State: AOJu0YyywC2U98UQQDUURW7H7KzaYskc7YmxVJ072yT37gRhCI6cmJTH
	CVXgu/4NyCV6l6uAYp2OfDoXS0HA/ALugbhW1tQO2sq2tiCW0FBAyE1+rUGJOrPbw6iBW5rB4d7
	XBFgcq9xrnXkqprSUogJiuyweehjIvzbJDw==
X-Gm-Gg: Acq92OE07s4iVHqdpUjlbQzefUUEiJE6InBvgX7Onp5dFF90vJImWaUhsRzTO4BDuFF
	ysRVsNZtEbpyPXzo+ft8d8O07+cKv3Lf1xZqswpE5zEaz6yEFDCRXSx0nCsiwqkbECme7sbPXHV
	HPx2onhMFzF8AUd50D8U6N1b9u39tbLOnRIzoanGKvL9R4P9zuWM8XRNdgG9/d89uiKJnYS7fkN
	hE7p+p81nI4VNjIVZWkMQIjjON9fYjKW9qLQ9P86uyH5NkLOlqjBRXhQSwyl42SMHU1/pCLWTmB
	i9v0P2FOhU/moIUQwVsFhMteuvCTzQ==
X-Received: by 2002:a05:620a:29c3:b0:915:8055:3f91 with SMTP id
 af79cd13be357-915a9da7dc7mr3183912785a.43.1780998559950; Tue, 09 Jun 2026
 02:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260507062049.1461147-1-Qi.Chen@windriver.com>
In-Reply-To: <20260507062049.1461147-1-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Jun 2026 11:49:09 +0200
X-Gm-Features: AVVi8CcAlvZLQmNOH3mnKvCTnh44OAd1ph4CYbrJ2nrniRFSyOsxbda1l27meU8
Message-ID: <CANNYZj_WqwpxHWs0pBeszPSZZpZZzw_8soL_aVC6O+wG=YK=jQ@mail.gmail.com>
Subject: Re: [auh][PATCH] upgrade-helper.py: add --stable option to do stable
 version upgrades
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 09:49:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4183

This has been merged, thanks.

Alex

On Thu, 7 May 2026 at 08:21, <Qi.Chen@windriver.com> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> Add --stable option to do stable version upgrades for recipes.
> This needs to work with the recipeuitls.py change in oe-core and
> fetchers' changes in bitbake.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  upgrade-helper.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 40f31c4..668839a 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -100,6 +100,8 @@ def parse_cmdline():
>                          help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
>      parser.add_argument("-e", "--send-emails", action="store_true", default=False,
>                          help="send emails to recipe maintainers")
> +    parser.add_argument("--stable", action="store_true", default=False,
> +                        help="Do stable upgrades")
>      parser.add_argument("-s", "--skip-compilation", action="store_true", default=False,
>                          help="do not compile, just change the checksums, remove PR, and commit")
>      parser.add_argument("-c", "--config-file", default=None,
> @@ -711,7 +713,10 @@ class UniverseUpdater(Updater):
>          upgrade_pkggroups = []
>
>          for layer_name, layer_recipes in self.recipes:
> -            pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
> +            if self.args.stable:
> +                pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes, stable_upgrade=True)
> +            else:
> +                pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
>
>              for group in pkggroups:
>                  upgrade_group = []
> --
> 2.34.1
>

