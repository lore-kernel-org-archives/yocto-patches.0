Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D88CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 12:19:41 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
 by mx.groups.io with SMTP id smtpd.web10.18295.1755692377412778094
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 05:19:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WGnzvgnv;
 spf=pass (domain: gmail.com, ip: 209.85.221.176, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b1754a419so4467064e0c.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692376; x=1756297176; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8RqiHBmDj3H47CfBY5cXauvWyREUsXwTAIv8VggqTc=;
        b=WGnzvgnvrVY5mVKIjxk4JG17+sG+Iz4+G7cO8lTVkaf2klxVxs2BI+k9oxKlAt21iJ
         vg/qnsyIiNQ9zi9g2mly+FQZ7UADWqaAlPbyvMXMD4sI2cHM4DjQf7b6PGoSJVi5NVY2
         jzlDe18almp8ZyLt/Xb3g+89BD9tNLIIKl2d6zZAmsyJaF1xGV4XaWZllUdJYvLVIz8M
         zFM3iVeoIvBsCRR2B4Cx7Y7/n5FyFnWlInZpzAXZBL1LLIuObHYZCPKrmWDjKSZcCJuB
         VxseB08sCTVnO69OWvVt2+MeD8TDxPBtLkjYdq11UcwUD8X+bge9wY4xl+jxht0JKW1c
         sMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692376; x=1756297176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8RqiHBmDj3H47CfBY5cXauvWyREUsXwTAIv8VggqTc=;
        b=oXjsOigVSOS3SSpNUxdcskmqyn77muJctmcHjJGOS1rCEFbdxPwX0TNY/cBatpHUJp
         E4j918M0TPyncOVWgxlQPfcEGgqN9iM6rmG2ej8hNT/kePlVOtm4DG3LDVd7Jlcg0T/C
         mwDI7rVUPBqJTYzrPnEwhGFdfmDUfH1XW6FKOPp96faMFID4BQ5oS9tmjSWT+s5bpzpM
         opFiUtPMSLkxRExnShQVlop7QAYwnK4yuv/Q0gOf9UaCBygIvhuQ6UqecwCFMUp17so4
         runKF0z78HdBhCtpCdT1W8C+KReGPEmfTtvR0Z/rEFhDu0m6Ja+FzQE43S8W2k2he4dz
         +XkA==
X-Gm-Message-State: AOJu0YzehAnhYmqmcXGxQSWH4FakJLQ5ljCCOrZJDE9SL6GtH7eVEIj4
	KmRUD5Y7MmPV3GGIjQ2bn40/P1+0mxXNvU92I5Jtp+4I3hgJ9PScNeWp+RT5D79kFhn/Fyb3fHV
	p2419cXi4roLR5g8FftXTezUs3PCk/nTmxiCD
X-Gm-Gg: ASbGncsw6ZUySYe0ZR4sdct+qd5s2quIBS9RpmoOnPhFzkt8dHh77pK4Avm0i3xGKpZ
	eb1aGwVBlDIZW4AbpFsjOmzadoshiHzRAsNyBlVQRS82+ZS/+GnunTdmxRGAC+QfGF0sdKpljQO
	ATSWi/M9rYF5OEZ9eE76zX5tu1yfatstXBcSvqOYDnqkD0qqrodOQrrTgFQG+icvoV639w3KbTr
	iouaFYJChZscycTIM4=
X-Google-Smtp-Source: AGHT+IFAaxHXg+GZuqIu1Uduq8rSb+MCErk/iFfTmUj1aOK/8nJbEzuQqpM3nM+6qDwCZAKUVmcUE7qk42hRWhcaa2s=
X-Received: by 2002:a05:6102:4413:b0:4fc:824d:1cba with SMTP id
 ada2fe7eead31-51a4fb45255mr775671137.12.1755692376205; Wed, 20 Aug 2025
 05:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250818225046.55311-1-peter.marko@siemens.com>
 <CANPvuRkYWZZ3YnegmTxCYLM65G+wvR7UvsRE0DeZ2enWzXSwcg@mail.gmail.com>
 <AS1PR10MB56973181DD547A7B6EB042B9FD33A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <185D77A108AB874C.23467@lists.yoctoproject.org> <185D77DA7A06B044.23467@lists.yoctoproject.org>
In-Reply-To: <185D77DA7A06B044.23467@lists.yoctoproject.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 20 Aug 2025 13:19:25 +0100
X-Gm-Features: Ac12FXyJCjUgWV6sYvP5jZ86Qt6E_6vitThhbZvYsnU4VZZZOJ2bzqG6Gsl_3i4
Message-ID: <CANPvuRkVgZm0zEKy6mpqQHjaB_DdzVR54HNS85cUugACuqeuXQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH]
 conf/layer: switch to golang 1.25
To: yocto-patches@lists.yoctoproject.org
Cc: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000006b2ef0063ccafcef"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 12:19:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2069

--0000000000006b2ef0063ccafcef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jose Quaresma via lists.yoctoproject.org <quaresma.jose=3D
gmail.com@lists.yoctoproject.org> escreveu (quarta, 20/08/2025 =C3=A0(s) 13=
:00):

> I think this one shouldn't have gone, I'll do a build to check
>
> https://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkstone/go&id=
=3Df3bb48cea8c9794ff9e4d9eb13309c4651a7a226
>
>
Fixed

--0000000000006b2ef0063ccafcef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Jose Quaresma v=
ia <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt=
;quaresma.jose=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.=
com@lists.yoctoproject.org</a>&gt; escreveu (quarta, 20/08/2025 =C3=A0(s) 1=
3:00):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">I think this one shouldn&#39;t have gone, I&#39;ll do a build to c=
heck<br><a href=3D"https://git.yoctoproject.org/meta-lts-mixins/commit/?h=
=3Dkirkstone/go&amp;id=3Df3bb48cea8c9794ff9e4d9eb13309c4651a7a226" target=
=3D"_blank">https://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkst=
one/go&amp;id=3Df3bb48cea8c9794ff9e4d9eb13309c4651a7a226</a><br><br></div><=
/blockquote><div><br></div><div>Fixed=C2=A0</div></div></div>

--0000000000006b2ef0063ccafcef--

