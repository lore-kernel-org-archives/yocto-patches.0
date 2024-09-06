Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF79E6FE43
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 18:41:07 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.6404.1725648062954304280
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 11:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W05xK8fI;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581f44b9b4so570161cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725648062; x=1726252862; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUwOeTB4bJIoRc0kCf5VCjCN3yB/BNiYlpzm25o5g7Q=;
        b=W05xK8fIEA62QS0DRH7jMCpKVGoJoSjY+vjQbPpBU0PdlnZk/2xtlZKqdNWippHJCS
         yVlMpmTLrRCQWvHTrVJgsGjWhZPsMiKSf8fwzEB0IVbVm+7tX66kwluCGEtLtPZfupVm
         no3PGQ35GNKmz8ny0qT+/yNVu1Pzx7k+KAEI5XsWNJlK/SZ31BwDjhvgommNO4yLwzoL
         xlqpdVl8SV0f/e5OixI5xXWV6dpMTrWnNirLaR+YEeJ7ekQW8pIRRaVULDQurPu7FQIZ
         7sFd77yU9wE5M+9TYWsx6ZOI57dayAmNCyQXRUh/ycP74KatQei0DEEKUD7TroK2jM/A
         YabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725648062; x=1726252862;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUwOeTB4bJIoRc0kCf5VCjCN3yB/BNiYlpzm25o5g7Q=;
        b=NlPA8S6hb7WHFfEeTe+9/Gw3qyGvjmy2EWwfQwca1IiEFcYzwvJPoa8Bs22qjY5ZhR
         ZywbBG2KLmAfETV+UUSNGFNIcnWceSWzngZ+eWNA3XnjZG5sdR//6ast6jGJrvZXLKaL
         02QjYvmcoWgzi9QTCBnxFIg4qecx5JS2Unu2a1pBQiUnkcKMcCDpynwEEnlyBlopqzMb
         VJvGIAb2Gb5i+QpndaScWKKKPeIPcnF2cPUEdNLb7tel+/vCzsTSq5pfdK9BXlaia8OW
         +79l5rSz+rQx8paEE98nSS+9RWCfyPraRi2ncQJkw9nGzvSW72B5esMknfhXri6ic+WT
         Bu9w==
X-Gm-Message-State: AOJu0YxaKPf4syjb+webA8yNaTcshmwoIUkSVDb5/mSEZ2tCshNYZKfC
	BbSsxDsq80jPXj9syyYPrbUNMzQ28jPqeZkbIP06PW0wzuG4FduO
X-Google-Smtp-Source: AGHT+IEVK42sql8XsjUP1/U/GGJy0oQ73ub994Sqeiy+6Z6sX/MPCa6ZmevdgZqPDPmZTRIJb/LMcQ==
X-Received: by 2002:a05:622a:1354:b0:451:a0f4:c037 with SMTP id d75a77b69052e-4581f57b4d3mr2292851cf.31.1725648061842;
        Fri, 06 Sep 2024 11:41:01 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b37007sm18525251cf.39.2024.09.06.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:41:01 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:40:59 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip] [PATCH] layer.conf: Update to styhead release
 name series
Message-ID: <20240906184059.GA33810@localhost>
References: <20240906165911.3777945-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906165911.3777945-1-martin.jansa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 18:41:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/617

On Fri 2024-09-06 @ 06:59:11 PM, Martin Jansa wrote:
> oe-core switched to styhead only in:
> https://git.openembedded.org/openembedded-core/commit/?h=styhead&id=b4cf6d5236a3eacaf56ca2f805b006efac65b26c
> 
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  conf/layer.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to meta-rockchip, master branch. Thanks!

