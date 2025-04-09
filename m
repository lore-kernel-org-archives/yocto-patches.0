Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6824C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 07:19:51 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.2807.1744183190291056133
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 00:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UiNlskmo;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso12318715a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744183188; x=1744787988; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PK0xtqib3LN1CsWstTmPpL+daJoZklqafuCPZgX+BpI=;
        b=UiNlskmo0rCJDxsCvfrgTlScFBa/eC/PsQGDZ133FbU1Q377Dp++2fXjrtMPYDfi/R
         Npm52+J0NWkYQn6TODTjj1Pn+rf8BqLY8Ii0eUW4mK2NEVcuyZyWHg8tqIlPqHzzKbKR
         WSrQORsYltHzh2KkhoNNcGPwp2+y2VKxpLtwq5nx3kjaySbN7LkZ8GZ+MGwpp0InhZvY
         +DOvzJ0GVv+6kPf0FPCIjsJpMNFZfP84xgbjHh556mbSjV2nV5IVajPPScudmVNRpCau
         i7FeZvTtM0qsNCQ+bjtN8SxYKs+nPWYlNniBzfUuNs48lPLxIx9qEr2cK2iYpD65DDck
         dzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183188; x=1744787988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK0xtqib3LN1CsWstTmPpL+daJoZklqafuCPZgX+BpI=;
        b=J5uTfRxVN2Zh/LARrXEKi35L0nEmdzP7aoO+5t/J9snlFtoW969ST6pk1obsawFfBl
         DPIOFHT1/xg2/7z9QV/urSbnmx2Rriyv9WJwgmiEqMXFqYYKHx3MfgWex1rq0xnJ84JT
         wc2/d8LZ8DQAWd7SwCU21x5cCDFk+1XUNdpusSU/Ou7uw6JhiNQqvXqKWSFGSTJbrdRt
         9g5uUWRt+KEy52FWZl2yzCBjNfw6vV7nI3fzJnzG8E4QSqX84EfrdrJtXN6LuCltvl13
         pT5b3hO7VSIJLM3QyNuz0kv7jax7fgzpYrtTXbo33MDOwrz3TVXl8R4k/JcQmkimrhnW
         k/eA==
X-Gm-Message-State: AOJu0Yyj/onivKXP512ZnxZkEDkQGH28pckhquSfNF9X4HygyE+QllIA
	nzDHW1LmiTjzaINKuGK7jlu76xMdMabiwqrBn/GMmGYHYvt2vEflCcZL6Q==
X-Gm-Gg: ASbGncuOcdYHwFluHFbdPT26d2/esS8VEQSeIBvCYWznE3fSpk+jISJFx0Z31owbeFl
	T6eCYaNNtIpEg+M1SMYzvucYGuY7R/ODUl4dit4I+fN1C/waXe/0wNbgov63jz19LmDqR03+QcF
	ZkplBd144EqHPBNEFLboR997iTrO+4pXrVPwvT45d6H4ScpomJ0i10R12pdfcosRjgPjAGNczLs
	iE2T57qgnP5wLl6LzLVhw/VP9ldCc6WTjlO+Fo4fH0dmoOey4TSh0UybRUCpOoVqNLHDyeS6XSe
	Oo9NAl1MzcWhFQqWbZ3LOxgiNk8s6tmweIYuGD8M2Eue+LAW
X-Google-Smtp-Source: AGHT+IHzAHjrCBbLvbX8vBb0f0EchwCC6LDLct/R3lVZqD7jrMPgSMdiAa9OL3ItQlFENdpNDieIQw==
X-Received: by 2002:a17:907:706:b0:ac7:95b0:d0fb with SMTP id a640c23a62f3a-aca9b6bc5f3mr197378266b.34.1744183188199;
        Wed, 09 Apr 2025 00:19:48 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb42casm45374766b.88.2025.04.09.00.19.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:19:46 -0700 (PDT)
Message-ID: <13dca9e5-726b-486c-9067-62e58ae94184@gmail.com>
Date: Wed, 9 Apr 2025 09:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/29]
 Update to Rust 1.85.1
To: yocto-patches@lists.yoctoproject.org
References: <cover.1744061149.git.scott.murray@konsulko.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 07:19:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1338

On 4/7/25 23:29, Scott Murray via lists.yoctoproject.org wrote:
> This patch series for the scarthgap/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to to pull in the
> 1.81.0 -> 1.85.1 updates that have landed in the last couple of months
> in oe-core.  At this point the backported selftest (as the "rust_mixin"
> module) is passing in my environment except on qemuriscv64, which
> is currently also failing on oe-core master based on my testing.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.
If this comment is of any use: in the past 24-ish hours I have compiled
Firefox in many ways using this patchset on Scarthgap, couldn't find any
obvious issues - it seems to work for those recipes at the very least.

