Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBEC369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 10:42:36 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.9098.1744972950714362230
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 03:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EPB2E+nS;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25520a289so242176866b.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744972949; x=1745577749; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hNDsT1xShiBfw+6/VHD94Fd6UY/tqy/6tnY1hPTsxg=;
        b=EPB2E+nSzBcgOUNyXcJlgOiHi8W1LJbIqTuGRPGw/w9DbhmZvbXF60afdPmCSpbU4+
         oo5I2SkudY1WAoMtkuXNcasc3EcMbhQOfbklwcR4HAkbKF3FppS0nofp4jAR9vY8dvGY
         prXO2afb5wzKgEGo6kKJD/gGXSNiu7OLPhFC9fqF+qkPr5QVhHqsQroev69hgHTmE9TK
         CsCiqSB5TwUfYtkN1h17mCeTJeAxHD5uDD1baYgR6EEsCVN1j22RB4l3HcxOYhJB3HHe
         C7p+ftzWKAihM6qjzdIsiEP554kfO7AmthJcsei7mCOiV5cCl6WQInBBlEI0IXMygPhq
         GdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744972949; x=1745577749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hNDsT1xShiBfw+6/VHD94Fd6UY/tqy/6tnY1hPTsxg=;
        b=v1OjVvTxogj/ngQ4kFnZKfcJhKOMHt96uiSM9Xg1CH5T3aUbgFjUlCP/8rzXGax02Y
         YkNunr/VO6CdejH7IdXT31MFhTAG+DKLKZerfwnbd1jlH8qDzmIDwieezDxFK+Ckbc+h
         zXHsL5LLJrWEvX3iz/jafHDMjOYaja6ZWXtkpIBEAr0CsTVNb/xaaxJO7CNkgQ/iquvv
         W6Hnnvptnv22FeC1FgcfE+tQDAMh2NEOMvKmdLYg0Tvq3SCuGFEWmKXDrSrVRciZBoc5
         pNWJ6QCO+LCHo1Vl7To+qh18Yohv9D2RJThNZ1ZzZkQOsHP0EYap3pDnTZyi1nGSZsf4
         9JZA==
X-Gm-Message-State: AOJu0Yzg84di7s16mLplKbP44eCrxc5g2yuBdk0PxFUtpUgjIkxtS9ET
	zX4VCFWdTHkmAnygalI30A/sFoJSw4q7xOu49HCSbg1gksqu7tkBANDlfg==
X-Gm-Gg: ASbGnctGflTUD/CwMeNhSZdZ54tE9lt4m1Dzqw0F53yerUsqM8He+bnYAnzkrUumAkN
	PFYtdUXHA+cqibC0wF9ROqkAviNnaCAInKVJI2HV6tORS3R8X2jbWxYlbqXxtCAZ8aH/W6FMokp
	/F8BQGj8p3O6zlixXLFqMUl/qPabY3MSMWw6MduNsG/z1iRW0PavFWS7ouax1EkskEPZlTQXhz8
	iIpFmfImliW9FRCPMUFNBXKz6aZAp5ywgGJJdWJFk5FlkvsRHnEr7eo9OHNaZZucf0ffYWLT61R
	EAUjVcF9gvhfB5KbdaK+O0wPH7/VaCOew3KB6ftu1ndoKxB9QBiWX6pnPmY=
X-Google-Smtp-Source: AGHT+IFZ9vEJIIunyrj9zlzRUxb8Qi/xaSdl48k1vrdwdcUf2P420bWkMtdpOBYlmIPF8CCdXLYudw==
X-Received: by 2002:a17:907:9484:b0:abf:c20d:501a with SMTP id a640c23a62f3a-acb74b0594cmr177761866b.16.1744972948789;
        Fri, 18 Apr 2025 03:42:28 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62554a32fsm826710a12.5.2025.04.18.03.42.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 03:42:28 -0700 (PDT)
Message-ID: <3211d1e0-2bc7-4fe0-9db5-12a534c3d09c@gmail.com>
Date: Fri, 18 Apr 2025 12:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 disable ptest by default
To: yocto-patches@lists.yoctoproject.org
References: <20250418051738.2928980-1-yi.zhao@windriver.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250418051738.2928980-1-yi.zhao@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 10:42:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1383

On 4/18/25 07:17, Yi Zhao via lists.yoctoproject.org wrote:
> +SSG_PTEST_ENABLED = "0"
Wouldn't "?=" be better, so it could be modified easier from local.conf
(&co) and env vars also, instead of only bbappend?

