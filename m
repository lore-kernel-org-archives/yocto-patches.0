Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F0E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 17:29:23 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.39278.1734283753665844059
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 09:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OTq0tn6d;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so37123751fa.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734283751; x=1734888551; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qu2+8LG0ynazlvscd6uiZSLlgaXvAhBA3N6YiBvx1lE=;
        b=OTq0tn6dQvQsg4umefiyhwUNzDIbdz0ABUqvpwXBDWf8gHO1m2w7r/DwO+N4i5gPvn
         MJ2UlxMdNYyuTj7e5lJhUX+w58/pq+CBBUwNwoLjdIiCEzCcMFyTdPmobUThW/hKHWaD
         TKtnLiommgfD5aj7cIUY5XW20x3EpgyNA6MFkpLTY4n0ETl6Te0huY10iD0LyLp3x1tM
         dPOEAlQMkRHhiC3wZo8P+CTywym/giBNeYVuVwts76iRVHYUj8mTSDDyeZ96xCHS+zWA
         twGj1Ypc9aHw7kDHZ67pSLtzYbrgnozbO/CjPXDL3e7Uzb/CTBwpw2FmFkveAiBRKFiA
         1FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734283751; x=1734888551;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qu2+8LG0ynazlvscd6uiZSLlgaXvAhBA3N6YiBvx1lE=;
        b=w+tHUd2o1uF7lgz7ra9/8yKGkJIJho/kVxCtEE1FpKHfCBNI+Ax96ewAUyE/ToOcvR
         uUjDvFOj+XrelBZWemvdHFr4PmwMCIUK9MjSaBnYX1JCLZWCSs28WjOCI4msIin6D0N+
         QiJK/Zn4F9p0Ssr7EIsJKqro/SVyJGFun05L4hEGt7cUNcV325voIPFwuckjBQKdZe27
         4R2Fo8PzjlPJ1jbTJm3HElO347xNwHdwS3m0RbpHVzVTtisyoRgf3AS1eNNsirs0oT2x
         7AC/wkLIpD/AmWSbvuPv+1Gqam2XO6s38GM1OqA1cUysGKAmZAOGIclloEtYA3bjDJa6
         x+GA==
X-Gm-Message-State: AOJu0YyY8fzzuwxpJYHIdVf1oeTTXYJfv9sRaIpZ2AKo1hdzOCaSUL/L
	+eA/UtKULUIZWX+8Tr61Z4YoiltUzOrUqoE/CCGQX7+wBTxBgd2bWWuv7K3I
X-Gm-Gg: ASbGncvn1HkEta/1fDj23ReP14Zzf0d0RDtJ7xVLJylTg9Zs28OTWVKdFnv14jCiF2H
	0ANJbXdkHBkkyjI81Q3P2TIxT6xvXB4iPabtlGGW4HJa5LyYhnD2h3JI6qdTMWMzOvl1ZTY+vx9
	4GT07XFinxGde8oRjuh0lbAugTZabG/BWa0NscEHoMe7hYRIN5Ud3jIt2njpZkgvuMd0xKt+TT1
	8l1cFna84RKxVoUyNDd0yRX+7cix8FH8g5rb0wtKvqIzakTKtfd0osowPX/ssbeK3voLw==
X-Google-Smtp-Source: AGHT+IGDCdC/Bz2A/4YNPE5C370de3RxbbcMMtEKybCVxm9Mrxc/LuVZJj3ZvRr20RIbDdoPDn43Bw==
X-Received: by 2002:a05:651c:198d:b0:302:27ea:a56e with SMTP id 38308e7fff4ca-3025459b6a8mr35814591fa.32.1734283750605;
        Sun, 15 Dec 2024 09:29:10 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a58f4sm6336051fa.101.2024.12.15.09.29.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:29:10 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------BSt50ohM0uRaarfTVoQejUGt"
Message-ID: <b881d71c-48e5-4003-828e-4f48f258e9c7@gmail.com>
Date: Sun, 15 Dec 2024 18:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 3/4] radxa-zero-3:
 switch to yocto-dev kernel
To: yocto-patches@lists.yoctoproject.org
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-3-twoerner@gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <20241213154843.27592-3-twoerner@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 17:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/915

This is a multi-part message in MIME format.
--------------BSt50ohM0uRaarfTVoQejUGt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
> but they are supported in the yocto-dev kernel. Switch to yocto-dev until
> support is available in the yocto kernel.
>
> Signed-off-by: Trevor Woerner<twoerner@gmail.com>

If this patch is the next version ofhttps://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t

then Reported-by tag disappeared. ( it is not critical for me, feel free not to add it )

Checked on my side and LGTM: Reviewed-by: Oleksii Kurochko<oleksii.kurochko@gmail.com>.

Thanks.

Best regards,

  Oleksii


