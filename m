Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1872CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 14:04:07 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8011.1782309839653852765
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 07:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BMog03a/;
 spf=pass (domain: gmail.com, ip: 209.85.161.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a0de515e54so1302519eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 07:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309839; cv=none;
        d=google.com; s=arc-20260327;
        b=EBVutb83aD4znm8QR/rCv8ZBlgn1+EqSeZDE01AaSnnDE1zmjTUqlTHIExy1hvK0XT
         slPoV48MaLAlWor30dSv/Xc8VppdaDFV3R/yMMsM4UzCs4Iu810D7uhSCfnbK6QUw6sd
         VLLDW/4rfiBDcXOn1xNhJrqZF83AF8hMB9ci6bTP6XyCSLWIMIIv3XoD9nIIur3xPlSZ
         /MJlm0FfL/cWhNYF3tzwaRD7lgwJfxEKicYNsVYcXfFq7bpgZ63TUc7pILudPTqNazdu
         dvSGcaLq6tBKsLoohNt8ASecPnpTo2KDIc6zxbTIBw+0GP0NVbZirWFuUuCAD5O7lvnu
         b1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ssUtScHcbKMKf2yHc1JbRHy9q9x3UG8tnOx5nV3WSUg=;
        fh=tkte4INkXHK7MOLKTWn6ahFWkAkGo1rhW3i+9/4+3jA=;
        b=l+3qXIs8ykDnAtfeq+ypcZhlaOUXzJQGMYGT0POBeNEPCUcLAiV9oNU4hZXF+q4ecC
         4lZu3FTsHWnYuRbNG1t6Fu6ow9oZA4NQ1Tx2+xS7rnSjkJifHItl9ybPA+FCqDn8jp6M
         AMLI9n2Ta4IjuqK2HtWHJG/QRl7ss8IQiDbJw2jp1l7szoexDd1ncV9lQc+mAVSVuEIP
         dqxUAWasgvIgKALqLT6m1w2LOXIetbSGE9WApM+o2hUXY8c6XIhA5W881fbZ60GahNdv
         IbtFcCu0SnxA32Iu6HZ0Mayc4t6syuoIBqsEkAu0VD2RlcWNcvgQD81BAjeTLQxoHTM2
         zcCQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309839; x=1782914639; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ssUtScHcbKMKf2yHc1JbRHy9q9x3UG8tnOx5nV3WSUg=;
        b=BMog03a/5AVq8PScFs7cx6huy0XLJ+7TsNftDdRePSsmnKqVL/97RTHgUTk1PmgCTS
         JXLfk339KZL4Di+wiU6kSS4R7Wxx1CO1WP27fdGDPMRJRGnmCjUS85SApNjS/L2agS3x
         CleditnhHqMk3xWFNpRtpyVFkdALTW4I69x8v+cuMes3GEhosRGqwlIQYp/7H3Y7kZ+L
         sAxxEmb26Apw0Z8lx66mKnfiecfZs/kjjoxp5SDBR+CSoMjCTDj1XTvL/hqokMTRb/Zs
         NSxWeDeRCOpl3/lYbOsdMdYZC0N9jaxS0c6JCjyIzIb+mkW36xXZnMYcw1ua1iuSDCYI
         CDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309839; x=1782914639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssUtScHcbKMKf2yHc1JbRHy9q9x3UG8tnOx5nV3WSUg=;
        b=nGYpFgd48zkeSAXu9HKcfZXuF9pQAcOmcqCjM8pmXvEztis1hInEOd3IuPb7Ghmk9c
         DpaZvpYma87gyaYc8Ryr0qXOA9Zj77SVSTzqUVbm//YlwsA/w44dsMFecmLixzCeLdnw
         wXSF9auB6EraRVFbYQQvCqk/eSVNuFQqIuxrN8AZ5n41Zg+oa+sqnO2Jwq0XVf9uCplc
         tWZOFjyacnl6eJ0VsoOtkKZfxalyglD4wLz5gC4cAPyzPWE1Ie8/gzjw/vWihxE6Dfxl
         257oOsTUzatkzqlVDwpxvyGE5i8dMsiN37m/nTG9yI/Ss+mnEorZLj9i8PHvZ/C15SEf
         4HRQ==
X-Gm-Message-State: AOJu0YzQWs1+7s4nei3nkPkt20lENYEK1ettAwJpiDQLRxnKNZGP9ijh
	H8gnitYI0ik9F314+5GKSyK+tAODT6ozqVJU73u0ClPsOHdTxYFgqV1FMDQhqi1/yNPsl3KN9qN
	W3dnkGZRYzXC+lHAiSov6HlRe7Y4f1r7W9smU
X-Gm-Gg: AfdE7cnT62twE2+q4naUSULKnBbIwAQC91TZAsz3ccNXtd08ClBNa8wzHKa3biCcR+v
	U+R2THg4iZXeyd2sZz8EylnAtfidQW9uVscYnvw/TW7W4cWQDZ46N1/pjzwLbPgIsK7oRWl2ms+
	tcgE3hTEchGcuUNoP+adC5+0QN3q3owqVa+TQMAT4mJkyYSJigIB2zGXtBdZrJOwtIW4HBI7Woe
	2zsobzgh96Rkouy/ZLM9dvWkKuK+wCe+u+2wIQ5dIu39sbLKPJ79pJ4h9Dc3EX8hdNORbv7vw==
X-Received: by 2002:a4a:e905:0:b0:69e:9af9:ab47 with SMTP id
 006d021491bc7-6a1127cc75bmr4821540eaf.34.1782309838540; Wed, 24 Jun 2026
 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260624062620.753-1-adityags2004@gmail.com>
In-Reply-To: <20260624062620.753-1-adityags2004@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 24 Jun 2026 16:03:47 +0200
X-Gm-Features: AVVi8CfhOi3H6NowaooHFh5gYhIWI300Ow6MLyyTOLcmMzfCxT9YFAdM7nfFflo
Message-ID: <CANNYZj_91TYttV2Y+yMcC7F0DGcpkdMOt9yU+8_p7XYnWNmcxA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-collab][kirkstone][PATCH] openssl:
 upgrade 3.0.20 -> 3.0.21
To: yocto-patches@lists.yoctoproject.org
Cc: Aditya GS <adityags2004@gmail.com>, Aditya GS <aditya.gs@bmwtechworks.in>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 14:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4295

On Wed, 24 Jun 2026 at 11:06, Aditya GS via lists.yoctoproject.org
<adityags2004=gmail.com@lists.yoctoproject.org> wrote:
> -           file://CVE-2024-41996.patch \
> -           file://CVE-2023-50781-1.patch \
> -           file://CVE-2023-50781-2.patch \
> -           file://CVE-2023-50781-3.patch \
> -           file://CVE-2023-50781-4.patch \
> -           file://CVE-2023-50781-5.patch \
> -           file://CVE-2023-50781-6.patch \

You also need to remove actual patch files.

Alex

