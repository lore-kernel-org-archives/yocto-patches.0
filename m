Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDBD6D238
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 20:11:02 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.80901.1732738261092859463
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 12:11:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TDjmqGGo;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46690cbec70so905021cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 12:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732738260; x=1733343060; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4e2NIo/6q7dN7pE9hnkOiBem4hRuzZch9E1cupwxm0=;
        b=TDjmqGGoG5LktidmiPHsWFSjaoPbV9LFASClbmRMBb5GQljLXzTWEsat3zBVqDTJpK
         YUH6p9rzWFbswmiF8nQUiCFvh2aZVYA6MqEki5FqCPm6HZPtbDuEx39yU+2addprreck
         Ju+8T5LeN48WvQzhiiCbx///K9uNOYEMzlggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732738260; x=1733343060;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4e2NIo/6q7dN7pE9hnkOiBem4hRuzZch9E1cupwxm0=;
        b=GKDhPI2NOvamm2SLgMd1SLdQ2d57EAIJN1bIHeOGRe801o1x4Ech9zwHEMWv0okPiU
         SJLxfvH5cWL/yUr1ARK6VArE2zxQuDeIfdawC4tLUEW79T7Td+Okoj1sOIUkntHcQc5D
         AAumdMftTaEHVbSf1p1WDPaN0d5K9KwXoPODKHTQ6jwhteslvtkZ09XDDV03QaBn5SbG
         OEqBkd29aQFo9KVlkzctEQumtqTRf6y9f9VgGg+2rBQBPgFaGD/xyIIQGrPNUdyegdy1
         Dub9tEx2LzGw8s/ijHphdL1CBkCaMwtaJAkmGVAediAoxQgcYftldZpDBtDL5cVHcJMm
         pRLw==
X-Gm-Message-State: AOJu0YwZoWCxd0L4UNOvfWWI63IZwLo34dBHRWqLHKGTosylSpz4pqT0
	+f7nNDE9kYjxBGXSjeDpOUvWLUG6UkSp6aFSQkpsNnWEUd+1eM1Gljg3JdtdL+95P3m4G5oMWLH
	1
X-Gm-Gg: ASbGncuU9DAKXUrryzTbDP8S6uiPd61LObozSMWGaS1JdkfodBrZoaUvWwkbsKVXQZA
	lvMS6tVJPPAL5zkydMQGqUCmVa9aXcJNDDSelYB76IcHnXkRgJ1cYw5GfFckSpjWGiwvL54VhHP
	sRlwalN7cHyPD4vvEGIOx42dwQo9UtMAbLB2lQhfAAkGck2smRsdVToR7oesEpAR377tiW2TrBE
	1PjIiaP61wXJw25bHD555CepPE4LSVKBhU0ov1XtpaRJPS+lW9vLnpm0SVvGSzSwFOI2sQEV1UJ
	2jN35BpS
X-Google-Smtp-Source: AGHT+IGIuYzBzf2uiNj9xNKYHGFPlAS6sOF844mXwVJj7UVwUjoq/HfsqDntn4y1tkP0AVNGo9bBPw==
X-Received: by 2002:ac8:59cc:0:b0:466:9b80:d8f1 with SMTP id d75a77b69052e-466b366245amr67325921cf.46.1732738259842;
        Wed, 27 Nov 2024 12:10:59 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6652d048bsm396246285a.75.2024.11.27.12.10.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:10:59 -0800 (PST)
Date: Wed, 27 Nov 2024 15:10:58 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 0/9]
 Upgrade to Rust 1.80.1
In-Reply-To: <180B97340309AC8C.7301@lists.yoctoproject.org>
Message-ID: <5e40eaed-9cce-e038-824d-6445bbfca2bd@konsulko.com>
References: <180B97340309AC8C.7301@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 20:11:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/848

On Tue, 26 Nov 2024, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to pull in the
> 1.79.0 -> 1.80.0 -> 1.80.1 updates that have landed in the last few
> months in oe-core.  As the layer README.md mentions, the interim
> versions have not been tested at this time, but in theory they
> should be usable if you point at the appropriate commit.  I have
> improved my backporting process to try to better ensure that commits
> are in the same order as they happened in oe-core to hopefully
> work better in that situation.
>
> I intend to push this series to kirkstone/rust within 24 hours
> unless a serious showstopper is pointed out.
>
> Deepesh Varatharajan (1):
>   rust-target-config: Update the data layout for x86-64 target
>
> Deepthi Hemraj (1):
>   rust: Upgrade 1.80.0->1.80.1
>
> Harish Sadineni (2):
>   rust: Upgrade 1.79.0->1.80.0
>   rust-target-config: Fix TARGET_C_INT_WIDTH with correct size
>
> Peter Tatrai (1):
>   rust: Add patch to increase timeout in process-sigpipe rust selftest
>
> Ranjitsinh Rathod (1):
>   rust: set CVE_STATUS for CVE-2024-43402
>
> Scott Murray (1):
>   rust: Restore CVE_CHECK_IGNORE
>
> Yash Shinde (2):
>   rust: Oe-selftest changes for rust v1.79
>   rust: Upgrade 1.78.0->1.79.0

[snip]

These changes have now been pushed to kirkstone/rust.

Scott

