Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B2CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 16:36:04 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3343.1762533353938023606
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Nov 2025 08:35:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SCKX2Asn;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710665e7deso4600315e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762533352; x=1763138152; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skjOlncXjaz2xrwXqkv6LGZHqlG6FC6qWv6Gz9NXDuo=;
        b=SCKX2AsnubQts8RAK1/pdLHeJJmb8KkxhlisCAW8ggKH46Dxzt7SuVCwDIhNMVWIFJ
         rQB8uWJPyK+dSqurqQp52vzFSaCt9zeXDB9TOheFRatdk6dmHUG3a2o/nqhVCytGGYwZ
         g/HPAmPek4tbhPQuXEpY2pb1Q6KTFMl94HYZVi45WEL0bxCsVH6ox5VWCw+HJzhvk3jU
         jMSgFf7rj1IxlTUFgPlP2BYQyRUNOfkk7MTU3solNcNyBT0Wp/SaXC1ODj3wStlKQlkG
         cxrv0nsYBsnc04jiTaWc1HDyKQFlyn5s6Wd1RLYCAyMLrUyMUXuxR3r9n51sj1diIjT6
         zRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533352; x=1763138152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skjOlncXjaz2xrwXqkv6LGZHqlG6FC6qWv6Gz9NXDuo=;
        b=OMZ+dbWwAXyIjgiLmmbv0Spqqa6aRS50KzLi7n8zwS0rej8p3j+0II43sU7Tra1xAI
         kj50E3zO2RuwUwT9TrbNsrbn+PxKx7XO5M6ZiptR8chcgiFTwn7ERAiD05QtHra8z7me
         bwG/Og6eLw9yVaUId+HN57UT24ddSH9SiV4+KdWm8Q/E56of8FaEkGw4jMV1H1DSf/0l
         hFIYf3vBhO3qeT+FWc+3CQPBokrmQ9rLddmfXVHjKfER9xNOK+YAX91JNc8WNKWpL+xV
         ryD2e8ecDGLVjWIVdxFnXNTIy1x4j9jV8ouWq1pOnnm31hGRBQL1kutEDdEu72GoKo6T
         y0Ww==
X-Gm-Message-State: AOJu0YwfuEjl4MbeIWVliEb1lapgozhqHpb+k6Rg1wiPFsrTvWXy8Eqw
	/eMBo8z/QK7O6O3U8Oj8mGKHHnJwFZNShePoVU0osI7zC+xENRY4VUAa6qBGmkOEYKE=
X-Gm-Gg: ASbGncu5kDEZZAlNbJPb0lg/TT1ewRbf0n3QyaJKlGL73rFploavc6Enx12b8/9S3gk
	i6HEpyjRbCRTR4SNC12h03YnkQhaQ4a/DFYRVor2J8xgyTHQoPEeYkLub37s+6gV+qctL0IWsH9
	Es5gn8TY40w24RCyMoK3QjN/3h5x408XxhD1NfgiC0ovkLJV/jx6DPkY4iOtI9YVbxeia9YtU3c
	1wiMX0CFH3HIdCBz+0X7tXQ2ydo0/012oviBLdNbrEdNk0gYzIEbBleZG2wyuVvEuQiESGfeG3V
	dUXwpXLsudbA8+crFP4Zeg9YLl291qrANswFMZCbEEa4dJY64dmRS9qp3sGGSnTzH5NnvJqqa2m
	fGhuIRNFMjlKaalK7H9D/xzEXjDVluDba89c2B7aDk84BqfV5ftxZXfq8PLSVtBLOFgV/TsTQc5
	37QwS+Clz8+mbV1XjeY0c=
X-Google-Smtp-Source: AGHT+IGnKWV8PvIMkumNgsb67F4jzdk8PJjc9PbB8OzcW55nU6cKa1+yuQsHUCHjJbWDQmiD5o6tSA==
X-Received: by 2002:a05:600c:1c85:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4776bcd5abfmr36058035e9.25.1762533352037;
        Fri, 07 Nov 2025 08:35:52 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm75339675e9.14.2025.11.07.08.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:35:51 -0800 (PST)
Message-ID: <ce65d0a7-4873-434d-98eb-dd5bf922b565@gmail.com>
Date: Fri, 7 Nov 2025 17:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 00/12] Initial fixes for
 master branch
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>, marta.rybczynska@ygreky.com
References: <cover.1751647559.git.scott.murray@konsulko.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 16:36:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2430

On 7/4/25 19:11, Scott Murray via lists.yoctoproject.org wrote:
> There is still
> quite a bit of work to recreate a working CI setup, as well as ensuring
> walnascar and scarthgap branches are in a testable state.  

Is the Scarthgap branch still planned to be resurrected?

