Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF71C83F0F
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:26:13 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.16149.1751973966909333757
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 04:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UbPRHB+b;
 spf=pass (domain: gmail.com, ip: 209.85.216.44, mailfrom: rybczynska@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313910f392dso3400181a91.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751973966; x=1752578766; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2I8QYI4srheO1eK0/k5XQQyGj1/Gr6GU0euwD7gLfQ=;
        b=UbPRHB+b+swHkdQIzng/O5cw1TsjNmR+CjamWkIV4rzYrh+pv/heawBsKFdSTOmRAx
         2PgwiyvovbA7GMvNByqDFVPSC3NcbwuPXLvMZknukUx4ASS1xKE3bvf0HG/WKdg27CeN
         kqlIaAqkGT+wLOPG7dztNWt2bYnc8Fsbfb2bdqwwfUzzutE5/Rdo9SrlEOhdj2sLGahv
         xpF4V/7dltYDOz1VUoMik4OLY+Bwej0XeaAzViKm94kAFiLyvh4VEKYg0PLVu61FYGxK
         XdjrjuOpYRJ1uTuHmk0ve6rCv6P9hiXZWFFTNgVK8KN3IiU9Qo1B5Gjj4MIegAOvfM1y
         tLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973966; x=1752578766;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2I8QYI4srheO1eK0/k5XQQyGj1/Gr6GU0euwD7gLfQ=;
        b=BzMcD38pYB8HmVG0eFX06MtDhU9pCwqqkhM3iCCVyxPpdJXtsBw0zuPAMuY7BgDphh
         O2AACvpN8dmAInUEx+ep8RTQsQukoV+zY7FNUstJFFTcYaKPH7GWmDdfxaFL2n/pnbbQ
         wWowxTsEJVpLtupnvXmniBCCZvd7/2yBaRBlHJ84/MZ7O96X/zIm2eipg21VDRp8DbZ6
         qSXF8IFbTwKN3khtrtqBt3fsfwoLuqzG1Gf5X4MxE/+0BHzOp3o66TGzfJVgKFBSyBeG
         lovdNpRw2DvWMKzBiZqx51i3W0FTXF4pRIOaaI1yeKXm+HqQLUckzZpJwdHmUifEu0J0
         8dvA==
X-Gm-Message-State: AOJu0YyBYPxAZKn00ne7U9koFO4EBEuz3j69TFtxjzJCstRZi43AexGQ
	IGmAdwhxglrcYkq5jH8Zl9RKMVz6Zs9Vm25TFt4FDO5m6qm2MYMM0o6FemphGUC96yFd6bV4h9b
	XKzwhEzeFAqtTXbG0VszBKn22afSTmFjWCw==
X-Gm-Gg: ASbGncuiFCsLvjXPSk1sIKPTG/zH3g+ZX6UdRsfwv/nWhqlLc/FZ8c9785jjR3myeSK
	cgpgw12+M2/+rzciqh3xr+5E2y6fBMn8GKWDiAc1q6wSrU2kxgK4L+TtyFURiwgRlcNl01ml8GW
	LolgXsW6/wr077JXuMrIeRT5LeJ/s2XsL4AwdVJE/S0zg=
X-Google-Smtp-Source: AGHT+IHg5+CMIj5S/ZuMvI74UONuM8xF34hTrjSZk4IDblXdn+pmDeeAkwOAw7pAWN7nVh0eYSTJraPxe+oQQXEC3bM=
X-Received: by 2002:a17:90b:2e4e:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31aadd28eadmr29067975a91.12.1751973965771; Tue, 08 Jul 2025
 04:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <184F1B9597C17008.7007@lists.yoctoproject.org> <093773af-5310-49f3-a535-f7515f1562a0@konsulko.com>
In-Reply-To: <093773af-5310-49f3-a535-f7515f1562a0@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Tue, 8 Jul 2025 13:25:54 +0200
X-Gm-Features: Ac12FXzoksc0m5UiB93ffWvw2oMrgSWpUhzqkf4raJJAbcPJmuJRnZpD0bAZh8c
Message-ID: <CAApg2=S78+EH5COOEmTqOnGwxN9V7UyW9Rkyzj3nfCJpMd=RvA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/12] Initial fixes for
 master branch
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e2b72f06396939ce"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 11:26:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1784

--000000000000e2b72f06396939ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:41=E2=80=AFPM Scott Murray via lists.yoctoproject.=
org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:

