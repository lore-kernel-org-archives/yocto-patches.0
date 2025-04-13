Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A88C3601E
	for <webhook@archiver.kernel.org>; Sun, 13 Apr 2025 12:02:05 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.27437.1744545721030484005
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Apr 2025 05:02:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i8fY0cWb;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2aeada833so665058866b.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744545719; x=1745150519; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GehopOtvm9y1vNUXd2Ut4+F7yuVaPFd7umsVuPCLs78=;
        b=i8fY0cWbIKBxJWjEsHhgtOZ2X9ceNWLnWF3lNjtiA746lFVeafo4HrNqU9LIwP/1Jw
         ZtMb4cZF2yQivXqnYiQU5MUbc/oSKrGn1jdDrvmqGXudbolPyKOFGt66oQHuNcmMYAt3
         LAH4vRJOakIq+pqB/0LLwpWEf0VatDxaKiU/L+Jem9ROxDlj40+8gfjfV+vnoSlHRhjK
         LCijAtqzSCepMFVDpnLbY+u1pVoHrzdx7KOvZh0PTnHch+fb2QkgL3Owk3FclQi1m2mx
         W8SKTv+lBPsu8t1ru7wUMhS1t5IhgFXiilYVmLMDgIhQ27zgW/B7quC5cFSQWlRltJca
         I+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744545719; x=1745150519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GehopOtvm9y1vNUXd2Ut4+F7yuVaPFd7umsVuPCLs78=;
        b=rO+ahK93lGcxMaZKOPRVYVz7xrFbrZ+HSo9V2JU5QpU0yhdu+9CWmsspgatIIsGdGl
         dKd03YLhsrdXkXpioNFfM1rUyZuk2KYHohjY3xMuz3lRIB6LgIShc4pTsK9Gr5IiJsmi
         tia/nh67rfM+LXs0QWfdHMznHxDOVl/eG2dxzX879hc1U9IbFZfQ2WpAHDmvEaBHaZVD
         f+L3rG15Rb9I7POggUpI6XColM2Eh5orbl+1B7G43rAYSmgsdKHXxwSD5bRP6bSvqr6D
         vaRwBHbjT8k3dFayFMkrdF+UY2SGdlu7MYwqAsszWwuUSsnPCPVuQGO4CwnzLeEj4RdS
         DEwg==
X-Gm-Message-State: AOJu0Yz27YIGrAECXlyLCCr4ebYalh5gYiy/uxppSTmSyvXsX8xE8JUH
	Gd1XepwtBOi/p/yO04UpkKiWLyh1SgMdRc59gLeLoHUusC9Fegmv+RN8+2ME
X-Gm-Gg: ASbGncuT3jfjvk81hy3Lj9HJisaMI2vZ5XdyDkYmUNpupZqkZlZqK0IzAQXqFfDt1Wh
	68NcE2RxlZVPtaBSbsNTk1sE+VGP2uKN4eb6T93TnCWdQKgVb21DplwQLmZIiLOxIuXajSYUOP2
	2ctNLoSs4AiLydTa50cPhemFqCchs3PNnk0VZ5S3fxRzVmtrPEK3etV31eB1ZlhUqUHeuvI8QOb
	26/PgjlGlruofG+v39s3N/T0TdHB4N1MxZ/AOHdysI6dwqec8ClZBYGiRyLOsSNVy/AqoUbvjIG
	sCFrkQVlRA7n+22XKWJeUq06TfYrFuf+y3HcqUJpDmOQjp3z
X-Google-Smtp-Source: AGHT+IFY2kVM3mh1EjX814dDsqPYyFq1uX8NOYTaTWvUQ+HvVNqW47L8wELzXWwaP5jzwRkZfqktFg==
X-Received: by 2002:a17:907:3d0f:b0:abf:742e:1fde with SMTP id a640c23a62f3a-acad16a0410mr966829066b.14.1744545718860;
        Sun, 13 Apr 2025 05:01:58 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7f7dsm728675166b.180.2025.04.13.05.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 05:01:58 -0700 (PDT)
Message-ID: <08f5f7fa-60e4-49ee-8a72-0febeb735721@gmail.com>
Date: Sun, 13 Apr 2025 14:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] Fix warning : lack of
 whitespace around assignment
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
References: <20250412172641.1632340-1-schonm@gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250412172641.1632340-1-schonm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 12:02:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1363

It's not really about this specific change, just 2 typos I noticed while
skimming it through... if you don't feel like doing a v2 for this, I
understand.

On 4/12/25 19:25, J. S. via lists.yoctoproject.org wrote:
> diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> index a746c56..d9d80fb 100644
> --- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> +++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> @@ -26,7 +26,7 @@ do_install(){
>      oe_runmake INSTALLDIR=${D}  USRLIBDIR=${libdir} SBINDIR=${sbindir} install
>  }
>  
> -PACKAGE="${PN} ${PN}-dbg ${PN}-doc"
> +PACKAGE = "${PN} ${PN}-dbg ${PN}-doc"
I think this should be "PACKAGES".
>  FILES:${PN} = "\
>      ${sbindir}/* \
> @@ -46,4 +46,4 @@ FILES:${PN}-dbg = "\
>      /usr/src/debug/* \
>  "
>  
> -REQUIRED_DISTRO_FEATURES ?=" tomoyo"
> +REQUIRED_DISTRO_FEATURES ?= " tomoyo"
...
> diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-security/sshguard/sshguard_2.4.3.bb
> index 37b414e..5380c74 100644
> --- a/recipes-security/sshguard/sshguard_2.4.3.bb
> +++ b/recipes-security/sshguard/sshguard_2.4.3.bb
> @@ -1,10 +1,10 @@
> -SUMARRY=" Intelligently block brute-force attacks by aggregating system logs "
> +SUMARRY = " Intelligently block brute-force attacks by aggregating system logs "
Typo in SUMMARY
>  HOMEPAGE = "https://www.sshguard.net/"
>  LIC_FILES_CHKSUM = "file://COPYING;md5=47a33fc98cd20713882c4d822a57bf4d"
>  LICENSE = "BSD-1-Clause"
>  
>  
> -SRC_URI="https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz"
> +SRC_URI = "https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz"
>  
>  SRC_URI[sha256sum] = "64029deff6de90fdeefb1f497d414f0e4045076693a91da1a70eb7595e97efeb"
>  

