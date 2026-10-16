Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0ACCA462
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 08:04:08 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17023.1792137840941897976
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 Oct 2026 01:04:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MZBeIEkg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so38588275e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 Oct 2026 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792137839; x=1792742639; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ci/Egpc1rP1khXTLxPy2mScVTOs7jDiaaYMLpxcF+o=;
        b=MZBeIEkgDLuLGLilZ9fuzpcuNJGtOuwIi0aVWo+Qv6XKNU1G6aMwa1EOrxELPGhaD8
         QJQ3Yv4gMYaTB9C9OlrgtszqIeE0JkjT7yzsgwgKN2malEXHD1Yx5w7RkzdL/LKatcUY
         Ukch/sNykH/U70ylHdl/f0blSxrjbb/WzH4Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137839; x=1792742639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ci/Egpc1rP1khXTLxPy2mScVTOs7jDiaaYMLpxcF+o=;
        b=gwj+E355MQTLXX6BiOGaLd0NqeQHqIaa6/OJxu7fybwoA7kxroe1z2sk+GLx15Qq9Q
         gzkaGWQYO8ZNEn/KLYpTCe2RwWAf5kyqViejyfbIgKOg292PThvk2lYAJEsnZO1T6r0f
         uaJtuR9tEmQ4PKWj8vvJJB9aJ8riRWGFdlrh/RhoUl3fcRWlvSgw1ZvPAJBgI6ITzduk
         /M+PvPDITyxSwA+sRZf4/N6MPqwysr3mn1OdkfqgDRcSx7lQqpvIWbKRrCa67FoybF8U
         sOQ2XNoU4+bVdbC4VSeIcrJptVJIU5c962GSLZIqpIqiiUyDx4kfg68PIIFPTA/6FzW8
         kdeQ==
X-Gm-Message-State: AFq9FYJg7S6iewuw7qS2rR3jhEzkm7ocRslnoZUsUatrxdescrtQBju8
	XDCQWPRkoX/B7Wk7MJ9c6q+NfVwNIcXJ1G0XJ4NKa1obv0bWnHPsZhjCmXznITcdYelND6VlRxs
	SRuaeT4Q=
X-Gm-Gg: AYBFou2N0Yn3+W3qKIPdjheXd40WFDmpLjR2WLNmordqC+sIrPf/A9nMLimeAapRbah
	7bw5ay3FhYm0FCNO5KtHUndjZts1WN7KMz4Yh4xJlBQ7jWiQkMwaU/4vvHKP1TsdNhJ4SlDpCGI
	byUt6YDsUNlpa5pEOM+jYmaVcZrGAHgPYPinGdSe0e4BZs8zI4n/PGWj4S9UwhSB2ZVIuX7+Myx
	fK205cHmoiIBenXiCiYCtCdtMEb4ptVzMDOBtjtjKT/+4Uho7DkkQWMvkQvammdk75Z0D0CelVg
	dMvpzfId8EPNBVdqhkMoyqRDsbz6ByuF3qyduHTx550YD10i2cy8TV8RN/k6p3fk+vxAIVa+FLM
	KBhXFfy5MokZ+aDDGNiXLqJBUqJZ773acTp+TmnLplWRpRp9cUs6tdh6brXaqTe8a46mTz6I7M0
	1wYwrBjRmMQTdsb1vQgZDXLebJLecmsLpy6JhKSZ9z0oKyzmKugoVFVhzES3I0GRo2rSlajHpkg
	zsUfkUHmzoO2vrep5Xg577Mrmxi2BFSZ12T813TeKbS7qHk2FmQ10GmMUIewG0=
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr435842485e9.0.1792137838757;
        Fri, 16 Oct 2026 01:03:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:988f:f245:635a:3450? ([2001:8b0:aba:5f3c:988f:f245:635a:3450])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm149091455e9.10.2026.10.16.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:03:57 -0700 (PDT)
Message-ID: <279f30c06d89b7ca0749251a802d1eac0adfb89c.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH v2] pseudo_client: Fix
 xattr/rename handling with empty paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Fri, 16 Oct 2026 09:03:55 +0100
In-Reply-To: <DM61H2PIVOOH.2ZEU6CJ6BQST7@bootlin.com>
References: <20261015220227.794655-1-richard.purdie@linuxfoundation.org>
	 <DM61H2PIVOOH.2ZEU6CJ6BQST7@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Oct 2026 08:04:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5035

On Fri, 2026-10-16 at 08:12 +0200, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> On Fri Oct 16, 2026 at 12:02 AM CEST, Richard Purdie via lists.yoctoproje=
ct.org wrote:
> > On Fedora45, we can end up in a situation where path_extra_1 (for xattr=
/rename ops)
> > but path is of zero length. The path_extra_1 codepath does not handle t=
his well and
> > corrupts memory.
> >=20
> > The issue is "partial_len =3D pathlen - 1 - strip_slash" when pathlen i=
s 0 (and
> > hence strip_slash is also 0). This leads to invalid memory writes and i=
f those
> > happen to access off the end of a mapped segment, the program segfaults=
.
> >=20
> > Fix the code to handle the pathlen=3D0 case.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0pseudo_client.c | 18 ++++++++++++------
> > =C2=A01 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/pseudo_client.c b/pseudo_client.c
> > index d83175e..1c742ba 100644
> > --- a/pseudo_client.c
> > +++ b/pseudo_client.c
> > ...
> > @@ -1806,12 +1810,14 @@ pseudo_client_op(pseudo_op_t op, int access, in=
t fd, int dirfd, const char *path
> > =C2=A0				return 0;
> > =C2=A0			}
> > =C2=A0		}
> > -		memcpy(alloced_path, path, partial_len);
> > -		alloced_path[partial_len] =3D '\0';
> > -		memcpy(alloced_path + partial_len + 1, path_extra_1, path_extra_1len=
);
> > -		alloced_path[partial_len + path_extra_1len + 1] =3D '\0';
> > +		if (pathlen) {
> > +			memcpy(alloced_path, path, partial_len - 1);
> > +		{
>=20
> Typo :)

I wondered if anyone would notice :)

> But aside of that, I believe it's OK now.

Thanks, it did pass testing too so I think it should be good.

Cheers,

Richard

