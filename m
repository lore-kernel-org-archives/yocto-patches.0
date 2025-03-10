Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F4C282EC
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 15:47:38 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.41651.1741621649791031092
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Mar 2025 08:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nCzrXSyi;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47662449055so11371031cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741621649; x=1742226449; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hdNZfkS1RqqRCAoeGuw1C+Kv+J4m9A0UHcsxoIADeM=;
        b=nCzrXSyiXaWDcbtYsm3FLUA4qppjkLgq0vW/U8+R231HiOI+cHIoQanhGy5nlkS+qh
         P6wvFoi+A0pdDFXj4rGRNG56c1INKl3Y9AT7xj8tUkAuoK/JVQ44olugTkFCPNkvBCqK
         tjhT0JTEnE3gaj3axTFKyqwR+BFJiKgxTHHjynIK/KTJY1wucb8y2Jr0cjVII3Yxo94m
         0KOjW+zKjUU55xGowOOwtC2fYnm2hiK1wXHMvE32b3S4HBJoXkx49hVSwYllOMG/HAx1
         Ok33rU0HcQ8ORBjEQgJfpmzzDQyk1306YK1VgyGJbmCCb8kJhuLOP0V2mdQh0s4ZcOYo
         6v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621649; x=1742226449;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hdNZfkS1RqqRCAoeGuw1C+Kv+J4m9A0UHcsxoIADeM=;
        b=cC8BOY6qeZBX/g7wouwKG0uiDJLvYfwNIIjE+Q6xK9s8B+7+0r3YKSJ5Hrqg6XjJqU
         CMQEDPSYHy9BGInaNSGl+0AayHA+D4ZnB93lu3wQ6sVuDSZz0hsGt8kxYpHk+LvzYNe/
         Igyp0s4wsUJanRXx9cnMGIc+6v3oC7GVqHiBKgUH1tD3zOjNvsJxxtPpTtQARWfUumdB
         Qplix9+xFqTMkkAKF1QwVz0WAIyujczUuMewtrmkRrWqSNHa7pzIF/CfbGjHYgRVw1eC
         F0sRBO66h0AS/vzc7TxKth0jmoPWpI8sNN8rvXl4ET30i46cY5+s//w83BXQZTWVbMTs
         SjPw==
X-Gm-Message-State: AOJu0YyNbgE4te2G7N5m5nz9nDSqtQXJz0S6+Ij58TLnh1pORxGN5pj1
	t45V4OIuPPdYdtm1nLTsWsboJ243fBUnQRq4A1GuaYiQJ0Q9hgbevXFUZs1I
X-Gm-Gg: ASbGncv34XKYE6Qp3+KhczX7ADmGfCM4J9rvHH46Ce/KZxXF3/7o23cgFfrVH1PHbJI
	GwPI3P4uDlWV6Xj8LlBr2uEI6LDj/SHoGjggXKfQF1NGBtTjSCORhhkuiK21MZvECTpa8okHYWh
	sIZ9pFmzLRIpAx2kGfDRcK0yVwNCBlyIsSLVnQ/Cu4vA5SkdMdzxkjSN4nRE91yQPdDoFNICxeQ
	56v3c3o0kUPDiGPeITWRMzIG0x4qPgYvOvB11Dav624KtRpYQmp6QEftuW3CjpIU83BBIsxRIfr
	iAr8Ngac+Vp/pXSN2kys/nwqPhScgMt/Z+bFbqU5POhr6lr8aiuF2apsfaPY6ly5jdAjgLzt
X-Google-Smtp-Source: AGHT+IFyol3Ep55C+qFL3Gf6P2+VuI0c6QJEABlozApXWH/Ah24vRA7yB5JFk9zq+bugMILoMT/1jA==
X-Received: by 2002:a05:6214:e49:b0:6e8:f5db:d78d with SMTP id 6a1803df08f44-6e90067700amr152080746d6.23.1741621648648;
        Mon, 10 Mar 2025 08:47:28 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e907100f62sm40209846d6.60.2025.03.10.08.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:47:27 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:47:25 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: =?utf-8?B?5YiY6Zm254S2?= <ltrsunny@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: Kernel and u-boot version selection in meta-rockchip
Message-ID: <20250310154725.GA34977@localhost>
References: <CAGNQujsSc1TpF3ZpmoQKpa0cBeqTdnY3tpKFZh9udwaA0ZQomw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGNQujsSc1TpF3ZpmoQKpa0cBeqTdnY3tpKFZh9udwaA0ZQomw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 15:47:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1173

Hi Taoran,

On Mon 2025-03-10 @ 11:10:31 AM, 刘陶然 wrote:
> Hi Trevor,
> I'm trying to build the scarthgap branch for meta-rockchip and got errors
> in kernel and u-boot.
> I noticed it is because of the receipts in the branch. Just like
> https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/linux-torvalds-next_git.bb?h=scarthgap
> 
> it's using next-20240904 from linux-torvalds-next
> <https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/linux-torvalds-next_git.bb?h=scarthgap>,
> but the branches in this repository are expired very frequently.
> 
> For the LTS version like scarthgap, when the version is frozen, it should
> be set to stable(better to be LTS) versions of kernel and u-boot, isn't it?

Yes it should, and it does... when it can.

Yocto scarthgap is based on linux-6.6.y. All of the machines in
meta-rockchip's scarthgap branch use oe-core's linux-yocto_6.6, except the
radxa zero 3 machines and the orangepi-5-plus. The reason for this is because
linux-6.6.y does not support these devices.

oe-core scarthgap also provides a linux-yocto-dev kernel based on linux-6.9.y.
This supports the orangepi-5-plus machine (so this machine uses that kernel in
scarthgap) but linux-6.9.y still does not have support for the radxa zero 3
devices.

Yocto master currently supports linux-6.12.y with linux-yocto and linux-6.14.y
with linux-yocto-dev. linux-6.12.y supports both the radxa zero 3 devices and
the orangepi-5-plus (which reminds me, I should update those machines since
they're still using linux-yocto-dev).

So I assume you're probably using scarthgap to build for a radxa zero 3
device since your comments are only true for that device. During the
time-frame of scarthgap I was eager to be able to build for the radxa zero 3
since I had one and wanted to use it for a project. So I had to pull in what
was (at that time) very experimental code to get it to work.

I could back-port oe-core master's linux-yocto to scarthgap in order to
support the radxa zero 3 in a more stable way. But perhaps a better solution
would be to remove radxa zero 3 support from scarthgap and simply ask that
master be used for this device.

Thoughts?

Best regards,
	Trevor

