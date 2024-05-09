Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3DC10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 03:23:07 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web10.1646.1715224983882189026
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 20:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V/wLFDay;
 spf=pass (domain: gmail.com, ip: 209.85.161.42, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b206b78b47so172636eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715224983; x=1715829783; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idQJ6GSYbRTqqwFeurK97aWzy4PMTCNPYTV8e0JtBog=;
        b=V/wLFDayCPZRpQc6Em7EaWuk3NoQtgZNsit85McGKrijvIVn0t7gKvkaOAF9BZBkU2
         dUw0avN51wQJs5BHqqOa6Hp5AKm13wqz859ooe0RSOKkB3hYY5mlhc+5VfIGlzvtdV1B
         Vk98Tv+HjC6WYm/P7C6q185KdjKdhpn4KJuEUnM4IrEabrAiCGcIEOF/4KuRu19UGxqC
         eEI7yy5jQcc2knM4v+uiXLmPEQRW2wDJpm8sDvGuuJbFcYfQ7QtFl1H2OyWhBpNdNiJ2
         NUFLusYTzdUHkXYb+uwzFi32w3lqiemGuDC89RlIZ/FIco+um3MzjHSpE3rL4aWxszyb
         dKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715224983; x=1715829783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idQJ6GSYbRTqqwFeurK97aWzy4PMTCNPYTV8e0JtBog=;
        b=xRlYIxoxmZy1wU3GymWbwL/UQC7tIcB1PMERQScBJNDZcVAvIOuKQ5ir02sFzfzv5I
         EolqJ5QIXDJDrAhVcZKx8C3CaNHvaoYQv1fgyurkOHYWTBQsb7oiD4O1N9Y1A3HhWlxw
         Q1mUsdWewXgMp88EGqNDfJPjuzfTwcvd6xQANGypQNUxzer1xBG3CUFQ3Hz99miK3+dx
         bX7qhereo4gWkUZdd8O3VPMiS1d4IHhLWzy6F8/MgQdOxQEN7GbIuIskcJH0eDoEkXDk
         wAwYN5mHxjelGVsuyclEBefL3LcNyVZXuIjtGf0iOduWQ7pGMJo8TE0WQ/UPguAhxt65
         qNEQ==
X-Gm-Message-State: AOJu0Yxfd07BTXdZoJfOJ7daz2g/91s/VPiCDGbNYpPLYo37408PCc/7
	cKyMtwSGR0j13DnerZ75sTb+kZ0AoWpB3WZpinRt09BcILX3gX5YiZx13AWjLYsIsg5gF5E6JRt
	FnwMAk5A4xQYoC9NohSgeGfTLdSE=
X-Google-Smtp-Source: AGHT+IHQhh7OIUAWSfMOjLAW5mVfpN4qbOOd0j/DAR/JinUKUo+uZEQwskQWJH5FuBRHMTJHXc2u/JRKMf1+MazrAMw=
X-Received: by 2002:a05:6358:310f:b0:192:7ee2:f5aa with SMTP id
 e5c5f4694b2df-192d3778842mr559550555d.27.1715224982715; Wed, 08 May 2024
 20:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
 <Zju3bQe0KEoRZcpH@gmail.com> <17CDB04A349AA572.8965@lists.yoctoproject.org> <018454b2-f535-4626-a065-6a61a4560672@windriver.com>
In-Reply-To: <018454b2-f535-4626-a065-6a61a4560672@windriver.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 8 May 2024 23:22:51 -0400
Message-ID: <CADkTA4MZdG7ihiG+H7OgvuRSqzvq0MfgAhDFzrAiHpuB6ONCZw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, Kevin Hao <kexin.hao@windriver.com>, 
	"He, Zhe" <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 03:23:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/109

On Wed, May 8, 2024 at 11:09=E2=80=AFPM Yu, Mingli <mingli.yu@windriver.com=
> wrote:
>
>
>
> On 5/9/24 10:14, Yu, Mingli wrote:
> >
> >
> > On 5/9/24 01:33, Bruce Ashfield wrote:
> >> CAUTION: This email comes from a non Wind River email account!
> >> Do not click links or open attachments unless you recognize the sender
> >> and know the content is safe.
> >>
> >> In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt:
> >> add bfp configs by default
> >> on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:
> >>
> >>> From: Mingli Yu <mingli.yu@windriver.com>
> >>>
> >>> Userspace functionality that requires BPF is becoming more common,
> >>> so enable it by default [1].
> >>
> >> bpf used to have locking issues with preempt-rt, which is
> >> why it isn't already enabled.
> >>
> >> Can you show some logs for your testing that has happened
> >> with BPF enabled -rt so that we can document what has been
> >> done to prove it works now.
> >
> > When CONFIG_BPF_SYSCALL is't enabled, there comes below failure with rt
> > kernel.
> >   # docker run hello-world
> > Unable to find image 'hello-world:latest' locally
> > latest: Pulling from library/hello-world
> > c1ec31eb5944: Already exists
> > Digest:
> > sha256:a26bff933ddc26d5cdf7faa98b4ae1e3ec20c4985e6f87ac0973052224d24302
> > Status: Downloaded newer image for hello-world:latest
> > docker: Error response from daemon: failed to create task for container=
:
> > failed to create shim task: OCI runtime create failed: runc create
> > failed: unable to start container process: error during container init:
> > error setting cgroup config for procHooks process:
> > bpf_prog_query(BPF_CGROUP_DEVICE) failed: function not implemented:
> > unknown.
> > ERRO[0059] error waiting for container: context canceled
> >
> > And the above issue is resolved once CONFIG_BPF_SYSCALL enabled.
>
> And it seems the BPF with rt kernel issues have been fixed by Thomas as
> https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/.
>

We still need to do our own proofs, as I outlined in my previous email.

Bruce

> Thanks,
>
> >
> > Thanks,
> >
> >>
> >> Bruce
> >>
> >>>
> >>> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.d=
e/
> >>>
> >>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> >>> ---
> >>>   ktypes/preempt-rt/preempt-rt.scc | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/ktypes/preempt-rt/preempt-rt.scc
> >>> b/ktypes/preempt-rt/preempt-rt.scc
> >>> index 7ff7c0a8..a5e345f9 100644
> >>> --- a/ktypes/preempt-rt/preempt-rt.scc
> >>> +++ b/ktypes/preempt-rt/preempt-rt.scc
> >>> @@ -39,3 +39,4 @@ include backports/backports.scc
> >>>   include features/rt/rt.scc
> >>>
> >>>   kconf non-hardware preempt-rt.cfg
> >>> +include features/bpf/bpf.scc
> >>> --
> >>> 2.25.1
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>
> >>
> >>
> >>
> >>
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#106):
> > https://lists.yoctoproject.org/g/yocto-patches/message/106
> > Mute This Topic: https://lists.yoctoproject.org/mt/105976633/3618448
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> > https://lists.yoctoproject.org/g/yocto-patches/leave/13176015/3618448/1=
484545583/xyzzy [mingli.yu@eng.windriver.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

