Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD9C7EE30
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 15:55:33 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.11522.1750953331476510427
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Jun 2025 08:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KodOSaPK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453066fad06so6912945e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750953329; x=1751558129; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jGCPOkFwZCWiuw9c7TA0m5BBAFMqbe/NaEj1Q+ujfI=;
        b=KodOSaPKk5rO9uslDK6m9HKkuYIxaTWrklLzD8+yNtlCctobi/qFA1Fu/Y0gOYnxS+
         +kSIJweuNKJjICdMJkfJnjgTKitwoLToUEyilAZ5dBczaPzbLe2Yt2qjhA027+LGII5O
         8JsAg6/bOV0jtcKXVhcscfimUz92R4EVZEeXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953329; x=1751558129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jGCPOkFwZCWiuw9c7TA0m5BBAFMqbe/NaEj1Q+ujfI=;
        b=JEHTFpzr7aaJ/uUPTOTHGFPK7U9xgstF+Kek3TBE00bMvXQKRuGT7xda97TRMK2H5Q
         XJiSmfWF8KfBPdIulp0LDB6dC0fXYZQ4ASRFdNXYT2sZTecSxWI7HIaMoEGHVd0YTGhJ
         OHU09pUo0L/35wyzzSBsiG5q44kSdesS6IuhYOV6gcfOXtyhmFVQH9E8zbTlqwl+Eqeh
         yvjZ2/T5NqnKprpAgZ2tJmg9ks2171PA4O+PIHA1ozn8o0qKP58IYDFroH04hDxgW4Do
         KpWGP9ZAOz6l2a//ktONhogw2YjdOxbxLEB5CHS8ji4Zc/gvbS4TbIxI49jSdCcnZ8ij
         +sFg==
X-Gm-Message-State: AOJu0YxMI2vfOL/qSYgQAdIuORxs7FyJ5g3bmA2sjl4YZQE/x8QoLzn1
	6G+zXUOFzEYPooW8xY/OHG1LLm1zefzy9y6Wfp5er5Tfkozl9tRi0Au1JOiK+94r9IKv6XGIgNo
	vLvPA
X-Gm-Gg: ASbGncvPDjUfRYKqs5KSU7R2belVoM2bnr0Kclq0vSurDIqbNnjLXq9kcKlPvHrefaG
	rt2fq3UkXKRBMnU+/uo7Dxn3NPC46MUikum5wAoWSncPuwz30BNduQ3VyFnHTsHU1nG8QLMFx8U
	myWrZC0LMOxbXGWJCsV/1sPLZkwE0QyWy3cp0cgxPbkrjSZGEqjfQDZjcG9icJs0tG6rmW1Ivnc
	aNUmvo4fpsEXtyWB9rXta+Q29c6ULSoznx7Tr3NOgEG3Jp6AA9454zrpzObBz7X1XMmLcBC5bn5
	/bNL3k1y0PXoSb7t8J7MZPsRhfo2pCwF1XJl+f3BqpMbikD1lX8YXGmML8a4UhPZ14wOWITZ7MS
	oH0cpAQ//Ks8laGvvK5y/euYWoJ4LCCZXFt6T5YPh0UQdEICns4g=
X-Google-Smtp-Source: AGHT+IHYa+iXDL8lmdzwU05o365pyb9UQh/4dLPrtsd9JJoZIhoklWDEloss8+va6DLREoYnQ2oXRA==
X-Received: by 2002:a05:600c:3155:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-453886ed61cmr41085975e9.11.1750953328924;
        Thu, 26 Jun 2025 08:55:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:50a3:2b09:3b63:a706? ([2001:8b0:aba:5f3c:50a3:2b09:3b63:a706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b6b3sm55597365e9.13.2025.06.26.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:55:28 -0700 (PDT)
Message-ID: <aa0978da7b573011914c44da2794e6b4d5e64b9f.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/1] Time to move on.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>, Scott Murray
	 <scott.murray@konsulko.com>, Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 26 Jun 2025 16:55:27 +0100
In-Reply-To: <CAApg2=TCLjAjM2Q+LASBYLm79dPW8Zioe2vBR8UiOn+mqBHBBw@mail.gmail.com>
References: <20250623202701.12590-1-akuster808@gmail.com>
	 <6e7dc22b840812a82fc74ba314826c0728786950.camel@linuxfoundation.org>
	 <CAApg2=TCLjAjM2Q+LASBYLm79dPW8Zioe2vBR8UiOn+mqBHBBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 15:55:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1701

Hi Marta,

On Thu, 2025-06-26 at 13:48 +0200, Marta Rybczynska via lists.yoctoproject.=
org wrote:
> I've been silent for a while (because we're preparing a bigger
> announcement), but volunteering to co-maintain the layer has been on
> my TODO for a while. This is the moment to do it now then.
>=20
> If there are no other people who would like to do it, I volunteer for
> this layer.
>=20
> To say it clearly, my goal would be to make it the default layer
> everyone uses.

The YP TSC did receive another maintainership proposal from Scott
Murray and whilst we haven't had a full discussion about meta-security,
I think the TSC is minded to accept Scott's proposal. That said, the
TSC believes there is plenty to be done in this space so there is
probably an opportunity for co-maintainership in some way as your
skillsets probably complement each other anyway.

My only concern from your perspective (Marta) is that you've been
extremely busy at times and I'm not sure if you have the time/
availability the maintainership could need.

I'd also add publicly, in the Tuesday call and in the TSC discussion,
it was felt that some kind of rationalisation of the layer could be
needed, particularly trying to work out how it sits relative to some of
the other layers out there. I think Scott has some ideas and would talk
about those with the layer users, as well as being open to other ideas
so I won't take that further, other than to say this is in line with
the TSC's thinking based on the information we have.

I think I (and the TSC) step back at this point and let Scott and Marta
talk, as well as any other interested parties but Scott's proposal is
attractive.

Cheers,

Richard

