Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C25FCCF9E3
	for <webhook@archiver.kernel.org>; Sun,  2 Nov 2025 17:59:44 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2770.1762106380621536890
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 02 Nov 2025 09:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IF/OSA/B;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-784826b75a4so41764587b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 02 Nov 2025 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762106380; x=1762711180; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZprwA1sk8Z31ldQ0/yknq0uf9iq0zcLxnLzLSymEs5E=;
        b=IF/OSA/BYjgU8BopCeSQptEye+CdU7lp6/fYrHPb82AUosjS9cWXSNhtvpcfvmvaxO
         8/dxqzk8lTZ7Q3SjxykFe4ma1iFaOq5nBgfouTVeJdgXR9FzraGcfMc3pVNDd6znyFHI
         XWcMG6N6UEhB/AoZUZ1udOiQgCZphmUQgcLirpb3mZcDtoZA3fBcm2jD6kzF1dIhc0fw
         OF4sIlV5fa43/xDBAw/e+UTlAeW6XXlj1gYKNe+HsWDYmIBxiYG8rjdDeKeih7/A737p
         Fg6HKZN+58Xi193edd7AWK5mR7ZiYFYr553Pkt1m1wvjg/bSrABrCGgzKyiTXi2Qq9W2
         j6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762106380; x=1762711180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZprwA1sk8Z31ldQ0/yknq0uf9iq0zcLxnLzLSymEs5E=;
        b=rtQJUkBfthZUD1W/wR6NZlhrPRkcItFjZEWNpNSuKNkZpANwAgFg6m06bOwWpiKHcX
         X6s2oVy+OjCAywWmN9verkusVbWqUN/wYiAPQDGOB+jKMXs+9ZZvPHAYKqD9srOi3QGc
         /LMvNkD+nSnMYtZIE7/zCqOOM3oyb7mMFfCIzOOBaB8D60gz1X9RBo1YDhkhasI+Gh6I
         2YtXWcD11D2DS+Sm/9/94D58UwjFYi5vy1n1jHw2UB7h3Iqo+XpuX0+eRW+BVDqg+pN5
         l7LFzwYhHAJef6eO0tyRvnqN4q78a7PszJKD2wS+D/GKTNi4wASxAelNLmdOKj1eNram
         GHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyrL8qOnwwKn3SR46Z5LOLMw2c+lctaAH1XxyBbtWzkLcqiTV6MdGBZsQ5nbkRKOBBitnrrWEiQWR/IN4R@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxKxJ3Q2+ty7eZ1sLcSkD8gMyeK6ibm7z0Uu3Ij/o2oDCuFaJfV
	F85Dg2ezreBCefzraQS2Jlf1cQbEv0mj/aIJJkIsOzdmDaox48Vhs4a4btX1vIAKMP/HLcclPmg
	ZYa/yYitLxeyfD3U/MFHM3iT5HuXBAs8=
X-Gm-Gg: ASbGncs5o+ssvsAFRx7U3JNnlnWMELGF2e2RbyQdd7knIUOF0p1So7L/sNnPJyUom7H
	8X7J3b/nHR/kWBVDDwaphBc55YCp8i9SRFeF0YNZ58LkoqaVaYX88Ip+nRdZDPT+rBSWRZaZ1UD
	e0IsaBfVJ8QPrx4DLrO9ZiZeMxQhNyXK+z0flO9rMfYH5ic0ujvI56idpJ7larIUl1iDgJJn0Ic
	oC2qFwVOKVIYUuG6jHmH8tdIJ2MBnRaM/CJEUTxFek3X/6yjjOoUYdJf4JefqbuElCo+Q==
X-Google-Smtp-Source: AGHT+IE+7FNpQcz5/xMz6XzX3oTuuNf0WUwT4UUtD/X4gTRgzhA03qa1ZXThm7/JqXOBhQRQbIa60Rn0K5iZ0ctoz2w=
X-Received: by 2002:a05:690c:64c1:b0:786:504a:4fe7 with SMTP id
 00721157ae682-786504b882emr71094747b3.67.1762106379711; Sun, 02 Nov 2025
 09:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20251031080447.2751414-1-Qi.Chen@windriver.com> <f61d5e8fdb8bfe0e01824520c3dfbd3221c84e6f.camel@pbarker.dev>
In-Reply-To: <f61d5e8fdb8bfe0e01824520c3dfbd3221c84e6f.camel@pbarker.dev>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sun, 2 Nov 2025 10:59:29 -0700
X-Gm-Features: AWmQ_bn6HnNsIsA4qLMcv29YhzPLopPxrmZlf2nx2SXmca3oRGu8MzV5iOVSvLA
Message-ID: <CAJdd5GbxVAVDq01o-m=vMQb45Jns5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com>
Subject: Re: [meta-mingw][PATCH] meta-mingw: support generating Windows SDK
 with no symlink
To: Paul Barker <paul@pbarker.dev>
Cc: Chen Qi <Qi.Chen@windriver.com>, yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000d1b6e30642a05cd0"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 02 Nov 2025 17:59:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2409

--000000000000d1b6e30642a05cd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025, 8:27=E2=80=AFAM Paul Barker <paul@pbarker.dev> wrote:

> On Fri, 2025-10-31 at 16:04 +0800, Qi.Chen@windriver.com wrote:
> > From: Chen Qi <Qi.Chen@windriver.com>
> >
> > On some Windows systems, symlinks are now allowed due to IT policy.
>
> Do you mean "not allowed" here?
>

IIRC,  Symlinks on windows have to be enabled by group policy, which can be
restricted by the domain admins. Unfortunately I think it is (or was)
disabled by default, so depending on how strict your IT department is, it
might not be possible to enable it yourself

>
> Thanks,
>
> --
> Paul Barker
>

--000000000000d1b6e30642a05cd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 1, 2025, 8:27=E2=80=
=AFAM Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev">paul@pbarker.dev<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 2025-10-31 a=
t 16:04 +0800, <a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_blank" r=
el=3D"noreferrer">Qi.Chen@windriver.com</a> wrote:<br>
&gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_=
blank" rel=3D"noreferrer">Qi.Chen@windriver.com</a>&gt;<br>
&gt; <br>
&gt; On some Windows systems, symlinks are now allowed due to IT policy.<br=
>
<br>
Do you mean &quot;not allowed&quot; here?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">IIRC,=C2=A0 Symlinks on windows ha=
ve to be enabled by group policy, which can be restricted by the domain adm=
ins. Unfortunately I think it is (or was) disabled by default, so depending=
 on how strict your IT department is, it might not be possible to enable it=
 yourself=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Paul Barker<br>
</blockquote></div></div></div>

--000000000000d1b6e30642a05cd0--

