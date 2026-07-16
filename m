Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C0C44511
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 15:46:43 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16123.1784216796935204067
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 08:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YLzUhP7c;
 spf=pass (domain: gmail.com, ip: 209.85.217.53, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-73f6a641f6eso2209321137.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 08:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216796; cv=none;
        d=google.com; s=arc-20260327;
        b=TCx0THJ2RjiNWg215E2MiLdGyddpJ6Pqk7TmVGFPSWofhjaovVqTHwwiNRdDVxxlJf
         q3hO8sgWKHcZ2B+uy3Pk929DSr9ouxpzSbBPUanKvD2MBcY2Pem+3XlMwElajQKu3R3N
         NYiGQopWEiYXSR+ugi49cKoZ3g6sI1UndIK34oIzQbBN9os0HdlS83qUncrfnyFnXVWT
         bQMusII5Yu4SpDCdETX0O+7Wjm1nFFXs8D2mS9CcyFrMlvNzXeKBvWMk/nlb4/1VQPRU
         JmYjemag81nTP6n9sujLslkgbzIUsTPjJmg0bXrm8SeWI9uYOcGGL1/dSRGTIgcYwb+A
         Vevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KVrk3SSAYVTkR8Jkp6o7nHGga+t2Z9oTqvQHJp5qXb0=;
        fh=J0h5LNkBHsYUDKXio0teohqa5ITY1AFIiE4e/apQEwU=;
        b=ciRQalAO0dueDjZX3ZR4VEhXkV0e8EYduqqzRDjggIEEOaO8huIs3aNtA5+wI8gkDV
         HKM/TIsrh160l62LYccwNw+1rTW0wz5hxhTmcKvkgJcLyqW4baFILq7skU/T+cRyWGp4
         IetsflhXUKvKfEcf7nsQFkqMNRMapfM7i3hH9IBl3/7rHHwBinmWFLrcnurzsXZKojsP
         baG/R3f3njbV6S5YeXp2tRrE6tdOEAdjFs0bLvHYNQpjsIKrOJbOuB0YhBbK+P9nvj8S
         1fYRjzJjUQvpEOsfImXMCPKzvWIPyjzkVd0gOP3eK63E4aAnzdjW2pr5U/SyqjNWLuFw
         uzVQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784216796; x=1784821596; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KVrk3SSAYVTkR8Jkp6o7nHGga+t2Z9oTqvQHJp5qXb0=;
        b=YLzUhP7cXuIOW59vzFLqzwTHVhswNehxUXTKh4SobG3gjxlZc4mlfMOsJlOEeSMXiz
         qO0gI4jKXyV2YgHn9pJGSZ+8WUMx1Rz6WIiaTlthr7G3RALSPs6Td1XowX0D7PTr5XQ8
         WsAuzNDEpwn4jS8g7dnU1c2AffhtQJdtCuJrTo5Qn4MXvvLZ5eazAO6HGTES8WBWsGx6
         ITVUlrTXJp2/Ov4Fk0OqNNh3Ci2olOlv037BcYxojwj8g8AHYiYrpkLPB6GwZT//Z0a7
         lQLCy0E1l8qAIDgflJa1nNOXJU9+Dr1Vp1a+OZDvM/qZXpSrwhK8IrjYJitN2KOg066B
         vDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216796; x=1784821596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KVrk3SSAYVTkR8Jkp6o7nHGga+t2Z9oTqvQHJp5qXb0=;
        b=AXz+7XDbTmMIZlwU0Zj1l7cE2tiIja+XumoA1Ah5j9qRq/JHlVPllbMaUleVlPLKTh
         Q527nV7BED60piw0ZYwk+Ini76VxnqR5m/rZ0n6rlC7tf3O6yLclslJp2zU163zE+4y/
         yIU99ZhF96AtptkGMU5WcKogaUeAceNayVS+kI2mq4os3wOG+GN0I5SPRO4MnPShga0M
         xAqZ6ziPuGz+ISfJczIr7vCRTKaFti2iCIYgVM+yrLkGGs/032j+rAjTvk/Ht7jDf14m
         mIYFmu4lPqI62udOrDTjUZezB2pr23Vo3g10HW5CGIURQLYdfQfuwSMfLtM/fh8EtiOs
         /Jsg==
X-Gm-Message-State: AOJu0YwAwN9Ol7wBtcnSszaIUhc2FQ9JAXknob6rhdBwDXhQiJESQN3o
	LD2ipKcweVbyDTx+sx43ES6UzoiC1smnOh/sOVBMtxf8rr9+f5XloANDA3UD4LyCYzS7NlAS2re
	7h8CrR7zpXhYu28ZufHaIdEA8qvJGc+I=
X-Gm-Gg: AfdE7cm5dCnJO2lldbp12vEA9YUubttz0tYig3dp0K+AB0UrdpV3tYVjXqKO7fvskkH
	855ejtmKwZ3rluUpY7IgZci+6Gr9nvNOJz6O8j4r/mF9mLuabTr8fd7JR9hUbcoOmk9UpiC1NYQ
	1cHilMJTRZ8wtyEGfCMvu3wwaqZRndWS4/Nr3pb5wIpUQ3OSUzBTE71o9j+jMbKPtb19yRzmMwc
	iTVHFoDH/2BZtLRrV6j7p1EBZ/LA0VUnpa+D9XDtodS/VboaBK4lAspEbP1I7y+x210sjObOsmP
	yJMBYiTrSQ8nA1inTg==
X-Received: by 2002:a05:6102:5814:b0:739:d787:be8 with SMTP id
 ada2fe7eead31-74599e0d81bmr4181114137.9.1784216795471; Thu, 16 Jul 2026
 08:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260715054142.7-1-bbnpreetsingh@gmail.com> <20260716055633.7-1-bbnpreetsingh@gmail.com>
 <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
In-Reply-To: <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
Date: Thu, 16 Jul 2026 08:46:24 -0700
X-Gm-Features: AUfX_mynaYK5hjlCuSqSe0t2dyuCIe33TsCFeyp9cLjHDJaNAo7cL46gMsc9z4E
Message-ID: <CAO8wpHypNwFNKPCnwzcgGcMVqHK9DscZ1XO8U1GD29W1kU-NbQ@mail.gmail.com>
Subject: Re: [pseudo] [PATCH v2 0/2] close_range: implement it rather than
 return ENOSYS
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org, Paul Barker <paul@pbarker.dev>, 
	Mark Hatle <mark.hatle@amd.com>, Randy MacLeod <randy.macleod@windriver.com>, 
	Vincent Haupert <mail@vincent-haupert.de>, Mark Hatle <mark.hatle@kernel.crashing.org>
Content-Type: multipart/alternative; boundary="0000000000004be1550656bc58c1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 15:46:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4496

--0000000000004be1550656bc58c1
Content-Type: text/plain; charset="UTF-8"

Thanks!

>  That said, I couldn't see what pseudo_prefix_dir_fd actually helps with
> and I couldn't see why we need that...

I flagged it since it is held open and a close_range() sweep will wipe it
out. I hadn't checked if anything still reads it untill now. It seems like
it is just kept open and alive and the socket connection + fchdir() has
been moved to pseudo_localstate_dir_fd.

So, for the follow-up I'd purpose:

1/2: remove  pseudo_prefix_dir_fd
2/2: add pseudo_pwd_lck_fd and pseudo_util_evlog_fd to the descriptors
OP_CLOSEFROM and OP_CLOSE_RANGE step around

If you'd rather keep the fd, I'll drop the removal and add it to the
protected set in 2/2 instead.

Thanks for reviewing,
Baban.

On Thu, 16 Jul 2026 at 03:46, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:
> > pseudo's close_range() wrapper has returned ENOSYS unconditionally since
> > 35433e6 ("ports/linux/guts: Add close_range wrapper for glibc 2.34").
> > systemd v260 deleted its /proc/self/fd fallback and treats a failure as
> > fatal, so under pseudo every fork+exec dies. That is [YOCTO #16339]. Full
> > story in v1:
> >
> >
> https://lore.kernel.org/yocto-patches/20260715054142.7-1-bbnpreetsingh@gmail.com/
>
> I had a quick look through this and it looks ok to me, thanks!
>
> > The v1 question about OP_CLOSEFROM stepping around five of pseudo's
> > descriptors while others exist (pseudo_prefix_dir_fd, pseudo_pwd_lck_fd,
> > pseudo_util_evlog_fd) still stands; happy to send a follow-up if that
> list
> > is short in both places.
>
> I had a quick look and yes, we should really be protecting these too.
>
> That said, I couldn't see what pseudo_prefix_dir_fd actually helps with
> and I couldn't see why we need that...
>
> Cheers,
>
> Richard
>

--0000000000004be1550656bc58c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!<br><br>&gt;=C2=A0

That said, I couldn&#39;t see what pseudo_prefix_dir_fd actually helps with=
<br>&gt; and I couldn&#39;t see why we need that...<br><br>I flagged it sin=
ce it is held open and a close_range() sweep will wipe it out. I hadn&#39;t=
 checked if anything still reads it untill now. It seems like it is just ke=
pt open and alive and the socket connection=C2=A0+ fchdir() has been moved =
to pseudo_localstate_dir_fd.<br><br>So, for the follow-up I&#39;d purpose:<=
br><br>1/2: remove=C2=A0

pseudo_prefix_dir_fd<br>2/2: add pseudo_pwd_lck_fd and pseudo_util_evlog_fd=
 to the descriptors OP_CLOSEFROM and OP_CLOSE_RANGE step around<br><br>If y=
ou&#39;d rather keep the fd, I&#39;ll drop the removal and add it to the pr=
otected set in 2/2 instead.<br><br>Thanks for reviewing,<br>Baban.</div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, 16 Jul 2026 at 03:46, Richard Purdie &lt;<a href=3D"ma=
ilto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:<br>
&gt; pseudo&#39;s close_range() wrapper has returned ENOSYS unconditionally=
 since<br>
&gt; 35433e6 (&quot;ports/linux/guts: Add close_range wrapper for glibc 2.3=
4&quot;).<br>
&gt; systemd v260 deleted its /proc/self/fd fallback and treats a failure a=
s<br>
&gt; fatal, so under pseudo every fork+exec dies. That is [YOCTO #16339]. F=
ull<br>
&gt; story in v1:<br>
&gt; <br>
&gt; =C2=A0 <a href=3D"https://lore.kernel.org/yocto-patches/20260715054142=
.7-1-bbnpreetsingh@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https:/=
/lore.kernel.org/yocto-patches/20260715054142.7-1-bbnpreetsingh@gmail.com/<=
/a><br>
<br>
I had a quick look through this and it looks ok to me, thanks!<br>
<br>
&gt; The v1 question about OP_CLOSEFROM stepping around five of pseudo&#39;=
s<br>
&gt; descriptors while others exist (pseudo_prefix_dir_fd, pseudo_pwd_lck_f=
d,<br>
&gt; pseudo_util_evlog_fd) still stands; happy to send a follow-up if that =
list<br>
&gt; is short in both places.<br>
<br>
I had a quick look and yes, we should really be protecting these too.<br>
<br>
That said, I couldn&#39;t see what pseudo_prefix_dir_fd actually helps with=
<br>
and I couldn&#39;t see why we need that...<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--0000000000004be1550656bc58c1--

