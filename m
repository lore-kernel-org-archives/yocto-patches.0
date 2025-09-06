Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E6CA1012
	for <webhook@archiver.kernel.org>; Sat,  6 Sep 2025 08:59:37 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web10.4896.1757149170967627410
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Sep 2025 01:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ENiy1psn;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: dixitparmar19@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-321281431f1so501575fac.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Sep 2025 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757149170; x=1757753970; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8L9kTxzTRj6SPq+vrisaF7M/Tp76zoF6JhXmKGKnbI=;
        b=ENiy1psnve2wCOVO1961/KFfH0vtb+3YMALP81738/Wp26EGuTNO6I7z897BA0FHBp
         OhSNzX8Rah9xv2RTJY7HETivPHMYi+tHcpb5UMbBQEJP+CJDdixmE/zxv5b2lVWg2O6a
         lRkK6TTNtJ3WUhHOx9Y20NVOegVLso8Hl+T2EYT7KA3q4YkybZcSrka6lyUrSTcRg6s9
         oBIpuRJ6LExuw73zsqFPepYRnxtJDljLu+/8gUYRrpGDma1mJ+HdykjnXASm7Jww748x
         LZqD9vLlAWZOR7Pu6KITiVf/76Ze/Fuv+uDauWe8w/aAqkNYPdQ3KlP4cdoIhP2J4K9f
         gh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757149170; x=1757753970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8L9kTxzTRj6SPq+vrisaF7M/Tp76zoF6JhXmKGKnbI=;
        b=o9E9FpbkLoWtAlOMj5YBC+pzsG764QfLRN//zUAYQZLdftxeBRoWygbFRngGjjujNg
         lZkRBhfpetuR+LxQfiuWAdyfsER+EPfOAg6hU84daJBEt7nqW2bbnasLSRGWrxErgHvS
         qHuCMyJgdErBXgMaEeb6PEmkb35IbF01fbMb0QTB+PtRRF83iow69HALyh+PYiTsh+Pk
         V/NS3G4NiXbpd1OyoLtFgZRZAdW56TWg0pmbuwfi5MiClb+r0XNmDgldNe1kdzBdC1d3
         iKk+QesoTXBVj5ocQ93AHgANCmBQEbfjuRJStFvK+Rsm+AE2oGzKsdpnoGmTs+fl3Qfv
         CGTw==
X-Gm-Message-State: AOJu0Yw8xkEZgtlafOhlzgNvj8gRkZVdVpXg9NRofBqY7yAek6ecoGCz
	oafEIXLBa8zZn0kh0WTzfiWitpyZVJ59ApBhi7MGMTtMNIHlnxSPdk/cgqVhfTyWTgbYXHmfDpJ
	8m4CJ4a89huIecjaun57Y6g1ejEy5IcA=
X-Gm-Gg: ASbGncuuJTM2a3lo3P2iPghFHrD93qlEJqV0f0LXGG9HgYi5joRul9aPwLShfaH6bU4
	vsTxG/N8F3NWhenVO92EtIPHWsquD+HaueQmIJYf3yLBDgEpYepI65DrfLVjn4SU4DWr7pqYo8v
	KuKRtDCrCNIA5gQCLsYzeFJs3Hkia/gw2s1qwekCgj8Jp4g57k5xe+m85oHyOys2IJpLnX2oY5q
	0fWIpcRcjYYN2pvj23gYFmb5mLQCGuU+j2Uf9LbHg==
X-Google-Smtp-Source: AGHT+IHrU0u/Xe6RzVA5p5SPz9em7e8a388ZSUHjvPSXvFmqwIYQcoY82JagvjkmXqwSWa0N6nK7UaKmXGz1lXkgeF4=
X-Received: by 2002:a05:6870:63a0:b0:31d:8c33:59b4 with SMTP id
 586e51a60fabf-3226460b27amr588980fac.28.1757149170032; Sat, 06 Sep 2025
 01:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250815142901.1742993-1-dixitparmar19@gmail.com> <89C14622-E2D8-4A08-8D22-5C612FEE6283@arm.com>
In-Reply-To: <89C14622-E2D8-4A08-8D22-5C612FEE6283@arm.com>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 6 Sep 2025 14:29:18 +0530
X-Gm-Features: Ac12FXz6IQODZ5QsexK_unugbq1qTt3ZjiTqj6xpWg7vOTwR_Ugl1Va_AdZOrHw
Message-ID: <CAFmh=S2qWeBJ2w_FG4UZWaaAq4iNVxLbuO=qF-zHv_J8yXYt+Q@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH v6] [matchbox-panel-2] panel: added sysfs support
To: Ross Burton <Ross.Burton@arm.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Sep 2025 08:59:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2144

> There=E2=80=99s also a few places where tabs are used for indentation, so=
 please reformat consistently as it is messing up the formatting.
Can you please help me which place is messed up, I can check and
correct it. Also, what is the standard way to check it so I can follow
that everytime?
Thanks,
Dixit

