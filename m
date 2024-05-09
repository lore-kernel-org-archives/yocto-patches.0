Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA467C25B10
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 12:48:30 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.9251.1715258904012833633
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 May 2024 05:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=II0e0G70;
 spf=pass (domain: gmail.com, ip: 209.85.215.182, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso657356a12.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715258903; x=1715863703; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJcM3+E5PvT7Spr2MQpDNAco3+5FRxn4cFzjOTSLbsU=;
        b=II0e0G70LBKTxOqueeVs/Km9zCsqXcqiSAQQ5pfZ0w1zup8Q57eUnEgyKcdDBWmeW4
         aju0sPyyrMXgy/bzmsw1SyKYINuiWvRdQ1LvRhcEaevPLqqtEsNSlnBW4L1KPiT8fwK0
         lABlphhyLSxRjULJXrpHw1W+yweIP4lPi01aHx8Zf4oE8FQbc0pxliuEMyNIFPWoOG7t
         IxDfPEB6K+kpoi27dXaiyK9Xz/AeOFdSVaj3TVtLODn9BUd2kDSTY+2U128+C8Zmzrsl
         0ZNXKptOJLzP7UI8wuMy18F9ODW4esh+h3GCZXUkA3N+NNbAL3Zvx13i69WTbcsB37wZ
         ogaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715258903; x=1715863703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJcM3+E5PvT7Spr2MQpDNAco3+5FRxn4cFzjOTSLbsU=;
        b=bEMO88YP/KUgU9Xk1lPDC5+XCowPJl6Mu8AP+WYnYTeGhdXEZOMZfQwSUBaXk35mdV
         jz160KdKCglfJHRnKZqU3iJ7uakFtUDQduTcJtNm3QJpx1HH2PhTEw04ZYcYmHC6R6jb
         k3G07Yfx+zW7rbm8nwsnmnUXM1yh0m4wDUs6PP5k3akmSpnXdNV+lxiG5gbVktFpWIgh
         2HLYMW8GAELK8ZEB0h61nB5LHIs8hKDCWNLJYEN2xbOzsJ6sr07q6oZNKHrEFS+daZ/o
         XxtoIP3y99CLKscvgUHY/Pq4gMQtAbihCmUkCXmsReJH0pbdPT1zYPC1ljrmprOp+y+E
         0Wcg==
X-Gm-Message-State: AOJu0YwdpQg80JMqmLeiHkLAfZsoiKrQgRM14fMcJEMoSvDsjFYEB3iB
	k4e/9l28BB6IM2wUBUjx61+AnEySSeesp0oRbvpMp2E4tGvNlKpyJeFc6k6OAvBOr6qa56HnzOV
	i8APu0qw1snVL88hRPHbIOGSPY4U=
X-Google-Smtp-Source: AGHT+IE/0yJ+5B4A4phCjMBNZnMxICOiANFPku/o/aBcvAEoV7RWH6/4Mq/O+YoTkVRkE6EL6QE5hdMIYWIZ7/r4Tgk=
X-Received: by 2002:a17:90a:940c:b0:2af:1d61:e65e with SMTP id
 98e67ed59e1d1-2b6165aeecamr5110194a91.17.1715258903323; Thu, 09 May 2024
 05:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
 <Zju3bQe0KEoRZcpH@gmail.com> <7aedf47d-3c8b-4627-b533-3cff6ceacc77@windriver.com>
 <CADkTA4P4vuunbmNc8O712pD9=uR=fDFcXwuwG129vd0yF-4VoQ@mail.gmail.com> <41fdcf95-8db0-44af-b7a4-56e9ec078f00@windriver.com>
In-Reply-To: <41fdcf95-8db0-44af-b7a4-56e9ec078f00@windriver.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 9 May 2024 08:48:11 -0400
Message-ID: <CADkTA4N4pnfMp3CZF1kWjc5vU+2X+cVFCT5R6cLju0AsAu5_zw@mail.gmail.com>
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
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 12:48:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/112

On Thu, May 9, 2024 at 1:40=E2=80=AFAM Yu, Mingli <mingli.yu@windriver.com>=
 wrote:
>
>
>
> On 5/9/24 11:22, Bruce Ashfield wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > On Wed, May 8, 2024 at 10:14=E2=80=AFPM Yu, Mingli via lists.yoctoproje=
ct.org
> > <mingli.yu=3Deng.windriver.com@lists.yoctoproject.org> wrote:
> >>
> >>
> >>
> >> On 5/9/24 01:33, Bruce Ashfield wrote:
> >>> CAUTION: This email comes from a non Wind River email account!
> >>> Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
> >>>
> >>> In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: a=
dd bfp configs by default
> >>> on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:
> >>>
> >>>> From: Mingli Yu <mingli.yu@windriver.com>
> >>>>
> >>>> Userspace functionality that requires BPF is becoming more common,
> >>>> so enable it by default [1].
> >>>
> >>> bpf used to have locking issues with preempt-rt, which is
> >>> why it isn't already enabled.
> >>>
> >>> Can you show some logs for your testing that has happened
> >>> with BPF enabled -rt so that we can document what has been
> >>> done to prove it works now.
> >>
> >> When CONFIG_BPF_SYSCALL is't enabled, there comes below failure with r=
t
> >> kernel.
> >>    # docker run hello-world
> >> Unable to find image 'hello-world:latest' locally
> >> latest: Pulling from library/hello-world
> >> c1ec31eb5944: Already exists
> >> Digest:
> >> sha256:a26bff933ddc26d5cdf7faa98b4ae1e3ec20c4985e6f87ac0973052224d2430=
2
> >> Status: Downloaded newer image for hello-world:latest
> >> docker: Error response from daemon: failed to create task for containe=
r:
> >> failed to create shim task: OCI runtime create failed: runc create
> >> failed: unable to start container process: error during container init=
:
> >> error setting cgroup config for procHooks process:
> >> bpf_prog_query(BPF_CGROUP_DEVICE) failed: function not implemented: un=
known.
> >> ERRO[0059] error waiting for container: context canceled
> >>
> >> And the above issue is resolved once CONFIG_BPF_SYSCALL enabled.
> >
> > Being able to run docker on preempt-rt isn't a use case that I
> > consider high priority. Not that it is a bad use case it is that if we =
want
> > -rt to have any value, we actually need to show that realtime behaviour
> > is preserved as we enable more options and run different workloads.
> >
> > Getting docker to pull an image doesn't prove/show that -rt and BPF
> > aren't going to spike latencies, or cause other issues.
> >
> > BPF used to cause locking issues and other latency issues.
> >
> > There are BPF self tests, showing that they run and pass is a good
> > first step.
> >
> > Then also running the latency measurements while running both
> > BPF tests and pulling, deleting, pulling, running, etc, containers is
> > the second thing we need to show. If there aren't any latency
> > spikes or locking traces we can consider it "safe enough" to enable
> > for -rt.
>
> Thanks Bruce for your clarification!
>
> I'm not familiar with BPF tests, so can't provide the test results right
> now. I'm okay with your concerns.

If you have any issues, let me know. I'm trying to create an automated
latency test image for -rt in the next few months, and running tests
like these while measuring latency is a good starting point (which
means I can spend some time on it as well).

Bruce

>
> Thanks,
>
> >
> > Bruce
> >
> >>
> >> Thanks,
> >>
> >>>
> >>> Bruce
> >>>
> >>>>
> >>>> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.=
de/
> >>>>
> >>>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> >>>> ---
> >>>>    ktypes/preempt-rt/preempt-rt.scc | 1 +
> >>>>    1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/pr=
eempt-rt.scc
> >>>> index 7ff7c0a8..a5e345f9 100644
> >>>> --- a/ktypes/preempt-rt/preempt-rt.scc
> >>>> +++ b/ktypes/preempt-rt/preempt-rt.scc
> >>>> @@ -39,3 +39,4 @@ include backports/backports.scc
> >>>>    include features/rt/rt.scc
> >>>>
> >>>>    kconf non-hardware preempt-rt.cfg
> >>>> +include features/bpf/bpf.scc
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
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
> > --
> > - Thou shalt not follow the NULL pointer, for chaos and madness await
> > thee at its end
> > - "Use the force Harry" - Gandalf, Star Trek II
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#108): https://lists.yoctoproject.org/g/yocto-patche=
s/message/108
> > Mute This Topic: https://lists.yoctoproject.org/mt/105976633/3618448
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
015/3618448/1484545583/xyzzy [mingli.yu@eng.windriver.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

