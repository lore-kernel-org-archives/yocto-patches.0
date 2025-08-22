Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF52ECA0EFA
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 02:04:36 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.5946.1755828275501544580
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 Aug 2025 19:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CLPTVBfk;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e56ff1f604so8842315ab.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 Aug 2025 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755828275; x=1756433075; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=CLPTVBfkOGDvopnPKkPdwnhgNpfxt/P7Zn4a2soqry4uag6sY+bM9xUAu9bLWLUqMK
         31+ylvvqnbSolVhvfU3GxEj+30rd8de5+IQ7yHQTAp3ikKcKWvUps9jvVbBBLd64B94L
         ananu2BNOP2PddD/Qclo5c2rVFZ6zZYZnaXG3Tgff0YpSojAasYulSDKTW2Y0SGtQGhl
         x8D7ul7VPkDXCfJOhQqtpkoqWf74LRju1P+zvb1b96VaBpwi86uD4ctEq94RZ/NLKeug
         So1UcHLjpqmIG8cyXAIDac3ZEIchinAn3KvteAJsO8jmxGJFpYcAkmSL3SkJHkdOOEzJ
         pESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755828275; x=1756433075;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=fEJYZ2hqCabsWxpttuR9eaWyzG/dmihBsIMRm5fIyP9ydMZeSkpIayFCZVpsuaUwRF
         niKkNy6wvaoDvT8UmESQR/F4Y4K6RkspuxGORhIiKPJtm1Y9kix0xcU5rTdyv3bw3t+A
         aNJnTEskEMd79Mmhd+mRaGoJMZKSM1Jv2QBZ5PVrtG8WRHA+Yw2Kgml0cV4/gHQ5CQKx
         0OPqbNY1U7qcx247WKY+S3WpB3Bg1FQvtyZUl/SeoBvTzSVX8PG7LKR1OB3Zqqc7PTYR
         EstwuE5DIpBM798rZ7bBmIZCTrOegR01e3iZ8uU2Y3EgBxq50OZ7MfoKCvdGdLxcXqvI
         T9kQ==
X-Gm-Message-State: AOJu0Ywgj+X4AI1xD+j729+/ro1ft3JbtGEoMV5w84qHJItHE6fv0gD4
	tjdYMp2UP3jFFvW9wp76zbrNCN533V+e+rRKlK6kpa9uIB62GAzm13tRpIoCfA==
X-Gm-Gg: ASbGncsa2KeB387h+PSsMRWEKfbzp4Q36MP9YlgL5ha73WSRIgGpZsg5aS/8/46wC+y
	pC52+p7nROl6JLRT5cLvCqbROytyfqi4JPYbFWTlSlS6GF5DrmqALH7nY7tIigm+6s9yhP02+ZB
	lFk4qMnomJLhjB7LPIxbwHk5NRczWdsJYw8gjW9PCeyxtdKN7LExDKqtYLqhKlG/lTOk0vxZPzP
	XmYdguO7JTnVsufzXax6aqe8Zr/JbRWoAN+2OZZz6nV2T//UoIhE9GB/9eydV0I+lq+f15dvgFb
	AfT6/gePq07UqFsOmcUxol27AeDhyRSqGPMlFVKPXzoO3D2azKsfSV8vX3nh5P9MvQ9LKiF5PSz
	9+goaXaKadalRHvGt0boqJX84GuwuZfxyRywYfbFD1kf0ulZ7mQDK1M+y8S4TJzZ2GYwQC0SD
X-Google-Smtp-Source: AGHT+IEpxXyp989FS5rpK4x8skGxAuQ4DXyZgTGCjqqk6+n2+oTmuaXpiG9fRDTFR6XqjwIwUPSvbA==
X-Received: by 2002:a05:6e02:148c:b0:3e5:5269:89be with SMTP id e9e14a558f8ab-3e921a5d80dmr28058435ab.15.1755828274586;
        Thu, 21 Aug 2025 19:04:34 -0700 (PDT)
Received: from [172.26.252.3] (174-16-207-42.hlrn.qwest.net. [174.16.207.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58cba5sm85780535ab.9.2025.08.21.19.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 19:04:34 -0700 (PDT)
Message-ID: <4c79afc7-6325-4a96-8d55-ab5512c24385@gmail.com>
Date: Thu, 21 Aug 2025 20:04:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH v2] suricata: install classification,
 reference configs
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
References: <0272a677-57d5-4dbc-b053-8833c6771928@gmail.com>
Content-Language: en-US
In-Reply-To: <0272a677-57d5-4dbc-b053-8833c6771928@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 22 Aug 2025 02:04:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2077

Hello!

Was there any feedback?

--
Clayton Casciato

