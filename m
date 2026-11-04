Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13994.1793811416351879012
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 08:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fPfKyd2V;
 spf=pass (domain: konsulko.com, ip: 209.85.161.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-7037daaa820so441534eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793811415; x=1794416215; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dARH1VRsHzpgQcaulA+lWqnBsgrC44kZq6yjnieYl0o=;
        b=fPfKyd2VajS92D2VGluQRvVC+YdYZuNl3i1I5T2kQVgsTISQ19EKHV7IiwWZSc82Lh
         wgZqf2PxFV3xCTLFyorKP7x2jdEt89VHZ2RzmAkrc4WpUrTBMiO4WchbwKqrLgXGYkUF
         glhoWLlWERygpqVGaOhAgK8u3txrcxGA5876c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811415; x=1794416215;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dARH1VRsHzpgQcaulA+lWqnBsgrC44kZq6yjnieYl0o=;
        b=naH4K82nEiJNQzuhc6aCEZpEue0VvZSEFozNODXOxDC+nLbIfKttKqgYbh0teKjxFE
         067ZV0VwKXdvCpVQQ7A8BlyfM3vdxhxNTSq9aLnw7xA/UUkg3CivMuptRkXXMjSQqjWN
         ijCFSEs+4m66bAlCUDCCi4umPIUpxL4Pwxn+8hCU2NofvtzwDOziYQhjixugW5sTEv51
         xUckklJXd2DIcUwl3nVaPN6b1PH6bXcgWGGXHFGBjMu7ZOU7py2zoe9UYqeQ76cQgRjj
         j3AhuiYl0AvvblxsQvV1ONcNahuZWb1FZJ2SQEw6dHGHSP2WINmJBKGSPPYi1E6AUg/Y
         GHSg==
X-Gm-Message-State: APuU4Z+7BAn4fbqP1B9X8gmbVvhst67hXdDERtjhJqDkDQtwY1Anj5Hv
	XClJPqpoBD92mMelhCmUh7+Bp9LXuYHGOvXZ8ty4fTMMH2yBvS3HZngvjzorxeVqmmGlesxtcqj
	jkyzKvro=
X-Gm-Gg: AYBFou0IFhpGHO1Pb0DkjduQttY7N4EqSuFEVz9ZHdIUvJT/t1BVX/XOp3VCIeHk2mj
	gAjggFLkZsrhCtIo5DWfyAGcKE/z9EyCaEf0rCXCGl9WseRPUNZ89A16OMo0GY1Edpshh+6nCzu
	9JuKn8VSGizoMgJ3iTYH+hxbR+RtAryxFSxZ1YGFSVgQ03tM7h9RSBqcwWpvr8LMBFBEU7GWc0h
	SdzNFDoKY1W8gMDyodOe8abEwYSO+aTnyN5atN937nS+IAouQOvu1U9ve64SpRm0Xog4FuUkScD
	QpRFZcks8+H2hG2cW6WIyjinBw9rAOC8rPuOZLSTH77PibEG0daTyVgSlCqBLqaO0vzfgmTkuuP
	YMn0b/H+X1lbZFbRTugt95NBZDvDKxtbTBKsUFSPCBGVOvQSwEFh4XR2fVoIFrYyMTDqD4jcRlx
	dLufRDLCJzgDnfG1jDkgvCAmGFhLBhZBj50tvY9RuiaT8H9VYW4erOHuNlqm3Pcukg49vBvQ8MU
	1W2hM9wkUknJWnAzL4FIo8muo29FE4XXDv3uP9gnEifoTHPQ60gCYFVwwEkO4X9iCT+xYn7yZ+m
	FHxm/kDKv33FicVwGsAbmyFgC9kfZP0R1sYl7z48YlUPR1PavSQ0vpo4n0Zb2yc5B4nCZ0+yvW8
	Qw1EJFSuJE2z3ydFIyCMoPjyDQLCTWv0PVj45/GHknDmBuTMEwstJsyo=
X-Received: by 2002:a05:6820:338c:10b0:70a:6888:224d with SMTP id 006d021491bc7-714f2a821c5mr6731677eaf.69.1793811415099;
        Wed, 04 Nov 2026 08:56:55 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c1254321sm2031987eaf.4.2026.11.04.08.56.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:54 -0800 (PST)
Date: Wed, 4 Nov 2026 11:56:53 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 0/4] Assorted updates
 11/02
In-Reply-To: <18E45BFAF1906B48.173316@lists.yoctoproject.org>
Message-ID: <421481b3-6848-29c1-f8d9-cf35ff5c1074@konsulko.com>
References: <18E45BFAF1906B48.173316@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 16:57:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5234

On Tue, 3 Nov 2026, Scott Murray via yocto-patches wrote:

> This got a bit hung up a bit getting through CI, there are a couple
> of recently submitted fixes, as well as a couple of build fixes
> from myself.  I have pushed them to master-next if you want to try
> them locally, and plan to merge to master by end of day tomorrow
> (11/03, EST) if there are no objections.

I delayed a bit to test the fix for tpm2-tools + OpenSSL 4.1, the
below changes and it have now been merged to master.

Scott


> Changes:
>
> Leonard Anderweit (1):
>   tpm2-tss: update to 4.2.0
>
> Scott Murray (3):
>   ding-libs: update to 0.7.0
>   swtpm: Add missing useradd inherit
>   python3-tpm2-pytss: Upgrade 2.3.0 -> 3.0.0
>
>  meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |  2 +-
>  ...0001-Handle-CC-values-with-arguments.patch | 51 +++++++++++++++++++
>  ...s_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} |  5 +-
>  .../tpm2-tss/tpm2-tss/fixup_hosttools.patch   | 13 ++---
>  .../{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb}  |  4 +-
>  recipes-security/ding-libs/ding-libs_0.7.0.bb | 11 ++++
>  recipes-security/libdhash/ding-libs_0.6.1.bb  | 12 -----
>  7 files changed, 74 insertions(+), 24 deletions(-)
>  create mode 100644 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch
>  rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} (80%)
>  rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb} (94%)
>  create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
>  delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb
>
>
