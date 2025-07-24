Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64416C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 11:28:53 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.10226.1753356531978990000
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 04:28:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f3SJp8yx;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab380b8851so6748571cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 04:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753356531; x=1753961331; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3B51IImtkMwF40Z3vRfqpspkJdvOp/GgZYDXKKSUKLg=;
        b=f3SJp8yxGh2tn3jyVpG2UHaDra/1CZ5uaBZFONIlvWZMEB3XgMDwq3U5xhg9tiRyrp
         ToQeBO4sEQlxr80+4zCZyTu06lXB3oFMbmHjgzXSha6XMqRiv4TWFeyypopnGnvbkdy3
         RG/3b6Azw5IvN1rdTxXX/U8nsF0bEpLKIVTGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356531; x=1753961331;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3B51IImtkMwF40Z3vRfqpspkJdvOp/GgZYDXKKSUKLg=;
        b=I4QXhzZHLV9EdUjOql3NJZkhTqMeYlyFJ2WH4fiVnzXmN+M2oIyuQK/1fGE1dt95Rb
         oyBaR5UVrTYwCC+WSEWoBCJ6ppEPnvcxdC+CDJtwM6sMZHrOYdDlXdUM2dXzRAvzlsmI
         4V8mIxaTFoxAx7JUoOE8zYoISEXFzWpHL7Hweku8mWhq9/xEmy/lA8dZpZyMyTbn1oxY
         olpQ5Y5Kg36gzjuD0bfrMLShDdU++zKubqLtOELKqDvGdzRwIWYleo3siEsrHFaraTdw
         /JhJjk+AWYyWDjJsjvm21p0LEWCIbIQaibYNl3Svv5NMGhKX/F6qWHZMKnwn/0zPKkJs
         d0mw==
X-Gm-Message-State: AOJu0Yz1kWQEWS1Yncx3cD+VlkpQ2ApE6aQitpi6rz1n2kFBWzcDwTap
	YKe+CH762ulg0w2pAicQMDTeGl3ke4QD7vS+K5vsSAwOxchAfVktQouLfuvxP8heJ6ojs43YkLT
	ArzoS
X-Gm-Gg: ASbGncugYvvwYK07lH1KadC1g8rNA5aRLYBV4Vpm6B+V1y1x+rMxk0urM4icCdwT6Oa
	oaPIsM7PW8tQLmbpuByijJQTxKV44IR1hZaZlnHSEAo0ev2yz6shTH8fC/c/wPZSp3UUxo4QEi2
	d9FVN25LHHGK2x21xK1NVwJ8BOfEiOq8YRyUyathjyktzliokQ9Yd/zIp9pV7tJGccmN6PHfw/j
	3vPVq5Ti7p7eiquQQAaZvIAlnnGk9k9uwiPpZuvVLq8Y4GzDJxhNmL/SEIMzI+LTsfWlGr/mHWm
	gDMwvzlc6rSyLmcNOECWah/3K254qcN3g+vYtXUX0QelzILb25gYEIJOHUAy/tWMt4cdNYVLJ5I
	gEBi7ggYXeeBeXMMI5xuJpJwouI5oS81WYV1+XYkexyzb3N2UTVt68IYznn7pHMG9yKc=
X-Google-Smtp-Source: AGHT+IFRTuhkgRJvbqd8ps3OOz2aLSx4HJUpSamgoc2z8Wvi3jug9A9PNVvoFN6jrX1ec/CJFs3GLw==
X-Received: by 2002:a05:622a:120c:b0:4a7:1401:95a0 with SMTP id d75a77b69052e-4ae6de2d250mr89764741cf.2.1753356530539;
        Thu, 24 Jul 2025 04:28:50 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae7e32b4e9sm10045381cf.21.2025.07.24.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:28:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 07:28:35 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <marta.rybczynska@ygreky.com>, rybczynska@gmail.com
Subject: Re: [yocto-patches] [PATCH 0/7] master-next updates
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
Message-ID: <d60893ec-750d-9226-6085-4a86d5137d45@konsulko.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 11:28:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1867

On Thu, 24 Jul 2025, Marta Rybczynska via lists.yoctoproject.org wrote:

> This patchset includes updates to fix the CI on RISCV and with musl,
> add improvements in the build speed like the addition of shared
> sstate/dldir.
>
> Changes from 06bd60600e8db1b843cf5cc0f074a11eac7e9a80:
>
> Marta Rybczynska (7):
>   gitlab-ci.yml: fix file redirection for qemux86 build logs
>   packagegroup-core-security: unify conditional adding of packages on
>     RISCV
>   checksecurity: update the debian package
>   bastille: prevent host uids on files
>   kas: add common dldir/sstate
>   aide: remove for musl
>   kas: add whitespaces around assignement

LGTM, please merge to master when you get the opportunity.

Scott



