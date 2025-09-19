Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63484CAC59A
	for <webhook@archiver.kernel.org>; Fri, 19 Sep 2025 15:41:58 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web11.19928.1758296512338858414
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Sep 2025 08:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lhlJYPbR;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-826fe3b3e2bso240302385a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758296511; x=1758901311; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJC07mAqv006UfiY8gLofTo31YOXNrcoQEfDckziBVM=;
        b=lhlJYPbR95GYaemN5hJIupCslsHjn2lN+mSTX66QlyiW+vVFeFZXYBDv7uUaieQMtH
         ep42srBR2XU7CLe1Je20PbRAZxl8zsBxzVq2zlr0wPEQMT+5lKzoAWEhXWI3rCOpOuMm
         iEJET6s853+ye2uex0n0avSoRUMopIBTmjmik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296511; x=1758901311;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJC07mAqv006UfiY8gLofTo31YOXNrcoQEfDckziBVM=;
        b=bedcMKl/rmPwmx1dnfjnu1NC64mwOBRq+BoJzdrStD6/wWqcKqMJvnmJwo/Scgvfjl
         5jzbaqyLtqGbqRg+dMjzvMLKpbxPdBcuYELvOIlYI5oK/SWlORvAkVHF9NAtDbhWTofq
         lzwm347BNnQOivMO2KqLL4FS5/pwiwYuZYqFAS+5wKfPcfpNMcL8DC4yT8cZYemm0lAp
         2l4tT9QIUxx8wZcOR+kl4gk8kNVbc4qucmew4puKwzJZIepW364GbEXnYFAkldifmoMf
         2TYkNfglFwLVOGPjyHC2DD4jQ6Sj2bzimzCAzLAsuTJNghKSfj5FwacSbFtM0SqDcG/X
         X2uw==
X-Gm-Message-State: AOJu0YwQ/X0iqBOfGKgxxLHxtUd7JiTntTpMTlnsVCXaiSUzJ8yfnGIi
	bQ795SpHTjmMdcGxZyIMH3kmDIBCbtjWIrPY8DxV76Z79NZcftxoU3lY0V1Ohv5v99QipoW70P0
	p+8lw
X-Gm-Gg: ASbGncvtF0kNl7B9qBkTX+5zybfc0jRPs1gsHr8CCbrstdA+Jx6VOC6F8VzhS0z2OEX
	WoNUqU20rLgp/v4KQWT3GAuMiRVDQ0dFx+rw1JinrQTa2K3y3JyYXOEDJlYRornNiqp8CsKWyS9
	LeKwtFPuZkjmFSKG8tH46LLVjXX+Mz5V73oEzcfxYs/pOnphKxcqMULziqM3+zG2JCEYsgiZW7R
	SfhVbXkQH97wSJQZHFyJhK8PGqerUGiTfzEcu+LKzixSv9D1Z1onJOtQIn5wkoIYyUKQEuRxLjL
	Qj0YQ9s3mgYW2vxXr9b51H604QC/QW0PF7swiaSQKNhEs33qVirMzDSJEPfM3R8f8zZ3Pmiy8Z6
	11mxjXjY8eC84Dr9nH3AJFZ1tTw50zzkYxmUUi+E5ct1fpggtWWXBCpyAMA==
X-Google-Smtp-Source: AGHT+IE0yFnf6Z6uFAWpFyXaYA3CHj81L6qX4zHZD4o2TTt0EOOaDkA5uhr51zuWoucu6AoIRkk95A==
X-Received: by 2002:a05:620a:a484:b0:82c:556:eaee with SMTP id af79cd13be357-83bad7d3596mr426953585a.66.1758296511077;
        Fri, 19 Sep 2025 08:41:51 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda15f6710sm31236491cf.2.2025.09.19.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:41:50 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:41:49 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/5] Assorted fixes
In-Reply-To: <18662CA381C71531.13540@lists.yoctoproject.org>
Message-ID: <1dbe1089-503e-774f-be3c-becd74e73c1d@konsulko.com>
References: <18662CA381C71531.13540@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 15:41:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2221

On Wed, 17 Sep 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up contributed patches from the past few weeks.
> I intend to merge these to master branch by end of day Thursday unless
> there are any objections.

These have now been merged to master branch.

Scott

> Changes:
>
> Clayton Casciato (1):
>   suricata: install classification, reference configs
>
> J. S. (1):
>   lib-perl: add a HOMEPAGE. Use CPAN_MIRROR
>
> Michael Opdenacker (2):
>   lynis: homepage update
>   lynis: update to 3.1.5
>
> Patrick Wicki (1):
>   tpm2-tss-engine: remove libgcrypt dependency
>
>  .../recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb     | 2 +-
>  recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb}   | 4 ++--
>  recipes-ids/suricata/suricata_7.0.0.bb                        | 2 ++
>  recipes-perl/perl/lib-perl_0.63.bb                            | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
>  rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (91%)
>
>

