Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A647CA5FC1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 09:32:35 +0000 (UTC)
Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9549.1790760748433473758
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Sep 2026 02:32:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jNngv/HC;
 spf=pass (domain: konsulko.com, ip: 74.125.227.37, mailfrom: scott.murray@konsulko.com)
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5d4129be80fso470323e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1790760747; x=1791365547; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfUWPmqKfQO1Kf7J3Nylv/FIsWyU5cOsxmlzCncm/1Y=;
        b=jNngv/HC+PePVXd7SKrCI+hsDHJQc/Hf+3KsCVFGi1buSEqV2bzpaVHW4HQVo28vmk
         vwgvzWbtGAm0UjAbd032Y7TB15Zz1uK8JPpk2Of3sw9anw69Jc2BOw14xpBcaZ4zgez+
         0R4ZWNOBwF0ggJw9VHPjXbRhhs7/nF6Vj9Src=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760747; x=1791365547;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfUWPmqKfQO1Kf7J3Nylv/FIsWyU5cOsxmlzCncm/1Y=;
        b=DDb8EAGxSOpvEYM3lP5pQzqu/P7yBiqk/BSyqM3vVdAoSRMI2RdYZUGlGXGCamO6/u
         ce3C2o1NANtDURN/+ijLrhlpasY+Qg/YKClD/ZkJaDttOs7Y6cVHS2ydUsog2nSJyiNQ
         yvZGcaq+TPe3vl9xcEaZyfUjsiwgW7dPEqJce2giAso9MaBS51atZ9PBDQmOnTRZVr7k
         cxcoPxM+8c0TDGubwvnc7d5R7CFPDh1gpsymjLwXVYanXVglvWJ+6b3E9aCABhlNqexj
         Vs6jDhXSXSH/KVJZbfceqIHDJHcVBcT3xn8j5NY8fPABJM8r/8hDX1Ws6bnmT/bGYMZE
         DJ5A==
X-Gm-Message-State: AFq9FYI1kz2vFRTkZRby4b1UXw8UYLRp+pk0KpphyuT9oam/nk+2AXo2
	1wVCELXcHHrXBHSdCDR6t0XX7kdj9NijvingIkBLILE86g/poQ9y2b4JXqK+2e6pOHCNWE/EFQt
	OMTrfoqQ=
X-Gm-Gg: AYBFou3yuh/5Gca71q4HBvGVP7REZLFH7FaYu+N3wX2ZKRm9BWAhysFu5rTzR5konSM
	R0ZPq2XyZfT5h9dPfW8VtXVu4vGicayhSgbDmcnalTV2qvWCmoO4ksp/zapvSVrI5VjtyJ0szim
	I2bZdm6XAtskXIzetdkGXkm+xy7vT3ARAIeKHDSUrwdqGlZgDuBiooFNgCSlFowe2coGCEctjlG
	mrzI4d8fq4eRGdVoU8b1wlrv5gQCeIbkPUFUclwan1OVzvUo2OxGpWmpWw5uO/sTI9mu2tGzOc3
	7+FsW0E9UtpQL4KBN05aTeC6eMQh6VFbZ8oVYV9Af6ATXfs0ZsngEZ9GqEF0vu6gtRrV9TozS7Z
	DLFYAvNL4pDD7JgjX/rMYBkMTMCVCU3E48RO5FxtBDseRezIBkIopE9gK9VFPp9TNre7+dFi/B7
	Z4+Dhm/Cz6lC7OZx8+gR1VuRoCTfKw7SRnZIar5sVv+70g139HMW7fEiFklBhw6d5U9NcvQDJHh
	v+v/TyD74xSl71W4QwCmjCuvWOmu4MlL0pAO6n+doC55/sHFzvaTwz3Gw47vV+jZ+chURWrESLl
	7CFJ0smZr74dwvAgYw==
X-Received: by 2002:a05:6122:e44a:b0:5d0:e3b7:334f with SMTP id 71dfb90a1353d-5d67e5de03emr143009e0c.18.1790760747131;
        Wed, 30 Sep 2026 02:32:27 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d611ef7243sm1157534e0c.3.2026.09.30.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:32:26 -0700 (PDT)
Date: Wed, 30 Sep 2026 05:32:10 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Khem Raj <khem.raj@oss.qualcomm.com>, raj.khem@gmail.com, 
    Martin Jansa <martin.jansa@gmail.com>, 
    Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] layer: Add blacksail YP
 6.1 to compatible releases
In-Reply-To: <20260927032841.305194-1-khem.raj@oss.qualcomm.com>
Message-ID: <4992cce6-a805-be9d-f1b6-6df179f827d5@konsulko.com>
References: <20260927032841.305194-1-khem.raj@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 09:32:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4969

Sorry for the delay on this, the timing wasn't great wrt some conference
travel.  I'm running it through CI now just in case there's some other new
master breakage, and aim to push it later today (CEST); I'll reply to this
when I've pushed it to master.

Thanks,

Scott


On Sat, 26 Sep 2026, Khem Raj via lists.yoctoproject.org wrote:

> Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
> ---
>  conf/layer.conf                | 2 +-
>  meta-hardening/conf/layer.conf | 2 +-
>  meta-integrity/conf/layer.conf | 2 +-
>  meta-parsec/conf/layer.conf    | 2 +-
>  meta-tpm/conf/layer.conf       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index f0d8bba..af9b105 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
>  BBFILE_PATTERN_security = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_security = "8"
>
> -LAYERSERIES_COMPAT_security = "wrynose"
> +LAYERSERIES_COMPAT_security = "blacksail"
>
>  LAYERDEPENDS_security = "core openembedded-layer"
>
> diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
> index c95371f..ef61466 100644
> --- a/meta-hardening/conf/layer.conf
> +++ b/meta-hardening/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
>  BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_harden-layer = "6"
>
> -LAYERSERIES_COMPAT_harden-layer = "wrynose"
> +LAYERSERIES_COMPAT_harden-layer = "blacksail"
>
>  LAYERDEPENDS_harden-layer = "core openembedded-layer"
>
> diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
> index 22d2992..e5bdc89 100644
> --- a/meta-integrity/conf/layer.conf
> +++ b/meta-integrity/conf/layer.conf
> @@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
>  # interactive shell is enough.
>  OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
>
> -LAYERSERIES_COMPAT_integrity = "wrynose"
> +LAYERSERIES_COMPAT_integrity = "blacksail"
>  # ima-evm-utils depends on keyutils from meta-oe
>  LAYERDEPENDS_integrity = "core openembedded-layer"
>
> diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
> index e2a7a8d..fec647b 100644
> --- a/meta-parsec/conf/layer.conf
> +++ b/meta-parsec/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
>  BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_parsec-layer = "5"
>
> -LAYERSERIES_COMPAT_parsec-layer = "wrynose whinlatter walnascar scarthgap"
> +LAYERSERIES_COMPAT_parsec-layer = "blacksail wrynose whinlatter walnascar scarthgap"
>
>  LAYERDEPENDS_parsec-layer = "core"
>  BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
> diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
> index 3ea7c08..b376a93 100644
> --- a/meta-tpm/conf/layer.conf
> +++ b/meta-tpm/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
>  BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_tpm-layer = "6"
>
> -LAYERSERIES_COMPAT_tpm-layer = "wrynose"
> +LAYERSERIES_COMPAT_tpm-layer = "blacksail"
>
>  LAYERDEPENDS_tpm-layer = " \
>      core \
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4957): https://lists.yoctoproject.org/g/yocto-patches/message/4957
> Mute This Topic: https://lists.yoctoproject.org/mt/121451461/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

