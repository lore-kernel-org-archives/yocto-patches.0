Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A4C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 08:09:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.8289.1751011778544392683
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 01:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h1drM87+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso12688105e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751011777; x=1751616577; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGNZPCtZ2o6qLZ9lAuGCBClkX/bBnBlz3m0f32JdqQ8=;
        b=h1drM87+lNG0IIcRNlTcCxVeYADZ5vHR/I38HkS/ntjvRy9Vxz0M9qf7kf992kl02a
         z+TIEC6W/wcV9aohwmqp3sn9y71XY8js/IMB00qfBalYlmu5IZq0ksEp2tj0XZmno8yf
         j9R6Om+EaJFVy5X0bwoT4LuH13EqrguM4F6FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011777; x=1751616577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGNZPCtZ2o6qLZ9lAuGCBClkX/bBnBlz3m0f32JdqQ8=;
        b=wSMOl5w9veduQRF4GJu+Ba2Xvfn7AaaedsB/O3mbCJQKA7QxmVxwVhcD2HvMqQkuoq
         Lug9FGYKsX4/SPmNMH8a0vQ/PZdb/EoTwtpUZyUCWfQGrjAWojxJkoeqPh/XuhHe1q+N
         IkGSK6oQTYC2ogwOHlXS4PZeV9QpVC8pjegU8aL0SuhTrYFQOLzZJZlNpdbRJYwzox24
         MqjN6IVuGUmRWLXTSyiVtoGX65ho9TrDqEMykeIncdpXHGdgwZ6JclX8dUo9c1JMVFnU
         jNMWM/eeaecN9wRF6DKrb68lT5Qc0Uzlonc1kUL3RddXOBIZ6BeFaZlB364tj0B4C1AV
         4T/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcm3joRzk72v6vgQRK6KGjxIWEKnV1qkrrRtPMWUme5Ef6JuLI1GW3U9R+8E6D10mUcafqkX7xf0rCKnFZ@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwpcTXUP92QBbBrsMTmHFF8exIZK1zK7NPdrnYdnmJWGK1JS5kW
	lYofIc/pK0I4+Q4EYxletYgV+S99dbxJjfKgUt33mEZdwHkZh36uFlqJ3LfElqcAKAk=
X-Gm-Gg: ASbGncuBtmm8VnIsbYpe1xTaANJQwxfU3uqfJgm3ZQpGJnr7VJRbU0V/EOKOyMnF9EY
	tqRXljQX0QUhk+llFUniz1fcTdolViyNrMgsiYd7GTpIbnOlm8lpV/99hNqWaasj2gLpLB5umhZ
	/c9TXFDLMJVpJtri5uXp8SQ2IBF4oRDAb5MUKorNDzWMUukIH/z8CeKXmFb5Ah/z5USptvx1Tnu
	zd6g4NFxR9jcsyBDMtH3IOS2W+2cEZjKAxxnp/0W/AzWhjDR/jjzsTLfEmmxG+4CVJ88y6KPGht
	ykQ6faYbKmDF2t7YmtOVmlHpw53ftz9alX1sxmafIId2lcfU2TvWRRn4l9MJl5z4KEkoAMup7I8
	bKxe84trrbWL6sgNB0FitfnJhvP25tqCSZgEm1tNNwJBUf22gyW0=
X-Google-Smtp-Source: AGHT+IEqdvZsh8oRiU7fasXDOMu7McBKsdNdkDqMDcT4ikUTQfGwhrMJbv8bc8v2MXTN3cmlAmmo8g==
X-Received: by 2002:a05:600c:37c4:b0:450:d61f:dd45 with SMTP id 5b1f17b1804b1-4538ee5617amr25310145e9.4.1751011776695;
        Fri, 27 Jun 2025 01:09:36 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ef04:c18a:8ac7:33db? ([2001:8b0:aba:5f3c:ef04:c18a:8ac7:33db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453822c6b9fsm72949535e9.0.2025.06.27.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:09:35 -0700 (PDT)
Message-ID: <066e1255466f5be3f01581e9b6498abc0450b110.camel@linuxfoundation.org>
Subject: Re: [meta-security][PATCH] layer.conf: Update to whinlatter release
 series
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>, 
	yocto-patches@lists.yoctoproject.org, Hiago De Franco
 <hiago.franco@toradex.com>,  Hiago De Franco <hiagofranco@gmail.com>, Marta
 Rybczynska <rybczynska@gmail.com>, Max Krummenacher	 <max.oss.09@gmail.com>
Date: Fri, 27 Jun 2025 09:09:35 +0100
In-Reply-To: <20250627074019.GA5745@francesco-nb>
References: <20250622173729.13803-1-hiagofranco@gmail.com>
	 <20250627074019.GA5745@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 08:09:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1706

On Fri, 2025-06-27 at 09:40 +0200, Francesco Dolcini wrote:
> Hello Marta, Richard, and all
>=20
> On Sun, Jun 22, 2025 at 02:37:29PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >=20
> > Update to the new Yocto release series.
>=20
> I understand we are on a pivotal moment with meta-security maintainer
> discussion [1].
>=20
> And currently we have our whole integration and testing blocked
> because
> there are build issue on meta-security layer master branch.
>=20
> Do anybody see a short term solution, to solve the bare minimum build
> issues?

There are two sides to this. On the one hand, you'd like the issue
resolved ASAP as it sounds like it is causing you a problem. Whether
such a change like this should cause you such a problem and whether you
can in fact work around it is a discussion for another time.

The trouble is as soon as master gets fixed, people will go back to
focusing elsewhere. Many are already finding ways to ignore it until
someone else fixes it. There is a much bigger/deeper issue here.

Since you have a key dependency on the layer, I did have a look at the
commit logs but I don't see any patches from you, which is interesting.

Thankfully we do have a couple of potential volunteers to help but I
was extremely worried we may not have any at all.

Work on layers such as this is hard and as a project we're struggling
with maintainer burnout. A drive for "the bare minimum" bandaid work
isn't going to help anyone and I want to be really clear about that.

I've recently been told I should just "let things break", i.e. stop
spending my life doing diving catches to keep things working/running.
If I do that, I suspect the ride will get a lot rougher.

Cheers,

Richard

