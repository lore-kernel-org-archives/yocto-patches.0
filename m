Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE7FCE8E60
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 11:17:07 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.12216.1729768619912505683
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 04:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LlLnVrwj;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e4b7409fso892133e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729768618; x=1730373418; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VEnrGXGGD6Dgce8ZdiAxQfkI89WuYw3ZyP1YPXaT8E=;
        b=LlLnVrwjdaawuu6c3Muj7uK/Z326ZemC2QBr/O/9GuGp7/DH0MGEXvkRPj92iOddco
         /Gb81oESlXv2fUEBpvRsElSovtGJA+3mXx4x+r3sq6mVDqNdjBI2C6doNKKNsmEn1kqg
         YlNmC11/frQbEjp5NpSClwss16tbn9UExYBpnvBE31AFJZ72h3AxGpdlN6SfQ2IiwMnZ
         v/zPNuukxJy/L0/okBKWfSHThkU//43ZbF39/Xw7nA3Zv52NEvy8Yr4ZdY8eHxcaZOKc
         LYAR34WLa6oW9tUdcYgz7X/OBEM21fU1Z2QSiZfTkpAnfdPl9QIRSLZwxIH4D+9NSzsX
         svcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768618; x=1730373418;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VEnrGXGGD6Dgce8ZdiAxQfkI89WuYw3ZyP1YPXaT8E=;
        b=M4pCpgPV8ACvcqJmhpJY1VvHx/gHh/8+jHVggqdT4Ub+TTX4W6KKQfGKH0y4C1w0sY
         qFtcgLC5lMCufri4h4wkxkO4sQ+VJEnCTmJzWNWykBmp0GT8PqH4/PU+XiwffErdQrZI
         WDYx4CkvyV/gvtGSr7pcPPAGgMxDVZNKt8uB+VOR6r+j6URaQet9Iwt5IQRmqrNMSiq6
         E0DTNPkEYEq+sk+mVF6vhyshnaz/QZ2t8aEYleyHQ3htweT1RoKAxGykhQyJcEjjxL4r
         jkja8LCsmN+BMEV2q27BPZfzd7TlUy05B4V+UR6iXtKRMCIrJSuYpxZ8ZowbkHavAdWx
         nuNA==
X-Gm-Message-State: AOJu0YyO974N2tZmv8b+ii8O2S9nmJljFiI/oFIQ+3s0jnzSAo4jigy0
	LGZUb2JNBTkYIFBe4f6ozxID9C8jHr778ciojaBfxOgjWyvUkRnaPS4av3ZVqzJghoDQIJRDu0M
	UrpOlqjCVieNWSAn3VePimQ0Y2w0NzA==
X-Google-Smtp-Source: AGHT+IFba+c9klOkHUnFdA7ns1CP1S5U8oYVxkqpw4U+hxfRqND1WlptJ/Y+pBjTHeobFAAnH8XC45HF6v2thzYRQlI=
X-Received: by 2002:a05:6512:6d1:b0:539:f1d2:725b with SMTP id
 2adb3069b0e04-53b236c8d5fmr599012e87.4.1729768617837; Thu, 24 Oct 2024
 04:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-jKcPW8cSiBmiXJHnrf96vLybi25EeqxnmJUnLQ-k7rQ@mail.gmail.com>
 <16955.1729768225337770503@lists.yoctoproject.org>
In-Reply-To: <16955.1729768225337770503@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 24 Oct 2024 13:16:46 +0200
Message-ID: <CANNYZj84yK+tzXCfr6sqzw0AA_a8eSPmPNwg6H3Mn0YdARA2Hg@mail.gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org, Ross Burton <ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 11:17:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/742

Thanks, v3 looks good. We don't really have maintainers for these
items, but hopefully Ross can pick it up and push to repo.

Alex

On Thu, 24 Oct 2024 at 13:10, Dixit Parmar via lists.yoctoproject.org
<dixitparmar19=gmail.com@lists.yoctoproject.org> wrote:
>
> Thanks Alex, I have pushed v3 patch with the suggested modification.
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#741) | Reply To Group | Reply To Sender | Mute This Topic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [alex.kanavin@gmail.com]
>
> _._,_._,_

