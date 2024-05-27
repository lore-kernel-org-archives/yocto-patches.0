Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B2C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 20:36:47 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.6832.1716842196912230698
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 13:36:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=byfTkD5P;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso728751fa.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842195; x=1717446995; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DZCHZE4LCie2uD7A8qCHVBM2hWKX6Ln7Ir0m+MhjVI=;
        b=byfTkD5PuF7yrnbNI6o9tT2cNEmF1wv+6AC1fklMtpwVtN316Vsd/dcmI5H7cuxRwk
         4nr9gUUeVNc0j77vsmzGnYdE08FXaRfYkDWcnYT9yiHJYQa0j7tq/jFLFnwaG+69yV8p
         mV9rRJF2I7iFibmrHGQ2xjyquWsN3nV629brcqqpAlgu0b+Ktom4HTJCpyqcGWYfXWDg
         uUop5/2Huo7QCZVF9sd1Qbyq4e5hlsyV9UZabuJ/cTaA+EKjZ+ykxj+QzsVD6JAm1Ye6
         zRRHxmBJw2csaO1TGlA7Lih9bA3cKDyswG5zIs42PBul49z9xwUrI1YQb6ac/zsDB0O/
         T9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842195; x=1717446995;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DZCHZE4LCie2uD7A8qCHVBM2hWKX6Ln7Ir0m+MhjVI=;
        b=L5cSzRSquBiFK3uOC2KH4FaRgVte/q951QCmJJq2HDB7jfvCrKWOXdZXt4cK9x9KkJ
         0cOYOqGt7skxrivb/hkrJ5CC2JppJVG8apXqcQ0aOI8lbQu7jtUkmY4Sdd7v7ShfSa6F
         OYDM38/MNy2KhRC6nUJtDBBPBoUHMqAH5j+/n5sqhnBAKxvVuP9nF9TuwaJX3IRKnDj1
         UHNOGt8zokoIu+nc1ekoAypTB/XBVBTXxXGgGcMeVR7M5pCSg+TpLnd5iC+JxBOObak6
         /2CUGnRk0ytX2BTOBuW3yyR+X2u1DCJi9zgANWUDXBc3b4TCVdZTB4FKnh9EIM8srmfP
         v29w==
X-Gm-Message-State: AOJu0YzVfV/HRp9ypPeJPdt8L8DGKFEV0XPl0NEFBKa6pL4kx64eIvMi
	uYN6woy+QqFoKipChzq5bbegZEUeq/0KY2qIo13Hu6hVYxAasvVaI6783324hNzj6/geXz26EW2
	2+wKIw5j4vYOb4hV35RrWyjTxTb4ALw==
X-Google-Smtp-Source: AGHT+IFteLH0MGfOLFlGOg7eA+w/jN6u9YrLkMSPByEbjt36q+YLocZ7sv+dCHz56B1s95sXwjYX4tlQDUh0YfIzLZc=
X-Received: by 2002:a2e:a556:0:b0:2e6:fd20:2982 with SMTP id
 38308e7fff4ca-2e95b0946cdmr77959191fa.3.1716842194825; Mon, 27 May 2024
 13:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240527203230.1258788-1-tgamblin@baylibre.com>
In-Reply-To: <20240527203230.1258788-1-tgamblin@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 May 2024 22:36:23 +0200
Message-ID: <CANNYZj9prGjk=eCwMxnCV41BSWLOFCdjnzAX=0vW8TQ2OGgamA@mail.gmail.com>
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: yocto-patches@lists.yoctoproject.org, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 20:36:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/219

On Mon, 27 May 2024 at 22:32, Trevor Gamblin via
lists.yoctoproject.org <tgamblin=baylibre.com@lists.yoctoproject.org>
wrote:
>
> From: Trevor Gamblin <tgamblin@baylibre.com>

Yay! What did you do? We need to update the yocto docs with a
bulletproof configuration for git.

Alex

