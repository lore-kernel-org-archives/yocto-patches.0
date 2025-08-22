Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C76CCA0EEB
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 16:54:22 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.915.1755881643866828520
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 22 Aug 2025 09:54:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ECsTJD64;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e864c4615aso341053585a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 22 Aug 2025 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755881643; x=1756486443; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtkE+3YDyZnC12YQE4CKGevWx+F//cEwyO4sBdk5964=;
        b=ECsTJD641csSgYu+2CerGGgWo/oPI8KIDp04sjKSuB07Mez818ctL76nzcL//CwcgJ
         ktT7dFEGInFlrF6Jnz2o/gVNgPPYup2aw4SimFeWPfS5QxfLOPQ1/LWz/xshycbHguuj
         DaTYFlKPErUlWiQRbOziKdvlpMD53RB5YtpQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881643; x=1756486443;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtkE+3YDyZnC12YQE4CKGevWx+F//cEwyO4sBdk5964=;
        b=qUV1lCk/Hoz8POhh+kckNBuszliOHla0uDLZ0ud7QJ5WUnWmc+YCKEJj7K/w7SQ2l9
         yBVxVgipaybbvP2Bhz7n0kJ3fX77SpSXqNIgdCkMgsj4y09XJTmCflBxP7/x5DxAZqwW
         M0Wvb8lFZM+7KLJUsYjC1kRte1/OBLo1worZAeMbzLApKakhVo+rh1bMgJukmPKSuAuX
         f03oT/xEboG+eUUYqNc+EwosmiNqRDD5G7cRNBrlSFyu/lr718H4RJQ9eOu3O80yBfUu
         6ZRjfFOu8MUolQcKxzTwWp8F93XcjmzP+w3LuMdZ4ip8KPziy07SkDXSsBQVpZsg4HoD
         VrvQ==
X-Gm-Message-State: AOJu0YzyqUIYmeWp9b6MklD3R8IhEteSoWjRe0I4/T18Ux6Q4ggefzSj
	RvRnRtlTLfO8oaGtx2w7iPCwEdPfn71a8B8stnlR+xKI4Ff8ZBu4WXOZ0c2qxVvS0w0=
X-Gm-Gg: ASbGncv9D3+RbvlGzbEBMonNgjgfkgqezYKSJnJGxoU2VPI7EvvhCS6jz93wbxIRZlL
	mLD+yEuQpNuHbeWNYK/ZmN9ZdHCjeE3I+HNL6BYOPrsNVgcRt8YIMgXC3yLKtgQ/RfW2RaZ0ii8
	i8/f2N4b0j0e+ghBjlHUJYVt6/G6ChnHFXFj+AMbTrkRj5bm6EM9qP7WHmz/YNLcIQpPzIWpo6s
	WdfULIfgmUbO3SC4ystsGQAuu9k/hjKdSMMRxhHmpZjIzO7NraUVf2PzzM0w47y3lPnETMMDzDT
	Luqmxedf7MtnvCdbLlVZ8fuNZ95siwk1UZV2Aohfgm4ido/U1F6XuuaTxgujMU6HMAb+Bl38gRa
	ctwbzfdOOWNNRdbb/0Qn2x6p5hbjp8UAFWXwvXvIfr+hdDuwiem733en/
X-Google-Smtp-Source: AGHT+IGnnLQO9SV2mbbJN9X2hPo18gIhiyFRF32LBNkCVTemFados4V9Z6aVVRDrCF9l7j0IJhHWng==
X-Received: by 2002:a05:620a:4146:b0:7e9:f81f:cebf with SMTP id af79cd13be357-7ea09499a9emr770101085a.36.1755881642826;
        Fri, 22 Aug 2025 09:54:02 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed79ac9csm13270685a.21.2025.08.22.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 09:54:02 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:54:01 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com
Subject: Re: [meta-security][PATCH v2] suricata: install classification,
 reference configs
In-Reply-To: <4c79afc7-6325-4a96-8d55-ab5512c24385@gmail.com>
Message-ID: <6f38fff7-b885-7f5c-1a7c-008e357f28ea@konsulko.com>
References: <0272a677-57d5-4dbc-b053-8833c6771928@gmail.com> <4c79afc7-6325-4a96-8d55-ab5512c24385@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 22 Aug 2025 16:54:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2078

On Thu, 21 Aug 2025, Clayton Casciato wrote:

> Hello!
>
> Was there any feedback?

No, just a bit too busy here atm to test and push out an update.  We'll
both be at OSS EU next week, but I'll work through some testing and will
hopefully get it merged.

Scott


