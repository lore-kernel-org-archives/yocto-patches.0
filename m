Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E89FF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 11:39:23 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11324.1777376362603958786
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 04:39:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Xlcpvq8u;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fb8e9a4edso83634611cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 04:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777376361; cv=none;
        d=google.com; s=arc-20240605;
        b=lwxPpN4DLN5hiMi60UG+J3weMEyhyfMQ/my4MCkRbFwAxoDHd9q+DihAZgLc1o/Qop
         yeIEhUgeGpXpx6EmwtEEN2oAUTjupZb7iM8QQQZeUy7o/bs9JHMGbb0tcoHrgfuGV9Ao
         qmDj2pNeidinZBPMDRHBFDhhkzGz2Y8wr22QvfgwNmd1biRd2qXSBwKG/WspQgq5xvH/
         1PK/g6QJJ9b/UlGu7xxB4kDbmX7MxKO5dOf5cC6vP8lDtQMT60aQDj+3CCxbz/bA5FMr
         9I+HsXvAxh6+Fz2DfBHTQ1v3SgrjvJAI5QJNrCJCREF0S5Y3clHLnqjARC6o9iv6cX8f
         LmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uqr1gJRAwrTsK/x7KKHtTSGQPp8fusEknZnMU/YZwkM=;
        fh=60IiahOK0XKPZNZra6/7NaG44d/BLv5erzx8lzqCMA4=;
        b=f5RvfSvzwlnEp1+D0kIppurIWSlX1CsW42S1r1OIw9iVbqcnq/00HjEzIUobZ71YN2
         VI0TmpAMWY4gdC7jH/JzDzrR0FOcQ6JQkCU9JiEojrVqMrmmRVRkUh6p3sO7eQG5iDZ1
         0Bftogac7KO5pql1x64MO/vOIf5v1jfKrPbQZf5LSNu3OuxJqLV8OTmq0kXsFVWK+xHU
         HyM5cu2bhbNRI/NiN+ptui+t9+nyGgNMAFfUo+wSPTcF1lgpBjxUlJTTD2+7KzOXXPk3
         C1eet7tmuEO/jwsU7RyxKhk7ohL9wJRidp6bxtC98BY5yJaVcTBmsM/7p/R1+Es3Eumx
         2fRw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376361; x=1777981161; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqr1gJRAwrTsK/x7KKHtTSGQPp8fusEknZnMU/YZwkM=;
        b=Xlcpvq8uQc4GeEUjVdbsOIrsR2IlqumAFg2ZCPe0Z88T28gyeLLy95D+AdwS5RtZmQ
         M1goX6xs2NN4S9iXFKqvtfV7EUcamoxu9Nn4XqoROsUyCAPAwKvGMC+u3QDgsdtXtybe
         /MIS2H6zmTcnNfyIkYlO/UZGOCnL+LgGD40KjYoq4IPc6ji/tic4lNbvnJGN+sdafM43
         8rBSx3bkr2VLu3muRWVKYst5lLlzpGdCjmxEBIZX1TN61Y2Esd1bgWkANnAFBRaef7eX
         P+ZuQQUyLBCXG+1Li2/8icCE32WDkTEQ2gSzp/YkJMTGpksshBoC75fPYFJHqQDEmyuK
         yR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376361; x=1777981161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uqr1gJRAwrTsK/x7KKHtTSGQPp8fusEknZnMU/YZwkM=;
        b=QFcImxs61ENGtVCSNyafEQW4vMEPG6/z+2tZTJx1gW0hr8u1JnLKOCDq63sqZLshZY
         LXT+fkUZmJnGqKCBcFkYY4iR+tzW4azl7JU2b2rn+/4m3RDhpyJCDFB2rlUFSTpFy7XA
         fyJUt+uySAB063ToCd2/RDWd/qc+aSVI6oNMInKLHPVGiMNNLDBfEDm/qwsOpquMrXE2
         FCCOIgFOFdsFfoceh8PHnmB5moLsF0NQtpNNp7zfKh3SQ1EOQTkiAwG2JnIPpLwYTtRi
         avA4bL/zwt89slD7uOfHJicOulwm9/GHEfCNGVaOCnPa6wn44CSgx29CM0ko1OCE6wJI
         NFiw==
