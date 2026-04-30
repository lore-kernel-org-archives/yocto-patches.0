Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA10FF886F
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 04:37:54 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13197.1777523862097638510
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 21:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bcyJV0uK;
 spf=pass (domain: gmail.com, ip: 74.125.82.41, mailfrom: rybczynska@gmail.com)
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c637089ccso542193c88.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 21:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777523861; cv=none;
        d=google.com; s=arc-20240605;
        b=gX9neJTH30I1TCswTL2JPdF5zaoW9CS65r5zu/jSgjOHM1jA46aOBn7dKCt1VdI+Fb
         SSZwrdN1Bsuq9d8A+Rvrzy0yf7hcu9Y1Yz7M2LNliAc23u9HMcyKIGpwbySGpkxxDknR
         FFpdac5sFj4LxVCOQ6EGsaq7aJkXz+T+CXCF7g48rKu4Qgum8lzDucOUULp8Gzbx1u+W
         PLmmfMMIYx/BaDuAev8gXH73ppKiZthN9HKMoRYucXl3SgMnzbIC1y7EaCEPmXIa7jZB
         zxi4vv8VwVFdxdAZsTmmTGgd9aZ3Bb2F5MOfR9VU27jQqixx20UDYMIcA1YUoMfM+Gn4
         H2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=8vsONn2Ai8tkSd7GqDg/9dxFBP9LED/inWO1e6Zs8iQ=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=ZGs3gzMXXVWIdGlE9V28ikFY3qrrshCecdcsqJkoQmMxInPkAYVa3kX8LmMoZPkIZH
         vOtbJJp7TFoZMVAAhrGMMhlk8zPaq22ZkdZ75vc93tLMr6Y/GShP8IFLk5x3+d4J4qrJ
         rwtASQu2xXmX+cdSu8cw5eLP7f4Oo2SOLnBegZLe2ZdQ1kNn9t75ddHhYopHRYUq4PDk
         I4YrsHXpWawV6zXF0Tb/i9dErHk1uOULaijdAeBhupedjeo9euPHJoL3kblQ9GecFi4w
         sNSfc9qN/Pc6mV14RNKyo4IRH9z4C80opllCypjh2iHtJonoso8fDAa+Z76cCkiFZmSi
         vqAA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777523861; x=1778128661; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vsONn2Ai8tkSd7GqDg/9dxFBP9LED/inWO1e6Zs8iQ=;
        b=bcyJV0uKY2XiBjJtCD7xYheeasdjbFg9YQFy7P/hFKpQpE0purMXpT/NWrFuGa/+3h
         gRowNVY2xWfde1nt4QSVT8kL7qV2DePOGkGvgzNr3DacbsNHMzJXKSL0syAkV+0Sjx8b
         pbQUyc7gYQOzRwmmCsRN+NNjwvn/TZFDC1bhSfAZiHMmTPA5QkjfcmD8ks1Si+Z9vYa9
         bWpo4+8W6vt8h4ug99q6TgsnnehJy12LjuRaXMFo2XpTj6btIVJQnULW4n7xHJm6O2I+
         81dxOWw11zQ6IXVN8tUNKpwN+vsHjI/lmhZuxQIWBoDPbkymSfyqzl5q3d1V9o5dpWwD
         CZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777523861; x=1778128661;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vsONn2Ai8tkSd7GqDg/9dxFBP9LED/inWO1e6Zs8iQ=;
        b=YqQI8KYMNCzxYCDvHUyGyfLxIb9ngzAeT4fRBkUbApnbQU1TWgdLbsZf94TWqLRmIU
         WVH+gyR/GTonifuxRw8gyLsTY7/Dytk1qvfCXJMzc2YPQN0O+sSySk+7+U0/BkTw5Eui
         OSun44zDTeMACzfm+Z6FR3z7mKLEydsTpR0n36EasM4rW4c6nyZpjs4Mi+yQulJohAKd
         6TfDt1a9+lf3LM4+GlT3u0pMw+uCwhBU7wa8lKFu/bhGK3hu6w3lGbzI6O2z8zPPws/f
         z++0j/3ppoDbEVeR1honBc0WJpgmZFkuf20qZXhTQUJ1oXygLFdWr6s/DpQ6GPscP6El
         O/AA==
