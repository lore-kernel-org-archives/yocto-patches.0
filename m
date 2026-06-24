Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5DCDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 02:06:27 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3320.1782266783096995639
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 19:06:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DbHKZKAj;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-920d6e3963fso42279085a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782266782; x=1782871582; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nBahr078L/iu04vkXB+TRLzyPxmx1Orq8RvUDGM3b44=;
        b=DbHKZKAjxgIjDkvjIiBmnoTLxoYrAY25VkA8RpPMnEM9sZ52cTCEQWzepbZeN3aLKq
         G/DQW1vUB/L8vwx/bp99izU+fa0Za/7tr8CqJXngAw6QWpHzjmlqPttTGdjIdwCK1b6O
         1Stm981DBL4JivUpA158AQ/DR0Zkgq5wsymUv6TKmHMIXdj2aezC1nyE3IkDi1bH4moG
         hRdmuOo77W0n+V5FfQ0P8KSwo63ZgEAqzusLuxL8cjePG6r5HxpcNJYNUbRMhNu/vZWC
         zjsgDUmjZG6iPCoEp2BXnHctvYAkipMrWDeNifTIX0buuu1bAEsCfuxA/VckNQZytopc
         j6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782266782; x=1782871582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBahr078L/iu04vkXB+TRLzyPxmx1Orq8RvUDGM3b44=;
        b=HCvXNcNsH6u9wG2xfs743zs/PuuPDbANP52H5svjQJoLB7t5aelPDinwjkjvEA3FqT
         Wb8LO5oRXl+9308dXdHMfimf+4VoTl3pp6LjDJOJiPHh3ukZeYCsvJt9wx1yNKiqe2YX
         GdnhxIOpJh4E/DGEZQgsPLQbSMu5xaNZkugasJT41U6Ygl1u+YV6Pl87bNAWOk484KZr
         ejlgwoHP0BYRbUwkBuvQoiXnDS/5oYtyTfG5oCufGdE83avUli+fmB1X/0jbpGJYZYQ4
         x1ZvTiyRlQM4csDY+2ibPNg/trwV/fCG9FAuBaF3q10WpR2cU5opPtMAtcUa7t+ZsBeT
         wvsg==
X-Gm-Message-State: AOJu0YyzviZFKUoXwsWAGBmpQNpgdea9UxnTFvQAbAh6qmevLCYsnu8N
	hM2VogV0LD11LPgdcz/oJkFsfAa+9Zn75njkW01nFU8+Fzxoh9rQfNBb
X-Gm-Gg: AfdE7cmCkoi4MIJKzeK1xtblYSWY+dmK37QWt/Lj7dJJzqixV92DvBESh5jOXk6VoUl
	J8Gp5ydSC+O/NvsFcUkaVXhc6gqaFJsewftzD11JHzPWKAe9Nuonl32IGlK33HQCD/QKGvRkwBh
	HFE45Mm5er+vQxXuLZx1It3bNgYiK0mrQ0240d5J/1gsqu6uKAWybdOwd3ARyAn9pge0YR4Kdee
	PYXVXqmfu1o3NkDG47FW8Qv0fpc8UEq7VVkP5YETI4M9YZ/rzFjpfhP52jpC6pUjc6CxSBgCqBW
	ZCou4IInpNmCDVk5GuDfjL29TdjlcFgrDWGMRBzZjaH7lWw8SuMtz26JorpUNTCd9WSTVQrCynr
	Ivy/amJ6rzoQ0ZZUyuOaayNSivc+1V+hCztffc3W65Nmi2KXCLVZTmwuME98hGY3myzPxTE+a/M
	wnRFdM3dO6NQ1C6tHLB3WL+QdT+GuHY1cm1oEVbc+YdbHMzKTqO6LhtWE=
X-Received: by 2002:a05:620a:8807:b0:915:afa5:722 with SMTP id af79cd13be357-9277c3c8b4bmr275605785a.8.1782266781958;
        Tue, 23 Jun 2026 19:06:21 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde9ecsm142545276d6.24.2026.06.23.19.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 19:06:20 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:06:18 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org,
	=?utf-8?B?R2HDq2w=?= PORTAY <gael.portay+rtone@gmail.com>
Subject: Re: [wic][PATCH] bootimg_pcbios: fix typo in comment
Message-ID: <ajs7mutsGR6bcR6k@localhost.localdomain>
References: <20260617074007.2599873-1-gael.portay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617074007.2599873-1-gael.portay@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 02:06:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4287

On Wed 2026-06-17 @ 09:40:07 AM, Gaël PORTAY wrote:
> From: Gaël PORTAY <gael.portay+rtone@gmail.com>
> 
> Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
> ---
>  src/wic/plugins/source/bootimg_pcbios.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Added to wic, master branch.
Thanks!

