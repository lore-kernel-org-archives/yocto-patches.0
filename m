Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C4C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 09:20:52 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.19552.1740129645482965045
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 01:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eghcgY/P;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e6846bcde2so15604876d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 01:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740129644; x=1740734444; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87Iwb78d55/pylvCid3k5z/XX8E8HHwWf6M9UrYNg4c=;
        b=eghcgY/PEXAOKMSAGN+XrSwDPR7BW0UNDyrH5sGBExZoahClUgZAtHSdEHIHo07HTI
         49/q8anf39krlffuSmvjwRA6H/LQTwRXlB9GBj7norgKeXyEght0yrY9h4+ya1gil00p
         90+EFTFFOawNJJG4EdlyXbWNMzw9XhavF1lZmmGGqdB9rn2fjNX5koPxvQsmMLp6GYkL
         1o3drB3Cue+wVynnpBwWLqxg7I6s6JbpZhwdQvxfDAPEF/oikfHRHlAgVUIPFss/Us3I
         JOVGe/m4FSbdn5NdMOmJxMH/YFXCSSeGBSvsc98xeVQUwcYHL0a2y3lESTptN1612WZE
         bEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129644; x=1740734444;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87Iwb78d55/pylvCid3k5z/XX8E8HHwWf6M9UrYNg4c=;
        b=wsGB1by9ymVU5nupwXpMBElTE/ZTFRDFfw3/VVkvMidO/4ORvKUXIvKWs1YbsUbaOV
         TMYw1MFYFcQS3xlE7UN4mDNsKAkqbyd9KRoEmFXxM//4t7Trk/Kgq4byQqhvz8G7g+Cj
         BORR+OxBJkczkgBwAu05ZmKYuiGNHEgA61NEb+R9bCk5JDQCePPxs7GKdrr67kJRT4Ta
         IO9UJb60KfG5WRrco3Aexi9eBqwpScLAWbEiTHqcwWKvKKgSPhjcdrc5WEvjHkxPgS5Q
         12qkIXAz9HdqxwScoy6kuTtGOUD1OSv8pwwR+H2AEyGpazRtza9Tj710lE9xKpVODqQk
         /NFw==
X-Gm-Message-State: AOJu0YzQxxke96Pixr4nhHcLDDZKu5s3bAEajIU6lUOvb6c2EfAgi0Wk
	HBRQao9qKwUp2V74cPWC9EbcSH8C0Ape2BTAvtdU1Cw2S9ljrS1HU8If/3S4/12/FYcLqHFMMOw
	lbrzp1H29S1/wTReajyqTNkGecXAsDVq2
X-Gm-Gg: ASbGncsw47hcjk1cqgA48NityPHF+WTy1L4AAi/Ucz01KUfYnZVi7MFrgPGAM6tfqoe
	FGa0hkXXb0oXxriJU2y4lX+DPFk+xTxGsYzk9ksb/hXHJN9iWpOSe150DV34NaRFV6tAbkcGiAp
	YFf74EIRWJMpLlAF/P6yri9I3XrRqY8eKSmnA+o2baIg==
X-Google-Smtp-Source: AGHT+IGN4SRJ+YN/DhL77TGLj/DDLXLW6dSQrwQDdThj451s8S2eILyAMpgeETusKSU2x97nQbSIGlRg7PjJ/WhC6Wc=
X-Received: by 2002:ad4:5942:0:b0:6e6:5ec3:868e with SMTP id
 6a1803df08f44-6e6ae9be0c2mr34036426d6.31.1740129644490; Fri, 21 Feb 2025
 01:20:44 -0800 (PST)
MIME-Version: 1.0
References: <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
In-Reply-To: <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 10:20:33 +0100
X-Gm-Features: AWEUYZmAUcOlDQNoPBiuQ7SLMG98dtmz7Mc58LoYA5dQErWubp5nF89pmb5zfO0
Message-ID: <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in patch
To: yocto-patches@lists.yoctoproject.org, wangmy <wangmy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 09:20:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1113

On Fri, 21 Feb 2025 at 10:12, Richard Purdie via
lists.yoctoproject.org
<richard.purdie=linuxfoundation.org@lists.yoctoproject.org> wrote:
> > It's definitely the best thing to be able to do this
> >
> > But there are many patches with this problem, and it is uncertain
> > what the purpose of the patch was at that time (many patches do not
> > have commit information).
> > In addition, most upstream have not been maintained or updated for a
> > long time, so the feasibility of modifying them all seems not very
> > high.
> >
> > It is best for the author of the patch to make the modifications.
>
> That layer is struggling for maintainer time and the authors of the
> patches have moved on to other things a long time ago. I therefore
> don't think it will happen by the author or the layer maintainer.
>
> We do really need to work out that information but it isn't an easy
> job. This is why we now require it but these patches date from before
> we did that. It will need someone to spend time on it.

This is the situation with meta-java:
https://lists.openembedded.org/g/openembedded-devel/message/114958

I'd say you Wang need to commit to maintaining that layer if you want
to keep it in some kind of working state. There's just no one else who
has an interest in it anymore.

Alex

