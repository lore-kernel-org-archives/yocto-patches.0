Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BDC44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 14:57:12 +0000 (UTC)
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13608.1769007425071068649
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 06:57:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q932uszu;
 spf=pass (domain: konsulko.com, ip: 209.85.160.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-501488a12cbso70860761cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769007424; x=1769612224; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfc3cJKnLwnbi/QSVIyGv42/hQ39P25ZmixNEJHrp4M=;
        b=Q932uszuDf3UztAl/s4a3pgNNg3cnGctojkY1Adm1+a0QBTSFxDI+JTtN1w5NOR2EA
         173r7dyplGB9jJB50tVU93Cv2qIjMbHDe/UlIwu/qoT9+manEqs+U5yxSNcln9BxhHOz
         PvSqt/hSDlNS3R0ibbLiRtfzix7QrZk3dC3M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007424; x=1769612224;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vfc3cJKnLwnbi/QSVIyGv42/hQ39P25ZmixNEJHrp4M=;
        b=E0ff0oF6FCXUJOJRVWY1I3ZWsjHNG5OQiFYc5WfJYnLmBehNeX7q06JgpWIa+EbaTK
         YzXgpV4GI4WqGSBiB5hxDCEYzJoUYlan0k4/lwJXn826Nz2WmuK5IN5bXEFtFf51Zhp+
         bwmM8oxkrXMuKkc4a7ZY8T9H4uGLdg0DFRZQpteTWmkXYe+ZgK5piiYsialJm4m4QdyW
         ispYeEX8ul6ZE2P9ZH+q1fHwVLxZPg+7j5U8AgEZZ0Pt2tdv8mGchyKMBHqkGcNlFSVG
         LMEn73EwGynwJX1nc0lxLPxl+12bJdgPV1ZTQ7vMUMRAjqPeLC7AU9xIknFZmDEPwAZJ
         9/Jw==
X-Gm-Message-State: AOJu0YwBgnyB87M4xnbkiTusAPTQH40Eh1IVEAbV2iukPIWAKtTjF93l
	SS7cPrRgUJJWk1JXUsg8JD9Bf30VgDF27flhh+GJIAznsrueGoSVTDHDtOTprLQ+f9raVb8771m
	wOkfTMuo=
X-Gm-Gg: AZuq6aI83Pan0OJ15MWnpNNfMKG/bfVTUzr1qk/pnnmCsoNgGA1JXNb6MjX/VPC7wxk
	YChKvQvwuYxguBvyhd9R9RXytYWVR1vLBaHSFjmL8HL3VkWyYjxbbmGoCen1HCIExQGJusmEjUJ
	IOHH1s/fHGKozdkpF/YNgOpxvWTx8HITr5Ext/g2pl4xJHFmDR84i8cipq1VKVzKAP9UBAD5q78
	kfqjeQ0VLvX/xRwi5G65F5CNDTLpF85gt5w6Io6Rww+C1t50Dzb1vbv+5Xh0TrddFlnHxa8j+Pf
	Q3u3gNGco5hu/vdnJ1sla+XQPMOG0H2hcKDooUBadTmtUPMzsp1CuXJajjKBCVnAcpD+S0g7vOv
	a43QpufI7e0I7UPdfhSrCnZPqCQ/Psoh/Knb3AywKIrBqOGsuh1G/75B8/8cUX+u0SPZSanGWWo
	W97Fwzbmo1kP+SaE7LSlzY33m28br9HYrohZgAFflH0EkIU8bfQ/r5+0aBAVtKJb6UFEsDroo/f
	0c4dVvjBsZ9BS+RDkrdO6GQYHY+auEVtoM=
X-Received: by 2002:a05:622a:134a:b0:4ed:b5d8:a192 with SMTP id d75a77b69052e-502d854d40amr68790141cf.38.1769007423888;
        Wed, 21 Jan 2026 06:57:03 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6031b4sm126022506d6.15.2026.01.21.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:57:03 -0800 (PST)
Date: Wed, 21 Jan 2026 09:57:02 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH 0/6] Assorted
 updates 01/19
In-Reply-To: <188C3C72D6600EC7.3354624@lists.yoctoproject.org>
Message-ID: <4d62bea3-c89b-b5e5-321a-ecec26605ac6@konsulko.com>
References: <188C3C72D6600EC7.3354624@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 14:57:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3041

On Mon, 19 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past couple
> weeks, plus backported lynis updates and a sssd update from myself.
> These changes are queued on the scarthgap-next branch if you would like
> to check them out to test yourself.  I intend to merge these to scarthgap
> branch at end of day tomorrow (Eastern Time, Jan. 20) unless there are
> objections.

These changes have now been merged to the scarthgap branch.

Scott

> Changes:
>
> Marta Rybczynska (1):
>   lynis: move to GitHub fetching
>
> Michael Opdenacker (1):
>   lynis: update to 3.1.5
>
> Scott Murray (2):
>   sssd: Upgrade to 2.9.7
>   lynis: upgrade to 3.1.6
>
> Vijay Anusuri (2):
>   sssd: Upgrade 2.9.2 -> 2.9.5
>   sssd: Fix for CVE-2025-11561
>
>  .../0001-sssctl-add-error-analyzer.patch      | 42 +++++++++-------
>  .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
>  .../sssd/files/drop_ntpdate_chk.patch         | 17 +++++--
>  .../sssd/files/fix-ldblibdir.patch            |  9 +++-
>  .../recipes-security/sssd/files/fix_gid.patch | 16 ++++--
>  .../sssd/files/musl_fixup.patch               | 34 +++++++------
>  .../recipes-security/sssd/files/no_gen.patch  | 18 ++++---
>  .../sssd/{sssd_2.9.2.bb => sssd_2.9.7.bb}     |  3 +-
>  .../lynis/{lynis_3.1.4.bb => lynis_3.1.6.bb}  |  6 +--
>  9 files changed, 141 insertions(+), 54 deletions(-)
>  create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2025-11561.patch
>  rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.7.bb} (98%)
>  rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.6.bb} (87%)
>
>

