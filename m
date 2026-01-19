Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61942D2ECE5
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:38:53 +0000 (UTC)
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44554.1768855131403090951
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:38:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HBNNVItk;
 spf=pass (domain: konsulko.com, ip: 209.85.219.65, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a32bf0248so33710166d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855130; x=1769459930; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxk0lC8W5cCPu5KFrLMRI6OviNBaG5WUqO/Y3kVEFfg=;
        b=HBNNVItkttaw8czz91XilxFa1/KTlyA7erElHYuxGiVjwTfotHfWvkfv58c1VdjZtx
         WzR8eQBKaRwZXmYkAg9ZvbjW78ZDnGWUdLEC3EM3qxoFwKE4XQgNn0vW6Aoz1YGhvOgV
         9wQZ5Ij/tlnqkqdsu8QFHXPJpZXf2T9XAXdXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855130; x=1769459930;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxk0lC8W5cCPu5KFrLMRI6OviNBaG5WUqO/Y3kVEFfg=;
        b=MLLBTm3SG5pN7JcPMwu5OyHmS0eySkYa7b35jYhb7vZS3UVAzxaKwPDQe+QhfesABi
         8w8oUO5dYXxpapTfG1VgtvNJeTRNoBM3iCDIXRXiUMA+MEbWQ70rJ36p6eDh1K9MW75P
         s+f7b0LTRUT5Rj8jO1gwgqbR1/lyE8blC4BVrrOZ45VCO1L2dJPGPcnjKqypYPAnk48m
         Y3DRisVOS9l1A1a4xBwc5AX2Mz+/2O83Sz1BAUAoVR52PwCtVODnTQPKv4yct9OqI6Oq
         xG8Tjd1AAq7ErYism4gYqPSZgjkrucDeK5jDRFAIniB7okOh5iSK2AhjJs4Eq7Kuq1CD
         N2Sw==
X-Gm-Message-State: AOJu0YxFT61tUx7qWTIlw+AOJnRWxXzBKQZbsiFrdVR3LXpBea3Im0AX
	7QwGla+d31EqZY6FQ2OJNULqg/DQ407NrUX0lFN+EOBkzeXOxJ7hAXjw2+arnCvUX43+czPvO9P
	zQiM6Hm0=
X-Gm-Gg: AZuq6aJMF0jLVW7r4ayzgkQLvcpf/vchksk4pntI961UCCRX3MCKoGiCGSFlZOiCzwe
	l0pRg5LG60slDeY/KCNIQava8vOlaYilfIJ2NBXy886KfxtIXeg/jkN7w5uMNhjtvIjg9Qq3uGW
	7ogihfpMiI4OpZwumj45Pke5q+Hprn9j9wQBC1cTpjkb5u7x5xKHi+pfBMf4KEhd+i2lf7kShwX
	6jFYz6YmNLhlJAvVkhUYjq6zvEgVhc6TAWHOJkZCNfwmBrZkynUqpevWF9Jnu/TTvbQ0f7CP0Il
	er1fh/BIgiLOFXmawd97LHKdSPe440+2z98xWSzbFFe6HqqWtM0X7oCzj1f7TGtxq4mvS1Zywv5
	0Otmu0Ci7TUmVjUdyyieRfBSiVGLkzCNTmhv6B9gpP59oPxw2IK+gbqYQQvJrzgxyfQ3e/t9sfl
	bCrpjtwjJ74Tb0FwmFx9aFGSW+WdI8/U88HpeAuf/UtR3ikmT5x6f3p+9dFMRhr5kbFhtrasKBM
	zbFtrvdHb7/oW0M569H91Qwo7e9k+zub7oebGK2C4JKYw==
X-Received: by 2002:ad4:5c67:0:b0:880:461d:2e19 with SMTP id 6a1803df08f44-8942dd70189mr177230056d6.42.1768855130060;
        Mon, 19 Jan 2026 12:38:50 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6cd63esm86499576d6.49.2026.01.19.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:38:49 -0800 (PST)
Date: Mon, 19 Jan 2026 15:38:49 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-security][whinlatter][PATCH 0/3]
 Assorted updates 01/19
In-Reply-To: <188C3BFF15A14E90.3354624@lists.yoctoproject.org>
Message-ID: <6d9dd9d1-95f9-8bdd-8cc9-e1eb14570385@konsulko.com>
References: <188C3BFF15A14E90.3354624@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:38:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3023

Oops, these are indeed for meta-security, the "lts-" in the subject
was a cut and paste accident on my part.

On Mon, 19 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past couple
> weeks, plus a lynis update from myself.  These changes are queued on
> the whinlatter-next branch if you would like to check them out to test
> yourself.  I intend to merge these to master branch at end of day
> tomorrow (Eastern Time, Jan. 20) unless there are objections.
>
> Scott
>
>
> Changes:
>
> Clayton Casciato (1):
>   suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute
>
> Scott Murray (1):
>   lynis: upgrade to 3.1.6
>
> Stephan Wurm (1):
>   dm-verity-img.bbclass: filter units from value part
>
>  classes/dm-verity-img.bbclass                     |  4 ++--
>  .../lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb}      |  2 +-
>  recipes-ids/suricata/files/suricata.service       |  1 +
>  recipes-ids/suricata/suricata_7.0.13.bb           | 15 ++++++++++++++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
>  rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)
>
>

