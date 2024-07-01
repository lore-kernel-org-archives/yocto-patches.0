Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BBC2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:12:25 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.16953.1719832336640658438
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 04:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H7CcXVKt;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0356299630so2315543276.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719832336; x=1720437136; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y/GqCTxtvc3rQBQhCQ5Kg8D1P02ANtf/UYWc01XVreA=;
        b=H7CcXVKtIiftvlhnU5WpmfObFPLPOwCUxAuQoFcqjHXV1cpjcqPaP+lURoR2ZOXU6t
         c1c0gFJs6Qlrquf7hh21kMoYRhz9l1na5kHPrpvfh1Tj/6ctl8/IbZZufhZKg6IgB0xC
         +ilXUrbKEvIGjFWLG5IaycIqY8ou+Z9xYRYn7hNtk6E1Mi3RF0Jsca40GK7EV+qtXzOa
         4978B5QVDjWJ4W3TS7Fjgxj+hxjXcID4UUpLoQEdtd/cn5huA78RB1djocvF9XUBNT6W
         qbK9rmuCFO7F1DOL0WeEOoj6Ue3piLNF/0FRwkMawv0+svwBhlzbkhSU2EZJeNI93BFw
         jBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719832336; x=1720437136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/GqCTxtvc3rQBQhCQ5Kg8D1P02ANtf/UYWc01XVreA=;
        b=VejJGs3mhQVSxqS8uOyIrBXI7N/3Vn3z4/IOyPj0MIPxX4lS/9DgXQuAEJvZRRbWX8
         FotXMstx622WJB2eRZfNmd5dPCWD/YocSjqXlw90jz4A1aUi/MlWw0WPfqlNaiEHBMeq
         ZfOe+W3ibAiZNXyX2YtY/gInzpD7y8z8U0aEYJsvhKIYpvOpq1AS49u8bPTbs7iO4bLt
         tWb/qBic4ds2sjvI0HnM1Ezlr3hH0XR/k+hAbvaTdNt7aclDVlBNMfEm8Jlvr2MyF12j
         IZLpraEU7GZOwb5aw/0qjCfq9GnJs1kTmPBQXtARZfnL9WIMBsYIaPaqY9kwfL3K/+u0
         lyag==
X-Gm-Message-State: AOJu0YyXpST+7HBoge0t/hhT4m6TGHl/CKBd0wnxwVB1frDPoS2UZ6yp
	DWYibqPGD4oXx/xHOxGGSLsOkNCDJ1++L0E5gPCP9BoJrD0BceTDWsuaXA==
X-Google-Smtp-Source: AGHT+IEj8x6HR0UDZZICXPjE6F3EZvncYgr/EdOc1GuQY/1981qlx9UKDPcjJMb9FMVuTD4JEpaaMw==
X-Received: by 2002:a25:720a:0:b0:dfb:582:556f with SMTP id 3f1490d57ef6-e036eb29ec9mr5287747276.15.1719832335610;
        Mon, 01 Jul 2024 04:12:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:978e:d840:6c32:150a? ([2600:1700:45dd:7000:978e:d840:6c32:150a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353f45ec5sm1232297276.42.2024.07.01.04.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:12:15 -0700 (PDT)
Message-ID: <8af766e7-bb2b-400e-83df-3e5b20087f98@gmail.com>
Date: Mon, 1 Jul 2024 07:12:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 2/5] sssd: fix
 ac_cv_prog_HAVE_PYTHON3 value
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com, =?UTF-8?Q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-3-gael.portay@rtone.fr>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240626133913.790145-3-gael.portay@rtone.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 11:12:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/395



On 6/26/24 9:39 AM, "Gaël PORTAY via lists.yoctoproject.org wrote:
> The variable HAVE_PYTHON3 expects a boolean value[1] and the configure
> script raises an error if the option --with-python3-bindings is set and
> if the value HAVE_PYTHON3 is not "yes"[2].
>
> The recipe sets a non-boolean value to ac_cv_prog_HAVE_PYTHON3 and thus
> causes the task do_configure to fail.

Does this apply to master?

- armin
>
> This fixes the value set to ac_cv_prog_HAVE_PYTHON3 by setting it to yes
> instead of $(PYTHON_DIR).
>
> Fixes:
>
> 	| checking for python3... (cached) python3.10
> 	| configure: error:
> 	| The program python3 was not found in search path.
> 	| Please ensure that it is installed and its directory is included in the search
> 	| path. It is required for building python3 bindings. If you do not want to build
> 	| them please use argument --without-python3-bindings when running configure.
> 	| NOTE: The following config.log files may provide further information.
>
> [1]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L323-L325
> [2]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L353-L377
>
> Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
> ---
>   recipes-security/sssd/sssd_2.5.2.bb | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
> index fe82452..98a4b5e 100644
> --- a/recipes-security/sssd/sssd_2.5.2.bb
> +++ b/recipes-security/sssd/sssd_2.5.2.bb
> @@ -41,7 +41,7 @@ SSSD_UID ?= "root"
>   SSSD_GID ?= "root"
>   
>   CACHED_CONFIGUREVARS = "ac_cv_member_struct_ldap_conncb_lc_arg=no \
> -    ac_cv_prog_HAVE_PYTHON3=${PYTHON_DIR} \
> +    ac_cv_prog_HAVE_PYTHON3=yes \
>       "
>   
>   PACKAGECONFIG ?="nss nscd autofs sudo infopipe"


