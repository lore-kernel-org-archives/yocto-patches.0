Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6DC79F82
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 16:48:33 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2747.1788540510402682875
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 09:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Wb7EHfms;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482ea739de2so831849f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540509; x=1789145309; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=Wb7EHfmsDKgnuykAlkGF3Hky/Zvb8xg59y1mIbbOsii7T2Yl5cwFgtMH4AdYO8oYFN
         OpVqRi0KgX/S17YlW+nZJ0Ixy+LDAfw9WukYsVadmBenlonIicoCappYYgPRah8sn+f2
         o6GvNObNW9ZcNhMQw4LoCGi3KO91vNlmOOo4NbilBbfaDfGRymrs7YhMLi8ctFYVivj3
         k2Cz6474c+o72Co3eAcuEqn1q/pqq9TlN94nu/Yu2aGhQqvqgxFbErh14Q4V3dWmqeZI
         IzJo7KGmW2S658ofhiKn0kcKWhmgZOOfys3xcw5AbfMOBmwANiEHHJl99oSEQFcSrisB
         416w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540509; x=1789145309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=KFhg7MmkknBkYw8S0tIdUo7c6R0X9depmvsBZcGFKQhshgJ7COKaiwP7SXeK+gWupP
         P8B2pdtV1c6b6NEKOh6Lc6pGe/7TkxDmDs7h9VeuztWimDC6HzSbwV1j4sec+s+oz4NJ
         DoKxswtxaKzHUIHqV3mmz3iPrVw+jf8J2G5Iv1/kjFqxTGaLlPMwhzBPcwU63peLJDs6
         zRrSu40HyZ6PW9jwrj4rjrfwVJEQip0ev/jEa8B00lkBXDVM0ckV7f37uhyJulJUVnW8
         dE4npYo/GLrWFRPgN9M8ivFESqeeQyN9aCMj2bC+drIXBAt1kQbVEgMk+0a1K4NCWDFm
         054A==
X-Gm-Message-State: AFuF++lQ0Y6al6rZMIalID07g4Xv7XzUns+9xPdF/XsFdRz0g2P9ymyA
	QCmEkT7OiJxZPobBgQ9JaVbOWNuDByIzgEgEis/1Jy2gt2SnJ5IuGC4f
X-Gm-Gg: AYBFou3KdJPRvRMnJXKypE2ftOR9TsUcd09xkdQxE1lp8KQiEVlEnpBYpfvEs0U/qCW
	EvS+TngRmVnpSsHGOUCZYRBKazRLzomZXnN/ue6HovNdG6yVIXmJjMSKXlVOfWOF9O6hXUY6uV+
	Vfq4+THrEcl0BTeg+iIgNxEGzDMxWw1PUbXIJQPqcyPTAiu1jmPqZ4/XzpF97aPWzEtpa1lUAF5
	cKBHrusVrXdo1VYyiStxU/4Yuu1D1sC0drFPo1EHCKboYxGFEySGsrx/NY/QTqlVhLHi4Fa+QLS
	poEbz3SvdJt6U67fsMI+f+eA0LNmHvbHxsU9jEK0sOJjhq0XrepK+34Y8IP/LAX8I06oaBuyI3z
	+O2xHeIqZiRhaeftslVVa26p0nlJ2pVY/kV9uQnVNMpPW7VMAI8GVElGXHB3E+RbSdQ12KaCCcr
	DrWBwAeX3SWIny70ERSLkSnsx0DlAtzkrdQPSAstZ/L9sCQhWfsDwVKAhtIY5pPtsqfJYlqkwwm
	PHFpX5UvBFwnhTUw0piNgBhuOGh0j1ZDtNRpwT0L0ipepIR9lzQw6b4opVYmq4l2vELIh9ZRBy/
	GenxRrEeQJO2wmpP
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr79799435e9.2.1788540507654;
        Fri, 04 Sep 2026 09:48:27 -0700 (PDT)
Received: from ERL0724PF3HPJ22.fritz.box (p200300f847017a009ce9fbcb9cba4fab.dip0.t-ipconnect.de. [2003:f8:4701:7a00:9ce9:fbcb:9cba:4fab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm426392895e9.0.2026.09.04.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:48:27 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: joe.macdonald@siemens.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] libselinux: Reduce memory needed in libselinux 
Date: Fri,  4 Sep 2026 18:45:50 +0200
Message-ID: <20260904164823.632472-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1880129.1787219504609892194@lists.yoctoproject.org>
References: <1880129.1787219504609892194@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 16:48:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4734

Hi Joe MacDonald,
 
please let me know if you have any suggestions for improving the commit.
Or if you are not interested in taking this commit.

Thanks,
Yannik

