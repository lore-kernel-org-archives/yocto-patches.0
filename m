Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29546.1794840570968366910
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 06:49:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Yt7sWj6X;
 spf=pass (domain: gmail.com, ip: 209.85.161.45, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ae5389c00so912536eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840570; x=1795445370; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILnijhfnCnMBVV64iCPMIeEVl3Q6DE1/WyXIaR3DTcE=;
        b=Yt7sWj6X0gOECIKSsgxY0qIMJ9gPAo8pjTpQHDKId6Brmk7wU8YL85B/Pu0fTmF+dl
         C/OTfKP2Ym1C1v8gkELEiTsMUKXe3r6wmqOiEGbRPvxu4hhMWYesvSvM4DfW2TguK2n1
         ZWkVRL5jwS8gWx8BOMYq+YnJDgDBaH6DdduQqVZ3KDEZdMRDuMCe8B9dqV+Z0H/XLeRF
         PgumpiZBGBQ7m++3p/1JZ5QcLDaHR+ZDwhx5NpPPDzHER1YSYeGAy+npykKnLYNNXm6W
         UT2Y/brD0qeHOU0SUVxrw8euitUPd9OVRJZn1I07YVbL2aYty1ow/8ZlPOl7Cfr8Itsj
         IZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840570; x=1795445370;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILnijhfnCnMBVV64iCPMIeEVl3Q6DE1/WyXIaR3DTcE=;
        b=YYyp6qH3oBP6f4khfBrW9VCjQne2hbLsgPjwBqBDHfxqNFtlnJkI7T0+ZlW0XXV2xY
         rKN8cGtWNfwPUe5qGIa0QiT/xH99JNk0Nb57nxLS8k4WgaVeW7Ox8QiyTR43JDvNB6Ic
         KR/se3t9eK+lbi8O5cfDNE3Oz/PO2WFn/mAS17ztaAaIIuW2bY0B1KcScCxmwfSeuLjG
         Jy1eUnMnP1p+SJ9Cp7iK05UoTH+hyzHIXowdh2LAQ3UDCmcloYMMs6za4fvIuRoB6PUV
         ktLKsznoWQedABKXfKZxptgqZcKAIK8MGuFqHRbr6oLM6HeePs4Ntt9in+gK5eihI0Qi
         RWGg==
X-Forwarded-Encrypted: i=1; AL+hErG0yJ6wYbtVYko3BxLjTFFwuoG9jh5d5ysLPN8vN9Ts8MQEDSpDhqK0ijalL/WKiUfo1TE8slPrPUcM18uq@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z8dcRMGfo06yNS7GdXcHK62W39A4bm2rDtSu7B0i+RovD8N6rBT
	6Y2KO4U1UbfpgyStqz86XXZ/Qs/9EvqVBCXYuYN63VI+LfgBWUeDHcAX
X-Gm-Gg: AYBFou2bFkYKM2AUqGZma4wz5GbLPIj3ue8WZMiEKG+yKcjc/T84RhPlMDNZUUN5syq
	L7kuNEgFkDAe6oDCF+LKym5GtmXX5Th8Tq3DFLi6k76tUGf7G7oC5V42UNt6sM2EOsusYG1aNpW
	W0IwHpYHgmGy0at1i0MKl/KJGWkp6LkokYIyXFQ9jie0sqiQ2d1C9B35gz23NVVAwXYlkbHL42X
	yCGd9ksm6Lb30L9rmZjow4PqJKOLu2D1MfcIMEVK7ZWKUNhNlI5yqPbyTVix5p6HfYg2PgPPx1J
	1zeHZOeE4TW1yO/k06qP8O6OPCKJAhhluWWSXDAgeZPGHxApc2k6kieBDJWhzzn98TeCtOBhk+l
	mheHkU/4CCJqqdiYs+Pmwg5uogPd5arkoDZA/KKMs3Yya1xTSLoa5zfHnq8XoaQP0v4R0UXwH8f
	gPRLEYLaGBQeT7JRazUovYQUhNNYEIf58pY/2c/qaOOd0p3JQV1rJujhdLUubQnTwt3YjTUfdTm
	TyJut1EIMNzLg/+nGCPJI+fIpLhUqa9dDRHKzOOA7IvO1B6bkF/kS7BQOwNJYccrsEWpOKfg80v
	or4KeEEofrLcgpd1hPHiSlXZ1/p+Tk7XsRZbGMPNh/tS+EpBGHOjFADGqYANfc0BTWaQm9ZALQ=
	=
X-Received: by 2002:a05:6820:3387:20b0:71a:f794:49ab with SMTP id 006d021491bc7-71af7944b92mr1018596eaf.61.1794840570070;
        Mon, 16 Nov 2026 06:49:30 -0800 (PST)
Return-Path: <majortomtosourcecontrol@gmail.com>
Received: from [172.26.252.72] ([73.229.151.109])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b3f9352d64sm311875fac.6.2026.11.16.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 06:49:29 -0800 (PST)
Message-ID: <75e87558-98fa-42a4-83b6-efd9eff0ad1d@gmail.com>
Date: Mon, 16 Nov 2026 07:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 6/6] refpolicy-targeted: allow
 ssh_sysadm_login by default
To: Chen Qi <chenqi_hycx@cetc.com.cn>, yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
References: <20261116025714.2558951-1-chenqi_hycx@cetc.com.cn>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <20261116025714.2558951-1-chenqi_hycx@cetc.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:49:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5407

Hi, Qi

> The targeted repolicy is a looser policy than standard/mcs/mls

Nit: repolicy -> refpolicy

> variants. What surprises users is that a looser repolicy does not 

Nit: repolicy -> refpolicy

Yes, this surprised me: https://github.com/SELinuxProject/refpolicy/pull/914

> allow ssh login while the sticter ones do. 

Nit: sticter -> stricter

>@
> This is because Yocto's targeted policy is making users land in
> unconfined_u selinux user by default, and unconfined_u is treated
> as privileged user, thus being forbidden by default as the default
> value of ssh_sysadm_login is false.

A Yocto mechanism could be added to map users; I do this in a private
layer.

>@
> Change to enable ssh_sysadm_login for targeted thus minimal by
> default.
>@

I don't think ssh_sysadm_login should be enabled by default, given:
* RefPolicy upstream doesn't do so (secure by default)
* Yocto generally doesn't do so [1] 

What are your thoughts on adding a configuration fragment instead,
similar to [1]?

[1] https://docs.yoctoproject.org/security-manual/securing-images.html#considerations-specific-to-the-openembedded-build-system

Thanks!

Clayton Casciato
