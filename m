Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D012EE6B4A
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 18:38:02 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.356.1770403079587595878
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Feb 2026 10:37:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TQ8UiCWR;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c7146b0854so257587085a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1770403078; x=1771007878; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vN8WSi4IQmZM6Nu3o9ConxNA5zUVT8/hsW5zMZ5iH8s=;
        b=TQ8UiCWRrWuOym23tb0DUs5EXewQnHCE/4L9u2k5joH57W8VAcsdQ/YcJWTmGh9o/j
         qY5uEj0HOwacG3PQ2aZwOC4AVXP9gcJgnCU+Z8R/BqauSV44DBg9DKJSxjLL4Me7df1o
         N9C+5ANtd78bV+yv6ZlEU920yGezKTPkZxuPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770403078; x=1771007878;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN8WSi4IQmZM6Nu3o9ConxNA5zUVT8/hsW5zMZ5iH8s=;
        b=wwFHbdvWn5XYYycKmnsAaxYFTW+zVaufEQDs7XHA0SYv5Se068XZyMY7c19ubnwY8g
         gKOB6ISjqpXGnPlk+OFh0z587cbqsyjbu1p2TMLQEb3jfUOQFKk7Oiy0s5F37i8ze59D
         g9DE79tckMJECRLp0IuesTFiSGTHxbe8xFaKFXx9cQgVT10G5Avb8wXN8k0DkG7flrIG
         3a6d2HjPDT1wLOvjWXG1McFyovXF0lYFPBGK6zRoeJjFGTakeBiq5+uLMDFJV+9nmCjh
         WHx1C7Jn6B8XuB/tbSqJU29uCAOlhSJZzpBAyiHihKKQil/DNXCngWhYLZb+FC2epSAP
         HAUg==
X-Gm-Message-State: AOJu0YzKWOIhUWNeCo1VhbdNKIqZ52muw33G0HO7UD/MLxaVXd4nBOJq
	iKPraZDxhYkHsQXMSOgeOfOoJ7JI3at0zo51fxwNafVRdRyXCHn/N9f3niv15n8vb746GD4N+cf
	vAXK2
X-Gm-Gg: AZuq6aJ0Lu0V579iJ2A7XP9pYnxt7ZaCWYyYBAk0xw7jJ+pTyYmY0Qjn4Qqjl8eNffI
	5uSS9VRXu9w1CnQnkiAyTjALlpI/Mq9Y1Hj3YcAYumDFh7nAQNea9QDCKca/1+o2affaDPwKPe6
	upiWF+PcRtIJobW629C7giCnQ8ogwtnF6tm2ZHanQiSR0hTxTN+gzx/IHwYoA7NfSdHiwO2flrn
	6GH750CCN1KxVSS7VO/NzIE6t7upZxn80vTv7vgXlcWj2LC68miBU31vQmG+E1Hj0lc3rI6yXnu
	3M4ogj0/1HrmaSNkcs2dixIKDIIvo03ns8DimRQvZony41EoTaoBgK068pC86BSo1JJ8ktmsnJO
	Dnt/TrJ1HWadqSzhJHbN0WZ4x8pypwePbrWd/CtPvDGV81mX84UxTGxqUsccp5DPswnBTbZD2DJ
	lAgQeUpM8mKgqieXI8lQAhaVZ2exQTAu6fmQJUlJ/ATUTuGGCyzc+3jIDoSpnxldUWBfI84Q24z
	EWYpv8kjMhi7yVnjDrW+4hiZndcG0xSoEY=
X-Received: by 2002:a05:620a:370f:b0:8c5:3045:3e7b with SMTP id af79cd13be357-8caefeb71a6mr461611385a.26.1770403078385;
        Fri, 06 Feb 2026 10:37:58 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16558sm205083185a.27.2026.02.06.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:37:57 -0800 (PST)
Date: Fri, 6 Feb 2026 13:37:45 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: "c.schlegel via lists.yoctoproject.org" <c.schlegel=televic.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH]
In-Reply-To: <1121335.1770279530420896548@lists.yoctoproject.org>
Message-ID: <4e547f5e-1f1e-ae67-0cc9-0d706de247d6@konsulko.com>
References: <icKu.1770116970811561631.kJ0f@lists.yoctoproject.org> <c1b4d665-f0eb-4e76-b957-1c0aa34321d8@gmail.com> <1121335.1770279530420896548@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 18:38:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3196

On Thu, 5 Feb 2026, c.schlegel via lists.yoctoproject.org wrote:

> Hi Clayton,
>
> thanks for the tips and references! I will learn from them and improve!
> I will look to submit a bugreport/patch in openembedded-core first. If accepted there, we can look to backport it here.
> As far as I can see the issue is not fixed there yet as well.

The Rust selftests passed for me on qemuarm with latest scarthgap +
scarthgap/rust when I tried it yesterday, so it seems like there's also
a relevant test missing to catch this.  If you can also reproduce with
just latest oe-core, getting it fixed on master is definitely the
starting point, then we can backport to the mixins.

Best regards,

Scott

