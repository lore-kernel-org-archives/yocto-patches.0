Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B428D59F77
	for <webhook@archiver.kernel.org>; Sat, 13 Dec 2025 07:11:08 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1441.1765609866951892978
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 23:11:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QNAFadEO;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edf1be4434so16706131cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765609865; x=1766214665; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ/LJKVmRoNW7uSXmh5LcoDZmM3qWWTIECadoNjr2Gc=;
        b=QNAFadEOVuJt47aHX1GICzumtYvSW8mhzsd3M3BowbQheOmzrgI0e5zcFVpXlOJxBX
         fnZmdSxHkIb8RiIV/VZD0+vFWZPfF8SVTqG1DePc2SoXDwH2DxHuDqdO+6YUfV8l5p0r
         QNv8l2CtETNPa/KwFX4Rmqiaq3pYYOPhHI4kEE96xJyrgqPckJ9rrXyWjmOjO9ztTnBa
         WEfEH8qo/FVoHwna4xXqvixBiCUo/OpMmXaVmBeaikDdTPQBdn1t9hwVUK4XKRB7RUIY
         Vy9lRRtcFRDR8fQFoBPSdlESW6DkTRDr9xoH6LPl3ziu8eiLXqYdMCbZ9bmFVhr2S3MM
         xdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765609865; x=1766214665;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQ/LJKVmRoNW7uSXmh5LcoDZmM3qWWTIECadoNjr2Gc=;
        b=FwObZYLhTHtXMzGjl8Qydb6xGdh0XzKpqw6mBP2TQT1SurhZrE5HmtfJ9pCsQoYNy0
         6VCM5bkI+1xhh+aYY2bTWt89J0O+tNbZNywP2qE3ErNWaYW/dbWSqNW54ug72dzC6VOR
         nS2QiDLJnDQBRHPCmk6JTtM5lutuATM/2SpL04NTJR6yVOG2HiuEGo3Vq2mFQIcId+Op
         J4YBsZb7hXzjppiDZXuoAiXl/YuTLJJe5w490vNhmeZX6opH0hTpNM1E1yGIbWFnt7J+
         W0lEIw8zrG3FsPs9dGTwJfLjumsdiBFY9Sk5ScvzwPc1ixgTiQA+YuEvpiyr+oV3/aK/
         ROTg==
X-Gm-Message-State: AOJu0YyghotZgj2uAGc3fg07fyRru2VqXXU3y32NQI7H5VSmcIHOn7/M
	23uLKGDyYtDB80vXRtlMBlVpFfFhoVbKgAfozg0y/MyljxKjOnl7xANcILuf0w==
X-Gm-Gg: AY/fxX4FhATzoCvwDvrz3KKyFrQZ+m4GHEGJuw7PJLjuEhePSTXDwOPcLwP7g2KeUir
	n25coIjZB9kM1FdNA9G7oZfUh1NjXvBfWiWkZ09dkkLJmtcIb6bY1GdREDKYbfzPxTiBiXzTdXs
	STpTr/lx3tlj/r4XDYrkufT0/GyJ8mJGTpBYlXGGeChbAtr6AOlyE9afyGPe2XJiTSYBslLCdGU
	Q+6LANkiIRYdchbJ6TsqXXRTVnSxh12GnH11lFCwMyaM7xCWzcqxeKcMonXBPtE4F61cj3KQJad
	/i9uiz02NUa2wU+bKmvj/roHW0ZYdGgAaVRX17sAs7foa3P2K5w1+SOi4Pi4kylqCzVbeG1ugBI
	m6+AQHGyIIfXInuNIK6BkgAZRmv8OvmWSltM/Ov7YAMNVPm+WX1gsVYwYMM9D0b5hyIVN9p/upk
	IIPBJX3yJD8fwGD1nA760jWWdrhUk9Cz1VQYDztg==
X-Google-Smtp-Source: AGHT+IFSwH4zgmXEC1mmmKauJF65zGycqZOINw//SxUuXY8I+bC4+6F/GRB6/UESgYARlh7ZgrxMuw==
X-Received: by 2002:a05:622a:4d99:b0:4ee:d6:7a51 with SMTP id d75a77b69052e-4f1d04670b7mr70199681cf.12.1765609865481;
        Fri, 12 Dec 2025 23:11:05 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5665e02sm596486485a.19.2025.12.12.23.11.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 23:11:04 -0800 (PST)
Date: Sat, 13 Dec 2025 02:11:03 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 2/2] abd-partition: place unit file in
 system location
Message-ID: <20251213071103.GB29788@localhost>
References: <20251212182420.24920-1-twoerner@gmail.com>
 <20251212182420.24920-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251212182420.24920-2-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Dec 2025 07:11:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2781

On Fri 2025-12-12 @ 01:24:20 PM, Trevor Woerner wrote:
> The system location for systemd unit files is in /usr/lib/systemd and
> local or admin-created unit files, that are meant to take precedence
> over the units in the system location, are to be placed in /etc/systemd.
> Move these unit files to the system location instead of putting them in
> the override location.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes since v1:
> - added
> ---
>  .../rk-rauc-demo/recipes-core/systemd/abd-partition.bb        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed to meta-rockchip, master branch.

