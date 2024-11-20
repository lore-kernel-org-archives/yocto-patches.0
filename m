Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85842D743E7
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 22:02:42 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web10.128.1732140154250884846
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Nov 2024 14:02:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=A4Kta8r/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b35b1ca0c2so148808285a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732140153; x=1732744953; darn=lists.yoctoproject.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT5l2OtLGszoOSoBFPp057jVRGtjM2VG3ZBn+X0bxbI=;
        b=A4Kta8r/0FolwTv7xcTrYFW6DCgOb4WE9v3szJ8dWfprTogElvG+gS62H0zq6bB5QC
         4HlVTwc/mfPKDH8YNY61nlhIT+m/im3SS+bpiXwpKrFZBrhX5r/ntjxyPGMST6VbztKz
         5bXFn4PJOinK+Bw5ejo+upe39q/HznQ0sySBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732140153; x=1732744953;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT5l2OtLGszoOSoBFPp057jVRGtjM2VG3ZBn+X0bxbI=;
        b=LrdpVP/w2cGewZxZT4tja4RVyvA4zzOpEO0eAOtiWKtvoMJpTFKo2vNMbJY440JrBS
         /5b1piDyp3xkOw0LvvO+/dCgj7i8RqB/UGseIREamfkXJ0yjSMjJM8q+Ex1lEbLH/mb4
         aFAqmBLLcRkzlaezbSX/GR5p3+1Z9j4O9C+wmUUv2XWUVVGgNzHPKcpcB4GvqLrtubQl
         gSx9weLlXtgLSavLv3wcn1GSAyQB5CV9shuyOKX6sq10J9FXMjzKN9Jn6nRhG8jkEm74
         7lSq8NlOgPQtaYTOV1JgEnz7bDSPASVtpPR8pB488jw3qDbdRXYo9z0JHe16EqxmVyWf
         KiZA==
X-Gm-Message-State: AOJu0YzBhgYGKH3G9xr7HT3bHcHlCHg6jjIi6nOR4MadD9eaWVJ2DMUZ
	t+jcTNm0ErK5WOW1eiDw4kwmzk9rybYwryG9VHggvMVDxY3pgS6JvrTYEDBZ3E4=
X-Google-Smtp-Source: AGHT+IEokIsCUJ3LmoLk2YpcKLdQDoG/z75QKVujGn0V7ck9gsNcAc2ANMy+5r8HgDlM1mnMaoWCCw==
X-Received: by 2002:a05:620a:8904:b0:7a6:75e6:3c21 with SMTP id af79cd13be357-7b50c11a595mr158762185a.1.1732140153128;
        Wed, 20 Nov 2024 14:02:33 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b34e0sm15502376d6.22.2024.11.20.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:02:32 -0800 (PST)
Date: Wed, 20 Nov 2024 17:02:31 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: dorum@noisolation.com
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins] Create scarthgap/rust branch
 to backport Rust 1.80 to Scarthgap
In-Reply-To: <C9A737D5-315E-444F-8D89-1B190D13D3AC@noisolation.com>
Message-ID: <fa7168a8-5e96-9025-8fcf-c13df18e54a8@konsulko.com>
References: <C9A737D5-315E-444F-8D89-1B190D13D3AC@noisolation.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811583-424729196-1732139793=:33593"
Content-ID: <edc8ffed-8442-d92a-940a-d95165334cd7@spiteful.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 22:02:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/827

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-424729196-1732139793=:33593
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9bf43531-845a-c054-1cfd-45aa51ed163e@spiteful.org>

On Wed, 20 Nov 2024, Martin D�rum via lists.yoctoproject.org wrote:

> At present, upgrading from Kirkstone to Scarthgap might mean
> downgrading from Rust 1.78 to Rust 1.75, because
> meta-lts-mixins kirkstone/rust exists to backport Rust 1.78 to
> Kirkstone while there's no equivalent for Scarthgap.

That's not quite correct, the intent of kirkstone/rust is to track
master, but I have been slow to pull in the post-scarthgap updates
(sorry about that).  I will be pushing updates in the next day or two
to get it up to matching HEAD of master.

> We encountered this issue as we tried to upgrade from Kirkstone
> to Scarthgap and were unable to build code which depends on Rust 1.78.
>
> To enable our upgrade from Kirkstone to Scarthgap, I created a
> meta-lts-mixins scarthgap/rust branch myself, with backports from
> the current Poky master branch, in the style of meta-lts-mixins
> kirkstone/rust.

It has been my plan to create a scarthgap/rust when required, and
similarly track the latest versions from master as with kirkstone/rust.
I have not had a strong need for it yet, but had mentioned on the YP
call yesterday that I was going to work it up for next week.  If you
don't really want to maintain a branch for the next 3.5 years, would
you be open to waiting for that and my doing it instead?

Also, there has been a request for a kirkstone/rust-1.75 to have
a kirkstone -> scarthgap correspondence, and I am aiming to get that
pushed to meta-lts-mixins this week.  From what you describe, that
seems like it might be a better fit unless you explicitly need newer
Rust.

> I kept the recipes as unchanged from master as possible,
> but I had to replace ${UNPACKDIR} with ${WORKDIR},
> as that change turned out to be incompatible with Scarthgap.
> The Scarthgap version of the recipes uses ${WORKDIR}.

With kirkstone/rust I've tried to avoid changing recipes as much as
possible to ease future backports, so I would suggest not doing this,
and setting UNPACKDIR = WORKDIR in the layer.conf or in just a minimal
number of places in the bbclass's if possible.  The former has been my
plan for scarthgap/rust myself.

> I kept the master branch's Rust 1.78 recipes,
> even though they don't work.
> They could be made to work by setting different shasums for different
> Rust versions in 'rust-source.inc'.
> I kept it as-is because if this should be fixed at all,
> it should probably be fixed in the master branch first
> and then backported.

I would just drop the 1.78 recipes, as you do not want the hassle of
someone seeing them and trying to make them work.  If you're keen to
make a go of maintaining the branch, I'd suggest taking the alternate
approach of starting with the first post-scarthgap update commit and
working forward.  This is more work, but has the benefits of:
- establishing and testing the workflow for updates for the life of
  the branch
- allowing downstreams to potentially pick out the various
  intermediate Rust versions.  I do not make guarantees this works
  for kirkstone/rust, but it should in practice.

> I haven't tested this extremely thoroughly,
> but I've verified that a basic Yocto project with Poky Scarthgap +
> scarthgap/rust can build librsvg (a Rust library).
> I've also tested it with our real-world Yocto setup which
> has some application software written in Rust.

Note that unlike with kirkstone, there is some potential to keep the
Rust selftests working with the mixin layer, so if you want to run
with maintaining this, I would suggest looking into that.

> What follows is a commit which works as the root commit of a new
> scarthgap/rust branch.
[snip]
> diff --git a/README.md b/README.md
[snip]
> +Maintenance
> +-----------
> +
> +Layer maintainers:
> +Scott Murray <scott.murray@konsulko.com>

Heh, I'm not adverse to this, but if you'd like me as maintainer
or co-maintainer, I would prefer to submit my own starting point as
mentioned above.  Otherwise, please resubmit with your info here.

Thanks,

Scott
---1463811583-424729196-1732139793=:33593--

