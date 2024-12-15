Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11044E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 15:11:03 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.37100.1734275454371970326
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 07:10:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h5vU/7Q6;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so3347441e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 07:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734275452; x=1734880252; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHHZ6e76J3FxdeiZETtl6sNa6dn9IFZVBGj/fCQGy8w=;
        b=h5vU/7Q6bE9fxkwBWQZaajV8OaUJudQwqJ0EXiV+9GC48LCmCl0MnPtcEP+nLEUBVr
         X23ukZsdpABoCrXk+pQz+GWKUnfuqS1KGbie0utscXitiliDQVbfqLZO7m/84wtbMPza
         gQEJuwSH48+8B7liFrbb2euLv6V/aopJhsbO7Dk5LK/NAU/Wxna34r479udUB8CYtMFd
         pKCcsR0ZgmAnyU0o6ZHjE4Bb2KVFAUy5D6UOYWPdc/I4VU9gxTvgdrnRbsJy1qiIBMec
         uI+WZbR1mRLFagwxK5jgOJYQ0DboV5Ym+DyzXlj5A5q3yomjEtvYrWERUH6gy0FJvZKA
         RNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734275452; x=1734880252;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vHHZ6e76J3FxdeiZETtl6sNa6dn9IFZVBGj/fCQGy8w=;
        b=I6kNGoKqAhq78LZXGWjQQnyMbxd1/UgWy5iezTD3oTKNyUQaUfJSS7QqTsvE2uafYP
         h0oAybNxmaMEqONymdvjiD5/2UfeQqvcxzWXu4TUKpjxTGdDkDFZo33Zf+9Wy3+b/rhG
         Cp7/eGm2rdSts2OQBHkMJFSCaUDRD/1Hoo+nnAlfqUp2FpqmwVNwIToyvUj1fkP7kQRb
         hA5boTugOlDK6j9tsB/2QnOEgm8LdrliW1uMVkuXNhH/cKhkfl0I+SCN1kAvwgFCEJax
         rpuzcVLtaSZeglc3VTulcxzo2rpRVeTmleolV8yUNt2F5n6CizB76AGKs00ZEh8gXzP4
         14zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTDu07HCYRYjSWW5+4pyDfMVKN32MIu6F70F1nj75vCCHcPzYOGlxAeBc1CVBw1ToNjf4pF3weZw2IXJ5x@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyphTwELUBfcA6XPklsPWGPlJ0Rg3lote7LYd5BUPVRiEqzYYAm
	g5BAC8hDJB8ixLyIP07TTMQ6S/Ef8PaYDq98MACsohnpWpOxzzPe
X-Gm-Gg: ASbGnctn+ZYASMAGwHZrtgrn06ymZVuze5cygAnOgD2DuLnC4am5pfAABgaQ/5yPwmN
	ZM+khCTrJTFg5iJDIn7Hh6LKnlg+q59Mxr97+KFK7ukJIPFs5hYzkKr5C8BsNBYt802BnWhlhKK
	5Qvkr0jPPehgpZjFUlzkUGAPZO33xbdBO6AIB5VVVgTqJ7G1yQJZUOt1aKgCRUAQBObRH8LRqx5
	xhACVQQvUe9gTksATMoZm03u4wAuibZpEjbefotMgg6sZWVlvAwJOvm/n6f7pFtYFD5bQ==
X-Google-Smtp-Source: AGHT+IFNUyeIJAtHQqQiNhVlCbt0Iv99ZSY651tWSX39cDFY0yLSANCvbJzsOAEE0xeLalIeDjl0sQ==
X-Received: by 2002:a05:6512:1246:b0:540:2fd2:6b85 with SMTP id 2adb3069b0e04-5408ad15dc0mr3047207e87.13.1734275451986;
        Sun, 15 Dec 2024 07:10:51 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f4f1sm525745e87.24.2024.12.15.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 07:10:51 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------orSTKQ8BU1hdsOexWE1shzb8"