X-Gm-Message-State: AOJu0Yw+awa9cVyTXuFCvMUrp8/DDhG9IcnheZRfDiSPjtJtsTULuyOk
	LD7ixofoneIfnQFvmTQMzmNAoW+NZK/P+ujrTUyWze8qPI1A/OUyYrQGYdK+rp9X1KWrt7Ha0zB
	st1w+jJbK+MlUsXutGCotNBgmjrQ5nKY=
X-Gm-Gg: AeBDievhCa8N9DLn9IQbl2ab/sOvyjpnHrMlIucd8LVYjkNr9yCmeaJozLVheY7/Esk
	lbAxLmBmowQSId9/7XOREsmzDsR1UF82+Ny7sYOVw9KL3jXx/XFBNQgwlhY8PUcX3lGZkduSQzF
	hg7iB5InsMtZ02YHnj7LMXJtftoPk+/Rv2Iqb4aGQoqp3nMD9mzxGpzsHz/41uR3XbAxfCvEz96
	V/42AuD2razgt2KGvZCv4K5z+wsrZNQi708ZcVf9TLw9hbqeQeldmVR5/3Sm+Jtb1GQjILGncCy
	QKYzltGdC42eiyZl40usHYHi2sghAZYXzaSKcGOMtDIr8ZX36FAXV/fhS79tk7E=
X-Received: by 2002:a05:622a:4a08:b0:50d:7c18:c66e with SMTP id
 d75a77b69052e-5100e10e323mr36401211cf.13.1777376361426; Tue, 28 Apr 2026
 04:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com> <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
 <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
 <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com> <CANNYZj8dwq7RR0Z14rkrSR8rznCQ9=4=E0XxOGsbXLUOaxbphQ@mail.gmail.com>
 <CO6PR11MB5602A0CB35F09BE577F33A28ED372@CO6PR11MB5602.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5602A0CB35F09BE577F33A28ED372@CO6PR11MB5602.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 28 Apr 2026 13:39:09 +0200
X-Gm-Features: AVHnY4JW-UOsWLubHwH7VCBsmv-1DViAnnyXVwbIL9wuxXTOegH5OS0quzeOwVo
Message-ID: <CANNYZj_Sy-W6c=B154jsiuP7H3qmmeag=Qc8NnbP6j979T8K3g@mail.gmail.com>
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
To: "Chen, Qi" <Qi.Chen@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 11:39:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3869

Hello Qi,

thanks for the detailed answer. I fully agree those would be useful
improvements, my concern is that AUH right now is a very shaky
foundation for doing them. Specifically:

1. No test suite. This is becoming a real problem, as I struggle to
have confidence in non-trivial patches, and especially when they add
new features instead of refactoring code. This code can and does break
easily, as the amount of corner cases is particularly large. If I take
this patch, you'll expect me to take more patches that add even more
code, while still not having any way to test them.

This could be addressed by having 'mock' versions of bitbake and
devtool in the test suite. The 'mock' versions would print things that
AUH expects, both in 'success' and 'fail' scenarios, and maybe write
out 'upgraded' recipes, but otherwise do nothing. That way, all or
most code paths in AUH would be exercised, without having to run a
'real' upgrade, which is heavy, takes forever, and not really suitable
for testing changes.

2. Which brings me to the other issue, and it probably should be
addressed first: the brittle interface with devtool and bitbake. AUH
makes decisions based on finding strings in human readable output of
these tools. This isn't great. One way to address that is to move at
least the upgrade/finish/build/test/commit loop into a new devtool
plugin, so that it would use devtool libraries directly, and interface
with bitbake via tinfoil. Then AUH's job would be simply to determine
what needs to be updated, call devtool with appropriate command line
arguments (or maybe json config with the 'upgrade job' specification)
and to make reports/emails from resulting patches and logs.

Once we have these things, adding more features becomes a lot more
sustainable. I understand such a refactor is non-trivial, but equally
AUH as it is can't take much more extensions.

I also have a side question: when you say "Upgrade recipes (stable
version upgrades only) ", how do you determine the stable versions?
There's an ongoing discussion about this with some patches; figuring
out what the stable versions are isn't trivial.

Alex


