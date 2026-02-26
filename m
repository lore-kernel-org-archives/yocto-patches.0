Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B9FD8FFB
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:26:53 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78573.1772134010063850415
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 11:26:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CfhiqLtx;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8954c9daaeaso14480526d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772134009; x=1772738809; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CBpKJrcGo6ynR4RDH5oh4eoMcjGVYDWg2W8hzjV06Y=;
        b=CfhiqLtxAvG611dICCFLzxxORuDYMvRavFfoMcEbKnV+TDqQH3TSlZUepRusif4hW9
         xqDH8mGW/mCXInRZm2KQBw2T7wFR4Se/pzwrfcdRQ8IhMhkascQC4ocajaY99oUzsBzo
         1R1ovHPOgm4MgeXm7deV30BD/wYNegqS3pmIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134009; x=1772738809;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CBpKJrcGo6ynR4RDH5oh4eoMcjGVYDWg2W8hzjV06Y=;
        b=XQZMGsoXXhWIfEo93SElBqBxZliu267i5UXmWcyIaNiPP//yE5rEVQWfo0AUZPxA2V
         6RS6e8jFAQU8pN/KAqzBEOELROMSiNZIdnbLa03+fgc7ap5B6KE3gLedPPWkJ0x7LVxu
         x0G3dDdwvPGTBaPXQgVq1Unk4Xe50TSXi4XQA5WnIpMJZlWWUtu76GpYI2sccBQxyIcw
         Hx2hUEnGA2sh3lq553wPt9gtDtvqFbT595JQz/UiUQpfptlYe60rDygnXsHvn0VCIFpj
         xq09cb3yDhQa8GCDwmgiPn9bOVuVIkWlLc/hNxn4KKvinHizCkZi1JfJWDj4YbhCsSlt
         NQKQ==
X-Gm-Message-State: AOJu0Yw9wG32YauvaV7zD7Q6iSbLTHPEmve41t37KyZSnn8ytN5BFLat
	Xv4CQWDI6CFumXe00Uayaay0Dadelu63m5R+hstij8idtTPzRQwPI5Jn+l4jnN22TR9x6fJXcpC
	frGmF
X-Gm-Gg: ATEYQzwEV7w5ZpcR06Vbc/ggnuZ8MceDyP00QQiXa1IA3SX/xDqRo+Vtv+ckuClhlpL
	ORgmh8+Olgyuw3fcC0MQOIh6n6US7AV40TvNQXL/EaqNJN8nUyusuS9JcgITAIBU4T+JRa9lgdR
	EFK6tVROFhB+gMb51ZjO15EtN5AuvMljgNZCae+6ydXVMMtk7w9gmrQfjyZp9ARfwXVwvqoPdWa
	/iRzfGGgTprT5SL8CEKGTTIlim8oSW+/rubdkJNy5cww7lGwuaKGvvaUdu/RXOFxx0z3y3CPsB6
	eC9XWpbablV9TuJINLkoP/olSTCOapbmR0OsU+PfiYpl+GxektHn79qGcn1FP41bQByjSkbAJkE
	Q8GNu7L0KB9EUlmriw8j1temAXzuRfDCvRw/erUk9Ev8f/ciNQMzc6Fs2gcHOaegT+vu+JtVBVn
	dL7xsJfIsTheV2htLVRmPwYa8jjiSPLDOr+ZbnAceIjFQ/FyAA3qfaKqQArBkzUCy8xz1Sd0+n3
	+NY36iGsakNfjbwGXrFPJGKzhQj89JI5dYf+ysnofR98ro=
X-Received: by 2002:a05:6214:caa:b0:899:c404:9877 with SMTP id 6a1803df08f44-899d1e7ceb1mr3373516d6.56.1772134008854;
        Thu, 26 Feb 2026 11:26:48 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm320554685a.17.2026.02.26.11.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:26:48 -0800 (PST)
Date: Thu, 26 Feb 2026 14:26:35 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: "Hitendra Prajapati via lists.yoctoproject.org" <hprajapati=mvista.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCHv2] suricata:
 update to 7.0.13
In-Reply-To: <115433.1771994611635209899@lists.yoctoproject.org>
Message-ID: <380ae2ee-ad83-2024-0141-b0bf59df4a07@konsulko.com>
References: <20260216112851.17973-1-hprajapati@mvista.com> <115433.1771994611635209899@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 19:26:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3295

On Tue, 24 Feb 2026, Hitendra Prajapati via lists.yoctoproject.org wrote:

> Hi ,
> Any update on this ??

Sorry, I have been focused on demo stuff for Embedded World.  I'm aiming
to get some updates pushed out in the next week or so.

Scott


