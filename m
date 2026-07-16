Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E975CC44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:47:00 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10121.1784198810479727474
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 03:46:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QqQv38Qk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-472326ca506so5259748f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784198809; x=1784803609; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZM7+fCMyQlxc0beEtf0h40FcROLiKa8xJapGby75Q+w=;
        b=QqQv38QkZl8dBt8SYFXDj3Ji/318GXQCRwxYczdDncHsxXtEhug0ToRV2dmngbIlu9
         ob4nT7dLmGbzUFs5c7LWiHh3CkmNMgyUMFC3jzWSOJZr+0/NPYjBSi+2jV2F8k45Gpyu
         wCqm7iPK1tTzbPLY8vhNdU4DY4pDomLleiQFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198809; x=1784803609;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZM7+fCMyQlxc0beEtf0h40FcROLiKa8xJapGby75Q+w=;
        b=ZEmSoFNoS6N8VJT4+kBzgFhSI6Etjmnvol0CcbfynjqHUNcqZGe34KJlXsy73ihQu6
         +PxxQs4nEdkcfwX7/vv0YbQBrQQR8ZGKHH+i1h7KpPsc3d3GcYv5gXYZKQ0mrSKUmUK4
         FLr8h5/W5DvtBhlWLGGKLEEw3VyI6Xk9WacK1RrnoZEizUISTMNry49ZXndhYh8AGMWC
         rKpKUKQRKyLGljgMtyVod8+Ydgmpeb+3aLXA4V6SAyGFc+WFrWuf8Nc1qWqYBNT3DgX/
         vWA3Ms35TUSqGLdMgv3nUGQrCJ5EF7DKQmdJ+wFmFuefo9njRB5XO0xSHaZkXXqCgsf7
         vYkg==
X-Forwarded-Encrypted: i=1; AHgh+RrrLx7Fljqs4F99HlNF7ThjIHDkXL1aHMa6LDfDDsLryEzo6xo3dnupHLn5HL56x5NuxbCln+TIYQalpUfv@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxmVrcM88rApC//2sHjJvl/bQkNx/wup/ZVGakQF6hKg/agTdES
	gWdMrSOnB9L1XIkbuG7uxdhSKefErtfX4gS1lgWKUkMWaxs3CHPX37iTQ5eg15T0g3E=
X-Gm-Gg: AfdE7clQ8TAXFY7Ip+VxlEeUekuNMF+OK5/ZZLunm/tBy1DT27swW7M53CVGA9/FRE8
	hglgDjJJyrK1hZ8S+/8Q+iDKL018vpj8ed2VRWgk7K4syvm6rkXbeBhDEbDmqo5r0yKsW1NhHzE
	CdoNEtLt9mlnE4qVJv/fNpt5mgGG3/Bjl+gjja/aWaiP2uNyTAYd5QyYFPNr8tRvk72aQe9m4rs
	eWZ1B71Cs1PE42pMKpyXOa+R5vT0vjn7M4h1gevvzXvCvu+Oaj1W2KFBe+PFmH01BW1XqiuX/FF
	eJPcYpQuxQJMrjOUpfLQFgCsO0NxhN+g1OKAYLEKxXKS+FR2XysCjTBKX8+wRyGftCaM/yITugM
	z7asbMZvLbeabrGsJuq0Nsl7hmc9RXUK2pyWLpDoyJF1XJ0wYaxJXnCCa2WE272rQ20dkHhWldt
	rOmv2FTBjndGh9SK7XH7nVRWGyfG0dioh26saVC+nqB64Womf1V5UUEP7qsOsLn2j2IDY=
X-Received: by 2002:a05:600c:4fc4:b0:495:4505:daca with SMTP id 5b1f17b1804b1-4954505dc97mr10494595e9.9.1784198808672;
        Thu, 16 Jul 2026 03:46:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a03c:6417:d88d:c21a? ([2001:8b0:aba:5f3c:a03c:6417:d88d:c21a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9425asm80455505e9.11.2026.07.16.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:46:48 -0700 (PDT)
Message-ID: <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH v2 0/2] close_range: implement it rather than
 return ENOSYS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>, Mark Hatle <mark.hatle@amd.com>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert
 <mail@vincent-haupert.de>, Mark Hatle	 <mark.hatle@kernel.crashing.org>
Date: Thu, 16 Jul 2026 11:46:46 +0100
In-Reply-To: <20260716055633.7-1-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
	 <20260716055633.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 10:47:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4494

On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:
> pseudo's close_range() wrapper has returned ENOSYS unconditionally since
> 35433e6 ("ports/linux/guts: Add close_range wrapper for glibc 2.34").
> systemd v260 deleted its /proc/self/fd fallback and treats a failure as
> fatal, so under pseudo every fork+exec dies. That is [YOCTO #16339]. Full
> story in v1:
>=20
> =C2=A0 https://lore.kernel.org/yocto-patches/20260715054142.7-1-bbnpreets=
ingh@gmail.com/

I had a quick look through this and it looks ok to me, thanks!

> The v1 question about OP_CLOSEFROM stepping around five of pseudo's
> descriptors while others exist (pseudo_prefix_dir_fd, pseudo_pwd_lck_fd,
> pseudo_util_evlog_fd) still stands; happy to send a follow-up if that lis=
t
> is short in both places.

I had a quick look and yes, we should really be protecting these too.

That said, I couldn't see what pseudo_prefix_dir_fd actually helps with
and I couldn't see why we need that...

Cheers,

Richard

