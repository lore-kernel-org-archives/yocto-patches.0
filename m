Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6ECD5BB1
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 18:33:08 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3146.1779820382107793017
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 11:33:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JhiWfNYf;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-911501a99feso1311137585a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779820381; x=1780425181; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jchelAsiNMyK9ONpwiKcNOZlUcix/qqhNzbBfjF6cfg=;
        b=JhiWfNYf1AwAH0doLcYx/3t8V2qSkTasy/9k73IwrisKScW85fzV31b6ySk9RnPLhc
         fYILvO+n2oPchjUuIdj1y5YhQ3vsaNbz+BTySmjU1u1m6E2nCpACorFywYO5Gg5LhGjl
         oza2gPuc5ceN9Xp0Z4Dmzt0JeCuYDAhLoQiDeRb1IrM74tD19MJNqdgTxG5cqa+F3eEh
         KN4syghTOn1NfiSmUMNqWI9ECJbXhPYVEokY7UZkYTig+yBfSwWzLw8kyLOp4u9BmmL6
         0jAHY+3XSEDAgtraE8bYgTUA/eh1guUsaZTsKVvbd8lD3BHPvH9TnduHAJPizE24FSRT
         VtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820381; x=1780425181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jchelAsiNMyK9ONpwiKcNOZlUcix/qqhNzbBfjF6cfg=;
        b=neLH/eRLwOdisNQJ5K0nrO/avsuXGzUzswaZeK7xadgw74QJaHcSQzqV50YQFvzELt
         ey5IpcgQ4NVcRfu7nAEBWzf3CIpwsjftif7aTJgae/PP0/ZtZKtlLRDg6PFPoHIvUtdl
         lA/GLLzRIwLYjIIVkwo6zJfZ7kU42quaG74GCtGvMweUxyRfzoWf2CNIjfI+zBZBauLQ
         C/Nh78TZaUPy6yLTxzJtdMuaqanksvagxdQrYD81Dk+gWqBOfVKhKcbri2uH8rH0VlP1
         EOm4LSfhmYlCronmbzQCzVawJKQDur7E7o/oxhAbdA1J6bL46PcSn+FyYcbz5EdKp5VD
         NDsQ==
X-Gm-Message-State: AOJu0YzuyYDuLkg68E9xKUuTOug+RlyrJdteQ0k4GUZZ52IvVJtoUzIn
	siIBsap1qdlpryHa6nowTnYumiVtR8bI0nz6WXcg2ZjQUWgPzsUBYwZi
X-Gm-Gg: Acq92OH0DaxRZn3y4kQyhv8P5Bx5w1a0nacTYEwF8wADKZeZdMU8QUyQdt1BhpeIQzB
	qGAUWA0BZ0HAacpM5rJx5zbu1JcA8IQkI6YYMlGFdj+ScLB8VFUxXQTZFFp0wT+WiMhv8oaODvf
	KSwlbvbIuVCY531IjbKBAVDBl0dBna3I8RrK2ZuedFNxKRLeGhjLyzi+CLSOB9DkP1ew+extGfI
	bTYfKrPi+dfbIMoJnvy5SBq7Krrh0pYdv6iAFgoCWcZgxkdJMXcb9+Ig584m2C+CLsYIT8/JmsL
	sWxjg0TbP+l2Fqzm4Z4SAxZJ3AN+qlA4neQO5HzdXTXQZe3Motbext6HCdUmSdOdXBsDJMAw88O
	p0zT44EsfJnff2ZzhUv/TBFAJ8xC37Ud15fFqKwshwXXmSQ2hPDplzS/HEEvdxpen9DfwHRrN9q
	k1c7gTA50U7vABDWdcq5Nn8t2pDaCKFAROpgo+kZYL+4nALewULMMxwnHmm4g2zPT04jmt0m+Hh
	/qj
X-Received: by 2002:a05:620a:4096:b0:914:dbb1:1487 with SMTP id af79cd13be357-914dbb114e6mr1559611785a.53.1779820381071;
        Tue, 26 May 2026 11:33:01 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8801390sm312941185a.36.2026.05.26.11.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:32:59 -0700 (PDT)
Date: Tue, 26 May 2026 14:32:57 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Gourav Singh <gouravsingh@siemens.com>
Cc: yocto-patches@lists.yoctoproject.org,
	Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: Re: [wic][PATCH v2] wic/plugins: gate root= with rootdev check for
 efi, pcbios and partition
