Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71FC83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 23:19:52 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.10219.1751498382062063734
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 16:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g47vDTzm;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d38b84984dso1218243285a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751498381; x=1752103181; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNGEHU7647fHvnxGRamZIqHxaAhG5SNu+N1WPOkXGIs=;
        b=g47vDTzmLCXmkOEeYIA3ZGVUCG+Ln76XVz7W3AMH5HTRjIPYHE1dB+4vwiTlAC+6q4
         nLmq82LQ7XL3itI9x6UNaycOMlO7PhiVDQdI4ODmzwyQkA/AFI0YvhwCywgvzF1Zob/h
         pOt2YjSOW+Ofi+cB1C3gkSgWVV0nyOrahyZv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498381; x=1752103181;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNGEHU7647fHvnxGRamZIqHxaAhG5SNu+N1WPOkXGIs=;
        b=sjfNtcNMcCO0H4Q2o+iIPuAAWWZFrSA3kgfMpkbJmO+njCS3KHlZ8IkipYPgX0XgUR
         VXBQEuZA1ZWojUq0Cx+Qk62aE5pEbi2n3PckB/+WnjnJpK7QJDbKdqj48PYh+mjSY+se
         nO8VwlSjBBFBNTFeUOgYf9FDcEhEO2huC8bJ4D8ZCFSgVl+96LYlDQul/eGyIOU9Mz/p
         Y7TFG1OkrriLjrt9HfbokYAVm3166haEN2QL3sgWfkFZG4IE54NJzVSTWxchZjlktQCA
         pkZKEJlGT9GoBGhiZhDooZ1/kEHn5o5Nl3fyE4GVuHpFg/J8KILXq2Xk5JbEeD0fbZ4Z
         KJ9w==
X-Gm-Message-State: AOJu0Yyn7tpXuduFGmQepEL9KM/G+qAdgtqCRrTLpuMpIL2WE5J3wrhl
	EEtlsvwOyCEVC2p4UkiHRePJWuhfnENe8XN91d4TNjDiLZgBmJL5RloKmJXlFIl4pbVahcajLTU
	+YxZ0
X-Gm-Gg: ASbGncscKRBzfZErUhnPRMLm2IiCmraajqzrpbaEFLMdFz3HCVZAhpTCnAvFpW75dpH
	LE3o/vGr/5v3Cz3heUui7V9iEdCQW1vJpbDmeJXs5OhFxnA5MeuaMwQQb2p+7LExMPtFGWwwAnh
	o/LkqAc1z3Id39mDbFAUSYZbFx+FUclDTrGW2IXHIkwhZveC62hWcEtLq0r2upftxwOeqzMrrxx
	ReZa+jy9QZOl0EB/srF881mWQaZBhO1D0TeY64qK4DCQyg8ym/iZezQnud9/6R5PQnP0gtnz9iX
	lgi9HebMFU4CSrTkVwhi3MKpF0nOD2k5Cgz4nn8PHvfjwkQV4aEcES0dOAq3R8VyaVuNrYLNlpj
	+mI8VpKbFktG82S3Xu6mBl5K5vtfaOh8=
X-Google-Smtp-Source: AGHT+IH8CszY5+p7J8rYBKtPvrmWSQ78n6iie04nYECeig1jdr3w7X8l9CeWRXzKBcMstAwrMsr9ag==
X-Received: by 2002:a05:620a:2a10:b0:7d3:8d33:f550 with SMTP id af79cd13be357-7d5d146bcc1mr223841385a.42.1751498380706;
        Wed, 02 Jul 2025 16:19:40 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443201b67sm1012572285a.61.2025.07.02.16.19.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:19:40 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:19:39 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 1/1] Update maintainers
In-Reply-To: <25294.1751202200711749103@lists.yoctoproject.org>
Message-ID: <abc3e0a7-5355-1305-12bc-d0158ae3a51b@konsulko.com>
References: <d362cdc5e05123ac1907f64d94ea604fdaab884f.1751049467.git.scott.murray@konsulko.com> <25294.1751202200711749103@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 23:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1740

On Sun, 29 Jun 2025, Anton Antonov via lists.yoctoproject.org wrote:

> Hi Scott, Marta,
>
> Thank you for taking maintainer roles for meta-security.
> Armin also used to be a co-maintainer of meta-parsec. I don't know if you want to include yourselves there as well.

Given the contents of the layer, that seems reasonable, we'll discuss
making it official.

> When you have access to all the repositories could you have a look at his PR: https://lore.kernel.org/all/20250519084553.2027324-1-Anton.Antonov@arm.com/
> It's a breaking issue.

Okay.  From looking at meta-parsec, I'm curious if your usecase for it is
currentlty relying on the LAYERSERIES_COMPAT on master branch including
scarthgap?  I can see that potentially working for the moment  with the
recipes in the layer, but I'd prefer to drop it to simplify testing.

Thanks,

Scott



