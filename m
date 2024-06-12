Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556EC27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 13:20:21 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web11.11201.1718198418940332733
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Jun 2024 06:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mp3rqpZe;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955aaf8006so289706585a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718198417; x=1718803217; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si5PfmveNIAyPqn+BH97lNOmJlAznVCilBNSRgMxRMc=;
        b=mp3rqpZeO3FjYliChH2de9n+ftgD79HCX63YmBj4nERGGJ9SsS6opDFvvTKJSgZVFf
         eCEoyi1RdpmowFuAgg6A3y+Aw0984Ck3BB7Z8VztYqda0a7zj0BiW3Pfpm3rvlSXAcRT
         e2/q1ndH7NVM0lNlbBVg+H7hsOgGGkUtbYY5b4VPlX+ots3he/3ZOKfpPxrvwIwfPzXb
         NT3rUM3azCwQfCZLULgEwdht3lrfxI00jA69Kag/p3yqBY6LPlSBNlNPYsiirP8Dvet/
         2rjK+CWG3qc/pPqGxzjUy1easOeJhHfbzjWm8r/kw3wgJnMIed3myX1Wk+PQljpvGg6h
         v7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198417; x=1718803217;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=si5PfmveNIAyPqn+BH97lNOmJlAznVCilBNSRgMxRMc=;
        b=Db3C7FFD/lTCxgDMR1mnqWWDdiY2tqor6EKnjnVF18wcwB8/pLG/j13AouJpkLOPrs
         9RRvuy0h5WuWKH6gpVHVIpDhiMWLgCrs+aHmlJqWI7kPSB5JhRL7U6naxgB717BWXjTn
         jiaNgYHKipRqjzEQVdCDNTnb1uwV7J2gBou4ZjzaPqieP7yBD9Mpntn2TQI1NKTrGL3B
         DPlFBzkDRWc/eTIbTXOkqZ5SdRObcxapRfZrzqLz3KDpUZXZpY4cjcZwQDreumLM8kao
         8sKKDmSXgeDZdX3j3tu2UmxoIlpRd7KEyUV8vf62N+Ra893zBU+sS6mq2Y7tXJHGjosk
         4dGg==
X-Gm-Message-State: AOJu0Yy/LUs1CpHMQPDOsv6AysHo+7+uGe0ZXfsVRILimFsLERUP2nCh
	fTTuJQmeCFFjgz2kGnRjfPlsNRS2Vz98mUkYVhcPY5fOfOw3vcUWtf9ttg==
X-Google-Smtp-Source: AGHT+IGzbQbwMl+JOdHIQF2Ip2df1bt3O5Zh3ve/BhFhEXTiXzDjp1o1NniQanbaoOky8eQmhAf+IA==
X-Received: by 2002:a05:620a:40c4:b0:795:5efe:e7c with SMTP id af79cd13be357-797f60f6f24mr194152985a.12.1718198416825;
        Wed, 12 Jun 2024 06:20:16 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954e5ab739sm446734685a.44.2024.06.12.06.20.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:20:15 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:20:14 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] user-selectable wic
 compression
Message-ID: <20240612132014.GA25815@localhost>
References: <20240611181742.1408-1-twoerner@gmail.com>
 <6e0f1d2a-911c-4ee6-bd4d-5dcb0824faa7@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e0f1d2a-911c-4ee6-bd4d-5dcb0824faa7@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 13:20:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/315

On Wed 2024-06-12 @ 10:36:11 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/11/24 8:17 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > For boards which build and boot wic images, the user can optionally specify
> > a compression using the WIC_COMPRESSION_EXTENSION variable. By default "wic"
> > images are built, but if the user would prefer, say "wic.xz" images, simply
> > specify:
> > 
> > 	WIC_COMPRESSION_EXTENSION = ".xz"
> > 
> > in the configuration (e.g. conf/local.conf).
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to meta-rockchip, master branch.

