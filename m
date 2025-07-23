Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A663C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:10:59 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.23223.1753297852008488023
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Y3fY5zB1;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab6416496dso3639551cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297851; x=1753902651; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwwc5WsvKuh0ED/9GtqXr5sEDoAqpd83LF56U6LTm90=;
        b=Y3fY5zB1sexpUxJz5cykYTikVAVlpr0KlNeEq/oxrmPgqTkpiQEWL9aogrAZZGSAd8
         amiiddAdLcGxnE39cEwYMnz2ZtP7SkaGIt8rj+KmOhncWQjveXPMt9FMFd44ThQBIpu3
         4YRaj1+G1eIlG1Cp7j484iqRR7IWZ/BoMHwW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297851; x=1753902651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwwc5WsvKuh0ED/9GtqXr5sEDoAqpd83LF56U6LTm90=;
        b=oq2h53Ksm5FN3mvdlHACCSxP01gvPoBHAyV1F91GOTZR3WdbdF22plXrmL1KvISw1r
         /pMP+x4aSiJMzioiP8h7WF9xb9ZO3O9vaSSmV29l4T6tqfe9g3x8cI2cApw9Srs5unzs
         bOW15vms2SeLB0pycwaCNN++JFPbYgvvqDwTRs51rxppa06r0Rf51uDmbEkXIKif4WHf
         /R+MLmXlHDcAS3rystquFjyHo9t8N/RFCbYqAg/zKpsk4Phb5k+5xVGdhmwo6YPUwgTu
         4UcY1lbfpBt/luKeR6Bt3mOq765qRLNo4n8WJclHA0y6FTJNXuBWt0TVxHrNeecuukbJ
         uqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9peAnHrm44fsbpz2MTgrFOCt4aETPUdiglmwkYsJmHg9Fztcgw9/E4iVEy8yHicsfP2xiLljCfr3w/yV@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyg1zNmReheq1pgTUfRvCrTXlMQ94kXGLwEXJ4hTMiDBRGmF3Kt
	8aObmbOVV+eeQS/oas2Og4ijlFz0AZcFXKomb/4CX5IZGbSt+uwaeoU3++SC2qIeYnk=
X-Gm-Gg: ASbGncvfa8SN2MJhK9t6c0i0tkonIKjEXpPpFWHxhYYywuM33Tyh9XGnMkD/2tOhjRZ
	5LNSAG9CSkMSv9Ai8BSfDk6Pdu0MFBnRCiw0ki5ogc97jZkoqYdlNOPn0Yz00aXBCpG9tgiEoqB
	7VcYI1Dk+h7zU0fqR5eGcpRtbNTaTd7hjaetIRP/5JktW/zx+lzbwZHTd/bWu3qrOjLMETHw3nQ
	o6eSOWd7XGbsk/doRTIz5jCmg8L+6GPLnuUInSJHjYmzxfENc0nvKEXUg6fByYz0EepUz68NlO/
	VucAk9154qXlLmUC4HN4Hm7nUNGRceFKTA+TARBRoPuaHxEbRnTK6uPCM3hLr+ox/kNO3xpgLbI
	FZD4q7Z4MYGE9RJBCJo5gfksKClxcEhxm1dJwh7eTg95QnTzYIMIvkW2s
X-Google-Smtp-Source: AGHT+IHJdX4C0Xw6pAFFPMO+bmzDn3E2xmwIMO7WN4ip0u+w9BVDCeF5/tTcb1o0juy/xVOAx71wag==
X-Received: by 2002:a05:622a:8009:b0:4ab:6a1e:ea51 with SMTP id d75a77b69052e-4ae6e266237mr35246931cf.11.1753297850978;
        Wed, 23 Jul 2025 12:10:50 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4981ec5sm68722741cf.11.2025.07.23.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:10:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:10:49 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Yash Shinde <Yash.Shinde@windriver.com>
cc: Randy MacLeod <randy.macleod@windriver.com>, 
    yocto-patches@lists.yoctoproject.org, Sundeep.Kokkonda@windriver.com
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Fix DEBUG build
 segfault with p384 crate on Rust <= 1.85.1
In-Reply-To: <c387043c-e304-43f7-83a2-40b64ce301ab@windriver.com>
Message-ID: <d52d7d4e-aa65-a4d0-840d-db8e4ec4465d@konsulko.com>
References: <20250709072014.1978605-1-Yash.Shinde@windriver.com> <a2703f2b-0c6f-4180-9395-e0e9c60cd0da@windriver.com> <1fde4016-2fa0-2b91-4024-7f84caa430fd@konsulko.com> <c387043c-e304-43f7-83a2-40b64ce301ab@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:10:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1855

On Thu, 10 Jul 2025, Yash Shinde wrote:

>
> On 09-07-2025 21:18, Scott Murray wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and
> > know the content is safe.
> >
> > On Wed, 9 Jul 2025, Randy MacLeod wrote:
> >
> >> On 2025-07-09 3:20 a.m., Yash.Shinde@windriver.com wrote:
> >>> From: Yash Shinde<Yash.Shinde@windriver.com>
> >>>
> >>> Backport a fix to address a segmentation fault in DEBUG builds when
> >>> compiling\
> >> No, too much of a change.
> >>
> >>
> >> Sorry that I wasn't clear, I wanted you to provide the two line
> >> change that changed the debug build into a release build.
> >>
> >> Scott,
> >>
> >> Will you take that?
> > I prefer to take changes that are straight backports from master, but
> > I'd consider a less intrusive patch (i.e. the 2-liner you mention) if you
> > have a real hard requirement of supporting 1.85.1 with it versus being
> > able to go to 1.86+.
> >
> >> At some point, we'd update to a version of rust that has this fix - 1.86,
> >> right Yash?
> Yes, right.
> I have sent the 2-liner patch
> https://lists.yoctoproject.org/g/yocto-patches/message/1799.
>
> > I've been a bit busy, but plan to try backporting the 1.86 and 1.87
> > upgrades to the mixins next week when I'm back from an AGL event.
> > If you're okay with waiting another week or two for 1.86, that does
> > seem a better approach.
>
> Thanks for the info Scott.
> It would nice to have rust 1.86 and/or 1.87 in meta-lts-lixin layer which
> comes with fix.
> Meanwhile, we can apply the 2-liner patch.

My apologies for the delay, I have just sent a patch series to go to 1.87,
once it gets merged (plan is tomorrow) please let me know if it does not
resolve the issue.

Scott


