Return-Path: <jpuhlman@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2702EC3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 23:34:03 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.24425.1721864034745767601
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 16:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=ZqzmZ8Do;
 spf=pass (domain: mvista.com, ip: 209.85.214.182, mailfrom: jpuhlman@mvista.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd6ed7688cso2895425ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1721864032; x=1722468832; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qphR7eNJhfwoSY6atV3XpNsTYMDFu/S40ZhZrl3uT7Q=;
        b=ZqzmZ8DoFnUylgttMn+JxdaJW4VnY2lvvIj7DopevD2/GnXYD25WQa1dhT9HXEhUrc
         d7MTDe/JJPmggxswhwKk4eqPBJiLfqP8sXQahnFGLTwO5FWJZIR+gbZ0sN+qVM3W3Rke
         A4yDYYuoTB7J8zPucqHqcN/wNKDUt5e5/YUPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721864032; x=1722468832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qphR7eNJhfwoSY6atV3XpNsTYMDFu/S40ZhZrl3uT7Q=;
        b=tRUHLRkS5/+DI4P8bTzDyFj5+rto2dK/eJNKgUVRP7wrgvD7qEiieeP196QShC464d
         VhXKZW174JZzah7yWV4GeKjvUc8Y5PnDIkcrB6noNLnCpTk1bG1I5iM3A/kKpOdnk3lB
         aFvS97168uRUs3kBdx+XDHAWJFGuSrEOM3IIyGCN8LlTulEhyo9KwplqF+4mX+X86lt+
         Ceye00gz26YC30SVBeVfBNq41/vr9lnw+Aowltr7IDDsKktpfqn/r2/zH1PVwcaf8QKD
         WJ+imVxUGAy/1cbqiAEV/vItzWcKxgMPnqefkNfCgpi/gMA+E63+N64JPbt3+BBVw7Q5
         lhJQ==
X-Gm-Message-State: AOJu0YyXP+UMOMEf+Zoo+HILnrd3TN8rE9f+QxcxrqZs4CfiuPHlk8rc
	kMvnyIQm1PtfgqcHYI2zpcU1LPrbg9i41aiGwHMRqSuL3h1m04K8TUsGqxmSeBUz2W6dmy9JPr4
	d
X-Google-Smtp-Source: AGHT+IG3n+Em4ghrqCKBhGu4B5R6cwWUS2oZd2js3FnyihpY1ub/qRYCXWWb41iI/ditjSYSyYbiag==
X-Received: by 2002:a17:903:2343:b0:1fb:4f7f:3b59 with SMTP id d9443c01a7336-1fed352fd39mr12954045ad.3.1721864032398;
        Wed, 24 Jul 2024 16:33:52 -0700 (PDT)
Received: from [192.168.1.9] (99-14-97-149.lightspeed.frokca.sbcglobal.net. [99.14.97.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2c2e2sm1336265ad.193.2024.07.24.16.33.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 16:33:51 -0700 (PDT)
Message-ID: <9d690dfa-a5c8-4dcc-a6a8-456de660965a@mvista.com>
Date: Wed, 24 Jul 2024 16:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-cgl][PATCH] pacemaker: remove remote
 resource agent from pacemaker-remote
To: yocto-patches@lists.yoctoproject.org
References: <20240723155945.1705212-1-mathieu.dupre@savoirfairelinux.com>
 <da18e2d9-48a1-45ca-b5bc-5b96304b2816@mvista.com>
 <6dd36b40a4ae5316bd7c0ddff006d1f7a2c12ae3.camel@linuxfoundation.org>
Content-Language: en-US
From: Jeremy Puhlman <jpuhlman@mvista.com>
In-Reply-To: <6dd36b40a4ae5316bd7c0ddff006d1f7a2c12ae3.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 23:34:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/456



On 7/24/2024 4:24 PM, Richard Purdie via lists.yoctoproject.org wrote:
> Sadly the from addresses get corrupted in nearly all cases now due to
> changes made by various mail servers. I've given up asking people to
> fix it (they can't) and just have a hacky script which fixes the mbox
> files before I apply them.
Fair enough. Thanks.

-- 
Jeremy Puhlman
jpuhlman@mvista.com


