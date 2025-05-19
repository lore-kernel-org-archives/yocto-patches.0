Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E28C2D0CD
	for <webhook@archiver.kernel.org>; Mon, 19 May 2025 14:38:44 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.52757.1747665515702923495
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 07:38:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fAFylUQL;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a3758b122cso418702f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747665514; x=1748270314; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwly//H1Q7daGNgHVV9Ht1As/vJUkoB0NrtuKEKAwto=;
        b=fAFylUQLj+kzGSgr7ZDe634qxGdH/8js0e7IoqHaAdFYAnL+mBM7FMTy5l8Om2aUHA
         yc4ZgErSGD/WyYaGfF/6v5QhLb/bDb+p3ZL5iAFSUveiTR2Rddb/xG2d1R1FoEJBzCB8
         sMxVWfeNtDxmX9v8F7+fyjy1xC2HCJ1+yE5ZRz/2Ou6eORsYpQeqRKkpivG7Uj0gLxkJ
         QhRtthOXUC60YdVgtu6GjVCY4M7S1IOBC8FlQ+q0cs9UxbElxs/aedd/v6svUGUBdDcP
         9r41dFbAAAXWIswoQbHJD9XKjhSlY8p170MHzWg4DeX9oOxK9OU4VH8TGwK7avHsvHWi
         A6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665514; x=1748270314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwly//H1Q7daGNgHVV9Ht1As/vJUkoB0NrtuKEKAwto=;
        b=wryO/SxCUmLx4o63wedhZBQdMD6UJRz4/RBwBStZUdlPQAeCpycCbV3xz0HZPqvYXi
         i0S5JM39Y57Gni/n9sud2sO/GL0IPSyS3KzaH6+CrUBmzrCT0yaUxXHcmb4zUPbSwUS5
         5wI1JlyDgD9c8RukIXktrqUHnMrKc166YuciY8CBU6VpSOPc0KHCgqLe8ExaUt8xQmi2
         8XsmQ+HeEq1HehzBQrgdq6Pcl5JQg+ceiE7uqNlB6PbwcWBez307YeuQxuxj27zdWWQO
         3ApEWep27roOguY4Z+8ifCMvW231BkuVDoDlPXO2kIt0n6cqb1y7AwI6mdSihAoFZ5lV
         fbmA==
X-Gm-Message-State: AOJu0YysekmokmSW8WtIa9mCD6pa7vRNou0H6Hs8alsedUVCU3XkyZ9f
	zWTj8mdn6r496aZPF72OG6E+KAzxUvKFP1tdIpgjZ6l/oiifpmtZWKIRSIK1Hc0a9U/AW1tH8UW
	xgFlIHo0=
X-Gm-Gg: ASbGncvgSa4bYtDYx+hud6EQBCp35PnhEMUIWWfdFjME7Ivb/GxVnoyU7YTTZmyGXyT
	0JEiUhGCOY7lF+Ld/YzpDd83XEHMdYLb2USb6/Ty8/xDTXlAPzM8+mRPe2mmKFCI9cjQUyi0W7/
	ZlrL3cQU2CsuM7vMGRWx49UdCf7T63xwd6x1LluklSUaG3r6jSVEi1dgu1dmat0DdySk/0pvmae
	l0aog8L0WCcQ2F6R+HV0h1Kn1IEb7bkcgtJkTeA68UWGp3sFXWbtjpv+8TaBub+UGnIwJhwliy5
	QIKa1fS9bcUFVNPej2+SmDuWeFSkq0qhFvCIUfXFCDp1GGyJ
X-Google-Smtp-Source: AGHT+IF2hCiEdwzBiT1B0Ct/01F2Z2k77p4Np2EyTq1xEWJpcWUPn3nUfKY/BE7yny0HvV79zzdfnA==
X-Received: by 2002:a05:6000:400d:b0:3a3:648c:b5b0 with SMTP id ffacd0b85a97d-3a3648cb5eamr7005459f8f.15.1747665514093;
        Mon, 19 May 2025 07:38:34 -0700 (PDT)
Received: from nuoska ([62.48.241.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6265fsm12804366f8f.43.2025.05.19.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:38:33 -0700 (PDT)
Date: Mon, 19 May 2025 15:38:32 +0100
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>,
	Khem Raj <raj.khem@gmail.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Trevor Woerner <twoerner@gmail.com>
Subject: Re: [meta-security][PATCH v2] systemd: disable linker GCS warning on
 aarch64
Message-ID: <aCtCaKvyn-8DnF3o@nuoska>
References: <20250507150247.1408201-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507150247.1408201-1-mikko.rapeli@linaro.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 14:38:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1563

Hi,

On Wed, May 07, 2025 at 06:02:47PM +0300, Mikko Rapeli wrote:
> openssl asm code is missing GCS branch protections and
> linker throws a warning which currently fails the build.
> Ignore the warning for now since some branch protection
> is still applied and only GCS is missing. Works around:
> 
> .../recipe-sysroot/usr/lib/libcrypto.so: warning: GCS is required by -z gcs, but this shared library lacks the necessary property note. The dynamic loader might not enable GCS or refuse to load the program unless all the shared library dependencies have the GCS marking.
> collect2: error: ld returned 1 exit status

To conclude, this was fixed in oe-core/poky instead.

https://lists.openembedded.org/g/openembedded-core/message/216132

The other patches in the series are still relevant for meta-security/meta-tpm.

Cheers,

-Mikko

