Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A8C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:59:53 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14790.1785254386720602923
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 08:59:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=COz0cGl0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f71156e1aso13522f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785254385; x=1785859185; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QwDYWoZl/Zg3CBFVcUQtY2NwBLH0LosVk6+U2RgCiug=;
        b=COz0cGl0r/WWaGz3/voTSOH78FYTcv1J+j3KB/icH2FgpUTnWkbby8uAyHKHPKwVMt
         AMsxGkKSSEwkKIpVbvcbChvB0GxMokuU4FWgaXKB58u1i7PbDj2clDELPiveuh1MBttI
         3rh52ZWKqUjNCGOP3RlsHXSVIXgXtggPYHoek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254385; x=1785859185;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwDYWoZl/Zg3CBFVcUQtY2NwBLH0LosVk6+U2RgCiug=;
        b=PxuvqmST16e65sT6BH5jESl4gVg0IWNBgkxuqp56jc+dXMtxXyyMWKTB74EAVTCF23
         O08I6lHcOWlRvvERhjjMZdKVGMt6F15mnWW+ROAqZWtIJJkpn9kLzmTWhULwP2WJ9B/H
         ZFLgJRk0SF+5jzP7ZgbA4U0Alg62zToNXuhAfjCNZIg1/AGq6vdE2aG8YLYC+eR2ec1Y
         L5m6JD/Hhkna4KiqJViiWPQJIQtYJJPxEFav4HWlRYfZ+3fhnFn3/N3sOiCLY6e9agXP
         0lOlmYyXSynObVstktcnCKXPmBATnCkJZFPDZt3rt3OrDFh2B5+YWqG93IGKNJLDXxCV
         Ilvw==
X-Gm-Message-State: AOJu0YyrT7eulTw4CqDumDaSW8xEWcn+rSiFC5IJUxcfoOK77wr+ji6K
	CaUINr0ZFljSYrvzgMgwY94kiBe/7waewEfTAGn1gWAq66+tU4OXLxZPIQ5uAysZ3JcNgD0Wb/h
	9DBd0nDc=
X-Gm-Gg: AR+sD12VBEkNtaJYhmxSzfQZ7JB93LemMkNHBJZjW3Fxq3Pq2etd9ZSrviEgJNKvJIP
	Nn5+dG4CHGeCmHPJPphDTsyeQJnOOidyujvnTE0i4Hszk540I10V3q2kPqvzr/XKyq8IJoWOgfZ
	VqxbnPdxz10ZI65ozHgY27loJodE3j7sNagOSolTjPwFBcMRZWoLWw9LoymCy6RSQvfbOjmekvO
	Uubyvjv2DaVytjBIbB1MMfyz/xRQy+XJwaAsGaZBkUtRw4kZJAEplfs1cVCMSb093UDaJDiknKu
	3/KK7R77y+1g2e8shpDQyucTsGKTX5B3yvp5hrs/RIVqFoP7fn6FM9VUdGD6pW9ogJfWhggfnVx
	BSOoGj2oyTQOn/rrFRKHK5RQ5zFcnCRUl3zbVz+er01O5rxDgfONZLcDmKp1h0Q4eFMHQBmCrXt
	Jsj/Nc0+86pr2HzM3LL6jbgcG6BFcFTK7uckjoeGz2dzx6dmSyLJWskFzwFIjDbA7R
X-Received: by 2002:a05:6000:26c9:b0:47f:93fc:2d24 with SMTP id ffacd0b85a97d-47fb1ecdecfmr3618752f8f.32.1785254384929;
        Tue, 28 Jul 2026 08:59:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6acb5fdsm201549f8f.12.2026.07.28.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:59:44 -0700 (PDT)
Message-ID: <d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 0/3] closefrom/close_range:
 protect every pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 16:59:43 +0100
In-Reply-To: <18C67ECA93F98D2F.1643407@lists.yoctoproject.org>
References: <20260718043750.7-1-bbnpreetsingh@gmail.com>
			 <20260728050815.7-1-bbnpreetsingh@gmail.com>
		 <18C6660077364169.3010641@lists.yoctoproject.org>
	 <18C67ECA93F98D2F.1643407@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 15:59:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4560

On Tue, 2026-07-28 at 16:48 +0100, Richard Purdie via lists.yoctoproject.or=
g wrote:
> On Tue, 2026-07-28 at 09:14 +0100, Richard Purdie via
> lists.yoctoproject.org wrote:
> > Hi Baban,
> >=20
> > On Tue, 2026-07-28 at 05:08 +0000, Babanpreet Singh wrote:
> > > A gentle ping on this series and the close_range v2 it stacks on
> > > (which Richard okayed on-list on 16 Jul).
> > >=20
> > > I noticed pseudo master has moved since (now ca47829, with the
> > > memory-handling and openat2 changes). I've checked that both series
> > > still apply cleanly on top of current master, so no rebase is
> > > needed.
> > > Happy to rebase and resend anyway if that's more convenient.
> >=20
> > Sorry, we haven't forgotten about this, we even did discuss it
> > briefly
> > yesterday! Mark has struggled for time and I've been juggling a few
> > other issues.
> >=20
> > There were a few fixes ahead of yours in the queue, I have those
> > merged
> > as you mentioned. We then have yours and the logging fixes along with
> > some tests Mark worked on which are next.
> >=20
> > I've pushed your changes onto master-next where there were some minor
> > conflicts with other changes. I'll run some wider tests on the
> > resulting branch.
>=20
> Further testing showed the problems came back so I think I messed up
> the testing somewhere along the way, sorry :/. I'm pretty sure the
> close_range() implementation is the point things break so there must be
> some subtle issue in that code...
>=20
> I'd suggest we reorder the patches and get the skip fds and drop the
> prefix fd patches merged/queued, then come back to how to get
> close_range working. I still thing one common op codepath for both
> cases makes the most sense.

I think the missing piece is this:

diff --git a/pseudo_client.c b/pseudo_client.c
index ca37a80..a1c7052 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1633,7 +1633,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
                }
        }
=20
-       if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op=
 !=3D OP_CLOSEFROM && op !=3D OP_DUP
+       if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op=
 !=3D OP_CLOSEFROM && op !=3D OP_CLOSE_RANGE && op !=3D OP_DUP
                        && pseudo_client_ignore_path_chroot(path, 0)) {
                if (op =3D=3D OP_OPEN) {
                        /* Sanitise the path to have no trailing slash as t=
his is convention in the database */

Cheers,

Richard

