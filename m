Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562FFCE08D
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 14:21:11 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70810.1772115662621894915
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 06:21:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RvAHT+e0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837907f535so8749785e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772115661; x=1772720461; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fkmUp8EwOzgC7ADJJEUjBLZAU2KL1MaSGtEF8a5jAc=;
        b=RvAHT+e0uxzFNfDJc8127HMSsIBq6f3LJzFdA2OxBpaVC6vVsEJckEyQp9JypKRPT8
         mEuQhcVdVd/tNxKhnttbQx5hyY7l4qDSwA0cFP96w3TaAGWNgoEdgOPisRyETtD84vIM
         ejipUTJpRLAF7W/oagKkxcBlOsG9NfyeZYcRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115661; x=1772720461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fkmUp8EwOzgC7ADJJEUjBLZAU2KL1MaSGtEF8a5jAc=;
        b=sdiJjSW4VGpXbyrJuraymWFGTuAVHSS0P8kqIGLAJs8ZzTRyabZRVTdayWMRYwDoTE
         qF5/K9XgxzWQ4F+2CSioGV3FgcgiqI7otoCPeau0oRtipFQ8U2iVa6AngSnIuva9a+j2
         Jjv6WFoLhwZ0VPaGJLBdI1WKYokmA+ttiwXQOKB4HiWXVwoD8nb6XXGiZPB4Q+o6nYVC
         VjeG3tzFlWWvqjEWmDBgNQpqdP9s9zMFlo+GU+e0IwkkgPm28grDeFk8ZHD1MRXtJmMK
         ABUymTL5/RY8UFpdOTvOtCCh6d9oRoy3IkPynIhvN7WoIsUvY5vKkkvlRc4JlBc/Rl0c
         iGwA==
X-Forwarded-Encrypted: i=1; AJvYcCXkSe3n8LuA4egFspVJvcUXVEMFHRc/nkPNfkdJw//nVZpF4L121BDgjZNR6RrY5GGfD1VVKMnx6kP3E2h8@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxFlrT4t2VfOmx0rY7dOTcLwm+x4iMjZ6lI3ZCcTlBCcWY0Iv8U
	NuLIVN7YOE/ZHBYtsDAS0s+r88wfODeT9qKRC2vHIJpShBQSq9V5dYP04eHGyXfifwg=
X-Gm-Gg: ATEYQzwoEmzCo9Jy9o2awgXDN2CXyqdG9atY+KzQd8nwsKYbDWQS80nzTY3hRlWnOW6
	AYb/9bJzv2IGC7P/G6zr+ganSiHkyJqWiiwmgr+P6yAdGHBCEQe9OVvsDK1B6ZOLfzYJMobOqeO
	YoEsG3bHu+7dwlZkYWgl/i8ljMHuWVT08vSnazS0v6vmd0C6OgKCfmkxzGkYNcdK8WgENXi+yye
	rO8u8a9t7+xMgnC9xwFJJNp9qRw5IcOEdREp7fRPwdMy2ZwzE6hKw7E93njjZDJEHkBT/1Uysx+
	Qdx8KRyUFKTtx4Qt5xc/HbGj/A4coIfX8Q3ir/H+KKIMBXwCClQMy0az6W1rGvOmI9UIKgTn04W
	Bqjc4apLZmn5Q+/jt/foikHlfSH3+zkWMO12fKPkyosjLrmORWa6VEATwV0usQmw3nwHVsVEmfT
	pPbQ0ZMs1Pp2WMO1EeWUgCAKz3Ua8mekZiNWwtLq9sufr4Lb5MVX1vk/7hYIrUzSP6kbxEdJczw
	p5Cc7nA4ioZdVw=
X-Received: by 2002:a05:600c:c172:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-483c219fcd7mr63499525e9.23.1772115660840;
        Thu, 26 Feb 2026 06:21:00 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6? ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439941a2d34sm8057151f8f.38.2026.02.26.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:20:59 -0800 (PST)
Message-ID: <1c697801f703b4efeedf1b277a522ae549b4f4ba.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] Running Large Language Models
 Locally -- Contribute meta-ollama to Yocto
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: hongxu.jia@windriver.com, Michael Halstead
 <mhalstead@linuxfoundation.org>, 	yocto-patches@lists.yoctoproject.org,
 Khem Raj <raj.khem@gmail.com>,  Alexander Kanavin <alex.kanavin@gmail.com>,
 openembedded-architecture	
 <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>, Robert Yang	
 <liezhi.yang@windriver.com>, Randy MacLeod <Randy.MacLeod@windriver.com>, 
 Mark Asselstine <mark.asselstine@windriver.com>, "Holmberg, Tomas"
 <Tomas.Holmberg@windriver.com>, "Chen, Qi"	 <Qi.Chen@windriver.com>, Koen
 Kooi <koen.kooi@oss.qualcomm.com>, Ross Burton	 <ross.burton@arm.com>
Date: Thu, 26 Feb 2026 14:20:58 +0000
In-Reply-To: <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
	 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
	 <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:21:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3285

On Wed, 2026-02-25 at 13:22 +0800, hongxu via lists.openembedded.org wrote:
> Ping, what is the status of the approval from Yocto Project TSC?

From the TSC perspective, we were waiting on the answers to some of the
discussion/questions that were raised.

> About the suggestion to rename the layer to meta-ai or meta-llm and
> collect other LLM applications, such as llama.cpp.
>=20
> I am open to it, but I strongly insist to maintain meta-ollama as a
> standalone layer, further more, if we support llama.cpp later, we
> should add it as meta-llama-cpp

You mean that you don't mind a meta-ai repostory but within that you
would want meta-llama and meta-llama-cpp to be separate layers?

The other key questions I don't see answered are with regard to:

a) contributions=C2=A0- is this open to contributions from others? how woul=
d
version updates work? what testing needs to pass for patches to merge?
Basically, what is the plan for maintaining it?

b) specific architecture support - what would someone need to do to add
support for a different architecture?

c) specific feature support - if someone wants to add a feature
WindRiver aren't using, would be it accepted?

The TSC needs more information in order to be able to make any kind of
decision.

Cheers,

Richard



