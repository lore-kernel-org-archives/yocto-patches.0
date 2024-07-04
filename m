Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B311C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 13:53:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.10687.1720101178411355592
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 06:52:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fhumtMHW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367a081d1cdso321641f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720101176; x=1720705976; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xO6Z2wZmIzRwIaE+l9U+24S4+8e6pln9nfF/nYrZblU=;
        b=fhumtMHWqqYlu/CG0/uT9GixpwR86xhIZz1QnHa6ZA+T/UegKa5jOymr871cBwHMHo
         xc3dan8rb2nK79DhXvanAxrU54GtDXYQpOnqA5O+R4Yh9IK/yZEL9rQFw5Ga2Jkln9ff
         NFxhJNFfuwVY2ZuxqbAlewVtnOhKLrXf0udRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101176; x=1720705976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xO6Z2wZmIzRwIaE+l9U+24S4+8e6pln9nfF/nYrZblU=;
        b=UUqqhh/4T0AcjW0aWkJQqGmi6BfbkKL1IqfEEqIORtjhbiYdmW6Yd028F6T0z/Dmfo
         aQk2QR8t4HZO87Cr6trG4aHwu3xN5iJcJUHFjn/MKJWUvpcDTcmJuvFAe3iwroMj7hCo
         Bo0iHTmkucZ2C8b/NxAbHl3FFXXMJJsIps1Eu6Uc9rcZusFn6FXnJ6980hI/xNtuWxeR
         lYvIexC9uGz1qm0ktefwJKWHN1dl05EDv9zdcZRPMO5lRgeg0+eN9qacpn+RtZuU1Xfr
         uGNNX/4HDYtqyE4P6n3u6iss4vUgxQs6i8QIEy5XbY4uoGsE+RiCDcB6sBZeyuycSHNY
         W+WQ==
X-Gm-Message-State: AOJu0Yz3hg+PpzOPOVc+5oj4IYcs05QURdcIj1ccUcAiSpMWjmnBkJUk
	PnBKvtuCW6LHUX4rmJtT01AGhC0nuC8SWDO4wk6o0Sw/mP0wCKagBjtdjrfC5qrXAusnp+vLrMh
	M
X-Google-Smtp-Source: AGHT+IGt7gMBj5uBo42ye1DzXbfCxOoxfmLc0Df59CCk2MAXqSj7NkthKH7Tu9XxUWeGNfM3hd1stA==
X-Received: by 2002:adf:f587:0:b0:362:41a4:974a with SMTP id ffacd0b85a97d-3679dd72154mr1306459f8f.66.1720101176273;
        Thu, 04 Jul 2024 06:52:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:be20:56c3:ce73:d7de? ([2001:8b0:aba:5f3c:be20:56c3:ce73:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679efcffe0sm1479535f8f.97.2024.07.04.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:52:55 -0700 (PDT)
Message-ID: <2c94095cbc2865184d4ea4e1eb4f3c763059be66.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-metrics][PATCH 1/2] patch-status: Add
 missing inactive-upstream status
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>, Yoann Congal
	 <yoann.congal@smile.fr>
Date: Thu, 04 Jul 2024 14:52:55 +0100
In-Reply-To: <CAN21hX7y7j64LM+wp8vV9f6_uKo84auwqk3wCGtJ949VMq5JYQ@mail.gmail.com>
References: 
	<CAN21hX7y7j64LM+wp8vV9f6_uKo84auwqk3wCGtJ949VMq5JYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 13:53:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/414

On Thu, 2024-07-04 at 09:45 -0400, Alexandre Truong via lists.yoctoproject.=
org wrote:
> From: Alexandre Truong <alexandre.truong@smile.fr>
>=20
> Adding missing inactive-upstream status to the pie chart and
> to upstream status graph.
>=20
> Signed-off-by: Alexandre Truong <alexandre.truong@smile.fr>
> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> =C2=A0patch-status/index.html | 19 +++++++++++++++----
> =C2=A01 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/patch-status/index.html b/patch-status/index.html
> index 99ddbbd2..c77db918 100644
> --- a/patch-status/index.html
> +++ b/patch-status/index.html
> @@ -272,6 +272,14 @@ SPDX-License-Identifier: MIT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
<p><em> Rejected patches could signify issues with patch
> quality, conflicts, or discrepancies between the patch and upstream
> requirements.</em></p>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </dd>
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <dt><strong>Inact=
ive-Upstream</strong></dt>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <dd>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <p>Th=
e upstream is no longer available, due to lack of
> activity for several years.</p>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <p><e=
m>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Inactive-Upstream patches indicate that the original
> source code repository is defunct, with no recent commit or releases,
> and unaddressed bug reports and merge requests.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 There is no longer active maintenance or development
> from the original project maintainers to merge the patch.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </em>=
</p>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </dd>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <dt><strong>=
Total</strong>:</dt>
> =C2=A0
The patches look good but unfortunately they've come through as line
wrapped and don't apply. Could you fix that and resend please?

Thanks,

Richard

