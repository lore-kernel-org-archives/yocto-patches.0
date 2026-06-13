Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB44CD8CA8
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 07:22:43 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87132.1781335357266445212
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Jun 2026 00:22:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZaBzXwBs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4600ddc4017so1196125f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781335355; x=1781940155; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hXgRjrs9H27LEmVmiX0HVBRVk49UiwKDXbQ5KLKs4PQ=;
        b=ZaBzXwBsSgvquPs8eYAI2gb2UWFX1gkptoDoWDaED7qoFW/iIGPgDgLk+IvWFwpY0t
         pQnB/M04XQVor/cpuarEDwDXtZqVhJ7nI+dl5nambrcoA6M78SExaKxRZBBe2O8jNx2u
         rd/k5oDDZTj7h8nyM7d3Lk3G/SOsy1SIKNMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781335355; x=1781940155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXgRjrs9H27LEmVmiX0HVBRVk49UiwKDXbQ5KLKs4PQ=;
        b=Be7iY8vKR/qQWy7h/JJSa3x5BPiLs6IgrEX/wgeDxsWrwwQmsf5ojedyj5KYIO2yab
         MXNiGIxqmkXkzKj9gouKpkKfGoaKwI46iuAqtbvcAO6fBJ9uM4HaSxr71tqgBLgQkf3U
         ofwnqYBC2VHkZnbe5hur81DLMH21QSRhcjnjTb1R1GLS7WqvG0s8F7PTwpFs9dXHYWw0
         +Vw3eeRTRfLpFUYGR+pVpLWnWPAIHXlQAPZ31TTq+7bl8W9PubCd3AUjOWq57el8JxJX
         9oM6khbM5ZbWvKOR4u3sV5BTedUDN3N0YSjvWH3HKmqaV0RomKWbFHXjN9dewOmPCD/3
         C9vw==
X-Gm-Message-State: AOJu0YwC+iADV6Js2n0BCLIKYp/DklFBy7L6i4YkEjJrDw6WlzdVH54M
	kiPwbuZXh0J2MyJBfH0Fdcv8UUDwVIeEYCwAic3BfwjDV7UGRraat1la2oUIDweC9mskn5DF0lw
	Lot8N
X-Gm-Gg: Acq92OFWbfNYL7UB4SF5KS4sMYxrz9PcEQsWf8pmbsHctmj5fPsVmBcEKRSG9zcInet
	8IQ0U5QLazACj//h5d0/w0B97CQlAIRNV4rUyBskBwdPJ16VKAtIlB5LL4CsKYZRy4mdhWrff2B
	nryYUUhGIDn5kkQXgYygjNtMCuoPutVRSAssvdhp9UYiVKTh5rG1ZK5c2SM7rDZ9wTxNhLfgPkl
	pTz4jcLuLopryXCR4f/WG4+AHepNGnxLx6WaYrAcOnDtfCQjmEZxVnDIhemjNVfdwD+F5woPa1z
	pFScDWjTrETur8hC99ClkfX4ptWqyj6zSU6TwuM2Kr91aiBfUw32cE36fa3IweBm+PajHQ2Dv72
	Ggd0ztK9yUz4L1sQh06SssnqYTk2xfiVQ5cx2CdJlOocFwTw0FuJVRWpOdC3nGbIvrog1ovuZ5B
	U+W8iuEikE/FkistkG+IljH1OhZecxKNGbuvcYnqIpSiRXGbUxaLjwcwg7lxUC4aCHRHdrTgQvJ
	WFzJv6FYC0KMc5G
X-Received: by 2002:a05:6000:4a06:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-4606dbad478mr7927490f8f.23.1781335355412;
        Sat, 13 Jun 2026 00:22:35 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4437:5798:e78b:2888? ([2001:8b0:aba:5f3c:4437:5798:e78b:2888])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm12362898f8f.33.2026.06.13.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 00:22:34 -0700 (PDT)
Message-ID: <a35c0f4d636255b636b5ec1ed9b7454a513b3762.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH 1/2] schedulers:
 Drop whinlatter
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 13 Jun 2026 08:22:33 +0100
In-Reply-To: <20260611130338.484322-1-yoann.congal@smile.fr>
References: <20260611130338.484322-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 07:22:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4218

On Thu, 2026-06-11 at 15:03 +0200, Yoann Congal via
lists.yoctoproject.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> The whinlatter release is out of maintenance now, stop running
> metrics for it.
> Also, its CVE metrics count dominates the patchmetrics graph:
> https://valkyrie.yocto.io/pub/non-release/patchmetrics/
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> =C2=A0schedulers.py | 1 -
> =C2=A01 file changed, 1 deletion(-)

I'm torn on this. You'll note we still collect metrics for some of the
older releases and have done for a while after they are no longer
maintained.

There is a reason for this in that I wanted to collect data about what
happens to the CVE count after we stop maintaining them so we can see=20
before/after data...

Cheers,

Richard