> ---
> changes from v1:
> - add [meta-rockchip] to subject
> ---
>   conf/machine/include/radxa-zero-3.inc         |  2 +-
>   ...xt_%.bbappend => linux-yocto-dev.bbappend} |  0
>   .../linux/linux-torvalds-next_git.bb          | 25 -------------------
>   recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
>   4 files changed, 3 insertions(+), 26 deletions(-)
>   rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend => linux-yocto-dev.bbappend} (100%)
>   delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
>
> diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
> index 1c6f972c1e31..b351afae8c0f 100644
> --- a/conf/machine/include/radxa-zero-3.inc
> +++ b/conf/machine/include/radxa-zero-3.inc
> @@ -2,7 +2,7 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
>   
>   require conf/machine/include/rk3566.inc
>   
> -PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
> +PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
>   MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
>   
>   UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
> similarity index 100%
> rename from dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
> rename to dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> deleted file mode 100644
> index b961b1408f09..000000000000
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
> -
> -DESCRIPTION = "Linux Kernel"
> -SECTION = "kernel"
> -LICENSE = "GPL-2.0-only"
> -LIC_FILES_CHKSUM ="file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> -
> -ERROR_QA:remove = "buildpaths"
> -DEFAULT_PREFERENCE = "-1"
> -COMPATIBLE_MACHINE = "^$"
> -COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
> -
> -LINUX_VERSION = "6.11-rc6"
> -KERNEL_VERSION_SANITY_SKIP = "1"
> -PV = "${LINUX_VERSION}+git${SRCPV}"
> -SRC_URI = " \
> -	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
> -	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
> -	"
> -# this is tag 'next-20240904'
> -SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
> -
> -inherit kernel
> -inherit kernel-yocto
> -require recipes-kernel/linux/linux-yocto.inc
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> index b6a63d7b7b29..f738d1357d6c 100644
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> @@ -1,5 +1,7 @@
>   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>   
>   COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
> +COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
>   
>   SRC_URI:append:orangepi-5-plus =" 
> file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> +SRC_URI:append:radxa-zero-3 =" 
> file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
--------------BSt50ohM0uRaarfTVoQejUGt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 12/13/24 4:48 PM, Trevor Woerner via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20241213154843.27592-3-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
but they are supported in the yocto-dev kernel. Switch to yocto-dev until
support is available in the yocto kernel.

Signed-off-by: Trevor Woerner <a class="moz-txt-link-rfc2396E" href="mailto:twoerner@gmail.com">&lt;twoerner@gmail.com&gt;</a></pre>
    </blockquote>
    <pre>If this patch is the next version of <a class="moz-txt-link-freetext" href="https://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t">https://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t</a></pre>
    <pre>then Reported-by tag disappeared. ( it is not critical for me, feel free not to add it )
</pre>
    <pre>Checked on my side and LGTM: Reviewed-by: Oleksii Kurochko <a class="moz-txt-link-rfc2396E" href="mailto:oleksii.kurochko@gmail.com">&lt;oleksii.kurochko@gmail.com&gt;</a>.</pre>
    <pre>Thanks.</pre>
    <pre>Best regards,</pre>
    <pre> Oleksii</pre>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20241213154843.27592-3-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---
changes from v1:
- add [meta-rockchip] to subject
---
 conf/machine/include/radxa-zero-3.inc         |  2 +-
 ...xt_%.bbappend =&gt; linux-yocto-dev.bbappend} |  0
 .../linux/linux-torvalds-next_git.bb          | 25 -------------------
 recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
 4 files changed, 3 insertions(+), 26 deletions(-)
 rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend =&gt; linux-yocto-dev.bbappend} (100%)
 delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb

diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
index 1c6f972c1e31..b351afae8c0f 100644
--- a/conf/machine/include/radxa-zero-3.inc
+++ b/conf/machine/include/radxa-zero-3.inc
@@ -2,7 +2,7 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
 
 require conf/machine/include/rk3566.inc
 
-PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
 MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
 
 UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
similarity index 100%
rename from dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
rename to dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
deleted file mode 100644
index b961b1408f09..000000000000
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ /dev/null
@@ -1,25 +0,0 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
-
-DESCRIPTION = "Linux Kernel"
-SECTION = "kernel"
-LICENSE = "GPL-2.0-only"
-LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46">"file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"</a>
-
-ERROR_QA:remove = "buildpaths"
-DEFAULT_PREFERENCE = "-1"
-COMPATIBLE_MACHINE = "^$"
-COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
-
-LINUX_VERSION = "6.11-rc6"
-KERNEL_VERSION_SANITY_SKIP = "1"
-PV = "${LINUX_VERSION}+git${SRCPV}"
-SRC_URI = " \
-	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
-	<a class="moz-txt-link-freetext" href="file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta">file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta</a> \
-	"
-# this is tag 'next-20240904'
-SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
-
-inherit kernel
-inherit kernel-yocto
-require recipes-kernel/linux/linux-yocto.inc
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index b6a63d7b7b29..f738d1357d6c 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,5 +1,7 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
 SRC_URI:append:orangepi-5-plus = <a class="moz-txt-link-rfc2396E" href="file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta">" file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"</a>
+SRC_URI:append:radxa-zero-3 = <a class="moz-txt-link-rfc2396E" href="file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta">" file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"</a>
</pre>
    </blockquote>
  </body>
</html>

--------------BSt50ohM0uRaarfTVoQejUGt--

