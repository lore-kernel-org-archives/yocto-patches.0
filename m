Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B96CC7EE30
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 16:43:40 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.474.1750956214697141902
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Jun 2025 09:43:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ggecAjrJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so11882726d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750956214; x=1751561014; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HIs7X8shMJPuPoTyNi/Op1jiU3p8FYHJREEf6yVF2w=;
        b=ggecAjrJP+i2A3rO6keQlPrgeO7CdNDggBdyvUd5XQFlu/sKzCXJ7oyK3O6UADY7V7
         jz0gyC2WPBcjY5CiyInOjLydL6XsaAcqB7C+aW4VzD2tck87nInFReMis9Y4Mmz+dRwU
         xXPcLjWo7+M8/SnSckeDqk+fegthumSyaFvQUmNhz57TwKy/YKLU1qPhf0SATS2fwEj/
         k1aGvKrHf5WsgssjPkb8VRvUgMqjD5+R6Lh0f9KyuesPfixHZlGPkUOUUZfENx9qJhpA
         NCgmbzeTt1rsyfoyz9edy7q/91mM8EL2ZowxPww3yh3RW1s0ikThp5PU2b+F3mBj1ri2
         fGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750956214; x=1751561014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HIs7X8shMJPuPoTyNi/Op1jiU3p8FYHJREEf6yVF2w=;
        b=YHQPMXTMTFRXSPilh9TdgN5gM4I7l7jn8CgmJuffNCXDd14Y72D3o9dFHsOvZANuOS
         BS721MsvoPa05uOjrcjKxMEk6cfWsiy1z67+UBVbOaAzaV3KIVBzkOnhCBVH/2b0Mokn
         E8G04qKe5yQTiVrG0l2CesaVPjA9HPgpcYFIycpA80qoHMHjScm94iN4y5xEe49lV8jP
         sq/4KxM003aEHBorrZrqr+BDYObnho2uMzyLdmJXUPjGeN9cB8FqPprrSiClAH1XiwvN
         qsqhuilWQeYPgKqk4/byMMkhJ1QLhNTBsn0q3lKsDrkzMcZuPsTB3QRkiC6HX/B6R/+1
         /Fhg==
X-Gm-Message-State: AOJu0Ywo/NB0cRszRI7kjiN4s4ob82lAfxS15DtV+hkseQDEMvWJ8++Y
	oszNriu7+v/vousD0KHjC2aqIHYfFD95Zhpli9WuSBriFP+770uv3W1zVO2Yw1+/TQ6syAAYh+o
	fUvGQOa4FPBha+2G9UKckJzmchUhUD9nakA==
X-Gm-Gg: ASbGnctThEcUeMNrkbO1PJRdTUwbJsUMs857PtDdzaiDrOsrZTWtciiV1y4ShiEEZ15
	ZuCwS6D8xwFQ7wPXc+gg+4FnMRCudJS1z0s+uEpAZ94tqZR8jUrd/dP8gqOQkmEB/rdpZr9WyTP
	IPT3f7cV4dwVV+b0iohrTf2J4ftZ3yPV9Cf4puFOQsdEpLA9zrPqyq5zKb24drR6kNSQgYfqg8i
	8PMdAD4SI/RvPbX
X-Google-Smtp-Source: AGHT+IGtcNuY0Jg2TW5X8+qD8E83ww/78j6IIKbEyJ3QO+rwBxk/ROKXEGiFcqxwr8lcF6mincv6SQa9XZ2KrS4SCYw=
X-Received: by 2002:a05:6214:e4a:b0:6ff:154a:aa4e with SMTP id
 6a1803df08f44-6fffdcfc05emr3818466d6.7.1750956213554; Thu, 26 Jun 2025
 09:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1750882005.git.scott.murray@konsulko.com>
 <848dd8066de86d3feeb520ef49e902548743fcdd.1750882005.git.scott.murray@konsulko.com>
 <CANNYZj8hvFiu4774qYFkBUu1NCiX8wLtOPnXu8hFb3S-u4SnUA@mail.gmail.com> <fb5c3279-262d-2874-d537-6789688538b0@konsulko.com>
In-Reply-To: <fb5c3279-262d-2874-d537-6789688538b0@konsulko.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Jun 2025 18:43:22 +0200
X-Gm-Features: Ac12FXzoU2Hr1Hm6yY-Awg7aneuqVdA7N8DuW88Jb_ST4Zd7m-GgCcjfxVXK_GU
Message-ID: <CANNYZj_GQ79NGC8QOievKpsWZZRnbY9Nf55n8BcY69VvKUqSYg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] Adapt to UNPACKDIR changes
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 16:43:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1702

On Thu, 26 Jun 2025 at 16:19, Scott Murray <scott.murray@konsulko.com> wrote:
> Those recipes all pull in selinux_common.inc, to which I've added:
>
> S = "${UNPACKDIR}/${BP}/${BPN}"
>
> to avoid the duplication for all the recipes where the subdirectory
> matches the recipe name.  If that seems too opaque, I can mention the
> change in the commit message, or if that doesn't seem enough, I can
> change all of those recipes back to defining S separately.

Right, this just wasn't clear from reading the changes. Perhaps
adjusting the commit message is fine.

Alex

