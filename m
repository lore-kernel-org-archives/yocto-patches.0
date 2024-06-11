Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9E1C27C65
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 18:22:14 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.1420.1718130126362286199
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 11:22:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DzUWR0jE;
 spf=pass (domain: gmail.com, ip: 209.85.167.171, mailfrom: twoerner@gmail.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9d70d93dbso838796b6e.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130125; x=1718734925; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwNiJhkQgOUWqw4OswyziJNSTKRF0gGCDjIsScmHjYI=;
        b=DzUWR0jEsL+iUzcAFKOUtfTuTfHkUFcrxIDaSnLYJRd9dA2mKcX+v9cgcpB/7IeUfD
         2Wsun6/3Gu9hOKKiy16e6j2AKMysHvKEb3zHLulebhSSuAeAfSvtpiOp2YF+OSxqkbP9
         +h9NFzMdM/rZPitKzCG1nh2P0izKQ1/R5ta0c8Hsjv7mgRQmm/+Q5UEJlTuKqNhReTdE
         upHTfNM0g67JmWnrSgIOansNxuRCIM6qMQ5XDrZKVKhjQ8EYZLvPXFfFsz8FziLkvkNB
         UkP+OgomXrT2uvQ3CL1DrSTapvcnDo6VdQBEc20B1NsVe0m5JDUWNzHz1aDTKrZmHLd9
         hsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130125; x=1718734925;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwNiJhkQgOUWqw4OswyziJNSTKRF0gGCDjIsScmHjYI=;
        b=jjQZUgp/I1QS5fiKg8By1zBZpSbRBUeb0j2IcAFy2W1aW0k+FH56ttQfRcWGaUoxoc
         2sAMsKOfG035+E7DTcaUDvHVD63KAM2TnGY8VZ/TiKs2jtli+K2ThT5EZ/uUMvrf6+La
         u4iU+DWAjtPrLEX8nUJ68WF5POyWRInG95pfkAjmci8FNRM9MbokuSW7EWHETka1oAxU
         pTanxdmEfv2VKZbFSvAUa+xMlChsQ63dI+7Enu/u+v4nL238rSdLKam3ROOySHaYgNj+
         5M8LZ+o6BHfuLGdQvpCqz88OMoj0MfKzJbZK9s/WM88sOcq9/H42hbNLKOkVrO4CRRQn
         IxXg==
X-Gm-Message-State: AOJu0YznkSpF+Z/i5UyTM7WjH2XCQod01XCHju4ZL3h8lQ/BPvcQeDc5
	HyqR+re8V12vtDWRU1OPQmhjUKHMFLEbygWr+5G90zxf98O0iEKY
X-Google-Smtp-Source: AGHT+IGAH0kH2diCDhXFdeEn5cDYOEN7m7tgpqNzGb7oDpxVGy0WDegTE6cP1TXFAGvdHMqu/8Q/8w==
X-Received: by 2002:a05:6808:14cc:b0:3d2:243e:e4b7 with SMTP id 5614622812f47-3d2243ee7e5mr8940365b6e.23.1718130125581;
        Tue, 11 Jun 2024 11:22:05 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44058d888b9sm32423521cf.77.2024.06.11.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:22:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:22:03 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip 0/2] enable Panfrost on
 RK3328 and RK3568
Message-ID: <20240611182203.GA2552@localhost>
References: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
 <20240611132944.GA39107@localhost>
 <b5cc2a36-3aca-492e-b726-c6f27abe12df@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5cc2a36-3aca-492e-b726-c6f27abe12df@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 18:22:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/311

On Tue 2024-06-11 @ 03:46:52 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 6/11/24 3:29 PM, Trevor Woerner wrote:
> > On Fri 2024-05-31 @ 02:48:13 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Note: I do not have access to any RK3328 or RK3568 device so I could
> > > not test those patches.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > > Quentin Schulz (2):
> > >        mesa: enable lima on all rk3328 boards
> > >        mesa: build panfrost for RK3568 boards
> > > 
> > >   recipes-graphics/mesa/mesa_%.bbappend | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)

Applied to meta-rockchip, master branch. Thanks!

