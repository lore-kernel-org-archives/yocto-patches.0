Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B2C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 15:36:40 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.2888.1742571398610305786
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Mar 2025 08:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kwgEs/eR;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac339f53df9so449230466b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742571397; x=1743176197; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRD8m54+86tnJpnG85b9KwexoeOlyolpqqSUHa0eHEA=;
        b=kwgEs/eRMk/+gRLcpec+UhSxFto4l3WaWerpEegbeyv0CSPVfvythX0SL79PGt0brL
         9dKASMVh6zCIFjXArWSZN3PK2o1xMxPEfs0crWbxjLXRng9emhIahyPUawxxmpRyh2eb
         KtkEK0F0TexQwelXXS0FiENJ79Qz9T7r//PKJFiLQ3ChS5XRl8siuJlhLVteneAiBarr
         BKucPe2RwRyipJOgFr918qYKKUi6kcktR4Sr9zxkLCnuE+8169i+NdxKJ6cZoFr69zKA
         ABw01rvYfxFfS1KDfk/Y2s1byLre5TBMiGnYVlh5iIWDaCaYlAhrimrGCLOFbtqUI+gX
         rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742571397; x=1743176197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRD8m54+86tnJpnG85b9KwexoeOlyolpqqSUHa0eHEA=;
        b=GV6dgaZ4X1krbivb2topXp1P7tCw4MJIc6kf2FwrfM2IuPenHd01uxEnrKCmSdrXlx
         T6k+57vTzWuhkxbwD4eBexijdkSY1x8K7LGhNDppBJOBtf7nbVf80O4TVkeNzBkG2OS4
         ERVtCswGxfcyum1mUg82ax6nfNNBFaIMxWmZCCkOxAteQTxLb0SxHGv/VVdjwQXG7v+X
         ZeLM5hT8YYp1kvJuAXmrCOkNN4jsP7+5HPWK7QFISrBkXtzjghNgc8YVxsgQAcrU1xaV
         Ydy5h40NByHjI7v5fNyYkUAtZcE48a84zHRUvMfGT0fjk18ynOXhFvVMd+apS5LdyDtv
         Z4Cw==
X-Gm-Message-State: AOJu0YzBEwBI/xQJBDqx2TpPFfG3fge1oo0RVi1AvEudMpc+GicxKykL
	oXdjx8CHwknhQggFUkxe4FwOe9irBm4PQa3yKN3lmI564cZGeRwmtDF/1Q==
X-Gm-Gg: ASbGncuZuUpI6c3mzy/QQVJL7f6bzIKgVbPMmvCtkEs9EGVEJLxPgreGiAyRSZ6Iwhl
	1w51wpFyEL4HwmW1aGRLC6MTElFObjop1eHkBrCgahyC9mgkxCvJyzce6gUB9FLxWLX393/qVQ5
	pESYUe99+XWEvo5JlRS6cpyaRIUnNFxpd08sfsCKJI3Id2RhMCakZLURuJRVap/PmqcCN7mpvPS
	wANCKHRr6LY6PWbIRrd0kteVlqwPlKXtMcrTKffHNnMOb5Ia09aoAWn1ZBpp9jIhNimg9VHSyTo
	ZimLUer6EAoQ3TgJ/k5pbCOQIVuFZnsBnZ0zE6dSaXFrvFsUuw==
X-Google-Smtp-Source: AGHT+IGkzlwSbVCarUIynEjN47phffvGO5bP86i7SiBKurGFsL4/q+b1dIB1k+Xr1BQTxpaTqZj+sA==
X-Received: by 2002:a17:907:d8e:b0:ac2:8428:c5c2 with SMTP id a640c23a62f3a-ac3f20e51e1mr397861066b.20.1742571396626;
        Fri, 21 Mar 2025 08:36:36 -0700 (PDT)
Received: from [192.168.1.2] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdc7d0sm169506266b.133.2025.03.21.08.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 08:36:36 -0700 (PDT)
Message-ID: <3a1e9acf-69e0-4fbc-8412-36fcca575b89@gmail.com>
Date: Fri, 21 Mar 2025 16:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH] rust:
 use 'config.toml' instead of plain 'config'
To: yocto-patches@lists.yoctoproject.org
Cc: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
References: <20250320125903.2497365-1-vasileios.anagnostopoulos@siemens.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250320125903.2497365-1-vasileios.anagnostopoulos@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 15:36:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1239


On 3/20/25 13:59, Vasileios Anagnostopoulos via lists.yoctoproject.org
wrote:
> +	cat <<- EOF >> ${CARGO_HOME}/config.tomlig

Is this really "tomlig", or just a typo?

