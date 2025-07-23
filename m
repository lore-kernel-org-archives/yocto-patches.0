Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA5C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 02:31:33 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web10.5131.1753237883816969842
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Jul 2025 19:31:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kGVjy5Ee;
 spf=pass (domain: gmail.com, ip: 209.85.166.53, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-87c46159b24so101064839f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 19:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753237883; x=1753842683; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AbK7nzRFzbGczAioJ+xJHTpL1wbhNPk04c/TLl9Xbek=;
        b=kGVjy5EeCjnlFgpgdzq6NdXEUji3J7DfSnuKIu1FtrBELNPFs/fBEWsbekFSGg6Kzk
         n/IVAgF7My45r4Inm9xW3DcXLBbfujWFlZ+vBBJMxN+IfypvZNFWIAUieuy0zS8cP0kX
         uxAyHSHpBnNI6amycxV42EnD0gPUc9+e79mOr8ROTReubtKF7V9bSrIsEDgyd+hBvimn
         1W+BXNI0CCQ9n0ndAi6NsWgmew/JRN797I66p2hZOQZiGh7lWVxqj1HP1xVDiqjy0mc0
         Jpg/leKp4fHJfXayKQIq/JHqir1qjrXy66zuxdaVHhabqTudDGGl5x2n5bEFz6VsqAhO
         gqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753237883; x=1753842683;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbK7nzRFzbGczAioJ+xJHTpL1wbhNPk04c/TLl9Xbek=;
        b=tkkvrn7FTEpub9HkcuRPPhGLqIse7dqK6WIPJxslUK35F0CzKRj1btK+KBBKQUhHUx
         5Z++w9vJuY/7SqN7PEIUiKlX7tSvQVDTTwBvjGDdDnV8B6TbCE2qB9rx3CbiAM4kVWnk
         SG/6T/vIzmVioxKRogonsPbAe+tarjQOxj6Tniphdq5Cc5rBtssUL6CS+tnG5EwqhS9T
         MbCTEjNFtzK5WrTnb88NIValbc1giTnSVXP2GW27HqQ9w69jYvUjgM4agUt8mo1Hy+hP
         dnadFV+r9XN5n/RXt86ZlcMN9h4IfHVkTURiBbUmR5STF0/wH8hJb+dNuWbeNOj6hDwx
         UZlw==
X-Forwarded-Encrypted: i=1; AJvYcCXRpkJMptHOi6Kjxo3HlFjvBSR6pf2TyozG/KltR8tevEo9cSes5+s6OINj1+286J+kSBJmirf4LStwLumL@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxMtVnOxhc9a34dzlIsN2nD/X+wpslMBrwawQty6wchIM2PXAey
	e0RIJ5jGCdR/3wTjEi57zQTr7WLoQWhKDctyXSEohfzk1rkqs2ai4Grj
X-Gm-Gg: ASbGncvEuly8QACLerMvJTiZa5eO6keG8RwM+p0dT8LvA5WGTaRr5jhmRei5AhNJpdU
	Z24hvKd9hD3G0dcQx6m10r6g6x4KBl51ol4cxUwZx1AON/6VMhPlvLInr6D4uykMp2vuHF4+OBH
	0kv1qbpOWMHUY8NdndQ+vYhhMBp+Dlp1AL0IHkjHFGa6rhQwAKeuP6pmKvjSlCaIIYZxRdNYcf6
	Vm31As60QyeB+ZdgNi6JcSwfzmv46G/Qg8blSSU6gNxz2lTsbsBhQ1Hxnbc++quly2ZEEi2zyju
	MCGmTTT4Q1yRO04VArcrTIfnXnRlZq/+7gjVFlHAkWP/gkuMKzWAvLPk1xUB5gxBcC77G2Owqy1
	NdBplnv5LZ3Ki6nNDTI/FjJyt6ECy0vlu6UWQf+riUIa46a/Rk3FN+tYVpgCnSCddNvk=
X-Google-Smtp-Source: AGHT+IF/+7cjXyxr5Y5ees/6fmKAxXAWGgxAdC5EmIbthgJuFYAQyS6r7YkkvA3YEw2fDITAo3wb6A==
X-Received: by 2002:a05:6602:3fcc:b0:87c:3872:6787 with SMTP id ca18e2360f4ac-87c64f3ff78mr278097839f.1.1753237882864;
        Tue, 22 Jul 2025 19:31:22 -0700 (PDT)
Received: from [172.26.252.3] (70-59-40-14.hlrn.qwest.net. [70.59.40.14])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e46e2fasm330844139f.17.2025.07.22.19.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 19:31:22 -0700 (PDT)
Message-ID: <8c2f5b33-083f-423b-b0f3-984c7774611a@gmail.com>
Date: Tue, 22 Jul 2025 20:31:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] openssh: use config snippet
 instead of file
To: levi.shafter@elder-tomes.com, yocto-patches@lists.yoctoproject.org
References: <01068fb4-eb25-4d6c-95c8-98007719d4ea@elder-tomes.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: joe.macdonald@siemens.com, yi.zhao@windriver.com
In-Reply-To: <01068fb4-eb25-4d6c-95c8-98007719d4ea@elder-tomes.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 02:31:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1824

Hi, Levi
> 
>  .../openssh/files/sshd_config                 | 118 ------------------
>  .../files/sshd_config.d/50-selinux.conf       |  15 +++
>  2 files changed, 15 insertions(+), 118 deletions(-)
>  delete mode 100644 recipes-connectivity/openssh/files/sshd_config
>  create mode 100644
> recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
There should be corresponding changes in openssh_selinux.inc [1].
E.g. see references to "ssh_config" [2].

[1] https://git.yoctoproject.org/meta-selinux/tree/recipes-connectivity/openssh/openssh_selinux.inc
[2] https://git.openembedded.org/openembedded-core/tree/meta/recipes-connectivity/openssh/openssh_10.0p1.bb?id=99c09d29d56cb98f749c2283b5b800de9af98745

Clayton Casciato

