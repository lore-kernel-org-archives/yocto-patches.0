Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626DC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:19:33 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.25195.1716909568670214674
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 08:19:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c86KAEQn;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ab9d01cbc4so4736356d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909567; x=1717514367; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/2mQds7SRycKYXcTzFErqu/gzd19TZMZNkzEu0MZeg=;
        b=c86KAEQnfvegNQgbw+w4Ucvn9BLpkwhmLqgpI64fq2tahWprZ2ig6Zx7lVrr1+Ylhl
         ynMdUd/DYdpuww6zz9kFpN8wijSmuEsDuSWvCJQbKrk/VLUHnrGy7/6/wsk06Dck48T7
         XP6dp38ewhb8KcQZ9kkNK8NyuCSYkQV1PJd+du87p4kKqHPKGVvYMIxL4UcaZi/9dveQ
         Ni5bCsEDdKHzTcKbtq+/qo8zpe26W1uZH1ZqjfUr6gAvsVhwvJng6RTfu4qpJyKx6WHa
         M9QM2dmj06ZyJLWV6bpXo17MrK63vEcZ1jEzgHWHvE3JQ6XwE86sPqF25TlARoSQDA9B
         v21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909567; x=1717514367;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/2mQds7SRycKYXcTzFErqu/gzd19TZMZNkzEu0MZeg=;
        b=vcyKfcOxwVCBiq9plXYP5Sf+Cb5vN5JU0vSRi1dtY3qEeGCJ0NevAoJdrT1k43nuQl
         kvu+JsC0Dk7MIY8d/PZcnkfv3uMSWli1gMmX0gW182uFr9OwskpPQVlQzCeAIgWDmESj
         lBT0RREowcUqIgkiYG6bxhXwfnd//v4xPkNjr2WMOSjjrAof9hqUQBeuuiWVEEEqcVQ2
         7p37GjPswBHSCUdaL3YHLkzVnyTxBlvan/13ZQiMkNsPnVddRWNqPT3o8QnEd5rVj/i6
         9sIEWfrs6+0XpFpyDuKOQSm1YrBj/5ftgckfMmTKehn2yEy/7w63jQIczmKecbfrm2WA
         IvCw==
X-Gm-Message-State: AOJu0YzDadnuZ3ip23iITu8C01gCQxzhcXJjWWcHaobz4gFAY6uPd8C8
	qSIlw5oZrwpk355RAuMjEQxc5BI/v9T6EqD39LdzorkFjoGcBo77xcJxKA==
X-Google-Smtp-Source: AGHT+IEdYvirsrn5XLlPXzqQiD/7+qygZn9bb1JTJzqogeQ/MbvCWm/ds11kcRuW5mSgyVOVakrYzw==
X-Received: by 2002:a05:6214:5a02:b0:6ad:80d8:86c8 with SMTP id 6a1803df08f44-6ad80d88af5mr91484566d6.13.1716909567031;
        Tue, 28 May 2024 08:19:27 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac07100a89sm44788756d6.68.2024.05.28.08.19.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:19:25 -0700 (PDT)
Date: Tue, 28 May 2024 11:19:24 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: updates for
 WORKDIR/UNPACKDIR cleanup
Message-ID: <20240528151923.GA28595@localhost>
References: <20240526010209.33012-1-twoerner@gmail.com>
 <56b1e90f-3ffa-43b3-88fc-e8e0f1493aeb@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56b1e90f-3ffa-43b3-88fc-e8e0f1493aeb@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 15:19:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/236

On Mon 2024-05-27 @ 02:23:02 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 5/26/24 3:02 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Builds no longer work if artifacts are placed in WORKDIR.
> > 
> > oe-core: b84eec5c4cbf ("base: Switch UNPACKDIR to a subdir of WORKDIR")
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> 
> Note that this isn't compatible with Scarthgap, so we need to branch off
> master into scarthgap in meta-rockchip before merging this?

Done.

> Except if OE-Core is planning on backporting an
> UNPACKDIR="something-reasonable" to scarthgap? Are you aware of such a plan?

I haven't heard any such thing (then again I don't read or listen to
everything).

> For the change itself:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Applied to meta-rockchip, master branch.

> I also saw that we still have WORKDIR used in
> classes/rockchip-gpt-img.bbclass, probably some changes to be made there as
> well?

Probably :-)
It would be interesting to see if anyone notices (in practice).

