Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB9C9EC92
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:51:43 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33283.1768225898040683458
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Jan 2026 05:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ax3HkL5w;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ce73aa575aso707021a34.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768225897; x=1768830697; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ec52MVDVALgwzxisIg8UTtmNEzvEpVAZl3yo1gd63fM=;
        b=ax3HkL5wxaamZcuPcLLT401DC9adF5fIuFPz8BfcUFwkfZi6/O97onnfzFFVpRRNva
         qAJDlvNWl0Z2bTXpeRQCuUc4eZeY6+Q+jV71jRPI/z8ObeCJzMmD/LqcekAyHJoX20uz
         IzHk2e5zWmp5pQqt/tZtY/v7GXcupTCXkxWQKVt9bF/nlGY8gmCGlvpqvFADXEf2noxT
         9rL72NMIofdT8OcFyyclkReUmi1i18Lxhp2j1WziLNAtYxPfI+wX9cKYcBgALrB7PUvR
         v/JsaDTMD0vH/XCM+aFkx3TPgZIr+CMtBIOjTEpTCQ1pusAtfDcU/MidjwYO2bDw/bKV
         9POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225897; x=1768830697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec52MVDVALgwzxisIg8UTtmNEzvEpVAZl3yo1gd63fM=;
        b=I3uwhwZ8OPm5KqlEkp4p+D7Lpd0CcHyO5Lw6oOb1RWCs2slw8L2jtLhVO+JinZPgUN
         wkjB2vLFnPsIL4k9DSsLjZXFnaTpwA8gL0VKyKSbGUPCuj2xWNB9l7G69MkC/77ftcQY
         pXyPaZXqHHNk0Rfb0c5BI15Ii3k8w4hx25KI3Y21/h92a0b0OQmaJMo0xqbopq9w/IqG
         7itLyS6bgpfkNMlPlCfEc6O1RjjcasLaPER9PxFSfcqeJPRdBlKuFKrrtBPOBLCzom8d
         9iWQ4q80oRy4UbxrRdF8OGWupwpOerDaVir9V7srXwrv416Pbyk0Huw51MaaIRLtLJbm
         7nog==
X-Forwarded-Encrypted: i=1; AJvYcCV3zSspj7DLIOC6AyOZShlBssz+57hKoDrdd66WzHuvD6VF+2WEHL6feZnZ7r0+EZsHODc13Z56uPRmq+FE@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yznw4mhpEUuHjmLpE0cpN+kfNGcznQT+5yXcFWttfh/yRxzWg7g
	aTVP3m2AB8oGk9jaR2hAhx4G6rP2l70+gDNMilt65bqEK5j8oo99fqD5
X-Gm-Gg: AY/fxX7oEe4g8wCTo18c1Oba//U4Kb/1NgoUa7FX0rsHLPD5uHPF/fVvnLh8PVt71NO
	2qRBmVfThJvddwyUvTzncEsesCT6hazzBmWvwmBTWNmmLFB0voFeW8DCyAnXhtrgPS7oVB7nntD
	3zo/IC5uVWqVUHQvUuW0MQPBeFLd1XJZ6sFPbYxrbl7k93kxKqmuAVJlh8m5A6AFraVdAfj5OT4
	JxKLgt88eic7V7Toymd4mdA2VbOHEPaR3on+goYwhzSpgJxbdCN20WwxiWUn6L33dBo7aE6D09b
	giuL8sGB/xF3VkvinvUfq2/dtfCquh+g2qqq/dzbMAKlBprngy6pCHewJOidg1uzTOr40VgrEp9
	gJCBRF9WYb0nYUjnIhD3WCspOnNvNxmmGhu4QDpB2J5MU1snVUuUXLtUAsiS0c245PHIC71hEfH
	MOk8hmgt7FLwF698ZrqYMLIuar6zRVjy8TeL2b8sICLfF0S8fqbqph2cJbhDbbn80UhIMxbkJT
X-Google-Smtp-Source: AGHT+IH3oQZ/ao6gXNpZ6p5Dvt/mkPa46CD13c0ryTlQdVM8sH4C0N1Ff9VDAlT0fu4av50tS+kGJw==
X-Received: by 2002:a05:6830:2e06:b0:7c7:8280:91fe with SMTP id 46e09a7af769-7ce50ab3f24mr10452705a34.38.1768225897200;
        Mon, 12 Jan 2026 05:51:37 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c43asm13014386a34.7.2026.01.12.05.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 05:51:37 -0800 (PST)
Message-ID: <99f90ea2-b2e1-4254-8c61-cee8dafcda5e@gmail.com>
Date: Mon, 12 Jan 2026 06:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] suricata: fix
 CVE-2025-64332 && CVE-2025-64344
To: Hitendra Prajapati <hprajapati@mvista.com>,
 yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
References: <20260112051833.59731-1-hprajapati@mvista.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <20260112051833.59731-1-hprajapati@mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 13:51:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2946

> Backport fixes for:
>@
> * CVE-2025-64332 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/ad446c9006a77490af51c468aae0ce934f4d2117
> * CVE-2025-64344 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/d364b04a595facd5980c44f4f9ea39319999bf66
>@
> Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
Hi, Hitendra

These are not an issue as of 1a0643fa366f ("suricata: update to 7.0.13")
https://git.yoctoproject.org/meta-security/commit/?id=1a0643fa366f31d439b4300bea5e3a87088e59a2

Please note Scott's previous direction:
"Going forward, I would prefer suricata and libhtp upgrades over
accruing a large set of CVE patches [...]"
https://lists.yoctoproject.org/g/yocto-patches/message/2658

Clayton Casciato

