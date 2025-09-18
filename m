Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42437CA1013
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 17:41:45 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.21919.1758217296398365323
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Sep 2025 10:41:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Zw7tc6Vf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7900952fb89so11152626d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758217295; x=1758822095; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePj/FDctOfX+FdQbThttaSuJ6XsfICK+h1QIIRRmQFI=;
        b=Zw7tc6VfETjnufTxXLxIymwFF1A2PgYr5vOWZ2ye58HKhC50cziYh5PPZ4udPktOmQ
         Ur9p2dBmMc5Yb1uuIaC0KKNT+rnuYQBf1wIk5NG1666a3OJL3DFXN7cIhwHdXQhTbSDq
         /oO+rQqgifFdjWPN/K4Ui7wSbhle3BBxXc+fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217295; x=1758822095;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePj/FDctOfX+FdQbThttaSuJ6XsfICK+h1QIIRRmQFI=;
        b=xD1nfpdEdcYzUd92JQU0FmawE9O0Ki5Zo7jA5TSqLCEYO/jCgXyQBu91kqxIey9jp0
         qerlIPdGQjAnfpvkV09QeO23fikZ+Wb/iziOF5IoVDdMS9F5L186xEsXjw/91y2YHWSo
         SS7GXp5rujbcWEFYQNoGoKAjDyU6TGPbIALLIlER3XMpu9LDvTJC6ENRtFdEopj+qjt2
         wAUNdo/Wq92gDUutnZNjfWP2qM9bIiSzuNc0WzePr6ezMQu20JDLhl0uYDEVhvhZGXPn
         0LZqyy7kRHYixe0td6PYklpN1D8tr6A2ieK+Q8xbjULULGzFLVH5bAgf064MqjX0bq4s
         9p2Q==
X-Gm-Message-State: AOJu0YyiJfde2jUbvO6gIMoX32VKK7LKtHuB4ocX5h+cFddzovlxYksq
	6gLcou1xNOmBtcoLrG03J/kEcCWPGgp3mxZbgrum98JzcDLJChcGuD+YpxV4bIgKeeA=
X-Gm-Gg: ASbGncvZQUhSOqAbn3aHG6JYfvNVjtPf0mYtyWMYr2t2ZWftBG05oQ6SqrsCOApUuLA
	n7YKgrfbkMwrE8vnVxyr12OAK+3NJ3RTx2a02m9YpT3yBYt5Bhygljk/BEFPyPUHeyXUjFKyNhi
	w5IJzMAz8Tc/VRYE8AW9pFur0RXNdklZfUxhn1aaZYaGH9/nVu9CBq9TbF80sa0t63lrhoNCdxn
	pkrO4lq4kTURH5deQexzyyG47XpzNrvkB3f3Bm6KpTMrKTygPoFEVK5R/ZrhxXaN7mEnGROogmb
	dOw6XwusZIUNRZox8Ls5diUSXwaBPGjGo4gzXWhEVXYIMnqms3eJtpDdR1WE9oL4CwBdHoEJ/a+
	ktWroPO0DWci7tDKRGhBtWVVrNXlcuDVgiw9jV0iMnGS3vop51DjojrfwybV/btjFBp+6dlVL6t
	af
X-Google-Smtp-Source: AGHT+IEnreX8SOkTDyB4+nk0ajcMtNEsNrmNykjTPHRI7OKFhDImGoY9er3dVFslCXcNw38/Yl/ekg==
X-Received: by 2002:a05:6214:5189:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-79914361ce3mr3646456d6.23.1758217295184;
        Thu, 18 Sep 2025 10:41:35 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79355ce6936sm15988966d6.66.2025.09.18.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:41:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:41:33 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marta Rybczynska (Ygreky)" <marta.rybczynska@ygreky.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com
Subject: Re: [yocto-patches] [meta-security][PATCH 5/5] lynis: update to
 3.1.5
