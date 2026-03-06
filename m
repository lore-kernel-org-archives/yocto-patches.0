Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFEFCB614
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 15:19:10 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71328.1772810349718726667
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 07:19:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bTGZvwvG;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a321cc53so103055181cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772810349; x=1773415149; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dVhkAM9bTIv6Loi/jx4NNrggcq0daVvnFXx8zkMF6Hk=;
        b=bTGZvwvGJ2GITh3v2j65v84Z7erpS/zzoGa59tKVMToIApJ4gWta1/xF9B8599m9j6
         Yrhfk6AY2kUfWNFIxpEWMoWe31CksPe08OQE5JsqbdE8MRcEVj+EUjIq/kQ4ceIpjiSD
         pwV23tYR+VbQgTlb75M8ETOyOB4dbp/QUXH1yajlwCWTECSC5SHcmnLgWrTvMmJzfgVD
         EQTjATfm4H5YJPh+3PeX65e/KLEniLOAdMKxOBAdjL6Tk9Dcu4wRIjlR/Mxkh0xhfBCC
         Y2lRrY08RNWQcfVIucFdDJQLWUkE7Otuj1cfCh9Az+25oVGbgm6CHqYbr3zW9wQhwv22
         FA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810349; x=1773415149;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVhkAM9bTIv6Loi/jx4NNrggcq0daVvnFXx8zkMF6Hk=;
        b=Ty/J4Vjx4xFI2+6REvceZkl5ribnidCueGqgOhy1hvtkxwMaXdLDUQZ4Zsh/dyqAp6
         gR3ZZlyLopcb6ADoLGw3gXDSwzqFHgnfZyCls+uoK6tnCavcwwyMaxHDE3KyJlQC1h7M
         KdrE4DIYBKLKKPVCvFs3VvqoZzNPM/QUdVTG6Rq0ZVU4kYXmrPHsP7Mz+Hs4cz9oLE0l
         9kxJ9x2JVejl7pyMLPlNzP2+P7pidZ0NBv8TgVxpiJIvvzDeNyRvZE/78jh7D8wFF9mz
         Itrwhf9UEOj3FOv5wbIfVHNisjLrwfu9x9Xy1RrPu8ETa4jgaM1tlT+5VDrcUEblCBJY
         TTSA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYPGcokVtQg/wlsi5xv1yKzhZAZTRoN65QY3y4wF7L2KTYlyS2UHy1nBdzrfGzlkg4gGfIIjcHdPtAzMK@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyC7h+k0t4mMK6oyA8jwGTtbcDgN4NoX/vW4ofIP5tXFy0/OROS
	OF0Lciwgi5vi7VXoiBEcmiCQ6vqqVQDzKwV3jEdBeGIS6/F6qavyXy7W
X-Gm-Gg: ATEYQzxuApSRv8j54EFXyzsEiZB5wZ8SXj6MMgdgeKnbpAGq1rNBHeUKRqZ6rpLfFvt
	zU7NVaxvvaMMRy0QYnOaS/4MNOZMZa/IyXuiiuEZ2bQ+t5xKns5ReICGGSC9hQu/KGBNQzbcUNL
	FWM/ynnlfZNMdFOLVBzHfJp+yrx3ArY/GG2lphB3jMeNCI2qF3NjmlOrPEc0y3mQB/iIV0D7LYj
	fFetLBwxOx915lTTzSXbv8Tb3gIA+NsNueiLkosq1tXyQggx5NNUUbDQtqiyPVzG2XE8qhH4hRe
	gK/zMvlIdxqmCA0sSnp6pfdFO2rrVN02Ue1NNWT0EZZ/yMJ6WojKwW4Quid2FSEnVTuALoJCavb
	is12nEMGW80QAqyMiYfNgDIgprGpC4HvRrJIE/6Iz6q4kUoEmOWzXYFvaJnAouBkSukHCGky3TD
	B1vCTaIehPiIWj9+QcVXzYu35LoWe4nJ04ypdoquEgxSkbeNr2MdtNC9z4FYnKFAin5q+AkxvXH
	mVZ
X-Received: by 2002:a05:622a:1a9c:b0:4ff:c884:31ad with SMTP id d75a77b69052e-508f495b840mr30956371cf.53.1772810348662;
        Fri, 06 Mar 2026 07:19:08 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66b64cesm11694871cf.24.2026.03.06.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:19:08 -0800 (PST)
Message-ID: <c637869c-3fda-42b5-ba53-5ada2cb22d1a@gmail.com>
Date: Fri, 6 Mar 2026 08:19:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Introduce a new SELinux
 domain for the Qualcomm tee_supplicant to ensure proper labeling, isolation
 and access control under the target refpolicy.
To: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>,
 yocto-patches@lists.yoctoproject.org
References: <20260306034719.1998371-1-wenjia.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com
In-Reply-To: <20260306034719.1998371-1-wenjia.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 15:19:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3349

> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 2e1a929..e3d38ee 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -74,6 +74,7 @@ SRC_URI += " \ 
>          file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>          file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>          file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +		file://0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch \
>          "   
>@@
>  S = "${UNPACKDIR}/refpolicy"

Hi, Wenjia

Here are a few suggestions:

Follow the naming convention used in the other patches:
0059-policy-modules-services[...]

Follow the commit subject pattern:
https://git.yoctoproject.org/meta-selinux/log/recipes-security/refpolicy/refpolicy

Shorten the patch subject:
https://git-scm.com/docs/git-commit/2.53.0#_discussion

Use space indentation for the SRC_URI addition (as used in the other entries).

Include the maintainers in your mailing:
https://git.yoctoproject.org/meta-selinux/tree/MAINTAINERS

Here is a recent accepted patch for reference:
https://lists.yoctoproject.org/g/yocto-patches/message/3279

Clayton Casciato

