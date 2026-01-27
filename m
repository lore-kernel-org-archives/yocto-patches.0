Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A3D2D8D7
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 09:45:28 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6917.1769507121333305936
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 01:45:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pJJT4N4+;
 spf=pass (domain: linaro.org, ip: 209.85.208.174, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37fd6e91990so58507221fa.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507119; x=1770111919; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4UHdbojI+lAnudqHG7JFJUfFSxp2vjji6HV4b7uEXw=;
        b=pJJT4N4+9RzhE1PhDQh0XrGIG4/SMkhbBCeAP9LAEWu8fmiSNDd2BipoLMHu1G0HEI
         hlRlRUmJlhyhLovcgOYWWyBKThgLZ1SADYtiQKMwDJC1R6bMiXwVeIKPl5HQUgxtbYaa
         koqM3TOj5fTRKYcWhiS2kjaXmLHGf4eKW/BdSzLWJDzdHelMWggHQXwzZpdfoHOPZr1g
         eiuPvRWL28lXgEl8UZlCplRKbgv8lZb+nWeyIt5ITyjES1/HwaEm1832cV1GTOXIL1d6
         CByGIlXmMJM9MlTbMp3jgFcZnbzbNE//XDqutTIe8jXwQ8AgIXoRKYUg3fUTqp39/jve
         UhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507119; x=1770111919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UHdbojI+lAnudqHG7JFJUfFSxp2vjji6HV4b7uEXw=;
        b=rm20oBMMycj4PVrCkPBZ2k1J5nelX+3+CXZ3nvz34diqfxh5Q1JEvv4bPjes3tPdlO
         wg1ISmcooSnBYEW0k/8Rl8sAjVQ+TlxaQJouOrMTbO5FJF4Mdc56pZVQb8MUnGkXHOxr
         1Sw2lFANgpb0VwYbr9NVW7rXy9o+ElFeECfWWPpi2C0XrggLBRNXaHSo/3j2oLViLsT8
         OVBa4gXCaXxi43Lfcy5p3WuG2z2k41mFYuirj+BpjXtThdot9gJ6yM135keTm9YYn+em
         Qepn8iQUK8POatTaK7FJZYl50QoR9pNjCR35Xin6KjVpfEnj90yxsRwUpPqju6BnECZ/
         bXOg==
X-Gm-Message-State: AOJu0YyGoatQAi/TbocBZLN68MW8Bh1LPahBjJWF+/PF9esP0lxg18V1
	KZg4OFFDxutqh3eriCEgCMhm2qy3A8Haqq6DXgPsRlokYlFoEUdD/KBBxP75oX4QNYBeaDFqG18
	D/0Pznro=
X-Gm-Gg: AZuq6aLD7YVXRvHikyvD6P4hdgwhH0ceOfnxowfNxbmmlREgXLVdEV9h+yKnJGfLoXw
	zX4dGEg1iI0WIlaJlFNCdENiDQYOVjhjAhxaXNB7aehpUOQNKUPJeW4hSjbghIa+PysWZlvQpG0
	SdQTFhxF68yq0odtyZIZ4wcD1xHToavcTK1jgVm/ht445DQB1BZhXG+QWUQ7ob6k7RXl4ueaoHu
	Q4X5CaScVLB9iIJtUmxZtqs5ChiKUhC9xepyQeBiHcshjHDgeRPwEGtt6ulCBtV5WQH1y7qgXlw
	FfZWROdhDu2rfB7bmYE+37HgG3yV6wErqJJYg2JqzH5avzT+orzCl2t27HqtLCIYq0rWUOx66RT
	NGHlxyHoNINPf6pDgL5KlgH4/Vmw9oM7/zaklBGuro9Z+kb0DxGs7TK7mNYW/rx8CeB6rBasl8O
	aZ3SR+id1Psh+PVbmqb75Zc4HHgsluqiOLs23F7WBQEZXRZyrbrkNuxKc=
X-Received: by 2002:a05:651c:18c6:b0:383:108d:382e with SMTP id 38308e7fff4ca-3861ca226d4mr5078111fa.45.1769507118884;
        Tue, 27 Jan 2026 01:45:18 -0800 (PST)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385d9fae759sm31794481fa.4.2026.01.27.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:45:18 -0800 (PST)
Date: Tue, 27 Jan 2026 11:45:17 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
Message-ID: <aXiJLd11pS_eKmRS@nuoska>
References: <20260126085252.178615-2-yoann.congal@smile.fr>
 <aXcy6iZSrBkErjvm@nuoska>
 <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
 <CAMSfU+5Kx7GNqRgymCn0WzKGZZfz7E7Pt5tZNLi+U1bn5aTjYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMSfU+5Kx7GNqRgymCn0WzKGZZfz7E7Pt5tZNLi+U1bn5aTjYA@mail.gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 09:45:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3115

Hi,

On Tue, Jan 27, 2026 at 10:40:10AM +0100, Yoann Congal wrote:
> Le lun. 26 janv. 2026 � 15:19, Yoann Congal <yoann.congal@smile.fr> a
> �crit :
> 
> >
> >
> > Le lun. 26 janv. 2026 � 10:25, Mikko Rapeli <mikko.rapeli@linaro.org> a
> > �crit :
> >
> >> Hi,
> >>
> >> On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via
> >> lists.yoctoproject.org wrote:
> >> > From: Yoann Congal <yoann.congal@smile.fr>
> >> >
> >> > This would allow to quickly identify commits that are not on the right
> >> > branch.
> >> >
> >> > Partial example of output on my whinlatter-nut branch:
> >> >   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30
> >> (yocto-5.3-3-g74f8a927c)
> >> >   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07
> >> (yocto-5.3-1-g6973ca6)
> >> >   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a
> >> (yocto-5.3-73-gb4e7819b99)
> >> > (It shows that every commits are correctly after yocto-5.3)
> >>
> >> The output may or may not work, and may actually confuse users:
> >>
> >> bitbake$ git describe --match yocto-* origin/master
> >> yocto-5.3-52-gcdd79c1768ac
> >> core$ git describe --match yocto-* origin/master
> >> yocto-5.1-4541-g6c31c2a73185
> >> meta-yocto$ git describe --match yocto-* origin/master
> >> yocto-5.0.10-40-gc23c19e0b300
> >>
> >> and I don't seem to be able to find out in a few minutes which branch
> >> of bitbake is used with core and meta-yocto whinlatter branches
> >> since the branch is not called "whinlatter" but bitbake version.
> >> Oh bitbake
> >> default-registry/configurations/oe-nodistro-whinlatter.conf.json
> >> has it as "2.16" but openembedded-core doesn't seem to know which bitbake
> >> version is correct for whinlatter.
> >>
> >> I hope this works for "whinlatter" and other releases in the future
> >> but the tags are a bit messy stil.
> >>
> >
> > Yes, agreed. That works well only for stable branches after the first
> > release.
> > Maybe we can only take this patch for those branches?
> >
> 
> This is something I can check locally before greenlighting a build for QA,
> just tried it for 4.0.33-rc3.
> => We can drop this patch.

Is there any possibility to fix this for yocto 6.0, for example that yocto-6.x.y tags
would be aligned on master branches too?

Cheers,

-Mikko

