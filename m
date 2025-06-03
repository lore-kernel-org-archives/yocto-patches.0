Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0AC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 20:09:51 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.162.1748981387241701275
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 13:09:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=goGRqCXw;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0ad74483fso58042146d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748981385; x=1749586185; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFWc5XK0nv7qt4AxckuY2MLgLsVkK0VA2geTy1UL0Mc=;
        b=goGRqCXwvyyE53tqbGwGspxbMetOnuOxlwhG6alzsYHpdluwJSk3ygaECcnj2zHuno
         0qmOPRKpp5ppbOt/5ubOtnBgwyDEuEmYo64X6bfVLtj2so5VFdP8XMCGJN+DAF1zchsR
         OPVkficYmJOnl4xft/91AbTYBAOgJkl48Gv7yJ4uJW0dKZT/k+BF25tUD6mfx3ZA4HGz
         jYQ8Zh5tlzicAk3xzlh90FWQrxAQFMz4ZLsBKyTwIcgjrTmav8VkvF7mPE6NozlnyqC6
         qgwaIHbAACtAo1C3RaUWn4GXeVmOBVOVby4fISj/oUfYhUePETvGRCAmStj1D8/Yd6XE
         fkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748981385; x=1749586185;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFWc5XK0nv7qt4AxckuY2MLgLsVkK0VA2geTy1UL0Mc=;
        b=bxu2EW7ejBMki/AsRqnu8VcTvtgQyHDCgWC0Cjt7VhV9ti7M67l1pIfzyQ/pScgxVx
         hgh/ZC20B5hzBVN2xDMD4BJTq8V6v3uXOaiMS4X+HiThwL4Z2BGGOJoytZo+sA4Dfwtg
         FYVN/XFoE/Imlr2qd2cC4QjsZq7HOb1fnz2wWKErCdbMft63NKH3VXbrKFDoaPrJgTTh
         0Mp11PXYUQyBy6D7sA/zBF0if9gU5u+Ojskmq+eiKeytysovJzqsF+eYQOqizr5wzgop
         kGfN8i0iXNDIb+RpcxPhR9M30gPA7ypptgIHXjtc4QXu3zOj1RzPF/6FK/gPcEnGFpb2
         NYgw==
X-Gm-Message-State: AOJu0YzhEtRCrzU4E9YLtnqMIkR6CkKnK/so5qz8WaPkJolQ4/2TPzRn
	R8b0eHi7yZ7RZC649c3FfmpH8Q7wD3K5gpQWv559OR2y9KwIDwb9IA+XWlCuuO9i
X-Gm-Gg: ASbGncvtD6bz5Q12FeXIrT8HstT10GfbY3/J/EUO/kGNEoEAKSC8GLeEzB+W4YiBCh6
	R6n9i748ZtHe19/R1JVOCfXer48SuTI5Wssez4qzeBPxjIzXQc7XkI2h+0kx56eOpm1OMCKBIJY
	hrIkDNhxnpKtbdOGx5hwnM5POhRS+Lm5IUY+KKfsEoP8mli6uDCa+VGeGyFJ3z890K0M52ZTKeC
	G9N6r9ZiCYJ9s0IK9g2sYLkT98AEQeRut1PNkNmMWIj9EIDW2K9Ho1zzB3Msee3P/Lrn4VHk5c4
	91c79IZsiCUrcVE7S7fOnHY0UCohl39qWpYc4e0oWhS/JQ0Lt1wSwdthiMhz8IRUXLOp4tldZo6
	9cFY=
X-Google-Smtp-Source: AGHT+IEbTGdJHm7i885pYwinaBdE6QuWQeO0mBNsVCXGnN7Zt9JVFbM5XvVRyHNOmiGMpaeraPZ1jg==
X-Received: by 2002:a05:6214:1c09:b0:6fa:ba15:e7f with SMTP id 6a1803df08f44-6faf6e79059mr1498066d6.9.1748981385194;
        Tue, 03 Jun 2025 13:09:45 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5bd25sm86591246d6.68.2025.06.03.13.09.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:09:44 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:09:42 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][scarthgap][PATCH 1/2] rauc-conf: adjust
 PACKAGE_ARCH only when using the demo
Message-ID: <20250603200942.GA7730@localhost>
References: <20250530172234.7393-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530172234.7393-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 20:09:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1615

On Fri 2025-05-30 @ 01:22:33 PM, Trevor Woerner wrote:
> Make setting the PACKAGE_ARCH occur only when the user has enabled the
> rk-rauc-demo feature.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to meta-rockchip; branches: master, walnascar, and scarthgap

NOTE: for walnascar the previous commit for this tweak didn't exist, so for
      that branch this patch is slightly different

