Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480AC282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 15:55:02 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.18508.1741881297904689281
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Mar 2025 08:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eRkB7ICS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3965c995151so402208f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741881296; x=1742486096; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+AzA+p8H87zQ3foCj10iqsUWSUaNDrxI/Qmlr25CCM=;
        b=eRkB7ICSbov27doAonhp91Lrjocf0eUqewaJ0sY6aKzVNSRZe+yi53sdObeBOpY8+8
         hFg5oAYgHo7MXl0ZpVeKpwXRixkHb1IHbHc8dcnxdUjxigHzBbMe8SU3A9pzbad6LCI+
         Cr7wmLnCvsBMAqUPZc/9jULGDXjV34cKmL8w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881296; x=1742486096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+AzA+p8H87zQ3foCj10iqsUWSUaNDrxI/Qmlr25CCM=;
        b=cIH8B3IlndE/iKZsAOBbTwUKgJHyVjbHNDHDSOUlyepEcUBReQRF/VHCSt6+9eVWgr
         Qf7Os0mRmN1eG6tQj2+OdTmCJlGQ10S7xGAicnt2naBNDn4ihpkfsL8n5xBFLf7QQYfd
         BQ1V08W25VXG96aOyR4h4CYW7MO370D9urMHJc7miN+CooQQxwpEjmHiT9jqPNFR88SQ
         ZjD7Q6DpIIK1wek10mB9+7D2jsCWK8rd+GZdaNKkglOm3gf9VGFIPS7fg1THtRFimsc/
         aTjzmzchnLrlXXIJltYftHy6pfRB66+qDJjyWu+NdVy9VnSQ5DN1C541OgJjyCf/i/G6
         AwBA==
X-Gm-Message-State: AOJu0YyE4Ycxv2h7+x2zT0FUcbUoIj1qMtrtx0fH5bgabt8l1lJNiIEN
	5aX+SW/69hC5HV66xcllkIeshxDWRHUhJn2XyahRWopwoAznhvvHBinlYZ2wA7pheKf+t65HHWS
	x
X-Gm-Gg: ASbGnctPRM7SmR24t8YWN+IgUsM30rI9ZtkOlyKH8vsayytwXyAHN3ajcwuKVSpzlYV
	GeC7HpyGYgvxDd+Hm3iBOPl26NJNyu1n0HZuOw7BS3+jNueii1qa+fueheYUldPX5ETFMqpLuYt
	y9Oreo+EO1HfSPpkBb5h+HXREnjBkWo+w2DE7lB0HJxAu0RZIy2W6tkn1IUOfXsW0PieYmu3lEm
	++JERKtqWPYyNDw0zGf67ccZ+q1ekofV7gGVYntvJiLLFl2WnTWiHC8gPf8JR7TpPZTMtzSq+i2
	UDZ82pfQS5/xwFR7Y6fpe+FIgRlkGv3P4hYF8l5lhiQtv3rlSErGqvFh5/zr79tVFXhpImXn5jG
	4pQd/rYhbksd9qyiLCONPinUHcNUSZo8A1I/J1E7Secj8
X-Google-Smtp-Source: AGHT+IEGaMqtO4T2btugQhOfK6yJLNDX/0g8r5DWI3O2AAg08PrMQfTJsw9CIur3TdTwOxgVq1xdGQ==
X-Received: by 2002:a05:6000:184b:b0:391:23e6:f08c with SMTP id ffacd0b85a97d-3926c5a48c5mr10468407f8f.47.1741881295939;
        Thu, 13 Mar 2025 08:54:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cc37:5f80:1a41:4bc8? ([2001:8b0:aba:5f3c:cc37:5f80:1a41:4bc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaedsm2554229f8f.90.2025.03.13.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:54:55 -0700 (PDT)
Message-ID: <89631d665d97b77ad40924cd5abc003e77c8dcb1.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 2/3] Makefile.in: Use
 ARCH_FLAGS instead of -m32 and -m64
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
Date: Thu, 13 Mar 2025 15:54:54 +0000
In-Reply-To: <20250309060039.454124-3-wuxiaotian@loongson.cn>
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
	 <20250309060039.454124-3-wuxiaotian@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 15:55:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1202

On Sun, 2025-03-09 at 14:00 +0800, Xiaotian Wu via lists.yoctoproject.org w=
rote:
> Gcc on Loongarch does not support this -m32 and -m64 options.
> we can use the $(ARCH_CLAGS) variable instead.
>=20
> Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> ---
> =C2=A0Makefile.in | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile.in b/Makefile.in
> index 48fdbd2..0bb8a88 100644
> --- a/Makefile.in
> +++ b/Makefile.in
> @@ -157,10 +157,10 @@ pseudo_wrappers.o: $(GUTS) pseudo_wrappers.c pseudo=
_wrapfuncs.c pseudo_wrapfuncs
> =C2=A0	$(CC) -fno-strict-aliasing $(CFLAGS) $(CFLAGS_PSEUDO) -D_GNU_SOURC=
E -c -o pseudo_wrappers.o pseudo_wrappers.c
> =C2=A0
> =C2=A0offsets32:
> -	$(CC) -m32 -o offsets32 offsets.c
> +	$(CC) $(ARCH_FLAGS) -o offsets32 offsets.c
> =C2=A0
> =C2=A0offsets64:
> -	$(CC) -m64 -o offsets64 offsets.c
> +	$(CC) $(ARCH_FLAGS) -o offsets64 offsets.c
> =C2=A0
> =C2=A0$(PSEUDO_PROFILE): pseudo_profile | $(BIN)
> =C2=A0	cp pseudo_profile $(BIN)

The whole point of those lines is to generate 64 and 32 bit versions of
those files. A single ARCH_FLAGS value will not do that and it would
break their existing usage.

Since these targets aren't actually referenced anywhere I can see, I'm
wondering how you ran into this in the first place?

This wouldn't work on Arm either but we're not running into it in
normal build usage.

Cheers,

Richard

