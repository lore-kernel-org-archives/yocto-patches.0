Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB94EE36B6
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 17:57:16 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51753.1770919027816518311
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 09:57:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P0jg1eYS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.46, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso69281e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 09:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770919025; cv=none;
        d=google.com; s=arc-20240605;
        b=HqHjHVi9JyPEzMAd7xyHedYHyhtnPHNf3hqaNGQMupl+sLy1YktxxG1lK2N4sps98S
         EG2Snpacd8kZSwHKFOMEmWjT6TrA+CzS+Syhiko44bsEs1IEhC2oGsWdfBb1gLk5A7DD
         k1X53mjTTfcdPO90/NwLhjxWGlxBbpTQ459GYEeT/8aC7kuakwf7JcRzbTLV9mST19Jt
         IkPIf7BtZlmGSQliR6/Oq0jk4g08bnAMx6LRMESQAXqiRPmzHvTV7sWbwEH6NV2zJ1yt
         RhUwm1ZXNKDwc3MQJc8EHhmcB0e1b8L0HgxI8v0cmjQSRVmYvnBTeeERzHnaClekqdsV
         zOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZKzzGTmAU8h4IjmHZhpJ32sH3o8kabd1MML0IdmfX8=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=QK9Q2RGhU0A7vGot9oXTF9Xbz+X/alSh2C5P5SqBSA3paeBvcjpWJiMPcM5wAGjHz4
         PjSBXFg797+pb/bk8HkQzs5tbrNUIRzeT0FgOKRAyyxLglEDSqZlAB8Z/tLCvRx+1Jw1
         TsXB7tnJ/4qC2BMP5zZXqo4JGTDY2JBUqpYO+85mtVSryGOtsq4rpTdCpYYsuBPru18C
         fk+y5Vk7RqRzUiLM3vAI8YL6F6u0cdOlW5V60bG5kxF/HevA4uj15bnF/s/HfU/VNaUE
         kJRvWC3EDsppYVNkOSq2tjJU2nF01jsZ7sQyMeCRfXg5aRqQXF5zA9MVTPzVE8SIZf0z
         KSZg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770919025; x=1771523825; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZKzzGTmAU8h4IjmHZhpJ32sH3o8kabd1MML0IdmfX8=;
        b=P0jg1eYS9XjxLT9QcwKvQuzKHnR3AiYAbaphnxvlC2770wdtAT0hzWiLw6lOKau2wh
         QZWPQH4Pwv8SZWgYrpVHgJ3Ur+rOk673F6+CToOR1Kf2iYwymKS0k8imshFhNva8RFg7
         ey0137E3uX60zczLebLiK5eV3UPNAkTh92cZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770919025; x=1771523825;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZKzzGTmAU8h4IjmHZhpJ32sH3o8kabd1MML0IdmfX8=;
        b=Hir3aaltgnKbQz9p4H1vGJ2WbzNSLq5IXsHqH3WiA6vFMOE72Qn+1FvfYWnCvRh9q+
         bROM9olumMgtWesgStx1S16NmVsnyxioX8xiIPOzKHaUINvTtva5qy1Tn6AgAM0OLG6e
         XEAxWTdKlkpyEdSJ29leQMdjoH/WLqIcuIu46BVYIfy/CicVCe0KTuhmA5ET/b7kKgRO
         nYDwmaoL3uBbHGQ4I/prEJjrlJ9FFtDlubwwbSmt1W+iYXz8PkJRpeDqwlXa6LQ3qpNI
         zWxJpbltSDm+l5ukt0A5lMOr9N39bT7RpxThfeczY4jdBGJ6zKIjdFCcYnoUh/t6RZXd
         rFtg==
X-Gm-Message-State: AOJu0Yy9EMKrq99hKg1NGXx4sumyIAfxPMmzcS0LIirFpVOZXNeXPq8k
	GNumnIgknqscOfcYivWi8iK4XbgH/O8iOFIyrHXjjzBXnRhoM7Dy5ndC1N8Hh5g/3RVnhWuF0Sj
	pPKWYyJRkECNOn2qpzpX63pXaOWFnOIFh9kzjvBPctK5hP2tTFokJXnoCAA==
X-Gm-Gg: AZuq6aKh7DhfqgZzR9Bg5qTLVuwH9PNvN90aa+Jk/uUuddqQT39nmwOWuJe7m94nPU1
	HA77pWiG233KWQmSxl7IYe6K9FZytTmcvoH5F9F9FMElLwKDp3nKw7x/b6EXoldKw0kI/oxH3ZC
	0w/o3lnbGM34rP+AIheUg/9SV/BY4v4O1Sf7J6sNbf6W8U1qojm4SUZTvmTeDgG9wYpTsohfN6y
	sRgcV/P14XXkOjZkE3G1KpsJ/wh+Ox6Z2engGpBO8lC/ZQhcnx8uZugBvWjvPvUC6V09Ny9QdAP
	7+cx+lCxPnCaBlznmpKDO2z7wKHaMf4=
X-Received: by 2002:a05:6512:36d8:b0:59e:6c2c:f235 with SMTP id
 2adb3069b0e04-59e6c2cf24dmr159197e87.32.1770919024744; Thu, 12 Feb 2026
 09:57:04 -0800 (PST)
MIME-Version: 1.0
References: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
 <DGCU4J5YR1W5.INVOLGGIIOMG@bootlin.com>
In-Reply-To: <DGCU4J5YR1W5.INVOLGGIIOMG@bootlin.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Thu, 12 Feb 2026 09:56:53 -0800
X-Gm-Features: AZwV_QhiAAI-hIKlmWXKyjvxarZbLlGV4XgL6bNG1M4HoBVjHyjY7vy-GHbuOgs
Message-ID: <CADfgfoa0uB2JuykV+itwLU5E8QJD-6+ve0b3OROzu48okHMDEg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/release-parser: remove poky repo add wrynose branch
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 17:57:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3229

Antonin,
Your patchset is much better, mine was just a quick fix and not tested
on production. Let's revert and take your patches plus an update for
https://wiki.yoctoproject.org/wiki/index.php?title=3DReleases&oldid=3D86736=
.

+        if branch =3D=3D "yocto-5.3":
+            status =3D "Stable Release until May 2026"

On Thu, Feb 12, 2026 at 12:19=E2=80=AFAM Antonin Godard via
lists.yoctoproject.org
<antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>
> Hi,
>
> On Thu Feb 12, 2026 at 12:15 AM CET, Michael Halstead via lists.yoctoproj=
ect.org wrote:
> > Remove references to the deprecated poky repository. Use meta-yocto for
> > tag data instead. Update to include the 6.0 branch.
>
> I had already sent a series about this:
> https://lore.kernel.org/r/20260204-releases-parser-updates-v3-0-be208a774=
8b1@bootlin.com
>
> Which does some improvements to the script, mainly for maintainability. I=
f
> there's better reason to use meta-yocto instead of yocto-docs, maybe we c=
ould
> merge the two? Should I resend?
>
> Antonin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3220): https://lists.yoctoproject.org/g/yocto-patches=
/message/3220
> Mute This Topic: https://lists.yoctoproject.org/mt/117766234/1003190
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1316220=
5/1003190/458545045/xyzzy [mhalstead@linuxfoundation.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


--=20
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

