Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A0C3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 10:26:35 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.53059.1722248791458075108
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 03:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=s7WmFXuC;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso3893431e87.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722248790; x=1722853590; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FFVZ9Z7Psq8jv44h6NumPAMc13/eYUkQx2ia8k2BRo=;
        b=s7WmFXuCKRytmawiy+I9d+bDiTSPv4houd/k9tULuwNpVysLuqoa4wTUOb7eZUSX2F
         u2yDIyy86eAwHuzueCkm2LXbMe/dmsc3Whaj/NgaC5eaWfulJVuOXzj2YcSNVWkHqnsS
         A6mKRgD4SQ7Ik8ePx2vhpWwsm1vslpAQOItS1B4j8t36+ehh/M+oqk/bYBA27JLFdtH7
         vTZYMMyr/NY0skxijZ2YdAlLLJuYrMMKheskwe1MkEWA+XLfGN3azfIHeMqdZMl854ng
         5O2EBdfVXzihR/8myU45NJDXaZ/kPlIr4B8+SzPFEjvqeZdLEy7RaA56VDty5LdoLZvB
         oypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248790; x=1722853590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FFVZ9Z7Psq8jv44h6NumPAMc13/eYUkQx2ia8k2BRo=;
        b=PJl+f2of5jN4YqHbu/JeQaNCM8RK/6LdJwUjPvu1smbgLqf8ZTpMU+a+z3wtfAuEkm
         v3sQi95I+IHHpvcb8+k5elCbZlKN5vJ8TVrQaXxq+y0qZug8Rbu+wd5R2kOq5vgNMBvl
         oYuOGbA0AiLrXDoKLjDcJIZMNnPgnXYsVAGs6c/LDweITiqmFTn45kVfMh3tMaAT7Cvp
         JurSWdwuimWhI7uPNkwyYJbkcUXTzJ3rZRozpSAcY3tiCEK8nMW/vp36nJ/vWcGchYRP
         e31V8NsHNC3+wDd3xNu8AsxQMb4cuIc/MVQ25uJM9zsOnDezYO23x/ZtqJ1Om5yw5/eJ
         qzHQ==
X-Gm-Message-State: AOJu0YwZOQn9tWhUONujhBUcPCs8MOaUkB744EzO/OISsuCQRWHptLF4
	uF4gD7xxf2c8aw8Qcp6QRoJaP5AHf60Y40Deg57XyNZB+b397dPT/eXlqce8imINdbHrwcmluwg
	j
X-Google-Smtp-Source: AGHT+IE2ncu6jJTR/YgFhTiUzBHDUMjDxy59qGgZpp5OifgyfQKqsbqTCTDn1sPsL838k5ZOiyF7ww==
X-Received: by 2002:ac2:5ec3:0:b0:51a:f689:b4df with SMTP id 2adb3069b0e04-5309b2bcc33mr5626497e87.44.1722248789559;
        Mon, 29 Jul 2024 03:26:29 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2cddcsm1445904e87.281.2024.07.29.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:26:28 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:26:27 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808 <akuster808@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 01/17] bastille: UNPACKDIR
 fixes
Message-ID: <ZqduU2v41aUdEm5d@nuoska>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
 <ae98ea6b-f9eb-4f78-9f9d-f5f196d884ff@gmail.com>
 <17E69FE11E8A6BB4.683@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17E69FE11E8A6BB4.683@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 10:26:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/490

Hi,

On Mon, Jul 29, 2024 at 10:54:52AM +0300, Mikko Rapeli via lists.yoctoproject.org wrote:
> Hi,
> 
> On Sun, Jul 28, 2024 at 01:01:10PM -0400, akuster808 wrote:
> > Mikko,
> > 
> > Is this series different then the one I posted a few days earlier?
> 
> Yes, it's different. I missed your series, sorry about that. I guess you
> mean https://lists.yoctoproject.org/g/yocto-patches/message/446
> 
> I submitted fixes for the issues I see in my environment and when
> trying to compile some of the recipes in meta-security
> after making changing. I don't mind which patch goes in.

master-next branch is ok for me with the just submitted meta-parsec fix.

Thanks!

-Mikko

