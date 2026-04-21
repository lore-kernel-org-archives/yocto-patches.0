Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEEEF8FA9D
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 16:56:07 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39046.1776790566274350256
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 09:56:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=i24xa9s3;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8e895b9e7cbso427821785a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776790565; x=1777395365; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tPXeCiiV4VhTILAoC6upuETdnk54tx3a1xO4zyLc7s=;
        b=i24xa9s3Ovfvrt8+7iZY+IDfKe2iE//zBx7GlTKLRQ2ZtMUhGxiLBJHNzIegTOQv2G
         3q1i1bbvguohVtpoyNQzSuBH9KDzURFsIuMh4WuGNgrw7A5JvaPStXeqKnZGMmuCeNeW
         FnEGgjNMga+9AvNWUTcfRA5kPmkuZf1XRm88Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790565; x=1777395365;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tPXeCiiV4VhTILAoC6upuETdnk54tx3a1xO4zyLc7s=;
        b=M0iyC8/6BuVg4Cs1i5xfFRpck+TQTrlj6Iem0OxAopI7CJi5sJCThDHH8y6iWH61UI
         +DVij2xrua0H+yksMjDKPqfypgS9mQti9nG81aWE71WCw0z75CvMeokxLTQMd/yw6jpe
         ZvTvQOMRsGoVbHUH8lravRgCX+krDzXSsghczSIjG/m1/DE7lbGtEuLypJXbLB+F3j7l
         TXBhgBj+V0njFWC4BIrD8v/Lr+s6Evf5Sgow+iVyHAebny2ma2468c5lCvlt1NudBf30
         H2AwRX9ACjIwNP/3tVZc+7eRskanNxWfBbAq0XYtR1IhNnePaDo9qL8/x6BJVJEYYhag
         83AQ==
X-Gm-Message-State: AOJu0Yz48nQuUikuqYvZ3z5A4EqHUcbrxlt+ceTP65a0w5xpeoag4Vfa
	K+fC23o+o3z82xZ6FrtEm+OhdqyZdjvIT/iI5lPUHnduSRPkkpiILa0MK8E53aPyq+GwZcO6drq
	0H5vl
X-Gm-Gg: AeBDietYXpeCEhDKZG5RLyJEpc14lVZ1rq6nLZ5Wg6T+DSh18qnLMhztmL9vxkDb+iT
	ual8MAlbRGjJycziJyHkD5/jRcT2ltD1xtYCOekxUwdSVlRrS8L7HGBKATs8mK53xJLE9bPgFCi
	2uyPaNMvbzrzgCqV4OJvMJUJebqITIVzpWAXPTnSDo9yShYRayvi6Iqwmc/zJLeES5lOGfsq0Ib
	+TkxQzSoAOGNcEUHbZa2PZIkuVu1ELWILq+nj8fOyxfeHS2e8w5Md8XHL/a50Ltd1RGnoD7ykPA
	OGWO6ADmUrN7u9zxOD50mVsYkUv15xYCzpWZM/vVSWPaocQNprF4MSYnARXv6e1qQnP3DwTiARF
	YxxwIE/EwyOETYvWYLE/Y3oRCB6qUu5RD7x8ta1j2ihxRb2g2JzkoMbicTiJVMOjzPRCSEEBdsX
	I4l8hINBIFMMI7fQkLd1Gf+IhSDe0gHdUgPcyu7raZ7ojZDvtRzrUWffNa9fczW63bI65ktIugj
	EipeziidZzUMPSmQ7nqJTFc4d/CCfr+4b5i83icGWVBF99tg5Bf6cQxMQ==
X-Received: by 2002:a05:620a:472c:b0:8da:384b:9545 with SMTP id af79cd13be357-8e78f24dfedmr2703959085a.12.1776790564876;
        Tue, 21 Apr 2026 09:56:04 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d98c15a9sm1250961285a.43.2026.04.21.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:56:04 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:55:49 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <marta.rybczynska@ygreky.com>, rybczynska@gmail.com
Subject: Re: [yocto-patches] [meta-security][PATCH] README: update CI links
In-Reply-To: <20260421054133.16448-1-marta.rybczynska@ygreky.com>
Message-ID: <56844543-bc13-4e12-1f02-db96b1718dff@konsulko.com>
References: <20260421054133.16448-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 16:56:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3749

On Tue, 21 Apr 2026, Marta Rybczynska via lists.yoctoproject.org wrote:

> Update CI links for meta-security
>
> Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>

LGTM!

Scott


> ---
>  README.md | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/README.md b/README.md
> index dae5aad..c92d3f2 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,7 +1,5 @@
> -Master-next:
> -[![pipeline status](https://gitlab.com/akuster/meta-security/badges/master-next/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master-next)
> -
> -Master: [![pipeline status](https://gitlab.com/akuster/meta-security/badges/master/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master)
> +Master-next: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
> +Master: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
>
>  Meta-security
>  =============
>

