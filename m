Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0673ED43344
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 20:22:23 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.121.1765484539276975731
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 12:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LNVk1FiP;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee0084fd98so4236131cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765484538; x=1766089338; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uygWtKCe4Q1URgPyOCX1bLXl5KHd9oCJIg04aEHGcTk=;
        b=LNVk1FiPUyOn8K2XrWUeWyoRqPsnixbh8vi6TnqpuT2+ohKzz9C1DA4zx+KuzO0bEK
         n4POWwKST6mvA35fisz+NwbYAvadJiz+2384MFjiNnV/sqM3K2QuN8S6Umf+zt3oTd3z
         BJEqcQ5A6REn25ouHw1yiXeTD2cIEPcqE9fobkY4+evut7hDQIwA1nB8/gI+/+YTqZK9
         N4+BJKzb/Li0c/cUgldFbd25PFp6GTsPMMMBbblhtBYeU6hjFKwg61cMM7znJzZAPUgS
         LNn02tK4rzG/DjEH7k6rXtVzevietcSb9O3kWhkqLhqmuURYYbelsUtYUEx4voQwhe8x
         n3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765484538; x=1766089338;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uygWtKCe4Q1URgPyOCX1bLXl5KHd9oCJIg04aEHGcTk=;
        b=TaodsJycYMM7zur05ShVrnYva3OLQU7BT/Cn8eQCvYjJZ/FxES2qj4rtUlh6Ywyruq
         Fj/FHHkH9wFHxUctnOboa0CGRh5R//q6WWlklorGZHJL8pb9/9kcKXzbeCHB4ITOHNR6
         LSb0WkQXPvz4WeJSDZRlBf6InYAHJ9X2KA9qG2/+cdQ0o/HeEN0v/FPBpRG4YGjXdGOq
         w+Zjq6GyEzGzbBssVBQTDXo+5aIDB8mfq7bxESir5sDLQLQcH1tFIC+jzqSCCXny8Hh/
         RklUWkEqNtIJVoKaFQumr0li/xfOJ3NVRdX7JOoAdhkKrjCRWxbx/mywS4lJP6RxgKSf
         jhWA==
X-Gm-Message-State: AOJu0YxAcjWzAgPqlBM6jWK3uNDk3nXK0URpf5KCq3pcYr5ZjP5tZQN7
	Wa/tYE0/r6/FM44pjzx7L3ES5cdG6C0bIjHKwLmrWm6vuDiNrFKwKOkWb1UPVw==
X-Gm-Gg: AY/fxX4LC7IX69H0+tvZfPmKqr0So3JD2MMeU6Rfc5Yrbaw19HjBUY5xk7pr3UclrUq
	yfYgvoNyFV/lByFRYBBH2ZjzyEnZdg5N1X+lsccJNhjXgWZCt7vvl+8paocm8679JTwRMg6sGwf
	+J+X9aIVXqPOGuh0amLeez9gtOn93+pNLNysjK98YekQvLcZ9b08nwvR8s9VZ5twS2okbZFoVNm
	Xnrl0lZ/5Rg9Wz8GQcNKep4m9/YfOTBkjYt/MEpdN1GvWNvku9Yj/dIiXttwkF7NWbXN/Ty7IN4
	+Vo5nLEHtd3exShVRs/sM/quF35oUpSAokIKJdOvUWYL3U6Yt8wJOl9wKUrIdMbTY4Vgik9x+HM
	r1VWJ8b+0NgsAs9P6t0/oeWM5ACS35wUDV0n2z0y2W9E0A7yu5qXM90BSAXRtAQGNfv7vR+vwIt
	xlFPOKzoillF/DFmVN4WnN1uoiwBtkg2YygykfPQ==
X-Google-Smtp-Source: AGHT+IGQpXZGw6DppYTFWOQnWPAb1zlAFB/ufRqUqTCf9JUYU8GSn/ZAu2x6JjESU565ZejDP8uDng==
X-Received: by 2002:a05:622a:1928:b0:4f1:abf2:54cb with SMTP id d75a77b69052e-4f1b1a7ba20mr95652061cf.43.1765484537563;
        Thu, 11 Dec 2025 12:22:17 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd6ed38esm24873821cf.29.2025.12.11.12.22.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 12:22:16 -0800 (PST)
Date: Thu, 11 Dec 2025 15:22:13 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] make rockchip
 kernel tweaks easier to use
Message-ID: <20251211202213.GA35676@localhost>
References: <20251208193551.2426-1-twoerner@gmail.com>
 <e2a21a1f-050a-49da-b368-73f1c03f9157@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2a21a1f-050a-49da-b368-73f1c03f9157@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 20:22:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2768

On Thu 2025-12-11 @ 03:13:50 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 12/8/25 8:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > If the machines defined in this layer are used, they will want to pull
> > in the kmeta data that is also provided in this layer when configuring
> > the Linux kernel. This all works automatically if linux-yocto or
> > linux-yocto-dev are used. But it causes build failures if a kernel
> > recipe is used or defined that is not one of these two.
> > 
> 
> The issue is that we have machine configuration files settting the
> KERNEL_FEATURES variable in a conf file instead of having it in the kernel
> recipe.

