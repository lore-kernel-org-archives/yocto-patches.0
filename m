Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE18CC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 07:55:04 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.51597.1722239696317035069
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 00:54:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qN9sq7VK;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f04c29588so5647367e87.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722239694; x=1722844494; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKoJYn1iUPd51gS2v5/WwSGKZTymWZ4PapMc84N0mPo=;
        b=qN9sq7VKeExqvjKYiEPC1fOt3n96JmTMIfKv9CuLxMsJF/b8ndAS9X2aZRLfgnXYqT
         odi0xpyzMQ/Ub/u3fEzmRruyTGvmN4x3sFs9JwJK1NoZ4Xo76vC5VB+yNzRjELNZcEK4
         TWGSJNX5ALnq+jPe9SUPiVgWaFH1u542KwD1USJPlPHm4lz7QjaoW3RRrR+bxC1fKUC/
         XZmqgUVOqtnj8Y2Pu14OKfy/ZeMoaqYvaW1q1rDdOlBRxc0G0bbwqhqTf21LSLfOUQbc
         xn3Hoh6HtCVarM9ztfFQXPc3SAFP2gE38NrVREKtCNrfPMfpCY+mWe620TJyZ0ZUGimF
         3Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239694; x=1722844494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKoJYn1iUPd51gS2v5/WwSGKZTymWZ4PapMc84N0mPo=;
        b=hyfLAbONAjrcnWitdBY8drOWjVOwM4v6AB20Jre9+2ptuhfJ1lPNyDn+DvCdUz3RXm
         9vzv1sNqYAkOeYm2tOvOe/52szb4vfsTdHCusHUvIKb28HFvcaKTWHTA2oqBjvvzSx7f
         jFvJ550JcqA0564CagbCG9SjoetZuZnnxXmntDrcGeZU03nIRWwGcxKMsQO/Gh3pnDMF
         9xWqifEuHSbMaXBDFmD/vPPY0OSQEJrOnbajJC1cpTvV25cerWTPL0N4xRJxZcTODKqi
         pGubeLWYR6CQQ+okMdh1v1MDV+Hi8ITkU01wNxXS4TYvHQeu+uWV08/6KNeooU1hPnE9
         Qr1Q==
X-Gm-Message-State: AOJu0YxVSJCDy8J9V70O77dOJUSIk7YlbvHTw2UjakHhQbAtAcwhV2Tp
	Cf4oaWh+1wDW9r+5dJ728dipW/SNkOIKXnji9VdEvBub1sKgI1SshjvS+ydc3aE=
X-Google-Smtp-Source: AGHT+IHSJ4pvJ/uhseI+pX5RiKgdUo2c861TivfK20lRCqv0Xod9I5pFH5CkCHcRso8ULU6C6Hzw+w==
X-Received: by 2002:a19:e041:0:b0:52e:9ba5:9853 with SMTP id 2adb3069b0e04-5309b27a55fmr4340567e87.24.1722239694322;
        Mon, 29 Jul 2024 00:54:54 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd11e5sm1401629e87.114.2024.07.29.00.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:54:53 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:54:52 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: akuster808 <akuster808@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 01/17] bastille: UNPACKDIR
 fixes
Message-ID: <ZqdKzCM2UXssQtWz@nuoska>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
 <ae98ea6b-f9eb-4f78-9f9d-f5f196d884ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae98ea6b-f9eb-4f78-9f9d-f5f196d884ff@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 07:55:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/488

Hi,

On Sun, Jul 28, 2024 at 01:01:10PM -0400, akuster808 wrote:
> Mikko,
> 
> Is this series different then the one I posted a few days earlier?

Yes, it's different. I missed your series, sorry about that. I guess you
mean https://lists.yoctoproject.org/g/yocto-patches/message/446

I submitted fixes for the issues I see in my environment and when
trying to compile some of the recipes in meta-security
after making changing. I don't mind which patch goes in.

Cheers,

-Mikko

