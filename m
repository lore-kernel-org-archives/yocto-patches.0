Return-Path: <joe@deserted.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C16C3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 14:54:00 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.12678.1721832836104860427
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 07:53:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@deserted-net.20230601.gappssmtp.com header.s=20230601 header.b=DYG9VuUY;
 spf=none, err=permanent DNS error (domain: deserted.net, ip: 209.85.222.181, mailfrom: joe@deserted.net)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f1828ed64so458400385a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deserted-net.20230601.gappssmtp.com; s=20230601; t=1721832835; x=1722437635; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CkpJtw/k2GM4jzAs/pXl2Jz/x7bjoEsLbGsJZEQBYk=;
        b=DYG9VuUYKEKQoPMrHIYHguCsK2MFEGcB86iwAZ8u9rqaE5g9/Y5ZStwdbN/1OR1Gy/
         agf7uPAnVMJR4ZuoyymBEtVKjWoIxCknCmHXl062BmzIxL8iGuxZQ4pumMCG5UqUllYg
         1uMCBvNPj7wnN0/5730KhCuo4sdeAWzNsYeOeoCNP+0sd8jrhVPkpsm33v8DET/OkM4g
         oSZhT70SGs+NtRbjDp86QBRtt74ghvGrP0Pu5mcDdwDwWZ2/OIGZjRmTlc8rN3rWkilk
         ooChTADoU+Mau8sOKV57QQ+s86X+tk2dN0ZCUg57aILUAtTyng4VQ1zm3B/i4oPAiBnM
         vz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832835; x=1722437635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CkpJtw/k2GM4jzAs/pXl2Jz/x7bjoEsLbGsJZEQBYk=;
        b=JjMqiPcVKZ+2iWr1fGXIis4pBZC5bCzx2iXeiWamWccrAXRsCY/6d9y/S/GPc8YaNR
         yVMQ1ePH1E+V3rIVSuBMnV0rsTXwyz0rBatwTC5XZ/AN/zQwYUe0VSokSh+uc99sLD02
         SE6ltLozG/OdQQmPM3CGd4MhWlkGp2t5IIxLhcoQWsZGdsYd9q05jc4rqLL28wYlLXMs
         JYOGfqH11Y/yCS6MFYQI6wBk23uapZL83fIid0ZnndooV/eiHBzFF0ytyPlQLzfFFSxB
         CAg9PS/gHuk/b+2U/9Qi5dArsc6pX8UKMBqOTQl1+7g6VHRrpwvNIYVzbKNcKthe7h3l
         jSig==
X-Gm-Message-State: AOJu0YwMT19GlASplDUG7+z8+mWxZQOw0vEhjnNnztTazYNPHWu7gSj6
	4TKHYEOGFzz4wPdQOrkqQ8pCY9ZTBFN98fpYg46nhL0vqK+JpbBxdS/kvVGOeQ==
X-Google-Smtp-Source: AGHT+IEgdHDmHV8lNRhmwDWmor7IjvtZ9w/nAyte5XPRxFtumi07jlchiXFQpBCdEL3Jayx0QxaUuw==
X-Received: by 2002:a05:620a:1a13:b0:79f:67b:4fdc with SMTP id af79cd13be357-7a1cbcd6549mr284174785a.2.1721832835134;
        Wed, 24 Jul 2024 07:53:55 -0700 (PDT)
Received: from nightwinge.deserted.net (bras-base-jkvlon0513w-grc-21-76-64-181-148.dsl.bell.ca. [76.64.181.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d0068d3bsm29849185a.63.2024.07.24.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:53:54 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:53:53 -0400
From: Joe MacDonald <joe@deserted.net>
To: Yi Zhao <yi.zhao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
Subject: Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in
 login pam file
Message-ID: <20240724145353.7yxqlbaetvims2tz@nightwinge.deserted.net>
References: <20240724141329.3326073-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724141329.3326073-1-yi.zhao@windriver.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 14:54:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/451

Given that this is deprecated and disabled by default, is there any
reason to keep this in at all, rather than just removing lines 67-70?

[[meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 22:13) Yi Zhao wrote:

> The pam_lastlog module is deprecated and disabled by default in
> linux-pam since 1.5.3[1]. Comment out this line to avoid loading
> pam_lastlog module by default. Users can use lastlog2 provided by
> util-linux as an alternative[2].
> 
> [1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
> [2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0
> 
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  recipes-extended/shadow/files/pam.d/login | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
> index ec5bba9..eb43f3b 100644
> --- a/recipes-extended/shadow/files/pam.d/login
> +++ b/recipes-extended/shadow/files/pam.d/login
> @@ -66,7 +66,7 @@ session    required   pam_limits.so
>  
>  # Prints the last login info upon succesful login
>  # (Replaces the `LASTLOG_ENAB' option from login.defs)
> -session    optional   pam_lastlog.so
> +#session    optional   pam_lastlog.so
>  
>  # Prints the motd upon succesful login
>  # (Replaces the `MOTD_FILE' option in login.defs)
> -- 
> 2.25.1
> 

-- 
-Joe MacDonald.
:wq

