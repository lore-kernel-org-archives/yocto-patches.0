Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D8FF8862
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 08:55:36 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39007.1777280132175192196
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 01:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GIae6i/X;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d65f4073bfso1392289785a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 01:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280131; cv=none;
        d=google.com; s=arc-20240605;
        b=SGRZA9IDGMJrh50gszYZ3P7+4JpIf9pV0vQJv3m8KTP0iDMBUNvNx54wwfyhAGsT9N
         DdZ7rP6zLCW3KWGm3Xdk+vPssFOzwML0ga7I9/5QMF9yB+UcMDTqiTyMwAw8ftiDcdiF
         GVJjrufxeSYg4CH1QpkufuY/1Tppfip4SzY2kRFWg+dflltCV1C6RrPIpYe1xPO/vzyg
         pX02hpH0TQITd9MgbzQpqNV8T+7yjfDv6jSm8gDrgAi3hTFAiG6BpMEZ7fRGEOe5l4r+
         y0Atqsx5bAx+a851+ZVCWUxG01jl39nXYW2SWBtVifIKXriQweQkVdMkNVckjxWOpePS
         BqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WFRbez8k0XR29Lw1FCExqpxv6jEwZ5zGCXjdkRlzU8w=;
        fh=NpUYbtfyceGfIB1YO/o+nJWC4lWZz3AypSRhWWnPDwE=;
        b=FxD62kiGUAPW6+c6UJJBXmXIp95aWzNWRxRMPRj0iUb2XMqrslAd+Lhxf2kDrrRipz
         cw1KJqaEQMCsF34T5b6mc3e5uOUvie3gAKcK1MjRHNlVkGgnRz/7ud5Gr/Kzy/gXFF++
         bUXCmHzosMqPS0s4KlhqKNPmtW9hsRuqRl0lk2wjCcZo1cLUqd8MWMqy6Fr9TVA4zqgR
         zlN6qHGw4x3kKpQj8ByLfTlksdvrzntmOlMPaDEshkhaicAY/JWyyEsiWja5RuJLJ4Hm
         i9XUo6uFjR6P+U2khqgAHtneZIMoe2tV1rhLmF4opGUT7ieRPISQKEU/4oEnCOEzVaeX
         DE4w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280131; x=1777884931; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFRbez8k0XR29Lw1FCExqpxv6jEwZ5zGCXjdkRlzU8w=;
        b=GIae6i/Xx7Gvwrcf2Z+SqrtvODmMd2kc9n1ZDQrFCcJNEpCBveLLR4vv3m5+Q2xisC
         podB/2a38i+ND7UpW2zHrHnxo/wmbIz8ionuSXURiV1/30QiJsnY0zgREudK+OS0+IyK
         cxWOSw4mZ1hl6MyCg5EcTSF1LNFSJOwSccfz/cqAni/X6C4nTs7hdWSBZ2z8VraEmv8M
         LlcqBY65mR2LeEwg5pSDsMrKFSGHffURRi8Rvf9mRcxeX8E4DP/Avw1g09gW6e2sF4C9
         NQFeuYT/EIE8djFoqj5DjrEydCT2ORiHu1qUzSuCx3Di11IBQl2Sxs4QJPZlTha8xiLC
         W+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280131; x=1777884931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFRbez8k0XR29Lw1FCExqpxv6jEwZ5zGCXjdkRlzU8w=;
        b=nF7Kqx1ABD4sCFCuqSUc5dTB3PfZ/bdtI+kRJd7v28adqaPS3qddQZ0qc1T07JR0+a
         5eysVA68AIs0koYKOHQHYtofe7RBfyWHNTuBQ6lzJKN+hMHnIB+/bdWPD3dA5KPhqvbk
         JutRhYv5nBgqZgqQzzqFTijyZkl0nqbTRmXY22nodd/Vl0YiMD10X+hASWs0nCkdFEns
         82+b1GO9Z0nC+hOtdlVJrJbW5UkOahCrfuuBzqp2K0H5PYR1yCOuVSZkRwGXVc2d2kmO
         oWE9mL7FqeTzsHUsxAEIrcmGg690H6pSikWvykgLaR0TUviHhUKNj0e0nWkwbHA6DmWc
         1FOQ==
