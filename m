Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50608CD5BC8
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 10:20:27 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33989.1779790818863889847
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 03:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n48V4pEj;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so114130136d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 03:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779790818; cv=none;
        d=google.com; s=arc-20240605;
        b=JsgEqDRGhgyWMen0Az9KcNOeXAw8I1KKetlZorPTVfNI/UDdR348eFso/jBrXtckjQ
         YaN0d12ouYkeLzab8Cu9TCgp7m2vlTg3b+rItcQLW77dIGUWEBkaxWvDHJGNbFPO6pS3
         91SfW01WEANC8SHxFL2Y2UDDDTQsRStnxQ2BiaXJw/8AjJosiijV83ONX4+l2U1gumSd
         vU2BSumsCn0bP9Kg/AKFWVHPI4wy1rVkbC+RTqqZV1CNkCTDGaBfR6ussE/HmDzDUGMx
         HOyvHLkml+OXBNBwTvWLzYkCAbXuW14IV5FP2h+ChIE7eSv7NADfHoDF9TsR/zVZSV8u
         Tj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Te4WTQn8QTCdLGIofX9BzFP/5hkouzU3TWvOKeYc2k=;
        fh=rf9H1FffE+gbkgV4ydZTkDFj5jA/ifIF1hTU8l4NTZE=;
        b=DGFg/zEUYxLs5dY/XgekLk/HScd3cY7P+mvYxSVlXLRvSDn1ro7+9gJdO49on1DyQc
         f0JWsfCm2/lIyWQxJELYKYeVDuKbiAdiNViIjE+rdEhZip24FIz1K69rKTyO+KwTTK4a
         op3PCKT7pHmU5bwJl9F6LQP2DGQgYlC2pesC1FTHK2zRuGexU9IucWcvhqZzx1aGIjNK
         vRpVp6+ZhPaS/YiuwCk1AowuwL/eu+3yUKKc5+TJxZU+1zExz0L5YILjJYRt2h7D6ZDr
         x0HA++Y5aLy5d6jeqIXxq2BjAB2f32BtJGzoEA5HJnjehC82uXbGWxCpF4Tc92puZxd9
         FQFA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790818; x=1780395618; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Te4WTQn8QTCdLGIofX9BzFP/5hkouzU3TWvOKeYc2k=;
        b=n48V4pEjS6MYvz8d3PQhoHhT9/uquSLiILhev5nZAlX/KDLCnW+OPovX8Ljo2SJ+ad
         L5alt3u20UXIljuKprfmGRbnz9RUVAQBX/58IpZ0HXrR3aU3JNOh5/St47eDMxbkh/0z
         94bDNGLHcarbXpcdLvP8xrx2E7hkvy7jsvRnetToxhY3qK1hu1g80yB+BL5KZ/ukK1g5
         NFeOTomXZAO6dt75QFhg0tmulACZNdvwOKbzdI34sTu0npW5oul+tkN4vsdytmLXpF8O
         80iNjUtE/PsBM135TQ82yN1oQdRaWKjiqYM7SUX8BezMmepFimKsViZ0GYvp14nLJYxu
         /yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790818; x=1780395618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Te4WTQn8QTCdLGIofX9BzFP/5hkouzU3TWvOKeYc2k=;
        b=Zvz+tzVaLE8nXFJfLtk5yQ86l/0VLemlCty7f0U+n+VFP1AWValrzOSVf5JOUB/8+R
         FVhVcXMvvdeq/a+ZlA6GhbQIopoayZ0+OfohDOxW2ShOwUJhgvjJM5AJVBODO7NNVyLD
         VrLyKnqh5uhF9Pipk4EQ+hkPpB0vhjy+mSDuxCRKF/px0a9bXaOx79QYF8ZHxF1qAWL9
         lJ9r7rTpL4x4Yr4mZztNSQyQAoG2riWv9S6qMGgm7raJLS2RzcoqTPe0ljOm/BcnO9dB
         t9cVRrvIhN4KmFmweZqyx1l876/PfD4CNRBY1JOFmx8s7IKskDH8F6WvIdB+gJMO8Roa
         yX/A==
X-Gm-Message-State: AOJu0Yx/s6+jwHLaHXbrKVrIND4MPh2bEWYX3L5m99B956KfnCJbJeSO
	b9OLHST2Z4A+HbvZlL3D59NGVZdLxoCvOLen2Ql8f16972oAuC+e/ZKWYQSpaMdqNtt7sGmbG97
	PDsA3yRj9gyWsxJPSXgtS3tG7L8CZIJk=
X-Gm-Gg: Acq92OFTe0NlGllsVxeR+fxgYBASUcPWf/sIFulfUhaFV94ztMc0TvRbWKgySDJESIh
	OVPONVceds1gFVr2tNZJkkrS1VyeZ9iif7Z2S3AlDt6nfSP29SkNVXD16w9W+mhFpihmkwLD4+h
	8dPxOr07SrAPgR8kNI9qbVN2o2qR3cqZkT6ZJzDFyQfszL0w8ng43dy/b5E2EeZDPHwHDPjGf0b
	0o/EEEUoAfXhOre+kC98eKj+jp1tO3TNqg25YKDkDvYueqPTTNbXnN+6+poJuiwyZLzVfVblv7D
	QuRDuQPEz9nrLv+DQ9vhYNuEy+Fef/8UBLapxdptvQ==
X-Received: by 2002:ad4:5d4e:0:b0:8ca:2fb7:664 with SMTP id
 6a1803df08f44-8cc7b67b729mr324720326d6.35.1779790817779; Tue, 26 May 2026
 03:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260525111845.1018725-1-daniel.turull@ericsson.com> <20260525111845.1018725-2-daniel.turull@ericsson.com>
In-Reply-To: <20260525111845.1018725-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 26 May 2026 12:20:06 +0200
X-Gm-Features: AVHnY4LFMR0MPg1lSYExmpx2zCWQQaer9jmY-AqKJ0S0RK0BJc878facUyc3SPM
Message-ID: <CANNYZj8KH+t_XV_0oyDJcKGmLtGMHUqsbTEL7EHPZ+SRU9yCNw@mail.gmail.com>
Subject: Re: [AUH] [PATCH v2 2/2] steps: include devtool changelog in upgrade report
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, Qi.Chen@windriver.com, 
	richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 10:20:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4055

On Mon, 25 May 2026 at 13:19, <daniel.turull@ericsson.com> wrote:
> +            text = text[:max_len] + "\n\n[... changelog truncated ...]"

I think this could say more:

Changelog truncated as it exceeds {max_len} characters; the full
changelog can be found in an attachment to the AUH email.

Alex

