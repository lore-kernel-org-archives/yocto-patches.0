Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E11073CBA
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 13:20:28 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.106217.1775654419121924458
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 06:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H59j9bko;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb4136d865so791995085a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775654415; x=1776259215; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydz39XnNYO1bc7QkXfGhxzVkBVWJUCq6SZyL82Vie+Y=;
        b=H59j9bkop9oAPXlcy13MuwolNgikLDrIpmBFYxIeA6BtC7ulnUR8wWnCPUDja/uWvr
         iqDL5dVdrXSGOQLnlSDN2i74yNlPLUOnZASakE8GxqoWOvixFQjL32idB+W+r5LTdDgl
         s23pUq0IyNLnp01+Ek++DjWPb3u3vZYuHXgoeKBvbLMY0+EE3TMfksp63fJOAruW+r8h
         JXPr/nXTcGPsEOhbqXLApblrtYUkoIARJ8Z4CtYeJnke+A2T6AiFMZpoXEz+LjaeAJh5
         UPoA00LV6zOO1X15hJ/Z+xMdR1q2hPuATrTHXVIctjYfOnT1bfWeGNXipXzsxQku/GZL
         0S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775654415; x=1776259215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ydz39XnNYO1bc7QkXfGhxzVkBVWJUCq6SZyL82Vie+Y=;
        b=R25BWlIIiWKrCiPOCNuNE7QtBqQjgkZH2nxzmv6BRxRjjjnnhJvOR5HQ8CXZzUm9p+
         YlVpJneLQu0qe2WdnloWv/eSDiwgLl8lA5q4nt4Y3sNh/+wyYjhnwXgQnWqThbh/4eo6
         tYfcRNm908PN0UfsUaUpcy8MXDLdlxeBIeLkrDV4jDsIC+nC7GhJC5OuL/phVS4B3ZF1
         A9ml1gHaiduDfGWf54HOVgfTM55n1LcPUZMbzWF9TBWNwl6dBaiq39iPoFKMlJ3JNMFZ
         4sW6L0F4093SGoKel9sN2JzeMqniJZLmD7GJqoXUzdG5xIALsnZlYylqYXrQfk2O2czE
         b7YA==
X-Gm-Message-State: AOJu0Yy9qJAkwUv2E5cFx0NHNUe7I78hS/w4SwXkh2hmrAT9MEpX9kZo
	5fskevr9m8bETt2rC4LkhR8QC3SQ/NlmAQ9xYmT3pKVM5APWPTDaw8lAi4Ejgw==
X-Gm-Gg: AeBDiev/tPHl7kUdQBFRVgWhGTCoD4a6cdFNdVYg10Jug5gLhMSnqi3bSDUrvsJ4c26
	TKlw2pqo1zH/Xu8UOJ0V6WiG0bqpvJn1Dw44BMUH2XFrC80d/dnUfw4E2gwdDTVmJgakV0YZpmj
	oDfqxadzdSQEsboRc0xiVHjXaQPrfNEU8d0iWk2xU4OCrypm/hcDxkJHLjTbuZ9T6Z4sLmSBOvk
	yiSwpTjS0NtI9kChUOJ64BwYHq7GRQKA3/Y7h3+dn3OvfdXmDlbC2F2VzAMNCfd943VVqIYs4tq
	5v6GPKUjZ2CQnL/GgUPDYdS3dRTpL9vNhA2QVDvOpLDWZYeWQg019Edd2tkmXkwQkNXMhH97vx5
	0saaDcANJC/04Xv2Vo2Hu8e3ioVhTCGPIJY+hhzjiLWJEA4zZFARLy0Lo6BU7MUfS2SoVVaRJMQ
	E1PGA9/A2FwmAl65B9qDGNl1PMeBM4Gs9TONBUVjWgXByeryoxBMgbQQUqa1JNCapVEg==
X-Received: by 2002:a05:620a:6cc2:b0:8bb:1a5b:5a47 with SMTP id af79cd13be357-8d41c1bebdfmr2857286585a.17.1775654415158;
        Wed, 08 Apr 2026 06:20:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5336aa9f0sm1138380985a.28.2026.04.08.06.20.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 06:20:14 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:20:12 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] wic: move wks files
Message-ID: <adZWDJkTl1a6_KHV@localhost.localdomain>
References: <18A44E63FF7834B0.777565@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18A44E63FF7834B0.777565@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 13:20:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3664

On Wed 2026-04-08 @ 02:38:58 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> The new, default, only location wic will look for wks files in a layer
> is files/wic. Move the wks files to suit.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  {wic => files/wic}/rockchip.wks | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {wic => files/wic}/rockchip.wks (100%)

Applied to meta-rockchip, branches: master and wrynose.

