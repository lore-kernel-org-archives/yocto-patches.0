Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F69E9D3EC
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 14:45:18 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21941.1770216315920004371
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 06:45:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RquX5XBH;
 spf=pass (domain: gmail.com, ip: 209.85.161.51, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-663170b9472so2992313eaf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216315; x=1770821115; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzY6zky0Uceks7ZszRxeupkagOIjS1GduRYVsk8ysWc=;
        b=RquX5XBHkWhnN2vKp2wwKH3J2tzfj36i/qVMBPQ4guCcOvTEn2Ig1zw/F0R1oDNv+p
         0BQPdHJChhxqYqFMXLxNxJT9uEkXrRJ/1xdqMihIqf4OQOtHgsm6qOYWyYHmsZ58Noel
         pXS+CxMCrvMVh3qI94/ouuuVl1Mr0RCLk+HXHhDj+Rgx2U/Ol+QzijsGBR8OIOTKs93Z
         wiklsNWBPDlIVX/UsVXXlBgkHAShqUvTd9kEI3zyuQ/1VHDjnVc0auMA9wHfWj9AeU8J
         s64ES3uf8aDACP/R4ge7I2ZF9azdVG2Ewr1C6jiE0YtZ13UlwGrzH5cdj3DXk757El8L
         X40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216315; x=1770821115;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzY6zky0Uceks7ZszRxeupkagOIjS1GduRYVsk8ysWc=;
        b=NbSEXzYYWL2H1wqQv/mLOy3H824fmgn0s5xc6u71RBK3TZFcWk8WkSDZK8/YkVERLZ
         vWEvXvOoANR/LWHW1/5i0Kc3zjo7taLqUIvf+2UNbwzzW6nzJnvn4LFMR7Bw9a2KtxMG
         TlG3asZEsPcYAwnKYV9j/2M0E9PZYwIwcCQiLpNeAOK9vqwbaLLU7CjULQOVfFt0wvsZ
         +4bek37cM0UBy3QV5bo4+NFcgOgch6QKsn5q98kxvxcnHPa8i1yDY8kHQIrtdwelfAkG
         ZQuNgyT37Wzdf4L2Xo52l0Zg++/2GESRIu+0ouMkZbJh2UB0ukUZfffi+48cknVtcN35
         mezg==
X-Forwarded-Encrypted: i=1; AJvYcCXg95j3Xi2Ncbe8xZT9U4ZH6JAyeBNAyUbu4h7S3dA0ODYPBMS+rfFS3tPClzZB8OniXHX3J+DIia2tmoiz@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyPVKc9pfTapLS6wUwI8q5lhcBiWLtE2foNMBVnAX/lY1OzEXEK
	rsPexVrCAmjpsUs9wzmjeXWw388Ec0dswiXPR6etWgAoQXpceurLMdQP
X-Gm-Gg: AZuq6aKyV0/Uxks7CIk0azlMf9+8ZBf/gggCzYx59mFUVn0bZz32oV9a4wIc8cZEnng
	CXp83HhWUZCcuuf/WHAr5jNG6hNrdZNm9oWhMtTj251ArZ7MnzrO4rCVuZWAZ776xUztWllM7Ps
	R8YwpUoj/yww9TyvErjxUxt0EmycQLNR8utxVw2I/BnVSE+BgLdQegJA4F2TDPkgQ2IMro4AHhY
	YM6BE1iiwWWyi09T1a0gHH9DeYlK+FWEYjy5/MJBHRnTFORzyLBTRY7W2bKPPPP1P999X5o4NUd
	NaA6hGfrOvmBhzvqwH3B05ADYLgR3UtRVJp+ZKHM5qor3yEt6RmwNGaWf40Hm1k0WCV48ReFKNM
	LVGHLpZtR80SP+gzIBBRWbpiQimUn6aJmjcSAuLPMHzyu+SlZ6avzsviJvhsc9YPDG20GBLcnBO
	7lcCuHbNj8fEpObKRn+mkH8daKZvgP9FoOHzJxrN6XOsHZSJKBHgG6SbRe3z5omF6D
X-Received: by 2002:a05:6820:8cb:b0:662:c5c5:4fad with SMTP id 006d021491bc7-66a2123393fmr1320447eaf.27.1770216315012;
        Wed, 04 Feb 2026 06:45:15 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a541d5c68sm1840899fac.6.2026.02.04.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:45:14 -0800 (PST)
Message-ID: <c1b4d665-f0eb-4e76-b957-1c0aa34321d8@gmail.com>
Date: Wed, 4 Feb 2026 07:45:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH]
To: c.schlegel@televic.com, yocto-patches@lists.yoctoproject.org
References: <icKu.1770116970811561631.kJ0f@lists.yoctoproject.org>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: Scott Murray <scott.murray@konsulko.com>
In-Reply-To: <icKu.1770116970811561631.kJ0f@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 14:45:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3190

Thank you for your contribution, Clemens!

Here are a few suggestions:

Please review the contributor guide [1].

If applicable, this should be merged to recent branches first
(e.g. OE-C master) [2][3].

Sign off the patch.

Include the patch subject in the mail subject.

Include the maintainer(s) in the mailing [4].

Split the mailing into a cover letter and the inline
(rather than attached) patch.

Here is a recent example:
Upstream fix [5] 
Cover letter [6] 
Backport-like patch [7] 

[1] https://docs.yoctoproject.org/dev/contributor-guide/index.html
[2] https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#submitting-changes-to-stable-release-branches
[3] https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/rust-target-config.bbclass
[4] https://git.yoctoproject.org/meta-lts-mixins/about/?h=scarthgap/rust#maintenance
[5] https://git.openembedded.org/openembedded-core/commit/meta/recipes-connectivity/openssh/openssh/sshd?id=4e6762f5967b1996cf31ae100fa49e775dfb2866
[6] https://lists.yoctoproject.org/g/yocto-patches/message/3138
[7] https://lists.yoctoproject.org/g/yocto-patches/message/3139

Clayton Casciato

