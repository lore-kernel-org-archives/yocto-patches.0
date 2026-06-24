Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59FCDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 02:06:57 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3326.1782266811886991795
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 19:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IufdnwOY;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91587626a3eso50348285a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782266811; x=1782871611; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckhndSyDVjQhrSbGKtgJwMYxZHRShfbq60KB9runN5I=;
        b=IufdnwOYOF+CfyZD7VZMHlwlxJAlwBFvORwjax077RTD+Nl//3CjjNxpMVUKQlSQ1C
         p0OBOarQofG+ewCjFjsZbj9kwt4RXoQY9xvyWFgrD7pnoLXRijrrpeZ7mlKTrB32t/72
         3czUY3ivCL7TLvtn/OpMB2FqZq3BehV4Zg/e16BwSfv+J57GfHUmG3LT+czMj42htrjS
         BBBCEUjWEGdsCeSbMrrS4gJ6Agc12OxMHJ6eBWuCLoUIoU9yQ+0CTIoFY13qmyEmw4CY
         OS9lZH30dRsK9y25Uv5C2yOBnxweu+6GUr3TLMtINk/I0g6FVuYvxMZtcXSLbsWhG9PJ
         iwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782266811; x=1782871611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckhndSyDVjQhrSbGKtgJwMYxZHRShfbq60KB9runN5I=;
        b=LhOALStLdpboWOOPkaCj28jl/cVx6qhs92PFxPGfBIbcVAW1UxbJkh6Dx7l1ee/ohx
         Y5fgrDtjJG0VD9heq9pFux4HEJPomaC4OJIuMJI5/So1qBtQwlXiVvPDaEze+sKOWiae
         BlNRzEkKnnN/mBy/MusoLxc9vq69Q1rz/gDZqbAHZM77/lgbKCGKvSLEpNM2y5lgo4JD
         wAqw/3YET2zE6nw6idS5xvox8XClhgtmJmk1ehryQVt2NNPDvTg7OkYaHbMK4GvBwsKp
         2nJI0u6x9Mn7U3KklTGsBQWlIxHQOb1xCe5r310aEj+inlhv5MIdyl6m3cxqqMrcd+vh
         2ZAw==
X-Gm-Message-State: AOJu0YwIQJ/6/+DwAChm/0KuYYmfrxUAP/lmBR5AVqpBSlfemCLFDQcD
	4BMx7L9cdo688udSw2dvqia/Bl+3yrzweyQZASpCWZzzYBxBljxFRnGT
X-Gm-Gg: AfdE7ck1mXK7aNGfE9mKMdfvVnuRsQUh6WsdQue4w/eFKZD27FVLfd8bMx7tl15CYiZ
	5QNF+jC+fNTrzpo3FFjcAdaD46jqDXVw6hqfHSHYCqGUFQZE7iZ6gdqoKGmq1O8fW6nVmk52uDc
	HekWH6KpcnQjxwV+++KxCdeui8yhET2+oGMN0ziHPL3tYFC5tW6+ZcDVAe05G38U7f19cqXFX85
	66gkm3BUxZTJ90UT4ebsyg39tRLovfenSU7542pT+8BfUPPA8FqhpCL03VYu8B/hj2T0KcegAUd
	vVRpZj+Pw93RSswAA3/bLperb6cY72Plz/arYpUpSO3Obr+LJmmHEFGAzxuwfBSi7KgwX01dt0E
	07ocFsWTjXfpq9w6N4EBlMKzQgeV9gGE28EBO+SUIKa7YNBW0AINuvi0RKoMYTZli7L8oj6YBa0
	iyESV7wNRQQYmm+7H5ua19c/PQVBaLED6pUmD3/v4HaWQm8eVZZWRVRJo=
X-Received: by 2002:a05:620a:1a28:b0:915:c4de:7ac2 with SMTP id af79cd13be357-92646678987mr905518485a.30.1782266810887;
        Tue, 23 Jun 2026 19:06:50 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c1cecsm420758385a.24.2026.06.23.19.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 19:06:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:06:48 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay+rtone@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [wic][PATCH] wic: Update after plugin name changes once again
Message-ID: <ajs7uOiripWLHmlt@localhost.localdomain>
References: <20260617132955.2607392-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617132955.2607392-1-gael.portay+rtone@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 02:06:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4288

On Wed 2026-06-17 @ 03:29:55 PM, Gaël PORTAY wrote:
> Update the plugin names to account for the "-" to "_" plugin name change.
> 
> See commit 78a3c516077 ("wic: Update after plugin name changes")
> 
> Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
> ---
>  src/wic/help.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Added to wic, master branch.
Thanks!