X-Gm-Message-State: AOJu0Ywewk2CZip/2gq1AJOUXmyjKiGpUyAeCTHSz1anYPErQ90JAQOD
	Mi51Pa42eDoyWtjrmtsyVkSHo1D/IFfvyW4qeBpIqWxDgtDkdEnkXPpEXf9UnLYwxI5xo25aPzG
	4k2CMnqiYaoM7Qqy65zPyQwJKXFcOe4TFgQ==
X-Gm-Gg: AeBDietYUkUWJMryqYgfCKeYhbLE8SGublcJDuzOpoHyFdHFoXQ1+zlul1Z3Jc7IxNi
	NgMLWwsHMTiFn0Q7E3ddjtRDrghr9k509YkWpNPbiyOfKTnnKNrne1kpxQMvQTbm0ZuF+pVMkdR
	FUrfE7HklkTW8avpJq/5JaUYRygZLT6j6sFgUBAgql7JXp+hEzzQi1KmPi3PjFTII6tJmMtMA50
	GN27JWcl9WYYilOwOqiuJ6xE33UnjF215mHEZXlGEYHS6CxM/m2iqViVRaMJIfN6tpNDud9DIVD
	auUvSf7Ac17rag8eJxH0WSeh0eYtDiaNBNT5nHdoCYeXKP7/MzSe
X-Received: by 2002:ac8:5fd1:0:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-50e36a3f60bmr626980571cf.18.1777280130951; Mon, 27 Apr 2026
 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com> <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
 <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com> <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com>
In-Reply-To: <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 10:55:23 +0200
X-Gm-Features: AVHnY4JTpLAb9r95_AjCHeEy3oiY3p-g4oGqzE0IVIu49pb1-XGYZqDcrGwzmRQ
Message-ID: <CANNYZj8dwq7RR0Z14rkrSR8rznCQ9=4=E0XxOGsbXLUOaxbphQ@mail.gmail.com>
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
To: ChenQi <Qi.Chen@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 08:55:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3830

On Mon, 27 Apr 2026 at 04:09, ChenQi <Qi.Chen@windriver.com> wrote:

> With this parallel build added, Yocto can configure oe-core's upgrade to
> use machines that oe-core uses as the acceptance criteria. This means a
> successful auh upgrade will very like to be merged without any change.
> If there is some failure, e.g., qemuarm64_musl, the
> developers/maintainers can see it directly without doing more local builds.

For the purpose of updating oe-core, I feel a bit different about
benefits of adding more machines actually. I think it's unlikely that
adding more entries to the two existing ones (qemux86_64 and
qemuarm_musl) will help uncover more issues - if 32 bit and musl
variants are already covered between these two, then it's unlikely
there will a particular 32 bit x86 issue, or 64 bit arm issue, or a
risc-v issue, e.g. something that those additional machines would
catch.

It's far more likely that an update builds fine by itself, but breaks
something not covered by AUH recipe builds, e.g. a dependent recipe,
ptests, oe-selftest, or runtime behavior. Such things are unrealistic
to test for each update, and so they're done after the fact, in
a-full.

I agree that speeding up AUH would be beneficial, but that is better
done in the outermoost loop, which takes recipe groups and updates
them one by one. Parallelizing that is more complicated, as each
update operation would need its own copy of oe-core repo in addition
to its own build directory, but it would really run everything in
parallel, including devtool upgrade (which can be very sluggish on
large source trees or large commit histories), buildhistory, and test
builds. And of course, lack of AUH tests hinders such large refactor
efforts as well.

Alex

