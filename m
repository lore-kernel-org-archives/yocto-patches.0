Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E36810F6FD9
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 16:06:14 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17104.1775059571264797554
 for <Yocto-Patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 09:06:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=HcE6R9iN;
 spf=pass (domain: smile.fr, ip: 209.85.218.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so151281866b.0
        for <Yocto-Patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775059569; x=1775664369; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y78oO6H9nDdsg+ahMt8LOoIloaIvVdXsNIEudalhmeA=;
        b=HcE6R9iN2GId3U4DkCu4Wkma/LLxrrgDLqboKgw+evMxbRfXnj16znyXn43QIs21tE
         5B50SoJ5M5NI+KqVj0uw7woUFmr1L5Pw+jFA24Ve8Xj6hbJZ1B5RERNuu1kh5Cqt9Lz3
         /9IyTRRKf5Fr5VWffpruHc+LngYNAZctR2kNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059569; x=1775664369;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y78oO6H9nDdsg+ahMt8LOoIloaIvVdXsNIEudalhmeA=;
        b=RupuAuM8JmWm5J+jRyOWEN7ryF2nunhjGl21CIrQk4bP4EvHUY62JlV45d/q/jmWct
         vTgyMnEKmEnP1JxNO1zfvydSKXsILhmt0TZ7eWCV6sayn8WbSKc5nILPADbAc4agorOh
         SmlchcM76HuJiwj8uEUXoG8w0JEdus5jZYe0OEjwmZ/a1KFmnH79tzaYDBqTNXltwKsE
         4Hol3eGJ/efUE0uoWxzAD00D5bHhK9UHK4fZZ1f0ZLRjzsMq5I7dtrMmJdlOP921u8HJ
         qgRVf9aZ4RtOGNBrjMl3P5kEZrHyuwhfUUETghLDgx+bTvPtG5Ae4+CQZp0Y3YI+eaqr
         rEnA==
X-Gm-Message-State: AOJu0Yz57Kx/nKxooS4zPvxASsVn0D/N9/Uzwwgte2InYEpuEH0ESzb/
	qScFbHcQaGcfMlQqtU49DtFIysSTwKr5bVcfh1zgKTgTkc4yeKGoJfpqpOilfcicrIs=
X-Gm-Gg: ATEYQzw2FcoBONqSV+dC0EzVb+portdTmemG50VjvONrE+ohkwBFEw2iwgnPiLuCu4i
	TKqkHI4asLshteptsVywSOEQYiw2sRE6UmSJseZPo+JRM/VxIBBB7QwbF7MTdJLL+hz3TdSu8WM
	R7TImThIXpsnJD0lVRF1e62JLMCOT7PXF5c+2a0jphOkMtfnk+KcA1DBIxruViMU5hSRvTDPYD5
	eJWdcyXltr3GKyhDFp/b+eVt7QcUWOTQVu5j+XqdWCvEd/irJK0nJv0ttx4VlaQvgKCai75RuAV
	YzWUr0rIi4qX99squLvQDO79wrY9R1YgefVXGvmXrc892lXFhQc8v8a9Sk0l8lVrMrX5jgEbj8r
	1eNuP/H1r/SMOy3jecZhymvB/VwOERRM1YvJO+wnPr1Lo24u/jsgUGOMlaxouSXmGkmorTrewRm
	Skz/CK7RMRNgHdqey9abLC0iMFMIKJDcrF5Bsx72kWhR06lYTjq6rSTnJ2CmmD7KdKugc7lkVEB
	cc4CtKx7vjS0A==
X-Received: by 2002:a17:907:bd83:b0:b96:f9c9:9d2b with SMTP id a640c23a62f3a-b9c137b7972mr261201466b.8.1775059569422;
        Wed, 01 Apr 2026 09:06:09 -0700 (PDT)
Received: from localhost (2a02-8440-3504-429d-f401-561d-2d69-b702.rev.sfr.net. [2a02:8440:3504:429d:f401:561d:2d69:b702])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c9722a9sm3195366b.3.2026.04.01.09.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:06:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 18:06:07 +0200
Message-Id: <DHHY3NWNG309.2TRRWPJTSE5N3@smile.fr>
Subject: Re: [yocto-patches] [PATCH] patch-status: Fixed typo in some h3
 titles
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Yanis BINARD" <yanis.binard@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>,
 <Yocto-Patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260401145614.274137-2-yanis.binard@smile.fr>
In-Reply-To: <20260401145614.274137-2-yanis.binard@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 16:06:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3597

On Wed Apr 1, 2026 at 4:56 PM CEST, Yanis Brd via lists.yoctoproject.org wr=
ote:
> From: Yanis BINARD <yanis.binard@smile.fr>
>
> From: Yanis BINARD <yanis.binard@smile.fr>
>
> Signed-off-by: Yanis BINARD <yanis.binard@smile.fr>
> ---

Hello Yanis,

(Following a discussion at Smile)
I forgot to tell you that this patch should be tagged
[yocto-metrics-meta-oe] in the mail subject.

To the reviewer: this is a patch for=20
https://git.yoctoproject.org/yocto-metrics-meta-oe/

>  patch-status/index.html | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/patch-status/index.html b/patch-status/index.html
> index 071bb1b7..cdd89e6e 100644
> --- a/patch-status/index.html
> +++ b/patch-status/index.html
> @@ -95,7 +95,7 @@ SPDX-License-Identifier: MIT
>      </section>
> =20
>      <section>
> -      <h3>Patch Upstream-Status Counts (meta-openemebedded)</h3>
> +      <h3>Patch Upstream-Status Counts (meta-openembedded)</h3>
>        <div id=3D"upstream_status_chart" style=3D"height:400px;"></div>
>      </section>
> =20
> @@ -105,7 +105,7 @@ SPDX-License-Identifier: MIT
>      </section>
> =20
>      <section>
> -      <h3>Recipe Count (meta-openemebedded)</h3>
> +      <h3>Recipe Count (meta-openembedded)</h3>
>        <div id=3D"recipe_chart" style=3D"height:400px;"></div>
>      </section>
> =20
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3596): https://lists.yoctoproject.org/g/yocto-patches=
/message/3596
> Mute This Topic: https://lists.yoctoproject.org/mt/118617416/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS


