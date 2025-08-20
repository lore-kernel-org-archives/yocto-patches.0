Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89975CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 11:31:21 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.web10.17568.1755689472053822023
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 04:31:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ck4mz6zk;
 spf=pass (domain: gmail.com, ip: 209.85.221.173, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b17531009so2081562e0c.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689471; x=1756294271; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qMQMzO3QiEZcoBxEmJMymdm2QfatCFDNX8/G50puTE=;
        b=Ck4mz6zkhIMLMUo8IR3iAV2CZNEWDUMC+yo+jqS+MmBMx/KxaI6yDjJR3+fhfzgfO9
         33CGhLZJjCPVJ0qTcpd6gi8g6rPSQZEKqxDjIrwnf5icA6QAgW3k6h8nDT1NBT0vn3QA
         8SwdgvPiyJ82QazG3w9ywtRJG0NI4OpxsI6KYzO0cjfK5XXKQJEJrTuBxW+yAqmW68LP
         1Xvl2vK5CmnUu9/9RB+PHyLj6te8BMRJesd3wWWe+ZoiNijwE7OGG4V0yFF7KKe031tz
         M6kRuHmVfmApRK63LoxdwY8N+wTKLfO/utMikRF/UZQ8ptvG2JYLoc/NAEYYsbMMpsJd
         iWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689471; x=1756294271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qMQMzO3QiEZcoBxEmJMymdm2QfatCFDNX8/G50puTE=;
        b=AqeLy+v00hahtO4ovDsv1WpvZYtK23JmC2p6eBwO7raX4hNvZYy+ouYBfgeQABHUk/
         IAp0gopRiElfxgQdsyFufH6u7Eo/l70QsJmW0SL0REuDUkLpyfreXTRgfRKpf/kYBa0J
         1hImVYtQ2K2o6UdXiX4g1uFeLy8R7ANX3+YhVWzDSZ3NAMLbU5vmXDzXf31u4Tpfb62U
         XahKvYHmLmnjXeU+cHodje2d4fY6yL/PLuFpKZSQosaR61/fyJcWBWq98S8LqUbZXSbP
         1G/zjyY1PzUkwGtdi3xlh/KaE1fCHNH9Arb0oCAjl9wzjUo2Jf096MFCH9dJjOXuKkfO
         2SRw==
X-Gm-Message-State: AOJu0YwVSfc/D4oNU78NTHOgZ94hvgOjjWPSMNH2qYVtc6IAU53lrgoY
	Vq0RtnmmShDNqPH3mcZ5ALILvVhq8oPLAViD80n1pohCCd5mx8K1yA27Kepw58Xr4QvU5i7mYJ+
	XqHbQdJ2YsEp6LbKqUvFdQd/DaTJ9EFX5ZemlxvM=
X-Gm-Gg: ASbGncuylK+2ctN2TJXXsEFFuMsNiDxW0M9jDPNdlIciizLl2eUzgvedrb3wD04SthH
	kFm6xcOZ8fhQTc0AMsyK1qexMFJzcNVi0il+hW8OmzWdEh67YFn2aYSmtyS8VpKs34gz0adEZAL
	kRsh+9R6Cdv6MB+ZR3gqhUdcYaurUqvtnKtWqr8H/+toxUunWpDmDK4a/dMDh8S5lnWtpOaAJHa
	rvuv9qQ3PzmJrTEg5c=
X-Google-Smtp-Source: AGHT+IHqgF6nXAf7tIWegvJk2YNAl1hfJXZujTNn83wGnzktxexw1W45aDaly4WI0Ur2CLzUav8fwhUTpZVA9R7nC5M=
X-Received: by 2002:a05:6102:6a93:b0:507:76ef:2a59 with SMTP id
 ada2fe7eead31-51a4f441fa7mr664039137.7.1755689470553; Wed, 20 Aug 2025
 04:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250818225046.55311-1-peter.marko@siemens.com>
In-Reply-To: <20250818225046.55311-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 20 Aug 2025 12:30:59 +0100
X-Gm-Features: Ac12FXy5585UAejBSaS8rtv0n8y_gw-6wGnwp3sejngQ_ldkbvS9e6jBtmO6GXk
Message-ID: <CANPvuRkYWZZ3YnegmTxCYLM65G+wvR7UvsRE0DeZ2enWzXSwcg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH]
 conf/layer: switch to golang 1.25
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000003a7475063cca4f34"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 11:31:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2065

--0000000000003a7475063cca4f34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (segunda, 18/08/2025 =C3=A0(s)
23:51):

> From: Peter Marko <peter.marko@siemens.com>
>
> No other changes seem to be needed.
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  conf/layer.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 5d1b19f..6c1738b 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -14,7 +14,7 @@ LAYERDEPENDS_lts-go-mixin =3D " \
>      core \
>  "
>
> -GOVERSION =3D "1.24%"
> +GOVERSION =3D "1.25%"
>
>  # Since go-1.21 GOPROXY needs to be set explicitly, otherwise it fails
> with:
>  # GOPROXY list is not the empty string, but contains no entries
>
>
Hi Peter,

All were applied.
Thanks

Jose

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000003a7475063cca4f34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;p=
eter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.=
com@lists.yoctoproject.org</a>&gt; escreveu (segunda, 18/08/2025 =C3=A0(s) =
23:51):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Pe=
ter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank">=
peter.marko@siemens.com</a>&gt;<br>
<br>
No other changes seem to be needed.<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
---<br>
=C2=A0conf/layer.conf | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/conf/layer.conf b/conf/layer.conf<br>
index 5d1b19f..6c1738b 100644<br>
--- a/conf/layer.conf<br>
+++ b/conf/layer.conf<br>
@@ -14,7 +14,7 @@ LAYERDEPENDS_lts-go-mixin =3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0core \<br>
=C2=A0&quot;<br>
<br>
-GOVERSION =3D &quot;1.24%&quot;<br>
+GOVERSION =3D &quot;1.25%&quot;<br>
<br>
=C2=A0# Since go-1.21 GOPROXY needs to be set explicitly, otherwise it fail=
s with:<br>
=C2=A0# GOPROXY list is not the empty string, but contains no entries<br><b=
r>
</blockquote></div><div><br clear=3D"all"></div><div><div>Hi Peter,</div><d=
iv><br></div><div><div>All were applied.</div><div>Thanks<br><br></div>Jose=
</div></div><div><br></div><span class=3D"gmail_signature_prefix">-- </span=
><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best regar=
ds,<div><br>Jos=C3=A9 Quaresma</div></div></div></div>

--0000000000003a7475063cca4f34--

