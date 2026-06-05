Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A851CD6E5D
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 11:06:18 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5930.1780657567877251743
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 04:06:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ypJfYbia;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso9397115e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780657566; x=1781262366; darn=lists.yoctoproject.org;
        h=in-reply-to:references:cc:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7DO9cYQ99KsAI0qeKoy9G1DPTusv0HU77m1Z8RHV8Q=;
        b=ypJfYbiaAqJTNH/4G2w9u5r8xAyxVppv16yjPQxc/0PS3ZBTMSHyIi5YXjeh7d7AP6
         DDRljeRgnpcbRkRhDjsR5CkRR08oxkwXM7G0v7zKpQCA/BxJ3MIWDCRC5Sq+d3jWzu7Q
         Tu5M7XuG9z0IDW8YyIKT7jfBB03YosPn670/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657566; x=1781262366;
        h=in-reply-to:references:cc:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7DO9cYQ99KsAI0qeKoy9G1DPTusv0HU77m1Z8RHV8Q=;
        b=BG2NvQnNkFztKRUWDDR0Ud+Hw/4DdtR6xl8VRMZOk31Ivr6OyTq6ysrpvynT9j3sNH
         l643wpLaHoC7tgtJKnxWk2qTZTIsBk6O2ubGrvQ9AKSMTbGaxpeSTQbz/X6kA8b7jcAC
         1mqnd6Pt96sJampNsjYXOsuFcTWc3K8HbK7uE9QzVzewPOqYhIHTmJEWK5NafBw4iWGg
         DjbEmrbIA7bOB2qtNhEraqoOg/wQi1VPja8+mGO40ZJQvwIvB+PRUe7zgWs6yRPhyhUK
         sL8mfX7pzZmBQkYH2QCVQkHW2YzRNwZh03VbxWbvizDM1PIs5fKB6N+tFsOfi81Bna3g
         AmnQ==
X-Gm-Message-State: AOJu0YxY9A3JoX7JogYigD+X2ne4PwBYkkpbXT0h3/evE9zA2TYIuiL1
	bklsiXq3g/QSGFVsr2OYE33GEPL5eKesmhjDiFmyGYGvWO243RvHNTPMAeUAUFP9wyEQ807XjOG
	CB/7r
X-Gm-Gg: Acq92OGLevxgFfNU1dB1IcC3fBzPmt9rGvX3vHi08ymVEX3POKAM17NAcHcJz4QlSRK
	dyIAWW0CXZ5pTc4X/6poCPUwfjgO5QA0pdq8Rxkr5aP8Af8DoqwGo5M71jXcplos5iigbI0HYiP
	QbYA3JiK8jguYzXYR4a++AbQT7e2+mvJG4JpOiZtMX5dG+gwz1pEjwHDgBYcRYXn6KmnQPbp5ML
	xGCTOa+yObQbI8mwvoIiHw9LUHptHgck+KMM2TTccaB+ONCKL2UVBkwLq4PpLOxWAn4JIuPmDRx
	SlTg8HXwBMwiHm7XVKgttQlXxWw6ToBQ21VI32i7pwdvkgrQx+Q2nYM7z24W4lTlbQ8s4ft+5/a
	LLJ4DTltQvBVQEwh6OV/1aBNnGuphrQ7SLBlYaQXgQSghYnXVimXBDxig8hD1rR7mbXqDAgYAWH
	xybqK+oIWurtRGJiRtgwfUFDbg4J3nXV0hlOGPMm9gRsrnXpIAKgLXne+3smTraP4gJ3rcJ1Yjt
	tq0jL6h1pwWofhJLT9olvw9VGAvAjP1Gc8WIA==
X-Received: by 2002:a05:600c:a088:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-490c25f9100mr46730135e9.24.1780657566147;
        Fri, 05 Jun 2026 04:06:06 -0700 (PDT)
Received: from localhost (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918d7sm133217365e9.2.2026.06.05.04.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 04:06:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 13:06:05 +0200
Message-Id: <DJ12FCFXAMWO.2G9Y2U06OJIYR@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] schedulers: add
 missing wrynose branch selectors
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Mathieu
 Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.20.0
References: <20260605-mathieu-wrynose-branches-v1-1-a18888aab77f@bootlin.com>
In-Reply-To: <20260605-mathieu-wrynose-branches-v1-1-a18888aab77f@bootlin.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 11:06:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4146

On Fri Jun 5, 2026 at 9:58 AM CEST, Mathieu Dubois-Briand via lists.yoctopr=
oject.org wrote:
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  schedulers.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/schedulers.py b/schedulers.py
> index 67fdd39d8f88..78e057bc3365 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -74,6 +74,14 @@ branchdefaults =3D {
>      'wrynose': {
>          'branch': 'wrynose',
>          'branch_bitbake': '2.18',
> +        'branch_meta-arm': 'wrynose',
> +        'branch_meta-aws': 'wrynose',
> +        'branch_meta-clang': 'wrynose',
> +        'branch_meta-exein': 'wrynose',
> +        'branch_meta-qcom': 'wrynose',
> +        'branch_meta-risc': 'wrynose',
> +        'branch_meta-ti': 'wrynose',
> +        'branch_meta-virtualization': 'wrynose',
>          'branch_meta-yocto': 'wrynose',
>          'branch_oecore': 'wrynose',
>          'branch_yocto-docs': 'wrynose',
>
> ---

Thanks Mathieu,

I've been meaning to do that but last time I've looked most repos did
not had the wrynose branches.

> base-commit: a999d97e0aab0059ee6dd25432740660511e6db2
> change-id: 20260605-mathieu-wrynose-branches-358054f6f3d0
>
> Best regards,


--=20
Yoann Congal
Smile ECS