As far as I am aware, there is no rule saying that KERNEL_FEATURES can
only appear in kernel recipes; in fact I think that's the wrong way to
think about them. The kernel provides many things, and each of these
things can be configured in the kernel.

For example the kernel provides filesystem types. If you developed
an application that, say, provided a fancy dashboard or status or
configuration or debug interface to a particular filesystem, then
I strongly feel the relevant KERNEL_FEATURES additions should be
contained in the Yocto Project recipe for that application. Perhaps
your application needs the CONFIG_*_FS_DEBUG flag enabled in the kernel
in order to work correctly or fully, in that case the KERNEL_FEATURES
should be specified in the recipe. There's no point having a user
include your app in their image if the kernel doesn't provide the
interface or data it needs to work correctly. I would even go a step
further than that: ideally all Yocto Project recipes would include the
KERNEL_FEATURES on which they depend, regardless of whether or not that
feature is present by default via, say, the in-kernel defconfig. For
example, a user might not be relying on some defconfig (regardless from
where it comes, whether it be in-kernel or from a BSP). In that case,
the recipe should work "out-of-the-box" for a user who is including
it in their image. My guess is that currently throughout oe-core and
meta-oe there are probably some recipes that have an implicit dependency
on some kernel feature being enabled; I think those should be make
explicit via KERNEL_FEATURES.

Another thing a kernel provides is architecture- and SoC-specific
code. In the same way as my user-space application example above,
architecture- and SoC-specific KERNEL_FEATURES should be specified in
machine configurations, not kernel recipes. Somebody building an image
for a Rockchip-based device does not need (for example) Qualcomm support
(and associated Qualcomm-specific drivers and features) in their kernel.
In meta-rockchip, using one of the meta-rockchip-defined MACHINES
disables Qualcomm (and others) support. This saves you in image size,
it saves you in runtime RAM usage, and it shrinks the attack surface
somewhat. You're suggesting meta-rockchip should have bbappends for
various known kernel recipes in order to provide the user with the same
kernel configuration adjustments, but this doesn't help a Rockchip user
if/when they define their own kernel recipe, or use, say, linux-stable
or linux-mainline from some of the kernel-specific Yocto Project layers
that exist. In that case they will get no error or warnings, they just
won't have any Rockchip-specific KERNEL_FEATURES enabled.

In an ideal world kernels would be configured starting with nothing,
from the ground up, by using KERNEL_FEATURES. BSP layers would add
KERNEL_FEATURES based on which SoC/board you are using which would come
into your build depending on which MACHINE you chose, software layers
would add KERNEL_FEATURES based on what software you're including. A
basic set of KERNEL_FEATURES would be available that most people would
want, but it could be overridden or tweaked as the user sees fit for
their purposes.

I feel the correct location for Rockchip-specific KERNEL_FEATURES is in
Rockchip MACHINE definitions, and I discovered they can be cumbersome to
use when they are only available for specific kernel recipes. Moving the
core of these files into an *.inc makes them available for all kernel
recipes.

> kernel-yocto.bbclass is the one reading the variable and expecting to find
> an associated file defining what to do based on that variable.
> 
> So, by setting KERNEL_FEATURES in the machine conf file but only adding the
> necessary files to linux-yocto and linux-yocto-dev, any other recipe which
> inherits kernel-yocto.bbclass will fail to find the file associated with
> KERNEL_FEATURES (as the former is missing, currently only added in local
> bbappens and the latter is set from a conf file so always set essentially).
> 
> > Putting this layer-specific metadata into an *.inc file (then
> > referencing it in the kernel bbappends provided in this layer) makes
> > that metadata available to any other kernel recipe through the "require"
> > or "include" mechanism. Any other kernel recipe that is created can pull
> > in this metadata using either of these lines in the kernel recipe:
> > 
> > 	require recipes-kernel/linux/linux-rockchip.inc
> > 	include recipes-kernel/linux/linux-rockchip.inc
> > 
> 
> That's an okay work-around but why not move KERNEL_FEATURES into the
> recipe/bbappend so we don't break by default recipes which inherits
> kernel-yocto? You can still have this into a .inc file so it's easier to
> include for other kernel-yocto-inheriting recipes.
> 
> See meta-arm, oe-core with linux-yocto. I don't understand why we have
> KERNEL_FEATURES:append:pn-linux-yocto and
> KERNEL_FEATURES:append:pn-linux-yocto-rt in
> meta/conf/machine/include/qemu.inc though. I'm assuming we can move that to
> linux-yocto and linux-yocto-rt recipes.
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2765): https://lists.yoctoproject.org/g/yocto-patches/message/2765
> Mute This Topic: https://lists.yoctoproject.org/mt/116682100/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

