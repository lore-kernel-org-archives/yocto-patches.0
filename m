Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11463.1794483987702216272
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 03:46:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=ipEQiTHp;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so32070345e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1794483986; x=1795088786; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN87c2BhxtelVQjvmsvDOcl8DFtE+eyG3uNl/thmH0A=;
        b=ipEQiTHpnIYNTuJlAnPUm4O/WK3U7x0Fik/8kjVltCwUb6+zIZ0wqOsbL9faZfzgzs
         k3D4iUjgnh8xaVz/t8c7mAehYo21a4ID8gQDlliRZlPVaKIzAj5TRSWLRlQMwgumkQJ8
         Z267ajh1dkL96lo/nckNsqjbf8DgRMCnmzJMSf3+NCy48l8soaKAMxumGMLNbpv5sm6L
         snan5j+zoBCXskd84RqiyRfuwUBdRjdqUr6tES1bdVrp3YMp44NZC4HspaEcYPvjN1mv
         cPnkaSplCMEZX+nPoTrfLNcRHCfwGeREc9UICbP/tnZAkwxx4aUtJYXbFxV7I4Iw2h/u
         D+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794483986; x=1795088786;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XN87c2BhxtelVQjvmsvDOcl8DFtE+eyG3uNl/thmH0A=;
        b=1CCO08AiyQtT9nh+H69H1b0owZ9p8PGu3CQ7MOhZasspiCnRt3lB4tOTt29Ulzirqa
         YlBiXe2sVIxWH/h2iOPndJv7awAS72Ffix9MXKJ614MVgx5Mzgmf8zWtg8SwabkEhuRM
         Aa3ryPHWpRcWKqRLUiQGWMvJispkok99JfU8mmBLqLVSixbW6o5yIrZc9iYNAsiPKIIb
         gEo5/4IT7otXEhM72P8/1xEEckJ4rrotPsztBqPn8jGrtYC/IiW+EpJ7dbpRx/2aMhMS
         yAmtmpUYvBp4OcFK7sotSdYNq86tj/l83JKSPEeszIUZovJCQ4yWvF0jgRlys8EdoI4g
         Bqpg==
X-Gm-Message-State: APuU4Z9aJaL5Awn8An2tQrFlCOtXayJI5dIGAZW/dlTTTLTPx7/uguUi
	Nt3nyIhQnNkEVScw5dBS2A0SNlvSt8e7T1rJHmLGSi9LzuiiFuwcGhpDZLPzGgKbfYTW4Ayhblh
	QLpWgxgM=
X-Gm-Gg: AYBFou1NnMO1IaU6WMcGRFGE3rECNR76xV0i7jgH5yGGvx5od6Z/Gb0NVvSvDxSMLC3
	71ITOQ0v45A0VCTYu5jgM2uD8a+Qk8ngYsBwxLW2LQLDTEZfbfYp5pwNLhhMmjuJc6PU2HkxEfX
	+TYWgPrPLtTr2nKwSxYirsK09RnV/6qU4TExVkfYuDD/8L/IkhFIz4FGVlGLmHymLx5nHMgEnuJ
	1JW91tuGbZP/YPAJ7g/rfOVu5z2JbvznPZv9ppqh58i981VK0i1/H1pCht0AnPSvnMObKoeWM7p
	f0eF+r5ECgQk/XtIh4/aASR94PPE9Kh8idGuDZa+dSk4XAMab1jRaCiUclPRiOH1tZ2+Mxrkwfg
	UCJmAVC54yIhHJdHTGUvj7z3fY/4pYSaWVaAuKhIdC0v7DRiSnbIeXAM9kUlJ8IN+1Tsck6B13C
	xPm9qIykrWARaIy1cFBfmnI1aIQMyohtJ+/dU3j9M+tcpYODjkRwrDj3YGCqlpu8iMsle4ZcsN/
	bxh8BWn0KAYgx92xpz81GVXtBm5SRrACimuFoks5Qwt5D70dCp7a8y7THBcW/EFsxkORrhTEq8s
	LYkjm8tiNOaN1ir9juaN8W2LWIq5kN0X5i0cKl97bZNH2mDHdonno5JnXEB9OPZn4K8P0HO1IVj
	33QNC5QuqWq2cQhjx
X-Received: by 2002:a05:600c:474f:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4ba093abb32mr99766915e9.32.1794483985598;
        Thu, 12 Nov 2026 03:46:25 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e57504sm105707345e9.2.2026.11.12.03.46.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:46:25 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 12:46:24 +0100
Message-Id: <DMT7HDZT3P6O.1DHC10SI0D1UB@smile.fr>
Subject: Re: [yocto-patches] [pseudo][pseudo-1.9]PATCH 00/10] Backports from
 master to 1.9 branch
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
In-Reply-To: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 11:46:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5324

On Wed Nov 11, 2026 at 5:15 PM CET, Mark Hatle via yocto-patches wrote:
> The following are backporting a small number of fixes:
>  Add open_tree test case
>  Fix makewrapper compilation warning
>  Don't require linux/mount.h (part of the open_tree work)
>  State a minimum gcc 5 requirement
>  Add in the parallel rename/link locking
>
> It is also adding to new files:
>  Add a README.security and AGENTS.md file
>
> Note, there is are a couple of additional pending changes likely
> specifically for Yocto Bug 16493.  This is still in testing and
> will be sent to the list once ready.
>
> Mark Hatle (10):
>   test: Skip open_tree tests when the function or syscall is unavailable
>   makewrappers: Don't generate unused _int paths with noignore_path
>   ports/linux: Don't require <linux/mount.h>
>   configure: Require GCC 5 or later
>   pseudo_client: serialize path changes across clients
>   ports: hold the path lock in create and metadata wrappers
>   ports: check created files under the path lock before recording them
>   test-parallel-ops: Add a parallel create/rename/link/chmod test
>   README.security: Add information specific to file/process security
>   AGENTS.md: Add to assist future developers

Hello,

FWIW, I plan to integrate these onto my stables branches to test them.

Thanks!
--=20
Yoann Congal
Smile ECS

