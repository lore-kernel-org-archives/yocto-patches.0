Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13747.1795012156394472453
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 06:29:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=CHodHK6x;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4d7034a99a9so480041b6e.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012155; x=1795616955; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCvZhFH9Xqb55J+1rLWbgkRqNGHK++FzcynOHKN7Q4U=;
        b=CHodHK6xoCbrBh4YLbkzWiP//zUUFSd1EqVfzTJd6VJUjLvhdrepc/NM8ykhKu52l3
         1NElqcl63pu0oUjNfEUgHQUyH8fNLkzSrOSNX0hxOame41zX7YnaH00yF689hxnmNui7
         L+nlrQnGk4O9CKHz/6sQZc+eRGv697xvZxXZzyqPROLgXV+AuJVJoeyiXDV8Prpyj05u
         KiFxAHyKdU6e117+bmScC8BAmesFc3gsfU/74oGtO7LiPurZ5rH/kOgoXtiBglKqJT4i
         KzF8eazCih1WqfVVQZMgsMTnsb+MtDe3fCC2Ce0mKeiXharnTXz3vZ5oC5D51Kv0Y1XH
         DIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012155; x=1795616955;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCvZhFH9Xqb55J+1rLWbgkRqNGHK++FzcynOHKN7Q4U=;
        b=p+Vh7l7HoeUQ++9IDPXjvKiDwXufjXbK6cTVRt0WOOssiTTOFCbJ0n2ICKYAV+2GlY
         HlwB9msSDPH8+6ftuSF4Ws37IQ01Z8h1A8uoHfOvv4cbIfrl6rsFHnM305qD51lhJfZE
         OyXofLdS1V0ZA4/O6SqxD7olj9R2Ub/bkMlQF6/0hQzxi2Nb4L8MldSP1ZwGWFSj3ljm
         wLBGyHJD3Mjspulibv7z4F32xZBWBz1COtEQ28I4py/oHIFr7nAdrdtW1Igci1sAERGA
         M0opgA5g4rvx+AD/zgVV884K0SR2VguXMwh/ItqlKWK2KzSHW4oGNDEtWrtSllF3+dwW
         1ysA==
X-Forwarded-Encrypted: i=1; AL+hErHWq1MVuBk9r9tLzqnQsJWpVt59+JWaPy/buZIl4Sk357R7sMNWg/w1VS+mI/7YPK0UXthZAYla9DZDq79k@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z/0+D2muIEriJzy1U2y3y+FLI6wyj6CJDgpgk6cPf+VjXAtxd7p
	raznR4Cmc/PRRSiLKHG96ymzW0MFElM9JVxaX9buDHhy1qeB1p7zXjmi
X-Gm-Gg: AYBFou2uCoj05wNdfai4VvzvWXJJdfwG1iEtd0fVoUCSuEXiR+3PVGS8twDpyx78F/d
	r94Q6ppAh3ec5wt201jxE0G0PBRYBatc14z2ScUSb3FMEm8J6EzmbGZrNVfSmCcs7fyXKtnQqP9
	jeUOypGkEdfobe/rGl31+BuknkAZfu2unL7616zd9VshXMfdm5ds1wwfDYF+w1TeS/fBn9rPFia
	aw/opKpedV1tUiyM9rGFdC+wbqzfGA69bDK1RozSmepHUL+FSi//joPK6keTs7inJPenJNgf3wO
	GR7NNbm689PMtdbeR549iZHzqTeFBpZoxWyDjS9Xw23NdnWaXfsD3/yqfQFdEHdpGO+nZicSY/6
	fz4nQYCdKc4pOiioXfT3O/qb4nFJ1LJyaB1G+EV1KSG/smT9hXNunQ/hksgttXK5AkR0/yXLcza
	/WTKkt7Skk7mcePBuEQwxA11Xmus2oFZNkF9ofZ+1lOaVcqEudcLHmMBP8ixpWnrJL7DifWa4Uu
	ojeQC6yoGMhOCIaHi+Jng5ttv867X856xHTsfZgrdqTWS+OfNes+wHtChn/PbJKr+j0eJmas2Zk
	1mVyjdk9pnJWW3lIoXmqRIYT0UrNuKfQ+1CYdbmsTxlnvcqV1hWvIL289b6J9xVyx87BJk5QlaA
	=
X-Received: by 2002:a05:6808:1514:b0:572:6ee:8b6b with SMTP id 5614622812f47-5773f643eecmr2708263b6e.66.1795012155517;
        Wed, 18 Nov 2026 06:29:15 -0800 (PST)
Return-Path: <majortomtosourcecontrol@gmail.com>
Received: from [172.26.252.72] ([73.229.151.109])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777ad9b65fsm1525475b6e.11.2026.11.18.06.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:29:15 -0800 (PST)
Message-ID: <e7845261-7554-4074-8884-832f09747e22@gmail.com>
Date: Wed, 18 Nov 2026 07:29:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 3/6] refpolicy_common: ensure we start
 from a clean state in do_compile
To: Chen Qi <chenqi_hycx@cetc.com.cn>, yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
 <20261116025620.2558594-4-chenqi_hycx@cetc.com.cn>
 <ac2f592c-a707-4bad-ac36-3f003ba449a5@gmail.com>
 <452777be-1505-46c8-bace-cf22e5b5ed8c@cetc.com.cn>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <452777be-1505-46c8-bace-cf22e5b5ed8c@cetc.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 14:29:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5473

On 11/16/26 5:41 PM, Chen Qi wrote:
> Hi Clayton,
> 
> This 'make bare' not only solves the legacy booleans.conf but also the legacy modules.conf issue. So I think it's a correct thing to do.
> 
> There's a POLICY_BOOLEANS variable recently introduced into meta-selinux: git.yoctoproject.org/meta-selinux/commit/?id=3fc98271005b8c5a9ccb77ddb6aa675106c4dfe8
> 
> For your use case, you can use one of the following ways:
> 1) Switch to use POLICY_BOOLEANS
> 2) Copy your custom booleans.conf in set_policy_booleans:append
Yes, the recommendations appear viable.

Thank you!

Clayton Casciato
