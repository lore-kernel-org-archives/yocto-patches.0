Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA1C44501
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:33 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3766.1783581931127906378
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 00:25:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Kx/wtZpP;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15e62c695cso1851666b.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783581929; x=1784186729; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:sender:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c25YVC+/qTGSjZjxiuHaWwfLeTq6L4tK8DxjPBtjzbk=;
        b=Kx/wtZpPh1hRW5rbJ6ot79OOQijqa38pwUtKTnuUpYF3qXXs1oxTLzOVSjr9XPdutq
         SbUxXbc49LTdx2V9hiQX3XJdnp0VqfXfjsuC0ipPNQlN+vfZ5xyjbbMJvNYupUpRYSy3
         RnckcazEU7o6jYKuWwbf/0cOYyc8rC8eju2RJyaln91cEShmcofnEj/FIaf7prmmhZtb
         YMlmpLEAlrh9IfOBh+Cpai4Z4RZ2q28PW7LBIVIP5m80tWhCa3t89ya2r1M35tovhtM4
         fLhnrhQv0qPZp5gbeXQzhUSfzHMhZ8Im8SDrB6cjDmO4cJHMmx7d1OARFA9W+d3O29HN
         Bnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581929; x=1784186729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c25YVC+/qTGSjZjxiuHaWwfLeTq6L4tK8DxjPBtjzbk=;
        b=Ubo5jDKi0X/eaCfO3zq9Hoy/0x2pwgeEpGcHhGJFf226au+VnIDTIIbJ0Fqr5B5e/U
         i3Lpmi+REep4t9ZSNCifX8GGjPTD0FSw/66rvVNdgeL4S6uWKcYkmEc1Cs1XEe0+XSXq
         /uNEjnC9zt+bCBHQ1by9mFpUJgqMxXav9OjI53Z8j9gkGaLPATB1MjzTnONOru5W2uQK
         Q8nDRZWKQYApEDFj8BSzgAM+bvotzj7R9/iDatafJUIOPQRV6xTZ7utTuLZ005zK+EB9
         oHOyjbBUFRMKXRD1EZ3dp7hbWW4jHgl49ykC2zC25awG8KIs4GTzk7pa5Isr/pXfa1DJ
         dB2Q==
X-Gm-Message-State: AOJu0YxLiz0XbqMs8OFf63n0OeHjylGAZeWLqKDlHJelLOdkYRC7sqjB
	In0KpaAnaFl7ESmJauQ24Tdt1cS6BWibIzy/EkfCdvi21N051wDHgvIi
X-Gm-Gg: AfdE7cnlxInzad6xTVO+Q8Unqunq90JDR5M8xjK2XNZ51gA8uXr3H8ZydoJ/R034bvr
	gP4xX1ivHK0QJ//AyigcVOQtC64jU0pAmePtEfhFvJOAdD1R0C/oYi5LV0+L8Gbc1FKtVX8QR6N
	MvlNAcS66D6vioVU1Tu2031ZBwdnCxYX8k6WlN+iSqqikdP7uKW+QrovZO4SLrbeV00Gj31LU9p
	vXT2owhDRt+cttB0AdLv+Na6sGYhFQQ2MBvfYfDmq2hWgDiFK+0ez4H74sTct0s/WXWz1kpj94k
	QKMR89nhZYnlRRflhnRJzs5muKC7PTTtJMMfKmTwNjGiEMW1uwjMfJIYMrheJgqm1YzuP5RRJxN
	9luc12PU0o0UMY1e8YLixTtqPRrT8A2RE2pmjfa1n62rSFhpW8YWGijb/zscWRCHPFK+DVhcmsf
	SDB7fDL9rKeNoQ+r91xwLPMJFe4gkllEBYNsEfvfnLtChstvA5kL3hfhmMMSul0mWgyyL5eRefz
	+lEGgRBH9lMX1hkFjmZMYvZpsyyJJIilQ==
X-Received: by 2002:a17:907:e1c6:10b0:c15:ef57:de2f with SMTP id a640c23a62f3a-c15ef57e7a1mr8156866b.1.1783581929203;
        Thu, 09 Jul 2026 00:25:29 -0700 (PDT)
Received: from localhost (pla93-h04-89-80-79-40.dsl.sta.abo.bbox.fr. [89.80.79.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ae0bb618sm435529866b.20.2026.07.09.00.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 00:25:28 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 09:25:27 +0200
Message-Id: <DJTV0XT222JF.8QDPSTQ3RWY4@gmail.com>
Cc: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [PATCH 0/6] wic/help: Refresh wic create help and usage strings
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay+rtone@gmail.com>
To: "Trevor Woerner" <twoerner@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
 <ak8attfxZztmVJdX@localhost.localdomain>
In-Reply-To: <ak8attfxZztmVJdX@localhost.localdomain>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 07:25:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4458

On Thu Jul 9, 2026 at 5:51 AM CEST, Trevor Woerner wrote:
> Oops! I missed these.
> Please put the tag [wic] in the email subject in the future, thanks!
>

Oops! I forgot to set the tag for that series.

At least, I have set the tag for the other patch; I will do my best to
add it in the future :)

Regards,
Ga=C3=ABl

