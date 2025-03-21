Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A28C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 18:01:07 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.85.1742580063856979049
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Mar 2025 11:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UWNd13yr;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso385486266b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742580062; x=1743184862; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oduICJvgCdImvTF+mCCZLU6UQFXqkp+9AiakiJgmnp4=;
        b=UWNd13yrX13+2dHoiZxTHurs1duAe43viz4kmU5/czYqgjUPxV6lSh+cwhLZunhMd2
         DaHkQ2Ejf1oaO4BKWgfpTIfOKA9a0tEPF12/OhTqcHigu+ARkFd2psycBQolTSi8KL7/
         D3IPG8WY91kaK7swUjSQbK4xvkVwBYPa73cqorfkFBlIciOmFRnYsVD2hXw0UxTypai4
         rsu+yaMxzg2U8A1RmpA4pCJTwbTWM/r4dYgwOQQkaEcRDbXgOaedBRrurS+6zbHUiO/6
         SSs1riH1h+nf1Sm0DJA6kXGKrK3gTY8ke+w6aW5R4iUUl0YTVWuaIKG1eQ1kwhvpYWBu
         qLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742580062; x=1743184862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oduICJvgCdImvTF+mCCZLU6UQFXqkp+9AiakiJgmnp4=;
        b=Spmf4tWgaDr6GeDVPgNAaPbNacOxWprTEarsCf7GAn+5Y8H+KSohq4RfRBxfzoInst
         gV/qdc8XiE2jcK5b/Ne7BYi3j9IsprbFwGcXwjGmK1n6XHKpwsmkFsde/Ak2tpqvZvKP
         UGMWmQY4saSXfjmhBYvyen6AarmjZKFjYvLZsC3VPqYczZ0YJDfpScrucqPdFnS59pfS
         Xx3NHWly/s4lRi8Yz6eNBsN0cIRCGfIPMWzotB5tcoVsBtIRqPMFrEWw+h2ZaXZcLwiF
         0j8d2MTHa/VlK357jiP0PR0ju6qHsdzV+oUIhLbOXrfAFcYSmmHsPqK7VGKxCJ+4XurB
         7H4w==
X-Gm-Message-State: AOJu0YxpBO8OU9Qd+rHR0mkL+S5zgE5kU9ef2h5ou4H7SlqvKQt7PCkK
	e3TRm7ca8/7EGRnFzJaiNnRJrGSUnn2K+OAnAAgE9y6V9rD1AFa2whu8cA==
X-Gm-Gg: ASbGncsNqvsl/FC1gecqTFMJuW4T2Ou2feVCFXTpaI9cEREYe6GDbZGIuRkYASlbnb8
	Tgr6hdt2bNWsfTHEQ8dkSGxH7oi4DyDO6jShZQ222VzF+Hvkj85rz5/yF7If5TDFcv3UTNZrGQa
	Ckd53MdiIjF9hoJeuFIlrv18xP5uPV8MnVw37s1w8Q3WqeW6Vmo5+YAeRIeriiLJJ1x4ShGyLMT
	L9sK9hXebGa5n13oVUsJtLUyQCUVEcXT9hau9HlioNINt/qmsKiHdOGOWJ1tarZerg3sPB/lcaj
	uvDih84FrMMsIjGo2RS7TV2IrwwFXwHI3LqCKNCijPadPR3OLw==
X-Google-Smtp-Source: AGHT+IF1X8D1TW4N4e4wh9/IQb3tn9OlKn3xfcmQiAfF4nlL1isCDzMVgcRt2TtF6xQEDgvPTXvZ7A==
X-Received: by 2002:a17:907:a58c:b0:ac4:759:42e with SMTP id a640c23a62f3a-ac4075904dcmr43093166b.50.1742580061676;
        Fri, 21 Mar 2025 11:01:01 -0700 (PDT)
Received: from [192.168.1.2] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e532asm192888666b.56.2025.03.21.11.01.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 11:01:01 -0700 (PDT)
Message-ID: <b3c11a3c-0b73-434d-8d28-3f2ac271884b@gmail.com>
Date: Fri, 21 Mar 2025 19:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH] rust:
 use 'config.toml' instead of plain 'config'
To: yocto-patches@lists.yoctoproject.org
References: <3a1e9acf-69e0-4fbc-8412-36fcca575b89@gmail.com>
 <4622.1742577964751482245@lists.yoctoproject.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <4622.1742577964751482245@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 18:01:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1241

Yeah, I think a v2 would be nice to have.

On 3/21/25 18:26, Vasileios Anagnostopoulos via lists.yoctoproject.org
wrote:
> typo that I made while preparing the patch with git send-email ...
> Should I send a new patch ?
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
> 
> You receive all messages sent to this group.
> 
> View/Reply Online (#1240) <https://lists.yoctoproject.org/g/yocto-
> patches/message/1240> | Reply to Group <mailto:yocto-
> patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-
> patches%5D%20%5Bmeta-lts-
> mixins%5D%5Bscarthgap%2Frust%5D%5BPATCH%5D%20rust%3A%20use%20%27config.toml%27%20instead%20of%20plain%20%27config%27> | Reply to Sender <mailto:vasileios.anagnostopoulos@siemens.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-mixins%5D%5Bscarthgap%2Frust%5D%5BPATCH%5D%20rust%3A%20use%20%27config.toml%27%20instead%20of%20plain%20%27config%27> | Mute This Topic <https://lists.yoctoproject.org/mt/111808265/6084445> | New Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription <https://lists.yoctoproject.org/g/yocto-patches/
> editsub/6084445> | Contact Group Owner <mailto:yocto-
> patches+owner@lists.yoctoproject.org> | Unsubscribe <https://
> lists.yoctoproject.org/g/yocto-patches/
> leave/14038302/6084445/1344600526/xyzzy> [skandigraun@gmail.com]
> 
> _._,_._,_