> On Fri, 4 Jul 2025, Scott Murray via lists.yoctoproject.org wrote:
>
> > Thank you for your patience, this patch series is a start on getting
> > master branch maintenance back in order, and allowing Marta and myself
> > to try getting through some resource estimating for the new CI setup.
> > The focus has been on patches that allow getting through clean builds
> > of the majority of the build tests in the CI pipeline, which I have don=
e
> > manually for qemux86-64.  We will shake out any other issues as the CI
> > setup is tested (or reported via the list).
> >
> > Note that I did pick a few patches from the backlog on the mailing list=
,
> > but generally not things that were not build warning or failure fixes.
> > I did the S/UNPACKDIR changes myself, as I had started on them before
> > any of patches were posted to the list.  Additionally, there are 3
> > fixes for gcc 15 issues (the libhoth patches will be sent upstream
> > in the next day or two).
> >
> > I would ask that you give us a few days before sending (or resending)
> > patches with any expectation of immediate turnaround.  There is still
> > quite a bit of work to recreate a working CI setup, as well as ensuring
> > walnascar and scarthgap branches are in a testable state.  This series
> > has been pushed to master-next, and while I'm aware of the US long
> > weekend holiday, the goal is to merge these changes to master by Monday
> > afternoon at the latest, as I have some conference travel next week, an=
d
> > we do need to unblock folks testing against master branch.
>
> I have gone ahead and merged these changes into master branch, please
> let us know if you still have any parse/build issues.  As I mentioned
> above, I am travelling this week, so turnaround on patches sent to the
> list will be affected by that and our focus being on getting CI working.
>
>
Hello Scott,
Thanks for that. For information (for others, mostly), there are still
issues in
CI after those changes. We're on that (host contamination reported in QA).

As Scott says, until we have CI up and running again, the patch flow might
be slow to happen.

Thanks to all who have shown support and/or sent patches to help!

Kind regards,
Marta

--000000000000e2b72f06396939ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 7, =
2025 at 8:41=E2=80=AFPM Scott Murray via <a href=3D"http://lists.yoctoproje=
ct.org">lists.yoctoproject.org</a> &lt;scott.murray=3D<a href=3D"mailto:kon=
sulko.com@lists.yoctoproject.org">konsulko.com@lists.yoctoproject.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri=
, 4 Jul 2025, Scott Murray via <a href=3D"http://lists.yoctoproject.org" re=
l=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
<br>
&gt; Thank you for your patience, this patch series is a start on getting<b=
r>
&gt; master branch maintenance back in order, and allowing Marta and myself=
<br>
&gt; to try getting through some resource estimating for the new CI setup.<=
br>
&gt; The focus has been on patches that allow getting through clean builds<=
br>
&gt; of the majority of the build tests in the CI pipeline, which I have do=
ne<br>
&gt; manually for qemux86-64.=C2=A0 We will shake out any other issues as t=
he CI<br>
&gt; setup is tested (or reported via the list).<br>
&gt;<br>
&gt; Note that I did pick a few patches from the backlog on the mailing lis=
t,<br>
&gt; but generally not things that were not build warning or failure fixes.=
<br>
&gt; I did the S/UNPACKDIR changes myself, as I had started on them before<=
br>
&gt; any of patches were posted to the list.=C2=A0 Additionally, there are =
3<br>
&gt; fixes for gcc 15 issues (the libhoth patches will be sent upstream<br>
&gt; in the next day or two).<br>
&gt;<br>
&gt; I would ask that you give us a few days before sending (or resending)<=
br>
&gt; patches with any expectation of immediate turnaround.=C2=A0 There is s=
till<br>
&gt; quite a bit of work to recreate a working CI setup, as well as ensurin=
g<br>
&gt; walnascar and scarthgap branches are in a testable state.=C2=A0 This s=
eries<br>
&gt; has been pushed to master-next, and while I&#39;m aware of the US long=
<br>
&gt; weekend holiday, the goal is to merge these changes to master by Monda=
y<br>
&gt; afternoon at the latest, as I have some conference travel next week, a=
nd<br>
&gt; we do need to unblock folks testing against master branch.<br>
<br>
I have gone ahead and merged these changes into master branch, please<br>
let us know if you still have any parse/build issues.=C2=A0 As I mentioned<=
br>
above, I am travelling this week, so turnaround on patches sent to the<br>
list will be affected by that and our focus being on getting CI working.<br=
>
<br></blockquote><div><br></div><div>Hello Scott,</div><div>Thanks for that=
. For information (for others, mostly), there are still issues in</div><div=
>CI after those changes. We&#39;re on that (host contamination reported in =
QA).</div><div><br></div><div>As Scott says, until we have CI up and runnin=
g again, the patch flow might</div><div>be slow to happen.</div><div><br></=
div><div>Thanks to all who have shown support and/or sent patches to help!<=
/div><div><br></div><div>Kind regards,</div><div>Marta <br></div></div></di=
v>

--000000000000e2b72f06396939ce--

