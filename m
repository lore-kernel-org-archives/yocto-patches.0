Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC64CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 15:09:28 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18851.1763996967653556371
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 07:09:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Vi8nyJ4q;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed9c19248bso39320871cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763996967; x=1764601767; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KrJkL9QEz/e86+XfloGbXafPxpt/cW8fpI+Wrk+tmg=;
        b=Vi8nyJ4qqkOf+bwUyMB89ET8qra/Ekf/Hr4IyMgrl5BEZsezmrvl3XVc/rGU6KmRHr
         smSoHNVE18wE7yRXIJ1otcaBXyjDFl+m72jrkxU7GN4Hqcci9qdlushAgzzGk371cXpK
         C2RKSh4er2CeBbp+Ocs+fjIwY5p2yw0J4XWpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996967; x=1764601767;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KrJkL9QEz/e86+XfloGbXafPxpt/cW8fpI+Wrk+tmg=;
        b=EXlNGy+dpluA4K+ppyfqqZm/A3lPMyNg0YQL85yMV37gyoBlYbTH9eV4B2/QjGDESK
         MjCwi7LnXDG708x1Ce2MUjNkDX8eYZMPBSQd2P17/5c27c56AoSeo/Srgu8iBQTkaLhv
         cWq5m2xIASsvRtQ4GOZqx8BaR21fCWrz4g7bF+iRGgekMUK7ejSf+053bzi6yXOZRFNh
         +KFIWhDR2y81O2t8s4XYOlnZJ2OfYacuuVeJQomGEHRs7qn6gD2i4zeROTenc02H+pR/
         FLQi/LN2rKNik/RzlCFIVb7Vn0NxvOGV5bl8jos9IAWgNxe6+xDCmb6JTOSWtROPYKXs
         royw==
X-Gm-Message-State: AOJu0YxKDFp/Ruc2P/kZI7mCnEhb7AKsz+MCoLxI0po3GzpoScmK2Iuo
	rFAQiG8lexVlRb9eO5QWgEvZb4EMDKcqFzRDloVgNc6Ze/URtsJ72xtQpmbSz9gTYmo=
X-Gm-Gg: ASbGnctzjM5Be0f7o5VP6T+Cw4cH2eJtJ8Ew1acGG2ZCdW2Ad2bCxFBheympQhi+hlG
	LWVRyZdm4BTyzoBgFWirqy2TnvbMZaeV3tIeHnj0WkieTflD5wbiX+riaBL7qW+p2WIgR7QCvEp
	IV7RWW3hI/RGgKzOmw0CJ2mAcuzJqrC0XGSqsd5PsqiC1bH2Njq0S56/YzvNH+KFTg3ovbDkkJ/
	hx59JYLl/Xp1SaxSAUw+/GA4u3StY6rf1v5oGNQeo556D4niTgzixWcumNFVp88ZahG+DP2dYbh
	tE+mTcl60v5biSROa2SugxROWBAhDcofukSrK25S2Kmub+TsETTIw5VanrJ/+V7IlBkG+RjqKHy
	KgFhNDxc1nZ+xGhkV5drjvgkFW40mJMFwtaLlL+6xwflaXGlKH5BJOSJ89nKDhx394sGrvdgH6D
	o8ueUH0YsviRE0KV6B79FlRdP8aPjZW22jll3IA/wk4FfAXpz7TfjhrY/j
X-Google-Smtp-Source: AGHT+IEzuGYnXMyeqVObhpJusGIWGFJ+39h10uIGKFSWdFe4NCwj/Itljd+1JWI2AN+ZAblm+o85gg==
X-Received: by 2002:a05:622a:494:b0:4ee:4a3a:bd11 with SMTP id d75a77b69052e-4ee589263b0mr154820361cf.64.1763996966083;
        Mon, 24 Nov 2025 07:09:26 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329528337sm959706985a.20.2025.11.24.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:09:25 -0800 (PST)
Date: Mon, 24 Nov 2025 10:09:25 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Hemant Jadhav <hemant.jadhav@emerson.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 1/2] clamav: Add recipe for version
 1.4.3
In-Reply-To: <686098.1763996152543724259@lists.yoctoproject.org>
Message-ID: <1c348ec0-99e1-a701-a3b0-db856d6981d3@konsulko.com>
References: <20251120231345.1004458-1-hemant.jadhav@emerson.com> <5cf5a43b-152a-099b-1aaf-b5a5f7a9a129@konsulko.com> <672520.1763935693231696616@lists.yoctoproject.org> <2a78e262-0747-923f-4deb-43036e22711f@konsulko.com>
 <686098.1763996152543724259@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 15:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2697

On Mon, 24 Nov 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> On Sun, Nov 23, 2025 at 05:57 PM, Scott Murray wrote:
>
> >
> > Okay, thanks. I am surprised you have pkg_postinst calling
> > populate-volatiles/systemd-tmpfiles, AFAIK those are run by
> > default in early sysinit, and shouldn't need to be run
> > per-package. Did you test without the pkg_postinst to see if
> > that worked?
>
> Hi Scott,
> I actually added the pkg_postinst:${PN}() purposefully after testing it for uninstall-reinstall on running system scenario.
> Here's what I found:
>
> **For Fresh system boot**: volatiles/tmpfiles work perfectly and create the directories automatically during init.
> **For Runtime package installation** where I manually removed/uninstalled clamav and removed directories: the directories are NOT created until the next boot.
>
> Without the pkg_postinst:${PN}(), when installing the package on a running system, freshclam fails immediately with:
> "ERROR: Failed to open log file /var/log/clamav/freshclam.log: No such file or directory"
> When I manually ran `/etc/init.d/populate-volatile.sh update`, the directories were created and everything worked correctly.
>
> So the pkg_postinst:${PN}() was added to take care of this scenario to
> install or upgrade packages on running systems without rebooting.
> So that package is usable right away.
>
> I can remove the block of code, since for the fresh system this is not
> a problem and usually user will reboot after removing and package. Let
> me know your thoughts.

AFAIK this is the expected behavior for system-level tools, and you do not
see pkg_postinst used this way in e.g. openembedded-core recipes.  So
please send a v8 with that removed.

Thanks,

Scott


