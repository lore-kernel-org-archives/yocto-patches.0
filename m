Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5307C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 03:22:17 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.1636.1715224933781969239
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 20:22:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eDtw0rl6;
 spf=pass (domain: gmail.com, ip: 209.85.215.179, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e152c757a5so265434a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715224932; x=1715829732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmuuuuD/5BcNZ0F5GNPcegmktlDb3HjjMsVi2Xlw0qM=;
        b=eDtw0rl6NwPmTGrhOqjkBu2j0NuqB1Qp7srV7T7e69iDkFqUO1y7f7+4IRdAYCQTal
         m1YJcdJg2WREftfdmxOvjE3RFhO+1LtcFDuXjC3d5ODbg3vWYFiJRkhUoMYWahhyTsMc
         CHwZ49uqa/Pzw+GyMiNWJT9TaydyjAFNLE5y8ic+BJqhmHyj/dejW+74U5DGyHBfKmWK
         Vq7qAkfVQnPTnnTT0X0Awj+KUb+7XQmxqCIbtMF+bC9GkQ4glT6ae9gSwJ56B+l1fBhA
         gPddioL8w+6duN1SPkb7C5GPsgpwrXfR2Q1NRpCsHb9qeUn1oxUiL/KvFF/4cwNJXbCc
         w9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715224932; x=1715829732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmuuuuD/5BcNZ0F5GNPcegmktlDb3HjjMsVi2Xlw0qM=;
        b=WNwLKJYVXI/zqdzZb/gDOi/sOikYWnocs8EoCzsLc8kxnk0qmbSV+t5c10/NeFHXza
         X49O5VYBy8471xQDdi1NGrKHOYGbOjzigC451LdgbP3kXvpXcBs2LJ5De1DZjuvqFyb0
         zQ/0sRWAR36R5lv+u/evLVR8zxCeQnIVyoh7QMB8h7vBIBidTr3/TMDSjLr43TKdajIL
         yHmq0Ir+121rEaSAe4Aq52CA0X79Fs/H1CELTJmA5rZjM5TnmVuwfKcWtS53qfkJioOo
         XUcPc6PfKVVSx7vpIdHspOPsyulURYVau9cgtUOVuafqBgPr4cDklPcPAzr5t/xzUnV9
         v/Mw==
X-Gm-Message-State: AOJu0YycZTOe2RyYtiSHegADRsTQaTi5UxsmJHGtulVUO4/cGwF9QRQc
	QrXflGH6XTCIpF9U8zUzSDY4V2X1ta9ANdEmgXt4AwiM2Gj+SZg53FI30xaSIgW1I9VN8wuc16M
	9ePzZFWl/wHW5b1bxwfqMWi6D4WmZ3eN8
X-Google-Smtp-Source: AGHT+IEwi80abYZ5UItDzw/q4Frx8JfyggcoVw7MAsDJ+c91067aXQ3Iz1l1ml59b/k6gwXbnPEpkR9HNlJ7wFSH7ug=
X-Received: by 2002:a17:90b:909:b0:2b1:817d:982b with SMTP id
 98e67ed59e1d1-2b6165a0564mr4538590a91.14.1715224932437; Wed, 08 May 2024
 20:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
 <Zju3bQe0KEoRZcpH@gmail.com> <7aedf47d-3c8b-4627-b533-3cff6ceacc77@windriver.com>
In-Reply-To: <7aedf47d-3c8b-4627-b533-3cff6ceacc77@windriver.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 8 May 2024 23:22:01 -0400
Message-ID: <CADkTA4P4vuunbmNc8O712pD9=uR=fDFcXwuwG129vd0yF-4VoQ@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
To: yocto-patches@lists.yoctoproject.org
Cc: Kevin Hao <kexin.hao@windriver.com>, "He, Zhe" <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 03:22:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/108

On Wed, May 8, 2024 at 10:14=E2=80=AFPM Yu, Mingli via lists.yoctoproject.o=
rg
<mingli.yu=3Deng.windriver.com@lists.yoctoproject.org> wrote:
>
>
>
> On 5/9/24 01:33, Bruce Ashfield wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add=
 bfp configs by default
> > on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:
> >
> >> From: Mingli Yu <mingli.yu@windriver.com>
> >>
> >> Userspace functionality that requires BPF is becoming more common,
> >> so enable it by default [1].
> >
> > bpf used to have locking issues with preempt-rt, which is
> > why it isn't already enabled.
> >
> > Can you show some logs for your testing that has happened
> > with BPF enabled -rt so that we can document what has been
> > done to prove it works now.
>
> When CONFIG_BPF_SYSCALL is't enabled, there comes below failure with rt
> kernel.
>   # docker run hello-world
> Unable to find image 'hello-world:latest' locally
> latest: Pulling from library/hello-world
> c1ec31eb5944: Already exists
> Digest:
> sha256:a26bff933ddc26d5cdf7faa98b4ae1e3ec20c4985e6f87ac0973052224d24302
> Status: Downloaded newer image for hello-world:latest
> docker: Error response from daemon: failed to create task for container:
> failed to create shim task: OCI runtime create failed: runc create
> failed: unable to start container process: error during container init:
> error setting cgroup config for procHooks process:
> bpf_prog_query(BPF_CGROUP_DEVICE) failed: function not implemented: unkno=
wn.
> ERRO[0059] error waiting for container: context canceled
>
> And the above issue is resolved once CONFIG_BPF_SYSCALL enabled.

Being able to run docker on preempt-rt isn't a use case that I
consider high priority. Not that it is a bad use case it is that if we want
-rt to have any value, we actually need to show that realtime behaviour
is preserved as we enable more options and run different workloads.

Getting docker to pull an image doesn't prove/show that -rt and BPF
aren't going to spike latencies, or cause other issues.

BPF used to cause locking issues and other latency issues.

There are BPF self tests, showing that they run and pass is a good
first step.

Then also running the latency measurements while running both
BPF tests and pulling, deleting, pulling, running, etc, containers is
the second thing we need to show. If there aren't any latency
spikes or locking traces we can consider it "safe enough" to enable
for -rt.

Bruce

>
> Thanks,
>
> >
> > Bruce
> >
> >>
> >> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de=
/
> >>
> >> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> >> ---
> >>   ktypes/preempt-rt/preempt-rt.scc | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/pree=
mpt-rt.scc
> >> index 7ff7c0a8..a5e345f9 100644
> >> --- a/ktypes/preempt-rt/preempt-rt.scc
> >> +++ b/ktypes/preempt-rt/preempt-rt.scc
> >> @@ -39,3 +39,4 @@ include backports/backports.scc
> >>   include features/rt/rt.scc
> >>
> >>   kconf non-hardware preempt-rt.cfg
> >> +include features/bpf/bpf.scc
> >> --
> >> 2.25.1
> >>
> >>
> >>
> >>
> >>
> >>
> >
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#106): https://lists.yoctoproject.org/g/yocto-patches/=
message/106
> Mute This Topic: https://lists.yoctoproject.org/mt/105976633/1050810
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317149=
3/1050810/607820704/xyzzy [bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

