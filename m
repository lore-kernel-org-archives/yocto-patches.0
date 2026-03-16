Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A3DF013F6
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 09:16:48 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46740.1773652599608029669
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 02:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GhXJyKES;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso3050887f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773652597; x=1774257397; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQWBncwYZLZNpV27iA/+mO3Ze18KO5WWvR5wxt9+joc=;
        b=GhXJyKESlkyuzT7J7qksSwSGaHXy1bmVZHmkJfTwEt0e4hwr29cnJvfk0HmvgQK93o
         4qlbJ2KjeGwQVBN3zN241vR5y8TUwwFNKO+pROeJzRjvBbvnnFz0ZUgh7240+iII5U7l
         rSs1wTGQyIeX2eYQwXttMqOdAP44YADQwfsLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652597; x=1774257397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQWBncwYZLZNpV27iA/+mO3Ze18KO5WWvR5wxt9+joc=;
        b=hZofoR1MccpgDaShUvGjv8ue8UibK91sZoobTCLyEJ8jsadnSvNQBDWfSfUVNKKUTp
         Feem0BIHg56gRWb7Mkg2Ewu9Di3gWSddwNwvmk4bgpt6yqo8VuXbrcTQRrh2oo4Hvnm5
         QMFFKOqz6gtfosiwpJTSrQo+5bfgPG/oQKvJBEMIMWcoNt/IGNXbkFuP1Ct5rIzUGj/l
         kaSVVuNVWPNR24e4UcGyK/P1QnLRtdQDAKuuH5jQ3aR86NV9OtJopXexPaBO1J+ZqiBu
         Cw7ONXmfH/jQY+Me10ZYYkyClSbXNN9+c4VNPF8JAIIRSeacSlQNxDJZaJLgAAYbi9sQ
         W5/A==
X-Gm-Message-State: AOJu0YzKi29FHpiop+0whCkOaVeo+0hEZ0MxMzrkWN/iow0cdzpG3Xjg
	hhR9DiEacN/iiZdgA4LJKbsTBFCIkONcfxG99haMpuY7XqBCZlxngKQ00LhTdN4nWtfVueT4afS
	QfQ7g3kM=
X-Gm-Gg: ATEYQzz4xpxqDWi3xc8f9XIgYaJepcVXDSotOMqxs0qOmYNFJH3OwrU/mLuxD/9sjgQ
	AMnChgkvEeitAH5OZ7+Q7cUqNF19uGBcW7Tod6QeFgsBRJ5O0IZDxDTK7noHJ9Nj9UzOFZxmRjp
	J++Cc0/cA/7ANgn6Vz1Ie0qERWROZhDlIpAb5N1jSl/PsPR4OdXsJH3YEwl5/muX55KjGsHdq/R
	5s73kfVBupS83wtEOlWJa6HwFGxbeiqut5JBVvyo10o7XijEe2mTDdNROxmOP4t3iCvfdUche93
	9U+KD+mWUYBIztvoBCdTA/EOMdB9XsvWmlkD1fAZUnGwOTUf0i10QezGXm6h31itN4H7jZhFYbx
	P38bldlAsYvVvQ3ENfvqaHlkrf44Szh7nEfYObjHlQ7Vws3b55VaNxMtOy22prfI885JylmRAQS
	d+SpDa0X5ived9RGuJFWYhefvTpc+ca2TmhpcmS5YkNbeQG8MVZVhnuaJeeXpHOrUgL7BuW1yLq
	vJ7h6dqzNn//4WE4n8JkaIy/A==
X-Received: by 2002:adf:f8c4:0:b0:43b:4468:b114 with SMTP id ffacd0b85a97d-43b4468b49bmr2928324f8f.23.1773652597479;
        Mon, 16 Mar 2026 02:16:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1225:f5c3:a704:878a? ([2001:8b0:aba:5f3c:1225:f5c3:a704:878a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b416e3678sm12478816f8f.17.2026.03.16.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:16:36 -0700 (PDT)
Message-ID: <d5b8168f1c98b0a36e699fc78069b1581624777d.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/release-parser.py: add bitbake version mappings to releases.json
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Antonin Godard
	 <antonin.godard@bootlin.com>
Date: Mon, 16 Mar 2026 09:16:35 +0000
In-Reply-To: <DH42Z0QXNNSZ.2OI2R6DSNV24I@bootlin.com>
References: 
	<20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com>
	 <DH42Z0QXNNSZ.2OI2R6DSNV24I@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:16:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3468

On Mon, 2026-03-16 at 09:57 +0100, Antonin Godard via lists.yoctoproject.or=
g wrote:
> Gentle reminder regarding this patch. This should allow me to move
> forward with documentation series for yocto-docs and bitbake.

The challenge is you sent patches with "X needs to merge before Y else
things break" and I just haven't had the time to focus and work it out.

This patch needs to be rebased as it doesn't apply as far as I can tell
after spending too long trying to work out if I was missing a patch.

Cheers,

RIchard

