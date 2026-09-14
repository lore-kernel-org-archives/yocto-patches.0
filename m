Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B67C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 10:25:04 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17300.1789381498664054336
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 03:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SZR+zCVL;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90ceab90152so29959856d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 03:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789381497; cv=none;
        d=google.com; s=arc-20260327;
        b=jvdPeycOtuanYMoA+zQiW+Tya/Yqq2rmSOQfYhPR1rPycZUxYDvJLZSMz8kVd2CUX3
         U9Fg1/E4GC3mT9vqVlTXRF+2eckQHbAm2pCD+7C3RksAIkZqpANCgISgwAZmRBVW2Qbk
         XdKbYo32t+n0teGe+LdYrchIbJ9PYWzDaygDx0E4V+4aczcLMlv9THUNXUlD7rgFYMfh
         lJJPPFYUNu/CHArbfqdaqST7H/GkIq2xX8gID2Am6MzNFdWjFkiNLZ21HW7MJxdGsiEV
         wgaVlqKzbQRVQG27aBpWm9mSxiAEFZKFOwvGnyVtyWFLIc0P0Tj5iCNfKumpP847PDDo
         lRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iEZBnzOP60mn0EQlia56wC4qsHnYnxBr971PZG6zCJE=;
        fh=WFk6WqVLMumhhBiMgmEG6lAyoeJm2sRryqhUz7/ms2k=;
        b=ijB63WssC3IliiR53YwUNEsDWSTpylQ7gIPbBFoyYivAjEEkvbQz4X+TOcBEa6bN2n
         LJPaHZIsKW6/3ANEcW7IMMzeCDHqTHcj8wgKlB4ufSG3SI7vzD/1d/s1WNOEBg11SpLf
         1e5bBmqusA1NOGsME5ecg8qS1yaRPrsyTuR81LiBT5XdJjpbLIaKiS1RHjfmI/Pz22IZ
         npzE0Fz5P9hqnnXEtfFh57sSCXC0fSl3JpdV1RiZOF0oZVRO07sIry9GiDm56V0qiXMA
         vN3N0hM7onA/A/gYxUenj65hFi1SnmGWISTgSip2liXqHLR1h9fecf13FN7l2FSWX9VC
         NV5g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789381497; x=1789986297; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEZBnzOP60mn0EQlia56wC4qsHnYnxBr971PZG6zCJE=;
        b=SZR+zCVLqBDjaOJBR49EkpneQM3TinrR3iRek7KMgsZQIY+SyVohLEizLFtFo+TUAv
         OekvlkO9UNYd4rCS+DxAL7uAzPsUgA05sSbp5O46FR42QDMyRgllnyrB+xT74dOl2+hG
         t2Q2gnF77qL9Aooba3LL7N6igJMLbBXQdhugVal9IzfQSc8H2kB4pTsnlhgzARi9Y836
         8eOBrgAqgypu/LGgWq0txeySgQXZ5g5i4nbjC7QwSQ2pcfOQiM1L/WU0lsrbAaaPYSfR
         ycLep0ifgjiGheHgAWa7Z8u2whUYrMn64CxhUqGkDjmBntJUBwFg/brRLODmVsRKrlBu
         kS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381497; x=1789986297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iEZBnzOP60mn0EQlia56wC4qsHnYnxBr971PZG6zCJE=;
        b=C5Iw7IG5sDYU+CwmTLYmo81SJ/3K0199nN8TN2EmFCGiVuxEDs3/PI+0r/YkVp4fdw
         Dk/KvPtKDfUvwaI85vBKtxCV5H7KugyKT2RtuGGDaDaBIDgFbtsXpX65t2EZ3vuFc1Yo
         GIBjBMedFCrCkRo670li7fSfW+ZRxIM7uZOUtwkrxCcN43KXthKgkC/GqlayNH3ou1tc
         D0GgfvtZuXKNgr04sRNL0vCaUQ7Btcdp0UhCfG47mchk2KkMh091DlTxmsE5979RynKN
         WrqsdovI9y54cY/2lWVExAJ5QIvrZX3RR2N4GZBz7VJ8mK6qXNiA1xYDnIQNYKgTMfhd
         vNUQ==
X-Gm-Message-State: AFuF++kxZM3I+2dqmMRukSJ1gFCXC7XDtv0p/Ip4VrRe3e3ikGs4r1mq
	DWptQGi+py/VWDIxHlctNGiXWGmWGwrJO46BHRfL7uMxqohf6YOhEHXeTKkt4QSl+NGPCCoMavJ
	bhvwECE8JOskXs/5qyVdN+GbjV2hDY3U=
X-Gm-Gg: AYBFou2uV85xjs402Nx30aNr7Nsk7bz3n6rtiLAZJc3i5Ajvmh5C+uWG+8YkTpDYbcO
	H31zgxQU5970lp/UK+zD34HpE8v4wAaHMgvLBcOrN7m4JvKrB1MVd7YW/wo3Iu90JqlabER9Bk1
	oxh5a9H1Gwl1gwuwLCyI4fESSYuDYmOXy3znA/Ub50RtXw6Y/ToWcrL02RoZ0fEtfX0zr6SqahC
	f+tzaQbGImLqxSHFLMLpRtCXIb0DYQ1BWbYqH8dEEewp/kFcOQphNe+WPqECRInX+0d6cooWlql
	7KH+Bf2QvwLt1/UwPVviVeile61ul82ICHao8SH4UFfBrBVxrJBMsyzWlQLCFRopQkTgqwlNgJM
	Jfx02ikOeqDED0w==
X-Received: by 2002:a05:6214:5d06:b0:8ef:1fc9:935b with SMTP id
 6a1803df08f44-9122e4c3551mr24835316d6.12.1789381497552; Mon, 14 Sep 2026
 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260907131252.2810926-1-daniel.turull@ericsson.com>
 <CANNYZj-TeqYEDbrR6XLPv119e38QaPGDoA7RDTDczTnA38d2XA@mail.gmail.com> <5ad85174ef25d5389b9f42a53ce3b0e54377b1d1.camel@ericsson.com>
In-Reply-To: <5ad85174ef25d5389b9f42a53ce3b0e54377b1d1.camel@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 14 Sep 2026 12:24:46 +0200
X-Gm-Features: AcwNN1UGCAqaiMxVeRTMwluXfHY080KBPeMSbDCeJtnAW4j-UDbEvIG7Hh3_ruE
Message-ID: <CANNYZj-FMaWfmwk1C5Qz_W20S2Hf2eOU+AbhV8kDMyio=bM_9g@mail.gmail.com>
Subject: Re: [auh][PATCH] steps: ignore source in commit msg
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 10:25:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4827

On Thu, 10 Sept 2026 at 09:14, Daniel Turull <daniel.turull@ericsson.com> wrote:
> > This code block relies on brittle particularities of how devtool
> > writes out the changelog file. I wonder if we can rather make it more
> > structured, e.g. devtool writes out a json with all the metadata
> > including the pointer (filename) where the actual changelog text is,
> > and then auh can pick and format pieces the way it wants?
> Should we have the metadata in a separate file and keep a pure text with only
> the changelog? otherwise it may be less human friendly for people using the
> changelog text without the AUH.
>
> metadata:
>  - packgage
>  - old version
>  - new version
>  - filename of the changelog
>  - changelog text or filename with the changelog text

Yes, no walls of text in the json please. It should be short and sweet
and nicely formatted with indentation. Actual changelog(s) in seperate
file(s), as it is now.

Alex

