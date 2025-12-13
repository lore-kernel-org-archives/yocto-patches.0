Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A14DD59F75
	for <webhook@archiver.kernel.org>; Sat, 13 Dec 2025 07:10:28 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1432.1765609823099238118
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 23:10:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AQWNQXXJ;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee1879e6d9so21341011cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765609821; x=1766214621; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waAqQZPSSINSGVOKwt7teD6yd7fInbv7AcfjKM6ItWc=;
        b=AQWNQXXJcPs8DhRGSpkox7QTKQ/qds4tKMcjfmyagh6Es6kg5K3q1p01hxgpGxv5Um
         0BGC2dYb/vPXLQUgCwJHx8HCaOYdKDFaOZIb4ZISLw8jaRUQRf+12WAox8DPyUzG7vc9
         8WxNYvMEuk8HhjPIov8qqZU5ocT3NetvEC07A8WRfeGN9swNsvhSRoCBPlWwi04Lmgn1
         uK1UGGomJuKux9sITfbCUGYtLl1u0qbnKuVDAdv7XX/CJIO2EwHfOG9llLGeqg3YhnoP
         Fz7tSp83Qd5pX/B5pYJhhOA1iYZxNdRfXoV/FRJNxrizoR15xR7wIn9opT2398ESrTU/
         yuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765609821; x=1766214621;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waAqQZPSSINSGVOKwt7teD6yd7fInbv7AcfjKM6ItWc=;
        b=w5U6tu2UU7tLo7TPoC+ifh7tGyeMAzFabgy3h0fX3wMLtJwPkKt7KcPMKnocnQukib
         XUvISZKHZWf59Sv+b676uTtEKsYlg/RKNJlQ7syiGHMNOmRqyFtDK9eJE8Wc6fuQw2vr
         pQksU/bTjKnF8kWm/cyfqab02TLJ3y9mTo+TeXfvBBm8w8laP/AuSenxCCOT9SxRUCg+
         CF1RxtkbbHiERhaK+pYLxQd2Cmn0POWYLXizP5PTO6fKNgkr6E36ejq9k8s4nR2ZbtqL
         d6LFi26efZVxUFRWcKYBM7krD4rBniO9rzoC17/TspP/kojw7Kw5+gWlAlTXLxDq438k
         zMeg==
X-Gm-Message-State: AOJu0Yz2fb/lpsugkHfliIdMmjrY8L13jpJckwH6GovgjFZvN2kx2xYP
	AJTAY0N3zRIfbjQEtxrT8AJKQnpwkhosMmUvXPfGHQ94p7ewKQ11NwE/3cqnhw==
X-Gm-Gg: AY/fxX5bZ9nfAJCiDQTmJCnkEeqiZZd2Q6nvEo21RknAjr0dh0sUWwmIromTE8Cgvci
	uyPLYCSyicoXl7a6T0IN+mvYvg6IGeSR2Qemy6UtF0zf9ll1bFwI9ciuRmu2i9Of1qUm/CZWN7o
	xf+5Ohfefr1f5EJetXncjvQoPYM8CExedqOIvRFK+mr6JNHzmInqfy9LDLB6a8ffO9PbygA1qlL
	1wetkttwMOD+/rGpYFhcXmgxiGj8iU5hNo6HmyCFq+zFrlEQTy+JeqfHU22FVcFCdYNpo7TFuBj
	WooW9zIAB1cB3llFfGpnPPEffbGo8XXKVOj5GMapttpvVuumiqj1pj0tlKqaJc/SaGHM03KKozd
	7UHk/vXGzMQPtzYdbTmVIO/tS6osmYHYcMd95dSAYYYbYnT7zzSCz+oKliGhpn11nZBxuuev2F6
	HIuXKF93IZWmZ3ZV88btrLhUlJrlQIs2ogUwDNHA==
X-Google-Smtp-Source: AGHT+IF67pD31UUIR3JY4+WoCCGZH1AKE2cidIVZq1i48g9kyxZT4aJFmc3wBfhWycIwvByUNqjZkw==
X-Received: by 2002:a05:622a:4244:b0:4ef:bed6:5345 with SMTP id d75a77b69052e-4f1d05ad4demr64613431cf.50.1765609821440;
        Fri, 12 Dec 2025 23:10:21 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd5c2e41sm56758601cf.13.2025.12.12.23.10.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 23:10:20 -0800 (PST)
Date: Sat, 13 Dec 2025 02:10:18 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 1/2] provide a filesystem overlay
 example
Message-ID: <20251213071018.GA29788@localhost>
References: <20251212182420.24920-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251212182420.24920-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Dec 2025 07:10:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2780

On Fri 2025-12-12 @ 01:24:19 PM, Trevor Woerner wrote:
> Most implementations that use an A/B, full-partition update mechanism
> (such as RAUC configured for this scenario) need some way of preserving
> system configurations in a location that survives updates. The RAUC demo
> provided in this layer is an example of a full-partition update,
> therefore provide an example of using a filesystem overlay to preserve
> the /etc and /home locations.
> 
> This example is gated by a configuration knob:
> 
> 	RK_OVERLAY_DEMO
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes since v1:
> - the commit message was updated to identify the locations that the demo
>   will overlay (/etc and /home)
> - the README blurb was updated:
>   - to also indicate which locations will have an overlay in the demo
>   - to indicate the kernel config requirement
>   - to explain options on how to include the root's home directory in
>     the overlay
> - use the standard bitbake variable to place the unit files in the
>   standard systemd system unit file location (/usr/lib/systemd)
> - use RequiresMountsFor as the overlay mount unit's dependency mechanism
> ---
>  README                                        | 50 +++++++++++++++++++
>  conf/machine/include/rockchip-rauc.inc        |  1 +
>  .../systemd/data-partition-overlay_1.0.bb     | 22 ++++++++
>  .../recipes-core/systemd/files/etc.mount      | 12 +++++
>  .../recipes-core/systemd/files/home.mount     | 12 +++++
>  5 files changed, 97 insertions(+)
>  create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
>  create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
>  create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount

Pushed to meta-rockchip, master branch.