On Tue, 28 Apr 2026 at 05:34, Chen, Qi <Qi.Chen@windriver.com> wrote:
>
> Hi Alex,
>
> I totally agree with you that "It's far more likely that an update builds=
 fine by itself, but breaks something not covered by AUH recipe builds".
>
> Let me first share my local practice and then share my thoughts on AUH im=
provements.
>
> Here's my local practice for LTS releases:
> Upgrade recipes (stable version upgrades only) for each layer using AUH (=
parallel build enabled) + manually checking the upgrade results + world bui=
ld
>
> I'm using world build instead of some extra build tests for each upgrade =
because I'm upgrading quite a few recipes in multiple layers, the upgrades =
are stable upgrades and the server is powerful enough to finish a world bui=
ld in a few hours.
>
> What I have in mind for AUH improvement for oe-core master is that, apart=
 from this parallel change, we can also add some other changes to AUH so th=
at it can be more efficient and save developers time.
>
> 1. A new step, compile_direct_dependents, could be added after the compil=
e step.
> What this step does it building recipes that depend directly on the recip=
e that  was just upgraded. The can be got by using 'bitbake -g world' + som=
e filtering.
> This step can be enabled by default, but could be also be skipped by sett=
ings. When enabled, it only builds those recipes for the first machine.
>
> 2. The machines settings could be extended to include fragements
> e.g.,
> machines =3D qemux86-64:core/yocto-autobuilder/multilib-x86-lib32 qemuarm=
64_musl:some-fragment-to-enable-debug-build ....
> In this way, we're giving AUH more build coverage.
>
> With the above improvements finished, a successful AUH upgrade in oe-core=
 means:
> 1) it builds successfully for all specified machines and configurations
> 2) all recipes that directly depend on it build successfully
> 3) testimage passes (which means if it has ptest, its ptest passes)
>
> When the emails are sent out, the maintainers really do not have much to =
do with a successful upgrade. The maintainer just reviews the changes, corr=
ect license if there's some license change, put some commit log and send ou=
t the patch which is a sign of commitment to fix any further problems. When=
 the AUH upgrade fails, the maintainer can also easily  see what the proble=
m is and how to reproduce it.
>
> What do you think about this?
>
> Regards,
> Qi
>
>
> -----Original Message-----
> From: Alexander Kanavin <alex.kanavin@gmail.com>
> Sent: Monday, April 27, 2026 4:55 PM
> To: Chen, Qi <Qi.Chen@windriver.com>
> Cc: yocto-patches@lists.yoctoproject.org; MacLeod, Randy <Randy.MacLeod@w=
indriver.com>
> Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor =
compile() to use parallel per-machine builds
>
> On Mon, 27 Apr 2026 at 04:09, ChenQi <Qi.Chen@windriver.com> wrote:
>
> > With this parallel build added, Yocto can configure oe-core's upgrade
> > to use machines that oe-core uses as the acceptance criteria. This
> > means a successful auh upgrade will very like to be merged without any =
change.
> > If there is some failure, e.g., qemuarm64_musl, the
> > developers/maintainers can see it directly without doing more local bui=
lds.
>
> For the purpose of updating oe-core, I feel a bit different about benefit=
s of adding more machines actually. I think it's unlikely that adding more =
entries to the two existing ones (qemux86_64 and
> qemuarm_musl) will help uncover more issues - if 32 bit and musl variants=
 are already covered between these two, then it's unlikely there will a par=
ticular 32 bit x86 issue, or 64 bit arm issue, or a risc-v issue, e.g. some=
thing that those additional machines would catch.
>
> It's far more likely that an update builds fine by itself, but breaks som=
ething not covered by AUH recipe builds, e.g. a dependent recipe, ptests, o=
e-selftest, or runtime behavior. Such things are unrealistic to test for ea=
ch update, and so they're done after the fact, in a-full.
>
> I agree that speeding up AUH would be beneficial, but that is better done=
 in the outermoost loop, which takes recipe groups and updates them one by =
one. Parallelizing that is more complicated, as each update operation would=
 need its own copy of oe-core repo in addition to its own build directory, =
but it would really run everything in parallel, including devtool upgrade (=
which can be very sluggish on large source trees or large commit histories)=
, buildhistory, and test builds. And of course, lack of AUH tests hinders s=
uch large refactor efforts as well.
>
> Alex

