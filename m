Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8803CC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 14:26:10 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41098.1792074363228961425
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 07:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fuBzFCtB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dc202a60eso2003933f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792074361; x=1792679161; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JFwpL+nd/tMmk5lwlcz/bA8fFMDQmz+nxV6mdhhbEro=;
        b=fuBzFCtBygEVgo+Y4qaWehHdxM8gszjwg31F8RgojE8wZFwTO2HNtrYsU7H2hGhBoI
         MgxYlqWJL1+IcAgN1iwP14d3xBzwypUj2rwF92yET+ALak+WL6+nulrrTcoGIhu4QXvN
         /1206HPRhqybsxznzok4BCEr66dEC1Uwjmq3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074361; x=1792679161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFwpL+nd/tMmk5lwlcz/bA8fFMDQmz+nxV6mdhhbEro=;
        b=dYl2wlqJPxUlJWRl+gBM7otnM4p5AYZdOtXrZ194NmKIHPgE5UZ73vYDnaBSiXhan2
         R1LyT9z3nOQZNs93BgGzf8ygkH0JIuHsuSiI/9Ix9oKwTBgH4+1CVz7nOETzz5AOiSqP
         C973NZgBjgTzbDQsw1MbFPdeNLp7+5s66vYcM2irHYobggZlpRhXhDJZexcWpAxzUfQ7
         0+9FroyTlvghUaIQ0wXvfFqtVBwLZtgFtxyENSv3dg+v/3gdFODc0LQNLjb99S9q+/Oi
         3Z3XTlIuoZ0wEBukfNdAxyxXG4UfCBDfKamTVxSn9rWtjdjPT7FphmN3xTGdQdHzcwtk
         9spQ==
X-Gm-Message-State: AFq9FYLWpI125xYLndcFj328HsROS7UiVjnsPq9yfx0BPMwBN5CJBrc5
	M+VuJAA/Zp5o/INux5+BkhZI57z6W1M3EyBNoMqcQN7675vj9QlIWtLBDqTltbuaddj3TUb6MWx
	uGNv98Uw=
X-Gm-Gg: AYBFou0j3J5gzq6WQDZMMzupRRELVJQq7urCbterLO9YWsEIOa7XpHdwb/b1OsLV9uk
	NMAygUWIiivwagIMwt42RlHN3G2TXbOF3vTa8wYNRSAfYpJplEbWiv2VLeK9eVhDe+ikhsIbmpL
	GcYFwylz1BaxY1Cp0pAuk5Uh1m7l1CJheI1syyTynNGfriasHqc4GlVNnpHeqO4Y8K3L+FKrsua
	Aony3633euCL2l2G6d+AQFWHWXCbwTokNXPUaJ3PjG4cwWpIH1A7GZRHfBAhXx9lfjJ00Yht5Z/
	+pGjsAQi8tGRi52HRNXXgs5FzX7nZSGzwwK15pxA0FK0jwDlNEHE8ucoSkRQNVeyWo1+5kVdbnr
	7MJ20iv4rCmVTNYsIRAp7Oesw08FHh1i8i3HbX8Lm+pBWOqZtwP9G+oy5YvbNle5a3Q2bBbmLoc
	1CJ3H9ejy71dMmmTfe0h2gY/1B3wXAvR+24jVOft6X2qOEPhC5VHX2KV2t6NxfWSUbNP0Pm+sus
	JfXqkIupV7kToqkCg/DKR/OZudhtxrElPF1IWw/gAP2ayCzWB85kviv5bSZTbU=
X-Received: by 2002:adf:e008:0:20b0:48d:ef0e:b791 with SMTP id ffacd0b85a97d-48def0eb84cmr7080300f8f.54.1792074361001;
        Thu, 15 Oct 2026 07:26:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8627:1727:8a8a:57f5? ([2001:8b0:aba:5f3c:8627:1727:8a8a:57f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm16045361f8f.32.2026.10.15.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:00 -0700 (PDT)
Message-ID: <20a05c7e247e12bbf0d2adfb3286f0438ae8ac5f.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_client: Fix
 xattr/rename handling with empty paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Thu, 15 Oct 2026 15:25:59 +0100
In-Reply-To: <DM5GBKVJU334.34PL5P3DVVS4R@bootlin.com>
References: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
	 <DM5GBKVJU334.34PL5P3DVVS4R@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 14:26:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5030

On Thu, 2026-10-15 at 15:38 +0200, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> On Wed Oct 14, 2026 at 9:38 PM CEST, Richard Purdie via lists.yoctoprojec=
t.org wrote:
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
> > =C2=A0pseudo_client.c | 17 +++++++++++------
> > =C2=A01 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/pseudo_client.c b/pseudo_client.c
> > index 23d7b0f..002de30 100644
> > --- a/pseudo_client.c
> > +++ b/pseudo_client.c
> > @@ -1789,7 +1789,7 @@ pseudo_client_op(pseudo_op_t op, int access, int =
fd, int dirfd, const char *path
> > =C2=A0	 */
> > =C2=A0	if (path_extra_1) {
> > =C2=A0		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash=
;
> > -		size_t partial_len =3D pathlen - 1 - strip_slash;
> > +		size_t partial_len =3D pathlen - strip_slash;
> > =C2=A0		if (path_extra_2) {
> > =C2=A0			full_len +=3D path_extra_2len + 1;
> > =C2=A0		}
> > @@ -1804,12 +1804,17 @@ pseudo_client_op(pseudo_op_t op, int access, in=
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
> > +			alloced_path[partial_len - 1] =3D '\0';
> > +		} else {
> > +			alloced_path[0] =3D '\0';
> > +			partial_len =3D 1;
>=20
> Err, I have a doubt here.
>=20
> Setting partial_len to 1 looks correct, but it was previously used to
> compute full_len, that is used to check the if buffer is big enough
> (full_len > alloced_len).
>=20
> So if pathlen is 0, the buffer can be 1 byte too short, right? Just
> incrementing partial_len a bit before should fix that.

I can't see where partial_len is used in the computation for full_len ?

		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash;
		size_t partial_len =3D pathlen - strip_slash;
		if (path_extra_2) {
			full_len +=3D path_extra_2len + 1;
		}
		if (full_len > alloced_len) {
                    <realloc code>
		}

Cheers,

Richard


