Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFDDCD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 17:47:19 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21041.1779731229903501474
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 10:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TEWF6mKS;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914db409f1bso96673985a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779731229; x=1780336029; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GMkeUTz52ZCrRsr4gmKrgGiU58pq2kqT+NQwDhVWvY=;
        b=TEWF6mKSjLxDZokPaJj90csS4IkkAW+mRf93D87nfTiIMvdslvfIoXFCAT5TNe8Wh4
         JVhreJAYKWwviqFA3y+51KdwNf77Tvlp1GFPsFve88tIQldNmTDcl8rK+anygPQmlUO0
         DGMCKuV26eh6l331SZn9qH44wyIQ+46E5ggO4NjnR/zWt3EKEfBkH+/GW2meeBTKH/6A
         gkAurHE6kVLBbQTwJvOdbA2YzzDs7mzq11+iZ6RLmqWNMe3xER6d3QL1O48k4dzdEqRG
         0HZCXHUArgNgbuvuNfmLvLHpRUvtgRbEVqeQ6gY/E7PLbRg6+g0O1GhzdLdK74Le+aor
         1a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779731229; x=1780336029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GMkeUTz52ZCrRsr4gmKrgGiU58pq2kqT+NQwDhVWvY=;
        b=o9aCunrRF+yLR1SA+JlmdL8lHgpz3iiLTpEikuSzxnF+0TPHXn5XVXkAwK9b6Jdjj6
         stegh5zfmey/MC09yIrWYaqtiSGUTjQ3+Z6IL2JnRbzYYaBbRPTpKiI72LDuv9Vp0gOh
         /+Y2cRIAaZlFg0gQIezBkYMHzr3wQZ1yaauKRRmIaXmIsitxLLTO5NDTG3uHrmeqmgtY
         6UNuF2DnUN9RQvywhACOqtjq+zK7gSksb8XelmvdGPcJyY2d8Z9Y0SFwUwCS/Wta35BH
         9AjVMbrdy9VsY5Zdceq7e+xeGexEAot0I52l4/5j697YIhugE3ly+WrTf8vMg3gz7eT7
         9rKg==
X-Gm-Message-State: AOJu0Yyq6I4bKNCA4S6iE9uOYTNWYwaPmu0bg5SQ4PC+hfzJFXMEkCRk
	azB6LXhD8rN103Qg+LPCh7+kaE+WFUNc5gjRHg/FQybhTBZ16GgMzQFo
X-Gm-Gg: Acq92OHjgZj2k9h0fzsauQY6IWhOKbibduRWB30aO9EdElPjkVOUoQctI5UaOKJgDw0
	5ogsFhS+IrxPq+Th4r1yuGYa9rr1PVM2Y9770nbgLD6opU8auKvySv2cA379GFG6nX4PI0J9Kmu
	mjxdI2PYdM3Y7x+KtglALodXfXiMlxtTWlhydgdKb3hvjGPNXlgkaTuzPZYbsjzhsgTAygFttXu
	+qneqyTR99oP1/5KYH8MwwsstDX2epVT8v/xJBYJh0lKAbM/6wMvngrtTfCTHeHQt6yTd0fVlWJ
	fINntydl/uc93bK90gISD6Fi4pQYnAVvOEPfyze2F79n2/LxQeQ6T4ApSCdSfBgd088avqZ3yos
	jiIh2DYmJcc3lmKIX6tCuTIHo66HSvdsLAOVUUdbBq/WiDCNmiMGrBWysvaVlN4HuUHKvY3bHsh
	SLM7NRy5RbWS1kH555FdKQ9q+VUrEBMoaoQl4Ab76i7hLPeEAstRITj5yQP2cfxWhVuA==
X-Received: by 2002:a05:620a:4713:b0:8cd:8569:b957 with SMTP id af79cd13be357-914b4996334mr2237547885a.43.1779731228907;
        Mon, 25 May 2026 10:47:08 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c74e3sm1054094185a.9.2026.05.25.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:47:07 -0700 (PDT)
Date: Mon, 25 May 2026 13:47:05 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Aleksandar Nikolic <aleksandar.nikolic010@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org,
	Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
Subject: Re: [wic][PATCH v2] wic: Fix updating fstab for nvme devices
Message-ID: <ahSLGRJXk3XXqQzD@localhost.localdomain>
References: <20260525162711.282346-1-aleksandar.nikolic22@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525162711.282346-1-aleksandar.nikolic22@pm.me>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 17:47:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4047

Thank you, all review comments addressed.

On Mon 2026-05-25 @ 06:27:11 PM, Aleksandar Nikolic wrote:
> From: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
> 
> In case wks file references nvme, update_fstab() function will not add
> prefix 'p' before the partition number, as the if condition only takes
> mmcblk into consideration.
> 
> In case of nvme0n1 this leads that following entries are added to fstab:
> 
>     /dev/nvme0n11
>     /dev/nvme0n13
> 
> instead of:
> 
>     /dev/nvme0n1p1
>     /dev/nvme0n1p3
> 
> The patch fixes this as it extends the if condition and adds prefix 'p' for
> both mmcblk and nvme.
> 
> Signed-off-by: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
> ---

Process note for future spins: adding a short changelog block in this
location (delimited by '---') makes it easier for me and for tools like
b4/Patchwork to see at a glance what moved between revisions. Not a
blocker here; just a habit worth building.

See: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#taking-patch-review-into-account


---
>  src/wic/plugins/imager/direct.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
> index 832d0e6..76d0f73 100644
> --- a/src/wic/plugins/imager/direct.py
> +++ b/src/wic/plugins/imager/direct.py
> @@ -134,8 +134,8 @@ class DirectPlugin(ImagerPlugin):
>              elif part.use_label:
>                  device_name = "LABEL=%s" % part.label
>              else:
> -                # mmc device partitions are named mmcblk0p1, mmcblk0p2..
> -                prefix = 'p' if  part.disk.startswith('mmcblk') else ''
> +                # mmc and nvme device partitions start with prefix 'p'
> +                prefix = 'p' if part.disk.startswith(('mmcblk', 'nvme')) else ''
>                  device_name = "/dev/%s%s%d" % (part.disk, prefix, part.realnum)
>  
>              opts = part.fsopts if part.fsopts else "defaults"
> @@ -269,7 +269,8 @@ class DirectPlugin(ImagerPlugin):
>                  elif part.label and self.ptable_format != 'msdos':
>                      return "PARTLABEL=%s" % part.label
>                  else:
> -                    suffix = 'p' if part.disk.startswith('mmcblk') else ''
> +                    # mmc and nvme device partitions start with prefix 'p'
> +                    suffix = 'p' if part.disk.startswith(('mmcblk', 'nvme')) else ''
>                      return "/dev/%s%s%-d" % (part.disk, suffix, part.realnum)
>  
>      def cleanup(self):
> -- 
> 2.43.0
> 

