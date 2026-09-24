Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793AAC98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 06:51:20 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2071.1790232674348249417
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 23:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2qk9OnM/;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so8436845e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790232672; x=1790837472; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlEDx1//Gi1kp0qYI3am+PZPhOToQ/H1Xxa1HU4LPz4=;
        b=2qk9OnM/HGMFW1mznhwHSLTFQSglG30oiOJ5/XhZLcW+qqnGvNcoi2C0Gj9qcNi0BQ
         YZ+sWucT96k+M5zKgw7+25/clcyeO3IOFuh6YwU6GQqbACwLUrdZ/iPGSpg5nZnNWSGb
         QzzEil5b9HamEUF8LWeyiZolfh+AHj2/B/vj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232672; x=1790837472;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlEDx1//Gi1kp0qYI3am+PZPhOToQ/H1Xxa1HU4LPz4=;
        b=gU8VnVIDJ0iaWpnAHvBVaJJAQOaTM7+14UwhHxG3QE6Qaoq5ivyP1RvrAzfeAdZRJc
         MWPRewBtu50nO9MTStgX4dIYa3enVfA2k+3Ukb0QB6Qg/e+Fmiapa0naPQe6t+oPT6St
         p3B1KBDnyBjHuaD23xafnOsAXwxlwSeyNy8QYMWjv8s6jHY0EcLnHNvkemY8IGW5JWkU
         KzYufx20rOHhEeoxeg4EVg2mSoXY51H4yJ/Sa30bNMppazQp3xYuz6vgbp0XlnRyz6j3
         zQGH0Wucc3JS4Ek7OPHaqNrsKmWPCHk5CII87sDNl++ZW3ruWGz1rbAFZR9F3LlDsGvj
         5gpg==
X-Gm-Message-State: AFuF++kuMJMoBNNYzzFfjak7p1NtBvPaEGNKtelaTqEzTvEXYjhp8MON
	CWDYp+CoEz+aYsT5NlD/DcinSMRSDMfFfKC/XLfHvOenJOVsLFQ+QqZg0ko9Ypd1ihCir+yoshD
	3SahslGE=
X-Gm-Gg: AYBFou0HOHPERgYvCN+/aukucWY0u/FQCElDi/pbjXORljNOYE+ZCbGTygvx8/TqMpn
	M1vtrUiiLupU7SCRTrp8F3PfUXZ/yAOGNx/EPznFjukfE2bQPx8somb6tTk/hbgbxTysuobQ4T3
	r51OkCqdueEETGKrTFzBtsVFhs3u6dapboumYlreBNYv8uLHcHqIz7N75uPBccwEltJjcbzrOFj
	ee3GKzZ/chzIaarsQzFwqIkRKH4QRRDjzf5/x3ABRA1aUCIG7BVEHhYpPj4hwYtLG38uZwKZtF2
	QUG/yEo7zdOex91rdpvKEurgzYnM9Wl06KVN0KpZXcej8ddqetNuJaP1uHKk876zBGomBkyDi2O
	wSgUZaZtS9V2tI8HcKhtSNlOex4IDV9Gs6+jaj/4wGBCjxuZz4OdxsFnf6I06Vmk2O/yG8ZwrSD
	VsNWZiIFdsgFSsF32YuoQBAXnsnCkajkJf6V9QipL/t6DDUWQYg4ex/fdaZWIMpoHFRm/8lG9wU
	i3ap4p5dvr4JoTjUNeKe/l/3pBbi3V4HUB3BHHBdtezsh5OFag9eWBOvsrxSg==
X-Received: by 2002:a05:600d:8643:10b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fe67bc26fmr14468105e9.28.1790232672392;
        Wed, 23 Sep 2026 23:51:12 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm68755885e9.3.2026.09.23.23.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 23:51:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 08:51:11 +0200
Message-Id: <DLNCINQHU830.27H37P8U5X2QT@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][dunfell][PATCH]
 config.json: fix cvecheck iputils warning
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260923-fix-cvecheck-warning-fdunfell-v1-1-bd0c0b400f84@bootlin.com>
In-Reply-To: <20260923-fix-cvecheck-warning-fdunfell-v1-1-bd0c0b400f84@bootlin.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 06:51:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4950

On Wed Sep 23, 2026 at 5:41 PM CEST, Antonin Godard via lists.yoctoproject.=
org wrote:
> On Yocto Dunfell, an EOL version of Yocto, we consistently have the
> following warning showed during the metrics job:
>
>   WARNING: iputils-s20190709-r0 do_cve_check: iputils: Failed to compare
>   s20190709 < 20250602 for CVE-2025-47268
>
> This is because upstream stopped adding the leading "s" to their
> version. Since we can't patch Yocto dunfell anymore, as a workaround set
> the version of iputils so that the comparison passes. This makes the
> cvecheck class show the following warning instead, which is expected:
>
>   WARNING: iputils-20190709-r0 do_cve_check: Found unpatched CVE
>   (CVE-2025-47268), for more information check
>   /build/tmp/work/aarch64-poky-linux/iputils/20190709-r0/temp/cve.log
>
> Which isn't shown on the Autobuilder thanks to CVE_CHECK_SHOW_WARNINGS =
=3D
> '0'.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Test build (not pushed to metrics repo):
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/103/builds/4111

Hello,

Thanks! (I had that on my todolist for the longest time but never got to
it)

Alternatively, since the metrics is the last thing we do actually
maintain, we could actually fix the recipe (if the fix is non intrusive,
obviously).

FYI, dunfell had 2 recent fixes for the metrics job.

Regards,
--=20
Yoann Congal
Smile ECS


