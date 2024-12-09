Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB07E77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 07:52:50 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.96011.1733730761016739223
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Dec 2024 23:52:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iIw5v4jF;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so4714909e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Dec 2024 23:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733730759; x=1734335559; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXMYCcOUmpeO81LBqNRfTAWfWLtqhWJkTKLr1XNtR5k=;
        b=iIw5v4jFN2RW37MYEtCRv49A52+FYCUuQuUAnt70L0ulCSFmrvvyHkIJ55numsY/YY
         o3+MTCSYDieArFrNbl5MUopDGGiMeUYNZ0mr1DW8FCubVTzaNIrSlVCIpRMDlnidW2p2
         uqeROxdM4bPEQkToVPQ/xPAqHxUpRms0F7Jb1sBGqM9mrM6IjiBZxJBmYjBkwbardnTI
         Kz5osRG7dBh9q8s2T1wUA96hrCumjXXDcOmrHVGiVSkXHYuNynxhgJ0Zb3TgIFDkp0b6
         T8mNP2k/UfNbbCeSlGPv8NNy4M76wMPevXkkoNH+6N+isqo+uM2MwIWzOoFbUAhdOfCe
         ydMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730759; x=1734335559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXMYCcOUmpeO81LBqNRfTAWfWLtqhWJkTKLr1XNtR5k=;
        b=EyLFA6iKKNr9w6Pd4j+cCoWD+VWYCo2NoRxWdr7aVDPTZdsDgaE5iuQPlbad4Ky6xn
         V9hcQauM1SicqApozC5sBii4kAWxlUb8IIGevftgvDQDPN+FkXT68/Vvx+2D+4vCDnSR
         Vqa5JF2XeFXvfflu42BRjwMoE8inxYtKzdIAvpNnLtGshksYam3Dn+jqTAfyv4LYqdYx
         D/93e1i+S7iwc3A49cPxfxQHI+TU98VjV8scGXiSz8HTUpod/Mu0b8wWVZp/jKZKRyDZ
         6Buec6pPTctfVSTZVe2fb8YPYAe891STH59M+NvYoXaAE+vO66oCNAybHuTMCSAq/+E6
         yCrg==
X-Gm-Message-State: AOJu0YyflZQtgor2YRQ2AU44LcFfNyjpiFz9iq2s3GpaQxZwe1G+4I+Y
	sTI99RdOC0O82a7lMUQ7d7PsKV7Ojuy5I8q56lEzKZn3FYz0CCaLIimZFEHE/96N0r43lCpTt7X
	wr0s=
X-Gm-Gg: ASbGncv+xetpVwh4dG9jzn+hJviakc6D1zvHGErZ4H0gZPOTujvf8ByN8o99V4jIpp0
	qfMCYVnsZn0pG9t6TmJNptn2uqvjK8OlkKk1A9hO7KQVlFMda3y1BxDx5R/6ygYY3B/lJSSNrp0
	bcqb5Z/6AI00ptY1KKFNaHJ7+mYAJwW5uY8CPfdywhHlnDzPObb4HIhkraTL/+OcZCqArFBcxuU
	PVQrVJxhWTrJifUrZhcmuNua0wphcyN5l0zkghLuQoiFiQl6nK88ae5rd03eibEdG+ZTsFAK69A
	CQ==
X-Google-Smtp-Source: AGHT+IH9l3t90zDaawVUYge/nX6+UIpCqIFjR5jrY70tnzk9T5ImtHKck/I6kKRaQvE/2zz4GqvZMQ==
X-Received: by 2002:a05:6512:e84:b0:53f:232e:31db with SMTP id 2adb3069b0e04-53f232e3726mr2067193e87.16.1733730758827;
        Sun, 08 Dec 2024 23:52:38 -0800 (PST)
Received: from nuoska (89-27-108-43.bb.dnainternet.fi. [89.27.108.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3ac318a8sm709952e87.177.2024.12.08.23.52.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:52:36 -0800 (PST)
Date: Mon, 9 Dec 2024 09:52:33 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 2/2] drop: debug-tweaks
 from ci
Message-ID: <Z1ahwRtEYmWRsJ5H@nuoska>
References: <20241208175318.833015-1-akuster808@gmail.com>
 <20241208175318.833015-2-akuster808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208175318.833015-2-akuster808@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Dec 2024 07:52:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/871

Hi,

On Sun, Dec 08, 2024 at 12:53:18PM -0500, Armin Kuster via lists.yoctoproject.org wrote:
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> ---
>  kas/kas-security-base.yml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
> index fa7915c..bdd74b1 100644
> --- a/kas/kas-security-base.yml
> +++ b/kas/kas-security-base.yml
> @@ -43,7 +43,6 @@ local_conf_header:
>      BB_TASK_IONICE_LEVEL = '2.7'
>      BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
>      TEST_QEMUBOOT_TIMEOUT = "1500"
> -    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"

For testing purposes this is needed:

--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -43,7 +43,7 @@ local_conf_header:
     BB_TASK_IONICE_LEVEL = '2.7'
     BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
     TEST_QEMUBOOT_TIMEOUT = "1500"
-    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
+    EXTRA_IMAGE_FEATURES += "allow-empty-password empty-root-password allow-root-login"
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"


Or is this to be replaced by something else?

I'm trying come up with a set of patches which pass some of the runtime tests again.

Cheers,

-Mikko