In-Reply-To: <31ae3878-a205-4b83-a458-736af051607b@ygreky.com>
Message-ID: <a797760f-4f56-0c78-6c91-2deeff80c46e@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com> <730ebbddc121016151a72d3e0bce61351a0ad365.1758138771.git.scott.murray@konsulko.com> <CAApg2=TMGYOJN0=u5-YSSaEnZC3UDjnXf_deEpWSB9pAjFJyXA@mail.gmail.com> <bc3df76c-5037-46f4-ca68-b8e0fd281585@konsulko.com>
 <31ae3878-a205-4b83-a458-736af051607b@ygreky.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1341525007-1758217294=:17462"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 17:41:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2217

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1341525007-1758217294=:17462
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 18 Sep 2025, Marta Rybczynska (Ygreky) wrote:

>
> On 18/09/2025 2:42 PM, Scott Murray wrote:
> > On Thu, 18 Sep 2025, Marta Rybczynska via lists.yoctoproject.org wrote:
> >
> >> On Wed, Sep 17, 2025 at 10:43 PM Scott Murray via lists.yoctoproject.org
> >> <scott.murray=konsulko.com@lists.yoctoproject.org> wrote:
> >>
> >>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >>>
> >>> Tested on master (whinlatter) with beaglebone-yocto
> >>>
> >>> New in version 3.1.5 (2025-07-29):
> >>> https://cisofy.com/changelog/lynis/#315
> >>>
> >>> Added:
> >>> - Support for OpenWrt
> >>> - Bitdefender detection on Linux
> >>> - Detection of openSUSE Tumbleweed-Slowroll
> >>>
> >>> Changed:
> >>> - Corrected detection of service manager SMF
> >>> - Extended GetHostID function to allow HostID and HostID2 creation on
> >>> OpenWrt
> >>> - Check modules also under /usr/lib/modules.d
> >>>
> >>> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >>> ---
> >>>   recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>   rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (93%)
> >>>
> >>> diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb
> >>> b/recipes-compliance/lynis/lynis_3.1.5.bb
> >>> similarity index 93%
> >>> rename from recipes-compliance/lynis/lynis_3.1.4.bb
> >>> rename to recipes-compliance/lynis/lynis_3.1.5.bb
> >>> index 3546a9e..3d1e8b7 100644
> >>> --- a/recipes-compliance/lynis/lynis_3.1.4.bb
> >>> +++ b/recipes-compliance/lynis/lynis_3.1.5.bb
> >>> @@ -8,7 +8,7 @@ LIC_FILES_CHKSUM =
> >>> "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
> >>>
> >>>   SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
> >>>
> >>> -SRC_URI[sha256sum] =
> >>> "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
> >>> +SRC_URI[sha256sum] =
> >>> "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
> >>>
> >>>   #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
> >>>
> >> Hello,
> >> I was thinking about this one, as lynis is causing issues for each new
> >> version. The last version is indeed  ${BPN}-${PV}.tar.gz
> >> <https://downloads.cisofy.com/lynis/$%7BBPN%7D-$%7BPV%7D.tar.gz>, but when
> >> they release, they move the previous one. Existing recipes do not work
> >> anymore.
> >>
> >> I think the solution would be to use their GitHub releases like
> >> https://github.com/CISOfy/lynis/archive/refs/tags/3.1.5.tar.gz
> >>
> >> That would avoid the need to update the link every time they release.
> >>
> >> What do you think?
> > Those are not reliable, as Github may regenerate them randomly.  There's
> > actually a QA check in oe-core (src-uri-bad) that explicitly flags such
> > URIs.  It may be worth asking upstream to always also put the new
> > releases into their archive directory on downloads.cisofy.com right away
> > so that the URI can stay stable.  I can imagine them not going for that,
> > though, based on the recommendation to always use the latest version on
> > their download site.
>
> We can download the source code with the given hash of the release, as many
> for many other projects. Lynis doesn't have any build process, it is a shell
> script.

Yes, switching to git fetcher with the tagged SRCREV seems like a
reasonable approach (perhaps also using the new tag <-> SRCREV checking
in the fetcher).  I'd say perhaps submit that as a change on top of this
version bump from Michael, as I assume the real target is the older
branches that are going to be more likely to break.

Scott

---1463811583-1341525007-1758217294=:17462--

