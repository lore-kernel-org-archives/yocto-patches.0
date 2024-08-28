Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB6C7112F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:21:56 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web10.6297.1724876509679633509
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rBrdnbLH;
 spf=pass (domain: konsulko.com, ip: 209.85.166.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a109bc459so10859739f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724876509; x=1725481309; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GexZjndkRiNOv3Kf8b1JINl8kkSmYH/TTFznDR4mnew=;
        b=rBrdnbLH+i3ouOJt8xNlBDQZ8vnQUCX+8Chjy+B1RUXD42TodSpIj40PNTG7ZSu08f
         YhJe95nQP/KwUD2fzxdeBbL5oiu1qIYnL8BkB+PNIEngmc38fyP7M3fCqhUXVD21myCC
         zPq6/KvyyUZiy6a8OP+0TBFSobC8XQbIPcaOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724876509; x=1725481309;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GexZjndkRiNOv3Kf8b1JINl8kkSmYH/TTFznDR4mnew=;
        b=NFv69ogw7luJRm5nrTrOgi5ZO6ifF4YZuJ3HedjFQ6/Pv5ACdxop9x0QQi1u4B09GH
         f7rwjX2/KdYlpnCAT+lzB9UGxhGYXJdb6dSjGhKjmuplIANzM2tujreJuhoTQ2citBA/
         5joeCe9z8LZLsAagz3Wg0qkjbuhpboRv0V/bY+p8JZTS0M5LKoowUMD+2tM2Zxk9kKEA
         ydX7r8kEAxf6IvzRymzjXs9eRloJ3KHfBVZ2xdd/3BBOndw6n5/foVlumen1tF+gI9N2
         Xk2yN5bpiPNuL5nyPs2wgnj5SFWSu4l7LvqhWWH1mrnAXsxUQfWO8Gc6wihT4NdURcoR
         2pPA==
X-Gm-Message-State: AOJu0YzqFt2Uad/4/fmY94Mo3KoqjbN2nRsRyPAc28SatAVvH2O8u9OH
	fGCDNruxPFDep5oaLlqP/PFlTsh4P8nDnq49gO1ldoJaSRuYY2/BImlW9wJcplY=
X-Google-Smtp-Source: AGHT+IG9ym38yW0s3RQVwdODg1te/p/0tCmLhv9qMmFyXQNN6YSgZ8VLdcHGkDOW9jR0LwFJBYWxmA==
X-Received: by 2002:a05:6e02:1c2c:b0:39b:35d8:dc37 with SMTP id e9e14a558f8ab-39f38b47ab5mr2099555ab.13.1724876508759;
        Wed, 28 Aug 2024 13:21:48 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f38ecfdf2sm364435ab.69.2024.08.28.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:21:48 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:21:37 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Ranjitsinh Rathod via lists.yoctoproject.org" <ranjitsinh.rathod=kpit.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH] rust:
 Add new varaible RUST_ENABLE_EXTRA_TOOLS
In-Reply-To: <30467.1723016921022337678@lists.yoctoproject.org>
Message-ID: <b5aa249c-4cdb-8c4b-e37c-ed3d29e8aba9@konsulko.com>
References: <fa71e03e-a028-b802-1968-d4e98ee27799@konsulko.com> <30467.1723016921022337678@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:21:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/601

On Wed, 7 Aug 2024, Ranjitsinh Rathod via lists.yoctoproject.org wrote:

> Hello Scott,
>
> I have sent the patch in upstream scarthgap and it is accepted and available on the scarthgap.
> scarthgap change: https://git.yoctoproject.org/poky/commit/?h=scarthgap&id=6ced2e7ca3b58130154035ad61685cd222909680
>
> Also I have mentioned during the patch that this is not compatible for the upstream master as the line on which I'm doing changes, was removed
> https://lists.openembedded.org/g/openembedded-core/message/202732
> https://lists.openembedded.org/g/openembedded-core/message/202988
>
> Thanks,
> Ranjitsinh Rathod

Just to follow up on this, I have not included this change in my updates
to the kirkstone/rust mixin layer, as my policy is that that branch
tracks the state of oe-core's master branch.  If you want a hook to enable
building rust-demangler available for kirkstone, my suggestion is to work
up a change for the Rust recipe in oe-core master that allows making the
addition while preserving the default behavior of ensuring that the Rust
build is reproducible.

Scott

