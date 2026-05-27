Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C9DCD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:02:25 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15275.1779868940275936485
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 01:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dtaQxCJi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90d042fa745so2050473185a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779868939; x=1780473739; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvYwxfrvCGecA/SVg+G1BGaEDWevBRhEiP/JkmG1PAA=;
        b=dtaQxCJiyp71vA7KDI4+Q/n7/fv3xAlpjFNSoHA09+y1xRtAVIl4kY647Gizc3ND9K
         UaWwLasrw5/eALLiRZ+/4QtARp3HVWkvfPeJqbfLgS1pnvmu/mYujhwbPbKCwrjKhD9R
         7ytQ2XgOo0/AQCZLzk/ESjrX8sk4SnJ6y/mfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868939; x=1780473739;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvYwxfrvCGecA/SVg+G1BGaEDWevBRhEiP/JkmG1PAA=;
        b=XkNM+azikdh9mCMwBAm2KaXOm3irijcDVJvcJRdewSuOL4XuF2xBFANlDdSQaKDv6E
         kAHoFEJvHu8aFdPmXEz7tR80nzbW9tCFqWkbARgOal8IPeydKi8t/POyiPlkUheZyJf5
         rblsMEb34HQUXxHalo5ins3jC74BB7fec+uIvPDp0V+LoLA4wT+vydpdd3uJ94tAntfn
         21ssdTmsjgx19d103GzkJtqGniLQaw0BqgLQ9K8N60JF2wWM8PKCrRIUZKvkV0ZjRrHI
         8Fi6vp0te82Lonz4l+yh+4znxCB6qYnE354IuNLlKj1Z1QlPwp21kqMe5qSvS1NIvEhG
         3T3A==
X-Gm-Message-State: AOJu0YxouR6o4X+tMV3gsckyKS+HUIS1gh7KkudYB91DQbNAyvdt5DPA
	X3ZHbbJMXxGOUIya6ONRN64CMxZtE3IjMBLt5V7IcVW/fVbBNd3i0QfvhdG8BUq9rZO3bLOsp9V
	bGmwJRMnrCQ==
X-Gm-Gg: Acq92OFaP8IRLMfKKquwdm4Rn20jdZrjmAQY+jpEtXKsNWNKudzYHmL0cF04w29OHJx
	VxbyCALr3vdRQXVSZCaU0kQXqgtAX6FSq36yS96qFcUBMxUCNlhzDw+KCyrPZFNFag9xsQFd5QW
	JK8htDjLfo48j2eYjlLKo5ttffvcJX5pHboD4T9NqGdTi40pRV+W0+cjdFZRZb/fZl2/SwO0rbf
	lCooJ3vRbuyjb+pgK6gbFaBxkIdeYbfoybJ+btE80EJhdchTqGBb4Ul8g23jaxlAXDLueMnq9bD
	hHl5IA2hG+SboRW9pb80uMU5/s34pb7Djll91QQRRmYYoYeaIGTTGzNdgvxw2++dVcJL5xsbl8N
	UbjdOtAFMEr6grOd43HkNNuFr4mc90ozFj/N2W0CrUOBZkiUOjBKx0ssBf2xUBSlJ4Ahj9yFRxZ
	XWgxgSvyLP3thoWi3/IZ6d85P8ddbw5NHJ8Jzu9bikxG7m+qB2v5dEbx4pkUStbFRWiVeaVaK7j
	U0HbZXJWfcbS7BayBjD2Kbqr07+d74zExYJiU/IClfik6ITcxQ8F4SIeg==
X-Received: by 2002:a05:620a:2a14:b0:912:f766:78f5 with SMTP id af79cd13be357-914b48f4dbamr2990501185a.27.1779868938796;
        Wed, 27 May 2026 01:02:18 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86ed28fsm460439485a.1.2026.05.27.01.02.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:02:18 -0700 (PDT)
Date: Wed, 27 May 2026 04:02:17 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][wrynose][PATCH 00/13] Assorted
 updates 05/24
In-Reply-To: <18B280231BAC3BA4.3209974@lists.yoctoproject.org>
Message-ID: <6fc8901b-35cc-6c32-3e32-a318c5172fdf@konsulko.com>
References: <18B280231BAC3BA4.3209974@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4064

On Sun, 24 May 2026, Scott Murray via lists.yoctoproject.org wrote:

> My apologies for the delay in getting this out, this patch series rolls
> up the contributed patches from the past few weeks.  These changes are
> queued on the wrynose-next branch if you would like to check them out to
> test yourself.  I intend to merge these to wrynose branch Tuesday evening
> (CEST, May 26) unless there are objections.

These changes, and the tpm2-pkcs11 update I'd missed, have now been merged
to wrynose branch.

Scott

> Changes:
>
> Anton Antonov (2):
>   parsec-service: Update Parsec service version.
>   meta-parsec: Do not run Parsec CI jobs on 32bit platforms.
>
> Bin Cao (1):
>   samhain: upgrade 4.5.2 -> 4.5.3
>
> Li Zhou (3):
>   firejail: fix COMPATIBLE_MACHINE setting
>   layer.conf: correct WARN_QA
>   aide-base.bbclass: correct STAGING_AIDE_DIR
>
> Peter Marko (1):
>   tpm2-tools: make efivar optional
>
> Ross Burton (3):
>   parsec-service: assign PACKAGECONFIG in one line
>   parsec-service: do group membership modifications in useradd
>   parsec-service: update TS group name
>
> Yi Zhao (1):
>   arpwatch: fix typos
>
> jason.lau (2):
>   google-authenticator-libpam: update 1.0.9 -> 1.11
>   aide: fix pkg_postinst_ontarget shell script
>
>  .gitlab-ci.yml                                |  12 -
>  classes/aide-base.bbclass                     |   2 +-
>  kas/qemuarm-parsec.yml                        |   6 -
>  kas/qemux86-parsec.yml                        |   6 -
>  ...Fix-unnecessary-qualifications-error.patch |  50 -
>  .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
>  ...rvice_1.4.1.bb => parsec-service_1.5.0.bb} |  30 +-
>  meta-tpm/conf/layer.conf                      |   2 +-
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |   5 +-
>  recipes-ids/aide/aide_0.19.3.bb               |   4 +-
>  recipes-ids/samhain/samhain.inc               |   4 +-
>  recipes-scanners/arpwatch/arpwatch_3.3.bb     |   8 +-
>  recipes-security/Firejail/firejail_0.9.72.bb  |   5 +-
>  ...bb => google-authenticator-libpam_1.11.bb} |   4 +-
>  14 files changed, 533 insertions(+), 473 deletions(-)
>  delete mode 100644 kas/qemuarm-parsec.yml
>  delete mode 100644 kas/qemux86-parsec.yml
>  delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
>  rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.bb => parsec-service_1.5.0.bb} (78%)
>  rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)
>
>

