Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BCCA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:46:45 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.43523.1754902004234431931
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 01:46:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AYcp/GwT;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so4784921a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902002; x=1755506802; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlzZQRe9GmI0wrUp0mK02MO/YBxitBmFBDjYnE7x0iw=;
        b=AYcp/GwTTAl0kmjqhIV7l3JyyTwneDJFN6j1KftsnmIM1L6sNKeq2c43ZwC8Pc24Nh
         AfS9ZIclmxYB9ULkF52Gy3QAjFsTZilOVZPeWoP/4kYwhzj6hHZ6M1gjulDlkyW7KhC1
         FHCXgqWPxgZs1f7Bepb+4eDEghK+aIk0SNSpBe/QDNc4n28HYNJhZhhzuiZO3kibtbz2
         rSRJ9oWN/3bsfRIPQ3Ps6yRAN/d5whZsRD/lL5kEtgEsgHw1zbkQr57UJAX/bq7vQ7ZE
         tdoWhY2jrc5D0z0rTlVpVUSaBwviOJTtQStP49r63assihAtlcUbAALLbyZ2LIfdcUpk
         KGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902002; x=1755506802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlzZQRe9GmI0wrUp0mK02MO/YBxitBmFBDjYnE7x0iw=;
        b=K5XpuIVHcYVbgIQW5qqczbdPFmMMrBkN7UbG70cZ0AzcTBm9hYtPPUwBMctgI/g0lm
         vtuUA3AIRZqBuzmPEZ5bdDbEyw6m2lOL3qFyhB5tOYii+BI8xyLaUrPUd+jihQPidG2v
         VfePor0prvIuNsIk8I0ZgKyU5X03C1VQexY1Kvc35b5t50AJXgFXf5+N3GNASnUlL7Jc
         2LNQjBMFo94+apc6Jng9odek6/nHdn/SeuthyLRLgR/l3kg552loIbW/77QIg7O6kYqo
         MZ4NC03DzQRfa/ZmyqqeUpE9fU3l3rhakoK8BqNONII14uV9SfkliTIg+h33+uUtvCpB
         gBvg==
X-Gm-Message-State: AOJu0YwhUY8e/CC/HoD4b2tZAd75W3uH3i5GV3Pmjw4yPM5mK5X4wrMF
	Jz3LqdS/OSUXD19zjiHk5A/YQSvOHhbOhlEzvaIiwFWeF8HTMCjm477yRjhSVA==
X-Gm-Gg: ASbGncsyHHArxVxFut1+xESabxexK6ttAHyh9a0FJWu7AyzF3jN6/2PPixyzpgBqtop
	Jc487VN2HcBt32Z9VxaTJQTzk8HKfei13ZQsTnKfwfQn1QKyd6EEQ8+54qYOL9k1MIN2MdJSjcg
	BZYKvqp4nTwrkgx6vDz5UkpgKnCFQSjjqxEN1socf44F/zqbGy+YPdpykhGVjYpi4VX67FvLodc
	BmVhdR8W8/oX21pu1CMzFZU1bhTaKf/poDTWLCbtELyZwQFwLaSWsVEKe+swC1vtyaymS4itM6I
	hSJz+K5N2PXNoB7kcyyJ6YyFgm0Swe5dCH3r3idfH/rzgdWLpK5meMfKr9Tt70qh75TJZKvhD3M
	a02Bi2IrkVag+5XiyFPyFYvWrfZcb+A==
X-Google-Smtp-Source: AGHT+IFtw+VTv7O8q7B813dE/Z2sRqYQTbNd6PSQq3wF31lFCQaFbb+ffqWVJHzmw8g2S9kK8kuARA==
X-Received: by 2002:a17:907:9686:b0:ae3:a78d:a08a with SMTP id a640c23a62f3a-af9c633180cmr1121517066b.6.1754902002239;
        Mon, 11 Aug 2025 01:46:42 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c050sm1977240166b.104.2025.08.11.01.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:46:41 -0700 (PDT)
Message-ID: <83bc1d22-e6e3-41d7-b380-5d9387c9959e@gmail.com>
Date: Mon, 11 Aug 2025 10:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH v5] [matchbox-panel-2] panel: added sysfs
 support
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
References: <20250716031705.110773-1-dixitparmar19@gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250716031705.110773-1-dixitparmar19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 08:46:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1927

One more note, I'm sorry sorry for forgetting this from the previous mail.

On 7/16/25 05:17, Dixit Parmar via lists.yoctoproject.org wrote:
> +
> +static gboolean read_val_from_file(const gchar *dev, const gchar *f, gint64 *val)
> +{
> +        gboolean ret = TRUE;
> +	gchar *endptr;
> +

The endptr variable is not used at all, I think it can be removed.
According to the docs g_ascii_strtoll accepts NULL also instead of a
pointer as the second argument.

> +	if(dev != NULL && f != NULL && val != NULL) {
> +		gchar *file_path = g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
> +                gchar *file_content;
> +                gsize length;
> +
> +                if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
> +                       *val = g_ascii_strtoll(file_content, &endptr, 10);
> +                } else {
> +                    ret = FALSE;
> +                }
> +
> +                g_free(file_content);
> +		g_free(file_path);
> +		return ret;
> +	}
> +	return ret;
> +}
>