Message-ID: <ahXnWdS-VK9thPdR@localhost.localdomain>
References: <20260526093132.1956645-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526093132.1956645-1-gouravsingh@siemens.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 18:33:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4059

This update addresses everything from the v1 review, thanks!
Applied to wic, master branch.

On Tue 2026-05-26 @ 03:01:32 PM, Gourav Singh wrote:
> Checks for creator.rootdev (or cr.rootdev) being None were missing
> and would cause the kernel command line to contain "root=None". When
> using the Discoverable Partitions Specification, no root= parameter
> should appear on the kernel command line, as root=None is not valid.
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---

Process nit for future spins: a short `---` changelog (below the `---`
diffstat) listing what changed between v1 and v2 makes it easier to
see at a glance what moved. Not a blocker this time, but a habit worth
building for any series that respins.

See: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#taking-patch-review-into-account


>  src/wic/plugins/source/bootimg_efi.py       |  5 +++--
>  src/wic/plugins/source/bootimg_partition.py | 11 +++++++++--
>  src/wic/plugins/source/bootimg_pcbios.py    | 10 ++++++++--
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
> index 69aa38b..fe6c222 100644
> --- a/src/wic/plugins/source/bootimg_efi.py
> +++ b/src/wic/plugins/source/bootimg_efi.py
> @@ -97,7 +97,7 @@ class BootimgEFIPlugin(SourcePlugin):
>                          (get_bitbake_var("KERNEL_IMAGETYPE"), get_bitbake_var("INITRAMFS_LINK_NAME"))
> 
>              label = source_params.get('label')
> -            label_conf = "root=%s" % creator.rootdev
> +            label_conf = "root=%s" % creator.rootdev if creator.rootdev else ""
>              if label:
>                  label_conf = "LABEL=%s" % label
> 
> @@ -186,7 +186,8 @@ class BootimgEFIPlugin(SourcePlugin):
>              boot_conf += "linux /%s\n" % kernel
> 
>              label = source_params.get('label')
> -            label_conf = "LABEL=Boot root=%s" % creator.rootdev
> +            label_conf = "LABEL=Boot"
> +            label_conf += (" root=%s" % creator.rootdev) if creator.rootdev else ""
>              if label:
>                  label_conf = "LABEL=%s" % label
> 
> diff --git a/src/wic/plugins/source/bootimg_partition.py b/src/wic/plugins/source/bootimg_partition.py
> index 96f5e14..2e89b6c 100644
> --- a/src/wic/plugins/source/bootimg_partition.py
> +++ b/src/wic/plugins/source/bootimg_partition.py
> @@ -118,8 +118,15 @@ class BootimgPartitionPlugin(SourcePlugin):
>              if has_dtb:
>                  extlinux_conf += "   fdtdir %s\n" % fdt_dir
>              bootloader = cr.ks.bootloader
> -            extlinux_conf += "append root=%s rootwait %s\n" \
> -                             % (cr.rootdev, bootloader.append if bootloader.append else '')
> +
> +            # Check if rootdev exists
> +            parts = ["rootwait"]
> +            if cr.rootdev:
> +                parts.insert(0, "root=%s" % cr.rootdev)
> +            if bootloader.append:
> +                parts.append(bootloader.append)
> +
> +            extlinux_conf += "append %s\n" % " ".join(parts)
> 
>          install_cmd = "install -d %s/extlinux/" % hdddir
>          exec_cmd(install_cmd)
> diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
> index 1e5ec3a..2ae4eb1 100644
> --- a/src/wic/plugins/source/bootimg_pcbios.py
> +++ b/src/wic/plugins/source/bootimg_pcbios.py
> @@ -231,8 +231,14 @@ class BootimgPcbiosPlugin(SourcePlugin):
>              kernel = "/" + get_bitbake_var("KERNEL_IMAGETYPE")
>              syslinux_conf += "KERNEL " + kernel + "\n"
> 
> -            syslinux_conf += "APPEND label=boot root=%s %s\n" % \
> -                             (creator.rootdev, bootloader.append)
> +            # Check if rootdev exists
> +            parts = ["label=boot"]
> +            if creator.rootdev:
> +                parts.append("root=%s" % creator.rootdev)
> +            if bootloader.append:
> +                parts.append(bootloader.append)
> +
> +            syslinux_conf += "APPEND %s\n" % " ".join(parts)
> 
>          logger.debug("Writing syslinux config %s/syslinux.cfg", hdddir)
>          cfg = open("%s/hdd/boot/syslinux.cfg" % cr_workdir, "w")
> --
> 2.39.5
> 

