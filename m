Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8453.1792579182442946491
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 03:39:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QHAIY8vk;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2493c28bso43348785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 03:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792579181; cv=none;
        d=google.com; s=arc-20260327;
        b=rIDNT1lBuF0RYC8JRkatWjUInj/5UwHFkCYyb1Bi8i9NBZJYyhcKegnA7nN1wY4Aco
         8I5JenDc8nNV0mpu77fhudwyjh+jft44YGz//9X/HdcTR486ELmzbZgGfAUK3XgzF57t
         O0ybX77vR0AEz3S+XtSpxLW48+zgxLy16rVHtvT17Y/tFlJTPnb/H71cSm1Sro9IVWKt
         5a30B74bqbkurn4mfKF8/83W9xrVRT4SWBH+s4D0IrYPuHznUp2NgTRS/dbm/kUB6tJv
         q371FGixdGpxadBp92VgEg1wbP4CTETZH6P6/iNUQ47pE1hJKtLciPiZy0f9Jy0La8ba
         6Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v4wjmL5OuncSPQ/FHQZfqoXdQSnosul2d+V4ILonRmQ=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=W7V7yALjPveJ4Mvn+Fkq23hqwwzCbDC37krUaqxu0NZjVXNVrWz2xvUDvFdiURw5SW
         AsBI27jbZkkqe9GO6c73lfi6i0i0iJUPhTKekXSPf3J9FgshaLzxheZSjYb8Q04G5RdH
         yabH+9XpXKLqYBBGijvHdH7Jjb6GrN6E0z9ZQnmYgB/yxj4bACTHoc16NpveRMQt7+oy
         PQ6Kw8TfEzz7kAHGCXxfgz66v9v0eYGpJTKPMQRzWtspGvIAVvBQ6+QZ6AJkMTwsIUPp
         D9gdiHxJwWN98pL6KMO3CXqUl5xL+eOobf3CFBL+zW7dSflU3dY1BHrMF3ROc6gCXzD+
         ghFg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579181; x=1793183981; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4wjmL5OuncSPQ/FHQZfqoXdQSnosul2d+V4ILonRmQ=;
        b=QHAIY8vk5+3auGDyMXxIUPPtwLpRcOt0mLnAEeyEKpn3MlcOv6ERPCn/ql0Ale2hj3
         rSxmA0tmnLnIvdBVIxIDAb4aim1jIFkdnJ5HMcIRsGLL+T2TuxuuLk28LnQXZ+DRYItD
         VRUn6R38IuqeiXnTIkDhTPc9WkanWSml9+BSQVYfH8CiAC5Lx9H927jDeGUx7VAGXeKK
         ZCwvVYA6x8+CoCAmmquIMz37VYmf2ovl+zz+y7dDCQf37afY2YBcNzYD8Ngjal58xQLx
         Uch7WpKfF3lBQeCbH1sUKLVAM93r5yPJuCLX2+5TeaP1koYDluuw8jvv72hK/nTHnTOG
         Sq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579181; x=1793183981;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v4wjmL5OuncSPQ/FHQZfqoXdQSnosul2d+V4ILonRmQ=;
        b=aNKb4gqEtLlfluEm0wRck4TfBgPTCBhkpEZR0DxzucYi//F7Sw4BNPNBdcvsKfM0PU
         lf52UoxFZKk3Cj0Nxx1Z1raVsQoChXsAn7j9zkgaeTa8wq88iPJZOANsVO9TKUl4clYG
         GGHvUbG5b+5JyuFBhj/F+rBK7EIOiR5ye52BGnhO1Mc7pTGmWku9GS9+x6pKz2ysCH2U
         TE9gi2dGchBwj6hyAUniJhQe5R2KCkvhjJybxY83cA4ToVKgqvQON5/TvGVgygFLT9nk
         /15iAh9Zz1KAQI/53Dqq0iAhneNE63+rKHzTYCqBKG+HLyHwkZ8xs6aX4yYdvG/CnUDX
         qnSg==
X-Gm-Message-State: AFq9FYIS7foBAjRzG+/n/oN8f+qQLVsMMZmQsKT6Ex0LbX1Wb/oWH+E4
	f1sBkstzNqVQGahw1PLjqo4S4Zn48gmjxPMYawSCdxwjspZ9g/ycMq3c9zqfhnDn+SMCRLCRzBL
	iobybmjFwkleLQLj1JdnCWIK3XKvfcP0=
X-Gm-Gg: AYBFou0eCAScGKNp0RU2v4jlpK+KYmLx/bdU4xv8lJx70GerOJsNBMF1QvYE5ZaL5+z
	s+axD9uWou1rJSRoQmq3FZeIDACAYZ/7/N0i+ybHqeTzrlSlEfCt4zURpz+KbBTw9+OHVaZvGvX
	djjt1DJk/6RMz3vnCRTj/fHHrImquj+2ebLPN8U0xkfdt/Mb6m+wJ+tR1LXI8cEIJaZ8HFT34b3
	3Z/C08GJmXwilxX88XRFmtkNyr9r6wVx1PItzJPQ1t+Z5LqW3/XSE46LvKtU9sEIE1StqRAgtDb
	FfV0+AUUYYc2PM1Pzn98RNKeiIXnR9/m7mkYR/Swj5cPRFwDnS3hXSl0I+C2rI7O8fOJ3/PgWZT
	h1849Ss1WgUC0aSaNl4CcdbGf3wMQ2LW1c/BnsXLjV5gpz0QM7TKHqOMZ/E4SuR190BAfKm4zt+
	Tcmi2qUBVY1fz48FjZ
X-Received: by 2002:a05:620a:a8d9:20b0:93f:5892:e5fd with SMTP id
 af79cd13be357-93f5892e67fmr180917685a.1.1792579181348; Wed, 21 Oct 2026
 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261020090917.3132154-1-daniel.turull@ericsson.com>
In-Reply-To: <20261020090917.3132154-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Oct 2026 12:39:31 +0200
X-Gm-Features: AclHuK9-2mIRUkGAIqvkLCD-TsFczCo495WGKcG2RTAI5y8QvUg9pfE6PxqZ7Gg
Message-ID: <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH] auh-config: skip changelog in
 commit message for noisy recipes
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000560c53065e575d3f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 10:39:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5120

--000000000000560c53065e575d3f
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 11:09, <daniel.turull@ericsson.com> wrote:

> These recipes produce changelogs that are badly formed for a commit
> message: whole release notes documents (mesa, gstreamer, cmake,
> python3), raw git log dumps (u-boot, openssh, acpica, freetype,
> vulkan-validation-layers, parted) or markup banners (expat).


This creates an additional maintenance burden. Someone has to manage this
list, adding and removing entries.

I'd rather figure out a way to detect 'badly formed' changelogs
programmatically in devtool.

Alex

--000000000000560c53065e575d3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, 20 Oct 2026 at 11:09, &lt;<a href=
=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.com</a>&gt; w=
rote:</div><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
These recipes produce changelogs that are badly formed for a commit<br>
message: whole release notes documents (mesa, gstreamer, cmake,<br>
python3), raw git log dumps (u-boot, openssh, acpica, freetype,<br>
vulkan-validation-layers, parted) or markup banners (expat).</blockquote><d=
iv><br></div><div>This creates an additional maintenance burden. Someone ha=
s to manage this list, adding and removing entries.</div><div><br></div><di=
v>I&#39;d rather figure out a way to detect &#39;badly formed&#39; changelo=
gs programmatically in devtool.</div><div><br></div><div>Alex=C2=A0</div></=
div></div>

--000000000000560c53065e575d3f--
