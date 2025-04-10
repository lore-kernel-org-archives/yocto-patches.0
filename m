Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BCC3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:09:30 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web11.34139.1744290560787735918
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:09:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SrE5Sws8;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso5513755ab.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744290560; x=1744895360; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=SrE5Sws8h3ns49GafEHSUBk96qAwOTnHv0bo4cySuBnXkFVX5MAPrxL+7c6OIN5XTK
         oOJuzpDQGfv0TxPpAVTI1UsFWm4RZ4lDxb1BSRhShnMhTxcm8zpd2P/uko2hgDK/HmDx
         BFe1qQvxcyoYgdSA+Dbxq22byVaf5vlXEzfFQ+l3DxU2KapBOXgBPN5YVvTUkq6hffot
         j881GMQNot6ziEm0Bh5ufLPV7JjRnXyae/CFEIhPgw8akHUuphUIlWW+GAs1NN9HBL5N
         sGsSK/OV59uHLimaLg/rTP3CFddGPisyzg3QYY+CpUti3CAjqdLyG9MYdcOJNRAKQ5lA
         +pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290560; x=1744895360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=uHx6o2nbSZNoKCYOz0A3GWMr4v5P0/1/YlXa7xQOakMdreDzdafaq0wg+VIsW1OPJb
         lPtXP2NF3T6h0oPjZCI9sN1v9yLuBRw0rb5dWuAeFlFAicGPKcGrEbogqL0UlDhyeFXY
         nNMW5fDn75zz8nICL7L7asGUXlqFHhersuVwIoB+inq3OP6g9cS9ZivRLu9a7DwQnsOk
         CN2wxOtn8PKR/ACIhSz01fySNZwFwHFTdkT5v5q3s8oAv9p/5hcIRbffQ2ebHe3mZPzC
         OAe7yoG3VcNvh9O4cuhW9bzoKqtm4ycHuIN0IjxlfMopPrTuNTp2BmVp7kaCVSWeyNnL
         nS2g==
X-Gm-Message-State: AOJu0YzHDvsH6/Tn7eU/MVfy4le8KA90SfUjBBKscMxk8WQfjZxstwYi
	InSFwnyxqcoAImJ079uacHwMtzJ2h/WxKsxN70lLQTVKnG5j8U+YZhDsgA==
X-Gm-Gg: ASbGncvgMET3DPB0kXL56K9aAkf/6ak2XhVuByeEQAaB7rrLu5JU9f4s12CUjgnZ4KA
	1rcKrEmFKQXWNr5YlB+vwbQ4Dp08Tvls1SPgrwV9eTKfzxxTiSVh7Qpq2QXZKpD8l169rBbc2ig
	o4dKF15RXhbSPp9OyEXe3htL45SWyJ8OlKK2nDTef0nZWda7W51qjhnUyKfDq/ifwAg6x0QmB/g
	J27mulaWvHFJf7bVJ64QVDDxelXFe8FelrAX6sUNkuywY4jWRGfJ8ikC9M04CUpfmmaG1jbGbn9
	TgB8pRThOsYzNJJ765DDr4X+psWk4SJesGCzR/4V7tY9sTFtnKVmVaI0kePbFoAyGTozdHDOAfM
	r/7WIE99y6zAump8MZrTztvIPPsri
X-Google-Smtp-Source: AGHT+IFPgLYQx4hPeKoKyrrpmCpGs45gKOBnjHe9KO5GfAJTasxgtPXF7aJpbE8kX4alMLEULTd5dw==
X-Received: by 2002:a05:6e02:16cc:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d7e475c824mr29657385ab.14.1744290559740;
        Thu, 10 Apr 2025 06:09:19 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba958d2sm7471705ab.31.2025.04.10.06.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:09:19 -0700 (PDT)
Message-ID: <8b387520-36f6-4215-9dd0-ad7e4481da3c@gmail.com>
Date: Thu, 10 Apr 2025 07:09:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] smack: Use new CVE_STATUS variable
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: yocto-patches@lists.yoctoproject.org, akuster808@gmail.com
Cc: sekine.shigeki@fujitsu.com
References: <b61a1919-a65d-4674-8604-69ebf661cc8a@gmail.com>
Content-Language: en-US
In-Reply-To: <b61a1919-a65d-4674-8604-69ebf661cc8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:09:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1347

Hello!

Was there any feedback?

--
Clayton Casciato

