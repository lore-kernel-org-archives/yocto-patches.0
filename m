Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B49EF9D0FA
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 21:40:03 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5708.1776202800249131031
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 14:40:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=C97a4MEy;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso17072716d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776202799; x=1776807599; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SxzsMB2GLu2zYIDdR8J9zW3thuXPn/yq13fZKdF7Xw=;
        b=C97a4MEyonZX2X77G/bvkPdzSarXfML5wdUltnLII6IOLYDfgLBcwPK+4itRxsWMXX
         vcYJEFzUZe1QV+GB4YFwUgQSsiK43WAO95Pbywc5uxbna5xt/n27W/EnyB5H1zH7ms3s
         ZCIEuYdSVj4bbEqPsKEajmpeZQ+gyAgrb/8xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202799; x=1776807599;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SxzsMB2GLu2zYIDdR8J9zW3thuXPn/yq13fZKdF7Xw=;
        b=iVZify3YrsYY17D7ySq72J3hzP0tv1PZ706puSvaoPCHEd6lJttKaH92wbWMIAwVl3
         gkYyRSuwqDDaEiCy553PyB4Dm1gZQi+xtBBg1YdRTxtcWOFORiilWpLJGWGGElY7Gs5q
         s/TRXg7LX/ZzVwaEl5DsxyVNjTBIA6LliMpkiKWjZ/JGmOEVBOaVDeteRhXxvY98CGh4
         1VAqYy6PzwnZ2HPEtxkBOJnexTx+fmgnT7KJJsZNQdKljSd90r+GOSnJqJ0Sg+vPu5ra
         wCvQhaj9d4Rb1ZBnt3ASsBfdv2TiVit9rPDSXziTec7/iTmkGWgUckwopSsWtl/hUgz1
         LdKw==
X-Gm-Message-State: AOJu0YxSORvju4ZqXP9r7AFd4HGr0wGmVag1G4Pw7S8kjWGYHoJbyNBJ
	Am8GgLNJbUBsyg4rM2JawFI0DEsgd49WGWPcPBq/cVApiJoZJao0JBiWywxZ1OKzFHMEo9kZoE7
	Rippo
X-Gm-Gg: AeBDiet34IU0Z/VZvKERK1PiW/lQqQoT/8m6iXbdj2E6QB4k8ppqrXdMdDj15QtTB4e
	E/dprA6WyGskIqDD+G0ruwjBR8ESO6M8YYs5ChkLYaVpwYAKFT3qCmGU9jpFZ6e1VcKRE/CcH8O
	3y4oZG2XnW2xr2sQ7/hUZPZqul7MV9mc/9fcaFQzaTH2+AY3u1gG6Y0s9q6FeeWDMEw2CnCsmlZ
	Km4YkyypfNZw3MJo6CrU50yNbYjyOZLsAH+wwbEJfqm9EXjnP4ByfqFJEkE4DxEiOevsu9wKEq3
	OGOvJnTcHF1g+c1t0gIMLDEqLeGTyMeZCnY4TWhZHOXOusmH0eMoS6kpnGuB/jIODtmVJSz3Pue
	pPILsmiHvqYFrb7KsfHh+f4UU3+AvvS3oGSCCZntxN2Hi+PNf8fqXQFN0TJ3d8Dqj2QrelbMjZZ
	3vhdH5GcPweoEUL5o43EqYEgKN0+lVpJClVT698w2PhC9VQQgg3NYtbp5BgtsImlITcyShzpH2f
	eCE3XsZMYIdZC624YgqDJ4iEIdBION5ta166ng7pMklkgsd76qjk+YFwQ==
X-Received: by 2002:a05:6214:2503:b0:8ac:b562:2ef7 with SMTP id 6a1803df08f44-8acb562468bmr115237356d6.13.1776202798933;
        Tue, 14 Apr 2026 14:39:58 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8acb308d477sm64216956d6.49.2026.04.14.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:39:58 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:39:57 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: haiqing.bai@windriver.com
Subject: Re: [yocto-patches] [meta-security][PATCH] isic: fix RDEPNEDS typo
In-Reply-To: <20260414092207.1915814-1-haiqing.bai@windriver.com>
Message-ID: <475a0af1-475c-bc7b-4cc3-cb91d35567e1@konsulko.com>
References: <20260414092207.1915814-1-haiqing.bai@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 21:40:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3704

On Tue, 14 Apr 2026, haiqing via lists.yoctoproject.org wrote:

> From: Haiqing Bai <haiqing.bai@windriver.com>
>
> Fix typo: RDEPNEDS -> RDEPENDS
>
> Signed-off-by: Haiqing Bai <haiqing.bai@windriver.com>
> ---
>  recipes-security/isic/isic_0.07.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
> index 8e0f5ce..ac637b8 100644
> --- a/recipes-security/isic/isic_0.07.bb
> +++ b/recipes-security/isic/isic_0.07.bb
> @@ -31,4 +31,4 @@ do_configure () {
>      oe_runconf
>  }
>
> -RDEPNEDS += "libnet"
> +RDEPENDS += "libnet"

Note that this not is correct syntax, and results in a parse error; it
should be RDEPENDS:${PN}.  I have fixed it locally in my patch test
queue, but in future please at least do a test build of a recipe before
submitting changes.

Scott



