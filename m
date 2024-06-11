Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C90C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 17:18:55 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.2310.1718126328063005495
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 10:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SXT6Wlxh;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b0652ece5dso6179666d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718126326; x=1718731126; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJqBtODoCGXhV7znBUQdy8gGP8Q0kJezVMEpKfmjitg=;
        b=SXT6Wlxhepk4jrQyqb12fMDNpmRgCOr0xwB2HB2Tt9KBNlEKHf31jqCs+sG3tACsV/
         8hddKFtjloGCkIQdkvxb5yAze9JtiH3b1O6MttO+p3ZbueN+bU3xY9Iv3qug3LNKn7ZL
         hYuO1tQNnb+2RRvMQLVVNFzcV0Ll8GKpyLpCTLtcBbGLZyu++cnTB2SlfFx4G/oNQwAw
         /BRvylnxkPT0HJh8HvvnfJOHMZUu1k69Jjl4ng6X781gSwErvk1Fj9vzJXh5g8O8Z4Ny
         Vz++akb4fEx34fVtQQX2PO1rYBDXXpiC7Dbvro6r6tAf+x9yBhgzE9fOIuId9R+z2Gk8
         CT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126326; x=1718731126;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJqBtODoCGXhV7znBUQdy8gGP8Q0kJezVMEpKfmjitg=;
        b=GwVQqWL7Fl8inuNydPU1Nmru9vQZekIIdXsa6T+nFTxl57Il2jZ3msbBaCm4z2U31F
         tTa14bY+tZhjDCxSTTFv+zWh+/PU2UfXqCOEWbfJldRsJLfyQnnTMkVm/SiYmTq5hbGX
         RMGJqz4ZlpxZAXglHax17ZEr98O9zc9nXueeMg/iaia5E3pLFI0Hb5c6A+SCcU8ZKmiL
         RhLSfiVAmIeXeCsR6CN229Df4dIYY4IXFK9uR6XCa0bPFLQh+CNgb11ragUIApHaTobY
         1WoAxsVVor9Kxy6Lj+X2xsBp1c2NARjmZb640nGhWqZfRI92wRqilSQ+YnvCd7oqhHei
         e72g==
X-Gm-Message-State: AOJu0YzSkphMn0BNRaGmuX0ojZOefb1dK9Btm0X882yj5uydO7YCse9k
	SXFdQKEL6bcChSVdlVlWrSDCQRTGgFXKfYnBPr/92VWUBr/k91ZU0xeSKA==
X-Google-Smtp-Source: AGHT+IGWRvzUsR5WNerp3E96epTPn2TbT3wz5uyQ/9+EKw061bla4hjuS8suNOM8RnrJALsy39XOuQ==
X-Received: by 2002:a05:6214:570f:b0:6af:6799:912c with SMTP id 6a1803df08f44-6b059f4aeedmr107538536d6.54.1718126326095;
        Tue, 11 Jun 2024 10:18:46 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08d97d68csm7977816d6.128.2024.06.11.10.18.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:18:45 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:18:43 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
Message-ID: <20240611171843.GB34413@localhost>
References: <20240611140607.2719-1-twoerner@gmail.com>
 <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
 <CADkTA4N6vr-CwmAGX9JATaiCZ+OxprTYp=t=cjG8iX4roiFYQA@mail.gmail.com>
 <CADkTA4OV-gAFN+=Af1XDUwczqLTJWPKcdJs3wBwyUP2HaKjBWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkTA4OV-gAFN+=Af1XDUwczqLTJWPKcdJs3wBwyUP2HaKjBWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 17:18:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/309

On Tue 2024-06-11 @ 11:17:31 AM, Bruce Ashfield via lists.yoctoproject.org wrote:
> On Tue, Jun 11, 2024 at 11:01 AM Bruce Ashfield
> <bruce.ashfield@gmail.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 10:29 AM Quentin Schulz via
> > lists.yoctoproject.org
> > <quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
> > >
> > > Hi Trevor,
> > >
> > > On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > The linux-yocto-dev build was failing with:
> > > >       | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was exported
> > > >
> > > > Disabling some filesystem-related security options fixes the build.
> > > >
> > >
> > > Is this the case for every board, including non-Rockchip ones?
> > >
> > > Is Bruce aware of those issues? Shouldn't this rather be fixed in
> > > oe-core instead?
> >
> > Ross had mentioned something like this a week or so ago,
> > but I haven't seen it locally yet.
> >
> > It's an aufs6 export that is causing the issue, I'm looking into
> > it now.
> 
> I see the issue with the exports. One slipped outside of an ifdef
> and is causing issues.
> 
> It should all be fixed shortly.

w00t! Thanks :-)

