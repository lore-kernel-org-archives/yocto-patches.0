Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E7FAD3F9
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 03:47:06 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10482.1776916016434642979
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 20:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=V4ZXo5sq;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be94eeacso6228651a34.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776916016; x=1777520816; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abl7kPocd1Xg5//i7yp+HEv46RINXpqBWLGSVFu0Xg8=;
        b=V4ZXo5sqU2E9p3pK6puXYGvraMEsHev0dIn7A3K/iKh59ZImCZg9So2kNyQnBGrmP7
         DJhDjfu4wUa9Rvo6rdnsk4pHRmR7wCbaHHhV/a7uyMASZCgQHwqrnkPD5e3WT3AhL1/o
         p5GSvLTt+wuxOvVrWR9qBJ1t+0JO1x0VHTG4pvuxSWJTWEn2mBQZg+WLja/G/PzlASYw
         T21ABjYmY896Xzgu6I4BtRIpqNLh5dhThVxZTqEiz5YjzJhZ1yFrghKhdn3n8a20E9fz
         GvbzpFqVsy4Bx7SJN57H3noIx0L2VxoVpRvKMwtLPUtEnwWDtPjswiUxwShlvoewBWIj
         RXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916016; x=1777520816;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abl7kPocd1Xg5//i7yp+HEv46RINXpqBWLGSVFu0Xg8=;
        b=tDXQefwEV93zuTBZTCFmelwMAp7NeGP17tgz/HQedvxozJ8mxYXqJIjlBI/REpbxIG
         XN/2EFtj88QpPEOchXYkDqyYSdJsw+f4hEzLijHAWNYoORofjsxXLWk1Zzm1fwl+vaLr
         BYrisb1fFbhzTBRfC8jVCIH6mDkWOdbJPx2CGv7/8WPaZBbAKxpsqmtreGyM5m/6srt/
         WpT+yy8/McuXgwxEwKc+hxir0oWYAdwLBLykaeSJF7S28HXAf3hOgX5/vPwWZbr7/c8s
         j6fkW97KWCtEborpGrxTklIoXe/nPS7FGWBob5TAcjIXLJB6Gupox6EK9SagCVdo5xfi
         QK7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+b58a4L08myDKRAFUAtRhm+UqLTOE8zv4lCCsPKb1Db7bf3FVzRvSQsIj0YfDC5hEri1IlJN8oH91OvFAm@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzbH4g21i7wI4co9NmKk/C2SPwpIYgO59/UB+z/FFneBMk6kFuH
	UaS04RnWb0T9OVjvzHoRKR4a6IfBDLV3qXBM6k34O5B/6JLVq6DlweiOHStJBw==
X-Gm-Gg: AeBDievaaMtNdz64juvarlL8LBZ433+BCMC5kqF7Ii2yuUwqMuhdrkTB2yCMXIBrR8w
	frymnBqaqYqZcC9HW+CR2O12b3Rdlszy6dxac1bjV2fCLSjnJz01dbSyWicbL7bfold1fltgNX/
	xOKNCyegwq7S0BuJpFTxcbg7HRkRbD0WvLXH6tWnDFL56y0HbwkfdOHJzKe1y0toA3dOCXMLlG/
	/6PIzfloVAmTpbnc4b3UlZ7rro1HzxRF9MYgX8Lj6cctUywZYvGVaLsz3qqC63YrhyZ8lzOy44P
	sMWSevB9RCEr7Q6CtACLbC8A8E7pJgVWl2wU5nxkSsEB5+sgzKoTWSeGEM4W6qtIzamHvJzUjOT
	UGuWukXpnhj1Ow5Mej91q76V9eXJdU8Faz5vkknEAmmLEdWBJm/z6g+n2ePTlYvnPPTOD5B9l7f
	fa1UmHlP6oCkB+sTj2F3lZD4xTpH732QzOKSzk2pmiCWcLST+LIRhjYKIsYKAHdkLrDo9tERjn5
	y0Yohdxh6J2x3Q=
X-Received: by 2002:a05:6830:280a:b0:7d7:d510:4bf9 with SMTP id 46e09a7af769-7dc95100a5dmr17319500a34.12.1776916015671;
        Wed, 22 Apr 2026 20:46:55 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm8879274a34.21.2026.04.22.20.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 20:46:55 -0700 (PDT)
Message-ID: <edb8ba0d-e084-4e2b-a072-bbfee949f582@gmail.com>
Date: Wed, 22 Apr 2026 21:46:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH v2 1/1] suricata: update 7.0.13 -> 8.0.4
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: Scott Murray <scott.murray@konsulko.com>
Cc: Yash.Shinde@windriver.com, rybczynska@gmail.com,
 yocto-patches@lists.yoctoproject.org
References: <5500aef7-608d-4ae4-afab-5c816d255031@gmail.com>
Content-Language: en-US
In-Reply-To: <5500aef7-608d-4ae4-afab-5c816d255031@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 03:47:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3767

> It looks like the Lua 5.5.0 upgrade in oe-core has non-trivially broken
> the 8.0.x suricata build.  There's a somewhat straightforward issue with
> a new argument to lua_newstate, but after that there are link errors that
> the more I poked around the more I'm thinking there's some oddness wrt 
> their vendoring a copy of Lua (5.4.8) for the Rust side of things.  I
> don't see any signs of the build process for the .c files under src 
> pointing at that source, but then AFAICT everything kind of gets lumped
> together when linking the final suricata binary...  If you have the time
> to try to untangle this, please do so, as I cannot guarantee that I get 
> to it in the next week or two.
>@
> Thanks,
>@
> Scott

Thanks for the hint, Scott!

It appears an external Lua implementation is not required at build time.

I instead configured a variable ("SURICATA_LUA_SYS_HEADER_DST") for v2: 
https://lists.yoctoproject.org/g/yocto-patches/topic/meta_security_patch_v2_0_1/118966848
https://lists.yoctoproject.org/g/yocto-patches/topic/meta_security_patch_v2_1_1/118966849

Clayton Casciato