X-Gm-Message-State: AOJu0YzG5vzqyMaFvp0wSGan7x/ImQW9/x2S/i+o+tsSlCacmUOrE89C
	cFjiyME8CZCqskC/2n0LIu6t1PE4LlIxDY7wyk0WauFMseJwOGH8yUSO1PdGQ86qATs0OcV+VcC
	9hokHTi+Y2gQIQ5WTGYERY0FWixGVrGFby4un
X-Gm-Gg: AeBDieuHgduez7S+aAs3bS0cX/qtUs4TeZ0SCQuq4VZWrpAAK8PQgy5FCNckK335se4
	/1WwTsPk7L/EJVenqPtHQLtmMrcepUS7xcY4kI2MHl9i0C9YllHsR1Dp3qw6yOxXvO5WqnjehUa
	aKjnoKbUWTJGXYH+DE21hxuIkT0IUUPCWWazlhO49TjaQW9MDEH1+c2tzcHkj5hKxq61MbyNQyK
	L6Fe1xYW4+r8GrgDFHhcFioKIgTDi1oDPeYu0D9H8bU7z/SNVmKjfkwzQp/RDwc/2aVWosDUv9i
	tHHkjVneXaJnSTy8VF8zhVenVRXVJDk4qZ18NcD6adaKgGyg8Q==
X-Received: by 2002:a05:7022:1a85:b0:12d:c039:65d1 with SMTP id
 a92af1059eb24-12deac3a170mr660891c88.1.1777523860598; Wed, 29 Apr 2026
 21:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777476608.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 30 Apr 2026 06:37:28 +0200
X-Gm-Features: AVHnY4K7l6KE6ymX0jXSD1a7j8fcdwPnRbqyhZKSWgN_z7opcwFe5g3fwg-sLWQ
Message-ID: <CAApg2=RVq1z9Fpq5YJUMAUt03wQbm60LfqhLm9B3QYQv=iC5Xg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 04/29 and wrynose branch plan
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004a733c0650a606ba"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 04:37:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3892

--0000000000004a733c0650a606ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:40=E2=80=AFPM Scott Murray via lists.yoctoproject=
.org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:

> This patch series rolls up the contributed patches (barring some from the
> past few days), plus several recipe upgrades/fixes from myself with the
> aim of getting known breakage fixed before cutting the wrynose branch
> (see below).  These changes are queued on the master-next branch if you
> would like to check them out to test yourself.  I intend to merge these
> to master branch tomorrow evening (Eastern Time, April 30) unless there
> are objections.
>
> With respect to the wrynose branch, the plan is to push it by the end of
> the week, or on the weekend if vetting CI takes a bit longer than expecte=
d.
> The one remaining known breakage that I am aware of is parsec-service
> not building; Anton has triaged it, but so far we have not come up with
> a fix.  Once we have one, it will be backported ASAP.
>
>
Reviewed those patches and it looks good to me. They also improve the
situation in the CI.

Kind regards,
Marta

--0000000000004a733c0650a606ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29,=
 2026 at 5:40=E2=80=AFPM Scott Murray via <a href=3D"http://lists.yoctoproj=
ect.org">lists.yoctoproject.org</a> &lt;scott.murray=3D<a href=3D"mailto:ko=
nsulko.com@lists.yoctoproject.org">konsulko.com@lists.yoctoproject.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This =
patch series rolls up the contributed patches (barring some from the<br>
past few days), plus several recipe upgrades/fixes from myself with the<br>
aim of getting known breakage fixed before cutting the wrynose branch<br>
(see below).=C2=A0 These changes are queued on the master-next branch if yo=
u<br>
would like to check them out to test yourself.=C2=A0 I intend to merge thes=
e<br>
to master branch tomorrow evening (Eastern Time, April 30) unless there<br>
are objections.<br>
<br>
With respect to the wrynose branch, the plan is to push it by the end of<br=
>
the week, or on the weekend if vetting CI takes a bit longer than expected.=
<br>
The one remaining known breakage that I am aware of is parsec-service<br>
not building; Anton has triaged it, but so far we have not come up with<br>
a fix.=C2=A0 Once we have one, it will be backported ASAP.<br><br></blockqu=
ote><div><br></div><div>Reviewed those patches and it looks good to me. The=
y also improve the situation in the CI.</div><div><br></div><div>Kind regar=
ds,</div><div>Marta=C2=A0</div></div></div>

--0000000000004a733c0650a606ba--

