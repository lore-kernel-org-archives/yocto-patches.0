Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D8C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 10:41:26 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.47399.1746441673811926631
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 03:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ul0YgeGW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ede096d73so24849575e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746441672; x=1747046472; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95+BkpAFe+kfcVFOuSNuym2lUgJBHzG0oEaBkAHsjkE=;
        b=Ul0YgeGWS5OxsvgeiBtNtyW6/9RpmyHB2NaRFRjG2smmlIVc0KCU0ZZFolkpdTqrkF
         aEBrtysNDh2qEytblAtOMNSPDTUGY5FtI55qmhZSyuHToJeYXQ7IwBlsL8jxd9Uvn8i5
         Bg18oiKdGjIZyKtTdoqY91VDK6RePqWMsS4qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746441672; x=1747046472;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95+BkpAFe+kfcVFOuSNuym2lUgJBHzG0oEaBkAHsjkE=;
        b=cMq4X9NUwnL8NyVa8CY87uRVmLcKkZnVznCd3BBB90w15ys1xMhZhkAtmxbcrbJgC3
         9MkyLwHZlIpUhq/nrJRpeQR8wfC/jiqZbz54Ek+6tUwc5S521DyhKhXCYpQhD83u/7bp
         smHAAH+cCl+4EDcO3SDBGEnEHSLinUptDMihCgiuEhxysrGiPWPH03HodHNqjhZTuLXt
         N9UitjdHJPCPeaLZisNA56Mwb1TN4eYH5VLm/0vMqG1OR5RNb2d8YsYXbX/NOT5feDiM
         p29Z90Ns1Qm4xedCvmKZB3T8PLbkT5Ekn82WPMdbobS6P0Dqk+N/EUkcJmaKsUisS/l2
         +gYw==
X-Gm-Message-State: AOJu0YwN66MbpKjd9XREJ11qjd0VLZ4bdbZds/BKcjNGaG+EEC+4oqpF
	K2MB3QYsI7kJbzCapMNQn0SFzFhCKScQ4V1H72f5LgoAoH86o3xXSau9HROiHaVWB0dMOLgz/rA
	h
X-Gm-Gg: ASbGncuZQziCZVQhj+f3TbyI2kn8holaaAG1361jbaOZwxXYssomJbm3cHP9NefjzFJ
	Yhb+ld2Fupu+t78+WJjcdaUfjebmpnCaNqeqEmBXEh1KM7k/QVVLiqX0jDvZ4wXxvtCowEPSYd6
	YjoRfAp8ehIFu8e8M1QaOwB985YBKT93jNuAzo7CIro+XbZjTrs0f76SecTC7wi1HBYDoKF1Ucd
	jmeP4yKpN2W62TbgKY6uxt6rpG99AX0NDhFBTkLDC0cQhQaen+pjlPBNU+79Lu+jSdn1D5t4STc
	siMFU7/T0Dd4NwblYvNGnoYwAnW6C6AqTg9gY82srd6tiuA/Gy0TkkH3Swd1mvmck5nERrZCHNn
	GPGaYqt+cgIHq+e2xeHP1HYu+qe4052jZEDeH4u6f
X-Google-Smtp-Source: AGHT+IHhVKsJCNQ1cZq/3nnkpXvD1YGzOc0JG9neOQL/cie42vBeQGuwYRTlUy+jeHMVN0nz4RTsTQ==
X-Received: by 2002:a05:600c:3b8d:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-441c48b0590mr57472685e9.3.1746441671388;
        Mon, 05 May 2025 03:41:11 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4146:97bc:575c:a2f9? ([2001:8b0:aba:5f3c:4146:97bc:575c:a2f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc387sm132178635e9.4.2025.05.05.03.41.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 03:41:10 -0700 (PDT)
Message-ID: <2308ab050f809b28c4df09871d38652640c3a3ab.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-java][PATCH] Updates the mailing list for
 meta-java
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 05 May 2025 11:41:09 +0100
In-Reply-To: <23053.1746440261491786759@lists.yoctoproject.org>
References: 
	<2dadedef80eec9aae68c0e6bff49d3a66c4cbc98.camel@linuxfoundation.org>
	 <23053.1746440261491786759@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 10:41:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1500

On Mon, 2025-05-05 at 03:17 -0700, Ashish Mishra via lists.yoctoproject.org=
 wrote:
> Thanks Richard ,=20
> =C2=A0
> There are patch i have shared to correct the download link for few
> recipe.
> The path the recipe's were using have changed , i have updated these
> patch accordingly to fetch properly.
> =C2=A0
> If possible , can you please look into merging them, below is the
> cover letter :
> https://lists.yoctoproject.org/g/yocto-patches/message/1492
> =C2=A0
> I was creating manually these patches locally for last 6 months , at
> last i thought to share the patch so all benefit=C2=A0
> If any one just manually checks the old path in any browser they can
> confirm that old path have been changed.
> The shared patches just updated the path for these tar

I understand that on first glance they look correct and simple. If I
did merge them, it would only encourage more patches and more pressure
for me to look at those. There is also the potential something is
incorrect, then I'd feel pressured to fix it.

I'm not the layer's maintainer, I don't use it and I don't want to get
drawn into this, regardless of how simple the patches may first
appear.=C2=A0

Sorry, but I'm overloaded enough as it is :(.

Cheers,

Richard

