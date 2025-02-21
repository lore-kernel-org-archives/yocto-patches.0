Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F3C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 03:40:30 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web11.15580.1740109229902185042
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 19:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ifD2y/vW;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: raj.khem@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3ff03c89dso666730b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 19:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740109229; x=1740714029; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rnfsUmOB4rA4l5K4Pif3ZKDzrL+SA6+cUsvpwcvYD0=;
        b=ifD2y/vWY9Pzp86F9GvRMwjm1gIORIDEEUNi0jDBtiHcgZFUCzm3RP4tZHL893Sy8T
         vyNof+HxmS/IU/0uxT7o7TlopCSIQ9DlKRqKgE+Yl0ZBoLkmBdb8oSB55k06NjKDNFXb
         BpYA6Uk5d+RvFaa2sGl0QuUvxxc/iFwxGbUeW9Z0FOszFLuMKMEzhakCniT4WHQbkw3q
         Db8b6mzCGKHYXqjHwBiJD6X3gHYDG8SHv4UT7Nb5w0bO3ByM41HdYpyX6u9DRPyFDZq4
         tpS+68wnKA1gyxWnsem6g3PRnhQWrtOS4FruzkanBJgSkgkKQdboFxf+zrIbsfU7Y2vS
         5YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740109229; x=1740714029;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rnfsUmOB4rA4l5K4Pif3ZKDzrL+SA6+cUsvpwcvYD0=;
        b=AZzj2Pp+v44KMpx/75U6SMhDBp+eUiamC1uxbj+up1sBKOLoHQftff03HZuTHX6833
         0p5EYlzVRvDQ2IzLsVwr2My4YqqzzI5SX4gnXhXX2rflDKT0cesXywlSMWua91uKKkx2
         BxpIMe4y2U9hGwTnVJn5qyOyiHaMX5yuT1753x7ulQQCUJdziLgGiWwnxGuXor163Uug
         o/eHSBDcsv2e/oJ2VOIB6bLdUFBZg518G0wfZxMGq5DTsxCg59KGuEzCVXbUqoRsxoH6
         ClPoQLn9DvrvWdPEc+Jl1VXep1wzHVVhoC5H1OP9Caj7wqESeFP7GEA6NN3MRmvhESrE
         6nRw==
X-Gm-Message-State: AOJu0YxdFVYEMTLrmuDMayKCo3X2vZO68OIQC3mmjCxA3L3InQ2Z8AXa
	OmUDaYlHkibjkjnGnj3d+KxppRF6fmw4mj1TRVzcIP3GgKy7xzF8BQfcKeprF8i2FVJcvgbt5d3
	kfAaq/vYlr2h0Fki74GqUhw3hZZYoOn4Z
X-Gm-Gg: ASbGncu+Qe0khrEfc62AzuVFBhY+b+hYAmQDYGA1PntU9IRe68rzuux5zfJO60mGmsc
	eWwU1HUOvCcRPbkTllWGX5nTsdhmMvpgezrMcX0ubHrwJFBCVT4xRHg4smbzUWvEB6MC/5XQuic
	NXSrR7Dg==
X-Google-Smtp-Source: AGHT+IHVhDDC8tZYVbEgYhOP5vVpAqbyu1un5q0FokKXXaxD286MxkLAZ0UzBYi9WrlwjHAQwE/8ynrXWcBR8/PNnp0=
X-Received: by 2002:a05:6808:250e:b0:3f4:1a4d:81a5 with SMTP id
 5614622812f47-3f4247f2b90mr1643353b6e.39.1740109228815; Thu, 20 Feb 2025
 19:40:28 -0800 (PST)
MIME-Version: 1.0
References: <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 20 Feb 2025 19:40:02 -0800
X-Gm-Features: AWEUYZkH83LDJwXadst736WpPxYE3wZrOBbHn-I6uDDjSrtYSREAXt4pfpynbKk
Message-ID: <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in patch
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 03:40:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1109

On Thu, Feb 20, 2025 at 7:26=E2=80=AFPM wangmy via lists.yoctoproject.org
<wangmy=3Dfujitsu.com@lists.yoctoproject.org> wrote:
>
> There're many patches that have the following error when build them:
> do_patch: QA Issue: Missing Upstream-Status in patch
>
> Should I fix them by adding "Upstrem-Status" to the patch file,
> or add " ERROR_QA:remove =3D "patch-status" " to conf/layer.conf to ignor=
e the error.
>

Good uplift would be to add Upstream-Status as appropriate

>
>   --
> Best Regards
> ---------------------------------------------------
> Wang Mingyu
> FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)
> No.6 Wenzhu Road, Nanjing, 210012, China
> TEL=EF=BC=9A+86+25-86630566--8568
> COINS: 79988548
> FAX: +86+25-83317685
> MAIL: wangmy@fujitsu.com
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1108): https://lists.yoctoproject.org/g/yocto-patches=
/message/1108
> Mute This Topic: https://lists.yoctoproject.org/mt/111302715/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334078=
6/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

