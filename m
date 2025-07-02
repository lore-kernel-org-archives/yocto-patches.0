Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C700C8303C
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 23:04:32 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.9971.1751497465639288540
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 16:04:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=prLJR+/9;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so34801766d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751497464; x=1752102264; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yQtvi+SbW7VC5KZ5GgMuT3YqByFifd7spM+YAnTBlI=;
        b=prLJR+/9YI8x40YPrgLkAYFs2HNcjyY/oHksImYK8U+LljCdZLEYV7Qio/tfC18iKq
         MyT14+spC6I2Wt7+nzhQydy1yL+Rn2KGhZMlxbCHKfaSbLW201G5VwTKMlAug6QNbbU3
         raOqRTAszA1HaZa7ICFJFfnUEMNpf4qhmvTVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497464; x=1752102264;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yQtvi+SbW7VC5KZ5GgMuT3YqByFifd7spM+YAnTBlI=;
        b=xNL/hYCrW8WU7TF+5bKzIUtgpwQUbRms7rt6Ub2r1BqhQZmWOvXHlo9FH0kT+CLz4g
         tllB89Hshi+U8NmylXbJhxs05Hgdj9VKE8M9QXsbby1Qtgqbgn3lDBsMAJX4IJpoCv06
         exgw2bP4jbY7BoCYfDGIkfypO4/XIthQVl68eviKlPLNNUU48kpcmwP1kvRxAPji7vDl
         z0FcbPZ/ynzN5znxr8bYdBlmsvE8UbOEjEAE98OfFbyhCnpYIu4x0Lxsb9pQzkMqrCu2
         1tLNJgAZmwehHBcH+hZO9vWzjEUSN68AUQk7TslHXLs3ANTy9h4NjqlnaAVwiL7Mq+he
         W38Q==
X-Gm-Message-State: AOJu0YzyhNawXYqDtFmKMUQCbrJI2h41oE8OQJbwHhJLETm3aqBqtPn5
	nGfURAOT6ui+EBi81j/Wti9QZOQp665gQe4vEYWs1MZoN1OBLFyUXtAoHWMoKfq8CbkgZdW9qJN
	Qj+Cb
X-Gm-Gg: ASbGnctPrPy6C++3wrUMZANco8ajtu/FjA0kMNK5L9DCRepdc+OG2vz0zKZrRPfjL8C
	OtufRYo+YNoP44/rkKPGV6x/ETylXbint3EQmg3/E3xzorMCsQ5phaoPOCBUmEMvvk8JIkrJWUm
	/2PzRDdBkGUCcdhqt1KPsJTP9oDag2XIUEsgX6C+Kw7t+UZabhoWbINRFDFj1WUhsEdy8hyhbuk
	HoZ0fxANATkzY4nD8et2fRZHefr5yB9WmNb3sG3BPcNETo5JgiUEmXdfrL3h9faaofaGtoZy5Dm
	OAwUBIgsR7hdnkON+8ZUmtDHRS3aBqYrAsV01hrcYPZQVS5XyIxwa3n9pV45/BICsJLETGYB3W6
	uzOuJ+23uuGF8O3PYwwzf
X-Google-Smtp-Source: AGHT+IGLiSK5TF8IIeXNWW/dTGhWpYnp0N4wKvauNUWJ7THNBQQWppn3sEENI5/VnY8IqCwSOHp5uQ==
X-Received: by 2002:a05:6214:cac:b0:6fa:cc39:9f with SMTP id 6a1803df08f44-702b1b45070mr65759516d6.32.1751497464359;
        Wed, 02 Jul 2025 16:04:24 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772fcdb7sm107372486d6.86.2025.07.02.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:04:23 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:04:22 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
    Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: Re: [yocto-patches] [meta-security][PATCH v2] global: drop unneeded
 S assignment and update WORKDIR/UNPACKDIR
In-Reply-To: <20250702091959.1022-1-liuyd.fnst@fujitsu.com>
Message-ID: <0bc63d48-2f37-b90f-6360-858af2d19e29@konsulko.com>
References: <20250702091959.1022-1-liuyd.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 23:04:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1738

On Wed, 2 Jul 2025, Yiding Liu (Fujitsu) via lists.yoctoproject.org wrote:

> The series [1] changed the way sources are fetched/unpacked and
> S needs to follow that.
>
> [1] https://lore.kernel.org/openembedded-core/20250616095000.2918921-1-alex.kanavin@gmail.com/

[snip]

Thank you, but I have my own patch series that I am testing that includes
this.  I hope to get it pushed out tomorrow after completing testing.

Scott


