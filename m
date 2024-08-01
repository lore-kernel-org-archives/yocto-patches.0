Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D44C3DA64
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 12:03:16 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.66423.1722513792707842685
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Aug 2024 05:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gEYz2Vj5;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1dac7f0b7so432041585a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722513791; x=1723118591; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6CzLCVoQPmRDRtPUJbdvcsEGkliXUYlnrWwBkKTugk=;
        b=gEYz2Vj5KS1/ei+noAtsHZQhnaurkdQU02ttOtlHJOTVI2lvN1NVUNXQNlOFRfc8hJ
         y1j2eez/n212XassvDM1HzvCcd9PPmpxZgH3RwaKFVPjYe/myi3PT7FQ98Ec9if+ggxJ
         +M4wjGAeod2lA8tHHPK0L+yCL1tj+4vY+1OFgxI6xOmzNvFcpH9Dh80VRypNW6yyi/pU
         n+h4NPS3Vk3U/OzoArEKXcSPGrWtNd+3XjMtoGlKGRl9yiUFwVa8LEymjRKfAnvFpCwu
         rz0i3Msauptppt8xYvAKSjf893zNxVzHgklrLamWVuMo9MzaOMYrpSWAjc7xl2gGn8TZ
         tlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722513791; x=1723118591;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6CzLCVoQPmRDRtPUJbdvcsEGkliXUYlnrWwBkKTugk=;
        b=iVf8MNiVN3zGiljMM6via6pGCVC+AHq+YNIQdkb0qDilJsmD9XyQA++ji7aSSjLrv3
         Y3gFLJf4hg41ThqaFi3XePFqkYOeNibuIBZCE4uFQCJO6TJOBB3yVSbq4GfxvrqNOJI2
         /qzIQYKIUx3STY4sgP71JqcYmeiNa+jgG5KrlQLsiXlIvvTJjDIxHekweBGjLT2m8V+l
         2GTholQ4khp1AHRNAoaezzu7dQeDdmehgJMMJgFmg5z6stV6qH38aYVUXx6WZLzSU0EP
         Ev22EvRWcMIvqZpUMmJ3iBn2C6+3r3980/Sp5M9wNqAm4yIq8sxJ2DuEhw7TBz9Xmfd1
         fSPg==
X-Gm-Message-State: AOJu0YzhlKaRwOnUDDB6Maq+tO/KKJiUF4k/ckJfcYlVoJfnRxDiNQlP
	vx4iZVkXcnHOjwJkdDMWUZRPnnuGLRqGgZN63GIseJzJXPIEvSuadurAMA==
X-Google-Smtp-Source: AGHT+IGnOQ0e5ifI0Ooqujk78Q1qD8cwuP478GPeHrfXaPm+MVj/0aM8s0nqExBAum+frcUJ3mk8ww==
X-Received: by 2002:a05:620a:1723:b0:79f:73d:d2e with SMTP id af79cd13be357-7a30c6586e7mr229437985a.24.1722513790823;
        Thu, 01 Aug 2024 05:03:10 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73f02c3sm844468585a.65.2024.08.01.05.03.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:03:10 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:03:08 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 add rauc config
Message-ID: <20240801120308.GB6343@localhost>
References: <20240801030506.8626-1-twoerner@gmail.com>
 <7208a42b-4309-4216-ab64-16a5a82eced8.a73bd9c8-8cbe-42e2-876b-4c548d837fba.f860893f-53ad-4466-9b34-7b39f9829994@emailsignatures365.codetwo.com>
 <5b39fc2e-f15f-43f1-a992-77994d275d5f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b39fc2e-f15f-43f1-a992-77994d275d5f@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 12:03:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/508

On Thu 2024-08-01 @ 11:03:12 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> Considering this bbappend is only added if meta-rauc is present, which
> guarantees the presence of recipes-kernel/linux/linux-yocto_rauc.inc, we
> could have used require here.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Sounds good, thanks for the review!

