Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C82CA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 08:41:52 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.69852.1754988108363518259
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 01:41:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kGumcXVQ;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so8146370a12.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754988107; x=1755592907; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWpChZe1eIrO+TfxU82gtor0OqlO3oOzNrUT+GDqEp4=;
        b=kGumcXVQ3sPmDcysrD9AQy4Eyg7TakjFjiS4GGySNPTc9T68qezosRSi2j+UIlannO
         +1E/3qLBrSrGrv/Mze6eA4kwOm5xWstlYXtR+Vviy12x/97jr0T0Orp1Fwtilidic1Pd
         KEmoicyZYzoReTU0MQFH/uWam2y2Ra9KLVpfAZowRdZN1/ZtKZvdSttNn+I39Cxy6Uq5
         /dFnjuPPOelIamXgQfS8HTVW/T+p+pAkb+MIxknFrEvK+8JZ30qUXHHqW4X0tL6dcbT+
         YROvQXJDfTbf1M3kFVt4v0FlZLKvHhQN1jKjxvfEcwHYYTUj5kPjCNDwKnoL8t37+Pt8
         7Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988107; x=1755592907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWpChZe1eIrO+TfxU82gtor0OqlO3oOzNrUT+GDqEp4=;
        b=iudtcOalEyKbjydl33u8/nfjeB6/CTCb6lhFDhn4S5zDnvItLf4gDu38LK0lrHEOtA
         omduAymvZ5MxRZl+MixeHj+W2yqXZAzMTTqTKB09/nm1yuCdRvpXd0pSJY7X9pu3T8W0
         N4Dm96bdZv/UWRGdFpDHywAxGzJXjWtR2FnYgkbN15o605dEHq8JY/lzZURL98ydv6zu
         a1w/fQ5cElKFyDMKwi45NmH5EdN+UV0pHmfVc6fgqn1Dr8o30X7QOtVMWK20nmAoRZ/g
         W2mzYfWgHjjy1ZulH+ztL+8ICJjVEgVYxzIdgZlQ5jujji/e/mQn/j1Km8FvKhL6zSPW
         ld9g==
X-Gm-Message-State: AOJu0YxgtCFnoOiX5TErV/ZFFwZrzAcndhh9cLTjx0uVoa9hEYeW3rgj
	chh4S2ssJkYOB5TW13BO5oe2hnvQWUPV6lzPsD2sumUYHprlzFpZMsrRWjhy4Nww
X-Gm-Gg: ASbGncsQkTS+KwalV2/sVkN29M1Iw/1OapcbYnmw0UcUEXDPrzz3K2QLyT3+W/vhLLT
	sFSNrmDYx8hidN0e1u1NvUP1x3LiSzfQhXaemym+hai7qoGObpOWjSHWLaWjt3xLWpxXSCrUctQ
	m/tps9kQngR0DOxak2562mmxHnPeAY8YKkD734abxZoQdsCvHzN8CQetSwCkFjXYSCR45hnLRm4
	96aGA9IAxbzI1zKBqmRq11aBpnDhkyf350vaOpxj7sZ9REI3rmSkdJ3mdpXhcE/sIvLsREtyQ9q
	LjdRhJiNDqnXGteqGlVqix0kEPeqsyU8e8CXsQs7ww8N35mbTrHirggvf5r1O5M4MRUgTCMl89p
	qs4m+sFKZE+Z3jLpy7UDm/vs9OTrJQA==
X-Google-Smtp-Source: AGHT+IFTrTYHpy0GU6bbB269zJvGXY6Gs3QN4w9/WrM9xy5xv0mTSEPCO3u42dqBnmXZB2ZR+Do55A==
X-Received: by 2002:a05:6402:51d2:b0:615:a60a:38a7 with SMTP id 4fb4d7f45d1cf-617e2b705bfmr14252962a12.7.1754988106482;
        Tue, 12 Aug 2025 01:41:46 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618461ab3dcsm1809550a12.56.2025.08.12.01.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:41:45 -0700 (PDT)
Message-ID: <e66f8715-91fa-4968-ba95-3c4cff296835@gmail.com>
Date: Tue, 12 Aug 2025 10:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v4 4/13] layer:
 Set PREFERRED_VERSION for kernel and sdk
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com,
 sandeep.gundlupet-raju@amd.com
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
 <20250811194646.3408854-5-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250811194646.3408854-5-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 08:41:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1957

I think this patch could be merged with 3/13,
otherwise PREFERRED_VERSION_zephyr-kernel wouldn't be defined between
these revisions, and bisecting could susprise people.


On 8/11/25 21:46, Sandeep Gundlupet Raju via lists.yoctoproject.org wrote:
> Set default stable PREFERRED_VERSION for kernel and sdk.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  meta-zephyr-core/conf/layer.conf | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
> index e1bb263..e355b3f 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -20,3 +20,7 @@ LAYERSERIES_COMPAT_zephyrcore = "kirkstone scarthgap"
>  PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
>  
>  addpylib ${LAYERDIR}/lib oeqa
> +
> +# Default to a stable version
> +PREFERRED_VERSION_zephyr-kernel ??= "3.6.0"
> +PREFERRED_VERSION_zephyr-sdk ??= "0.16.9"


