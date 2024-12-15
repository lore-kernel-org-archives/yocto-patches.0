Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8030E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 17:28:23 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.39261.1734283699514061211
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 09:28:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JJf1YrlW;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so3429409e87.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 09:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734283697; x=1734888497; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PsziXLqCUi8MPSUHTgcPT1lSHUUZTxclS6MHDMD0hg=;
        b=JJf1YrlWml0Gnt2hK/x6Ol6ZfZRoMysvlJFe1gVb7MNqfAxr3OInmsdjbKmoVstdrz
         6yW9FN4Ahh1oBr1MSm0RvdrLWWwBmq2kiijUyvSQfrgrlQJxgFaf5UF1hxEIx9yk70dE
         UcyV1e7yNP2hd5HLBjRL+2xlprUWBAwoKPKr/gGnHB6ytJ6segCZYu9vunIPs2u/lUpy
         Q+GbNicxSox+Y5o9NDquNytIrqcPcHre+4H/qg1cWmNHLUzscDsJJu9NiKTSvGsE2hUa
         1jqaDsbMJ9pnzkLWRcBVh5ekHMkz1RSrypaZUmngCPtHPNtLMGnUBcpBwLb/5lVcYNAd
         ZpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734283697; x=1734888497;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2PsziXLqCUi8MPSUHTgcPT1lSHUUZTxclS6MHDMD0hg=;
        b=Dowuh60XG6YFHX5pZI1gVhzk+5YJkLIw+VL/DGTgjGbc+c6QxMEZDK0Tkm6jn6QQVO
         w+4BZwLlL4PcJgLFISjWKPUpK/PyAKCa1f4VJ6c2iTJtouzfhDxUaNGvRH9E1UBwomv+
         dEe7t7iUeladU8OK9mbA4SZIwH/six+lT4BfaR0SgoNX1X3QPEJ33G/MaNvMYtiZeLQt
         ppfCQEwizd9eEZuYHn3WR4qg+MHSRbYPTgwf8FlLbjjACYPqqE7FajtfzUXkIUSo3XNb
         Xesv8loXjLfgz+D/1B8P0E2xJfjaeuyE/xRlM1o+0qU9oaH1bZwA5rHa2Y165JiJKAqv
         6Lkg==
X-Gm-Message-State: AOJu0Yz65IQAlp8BoQbnFcjsoyBcDngUbSzacMT0hfw4N1sTec/8sP0t
	CGaZ/N/P16MR6mRwIGEdgDwwPkrK15yRZtL0EC7W3Gzv0VDhCNZzgrlwR4iJ
X-Gm-Gg: ASbGncv1utVOGSe+EWd3KGivly0Bv3AOQGSphGdoKmEA0TACSYcs6OYMWu/pzgF2ApT
	+wk13gRQIa9Y3cvmbPQyP2cgaR3La+dEW+U5RUDGj8UIzCDUKV9xsgemtG6RMlgKru32ExpDdgm
	wzSJ4f2ddPbr2HjYeJeMzPS9b0fpkK22uiWXFenqDuIzWUF2j4tvl6urmTxlIxYdHeZN3A4Io0A
	F6HGxr2EZ2xW7VxYdaPfEzG8Tqoma4o0c5FlYGIUIFq8nP2azkJvZG3+lgDEOc0TEqA5g==
X-Google-Smtp-Source: AGHT+IEbXQy2uWtsn7PTJ699gpyG3rYppEidY/yPIlALfsTo7WWZ24MiugPpgkhmjbp4+tfQelGXLw==
X-Received: by 2002:a05:6512:3a83:b0:53e:385c:e881 with SMTP id 2adb3069b0e04-54090560bd3mr2791071e87.30.1734283696672;
        Sun, 15 Dec 2024 09:28:16 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f553sm555371e87.50.2024.12.15.09.28.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:28:16 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------5C7IUKbzsWIkUoavwvY6DLZo"
Message-ID: <4a29665d-c067-437e-9f7f-52189f1dc65a@gmail.com>
Date: Sun, 15 Dec 2024 18:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 2/4] u-boot: use
 upstream for radxa-zero-3{e|w}
To: yocto-patches@lists.yoctoproject.org
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-2-twoerner@gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <20241213154843.27592-2-twoerner@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 17:28:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/914

This is a multi-part message in MIME format.
--------------5C7IUKbzsWIkUoavwvY6DLZo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
> for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
> U-Boot development for this board had been added.
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
>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index 06ba6d54de8e..08e1730b5d3d 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
>   
>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>   
> -SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> -SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> -
>   SRC_URI:append:rk-u-boot-env =" file://rockchip-enable-environment-mmc.cfg"
>   
>   DEPENDS:append:rk3308 = " u-boot-tools-native"
--------------5C7IUKbzsWIkUoavwvY6DLZo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/13/24 4:48 PM, Trevor Woerner via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20241213154843.27592-2-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
U-Boot development for this board had been added.

Signed-off-by: Trevor Woerner <a class="moz-txt-link-rfc2396E" href="mailto:twoerner@gmail.com">&lt;twoerner@gmail.com&gt;</a></pre>
    </blockquote>
    <pre>If this patch is the next version of <a class="moz-txt-link-freetext" href="https://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t">https://lore.kernel.org/yocto-patches/20241212195718.25203-1-twoerner@gmail.com/T/#t</a></pre>
    <pre>then Reported-by tag disappeared. ( it is not critical for me, feel free not to add it )
</pre>
    <pre>Checked on my side and LGTM: Reviewed-by: Oleksii Kurochko <a class="moz-txt-link-rfc2396E" href="mailto:oleksii.kurochko@gmail.com">&lt;oleksii.kurochko@gmail.com&gt;</a>.</pre>
    <pre>Thanks.</pre>
    <pre>Best regards,</pre>
    <pre> Oleksii</pre>
    <blockquote type="cite"
      cite="mid:20241213154843.27592-2-twoerner@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---
changes from v1:
- add [meta-rockchip] to subject
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 06ba6d54de8e..08e1730b5d3d 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,10 +2,6 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
-SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
-SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-
 SRC_URI:append:rk-u-boot-env = <a class="moz-txt-link-rfc2396E" href="file://rockchip-enable-environment-mmc.cfg">" file://rockchip-enable-environment-mmc.cfg"</a>
 
 DEPENDS:append:rk3308 = " u-boot-tools-native"
</pre>
    </blockquote>
  </body>
</html>

--------------5C7IUKbzsWIkUoavwvY6DLZo--

