Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF46CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 12:37:13 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14369.1781699829932618814
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 05:37:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PncVSnRy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so9585637a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781699828; x=1782304628; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVagAua5slCJcvFn2OBm/P2AqA4nSlLYxijMpfvj4K0=;
        b=PncVSnRyAf2Pt0OIw2LMS12bUdi+kH/rqpJp2F+Do3e21d8Vm4aZ8aPFJbmNCn3ZoN
         +dn+Vnrj1UyzMKSLaDPzKsd5urh8kr3KxxHp5sYW7tMpfiGxAsJvwPfAwd5WWTp7N4K+
         5jWr9fWpscEd0nxvern6y4c1L2/wzhVljcm38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699828; x=1782304628;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVagAua5slCJcvFn2OBm/P2AqA4nSlLYxijMpfvj4K0=;
        b=apwx2YPZKNqY9y7YYCjUm00jTyFL0Jed0nR1VmMFUOO9e4URgG+rr0S6xkTvVKOVHC
         k86gGkRHW9qNkvEoZwmd3bhiGZqLxgUxbR1OrmkHrlg9bl3yvmCAc/GvOxyCCbLgXSY7
         FZY709QtCOdP2O6+NdMVo2kNENRWlWNOJS35wm1mLAgdjQhpeVuDWVHI20TdcRiVQz9S
         9SBfSO9NT7WPTryrGKJlPv2dtMqogYq1LEfTHOHA2aYONHc4SJIRDwFr/zTgyo13VREg
         8RNG+W12M2zkq2gW2yb0tyw4si1KgNaJVR7Donf3QMuBVnh2X/b77RXumB0Jd0h5jS5Y
         wL6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+MaaBAscPL00QqXlHS7m0B9r5CwFYDw9iDL4DkfWMP/IEzuceL4qjcaOAe2XE54smiZMCFbAB6AGaZbXLW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwmgqDlk7GQPxArzXHpIBKZwWHbvqsBdpG97CXr4aC8/1RaNGlM
	ZTMarOFWBbuy6RU8s/2JULjq14Rqlqte5EDclRisL3/qpbuWj5jLEtc0R8/VXpZaozs=
X-Gm-Gg: AfdE7cmqQE6tvd8mRAybm8xnvRhr/Tfi2t9Pn8lQcq9bWc05icRdvVu6rVBb1hpN9Uh
	pqYdB/hMjqWZGbi/U8tmftqhTZfN1Wd5bdFQFw5bFYeUGlv3iygB8HOLz4k9YfKTsHHa+No4zYZ
	4ZcHIg6eZ6V7wo0NzpjtVpKtrbktVDOjY+BZGXqbGvmk7dL+eG30925Q4rXCc4fDBvvPNJ8p0xw
	sz9m4w6hdVnUHkdi5WUQkhLsUkRkEpW0z338iuAejxsCjXyMSNwA0h5HWN4BzLmEDEIfizNlhou
	2FD9GmhdPi7mv7jS99tUsL4VB7hs6Ce1DzYee/IPveWR+1gywSbj3nIqj6KMotoaCN+PxKT/Hhs
	zBQPg8KHLQvXSdSGR0E+sEVz3j5JPO4g4xTC0N3EhlNoGeyswuvCZOMp/jB0E8V5QdzwLEKmtvr
	R5L9pRzuwk74xl05KBvuBw1of+D2PzGMkFsBYRD/w3Ovk6t8jDu7rE7piXuA0It3TAF0CvkpmS5
	SnOC7D0ehX33CtK
X-Received: by 2002:a05:6402:5010:b0:68d:92cf:52f4 with SMTP id 4fb4d7f45d1cf-695473eec9fmr1658766a12.5.1781699828119;
        Wed, 17 Jun 2026 05:37:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1e34:81e7:2ec0:d3d5? ([2001:8b0:aba:5f3c:1e34:81e7:2ec0:d3d5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693c43a6d9csm5748452a12.13.2026.06.17.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:37:06 -0700 (PDT)
Message-ID: <67ec48c8598922257469ce1fc62a0bd8c68e742f.camel@linuxfoundation.org>
Subject: [pseudo] pseudo env corruption with bash
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, yocto-patches
	 <yocto-patches@lists.yoctoproject.org>
Cc: Paul Barker <paul@pbarker.dev>
Date: Wed, 17 Jun 2026 13:37:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 12:37:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4231

I thought I'd write down what I've discovered when looking into a
segfault in pseudo on the autobuilder. The bug in question is this one:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16078

opkg-build is a bash script. The issue is that bash implements its own
setenv/getenv/unsetenv functions which operate on bash variables as
well as environ. What that means is that bash's view is environ+delta.
bash does swap between different environ copies depending on what it is
doing but it only updates that when it is about to exec something that
needs it.

Pseudo noticed problems in this area a while ago and bypassed the bash
wrappers:

https://git.yoctoproject.org/pseudo/commit/?id=3D80c6334a2e4204cdc7132216f6=
4d1660eed62fd9

The trouble is that glibc's functions alter environ in a way which is
not compatible with bash and the two conflict. Whether there are issues
depends on which variables are set/modified in bash's local delta to
environ.

If I remove the glibc calls and just use bash's wrappers when they are
present, all the valgrind memory errors are removed and things look
much cleaner.

pseudo doesn't access environ directly that I've spotted yet, just via
setenv/getenv.

I'll ponder the right fix a bit more, the hard part will be getting a
list of all the envvars without using environ directly...

Cheers,

Richard






