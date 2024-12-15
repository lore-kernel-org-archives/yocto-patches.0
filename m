Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C8E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 21:23:24 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.43344.1734297796292160479
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 13:23:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ez8pFD8K;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so31137176d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 13:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734297795; x=1734902595; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AO6FmoZ18I0/nqAktkJgfWpW2oV9WovIyf+16s7P/lI=;
        b=ez8pFD8KWkOGv7yHbrsK1y5hP9btoPV2jeETKB4eKwau2EtF/dV0svPRj+7h+5TBg4
         96H9R+DsYLkTwM79c9nNtXueZIv3iEXwR0LDrrdIhkG1VmVxHPYQphlXDuQHw9DR0OHr
         TDE5SqRgzSidhyDuZ7OPsHD7dEU1FTqsZ1hOKRm/nv6lqdfEUpSAqOc/7wwWljpDJ0s8
         G3PQw3Lcpv5VQ1q8JklDEO40YspMxX6CPE/bGrnvR+s6fyGJ60OVXdfbB0qwo2Tkq2R3
         tZeV4xJdsVoYdTsnlj9yIhVE8fm4aY7OX5G3IQhnpqxSby/I6W75DHeWSLkfz8YStgHR
         ZCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734297795; x=1734902595;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AO6FmoZ18I0/nqAktkJgfWpW2oV9WovIyf+16s7P/lI=;
        b=pep8xPVods6ab7C62YmJgovR8VPHEwD56hzifCybt96dI2dcgwY7Zm7tfMIn1WtN6m
         31t3BcK9xJYGFUdAAsw8kGtvUapeUKVn9cr3/NqX3D9IlWjNsh8v2zBCrAYn2IQJM78h
         oJctsPDOBKsgEMPWzcce2Nx5Eb8D6Gc6lvuQkk0K2QjLu9iSbza48F1dEb4RyUm/r7DR
         d6JEZE1zxE7v/BAJsL/v9qSAWjCXi1yqM+RNc7RR6qeP0b4aTU7JclC6o+e9R6xfVVqA
         0SFhxRLgHzBDkDaoR2lALtbRK47oLChCyIT6/Q9/mCqrzP4sPpXySBBsQvH31qJyWzl5
         MERQ==
X-Gm-Message-State: AOJu0YxW8Sa/VhlntjQ+nQV6RWYKG2PmZOPbDs+JIIAtN3IDAKThlaX9
	OLRL4LR70Nnkv+eziF/5EU4QtE20DmhDrrCRV4P2L6SxCCYCWDEYvWzH1g==
X-Gm-Gg: ASbGncvPkUpVk9+TNxemSxSZf8LWzhoRvqFFewNqz9OzNh8t3Ktx1UloGirnpa91QDV
	+QPPPP+NhpSFRRO//hcQDSiv4it+iSxyfnqY+DfEkvokUltVCza0bdZDLpvjHMeO1OYeijyYlsp
	Cl0fZC908xGGp4jXz5FfvBn6xMOEmN48Cgz1QP0GZn4htqWdqPO7xfw6iNWjygmgZFE2LBE4M12
	Uzwb6K2EZ6uRByXwV89DTtQ8O359b6c153B+6nOJgoEDPbCnBiFuad29f9qfAHpwUsFjD+QJjf4
	77RI+ZTi
X-Google-Smtp-Source: AGHT+IHvrexGqTQ6QSSGkwQ+FYHjp7EBUYCu6NNtZObz4jQJZjOYba/EH9Z1S7WR2i/qFfrdsVod5A==
X-Received: by 2002:ad4:5f8f:0:b0:6d8:9ead:c665 with SMTP id 6a1803df08f44-6dc8ca8387dmr180199516d6.27.1734297794682;
        Sun, 15 Dec 2024 13:23:14 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd257221sm20246436d6.31.2024.12.15.13.23.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:23:13 -0800 (PST)
Date: Sun, 15 Dec 2024 16:23:11 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 2/4] u-boot: use
 upstream for radxa-zero-3{e|w}
Message-ID: <20241215212311.GA16568@localhost>
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-2-twoerner@gmail.com>
 <4a29665d-c067-437e-9f7f-52189f1dc65a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a29665d-c067-437e-9f7f-52189f1dc65a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 21:23:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/920

On Sun 2024-12-15 @ 06:28:15 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
> 
> On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
> > for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
> > U-Boot development for this board had been added.
> > 
> > Signed-off-by: Trevor Woerner<twoerner@gmail.com>
> 
> If this patch is the next version ofhttps://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t
> 
> then Reported-by tag disappeared. ( it is not critical for me, feel free not to add it )
> 
> Checked on my side and LGTM: Reviewed-by: Oleksii Kurochko<oleksii.kurochko@gmail.com>.
> 
> Thanks.

Yes, apologies for this and the other one too. The tags will be in the
commits.

Thanks for reporting and for your review!

> Best regards,
> 
>  Oleksii
> 
> > ---
> > changes from v1:
> > - add [meta-rockchip] to subject
> > ---
> >   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index 06ba6d54de8e..08e1730b5d3d 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
> >   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > -SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> > -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > -SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > -
> >   SRC_URI:append:rk-u-boot-env =" file://rockchip-enable-environment-mmc.cfg"
> >   DEPENDS:append:rk3308 = " u-boot-tools-native"
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#914): https://lists.yoctoproject.org/g/yocto-patches/message/914
> Mute This Topic: https://lists.yoctoproject.org/mt/110099067/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

