Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F8C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 03:51:28 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1659.1783569081933082428
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 20:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GCMHpQFn;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e53581361so70598985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569081; x=1784173881; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zi5gzNBAl9uq+i3roFifGL43V2/nCJK7ch2LYQV3lJQ=;
        b=GCMHpQFnx7DVc+T1lmz67CCiEYc+0zFpNrrq4D1hr18zcqEURGeaUWxNNnZpo5X3PO
         5H2T0696WHzBG1vmseGgEsm7gDVK4ul16ujHOGz1awGGJO+KGqAOqnT+DU77dnJTUFoo
         aVCXX2U+ZIWM9deJS8NPDU+2EQPz9RgQil2xqt8XgcgTXnYhHADB04i1ewS6+R9gq+yQ
         w2GBUTBoCabieh+GUzWkQK+8sgst7B9dL4Fqx1xXq2Kyh2FUt4Ru8HeA0o2c+/aUxsBv
         qmdJ1103STg40N/OstfheCGThnJ5VNZ8LnxDB23eD6QlOLeXG8pbGNu6rwuozqE+d6j4
         zxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569081; x=1784173881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zi5gzNBAl9uq+i3roFifGL43V2/nCJK7ch2LYQV3lJQ=;
        b=WCLeOBup+bxrvVvOgdImGpGqPXOmLOz/aE2qUfzSCvHB1s0whWSVRtSQi92TyTHAuh
         SIvjxiSCUuph21cfVPApA7AY9GdkYM5q6jKEH6Gdv7Jk2SFWPFa2EXT+x+XFz5Hjcigs
         o9OpRV40usZDNuyQrK5qqLd57GXcGIy0DTAnO9x4JAAH/mllStGMuZumFaWL8dj+82mq
         CctNlA3hMJ81EOvS05ad8ocDhkBVJvwbn7Ba0QXtnBRsSJTMCjNlbRcf7M7UyB2uvdwF
         oO2jAkkca99iaylHhzobqev5YPRfHrvEahQCguVvNbHk6MG+4VyvJ0p73rzNYs6cDvoI
         5ltQ==
X-Gm-Message-State: AOJu0YxBqExQKLg2HUlcAMO6RodRNjz5RN1md4tlhFtE1BybBmxcJ/Qy
	FKVfXcs4rsQQmbEtAX98CwIkbx4Vv7Mnr59h/WeN4thMvSr/XuZc6d9b2qC9RQ==
X-Gm-Gg: AfdE7cm8gADOJZQZ+i8Lf01Ag7+dXbf7VO302fPSeLXLHMWtSK75YQivgbNM3jxg+qo
	zQFndlVioEqJS89rs6bpoxgWPK3R/QdmpgtpotZ43JFZwXUck+Wq8ndmigi1bv+2DbND795tjUT
	42+K5hiYoCY1iykK96UMyh/WG/OfRwEW1aukIP6X5INFUw55Q/C9mW449IWW52L6cRHbP2Eic7G
	8YPQxNSmSkEzVxVcbpeBqELtx33roEzJGWuyhPOmKKoEsu2mjM9OrLkrJXDGEFw4HbH2jk4s9h8
	UA0N7yLm4IoRzY1vPDsrGPW8dxcUt9WZZ6SLoo3nBeYnpKFEpqDDwUZ2sawNfEGKoBQGDa/TNLA
	ngIBR+J+0BI87woalKzIW+l0la3XwIGVhmzsTyRo7AaMvHBPzqIANwaWISMHPvgrKSyIMuaCRW4
	9FiETm6+xhMNyG4le/xa7QlBHPtrq5bSpJRDJ0XiWoqT+UKc8pzgKzItg=
X-Received: by 2002:a05:620a:270f:b0:92e:666a:f4a2 with SMTP id af79cd13be357-92ecf8ea9c7mr588634985a.60.1783569080821;
        Wed, 08 Jul 2026 20:51:20 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm1568557485a.35.2026.07.08.20.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:51:20 -0700 (PDT)
Date: Wed, 8 Jul 2026 23:51:18 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay+rtone@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH 0/6] wic/help: Refresh wic create help and usage strings
Message-ID: <ak8attfxZztmVJdX@localhost.localdomain>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 03:51:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4457

Oops! I missed these.
Please put the tag [wic] in the email subject in the future, thanks!

On Thu 2026-07-02 @ 06:44:18 AM, Gaël PORTAY wrote:
> Hello maintainers,
> 
> That patch series refreshes a bit the help and usage strings for wic
> create.
> 
> The first patch removes the removed option --infile, while the following
> two patches list the missing options --no-fstab-update and --workdir as
> compared to `wic create` output:
> 
> 	usage: wic create [-h] [-o OUTDIR] [-w WORKDIR] [-e IMAGE_NAME]
> 	                  [-r ROOTFS_DIR] [-b BOOTIMG_DIR]
> 	                  [-k KERNEL_DIR] [-n NATIVE_SYSROOT] [-s] [-f]
> 	                  [-c {gzip,bzip2,xz}] [-m] [--no-fstab-update]
> 	                  [-v VARS_DIR] [-D] [-i IMAGER]
> 	                  [--extra-space EXTRA_SPACE]
> 	                  [--sector-size SECTOR_SIZE]
> 	                  wks_file
> 	wic create: error: the following arguments are required: wks_file
> 
> The fourth patch fixes inconsistent output between options by replacing
> the character `|' to `,'.
> 
> The fifth patch updates the output of command `wic create` that is
> hardcoded in the overview help string.
> 
> And the last patch outputs option capitalized values that are missing
> for options requiring a value; also, it ensure the lines are wrapped to
> 80-characters.
> 
> Regards,
> Gaël PORTAY (6):
>   wic/help: Drop removed --infile option from help string
>   wic/help: List missing option --no-fstab-update to usage string
>   wic/help: List missing option --workdir usage string
>   wic/help: Use comma to list short and long options
>   wic/help: Refresh output of create command in overview help string
>   wic/help: Add missing option values and rewrap lines
> 
>  src/wic/help.py | 52 +++++++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
> 
> -- 
> 2.43.0
> 

