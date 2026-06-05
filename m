Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB33CD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 10:23:07 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5344.1780654980859815405
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 03:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ssCSK9vQ;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91563382bcfso205722285a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 03:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780654980; cv=none;
        d=google.com; s=arc-20240605;
        b=lp5oH4+2U4DJPpXr5qkZ5k2FN+bxWpzEoL2+QyjUaAbh+Uo2lfViXaBC0QBd3qaYtA
         3kQS6zJw90OfcaDSQZquDxaOzF07IuAiEwkdWkOqDaeAjt4/LOw/x575UwHjl1w2mvhp
         PTsK7Zw4AOXfQ8sgOZM9otVO3qnCVst56uvwk9wy9kI7qI+tiGlLyM2FMZlv/E972xWI
         bOTJWFLv90qtnvV4ZAOqqCXHjtVhGqyVqh2SYUjU0STvK8ME+uY3OYy3cl0iA+Q8ccUS
         iRQDw0arjdRoikBLc66MCEDdMWoIQgrSPYuRxrF77MLKj70LT8r/Bcm3hZ7awFu+hm09
         6gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ovpNddiVv46j1KE8HVEgwi2LottJQV+tEZGVrETkmvQ=;
        fh=wYjPNaV38nAE6WEV2mxSYxyk6MB2mhWXe9fTXe2EQq0=;
        b=g/+GFX/0ccaGTRlANGAIFbpo6EiSgnGQcXW9iHemRZVJUwieYyUMmcLerNFlG/4GRV
         Tq4ChrcyEbfflvY5lYDx5XDe+Z48uhoYrqUc2+usAwUhbblSojITwRmeW9mMGm+UDvL8
         pcHz7x4+obzCXxVMbUXKMHGKOc++t9KcC9TtDeVN9+Ev+7wseWHW2F2prpJUAfXh1UyH
         K9fVkSRi96wMOGIXx4ma5dN4EBMirWGW8sOvrWzpeV1iHUtCdGrd0i0NGBGPWrjnXMnV
         d6W0+7pBRXVf6OJo37InYhuVvFGbg14mU7fMYQmIo7m/VSLOAj5s6BkGC6rmrPq+2BOk
         yHMA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780654980; x=1781259780; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovpNddiVv46j1KE8HVEgwi2LottJQV+tEZGVrETkmvQ=;
        b=ssCSK9vQ3jrxswGfXPe60dPmDsSD33sBbyN2DDicVg3dVgN+4SQ4iqj6yWVsNuKUut
         KClWWf1gShKYVX3FM79pmWWXoYA4sOVEoXoFf35DrocXR8d2u9CgyBlkZfkmBsnTBmpx
         NF4d+nLOIQ9jjMPafI5RGzDVe4Yf+vJk6y71rHHHPizF1Wb9yE9tPsZjf8HQES0WNyhS
         aADZjnVh8dahcpl9VF1ZhZY13D+yoofxC0CwcEqqjt/S4I0TNG6zct+COkbmeZ12CAo9
         J1Cx01BvRBhckIpnUqhNAxTHv6SagI+oMpcmNPoq0AopwH8gIccv6KyUhVERkCdLrqAf
         XqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654980; x=1781259780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovpNddiVv46j1KE8HVEgwi2LottJQV+tEZGVrETkmvQ=;
        b=kp4axvGg/DS73EOeMAmZuwR+KhzMb9FZF7sHDgA5qtotQqwItl9R7m/NSBbDkgmLkN
         yiVp8i5nmcK5NbvEMHhOnrQ7WTXz9fdTdYMLnXBMSd7Fq6/wGUNbFjZhQNIWYN2Q1JTf
         /B4hPRVw9I172CaAmKuiZSkBLXeqjszoV5e5ii0qHVKCdSFx1J3vTnLsi+gL5VNhT8L9
         uOfycyK4zDdbCw5tvAAOvTl7H0brhTTsCljO/pFBO5OFjOgc5speRTDc4XrCNmkJntln
         gYMKbKqdXopmuSFSp2Vl665eUn/V5QX79K+slBj2wbTR2fB0xddJ/iQA/NQz/Av7Emyr
         1ihQ==
X-Gm-Message-State: AOJu0Yw7fpA/d1CZREKu2UmfuFDKzlhoYvSPwQMU662zROdkJGaG3mzz
	xgHJVWD5oJgC5MAOiTYGA2P7K06b9zkSGZOTVUSJyPRT3+DbH8I8E5Gznd2JZYMLAtNbkEdiY/I
	XZpTFDgBxgTlmI2+9em0eUSF8BBiH7LGBKw==
X-Gm-Gg: Acq92OFDAbkPZndSNiqrgyhQHshqgXIkeZ8f3P/GcfMl5hbduStXp6MSjEcrSwRI6M6
	RrH7SlUzYTVSTQckB28f8ndzNnkoEX7ILI628X7gX/irLkyPtLc1Me85cwI66cmwfX6Ei30bm88
	9Ak9cOYtxW/2mQoOTW9xeevenVVMPlOy/xByM9eCh0E3iR4OPzDQaoy8XNE+BSmYWjS8D+CjvSd
	KfBsmIzveY2ta72ZwLrGkARQisrMT6B/ch/FMMxbZQ0IzKIljrgyx4w5nbqnufh1ahJ0fNaovCY
	vpQUekDSnfefZ2iLuYTl8D7okjo+upbKoMVn4SDpL/XaCF/DcAGz75+On1W2iJ4=
X-Received: by 2002:a05:622a:c84:b0:517:2aac:dbd6 with SMTP id
 d75a77b69052e-51795b0ed55mr47892071cf.10.1780654979786; Fri, 05 Jun 2026
 03:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260603134044.3377639-1-daniel.turull@ericsson.com> <18B5DDE619C5A079.3784076@lists.yoctoproject.org>
In-Reply-To: <18B5DDE619C5A079.3784076@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Jun 2026 12:22:48 +0200
X-Gm-Features: AVVi8CfKZ2r2rlvuz5xqcYwIZEPhRTLtBHfySEdyBBVGl4r8PX179B8WNHa6msU
Message-ID: <CANNYZj8TpE-SZjbd46G1u9JabeGL_oFK7__CgXg5QkGYg=DVzw@mail.gmail.com>
Subject: Re: [yocto-patches] [AUH] [PATCH v2 1/2] upgrade-helper: add state
 module and --incremental mode
To: yocto-patches@lists.yoctoproject.org
Cc: daniel.turull@ericsson.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 10:23:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4144

On Thu, 4 Jun 2026 at 13:40, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:
> So I'd suggest:
>
> retry_interval is renamed to retry_same_version_interval
> retry_any_version_interval setting is introduced
> retry_any_version_recipes setting is introduced, and is a list of recipes
> _prune() is adjusted to first check if a recipe is in that list, and
> if so, it's checked against retry_any_version_interval, and not any
> other intervals, so that it's guaranteed to be skipped until that
> interval elapses (and skip_reason() should consider that similarly)
>
> Otherwise, I think this is more or less ready!

Actually not quite. I'd really like to avoid duplicating timestamp
logic in skip_reason and prune(), and only implement it once, so
perhaps the way to do it is to have a helper function that returns a
dict:

{'verdict': True, 'reason' : "explanation here"}

Then function callers can pick and use the entries they need.

Alex

