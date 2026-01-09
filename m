Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D15D232CC
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 01:55:04 +0000 (UTC)
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1599.1767923701963750583
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Jan 2026 17:55:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fPI1vT5/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.195, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2148ca40eso533001485a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767923701; x=1768528501; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxjgQ+UtQppB+HMePxooc4wtm2/FGOg1X+Gp0lK0ZRk=;
        b=fPI1vT5/f/Hn0r9bf1ivEbxupotXy86Hb5USLMurMY89auvH4azZIOVybX7Jse8xBz
         NwSkzM6v09Im6bEXK65MvxNE5/hkLitllf98ISZD3IDYh2MS2y/BdT9nn7VwszTO/liQ
         Qul+esds508nFlN7qHnrlzVR56s0+JgNqdCIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767923701; x=1768528501;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxjgQ+UtQppB+HMePxooc4wtm2/FGOg1X+Gp0lK0ZRk=;
        b=sgnMM5m0F8XHIHMFkQdOdzPb+g9RGNk0n2wWPu4EQ1JF8Lhc0moStc8VOCZ4xt/vHA
         LQGkQIxA9t+Sc0UpailpxHtkzZQQZ6aYCQshW9iczDJf5rjxaJc9ZA8c8PUfk/lPABde
         wTsdd2bLpA0RGDd+JFJORnmwo8TWwPzNoR/NegTyoHNuixHH+W3SF8hc4GocuxRBGZlk
         nqgoAdSuF5l8LlYZve+8SI1N94risXV8zMm4AGDVR92stsZCnA5vopqx9sgZ1urOi/n5
         YJsKdSev4iFp2EALp1bakO+2odoN2lYO8SGP8lykJug9aEY7uyLVNGuzYGO2UIq0ncXo
         earA==
X-Gm-Message-State: AOJu0YzAdHyLegRUYuoCnmPZiRKAAgwY2wLgUi/as4QV5ELl6BP2e2oA
	KHh2y/Wnl6ONzvfn6vssPLNAGK49c9ItpV/v+aiUFMZsshLUNzo4vN8DqkGEcwUpbLrHBvjqefJ
	ZAWcqBAA=
X-Gm-Gg: AY/fxX6Ue/kETOSa2V9b3MR+Lm5WRVEUwBYI+uu9Axg54cnwY89Y8SpTKowxftDX6qW
	YhiyYMM79Xg+G7s/LUrxsGGvUyvGUR3d2Unt8nJq/KjFStCJHY26AaZLpnREIcyCc79Jv8AvMfr
	LFWfMfxMTZI2WTp0Jl3QvxX5MEA5ulPBko6lY6t8BATimKPaZSn8XImrpuypTmZoOIiEyHYsZYZ
	YDslZnTj9AIFcuy8XT0gQnpX7O6aZAoLJVTMXv07JpEScg/u3d4JJ7vY7CHzYtW/oZ1/AICWhfn
	vlgcJ3eguMp4QEEhfpYUCH3dWK7z3hnulvlGIwbvSgSQKqq2YWPLh+k3QIDqlmeWHExJ6EQN9HT
	vpV0AjRk0kBFCtHp0OFZHaN6c++tsFAIMd6Ru5D3vRKIzxSefAEeZXYPbJSiLIA2YZrYKM8CDvB
	0S0S92wg0Lfy4aDZmlNJQVYBQmHhvKuw004PbPaj3cWBcR2Vmp+23RjIIuS2oYdMAe7wY8TpkOU
	ZKcrqOVDnLZ1VD/sgnuieFQJahow3ThMDcxDkDgClUBNQ==
X-Google-Smtp-Source: AGHT+IGexVQXW0MAtUuyZaleFn3vkm1jwvWIoDQ/s7blX8KDmAGgcZxZeeRnXWcQC/gLV6IKv8egCg==
X-Received: by 2002:a05:620a:4082:b0:8b2:eea5:3311 with SMTP id af79cd13be357-8c389388cd4mr974777285a.26.1767923700599;
        Thu, 08 Jan 2026 17:55:00 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077234405sm72689806d6.30.2026.01.08.17.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:55:00 -0800 (PST)
Date: Thu, 8 Jan 2026 20:54:42 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>, 
    Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/4] Assorted updates
 01/07
In-Reply-To: <18887AF016DF02CE.2235664@lists.yoctoproject.org>
Message-ID: <1b9b89c2-06ba-b951-8fde-d7ba65e7198e@konsulko.com>
References: <18887AF016DF02CE.2235664@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 01:55:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2917

On Wed, 7 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past few weeks,
> plus some clean up changes from myself.  These changes are queued on the
> master-next branch if you would like to check them out to test yourself.
> I intend to merge these to master branch at end of day tomorrow (Eastern
> Time, Jan. 8) unless there are objections.
>
> I have not yet created the whinlatter branch due to some distractions over the
> holidays, but that should happen by tomorrow as well now that some CI hiccups
> have been fixed up.

These are now merged to master, and the whinlatter branch has also been
pushed.

Scott

> Changes:
>
> Clayton Casciato (2):
>   suricata: drop trailing whitespace
>   suricata: update PACKAGECONFIG[jansson] option to required
>
> Scott Murray (2):
>   meta-parsec: Remove meta-clang dependency
>   Update kas configuration
>
>  kas/kas-security-alt.yml                |  2 +-
>  kas/kas-security-base.yml               | 18 +++++++++---------
>  kas/kas-security-dm.yml                 |  2 +-
>  kas/kas-security-parsec.yml             |  6 +-----
>  meta-parsec/README.md                   |  6 ++----
>  meta-parsec/conf/layer.conf             |  2 +-
>  recipes-ids/suricata/suricata_7.0.13.bb | 20 +++++++++++---------
>  7 files changed, 26 insertions(+), 30 deletions(-)
>
>

