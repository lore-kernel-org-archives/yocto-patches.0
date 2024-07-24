Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CDDC3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 23:24:53 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.24041.1721863490455220817
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 16:24:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fK+bWDNM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so2023935e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721863489; x=1722468289; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Krl8SZMmq9Md0BWHyr/ANJkDRMUkfRf49RDx8dIk9h4=;
        b=fK+bWDNM1k0CpgHzj6mkaK+6xrlQeHHS9VTvq/vYK+UDYN30l8alnA/UuciPCMgY97
         GiI0pcRbX20JJztR5WBYsIy8KVmnqY+zP88RoaeVDTs11Bsfpk3HvAJageZ7mF9fR7EI
         6t1hZq6tFWp5uNzV7DMMVu/KFzniBy+Sli/Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721863489; x=1722468289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Krl8SZMmq9Md0BWHyr/ANJkDRMUkfRf49RDx8dIk9h4=;
        b=jC9BMJF8Ase59aWocKfuv3PNplzJucD1mE/wbOc1eukO+jOmLaSXsUt3GhxDLNwp+1
         McliY3Ga8/nW0N//tvTpiYXjbx9bL9NVVk8oUim8d2OgihnaIjn2plJTBJdvNfVvHkAm
         hA9lPiY2oSwLctJ3kbPVEgrG5C4/+SJ0bDHp/C2QL8dHXEs75DxjMYOx4KUG4K8a1Ihb
         d4XuBt62d3pGx32tc/IYbJDwWorRNB1MFBVATnyIcrJ/sb3LKmzdtWAwHQi7bmrRjILx
         Qgg/Tlro+LLNCe3Icka9wv+K41CO42tS4B2f1xzscxRTa7OYaKZuhGUgP10BqxCneVLu
         rp3Q==
X-Gm-Message-State: AOJu0Yz9Y20UNxFkd/lxWLvZ/19hDhqx48Y0j874P2WTZJ0q32Bxmf7g
	izeGkEk2OmRv19oS64eL4LLbubT4h9eG5oxgVW0lQuDLv+YbaXzQhd68RL27BC98t9DJtXoDBST
	W3JA=
X-Google-Smtp-Source: AGHT+IEzJfL3xCHpBHnCCmSaFiF/+sUQUX6r/HpLVFNHOAc0M7yNMwvgedp1fieFZzJR0mpOpqlM4g==
X-Received: by 2002:a05:600c:1d12:b0:426:5269:983a with SMTP id 5b1f17b1804b1-4280550c273mr3000315e9.8.1721863488538;
        Wed, 24 Jul 2024 16:24:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a74c:d12c:aa87:d7af? ([2001:8b0:aba:5f3c:a74c:d12c:aa87:d7af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730bd0sm6687775e9.10.2024.07.24.16.24.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 16:24:48 -0700 (PDT)
Message-ID: <6dd36b40a4ae5316bd7c0ddff006d1f7a2c12ae3.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-cgl][PATCH] pacemaker: remove remote
 resource agent from pacemaker-remote
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Thu, 25 Jul 2024 00:24:47 +0100
In-Reply-To: <da18e2d9-48a1-45ca-b5bc-5b96304b2816@mvista.com>
References: <20240723155945.1705212-1-mathieu.dupre@savoirfairelinux.com>
	 <da18e2d9-48a1-45ca-b5bc-5b96304b2816@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 23:24:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/455

On Wed, 2024-07-24 at 15:35 -0700, Jeremy Puhlman via
lists.yoctoproject.org wrote:
> Merged.
> Mathieu you need to fix your sendemail.from. I fixed it, but
> the yocto git server rejects the list default from line.

Sadly the from addresses get corrupted in nearly all cases now due to
changes made by various mail servers. I've given up asking people to
fix it (they can't) and just have a hacky script which fixes the mbox
files before I apply them.

Cheers,

Richard



