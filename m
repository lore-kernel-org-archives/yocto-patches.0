Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A87CFC28B
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:52:07 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13075.1763736718839454885
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:51:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QU91pI+w;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-880576ebe38so23484866d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763736718; x=1764341518; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j77+BsImSV8g/HsWSiaWcdVCK5a2AHFFGicS6qNPgIM=;
        b=QU91pI+wyZgEv+D6KD775bHg+EV7uqtjMtdKqRFpND93pBG73Gx9q/G0LsXSdGdWxK
         6oy+uM4t0eE0y7T1K7dV1RCkj0TmwBu21luMS5ft31ZxcAQZE+RPyLUC04tJdKUgsaLy
         csPWTtZhA22/JoQnpfHkRHANv4qdNsuHQSyx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736718; x=1764341518;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j77+BsImSV8g/HsWSiaWcdVCK5a2AHFFGicS6qNPgIM=;
        b=bGM1FPswOS9bT9yE9UqL5bNQXtwLwS9jJqQHHTx1DRRrnkDDy9vsRy0gIZTOawdlea
         WBP1kOED7lQyhd/Wi8AoLb2TqcMX7U5yLNxMI/PAEXK0AK3bOm9iDbzjoaZYXUcVMM+b
         w/R/UeWLiwoyupk2u9WVoBAquLMtsZPAJxXEXiOnMWQ6cbHjK3hdjQ35lodhpKFlp4aw
         MzzE/T3c2cvgvfMlf8rNM1t7LPvFoiHpISoLBb5E/GMToEiifW+AIvXqm+xqodDd5/Zx
         6aCidQejQ7SFsNOxYkIBeqew/kW3yUPVUPPPXfJB9PMh1feLpQAMQGlAzcrDBDO9HXPd
         h8Yw==
X-Gm-Message-State: AOJu0YwIuOOqIxxeCmJUp9YZYsa2zM2yr0ijy5tM9862qz7y2NcKb5CW
	+AQV5WTW901hvuco32mZ9Hq/W6T/mUBvPmsFFmYDzWwg3BhvZ1/kZliMbeRfcs7hQ38=
X-Gm-Gg: ASbGncv6BjqfeTRIeFi2cmLri7uxsqXsP1DYJmp1UUsMv1GSNI0B3ZeFYczMHRPqfKn
	C9DKa3me2ZMtGqrq5E53NyfRaIPElfb7j1QL/i+91HGhXkb/mrvOB06TtyrO26pvNjEDeaQPMUu
	7OgOvKivSwqXzC6SmKaZ3NrVBbOtHp9iiEG+7Cv3ZaWJ1vGT5mYBgPHrh4y0WXVCOmXr/9To4eg
	aA8DWZ/3KB1o5XNS/AoXfWqeV0fqwgevmRhIwFaDXfWcAz4bMne7tKDmzMFuEukE1paiaxj/Oj0
	GXbXABKnR/I7Cin2ADOjHHx5L9llSZAKWLwLswIaOlqQ2FbezEIM4+3iKVCV0pr0ixeJsVtPiDa
	yuE/UZ7Wz4EzvxhokAT8msHx33uElGKpiCBuXEFYZ8TwstXZOqx9DB7+AnZC1QBJy/f/qzTTNGM
	tsncjzCPPxfiNp43J71GFNhXvTt26fNoz8/vuzF8CDfee7cA==
X-Google-Smtp-Source: AGHT+IEs/pj7M/7NgOdq1QBVzJGNFIHZAtWA0hB0XILe8wOH5g9zxI0ZnB3FYL8x2kr/BvwyY7VHOg==
X-Received: by 2002:a05:6214:e4b:b0:87c:226f:f5c7 with SMTP id 6a1803df08f44-8847c548462mr37962856d6.38.1763736717528;
        Fri, 21 Nov 2025 06:51:57 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e46a4b2sm40111016d6.19.2025.11.21.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:51:56 -0800 (PST)
Date: Fri, 21 Nov 2025 09:51:55 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Louis Rannou <louis.rannou@semalibre.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com, 
    pascal.eberhard@non.se.com, yi.zhao@windriver.com, 
    Louis Rannou <louis.rannou@non.se.com>
Subject: Re: [meta-security][PATCH 0/4] openscap: upgrade 1.4.1 to 1.4.2 with
 fixes
In-Reply-To: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
Message-ID: <7f3fa589-dabf-388f-6430-38065904b683@konsulko.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:52:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2651

On Fri, 14 Nov 2025, Louis Rannou wrote:

> From: Louis Rannou <louis.rannou@non.se.com>
>
> This series of patches makes an upgrade of openscap and scap-security with a repends fix
> and other minor corrections.
>
> I have based the source on the well formatted github release instead of the commit
> sha. So let me know if that's incorrect.
>
> It also includes a runtime test and musl fix.

Just a heads up on these, I took Yi's prior upgrade patches since they
didn't change SRC_URI for openscap, and then applied your other recipe
fixes on top as a separate change, please take a look to see if I've
missed something.  I dropped the musl enabling changes, as both openscap
and scap-security-guide were still failing to build with musl for me
with a couple of different errors:

.../openscap-1.4.2/src/OVAL/probes/unix/process58_probe.c:161:18:
error: 'PATH_MAX' undeclared (first use in this function)

and:

.../openscap-1.4.2/src/OVAL/probes/unix/linux/systemdshared.h:188:50:
error: implicit declaration of function 'basename'; did you mean 'rename'?

(I saw this one in scap-security-guide as well).  Please test locally
with latest oe-core master to see if you can reproduce.  If you cannot,
we'll have to compare notes further, though my test build setup is pretty
plain.

Thanks,

Scott


> Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
> ---
> Louis Rannou (4):
>       openscap: update to 1.4.2
>       scap-security-guide: update to 0.1.78
>       oeqa: openscap test
>       openscap: fix musl compatibility
>
>  lib/oeqa/runtime/cases/openscap.py                 | 48 ++++++++++++++++++++++
>  .../{openscap_1.4.1.bb => openscap_1.4.2.bb}       | 16 +++++---
>  ...ide_0.1.77.bb => scap-security-guide_0.1.78.bb} |  4 +-
>  3 files changed, 59 insertions(+), 9 deletions(-)
> ---
> base-commit: 9f1d763bb17bf105cc313a95eb3b07496b34bacc
> change-id: 20251113-openscap_bump-5c33d1ab2ceb
>
> Best regards,
> --
> Louis Rannou <louis.rannou@non.se.com>
>

