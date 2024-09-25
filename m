Return-Path: <joe@deserted.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413ABC369D5
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 11:55:47 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.14061.1727265338870446358
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 04:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@deserted-net.20230601.gappssmtp.com header.s=20230601 header.b=re109nma;
 spf=none, err=permanent DNS error (domain: deserted.net, ip: 209.85.222.182, mailfrom: joe@deserted.net)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9ac2d50ffso69779385a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deserted-net.20230601.gappssmtp.com; s=20230601; t=1727265338; x=1727870138; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jp516UPtWJL/4DnPIrUq5SwPvhx7aA+RpTM/zy6EQig=;
        b=re109nmaxP5PT0aWUXKEqA+Mqv6b0X2X+M8sxZuuwVx9+8xxcDwPv+BQbyLjyuFrBg
         qxWKmeFW/K4+folwjS9h+YutulozyrkmIXIS8r53hfYJzMVTQjRPe6uSqfNfKmpo8qJJ
         Nq8yvIKEkttuGINAoe/4VmV2TKwZkMECCa+S8V/ICPhx/tUDttTYkBt7Vt0OwuWHKd1f
         q+U990iQfNRS05/OHQ47iylLgYp0OYjkYOkfm9gn1JPLoqMmz5R3uYThOUspEUN6xxxK
         Pzo1oQmkAKqCmjQ1CC+fGW+FRV2rXTgfW11EzNXaHtX4iZeNthSaFn9d7u2nqtrzBJ14
         Fv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265338; x=1727870138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp516UPtWJL/4DnPIrUq5SwPvhx7aA+RpTM/zy6EQig=;
        b=Km1c9jLiH0fzB/yr8WaM8BNwCKIeknaJ2UcF3Vs4piVmV9fB61CTQL9EfEjxcw+Sfr
         EBBw50vbOetXgNekcPSKUlNtxkAtIv0o5Da3LNsMPhXaS0wLF0oq4vpGBxK8PyBxYHVF
         bh5KRabUwB51gwBW1+daMDoFhIqgNpyzGY3l/BanxtpyS7TmYN8U37oiI8igYcNASgUx
         5OV+4EuXNHWcBG20msw64tLz0R8X+TmmdxLfFzqQm+UbLbAdayTD0l+tPbDjJfpbOL8C
         +3P4AEuHDbYo2QmuuuiGu9aqro1/xDTJcZVTC7GmhCN/Wwtxj/rbQxSTAyEarIa/z6gF
         jK2g==
X-Gm-Message-State: AOJu0YwO5UaZyOxFEXxkgSlfXZ3PiauM0FSxbrcWLV5ttlQ5ry1eNHEq
	9RuYk5CY3GQ5n6yUBp7fbxwTtt6EcV8MAiKwcu6l4PY9YFomqQ4PL3Uzev8JlA==
X-Google-Smtp-Source: AGHT+IGup35fIvV9yYAnkx6bqr1OthEOsCVscWg5fNS6wAf6T2+g3DEGfzwywdrWN4jKS3aYgwq/+w==
X-Received: by 2002:a05:620a:19a1:b0:7a9:b82e:723a with SMTP id af79cd13be357-7ace7544c0dmr416589485a.31.1727265337831;
        Wed, 25 Sep 2024 04:55:37 -0700 (PDT)
Received: from nightwinge.deserted.net (bras-base-jkvlon0513w-grc-11-70-54-131-55.dsl.bell.ca. [70.54.131.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5445b4sm163558885a.52.2024.09.25.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:55:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:55:35 -0400
From: Joe MacDonald <joe@deserted.net>
To: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-selinux] [PATCH] layer.conf: set
 LAYERSERIES_COMPAT with styhead
Message-ID: <20240925115535.2nr2hpiue5tz6pcy@nightwinge.deserted.net>
References: <17F693837DCF4DA2.31299@lists.yoctoproject.org>
 <TYWPR01MB11861C0221FAAFA6391AD0D5BDC692@TYWPR01MB11861.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB11861C0221FAAFA6391AD0D5BDC692@TYWPR01MB11861.jpnprd01.prod.outlook.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 11:55:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/673

I don't think this is applicable, there was an earlier patch that made
this change:

	https://git.yoctoproject.org/meta-selinux/commit/?id=7886cda8a505886fd9532d9585f7e9eae78cb52e

Thanks,
-Joe.

[RE: [yocto-patches] [meta-selinux] [PATCH] layer.conf: set LAYERSERIES_COMPAT with styhead] On 24.09.25 (Wed 07:16) Mingyu Wang (Fujitsu) wrote:

> 
> ping
>   --
> Best Regards
> ---------------------------------------------------
> Wang Mingyu
> FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)
> No.6 Wenzhu Road, Nanjing, 210012, China
> TEL：+86+25-86630566--8568
> COINS: 79988548
> FAX: +86+25-83317685
> MAIL: wangmy@fujitsu.com
> 
> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org
> > <yocto-patches@lists.yoctoproject.org> On Behalf Of wangmy via
> > lists.yoctoproject.org
> > Sent: Thursday, September 19, 2024 3:08 PM
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Wang, Mingyu/王 鸣瑜 <wangmy@fujitsu.com>
> > Subject: [yocto-patches] [meta-selinux] [PATCH] layer.conf: set
> > LAYERSERIES_COMPAT with styhead
> > 
> > From: Wang Mingyu <wangmy@fujitsu.com>
> > 
> > Set LAYERSERIES_COMPAT with styhead in layer.conf which aligns with oe-core.
> > 
> > Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
> > ---
> >  conf/layer.conf | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/conf/layer.conf b/conf/layer.conf index 4e04e5c..c7f8dfb 100644
> > --- a/conf/layer.conf
> > +++ b/conf/layer.conf
> > @@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
> >  # cause compatibility issues with other layers  LAYERVERSION_selinux = "1"
> > 
> > -LAYERSERIES_COMPAT_selinux = "scarthgap"
> > +LAYERSERIES_COMPAT_selinux = "styhead"
> > 
> >  LAYERDEPENDS_selinux = " \
> >      core \
> > --
> > 2.34.1
> > 
> > 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#659):
> > https://lists.yoctoproject.org/g/yocto-patches/message/659
> > Mute This Topic: https://lists.yoctoproject.org/mt/108535475/5974946
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> > https://lists.yoctoproject.org/g/yocto-patches/leave/13614271/5974946/19028
> > 31066/xyzzy [wangmy@fujitsu.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> 

-- 
-Joe MacDonald.
:wq

