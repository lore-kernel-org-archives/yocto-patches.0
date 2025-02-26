Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47DC021BF
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 11:36:10 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.3783.1740569760104454937
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Feb 2025 03:36:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bCdox2wz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390df942558so13634f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Feb 2025 03:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740569758; x=1741174558; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYLqEuibrCvlKr08JqxwvaRnZkxrIdZ0ZLj09DWLtkU=;
        b=bCdox2wzWlMTTgJZfike+NRxDxYn1Z1p/kWyP7YvWcEGzNVIk6sbk4JsEKbRxrFJxg
         rHJFwLU+tYRF+3WFGY5NTpy+7a7QlGNPvUHZFLkYUYQlDT/qpSZGlySu/u8MjgfET90A
         fq0MTHYhXsbLbfl1LdnZy3q9RgvOy2wW6DaPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569758; x=1741174558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYLqEuibrCvlKr08JqxwvaRnZkxrIdZ0ZLj09DWLtkU=;
        b=MrTRiZ54dFt8i12tHSf4IoFEGUv5p0r06YzcXJnw0uDszjnVm12Yw+lmmtF2t+cd6u
         7wYOr3bCB9IAw8+vXGKRK4VeMpjee1JuNJsX50+VQVGTaS+i56+GZ2ramKdi8yY4oD1l
         8U+HeashcsjWoTvA5NKySCR1GvSHUoNg5W6oEIKycwC/JmfR5SCK0G2pqaKa3N3uW3i/
         ftMMpvTP9WUIvLzq2Qxmp3ctmSomGoFmfzBlQkfJl5OpXiGa1F+nM+9fUrFiOvGddTcA
         s3GncuOIIwbTPnWcr0noZxeIsA6DXT9y/7IFkfVPN+LuIQAeT4sRJwsgRqdE7qYHBfLA
         CUog==
X-Gm-Message-State: AOJu0YxmqHGBl3MD69GH/A61jC7k6mmXwPCypU83OZL3+XU5GgsJBthX
	FE/Qrn39p+A4VFhHHG6t4aYxi0CipbT8fxXKI9nyYm9bJUiOeAXDB7W1AyiALZdDBdY4CPIZHII
	9
X-Gm-Gg: ASbGncu+hWG2/VCQLt7bs6TH6+6WZVM50/wg9y0P21a1r8MdL3gmmpAVlF0adjH1+bP
	PQ++DvXlkVtxtC/7a8bbvqa6X2i8KY6i4EOloSP8OcTc+FDibdV5daEFeeXxQf2gsC/7DX3TOzk
	M8Lh0hsDwQtRu9hM3fNQxwQPIoYe8ZAe1BnCNRJuEKEtZsSWa59aDVATg+J9E2AC6aXbLZunmQk
	UWr32/jj3uYESDew11jod01Ik3kMBlnpdUVzxSmdVeEfE+YRJ+1iwmv+o5cpYOtGIZtFfamziJn
	P+iAmi5Q8gEfnfj7i4e4lo6pTbqeuHFOsxcc0jGpXtE4DhBD1pTwXRux6PwXE5hbgLkJ7aeOU+P
	6NHOrupy6v4j76ek=
X-Google-Smtp-Source: AGHT+IH/E0ViCxZogpTsP6ubdq9tQ9wsJiRZRNHPJ+S/NOVdxXefMfBEsI5niA2RZjycqF9fhRTM4g==
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr2521730f8f.41.1740569757691;
        Wed, 26 Feb 2025 03:35:57 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5bde:6c25:9c05:f012? ([2001:8b0:aba:5f3c:5bde:6c25:9c05:f012])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8667e0sm5379854f8f.10.2025.02.26.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:35:57 -0800 (PST)
Message-ID: <51035527e7cdfa359095a272fb6d43b4d30233e1.camel@linuxfoundation.org>
Subject: Re: FW: [yocto-patches] [meta-java] QA Issue: Missing
 Upstream-Status in patch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, "Mingyu Wang (Fujitsu)"
	 <wangmy@fujitsu.com>
Date: Wed, 26 Feb 2025 11:35:56 +0000
In-Reply-To: <CANNYZj-g0eJ2y7e2HvZkLbjwhfA1Rk6Ox+_FK_k3-Ycocp2Wcg@mail.gmail.com>
References: 
	<TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
	 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
	 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
	 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
	 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
	 <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
	 <CANNYZj8My6Uf78BFFkA09_VKYkHssxbk1z0UMiPF8jAAhYpB7w@mail.gmail.com>
	 <TYWPR01MB1186195D31D8A8A089D2D8C75DCC22@TYWPR01MB11861.jpnprd01.prod.outlook.com>
	 <CANNYZj-g0eJ2y7e2HvZkLbjwhfA1Rk6Ox+_FK_k3-Ycocp2Wcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Feb 2025 11:36:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1134

On Wed, 2025-02-26 at 11:03 +0100, Alexander Kanavin via
lists.yoctoproject.org wrote:
> On Wed, 26 Feb 2025 at 01:34, Mingyu Wang (Fujitsu)
> <wangmy@fujitsu.com> wrote:
> > > The only answer is: meta-java has no maintainer, and Tim, or
> > > anyone
> > > else, is unable to help you. You need to become the maintainer
> > > first.
> >=20
> > I wonder if it means that I or somebody else can become the
> > maintainer of meta-java?
>=20
> What you can do is make a fork of meta-java somewhere public
> (typically we suggest github, but that might be difficult for you to
> access from PRC). Then you can add your patches and fixes in it, and
> send announcements here when there are significant enhancements. If
> there's a good track record and commitment to making it work
> according
> to official yocto layer standards, then we can make it official.

We could also provide a contrib/ branch in the repo which you could
push your changes too as a staging area.

Cheers,

Richard

