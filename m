Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE3CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 14:03:48 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17410.1763993022751875862
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 06:03:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OvR725Zm;
 spf=pass (domain: gmail.com, ip: 209.85.166.180, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4331d3eea61so13654885ab.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763993022; x=1764597822; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Nk+TN4adNd9DqBNitusIXV6/5hkbxcj1chYxZZWsSY=;
        b=OvR725Zmd/3Irmr6pAAtmgy7WMYPr0cw2n39PCDjBwCso1in7r99Cm2kfkvR91ecfB
         qYL+Jmk6fhpDssOigQhM+OzUudioJDT0iPg6HD0ku09IFMMAt+0/KLqvARikv0OHMhEK
         l5sBeL32YMl/Ej11pOL3+ifOzgKzc1j4wE7tgGkI9AI+rjeQVMxWmfE/yw+CJ3vLU1Ul
         KQEWLhg4czd6nd0ir8Ypnuqy6wfWcul7hOMBQxCVhEgw0DTLeXbtQNcmsN+b415U6Y/Z
         g8obsOUYgNBnh5NrfiN2FKnqLvzB3kHYfcHFLHHuwM1YJRgwKRnhdjIuLOqRS2lyTHuc
         zPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763993022; x=1764597822;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nk+TN4adNd9DqBNitusIXV6/5hkbxcj1chYxZZWsSY=;
        b=g5pWwt6VqsBmLBJXrgE14KotJ53TcXka4PnbhDDgU58x/7Ed0piepqnubLVh3foCTE
         cgdlrivkNcNcB3rRzoxxXX5acX9RrvTEmOFARPSx5x+/AK4JBF9vQuZCXuSCTMTQYJg2
         72lYB0GcTws0y3ZvmwjSpjRnEnfC+Xu1EYIumw4tNrJK+7g6XY4N58z39twR+HRaOecf
         mjJeM0kF0H9esd6GVEVHinqSgAspsFpsSUTIqGJQj6NkpDp1JSYJPTilmwh3oJnsGVWP
         u+U2x4GMWKU5Zyvtk9GhYAR1g+XP3sGKPjP/GilrkylXEpMuLLMvucAF3T1/4J31IyYR
         cBPg==
X-Forwarded-Encrypted: i=1; AJvYcCULMpmdOpVSoFfQOCsoC1ia7uP/qoYQhzULoikHPFdxUoDVurpu5S574eabFgcseUM3gZ4WzDxyh/Vi8Neu@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzYubQvdB3RDRFO0ykoX8B6w0UIHAjC8Ou4Z7YRzHDSXExLBXKd
	OPQq6uBNAtdZ2KQEW/FnQm3M3U8a1KrFV4TwNlGMvUS+VHcmnF189RO/
X-Gm-Gg: ASbGncva8CmU+5sgdRWvWopqoO0XZqeErCQgqDsJotoqq0KKE8YTQ5pslmspZjyS6ld
	mhgkSb9JzaE5ID/wNn8WQ/N6AYUasS78DHc7zqvu74WTMpLwiRMi7XZf0bCa884jx/ONp+iA8Pv
	UAv+mTYK7dEVgdatcCQNtqbDWdyWijMVQOHL7H5Av1eX+iddhKPESlEpNhA48N2z8Xv1qU9U5PH
	YuNwreE4udZIOSdpAqIlHXUhAj9t3uhysOfY6orve7Qz5P5qoWWYetUCXIEMmW0wtWnZMhY1b5q
	wR91BONXXrkKPSxfrDCnGjXrov0VC4AO7oxjImhJJ4ujD5Y06Aj4l4BEgYalIt/F/7OrNz6IVMQ
	SHnPEciFcP9jUAmnRMpg1ziiBQOWHyJsDHGxWAhUJeW837L4eUp8ylhHsQa0TgOLM4aAmXZ5Oao
	YWuKj+MtFPGh161sJMHHIAw9ou45EokGjiPPcReXv/9GghssaP6ZIVIuFqMXYDaQ==
X-Google-Smtp-Source: AGHT+IEuHMMBoD4ZXJmIBO3DojMeTGqJTneVqGe/HAPsohGpEDB/+h8LqZ8kOoBX4/04uz4YgVVBXQ==
X-Received: by 2002:a92:cda9:0:b0:430:c90d:10ae with SMTP id e9e14a558f8ab-435b8e672f6mr122737905ab.32.1763993021659;
        Mon, 24 Nov 2025 06:03:41 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90e9b61sm59571005ab.34.2025.11.24.06.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 06:03:41 -0800 (PST)
Message-ID: <8b9bc9e9-4b5d-46e8-9ef6-36158827ae14@gmail.com>
Date: Mon, 24 Nov 2025 07:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH 04/32]
 scap-security-guide: fix fetch
To: Scott Murray <scott.murray@konsulko.com>,
 yocto-patches@lists.yoctoproject.org
References: <cover.1763938436.git.scott.murray@konsulko.com>
 <7425c3ca03c6dbb21ba02d7a97787709cb51f8ee.1763938436.git.scott.murray@konsulko.com>
Content-Language: en-US
Cc: marta.rybczynska@ygreky.com, skandigraun@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <7425c3ca03c6dbb21ba02d7a97787709cb51f8ee.1763938436.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 14:03:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2693

> From: Marta Rybczynska <marta.rybczynska@ygreky.com>
>@
> The project does not keep releases in branches, instead they tag them. The stable branch
> does not contain releases, so we use the revision only.
>@
> See upstream issue [1] for details.
>@
> [1] https://github.com/ComplianceAsCode/content/issues/13543
>@
> Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> --- 
>  .../scap-security-guide/scap-security-guide_0.1.71.bb           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>@
> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> index 5e45332..e277ccf 100644
> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> @@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
>  LICENSE = "BSD-3-Clause"
>@@
>  SRCREV = "459f0abf2ac08d36e5fc4a2619bc75cff7000da9"
> -SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
> +SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
>             file://run_eval.sh \
>             file://run-ptest \
>             "   
Hi, Scott

I would suggest instead updating the SRCREV to
879672a39577a8b8c9413641c9e6b8a0bd4f12bc.

See https://lists.yoctoproject.org/g/yocto-patches/topic/116289037

--
Clayton Casciato

