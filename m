Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D7CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 14:31:27 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10810.1762353083751417300
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Nov 2025 06:31:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SUoVrgM/;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880570bdef8so34933696d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Nov 2025 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353082; x=1762957882; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htKijLDtOOMFEiGQasQl5e3e4wxi3quoZHZDN/UbLYk=;
        b=SUoVrgM/wY9uu2G/GIudOwhdqCoMKgGLiCfhNjiOkep5xRBt3Vxo0or+vbHMfkgtDR
         bzahzgXbnKgDCFSLJedV8cYu4qeRuTbUdhkTecMdnIuouttU8430shhHvdrxdLfxQIh/
         6gHmqSh9s9XDfq2qSgLVCsPCS/DzMYBuO26UdGpYJtjGyS+OBXOaSfMiBTioD5Pn9REd
         EhdonuGlsQwBbDRcv/yCCzHTxl9QLc3AEIi4avQYQDen+NwU6fezVyF9PGy+q7Vk1pJb
         ilrwsZs7Bap4YMmKA7Dm34cVMYq+0zsZ/u4QtMJyIE2rx+GlbaVYrHZ37J2tI2Nyd9Z/
         nqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353082; x=1762957882;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htKijLDtOOMFEiGQasQl5e3e4wxi3quoZHZDN/UbLYk=;
        b=FdwXT6++AKPOuH9Hh0HLH1XKZMoUciq4iC/iA4XJQnQHEtfNSVb8X43ByfBKj18BAt
         NE44FImcEJTfu8I7NgW2GVKoBo4Hx6bUjUrhLxKn5lfviJ03GK8YOoesZWma98BvwluS
         vJt/b0lU/i35fwXLgo6dhEpQvI5UrH52kYGrM+LyWHuvOla3u32WQy2ef5mijrwZA1NQ
         hMkCewZ/85f//ucVIWCHRxkBPQ+uqNX8w09huvdhO5DdjscvvX1VqxjD4cCxbbCiuiVt
         1sXZD8oRbV7lMqhrWn7OG7Q729sOGch96qdxojBJr3PjHvIKD4zXYk0narRufrizlPdx
         Ba1g==
X-Gm-Message-State: AOJu0YwTx/iCXbks/chHHCvXlAkmrTak3LYE6x1lfmw3IKSfAdb5ivT1
	WtsIKJcti9hvKdymGwFvcHAzRUbmnZjVhr5koB3Bn6CTuQOr5KSZSNm+4Mxhcg==
X-Gm-Gg: ASbGncssyPlmrx1wHarZYTcQ/I2HMEJR98rIbQVxGk9MN1LdKGbolLZgoHah2IPA7sp
	A1oAsa3fQtH+TbAJD1Bj1tUto1GFSQy2EfYA3J7BE4ZFdx8Ue70CV0CjplbbjPJAeaG9MDjgaVP
	RuKdtXsvao3A/zjb9RpC8h6nGMc5evfDnuTcDqvtxL7R0169Gx4YRBR37pgjkzMxCsezpPD6erg
	ivCxHfH4YhhRbLMELb2zcM8nMCQQwLohyEzM7VZrPKBjY78J4eW1QmgW8ZFliZ0Q4yTYo+HdohP
	hxZyrdwVjxoSXiASb8XUoAC5DwYaGS1ETON8zcJYeKmo97keK2HIZVaNcPq4EAzP6vyIhtfzXYb
	rhna0adVmah0keL9jCT+ltxryIRAJqXFSUNMjsk6JbofuSNuZmdhZ6GnNQkpJH/bijqlqW6Tb20
	Mu45XonaQN0HDHqawTpUoJa3obxNc=
X-Google-Smtp-Source: AGHT+IGVB115ws+SECyiGuZRCFcoYVtJfCNzLS3bJCQyLDwe7mONoEq8HNHwfFwDFXH5R6MrfsE4+A==
X-Received: by 2002:a05:6214:d0e:b0:880:57b3:cd1b with SMTP id 6a1803df08f44-880710be04emr45441346d6.18.1762353081952;
        Wed, 05 Nov 2025 06:31:21 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e94455sm41599186d6.49.2025.11.05.06.31.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:31:21 -0800 (PST)
Date: Wed, 5 Nov 2025 08:53:37 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] fix sed invocation
Message-ID: <20251105135337.GA3094@localhost>
References: <20251104174516.31259-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104174516.31259-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Nov 2025 14:31:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2423

On Tue 2025-11-04 @ 12:45:16 PM, Trevor Woerner wrote:
> "sed -ie" is different than "sed -i -e". Although both run the script on
> the intended file in-place, the first one creates a backup. These two
> were accidentally merged into one option which can sometimes work, but
> not in this case.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to meta-rockchip, master branch.

