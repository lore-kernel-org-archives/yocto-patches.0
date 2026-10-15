Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF189CC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37663.1792064698438034332
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 04:44:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PeS3lf5+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a01933b584so44566925e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792064696; x=1792669496; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLInUt/D0c1PsyOejA2+Ldj57AXYaP/N/HYYF5Wr7eQ=;
        b=PeS3lf5+qsvz/HPPeazc79QtXtw5FTKOuCEgl6RzxAxBQqNd3Dv34YtXMHWSVGlE+j
         PEcaLSd8epYAu9YWJTY5nADZPXp2Vzxne3KJ5wqSQd+hDBw1SkrzcVHOTc5HpLJPhYWj
         2gTQpiIsXF4ErgJ5gX+dJxZX2YxHd2Hjz/zNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064696; x=1792669496;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLInUt/D0c1PsyOejA2+Ldj57AXYaP/N/HYYF5Wr7eQ=;
        b=dSQJPrxBDl9G8QYrMtGNZwIYJz+WfEQHtdrFoGluN98/vOPSMKpynH6XPjfW2wYLS3
         0F6dpjpAHcbi8WDZREeAlmymoz8xdIEEt2kDzSXxsNBMeTe2SyJCwlAtuXklhvPcMtGG
         pCBYuY9woGxwvO+7OSkXsRCiwHJtpzN78vynx5exUa8oXIGSLl6SpcWUrjWNFmjIuF7I
         akgUzAnIYAH0MGrH4l7821mx8THjGVAVHJcjzcsTyx7fhURwpKtehMWyIaFCAt+L5ckH
         zaTS7q8DJa/3ETnuoB63VWLHpYF6CulW43nzU7DJfGjDlk3n6oa6g5ZoK92V29HTTM1d
         Z8Lg==
X-Gm-Message-State: AFq9FYLuTHnedWe8Bd3EnSZD0jxa/RfBZVvT/HJ+tlrQasLQOp/nk2bt
	BA6IjLeNAghrmh6ZcP+mamLwnMu/ourbqFmYa/yzzl3pDgUAtfob44Ut9zR8JAHvmtxAHhqvP+L
	1oSYftC8=
X-Gm-Gg: AYBFou1xcx+gESlw4aDw2GzfUbhuetaC5zfBmOFEXji4SQbba8hxpuEJ/OR5K3wJDhn
	rkdiWnYS5LWmZEYuuZF9lCSjbGRqNehGhhEPdp0VrK2vXBl9wMia0MO3DCl2RXLjaNxq0tm/yic
	z1gSY0138ixoyIYEhykx9w++ZpJ9/Ik4J4TCT+fXBKK4n18FmoEplQJ1SGxUSyDsdyhSPx9qNWU
	+12dSI3wXdqoEyJYMJnLkRbqL3QxdomnhVPOi6Y7wHktgZY85Brq0ZZ0ms23FF3FOf+VH5JPRb8
	CvoomavuiJSZuKD2Sabtuuu4t2ysbLsUavP44HF4irNzQm/DpfwHuf9x4lJ/yrGOR6YgbRSPXGH
	k9SCyUGUNHLp9bKPTuWiwDW7jHiWgOjZxa7g08VABbmaaV2ys/bjQ/dWDue+5PTLxHQNHs4CiYa
	2tPPKJkzFNg9LOz7bt4IXTDgNJWMW10Uems6eJGx0mpWD9gUJ7LQoPOOwp0ueRJbPgarhXgxZup
	1H1jpk3WCOiCEhcUPxkjBPAt7n+zx0W6E/xmec9DiLB5EVXGdcbWymQOGGzVhc=
X-Received: by 2002:a05:600c:154b:b0:4a1:6af4:c6be with SMTP id 5b1f17b1804b1-4a18e4d1c0amr356547485e9.34.1792064696508;
        Thu, 15 Oct 2026 04:44:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8627:1727:8a8a:57f5? ([2001:8b0:aba:5f3c:8627:1727:8a8a:57f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm59102315e9.0.2026.10.15.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:44:55 -0700 (PDT)
Message-ID: <4df5ef33f443128b352bca87d148a2abb574f3c9.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_client: Fix
 xattr/rename handling with empty paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Thu, 15 Oct 2026 12:44:54 +0100
In-Reply-To: <18DE7C971DAD1AD4.2478941@lists.yoctoproject.org>
References: <18DE7C971DAD1AD4.2478941@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5028

On Wed, 2026-10-14 at 20:38 +0100, Richard Purdie via lists.yoctoproject.or=
g wrote:
> On Fedora45, we can end up in a situation where path_extra_1 (for xattr/r=
ename ops)
> but path is of zero length. The path_extra_1 codepath does not handle thi=
s well and
> corrupts memory.
>=20
> The issue is "partial_len =3D pathlen - 1 - strip_slash" when pathlen is =
0 (and
> hence strip_slash is also 0). This leads to invalid memory writes and if =
those
> happen to access off the end of a mapped segment, the program segfaults.
>=20
> Fix the code to handle the pathlen=3D0 case.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0pseudo_client.c | 17 +++++++++++------
> =C2=A01 file changed, 11 insertions(+), 6 deletions(-)

I had wondered why we had something with a file descriptor which has no
path, I was worried we were not tracking some kind of fd creation we
should be.

The answer is it is a unix domain socket. It therefore does have a path
we could track but we'd not be able to do much with it anyway so it
doesn't really matter.

The reproducer is therefore calling fgetxattr() on a domain socket
which glibc does for nameserver type operations.

Cheers,

Richard

