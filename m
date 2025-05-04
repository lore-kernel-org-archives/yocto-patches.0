Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0A6C369DC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 16:22:00 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.31794.1746375711721980375
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 09:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GBoVr6PW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso33319205e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746375710; x=1746980510; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUaNyZYiioj6apaMCr4jJ3+vVHBWkLdse5+owy0RKiY=;
        b=GBoVr6PWKSCyV0oILWkcRh3irJ/mdid/aJIQTSj5D04i/M7GgX2QnAQpfSjCpJg8l4
         kETBr726YC3kyvXtxZawvGlacwHDByfTaFcMBmO2mUp8cDvdgocM24VLc6yVgUtTR8Y4
         w0aEDlUbOpSbd/fvbLVUdfFTglWRbCKe3ChIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746375710; x=1746980510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUaNyZYiioj6apaMCr4jJ3+vVHBWkLdse5+owy0RKiY=;
        b=TgVa8T6GszP3RWaiJ+SR62nYpfEyA4XVJQ3zpO2ch2EoH2zq32rX6CNF2mxkgzNisl
         zH0wNY47FJgnvWO149OZNTeAGumVNEf2po90K/jprqfNsG96FQy47Z5O25uNbse7GoiK
         Kjf/j6ycySQ9LLSu4ct6FPuq8BflfWSInHhUJ+GAYFJqvWWgfqvWJf7qPVuvrDjVknx6
         1iHPHK+RMwrjEfh9JwCacgJo53rwq1jD9G+LLj25aP1uzn/Qwa7Q2W9UudYGBGeaWnHI
         Qa9yLyVLvIJv5+IMzuPNT9avMx0H3gI0CCHddmtufFH9Dmp/b/yZNW7Re7Njj0WQyV/c
         Wq+w==
X-Forwarded-Encrypted: i=1; AJvYcCWxXsizbpaK4F2RSxCWsN1dv9SA4zfHiX+UxikODc6TS1oEwnNo3shD9ayQvXfE86ClodPshFS9Zq7QtKvb@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Ywg8vXo4kIApVeklV56Wl5nkDXzyXczyaKK01x9p2WiDx2SKeh8
	8sBEvbHsNQ3H+Rp1R1tOhR+0k8y4GgDr94rPmgtLFyOfMo41OHfLcOcIHx3xTCc=
X-Gm-Gg: ASbGncvVXjw/jVErs8UGVPVrNzyGSYEWctR0eCXNSWxnymytdD1Lw83F+8jcpcf8lHw
	vc8vLN8TLNA8J9PMt+0sbt3c5lepMX8nBYmWczLyiK/KUkDNmtLjLTb25s4aiPERYn/UKrYUG7a
	ExaicuQrjG07MVEgBSC09QgTzdhhItQSmdGfrOGZhgYQa8qDg+j1p01V6lqhAZe4NSWBF+08xyc
	1ihH1/q68/+YOhRSrUUl7RPxV+RglwyFRNoXPzCfkJ524UyG12mpgyaq+Nl2AOrLBK23fD8uu71
	2Q+Emuenc4OJGy9ZD//UjOdSD1VMXwamsDaBcJUFBqzGFBtdU9eJigxBp8NCTb0bmKLs7yJ416K
	WJGZ7t/GyX0e5fZpTzimT3dxOQF61Ig==
X-Google-Smtp-Source: AGHT+IEMmrAk5d5JDoAuYjhw6w7uEkLVBGBA4C1xlSqpGan4e1V9Hz0wgfZr2/uuNm7qD30RSid/FQ==
X-Received: by 2002:a05:600c:8711:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-441c48bb346mr31193875e9.8.1746375709926;
        Sun, 04 May 2025 09:21:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:994e:224d:4a8f:bee7? ([2001:8b0:aba:5f3c:994e:224d:4a8f:bee7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28082sm150517265e9.34.2025.05.04.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 09:21:48 -0700 (PDT)
Message-ID: <4f9145279f66fd87b7ac33c8eb73ce4fb633a5a4.camel@linuxfoundation.org>
Subject: Re: [pseudo][PATCH v3 0/3] nftw, ftw: add wrappers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, 
	yocto-patches@lists.yoctoproject.org
Cc: skandigraun@gmail.com, landervanloock@gmail.com, fntoth@gmail.com
Date: Sun, 04 May 2025 17:21:47 +0100
In-Reply-To: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 16:22:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1488

On Sat, 2025-05-03 at 14:59 -0500, Mark Hatle wrote:
> From: Mark Hatle <mark.hatle@amd.com>
>=20
> Note in this set patch 3/3 does not work yet.=C2=A0 The test cases need
> more work.
>=20
>=20
> v3:
> Rework from Mark Hatle
>=20
> Split the ftw/ftw64 -> nftw/nftw64 change from the rest
> Rework the integration around the nftw* wrappers
> Respond to comments from Gyorgy
>=20
> v2:
> Rework from Gyorgy Sarvari
>=20
> Gyorgy Sarvari via lists.yoctoproject.org (2):
> =C2=A0 nftw, nftw64: add wrapper
> =C2=A0 ftw, nftw, ftw64 and nftw64: add tests
>=20
> Mark Hatle (1):
> =C2=A0 Move ftw and ftw64 to calling ntfw and nftw64

FWIW I put the first two patches through a build on the autobuilder
applied to pseudo and I didn't see any issue.

Cheers,

Richard

