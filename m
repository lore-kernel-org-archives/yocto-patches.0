Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E834C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 02:42:13 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.5301.1753238529851731365
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Jul 2025 19:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dFG/YJgT;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87c3e35b3cbso202400439f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 19:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753238529; x=1753843329; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZPkDCaKZBQigdsYXuwgziMxa4JXFBm0fXgdBDdJfTI=;
        b=dFG/YJgTCKcXhP2Rm7OJVXfE1tjAui7FhJUJ9zoGtZ7K4cao3GVnBHZdIVSbiYwTvy
         OH+uwm1xRiILXDLgDH1x1+W66o6qUWIn/z9JJcv1SMVDUiIZU1HbpDp80ZFefqoe54HB
         x883E94iRJ8rgbO8HwWwCX9MFcN7thCK/srJsPngRmYAQqaMc2Y0P86QExKUm5QpJQu+
         JV0O6CsBLkufmCkX517xO59rMzbps1SKEbaeDpMy68iPyva0L2sSTIYEJqUvPNrb6qXT
         sTkk7k3R+AsHHkYVq6mixcY3mKc+l6P7AI1MoS5XBIixP+dDYUxd+7ZRWkgOKqjAPUlk
         sjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238529; x=1753843329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZPkDCaKZBQigdsYXuwgziMxa4JXFBm0fXgdBDdJfTI=;
        b=D/BdWKmGcubSpUgra9mb+DtxxYYNS4aK+7mbvT5ZkUecreitbS2VqOQfbdvYiE3eIA
         Nx6KwowuwWTPcLGIE74CYmlSHFZy+FOMZUnHnmP3Iyz4/Ch+LdSbks2s0ltXzeju4ynV
         lt3EqbSSoLPvn4ZYXfdMRNf1mxrFNgXgt5GR1KVW3TKSGhlAd1u2X2wKW4xP66ZCa8Rf
         y2efu7elBBQfbDoOstunk28S0gkUsV0cLd0o4wsqkVxPOwNqAtUuz93A5Qyq0dxfcg3W
         onPVp4lpMWS3DYk96OMbpEkqoJV1/IsqjydgWpW5fm3jKUAFJDGmUxqeDfcWzFebZ5bL
         ZYbw==
X-Forwarded-Encrypted: i=1; AJvYcCXx5DaoNqtsf031CDhvkyFxg//dZFeO44BexVgbsFY1eOCNlmKiRH9cDEefJtpRaMwuXPj4IgjAHhwUkAhC@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxawSrkPQOODVD3y4ZQfeFzqkd2M82QpNTqTHg3waP2EiGKHzc7
	/BEbf7AGrwP9PEeWjdZ5eeIbLqTeE0FAISaLHanQvDRg6Q5tcyvfb0he
X-Gm-Gg: ASbGnctQhW5yOvQMW4T8FCsTKhEQF8mQkOyhJik3RdQQirOoWM+wnpjPtCRruIgMVrp
	nw8SUg6B2klo6BNyL8H10nN0jlNKVioyylsC/ff9KSOIWpWIjJvqT/09e8kkenBvn1ujyrgTjCK
	Wyj39PaRG1x1Eo6NVk87O9Eepww6h6tV+mvIJ9L1WjLgUdFi5el5SYuZEcrf5aAxCCxrSEax5qi
	plYpQYS4p17FylLZkpPnSpqbpSlpISTWyEkioHoXLrt2T/yiNskzm8kgbbbv9GlUBJD0KQhLgiD
	Dpm/IHkZ0zuiV0jS3b6APcj2Q9uqxooZgKnOl3GmwDdVqv3OlZFC6R69XJmI4XyTmqsMMTuiH5+
	jYc7NIU2HhfJHwjVqHarTiE3c8F+cs0ss2YxXM/tvCtMb/DADbHj71skJn2Rm5unDSPA=
X-Google-Smtp-Source: AGHT+IFrIP36t4jNTg+Zc8W4S8bLiojycEkLZWeebArN8zx9keiPeQ+D8cIhMB+ASIWrKs3Lpawf9g==
X-Received: by 2002:a05:6602:750c:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-87c650431c2mr283639539f.9.1753238529025;
        Tue, 22 Jul 2025 19:42:09 -0700 (PDT)
Received: from [172.26.252.3] (70-59-40-14.hlrn.qwest.net. [70.59.40.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca0503fsm2889280173.105.2025.07.22.19.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 19:42:08 -0700 (PDT)
Message-ID: <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
Date: Tue, 22 Jul 2025 20:42:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: yi.zhao@windriver.com, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
Content-Language: en-US
In-Reply-To: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1825

From the upstream maintainer, Chris PeBenito:
"I'm not opposed to this, as long as meta-selinux maintainers are 
willing to maintain/contribute to distro-yocto sections."

Are the maintainers and wider community open to this?

Thanks!

--
Clayton Casciato

