Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B5EC2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 12:44:35 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.18857.1719837870589404126
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 05:44:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HiKerk0a;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: gael.portay@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e829086f3so2447233e87.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719837869; x=1720442669; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMQXKGYIIllt48UB99A/rLX0cvb3OdwkiK3HSdRl/0c=;
        b=HiKerk0aRCglEpHtuMpI48TeniTx3Nr45laeiRY3Z6GzDWv2wfqs2HULQi3ltRzSaA
         EqznGgm+fVWOnWnu98Cp2kSWi7pAZXBDnOF5VX+SYjMcG023SbpROb6YyMeazs8KJ+8e
         mt+8p5Iqn7KF1f4OW0uXNTbKiWvqDsxNO7Bf6khPXW9n9T+dGKHJDXRxM1uez6R7ulBK
         N+4ubmJiSiX61xBMaRVCu3+y4onjUyDOpwreGIW4PAIYRsuL2IGD35PrRc7eIB+vTHa2
         xbpu/iaNJABW1CoJ7hjQVnHIl0iJWhC0n4EwpcZ5OGvRcvT7Do0jsYGA94KDEoRAXKQj
         6Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837869; x=1720442669;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMQXKGYIIllt48UB99A/rLX0cvb3OdwkiK3HSdRl/0c=;
        b=dd2Sj1UvfVhKeKgIru40JJyQcNeuypXH0zn5dJtesJpEWRYGnX0a8z2DoGvHX0LPUA
         jT10t1J8SO/1+AKZ/H8yXjLLqqJr+uyEYFPiu1u+wd278i30Z78JABF8KPM1ABTY7wlt
         C9Z3SmbO1ELTezImoLXg5av9dgX6eXAm3c+GHmX9WdsE/CyVGJTYhTVDchAmzqY5L7D8
         d7XODepk3d1DNuGbpEk2CFGLIeMTLgU9s2QI0qvY3cvBmV3w8UQkf9HdxAN5NX2eQPe2
         IXyJLRK+JWYoXXN4TGtrS3Rtr/wxvCn1u9f+Zd2OGDQPFYNN/1c4nqdpLCtQzUVL/yM9
         YmrA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kIoopCQHNyzfyKvtIkC6iH8jRmH52UaGU+PVYo29uiHkLw3OYNIxTtikxvi+ZNBUIXotrVhOg5SDj6lFIEBwfNTwG0gkW0TCV+8aw+zHr1KUSIk=
X-Gm-Message-State: AOJu0YzWZwNWto3TLv18V+nD57ocDMMS50N0t3VFtYIxVFGU7E05x4ot
	NvCUPZtJmiuYP48RQIWLEfwZcu8TmzitKJSIQDpYLVk/3NcYo+h9
X-Google-Smtp-Source: AGHT+IEPkBRFM8sGAk1VftzqakhsM/ryasnqXCWAeUbsn+JgINAA0O14m7lAtOSb7siJ5ylUkJdpSw==
X-Received: by 2002:a05:6512:1396:b0:52e:8b15:7c55 with SMTP id 2adb3069b0e04-52e8b157d70mr1371978e87.27.1719837868291;
        Mon, 01 Jul 2024 05:44:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0642acsm157565265e9.25.2024.07.01.05.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:44:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 14:44:27 +0200
Message-Id: <D2E7N50PZ501.1BHUA6EVGOIGI@gmail.com>
Cc: <gael.portay+yocto@gmail.com>, =?utf-8?q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
Subject: Re: [meta-security,kirkstone][PATCH 0/5] sssd: fix python3 support
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240626133913.790145-1-gael.portay@rtone.fr>
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 12:44:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/402

Hello,

On Wed Jun 26, 2024 at 3:39 PM CEST, =3D?UTF-8?q?Ga=3DC3=3DABl=3D20PORTAY?=
=3D wrote:
> Dear Maintainers,
>
> This patch series brings several fixes to enable the support for python3
> to the recipe sssd.
>
> I have tested the build on the branch kirkstone with following change to
> enable python3:
>
> 	PACKAGECONFIG:append:pn-sssd =3D " python3"
>
> The command below runs successfully since then, however, I have not
> tested it on scarthgap (yet?).
>
> 	$ bitbake sssd
>
> The patch series creates the new target package sssd-python; tell me if
> is not misnamed (thinking about python-sssd?) or if the python script
> and its modules should be part of the target package sssd instead.
>
> Also, tell me if you want me to apply these changes on top of master.
>
> Important: I am no expert in python packaging at all, so I have probably
> made not-the-right choices in the first commit! Sorry...
>
> Kind Regards,
> Ga=C3=ABl PORTAY (5):
>   sssd: fix missing python3.X-config script
>   sssd: fix ac_cv_prog_HAVE_PYTHON3 value
>   sssd: fix issue if build machine is Debian

Armin, do you want me to send these three changes on top of master, even
if they have not been tested on that branch?

>   sssd: fix shipping python script and modules
>   sssd: fix path to python3 interpreter

(that change "cleanly" applies I guess).

>
>  recipes-security/sssd/sssd_2.5.2.bb | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Regards,
Ga=C3=ABl

