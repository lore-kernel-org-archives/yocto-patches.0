Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A149CE7B0B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 13:23:30 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17895.1763126600037834778
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 05:23:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lP3OHTDZ;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4331b4d5c6eso7577745ab.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763126599; x=1763731399; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL5ww/svv4QUaBdBRifT0GaTpP2ow4MKlaGJf9AlTME=;
        b=lP3OHTDZ/UrUiXKVRVdNJ7xnIFX+kcjN6QahHe5DCBviaQgkPLZWePZznD1plDVElM
         OSV/f81I1/mRk4Z4kEjA8hRZRnmeeLkhCTKJp9lMKwlQIYWYVyIIondAoXxcKxkmtk3i
         iHIHgZkxeglPOBJ/KFOqhcJcn6ZRTb7n2ECFWIb5ddNFIUSx0Jxkw8dJIJB2LIz0VesM
         oljFYxY8+CPSVUkHwyD5FcLrBbX57PLyyPKJ5FEsqnxTZt+xH2+XNzApDUQcl0bUnW5h
         DM7Xa0ygqIptTKyRYLYMxXVmMbm7iRmzxHNCZ66tUR55vLT41MpD6Dc7XBFhyffhR9yN
         BPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763126599; x=1763731399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CL5ww/svv4QUaBdBRifT0GaTpP2ow4MKlaGJf9AlTME=;
        b=Cx/M87+Xzkp1wPjGmHVukJZN34sJo6mpSR1WRgXKQaA4ZEBA2KuKpQsgmqXglxti+B
         BgwOTWOPA3zgmdzIfzsfxd3PPBDUv+4r0MH9vB+rCJ6vXUjqgQuHDslIUdXjzQcC63oG
         /wweujC2UxtuGphOzMfwwcOXvd/UYHl26ke6miLanCLrxWsx6zZO3hfGElQmN8BrBR2X
         Os4kQY69J6bsaJ1YPWzxB0gcR/JBnhNZ16aELaJKmJTsxgEVDRNsrZxqUog75p5+sAvd
         9KhPEJ/udKhq2Dd54Qkx6XySv8AZqYHxeNkomsvvBiFJZnzGS3DCl+ZTem7m7Z2tH+DQ
         6hpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoQUpofo91D7ov4aLcjzhSpnoalWqlHHtfFL+fSoxYgKLxSf1vIME1qlmmimBL/ofxIAjM69lyuO19rFTW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwBXmV+WEWZwOirTywNOr90HrehrEB7+TXBYxcq7Iw+21MkoBcA
	HlJuMDTLKuwVveXBLBL+bP4DTV46sNlco24RPuHXpy7AyRDLqMIau0JV
X-Gm-Gg: ASbGncsso0cmsVel5iYUxPGRkpKNT3tZ3GhoVVJQ3Ti+d7i2qgiTik87wtmrZ3DabxC
	0oj5v9FdwFwjuBcioZWt3Qxx2G0JcA+DO4G0EBpL7ggERdhRiCHtXPHaDwNkxHTSrpIxve1UM+7
	K61BzFSudC3tQjSBqAhyaNRlu9ttcc/NQVifPC3Nna1RQRMwe5qLVfbSl9fstgsd58PSiENSBYR
	GoqmIvk6YzazBGxeIt0taJWzrZXkTrsHr3UhoQ8OINLSkUp4pOGukG8BcYVFe4AYKeYHGamzNMN
	JmLDzKbei+DTX5/oK1TcOitSsNr49A5jTHsjl6J1C7Z895Aj/ttS7pdFOnb5MJnavh0gTRYgl/T
	MW6v9NHZwqzUUS2tRuBTSB9Mn8WXbfRIu32j88Rxf2+31/GA2sotr5WKSxklOVWFjaM+TdUM/I/
	EQaoy6/5sVGT9/xshK+aVD5WGPgb1pBBXS+SyPAdfPfAOd5gV4vvaAmxHa16ACVg==
X-Google-Smtp-Source: AGHT+IEs3cJHNZ5lA+a/lX6ObUavGW3jUXTlPNul5aEJ8TurQnR9iExlJZ89VGvhe4iye59PHVPqEQ==
X-Received: by 2002:a05:6e02:3812:b0:433:7b22:c2cd with SMTP id e9e14a558f8ab-4348c8be2b8mr45165655ab.8.1763126599083;
        Fri, 14 Nov 2025 05:23:19 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2d5a326sm229076639f.16.2025.11.14.05.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 05:23:18 -0800 (PST)
Message-ID: <e7aa30d7-259b-41f0-b855-4477fb5317f2@gmail.com>
Date: Fri, 14 Nov 2025 06:23:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 1/4] openscap: update to
 1.4.2
To: Louis Rannou <louis.rannou@semalibre.com>,
 yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com,
 pascal.eberhard@non.se.com, yi.zhao@windriver.com,
 Louis Rannou <louis.rannou@non.se.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
 <20251114-openscap_bump-v1-1-1c8169b8e332@non.se.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <20251114-openscap_bump-v1-1-1c8169b8e332@non.se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 13:23:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2565

On 11/14/25 1:29 AM, Louis Rannou via lists.yoctoproject.org wrote:
> From: Louis Rannou <louis.rannou@non.se.com>
>@
> SRC_URI is based on the github release instead of the SHA for more efficiency.
> [...]
> -SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
> -           file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
> -          "   
> +SRC_URI = " \ 
> +    https://github.com/OpenSCAP/openscap/releases/download/1.4.2/openscap-${PV}.tar.gz \
> [..]
I find the devtool experience is significantly improved using a
repo rather than a tarball.

Using a repo allows for cherry picking (especially useful for
non-master) and use of source control history.
--
Clayton Casciato

