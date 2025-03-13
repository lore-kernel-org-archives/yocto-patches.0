Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E86C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 15:48:22 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.18245.1741880897681897798
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Mar 2025 08:48:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FJE+d+5v;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913d45a148so957915f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741880896; x=1742485696; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7WevIy7uDQPb4LQcGw4t1HKQc7Y9/F7GBbZAPm73Gk=;
        b=FJE+d+5v7kU74dT0IvhGRtVnhZEUireDknNMW8xE/KkuFptUdNl2WTQmAC+oZtHO1+
         igi0gpfqpRkiwiDe6XWGQoKwiIfEfjryDpaIjBV7KBTZjoQgUq3LQDsxT2BmNDXmwWPi
         TFzeiDHaC99rFvB/TjbPCY7lodd2HIIcp1NYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880896; x=1742485696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7WevIy7uDQPb4LQcGw4t1HKQc7Y9/F7GBbZAPm73Gk=;
        b=P5UD0gda1xXUYMP1TjdEr5HH5SBdt+XX1yggq5jL94k9zpjguzeuRL0uqnIryYoBqW
         7t6rOMDipOxtEebZgY0Pa24O4eR98mXAuNrKIO5bKDOiAMzcDNHKDjOHP8XFu0KQezvc
         7YO4wWu6VbM5kMvtkdyYtc9xDWpJfd2atciQw7vWJ5ZJfp7opDxZfo2gVcTeYZJae+pj
         8UydUAA8TV9dckjN/31aQaBoc9qxpbxmHWWb6L/kFV25TeEvQTY1eozuRD119WHOfl+a
         eNMUyyyDez8+UNX/VM42O8OcInROU+x40Z3RQG+NITAoffCp9pGupEfueFAnXpp5zJD7
         nigg==
X-Gm-Message-State: AOJu0YxNe4BsapAHuI5r+QHh1rbEiY//Bf0i9L78QlObxhP3tV2lzzb3
	4epoeY9H5p+v3inE6Hasu/hFYr8IA07avaWr6KHj+elekqHBdlK2UW+lQ4hg82nGPY4F7UX+85x
	O
X-Gm-Gg: ASbGnctJEHZjz4Q5lHWZbAVw6pL9JmpzVlFMFnV7dT4xS4WEtLWeiPrgwY0vbKmaCB0
	vdPoR0IfxnL/V/iXo7aJPpbknNVWkp62LmgG8v1T1nd3eICy5kfrAfd77FStEruI1SJtLyc1/AT
	t9lwfcf8emEIqY28TEXJuxub2uwLrQHUdHfWoWnOoh03FF6Moph/hmAcxEcAqFy7he+egCU5c2a
	HLercB2zh25E3bHaFfDw7a7YtlQlkeJKV2GjsclWORWEiqDfPPPwAF73MDQQWFr+0/Zj/JQv/mg
	BLFZLovP44kazsbYpIXOfag4WdCaQDSJiEbFql69AkDqjCfZjkGSUCWY/AdnrjAyHNXUFZg8V7W
	OgVdvwLu1P7xILplkGFG9QWJ3nmsWA6sjzw==
X-Google-Smtp-Source: AGHT+IFA9IR2tUCl73jNo6DkMFti/g7k6OI7h9M6F9/eAFY3QYNbIDxTTjbxSOerg92raKxJPAA9XA==
X-Received: by 2002:a05:6000:2c1:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-396c345b248mr22227f8f.41.1741880895629;
        Thu, 13 Mar 2025 08:48:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cc37:5f80:1a41:4bc8? ([2001:8b0:aba:5f3c:cc37:5f80:1a41:4bc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm2428234f8f.85.2025.03.13.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:48:14 -0700 (PDT)
Message-ID: <cc8eb00a6f3790f6e66a6cc868dc3c56d18dd406.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 3/3] configure: Add support for
 LoongArch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
Date: Thu, 13 Mar 2025 15:48:14 +0000
In-Reply-To: <20250309060039.454124-4-wuxiaotian@loongson.cn>
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
	 <20250309060039.454124-4-wuxiaotian@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 15:48:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1201

On Sun, 2025-03-09 at 14:00 +0800, Xiaotian Wu via lists.yoctoproject.org w=
rote:
> Set the default architecture based on the current machine
>=20
> Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> ---
> =C2=A0configure | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 39b5fbe..9fbba9a 100755
> --- a/configure
> +++ b/configure
> @@ -22,8 +22,17 @@ opt_xattrdb=3Dfalse
> =C2=A0opt_profile=3Dfalse
> =C2=A0opt_passwd_fallback=3D'""'
> =C2=A0
> +UNAME_MACHINE=3D`(uname -m) 2>/dev/null` || UNAME_MACHINE=3Dx86
> +case $UNAME_MACHINE in
> +=C2=A0 i*86|x86_64) opt_arch=3Dx86 ;;
> +=C2=A0 arm|arm64) opt_arch=3Darm ;;
> +=C2=A0 loongarch32|loongarch64) opt_arch=3Dloongarch ;;
> +esac
> +

Using uname like this is not cross compile compatible and will break
pseudo from building in OpenEmbedded. We can't do this...

Cheers,

Richard

