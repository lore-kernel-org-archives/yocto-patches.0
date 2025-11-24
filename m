Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702B3CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 14:10:38 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17559.1763993430732655311
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 06:10:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CCw9wJEk;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-94861514a5cso166236039f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763993430; x=1764598230; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yz3h800N9wQrNAAHQts559LQJAzOoPsJEIip6yhGlpU=;
        b=CCw9wJEkK7z/DDxoI9t0FJ0FQWc/sMlU/XxSvA+1xDYu3AdqE/Ct0icyY1AtH++ZG7
         1I/XPh3pWndYi1pqDwN/gh3rg9sw9vYlhNE7KactHLbK2Wy64IIhZYSGb6Z2khENAq7I
         iSQbjlRQVcx4A8xF39xtJX0r5uqrpWoitrNYu1je9yGLNKbH28swDwzjxxcPdt7nR1jn
         5tnb49Cg0NrXzKrXSBp73q7Duv02C7MYKOfAyxJxw71s6+Jc7fyH6dOH075+LIGYuBNc
         GhsDC7eYukVfFf2EyHVAZ5rlhqxxhiYVRoorSQD2cLq1LM9WEzSr/pi0n6kAiGxDoLk1
         2aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763993430; x=1764598230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz3h800N9wQrNAAHQts559LQJAzOoPsJEIip6yhGlpU=;
        b=qVBvUmNxUpi92IBeiIY+OLh2wRAPcg56nB9/sc1tsgvaVVEAM5dhJhPNeI2ynhbFYh
         fRamdHcbk0E2RNNLht4G0mfW8ovZETw/UEeF5UQxHUu3CD6GaqKfDRh/guXPXnD3A0Fy
         1X/u+ce0E15BhQyH0mMnV03WM7zQ6g8jqTh3TF1DsS7086TrL9uyWuzX5u1uh7C1I9Fh
         kkRv2AEQ7i7Je8JQQNBgp7lAcIY4nfclysbus2HHgazKgbIM3p2w7AZkvrLp9h6/dmjR
         eH9p7/KHl/a38cv4ufsy5FgxzkG+BqxU/0LzRm+KtXL3wsdzaN2rhsOTJWYB03Z/U8oZ
         zLcg==
X-Forwarded-Encrypted: i=1; AJvYcCWPkRxXBwc46IhyTrgaWoHblrpHCBl7TM4q0qoDjeAY10SzcUWYNIGXdLSxtRTJBfJ4FwKWqZEbqfJEpkfR@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxLjgYm3ra2lM5XZnMIv8ThN+rqCKa3VQlzxDUgRcicnBA/RHbp
	qtgJ4p0gsJ9vY2zNbEg6fuPRIIT5cVVYPCf33YyAq+y3rHcgTm9+VosP
X-Gm-Gg: ASbGnctiTznWenIUzKsq/r0GOjl5BBqBlaIezJ6BkJdVv4PnhDBoakD0jvEtfomYfrI
	alQsiRF/GN+yiac5jpW18+B+ZredyzbxzbJ72uklth3SrgaA7AN2S2hHRHtNOv5+LoCXYeDBfmX
	q249kMTTTrbJeVSMLBwUbpAuuULIOYKYnLNGgk0mvYoKtk+E8tGGxHNm3Uaz+Gfy99OkZVbgsnk
	lQuP9rz/ltbPwPdFKRl4D9YDSqrPnoZGwrcU3GbKVoMJ43xy0XTX/s2RDXe2yQgW+zd/RyfsB5J
	C1nJDfSqCOXzaTAUlPcbxNayZ+xsYE0i5eD1/s43Ku4zRUdTq7zNUMYbYZtJqknvydkmZ5HALU4
	xNSl6KXbcyAOics3iYvVJjMrQsldQMqhByURcrC2ggsAbJrBBXmdeleJJnATAZibaN+8WkBj6Tn
	aqfS8WDylmGoMsIlGKx1PJRbYIPRWOtsj3S3ZNgXFuIiOoYlWXqSU4pJ3uREO5uy9QNPH6O9u8
X-Google-Smtp-Source: AGHT+IHhOJTm6rk4BAEOIFa7Any6IEV1pwuJGEzQdOEag9TiUTQPkpYI962GyAqP0e0XFOv4RCWMrg==
X-Received: by 2002:a05:6638:a209:b0:592:969b:a29f with SMTP id 8926c6da1cb9f-5b967acf28amr5826013173.18.1763993429858;
        Mon, 24 Nov 2025 06:10:29 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a7976bsm5646183173.26.2025.11.24.06.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 06:10:29 -0800 (PST)
Message-ID: <1a0d3267-8887-48d1-b970-39f7de3b4268@gmail.com>
Date: Mon, 24 Nov 2025 07:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH 00/32] Roll up
 outstanding fixes
To: Scott Murray <scott.murray@konsulko.com>,
 yocto-patches@lists.yoctoproject.org
References: <cover.1763938436.git.scott.murray@konsulko.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 14:10:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2694

> - There are still some other outstanding CVEs for firejail and clamav.
>   firejail is potentially upgradeable, but clamav is problematic since
>   I believe 0.104.x was already unsupported when scarthgap shipped.
>   If you care about clamav support for scarthgap, plus provide some
>   input on if an upgrade to one of the LTS branches (1.0 or 1.4) is
>   something you would like to see / would be able to help test.
Hi, Scott

I would like to see clamav updated (1.4 preferred).

--
Clayton Casciato

