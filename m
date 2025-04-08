Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4948C369A5
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 14:33:40 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.76664.1744122817734803382
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 07:33:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OyjYqT44;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac298c8fa50so944047766b.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122816; x=1744727616; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g31JJ7Xs4YSHWJHVLkZKncb8YGRFvCrroS/hEhTA+Bs=;
        b=OyjYqT44LiwoAwTfl9l0QRGPkVhHs4oHRyetVngC6yDCjAmhfKLP/Vs3h0DNPZ3GeD
         uzojpJGke0ZYzDAuCFDxf2eCw2XQxC8G71CUM/CPey5O1b3fA/LxrL7urm6qdKFEV3OK
         5mAYB7DUik2YLeU1clc/8lDGoM2vcBm07lVOdBwfi1/7X+IjdTBK+I8h2ZKi31/b7MfA
         HxyeRedQvgolJMUZg262c9zqDnQtUL3QhK+7/SHnPt0CNLqrS3KV8pbYsXuf6fFR6G/F
         xCLPUkasFLF2OcXxZ/vhE9seAKm8IBihGIWKsYvoDUTXEp8BkFnm1LhfrUExKaj88jA9
         E/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122816; x=1744727616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g31JJ7Xs4YSHWJHVLkZKncb8YGRFvCrroS/hEhTA+Bs=;
        b=wGhKmRJf5/tud0Px7HWt/S3AS3RBQYETUfaiI/1ORLyMGE8uxp1w7EzKQsLy9JjyFC
         K0BnTtDUIAcgcL2/Z0yny0/WSS7NKAJc0kw7I9di0l6ZTPW+jPVc+vX6t/RG3POrMmDj
         bGVjehs1jBMMDEWfmi3sO+BG/0gW8ZqhMrd/VbCvRRR9dH9U6OwArEtzvu79UA1OTZUl
         IMMXDvzoqo/wb8pR6qmJImccWk/ZV8FQFzIgQ3rOo85+YznxvPmPyTRdU7zGD6wY6Mpc
         u2ERUikHWvjp5LY1GQT6Dom7aYvBVDG/EDP7jTWYRpqIxDJ9MFcHUBIHfatDaVOl/8jl
         PJcQ==
X-Gm-Message-State: AOJu0YwI8wuXL5G07PcXFVpsusbOPTW4esyHuIIoODO5r99a22jBd+s5
	Ul8d47odkTSjGn2spgSheTSrAv12Knn4OMw92AVRj7gdT9a0VOKkJhXf5kIi
X-Gm-Gg: ASbGncuDuxuT47w7VCS6XjGgD+xTZnJ9ul1PeJazllKWeyryzYpltqRZyA4VL48SCC8
	GlzgJQiFMnBjnBzsaAArx1eMHl8yq1BfTo7fHIAmToDLhW2Wld4tEyprsuYivwoQ/w3c0gx79XW
	THzexyDaITr0kfFViOhRCRhroqnFQOGIfUqVG5aJ+fhDaaKkqgy5MfFSyeTszOFmFmssi0Oojav
	x/iRHdWvEJPGjFz5OZlpiQ7CVi6aWBXMuyhJTSjGwJ+B4NEU95ih8qsHB35hRtU9tnow1KQACyH
	/BPI2+ipPdiAuzfRmxHh9UKHx5h/uijbDn3XaFSKYm4Oxsl1xLWy
X-Google-Smtp-Source: AGHT+IGI2baH42/psCo2fOrAsiW1ltxIbHhqsAutfyVPTM35b+w7yDl8lo94cIlB33Ohjecuzx7kyw==
X-Received: by 2002:a17:907:9615:b0:ac2:9841:3085 with SMTP id a640c23a62f3a-ac7d17d8763mr1518111766b.30.1744122815623;
        Tue, 08 Apr 2025 07:33:35 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c5c5sm915038866b.29.2025.04.08.07.33.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:33:35 -0700 (PDT)
Message-ID: <b4499a40-ff59-4d17-9dc4-00a7221c4e19@gmail.com>
Date: Tue, 8 Apr 2025 16:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH v2 2/2] nftw, ftw: add tests
To: yocto-patches@lists.yoctoproject.org
References: <20250407191414.2992785-1-skandigraun@gmail.com>
 <18341F33308F8E0B.31078@lists.yoctoproject.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <18341F33308F8E0B.31078@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 14:33:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1333

On 4/7/25 21:14, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> +#if !defined(__USE_LARGEFILE64) && FTW_NAME == ftw64
> +return 0
> +#endif
If nothing else, at the very least a semicolon is missing in this short
path when the call is not available (and in its nftw64 pair). Will keep
it in mind to fix - won't submit a v3 only with this on my own.

