Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7206.1795734922189824125
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 15:15:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=KYYyfqLd;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c38cdd5b7so62823231cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 15:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795734921; x=1796339721; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLHTLAjIiKjWvnNeW1WoeseF6zhraTG7VyOnAlTlslQ=;
        b=KYYyfqLdu+aSWY1h1OP6Iihr8PCAC9nOAcfZA92MHUc3cJxXwyZyTqNTz+BlMKiWhC
         6Z198bHxWwA/0RlgI6YVrOc7pqLSqed/oLGOMkG+y3xc0RjMzL+/Owec/1rbYRqI1Fbz
         QtPShVOypjhZRydw+6Pl5PkSR6/QhnlwgsE69ppfBucnP91mqcOgDTGNWg4kkkBhKglL
         WcpA3nWfDQSmL9ke7jDIrReh63pPZX8p4aiCAUMknd/+izls32J1PLh9Gdjwv2GPmI9F
         VR4ODbYh8yOBxsH/ti8ekhAjGEgN3OKi1/W0ybWxQj1j/vyFUZntWPHzsc0r9gUMJPr4
         2M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795734921; x=1796339721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLHTLAjIiKjWvnNeW1WoeseF6zhraTG7VyOnAlTlslQ=;
        b=norNRByk0fr7dvacA6ZxrPkYG83d+ioOUGv924CTXVTxd9i4Tyfg4QZlxPAaU8ziPg
         qtVIwbb6G/KMzdsZFjUA6RK0KvgTTqkL26x5V0TbQVGZsjc0ekUtk/uRJLzqXTqDofIr
         AsZHJw/0iPdv4z6y2jLbYIuR14KR0Gd39XnujOsWHaER67ba7ngLXxqjg4675pGUEidP
         ahSAGc36TxxP7X9HEXfSd5q4U9upW0evI6DU+lbHGg1eVU+DCTytqSgTkupcmXMK5JO/
         OlHRe0ZBvdcaqABMGdbeAjdSCbhn0F2WhOr+5q1U5OFBEt2/D3K5/6INuJigbs6xY7h4
         3n8A==
X-Gm-Message-State: APuU4Z/wz2rnPy7Pq4WTUX3VrUQhOJL0XqhHhdGxRG3vTxFnnfZjIcvd
	vKrIqoMCU0H9XRvORl+Fw8ylo/QvhNUoecB0kiLyCUyj1+9+dLJayYyiILPALQ==
X-Gm-Gg: AZFdTZel8TWchNGU5adhNCHqmmjtA1mRTnyB6fcio4H3Qvd9ddX5FvwsOPahkHJsEhu
	iocVzU6BBStG/r3ZomcDW24dhD4pYzP1KBfwIG4rtQo4nXIcSnCI+xxVACh+w0LWvrOzbe5MYjh
	5H4HAnwD0d8h4sKx23ZwpIw/64teVlF6JD3qDY2zCkWGd7KSs1jZd/R4rsUvbw4rSgI0lTl+LZv
	xwWWQShJdfcSvcGLZojTbYyqfVHxogPbTTVjnFKPVE5XMSVRwuWCHOEzLQgWyycqn90e97vWbPA
	njVFTGAACH2SgBWf1zLXvjoWVoZd0LBMQxWsM7q4RzOIPFnBvNr963krmSW2ylM8BT/KDBAWRx+
	GBZu1KF/rieQWl0RnmJ6YRvfiMi1ZPAtYqtUo0JggiPwhpa0M2ChyAQFPWeVSLsAc7JMnMy0hzA
	aQzSmmH2aTQ0wWTZm4uVYrJst8ZTslD3CC2EbeDFp0MMXzxSm8w1S/SMiul6WJZypJD9RkMy09f
	uVBS6gjWKJ9Iu1ln0G2cCgR4NXb2mpVwjMjdYwRdpKgbGE/GzWbcNHRE0ttR1EgbQqMI3Oa1cFw
	Cc2y3bzjSX+zalfU0H2qQa8tld8w3pckJ4jspRus7c5ktScwo1GerPefV/qg5r1QA0YkAOVS17S
	PZMibsyAH+nftiV6VqnS/h/kqZ5cuUyg=
X-Received: by 2002:a05:622a:988:b0:55d:5ba6:bf25 with SMTP id d75a77b69052e-55d767ab475mr447696341cf.0.1795734920738;
        Thu, 26 Nov 2026 15:15:20 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dc7a6700csm18479741cf.7.2026.11.26.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:15:19 -0800 (PST)
Date: Thu, 26 Nov 2026 18:15:17 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v3] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
Message-ID: <awi9hSqATkNygf9A@localhost.localdomain>
References: <20261126040956.3591113-1-twoerner@gmail.com>
 <55a86d60-8777-4e99-b953-9bc733242fca@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a86d60-8777-4e99-b953-9bc733242fca@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 23:15:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5546

On Thu 2026-11-26 @ 11:02:36 AM, Quentin Schulz wrote:
> 
> 
> On 11/26/26 5:09 AM, Trevor Woerner wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > This adds support for the NPU (Neural Processing Unit) found on the
> > RK3588(S).
> > 
> > The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
> > Device Tree nodes (so not all RK3588 devices supported upstream
> > necessarily have the NPU declared properly!) and a userspace driver in
> > mesa (teflon delegate with rocket gallium driver).
> > 
> > This adds a config fragment for linux-rockchip kernels such that the
> > disabled-by-default Rocket driver is built and enables the Rocket
> > gallium mesa driver with the teflon delegate, but only when the user
> > requests its support.
> > 
> > This was tested by running the following:
> > 
> > """
> > wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
> > 
> > TEFLON_DEBUG=verbose python3 classification.py \
> > 	     -i /usr/share/label_image/grace_hopper.bmp \
> > 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
> > 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
> > 	     -e /usr/lib/libteflon.so
> > """
> > 
> > from an image built with meta-tensorflow's tensorflow-lite, mesa's
> > libteflon, meta-openembedded's python3-pillow and OE-Core's
> > python3-numpy packages.
> > 
> > Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
> > currently supported in the kernel.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > AI-Generated: codex/claude-opus 5.5 (max)
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > changes in v3:
> > - rebase onto current master; it needed git am --3way against the kernel
> >    config fragment list
> > - gate the fragment and the mesa PACKAGECONFIG with
> >    bb.utils.to_boolean(d.getVar(...)) rather than oe.utils.vartrue().
> >    vartrue() passes the variable name as a string literal, which
> >    bitbake's code parser does not track, so the do_kernel_configme
> >    signature did not change when ENABLE_UPSTREAM_RKNPU was toggled and
> >    nothing rebuilt in either direction. This idiom is tracked and matches
> >    the other knobs in the layer
> > - drop the kernel version from the README note, which said v7.0 while
> >    the layer builds 7.2
> 
> Why I added the kernel version is because "at the time of writing" means
> nothing to the user unless they go dig into the git history, then compare
> the date to the one in openembedded-core, and then check the linux-yocto
> kernel recipe version at that point in time.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I restored your v7.0 parenthetical, added your Reviewed-by tag, and
otherwise merged this v3 to meta-rockchip, master branch. Thanks!

> Thanks!
> Quentin
