Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BDAC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:53:15 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14003.1784296389518479429
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 06:53:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=beIfSE/O;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5218927884fso6017561cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296388; x=1784901188; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38xfoKN0S5HfKBdWC40De1DtE8gbPNMzU4+bix00vYY=;
        b=beIfSE/OCHyxWKvcxR/fuphW3yb5t3OcAkJNVVwssLqQMuqfk8M+VAZf/rWETsde7M
         aJn7LiQff4VFJ1vg4yRGTnLompUo9VbCzM9rcKS50ykMtpdwyCPTnkrC2F5t7o7sp3Yr
         vitkOV8klCAF644jbU83d1xmL2JQ/tv+br3GoNF26DsORWDUQP50QkpLHD68elRzMJ27
         y87/4/jKnZkI5jQGlN+rIhg83OiDHQM3rgf/kZhN4ys+/oHWoXZv3F6nZH2lgs7o8pp5
         jKF1EkP0tXqr+4EFr0mzgFcwgx4JGz/81xHYQ/U7mX2WF4pjExT1WU2c6UNSlmKutoqz
         a/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296388; x=1784901188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=38xfoKN0S5HfKBdWC40De1DtE8gbPNMzU4+bix00vYY=;
        b=Pu9tkspVws3wSuyKktAd76dNXWndaCEtWAPYQ1X8AtHjueBshXc8yXezrJdUFbNHiL
         1qrgLYgbM47dh+sXtLKyYoDf/DR5J6A9DaemIpn4c5iYf3yyQIXukLieZNaWtuKS4bWT
         bDO49tDWT6SSVZpwgjmLJ18mUv9HeFoQ/RRGNfQXHqof7BzmgJ6szi1ACXh98KmZN8vh
         rS3Fk6OkBA6rJLKl8Ooch8ZnM7WCXvXlb8mUatEskCGrIT1jTkpHgCa9tIan1iw3tswR
         KBod+4SoKcnhismEZ09P+6SK8p96DpNU0IPi4R1hL6ArsviZOmAkf3fOjvrb4X++HcY0
         tF1A==
X-Gm-Message-State: AOJu0YweMm1zw/vaJ6FE1Udqa0/IMZz4sTX5dbRQcZoVhKnavIvYQkoL
	X5A+DLfvnXU83GS+xCo1VRi1q73/pL7JDSH9acYhsYZVYjufCzEl2fCt
X-Gm-Gg: AfdE7ckYD5/kaQD3RIQ/0tgkv1WChwrA77/Zw0SFePAOC/ClQTobjEHE3dqdydhrEjJ
	cIf0yrR9GEkmyUSZI1/2c5keNsi8dvb9gjaB3D6uPrHeqiGLBEvXpTgZkUDlifl1hwwX08vqVWC
	MiUXx1yBR+rVs9c5rNM//r7Py7CUEdCMmTjSVeYDVYGW6mXKdtDPCbWnu0DUL9EC0qozg/Z4EjN
	svPxFJcR5+lH2999XoJTLhtuLg8EgZO+SYiX6fwH2F4ZagSH1BID1c75E+f0j0TThXkOBbIEJGn
	eQt79tbSqL9k9zuVaM7/UlfcVIqRuXCBbo+JcKcBgiudaJN2dbam7RLJw6orgHIUB7JQwbZDSkE
	8YhIh87ZCvptY+VdLF4gfQbpTODBXz4o2sRsvRXaIt4IruwJhL6D9hhdO7iy26dBxaQrG1Y/UHQ
	/ygvDqsv54Qv3Z8dO8sPLw73PrC8vBRLOLOS5/opsmQAoZ
X-Received: by 2002:a05:622a:48a:b0:51c:a2ea:64d3 with SMTP id d75a77b69052e-5213ae5557cmr22962361cf.35.1784296387682;
        Fri, 17 Jul 2026 06:53:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214c5cd3dbsm12802691cf.5.2026.07.17.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:53:06 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:53:04 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay+rtone@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH 0/6] wic/help: Refresh wic create help and usage strings
Message-ID: <alozwEnVdMwJQ0L2@localhost.localdomain>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 13:53:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4501

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

This patchset merged to wic, master branch.
Thanks!

