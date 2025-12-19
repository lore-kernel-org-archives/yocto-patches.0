Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201EDD7877B
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 13:50:20 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17079.1766152210140736001
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 05:50:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eiJiItlV;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed82ee9e57so22364231cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766152208; x=1766757008; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV42/aO/pjJ3T+5KQ4sc+hzYI9DZaC7jaZ4RXw1ifRk=;
        b=eiJiItlVOx51KVY/o5hv97UsuvRqfIPpA/mMrYhqg0hvAy4M166jeAOFrvUpveo3kR
         r+3MELfzyc02lchBIV3FpQiVF1tY7x5+7pQ0zB6Hk71+wNdAj+B6xRVC0h0aawNk5Ksz
         7o0Zu8o1oT/1y9E0MgWDFDuG4nsCaVyCpGNf2W21SPW+OHCGYz4iMzWiiihCnmji0n99
         9usn9iRpKXkYMk4yJTs8rAlgqVhkyMltVTXJPm6ufWUp6or6QIJ81SFMne3hLWDd4CHS
         itdxuFqChMn6i6pwoQl+pHlg81t+2CnDCusTV/6XVYEWo0ktwsK3nmGnMOcJoeSaM0HQ
         x+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766152208; x=1766757008;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JV42/aO/pjJ3T+5KQ4sc+hzYI9DZaC7jaZ4RXw1ifRk=;
        b=BCHycEO0kZL9jCmF28gcICrLyU3vAPmw5EpuPgkmTS6BZDrkUUJPAW8eE58w1YGyIY
         xa8S1mCNKVXDpDZVcPWU3fSsRAMvMsb0P8y9tHGQOI4f++hNNlsB9jh445UNkX2MtRs1
         pG4kK36IYa365vI3zOyz5YjQ7phlN4pMHCy+ki16M+zQCFp6CPuYGqQ3y7rUlU1TpUFS
         /LBQpaLcbZ41OyPrVqmjjlILLHUWoaaJsQgdanbuShv6OheXawfDfyCQ1gjD9iVTekp6
         DeVexODGGyZ+axXvmUPVO61KNwYg1kFq0etEIa9kScdNP6giKRTEv2nkGsy9pOKPORHA
         GtNw==
X-Gm-Message-State: AOJu0YwzLyoG2uPBIRQwNp1GhVHfePmkjb9FTe0HFe5k8kxFVKbRQ7b+
	OO/YdqqpWy2M+eEHxK8PXCIQr3E5IoDtqeYPiEzorzhPJ4vZsiTFjaWRJ2ocJA==
X-Gm-Gg: AY/fxX5piqUFrNrQ1VQfMNUF8DMk0sy2KDqsNU+5lNyV7RR/Jwk6TQxsZJLEM7QqPHm
	jgw6V2OCyvnRtUwux5/4mxHE+Ysu8quFSSPwOKAj7o1s7KDNMJT/+PSWf3c8lgW+TnYrRlWxyfy
	3ys7UWtdpW0sRCIy1m7YorYghkvs/ad+ko/6BWhjUAbuKgJD34TUw07W1QZzBIoz5ZBM8Ojr7Qm
	SZhakJXoKxMsXRzLLDdmsz/yZiDFYRi78TFKsg2sE6EaaGIGvFaWXSsLq5elp+L8TA/mCPSI0pO
	7QPNqsjeFJv93v0+UM+N7wVjX3HogRDY1vg7NUVvpLeyCGEOjnALXysYeegFQpAvqsBSLJctnK4
	KgUDNO15o12f0bhoeRi5QijbBTfEF2k7f+SqaT6uqnttSlt92FDmsZpN+beF1LNQgquR7PerfLn
	vjFSsiOudaqAZn3DC1Z1tjaytlpHxUK9gBEPqG+tXa6BQZpRDY
X-Google-Smtp-Source: AGHT+IFoO8z07/08wQsriQN98HPyd2qpj1bOpWrVmkzN+a06lSHTHl4TPsmNqxi/tCkwdWOYXOo/pQ==
X-Received: by 2002:a05:622a:1927:b0:4ee:19f2:9f1b with SMTP id d75a77b69052e-4f4abd0fc02mr36190071cf.37.1766152208484;
        Fri, 19 Dec 2025 05:50:08 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ada77sm19163266d6.37.2025.12.19.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:50:07 -0800 (PST)
Date: Fri, 19 Dec 2025 08:50:06 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] README: update patch
 submission guidelines URLs
Message-ID: <20251219135006.GA29957@localhost>
References: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218154226.25915-1-alberto.rodriguez3153@ctag.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 13:50:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2833

On Thu 2025-12-18 @ 04:42:26 PM, albertoj.rodriguez.gallego via lists.yoctoproject.org wrote:
> From: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
> 
> Signed-off-by: Alberto J Rodriguez Gallego <alberto.rodriguez3153@ctag.com>
> ---
>  README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to meta-rockchip, master branch. Thanks!

