Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C5E7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 03:47:16 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.49405.1734320829976719454
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 19:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J+C5TGV2;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6ea711805so350756585a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 19:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734320828; x=1734925628; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLBXL/oV66rtJw17BZ4++SKK1LvG5lX82BBjPd8Z9Lk=;
        b=J+C5TGV2iF1A+MpZyKF4HkwVxeVm2p9mCEvXA4MBGIehkm+qPdiTHviWj+VD3duasC
         JQdSxwAbKLAt1nRLQZx4SIrfecam0nRlmGAYiK1rfh9eUGh22xwYxaosjj32ZgbHZJJT
         3y3jQr0XmH676gAY5VuGjT9CaDjwFwJxeAYWlwlJAB/evre4kYb7RHqBg7Ujv0s9ERlY
         R3W3l+MfDQZttk92aEuvsrkh4UlS8VQghmr0vzRYca5APzS2AvfRbBLiEhS74J6NNp4S
         mcPNpys19ONnCJApOX58LV1buy7dKzSi24cHiaDvv1CqN3KRIWmPl+BdFEDfBfmO88CU
         BrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734320828; x=1734925628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLBXL/oV66rtJw17BZ4++SKK1LvG5lX82BBjPd8Z9Lk=;
        b=LVJW41qZM/NKf8QHXIaoVAhTsqtnfcnu18JYTJbFwQBU1Q9PzLprgw0wxtao8KiVs8
         Beyg/KrXIWqMS7sx5MHvP3FQVYPdmlr/19SSi2P/taEuqluoal6PJ1GtxtYCbyvPeiiw
         psgV+4xsVQgFSyA0ZlhL8BlNUR8Szt/L9fuqzJAJq16LMXelpy7Q8e8sIJCDDCCICz+C
         FSxpjBGOkBwAITdzbeU2pF+XLhHg9IDn4zJLoWyMwxjAwwGM0Q8ZinjU2TsTQP4qdFpZ
         aZN3AH9osmS/27wdeBif+R0WSghNo7yE+s4TWmxZ6idZmjtxeqvu2fIlv9fwD4cSfWWl
         vi8g==
X-Gm-Message-State: AOJu0YxEF7PT1o7oe3XWZlOD0GRG8BpJ+rys9ThLAQo/jYjBHA70lf4H
	LOnbHyWeEOixAoEuM/A0B/eXVwPOtlUtt1kGa+q6N2tpZNdf3TU4sEfgYw==
X-Gm-Gg: ASbGncvFuSA6h/5pT4+nVK60qBQm8Z4HI5zZ/eQT3IzObusofzFawG0QE/UOsJcy1pb
	nTdE0TopglX94kNyyr3vfnBOuAy1mG1+J1/HmAhB2JhVnHkZJXOQtWOZq/YXEiV9Gz7VbOWAx+Z
	awAjFlWYFjLAuP/fUSPvYoggT+7S0GeHpYBb0oHeHpDULMSSvu/OAqurv3jK5zz3EWsmaNnUjSh
	0Ajgm0eTgqtBrz2IofDPpIvGhIOCbp86b04zAjrt9kcNtlYHTo05j9hQd8btsc5nHyJ4TlvBeWg
	cJeumAg/
X-Google-Smtp-Source: AGHT+IGcKkOAw3OjHwg2e99sF2x+fZ8FwUJMNrUaBLgtPe0+EGKXUvpE8wRSPD4nRqNgtdk7UFfVTQ==
X-Received: by 2002:a05:620a:1727:b0:7b1:45ac:86b4 with SMTP id af79cd13be357-7b6fbee81b7mr2018392885a.21.1734320828273;
        Sun, 15 Dec 2024 19:47:08 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d599fsm188240585a.42.2024.12.15.19.47.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:47:07 -0800 (PST)
Date: Sun, 15 Dec 2024 22:47:04 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 4/4] rk3308: add provider for trusted
 firmware-a
Message-ID: <20241216034704.GA466@localhost>
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-4-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213154843.27592-4-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 03:47:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/921

On Fri 2024-12-13 @ 10:48:43 AM, Trevor Woerner wrote:
> A PREFERRED_PROVIDER entry was missed for rk3308 builds:
> 
> 	NOTE: Multiple providers are available for trusted-firmware-a (rk3308-rkbin, rockchip-rkbin-tf-a)
> 	Consider defining a PREFERRED_PROVIDER entry to match trusted-firmware-a
> 
> This allows the RKBIN_RK3308_LATEST knob to work in all cases again.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes from v1
> - added
> ---
>  conf/machine/include/rk3308.inc | 1 +
>  1 file changed, 1 insertion(+)

Added to meta-rockchip, branches master and styhead.

