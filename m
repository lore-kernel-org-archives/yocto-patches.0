Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC14CF9C69
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 12:16:54 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.8569.1726921006099281257
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Sep 2024 05:16:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W4TX2RFG;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45aeed46f5eso13393521cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 21 Sep 2024 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726921004; x=1727525804; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tatYbNvsN6TrwtVfLx+ehiR0iUuQeUMuSB58QXUqtcI=;
        b=W4TX2RFG2NNFUEydAonUYgwYZDHzLFvZgE7n4ctDsx2y5FVfO70nnvZnV5xLnia9Lu
         3aNJ+0K772xqYWFvGl7F/iXYHQWx7WtaFOdt+EbNiN4iYK7872L8T85GUdfT4iulJ96l
         qnpCaBBdMI0FHZZj1q5m8Nl1ij9jwh23lr2SqFiqgiD8WTl+AH+GWJi60CkaWNQX/Pm3
         eyj2B0+0BwNr9OAJv89sDaT8XXx3WpSaAioWQZCTek4PPtnF1+W/Iyoa/c0K2c82AMJz
         wwNDVI4E61a3d5ONDxbd8XWvfULWwPgr9yCapNjP4pc2ruQN3MoqokCuIlMiAu1GibzZ
         oUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726921004; x=1727525804;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tatYbNvsN6TrwtVfLx+ehiR0iUuQeUMuSB58QXUqtcI=;
        b=T7DPDRsmlJNDCED5ZoVI/1LxhODqO8XxaNby1/ZNnG2vr+Mlkx7390JlvOlmtjHI7q
         OFC/pQKHNDbUvV6i0Is8/AKP9T0buwYrVBQIn+/Q0dfKmBPWbn3E8LAu5HfYzwodeSXk
         25WT8R6Vq/OdyjYCzrU0MgFdyjCJvEKKp2Z5BhrgJqh+4dwV6VSGP6Ak3pyeMSiTUxAk
         28uE4I09mbnwd5AK2MPIhSO9h7RgPZ51VGQWq4+2sOYV6JeyvVYm/1wpcn4OFcjeeI1L
         AYqrGUOAUET9fATSQMUQZV0/BsmzmQr7xXQyAwr+3LInZhGYWalz0BMjlGKSwiLQdKYV
         H8Ww==
X-Gm-Message-State: AOJu0YxHMtzv/wpMmwdLJTuamSa5zI9mXZpV1q21I5X5WlY3ibN38vzw
	vjjaeQiKlJWMsa/pB4opprwtZVLyhWaJbyezvZq2xgHVzSszjkV6YdVrdA==
X-Google-Smtp-Source: AGHT+IHIumJ5Jaa251TeghC+t1HEPwsO+yZCbvOsNKEBP/klN2fL7wnlRWar89NYcXILi5VI+TFAwg==
X-Received: by 2002:a05:622a:1aa2:b0:458:3be2:d2d6 with SMTP id d75a77b69052e-45b22891b90mr68303691cf.47.1726921004174;
        Sat, 21 Sep 2024 05:16:44 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17867ea4sm28019391cf.2.2024.09.21.05.16.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 05:16:42 -0700 (PDT)
Date: Sat, 21 Sep 2024 08:16:39 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] abd-partition: add
 runtime dependency
Message-ID: <20240921121639.GA23774@localhost>
References: <17F66BD6D408F640.22254@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17F66BD6D408F640.22254@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 21 Sep 2024 12:16:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/662

On Wed 2024-09-18 @ 03:01:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The rauc demo implementation provided by this layer uses ext4-formatted
> partitions. Therefore the tool required to format ext4 partitions is required
> otherwise the repartitioning will fail.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../rk-rauc-demo/recipes-core/systemd/abd-partition.bb          | 2 ++
>  1 file changed, 2 insertions(+)

Applied to meta-rockchip, master branch.

