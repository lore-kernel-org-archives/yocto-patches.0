Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBECCA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:09:37 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11693.1790946574660195532
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 06:09:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XskuVqQc;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.141, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso338275e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790946573; x=1791551373; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PwjxyrNNgd6onzccARs3P87qJjozFcZ9c9zu5uXCCGI=;
        b=XskuVqQcbWjQmE5QNELijifxtcD92vOClFZRS/oItQPI8n5N2HzYj/mdTJNiD+5mxw
         /EpHZ2NzEeO8NowpJqB5dgUgL/p6TL1CMLaN27Tbkx2eV0K0Uhj+Q1USHmNbu0Jngs85
         kgfopDAlxpxAE7M8ph/zNqcOxIozce/H2gWhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946573; x=1791551373;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwjxyrNNgd6onzccARs3P87qJjozFcZ9c9zu5uXCCGI=;
        b=WvOI4O7QT9KOVzQvAP8qbGy5RGudSWmAnjrdctDQ7Z3/14kNSTN1BvD8Gyh7cblnVV
         wiV3/lxx5rpjNCasZcMCsPeIuuQx1bVClqMMrTotCZXQ1YBxiNVutyHyo3RlVKHTZszp
         tu8N+OPKRW6uJDQ+iltRKLo93up/OmSFP/FA0ipjfNs9xTwQb5kIlFDcGy6LkTOZOZXz
         QfhMRTckwV54maMiuXWghoQkCT4srAqSwZ2D3GjdZhsDAmEvq3UE/LuPpi+5pPqziZpB
         XgrmGzQyJHf8fSqjGJiDtTwliXT7ilBFGk55XcpcBof8XE9eiXDpA4FL5r9+iUisdi3F
         Y2RQ==
X-Gm-Message-State: AFuF++nD3aM6QgY4j+SaYu99TrjBOc8Tbb93DsbsL5nQuF7lrHuOyh7S
	67XqxZku1jwShDim4hPKtdJIvdhDfnnREI+Shzgtv0HkzmgQOooPWDy5TUxF82o8ECaFu8RbkSn
	X5wwzrJ8=
X-Gm-Gg: AYBFou1lSP0UNVshGkyDw0xm2KYYxQ3GSmLj8HWjXvWTV4lADoqkh0fMnG5Fyudtyi2
	loKwpyWnvYJ1CsfcfXHQQS3vql5s+CKtxztyZFcYzuSvpolPOjktGpKoS8Pd9dxb3lOxUeNl8mx
	XpszYzsR+fJisj+o5medY6OYe9wZ+NAuHizbQRzQmOy0OfPrk8ZHP/o7ZIRO0cFgxzz6ghCv+Gr
	7JoMaQuXc8K385fZWM+Ehxl0RJKFNfpEk5jrtQFYhBNeKYi3JhjEV9GBJSISDABZZE6xJETpiLI
	QNqdlJ7Nt3n1ZzyM9hL0lqMgrB/DNLGgieZjuhRe65Ta0Xd+Y+wVup9q/jzzfRyvsf8egww/8/N
	mDFWs5KFjlZFHj3btJEXoDM8pHMbYGCDMUY/M0sALNsVHoj/aJbVy9x+R7d84MUQgBhx+oSdC/E
	ff32cR03M8s+AjTh3vOMXkbUrLW9G6n2wdUtUhdebCEn9tSLbSvL/zUeWaS1iApUGeafkk/ly+T
	8PDJyVuPdLFCeGYXjFx0ClE/BqqBhd05S6R6iSojihIStWIyqSszRlpK4gF7D8=
X-Received: by 2002:a05:600d:82c8:b0:49f:fd66:5fec with SMTP id 5b1f17b1804b1-4a027456b72mr60890275e9.0.1790946572522;
        Fri, 02 Oct 2026 06:09:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2? ([2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380faaeesm5405323f8f.18.2026.10.02.06.09.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:09:31 -0700 (PDT)
Message-ID: <1df10f07a98c7e6d5fa13103fdcb082640979267.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH]
 getproperties: Ignore meta-mingw if it doesn't exist
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 02 Oct 2026 14:09:30 +0100
In-Reply-To: <DLUBE7BM3OE8.1FN6C7FT9U310@bootlin.com>
References: <20261001104641.1596895-1-richard.purdie@linuxfoundation.org>
	 <DLUBE7BM3OE8.1FN6C7FT9U310@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 13:09:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4979

On Fri, 2026-10-02 at 13:27 +0200, Mathieu Dubois-Briand via
lists.yoctoproject.org wrote:
> On Thu Oct 1, 2026 at 12:46 PM CEST, Richard Purdie via
> lists.yoctoproject.org wrote:
> > We moved meta-mingw from check-layers to check-layers-nightly which
> > means
> > it can sometimes be in the config but not present. It is find to
> > ignore
> > if it isn't present.
> >=20
> > The wrynose layer will be removed earlier now and never be present.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
>=20
> Hi Richard,
>=20
> Do we need to merge this also on wrynose branch?
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/85/builds/1441

Hmm, probably, yes :/

That wasn't quite my intention but that lack of graceful fallback is
catching us out and I may need to rethink it...

Cheers,

Richard

