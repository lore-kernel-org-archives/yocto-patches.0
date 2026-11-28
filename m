Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3963.1795855565641994241
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 00:46:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IYaAaZOI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso108190325e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795855564; x=1796460364; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vLVe3BgTj1unWSugDwJ5PCMn8mg12QD9zQGtrLM5qhU=;
        b=IYaAaZOIcv9uCmKdZxIjWOT8xbbQhmht3IeKHTctXlrpCTw5ZioCnrjz0+oNqumF/1
         a2bAWrBdv9oLcHwhnteyv7/cT6C4gh+AVDCZFr6wfZGBEHdAsFQbkJp3yNwLPbKCiO3a
         FRj+CH8yehtG5PQsM0TDSubdAfwSki5B9hffM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795855564; x=1796460364;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vLVe3BgTj1unWSugDwJ5PCMn8mg12QD9zQGtrLM5qhU=;
        b=oJ38d1CUFX3BffyVEelzRSHHaTzMHxEDaqlLhuSKL/0FQf+F4LFRe0yee7ZFAZYNmN
         UXt9rdtDFfbSJQD3kYT0TNpKbOu1u/IyMaRWNa0Bozc5UZeoMUKBdeY/1Ij/lN7Kc8Za
         TWmDV9gb0Xjezlxh3CCvzhzE0uiFACk3RtZauDLcYdSm3tPJkeczuxYbV1T8TuP4vEbM
         ChDcB03nudXeU+141g2zf8gxNqFCobySFxcDD9VMW/OLKvgwPR/7dAWuiIaoxt6PhWlP
         v2cItwy4mFJu48SnHLOsQlJeetoTQXm9ABc4GAX6+PYynqYP3v2We3NutBg1eLFLew8y
         ESUw==
X-Gm-Message-State: APuU4Z9cbQ7Tax/0vEyqyRYQ9pyWHQtwgQkhHQeWzgrnbw8NKi9BbkJG
	vgE7QEGMDf770/aoP396PzaIBIguFIfmDzYEXKWQNxmB3ybEnIhjkqSYmxUsS3e8CTcye6AA5n2
	9I8b6v90=
X-Gm-Gg: AZFdTZdvg4+yoagpcaTnSiBkCsnWGH+YNvUi80GevDwNhuU9sRS9UlUKNUp/K1HtFiC
	i0vWN69utQKKKL9sAyOnEM/xR0OplYS6uMYWrNkdNBeTzzpiX8d+L53ZIKf0dRnQkEkGRB2FGtI
	qufl80YBOPrNwwrfaSwhE9v1x1NyX1YXQHMYa5H238JX2FuHJP+0zmIUY2xa9fAZCnpSfyA9ScY
	7jInYbbJU0WPwwfECd/xwP25ipJ2FaAJoqSnE3n/zpDHMUI1Irv3f8AytqdjWfLt9Wh3NTwxHA3
	X4TPsotdCqbs58seWXwkKcLGRaoUPFI1xuMba3AjAX77GyqzG+l8PlID3f+7Co9R0sU7NH/F21c
	qF5Z1QhZcrJWswxCXJh2SF/U+dGRkO9GcX0pJJTNlTANLIVM6AyBDZ6YvTGzuQv3nYOM0MDJD87
	kP7ORLTXIXis8xsEwT/7eZbH+18gUGKhudheDa0X9xctp/b39ykebxaGTO8VC6gkNmEpt6wWApX
	LUJYidOnDXunsaxnO8TM/M73Ct4e9/0ir8AgWfwamrXj/XnOLH1JCRhFrsTdapR7F2x8r9Y4+9e
	+8TJw3sObm3aztxGYT1LkQTuD0gp7MJ0A/2mjtaH+SD2+Y16nGftTQAO9b2g4ELx3sNtpAh8cgs
	RzGASaytis3fnbjcMjHu1MIjdhSUnExMsdD0Oog4=
X-Received: by 2002:a05:600c:8b83:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4bb8880642cmr520931115e9.17.1795855563637;
        Sat, 28 Nov 2026 00:46:03 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:1739:bc1e:4865:8522? ([2001:8b0:aba:5f3c:1739:bc1e:4865:8522])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm1053355745e9.13.2026.11.28.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:46:02 -0800 (PST)
Message-ID: <ef6bc71f91c57ff819f531ecfecfd3a121915314.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [RFC meta-security][PATCH] Move meta-security
 main layer into a sub-layer
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Date: Sat, 28 Nov 2026 08:46:01 +0000
In-Reply-To: <ca908d34-7221-b942-03a4-8f86345cb742@konsulko.com>
References: <20261127165425.726917-1-jose.quaresma@oss.qualcomm.com>
	 <ca908d34-7221-b942-03a4-8f86345cb742@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:46:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5556

On Fri, 2026-11-27 at 19:15 -0500, Scott Murray via yocto-patches wrote:
> On Fri, 27 Nov 2026, Jose Quaresma via yocto-patches wrote:
>=20
> > With the new layer configuration bitbake will refuses nested layers.
> > The meta-security=E2=80=99s top-level layer contains all the other laye=
rs inside.
> >=20
> > To avoid nested layers, we'll create a sublayer for the top level.
> > Creating a sublayer for the main layer solves the problem and is a
> > simple change that only change the layer=E2=80=99s path.
> > There are no functional changes other than the relocation to the
> > new sub-layer path.
> >=20
> > Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
>=20
> I have been following the discussion on oe-architecture and am aware
> of the likely upcoming change.=C2=A0 I'm going to hold off on moving thin=
gs
> until we are forced to by the layer.conf format change to not make
> people go through two flag days.=C2=A0 As well, this may be an opportunit=
y
> to do things like split out some of the sub-layers like meta-tpm, so
> if people have an opinion on that idea or other suggestions, please voice
> them.

I think a few people are running into issues like this as they'd like
to test the new changes but it means everyone ends up doing conversions
of things they need for testing.

Would it be worth a master-next type branch temporarily queue these
things? I know those branches can be a maintenance pain for this change
especially though...

I'm mentioning this since this might be helpful for some other layers
too.

Cheers,

Richard
