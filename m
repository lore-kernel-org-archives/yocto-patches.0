Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780EC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 20:38:31 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.5511.1750711100756239176
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Jun 2025 13:38:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aWM3J1wW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so758025f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750711099; x=1751315899; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vHhd4Dvxxb84dGyMeGtZaQsG05sI1JJSnUm0HwcCuDI=;
        b=aWM3J1wWEoql5QWabKT4VRrN4NB9YNShUxNoR3OBl33sK7sIpEZLvGDMIPwVXRTKmC
         /jhcrMw8zy7cEn6PWSbIHlGaKfUlcSDS2KsDKUH5ypDOZliRsbVoRbn2Him2E6CdiTfM
         kEwU2X09cde3vyqbyKms+Y3KODO1fd1JpUzyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711099; x=1751315899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHhd4Dvxxb84dGyMeGtZaQsG05sI1JJSnUm0HwcCuDI=;
        b=N6RiaUL2LHVNIThavOXn3Sr8MSPxRm6KTAOAsIluefHDKuN54BEUL0eMioELlmqNhq
         lKWVjV9/JK76L6bNnb6I8bhqnBEhuWg2R22E8b4mHSEodvBfp94q+fihtC4ENuiGnJI4
         +wH6hohQiNwWFGXertu5RfsaFTIva/PDOW0vsFUDZPjDq+PCULUmxF6pfUoRQajLiebJ
         fcK0Jmy2f3vogk7Vec14SdDxp9VBlaQSrZ/KCc21e/Sk4VqQpt8sU+VfABcGjKxfjLAT
         n2seUTXPCy/3BkeYLmIg0XxHeIB2Ek4Ag7vwQSykKcQomfH0yp+7erGC0TAH/xuhj6Ej
         5fnA==
X-Gm-Message-State: AOJu0YxFkEugss44mF1S1KwY6rpDZAC/eskXiS+Hpl23vJN0NP6Oo9Ey
	+SfAn+bJ2a8yyOX0laYxv9//PuzLjwuN/L4hVQ0xvZVPcRv3m+GnG8sUIQNBPSkTgx/A7RWBMAj
	ehTu+
X-Gm-Gg: ASbGncuYhFh1Kqq9haHZBZ6czxCw0DSXn3E681GUjYTh4ZqML0ptolrFIV/PorsB4Qd
	zgAjNqcCSnZ27zcQgsnOAdnSL1sTfNk/HlKyCgVnUjwu1G0N/rPFJiFhHE70PhIxNtGIMt/0HHR
	TuDcG6qd9xbrZfK0PoUMMnyBaffU3Ded+n7F/NCGU7tjWJpE5QDxQtb/UlCh4JtdpA8KWFoguyP
	YF3OQHMQmgGScN8y3jWhzQD1spwtswqBQnu+ZbqXuprsx3Ikrx9rOtV7l9zTbk58zVOw/RdcW4S
	czD7VfaIYYrMa/XEVZGJ6PnN2S+vNg0oOmZlTHFy8bR3tibGPjCgedkY+12gO2V+YQORP6L5z4f
	giZB2UhIl21lGq2272w5murnpOa0kjqyY/50Y9mn7LtSdox42+k8=
X-Google-Smtp-Source: AGHT+IHcOIpUB5vV2TPEe4a4RwRHEX59Pn6JF9uxkUSIJmI2T5FiB++jDhoyxZVBMsB6QOZH5NiYvg==
X-Received: by 2002:a05:6000:2405:b0:3a5:1410:71c0 with SMTP id ffacd0b85a97d-3a6d12e1329mr10491630f8f.38.1750711098679;
        Mon, 23 Jun 2025 13:38:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8bf4:3d1b:6949:400a? ([2001:8b0:aba:5f3c:8bf4:3d1b:6949:400a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810010fsm65883f8f.74.2025.06.23.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 13:38:17 -0700 (PDT)
Message-ID: <6e7dc22b840812a82fc74ba314826c0728786950.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/1] Time to move on.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Date: Mon, 23 Jun 2025 21:38:15 +0100
In-Reply-To: <20250623202701.12590-1-akuster808@gmail.com>
References: <20250623202701.12590-1-akuster808@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 20:38:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1680

Hi Armin,

On Mon, 2025-06-23 at 16:16 -0400, Armin Kuster via lists.yoctoproject.org =
wrote:
> I have been maintaining this layer for over 12 years and
> I have had a blast being a layer mainter over those years.
> Thanks for giving me the opertunity.
> Its time to pass on the baton for maintanership of this layer.=20

Thanks for looking after it for all that time!

> I'll let the The Yocto Project TSC decide who the suitable
> replacement(s) may be.

I'm not sure we let you off that easily! Do you have any suggestions or
preferences on who might make a good replacement?

I ask since you're probably much more well placed to have an idea of
who might have the right skills or who might not. Happy to take
feedback publicly and/or privately.

Cheers,

Richard

