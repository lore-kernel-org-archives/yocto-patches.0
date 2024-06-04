Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7DC27C52
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 18:04:23 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.2905.1717524255836834343
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Jun 2024 11:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e9pzduFm;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6afbf5b88ecso11969346d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Jun 2024 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717524255; x=1718129055; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVa6UtKvDheCLphEXDDOveMdvRVNDTqTM85i4GgQh3E=;
        b=e9pzduFmm/UpIr3Pj1Tlwytu5Ndei6yXTKuohm+2rd8b2eu/ekXSdsuyrRf1QGA/Ya
         nlJfDE7pG2HQkA5kg5VDW53SVErLDgKrW6DWDmfSBIIe+2plxwulZbESudedp5HmDFDJ
         tXCAbgMlIXXvrSKaI3OBwBhg3W8SPoBoeyR/z2I/EKzhWHkp1tfKU9JXmNj8qorTZNCJ
         l/MmwMVJbwXCSCq07142JqcVhv18Xp0vC4rXTB68LNmoQp1tJ+TihZ9mDA+zpvz7jSe0
         AELuuloIv/QGBbsC/R+moN4q6Xzr0TXW6/CLOnFPl53HP/7/Eed/vQmTqA8VbgCAHlSi
         peCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524255; x=1718129055;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVa6UtKvDheCLphEXDDOveMdvRVNDTqTM85i4GgQh3E=;
        b=lmNHU8Qsu2ecpBDjsxB/Zn6k5SEH0zP6r0/oxw0e3OOAFf7FhQf44P5bJwno1f1wR0
         m81QNqGVYwHxuOSUA2gNzzRCUQADs7x2WzDL4DxJjTHAsgS9856pKDqTsQGi+AUzRpEp
         35EiaGy40hz7LuMBexPws54qTAHER2P4h4mR053OmHTK99NUEpb/S+dRbo+obsx8MfO5
         nO9wdYx69Voycu6FWdC84dQwDkdc9ObKWFqG1xV7pbepaq2N1M3SnWVgBIpYrb9F3oAB
         4Qk4Tg+lgDvKoRA15c9UQQpOVS2lwCOvTCd0WK9+o4tZjPuIveLVPSpC3Sv7kcH39re8
         cC3g==
X-Gm-Message-State: AOJu0YwjmE5tl7pIvpcFeXs4LM0JXE0POxRrFJ7G0I2HIVl+hmAc1VH3
	Mw/TmnIABLhOGX90JvMmWHkJGqBuBpgTimwmyXnIKodA5H1xaY74
X-Google-Smtp-Source: AGHT+IE5Wax74BKYeuPz1S0XcSlcNOnVIxQ+S9tlDqL1R4mE/jXLXyG2c7OKLd/rHulii7a5Ot6psw==
X-Received: by 2002:a05:6214:3a87:b0:6ae:3c78:3f08 with SMTP id 6a1803df08f44-6b02bf93021mr1240906d6.36.1717524254616;
        Tue, 04 Jun 2024 11:04:14 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af38de6cf5sm30045976d6.145.2024.06.04.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 11:04:13 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:04:11 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip] rockchip-extlinux.inc: fix
 non-fit KERNEL_IMAGETYPE image boot
Message-ID: <20240604180411.GA7175@localhost>
References: <20240527-non-fit-fdt-boot-v1-1-72bf2530547d@cherry.de>
 <20240530141144.GA23102@localhost>
 <cf4c218b-e40a-4ba2-bef2-318997d4adc1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf4c218b-e40a-4ba2-bef2-318997d4adc1@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Jun 2024 18:04:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/275

On Fri 2024-05-31 @ 10:50:43 AM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 5/30/24 4:11 PM, Trevor Woerner wrote:
> > On Mon 2024-05-27 @ 03:48:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > 
> > > On systems where KERNEL_IMAGETYPE is not set to fitImage, one needs to
> > > either pass an DTB or a path to a directory where DTBs are located on
> > > the rootfs.
> > > 
> > > When FDT property in extlinux is provided, FDTDIR isn't used (and
> > > actually u-boot-extlinux-config doesn't even write it to the
> > > configuration file).
> > > 
> > > When relative paths are used, they are relative to the directory where
> > > extlinux.conf is stored[1]. Since the DTBs are stored in /boot, just
> > > providing the filename of the DTB won't work because extlinux in U-Boot
> > > will search for it in /boot/extlinux. We should therefore either use ../
> > > prefix for relative paths or use /boot to make it absolute. /boot is
> > > more explicit and easily parseable, so let's use the latter.
> > > 
> > > [1] https://wiki.syslinux.org/wiki/index.php?title=Config#Working_directory
> > > 
> > > Fixes: d80fa46c42f2 ("rockchip-extlinux.inc: handle multiple DTs in KERNEL_DEVICETREE")
> > > Fixes: 3b51866f2251 ("remove /boot partition")
> > > Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >   conf/machine/include/rockchip-extlinux.inc | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Trevor Woerner <twoerner@gmail.com>
> > Applied to meta-rockchip, master branch. Thanks!
> 
> Thanks!
> 
> Can we backport this to scarthgap too? How do you want to proceed? I send a
> new patch with [scarthgap] in the title?

Done!