Message-ID: <ef1b59d8-a018-44fc-8f0c-e58db58380d9@gmail.com>
Date: Sun, 15 Dec 2024 16:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] radxa-zero-3: switch to yocto-dev kernel
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-3-twoerner@gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <20241212195718.25203-3-twoerner@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 15:11:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/910

This is a multi-part message in MIME format.
--------------orSTKQ8BU1hdsOexWE1shzb8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Trevor,

On 12/12/24 8:57 PM, Trevor Woerner wrote:
> The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
> but they are supported in the yocto-dev kernel. Switch to yocto-dev until
> support is available in the yocto kernel.
>
> Reported-by: Oleksii Kurochko<oleksii.kurochko@gmail.com>
> Signed-off-by: Trevor Woerner<twoerner@gmail.com>
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
> +SRC_URI:append:radxa-zero-3 = "file://rockchip-kmeta;ty
After applying of this patch series I see the following compilation 
issue for kernel:
     | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was 
exported
     | make[2]: *** 
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/scripts/Makefile.modpost:145: 
vmlinux.symvers] Error 1
     | make[1]: *** 
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:1871: 
modpost] Error 2

     | make: *** 
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:240: 
__sub-make] Error 2


Should I apply something except the patches from these patch series? 
Otherwise I think we should disable some security things ( as a 
workaround ):

CONFIG_SECURITYFS=n CONFIG_SECURITY_NETWORK=y 
CONFIG_SECURITY_NETWORK_XFRM=n CONFIG_SECURITY_PATH=y 
CONFIG_SECURITY_LANDLOCK=y

Best regards,

  Oleksii


> pe=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
--------------orSTKQ8BU1hdsOexWE1shzb8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello Trevor,<br>
    </p>
    <div class="moz-cite-prefix">On 12/12/24 8:57 PM, Trevor Woerner
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20241212195718.25203-3-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
but they are supported in the yocto-dev kernel. Switch to yocto-dev until
support is available in the yocto kernel.

Reported-by: Oleksii Kurochko <a class="moz-txt-link-rfc2396E" href="mailto:oleksii.kurochko@gmail.com">&lt;oleksii.kurochko@gmail.com&gt;</a>
Signed-off-by: Trevor Woerner <a class="moz-txt-link-rfc2396E" href="mailto:twoerner@gmail.com">&lt;twoerner@gmail.com&gt;</a>
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
+SRC_URI:append:radxa-zero-3 = " <a class="moz-txt-link-freetext" href="file://rockchip-kmeta;ty">file://rockchip-kmeta;ty</a></pre>
    </blockquote>
    After applying of this patch series I see the following compilation
    issue for kernel:<br>
        | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir'
    was exported<br>
        | make[2]: ***
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/scripts/Makefile.modpost:145:
    vmlinux.symvers] Error 1<br>
        | make[1]: ***
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:1871:
    modpost] Error 2<br>
    <p>    | make: ***
[/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:240:
      __sub-make] Error 2</p>
    <p><br>
    </p>
    <p>Should I apply something except the patches from these patch
      series? Otherwise I think we should disable some security things (
      as a workaround ):</p>
    <pre
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><font
    color="#000000"><span class="add"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255);">    CONFIG_SECURITYFS=n
    CONFIG_SECURITY_NETWORK=y
    CONFIG_SECURITY_NETWORK_XFRM=n
    CONFIG_SECURITY_PATH=y
    CONFIG_SECURITY_LANDLOCK=y</span></font><span class="add"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 102, 0);">

</span></pre>
    <p>Best regards,</p>
    <p> Oleksii<br>
    </p>
    <br>
    <blockquote type="cite"
      cite="mid:20241212195718.25203-3-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">pe=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
</pre>
    </blockquote>
  </body>
</html>

--------------orSTKQ8BU1hdsOexWE1shzb8--

